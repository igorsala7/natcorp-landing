/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · CONFERÊNCIA DO PONTO — os números do painel (Ajax Callback) — v2 (19/10)       ║
   ║  App 9503 · Página 204 (Abono Individual — a lista que leva à Tratativa de Abono, 203)    ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 204 › Processing › Ajax Callback › nome EXATO:  NC_PONTO_INDICADORES
               (tipo PL/SQL Code). Quem chama é o Natcorp_PontoPainel.js. O aplicar-pontopainel-
               pagina204.py põe (ou troca) este bloco na exportação. Guia: PONTOPAINEL-MANUTENCAO.md.

   O PERÍODO vem do painel: x01 = data inicial, x02 = data final (DD/MM/AAAA). Sem elas, o mês
   corrente (do dia 1 ao último dia). Até MAX_DIAS dias (6 meses); acima disso, corta e avisa.

   AS PESSOAS são EXATAMENTE as do relatório "Colaboradores" desta página: a mesma consulta (as
   duas metades, "Colaboradores Diretos" Sim e Não), com a mesma segurança
   (PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA, gestor/suplente do centro de custo ou da subseção, o
   gestor não vê a si mesmo no painel do gestor) e os mesmos filtros (P204_*), lidos da sessão — o
   "Pesquisar" da página grava antes. Os filtros feitos DENTRO do relatório (menu Ações) não entram.

   O QUE SE CONTA no período (as mesmas tabelas que a 203 mostra para uma pessoa):
     batidas    PE_TRATAMENTO_BATIMENTOS, por dia (nvl(vira_dia, data_ponto)): posições com horário
                (o abonado vale no lugar do original) ou justificativa; as ajustadas (hora_batida_abono);
                as horas trabalhadas (soma dos pares 1-2, 3-4…, só em dia com batidas pares) e, por dia,
                os RISCOS À CLT (somados num número: 1 + 2 + 4):
                  1 interjornada  descanso < 11 h entre a última batida do dia anterior e a 1ª do dia
                                  (CLT art. 66)
                  2 jornada longa  mais de 10 h trabalhadas no dia (8 h + 2 h extras, art. 59)
                  4 intervalo      mais de 6 h trabalhadas com intervalo < 1 h, ou sem intervalo (art. 71)
                Os horários são lidos como hora do dia (hh24:mi) e virada de meia-noite é tratada.
     eventos    PE_RESULTADO_APURACAO, por pessoa, evento e mês, com a regra do quadro "Período" da 203
                (Consolidação): sem o id_apuracao 9020; sem plantão; jornada tipo 2 (pe_jornadas, no
                fim do período) só os eventos consolidados (id_apuracao > 9000). Banco: crédito/débito
                pelo PE_EVENTOS_BANCO.TIPO; Ponto (folha): PE_EVENTOS_FOLHA.
     pedidos    com data do ponto no período, por situação (cod_sit_req): ajuste de marcação
                (PE_REQ_TRATAMENTO_BATIMENTOS), apuração (PE_REQ_APURACAO + CONSULTA_REQUISICOES
                'REQ_APURA') e hora extra (PE_REQ_HORA_EXTRA + 'REQ_HE'). Conta pedidos (cod_req).
     previstas  as horas previstas de cada pessoa no período, pela função do espelho de ponto
                (pkg_espelho_ponto.CF_TOTAL_HORAS_PREVISTAS — a mesma que a 203 já chamou). É a
                base do ABSENTEÍSMO. Chamada por SQL dinâmico (se não existir, ou der erro, o painel
                estima) e com limite de tempo (PREV_SEG); quando corta, avisa.

   O QUE DEVOLVE (JSON, "v": 2)
     hoje, painel, ini, fim, dias, total, cortou, cortouDias
     dims{emp,fil,cc,un,at,car,sind,gest,vin}   os NOMES, como as colunas do relatório mostram
     per[["dd/mm/aaaa","dd/mm/aaaa"]]   os períodos do PONTO de cada empresa (fechamento)
     evs[["101 - Hora Extra 50%","H"]]  os eventos: C crédito / D débito (banco) · H folha
     meses["202610", …]                 os meses do período
     nomes["123 - Fulano De Tal"], u0   cada pessoa e o começo do link da 203
     pes[[emp,fil,cc,un,at,car,sind,gest,vin, período do ponto, trabalhando(1/0), "resto do link"]]
     dm / da / df  uma tira por pessoa, um caractere por dia do período: batidas (0-9), ajustadas
                   (0-9) e riscos (0-7)
     tr[]  minutos trabalhados no período · pv[]  minutos previstos (-1 = sem a função)
     ev[[pessoa, evento, mês, minutos]] · req[[pessoa, tipo 0/1/2, situação 1-6, pedidos, dias esperando]]
     prev{ok, falhas, parcial} · tempos{…}

   CUIDADO  • NÃO filtrar com TABLE() de apex_string.split nem de coleção: nesta base, dentro do
              PL/SQL, dá ORA-22905 (visto na 200:25). Os filtros de escolha múltipla ("700,91") são
              comparados com instr(',700,91,', ',código,') — o mesmo resultado da consulta do relatório.
            • Uma consulta só (pop/per materializados) traz pessoas, dias, eventos e pedidos:
              RETORNA_MOSTRA roda UMA vez por pessoa.
            • O link da 203 sai do apex_page.get_url: a 203 exige checksum (proteção "C").
            • Números no JSON só inteiros (to_char FM): vírgula decimal quebraria o JSON.
            • Só LÊ. Não grava nada.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  MAX_PES   constant pls_integer := 8000;      /* acima disso o painel pede para filtrar */
  MAX_DIAS  constant pls_integer := 186;       /* período maior que isso: corta (6 meses) */
  PREV_SEG  constant pls_integer := 20;        /* segundos, no total, para as horas previstas */
  l_hoje    date := trunc(sysdate);
  l_ini     date;
  l_fim     date;
  l_len     pls_integer;
  l_cortouD boolean := false;
  l_saida   clob;
  l_cru     clob;
  l_buf     varchar2(32767);
  l_passo   varchar2(30) := 'inicio';
  l_t0      number := dbms_utility.get_time;
  l_t1      number;
  l_t2      number;
  l_tp      number := 0;                       /* centésimos gastos nas horas previstas */
  l_tq      number;
  l_n       pls_integer;
  l_pi      pls_integer;
  l_off     pls_integer;
  l_total   pls_integer := 0;
  l_cortou  boolean := false;
  l_u0      varchar2(4000);
  l_url     varchar2(4000);
  l_corte   pls_integer;
  l_r       varchar2(400);
  l_pok     pls_integer := 0;
  l_pfal    pls_integer := 0;
  l_pcorte  boolean := false;
  l_dims    sys.odcivarchar2list := sys.odcivarchar2list('emp', 'fil', 'cc', 'un', 'at', 'car', 'sind', 'gest', 'vin');

  /* os filtros do relatório: ",700,91," e a linha entra quando ",código," está dentro */
  l_emp varchar2(32767) := ',' || :P204_EMPRESA || ',';     f_emp number := case when :P204_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P204_FILIAL || ',';      f_fil number := case when :P204_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P204_CCUSTO || ',';      f_cc  number := case when :P204_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P204_UNIDADE_ADM || ','; f_un  number := case when :P204_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P204_ATIVIDADE || ',';   f_at  number := case when :P204_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P204_CARGO || ',';       f_car number := case when :P204_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P204_MATRICULA || ',';   f_mat number := case when :P204_MATRICULA is null then 0 else 1 end;
  l_sit  varchar2(10)   := nvl(:P204_SITUACAO, 'A');
  l_dir  varchar2(10)   := :P204_CHK_COLABORADORES_DIRETOS;

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(4000) index by varchar2(400);
  type t_lin is table of varchar2(4000) index by pls_integer;
  type t_val is table of number index by pls_integer;
  cache   t_num;      /* "dim|empresa|código" → número do nome */
  por_rot t_num;      /* "dim|nome" → número (dois códigos com o MESMO nome viram um só, como na tabela) */
  qtd     t_num;      /* dim → quantos nomes */
  rot     t_txt;      /* "dim#número" → nome */
  pes     t_num;      /* "empresa|matrícula" → número da pessoa */
  pes_k   t_lin;      /* número da pessoa → "empresa|matrícula" (para as horas previstas) */
  dm      t_lin;      /* número da pessoa → batidas por dia */
  da      t_lin;      /* número da pessoa → ajustadas por dia */
  df      t_lin;      /* número da pessoa → riscos por dia */
  tr      t_val;      /* número da pessoa → minutos trabalhados */
  pv      t_val;      /* número da pessoa → minutos previstos (-1 = sem) */
  lin     t_lin;      /* número da pessoa → a linha de "pes", pronta */
  rq      t_lin;      /* número da pessoa → os pedidos dela, prontos */
  nom     t_lin;      /* número da pessoa → "mat - Nome" */
  pers    t_num;      /* "ini|fim" → número do período do ponto */
  pers_t  t_lin;      /* número do período → '["ini","fim"]' */
  evn     t_num;      /* "B|cod" / "P|cod" → número do evento */
  evs_t   t_lin;      /* número do evento → nome */
  evs_k   t_lin;      /* número do evento → C / D / H */
  mes     t_num;      /* "yyyymm" → número do mês */
  l_npes  pls_integer := 0;
  l_nper  pls_integer := 0;
  l_nev   pls_integer := 0;
  l_nmes  pls_integer := 0;
  l_ne    pls_integer := 0;

  procedure descarrega is
  begin
    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;
  end;
  procedure cru(p varchar2) is
  begin
    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;
    l_buf := l_buf || p;
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
  function data_de(p varchar2) return date is
  begin
    if p is null then return null; end if;
    begin return to_date(p, 'DD/MM/YYYY'); exception when others then return null; end;
  end;
  /* "176:30", "176,5", "176.5" → minutos */
  function minutos(p varchar2) return number is
    t varchar2(400) := trim(p);
    s number := 1;
  begin
    if t is null then return null; end if;
    if substr(t, 1, 1) = '-' then s := -1; t := substr(t, 2); end if;
    if instr(t, ':') > 0 then
      return s * (to_number(substr(t, 1, instr(t, ':') - 1)) * 60 + to_number(substr(t, instr(t, ':') + 1, 2)));
    end if;
    return s * round(to_number(replace(t, ',', '.'), '99999999990D9999', 'NLS_NUMERIC_CHARACTERS=''.,''') * 60);
  exception when others then return null;
  end;

  /* o nome de um código, IGUAL ao da coluna do relatório */
  function nome_dim(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2) return varchar2 is
    r varchar2(4000);
  begin
    if p_dim = 'gest' and p_cod2 is null then return 'Sem gestor'; end if;
    if p_cod is null and p_dim <> 'vin' then return 'Não informado'; end if;
    begin
      r := case p_dim
             when 'emp'  then p_cod || ' - ' || initcap(fnct_nome_empresa(p_cod, 'S'))
             when 'fil'  then p_cod || ' - ' || initcap(fnct_nome_filial(p_emp, p_cod, 'S'))
             when 'cc'   then p_cod || ' - ' || initcap(fnct_nome_ccusto(p_emp, p_cod))
             when 'un'   then p_cod || ' - ' || initcap(fnct_nome_unidade_adm(p_emp, null, p_cod))
             when 'at'   then p_cod || ' - ' || initcap(fnct_nome_atividade(p_cod))
             when 'car'  then p_cod || ' - ' || initcap(fnct_nome_cargo(p_cod))
             when 'sind' then p_cod || ' - ' || initcap(fnct_nome_sindicato(p_emp, p_cod, 'S'))
             when 'gest' then p_cod2 || ' - ' || initcap(fnct_nome_func(p_cod, p_cod2))
             when 'vin'  then initcap(fnct_nome_vinculo(p_cod))
           end;
    exception when others then r := p_cod;
    end;
    return substr(nvl(r, 'Não informado'), 1, 380);
  end;
  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is
    k varchar2(400) := p_dim || '|' || p_emp || '|' || p_cod || '|' || p_cod2;
    t varchar2(400);
    i pls_integer;
  begin
    if cache.exists(k) then return cache(k); end if;
    t := nome_dim(p_dim, p_emp, p_cod, p_cod2);
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
  function poe(s varchar2, p pls_integer, c varchar2) return varchar2 is
  begin
    return substr(s, 1, p - 1) || c || substr(s, p + 1);
  end;
