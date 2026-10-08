/* +========================================================================================+
   |  ONTOLOGIA DE RECRUTAMENTO - 05  ONT_ADERENCIA (a nota de cada candidato para a vaga)    |
   +========================================================================================+
   calcular(cod_req)  compara TODOS os candidatos do banco com os itens da requisicao
                      (ONT_REQ_ITEM) e grava ONT_ADERENCIA_ITEM (um por criterio, com a evidencia)
                      e ONT_ADERENCIA (a nota final). Nada fora das tabelas ONT_* e alterado.

   Nota final = soma(peso x nota) / soma(peso) x 100, so com os criterios que se aplicam:

   +------------------+-----------------------------------------------------------------------+
   | INSTRUCAO        | nivel do candidato >= o pedido: 1 - um degrau abaixo: INSTRUCAO_UM_ABAIXO|
   | FORMACAO / CURSO | mesmo conceito ou mais especifico: 1 - mais amplo: FATOR_AMPLO -       |
   | CONHECIMENTO     | relacionado: o peso da relacao - nao concluido: x FATOR_NAO_CONCLUIDO -|
   | EXPERIENCIA      | habilidade com nivel abaixo do pedido: x FATOR_NIVEL_ABAIXO.           |
   |                  | Requisito que nao virou conceito: comparacao de texto (ont_texto).     |
   | TEMPO            | anos somados (sem sobreposicao) / anos pedidos, no maximo 1            |
   | IDIOMA           | mesmo idioma, nivel >=: 1 - nivel abaixo: IDIOMA_NIVEL_ABAIXO           |
   | DISTANCIA        | ate RAIO_IDEAL_KM: 1 - cai em linha reta ate RAIO_MAXIMO_KM: 0.        |
   |                  | NAO ENTRA se a modalidade estiver em MODALIDADES_SEM_DISTANCIA         |
   |                  | (home office, teletrabalho); peso x FATOR_PARCIAL nas MODALIDADES_PARCIAIS|
   | PCD              | so em vaga PCD: candidato PCD do tipo aceito 1 - PCD de outro tipo:    |
   |                  | PCD_TIPO_DIFERENTE - nao PCD: 0 e, com PCD_MODO = ELIMINATORIO, fica    |
   |                  | marcado como eliminado (vai para o fim, com o motivo)                  |
   | CARGO_PRETENDIDO | so se o candidato informou: o cargo da vaga 1, outro 0                 |
   | LOCAL_PRETENDIDO | idem com o local de trabalho (nao entra em home office)                |
   | SALARIO          | so se ambos informados: pretensao <= teto 1 - ate +SALARIO_TOLERANCIA: |
   |                  | cai ate 0                                                              |
   +------------------+-----------------------------------------------------------------------+
   Idade e sexo da requisicao NAO entram na nota (CLT art. 373-A e Lei 9.029/95).
*/
set define off
alter session set nls_length_semantics = char;

create or replace package ont_aderencia authid definer as
  procedure calcular (p_cod_req number);
  procedure calcular_processo (p_cod_processo number);
  /* recalcula se o ultimo calculo tem mais de p_horas (ou nunca foi feito) */
  procedure garantir (p_cod_req number, p_horas number default 12);
  /* onde fica a vaga (para conferencia): latitude, longitude, precisao e descricao */
  procedure ponto_vaga (p_cod_req number, o_lat out number, o_lon out number, o_prec out varchar2, o_desc out varchar2);
  function  km (p_lat1 number, p_lon1 number, p_lat2 number, p_lon2 number) return number;
  /* JSON para a tela: os melhores candidatos com os itens (apex_json) */
  function  ranking_json (p_cod_req number, p_limite number default 50, p_inicio number default 1) return clob;
  /* rotina noturna: reclassifica o que mudou e recalcula as vagas abertas */
  procedure rotina_noturna;
end ont_aderencia;
/

