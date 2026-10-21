/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HISTÓRICO FINANCEIRO — os números do painel (Ajax Callback)                    ║
   ║  App 200 · Página 21 (Histórico Financeiro)                                               ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 21 › Processing › Ajax Callback › NC_HISTFIN_INDICADORES (entra pelo
               aplicar-histfin-pagina21.py). Quem chama é o Natcorp_HistFin.js.
   Guia: HISTFIN-MANUTENCAO.md.

   OS DADOS são os do processo "Totais" da própria página (o mesmo WITH inf/hist, a mesma regra de
   não contar duas vezes o que está no histórico e no mês). Os filtros vêm da SESSÃO (o que o último
   Pesquisar gravou), como o relatório: o painel mostra o mesmo que a tabela.
   VALOR só de quem o usuário pode ver (F_Acesso_Salario_Apex = S, a MESMA regra da coluna Valor).

   O TIPO DA VERBA (a mesma regra da região "Totais" e da Folha do Mês 300:74):
     configuracoes.quatro_digitos_ocorr = N: provento 1-499, desconto 500-899, base 900 em diante;
                                          S: provento 1-4999, desconto 5000-8999, base 9000 em diante.
     Provento/desconto só com incid_liq = 'S' (com 'N' é base). 996-999 / 9996-9999 são os TOTAIS da
     folha e não entram (senão contariam duas vezes).
   A CATEGORIA é a do cadastro da verba (Fnct_Nome_Cod_Gerencial): Horas extras, Faltas e atrasos,
   Encargos empresa… — é por ela que o painel agrupa.

   O QUE DEVOLVE (JSON)
     hoje, quatro, sem_acesso (pessoas cujo valor o usuário não vê), meses[] {m, p, d, n}, ult, ant
     agora{ prov, desc, liq, pessoas, he, he_horas, he_pessoas, negativos (saldo < 0 no mês), faltas, faltas_pessoas, encargos }
     negativos[] hepessoas[] faltaspessoas[] pessoasmudou[]   pessoas {n, q, s, t, v, a?, b?}
     catp[] catd[] {t, q, n}   setores[] {t, k, q, n}   origens[] encargos[] {t, q}
     mudou[] {t, a, b, v}  as verbas que mais mudaram entre os 2 últimos meses escolhidos

   Lições das páginas 16/25/26/164: instr no lugar de TABLE(), uma passada só, variáveis antes das
   funções, chave de array nunca nula, NVL2/DECODE só dentro de SQL.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje   date := trunc(sysdate);
  l_passo  varchar2(30) := 'inicio';
  l_saida  clob;
  l_pos    pls_integer := 1;
  l_4dig   varchar2(1);
  l_lim_p  number; l_lim_d1 number; l_lim_d2 number; l_tot1 number; l_tot2 number;
  l_refs   varchar2(4000) := '|';          /* os meses escolhidos "|AAAAMMDD|…|" */
  l_min    date; l_max date; l_ult date; l_ant date;
  l_sind   varchar2(32767) := ':' || :P21_SINDICATO || ':';
  l_sit    varchar2(32767) := ':' || :P21_SITUACOES || ':';
  l_vinc   varchar2(32767) := ':' || :P21_VINCULOS || ':';
  l_trub   varchar2(32767) := ':' || :P21_TIPO_RUBRICA || ':';
  l_ocor   varchar2(32767) := ':' || :P21_COD_OCORR || ':';
  l_adm_ini date; l_adm_fim date; l_ret_ini date; l_ret_fim date;

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(4000) index by varchar2(400);
  type t_p  is record (n varchar2(400), q varchar2(400), s varchar2(400), t varchar2(1000), v number, a number, b number);
  type t_ps is table of t_p index by varchar2(400);
  visto t_num; acesso t_txt; nomecat t_txt; nomecc t_txt; nomefun t_txt;
  m_p t_num; m_d t_num; m_n t_num;                     /* por mês "AAAAMMDD" */
  pm_p t_num; pm_d t_num;                              /* por pessoa+mês */
  c_p t_num; c_d t_num; cn_p t_num; cn_d t_num;        /* por categoria: R$ e pessoas */
  s_q t_num; s_n t_num; s_k t_txt;                     /* por centro de custo */
  o_q t_num; e_q t_num;                                /* por origem / encargos da empresa por verba */
  he_v t_num; he_h t_num; fa_v t_num; p_cc t_txt;      /* por pessoa: hora extra (R$, horas), faltas, setor */
  r_a t_num; r_b t_num;                                /* verba nos 2 últimos meses */
  l_a t_num; l_b t_num;                                /* líquido da pessoa nos 2 últimos meses */
  l_prov number := 0; l_desc number := 0; l_n number := 0; l_sem number := 0;
  l_he number := 0; l_heh number := 0; l_enc number := 0; l_fa number := 0;
  l_neg t_ps; n_neg number := 0;
  vazio_n t_num; vazio_t t_txt;                         /* grupo sem 2º número / sem texto de busca */
  /* a regra do relatório (09/10): sem Pesquisar não calcula; aberto pela ficha (P21_MAT), calcula */
  l_pesq boolean := :P21_MAT is not null or nvl(:P21_PESQUISA, 'N') = 'S';

  function d(p date) return varchar2 is begin return to_char(p, 'DD/MM/YYYY'); end;
  /* data de um item da página (texto no formato do app, ou dd/mm/aaaa) — nunca quebra */
  function dt(p varchar2) return date is
  begin
    if p is null then return null; end if;
    begin return to_date(p); exception when others then null; end;
    return to_date(substr(trim(p), 1, 10), 'DD/MM/RRRR');
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
  function val(a t_num, k varchar2) return number is
  begin
    if a.exists(k) then return a(k); end if; return 0;
  end;
  function pode(p_emp number, p_mat number, p_fil number) return boolean is
    k varchar2(100) := p_emp || '|' || p_mat;
  begin
    if not acesso.exists(k) then
      begin acesso(k) := nvl(F_Acesso_Salario_Apex(p_emp, p_mat, p_fil, :P_USUARIO), 'N');
      exception when others then acesso(k) := 'N'; end;
    end if;
    return acesso(k) = 'S';
  end;
  function categoria(p_cod varchar2) return varchar2 is
    k varchar2(100) := nvl(p_cod, '-');
  begin
    if not nomecat.exists(k) then
      begin nomecat(k) := nvl(initcap(Fnct_Nome_Cod_Gerencial(p_cod)), 'Sem categoria');
      exception when others then nomecat(k) := 'Sem categoria'; end;
    end if;
    return nomecat(k);
  end;
  function setor(p_emp number, p_cc number) return varchar2 is
    k varchar2(100) := p_emp || '|' || p_cc;
  begin
    if not nomecc.exists(k) then
      begin nomecc(k) := substr(p_cc || ' - ' || initcap(fnct_nome_ccusto(p_emp, p_cc)), 1, 400);
      exception when others then nomecc(k) := to_char(p_cc); end;
    end if;
    return nomecc(k);
  end;
  function nome(pk varchar2) return varchar2 is
    l_emp number := to_number(substr(pk, 1, instr(pk, '|') - 1));
    l_mat number := to_number(substr(pk, instr(pk, '|') + 1));
  begin
    if not nomefun.exists(pk) then
      begin nomefun(pk) := substr(l_mat || ' - ' || initcap(fnct_nome_func(l_emp, l_mat)), 1, 400);
      exception when others then nomefun(pk) := to_char(l_mat); end;
    end if;
    return nomefun(pk);
  end;
  function pessoa(pk varchar2, p_t varchar2, p_v number) return t_p is
    l t_p; l_n varchar2(400) := nome(pk);
  begin
    l.n := l_n; l.q := case when instr(l_n, ' - ') > 0 then substr(l_n, instr(l_n, ' - ') + 3) else l_n end;
    l.s := case when p_cc.exists(pk) then p_cc(pk) end; l.t := p_t; l.v := p_v;
    return l;
  end;
  function desc_v(v number) return varchar2 is
  begin
    return to_char(999999999999 - least(999999999999, round(abs(nvl(v, 0)) * 100)), 'FM000000000000');
  end;
  procedure lista(p_nome varchar2, a t_ps, p_max pls_integer default 300) is
    k varchar2(400) := a.first; i pls_integer := 0;
  begin
    apex_json.open_array(p_nome);
    while k is not null and i < p_max loop
      i := i + 1;
      apex_json.open_object;
      apex_json.write('n', a(k).n); apex_json.write('q', a(k).q); apex_json.write('s', a(k).s);
      if a(k).t is not null then apex_json.write('t', a(k).t); end if;
      if a(k).v is not null then apex_json.write('v', round(a(k).v, 2)); end if;
      if a(k).a is not null then apex_json.write('a', round(a(k).a, 2)); end if;
      if a(k).b is not null then apex_json.write('b', round(a(k).b, 2)); end if;
      apex_json.close_object;
      k := a.next(k);
    end loop;
    apex_json.close_array;
  end;
  /* os N maiores de um grupo (q), com pessoas (n) e o texto para buscar (k) */
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
  /* uma pessoa do mapa de valores numa lista ordenada do maior para o menor */
  procedure top_pessoas(p_nome varchar2, a t_num, p_extra t_num, p_unid varchar2) is
    k varchar2(400) := a.first; l t_ps;
  begin
    while k is not null loop
      if a(k) > 0 then
        l(desc_v(a(k)) || '|' || k) := pessoa(k,
          case when p_extra.exists(k) and p_extra(k) > 0 then trim(to_char(p_extra(k), 'FM999G999G990D9', 'NLS_NUMERIC_CHARACTERS='',.''')) || ' ' || p_unid end, a(k));
      end if;
      k := a.next(k);
    end loop;
    lista(p_nome, l, 30);
  end;

