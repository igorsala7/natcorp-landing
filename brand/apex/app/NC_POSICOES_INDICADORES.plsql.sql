/* ╔════════════════════════════════════════════════════════════════════════════════════════╗
   ║  NATCORP · HEADCOUNT (POSIÇÕES) — os números do painel (Ajax Callback)                     ║
   ║  App 200 · Página 30 (Headcount — consulta das posições/vagas)                            ║
   ╚════════════════════════════════════════════════════════════════════════════════════════╝

   ONDE ENTRA  Página 30 › Processing › Ajax Callback › nome EXATO:  NC_POSICOES_INDICADORES
               Já vem na exportação f200_page_30.sql (aplicar-posicoes-pagina30.py). Quem chama é o
               Natcorp_Posicoes.js. Guia: POSICOES-MANUTENCAO.md.
   SÓ LÊ.      Nenhum insert/update/delete/commit: consultas e a montagem do JSON.

   O QUE DEVOLVE (JSON, "v": 1). O painel faz as contas NA TELA (filtros e cruzamentos).
     hoje
     dims{emp,fil,cc,cct,car,fun,vin,sit}   os NOMES, como as colunas do relatório mostram
     pos[[emp,fil,cc,cct,car,fun,vin,sit, "vaga", disp, comp, gestor, "requisição", AAAAMMDD início,
          AAAAMMDD fim, ocupantes, AAAAMMDD da última saída]]
                                CADA posição que o relatório mostra (as MESMAS regras: filtros P30_*,
                                f_acesso_fil, F_Acesso_CC e a regra do painel), na ordem do relatório.
                                disp = 1/0/-1 (Disponível Sim/Não/vazio); comp = vaga compartilhada;
                                ocupantes = colaboradores NÃO desligados (situação < 90) com essa
                                posição (cad_vaga) na mesma empresa e filial; última saída = a maior
                                data de situação de quem saiu (situação >= 90) da posição.
     urls{i: url}               o detalhe (página 31, com o checksum) das posições que aparecem nas
                                listas do painel (vagas, mais de uma pessoa, a conferir), até 6.000
     oc{i: ["mat - Nome", …]}   quem ocupa as posições com 2 pessoas ou mais
     sem{total, lista[{n,c,s,f,k}]}  quem trabalha (situação < 90) SEM posição válida, no mesmo
                                alcance (empresa/filial/hierarquia e os acessos); k = emp,fil,cc,car,vin
     cortou

   CUIDADO  • A consulta das posições é a do relatório; se o relatório mudar, mude aqui.
            • Os nomes (fnct_nome_*) saem UMA vez por código (cache), nunca por linha.
            • "pos" é escrito à mão num CLOB (só números e códigos escapados): com apex_json, 17
              chamadas por posição pesariam com milhares de posições.
            • Símbolos fora do Latin-1 não entram no banco: o aplicar-posicoes-pagina30.py troca os
              comuns e põe os acentos em unistr(), como o APEX exporta.
   ════════════════════════════════════════════════════════════════════════════════════════ */
