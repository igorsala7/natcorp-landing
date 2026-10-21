/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONSOLIDAÇÃO DO HISTÓRICO FINANCEIRO — o resumo da folha (Ajax Callback)       ║
   ║  App 9181 · Página 50                                                                     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 50 › Processing › Ajax Callback › nome EXATO:  NC_CONSOL_RESUMO
               Já vem na exportação f9181_page_50.sql (aplicar-consolfolha-pagina50.py). Quem chama é
               o Natcorp_ConsolFolha.js. Guia: CONSOLFOLHA-MANUTENCAO.md.
   SÓ LÊ.      Nenhum insert/update/delete/commit.

   A IDEIA     A página tem 18 relatórios (um por "Histórico Por"), cada um com a SUA consulta e os SEUS
               filtros. Em vez de repetir 18 consultas aqui, o processo lê a consulta do relatório que está
               na tela (apex_application_page_regions, pelo Static ID que o JS manda em x01: IR_1…IR_18) e
               soma EM CIMA DELA, pelo apex_exec — que liga sozinho os :P50_* da sessão. Os números do
               resumo são, por construção, os da tabela.

   OS NOMES    Os relatórios não usam os mesmos nomes de coluna (COD_OCORR × OCORRENCIA, INCID_LIQ ×
               LIQUIDO × "Líquido"…). Os papéis são achados pelo nome (lista em "papel"); o que sobra, aos
               pares código + nome, são os NÍVEIS (Filial, Centro de custo, Cargo…).

   O QUE DEVOLVE (JSON)
     v = 2, ir
     cols{rubc, rubn, catn, orig, tipo}   o NOME da coluna de cada papel neste relatório — é com ele que
                            o JS põe o filtro na tabela ("Nome Ocorrência em 'A, B'")
     rub[[mes, origem, tipo, liq, verba, categoria, valor, pessoas]]   (índices em "nomes")
          somado por mês × origem × tipo × incide-no-líquido × verba; pessoas = maior "Quantidade
          Funcionários" da verba no mês (para as listas de verbas)
     pessoas{AAAAMM: n}     quem recebeu na FOLHA: em cada grupo do relatório, a verba de provento da
                            Folha com mais pessoas; somado entre os grupos
     niveis[{nome, col, colNome, membros[], v[[membro, mes, ganhos, descontos, pessoas]]}]
     nomes{origem[], tipo[], verba[], cat[]}
     OS NOMES VÊM COMO ESTÃO NO BANCO (sem initcap, v2 13/10): o filtro "em" da tabela compara texto
     exato — "ADIANTAMENTO  (C / INC.)" com os dois espaços. Quem deixa bonito para ler é o JS.

   CUIDADO  • x01 só aceita IR_ seguido de número, e só de ESTA página.
            • Valores com incide-no-líquido: o JS usa ganhos/descontos com incid. líquido = S (a regra da
              região Totais da 200:21); o resto (informativas, FGTS…) aparece à parte.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_ir     varchar2(30) := apex_application.g_x01;
  l_src    clob;
  l_sql    clob;
  l_ctx    apex_exec.t_context;
  l_passo  varchar2(40) := 'inicio';
  l_ncol   pls_integer;
  type t_txt is table of varchar2(400) index by varchar2(400);
  type t_num is table of number index by varchar2(400);
  type t_lst is table of varchar2(400) index by pls_integer;
  col      t_lst;          /* as colunas da consulta, na ordem */
  papel    t_txt;          /* papel -> nome da coluna */
  usado    t_num;          /* nome da coluna -> 1 */
  niv_cod  t_lst;  niv_nom t_lst;  niv_rot t_lst;
  l_nniv   pls_integer := 0;
  por_rot  t_num;  qtd t_num;  rot t_txt;
  pes      t_num;          /* AAAAMM -> pessoas */
  l_dims   varchar2(32767);
  l_k      varchar2(400);

  /* a consulta de um relatório pronta para virar subconsulta: sem o ";" (ou "/") do fim — o APEX
     aceita no relatório, o Oracle não aceita dentro de "select * from ( … )" (ORA-00907, 13/10) — e
     com uma quebra de linha no fim, para um comentário "--" na última linha não engolir o ")" */
  function limpa(p clob) return clob is
  begin
    return regexp_replace(p, '[[:space:];/]+$', '') || chr(10);
  end;
  function q(p varchar2) return varchar2 is begin return '"' || replace(p, '"', '') || '"'; end;
  function ix(p_dim varchar2, p_rot varchar2) return pls_integer is
    r varchar2(400) := substr(nvl(p_rot, 'Não informado'), 1, 380);
    n pls_integer;
  begin
    if not por_rot.exists(p_dim || '|' || r) then
      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;
      por_rot(p_dim || '|' || r) := n; rot(p_dim || '#' || n) := r; qtd(p_dim) := n + 1;
    end if;
    return por_rot(p_dim || '|' || r);
  end;
  /* o primeiro nome da lista que existe na consulta vira o papel */
  procedure acha(p_papel varchar2, p_nomes sys.odcivarchar2list) is
  begin
    for i in 1 .. p_nomes.count loop
      for j in 1 .. l_ncol loop
        if upper(col(j)) = upper(p_nomes(i)) and not usado.exists(col(j)) then
          papel(p_papel) := col(j); usado(col(j)) := 1; return;
        end if;
      end loop;
    end loop;
  end;
  function c(p_papel varchar2) return varchar2 is
  begin
    return case when papel.exists(p_papel) then 'x.' || q(papel(p_papel)) else 'null' end;
  end;
  function nome_nivel(p_col varchar2) return varchar2 is
    u varchar2(100) := upper(p_col);
  begin
    return case
      when u like '%CLASS%CARGO%' then 'Classificação do cargo'
      when u like '%CLASS%C%CUSTO%' or u like '%CLASSIFICACAO%' then 'Classificação do c. custo'
      when u like '%FILIAL%' then 'Filial'
      when u like '%UNIDADE_ADM%' then 'Unidade adm.'
      when u like '%CCUSTO%' or u like '%CENTRO_DE_CUSTO%' then 'Centro de custo'
      when u like '%CARGO%' then 'Cargo'
      when u like '%DIVISAO%' then 'Divisão'
      when u like '%REGIONAL%' then 'Regional'
      when u like '%MAO_OBRA%' then 'Mão de obra'
      when u like '%LOCAL%' then 'Local de trabalho'
      when u like '%UN_NEGOCIO%' then 'Unidade de negócio'
      else initcap(replace(p_col, '_', ' '))
    end;
  end;