begin
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('hoje', d(l_hoje));

  l_passo := 'parametros';
  begin select nvl(quatro_digitos_ocorr, 'N') into l_4dig from configuracoes where rownum = 1;
  exception when others then l_4dig := 'N'; end;
  if l_4dig = 'S' then l_lim_p := 4999; l_lim_d1 := 5000; l_lim_d2 := 8999; l_tot1 := 9996; l_tot2 := 9999;
  else                 l_lim_p := 499;  l_lim_d1 := 500;  l_lim_d2 := 899;  l_tot1 := 996;  l_tot2 := 999; end if;
  apex_json.write('quatro', l_4dig);
  apex_json.write('sem_pesquisa', not l_pesq);
  l_adm_ini := dt(:P21_DT_ADM_INI); l_adm_fim := dt(:P21_DT_ADM_FIM);
  l_ret_ini := dt(:P21_DT_RETENCAO_INI); l_ret_fim := dt(:P21_DT_RETENCAO_FIM);

  /* os meses escolhidos no Período (dd/mm/aaaa:dd/mm/aaaa…): a faixa min-max usa o índice, a lista confere */
  declare l_resto varchar2(32767) := :P21_DATA_REF || ':'; l_x varchar2(40); l_dt date;
  begin
    while l_resto is not null and instr(l_resto, ':') > 0 loop
      l_x := substr(l_resto, 1, instr(l_resto, ':') - 1);
      l_resto := substr(l_resto, instr(l_resto, ':') + 1);
      l_dt := dt(l_x);
      if l_dt is not null then
        l_refs := l_refs || to_char(l_dt, 'YYYYMMDD') || '|';
        if l_min is null or l_dt < l_min then l_min := l_dt; end if;
        if l_max is null or l_dt > l_max then l_max := l_dt; end if;
        if l_ult is null or l_dt > l_ult then l_ant := l_ult; l_ult := l_dt;
        elsif l_dt < l_ult and (l_ant is null or l_dt > l_ant) then l_ant := l_dt; end if;
      end if;
    end loop;
  end;

  if l_min is not null and l_pesq then
    l_passo := 'linhas';
    for r in (
      with inf as (select i.cod_empresa, i.matricula, i.filial
                     from informacoes_funcionais i
                    where i.cod_empresa = nvl(:P21_EMP, nvl(:P21_EMPRESA, i.cod_empresa))
                      and (:P21_FILIAL_INI is null or i.filial between :P21_FILIAL_INI and :P21_FILIAL_FIM)
                      and (:P21_CCUSTO_INI is null or i.cod_ccusto between :P21_CCUSTO_INI and :P21_CCUSTO_FIM)
                      and (l_adm_ini is null or i.dt_admissao_basica between l_adm_ini and l_adm_fim)
                      and (:P21_SINDICATO is null or instr(l_sind, ':' || i.num_sind_diss || ':') > 0)
                      and (:P21_SITUACOES is null or instr(l_sit, ':' || i.situacao || ':') > 0)
                      and (:P21_VINCULOS is null or instr(l_vinc, ':' || i.vinculo || ':') > 0)
                      and (:P21_MATRICULA_INI is null or i.matricula between nvl(:P21_MAT, nvl(:P21_MATRICULA_INI, i.matricula))
                                                                         and nvl(:P21_MAT, nvl(:P21_MATRICULA_FIM, i.matricula)))),
           hist as (select h.cod_empresa, h.matricula, h.cod_ccusto, h.data_ref, h.cod_ocorr, h.nome_ocorrencia, h.cod_gerencial,
                           h.incid_liq, h.valor, h.unidade1, h.origem
                      from mwv_historicos h
                     where h.data_ref between l_min and l_max
                       and instr(l_refs, '|' || to_char(h.data_ref, 'YYYYMMDD') || '|') > 0
                       and (:P21_CCUSTO_CONT_INI is null or h.cod_ccusto_cont between :P21_CCUSTO_CONT_INI and :P21_CCUSTO_CONT_FIM)
                       and (l_ret_ini is null or h.data_retencao between l_ret_ini and l_ret_fim)
                       and (:P21_TIPO_RUBRICA is null or instr(l_trub, ':' || h.tipo_rubrica || ':') > 0)
                       and (:P21_COD_OCORR is null or instr(l_ocor, ':' || h.cod_ocorr || ':') > 0)
                       and h.origem in (:P21_H_FINAN_ACM, :P21_H_FERIAS, :P21_H_RESC, :P21_H_13, :P21_H_ADIANT, :P21_H_PART, :P21_H_RECALC, :P21_H_DIVERSOS, :P21_H_DIVERSOS_ACM)
                       and h.cod_ocorr is not null
                       and not exists (select 1 from view_mat_historicos_mes hm
                                        where hm.cod_empresa = h.cod_empresa and hm.matricula = h.matricula
                                          and hm.data_ref = h.data_ref and hm.cod_ocorr = h.cod_ocorr)
                    union all
                    select h.cod_empresa, h.matricula, h.cod_ccusto, h.data_ref, h.cod_ocorr, h.nome_ocorrencia, h.cod_gerencial,
                           h.incid_liq, h.valor, h.unidade1, h.origem
                      from mwv_historicos_mes h
                     where h.data_ref between l_min and l_max
                       and instr(l_refs, '|' || to_char(h.data_ref, 'YYYYMMDD') || '|') > 0
                       and (:P21_CCUSTO_CONT_INI is null or h.cod_ccusto_cont between :P21_CCUSTO_CONT_INI and :P21_CCUSTO_CONT_FIM)
                       and (l_ret_ini is null or h.data_retencao between l_ret_ini and l_ret_fim)
                       and (:P21_TIPO_RUBRICA is null or instr(l_trub, ':' || h.tipo_rubrica || ':') > 0)
                       and (:P21_COD_OCORR is null or instr(l_ocor, ':' || h.cod_ocorr || ':') > 0)
                       and h.origem in (:P21_H_FINAN, :P21_H_FERIAS, :P21_H_RESC, :P21_H_13, :P21_H_ADIANT, :P21_H_PART, :P21_H_RECALC, :P21_H_DIVERSOS, :P21_H_DIVERSOS_ACM)
                       and h.cod_ocorr is not null)
      select v.cod_empresa, v.matricula, i.filial, v.cod_ccusto, v.data_ref, v.cod_ocorr, v.nome_ocorrencia, v.cod_gerencial,
             v.incid_liq, v.valor, v.unidade1, v.origem
        from hist v, inf i
       where v.cod_empresa = i.cod_empresa
         and v.matricula = i.matricula
    ) loop
      declare
        pk   varchar2(100) := r.cod_empresa || '|' || r.matricula;
        mk   varchar2(10) := to_char(r.data_ref, 'YYYYMMDD');
        cod  number := r.cod_ocorr;
        tipo varchar2(1);
        vlr  number := nvl(r.valor, 0);
        cat  varchar2(400);
        ucat varchar2(400);
        rub  varchar2(400);
      begin
        if cod between l_tot1 and l_tot2 then null;              /* os totais da folha: não contam de novo */
        elsif not pode(r.cod_empresa, r.matricula, r.filial) then
          if primeira('S|' || pk) then l_sem := l_sem + 1; end if;
        else
          tipo := case when cod <= l_lim_p and r.incid_liq = 'S' then 'P'
                       when cod between l_lim_d1 and l_lim_d2 and r.incid_liq = 'S' then 'D'
                       else 'B' end;
          cat := categoria(r.cod_gerencial);
          ucat := upper(translate(cat, 'ÁÀÃÂÉÊÍÓÔÕÚÇáàãâéêíóôõúç', 'AAAAEEIOOOUCaaaaeeiooouc'));
          if not p_cc.exists(pk) then p_cc(pk) := setor(r.cod_empresa, r.cod_ccusto); end if;
          if primeira('N|' || mk || '|' || pk) then soma(m_n, mk, 1); end if;
          if primeira('P|' || pk) then l_n := l_n + 1; end if;
          rub := substr(cod || ' - ' || initcap(r.nome_ocorrencia), 1, 400);
          if tipo = 'P' then
            l_prov := l_prov + vlr; soma(m_p, mk, vlr); soma(pm_p, mk || '|' || pk, vlr);
            soma(c_p, cat, vlr); if primeira('CP|' || cat || '|' || pk) then soma(cn_p, cat, 1); end if;
            soma(s_q, p_cc(pk), vlr); s_k(p_cc(pk)) := to_char(r.cod_ccusto);
            if primeira('SN|' || p_cc(pk) || '|' || pk) then soma(s_n, p_cc(pk), 1); end if;
            soma(o_q, replace(replace(r.origem, ' Acm.', ''), ' Acm', ''), vlr);
            if ucat like 'HORAS EXTRAS%' then
              l_he := l_he + vlr; l_heh := l_heh + nvl(r.unidade1, 0); soma(he_v, pk, vlr); soma(he_h, pk, nvl(r.unidade1, 0));
            end if;
          elsif tipo = 'D' then
            l_desc := l_desc + vlr; soma(m_d, mk, vlr); soma(pm_d, mk || '|' || pk, vlr);
            soma(c_d, cat, vlr); if primeira('CD|' || cat || '|' || pk) then soma(cn_d, cat, 1); end if;
            if ucat like 'FALTAS%' then l_fa := l_fa + vlr; soma(fa_v, pk, vlr); end if;
          end if;
          if ucat like 'ENCARGOS EMPRESA%' then l_enc := l_enc + vlr; soma(e_q, rub, vlr); end if;
          /* para "o que mais mudou": verbas de provento e desconto nos 2 últimos meses */
          if tipo in ('P', 'D') and l_ant is not null then
            if r.data_ref = l_ult then soma(r_b, rub, case when tipo = 'D' then -vlr else vlr end);
            elsif r.data_ref = l_ant then soma(r_a, rub, case when tipo = 'D' then -vlr else vlr end); end if;
            if r.data_ref = l_ult then soma(l_b, pk, case when tipo = 'D' then -vlr else vlr end);
            elsif r.data_ref = l_ant then soma(l_a, pk, case when tipo = 'D' then -vlr else vlr end); end if;
          end if;
        end if;
      end;
    end loop;
  end if;

  l_passo := 'negativos';
  /* SALDO NEGATIVO: descontos maiores que os ganhos no mês (a pessoa fica devendo). Líquido ZERO não
     entra: é o normal de quem passou o mês de férias ou recebeu tudo adiantado */
  declare k varchar2(400); l_mk varchar2(10); l_pk varchar2(100); l_liq number;
  begin
    k := pm_d.first;
    while k is not null loop
      l_liq := val(pm_p, k) - pm_d(k);
      if l_liq < -0.004 then
        l_mk := substr(k, 1, 8); l_pk := substr(k, 10);
        n_neg := n_neg + 1;
        l_neg(l_mk || '|' || desc_v(l_liq) || '|' || l_pk) := pessoa(l_pk,
          to_char(to_date(l_mk, 'YYYYMMDD'), 'MM/YYYY') || ' · ganhou ' || to_char(val(pm_p, k), 'FM999G999G990D00', 'NLS_NUMERIC_CHARACTERS='',.''')
          || ' e teve ' || to_char(pm_d(k), 'FM999G999G990D00', 'NLS_NUMERIC_CHARACTERS='',.''') || ' de desconto', l_liq);
      end if;
      k := pm_d.next(k);
    end loop;
  end;

  l_passo := 'json';
  apex_json.write('sem_acesso', l_sem);
  if l_ult is not null then apex_json.write('ult', d(l_ult)); end if;
  if l_ant is not null then apex_json.write('ant', d(l_ant)); end if;
  apex_json.open_array('meses');
  declare k varchar2(400) := m_n.first;
  begin
    while k is not null loop
      apex_json.open_object;
      apex_json.write('m', substr(k, 1, 4) || '-' || substr(k, 5, 2));
      apex_json.write('p', round(val(m_p, k), 2)); apex_json.write('d', round(val(m_d, k), 2)); apex_json.write('n', m_n(k));
      apex_json.close_object;
      k := m_n.next(k);
    end loop;
  end;
  apex_json.close_array;
  apex_json.open_object('agora');
  apex_json.write('prov', round(l_prov, 2));
  apex_json.write('desc', round(l_desc, 2));
  apex_json.write('liq', round(l_prov - l_desc, 2));
  apex_json.write('pessoas', l_n);
  apex_json.write('he', round(l_he, 2));
  apex_json.write('he_horas', round(l_heh, 1));
  apex_json.write('he_pessoas', he_v.count);
  apex_json.write('negativos', n_neg);
  apex_json.write('faltas', round(l_fa, 2));
  apex_json.write('faltas_pessoas', fa_v.count);
  apex_json.write('encargos', round(l_enc, 2));
  apex_json.close_object;

  lista('negativos', l_neg);
  top_pessoas('hepessoas', he_v, he_h, 'horas');
  top_pessoas('faltaspessoas', fa_v, vazio_n, '');
  maiores('catp', c_p, 20, cn_p, vazio_t);
  maiores('catd', c_d, 20, cn_d, vazio_t);
  maiores('setores', s_q, 40, s_n, s_k);
  maiores('origens', o_q, 12, vazio_n, vazio_t);
  maiores('encargos', e_q, 12, vazio_n, vazio_t);

  l_passo := 'mudou';
  /* as verbas que mais mudaram (em R$, para mais ou para menos) e as pessoas cujo líquido mais mudou */
  declare k varchar2(400); l_v t_num; l_ord t_ps; l_x t_p;
  begin
    k := r_a.first;
    while k is not null loop l_v(k) := val(r_b, k) - r_a(k); k := r_a.next(k); end loop;
    k := r_b.first;
    while k is not null loop if not r_a.exists(k) then l_v(k) := r_b(k); end if; k := r_b.next(k); end loop;
    k := l_v.first;
    while k is not null loop
      if abs(l_v(k)) >= 0.01 then
        l_x.n := k; l_x.q := k; l_x.s := null; l_x.t := null; l_x.v := l_v(k); l_x.a := val(r_a, k); l_x.b := val(r_b, k);
        l_ord(desc_v(l_v(k)) || '|' || k) := l_x;
      end if;
      k := l_v.next(k);
    end loop;
    lista('mudou', l_ord, 15);
    l_ord.delete;
    k := l_a.first;
    while k is not null loop
      if l_b.exists(k) and abs(l_b(k) - l_a(k)) >= 0.01 then
        l_x := pessoa(k, null, l_b(k) - l_a(k)); l_x.a := l_a(k); l_x.b := l_b(k);
        l_ord(desc_v(l_b(k) - l_a(k)) || '|' || k) := l_x;
      end if;
      k := l_a.next(k);
    end loop;
    lista('pessoasmudou', l_ord, 30);
  end;

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
