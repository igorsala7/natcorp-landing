/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · MEDICINA DO TRABALHO — o resumo das consultas (Ajax Callback)                  ║
   ║  App 2937 · Página 39 (Pesquisa Consulta Médica)                                          ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 39 › Processing › Ajax Callback › nome EXATO:  NC_SESMT_INDICADORES
               Já vem na exportação f2937_page_39.sql (aplicar-sesmt-pagina39.py). Quem chama é o
               Natcorp_SesmtPainel.js. Guia: SESMTPAINEL-MANUTENCAO.md.
   SÓ LÊ.      Nenhum insert/update/delete/commit.

   SÓ O QUE A PÁGINA MOSTRA (decidido 13/10): as MESMAS tabelas, junções e filtro de acesso do relatório
   da página (consulta_medica, inf_pessoais_cad, informacoes_funcionais_cad, prestador_servico,
   tipo_consulta; f_acesso). Os números batem com a tabela. ASO vencido, exames, restrições e doenças
   (outras tabelas) ficam para os dashboards das páginas delas.

   O QUE DEVOLVE (JSON)
     hoje 'DD/MM/AAAA'
     dims{ tipo[], tipoDesc[], cls[], med[] }      os nomes; as linhas usam a posição ('-' = vazio)
     cons[[AAAAMM, tipo, med, faixa, n]]   consultas por mês × tipo × médico × faixa de idade na data
                                           (0 até 24 · 1 25-34 · 2 35-44 · 3 45-54 · 4 55+ · 5 sem data)
     dia[[AAAAMMDD, tipo, med, n]]         os últimos 70 dias, dia a dia (semana e mês, com o anterior)
     jan{ sem, semAnt, mes, mesAnt, 12, 24, 60, 0 : { n: consultas, p: colaboradores DIFERENTES } }
          sem    = da segunda-feira desta semana até hoje · semAnt = os MESMOS dias da semana passada
          mes    = do dia 1 até hoje                        · mesAnt = do dia 1 ao mesmo dia do mês passado
          12/24/60 = os últimos N meses (contando o mês de hoje) · 0 = tudo
     falhas[ "bloco: motivo" ]
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_ctx    apex_exec.t_context;
  l_sql    clob;
  l_passo  varchar2(40) := 'inicio';
  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(400) index by varchar2(400);
  por_rot  t_num;  qtd t_num;  rot t_txt;
  falhas   apex_t_varchar2 := apex_t_varchar2();
  /* o FROM e o WHERE do relatório da página, iguais (as consultas que a tabela mostra) */
  c_base   constant varchar2(2000) :=
    '  from consulta_medica cm, inf_pessoais_cad ip, informacoes_funcionais_cad f, prestador_servico ps, tipo_consulta t' ||
    ' where ip.cod_empresa = cm.cod_empresa and ip.cod_empresa = f.cod_empresa' ||
    '   and ip.matricula = cm.matricula and ip.matricula = f.matricula' ||
    '   and cm.cod_prest_serv = ps.cod_prest_serv and cm.tipo_prest_serv = ''1'' and cm.tipo_entidade = ''1'' and ps.tipo_prest_serv = ''1''' ||
    '   and cm.cod_tipo_consulta = t.cod_tipo_consulta' ||
    '   and f_acesso(f.cod_empresa, f.matricula, f.filial, f.cd_nivel) = ''S''';
  c_tipo   constant varchar2(200) := 'substr(t.cod_tipo_consulta, 1, 5) || '' - '' || t.descricao';
  c_med    constant varchar2(200) := 'ps.cod_prest_serv || '' - '' || initcap(ps.nome)';
  c_pes    constant varchar2(100) := 'cm.cod_empresa || ''-'' || cm.matricula';

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
  /* o tipo, guardando a descrição (o filtro da tabela) e a classificação do ASO na mesma posição */
  function ixTipo(p_rot varchar2, p_desc varchar2, p_cls varchar2) return pls_integer is
    n pls_integer := ix('tipo', p_rot);
  begin
    if not rot.exists('tdesc#' || n) then
      rot('tdesc#' || n) := nvl(p_desc, '-');
      rot('cls#' || n) := nvl(p_cls, '-');
    end if;
    return n;
  end;
  procedure falhou(p_bloco varchar2) is
  begin
    begin apex_exec.close(l_ctx); exception when others then null; end;
    apex_string.push(falhas, p_bloco || ': ' || substr(sqlerrm, 1, 200));
  end;
