/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 04  ONT_ONTOLOGIA                                           |
   +========================================================================================+
   [O1] Ajustes          cfg / cfg_num (ONT_CONFIG, com cache na sessao)
   [O2] Conceitos        novo_conceito, adicionar_termo, relacionar, recalcular_fecho
   [O3] Classificar      classificar_texto (um texto -> o conceito mais especifico)
                         classificar_candidatos (cadastro -> linhas -> conceitos, + geo e anos)
                         classificar_requisicao (requisicao -> itens comparaveis)
   [O4] Curadoria        registrar_pendentes, resolver_pendente, criar_conceito_de_pendente,
                         ignorar_pendente
   Nada aqui altera tabela fora das ONT_*.
*/
set define off
alter session set nls_length_semantics = char;

create or replace package ont_ontologia authid definer as
  /* [O1] */
  function  cfg     (p_chave varchar2) return varchar2;
  function  cfg_num (p_chave varchar2) return number;
  procedure limpar_cache;

  /* [O2] p_termos: outros nomes separados por ";" (ex.: 'RH;Gestao de RH;Gestao de Pessoas') */
  function  novo_conceito   (p_tipo varchar2, p_nome varchar2, p_termos varchar2 default null,
                             p_amplo varchar2 default null, p_cod_externo varchar2 default null,
                             p_origem varchar2 default 'MANUAL') return number;
  procedure adicionar_termo (p_conceito_id number, p_texto varchar2, p_tipo varchar2 default 'SINONIMO');
  /* p_tipo AMPLO: p_conceito e um tipo de p_alvo. RELACIONADO: valem p_peso um pelo outro (nos dois sentidos) */
  procedure relacionar      (p_conceito_id number, p_tipo varchar2, p_alvo_id number, p_peso number default 0.3);
  function  conceito_id     (p_tipo varchar2, p_nome varchar2) return number;
  procedure recalcular_fecho;

  /* [O3] */
  function  classificar_texto (p_texto_norm varchar2) return number;
  procedure classificar_candidatos (p_cod_candidato number default null, p_desde date default null);
  procedure classificar_requisicao (p_cod_req number);
  /* refaz os conceitos de todas as linhas do cadastro (depois de termos novos na ontologia) */
  procedure reclassificar_conceitos;

  /* [O4] */
  procedure registrar_pendentes;
  procedure resolver_pendente (p_pendente_id number, p_conceito_id number);
  function  criar_conceito_de_pendente (p_pendente_id number, p_tipo varchar2, p_nome varchar2 default null,
                                        p_amplo_id number default null) return number;
  procedure ignorar_pendente (p_pendente_id number);

  procedure log (p_rotina varchar2, p_msg varchar2, p_qtd number default null, p_inicio timestamp default null);
end ont_ontologia;
/