declare
  l_hoje   date := trunc(sysdate);
  l_cru    clob;
  l_saida  clob;
  l_buf    varchar2(32767);
  l_corte  pls_integer;
  l_passo  varchar2(30) := 'inicio';
  l_n      pls_integer := 0;
  l_nurl   pls_integer := 0;
  l_url    varchar2(4000);
  l_sem    pls_integer := 0;
  l_k      varchar2(400);
  l_ocup   number;
  l_saiu   varchar2(8);
  l_disp   number;
  l_prob   boolean;
  l_emp    varchar2(100) := :P30_EMP;
  l_fil    varchar2(100) := :P30_FILIAL;
  l_cc     varchar2(100) := :P30_CCUSTO;

  l_dims sys.odcivarchar2list := sys.odcivarchar2list('emp', 'fil', 'cc', 'cct', 'car', 'fun', 'vin', 'sit');

  type t_num is table of number index by varchar2(400);
  type t_txt is table of varchar2(400) index by varchar2(400);
  cache   t_num;      /* "dim|chave" -> número */
  por_rot t_num;      /* "dim|nome" -> número */
  qtd     t_num;      /* dim -> quantos nomes */
  rot     t_txt;      /* "dim#número" -> nome */
  ocup    t_num;      /* "emp|filial|vaga" -> quem ocupa hoje */
  saiu    t_txt;      /* "emp|filial|vaga" -> AAAAMMDD da última saída */
  pos_ix  t_num;      /* "emp|filial|vaga" -> posição no "pos" (só as de 2+ pessoas) */
  vinn    t_txt;      /* vínculo -> nome */

  procedure descarrega is
  begin
    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;
  end;
  procedure cru(p varchar2) is
  begin
    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;
    l_buf := l_buf || p;
  end;
  function q(p varchar2) return varchar2 is      /* texto JSON entre aspas */
  begin
    return '"' || apex_escape.json(p) || '"';
  end;
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
  /* o nome de um código, IGUAL ao da coluna do relatório */
  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is
    k varchar2(400) := p_dim || '|' || p_emp || '|' || substr(p_cod, 1, 150) || '|' || substr(p_cod2, 1, 150);
    r varchar2(4000);
  begin
    if cache.exists(k) then return cache(k); end if;
    if p_cod is null then r := 'Não informado';
    else
      begin
        r := case p_dim
               when 'emp' then p_cod || ' - ' || initcap(fnct_nome_empresa(p_cod))
               when 'fil' then p_cod || ' - ' || initcap(fnct_nome_filial(p_emp, p_cod))
               when 'cc'  then p_cod || ' - ' || initcap(fnct_nome_ccusto(p_emp, p_cod))
               when 'cct' then p_cod || ' - ' || initcap(fnct_nome_ccusto_contab(p_emp, p_cod))
               when 'car' then p_cod || ' - ' || initcap(fnct_nome_cargo(p_cod))
               when 'fun' then p_cod || ' - ' || initcap(fnct_nome_funcao(p_cod2, p_cod))
             end;
      exception when others then r := p_cod;
      end;
    end if;
    cache(k) := ix_rot(p_dim, r);
    return cache(k);
  end;
  function nome_vinculo(p_cod varchar2) return varchar2 is
  begin
    if p_cod is null then return null; end if;
    if not vinn.exists(p_cod) then
      begin
        select substr(initcap(nome), 1, 380) into vinn(p_cod) from vinculo_empreg where cod = p_cod;
      exception when others then vinn(p_cod) := p_cod;
      end;
    end if;
    return vinn(p_cod);
  end;
  function nome_func(p_emp varchar2, p_mat varchar2) return varchar2 is
    r varchar2(400);
  begin
    begin r := p_mat || ' - ' || initcap(fnct_nome_func(p_emp, p_mat)); exception when others then r := p_mat; end;
    return substr(r, 1, 380);
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
  dbms_lob.createtemporary(l_cru, true);
  apex_json.initialize_clob_output;
  apex_json.open_object;
  apex_json.write('v', 1);
  apex_json.write('hoje', to_char(l_hoje, 'DD/MM/YYYY'));

  /* ── quem ocupa cada posição hoje, e a última saída ── */
  l_passo := 'ocupacao';
  for r in (select cod_empresa emp, filial fil, to_char(cad_vaga) vaga, count(*) n
              from informacoes_funcionais
             where situacao < '90' and cad_vaga is not null
             group by cod_empresa, filial, cad_vaga) loop
    ocup(r.emp || '|' || r.fil || '|' || r.vaga) := r.n;
  end loop;
  for r in (select cod_empresa emp, filial fil, to_char(cad_vaga) vaga, to_char(max(dt_situacao), 'YYYYMMDD') d
              from informacoes_funcionais
             where situacao >= '90' and cad_vaga is not null
             group by cod_empresa, filial, cad_vaga) loop
    saiu(r.emp || '|' || r.fil || '|' || r.vaga) := r.d;
  end loop;

  /* ── as posições: a MESMA consulta do relatório ── */
  l_passo := 'posicoes';
  apex_json.open_object('urls');
  cru('"pos":[');
  for r in (
    select c.cod_empresa, c.cod_filial, c.data_inicio, c.data_fim, to_char(c.cod_vaga) cod_vaga,
           c.cod_ccusto, c.cod_ccusto_contab, c.cod_cargo, c.cod_funcao, initcap(v.nome) vinculo,
           decode(c.sit_vaga, 'A', 'Ativa', 'S', 'Suspensa', 'E', 'Extinta') sit_vaga,
           c.ind_vaga_compartilhada, c.disponivel, c.cod_requisicao, c.posicao_ind_gestor
      from cl_vaga c, vinculo_empreg v
     where c.vinculo = v.cod
       and c.cod_empresa = nvl(l_emp, c.cod_empresa)
       and c.cod_filial = nvl(l_fil, c.cod_filial)
       and c.cod_ccusto = nvl(l_cc, c.cod_ccusto)
       and f_acesso_fil(c.cod_empresa, c.cod_filial) = 'S'
       and F_Acesso_CC(c.cod_empresa, c.cod_ccusto) = 'S'
       and ((:P_PAINEL = 'PO') or (not exists (select 1
                                                  from informacoes_funcionais i
                                                 where i.cod_empresa = c.cod_empresa
                                                   and i.filial = c.cod_filial
                                                   and i.cad_vaga = c.cod_vaga
                                                   and i.cod_empresa = :P_EMPRESA_USER
                                                   and i.matricula = :P_MATRICULA_USER)))
     order by c.cod_empresa, c.cod_filial, c.cod_ccusto, to_number(c.cod_vaga)
  ) loop
    l_k := r.cod_empresa || '|' || r.cod_filial || '|' || r.cod_vaga;
    l_ocup := case when ocup.exists(l_k) then ocup(l_k) else 0 end;
    l_saiu := case when saiu.exists(l_k) then saiu(l_k) end;
    l_disp := case r.disponivel when 'S' then 1 when 'N' then 0 else -1 end;
    cru(case when l_n > 0 then ',' end || '[' ||
        ix('emp', null, r.cod_empresa) || ',' || ix('fil', r.cod_empresa, r.cod_filial) || ',' ||
        ix('cc', r.cod_empresa, r.cod_ccusto) || ',' || ix('cct', r.cod_empresa, r.cod_ccusto_contab) || ',' ||
        ix('car', null, r.cod_cargo) || ',' || ix('fun', null, r.cod_funcao, r.cod_cargo) || ',' ||
        ix_rot('vin', r.vinculo) || ',' || ix_rot('sit', nvl(r.sit_vaga, 'Sem situação')) || ',' ||
        q(r.cod_vaga) || ',' || l_disp || ',' ||
        case when r.ind_vaga_compartilhada = 'S' then 1 else 0 end || ',' ||
        case when r.posicao_ind_gestor = 'S' then 1 else 0 end || ',' ||
        q(to_char(r.cod_requisicao)) || ',' || q(to_char(r.data_inicio, 'YYYYMMDD')) || ',' ||
        q(to_char(r.data_fim, 'YYYYMMDD')) || ',' || l_ocup || ',' || q(l_saiu) || ']');
    if l_ocup >= 2 then pos_ix(l_k) := l_n; end if;
    /* o detalhe só das posições que as listas mostram */
    l_prob := (r.sit_vaga = 'Ativa' and (l_ocup = 0
                                         or (l_ocup >= 2 and nvl(r.ind_vaga_compartilhada, 'N') <> 'S')
                                         or (l_disp = 1 and l_ocup > 0) or (l_disp = 0 and l_ocup = 0)
                                         or r.data_fim < l_hoje))
              or (nvl(r.sit_vaga, 'X') <> 'Ativa' and l_ocup > 0);
    if l_prob and l_nurl < 6000 then
      begin
        l_url := apex_page.get_url(p_page => 31, p_clear_cache => '31',
                                   p_items => 'P31_COD_EMPRESA,P31_COD_VAGA,P31_COD_FILIAL',
                                   p_values => r.cod_empresa || ',' || r.cod_vaga || ',' || r.cod_filial);
        apex_json.write(to_char(l_n), l_url);
        l_nurl := l_nurl + 1;
      exception when others then null;
      end;
    end if;
    l_n := l_n + 1;
  end loop;
  cru(']');
  descarrega;
  apex_json.close_object;

  /* ── quem ocupa as posições com 2 pessoas ou mais ── */
  l_passo := 'ocupantes';
  apex_json.open_object('oc');
  declare
    l_ult varchar2(400);
  begin
    for r in (select i.cod_empresa emp, i.filial fil, to_char(i.cad_vaga) vaga, i.matricula mat
                from informacoes_funcionais i
               where i.situacao < '90' and i.cad_vaga is not null
                 and (i.cod_empresa, i.filial, i.cad_vaga) in (select cod_empresa, filial, cad_vaga
                                                                 from informacoes_funcionais
                                                                where situacao < '90' and cad_vaga is not null
                                                                group by cod_empresa, filial, cad_vaga
                                                               having count(*) > 1)
               order by i.cod_empresa, i.filial, i.cad_vaga, i.matricula) loop
      l_k := r.emp || '|' || r.fil || '|' || r.vaga;
      if pos_ix.exists(l_k) then
        if l_ult is null or l_ult <> l_k then
          if l_ult is not null then apex_json.close_array; end if;
          apex_json.open_array(to_char(pos_ix(l_k)));
          l_ult := l_k;
        end if;
        apex_json.write(nome_func(r.emp, r.mat));
      end if;
    end loop;
    if l_ult is not null then apex_json.close_array; end if;
  end;
  apex_json.close_object;

  /* ── quem trabalha SEM posição válida, no mesmo alcance ── */
  l_passo := 'sem posicao';
  apex_json.open_object('sem');
  apex_json.open_array('lista');
  for r in (
    select i.cod_empresa emp, i.matricula mat, i.filial fil, i.cod_ccusto cc, i.cargo car, i.vinculo vin
      from informacoes_funcionais i
     where i.situacao < '90'
       and i.cod_empresa = nvl(l_emp, i.cod_empresa)
       and i.filial = nvl(l_fil, i.filial)
       and i.cod_ccusto = nvl(l_cc, i.cod_ccusto)
       and (i.cad_vaga is null
            or not exists (select 1 from cl_vaga c
                            where c.cod_empresa = i.cod_empresa and c.cod_filial = i.filial
                              and c.cod_vaga = i.cad_vaga))
       and f_acesso_fil(i.cod_empresa, i.filial) = 'S'
       and F_Acesso_CC(i.cod_empresa, i.cod_ccusto) = 'S'
     order by i.cod_empresa, i.filial, i.matricula
  ) loop
    l_sem := l_sem + 1;
    if l_sem <= 2000 then
      apex_json.open_object;
      apex_json.write('n', nome_func(r.emp, r.mat));
      apex_json.write('c', rot('car#' || ix('car', null, r.car)));
      apex_json.write('s', rot('cc#' || ix('cc', r.emp, r.cc)));
      apex_json.write('f', rot('fil#' || ix('fil', r.emp, r.fil)));
      apex_json.write('k', ix('emp', null, r.emp) || ',' || ix('fil', r.emp, r.fil) || ',' || ix('cc', r.emp, r.cc) || ',' ||
                           ix('car', null, r.car) || ',' || ix_rot('vin', nome_vinculo(r.vin)));
      apex_json.close_object;
    end if;
  end loop;
  apex_json.close_array;
  apex_json.write('total', l_sem);
  apex_json.close_object;
  apex_json.write('cortou', l_sem > 2000);

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
  apex_json.close_object;
  l_saida := apex_json.get_clob_output;
  apex_json.free_output;

  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + pos + "}" */
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
