/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · SAÚDE E SEGURANÇA — os números do painel (Ajax Callback) — v1 (19/10)          ║
   ║  App 2937 · Página 5 (Dados de Funcionário — a lista que leva ao Histórico, página 6)     ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 5 › Processing › Ajax Callback › nome EXATO:  NC_SAUDE_INDICADORES
               (tipo PL/SQL Code). Quem chama é o Natcorp_SaudePainel.js. O aplicar-saudepainel-
               pagina5.py põe (ou troca) este bloco na exportação. Guia: SAUDEPAINEL-MANUTENCAO.md.

   DOIS PEDIDOS
     x01 = 'LINK', x02 = empresa, x03 = matrícula  →  {"url": "..."}: o endereço do Histórico do
           colaborador (página 6, janela modal), pelo apex_page.get_url — o mesmo que o lápis da lista.
     qualquer outro  →  os números. x01 = data inicial, x02 = data final (DD/MM/AAAA); sem elas, os
           últimos 12 meses (do dia 1 de 11 meses atrás até o fim do mês corrente). Até MAX_DIAS.

   AS PESSOAS são EXATAMENTE as do relatório "Dados de Funcionário" desta página: a mesma consulta
   (informacoes_funcionais + inf_pessoais_cad + local_trab) com os mesmos filtros (P5_*), lidos da
   sessão — o "Pesquisar" da página grava antes. Filtros feitos DENTRO do relatório não entram.

   O QUE SE LÊ de cada pessoa (as MESMAS tabelas do Histórico, página 6):
     E  exame_func (com resultado e entidade 1/7, como a grade Exames): o ÚLTIMO de cada exame, só
        quando ele tem "próximo exame" (dt_prox_exame_period) — é o que vence.
     U  exame_func: data do último exame (qualquer um) e quantos — "nunca fez exame".
     X  exame_func feitos no período: por mês, tipo (A/P/D/R/M/T/C) e resultado.
     A  atestado_funcionario que tocam o período OU os últimos 60 dias (a regra dos 15 dias do
        INSS): início (dt_inicio_afastamento, ou a data do atestado), término, dias, horas
        abonadas, CID, tipo, ocupacional.
     D  func_doenca sem término (doença em aberto).
     V  vacina_func: a ÚLTIMA dose de cada vacina, quando a próxima dose já venceu ou vence em 30 dias.
     R  restricao_medica (o texto da restrição).
     C  analise_acidente + analise_func com data no período (tipo, classificação, afastamento, dias, CID).
     L  o acidente mais recente de toda a população (e o mais recente com afastamento): "dias sem
        acidente".
     Q  consulta_medica no período: por pessoa e mês.
     estabilidade  historico_cadastral (a regra do painel de Acidentes, 200:150): voltou de
        afastamento por acidente com mais de 15 dias e está nos 12 meses seguintes (art. 118).

   O QUE DEVOLVE (JSON, "v": 1). Datas como DIAS a partir de hoje (hoje = 0, ontem = -1).
     hoje, painel, ini, fim, dias, total, cortou, cortouDias
     dims{emp,fil,cc,loc,car}   os NOMES, como as colunas do relatório mostram
     cat{ex,cid,tat,vac,res,sit} os nomes de exame, CID, tipo de atestado, vacina, resultado, situação
     nomes["123 - Fulano De Tal"] · pes[[emp,fil,cc,loc,car,idade,situação,últimoExame|null,nExames]]
     ex[[p,exame,último,próximo]] · xf[[p,mês,"tipo",resultado,n]]
     at[[p,início,término,dias,minutosAbonados,cid|-1,tipo|-1,"S/N",dataDoAtestado]]
     dz[[p,cid|-1,início]] · vc[[p,vacina,última,próxima,"dose"]] · rs[[p,"texto"]]
     ac[[p,data,"tipo","classe","S/N afastamento",dias,"cid"]] · ua[último, últimoComAfastamento]
     cs[[p,mês,n]] · es[[p,volta,até,situação]] · acid ",13,14," (situações de acidente)
     meses["202610", …] (xf e cs usam a POSIÇÃO do mês) · tempos{…}
     cat.sit  os nomes das situações funcionais (a situação de hoje de cada pessoa e a da estabilidade)

   CUIDADO  • NÃO filtrar com TABLE() de apex_string.split nem de coleção: nesta base, dentro do
              PL/SQL, dá ORA-22905. Os filtros de escolha múltipla ("700,91") são comparados com
              instr(',700,91,', ',código,') — o mesmo resultado da consulta do relatório.
            • Uma consulta só (pop materializada) traz tudo.
            • Números no JSON só inteiros (to_char FM): vírgula decimal quebraria o JSON.
            • Só LÊ. Não grava nada.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  MAX_PES   constant pls_integer := 10000;     /* acima disso o painel pede para filtrar */
  MAX_DIAS  constant pls_integer := 731;       /* período maior que isso: corta (2 anos) */
  INSS_DIAS constant pls_integer := 60;        /* janela da regra dos 15 dias (atestados) */
  l_hoje    date := trunc(sysdate);
  l_ini     date;
  l_fim     date;
  l_wini    date;
  l_wfim    date;
  l_cortouD boolean := false;
  l_saida   clob;
  l_cru     clob;
  l_buf     varchar2(32767);
  l_passo   varchar2(30) := 'inicio';
  l_t0      number := dbms_utility.get_time;
  l_t1      number;
  l_t2      number;
  l_n       pls_integer;
  l_pi      pls_integer;
  l_total   pls_integer := 0;
  l_cortou  boolean := false;
  l_corte   pls_integer;
  l_ua      varchar2(20) := 'null';
  l_ua2     varchar2(20) := 'null';
  l_dims    sys.odcivarchar2list := sys.odcivarchar2list('emp', 'fil', 'cc', 'loc', 'car');
  l_cats    sys.odcivarchar2list := sys.odcivarchar2list('ex', 'cid', 'tat', 'vac', 'res', 'sit');

  /* os filtros do relatório: ",700,91," e a linha entra quando ",código," está dentro */
  l_emp varchar2(32767) := ',' || :P5_EMPRESA || ',';     f_emp number := case when :P5_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P5_FILIAL || ',';      f_fil number := case when :P5_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P5_CCUSTO || ',';      f_cc  number := case when :P5_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P5_UNIDADE_ADM || ','; f_un  number := case when :P5_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P5_ATIVIDADE || ',';   f_at  number := case when :P5_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P5_CARGO || ',';       f_car number := case when :P5_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P5_MATRICULA || ',';   f_mat number := case when :P5_MATRICULA is null then 0 else 1 end;
  l_sit varchar2(10)    := nvl(:P5_SITUACAO, 'A');

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(4000) index by varchar2(400);
  type t_lin is table of varchar2(4000) index by pls_integer;
  cache   t_num;      /* "dim|empresa|código|código2" → número do nome */
  por_rot t_num;      /* "dim|nome" → número (dois códigos com o MESMO nome viram um só, como na tabela) */
  qtd     t_num;      /* dim → quantos nomes */
  rot     t_txt;      /* "dim#número" → nome */
  pes     t_num;      /* "empresa|matrícula" → número da pessoa */
  lin     t_lin;      /* número da pessoa → a linha de "pes", pronta */
  nom     t_lin;      /* número da pessoa → "mat - Nome" */
  ult     t_lin;      /* número da pessoa → "último exame,quantos" */
  mes     t_num;      /* "yyyymm" → número do mês */
  l_npes  pls_integer := 0;
  l_nmes  pls_integer := 0;
  /* as listas, escritas à mão (cada uma no seu CLOB) */
  c_ex clob; c_xf clob; c_at clob; c_dz clob; c_vc clob; c_rs clob; c_ac clob; c_cs clob; c_es clob;
  n_es pls_integer := 0;
  l_codacid varchar2(4000) := ',';              /* ",13,14," = situações de afastamento por acidente */
  type t_dt is table of date index by pls_integer;
  es_ate t_dt;                                  /* número da pessoa → fim da estabilidade mais longa */
  es_lin t_lin;
  n_ex pls_integer := 0; n_xf pls_integer := 0; n_at pls_integer := 0; n_dz pls_integer := 0;
  n_vc pls_integer := 0; n_rs pls_integer := 0; n_ac pls_integer := 0; n_cs pls_integer := 0;

  procedure descarrega is
  begin
    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;
  end;
  procedure cru(p varchar2) is
  begin
    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;
    l_buf := l_buf || p;
  end;
  procedure poe(c in out nocopy clob, qt in out pls_integer, p varchar2) is
    t varchar2(4000) := case when qt > 0 then ',' end || p;
  begin
    if c is null then dbms_lob.createtemporary(c, true); end if;
    dbms_lob.writeappend(c, length(t), t);
    qt := qt + 1;
  end;
  procedure junta(nome varchar2, c in out nocopy clob) is
  begin
    descarrega;
    cru(',"' || nome || '":[');
    descarrega;
    if c is not null then dbms_lob.append(l_cru, c); dbms_lob.freetemporary(c); end if;
    cru(']');
  end;
  procedure manda(c clob, p_ate number) is
    p number := 1;
  begin
    while p <= p_ate loop
      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));
      p := p + 8000;
    end loop;
  end;
  function js(p varchar2) return varchar2 is
  begin
    return '"' || apex_escape.json(p) || '"';
  end;
  function n(p number) return varchar2 is
  begin
    return to_char(round(nvl(p, 0)), 'FM99999999990');
  end;
  /* data → dias a partir de hoje (sem data: null) */
  function dd(p date) return varchar2 is
  begin
    if p is null then return 'null'; end if;
    return to_char(trunc(p) - l_hoje, 'FM99999999990');
  end;
  function data_de(p varchar2) return date is
  begin
    if p is null then return null; end if;
    begin return to_date(p, 'DD/MM/YYYY'); exception when others then return null; end;
  end;
  /* "8", "08:00", "8,5" → minutos */
  function minutos(p varchar2) return number is
    t varchar2(400) := trim(p);
  begin
    if t is null then return 0; end if;
    if instr(t, ':') > 0 then
      return to_number(substr(t, 1, instr(t, ':') - 1)) * 60 + to_number(substr(t, instr(t, ':') + 1, 2));
    end if;
    return round(to_number(replace(t, ',', '.'), '99999999990D9999', 'NLS_NUMERIC_CHARACTERS=''.,''') * 60);
  exception when others then return 0;
  end;

  /* o nome de um código, IGUAL ao da coluna do relatório (dims) ou da lista da página 6 (cat) */
  function nome_de(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2) return varchar2 is
    r varchar2(4000);
  begin
    if p_cod is null then return 'Não informado'; end if;
    begin
      if p_dim = 'emp' then
        select max(emp.cod || ' - ' || emp.nome) into r from empresas emp where emp.cod = p_cod;
      elsif p_dim = 'fil' then
        select max(fi.cod_filial || ' - ' || fi.nome_filial) into r from filiais fi where fi.cod_empresa = p_emp and fi.cod_filial = p_cod;
      elsif p_dim = 'cc' then
        r := p_cod || ' - ' || fnct_nome_ccusto(p_emp, p_cod);
      elsif p_dim = 'loc' then
        r := p_cod || ' - ' || p_cod2;
      elsif p_dim = 'car' then
        select max(cod || ' - ' || nome) into r from cargos where cod = p_cod;
      elsif p_dim = 'ex' then
        select max(cod_exame || ' - ' || descricao) into r from exame where cod_exame = p_cod;
      elsif p_dim = 'cid' then
        select max(substr(cod_doenca, 1, 5) || ' - ' || descricao) into r from doenca where cod_doenca = p_cod;
      elsif p_dim = 'tat' then
        select max(substr(cod_atestado_medico, 1, 5) || ' - ' || descricao) into r from atestado_medico where cod_atestado_medico = p_cod;
      elsif p_dim = 'vac' then
        select max(cod_vacina || ' - ' || descricao) into r from vacina where cod_vacina = p_cod;
      elsif p_dim = 'res' then
        r := p_cod2;
      elsif p_dim = 'sit' then
        r := p_cod || ' - ' || initcap(fnct_nome_situacao(p_cod));
      end if;
    exception when others then r := null;
    end;
    return substr(nvl(r, p_cod), 1, 380);
  end;
  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is
    k varchar2(400) := substr(p_dim || '|' || p_emp || '|' || p_cod || '|' || p_cod2, 1, 400);
    t varchar2(400);
    i pls_integer;
  begin
    if cache.exists(k) then return cache(k); end if;
    t := nome_de(p_dim, p_emp, p_cod, p_cod2);
    if por_rot.exists(p_dim || '|' || t) then
      i := por_rot(p_dim || '|' || t);
    else
      i := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;
      qtd(p_dim) := i + 1;
      rot(p_dim || '#' || i) := t;
      por_rot(p_dim || '|' || t) := i;
    end if;
    cache(k) := i;
    return i;
  end;
  /* código opcional: sem código → -1 */
  function ixo(p_dim varchar2, p_cod varchar2) return varchar2 is
  begin
    if p_cod is null then return '-1'; end if;
    return to_char(ix(p_dim, null, p_cod));
  end;
  function im(p varchar2) return pls_integer is
  begin
    if not mes.exists(p) then mes(p) := l_nmes; l_nmes := l_nmes + 1; end if;
    return mes(p);
  end;
