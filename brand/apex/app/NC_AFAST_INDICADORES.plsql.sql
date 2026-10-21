/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · AFASTAMENTOS — os números do painel (Ajax Callback)                            ║
   ║  App 200 · Página 25 (Controle de Funcionários Afastados)                                 ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 25 › Processing › Ajax Callback › nome EXATO:  NC_AFAST_INDICADORES
               (tipo PL/SQL Code, cole este bloco inteiro). Quem chama é o Natcorp_Afastamentos.js.
   Guia: AFASTAMENTOS-MANUTENCAO.md.

   O QUE DEVOLVE (JSON, "v": 2 — 12/10: o painel filtra e cruza NA TELA, sem voltar ao servidor)
     hoje, ini, fim, padrao     o período dos números ("padrao" = sem data no filtro → 12 meses)
     quadro                     colaboradores do filtro que não estão desligados (situação < 90)
     agora{…} + pessoas[…]      quem está afastado HOJE (situação atual ≠ 01 e < 90): total, voltam
                                em 7 dias, volta atrasada, sem data de volta, há mais de 15 dias.
                                Cada pessoa leva "k" = "motivo,empresa,filial,ccusto,unidade,atividade,cargo,vínculo"
                                (números = a posição do nome em "dims").
     dims{tipo,emp,fil,cc,un,at,car,vin}   os NOMES, como as colunas do relatório mostram
                                ("700 - Natcorp…", "10560103 - Linha De Frente"); cada lista uma vez só.
     quadroG[[emp,fil,cc,un,at,car,vin,n]]  o quadro dividido pelas mesmas colunas (o índice "de cada
                                100 dias" continua certo com um filtro do painel)
     ev[[tipo,emp,fil,cc,un,at,car,vin,pessoa,AAAAMM,dias]]  CADA afastamento que toca o período
     nomes{pessoa: "mat - Nome"}  só de quem se afastou 2 vezes ou mais (o quadro "Mais de uma vez")
     periodo{…}                 vezes, pessoas, dias fora (sem filtro do painel)

   OS FILTROS são os MESMOS do relatório (P25_EMPRESA … P25_MATRICULA, P25_SITUACAO, as datas),
   lidos da sessão — o "Pesquisar" da página grava antes. Os filtros feitos DENTRO do relatório
   (menu Ações) não entram: eles não chegam ao servidor.

   CUIDADO  • O FIM de cada afastamento é o da coluna "Data Final" do relatório (fim do histórico,
              senão o do atestado); sem nenhum dos dois, se é a situação atual da pessoa conta até hoje,
              senão conta só o dia de início. NÃO usar LEAD nem subconsulta no histórico por linha: com o
              histórico inteiro passou de 80 s (08/10). A consulta do período é a junção do relatório.
            • Os nomes (fnct_nome_*) saem UMA vez por código (guardados em "cache"), nunca por linha.
            • "ev" e "quadroG" são escritos à mão (só números) num CLOB à parte e emendados no fim do
              JSON: com apex_json, 11 chamadas por afastamento pesariam. Número com vírgula quebraria o
              JSON: dias vão arredondados (to_char sem casas).
            • Códigos de situação: '01' = normal (trabalhando); '90' para cima = desligado. É a
              mesma regra do relatório.
            • As datas do filtro chegam como texto DD/MM/AAAA (com reserva para o formato da sessão).
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje   date := trunc(sysdate);
  l_ini    date;
  l_fim    date;
  l_padrao boolean := :P25_DATA_INI is null;
  l_quadro number := 0;
  l_tot    number := 0; l_v7 number := 0; l_sem number := 0; l_atr number := 0; l_m15 number := 0;
  l_saida  clob;
  l_cru    clob;                                             /* "quadroG" e "ev", escritos à mão */
  l_buf    varchar2(32767);
  /* os filtros de escolha múltipla chegam como "700,91". Viram ",700,91," e a linha entra quando
     ",<código>," está dentro (instr) — o mesmo jeito das listas de valores desta página.
     NÃO filtrar com TABLE() de apex_string.split nem de uma coleção aqui: nesta base, dentro do
     PL/SQL, os dois dão ORA-22905 (08/10). f_x = 1 quando o filtro foi preenchido. */
  l_emp varchar2(32767) := ',' || :P25_EMPRESA || ',';     f_emp number := case when :P25_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P25_FILIAL || ',';      f_fil number := case when :P25_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P25_CCUSTO || ',';      f_cc  number := case when :P25_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P25_UNIDADE_ADM || ','; f_un  number := case when :P25_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P25_ATIVIDADE || ',';   f_at  number := case when :P25_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P25_CARGO || ',';       f_car number := case when :P25_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P25_MATRICULA || ',';   f_mat number := case when :P25_MATRICULA is null then 0 else 1 end;
  l_sit varchar2(32767) := ',' || :P25_SITUACAO || ',';    f_sit number := case when :P25_SITUACAO is null then 0 else 1 end;
  l_passo  varchar2(30) := 'inicio';                         /* onde estava, se der erro */
  l_t0     number := dbms_utility.get_time;                  /* tempos de cada parte, em centésimos */
  l_t1     number; l_t2 number;
  l_dims   sys.odcivarchar2list := sys.odcivarchar2list('tipo', 'emp', 'fil', 'cc', 'un', 'at', 'car', 'vin');
  l_corte  pls_integer;
  l_n      pls_integer := 0;
  l_pi     pls_integer;

  /* os nomes de cada coluna: cada nome ganha um número (a posição dele em "dims") */
  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(400) index by varchar2(400);
  cache   t_num;      /* "dim|empresa|código" → número (o fnct_nome_* roda uma vez por código) */
  por_rot t_num;      /* "dim|nome" → número (dois códigos com o MESMO nome viram um só, como na tabela) */
  qtd     t_num;      /* dim → quantos nomes */
  rot     t_txt;      /* "dim#número" → nome */
  pes     t_num;      /* "empresa|matrícula" → número da pessoa */
  pes_ch  t_txt;      /* número da pessoa → "empresa|matrícula" */
  pes_q   t_num;      /* número da pessoa → vezes no período */
  l_npes  pls_integer := 0;
  l_vezes number := 0; l_dias number := 0;

  /* (no PL/SQL as variáveis e os tipos vêm ANTES das funções: daqui para baixo só funções) */
  function data_de(p varchar2) return date is
  begin
    if p is null then return null; end if;
    begin return to_date(p, 'DD/MM/YYYY'); exception when others then return to_date(p); end;
  end;

  /* escreve no CLOB à parte, de 32 mil em 32 mil caracteres */
  procedure descarrega is
  begin
    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;
  end;
  procedure cru(p varchar2) is
  begin
    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;
    l_buf := l_buf || p;
  end;

  /* o nome de um código, IGUAL ao da coluna do relatório */
  function nome_dim(p_dim varchar2, p_emp varchar2, p_cod varchar2) return varchar2 is
    r varchar2(4000);
  begin
    if p_cod is null then return 'Não informado'; end if;
    begin
      r := case p_dim
             when 'tipo' then p_cod || ' - ' || initcap(fnct_nome_situacao(p_cod))
             when 'emp'  then p_cod || ' - ' || initcap(fnct_nome_empresa(p_cod, 'S'))
             when 'fil'  then p_cod || ' - ' || initcap(fnct_nome_filial(p_emp, p_cod, 'S'))
             when 'cc'   then p_cod || ' - ' || initcap(fnct_nome_ccusto(p_emp, p_cod))
             when 'un'   then p_cod || ' - ' || initcap(fnct_nome_unidade_adm(p_emp, null, p_cod))
             when 'at'   then p_cod || ' - ' || initcap(fnct_nome_atividade(p_cod))
             when 'car'  then p_cod || ' - ' || initcap(fnct_nome_cargo(p_cod))
             when 'vin'  then initcap(fnct_nome_vinculo(p_cod))
           end;
    exception when others then r := p_cod;
    end;
    return substr(nvl(r, p_cod), 1, 380);
  end;
  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2) return pls_integer is
    k varchar2(400) := p_dim || '|' || p_emp || '|' || substr(p_cod, 1, 300);
    r varchar2(400); n pls_integer;
  begin
    if cache.exists(k) then return cache(k); end if;
    r := nome_dim(p_dim, p_emp, p_cod);
    if not por_rot.exists(p_dim || '|' || r) then
      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;
      por_rot(p_dim || '|' || r) := n;
      rot(p_dim || '#' || n) := r;
      qtd(p_dim) := n + 1;
    end if;
    cache(k) := por_rot(p_dim || '|' || r);
    return cache(k);
  end;
  /* "empresa,filial,ccusto,unidade,atividade,cargo,vínculo" em números (filial, ccusto e unidade
     dependem da empresa, os outros não) */
  function org(p_emp varchar2, p_fil varchar2, p_cc varchar2, p_un varchar2, p_at varchar2, p_car varchar2, p_vin varchar2) return varchar2 is
  begin
    return ix('emp', null, p_emp) || ',' || ix('fil', p_emp, p_fil) || ',' || ix('cc', p_emp, p_cc) || ',' ||
           ix('un', p_emp, p_un) || ',' || ix('at', null, p_at) || ',' || ix('car', null, p_car) || ',' || ix('vin', null, p_vin);
  end;
  procedure soma(a in out nocopy t_num, k varchar2, v number) is
  begin
    if a.exists(k) then a(k) := a(k) + v; else a(k) := v; end if;
  end;
  /* manda um CLOB para a resposta, até a posição p_ate */
  procedure manda(c clob, p_ate pls_integer) is
    p pls_integer := 1;
  begin
    while p <= p_ate loop
      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));
      p := p + 8000;
    end loop;
  end;