begin
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 2);
  apex_json.write('hoje', to_char(sysdate, 'DD/MM/YYYY'));

  /* ── consultas por mês × tipo × médico × faixa de idade ── */
  l_passo := 'cons';
  declare l_aberto boolean := false; begin
    l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query =>
      'select to_char(cm.dt_consulta, ''YYYYMM''), ' || c_tipo || ', t.descricao, t.classificacao_aso, ' || c_med || ',' ||
      '       case when ip.dt_nasc is null or cm.dt_consulta is null then 5' ||
      '            else least(4, greatest(0, floor((months_between(cm.dt_consulta, ip.dt_nasc) / 12 - 15) / 10))) end,' ||
      '       count(*)' || c_base ||
      ' group by to_char(cm.dt_consulta, ''YYYYMM''), ' || c_tipo || ', t.descricao, t.classificacao_aso, ' || c_med || ',' ||
      '          case when ip.dt_nasc is null or cm.dt_consulta is null then 5' ||
      '               else least(4, greatest(0, floor((months_between(cm.dt_consulta, ip.dt_nasc) / 12 - 15) / 10))) end');
    apex_json.open_array('cons'); l_aberto := true;
    while apex_exec.next_row(l_ctx) loop
      apex_json.open_array;
      apex_json.write(nvl(apex_exec.get_varchar2(l_ctx, 1), '-'));
      apex_json.write(ixTipo(apex_exec.get_varchar2(l_ctx, 2), apex_exec.get_varchar2(l_ctx, 3), apex_exec.get_varchar2(l_ctx, 4)));
      apex_json.write(ix('med', apex_exec.get_varchar2(l_ctx, 5)));
      apex_json.write(apex_exec.get_number(l_ctx, 6));
      apex_json.write(apex_exec.get_number(l_ctx, 7));
      apex_json.close_array;
    end loop;
    apex_json.close_array; l_aberto := false;
    apex_exec.close(l_ctx);
  exception when others then
    if l_aberto then apex_json.close_array; end if;
    falhou('cons');
  end;

  /* ── os últimos 70 dias, dia a dia (a semana e o mês, com o anterior, e o que entrou em cada um) ── */
  l_passo := 'dia';
  declare l_aberto boolean := false; begin
    l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query =>
      'select to_char(cm.dt_consulta, ''YYYYMMDD''), ' || c_tipo || ', t.descricao, t.classificacao_aso, ' || c_med || ', count(*)' || c_base ||
      '   and cm.dt_consulta >= trunc(sysdate) - 70 and cm.dt_consulta < trunc(sysdate) + 1' ||
      ' group by to_char(cm.dt_consulta, ''YYYYMMDD''), ' || c_tipo || ', t.descricao, t.classificacao_aso, ' || c_med);
    apex_json.open_array('dia'); l_aberto := true;
    while apex_exec.next_row(l_ctx) loop
      apex_json.open_array;
      apex_json.write(apex_exec.get_varchar2(l_ctx, 1));
      apex_json.write(ixTipo(apex_exec.get_varchar2(l_ctx, 2), apex_exec.get_varchar2(l_ctx, 3), apex_exec.get_varchar2(l_ctx, 4)));
      apex_json.write(ix('med', apex_exec.get_varchar2(l_ctx, 5)));
      apex_json.write(apex_exec.get_number(l_ctx, 6));
      apex_json.close_array;
    end loop;
    apex_json.close_array; l_aberto := false;
    apex_exec.close(l_ctx);
  exception when others then
    if l_aberto then apex_json.close_array; end if;
    falhou('dia');
  end;

  /* ── consultas e colaboradores DIFERENTES em cada janela ── */
  l_passo := 'jan';
  declare
    type t_jan is table of varchar2(400) index by pls_integer;
    l_nome t_jan; l_cond t_jan; l_sel varchar2(8000);
  begin
    l_nome(1) := 'sem';    l_cond(1) := 'cm.dt_consulta >= trunc(sysdate, ''IW'') and cm.dt_consulta < trunc(sysdate) + 1';
    l_nome(2) := 'semAnt'; l_cond(2) := 'cm.dt_consulta >= trunc(sysdate, ''IW'') - 7 and cm.dt_consulta < trunc(sysdate) + 1 - 7';
    l_nome(3) := 'mes';    l_cond(3) := 'cm.dt_consulta >= trunc(sysdate, ''MM'') and cm.dt_consulta < trunc(sysdate) + 1';
    l_nome(4) := 'mesAnt'; l_cond(4) := 'cm.dt_consulta >= add_months(trunc(sysdate, ''MM''), -1) and cm.dt_consulta < add_months(trunc(sysdate), -1) + 1';
    l_nome(5) := '12';     l_cond(5) := 'cm.dt_consulta >= add_months(trunc(sysdate, ''MM''), -11)';
    l_nome(6) := '24';     l_cond(6) := 'cm.dt_consulta >= add_months(trunc(sysdate, ''MM''), -23)';
    l_nome(7) := '60';     l_cond(7) := 'cm.dt_consulta >= add_months(trunc(sysdate, ''MM''), -59)';
    l_nome(8) := '0';      l_cond(8) := '1 = 1';
    for i in 1 .. 8 loop
      l_sel := l_sel || case when i > 1 then ', ' end ||
               'count(case when ' || l_cond(i) || ' then 1 end), count(distinct case when ' || l_cond(i) || ' then ' || c_pes || ' end)';
    end loop;
    l_ctx := apex_exec.open_query_context(p_location => apex_exec.c_location_local_db, p_sql_query => 'select ' || l_sel || c_base);
    if apex_exec.next_row(l_ctx) then
      apex_json.open_object('jan');
      for i in 1 .. 8 loop
        apex_json.open_object(l_nome(i));
        apex_json.write('n', apex_exec.get_number(l_ctx, i * 2 - 1));
        apex_json.write('p', apex_exec.get_number(l_ctx, i * 2));
        apex_json.close_object;
      end loop;
      apex_json.close_object;
    end if;
    apex_exec.close(l_ctx);
  exception when others then falhou('jan');
  end;

  /* ── os nomes ── */
  l_passo := 'nomes';
  apex_json.open_object('dims');
  declare l_ks apex_t_varchar2 := apex_t_varchar2('tipo', 'med'); begin
    for j in 1 .. l_ks.count loop                 /* laço na coleção: TABLE() em PL/SQL dá ORA-22905 nesta base */
      apex_json.open_array(l_ks(j));
      if qtd.exists(l_ks(j)) then for i in 0 .. qtd(l_ks(j)) - 1 loop apex_json.write(rot(l_ks(j) || '#' || i)); end loop; end if;
      apex_json.close_array;
    end loop;
    /* item de lista: write(valor) — no 19.2 não tem p_write_null; vazio vai como '-' */
    apex_json.open_array('tipoDesc');
    if qtd.exists('tipo') then for i in 0 .. qtd('tipo') - 1 loop apex_json.write(nvl(trim(rot('tdesc#' || i)), '-')); end loop; end if;
    apex_json.close_array;
    apex_json.open_array('cls');
    if qtd.exists('tipo') then for i in 0 .. qtd('tipo') - 1 loop apex_json.write(nvl(trim(rot('cls#' || i)), '-')); end loop; end if;
    apex_json.close_array;
  end;
  apex_json.close_object;

  apex_json.open_array('falhas');
  for i in 1 .. falhas.count loop apex_json.write(falhas(i)); end loop;
  apex_json.close_array;
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