begin
  if l_ir is null or not regexp_like(l_ir, '^IR_[0-9]{1,2}$') then
    htp.prn('{"erro":"relatório não informado"}'); return;
  end if;

  /* ── a consulta do relatório que está na tela ── */
  l_passo := 'consulta';
  select region_source into l_src
    from apex_application_page_regions
   where application_id = :APP_ID and page_id = :APP_PAGE_ID and static_id = l_ir;
  l_src := limpa(l_src);

  /* ── as colunas (sem trazer linhas) ── */
  l_passo := 'colunas';
  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db,
                                        p_sql_query => 'select * from (' || l_src || ') where 1 = 0');
  l_ncol := apex_exec.get_column_count(l_ctx);
  for j in 1 .. l_ncol loop col(j) := apex_exec.get_column(l_ctx, j).name; end loop;
  apex_exec.close(l_ctx);

  acha('mes',   sys.odcivarchar2list('DATA_REF'));
  acha('valor', sys.odcivarchar2list('TOT_VALOR'));
  acha('qtde',  sys.odcivarchar2list('QTDE_FUNC'));
  acha('tipo',  sys.odcivarchar2list('TIPO_RUBRICA'));
  acha('orig',  sys.odcivarchar2list('ORIGEM'));
  acha('liq',   sys.odcivarchar2list('INCID_LIQ', 'LIQUIDO', 'Líquido'));
  acha('rubc',  sys.odcivarchar2list('COD_OCORR', 'OCORRENCIA'));
  acha('rubn',  sys.odcivarchar2list('NOME_COD_OCORR'));
  acha('catn',  sys.odcivarchar2list('NOME_COD_GERENCIAL', 'NOME_GERENCIAL'));
  /* o que não é nível */
  for j in 1 .. l_ncol loop
    if upper(col(j)) in ('ROWID', 'COD_EMPRESA', 'EMPRESA', 'NOME_EMPRESA', 'COD_GERENCIAL', 'GERENCIAL', 'TOT_HORAS', 'TOT_MIN',
                         'INCID_IAPAS', 'INCID_FGTS', 'INCID_IR', 'INSS', 'FGTS', 'IR', 'HORAS_FERIAS', 'DT_ATUALIZACAO', 'USUARIO') then
      usado(col(j)) := 1;
    end if;
  end loop;
  if not papel.exists('mes') or not papel.exists('valor') then
    htp.prn('{"erro":"o relatório ' || l_ir || ' não tem DATA_REF e TOT_VALOR"}'); return;
  end if;
  /* os NÍVEIS: o que sobrou, aos pares (código, nome) */
  declare j pls_integer := 1; begin
    while j <= l_ncol loop
      if not usado.exists(col(j)) then
        l_nniv := l_nniv + 1;
        niv_cod(l_nniv) := col(j);
        if j < l_ncol and not usado.exists(col(j + 1)) and regexp_like(upper(col(j + 1)), '^(NOME|DESC)') then
          niv_nom(l_nniv) := col(j + 1); j := j + 1;
        else niv_nom(l_nniv) := null;
        end if;
        niv_rot(l_nniv) := nome_nivel(niv_cod(l_nniv));
        l_dims := l_dims || ', x.' || q(niv_cod(l_nniv));
      end if;
      j := j + 1;
    end loop;
  end;

  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 2);
  apex_json.write('ir', l_ir);
  apex_json.open_object('cols');
  declare l_ps sys.odcivarchar2list := sys.odcivarchar2list('rubc', 'rubn', 'catn', 'orig', 'tipo'); begin
    for j in 1 .. l_ps.count loop
      if papel.exists(l_ps(j)) then apex_json.write(l_ps(j), papel(l_ps(j))); end if;
    end loop;
  end;
  apex_json.close_object;

  /* ── as verbas: mês × origem × tipo × incide no líquido × verba ── */
  l_passo := 'verbas';
  l_sql := 'select to_char(' || c('mes') || ', ''YYYYMM'') m, ' || c('orig') || ' o, ' || c('tipo') || ' t, nvl(' || c('liq') || ', ''N'') l, ' ||
           c('rubc') || ' || '' - '' || ' || c('rubn') || ' r, ' || c('catn') || ' g, sum(' || c('valor') || ') v, max(' || c('qtde') || ') p ' ||
           'from (' || l_src || ') x group by to_char(' || c('mes') || ', ''YYYYMM''), ' || c('orig') || ', ' || c('tipo') || ', nvl(' || c('liq') || ', ''N''), ' ||
           c('rubc') || ', ' || c('rubn') || ', ' || c('catn');
  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);
  apex_json.open_array('rub');
  while apex_exec.next_row(l_ctx) loop
    apex_json.open_array;
    apex_json.write(apex_exec.get_varchar2(l_ctx, 1));
    apex_json.write(ix('origem', nvl(apex_exec.get_varchar2(l_ctx, 2), 'Outras')));
    apex_json.write(ix('tipo', nvl(apex_exec.get_varchar2(l_ctx, 3), 'Sem tipo')));
    apex_json.write(case when apex_exec.get_varchar2(l_ctx, 4) = 'S' then 1 else 0 end);
    apex_json.write(ix('verba', apex_exec.get_varchar2(l_ctx, 5)));
    apex_json.write(ix('cat', apex_exec.get_varchar2(l_ctx, 6)));
    apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 7), 0), 2));
    apex_json.write(nvl(apex_exec.get_number(l_ctx, 8), 0));
    apex_json.close_array;
  end loop;
  apex_json.close_array;
  apex_exec.close(l_ctx);

  /* ── quem recebeu na Folha, por mês ── */
  l_passo := 'pessoas';
  l_sql := 'select m, sum(p) from (select to_char(' || c('mes') || ', ''YYYYMM'') m' || l_dims || ', max(' || c('qtde') || ') p ' ||
           'from (' || l_src || ') x where ' || c('orig') || ' = ''Folha'' and ' || c('tipo') || ' = ''Provento'' ' ||
           'group by to_char(' || c('mes') || ', ''YYYYMM'')' || l_dims || ') group by m';
  l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);
  apex_json.open_object('pessoas');
  while apex_exec.next_row(l_ctx) loop
    apex_json.write(apex_exec.get_varchar2(l_ctx, 1), nvl(apex_exec.get_number(l_ctx, 2), 0));
  end loop;
  apex_json.close_object;
  apex_exec.close(l_ctx);

  /* ── cada nível: ganhos, descontos e pessoas por membro e mês (os que incidem no líquido) ── */
  l_passo := 'niveis';
  apex_json.open_array('niveis');
  for n in 1 .. l_nniv loop
    apex_json.open_object;
    apex_json.write('nome', niv_rot(n));
    apex_json.write('col', niv_cod(n));
    apex_json.write('colNome', niv_nom(n));
    /* por dentro: grupo do relatório (todos os níveis) × mês; por fora: só este nível */
    l_sql := 'select m, cod, nom, sum(g), sum(d), sum(p) from (' ||
             'select to_char(' || c('mes') || ', ''YYYYMM'') m, x.' || q(niv_cod(n)) || ' cod, ' ||
             case when niv_nom(n) is not null then 'max(x.' || q(niv_nom(n)) || ')' else 'null' end || ' nom' ||
             ', sum(case when ' || c('tipo') || ' = ''Provento'' and nvl(' || c('liq') || ', ''N'') = ''S'' then ' || c('valor') || ' end) g' ||
             ', sum(case when ' || c('tipo') || ' = ''Desconto'' and nvl(' || c('liq') || ', ''N'') = ''S'' then ' || c('valor') || ' end) d' ||
             ', max(case when ' || c('orig') || ' = ''Folha'' and ' || c('tipo') || ' = ''Provento'' then ' || c('qtde') || ' end) p' ||
             ' from (' || l_src || ') x group by to_char(' || c('mes') || ', ''YYYYMM'')' || l_dims ||
             ') group by m, cod, nom';
    l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => l_sql);
    apex_json.open_array('v');
    while apex_exec.next_row(l_ctx) loop
      l_k := 'niv' || n;
      apex_json.open_array;
      apex_json.write(ix(l_k, apex_exec.get_varchar2(l_ctx, 2) ||
                              case when apex_exec.get_varchar2(l_ctx, 3) is not null then ' - ' || apex_exec.get_varchar2(l_ctx, 3) end));
      apex_json.write(apex_exec.get_varchar2(l_ctx, 1));
      apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 4), 0), 2));
      apex_json.write(round(nvl(apex_exec.get_number(l_ctx, 5), 0), 2));
      apex_json.write(nvl(apex_exec.get_number(l_ctx, 6), 0));
      apex_json.close_array;
    end loop;
    apex_json.close_array;
    apex_exec.close(l_ctx);
    apex_json.open_array('membros');
    if qtd.exists('niv' || n) then
      for i in 0 .. qtd('niv' || n) - 1 loop apex_json.write(rot('niv' || n || '#' || i)); end loop;
    end if;
    apex_json.close_array;
    apex_json.close_object;
  end loop;
  apex_json.close_array;

  /* ── os nomes ── */
  apex_json.open_object('nomes');
  declare l_ks sys.odcivarchar2list := sys.odcivarchar2list('origem', 'tipo', 'verba', 'cat'); begin
    for j in 1 .. l_ks.count loop                 /* laço na coleção: TABLE() aqui dá ORA-22905 nesta base */
      apex_json.open_array(l_ks(j));
      if qtd.exists(l_ks(j)) then for i in 0 .. qtd(l_ks(j)) - 1 loop apex_json.write(rot(l_ks(j) || '#' || i)); end loop; end if;
      apex_json.close_array;
    end loop;
  end;
  apex_json.close_object;
  apex_json.close_object;
  l_sql := apex_json.get_clob_output;
  apex_json.free_output;
  declare p pls_integer := 1; t pls_integer := dbms_lob.getlength(l_sql); begin
    while p <= t loop htp.prn(dbms_lob.substr(l_sql, 8000, p)); p := p + 8000; end loop;
  end;
exception
  when others then
    begin apex_exec.close(l_ctx); exception when others then null; end;
    apex_json.free_output;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm || ' [passo: ' || l_passo || ']') || '"}');
end;
