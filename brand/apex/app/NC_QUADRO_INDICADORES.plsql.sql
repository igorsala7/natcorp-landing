/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · QUADRO DE PESSOAS — os números do painel (Ajax Callback)                       ║
   ║  App 200 · Página 16 (Informações Funcionais)                                             ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 16 › Processing › Ajax Callback › NC_QUADRO_INDICADORES (entra pelo
               aplicar-quadro-pagina16.py). Quem chama é o Natcorp_Quadro.js.
   Guia: QUADRO-MANUTENCAO.md.

   O QUE DEVOLVE (JSON)
     hoje, ini (12 meses atrás), estrutura (filtro de filial/centro de custo/… preenchido)
     agora{ ativos, trabalhando, afastados, experiencia, pcd_faltam, documentos, cadastro }
     experiencia[] documentos[] cadastro[] cota[]   quem são / a cota por empresa (até 300)
     mov{ entraram, sairam, ativos_inicio }         os últimos 12 meses
     meses[]  { m, e (entraram), s (saíram) }       por mês
     saidas[] por que saíram (a situação de desligamento)
     setores[] onde estão (pessoas ativas por centro de custo)
     casa[] idade[] escolaridade[]                  o perfil de quem está ativo
     sexo{ f, m }  aprendizes                        tempos{}
     remun{…}  equiparacao[] semreajuste[] adicionais[] cargos[] genero[] massacc[] reajustes[]
               (só com acesso a salário: F_Acesso_Salario_Apex, a MESMA regra da tabela, pessoa a pessoa)
     contr{…}  aviso[] pontonao[] maoobra[] modalidade[] jornada[] classes[]

   AS REGRAS
     • ATIVO = situação < 90 (a mesma regra do filtro "Ativos" da página); 01 = trabalhando, 02 a 89 =
       afastado. DESLIGADO = situação ≥ 90, saiu na data de situação.
     • EXPERIÊNCIA: o 1º prazo é DT_CONTRATO (40 dias) e o fim é DT_PRORROG (+50); conta quem está
       ativo e tem um desses dois prazos entre hoje e hoje + 15 (decidir prorrogar / efetivar).
     • COTA DE PCD (Lei 8.213, art. 93): por EMPRESA, sobre os ativos — 100 a 200: 2% · 201 a 500: 3% ·
       501 a 1000: 4% · acima de 1000: 5%. PCD = Deficiente ou Reabilitado = S. Só vale para a empresa
       INTEIRA: com filtro de filial, centro de custo… a tela avisa em vez de mostrar.
     • DOCUMENTOS: validade do conselho regional, ou da CNH de categoria C, D ou E (motorista), vencida
       ou vencendo em 30 dias. Data antes de 1950 (o 01/01/1900 do cadastro) = sem data.
     • CADASTRO INCOMPLETO: ativo sem PIS, sem CPF ou sem conta bancária (trava eSocial e folha).
     • SALÁRIO só de quem o usuário pode ver (F_Acesso_Salario_Apex = S). Sem ninguém: remun.acesso = false.
     • POSSÍVEL EQUIPARAÇÃO (CLT art. 461): mesmo cargo e mesma filial; um colega ganha 10% ou mais acima;
       diferença de tempo no cargo < 2 anos e de tempo de casa < 4 anos. É um ALERTA para análise.
     • DISPERSÃO: por cargo com 3+ pessoas: menor, 1º quartil, mediana, 3º quartil, maior (ordenação
       feita aqui no PL/SQL — TABLE() sobre coleção dá ORA-22905 nesta base).
     • MULHERES x HOMENS: cargos com 2+ mulheres e 2+ homens; diferença = (média H − média M) / média H.
     • SEM REAJUSTE: data do salário há mais de 12 meses (e quantos há mais de 24).
     • AVISO PRÉVIO: ativo com data de aviso nos últimos 90 dias. PONTO: marca_ponto = N; liderança e
       gerência (classe do cargo LD/GR) podem (CLT art. 62) — os outros pedem atenção.
     • ROTATIVIDADE (na tela) = ((entraram + saíram) / 2) / quadro médio; quadro médio = (ativos de
       12 meses atrás + ativos hoje) / 2; ativos de 12 meses atrás = ativos hoje − entraram + saíram.

   OS FILTROS e a SEGURANÇA são os do relatório (o bloco "quem pode ver quem" é COPIADO da exportação
   de 08/10 — mudou lá? copie de novo). A SITUAÇÃO da página não entra: o resumo precisa de ativos E
   de desligados dos últimos 12 meses. Lições da 25: instr no lugar de TABLE(), uma passada só,
   variáveis antes das funções, chave de array nunca nula.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje   date := trunc(sysdate);
  l_ini    date := add_months(trunc(sysdate), -12) + 1;
  l_emp varchar2(32767) := ',' || :P16_EMPRESA || ',';     f_emp number := case when :P16_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P16_FILIAL || ',';      f_fil number := case when :P16_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P16_CCUSTO || ',';      f_cc  number := case when :P16_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P16_UNIDADE_ADM || ','; f_un  number := case when :P16_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P16_ATIVIDADE || ',';   f_at  number := case when :P16_ATIVIDADE is null then 0 else 1 end;
  l_car varchar2(32767) := ',' || :P16_CARGO || ',';       f_car number := case when :P16_CARGO is null then 0 else 1 end;
  l_mat varchar2(32767) := ',' || :P16_MATRICULA || ',';   f_mat number := case when :P16_MATRICULA is null then 0 else 1 end;
  l_passo varchar2(30) := 'inicio';
  l_t0    number := dbms_utility.get_time;
  l_t1    number;
  l_saida clob;
  l_pos   pls_integer := 1;

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(4000) index by varchar2(400);
  visto   t_num;
  q_ent   t_num; q_sai t_num;                 /* por mês "AAAA-MM" */
  q_mot   t_num;                              /* saídas por situação */
  k_vazio t_txt;                              /* grupo sem código para buscar na tabela */
  q_set   t_num;                              /* ativos por centro de custo "cod - nome" */
  k_set   t_txt;                              /* o código do centro de custo (para buscar na tabela) */
  q_casa  t_num; q_idade t_num; q_instr t_num;
  e_ativos t_num; e_pcd t_num; e_nome t_txt;  /* por empresa: ativos, PCD, nome */
  /* as listas "quem são": uma pessoa por chave (a chave já dá a ordem: data + empresa + matrícula) */
  type t_p  is record (n varchar2(400), q varchar2(400), s varchar2(400), a date, t varchar2(400));
  type t_ps is table of t_p index by varchar2(400);
  l_exp   t_ps; l_doc t_ps; l_cad t_ps;
  n_exp   number := 0; n_doc number := 0; n_cad number := 0;
  l_ativos number := 0; l_trab number := 0; l_afast number := 0; l_f number := 0; l_m number := 0; l_aprend number := 0;
  l_ent number := 0; l_sai number := 0;
 /* remuneração */
  type t_vals  is table of number;
  type t_mapv  is table of t_vals index by varchar2(400);
  type t_eq    is record (sal number, dcar date, dadm date, mat varchar2(60), nome varchar2(300), emp varchar2(30), cc varchar2(400));
  type t_eqs   is table of t_eq;
  type t_mapeq is table of t_eqs index by varchar2(400);
  sal_cargo t_mapv; grp_eq t_mapeq;
  gf_s t_num; gf_n t_num; gm_s t_num; gm_n t_num;   /* por cargo: soma e quantidade de mulheres / homens */
  q_mcc t_num; n_mcc t_num; q_reaj t_num; q_ins t_num;
  l_equip t_ps; l_sreaj t_ps; l_adic t_ps;
  r_n number := 0; r_massa number := 0; r_f_s number := 0; r_f_n number := 0; r_m_s number := 0; r_m_n number := 0;
  n_eq number := 0; n_sr12 number := 0; n_sr24 number := 0; n_ins number := 0; n_per number := 0;
  /* contratos e jornada */
  l_aviso t_ps; l_ponto t_ps;
  q_mo t_num; q_modal t_num; q_jorn t_num; q_classe t_num;
  n_aviso number := 0; n_pl number := 0; n_po number := 0; n_apos number := 0; n_interm number := 0; n_sind number := 0;
  n_adto number := 0; n_estr number := 0; n_60 number := 0;
  l_estrutura boolean := :P16_FILIAL is not null or :P16_CCUSTO is not null or :P16_UNIDADE_ADM is not null
                         or :P16_ATIVIDADE is not null or :P16_CARGO is not null or :P16_MATRICULA is not null or :P16_MAT is not null;

  function d(p date) return varchar2 is begin return to_char(p, 'DD/MM/YYYY'); end;
  function primeira(k varchar2) return boolean is
  begin
    if visto.exists(k) then return false; end if;
    visto(k) := 1; return true;
  end;
  procedure soma(a in out nocopy t_num, k varchar2, v number) is
    l_k varchar2(400) := nvl(substr(k, 1, 400), '(sem informação)');
  begin
    if a.exists(l_k) then a(l_k) := a(l_k) + v; else a(l_k) := v; end if;
  end;
  /* uma pessoa na lista: n (matrícula - nome), q (o nome, para buscar na tabela), s, a (data), t (texto) */
  function pessoa(p_mat varchar2, p_nome varchar2, p_cc varchar2, p_a date, p_t varchar2) return t_p is
    l t_p;
  begin
    l.n := substr(p_mat || ' - ' || initcap(p_nome), 1, 400); l.q := substr(p_nome, 1, 400);
    l.s := substr(p_cc, 1, 400); l.a := p_a; l.t := substr(p_t, 1, 400);
    return l;
  end;
  procedure lista(p_nome varchar2, a t_ps) is
    k varchar2(400) := a.first;
  begin
    apex_json.open_array(p_nome);
    while k is not null loop
      apex_json.open_object;
      apex_json.write('n', a(k).n); apex_json.write('q', a(k).q); apex_json.write('s', a(k).s);
      if a(k).a is not null then apex_json.write('a', d(a(k).a)); end if;
      if a(k).t is not null then apex_json.write('t', a(k).t); end if;
      apex_json.close_object;
      k := a.next(k);
    end loop;
    apex_json.close_array;
  end;
  /* um grupo em ordem FIXA (faixas): só as que existem, na ordem dada */
  procedure faixas(p_nome varchar2, a t_num, p_ordem varchar2) is
    l_resto varchar2(4000) := p_ordem || '|'; l_k varchar2(400);
  begin
    apex_json.open_array(p_nome);
    while l_resto is not null and instr(l_resto, '|') > 0 loop
      l_k := substr(l_resto, 1, instr(l_resto, '|') - 1);
      l_resto := substr(l_resto, instr(l_resto, '|') + 1);
      if a.exists(l_k) then
        apex_json.open_object; apex_json.write('t', l_k); apex_json.write('q', a(l_k)); apex_json.close_object;
      end if;
    end loop;
    apex_json.close_array;
  end;
  /* os N maiores de um grupo */
  procedure maiores(p_nome varchar2, q t_num, p_n pls_integer, p_chave t_txt) is
    usado t_num; k varchar2(400); melhor varchar2(400);
  begin
    apex_json.open_array(p_nome);
    for x in 1 .. p_n loop
      melhor := null; k := q.first;
      while k is not null loop
        if not usado.exists(k) and (melhor is null or q(k) > q(melhor)) then melhor := k; end if;
        k := q.next(k);
      end loop;
      exit when melhor is null;
      usado(melhor) := 1;
      apex_json.open_object;
      apex_json.write('t', melhor); apex_json.write('q', q(melhor));
      if p_chave.exists(melhor) then apex_json.write('k', p_chave(melhor)); end if;
      apex_json.close_object;
    end loop;
    apex_json.close_array;
  end;
  function reais(p number) return varchar2 is
  begin
    return 'R$ ' || to_char(round(p), 'FM999G999G990', 'NLS_NUMERIC_CHARACTERS='',.''');
  end;
  /* ordena uma lista de valores (inserção: grupos de até alguns milhares) */
  procedure ordenar(v in out nocopy t_vals) is
    l_x number; j pls_integer;
  begin
    for i in 2 .. v.count loop
      l_x := v(i); j := i - 1;
      while j >= 1 and v(j) > l_x loop v(j + 1) := v(j); j := j - 1; end loop;
      v(j + 1) := l_x;
    end loop;
  end;
  function quartil(v t_vals, p number) return number is
    l_pos number := 1 + (v.count - 1) * p; l_lo pls_integer := floor(l_pos); l_hi pls_integer := ceil(l_pos);
  begin
    return v(l_lo) + (v(l_hi) - v(l_lo)) * (l_pos - l_lo);
  end;
