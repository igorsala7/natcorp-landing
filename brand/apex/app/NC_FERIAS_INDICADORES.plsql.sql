/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · FÉRIAS — os números do painel (Ajax Callback)                                  ║
   ║  App 200 · Página 26 (Férias)                                                             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 26 › Processing › Ajax Callback › NC_FERIAS_INDICADORES (entra pelo
               aplicar-feriaspainel-pagina26.py). Quem chama é o Natcorp_FeriasPainel.js.
   Guia: FERIASPAINEL-MANUTENCAO.md.

   O QUE DEVOLVE (JSON)
     hoje, cal_ini, cal_fim                 a data e a janela do calendário de saídas
     pessoas                                quantas pessoas o filtro tem
     agora{ ferias, saem30, vencido, vence60, acumulado }   pessoas em cada situação de HOJE
     ferias[] saem30[] vencido[] vence60[] acumulado[]      quem são (até 300 em cada)
     saldo{ dias, vencidos, periodos, em_dia }              dias a tirar; % de pessoas sem prazo vencido
     meses[]                                saídas de férias por mês (pessoas)
     setores[]                              centros de custo com mais períodos vencidos
     maissaldo[]                            pessoas com mais dias vencidos a tirar
     como{ periodos, p1, p2, p3, abono, dec }  como as férias programadas são tiradas
     tempos{}                               centésimos de segundo (para achar peso)

   AS REGRAS (CLT)
     • Período aquisitivo completo (fim < hoje) com SALDO > 0 = férias a tirar.
     • PRAZO VENCIDO: saldo > 0 e a data limite para COMEÇAR (dt_lim_inic_ferias) já passou —
       a empresa paga em dobro (art. 137).
     • VENCEM EM ATÉ 60 DIAS: saldo > 0, data limite entre hoje e hoje + 60, e nenhuma saída marcada
       de hoje em diante.
     • ACUMULADO: 2 ou mais períodos completos com saldo.
     • DE FÉRIAS HOJE: alguma parcela com saída ≤ hoje < retorno (sem retorno: saída + dias).

   OS FILTROS são os MESMOS do relatório (P26_*), na sessão. Lições da página 25 (08/10):
     • filtro de lista múltipla = instr(',lista,', ',cod,') — nada de TABLE() no PL/SQL (ORA-22905);
     • uma passada só, somas em memória (nada de GROUPING SETS: ORA-00904 SYS_TBL);
     • nome (fnct_nome_func) só de quem vai para as listas, nunca por linha;
     • no declare, variáveis e tipos ANTES das funções.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje    date := trunc(sysdate);
  l_dini    date;                     /* filtro de datas da página (parcelas nesse intervalo) */
  l_dfim    date;
  l_cal_ini date;                     /* janela do calendário de saídas */
  l_cal_fim date;
  l_emp varchar2(32767) := ',' || :P26_EMPRESA || ',';     f_emp number := case when :P26_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P26_FILIAL || ',';      f_fil number := case when :P26_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P26_CCUSTO || ',';      f_cc  number := case when :P26_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P26_UNIDADE_ADM || ','; f_un  number := case when :P26_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P26_ATIVIDADE || ',';   f_at  number := case when :P26_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P26_CARGO || ',';       f_car number := case when :P26_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P26_MATRICULA_1 || ','; f_mat number := case when :P26_MATRICULA_1 is null then 0 else 1 end;
  l_passo varchar2(30) := 'inicio';
  l_t0    number := dbms_utility.get_time;
  l_t1    number;
  l_saida clob;
  l_pos   pls_integer := 1;

  type t_num is table of number index by varchar2(400);
  type t_dat is table of date index by varchar2(400);
  type t_txt is table of varchar2(400) index by varchar2(400);
  visto   t_num;                      /* chaves já contadas */
  cc_de   t_txt;                      /* centro de custo de cada pessoa ("emp|mat") */
  fe_sai  t_dat; fe_ret t_dat;        /* de férias hoje: saída e retorno */
  s30_sai t_dat;                      /* sai nos próximos 30 dias: a 1ª saída */
  ve_lim  t_dat; ve_dias t_num; ve_n t_num;   /* prazo vencido: o limite mais antigo, saldo, períodos */
  v60_lim t_dat; v60_dias t_num;      /* vence em até 60 dias */
  ac_n    t_num; ac_dias t_num;       /* períodos completos com saldo (acumulado e "mais dias") */
  futura  t_num;                      /* período ("emp|mat|aq_ini") com saída de hoje em diante */
  q_mes   t_num;                      /* saídas por mês (pessoas) */
  q_set   t_num; d_set t_num;         /* períodos vencidos e dias por centro de custo */
  l_pessoas number := 0; l_dias number := 0; l_venc number := 0; l_periodos number := 0;
  l_cp number := 0; l_p1 number := 0; l_p2 number := 0; l_p3 number := 0; l_abono number := 0; l_dec number := 0;

  function data_de(p varchar2) return date is
  begin
    if p is null then return null; end if;
    begin return to_date(p, 'DD/MM/YYYY'); exception when others then return to_date(p); end;
  end;
  function d(p date) return varchar2 is begin return to_char(p, 'DD/MM/YYYY'); end;
  function primeira(k varchar2) return boolean is
  begin
    if visto.exists(k) then return false; end if;
    visto(k) := 1; return true;
  end;
  procedure soma(a in out nocopy t_num, k varchar2, v number) is
  begin
    if a.exists(k) then a(k) := a(k) + v; else a(k) := v; end if;
  end;
  procedure menor(a in out nocopy t_dat, k varchar2, v date) is
  begin
    if v is null then return; end if;
    if not a.exists(k) or v < a(k) then a(k) := v; end if;
  end;
  function nome(k varchar2) return varchar2 is
    l_e varchar2(200) := substr(k, 1, instr(k, '|') - 1);
    l_m varchar2(200) := substr(k, instr(k, '|') + 1);
  begin
    return l_m || ' - ' || initcap(fnct_nome_func(l_e, l_m));
  end;
  /* uma pessoa na lista: nome, centro de custo e as datas daquela situação */
  procedure pessoa(k varchar2, p_a date, p_b date, p_n number) is
  begin
    apex_json.open_object;
    apex_json.write('n', nome(k));
    apex_json.write('s', case when cc_de.exists(k) then cc_de(k) end);
    if p_a is not null then apex_json.write('a', d(p_a)); end if;
    if p_b is not null then apex_json.write('b', d(p_b)); end if;
    if p_n is not null then apex_json.write('x', p_n); end if;
    apex_json.close_object;
  end;
  /* os N maiores de um grupo (q; empate: d) — t = o próprio texto da chave ou o nome da pessoa */
  procedure maiores(p_lista varchar2, q t_num, dd t_num, p_n pls_integer, p_pessoa boolean, p_min number) is
    usado t_num; k varchar2(400); melhor varchar2(400);
  begin
    apex_json.open_array(p_lista);
    for x in 1 .. p_n loop
      melhor := null; k := q.first;
      while k is not null loop
        if not usado.exists(k) and q(k) >= p_min
           and (melhor is null or q(k) > q(melhor) or (q(k) = q(melhor) and dd(k) > dd(melhor))) then
          melhor := k;
        end if;
        k := q.next(k);
      end loop;
      exit when melhor is null;
      usado(melhor) := 1;
      apex_json.open_object;
      apex_json.write('t', case when p_pessoa then nome(melhor) else melhor end);
      apex_json.write('q', q(melhor)); apex_json.write('d', dd(melhor));
      if p_pessoa and cc_de.exists(melhor) then apex_json.write('s', cc_de(melhor)); end if;
      apex_json.close_object;
    end loop;
    apex_json.close_array;
  end;
  /* uma parcela de um período: hoje / próximos 30 dias / calendário / futura */
  procedure parcela(k varchar2, kp varchar2, p_sai date, p_ret date, p_dias number) is
    l_ret date;
  begin
    if p_sai is null then return; end if;
    l_ret := nvl(p_ret, p_sai + nvl(p_dias, 0));
    if p_sai <= l_hoje and l_hoje < l_ret then fe_sai(k) := p_sai; fe_ret(k) := l_ret; end if;
    if p_sai > l_hoje and p_sai <= l_hoje + 30 then menor(s30_sai, k, p_sai); end if;
    if p_sai >= l_hoje then futura(kp) := 1; end if;
    if p_sai between l_cal_ini and l_cal_fim and primeira('M|' || to_char(p_sai, 'YYYY-MM') || '|' || k) then
      soma(q_mes, to_char(p_sai, 'YYYY-MM'), 1);
    end if;
  end;