begin
  /* o período: o que o painel mandou, ou o mês corrente */
  l_ini := data_de(apex_application.g_x01);
  l_fim := data_de(apex_application.g_x02);
  if l_ini is null then l_ini := trunc(l_hoje, 'MM'); end if;
  if l_fim is null then l_fim := last_day(l_ini); end if;
  if l_fim < l_ini then l_fim := l_ini; end if;
  if l_fim - l_ini + 1 > MAX_DIAS then l_fim := l_ini + MAX_DIAS - 1; l_cortouD := true; end if;
  l_len := l_fim - l_ini + 1;

  dbms_lob.createtemporary(l_cru, true);
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 2);
  apex_json.write('hoje', to_char(l_hoje, 'dd/mm/yyyy'));
  apex_json.write('painel', :P_PAINEL);
  apex_json.write('ini', to_char(l_ini, 'dd/mm/yyyy'));
  apex_json.write('fim', to_char(l_fim, 'dd/mm/yyyy'));
  apex_json.write('dias', l_len);
  apex_json.write('cortouDias', l_cortouD);

  l_passo := 'consulta';
  l_t1 := dbms_utility.get_time;
  cru('"ev":[');
  for r in (
    with pop as (
      /* A CONSULTA DO RELATÓRIO, só com os códigos. Metade 1: "Colaboradores Diretos" = Sim */
      select distinct
             i.cod_empresa emp, i.matricula mat, i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ,
             i.cargo car, i.num_sind_diss sind, i.vinculo vin, i.situacao sit,
             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor
                    then (select cx.cod_emp_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)
                  when i.matricula <> c.matricula_gestor then c.cod_emp_gestor end gemp,
             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor
                    then (select cx.matricula_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)
                  when i.matricula <> c.matricula_gestor then c.matricula_gestor end gmat
        from informacoes_funcionais i, centro_de_custo c, sub_ccusto sc, pe_escalas_excecoes e
       where i.cod_empresa = c.cod_empresa
         and i.cod_ccusto = c.cod
         and i.cod_empresa = sc.cod_empresa(+)
         and i.cod_sub_ccusto = sc.cod_sub_ccusto(+)
         and c.cod = sc.cod_ccusto(+)
         and i.cod_empresa = e.cod_empresa
         and i.matricula = e.matricula
         and i.marca_ponto = 'S'
         and case when :P_PAINEL = 'PG' and i.matricula = :P_MATRICULA_USER then 1 else 2 end = 2
         and pkg_matricula_listagem.retorna_mostra(p_cod_empresa => :P_EMPRESA_USER, p_matricula => :P_MATRICULA_USER,
                                                   p_usuario => :P_USUARIO, p_logado => i.matricula, p_painel => :P_PAINEL) = 'S'
         and ((sc.mat_gestor = :P_MATRICULA_USER or sc.mat_subs = :P_MATRICULA_USER)
           or (c.matricula_gestor = :P_MATRICULA_USER or c.matricula_suplente = :P_MATRICULA_USER))
         and nvl(l_dir, 'S') = 'S'
         and ((i.situacao < '90' and l_sit = 'A') or (i.situacao >= '90' and l_sit = 'D') or (l_sit = 'T'))
         and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
         and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
         and (f_cc  = 0 or instr(l_cc,  ',' || i.cod_ccusto || ',') > 0)
         and (f_un  = 0 or instr(l_un,  ',' || i.unidade_adm || ',') > 0)
         and (f_at  = 0 or instr(l_at,  ',' || i.cod_atividade || ',') > 0)
         and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
         and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
      union
      /* Metade 2: "Colaboradores Diretos" = Não (todos que o usuário pode ver) */
      select distinct
             i.cod_empresa, i.matricula, i.filial, i.cod_ccusto, i.unidade_adm, i.cod_atividade,
             i.cargo, i.num_sind_diss, i.vinculo, i.situacao,
             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor
                    then (select cx.cod_emp_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)
                  when i.matricula <> c.matricula_gestor then c.cod_emp_gestor end,
             case when i.cod_empresa = c.cod_emp_gestor and i.matricula = c.matricula_gestor
                    then (select cx.matricula_gestor from centro_de_custo cx where cx.cod_empresa = c.cod_empresa and cx.cod = c.cod_ccusto_superior)
                  when i.matricula <> c.matricula_gestor then c.matricula_gestor end
        from informacoes_funcionais i, centro_de_custo c, pe_escalas_excecoes e
       where i.cod_empresa = c.cod_empresa
         and i.cod_ccusto = c.cod
         and case when :P_PAINEL = 'PG' and i.matricula = :P_MATRICULA_USER then 1 else 2 end = 2
         and pkg_matricula_listagem.retorna_mostra(p_cod_empresa => :P_EMPRESA_USER, p_matricula => :P_MATRICULA_USER,
                                                   p_usuario => :P_USUARIO, p_logado => i.matricula, p_painel => :P_PAINEL) = 'S'
         and i.cod_empresa = e.cod_empresa
         and i.matricula = e.matricula
         and i.marca_ponto = 'S'
         and nvl(l_dir, 'N') = 'N'
         and ((i.situacao < '90' and l_sit = 'A') or (i.situacao >= '90' and l_sit = 'D') or (l_sit = 'T'))
         and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
         and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
         and (f_cc  = 0 or instr(l_cc,  ',' || i.cod_ccusto || ',') > 0)
         and (f_un  = 0 or instr(l_un,  ',' || i.unidade_adm || ',') > 0)
         and (f_at  = 0 or instr(l_at,  ',' || i.cod_atividade || ',') > 0)
         and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
         and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
    ),
    prh as (
      /* o período do PONTO de cada empresa, pelo painel (o mesmo do popula_colab da 203): o fechamento */
      select cod_empresa,
             trunc(max(case :P_PAINEL when 'PO' then data_ini_ref_ponto
                                      when 'PG' then nvl(dt_ini_ponto_gestor, data_ini_ref_ponto)
                                      else dt_ini_ponto_colab end)) ini,
             trunc(max(case :P_PAINEL when 'PO' then data_fim_ref_ponto
                                      when 'PG' then nvl(dt_fim_ponto_gestor, data_fim_ref_ponto)
                                      else dt_fim_ponto_colab end)) fim
        from parametros_recursos_humanos
       group by cod_empresa
    ),
    per as (
      select /*+ materialize */ p.*, x.ini, x.fim,
             /* jornada do tipo 2 no fim do período escolhido (a pergunta do quadro "Período" da 203) */
             (select count(*) from pe_jornadas j
               where j.tipo_jornada = 2
                 and j.cod_jornada = nvl(fnct_pe_retorna_jornada(p.emp, p.mat, l_fim, 'S'),
                                         fnct_pe_retorna_jornada(p.emp, p.mat, l_fim, 'N'))) t2
        from pop p, prh x
       where x.cod_empresa(+) = p.emp
    ),
    bat as (
      /* cada batida do período, com a hora do dia em minutos e a ordem entre as que têm horário */
      select x.*,
             row_number() over (partition by x.emp, x.mat, x.dia order by case when x.m is null then 1 else 0 end, x.posicao) rn,
             lag(x.m) over (partition by x.emp, x.mat, x.dia order by case when x.m is null then 1 else 0 end, x.posicao) mant,
             count(x.m) over (partition by x.emp, x.mat, x.dia) nh
        from (select t.cod_empresa emp, t.matricula mat, trunc(nvl(t.vira_dia, t.data_ponto)) dia, t.posicao,
                     t.hora_batida_abono ab, t.cod_justificativa jus,
                     to_number(to_char(nvl(t.hora_batida_abono, t.hora_batida), 'hh24')) * 60 +
                     to_number(to_char(nvl(t.hora_batida_abono, t.hora_batida), 'mi')) m
                from per p, pe_tratamento_batimentos t
               where t.cod_empresa = p.emp
                 and t.matricula = p.mat
                 and nvl(t.vira_dia, t.data_ponto) between l_ini and l_fim) x
    ),
    dias as (
      /* o dia de cada pessoa: quantas batidas, ajustadas, horas trabalhadas, 1ª e última, intervalo */
      select emp, mat, dia,
             count(case when m is not null or jus is not null then 1 end) n,
             count(ab) aj,
             max(nh) nh,
             sum(case when m is not null and mod(rn, 2) = 0 then mod(m - mant + 1440, 1440) end) trab,
             max(case when m is not null and rn = 1 then m end) pri,
             max(case when m is not null and rn = nh then m end) ult,
             max(case when m is not null and rn = 3 then mod(m - mant + 1440, 1440) end) intv
        from bat
       group by emp, mat, dia
    ),
    dd as (
      select d.*,
             lag(d.dia) over (partition by d.emp, d.mat order by d.dia) dia_ant,
             lag(d.pri) over (partition by d.emp, d.mat order by d.dia) pri_ant,
             lag(d.ult) over (partition by d.emp, d.mat order by d.dia) ult_ant,
             lag(d.nh)  over (partition by d.emp, d.mat order by d.dia) nh_ant
        from dias d
    )
    /* P = cada pessoa */
    select 0 ord, 'P' k, to_char(p.emp) emp, to_char(p.mat) mat,
           to_char(p.fil) a1, to_char(p.cc) a2, to_char(p.un) a3, to_char(p.ativ) a4, to_char(p.car) a5,
           to_char(p.sind) a6, to_char(p.vin) a7, to_char(p.sit) a8, to_char(p.gemp) a9, to_char(p.gmat) a10,
           to_char(p.ini, 'yyyymmdd') || '|' || to_char(p.fim, 'yyyymmdd') a11,
           p.t2 n1, cast(null as number) n2, cast(null as number) n3, cast(null as number) n4
      from per p
    union all
    /* M = cada dia: batidas, ajustadas, riscos (1 interjornada + 2 jornada longa + 4 intervalo), trabalhado */
    select 1, 'M', to_char(emp), to_char(mat), to_char(dia, 'yyyymmdd'), null, null, null, null, null, null, null, null, null, null,
           n, aj,
           case when nh >= 2 and nvl(nh_ant, 0) >= 2 and dia_ant = dia - 1
                 and (case when ult_ant < pri_ant then pri - ult_ant else 1440 - ult_ant + pri end) between 0 and 659
                then 1 else 0 end
         + case when nh >= 2 and mod(nh, 2) = 0 and trab > 600 then 2 else 0 end
         + case when nh >= 2 and mod(nh, 2) = 0 and trab > 360 and (nh = 2 or intv < 60) then 4 else 0 end,
           case when nh >= 2 and mod(nh, 2) = 0 then trab else 0 end
      from dd
    union all
    /* E = eventos da apuração, banco de horas (crédito / débito), por mês */
    select 2, 'E', to_char(a.cod_empresa), to_char(a.matricula),
           b.tipo, 'B|' || a.cod_evento, a.cod_evento || ' - ' || b.descricao, to_char(a.data, 'yyyymm'), null, null, null, null, null, null, null,
           sum(case when regexp_like(a.qtd_horas, '^-?[0-9]+:[0-9]{1,2}$')
                    then to_number(substr(a.qtd_horas, 1, instr(a.qtd_horas, ':') - 1)) * 60 + to_number(substr(a.qtd_horas, instr(a.qtd_horas, ':') + 1))
                    else 0 end), null, null, null
      from per p, pe_resultado_apuracao a, pe_eventos_banco b
     where a.cod_empresa = p.emp
       and a.matricula = p.mat
       and a.tipo_evento = 'BANCO'
       and a.id_apuracao != 9020
       and nvl(a.plantao, 'N') = 'N'
       and a.data between l_ini and l_fim
       and (p.t2 = 0 or a.id_apuracao > 9000)
       and a.cod_empresa = b.cod_empresa
       and a.cod_evento = b.cod_evento_banco
     group by a.cod_empresa, a.matricula, b.tipo, a.cod_evento, b.descricao, to_char(a.data, 'yyyymm')
    union all
    /* E = eventos da apuração que vão para a folha, por mês */
    select 2, 'E', to_char(a.cod_empresa), to_char(a.matricula),
           'H', 'P|' || a.cod_evento, a.cod_evento || ' - ' || f.descricao, to_char(a.data, 'yyyymm'), null, null, null, null, null, null, null,
           sum(case when regexp_like(a.qtd_horas, '^-?[0-9]+:[0-9]{1,2}$')
                    then to_number(substr(a.qtd_horas, 1, instr(a.qtd_horas, ':') - 1)) * 60 + to_number(substr(a.qtd_horas, instr(a.qtd_horas, ':') + 1))
                    else 0 end), null, null, null
      from per p, pe_resultado_apuracao a, pe_eventos_folha f
     where a.cod_empresa = p.emp
       and a.matricula = p.mat
       and a.tipo_evento = 'PONTO'
       and a.id_apuracao != 9020
       and nvl(a.plantao, 'N') = 'N'
       and a.data between l_ini and l_fim
       and (p.t2 = 0 or a.id_apuracao > 9000)
       and a.cod_empresa = f.cod_empresa
       and a.cod_evento = f.cod_evento_folha
     group by a.cod_empresa, a.matricula, a.cod_evento, f.descricao, to_char(a.data, 'yyyymm')
    union all
    /* R = pedidos de ajuste de marcação, por situação */
    select 3, 'R', to_char(r.cod_empresa), to_char(r.matricula), '0', to_char(r.cod_sit_req), null, null, null, null, null, null, null, null, null,
           count(distinct r.cod_req), max(l_hoje - trunc(r.dt_req)), null, null
      from per p, pe_req_tratamento_batimentos r
     where r.cod_empresa = p.emp
       and r.matricula = p.mat
       and r.data_ponto between l_ini and l_fim
     group by r.cod_empresa, r.matricula, r.cod_sit_req
    union all
    /* R = pedidos de apuração, por situação */
    select 3, 'R', to_char(r.cod_empresa), to_char(r.matricula), '1', to_char(r.cod_sit_req), null, null, null, null, null, null, null, null, null,
           count(distinct r.cod_req), max(l_hoje - trunc(c.dt_solicitacao)), null, null
      from per p, pe_req_apuracao r, consulta_requisicoes c
     where r.cod_empresa = p.emp
       and r.matricula = p.mat
       and r.data_ponto between l_ini and l_fim
       and upper(c.tipo_req) = 'REQ_APURA'
       and c.cod_empresa = r.cod_empresa
       and c.solicitacao = r.cod_req
     group by r.cod_empresa, r.matricula, r.cod_sit_req
    union all
    /* R = pedidos de hora extra, por situação */
    select 3, 'R', to_char(r.cod_empresa), to_char(r.matricula), '2', to_char(r.cod_sit_req), null, null, null, null, null, null, null, null, null,
           count(distinct r.cod_req), max(l_hoje - trunc(c.dt_solicitacao)), null, null
      from per p, pe_req_hora_extra r, consulta_requisicoes c
     where r.cod_empresa = p.emp
       and r.matricula = p.mat
       and r.data_ponto between l_ini and l_fim
       and upper(c.tipo_req) = 'REQ_HE'
       and c.cod_empresa = r.cod_empresa
       and c.solicitacao = r.cod_req
     group by r.cod_empresa, r.matricula, r.cod_sit_req
     order by 1
  ) loop
    if r.k = 'P' then
      l_total := l_total + 1;
      if l_npes >= MAX_PES then
        l_cortou := true;
      elsif not pes.exists(r.emp || '|' || r.mat) then
        l_pi := l_npes;
        l_npes := l_npes + 1;
        pes(r.emp || '|' || r.mat) := l_pi;
        pes_k(l_pi) := r.emp || '|' || r.mat;
        if r.a11 <> '|' and not pers.exists(r.a11) then
          pers(r.a11) := l_nper;
          pers_t(l_nper) := '["' || to_char(to_date(substr(r.a11, 1, 8), 'yyyymmdd'), 'dd/mm/yyyy') || '","' ||
                            to_char(to_date(substr(r.a11, 10, 8), 'yyyymmdd'), 'dd/mm/yyyy') || '"]';
          l_nper := l_nper + 1;
        end if;
        dm(l_pi) := rpad('0', l_len, '0');
        da(l_pi) := rpad('0', l_len, '0');
        df(l_pi) := rpad('0', l_len, '0');
        tr(l_pi) := 0;
        pv(l_pi) := -1;
        l_url := apex_page.get_url(p_page => 203, p_clear_cache => 'RP,203', p_items => 'P203_EMP,P203_MAT',
                                   p_values => r.emp || ',' || r.mat);
        if l_u0 is null and instr(l_url, 'P203_EMP,P203_MAT:') > 0 then
          l_u0 := substr(l_url, 1, instr(l_url, 'P203_EMP,P203_MAT:') + length('P203_EMP,P203_MAT:') - 1);
        end if;
        if l_u0 is not null and substr(l_url, 1, length(l_u0)) = l_u0 then l_url := substr(l_url, length(l_u0) + 1);
        else l_url := '!' || l_url; end if;
        lin(l_pi) := '[' || ix('emp', r.emp, r.emp) || ',' || ix('fil', r.emp, r.a1) || ',' || ix('cc', r.emp, r.a2) || ',' ||
                     ix('un', r.emp, r.a3) || ',' || ix('at', r.emp, r.a4) || ',' || ix('car', r.emp, r.a5) || ',' ||
                     ix('sind', r.emp, r.a6) || ',' || ix('gest', r.a9, r.a9, r.a10) || ',' || ix('vin', r.emp, r.a7) || ',' ||
                     case when r.a11 <> '|' then to_char(pers(r.a11)) else '-1' end || ',' ||
                     case when r.a8 = '01' then '1' else '0' end || ',' || js(l_url) || ']';
        begin
          nom(l_pi) := r.mat || ' - ' || initcap(fnct_nome_func(r.emp, r.mat));
        exception when others then nom(l_pi) := r.mat;
        end;
      end if;
    elsif pes.exists(r.emp || '|' || r.mat) then
      l_pi := pes(r.emp || '|' || r.mat);
      if r.k = 'M' then
        l_off := to_date(r.a1, 'yyyymmdd') - l_ini + 1;
        if l_off between 1 and l_len then
          dm(l_pi) := poe(dm(l_pi), l_off, to_char(least(9, nvl(r.n1, 0))));
          da(l_pi) := poe(da(l_pi), l_off, to_char(least(9, nvl(r.n2, 0))));
          df(l_pi) := poe(df(l_pi), l_off, to_char(least(7, nvl(r.n3, 0))));
          tr(l_pi) := tr(l_pi) + nvl(r.n4, 0);
        end if;
      elsif r.k = 'E' then
        if nvl(r.n1, 0) <> 0 then
          if not evn.exists(r.a2) then
            evn(r.a2) := l_nev;
            evs_t(l_nev) := substr(r.a3, 1, 300);
            evs_k(l_nev) := nvl(r.a1, 'H');
            l_nev := l_nev + 1;
          end if;
          if not mes.exists(r.a4) then mes(r.a4) := l_nmes; l_nmes := l_nmes + 1; end if;
          cru(case when l_ne > 0 then ',' end || '[' || l_pi || ',' || evn(r.a2) || ',' || to_char(mes(r.a4)) || ',' || n(r.n1) || ']');
          l_ne := l_ne + 1;
        end if;
      elsif r.k = 'R' then
        rq(l_pi) := case when rq.exists(l_pi) then rq(l_pi) || ',' end ||
                    '[' || l_pi || ',' || r.a1 || ',' || nvl(r.a2, '0') || ',' || n(r.n1) || ',' || n(r.n2) || ']';
      end if;
    end if;
  end loop;
  l_t2 := dbms_utility.get_time;

  /* as HORAS PREVISTAS de cada pessoa (base do absenteísmo): a função do espelho de ponto, por SQL
     dinâmico (se ela não existir nesta base, a página continua). Para em PREV_SEG segundos e também
     se as 3 primeiras chamadas falharem. */
  l_passo := 'previstas';
  for i in 0 .. l_npes - 1 loop
    if l_tp > PREV_SEG * 100 then l_pcorte := true; exit; end if;
    if l_pok = 0 and l_pfal >= 3 then exit; end if;
    l_tq := dbms_utility.get_time;
    begin
      execute immediate 'begin :r := pkg_espelho_ponto.cf_total_horas_previstas(:e, :m, :i, :f); end;'
        using out l_r, in substr(pes_k(i), 1, instr(pes_k(i), '|') - 1), in substr(pes_k(i), instr(pes_k(i), '|') + 1), in l_ini, in l_fim;
      pv(i) := nvl(minutos(l_r), -1);
      if pv(i) >= 0 then l_pok := l_pok + 1; else l_pfal := l_pfal + 1; end if;
    exception when others then
      l_pfal := l_pfal + 1;
    end;
    l_tp := l_tp + (dbms_utility.get_time - l_tq);
  end loop;

  /* "ev" foi aberto antes do laço; fecha. Depois: pes, dm, da, df, tr, pv, req, per, evs, meses */
  l_passo := 'montar';
  cru('],"pes":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || lin(i)); end loop;
  cru('],"dm":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || '"' || dm(i) || '"'); end loop;
  cru('],"da":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || '"' || da(i) || '"'); end loop;
  cru('],"df":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || '"' || df(i) || '"'); end loop;
  cru('],"tr":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || n(tr(i))); end loop;
  cru('],"pv":[');
  for i in 0 .. l_npes - 1 loop cru(case when i > 0 then ',' end || case when pv(i) < 0 then '-1' else n(pv(i)) end); end loop;
  cru('],"req":[');
  l_n := 0;
  for i in 0 .. l_npes - 1 loop
    if rq.exists(i) then cru(case when l_n > 0 then ',' end || rq(i)); l_n := l_n + 1; end if;
  end loop;
  cru('],"per":[');
  for i in 0 .. l_nper - 1 loop cru(case when i > 0 then ',' end || pers_t(i)); end loop;
  cru('],"evs":[');
  for i in 0 .. l_nev - 1 loop cru(case when i > 0 then ',' end || '[' || js(evs_t(i)) || ',"' || evs_k(i) || '"]'); end loop;
  cru('],"meses":[');
  declare k varchar2(400) := mes.first; t t_lin; begin
    while k is not null loop t(mes(k)) := k; k := mes.next(k); end loop;
    for i in 0 .. l_nmes - 1 loop cru(case when i > 0 then ',' end || '"' || t(i) || '"'); end loop;
  end;
  cru(']');
  descarrega;

  apex_json.write('total', l_total);
  apex_json.write('cortou', l_cortou);
  apex_json.write('u0', l_u0);
  apex_json.open_object('prev');
  apex_json.write('ok', l_pok);
  apex_json.write('falhas', l_pfal);
  apex_json.write('parcial', l_pcorte);
  apex_json.close_object;
  apex_json.open_object('dims');
  for j in 1 .. l_dims.count loop
    apex_json.open_array(l_dims(j));
    if qtd.exists(l_dims(j)) then
      for k in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || '#' || k)); end loop;
    end if;
    apex_json.close_array;
  end loop;
  apex_json.close_object;
  apex_json.open_array('nomes');
  for i in 0 .. l_npes - 1 loop apex_json.write(nom(i)); end loop;
  apex_json.close_array;
  apex_json.open_object('tempos');
  apex_json.write('consulta', l_t2 - l_t1);
  apex_json.write('previstas', l_tp);
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