begin
  /* o LINK do Histórico (página 6) de uma pessoa: o mesmo endereço do lápis da lista */
  if apex_application.g_x01 = 'LINK' then
    htp.prn('{"url":' || js(apex_page.get_url(p_page => 6, p_clear_cache => 'RP,6',
                                              p_items => 'P6_COD_EMPRESA,P6_MATRICULA',
                                              p_values => apex_application.g_x02 || ',' || apex_application.g_x03)) || '}');
    return;
  end if;

  /* o período: o que o painel mandou, ou os últimos 12 meses */
  l_ini := data_de(apex_application.g_x01);
  l_fim := data_de(apex_application.g_x02);
  if l_ini is null then l_ini := add_months(trunc(l_hoje, 'MM'), -11); end if;
  if l_fim is null then l_fim := last_day(l_hoje); end if;
  if l_fim < l_ini then l_fim := l_ini; end if;
  if l_fim - l_ini + 1 > MAX_DIAS then l_fim := l_ini + MAX_DIAS - 1; l_cortouD := true; end if;
  /* atestados: o período E os últimos 60 dias (regra do INSS) */
  l_wini := least(l_ini, l_hoje - INSS_DIAS);
  l_wfim := greatest(l_fim, l_hoje);
  /* os meses do período, em ordem */
  declare d date := trunc(l_ini, 'MM'); x pls_integer; begin
    while d <= l_fim loop x := im(to_char(d, 'yyyymm')); d := add_months(d, 1); end loop;
  end;

  dbms_lob.createtemporary(l_cru, true);
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 1);
  apex_json.write('hoje', to_char(l_hoje, 'dd/mm/yyyy'));
  apex_json.write('painel', :P_PAINEL);
  apex_json.write('ini', to_char(l_ini, 'dd/mm/yyyy'));
  apex_json.write('fim', to_char(l_fim, 'dd/mm/yyyy'));
  apex_json.write('dias', l_fim - l_ini + 1);
  apex_json.write('cortouDias', l_cortouD);

  l_passo := 'consulta';
  l_t1 := dbms_utility.get_time;
  for r in (
    with pop as (
      /* A CONSULTA DO RELATÓRIO, só com os códigos (o mesmo where) */
      select /*+ materialize */
             infu.cod_empresa emp, infu.matricula mat, infu.filial fil, infu.cod_ccusto cc,
             infu.cod_localizacao loc, lotr.descricao locd, infu.cargo car,
             trunc(trunc(sysdate - inpe.dt_nasc) / 360) idade, infu.situacao sit
        from informacoes_funcionais infu
            ,inf_pessoais_cad inpe
            ,local_trab lotr
       where infu.cod_empresa = inpe.cod_empresa
         and infu.matricula = inpe.matricula
         and lotr.cod_local_trab = infu.cod_localizacao
         and ((infu.situacao < '90' and l_sit = 'A') or (infu.situacao >= '90' and l_sit = 'D') or (l_sit = 'T'))
         and (f_emp = 0 or instr(l_emp, ',' || infu.cod_empresa || ',') > 0)
         and (f_fil = 0 or instr(l_fil, ',' || infu.filial || ',') > 0)
         and (f_cc  = 0 or instr(l_cc,  ',' || infu.cod_ccusto || ',') > 0)
         and (f_un  = 0 or instr(l_un,  ',' || infu.unidade_adm || ',') > 0)
         and (f_at  = 0 or instr(l_at,  ',' || infu.cod_atividade || ',') > 0)
         and (f_car = 0 or instr(l_car, ',' || infu.cargo || ',') > 0)
         and (f_mat = 0 or instr(l_mat, ',' || infu.matricula || ',') > 0)
    )
    /* P: as pessoas (vêm primeiro) */
    select 0 ord, 'P' k, p.emp, p.mat, to_char(p.fil) c1, to_char(p.cc) c2, to_char(p.loc) c3, to_char(p.car) c4,
           cast(p.locd as varchar2(4000)) c5, cast(p.sit as varchar2(4000)) c6, cast(null as date) d1, cast(null as date) d2, cast(null as date) d3, p.idade n1
      from pop p
    union all
    /* E: o último de cada exame, quando ele tem "próximo exame" */
    select 1, 'E', x.cod_empresa, x.matricula, to_char(x.cod_exame), null, null, null, null, null, x.dt_exame, x.dt_prox_exame_period, null, null
      from (select e.cod_empresa, e.matricula, e.cod_exame, e.dt_exame, e.dt_prox_exame_period,
                   row_number() over (partition by e.cod_empresa, e.matricula, e.cod_exame
                                      order by e.dt_exame desc, e.dt_prox_exame_period desc nulls last) rn
              from exame_func e, resultado rs, pop p
             where e.cod_resultado = rs.cod_resultado
               and e.tipo_entidade in (1, 7)
               and e.cod_empresa = p.emp
               and e.matricula = p.mat) x
     where x.rn = 1
       and x.dt_prox_exame_period is not null
    union all
    /* U: o último exame (qualquer um) e quantos */
    select 1, 'U', e.cod_empresa, e.matricula, null, null, null, null, null, null, max(e.dt_exame), null, null, count(*)
      from exame_func e, resultado rs, pop p
     where e.cod_resultado = rs.cod_resultado
       and e.tipo_entidade in (1, 7)
       and e.cod_empresa = p.emp
       and e.matricula = p.mat
     group by e.cod_empresa, e.matricula
    union all
    /* X: exames feitos no período, por mês, tipo e resultado */
    select 1, 'X', e.cod_empresa, e.matricula, to_char(e.dt_exame, 'yyyymm'), e.tipo_exame, to_char(rs.cod_resultado),
           to_char(rs.cod_resultado) || ' - ' || initcap(rs.descricao), null, null, null, null, null, count(*)
      from exame_func e, resultado rs, pop p
     where e.cod_resultado = rs.cod_resultado
       and e.tipo_entidade in (1, 7)
       and e.cod_empresa = p.emp
       and e.matricula = p.mat
       and e.dt_exame between l_ini and l_fim
     group by e.cod_empresa, e.matricula, to_char(e.dt_exame, 'yyyymm'), e.tipo_exame, rs.cod_resultado, rs.descricao
    union all
    /* A: atestados que tocam o período ou os últimos 60 dias */
    select 1, 'A', a.cod_empresa, a.matricula, to_char(a.cod_doenca), to_char(a.cod_atestado_medico), to_char(a.ocupacional),
           to_char(a.qtde_horas_abonadas), null, null,
           nvl(a.dt_inicio_afastamento, a.dt_atestado_medico), a.dt_termino_afastamento, a.dt_atestado_medico, a.qtde_dias_afastamento
      from atestado_funcionario a, pop p
     where a.cod_empresa = p.emp
       and a.matricula = p.mat
       and nvl(a.dt_inicio_afastamento, a.dt_atestado_medico) <= l_wfim
       and nvl(a.dt_termino_afastamento, nvl(a.dt_inicio_afastamento, a.dt_atestado_medico) + greatest(nvl(a.qtde_dias_afastamento, 1), 1) - 1) >= l_wini
    union all
    /* D: doenças sem término */
    select 1, 'D', f.cod_empresa, f.matricula, to_char(f.cod_doenca), null, null, null, null, null, f.dt_inicio, null, null, null
      from func_doenca f, pop p
     where f.cod_empresa = p.emp
       and f.matricula = p.mat
       and f.dt_termino is null
    union all
    /* V: a última dose de cada vacina, quando a próxima já venceu ou vence em 30 dias */
    select 1, 'V', x.cod_empresa, x.matricula, to_char(x.cod_vacina), to_char(x.cod_dose), null, null, null, null, x.dt_vacina, x.dt_prox_dose, null, null
      from (select f.cod_empresa, f.matricula, f.cod_vacina, f.cod_dose, f.dt_vacina, f.dt_prox_dose,
                   row_number() over (partition by f.cod_empresa, f.matricula, f.cod_vacina order by f.dt_vacina desc) rn
              from vacina_func f, pop p
             where f.cod_empresa = p.emp
               and f.matricula = p.mat) x
     where x.rn = 1
       and x.dt_prox_dose is not null
       and x.dt_prox_dose <= l_hoje + 30
    union all
    /* R: restrição médica */
    select 1, 'R', m.cod_empresa, m.matricula, substr(m.restricao, 1, 240), null, null, null, null, null, null, null, null, null
      from restricao_medica m, pop p
     where m.cod_empresa = p.emp
       and m.matricula = p.mat
       and m.restricao is not null
    union all
    /* C: acidentes no período */
    select 1, 'C', aa.cod_empresa, aa.matricula, to_char(aa.cod_acidente_tipo), to_char(aa.class_acidente), to_char(af.ind_afastamento),
           to_char(af.cid), null, null, aa.dt_acidente, null, null,
           /* o tipo desta coluna não está na exportação: lida como texto, só número inteiro conta */
           case when regexp_like(trim(to_char(af.quantidade_dias_afastamento)), '^[0-9]{1,6}$')
                then to_number(trim(to_char(af.quantidade_dias_afastamento))) end
      from analise_acidente aa, analise_func af, pop p
     where aa.cod_empresa = af.cod_empresa
       and aa.matricula = af.matricula
       and aa.cod_analise_acidente = af.cod_analise_acidente
       and aa.cod_empresa = p.emp
       and aa.matricula = p.mat
       and aa.dt_acidente between l_ini and l_fim
    union all
    /* L: o acidente mais recente de toda a população (e o mais recente com afastamento) */
    select 1, 'L', null, null, null, null, null, null, null, null,
           max(aa.dt_acidente), max(case when af.ind_afastamento = 'S' then aa.dt_acidente end), null, null
      from analise_acidente aa, analise_func af, pop p
     where aa.cod_empresa = af.cod_empresa
       and aa.matricula = af.matricula
       and aa.cod_analise_acidente = af.cod_analise_acidente
       and aa.cod_empresa = p.emp
       and aa.matricula = p.mat
       and aa.dt_acidente <= l_hoje
    union all
    /* Q: consultas no período, por pessoa e mês */
    select 1, 'Q', cm.cod_empresa, cm.matricula, to_char(cm.dt_consulta, 'yyyymm'), null, null, null, null, null, null, null, null, count(*)
      from consulta_medica cm, pop p
     where cm.cod_empresa = p.emp
       and cm.matricula = p.mat
       and cm.dt_consulta between l_ini and l_fim
     group by cm.cod_empresa, cm.matricula, to_char(cm.dt_consulta, 'yyyymm')
     order by 1
  ) loop
    if r.k = 'P' then
      l_total := l_total + 1;
      if not pes.exists(r.emp || '|' || r.mat) then
        if l_npes >= MAX_PES then
          l_cortou := true;
        else
          pes(r.emp || '|' || r.mat) := l_npes;
          nom(l_npes) := r.mat || ' - ' || initcap(fnct_nome_func(r.emp, r.mat));
          lin(l_npes) := ix('emp', r.emp, r.emp) || ',' || ix('fil', r.emp, r.c1) || ',' || ix('cc', r.emp, r.c2) || ',' ||
                         ix('loc', null, r.c3, r.c5) || ',' || ix('car', null, r.c4) || ',' ||
                         case when r.n1 is null then 'null' else n(r.n1) end || ',' || ixo('sit', r.c6);
          l_npes := l_npes + 1;
        end if;
      end if;
    elsif r.k = 'L' then
      l_ua := dd(r.d1); l_ua2 := dd(r.d2);
    elsif pes.exists(r.emp || '|' || r.mat) then
      l_pi := pes(r.emp || '|' || r.mat);
      if r.k = 'E' then
        poe(c_ex, n_ex, '[' || l_pi || ',' || ix('ex', null, r.c1) || ',' || dd(r.d1) || ',' || dd(r.d2) || ']');
      elsif r.k = 'U' then
        ult(l_pi) := dd(r.d1) || ',' || n(r.n1);
      elsif r.k = 'X' then
        poe(c_xf, n_xf, '[' || l_pi || ',' || im(r.c1) || ',' || js(r.c2) || ',' || ix('res', null, r.c3, r.c4) || ',' || n(r.n1) || ']');
      elsif r.k = 'A' then
        poe(c_at, n_at, '[' || l_pi || ',' || dd(r.d1) || ',' || dd(r.d2) || ',' || case when r.n1 is null then 'null' else n(r.n1) end || ',' ||
                        n(minutos(r.c4)) || ',' || ixo('cid', r.c1) || ',' || ixo('tat', r.c2) || ',' || js(r.c3) || ',' || dd(r.d3) || ']');
      elsif r.k = 'D' then
        poe(c_dz, n_dz, '[' || l_pi || ',' || ixo('cid', r.c1) || ',' || dd(r.d1) || ']');
      elsif r.k = 'V' then
        poe(c_vc, n_vc, '[' || l_pi || ',' || ix('vac', null, r.c1) || ',' || dd(r.d1) || ',' || dd(r.d2) || ',' || js(r.c2) || ']');
      elsif r.k = 'R' then
        poe(c_rs, n_rs, '[' || l_pi || ',' || js(r.c1) || ']');
      elsif r.k = 'C' then
        poe(c_ac, n_ac, '[' || l_pi || ',' || dd(r.d1) || ',' || js(r.c1) || ',' || js(r.c2) || ',' || js(r.c3) || ',' ||
                        case when r.n1 is null then 'null' else n(r.n1) end || ',' || js(r.c4) || ']');
      elsif r.k = 'Q' then
        poe(c_cs, n_cs, '[' || l_pi || ',' || im(r.c1) || ',' || n(r.n1) || ']');
      end if;
    end if;
  end loop;
  l_t2 := dbms_utility.get_time;

  /* ESTABILIDADE (art. 118 da Lei 8.213 — a MESMA regra do painel de Acidentes, 200:150): voltou de
     afastamento por acidente (situação com ACID no nome) com mais de 15 dias e ainda está nos 12 meses
     seguintes à volta. A volta é o fim do histórico (+1) ou o início da situação seguinte. */
  l_passo := 'estabilidade';
  for r in (select situacao cod from informacoes_funcionais where situacao <> '01' and situacao < '90'
            union
            select cod_valor_fato from historico_cadastral
             where cod_fato = 1 and cod_valor_fato <> '01' and cod_valor_fato < '90'
               and dt_vigencia >= add_months(l_hoje, -48)) loop
    begin
      if upper(fnct_nome_situacao(r.cod)) like '%ACID%' then l_codacid := l_codacid || r.cod || ','; end if;
    exception when others then null;
    end;
  end loop;
  if l_codacid <> ',' then
    for r in (
      select x.*
        from (select h.cod_empresa emp, h.matricula mat, h.cod_valor_fato sit_h, h.dt_vigencia ini,
                     coalesce(h.dt_vigencia_fim + 1,
                              (select min(h2.dt_vigencia) from historico_cadastral h2
                                where h2.cod_empresa = h.cod_empresa and h2.matricula = h.matricula
                                  and h2.cod_fato = 1 and h2.dt_vigencia > h.dt_vigencia)) volta,
                     i.situacao
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
      /* só quem está na lista; quem está afastado de novo por acidente aparece como afastado */
      if pes.exists(r.emp || '|' || r.mat) and instr(l_codacid, ',' || r.situacao || ',') = 0 then
        l_pi := pes(r.emp || '|' || r.mat);
        if not es_ate.exists(l_pi) or es_ate(l_pi) < add_months(r.volta - 1, 12) then
          es_ate(l_pi) := add_months(r.volta - 1, 12);
          es_lin(l_pi) := '[' || l_pi || ',' || dd(r.volta) || ',' || dd(add_months(r.volta - 1, 12)) || ',' || ixo('sit', r.sit_h) || ']';
        end if;
      end if;
    end loop;
    declare i pls_integer := es_lin.first; begin
      while i is not null loop poe(c_es, n_es, es_lin(i)); i := es_lin.next(i); end loop;
    end;
  end if;

  /* as listas escritas à mão: pes (com o último exame), depois cada tabela */
  l_passo := 'montar';
  cru('"pes":[');
  for i in 0 .. l_npes - 1 loop
    cru(case when i > 0 then ',' end || '[' || lin(i) || ',' || case when ult.exists(i) then ult(i) else 'null,0' end || ']');
  end loop;
  cru(']');
  junta('ex', c_ex); junta('xf', c_xf); junta('at', c_at); junta('dz', c_dz);
  junta('vc', c_vc); junta('rs', c_rs); junta('ac', c_ac); junta('cs', c_cs); junta('es', c_es);
  cru(',"acid":' || js(l_codacid));
  cru(',"ua":[' || l_ua || ',' || l_ua2 || ']');
  cru(',"meses":[');
  declare k varchar2(400) := mes.first; t t_lin; begin
    while k is not null loop t(mes(k)) := k; k := mes.next(k); end loop;
    for i in 0 .. l_nmes - 1 loop cru(case when i > 0 then ',' end || '"' || t(i) || '"'); end loop;
  end;
  cru(']');
  descarrega;

  apex_json.write('total', l_total);
  apex_json.write('cortou', l_cortou);
  apex_json.open_object('dims');
  for j in 1 .. l_dims.count loop
    apex_json.open_array(l_dims(j));
    if qtd.exists(l_dims(j)) then
      for k in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || '#' || k)); end loop;
    end if;
    apex_json.close_array;
  end loop;
  apex_json.close_object;
  apex_json.open_object('cat');
  for j in 1 .. l_cats.count loop
    apex_json.open_array(l_cats(j));
    if qtd.exists(l_cats(j)) then
      for k in 0 .. qtd(l_cats(j)) - 1 loop apex_json.write(rot(l_cats(j) || '#' || k)); end loop;
    end if;
    apex_json.close_array;
  end loop;
  apex_json.close_object;
  apex_json.open_array('nomes');
  for i in 0 .. l_npes - 1 loop apex_json.write(nom(i)); end loop;
  apex_json.close_array;
  apex_json.open_object('tempos');
  apex_json.write('consulta', l_t2 - l_t1);
  apex_json.write('total', dbms_utility.get_time - l_t0);
  apex_json.close_object;
  apex_json.close_object;
  l_saida := apex_json.get_clob_output;
  apex_json.free_output;

  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + as listas escritas à mão + "}" */
  l_corte := dbms_lob.getlength(l_saida);
  while l_corte > 0 and dbms_lob.substr(l_saida, 1, l_corte) <> '}' loop l_corte := l_corte - 1; end loop;
  manda(l_saida, l_corte - 1);
  htp.prn(',');
  manda(l_cru, dbms_lob.getlength(l_cru));
  htp.prn('}');
  dbms_lob.freetemporary(l_cru);
exception
  when others then
    apex_json.free_output;
    if l_cru is not null and dbms_lob.istemporary(l_cru) = 1 then dbms_lob.freetemporary(l_cru); end if;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm || ' [passo: ' || l_passo || ']') || '"}');
end;
