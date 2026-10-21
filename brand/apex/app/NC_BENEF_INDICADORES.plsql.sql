/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · BENEFÍCIOS — os números do painel (Ajax Callback)                              ║
   ║  App 200 · Página 164 (Consulta de Benefícios)                                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 164 › Processing › Ajax Callback › NC_BENEF_INDICADORES (entra pelo
               aplicar-beneficios-pagina164.py). Quem chama é o Natcorp_BenefPainel.js.
   Guia: BENEFPAINEL-MANUTENCAO.md.

   A PÁGINA TEM DOIS RELATÓRIOS (o "Opção de Consulta", P164_OPCAO):
     C  Colaboradores  IR_1 = BI_BENEFICIOS do usuário (:P_USUARIO). Quem enche essa tabela é o
                       "Processo Consulta" no Pesquisar (PKG_CONSULTA_BENEFICIOS), já com os filtros
                       e a segurança. O painel lê a MESMA consulta do relatório (a união do VT com
                       MEIO_FUNC/UTILIZACAO/CUSTO_MEIO + os outros índices): mostra o que a tabela mostra.
     D  Dependentes    IR_4 = VW_BI_BENEFICIOS_DEPEND com as permissões (permissao_func/pess/depend) e
                       F_Acesso — o WHERE é COPIADO da exportação de 08/10 (mudou lá? copie de novo).

   O QUE DEVOLVE (JSON)
     modo C: hoje, ref (o mês da última compra), vazio
       agora{ custo, pessoas, vt, saude, semtrab, semtrab_valor, parados, terminam }
       semtrab[] parados[] terminam[]          quem são (até 300)
       familias[] {t,k,q=R$,n=pessoas}  setores[] {t,k,q,n}  adesao[] {t,q}  saude[] {t,q}
       vtmaior[] pessoamaior[] {n,q,s,t,v}     os 30 maiores
     modo D: hoje
       agora{ dependentes, titulares, filhos21, fazem21, cpf, cpf_visivel, encerram }
       filhos21[] fazem21[] cpf[] encerram[]  parentesco[] idade[] planos[] {t,q}  titulares[] {n,q,s,t,v}

   AS REGRAS (modo C)
     • A tabela repete linhas (a mesma compra aparece uma vez por faixa de valor mínimo/máximo e por
       meio de transporte): aqui cada benefício conta UMA vez por pessoa + índice + código + tipo +
       início + mês de referência.
     • MÊS DE REFERÊNCIA = o mais recente de todas as linhas (a última compra feita). CUSTO DO MÊS =
       soma do "Valor Compra" das linhas desse mês. Planos de saúde e seguros não têm compra: o custo
       deles vem da fatura da operadora e não entra aqui (a tela diz isso).
     • VIGENTE = começou até hoje e não terminou (sem data fim, ou fim de hoje em diante).
     • RECEBEM SEM ESTAR TRABALHANDO = situação ≠ 01 (afastado ou desligado) desde ANTES do mês de
       referência, com compra maior que zero nesse mês. É um alerta para conferir (custo indevido).
     • PARADOS = benefício vigente cuja última compra é anterior ao mês de referência: segue aberto
       no cadastro mas ninguém compra — encerrar ou corrigir.
     • TERMINAM = data fim entre hoje e hoje + 60 dias.
   AS REGRAS (modo D)
     • NO PLANO = adesão final vazia ou de hoje em diante, e sem data de baixa até hoje.
     • FILHOS 21+ = parentesco Filho/Filha/Enteado(a) com 21 anos ou mais, fora a condição "inválido"
       — conferir se ainda têm direito (o contrato costuma aceitar até 21, ou 24 se universitário).
     • FAZEM 21 = filhos que completam 21 anos nos próximos 90 dias (só quando a data de nascimento
       é visível para o usuário).
     • CPF = CPF vazio ou com dígito errado (o eSocial e a operadora pedem) — só conta quando o CPF é
       visível para o usuário (permissão "CPF" dos dependentes).
     • SAEM DO PLANO = adesão final entre hoje e hoje + 60 dias.

   Lições das páginas 16, 25 e 26: instr no lugar de TABLE(), uma passada só, variáveis antes das
   funções, chave de array nunca nula, NVL2/DECODE só dentro de SQL.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje  date := trunc(sysdate);
  l_modo  varchar2(10) := nvl(:P164_OPCAO, 'C');
  l_emp varchar2(32767) := ',' || :P164_EMPRESA || ',';     f_emp number := case when :P164_EMPRESA is null then 0 else 1 end;
  l_fil varchar2(32767) := ',' || :P164_FILIAL || ',';      f_fil number := case when :P164_FILIAL is null then 0 else 1 end;
  l_cc  varchar2(32767) := ',' || :P164_CCUSTO || ',';      f_cc  number := case when :P164_CCUSTO is null then 0 else 1 end;
  l_un  varchar2(32767) := ',' || :P164_UNIDADE_ADM || ','; f_un  number := case when :P164_UNIDADE_ADM is null then 0 else 1 end;
  l_at  varchar2(32767) := ',' || :P164_ATIVIDADE || ',';   f_at  number := case when :P164_ATIVIDADE is null then 0 else 1 end;
  l_mt  varchar2(32767) := ',' || :P164_MATRICULA_1 || ','; f_mt  number := case when :P164_MATRICULA_1 is null then 0 else 1 end;
  l_ix  varchar2(32767) := ',' || :P164_INDICE || ',';      f_ix  number := case when :P164_INDICE is null then 0 else 1 end;
  l_passo varchar2(30) := 'inicio';
  l_saida clob;
  l_pos   pls_integer := 1;

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(4000) index by varchar2(400);
  type t_dat is table of date index by varchar2(400);
  type t_p  is record (n varchar2(400), q varchar2(400), s varchar2(400), a date, t varchar2(1000), v number);
  type t_ps is table of t_p index by varchar2(400);
  visto t_num;
  /* modo C */
  l_ref date; l_custo number := 0; l_n number := 0; l_nvt number := 0; l_nsaude number := 0;
  p_nome t_txt; p_cc t_txt;                       /* por pessoa (emp|mat): "mat - Nome" e centro de custo */
  p_tot t_num; p_vt t_num; p_vtl t_num;          /* compra no mês: total, VT e linhas de VT */
  p_sit t_txt; p_sitd t_dat; p_semv t_num;       /* situação ≠ 01 desde antes do mês e o que ainda foi comprado */
  p_par t_txt; p_para t_dat;                     /* parados: os benefícios e a compra mais antiga */
  p_ter t_txt; p_tera t_dat;                     /* terminam: os benefícios e o fim mais perto */
  q_fam t_num; n_fam t_num; k_fam t_txt;          /* por benefício: R$, pessoas, texto para buscar */
  q_set t_num; n_set t_num; k_set t_txt;          /* por centro de custo */
  q_ade t_num; q_sau t_num;                       /* pessoas por índice / por operadora de saúde */
  l_semtrab t_ps; l_parados t_ps; l_terminam t_ps; l_vtm t_ps; l_pm t_ps;
  n_semtrab number := 0; v_semtrab number := 0; n_parados number := 0; n_terminam number := 0;
  /* modo D */
  q_par t_num; q_ida t_num; q_pla t_num; q_tit t_num; t_nome t_txt; t_cc t_txt;
  l_f21 t_ps; l_v21 t_ps; l_cpf t_ps; l_enc t_ps;
  n_dep number := 0; n_tit number := 0; n_f21 number := 0; n_v21 number := 0; n_cpf number := 0; n_enc number := 0;
  l_cpf_vis boolean := false;
  sem_n t_num; sem_t t_txt;                      /* grupo sem segundo número / sem texto de busca */

  function d(p date) return varchar2 is begin return to_char(p, 'DD/MM/YYYY'); end;
  /* as colunas da BI_BENEFICIOS vêm como texto ("01/06/2026", "1170,4"): leitura que não quebra */
  function dt(p varchar2) return date is
  begin
    if p is null then return null; end if;
    return to_date(substr(trim(p), 1, 10), 'DD/MM/RRRR');
  exception when others then return null;
  end;
  function n(p varchar2) return number is
    l varchar2(100) := trim(p);
  begin
    if l is null then return null; end if;
    if instr(l, ',') > 0 then l := replace(replace(l, '.', ''), ',', '.'); end if;
    return to_number(l, '999999999999990D9999999999', 'NLS_NUMERIC_CHARACTERS=''.,''');
  exception when others then return null;
  end;
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
  procedure junta(a in out nocopy t_txt, k varchar2, v varchar2) is
  begin
    if not a.exists(k) then a(k) := substr(v, 1, 1000);
    elsif instr(a(k), v) = 0 then a(k) := substr(a(k) || ' · ' || v, 1, 1000); end if;
  end;
  procedure menor(a in out nocopy t_dat, k varchar2, v date) is
  begin
    if not a.exists(k) or v < a(k) then a(k) := v; end if;
  end;
  function pessoa(p_n varchar2, p_q varchar2, p_s varchar2, p_a date, p_t varchar2, p_v number) return t_p is
    l t_p;
  begin
    l.n := substr(p_n, 1, 400); l.q := substr(p_q, 1, 400); l.s := substr(p_s, 1, 400);
    l.a := p_a; l.t := substr(p_t, 1, 1000); l.v := p_v;
    return l;
  end;
  /* "123 - Fulano" → "Fulano" (a busca da tabela acha a pessoa pelo nome) */
  function so_nome(p varchar2) return varchar2 is
  begin
    return case when instr(p, ' - ') > 0 then substr(p, instr(p, ' - ') + 3) else p end;
  end;
  function mes(p date) return varchar2 is
  begin
    return substr('janfevmarabrmaijunjulagosetoutnovdez', (to_number(to_char(p, 'MM')) - 1) * 3 + 1, 3) || '/' || to_char(p, 'YYYY');
  end;
  /* chave que ordena do MAIOR valor para o menor */
  function desc_v(v number) return varchar2 is
  begin
    return to_char(999999999999 - least(999999999999, round(nvl(v, 0) * 100)), 'FM000000000000');
  end;
  procedure lista(p_nome varchar2, a t_ps, p_max pls_integer default 300) is
    k varchar2(400) := a.first; i pls_integer := 0;
  begin
    apex_json.open_array(p_nome);
    while k is not null and i < p_max loop
      i := i + 1;
      apex_json.open_object;
      apex_json.write('n', a(k).n); apex_json.write('q', a(k).q); apex_json.write('s', a(k).s);
      if a(k).a is not null then apex_json.write('a', d(a(k).a)); end if;
      if a(k).t is not null then apex_json.write('t', a(k).t); end if;
      if a(k).v is not null then apex_json.write('v', round(a(k).v, 2)); end if;
      apex_json.close_object;
      k := a.next(k);
    end loop;
    apex_json.close_array;
  end;
  /* os N maiores de um grupo (q), com o segundo número (n) e o texto para buscar (k) */
  procedure maiores(p_nome varchar2, q t_num, p_n pls_integer, p_qtd t_num, p_chave t_txt) is
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
      apex_json.write('t', melhor); apex_json.write('q', round(q(melhor), 2));
      if p_qtd.exists(melhor) then apex_json.write('n', p_qtd(melhor)); end if;
      if p_chave.exists(melhor) then apex_json.write('k', p_chave(melhor)); end if;
      apex_json.close_object;
    end loop;
    apex_json.close_array;
  end;
  /* um grupo em ordem de chave (as faixas de idade começam pela letra: A, B, C…) */
  procedure em_ordem(p_nome varchar2, a t_num) is
    k varchar2(400) := a.first;
  begin
    apex_json.open_array(p_nome);
    while k is not null loop
      apex_json.open_object; apex_json.write('t', k); apex_json.write('q', a(k)); apex_json.close_object;
      k := a.next(k);
    end loop;
    apex_json.close_array;
  end;
  /* CPF com os dois dígitos verificadores certos */
  function cpf_ok(p varchar2) return boolean is
    c varchar2(30) := regexp_replace(p, '[^0-9]', ''); s number; r number;
  begin
    if c is null then return false; end if;
    c := lpad(c, 11, '0');
    if length(c) <> 11 or c = rpad(substr(c, 1, 1), 11, substr(c, 1, 1)) then return false; end if;
    for dv in 10 .. 11 loop
      s := 0;
      for i in 1 .. dv - 1 loop s := s + to_number(substr(c, i, 1)) * (dv + 1 - i); end loop;
      r := mod(s * 10, 11); if r = 10 then r := 0; end if;
      if r <> to_number(substr(c, dv, 1)) then return false; end if;
    end loop;
    return true;
  end;
  function filho(p varchar2) return boolean is
  begin
    return upper(p) like 'FILH%' or upper(p) like 'ENTEAD%';
  end;

