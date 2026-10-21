/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · ACIDENTES DE TRABALHO — os números do painel (Ajax Callback)                    ║
   ║  App 200 · Página 150 (Acidente de Trabalho — consulta)                                   ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 150 › Processing › Ajax Callback › nome EXATO:  NC_ACID_INDICADORES
               Já vem na exportação f200_page_150.sql (aplicar-acidpainel-pagina150.py). Quem chama é o
               Natcorp_AcidPainel.js. Guia: ACIDPAINEL-MANUTENCAO.md.
   SÓ LÊ.      Nenhum insert/update/delete/commit: consultas e a montagem do JSON.

   O QUE DEVOLVE (JSON, "v": 1). O painel faz as contas NA TELA (período, filtros, cruzamentos).
     hoje                       DD/MM/AAAA
     quadro, quadroG[[emp,fil,cc,un,at,car,n]]   quem não está desligado (situação < 90), com os
                                filtros da página, dividido pelas colunas (o índice "de cada 1.000")
     ac[[tipo,emp,fil,cc,un,at,car,loc, pessoa, AAAAMMDD, "HH:MI", status, temCat, diasTrat,
         afastImediato, codAnalise, url, AAAAMMDD da CAT]]
                                CADA análise de acidente que o relatório mostra (as mesmas regras),
                                as mais novas primeiro, até 20.000. status = P/C/N (Pendente,
                                Concluído, Cancelado) ou "" ; temCat = 1 quando há número da CAT;
                                diasTrat = duração provável do tratamento (ou null); url = a análise
                                (página 151, com o checksum da sessão)
     afast[{n,c,s,t,d,r,k}]     quem está AFASTADO HOJE numa situação de acidente (veja sitAcid)
     estab[{n,c,s,t,v,a,k}]     quem VOLTOU de afastamento por acidente com mais de 15 dias e ainda está
                                nos 12 meses de estabilidade (art. 118 da Lei 8.213): v = volta, a = até
     sitAcid[]                  as situações contadas como "afastamento por acidente" (o nome tem ACID)
     dims{tipo,emp,fil,cc,un,at,car,loc}   os NOMES, como as colunas do relatório mostram
     nomes{pessoa: "mat - Nome"}

   OS FILTROS são os MESMOS do relatório (P150_*), lidos da sessão — o "Pesquisar" grava antes.
   Aberta da ficha (P150_EMP/P150_MAT), vale só aquela pessoa, como o relatório.

   CUIDADO  • Os filtros múltiplos chegam como "700,91" e são comparados com instr(",700,91,", ",cod,"):
              TABLE(apex_string.split) dentro do PL/SQL dá ORA-22905 nesta base (visto na p25, 08/10).
            • Nomes (fnct_nome_*) uma vez por código (cache), nunca por linha.
            • A VOLTA do afastamento é o fim do histórico (+1) ou, sem ele, o início da situação
              seguinte da pessoa — subconsulta só nas linhas de acidente (poucas), nunca no histórico todo.
            • Símbolos fora do Latin-1 não entram no banco (… vira ¿): este arquivo passa pelo
              aplicar-acidpainel-pagina150.py, que troca os comuns.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje   date := trunc(sysdate);
  l_saida  clob;
  l_passo  varchar2(30) := 'inicio';
  l_n      pls_integer := 0;
  l_quadro number := 0;
  l_pi     pls_integer;
  l_codacid varchar2(4000) := ',';                         /* ",13,14," = situações de acidente */
  l_url    varchar2(4000);

  /* os filtros da página (vazios = todos) */
  l_emp varchar2(32767) := ',' || :P150_EMPRESA || ',';     f_emp number := case when :P150_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P150_FILIAL || ',';      f_fil number := case when :P150_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P150_CCUSTO || ',';      f_cc  number := case when :P150_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P150_UNIDADE_ADM || ','; f_un  number := case when :P150_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P150_ATIVIDADE || ',';   f_at  number := case when :P150_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P150_CARGO || ',';       f_car number := case when :P150_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P150_MATRICULA || ',';   f_mat number := case when :P150_MATRICULA is null then 0 else 1 end;
  l_sit varchar2(10) := nvl(:P150_SITUACAO, 'T');           /* A = ativos, D = desligados, T = todos */
  l_e1  varchar2(100) := :P150_EMP;                         /* aberta da ficha: uma pessoa só */
  l_m1  varchar2(100) := :P150_MAT;

  l_dims sys.odcivarchar2list := sys.odcivarchar2list('tipo', 'emp', 'fil', 'cc', 'un', 'at', 'car', 'loc');

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(400) index by varchar2(400);
  cache   t_num;      /* "dim|empresa|código" -> número */
  por_rot t_num;      /* "dim|nome" -> número (o mesmo nome = um só, como na tabela) */
  qtd     t_num;      /* dim -> quantos nomes */
  rot     t_txt;      /* "dim#número" -> nome */
  pes     t_num;      /* "empresa|matrícula" -> número da pessoa */
  pes_ch  t_txt;      /* número da pessoa -> "empresa|matrícula" */
  sitn    t_txt;      /* situação -> nome */
  l_npes  pls_integer := 0;
  estab_a t_txt;      /* "empresa|matrícula" -> "AAAAMMDD|volta|até|situação" (a estabilidade mais longa) */

  function dentro(p_lista varchar2, p_cod varchar2) return boolean is
  begin
    return instr(p_lista, ',' || p_cod || ',') > 0;
  end;

  /* a pessoa passa nos filtros da página? (as mesmas regras do relatório) */
  function passa(p_emp varchar2, p_mat varchar2, p_fil varchar2, p_cc varchar2, p_un varchar2,
                 p_at varchar2, p_car varchar2, p_situacao varchar2) return boolean is
  begin
    if l_e1 is not null and p_emp <> l_e1 then return false; end if;
    if l_m1 is not null and p_mat <> l_m1 then return false; end if;
    if l_sit = 'A' and not p_situacao < '90' then return false; end if;
    if l_sit = 'D' and not p_situacao >= '90' then return false; end if;
    if f_emp = 1 and not dentro(l_emp, p_emp) then return false; end if;
    if f_fil = 1 and not dentro(l_fil, p_fil) then return false; end if;
    if f_cc = 1 and not dentro(l_cc, p_cc) then return false; end if;
    if f_un = 1 and not dentro(l_un, p_un) then return false; end if;
    if f_at = 1 and not dentro(l_at, p_at) then return false; end if;
    if f_car = 1 and not dentro(l_car, p_car) then return false; end if;
    if f_mat = 1 and not dentro(l_mat, p_mat) then return false; end if;
    return true;
  end;

  function nome_sit(p_cod varchar2) return varchar2 is
  begin
    if p_cod is null then return null; end if;
    if not sitn.exists(p_cod) then
      begin sitn(p_cod) := substr(p_cod || ' - ' || initcap(fnct_nome_situacao(p_cod)), 1, 380);
      exception when others then sitn(p_cod) := p_cod; end;
    end if;
    return sitn(p_cod);
  end;

  /* o nome de um código, IGUAL ao da coluna do relatório */
  function nome_dim(p_dim varchar2, p_emp varchar2, p_cod varchar2) return varchar2 is
    r varchar2(4000);
  begin
    if p_cod is null then return 'Não informado'; end if;
    begin
      r := case p_dim
             when 'emp' then p_cod || ' - ' || initcap(fnct_nome_empresa(p_cod))
             when 'fil' then p_cod || ' - ' || initcap(fnct_nome_filial(p_emp, p_cod))
             when 'cc'  then p_cod || ' - ' || initcap(fnct_nome_ccusto(p_emp, p_cod))
             when 'un'  then p_cod || ' - ' || initcap(fnct_nome_unidade_adm(p_emp, null, p_cod))
             when 'at'  then p_cod || ' - ' || initcap(fnct_nome_atividade(p_cod))
             when 'car' then p_cod || ' - ' || initcap(fnct_nome_cargo(p_cod))
           end;
    exception when others then r := p_cod;
    end;
    return substr(nvl(r, p_cod), 1, 380);
  end;
  /* número de um NOME já pronto (tipo e local vêm com o nome na própria linha) */
  function ix_rot(p_dim varchar2, p_rot varchar2) return pls_integer is
    r varchar2(400) := substr(nvl(p_rot, 'Não informado'), 1, 380);
    n pls_integer;
  begin
    if not por_rot.exists(p_dim || '|' || r) then
      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;
      por_rot(p_dim || '|' || r) := n;
      rot(p_dim || '#' || n) := r;
      qtd(p_dim) := n + 1;
    end if;
    return por_rot(p_dim || '|' || r);
  end;
  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2) return pls_integer is
    k varchar2(400) := p_dim || '|' || p_emp || '|' || substr(p_cod, 1, 300);
  begin
    if not cache.exists(k) then cache(k) := ix_rot(p_dim, nome_dim(p_dim, p_emp, p_cod)); end if;
    return cache(k);
  end;
  /* as colunas da pessoa, em números: empresa, filial, ccusto, unidade, atividade, cargo */
  procedure org(p_emp varchar2, p_fil varchar2, p_cc varchar2, p_un varchar2, p_at varchar2, p_car varchar2) is
  begin
    apex_json.write(ix('emp', null, p_emp)); apex_json.write(ix('fil', p_emp, p_fil));
    apex_json.write(ix('cc', p_emp, p_cc));  apex_json.write(ix('un', p_emp, p_un));
    apex_json.write(ix('at', null, p_at));   apex_json.write(ix('car', null, p_car));
  end;
  function k_org(p_emp varchar2, p_fil varchar2, p_cc varchar2, p_un varchar2, p_at varchar2, p_car varchar2) return varchar2 is
  begin
    return ix('emp', null, p_emp) || ',' || ix('fil', p_emp, p_fil) || ',' || ix('cc', p_emp, p_cc) || ',' ||
           ix('un', p_emp, p_un) || ',' || ix('at', null, p_at) || ',' || ix('car', null, p_car);
  end;
  function pessoa(p_emp varchar2, p_mat varchar2) return pls_integer is
  begin
    if not pes.exists(p_emp || '|' || p_mat) then
      pes(p_emp || '|' || p_mat) := l_npes; pes_ch(to_char(l_npes)) := p_emp || '|' || p_mat; l_npes := l_npes + 1;
    end if;
    return pes(p_emp || '|' || p_mat);
  end;
  function nome_func(p_emp varchar2, p_mat varchar2) return varchar2 is
    r varchar2(400);
  begin
    begin r := p_mat || ' - ' || initcap(fnct_nome_func(p_emp, p_mat)); exception when others then r := p_mat; end;
    return substr(r, 1, 380);
  end;
  /* o local de trabalho como a coluna mostra ("6 - Açougue"); "06" e "6" são o mesmo local */
  function nome_local(p_cod varchar2, p_ds varchar2) return varchar2 is
  begin
    if p_cod is null and p_ds is null then return 'Não informado'; end if;
    return nvl(ltrim(p_cod, '0'), '0') || ' - ' || nvl(initcap(p_ds), '(sem nome)');
  end;
  procedure manda(c clob, p_ate pls_integer) is
    p pls_integer := 1;
  begin
    while p <= p_ate loop
      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));
      p := p + 8000;
    end loop;
  end;