begin
  l_dini := data_de(:P26_DATA_INI);
  l_dfim := nvl(data_de(:P26_DATA_FIM), l_hoje);
  if l_dini is not null then
    l_cal_ini := trunc(l_dini, 'MM'); l_cal_fim := l_dfim;
  else                                  /* sem filtro: 2 meses para trás e 9 para a frente */
    l_cal_ini := add_months(trunc(l_hoje, 'MM'), -2); l_cal_fim := last_day(add_months(l_hoje, 9));
  end if;

  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('hoje', d(l_hoje));
  apex_json.write('cal_ini', d(l_cal_ini));
  apex_json.write('cal_fim', d(l_cal_fim));

  l_passo := 'periodos';
  for r in (
    select f.cod_empresa emp, f.matricula mat, f.scr_ccusto cc,
           f.dt_inic_per_ferias aq_ini, f.dt_fim_per_ferias aq_fim, f.dt_lim_inic_ferias lim_ini, nvl(f.saldo, 0) saldo,
           f.dt_saida_parc1 s1, f.dt_retorno_parc1 r1, f.num_dias_parc1 d1, f.dias_abono_pec1 a1, f.opcao_13sal1 o1,
           f.dt_saida_parc2 s2, f.dt_retorno_parc2 r2, f.num_dias_parc2 d2, f.dias_abono_pec2 a2, f.opcao_13sal2 o2,
           f.dt_saida_parc4 s3, f.dt_retorno_parc4 r3, f.num_dias_parc4 d3, f.dias_abono_pec4 a3, f.opcao_13sal4 o3
      from VW_CONSULTA_FERIAS F, INFORMACOES_FUNCIONAIS I, SINDICATOS S, vinculo_empreg v
     where f.cod_empresa = i.cod_empresa
       and f.matricula = i.matricula
       and i.num_sind_diss = s.cod
       and i.cod_empresa = s.cod_empresa
       and i.vinculo (+) = v.cod
       and ((f.cod_empresa = :P26_EMP and f.matricula = :P26_MAT) or :P26_MAT is null)
       and ((f.ind_situacao_periodo <> 'G' and nvl(:P26_CHK_PENDENTES, 'N') = 'S') or
            (f.ind_situacao_periodo is not null and nvl(:P26_CHK_PENDENTES, 'N') = 'N'))
       and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
       and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
       and (f_cc  = 0 or instr(l_cc,  ',' || i.cod_ccusto || ',') > 0)
       and (f_un  = 0 or instr(l_un,  ',' || i.unidade_adm || ',') > 0)
       and (f_at  = 0 or instr(l_at,  ',' || i.cod_atividade || ',') > 0)
       and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
       and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
       and ((i.situacao = '01' and :P26_SITUACAO = 'S') or
            (i.situacao = '14' and :P26_SITUACAO = 'F') or
            ((i.situacao between '02' and '89') and :P26_SITUACAO = 'F') or
            (i.situacao >= '90' and :P26_SITUACAO = 'D') or
            (i.situacao is not null and :P26_SITUACAO = 'N'))
       and (l_dini is null or (f.dt_saida_parc1 between l_dini and l_dfim or f.dt_saida_parc2 between l_dini and l_dfim
                            or f.dt_saida_parc4 between l_dini and l_dfim or f.dt_retorno_parc1 between l_dini and l_dfim
                            or f.dt_retorno_parc2 between l_dini and l_dfim or f.dt_retorno_parc4 between l_dini and l_dfim))
  ) loop
    declare
      k  varchar2(400) := r.emp || '|' || r.mat;
      kp varchar2(400) := k || '|' || to_char(r.aq_ini, 'YYYYMMDD');
      np pls_integer := 0;
    begin
      if primeira('P|' || k) then l_pessoas := l_pessoas + 1; cc_de(k) := r.cc; end if;
      parcela(k, kp, r.s1, r.r1, r.d1);
      parcela(k, kp, r.s2, r.r2, r.d2);
      parcela(k, kp, r.s3, r.r3, r.d3);
      /* como tiram (períodos com alguma parcela marcada) */
      if r.s1 is not null then np := np + 1; end if;
      if r.s2 is not null then np := np + 1; end if;
      if r.s3 is not null then np := np + 1; end if;
      if np > 0 then
        l_cp := l_cp + 1;
        if np = 1 then l_p1 := l_p1 + 1; elsif np = 2 then l_p2 := l_p2 + 1; else l_p3 := l_p3 + 1; end if;
        if nvl(r.a1, 0) + nvl(r.a2, 0) + nvl(r.a3, 0) > 0 then l_abono := l_abono + 1; end if;
        if upper(substr(r.o1, 1, 1)) = 'S' or upper(substr(r.o2, 1, 1)) = 'S' or upper(substr(r.o3, 1, 1)) = 'S' then l_dec := l_dec + 1; end if;
      end if;
      /* saldo e prazos */
      if r.saldo > 0 then
        l_periodos := l_periodos + 1;
        l_dias := l_dias + r.saldo;
        if r.aq_fim < l_hoje then
          l_venc := l_venc + r.saldo;
          soma(ac_n, k, 1); soma(ac_dias, k, r.saldo);
        end if;
        if r.lim_ini < l_hoje then
          menor(ve_lim, k, r.lim_ini); soma(ve_dias, k, r.saldo); soma(ve_n, k, 1);
          /* chave de array nunca nula (ORA-06502): período sem centro de custo vai para um grupo próprio */
          soma(q_set, nvl(r.cc, '(sem centro de custo)'), 1); soma(d_set, nvl(r.cc, '(sem centro de custo)'), r.saldo);
        elsif r.lim_ini <= l_hoje + 60 and not futura.exists(kp) then
          menor(v60_lim, k, r.lim_ini); soma(v60_dias, k, r.saldo);
        end if;
      end if;
    end;
  end loop;
  l_t1 := dbms_utility.get_time;

  l_passo := 'listas';
  apex_json.write('pessoas', l_pessoas);
  apex_json.open_object('agora');
  apex_json.write('ferias', fe_sai.count);
  apex_json.write('saem30', s30_sai.count);
  apex_json.write('vencido', ve_lim.count);
  apex_json.write('vence60', v60_lim.count);
  declare k varchar2(400) := ac_n.first; n number := 0; begin
    while k is not null loop if ac_n(k) >= 2 then n := n + 1; end if; k := ac_n.next(k); end loop;
    apex_json.write('acumulado', n);
  end;
  apex_json.close_object;

  /* quem são (até 300 em cada lista) */
  declare
    k varchar2(400); n pls_integer;
  begin
    apex_json.open_array('ferias'); k := fe_sai.first; n := 0;
    while k is not null and n < 300 loop pessoa(k, fe_sai(k), fe_ret(k), null); n := n + 1; k := fe_sai.next(k); end loop;
    apex_json.close_array;
    apex_json.open_array('saem30'); k := s30_sai.first; n := 0;
    while k is not null and n < 300 loop pessoa(k, s30_sai(k), null, null); n := n + 1; k := s30_sai.next(k); end loop;
    apex_json.close_array;
    apex_json.open_array('vencido'); k := ve_lim.first; n := 0;
    while k is not null and n < 300 loop pessoa(k, ve_lim(k), null, ve_dias(k)); n := n + 1; k := ve_lim.next(k); end loop;
    apex_json.close_array;
    apex_json.open_array('vence60'); k := v60_lim.first; n := 0;
    while k is not null and n < 300 loop pessoa(k, v60_lim(k), null, v60_dias(k)); n := n + 1; k := v60_lim.next(k); end loop;
    apex_json.close_array;
    apex_json.open_array('acumulado'); k := ac_n.first; n := 0;
    while k is not null and n < 300 loop
      if ac_n(k) >= 2 then pessoa(k, null, null, ac_dias(k)); n := n + 1; end if;
      k := ac_n.next(k);
    end loop;
    apex_json.close_array;
  end;

  apex_json.open_object('saldo');
  apex_json.write('dias', l_dias);
  apex_json.write('vencidos', l_venc);
  apex_json.write('periodos', l_periodos);
  apex_json.write('em_dia', l_pessoas - ve_lim.count);
  apex_json.close_object;

  apex_json.open_array('meses');
  declare m varchar2(400) := q_mes.first; begin
    while m is not null loop
      apex_json.open_object; apex_json.write('m', m); apex_json.write('q', q_mes(m)); apex_json.close_object;
      m := q_mes.next(m);
    end loop;
  end;
  apex_json.close_array;

  maiores('setores', q_set, d_set, 30, false, 1);
  maiores('maissaldo', ac_dias, ac_n, 30, true, 1);

  apex_json.open_object('como');
  apex_json.write('periodos', l_cp);
  apex_json.write('p1', l_p1); apex_json.write('p2', l_p2); apex_json.write('p3', l_p3);
  apex_json.write('abono', l_abono); apex_json.write('dec', l_dec);
  apex_json.close_object;

  apex_json.open_object('tempos');
  apex_json.write('periodos', l_t1 - l_t0);
  apex_json.write('listas', dbms_utility.get_time - l_t1);
  apex_json.close_object;
  apex_json.close_object;

  l_saida := apex_json.get_clob_output;
  apex_json.free_output;
  while l_pos <= dbms_lob.getlength(l_saida) loop
    htp.prn(dbms_lob.substr(l_saida, 8000, l_pos));
    l_pos := l_pos + 8000;
  end loop;
exception
  when others then
    apex_json.free_output;
    htp.prn('{"erro":"' || apex_escape.json(sqlerrm || ' [passo: ' || l_passo || ']') || '"}');
end;