begin
  l_ini := data_de(:P25_DATA_INI);
  l_fim := nvl(data_de(:P25_DATA_FIM), l_hoje);
  if l_ini is null then l_ini := add_months(l_hoje, -12) + 1; l_fim := l_hoje; end if;
  dbms_lob.createtemporary(l_cru, true);

  /* monta tudo na memória e só envia no fim: um erro no meio não manda meio JSON */
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 2);
  apex_json.write('hoje', to_char(l_hoje, 'DD/MM/YYYY'));
  apex_json.write('ini', to_char(l_ini, 'DD/MM/YYYY'));
  apex_json.write('fim', to_char(l_fim, 'DD/MM/YYYY'));
  apex_json.write('padrao', l_padrao);

  /* ── o quadro (quem não está desligado), dividido pelas colunas ── */
  l_passo := 'quadro';
  cru('"quadroG":[');
  for r in (
    select i.cod_empresa emp, i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ,
           i.cargo car, i.vinculo vin, count(*) n
      from informacoes_funcionais i
     where i.situacao < '90'
       and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
       and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
       and (f_cc = 0 or instr(l_cc, ',' || i.cod_ccusto || ',') > 0)
       and (f_un = 0 or instr(l_un, ',' || i.unidade_adm || ',') > 0)
       and (f_at = 0 or instr(l_at, ',' || i.cod_atividade || ',') > 0)
       and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
       and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
     group by i.cod_empresa, i.filial, i.cod_ccusto, i.unidade_adm, i.cod_atividade, i.cargo, i.vinculo
  ) loop
    l_quadro := l_quadro + r.n;
    cru(case when l_n > 0 then ',' end || '[' || org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car, r.vin) || ',' || to_char(r.n) || ']');
    l_n := l_n + 1;
  end loop;
  cru(']');
  apex_json.write('quadro', l_quadro);
  l_t1 := dbms_utility.get_time;

  /* ── HOJE: quem está afastado agora (a situação atual do cadastro) ── */
  l_passo := 'hoje';
  apex_json.open_array('pessoas');
  for r in (
    select i.cod_empresa, i.matricula, i.cargo, i.cod_ccusto, i.situacao, i.dt_situacao, i.dt_retorno_afast,
           i.filial, i.unidade_adm, i.cod_atividade, i.vinculo
      from informacoes_funcionais i
     where i.situacao <> '01' and i.situacao < '90'
       and (f_sit = 0 or instr(l_sit, ',' || i.situacao || ',') > 0)
       and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
       and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
       and (f_cc = 0 or instr(l_cc, ',' || i.cod_ccusto || ',') > 0)
       and (f_un = 0 or instr(l_un, ',' || i.unidade_adm || ',') > 0)
       and (f_at = 0 or instr(l_at, ',' || i.cod_atividade || ',') > 0)
       and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
       and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
     order by i.dt_retorno_afast nulls first, i.dt_situacao
  ) loop
    l_tot := l_tot + 1;
    if r.dt_retorno_afast is null then l_sem := l_sem + 1;
    elsif r.dt_retorno_afast < l_hoje then l_atr := l_atr + 1;
    elsif r.dt_retorno_afast <= l_hoje + 7 then l_v7 := l_v7 + 1;
    end if;
    if r.dt_situacao is not null and l_hoje - r.dt_situacao + 1 > 15 then l_m15 := l_m15 + 1; end if;
    if l_tot <= 3000 then                                  /* a lista para "quem são" (e para o filtro do painel) */
      apex_json.open_object;
      apex_json.write('n', r.matricula || ' - ' || initcap(fnct_nome_func(r.cod_empresa, r.matricula)));
      apex_json.write('c', r.cargo || ' - ' || initcap(fnct_nome_cargo(r.cargo)));
      apex_json.write('s', r.cod_ccusto || ' - ' || initcap(fnct_nome_ccusto(r.cod_empresa, r.cod_ccusto)));
      apex_json.write('t', r.situacao || ' - ' || initcap(fnct_nome_situacao(r.situacao)));
      apex_json.write('d', to_char(r.dt_situacao, 'DD/MM/YYYY'));
      apex_json.write('r', to_char(r.dt_retorno_afast, 'DD/MM/YYYY'));
      apex_json.write('k', ix('tipo', null, r.situacao) || ',' ||
                           org(r.cod_empresa, r.filial, r.cod_ccusto, r.unidade_adm, r.cod_atividade, r.cargo, r.vinculo));
      apex_json.close_object;
    end if;
  end loop;
  apex_json.close_array;
  apex_json.open_object('agora');
  apex_json.write('total', l_tot);
  apex_json.write('voltam7', l_v7);
  apex_json.write('atrasados', l_atr);
  apex_json.write('semData', l_sem);
  apex_json.write('mais15', l_m15);
  apex_json.write('cortou', l_tot > 3000);
  apex_json.close_object;
  l_t2 := dbms_utility.get_time;

  /* ── NO PERÍODO: os afastamentos que tocam o período, lidos UMA vez; cada um vai para "ev" com as
       colunas em números. As contas (motivos, onde, mês a mês, pessoas) são feitas NA TELA, que assim
       filtra e troca o cruzamento na hora. ── */
  l_passo := 'periodo';
  cru(',"ev":[');
  l_n := 0;
  for r in (
    /* a MESMA junção do relatório (historico_cadastral x informacoes_funcionais, os mesmos filtros), sem
       janela sobre o histórico e sem subconsulta no histórico por linha. Histórico de desempenho, 08/10:
       LEAD sobre o histórico inteiro = 82 s; "próxima situação" por subconsulta = mais de 260 s.
       O FIM de cada afastamento é o da coluna "Data Final" do relatório:
         1. a data de fim do histórico;  2. senão, a do atestado (a mesma subconsulta do relatório);
         3. senão, se é a situação ATUAL da pessoa, está em andamento: conta até hoje;
         4. senão (afastamento antigo sem fim registrado), conta só o dia de início. */
    with x as (
      select a.cod_valor_fato cod, i.cod_empresa emp, i.matricula mat, i.cod_ccusto ccusto, a.dt_vigencia ini,
             i.filial fil, i.unidade_adm un, i.cod_atividade ativ, i.cargo car, i.vinculo vin,
             coalesce(a.dt_vigencia_fim,
                      (select af.dt_termino_afastamento
                         from atestado_funcionario af
                        where rownum = 1
                          and i.dt_retorno_afast - 1 = af.dt_termino_afastamento
                          and af.dt_termino_afastamento is not null
                          and i.dt_retorno_afast is not null
                          and af.dt_inicio_afastamento = a.dt_vigencia
                          and af.matricula = a.matricula
                          and af.cod_empresa = a.cod_empresa),
                      case when i.situacao = a.cod_valor_fato and i.dt_situacao = a.dt_vigencia then l_hoje end,
                      a.dt_vigencia) fim
        from historico_cadastral a, informacoes_funcionais i
       where a.cod_empresa = i.cod_empresa
         and a.matricula = i.matricula
         and a.cod_fato = 1
         and a.cod_valor_fato <> '01'
         and ((f_sit = 0 and a.cod_valor_fato < '90')
           or (f_sit = 1 and i.situacao >= '90' and instr(l_sit, ',' || a.cod_valor_fato || ',') > 0))
         and a.dt_vigencia <= l_fim
         and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
         and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
         and (f_cc = 0 or instr(l_cc, ',' || i.cod_ccusto || ',') > 0)
         and (f_un = 0 or instr(l_un, ',' || i.unidade_adm || ',') > 0)
         and (f_at = 0 or instr(l_at, ',' || i.cod_atividade || ',') > 0)
         and (f_car = 0 or instr(l_car, ',' || i.cargo || ',') > 0)
         and (f_mat = 0 or instr(l_mat, ',' || i.matricula || ',') > 0)
    )
    /* SEM GROUPING SETS: com a subconsulta do atestado dentro, o Oracle dá ORA-00904
       "SYS_TBL_$2$"."$vm_col_11" (a tabela temporária que ele cria para os grouping sets). */
    select cod, emp, mat, ccusto, fil, un, ativ, car, vin, to_char(ini, 'YYYYMM') mes,
           round(greatest(0, least(fim, l_fim) - greatest(ini, l_ini) + 1)) dias
      from x
     where fim >= l_ini
  ) loop
    if not pes.exists(r.emp || '|' || r.mat) then
      pes(r.emp || '|' || r.mat) := l_npes; pes_ch(to_char(l_npes)) := r.emp || '|' || r.mat; l_npes := l_npes + 1;
    end if;
    l_pi := pes(r.emp || '|' || r.mat);
    soma(pes_q, to_char(l_pi), 1);
    l_vezes := l_vezes + 1; l_dias := l_dias + r.dias;
    cru(case when l_n > 0 then ',' end || '[' || ix('tipo', null, r.cod) || ',' ||
        org(r.emp, r.fil, r.ccusto, r.un, r.ativ, r.car, r.vin) || ',' || l_pi || ',' || r.mes || ',' || to_char(r.dias) || ']');
    l_n := l_n + 1;
  end loop;
  cru(']');
  descarrega;

  apex_json.open_object('periodo');
  apex_json.write('vezes', l_vezes);
  apex_json.write('pessoas', l_npes);
  apex_json.write('dias', l_dias);
  apex_json.close_object;

  /* os nomes de cada coluna, na ordem dos números */
  l_passo := 'nomes';
  apex_json.open_object('dims');
  for j in 1 .. l_dims.count loop                    /* laço na coleção (TABLE() aqui dá ORA-22905, 08/10) */
    apex_json.open_array(l_dims(j));
    if qtd.exists(l_dims(j)) then
      for n in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || '#' || n)); end loop;
    end if;
    apex_json.close_array;
  end loop;
  apex_json.close_object;
  /* os nomes de quem se afastou 2 vezes ou mais (os únicos que o quadro "Mais de uma vez" mostra) */
  apex_json.open_object('nomes');
  declare k varchar2(400) := pes_q.first; e varchar2(400); m varchar2(400); begin
    while k is not null loop
      if pes_q(k) >= 2 then
        e := substr(pes_ch(k), 1, instr(pes_ch(k), '|') - 1);
        m := substr(pes_ch(k), instr(pes_ch(k), '|') + 1);
        apex_json.write(k, m || ' - ' || initcap(fnct_nome_func(e, m)));
      end if;
      k := pes_q.next(k);
    end loop;
  end;
  apex_json.close_object;

  apex_json.open_object('tempos');
  apex_json.write('quadro', l_t1 - l_t0);
  apex_json.write('hoje', l_t2 - l_t1);
  apex_json.write('periodo', dbms_utility.get_time - l_t2);
  apex_json.close_object;
  apex_json.close_object;
  l_saida := apex_json.get_clob_output;
  apex_json.free_output;

  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + quadroG/ev + "}" */
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