begin
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 1);
  apex_json.write('hoje', to_char(l_hoje, 'DD/MM/YYYY'));

  /* ── as situações que são afastamento por acidente (o nome tem ACID): as de hoje e as dos
       últimos 4 anos do histórico ── */
  l_passo := 'situacoes';
  apex_json.open_array('sitAcid');
  for r in (select situacao cod from informacoes_funcionais where situacao <> '01' and situacao < '90'
            union
            select cod_valor_fato from historico_cadastral
             where cod_fato = 1 and cod_valor_fato <> '01' and cod_valor_fato < '90'
               and dt_vigencia >= add_months(l_hoje, -48)) loop
    if upper(nome_sit(r.cod)) like '%ACID%' then
      l_codacid := l_codacid || r.cod || ',';
      apex_json.write(nome_sit(r.cod));
    end if;
  end loop;
  apex_json.close_array;

  /* ── o quadro (quem não está desligado), dividido pelas colunas ── */
  l_passo := 'quadro';
  apex_json.open_array('quadroG');
  for r in (
    select i.cod_empresa emp, i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ, i.cargo car, count(*) n
      from informacoes_funcionais i
     where i.situacao < '90'
       and (l_e1 is null or i.cod_empresa = l_e1)
       and (l_m1 is null or i.matricula = l_m1)
       and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
       and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
       and (f_cc = 0 or instr(l_cc, ',' || i.cod_ccusto || ',') > 0)
       and (f_un = 0 or instr(l_un, ',' || i.unidade_adm || ',') > 0)
       and (f_at = 0 or instr(l_at, ',' || i.cod_atividade || ',') > 0)
       and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
       and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
     group by i.cod_empresa, i.filial, i.cod_ccusto, i.unidade_adm, i.cod_atividade, i.cargo
  ) loop
    l_quadro := l_quadro + r.n;
    apex_json.open_array;
    org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car);
    apex_json.write(r.n);
    apex_json.close_array;
  end loop;
  apex_json.close_array;
  apex_json.write('quadro', l_quadro);

  /* ── os acidentes: a MESMA consulta do relatório (mesmas tabelas e filtros) ── */
  l_passo := 'acidentes';
  apex_json.open_array('ac');
  for r in (
    select a.cod_empresa emp, a.matricula mat, a.cod_analise_acidente cod, a.dt_acidente dt,
           to_char(a.hor_acidente, 'hh24:mi') hora, a.cod_acidente_tipo tipo, t.descricao tipo_ds,
           a.cod_local_trab loc, a.ds_local loc_ds, a.status_cat st, a.num_protocolo cat, a.dt_emissao_cat dt_cat,
           a.qtde_dias_tratamento dtrat, a.afastamento_imediato afi,
           i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ, i.cargo car, i.situacao
      from analise_acidente a, informacoes_funcionais i, acidente_tipo t
     where a.cod_empresa = i.cod_empresa
       and a.matricula = i.matricula
       and a.cod_acidente_tipo = t.cod_acidente_tipo (+)
       and a.cod_empresa = nvl(l_e1, a.cod_empresa)
       and a.matricula = nvl(l_m1, a.matricula)
       and ((i.situacao < '90' and l_sit = 'A') or (i.situacao >= '90' and l_sit = 'D') or l_sit = 'T')
       and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
       and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
       and (f_cc = 0 or instr(l_cc, ',' || i.cod_ccusto || ',') > 0)
       and (f_un = 0 or instr(l_un, ',' || i.unidade_adm || ',') > 0)
       and (f_at = 0 or instr(l_at, ',' || i.cod_atividade || ',') > 0)
       and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
       and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
     order by a.dt_acidente desc nulls last, a.hor_acidente desc nulls last
  ) loop
    l_n := l_n + 1;
    exit when l_n > 20000;
    l_pi := pessoa(r.emp, r.mat);
    begin
      l_url := apex_page.get_url(p_page => 151, p_clear_cache => '151',
                                 p_items => 'P151_COD_EMPRESA,P151_COD_ANALISE_ACIDENTE,P151_MATRICULA',
                                 p_values => r.emp || ',' || r.cod || ',' || r.mat);
    exception when others then l_url := null;
    end;
    apex_json.open_array;
    apex_json.write(ix_rot('tipo', case when r.tipo is not null then r.tipo || ' - ' || initcap(r.tipo_ds) end));
    org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car);
    apex_json.write(ix_rot('loc', nome_local(r.loc, r.loc_ds)));
    apex_json.write(l_pi);
    apex_json.write(to_char(r.dt, 'YYYYMMDD'));
    apex_json.write(r.hora);
    apex_json.write(r.st);
    apex_json.write(case when r.cat is not null then 1 else 0 end);
    apex_json.write(r.dtrat);
    apex_json.write(case r.afi when 'S' then 1 when 'N' then 0 end);
    apex_json.write(to_char(r.cod));
    apex_json.write(l_url);
    apex_json.write(to_char(r.dt_cat, 'YYYYMMDD'));
    apex_json.close_array;
  end loop;
  apex_json.close_array;
  apex_json.write('cortou', l_n > 20000);

  /* ── AFASTADOS HOJE numa situação de acidente ── */
  l_passo := 'afastados';
  apex_json.open_array('afast');
  if l_codacid <> ',' then
    for r in (
      select i.cod_empresa emp, i.matricula mat, i.cargo car, i.cod_ccusto cc, i.situacao, i.dt_situacao, i.dt_retorno_afast,
             i.filial fil, i.unidade_adm un, i.cod_atividade ativ
        from informacoes_funcionais i
       where i.situacao <> '01' and i.situacao < '90'
         and instr(l_codacid, ',' || i.situacao || ',') > 0
       order by i.dt_situacao
    ) loop
      if passa(r.emp, r.mat, r.fil, r.cc, r.un, r.ativ, r.car, r.situacao) then
        apex_json.open_object;
        apex_json.write('n', nome_func(r.emp, r.mat));
        apex_json.write('p', pessoa(r.emp, r.mat));
        apex_json.write('c', rot('car#' || ix('car', null, r.car)));
        apex_json.write('s', rot('cc#' || ix('cc', r.emp, r.cc)));
        apex_json.write('t', nome_sit(r.situacao));
        apex_json.write('d', to_char(r.dt_situacao, 'DD/MM/YYYY'));
        apex_json.write('r', to_char(r.dt_retorno_afast, 'DD/MM/YYYY'));
        apex_json.write('k', k_org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car));
        apex_json.close_object;
      end if;
    end loop;
  end if;
  apex_json.close_array;

  /* ── ESTABILIDADE: voltou de afastamento por acidente com mais de 15 dias (auxílio do INSS)
       e ainda está nos 12 meses seguintes à volta ── */
  l_passo := 'estabilidade';
  if l_codacid <> ',' then
    for r in (
      select x.*
        from (select h.cod_empresa emp, h.matricula mat, h.cod_valor_fato sit_h, h.dt_vigencia ini,
                     coalesce(h.dt_vigencia_fim + 1,
                              (select min(h2.dt_vigencia) from historico_cadastral h2
                                where h2.cod_empresa = h.cod_empresa and h2.matricula = h.matricula
                                  and h2.cod_fato = 1 and h2.dt_vigencia > h.dt_vigencia)) volta,
                     i.cargo car, i.cod_ccusto cc, i.situacao, i.filial fil, i.unidade_adm un, i.cod_atividade ativ
                from historico_cadastral h, informacoes_funcionais i
               where h.cod_empresa = i.cod_empresa
                 and h.matricula = i.matricula
                 and h.cod_fato = 1
                 and instr(l_codacid, ',' || h.cod_valor_fato || ',') > 0
                 and h.dt_vigencia >= add_months(l_hoje, -60)
                 and i.situacao < '90') x
       where x.volta is not null
         and x.volta <= l_hoje
         and x.volta - x.ini > 15
         and add_months(x.volta - 1, 12) >= l_hoje
    ) loop
      /* quem está afastado de novo por acidente já está na outra lista */
      if instr(l_codacid, ',' || r.situacao || ',') = 0
         and passa(r.emp, r.mat, r.fil, r.cc, r.un, r.ativ, r.car, r.situacao) then
        if not estab_a.exists(r.emp || '|' || r.mat)
           or substr(estab_a(r.emp || '|' || r.mat), 1, 8) < to_char(add_months(r.volta - 1, 12), 'YYYYMMDD') then
          estab_a(r.emp || '|' || r.mat) := to_char(add_months(r.volta - 1, 12), 'YYYYMMDD') || '|' ||
            to_char(r.volta, 'DD/MM/YYYY') || '|' || to_char(add_months(r.volta - 1, 12), 'DD/MM/YYYY') || '|' ||
            r.sit_h || '|' || k_org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car) || '|' ||
            rot('car#' || ix('car', null, r.car)) || '|' || rot('cc#' || ix('cc', r.emp, r.cc));
        end if;
      end if;
    end loop;
  end if;
  apex_json.open_array('estab');
  declare
    k varchar2(400) := estab_a.first;
    v varchar2(4000);
    function parte(p_txt varchar2, p_n pls_integer) return varchar2 is
      a pls_integer := case when p_n = 1 then 1 else instr(p_txt, '|', 1, p_n - 1) + 1 end;
      b pls_integer := instr(p_txt, '|', 1, p_n);
    begin
      return substr(p_txt, a, case when b = 0 then 4000 else b - a end);
    end;
  begin
    while k is not null loop
      v := estab_a(k);
      apex_json.open_object;
      apex_json.write('n', nome_func(substr(k, 1, instr(k, '|') - 1), substr(k, instr(k, '|') + 1)));
      apex_json.write('p', pessoa(substr(k, 1, instr(k, '|') - 1), substr(k, instr(k, '|') + 1)));
      apex_json.write('v', parte(v, 2));
      apex_json.write('a', parte(v, 3));
      apex_json.write('t', nome_sit(parte(v, 4)));
      apex_json.write('k', parte(v, 5));
      apex_json.write('c', parte(v, 6));
      apex_json.write('s', parte(v, 7));
      apex_json.close_object;
      k := estab_a.next(k);
    end loop;
  end;
  apex_json.close_array;

  /* ── os nomes ── */
  l_passo := 'nomes';
  apex_json.open_object('dims');
  for j in 1 .. l_dims.count loop
    apex_json.open_array(l_dims(j));
    if qtd.exists(l_dims(j)) then
      for n in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || '#' || n)); end loop;
    end if;
    apex_json.close_array;
  end loop;
  apex_json.close_object;
  apex_json.open_object('nomes');
  declare k varchar2(400) := pes_ch.first; begin
    while k is not null loop
      apex_json.write(k, nome_func(substr(pes_ch(k), 1, instr(pes_ch(k), '|') - 1), substr(pes_ch(k), instr(pes_ch(k), '|') + 1)));
      k := pes_ch.next(k);
    end loop;
  end;
  apex_json.close_object;
  apex_json.close_object;

  l_saida := apex_json.get_clob_output;
  apex_json.free_output;
  manda(l_saida, dbms_lob.getlength(l_saida));
exception
  when others then
    apex_json.free_output;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm || ' [passo: ' || l_passo || ']') || '"}');
end;