create or replace package body ont_aderencia as

  c_raio_terra constant number := 6371.0088;

  function km (p_lat1 number, p_lon1 number, p_lat2 number, p_lon2 number) return number is
    v_pi constant number := acos(-1);
  begin
    if p_lat1 is null or p_lon1 is null or p_lat2 is null or p_lon2 is null then return null; end if;
    return 2 * c_raio_terra * asin(least(1, sqrt(
             power(sin((p_lat2 - p_lat1) * v_pi / 360), 2)
           + cos(p_lat1 * v_pi / 180) * cos(p_lat2 * v_pi / 180) * power(sin((p_lon2 - p_lon1) * v_pi / 360), 2))));
  end km;

  procedure ponto_vaga (p_cod_req number, o_lat out number, o_lon out number, o_prec out varchar2, o_desc out varchar2) is
  begin
    /* 1. CEP do local de trabalho com coordenada propria */
    begin
      select g.latitude, g.longitude, 'CEP', 'CEP ' || lpad(l.cep, 5, '0') || '-' || lpad(l.complemento_cep, 3, '0')
        into o_lat, o_lon, o_prec, o_desc
        from requisicao r
        join local_trab l on l.cod_local_trab = r.cod_local_trab
        join ont_geo_cep g on g.cep = l.cep and g.complemento_cep = l.complemento_cep
       where r.cod_req = p_cod_req and rownum = 1;
      return;
    exception when no_data_found then null;
    end;
    /* 2. municipio do CEP do local de trabalho */
    begin
      select g.latitude, g.longitude, 'MUNICIPIO_CEP', g.nome || '/' || g.uf
        into o_lat, o_lon, o_prec, o_desc
        from requisicao r
        join local_trab l on l.cod_local_trab = r.cod_local_trab
        join tabela_cep tc on tc.cep = l.cep and tc.complemento_cep = l.complemento_cep
        join ont_municipio_geo g on (g.cod_ibge7 = tc.cod_mun_ibge or g.cod_ibge6 = tc.cod_mun_ibge)
       where r.cod_req = p_cod_req and rownum = 1;
      return;
    exception when no_data_found then null;
    end;
    /* 3. cidade/UF do local de trabalho pelo nome */
    begin
      select g.latitude, g.longitude, 'MUNICIPIO_NOME', g.nome || '/' || g.uf
        into o_lat, o_lon, o_prec, o_desc
        from requisicao r
        join local_trab l on l.cod_local_trab = r.cod_local_trab
        join ont_municipio_geo g on g.nome_norm = trim(regexp_replace(ont_texto.sem_acento(l.cidade), '[^a-z0-9]+', ' '))
                                and g.uf = upper(trim(l.uf))
       where r.cod_req = p_cod_req and rownum = 1;
      return;
    exception when no_data_found then null;
    end;
    /* 4. municipio da filial (codigo RAIS/IBGE) */
    begin
      select g.latitude, g.longitude, 'MUNICIPIO_FILIAL', g.nome || '/' || g.uf
        into o_lat, o_lon, o_prec, o_desc
        from requisicao r
        join filiais f on f.cod_empresa = r.cod_empresa and f.cod_filial = r.cod_filial
        join ont_municipio_geo g on (g.cod_ibge7 = f.cod_municipio_rais or g.cod_ibge6 = f.cod_municipio_rais)
       where r.cod_req = p_cod_req and rownum = 1;
    exception when no_data_found then null;
    end;
  end ponto_vaga;

  procedure calcular (p_cod_req number) is
    v_inicio        timestamp := systimestamp;
    v_excluidos     varchar2(500)  := ',' || replace(nvl(ont_ontologia.cfg('STATUS_EXCLUIDOS'), '#NENHUM#'), ' ') || ',';
    v_amplo         number := nvl(ont_ontologia.cfg_num('FATOR_AMPLO'), 0.5);
    v_nao_concl     number := nvl(ont_ontologia.cfg_num('FATOR_NAO_CONCLUIDO'), 0.5);
    v_nivel_abaixo  number := nvl(ont_ontologia.cfg_num('FATOR_NIVEL_ABAIXO'), 0.6);
    v_inst_abaixo   number := nvl(ont_ontologia.cfg_num('INSTRUCAO_UM_ABAIXO'), 0.5);
    v_idioma_abaixo number := nvl(ont_ontologia.cfg_num('IDIOMA_NIVEL_ABAIXO'), 0.5);
    v_ideal         number := nvl(ont_ontologia.cfg_num('RAIO_IDEAL_KM'), 10);
    v_maximo        number := nvl(ont_ontologia.cfg_num('RAIO_MAXIMO_KM'), 60);
    v_rota          number := nvl(ont_ontologia.cfg_num('FATOR_ROTA'), 1.25);
    v_parciais      varchar2(500)  := ',' || replace(nvl(ont_ontologia.cfg('MODALIDADES_PARCIAIS'), '#NENHUM#'), ' ') || ',';
    v_fator_parcial number := nvl(ont_ontologia.cfg_num('FATOR_PARCIAL'), 0.5);
    v_sem_dado      varchar2(10)   := nvl(ont_ontologia.cfg('DISTANCIA_SEM_DADO'), 'NEUTRO');
    v_pcd_modo      varchar2(20)   := nvl(ont_ontologia.cfg('PCD_MODO'), 'ELIMINATORIO');
    v_pcd_outro     number := nvl(ont_ontologia.cfg_num('PCD_TIPO_DIFERENTE'), 0.5);
    v_tolerancia    number := nvl(ont_ontologia.cfg_num('SALARIO_TOLERANCIA'), 0.2);
    v_lat number; v_lon number; v_prec varchar2(20); v_desc varchar2(150);
    v_rf varchar2(1); v_ra varchar2(1); v_rv varchar2(1); v_rm varchar2(1); v_rmu varchar2(1);
    v_tem_pcd number;
    v_tipos_req number;
    v_n number;
  begin
    if v_maximo <= v_ideal then v_maximo := v_ideal + 1; end if;
    ont_ontologia.limpar_cache;   -- configuracao e vocabulario atuais (sessoes do APEX sao reaproveitadas)
    ont_ontologia.classificar_requisicao(p_cod_req);
    delete from ont_aderencia_item where cod_req = p_cod_req;
    delete from ont_aderencia where cod_req = p_cod_req;

    /* -- INSTRUCAO ----------------------------------------------------------------------- */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, evidencia)
    select i.cod_req, c.cod_candidato, i.seq, i.criterio, i.texto, i.exige,
           case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           case when i.nivel_ordem is null then case when to_char(c.instrucao) = i.codigo then 1 else 0 end
                when oc.ordem is null then 0
                when oc.ordem >= i.nivel_ordem then 1
                when oc.ordem >= i.nivel_ordem - 1 then v_inst_abaixo
                else 0 end,
           nvl(oc.nome, to_char(unistr('Instru\00E7\00E3o n\00E3o informada')))
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.* from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)) c
      left join ont_instrucao_ordem oc on oc.cod = to_char(c.instrucao)
     where i.cod_req = p_cod_req and i.criterio = 'INSTRUCAO';

    /* -- FORMACAO, CURSO, CONHECIMENTO, EXPERIENCIA -------------------------------------- */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, evidencia)
    with req as (
           select * from ont_req_item
            where cod_req = p_cod_req and criterio in ('FORMACAO', 'CURSO', 'CONHECIMENTO', 'EXPERIENCIA')),
         viz as (
           select r.seq, r.conceito_id conceito, 1 afin from req r where r.conceito_id is not null
           union all
           select r.seq, f.conceito_id, 1 from req r join ont_conceito_fecho f on f.ancestral_id = r.conceito_id
           union all
           select r.seq, f.ancestral_id, v_amplo from req r join ont_conceito_fecho f on f.conceito_id = r.conceito_id
           union all
           select r.seq, x.alvo_id, x.peso from req r join ont_relacao x on x.conceito_id = r.conceito_id and x.tipo = 'RELACIONADO'
           union all
           select r.seq, x.conceito_id, x.peso from req r join ont_relacao x on x.alvo_id = r.conceito_id and x.tipo = 'RELACIONADO'),
         viz1 as (select seq, conceito, max(afin) afin from viz group by seq, conceito),
         evid as (
           /* pelo conceito */
           select r.seq, l.cod_candidato, l.texto, v.afin
                  * case when r.criterio in ('FORMACAO', 'CURSO') and l.concluido = 'N' then v_nao_concl else 1 end
                  * case when r.criterio = 'CONHECIMENTO' and l.nivel_ordem is not null and r.nivel_ordem is not null
                              and l.nivel_ordem < r.nivel_ordem then v_nivel_abaixo else 1 end nota
             from req r
             join viz1 v on v.seq = r.seq
             join ont_cand_conceito cc on cc.conceito_id = v.conceito
             join ont_cand_linha l on l.id = cc.linha_id
             join ont_criterio_origem o on o.criterio = r.criterio and o.origem = l.origem
           union all
           /* requisito sem conceito: pelo texto */
           select r.seq, l.cod_candidato, l.texto, 1
                  * case when r.criterio in ('FORMACAO', 'CURSO') and l.concluido = 'N' then v_nao_concl else 1 end
                  * case when r.criterio = 'CONHECIMENTO' and l.nivel_ordem is not null and r.nivel_ordem is not null
                              and l.nivel_ordem < r.nivel_ordem then v_nivel_abaixo else 1 end
             from req r
             join ont_criterio_origem o on o.criterio = r.criterio
             join ont_cand_linha l on l.origem = o.origem
            where r.conceito_id is null and r.texto_norm is not null
              and exists (select 1 from ont_cand_linha_token lt, table(ont_texto.tokens(r.texto_norm)) rt
                           where lt.linha_id = l.id and lt.p3 = rt.p3)
              and ont_texto.contem(l.texto_norm, r.texto_norm) = 1),
         melhor as (
           select seq, cod_candidato, max(nota) nota,
                  max(texto) keep (dense_rank first order by nota desc) texto
             from evid group by seq, cod_candidato)
    select p_cod_req, c.cod_candidato, r.seq, r.criterio, r.texto, r.exige,
           case r.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           round(least(nvl(m.nota, 0), 1), 3), m.texto
      from req r
      join ont_peso pe on pe.criterio = r.criterio and pe.ativo = 'S'
      cross join (select c.cod_candidato from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)) c
      left join melhor m on m.seq = r.seq and m.cod_candidato = c.cod_candidato;

    /* -- TEMPO --------------------------------------------------------------------------- */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, valor, evidencia)
    select i.cod_req, c.cod_candidato, i.seq, i.criterio, i.texto, i.exige,
           case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           round(least(nvl(k.anos_experiencia, 0) / i.valor_num, 1), 3),
           k.anos_experiencia,
           case when k.anos_experiencia is null then 'Sem empregos com datas no cadastro'
                else trim(to_char(k.anos_experiencia, '990D0', 'NLS_NUMERIC_CHARACTERS='',.''')) || to_char(unistr(' anos de experi\00EAncia somados')) end
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.cod_candidato from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0) c
      join ont_cand_controle k on k.cod_candidato = c.cod_candidato
     where i.cod_req = p_cod_req and i.criterio = 'TEMPO' and i.valor_num > 0;

    /* -- IDIOMA -------------------------------------------------------------------------- */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, evidencia)
    with req as (select * from ont_req_item where cod_req = p_cod_req and criterio = 'IDIOMA'),
         cand as (select c.cod_candidato, c.cod_empresa from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)),
         evid as (
           select r.seq, c.cod_candidato,
                  max(case when r.nivel_ordem is null then 1
                           when o.ordem is null then 0.7
                           when o.ordem >= r.nivel_ordem then 1
                           else v_idioma_abaixo end) nota,
                  max(im.descricao || case when n.descricao is not null then to_char(unistr(' \00B7 ')) || n.descricao end) texto
             from req r
             join idioma_candidato ic on to_char(ic.cod_idioma) = r.codigo
             join cand c on c.cod_candidato = ic.cod_candidato and c.cod_empresa = ic.cod_empresa
             join idioma im on im.codigo = ic.cod_idioma
             left join nivel_conhecimento n on n.codigo = ic.cod_nivel_conh
             left join ont_nivel_ordem o on o.codigo = to_char(ic.cod_nivel_conh)
            group by r.seq, c.cod_candidato)
    select p_cod_req, c.cod_candidato, r.seq, r.criterio, r.texto, r.exige,
           case r.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           nvl(e.nota, 0), e.texto
      from req r
      join ont_peso pe on pe.criterio = r.criterio and pe.ativo = 'S'
      cross join cand c
      left join evid e on e.seq = r.seq and e.cod_candidato = c.cod_candidato;

    /* -- DISTANCIA (so existe o item quando a modalidade pede presenca) ------------------ */
    ponto_vaga(p_cod_req, v_lat, v_lon, v_prec, v_desc);
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, valor, evidencia)
    select i.cod_req, x.cod_candidato, i.seq, i.criterio,
           i.texto || case when v_desc is not null then ' (' || v_desc || ')' end, i.exige,
           case when v_lat is null then 0
                when x.dist is null and v_sem_dado = 'NEUTRO' then 0
                else (case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end)
                     * case when instr(v_parciais, ',' || i.codigo || ',') > 0 then v_fator_parcial else 1 end
           end,
           case when x.dist is null then 0
                when x.dist <= v_ideal then 1
                when x.dist >= v_maximo then 0
                else round((v_maximo - x.dist) / (v_maximo - v_ideal), 3) end,
           round(x.dist, 1),
           case when v_lat is null then to_char(unistr('Local da vaga sem CEP/cidade reconhecida \2014 crit\00E9rio n\00E3o aplicado'))
                when x.dist is null then to_char(unistr('Endere\00E7o do candidato n\00E3o reconhecido (CEP/cidade)'))
                else to_char(unistr('\2248 ')) || trim(to_char(round(x.dist), '99990')) || to_char(unistr(' km \2014 mora em ')) || x.geo_descricao
                     || case when x.geo_precisao like 'MUNICIPIO%' then to_char(unistr(' (dist\00E2ncia entre munic\00EDpios)')) end end
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.cod_candidato, k.geo_descricao, k.geo_precisao,
                         ont_aderencia.km(k.latitude, k.longitude, v_lat, v_lon) * v_rota dist
                    from ont_v_candidato c
                    join ont_cand_controle k on k.cod_candidato = c.cod_candidato
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0) x
     where i.cod_req = p_cod_req and i.criterio = 'DISTANCIA';

    /* -- PCD (so em vaga PCD) ------------------------------------------------------------ */
    select max(upper(substr(to_char(r.rais_ind_def_fisico), 1, 1))), max(upper(substr(to_char(r.rais_ind_def_auditiva), 1, 1))),
           max(upper(substr(to_char(r.rais_ind_def_visual), 1, 1))), max(upper(substr(to_char(r.rais_ind_def_mental), 1, 1))),
           max(upper(substr(to_char(r.rais_ind_def_multipla), 1, 1)))
      into v_rf, v_ra, v_rv, v_rm, v_rmu
      from requisicao r where r.cod_req = p_cod_req;
    v_tipos_req := case when 'S' in (v_rf, v_ra, v_rv, v_rm, v_rmu) then 1 else 0 end;
    select count(*) into v_tem_pcd from ont_v_candidato where ind_def_fis is not null and rownum = 1;
    if v_tem_pcd = 0 then
      ont_ontologia.log('calcular', 'requisicao ' || p_cod_req || ': cadastro sem IND_DEF_FIS - criterio PCD nao aplicado');
    end if;
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, evidencia)
    select i.cod_req, c.cod_candidato, i.seq, i.criterio,
           i.texto || case when v_tipos_req = 1 then ' (' ||
             rtrim(case when v_rf = 'S' then to_char(unistr('f\00EDsica, ')) end || case when v_ra = 'S' then 'auditiva, ' end ||
                   case when v_rv = 'S' then 'visual, ' end || case when v_rm = 'S' then 'intelectual, ' end ||
                   case when v_rmu = 'S' then to_char(unistr('m\00FAltipla, ')) end, ', ') || ')' end,
           i.exige, case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           case when nvl(upper(substr(to_char(c.ind_def_fis), 1, 1)), 'N') <> 'S' then 0
                when v_tipos_req = 0 then 1
                when (v_rf = 'S' and upper(substr(to_char(c.def_fisica), 1, 1)) = 'S') or (v_ra = 'S' and upper(substr(to_char(c.def_auditiva), 1, 1)) = 'S')
                  or (v_rv = 'S' and upper(substr(to_char(c.def_visual), 1, 1)) = 'S') or (v_rm = 'S' and upper(substr(to_char(c.def_mental), 1, 1)) = 'S')
                  or (v_rmu = 'S' and upper(substr(to_char(c.def_multipla), 1, 1)) = 'S') then 1
                else v_pcd_outro end,
           case when nvl(upper(substr(to_char(c.ind_def_fis), 1, 1)), 'N') <> 'S' then to_char(unistr('N\00E3o \00E9 PCD'))
                else 'PCD' || nullif(' (' || rtrim(
                       case when upper(substr(to_char(c.def_fisica), 1, 1)) = 'S' then to_char(unistr('f\00EDsica, ')) end || case when upper(substr(to_char(c.def_auditiva), 1, 1)) = 'S' then 'auditiva, ' end ||
                       case when upper(substr(to_char(c.def_visual), 1, 1)) = 'S' then 'visual, ' end || case when upper(substr(to_char(c.def_mental), 1, 1)) = 'S' then 'intelectual, ' end ||
                       case when upper(substr(to_char(c.def_multipla), 1, 1)) = 'S' then to_char(unistr('m\00FAltipla, ')) end, ', ') || ')', ' ()') end
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.* from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)) c
     where i.cod_req = p_cod_req and i.criterio = 'PCD' and v_tem_pcd > 0;

    /* -- CARGO_PRETENDIDO, LOCAL_PRETENDIDO (so para quem informou) --------------------- */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, evidencia)
    select i.cod_req, c.cod_candidato, i.seq, i.criterio, i.texto, i.exige,
           case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           case when case i.criterio when 'CARGO_PRETENDIDO' then to_char(c.cargo_pretendido) else to_char(c.local_pretendido) end = i.codigo
                then 1 else 0 end,
           case when case i.criterio when 'CARGO_PRETENDIDO' then to_char(c.cargo_pretendido) else to_char(c.local_pretendido) end = i.codigo
                then 'Indicou este ' || case i.criterio when 'CARGO_PRETENDIDO' then 'cargo' else 'local' end || ' no cadastro'
                else 'Indicou outro ' || case i.criterio when 'CARGO_PRETENDIDO' then 'cargo' else 'local' end end
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.* from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)) c
     where i.cod_req = p_cod_req and i.criterio in ('CARGO_PRETENDIDO', 'LOCAL_PRETENDIDO')
       and case i.criterio when 'CARGO_PRETENDIDO' then to_char(c.cargo_pretendido) else to_char(c.local_pretendido) end is not null;

    /* -- SALARIO (so se ambos informados) ------------------------------------------------ */
    insert into ont_aderencia_item (cod_req, cod_candidato, seq, criterio, requisito, exige, peso, nota, valor, evidencia)
    select i.cod_req, c.cod_candidato, i.seq, i.criterio, i.texto, i.exige,
           case i.exige when 'S' then pe.peso_exigido else pe.peso_desejavel end,
           case when c.salario_pretendido <= i.valor_num then 1
                when v_tolerancia <= 0 or c.salario_pretendido >= i.valor_num * (1 + v_tolerancia) then 0
                else round((i.valor_num * (1 + v_tolerancia) - c.salario_pretendido) / (i.valor_num * v_tolerancia), 3) end,
           c.salario_pretendido,
           'Pretende R$ ' || trim(to_char(c.salario_pretendido, '999G999G990D00', 'NLS_NUMERIC_CHARACTERS='',.''')) ||
           to_char(unistr(' (vaga at\00E9 R$ ')) || trim(to_char(i.valor_num, '999G999G990D00', 'NLS_NUMERIC_CHARACTERS='',.''')) || ')'
      from ont_req_item i
      join ont_peso pe on pe.criterio = i.criterio and pe.ativo = 'S'
      cross join (select c.* from ont_v_candidato c
                   where instr(v_excluidos, ',' || nvl(to_char(c.status_candidato), '#NULO#') || ',') = 0
                     and exists (select 1 from ont_cand_controle k where k.cod_candidato = c.cod_candidato)) c
     where i.cod_req = p_cod_req and i.criterio = 'SALARIO' and i.valor_num > 0
       and c.salario_pretendido > 0;

    /* -- A NOTA FINAL -------------------------------------------------------------------- */
    insert into ont_aderencia (cod_req, cod_candidato, pct, pontos, maximo, exig_total, exig_ok, eliminado, motivo,
                               distancia_km, geo_precisao, calculado_em)
    select p_cod_req, a.cod_candidato,
           nvl(round(100 * sum(a.peso * a.nota) / nullif(sum(a.peso), 0), 1), 0),
           sum(a.peso * a.nota), sum(a.peso),
           count(case when a.exige = 'S' and a.peso > 0 then 1 end),
           count(case when a.exige = 'S' and a.peso > 0 and a.nota >= 0.999 then 1 end),
           case when v_pcd_modo = 'ELIMINATORIO' and max(case when a.criterio = 'PCD' and a.nota = 0 then 1 else 0 end) = 1
                then 'S' else 'N' end,
           case when v_pcd_modo = 'ELIMINATORIO' and max(case when a.criterio = 'PCD' and a.nota = 0 then 1 else 0 end) = 1
                then to_char(unistr('Vaga PCD e o candidato n\00E3o \00E9 PCD')) end,
           max(case when a.criterio = 'DISTANCIA' then a.valor end),
           max(k.geo_precisao),
           sysdate
      from ont_aderencia_item a
      left join ont_cand_controle k on k.cod_candidato = a.cod_candidato
     where a.cod_req = p_cod_req
     group by a.cod_candidato;
    v_n := sql%rowcount;
    ont_ontologia.log('calcular', to_char(unistr('requisi\00E7\00E3o ')) || p_cod_req || to_char(unistr(' \00B7 vaga em ')) || nvl(v_desc, '?') || ' (' || nvl(v_prec, 'sem local') || ')', v_n, v_inicio);
  end calcular;

  procedure calcular_processo (p_cod_processo number) is
  begin
    for r in (select cod_req from ps_processo_seletivo where cod_processo = p_cod_processo) loop
      calcular(r.cod_req);
    end loop;
  end calcular_processo;

  procedure garantir (p_cod_req number, p_horas number default 12) is
    v_quando date;
  begin
    select max(calculado_em) into v_quando from ont_aderencia where cod_req = p_cod_req;
    if v_quando is null or v_quando < sysdate - p_horas / 24 then calcular(p_cod_req); end if;
  end garantir;

  function ranking_json (p_cod_req number, p_limite number default 50, p_inicio number default 1) return clob is
    v_out clob;
  begin
    apex_json.initialize_clob_output;
    apex_json.open_object;
    apex_json.write('cod_req', p_cod_req);
    apex_json.open_array('candidatos');
    for a in (select * from (select x.*, row_number() over (order by eliminado, pct desc, exig_ok desc, distancia_km nulls last, cod_candidato) pos
                               from ont_aderencia x where cod_req = p_cod_req)
               where pos between p_inicio and p_inicio + p_limite - 1 order by pos) loop
      apex_json.open_object;
      apex_json.write('pos', a.pos);
      apex_json.write('cod_candidato', a.cod_candidato);
      apex_json.write('pct', a.pct);
      apex_json.write('exig_ok', a.exig_ok);
      apex_json.write('exig_total', a.exig_total);
      apex_json.write('eliminado', a.eliminado = 'S');
      apex_json.write('motivo', a.motivo);
      apex_json.write('distancia_km', a.distancia_km);
      apex_json.open_array('itens');
      for i in (select * from ont_aderencia_item where cod_req = p_cod_req and cod_candidato = a.cod_candidato order by seq) loop
        apex_json.open_object;
        apex_json.write('criterio', i.criterio);
        apex_json.write('requisito', i.requisito);
        apex_json.write('exige', i.exige = 'S');
        apex_json.write('peso', i.peso);
        apex_json.write('nota', i.nota);
        apex_json.write('evidencia', i.evidencia);
        apex_json.close_object;
      end loop;
      apex_json.close_array;
      apex_json.close_object;
    end loop;
    apex_json.close_array;
    apex_json.close_object;
    v_out := apex_json.get_clob_output;
    apex_json.free_output;
    return v_out;
  end ranking_json;

  procedure rotina_noturna is
    v_ultima date := to_date(ont_ontologia.cfg('ULTIMA_ROTINA'), 'yyyy-mm-dd hh24:mi:ss');
    v_agora  date := sysdate;
  begin
    ont_ontologia.recalcular_fecho;
    /* a ontologia ganhou termos desde a ultima rotina: os conceitos de TODAS as linhas sao refeitos */
    if v_ultima is not null then
      declare n number;
      begin
        select count(*) into n from ont_termo where criado_em >= v_ultima - 1/24;
        if n > 0 then ont_ontologia.reclassificar_conceitos; commit; end if;
      end;
    end if;
    /* p_desde nulo = todos (primeira vez); depois, so quem mudou desde a ultima rotina (com folga de 1 h) */
    ont_ontologia.classificar_candidatos(p_desde => case when v_ultima is not null then v_ultima - 1/24 end);
    commit;
    for r in (select distinct r.cod_req
                from requisicao r join ps_processo_seletivo ps on ps.cod_req = r.cod_req
               where r.cod_sit_req = 5) loop
      begin
        calcular(r.cod_req);
        commit;
      exception when others then
        rollback;
        ont_ontologia.log('rotina_noturna', to_char(unistr('requisi\00E7\00E3o ')) || r.cod_req || ': ' || sqlerrm);
      end;
    end loop;
    /* resultados de vagas que nao estao mais abertas */
    delete from ont_aderencia_item a where not exists (select 1 from requisicao r where r.cod_req = a.cod_req and r.cod_sit_req = 5);
    delete from ont_aderencia a where not exists (select 1 from requisicao r where r.cod_req = a.cod_req and r.cod_sit_req = 5);
    merge into ont_config c using (select 'ULTIMA_ROTINA' chave from dual) x on (c.chave = x.chave)
     when matched then update set valor = to_char(v_agora, 'yyyy-mm-dd hh24:mi:ss')
     when not matched then insert (chave, valor, descricao) values ('ULTIMA_ROTINA', to_char(v_agora, 'yyyy-mm-dd hh24:mi:ss'), 'preenchido pela rotina noturna');
    commit;
    ont_ontologia.limpar_cache;
  end rotina_noturna;

end ont_aderencia;
/
show errors package ont_aderencia
show errors package body ont_aderencia

prompt 05_ont_aderencia: pacote ONT_ADERENCIA criado.