begin
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('hoje', d(l_hoje));
  apex_json.write('ini', d(l_ini));
  apex_json.write('estrutura', l_estrutura);

  l_passo := 'pessoas';
  for r in (
    select i.cod_empresa emp, i.nome_empresa nemp, i.matricula mat, i.nome, i.situacao sit, i.nome_situacao nsit,
           i.dt_situacao dsit, i.dt_admissao dadm, i.dt_nasc dnasc, i.sexo, i.desc_instr instr,
           i.ind_def_fis def1, i.ind_def_fis_br def2, i.cat_vinculo cat,
           i.cod_ccusto || ' - ' || initcap(i.nome_ccusto) cc, i.cod_ccusto ccod,
           i.dt_contrato dcon, i.dt_prorrog dpro, i.dt_valid_cnh dcnh, i.categoria_cnh catcnh,
           i.dt_val_cons_reg dcons, i.sigla_cons_reg scons,
           i.num_pis_pasep pis, i.num_cpf cpf, i.num_conta conta,
           case when i.situacao < '90' and F_Acesso_Salario_Apex(i.cod_empresa, i.matricula, i.filial, :P_USUARIO) = 'S' then i.salario end sal,
           i.dt_salario dsal, initcap(i.descr_mot_sal) msal, i.perc_insalub insal, i.perc_peric peric,
           i.cod_tipo_mao_obra mo, i.cargo carg, initcap(i.nome_cargos) ncarg, i.dt_cargo dcarg,
           i.filial fil, initcap(i.nome_filial) nfil, i.class_cargo ccarg, initcap(i.descricao_class) dccarg,
           i.dt_aviso daviso, i.ind_avprev_indeniz taviso, i.marca_ponto ponto, i.trab_intermitente interm,
           i.tipo_modalidade modal, i.ind_aposentado apos, i.sindicalizado sind, i.adto_salarial adto,
           i.jornada_mensal_h jorn, i.class_trab_estrang estr
    FROM VW_CONSULTA_PESS_FUNC_V1 I
   WHERE (:P16_MAT IS NULL OR (COD_EMPRESA = :P16_EMP AND MATRICULA = :P16_MAT))
     /* sem o filtro de situação da página: ativos + quem saiu nos últimos 12 meses */
     and (situacao < '90' or dt_situacao >= l_ini or dt_admissao >= l_ini)
     and (f_emp = 0 or instr(l_emp, ',' || cod_empresa || ',') > 0)
     and (f_fil = 0 or instr(l_fil, ',' || filial || ',') > 0)
     and (f_cc  = 0 or instr(l_cc,  ',' || cod_ccusto || ',') > 0)
     and (f_un  = 0 or instr(l_un,  ',' || unidade_adm || ',') > 0)
     and (f_at  = 0 or instr(l_at,  ',' || cod_atividade || ',') > 0)
     and (f_car = 0 or instr(l_car, ',' || cargo || ',') > 0)
     and (f_mat = 0 or instr(l_mat, ',' || matricula || ',') > 0)
     and :P16_PESQUISA = 'S'
     /* ── a SEGURANÇA do relatório (quem pode ver quem), copiada da exportação de 08/10 ── */
AND ((I.COD_EMPRESA = :P_EMPRESA_USER AND I.MATRICULA = :P_MATRICULA_USER)
OR EXISTS (SELECT 1
             FROM USUARIO_ORACLE U, INFORMACOES_FUNCIONAIS IX
            WHERE U.CD_EMPRESA = IX.COD_EMPRESA (+)
              AND U.CD_MATRICULA = IX.MATRICULA (+)
              AND u.cd_empresa_negativa <> I.cod_empresa
              AND u.cd_matricula_negativa <> I.matricula
              AND U.NM_USUARIO_ORACLE = :P_USUARIO
              AND EXISTS (SELECT 1 
                            FROM USUARIO_ORACLE_FILIAIS UF
                           WHERE UF.CD_EMPRESA = I.COD_EMPRESA
                             AND UF.CD_FILIAL = I.FILIAL
                             AND UF.NM_USUARIO_ORACLE = U.NM_USUARIO_ORACLE)
              AND EXISTS (SELECT 1 
                            FROM USUARIO_ORACLE_CCUSTO UC
                           WHERE UC.COD_EMPRESA = I.COD_EMPRESA
                             AND UC.COD_CCUSTO = I.COD_CCUSTO
                             AND UC.NM_USUARIO_ORACLE = U.NM_USUARIO_ORACLE)
              AND EXISTS (SELECT 1
                            FROM organizacao_detalhe od
                           WHERE od.cd_nivel_pai = U.cd_nivel
                             AND od.cd_nivel_filho = I.CD_NIVEL
                             AND od.cd_nivel_filho IS NOT NULL
                             AND od.cd_nivel_filho <> u.cd_nivel_negativo)
              AND ((:P_PAINEL = 'PO') OR 
                   (NVL(u.pg_visualiza_diretos,'S') = 'N' or (
           EXISTS (SELECT 1
                             FROM centro_de_custo cx
                            WHERE cx.cod_empresa = i.cod_empresa
                              AND cx.cod = i.cod_ccusto
                              AND cx.cod_emp_gestor = u.cd_empresa
                              AND cx.matricula_gestor = u.cd_matricula
                           UNION
                           SELECT 1
                             FROM centro_de_custo cy
                            WHERE cy.cod_emp_gestor = i.cod_empresa 
                              AND cy.matricula_gestor = i.matricula
                              AND cy.cod_ccusto_superior = ix.cod_ccusto
                          union
                           SELECT 1
                           FROM SUB_CCUSTO S
                          WHERE S.COD_EMPRESA = I.COD_EMPRESA
                            AND S.COD_CCUSTO = I.COD_CCUSTO
                            AND S.COD_SUB_CCUSTO = I.COD_SUB_CCUSTO
                            AND s.cod_emp_gestor = :P_EMPRESA_USER
                            and s.mat_gestor = :P_MATRICULA_USER
                           ))))
           ))
-- Chamado 30620 - Inclusao de filtro para nao duplicar o colaborador em funcao do ccusto - 31-07-2023 - Andre
and not exists (select 1
            from distribuicao_custo
            where cod_empresa = i.cod_empresa
            and matricula = i.matricula
            --and cod_ccusto_contab =  I.cod_ccusto
                and cod_ccusto_contab =  I.custo_contab
            and origem = 3)
  ) loop
    if primeira('P|' || r.emp || '|' || r.mat) then          /* a consulta do relatório tem DISTINCT: pode repetir */
      if r.sit < '90' then
        /* ── quem está ativo ── */
        l_ativos := l_ativos + 1;
        if r.sit = '01' then l_trab := l_trab + 1; else l_afast := l_afast + 1; end if;
        if upper(r.sexo) = 'F' then l_f := l_f + 1; elsif upper(r.sexo) = 'M' then l_m := l_m + 1; end if;
        if r.cat = '103' then l_aprend := l_aprend + 1; end if;
        soma(e_ativos, to_char(r.emp), 1); e_nome(to_char(r.emp)) := r.emp || ' - ' || initcap(r.nemp);
        if upper(r.def1) = 'S' or upper(r.def2) = 'S' then soma(e_pcd, to_char(r.emp), 1); end if;
        soma(q_set, r.cc, 1); k_set(nvl(substr(r.cc, 1, 400), '(sem informação)')) := r.ccod;
        soma(q_instr, initcap(rtrim(r.instr, '.')), 1);
        soma(q_casa, case when r.dadm is null then 'Sem data'
                          when months_between(l_hoje, r.dadm) < 3 then 'Menos de 3 meses'
                          when months_between(l_hoje, r.dadm) < 12 then '3 meses a 1 ano'
                          when months_between(l_hoje, r.dadm) < 24 then '1 a 2 anos'
                          when months_between(l_hoje, r.dadm) < 60 then '2 a 5 anos'
                          when months_between(l_hoje, r.dadm) < 120 then '5 a 10 anos'
                          else 'Mais de 10 anos' end, 1);
        soma(q_idade, case when r.dnasc is null then 'Sem data'
                           when months_between(l_hoje, r.dnasc) / 12 < 25 then 'Até 24 anos'
                           when months_between(l_hoje, r.dnasc) / 12 < 35 then '25 a 34 anos'
                           when months_between(l_hoje, r.dnasc) / 12 < 45 then '35 a 44 anos'
                           when months_between(l_hoje, r.dnasc) / 12 < 55 then '45 a 54 anos'
                           else '55 anos ou mais' end, 1);
        /* experiência: o próximo prazo (1º período ou fim da prorrogação) nos próximos 15 dias */
        declare l_prazo date; l_qual varchar2(80); begin
          if r.dcon between l_hoje and l_hoje + 15 then l_prazo := r.dcon; l_qual := 'Fim do 1º prazo: prorrogar ou não';
          elsif r.dpro between l_hoje and l_hoje + 15 then l_prazo := r.dpro; l_qual := 'Fim da experiência: efetivar ou não'; end if;
          if l_prazo is not null and n_exp < 300 then
            l_exp(to_char(l_prazo, 'YYYYMMDD') || '|' || r.emp || '|' || r.mat) := pessoa(r.mat, r.nome, r.cc, l_prazo, l_qual);
          end if;
          if l_prazo is not null then n_exp := n_exp + 1; end if;
        end;
        /* documentos profissionais: conselho regional ou CNH C/D/E, vencido ou em até 30 dias */
        declare l_venc date; l_qual varchar2(120); begin
          if r.dcons > date '1950-01-01' and r.dcons <= l_hoje + 30 then l_venc := r.dcons; l_qual := 'Registro no conselho' || case when r.scons is not null then ' (' || r.scons || ')' end; end if;
          if r.dcnh > date '1950-01-01' and r.dcnh <= l_hoje + 30 and regexp_like(upper(r.catcnh), '[CDE]')
             and (l_venc is null or r.dcnh < l_venc) then l_venc := r.dcnh; l_qual := 'CNH categoria ' || upper(r.catcnh); end if;
          if l_venc is not null and n_doc < 300 then
            l_doc(to_char(l_venc, 'YYYYMMDD') || '|' || r.emp || '|' || r.mat) := pessoa(r.mat, r.nome, r.cc, l_venc, l_qual);
          end if;
          if l_venc is not null then n_doc := n_doc + 1; end if;
        end;
        /* cadastro: o que falta para o eSocial e a folha */
        declare l_falta varchar2(200); begin
          /* por TEXTO: número com ponto/traço viraria ORA-01722 numa comparação com 0 */
          if r.pis is null or ltrim(to_char(r.pis), '0. -') is null then l_falta := l_falta || ', PIS'; end if;
          if r.cpf is null or ltrim(to_char(r.cpf), '0. -') is null then l_falta := l_falta || ', CPF'; end if;
          if r.conta is null then l_falta := l_falta || ', conta bancária'; end if;
          if l_falta is not null and n_cad < 300 then
            l_cad(lpad(r.emp, 6, '0') || '|' || lpad(r.mat, 12, '0')) := pessoa(r.mat, r.nome, r.cc, null, 'Falta ' || substr(l_falta, 3));
          end if;
          if l_falta is not null then n_cad := n_cad + 1; end if;
        end;
        /* ── remuneração (só salário que o usuário pode ver) ── */
        if r.sal > 0 then
          declare
            kc varchar2(400) := substr(r.carg || ' - ' || r.ncarg, 1, 300);
            kg varchar2(400) := substr(r.carg || ' - ' || r.ncarg, 1, 300) || '|' || r.fil;
            l_e t_eq;
          begin
            r_n := r_n + 1; r_massa := r_massa + r.sal;
            soma(q_mcc, r.cc, r.sal); soma(n_mcc, r.cc, 1);
            if not sal_cargo.exists(kc) then sal_cargo(kc) := t_vals(); end if;
            sal_cargo(kc).extend; sal_cargo(kc)(sal_cargo(kc).count) := r.sal;
            if upper(r.sexo) = 'F' then soma(gf_s, kc, r.sal); soma(gf_n, kc, 1); r_f_s := r_f_s + r.sal; r_f_n := r_f_n + 1;
            elsif upper(r.sexo) = 'M' then soma(gm_s, kc, r.sal); soma(gm_n, kc, 1); r_m_s := r_m_s + r.sal; r_m_n := r_m_n + 1; end if;
            l_e.sal := r.sal; l_e.dcar := r.dcarg; l_e.dadm := r.dadm; l_e.mat := r.mat; l_e.nome := r.nome; l_e.emp := r.emp;
            l_e.cc := substr(r.ncarg || ' · ' || r.nfil, 1, 400);
            if not grp_eq.exists(kg) then grp_eq(kg) := t_eqs(); end if;
            grp_eq(kg).extend; grp_eq(kg)(grp_eq(kg).count) := l_e;
            if r.dsal < add_months(l_hoje, -12) then
              n_sr12 := n_sr12 + 1;
              if r.dsal < add_months(l_hoje, -24) then n_sr24 := n_sr24 + 1; end if;
              if n_sr12 <= 300 then
                l_sreaj(to_char(r.dsal, 'YYYYMMDD') || '|' || r.emp || '|' || r.mat) := pessoa(r.mat, r.nome, r.ncarg || ' · ' || r.cc, r.dsal, 'Último reajuste: ' || nvl(r.msal, 'sem motivo'));
              end if;
            end if;
            if r.dsal >= l_ini then soma(q_reaj, r.msal, 1); end if;
          end;
        end if;
        if nvl(r.insal, 0) > 0 or nvl(r.peric, 0) > 0 then
          if nvl(r.insal, 0) > 0 then n_ins := n_ins + 1; soma(q_ins, 'Insalubridade ' || r.insal || '%', 1); end if;
          if nvl(r.peric, 0) > 0 then n_per := n_per + 1; soma(q_ins, 'Periculosidade ' || r.peric || '%', 1); end if;
          if n_ins + n_per <= 300 then
            l_adic(lpad(r.emp, 6, '0') || '|' || lpad(r.mat, 12, '0')) := pessoa(r.mat, r.nome, r.ncarg || ' · ' || r.cc, null,
              trim(case when nvl(r.insal, 0) > 0 then 'Insalubridade ' || r.insal || '% ' end || case when nvl(r.peric, 0) > 0 then 'Periculosidade ' || r.peric || '%' end));
          end if;
        end if;
        /* ── contratos e jornada ── */
        if r.daviso >= l_hoje - 90 then
          n_aviso := n_aviso + 1;
          if n_aviso <= 300 then
            l_aviso(to_char(r.daviso, 'YYYYMMDD') || '|' || r.emp || '|' || r.mat) := pessoa(r.mat, r.nome, r.cc, r.daviso,
              case upper(r.taviso) when 'T' then 'Aviso trabalhado' when 'I' then 'Aviso indenizado' when 'D' then 'Dispensado do aviso' else 'Aviso prévio' end);
          end if;
        end if;
        if upper(r.ponto) = 'N' then
          if upper(r.ccarg) in ('LD', 'GR') then n_pl := n_pl + 1;
          else
            n_po := n_po + 1;
            if n_po <= 300 then
              l_ponto(lpad(r.emp, 6, '0') || '|' || lpad(r.mat, 12, '0')) := pessoa(r.mat, r.nome, r.cc, null, r.ncarg || case when r.dccarg is not null then ' (' || r.dccarg || ')' end);
            end if;
          end if;
        end if;
        if upper(r.apos) = 'S' then n_apos := n_apos + 1; end if;
        if upper(r.interm) = 'S' then n_interm := n_interm + 1; end if;
        if upper(r.sind) = 'S' then n_sind := n_sind + 1; end if;
        if upper(r.adto) = 'S' then n_adto := n_adto + 1; end if;
        if r.estr is not null then n_estr := n_estr + 1; end if;
        if r.dnasc is not null and months_between(l_hoje, r.dnasc) / 12 >= 60 then n_60 := n_60 + 1; end if;
        soma(q_mo, case upper(r.mo) when 'D' then 'Mão de obra direta' when 'I' then 'Mão de obra indireta' else r.mo end, 1);
        soma(q_modal, case upper(r.modal) when 'P' then 'Presencial' when 'H' then 'Home office' when 'S' then 'Semipresencial' when 'T' then 'Teletrabalho' else 'Não informado' end, 1);
        if r.jorn is not null then soma(q_jorn, r.jorn || case when r.jorn = 1 then ' hora por mês' else ' horas por mês' end, 1); end if;
        soma(q_classe, r.dccarg, 1);
      elsif r.dsit >= l_ini then
        /* ── saiu nos últimos 12 meses ── */
        l_sai := l_sai + 1;
        soma(q_sai, to_char(r.dsit, 'YYYY-MM'), 1);
        soma(q_mot, initcap(r.nsit), 1);
      end if;
      if r.dadm >= l_ini and r.dadm <= l_hoje then        /* entrou nos últimos 12 meses (está ou não ativo) */
        l_ent := l_ent + 1;
        soma(q_ent, to_char(r.dadm, 'YYYY-MM'), 1);
      end if;
    end if;
  end loop;
  l_t1 := dbms_utility.get_time;

  l_passo := 'json';
  /* a cota de PCD por empresa */
  declare k varchar2(400) := e_ativos.first; l_pct number; l_exig number; l_tem number; l_faltam number := 0; begin
    apex_json.open_array('cota');
    while k is not null loop
      l_pct := case when e_ativos(k) > 1000 then 0.05 when e_ativos(k) > 500 then 0.04 when e_ativos(k) > 200 then 0.03 when e_ativos(k) >= 100 then 0.02 else 0 end;
      l_exig := ceil(e_ativos(k) * l_pct);
      l_tem := case when e_pcd.exists(k) then e_pcd(k) else 0 end;
      l_faltam := l_faltam + greatest(0, l_exig - l_tem);
      apex_json.open_object;
      apex_json.write('t', e_nome(k)); apex_json.write('ativos', e_ativos(k)); apex_json.write('exige', l_exig); apex_json.write('tem', l_tem);
      apex_json.close_object;
      k := e_ativos.next(k);
    end loop;
    apex_json.close_array;
    apex_json.open_object('agora');
    apex_json.write('ativos', l_ativos); apex_json.write('trabalhando', l_trab); apex_json.write('afastados', l_afast);
    apex_json.write('experiencia', n_exp); apex_json.write('pcd_faltam', l_faltam);
    apex_json.write('documentos', n_doc); apex_json.write('cadastro', n_cad);
    apex_json.close_object;
  end;
  lista('experiencia', l_exp);
  lista('documentos', l_doc);
  lista('cadastro', l_cad);

  apex_json.open_object('mov');
  apex_json.write('entraram', l_ent); apex_json.write('sairam', l_sai);
  apex_json.write('ativos_inicio', l_ativos - l_ent + l_sai);
  apex_json.close_object;
  apex_json.open_object('sexo'); apex_json.write('f', l_f); apex_json.write('m', l_m); apex_json.close_object;
  apex_json.write('aprendizes', l_aprend);

  apex_json.open_array('meses');
  declare m date := trunc(l_ini, 'MM'); k varchar2(7); begin
    while m <= l_hoje loop
      k := to_char(m, 'YYYY-MM');
      apex_json.open_object; apex_json.write('m', k);
      apex_json.write('e', case when q_ent.exists(k) then q_ent(k) else 0 end);
      apex_json.write('s', case when q_sai.exists(k) then q_sai(k) else 0 end);
      apex_json.close_object;
      m := add_months(m, 1);
    end loop;
  end;
  apex_json.close_array;

  maiores('saidas', q_mot, 30, k_vazio);
  maiores('setores', q_set, 30, k_set);
  maiores('escolaridade', q_instr, 30, k_vazio);
  faixas('casa', q_casa, 'Menos de 3 meses|3 meses a 1 ano|1 a 2 anos|2 a 5 anos|5 a 10 anos|Mais de 10 anos|Sem data');
  faixas('idade', q_idade, 'Até 24 anos|25 a 34 anos|35 a 44 anos|45 a 54 anos|55 anos ou mais|Sem data');

  /* ── REMUNERAÇÃO ── */
  l_passo := 'remuneracao';
  declare
    k varchar2(400); l_v t_vals; l_amp number; usado t_num; melhor varchar2(400); l_mx number;
    type t_amp is table of number index by varchar2(400); amp t_amp;
  begin
    apex_json.open_object('remun');
    apex_json.write('acesso', r_n > 0);
    apex_json.write('n', r_n); apex_json.write('massa', round(r_massa, 2));
    apex_json.write('f_media', case when r_f_n > 0 then round(r_f_s / r_f_n, 2) end);
    apex_json.write('m_media', case when r_m_n > 0 then round(r_m_s / r_m_n, 2) end);
    apex_json.write('sem_reaj12', n_sr12); apex_json.write('sem_reaj24', n_sr24);
    apex_json.write('insal', n_ins); apex_json.write('peric', n_per);
    /* possível equiparação: dentro de cada cargo + filial */
    k := grp_eq.first;
    while k is not null loop
      declare g t_eqs := grp_eq(k); l_best number; begin
        for i in 1 .. g.count loop
          l_best := null;
          if g(i).dcar is not null and g(i).dadm is not null then
            for j in 1 .. g.count loop
              if g(j).sal >= g(i).sal * 1.10 and g(j).dcar is not null and g(j).dadm is not null
                 and abs(months_between(g(i).dcar, g(j).dcar)) < 24 and abs(months_between(g(i).dadm, g(j).dadm)) < 48
                 and (l_best is null or g(j).sal > l_best) then
                l_best := g(j).sal;
              end if;
            end loop;
          end if;
          if l_best is not null then
            n_eq := n_eq + 1;
            if n_eq <= 300 then
              l_equip(lpad(to_char(9999 - least(9999, round((l_best / g(i).sal - 1) * 100))), 4, '0') || '|' || g(i).emp || '|' || g(i).mat) :=
                pessoa(g(i).mat, g(i).nome, g(i).cc, null, 'Ganha ' || reais(g(i).sal) || '; colega do mesmo cargo e filial ganha '
                       || reais(l_best) || ' (+' || round((l_best / g(i).sal - 1) * 100) || '%)');
            end if;
          end if;
        end loop;
      end;
      k := grp_eq.next(k);
    end loop;
    apex_json.write('equip', n_eq);
    apex_json.close_object;
    lista('equiparacao', l_equip);
    lista('semreajuste', l_sreaj);
    lista('adicionais', l_adic);
    /* dispersão: cargos com 3+ pessoas, os 30 de maior amplitude (maior / menor) */
    k := sal_cargo.first;
    while k is not null loop
      if sal_cargo(k).count >= 3 then
        l_v := sal_cargo(k); ordenar(l_v); sal_cargo(k) := l_v;
        amp(k) := l_v(l_v.count) / greatest(l_v(1), 1);
      end if;
      k := sal_cargo.next(k);
    end loop;
    apex_json.open_array('cargos');
    for x in 1 .. 30 loop
      melhor := null; k := amp.first;
      while k is not null loop
        if not usado.exists(k) and (melhor is null or amp(k) > amp(melhor)) then melhor := k; end if;
        k := amp.next(k);
      end loop;
      exit when melhor is null;
      usado(melhor) := 1; l_v := sal_cargo(melhor);
      apex_json.open_object;
      apex_json.write('t', melhor); apex_json.write('n', l_v.count);
      apex_json.write('min', round(l_v(1), 2)); apex_json.write('q1', round(quartil(l_v, .25), 2));
      apex_json.write('med', round(quartil(l_v, .5), 2)); apex_json.write('q3', round(quartil(l_v, .75), 2));
      apex_json.write('max', round(l_v(l_v.count), 2));
      apex_json.close_object;
    end loop;
    apex_json.close_array;
    /* mulheres x homens: cargos com 2+ de cada, os 30 de maior diferença */
    amp.delete; usado.delete;
    k := gf_n.first;
    while k is not null loop
      if gf_n(k) >= 2 and gm_n.exists(k) and gm_n(k) >= 2 then
        amp(k) := (gm_s(k) / gm_n(k) - gf_s(k) / gf_n(k)) / (gm_s(k) / gm_n(k)) * 100;
      end if;
      k := gf_n.next(k);
    end loop;
    apex_json.open_array('genero');
    for x in 1 .. 30 loop
      melhor := null; k := amp.first;
      while k is not null loop
        if not usado.exists(k) and (melhor is null or abs(amp(k)) > abs(amp(melhor))) then melhor := k; end if;
        k := amp.next(k);
      end loop;
      exit when melhor is null;
      usado(melhor) := 1;
      apex_json.open_object;
      apex_json.write('t', melhor); apex_json.write('gap', round(amp(melhor), 1));
      apex_json.write('f', round(gf_s(melhor) / gf_n(melhor), 2)); apex_json.write('fn', gf_n(melhor));
      apex_json.write('m', round(gm_s(melhor) / gm_n(melhor), 2)); apex_json.write('mn', gm_n(melhor));
      apex_json.close_object;
    end loop;
    apex_json.close_array;
    /* folha por centro de custo */
    usado.delete;
    apex_json.open_array('massacc');
    for x in 1 .. 30 loop
      melhor := null; k := q_mcc.first;
      while k is not null loop
        if not usado.exists(k) and (melhor is null or q_mcc(k) > q_mcc(melhor)) then melhor := k; end if;
        k := q_mcc.next(k);
      end loop;
      exit when melhor is null;
      usado(melhor) := 1;
      apex_json.open_object;
      apex_json.write('t', melhor); apex_json.write('q', round(q_mcc(melhor), 2)); apex_json.write('n', n_mcc(melhor));
      if k_set.exists(melhor) then apex_json.write('k', k_set(melhor)); end if;
      apex_json.close_object;
    end loop;
    apex_json.close_array;
  end;
  maiores('reajustes', q_reaj, 30, k_vazio);
  maiores('adicionaisgrau', q_ins, 30, k_vazio);

  /* ── CONTRATOS E JORNADA ── */
  l_passo := 'contratos';
  apex_json.open_object('contr');
  apex_json.write('aviso', n_aviso); apex_json.write('ponto_lider', n_pl); apex_json.write('ponto_outros', n_po);
  apex_json.write('aposentados', n_apos); apex_json.write('intermitentes', n_interm); apex_json.write('sindicalizados', n_sind);
  apex_json.write('adiantamento', n_adto); apex_json.write('estrangeiros', n_estr); apex_json.write('mais60', n_60);
  apex_json.close_object;
  lista('aviso', l_aviso);
  lista('pontonao', l_ponto);
  maiores('maoobra', q_mo, 10, k_vazio);
  maiores('modalidade', q_modal, 10, k_vazio);
  maiores('jornada', q_jorn, 12, k_vazio);
  maiores('classes', q_classe, 12, k_vazio);

  apex_json.open_object('tempos');
  apex_json.write('pessoas', l_t1 - l_t0);
  apex_json.write('json', dbms_utility.get_time - l_t1);
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