create or replace package body ont_ontologia as

  type t_cfg is table of varchar2(400) index by varchar2(40);
  g_cfg t_cfg;

  /* === [O1] AJUSTES =================================================================== */
  function cfg (p_chave varchar2) return varchar2 is
  begin
    if not g_cfg.exists(p_chave) then
      begin
        select valor into g_cfg(p_chave) from ont_config where chave = p_chave;
      exception when no_data_found then g_cfg(p_chave) := null;
      end;
    end if;
    return g_cfg(p_chave);
  end cfg;

  function cfg_num (p_chave varchar2) return number is
  begin
    return to_number(replace(cfg(p_chave), ',', '.'), '9999999990D9999', 'NLS_NUMERIC_CHARACTERS=''.,''');
  end cfg_num;

  procedure limpar_cache is begin g_cfg.delete; ont_texto.recarregar; end;

  procedure log (p_rotina varchar2, p_msg varchar2, p_qtd number default null, p_inicio timestamp default null) is
    pragma autonomous_transaction;
  begin
    insert into ont_log (rotina, mensagem, qtd, segundos)
    values (p_rotina, substr(p_msg, 1, 4000), p_qtd,
            case when p_inicio is not null then extract(second from (systimestamp - p_inicio))
                                              + 60 * extract(minute from (systimestamp - p_inicio))
                                              + 3600 * extract(hour from (systimestamp - p_inicio)) end);
    commit;
  end log;

  function usuario return varchar2 is
  begin
    return coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
  end usuario;

  /* === [O2] CONCEITOS ================================================================= */
  function conceito_id (p_tipo varchar2, p_nome varchar2) return number is
    r number;
  begin
    select id into r from ont_conceito where tipo = upper(p_tipo) and upper(nome) = upper(trim(p_nome));
    return r;
  exception when no_data_found then return null;
  end conceito_id;

  procedure adicionar_termo (p_conceito_id number, p_texto varchar2, p_tipo varchar2 default 'SINONIMO') is
    v_norm  varchar2(1000) := ont_texto.normalizar(p_texto);
    v_id    number;
    v_n     number;
  begin
    if v_norm is null then return; end if;
    begin
      select id into v_id from ont_termo where conceito_id = p_conceito_id and texto_norm = v_norm;
      return;                                         -- ja existe (mesma forma normalizada)
    exception when no_data_found then null;
    end;
    select count(*) into v_n from table(ont_texto.tokens(v_norm));
    insert into ont_termo (conceito_id, texto, texto_norm, tipo, n_tokens, criado_por)
    values (p_conceito_id, substr(trim(p_texto), 1, 300), substr(v_norm, 1, 300), upper(p_tipo), v_n, usuario)
    returning id into v_id;
    insert into ont_termo_token (termo_id, posicao, token, p3)
    select v_id, t.posicao, t.token, t.p3 from table(ont_texto.tokens(v_norm)) t;
    if upper(p_tipo) in ('PREFERIDO', 'SINONIMO') then
      insert into ont_vocab (token)
      select distinct t.token from table(ont_texto.tokens(v_norm)) t
       where length(t.token) >= 4 and not exists (select 1 from ont_vocab v where v.token = t.token);
    end if;
  end adicionar_termo;

  procedure relacionar (p_conceito_id number, p_tipo varchar2, p_alvo_id number, p_peso number default 0.3) is
  begin
    if p_conceito_id is null or p_alvo_id is null or p_conceito_id = p_alvo_id then return; end if;
    merge into ont_relacao r
    using (select p_conceito_id c, upper(p_tipo) t, p_alvo_id a, nvl(p_peso, 0.3) p from dual) x
       on (r.conceito_id = x.c and r.tipo = x.t and r.alvo_id = x.a)
     when matched then update set r.peso = x.p
     when not matched then insert (conceito_id, tipo, alvo_id, peso) values (x.c, x.t, x.a, x.p);
  end relacionar;

  function novo_conceito (p_tipo varchar2, p_nome varchar2, p_termos varchar2 default null,
                          p_amplo varchar2 default null, p_cod_externo varchar2 default null,
                          p_origem varchar2 default 'MANUAL') return number is
    v_id    number := conceito_id(p_tipo, p_nome);
    v_t     varchar2(300);
    v_amplo number;
    i       pls_integer := 1;
  begin
    if v_id is null then
      insert into ont_conceito (tipo, nome, cod_externo, origem, criado_por)
      values (upper(p_tipo), trim(p_nome), p_cod_externo, p_origem, usuario)
      returning id into v_id;
    end if;
    adicionar_termo(v_id, p_nome, 'PREFERIDO');
    loop
      v_t := trim(regexp_substr(p_termos, '[^;]+', 1, i));
      exit when v_t is null;
      i := i + 1;
      adicionar_termo(v_id, v_t, case when length(v_t) <= 4 and v_t = upper(v_t) then 'SIGLA' else 'SINONIMO' end);
    end loop;
    if p_amplo is not null then
      select min(id) into v_amplo from ont_conceito where upper(nome) = upper(trim(p_amplo));
      if v_amplo is null then
        raise_application_error(-20101, to_char(unistr('Conceito amplo n\00E3o encontrado: ')) || p_amplo || ' (crie-o antes de "' || p_nome || '")');
      end if;
      relacionar(v_id, 'AMPLO', v_amplo);
    end if;
    return v_id;
  end novo_conceito;

  procedure recalcular_fecho is
  begin
    delete from ont_conceito_fecho;
    insert into ont_conceito_fecho (conceito_id, ancestral_id, distancia)
    with f (conceito_id, ancestral_id, distancia) as (
      select conceito_id, alvo_id, 1 from ont_relacao where tipo = 'AMPLO'
      union all
      select f.conceito_id, r.alvo_id, f.distancia + 1
        from f join ont_relacao r on r.conceito_id = f.ancestral_id and r.tipo = 'AMPLO'
       where f.distancia < 10
    ) cycle conceito_id, ancestral_id set ciclo to 'S' default 'N'
    select conceito_id, ancestral_id, min(distancia)
      from f
     where ciclo = 'N' and conceito_id <> ancestral_id
     group by conceito_id, ancestral_id;
  end recalcular_fecho;

  /* === [O3] CLASSIFICAR ===============================================================
     Um termo "aparece" num texto quando TODAS as palavras do termo casam com palavras do texto
     (iguais; abreviacao no texto - comeco de palavra com 3+ letras que nao e palavra conhecida;
     ou 1 letra de diferenca com 6+ letras).
     Entre os termos que aparecem fica o MAIS ESPECIFICO (mais palavras), exato antes de aproximado.
     ==================================================================================== */
  function classificar_texto (p_texto_norm varchar2) return number is
    v_id number;
  begin
    if p_texto_norm is null then return null; end if;
    select conceito_id into v_id
      from (select t.conceito_id
              from (select tt.termo_id,
                           count(distinct tt.posicao) achou,
                           count(distinct case when tt.token = lt.token then tt.posicao end) exatos
                      from table(ont_texto.tokens(p_texto_norm)) lt
                      join ont_termo_token tt
                        on tt.p3 = lt.p3
                       and (   tt.token = lt.token
                            /* abreviacao no texto: a palavra curta nao e palavra conhecida */
                            or (length(lt.token) >= 3 and tt.token like lt.token || '%'
                                and not exists (select 1 from ont_vocab v where v.token = lt.token))
                            /* 1 letra de diferenca (6+ letras), se a do texto nao for outra palavra conhecida */
                            or (length(lt.token) >= 6 and length(tt.token) >= 6
                                and utl_match.edit_distance(lt.token, tt.token) <= 1
                                and not exists (select 1 from ont_vocab v where v.token = lt.token)))
                     group by tt.termo_id) m
              join ont_termo t on t.id = m.termo_id and m.achou = t.n_tokens
              join ont_conceito c on c.id = t.conceito_id and c.ativo = 'S'
             order by t.n_tokens desc, m.exatos desc, length(t.texto_norm) desc, t.conceito_id)
     where rownum = 1;
    return v_id;
  exception when no_data_found then return null;
  end classificar_texto;

  /* conceitos das linhas de um conjunto de candidatos (ONT_TMP via cod_candidato) */
  procedure classificar_linhas (p_cod_candidato number, p_todos varchar2) is
  begin
    insert into ont_cand_conceito (linha_id, conceito_id, termo_id, exato)
    select linha_id, conceito_id, termo_id, exato
      from (select m.linha_id, t.conceito_id, t.id termo_id,
                   case when m.exatos = t.n_tokens then 'S' else 'N' end exato,
                   row_number() over (partition by m.linha_id, t.conceito_id order by t.n_tokens desc, m.exatos desc) rn
              from (select lt.linha_id, tt.termo_id,
                           count(distinct tt.posicao) achou,
                           count(distinct case when tt.token = lt.token then tt.posicao end) exatos
                      from ont_cand_linha l
                      join ont_cand_linha_token lt on lt.linha_id = l.id
                      join ont_termo_token tt
                        on tt.p3 = lt.p3
                       and (   tt.token = lt.token
                            /* abreviacao no texto: a palavra curta nao e palavra conhecida */
                            or (length(lt.token) >= 3 and tt.token like lt.token || '%'
                                and not exists (select 1 from ont_vocab v where v.token = lt.token))
                            /* 1 letra de diferenca (6+ letras), se a do texto nao for outra palavra conhecida */
                            or (length(lt.token) >= 6 and length(tt.token) >= 6
                                and utl_match.edit_distance(lt.token, tt.token) <= 1
                                and not exists (select 1 from ont_vocab v where v.token = lt.token)))
                     where (p_todos = 'S' or l.cod_candidato = p_cod_candidato)
                       and not exists (select 1 from ont_cand_conceito x where x.linha_id = l.id)
                     group by lt.linha_id, tt.termo_id) m
              join ont_termo t on t.id = m.termo_id and m.achou = t.n_tokens
              join ont_conceito c on c.id = t.conceito_id and c.ativo = 'S')
     where rn = 1;
    /* numa mesma linha, o conceito mais amplo de outro conceito achado e redundante: sai */
    delete from ont_cand_conceito cc
     where exists (select 1
                     from ont_cand_conceito o
                     join ont_conceito_fecho f on f.conceito_id = o.conceito_id and f.ancestral_id = cc.conceito_id
                    where o.linha_id = cc.linha_id)
       and cc.linha_id in (select id from ont_cand_linha where p_todos = 'S' or cod_candidato = p_cod_candidato);
  end classificar_linhas;

  /* onde o candidato mora: CEP com coordenada propria > municipio do CEP > municipio pelo nome */
  procedure localizar (p_cod_candidato number, p_todos varchar2) is
  begin
    update ont_cand_controle k
       set (latitude, longitude, geo_precisao, geo_descricao) =
           (select g.latitude, g.longitude, 'CEP', 'CEP ' || lpad(c.cep, 5, '0') || '-' || lpad(c.complemento_cep, 3, '0')
              from ont_v_candidato c join ont_geo_cep g on g.cep = c.cep and g.complemento_cep = c.complemento_cep
             where c.cod_candidato = k.cod_candidato and rownum = 1)
     where (p_todos = 'S' or k.cod_candidato = p_cod_candidato)
       and exists (select 1 from ont_v_candidato c join ont_geo_cep g on g.cep = c.cep and g.complemento_cep = c.complemento_cep
                    where c.cod_candidato = k.cod_candidato);

    update ont_cand_controle k
       set (latitude, longitude, geo_precisao, geo_descricao) =
           (select g.latitude, g.longitude, 'MUNICIPIO_CEP', g.nome || '/' || g.uf
              from ont_v_candidato c
              join tabela_cep tc on tc.cep = c.cep and tc.complemento_cep = c.complemento_cep
              join ont_municipio_geo g on (g.cod_ibge7 = tc.cod_mun_ibge or g.cod_ibge6 = tc.cod_mun_ibge)
             where c.cod_candidato = k.cod_candidato and rownum = 1)
     where (p_todos = 'S' or k.cod_candidato = p_cod_candidato)
       and k.geo_precisao is null
       and exists (select 1 from ont_v_candidato c
                     join tabela_cep tc on tc.cep = c.cep and tc.complemento_cep = c.complemento_cep
                     join ont_municipio_geo g on (g.cod_ibge7 = tc.cod_mun_ibge or g.cod_ibge6 = tc.cod_mun_ibge)
                    where c.cod_candidato = k.cod_candidato);

    update ont_cand_controle k
       set (latitude, longitude, geo_precisao, geo_descricao) =
           (select g.latitude, g.longitude, 'MUNICIPIO_NOME', g.nome || '/' || g.uf
              from ont_v_candidato c
              join ont_municipio_geo g on g.nome_norm = trim(regexp_replace(ont_texto.sem_acento(c.cidade), '[^a-z0-9]+', ' '))
                                      and g.uf = upper(trim(c.uf))
             where c.cod_candidato = k.cod_candidato and rownum = 1)
     where (p_todos = 'S' or k.cod_candidato = p_cod_candidato)
       and k.geo_precisao is null;
  end localizar;

  /* anos de experiencia: soma dos periodos de emprego SEM contar duas vezes os que se sobrepoem */
  procedure somar_experiencia (p_cod_candidato number, p_todos varchar2) is
  begin
    merge into ont_cand_controle k
    using (
      with e as (select cod_candidato, data_ini ini, least(nvl(data_fim, trunc(sysdate)), trunc(sysdate)) fim
                   from ont_cand_linha
                  where origem = 'EMPREGO' and data_ini is not null
                    and (p_todos = 'S' or cod_candidato = p_cod_candidato)),
           m as (select cod_candidato, ini, fim,
                        max(fim) over (partition by cod_candidato order by ini, fim
                                       rows between unbounded preceding and 1 preceding) fim_ant
                   from e where fim >= ini),
           g as (select cod_candidato, ini, fim,
                        sum(case when fim_ant is null or ini > fim_ant then 1 else 0 end)
                          over (partition by cod_candidato order by ini, fim rows unbounded preceding) grp
                   from m),
           u as (select cod_candidato, min(ini) ini, max(fim) fim from g group by cod_candidato, grp)
      select cod_candidato, round(sum(months_between(fim, ini)) / 12, 2) anos from u group by cod_candidato
    ) x on (k.cod_candidato = x.cod_candidato)
    when matched then update set k.anos_experiencia = x.anos;
  end somar_experiencia;

  procedure classificar_candidatos (p_cod_candidato number default null, p_desde date default null) is
    v_todos   varchar2(1) := case when p_cod_candidato is null then 'S' else 'N' end;
    v_inicio  timestamp := systimestamp;
    v_inicio_d date := sysdate;
    v_n       number;
  begin
    limpar_cache;                                         -- configuracao e vocabulario atuais
    /* quem refazer */
    if p_cod_candidato is not null then
      delete from ont_cand_linha where cod_candidato = p_cod_candidato;
      delete from ont_cand_controle where cod_candidato = p_cod_candidato;
      insert into ont_cand_controle (cod_candidato, classificado_em) values (p_cod_candidato, sysdate);
    else
      /* p_desde nulo = TODOS; senao, os atualizados desde entao e os nunca classificados */
      delete from ont_cand_linha l
       where p_desde is null
          or l.cod_candidato in (select c.cod_candidato from ont_v_candidato c
                                  where greatest(nvl(c.dt_atu_p, date '1900-01-01'), nvl(c.dt_atu_f, date '1900-01-01')) >= p_desde);
      delete from ont_cand_controle k
       where p_desde is null
          or k.cod_candidato in (select c.cod_candidato from ont_v_candidato c
                                  where greatest(nvl(c.dt_atu_p, date '1900-01-01'), nvl(c.dt_atu_f, date '1900-01-01')) >= p_desde);
      insert into ont_cand_controle (cod_candidato, classificado_em)
      select c.cod_candidato, sysdate from ont_v_candidato c
       where not exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato);
    end if;

    /* as linhas (so de quem esta no controle com classificado_em de agora e ainda sem linhas) */
    insert into ont_cand_linha (cod_candidato, origem, texto, texto_norm, concluido, nivel_ordem, data_ini, data_fim)
    select f.cod_candidato, f.origem, f.texto, f.texto_norm, f.concluido, f.nivel_ordem, f.data_ini, f.data_fim
      from (select x.*, ont_texto.normalizar(x.texto_base) texto_norm from ont_v_cand_fonte x) f
     where f.texto_norm is not null
       and f.cod_candidato in (select k.cod_candidato from ont_cand_controle k
                                where (v_todos = 'S' and k.classificado_em >= v_inicio_d)
                                   or k.cod_candidato = p_cod_candidato)
       and not exists (select 1 from ont_cand_linha x where x.cod_candidato = f.cod_candidato and x.origem = f.origem
                          and x.texto = f.texto and nvl(x.data_ini, date '1900-01-01') = nvl(f.data_ini, date '1900-01-01'));
    v_n := sql%rowcount;

    insert into ont_cand_linha_token (linha_id, token, p3)
    select l.id, t.token, t.p3
      from ont_cand_linha l, table(ont_texto.tokens(l.texto_norm)) t
     where not exists (select 1 from ont_cand_linha_token x where x.linha_id = l.id)
       and (v_todos = 'S' or l.cod_candidato = p_cod_candidato);

    classificar_linhas(p_cod_candidato, v_todos);
    localizar(p_cod_candidato, v_todos);
    somar_experiencia(p_cod_candidato, v_todos);
    if v_todos = 'S' then registrar_pendentes; end if;
    log('classificar_candidatos', case when p_cod_candidato is not null then 'candidato ' || p_cod_candidato
                                       when p_desde is not null then 'desde ' || to_char(p_desde, 'dd/mm/yyyy hh24:mi')
                                       else 'todos' end, v_n, v_inicio);
  end classificar_candidatos;

  procedure reclassificar_conceitos is
    v_inicio timestamp := systimestamp;
  begin
    limpar_cache;
    delete from ont_cand_conceito;
    classificar_linhas(null, 'S');
    registrar_pendentes;
    log('reclassificar_conceitos', 'todas as linhas', null, v_inicio);
  end reclassificar_conceitos;

  procedure classificar_requisicao (p_cod_req number) is
    v_seq  number := 0;
    procedure item (p_criterio varchar2, p_texto varchar2, p_exige varchar2, p_nivel number default null,
                    p_codigo varchar2 default null, p_valor number default null, p_classificar boolean default true) is
      v_norm varchar2(1000) := case when p_classificar then ont_texto.normalizar(p_texto) end;
      v_cid  number;
      v_ex   varchar2(1) := case when upper(substr(nvl(p_exige, 'S'), 1, 1)) = 'N' then 'N' else 'S' end;
    begin
      if p_classificar then v_cid := classificar_texto(v_norm); end if;   -- BOOLEAN so no PL/SQL (no SQL so e valido no 23ai)
      v_seq := v_seq + 1;
      insert into ont_req_item (cod_req, seq, criterio, texto, texto_norm, conceito_id, exige, nivel_ordem, codigo, valor_num)
      values (p_cod_req, v_seq, p_criterio, substr(p_texto, 1, 1000), v_norm, v_cid, v_ex, p_nivel, p_codigo, p_valor);
    end item;
  begin
    delete from ont_req_item where cod_req = p_cod_req;
    for r in (select r.cod_req, r.cod_instrucao, r.anos_servico, r.meses_servico, r.exp_nec, r.ind_def_fis,
                     r.tipo_modalidade, r.cod_cargo, r.cod_local_trab, r.salario, r.salario_max,
                     (select o.nome from ont_instrucao_ordem o where o.cod = to_char(r.cod_instrucao)) instrucao_nome,
                     (select o.ordem from ont_instrucao_ordem o where o.cod = to_char(r.cod_instrucao)) instrucao_ordem
                from requisicao r where r.cod_req = p_cod_req) loop
      if r.cod_instrucao is not null then
        item('INSTRUCAO', nvl(r.instrucao_nome, to_char(unistr('Instru\00E7\00E3o ')) || r.cod_instrucao), 'S', r.instrucao_ordem, to_char(r.cod_instrucao), null, false);
      end if;
      for x in (select nome, exige from formacao_req_pessoal where cod_req = p_cod_req and nome is not null order by exige desc, nome) loop
        item('FORMACAO', x.nome, x.exige);
      end loop;
      for x in (select nome, exige from curso_req_pessoal where cod_req = p_cod_req and nome is not null order by exige desc, nome) loop
        item('CURSO', x.nome, x.exige);
      end loop;
      for x in (select nome, exige, nivel from conhecimento_req_pessoal where cod_req = p_cod_req and nome is not null order by exige desc, nome) loop
        item('CONHECIMENTO', x.nome, x.exige, x.nivel);
      end loop;
      for x in (select nome, exige from experiencia_req_pessoal where cod_req = p_cod_req and nome is not null order by exige desc, nome) loop
        item('EXPERIENCIA', x.nome, x.exige);
      end loop;
      /* "Experiencia necessaria" (texto livre): cada linha que for reconhecida como um conceito vira desejavel */
      if cfg('EXP_NEC_USAR') = 'S' and r.exp_nec is not null then
        for x in (select distinct l.column_value texto, ont_ontologia.classificar_texto(ont_texto.normalizar(l.column_value)) cid
                    from table(ont_texto.linhas(substr(r.exp_nec, 1, 4000))) l) loop
          if x.cid is not null then item('EXPERIENCIA', x.texto, 'N'); end if;
        end loop;
      end if;
      for x in (select t.cod_idioma, t.cod_nivel_conh, i.descricao idioma, n.descricao nivel, o.ordem
                  from idioma_req_pessoal t
                  join idioma i on i.codigo = t.cod_idioma
                  left join nivel_conhecimento n on n.codigo = t.cod_nivel_conh
                  left join ont_nivel_ordem o on o.codigo = to_char(t.cod_nivel_conh)
                 where t.cod_req = p_cod_req) loop
        item('IDIOMA', x.idioma || case when x.nivel is not null then to_char(unistr(' \00B7 ')) || x.nivel end, 'S', x.ordem, to_char(x.cod_idioma), null, false);
      end loop;
      if nvl(r.anos_servico, 0) + nvl(r.meses_servico, 0) > 0 then
        item('TEMPO', to_char(unistr('Experi\00EAncia de ')) || nvl(r.anos_servico, 0) || ' ano(s) e ' || nvl(r.meses_servico, 0) || to_char(unistr(' m\00EAs(es)')),
             'N', null, null, round(nvl(r.anos_servico, 0) + nvl(r.meses_servico, 0) / 12, 2), false);
      end if;
      if ',' || replace(cfg('MODALIDADES_SEM_DISTANCIA'), ' ') || ',' not like '%,' || r.tipo_modalidade || ',%'
         or r.tipo_modalidade is null then
        item('DISTANCIA', 'Mora perto do local de trabalho', 'N', null, r.tipo_modalidade, null, false);
      end if;
      if r.ind_def_fis = 'S' then
        item('PCD', 'Vaga PCD', 'S', null, null, null, false);
      end if;
      if r.cod_cargo is not null then
        item('CARGO_PRETENDIDO', 'Pretende este cargo', 'N', null, to_char(r.cod_cargo), null, false);
      end if;
      if r.cod_local_trab is not null
         and (',' || replace(cfg('MODALIDADES_SEM_DISTANCIA'), ' ') || ',' not like '%,' || r.tipo_modalidade || ',%' or r.tipo_modalidade is null) then
        item('LOCAL_PRETENDIDO', 'Pretende este local de trabalho', 'N', null, to_char(r.cod_local_trab), null, false);
      end if;
      if coalesce(r.salario_max, r.salario) is not null then
        item('SALARIO', to_char(unistr('Pretens\00E3o salarial dentro da vaga')), 'N', null, null, coalesce(r.salario_max, r.salario), false);
      end if;
    end loop;
    /* requisitos de texto que nao viraram conceito -> fila de curadoria */
    merge into ont_pendente p
    using (select texto_norm, min(texto) exemplo, count(*) n from ont_req_item
            where cod_req = p_cod_req and texto_norm is not null and conceito_id is null
              and criterio in ('FORMACAO', 'CURSO', 'CONHECIMENTO', 'EXPERIENCIA')
            group by texto_norm) x
       on (p.texto_norm = x.texto_norm)
     when matched then update set p.ultima_vez = sysdate, p.ocorrencias = p.ocorrencias + x.n,
                                  p.status = case when p.status = 'RESOLVIDO' then 'ABERTO' else p.status end
     when not matched then insert (texto_norm, exemplo, origem, ocorrencias) values (x.texto_norm, x.exemplo, 'REQUISICAO', x.n);
  end classificar_requisicao;

  /* === [O4] CURADORIA =================================================================
     A fila: textos do cadastro (formacao, curso, habilidade, cargo dos empregos) que nao viraram
     nenhum conceito, agrupados pela forma normalizada, com quantas vezes aparecem e uma SUGESTAO
     (o conceito com mais palavras em comum, se tiver ao menos metade delas).
     ==================================================================================== */
  procedure registrar_pendentes is
    v_min number := nvl(cfg_num('PENDENTE_MIN_CARACTERES'), 4);
  begin
    merge into ont_pendente p
    using (select l.texto_norm, min(l.texto) exemplo,
                  stats_mode(l.origem) origem, count(*) n
             from ont_cand_linha l
            where l.origem in ('FORMACAO', 'CURSO', 'HABILIDADE', 'EMPREGO')
              and length(l.texto_norm) >= v_min
              and not exists (select 1 from ont_cand_conceito c where c.linha_id = l.id)
            group by l.texto_norm) x
       on (p.texto_norm = x.texto_norm)
     when matched then update set p.ocorrencias = x.n, p.ultima_vez = sysdate
                       where p.status = 'ABERTO'
     when not matched then insert (texto_norm, exemplo, origem, ocorrencias) values (x.texto_norm, substr(x.exemplo, 1, 1000), x.origem, x.n);

    /* textos que passaram a ser reconhecidos saem da fila */
    update ont_pendente p set status = 'RESOLVIDO', resolvido_em = sysdate, resolvido_por = 'automatico'
     where status = 'ABERTO' and origem <> 'REQUISICAO'
       and not exists (select 1 from ont_cand_linha l where l.texto_norm = p.texto_norm
                          and not exists (select 1 from ont_cand_conceito c where c.linha_id = l.id));

    /* sugestao: conceito com mais palavras em comum (>= 50% das palavras do texto) */
    merge into ont_pendente p
    using (select pendente_id, conceito_id
             from (select p.id pendente_id, t.conceito_id,
                          row_number() over (partition by p.id order by count(distinct lt.token) desc, min(t.n_tokens)) rn,
                          count(distinct lt.token) comuns,
                          max(regexp_count(p.texto_norm, ' ') + 1) n
                     from ont_pendente p
                     cross join table(ont_texto.tokens(p.texto_norm)) lt
                     join ont_termo_token tt on tt.p3 = lt.p3 and ont_texto.casa(tt.token, lt.token) = 1
                     join ont_termo t on t.id = tt.termo_id
                    where p.status = 'ABERTO' and p.sugestao_id is null
                    group by p.id, t.conceito_id)
            where rn = 1 and comuns / n >= 0.5) x
       on (p.id = x.pendente_id)
     when matched then update set p.sugestao_id = x.conceito_id;
  end registrar_pendentes;

  procedure reclassificar_texto (p_texto_norm varchar2) is
  begin
    for c in (select distinct cod_candidato from ont_cand_linha where texto_norm = p_texto_norm) loop
      delete from ont_cand_conceito where linha_id in (select id from ont_cand_linha where cod_candidato = c.cod_candidato);
      classificar_linhas(c.cod_candidato, 'N');
    end loop;
    for r in (select distinct cod_req from ont_req_item where texto_norm = p_texto_norm) loop
      update ont_req_item set conceito_id = classificar_texto(texto_norm) where cod_req = r.cod_req and texto_norm = p_texto_norm;
    end loop;
  end reclassificar_texto;

  procedure resolver_pendente (p_pendente_id number, p_conceito_id number) is
    v_texto varchar2(1000);
    v_norm  varchar2(1000);
  begin
    select exemplo, texto_norm into v_texto, v_norm from ont_pendente where id = p_pendente_id;
    adicionar_termo(p_conceito_id, nvl(v_texto, v_norm), 'SINONIMO');
    update ont_pendente set status = 'RESOLVIDO', resolvido_por = usuario, resolvido_em = sysdate where id = p_pendente_id;
    ont_texto.recarregar;
    reclassificar_texto(v_norm);
  end resolver_pendente;

  function criar_conceito_de_pendente (p_pendente_id number, p_tipo varchar2, p_nome varchar2 default null,
                                       p_amplo_id number default null) return number is
    v_texto varchar2(1000);
    v_norm  varchar2(1000);
    v_id    number;
  begin
    select exemplo, texto_norm into v_texto, v_norm from ont_pendente where id = p_pendente_id;
    v_id := novo_conceito(p_tipo, nvl(p_nome, initcap(v_texto)), v_texto, null, null, 'CURADORIA');
    if p_amplo_id is not null then relacionar(v_id, 'AMPLO', p_amplo_id); recalcular_fecho; end if;
    update ont_pendente set status = 'RESOLVIDO', resolvido_por = usuario, resolvido_em = sysdate where id = p_pendente_id;
    ont_texto.recarregar;
    reclassificar_texto(v_norm);
    return v_id;
  end criar_conceito_de_pendente;

  procedure ignorar_pendente (p_pendente_id number) is
  begin
    update ont_pendente set status = 'IGNORADO', resolvido_por = usuario, resolvido_em = sysdate where id = p_pendente_id;
  end ignorar_pendente;

end ont_ontologia;
/
show errors package ont_ontologia
show errors package body ont_ontologia

prompt 04_ont_ontologia: pacote ONT_ONTOLOGIA criado.