begin
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('modo', case when l_modo = 'D' then 'D' else 'C' end);
  apex_json.write('hoje', d(l_hoje));

  if l_modo <> 'D' then
    /* ═══ COLABORADORES: a mesma consulta do relatório IR_1 ═══ */
    l_passo := 'ref';
    /* o mês de referência: a compra mais recente (lida como data) */
    for r in (select distinct to_char(b.data_ref) x from bi_beneficios b where b.usuario = :P_USUARIO and b.data_ref is not null) loop
      if dt(r.x) is not null and (l_ref is null or dt(r.x) > l_ref) then l_ref := dt(r.x); end if;
    end loop;

    l_passo := 'linhas';
    for r in (
      select b.indice, to_char(b.cod_empresa) emp, to_char(b.matricula) mat, b.nome, to_char(b.cod_ccusto) cc, b.nome_ccusto,
             to_char(b.situacao) situacao, b.nome_situacao, b.mes_situacao, to_char(b.ano_situacao) ano_situacao,
             to_char(b.codigo) codigo, b.descricao_familia, to_char(b.tipo) tipo, to_char(b.vlr_total) compra,
             to_char(b.dt_inicio) dt_inicio, to_char(b.dt_fim) dt_fim, to_char(b.data_ref) data_ref
        from bi_beneficios b, meio_func x, utilizacao u, custo_meio cm
       where b.usuario = :P_USUARIO
         and b.cod_empresa = x.cod_empresa
         and b.matricula   = x.matricula
         and b.tipo        = to_char(x.cod_loc)
         and u.cod_utilizacao = x.cod_utilizacao
         and b.cod_empresa = cm.cod_empresa
         and b.tipo = to_char(cm.cod_loc)
         and cm.empresa_vale = x.empresa_vale
         and b.indice = 'VALE TRANSPORTE'
      union all
      select c.indice, to_char(c.cod_empresa), to_char(c.matricula), c.nome, to_char(c.cod_ccusto), c.nome_ccusto,
             to_char(c.situacao), c.nome_situacao, c.mes_situacao, to_char(c.ano_situacao),
             to_char(c.codigo), c.descricao_familia, to_char(c.tipo), to_char(c.vlr_total),
             to_char(c.dt_inicio), to_char(c.dt_fim), to_char(c.data_ref)
        from bi_beneficios c
       where c.usuario = :P_USUARIO
         and c.indice <> 'VALE TRANSPORTE'
    ) loop
      declare
        pk    varchar2(200) := r.emp || '|' || r.mat;
        ini   date := dt(r.dt_inicio);
        fim   date := dt(r.dt_fim);
        dref  date := dt(r.data_ref);
        vlr   number := nvl(n(r.compra), 0);
        vig   boolean := (ini is null or ini <= l_hoje) and (fim is null or fim >= l_hoje);
        bnome varchar2(400) := substr(nvl(r.descricao_familia, r.indice), 1, 300);
        fam   varchar2(400) := substr(r.codigo || ' - ' || r.descricao_familia, 1, 400);
        sitd  date;
        l_m   pls_integer;
      begin
        /* a mesma compra repetida na tabela conta uma vez */
        if primeira('L|' || pk || '|' || r.indice || '|' || r.codigo || '|' || r.tipo || '|' || r.dt_inicio || '|' || r.data_ref) then
          if primeira('P|' || pk) then
            l_n := l_n + 1;
            p_nome(pk) := substr(r.mat || ' - ' || initcap(r.nome), 1, 400);
            p_cc(pk) := substr(r.cc || ' - ' || initcap(r.nome_ccusto), 1, 400);
          end if;
          if vig and primeira('A|' || r.indice || '|' || pk) then
            soma(q_ade, r.indice, 1);
            if r.indice = 'VALE TRANSPORTE' and primeira('VT|' || pk) then l_nvt := l_nvt + 1; end if;
            if r.indice like 'PLANO%' then
              if primeira('SA|' || pk) then l_nsaude := l_nsaude + 1; end if;
              if primeira('SO|' || r.codigo || '|' || pk) then soma(q_sau, r.indice || ': ' || r.descricao_familia, 1); end if;
            end if;
          end if;

          /* a compra do mês de referência */
          if dref = l_ref and vlr > 0 then
            l_custo := l_custo + vlr;
            soma(p_tot, pk, vlr);
            soma(q_fam, fam, vlr); k_fam(fam) := substr(r.descricao_familia, 1, 400);
            if primeira('F|' || fam || '|' || pk) then soma(n_fam, fam, 1); end if;
            soma(q_set, p_cc(pk), vlr); k_set(p_cc(pk)) := r.cc;
            if primeira('S|' || p_cc(pk) || '|' || pk) then soma(n_set, p_cc(pk), 1); end if;
            if r.indice = 'VALE TRANSPORTE' then soma(p_vt, pk, vlr); soma(p_vtl, pk, 1); end if;
            /* afastado ou desligado desde ANTES do mês da compra */
            if r.situacao <> '01' then
              l_m := instr('JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ', upper(substr(r.mes_situacao, 1, 3)));
              if l_m > 0 and regexp_like(r.ano_situacao, '^[0-9]{4}$') then
                sitd := to_date('01/' || lpad((l_m + 2) / 3, 2, '0') || '/' || r.ano_situacao, 'DD/MM/YYYY');
              end if;
              if sitd < l_ref then
                soma(p_semv, pk, vlr);
                p_sit(pk) := substr(r.situacao || ' - ' || initcap(r.nome_situacao), 1, 400); p_sitd(pk) := sitd;
              end if;
            end if;
          end if;
          /* aberto, mas sem compra desde antes do mês de referência */
          if vig and dref is not null and dref < l_ref then
            junta(p_par, pk, bnome || ' (' || mes(dref) || ')'); menor(p_para, pk, dref);
          end if;
          /* termina nos próximos 60 dias */
          if fim between l_hoje and l_hoje + 60 then
            junta(p_ter, pk, bnome || ' (' || to_char(fim, 'DD/MM') || ')'); menor(p_tera, pk, fim);
          end if;
        end if;
      end;
    end loop;

    l_passo := 'listas';
    declare k varchar2(400);
    begin
      k := p_semv.first;
      while k is not null loop
        n_semtrab := n_semtrab + 1; v_semtrab := v_semtrab + p_semv(k);
        l_semtrab(desc_v(p_semv(k)) || '|' || k) := pessoa(p_nome(k), so_nome(p_nome(k)), p_cc(k), p_sitd(k), p_sit(k), p_semv(k));
        k := p_semv.next(k);
      end loop;
      k := p_par.first;
      while k is not null loop
        n_parados := n_parados + 1;
        l_parados(to_char(p_para(k), 'YYYYMMDD') || '|' || k) := pessoa(p_nome(k), so_nome(p_nome(k)), p_cc(k), p_para(k), p_par(k), null);
        k := p_par.next(k);
      end loop;
      k := p_ter.first;
      while k is not null loop
        n_terminam := n_terminam + 1;
        l_terminam(to_char(p_tera(k), 'YYYYMMDD') || '|' || k) := pessoa(p_nome(k), so_nome(p_nome(k)), p_cc(k), p_tera(k), p_ter(k), null);
        k := p_ter.next(k);
      end loop;
      k := p_vt.first;
      while k is not null loop
        l_vtm(desc_v(p_vt(k)) || '|' || k) := pessoa(p_nome(k), so_nome(p_nome(k)), p_cc(k), null,
          case when p_vtl(k) > 1 then p_vtl(k) || ' linhas de transporte' else '1 linha de transporte' end, p_vt(k));
        k := p_vt.next(k);
      end loop;
      k := p_tot.first;
      while k is not null loop
        l_pm(desc_v(p_tot(k)) || '|' || k) := pessoa(p_nome(k), so_nome(p_nome(k)), p_cc(k), null, null, p_tot(k));
        k := p_tot.next(k);
      end loop;
    end;

    l_passo := 'json';
    apex_json.write('vazio', l_n = 0);
    if l_ref is not null then apex_json.write('ref', d(l_ref)); end if;
    apex_json.open_object('agora');
    apex_json.write('custo', round(l_custo, 2));
    apex_json.write('pessoas', l_n);
    apex_json.write('compraram', p_tot.count);
    apex_json.write('vt', l_nvt);
    apex_json.write('saude', l_nsaude);
    apex_json.write('semtrab', n_semtrab);
    apex_json.write('semtrab_valor', round(v_semtrab, 2));
    apex_json.write('parados', n_parados);
    apex_json.write('terminam', n_terminam);
    apex_json.close_object;
    lista('semtrab', l_semtrab);
    lista('parados', l_parados);
    lista('terminam', l_terminam);
    lista('vtmaior', l_vtm, 30);
    lista('pessoamaior', l_pm, 30);
    maiores('familias', q_fam, 40, n_fam, k_fam);
    maiores('setores', q_set, 40, n_set, k_set);
    maiores('adesao', q_ade, 20, sem_n, sem_t);
    maiores('saude', q_sau, 40, sem_n, sem_t);

  else
    /* ═══ DEPENDENTES: o WHERE do relatório IR_4 (instr no lugar de TABLE()) ═══ */
    l_passo := 'dependentes';
    for r in (
      select to_char(i.cod_empresa) emp, to_char(i.matricula) mat,
             case when pp.nome = 'S' then i.nome end nome,
             to_char(i.cod_ccusto) cc, i.nome_ccusto,
             to_char(i.num_depend) num_depend,
             case when pd.nome = 'S' then i.nome_depend end nome_depend,
             case when pd.grau_parent = 'S' then i.grau_parentesco end grau,
             case when pd.condicao = 'S' then i.condicao_depend end condicao,
             case when pd.dt_nasc = 'S' then i.dt_nasc end dt_nasc,
             pd.conjuge_cpf vis_cpf,
             case when pd.conjuge_cpf = 'S' then to_char(i.num_cpf_conjuge) end cpf,
             i.idade_dependente idade, i.faixa_idade_dependente faixa,
             replace(i.indice, '_', ' ') indice,
             case when pf.beneficio = 'S' then i.descricao end plano,
             i.dt_adesao_final, i.data_baixa
        from vw_bi_beneficios_depend i, permissao_func pf, permissao_pess pp, permissao_depend pd
       where pf.id_usuario = pp.id_usuario
         and pf.id_usuario = pd.id_usuario
         and pf.id_usuario = usuario.busca_user
         and i.cod_empresa = nvl(:P164_EMP, i.cod_empresa)
         and i.matricula = nvl(:P164_MAT, i.matricula)
         and ((i.situacao < '90' and :P164_SITUACAO_1 = 'A') or (i.situacao >= '90' and :P164_SITUACAO_1 = 'D') or (:P164_SITUACAO_1 = 'T'))
         and (f_emp = 0 or instr(l_emp, ',' || i.cod_empresa || ',') > 0)
         and (f_fil = 0 or instr(l_fil, ',' || i.filial || ',') > 0)
         and (f_cc  = 0 or instr(l_cc,  ',' || i.cod_ccusto || ',') > 0)
         and (f_un  = 0 or instr(l_un,  ',' || i.unidade_adm || ',') > 0)
         and (f_at  = 0 or instr(l_at,  ',' || i.cod_atividade || ',') > 0)
         and (f_mt  = 0 or instr(l_mt,  ',' || i.matricula || ',') > 0)
         and (f_ix  = 0 or instr(l_ix,  ',' || i.indice || ',') > 0)
         and F_Acesso(i.cod_empresa, i.matricula, i.filial, i.cd_nivel) = 'S'
    ) loop
      declare
        tk   varchar2(200) := r.emp || '|' || r.mat;
        dk   varchar2(200) := tk || '|' || r.num_depend;
        titular varchar2(400) := substr(r.mat || ' - ' || nvl(initcap(r.nome), 'Matrícula ' || r.mat), 1, 400);
        quem varchar2(400) := substr(nvl(initcap(r.nome_depend), 'Dependente nº ' || r.num_depend), 1, 400);
        busca varchar2(400) := nvl(r.nome_depend, nvl(r.nome, r.mat));
        rel  varchar2(200) := nvl(initcap(r.grau), 'Dependente');
        ida  number := r.idade;
        aniv date;
      begin
        if (r.dt_adesao_final is null or r.dt_adesao_final >= l_hoje) and (r.data_baixa is null or r.data_baixa > l_hoje) then
          if r.vis_cpf = 'S' then l_cpf_vis := true; end if;
          if primeira('PL|' || r.indice || '|' || r.plano || '|' || dk) then soma(q_pla, r.indice || ': ' || nvl(r.plano, 'PLANO'), 1); end if;
          if primeira('D|' || dk) then
            n_dep := n_dep + 1;
            soma(q_par, rel, 1);
            soma(q_ida, nvl(r.faixa, 'Sem idade'), 1);
            soma(q_tit, tk, 1); t_nome(tk) := titular; t_cc(tk) := substr(r.cc || ' - ' || initcap(r.nome_ccusto), 1, 400);
            if primeira('T|' || tk) then n_tit := n_tit + 1; end if;
            if filho(r.grau) and nvl(upper(r.condicao), 'X') not like 'INV%' then
              if ida >= 21 then
                n_f21 := n_f21 + 1;
                l_f21(lpad(999 - least(999, ida), 3, '0') || '|' || dk) := pessoa(quem, busca, titular, r.dt_nasc, rel || ' · ' || ida || ' anos', ida);
              elsif r.dt_nasc is not null then
                aniv := add_months(trunc(r.dt_nasc), 21 * 12);
                if aniv between l_hoje and l_hoje + 90 then
                  n_v21 := n_v21 + 1;
                  l_v21(to_char(aniv, 'YYYYMMDD') || '|' || dk) := pessoa(quem, busca, titular, aniv, rel || ' · faz 21 anos', null);
                end if;
              end if;
            end if;
            if r.vis_cpf = 'S' and not cpf_ok(r.cpf) then
              n_cpf := n_cpf + 1;
              l_cpf(tk || '|' || lpad(r.num_depend, 6, '0')) := pessoa(quem, busca, titular, null,
                rel || case when r.cpf is null then ' · sem CPF' else ' · CPF com dígito errado' end, null);
            end if;
          end if;
          if r.dt_adesao_final between l_hoje and l_hoje + 60 and primeira('E|' || dk) then
            n_enc := n_enc + 1;
            l_enc(to_char(r.dt_adesao_final, 'YYYYMMDD') || '|' || dk) := pessoa(quem, busca, titular, r.dt_adesao_final, rel || ' · ' || nvl(r.plano, r.indice), null);
          end if;
        end if;
      end;
    end loop;

    l_passo := 'json';
    apex_json.write('vazio', n_dep = 0);
    apex_json.open_object('agora');
    apex_json.write('dependentes', n_dep);
    apex_json.write('titulares', n_tit);
    apex_json.write('filhos21', n_f21);
    apex_json.write('fazem21', n_v21);
    apex_json.write('cpf', n_cpf);
    apex_json.write('cpf_visivel', l_cpf_vis);
    apex_json.write('encerram', n_enc);
    apex_json.close_object;
    lista('filhos21', l_f21);
    lista('fazem21', l_v21);
    lista('cpf', l_cpf);
    lista('encerram', l_enc);
    maiores('parentesco', q_par, 20, sem_n, sem_t);
    em_ordem('idade', q_ida);
    maiores('planos', q_pla, 40, sem_n, sem_t);
    /* titulares com mais dependentes no plano */
    declare k varchar2(400) := q_tit.first; l_t t_ps;
    begin
      while k is not null loop
        l_t(desc_v(q_tit(k)) || '|' || k) := pessoa(t_nome(k), so_nome(t_nome(k)), t_cc(k), null, null, q_tit(k));
        k := q_tit.next(k);
      end loop;
      lista('titulares', l_t, 30);
    end;
  end if;

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
