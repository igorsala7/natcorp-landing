prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.10.04'
,p_release=>'19.2.0.00.18'
,p_default_workspace_id=>1656634830766073
,p_default_application_id=>9110
,p_default_id_offset=>545535859522206724
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9110 - Recrutamento e Seleção - Menu
--
-- Application Export:
--   Application:     9110
--   Name:            Recrutamento e Seleção - Menu
--   Date and Time:   21:02 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 182
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00182
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>182);
end;
/
prompt --application/pages/page_00182
begin
wwv_flow_api.create_page(
 p_id=>182
,p_user_interface_id=>wwv_flow_api.id(34420079617768074974)
,p_name=>'Candidatos'
,p_step_title=>'Candidatos'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function save_checkbox_state() {',
'  var params = $(''.checkbox_item'').map(function() {',
'                 let $chk = $(this)',
'                 return {"id": $chk.val(), "checked": $chk.prop(''checked'').toString()}',
'               }).get();',
'',
'  if (params && params.length) {',
'    //var pWait = apex.widget.waitPopup()',
'    apex.server.process(''salvar_ids'', {',
'      x01: JSON.stringify(params)',
'    }, {',
'      dataType: "text"',
'    }).done(function(text) {',
'      //console.log(''foi:'' + text);',
'    }).fail(function() {',
'      alert(''Erro ao checar item!'');',
'    }).always(function() {',
'      //pWait.remove();',
'      $(''#candidatos_externos'').trigger(''apexafterrefresh'')',
'      $(''#candidatos_internos'').trigger(''apexafterrefresh'')',
'    });',
'  }',
'}'))
,p_javascript_code_onload=>'$(document).on(''change'', ''.checkbox_item'', apex.util.debounce(save_checkbox_state, 800))'
,p_css_file_urls=>'#WORKSPACE_IMAGES#natcorp_iframe_apex.css'
,p_inline_css=>'.nobr{white-space:nowrap;}'
,p_step_template=>wwv_flow_api.id(34420037505900074803)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'SUPORTE_NATCORP'
,p_last_upd_yyyymmddhh24miss=>'20260602115028'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8415090079819324871)
,p_plug_name=>'INCLUIR EM PROCESSO SELETIVO'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17046056391182373984)
,p_plug_name=>'Candidatos Selecionados'
,p_region_name=>'candidatos_selecionados'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34420053100889074878)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.ps,',
'       i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa,''S'')) empresa,',
'       i.cod_filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.cod_filial)) filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa,i.cod_ccusto)) ccusto,',
'       i.cod_unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.cod_unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cod_vaga cod_vaga,',
'       i.cod_cargo||'' - ''||initcap(fnct_nome_cargo(i.cod_cargo)) cargo,',
'       initcap(TRIM(p.nome)) nome,',
'       initcap(TRIM(p.nome_social)) nome_social,',
'       c.dt_contratacao,',
'       fnct_sit_candidato (p.cod_candidato, i.cod_req) STATUS_CANDIDATO,',
'       fnct_valida_doc_cand(p.empresa, p.cod_candidato) Documentos,',
unistr('       fnct_valida_cad_benef_cand(p.empresa, p.cod_candidato) Benef\00EDcios,'),
'       p.endereco, ',
'       p.bairro, ',
'       p.cidade,',
'       p.uf,',
'       FLOOR(months_between(sysdate,p.Dt_nac)/12) idade, ',
'       decode(p.sexo,''M'',''Masculino'',''F'',''Feminino'') sexo, ',
'       (select g.nome from genero_sexual g where g.cod = p.genero) genero,',
'       ''(''||p.ddd_recados||'') ''||p.telefone_recados telefone_recados, ',
'       ''(''||p.ddd_celular||'') ''||p.telefone_celular celular, ',
'       p.e_mail e_mail_pessoal,',
'       case when p.url_linkedin is not null then',
'         ''<a href="'' || p.url_linkedin || ''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'          aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'          width="20" height="20">',
'            <path data-name="layer1"',
'            fill="#0077b7" d="M1.15 21.7h13V61h-13zm46.55-1.3c-5.7 0-9.1 2.1-12.7 6.7v-5.4H22V61h13.1V39.7c0-4.5 2.3-8.9 7.5-8.9s8.3 4.4 8.3 8.8V61H64V38.7c0-15.5-10.5-18.3-16.3-18.3zM7.7 2.6C3.4 2.6 0 5.7 0 9.5s3.4 6.9 7.7 6.9 7.7-3.1 7.7-6.9S12 2.6'
||' 7.7 2.6z"></path>',
'          </svg></a>''',
'       end as url_linkedin,',
'       CASE WHEN p.CNH IS NOT NULL THEN ''Categoria '' || p.categoria_cnh end CNH,',
'       substr(desc_qualific_func,0,200)||''...'' qualificacao,  ',
'       --',
'       (select nome',
'          from instrucao f',
'         where p.instrucao = f.cod) grau_instrucao,',
unistr('       (select listagg(''- '' || initcap(fe.descricao) || '' - Entidade: '' || initcap(fe.entidade) || '' - '' || case when fe.status = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cod_formacao_escolar)',
'          from formacao_escolar_candidato fe',
'         where fe.cod_empresa   = p.empresa',
'           and fe.cod_candidato = p.cod_candidato)||''<br><br>''||replace(p.formacao_escolar_obs,chr(10),''<br>'') as formacao,',
'      -- formacao_escolar_obs,',
unistr('       /*(select listagg(''Curso: '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br>'')'),
'               within group (order by cc.data_inic desc)',
'          from (',
'           select initcap(cc.descricao) as descricao,',
'                  initcap(cc.local) as local,',
'                  cc.conclusao,',
'                  cc.data_inic,',
'                  row_number() over (order by cc.data_inic desc) rn',
'              from curso_candidato cc',
'             where cc.cod_empresa   = p.empresa',
'               and cc.cod_candidato = p.cod_candidato',
'          ) cc',
'         where rn <= 10 -- Limite',
'       ) as cursos,*/',
unistr('       (select listagg(''- '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cc.data_inic desc)',
'          from curso_candidato cc',
'         where cc.cod_empresa   = p.empresa',
'           and cc.cod_candidato = p.cod_candidato',
'           and rownum <= 10 -- Limite',
'       )||''<br><br>''||replace(p.curso_obs,chr(10),''<br>'') as cursos,',
'      -- p.curso_obs,',
unistr('       (select listagg(''- '' ||initcap(im.descricao) || '' - N\00EDvel: '' || initcap(ni.descricao), ''<br>'')'),
'               within group (order by initcap(im.descricao))',
'          from idioma_candidato   ic,',
'               idioma             im,',
'               nivel_conhecimento ni',
'         where ic.cod_empresa    = p.empresa',
'           and ic.cod_candidato  = p.cod_candidato',
'           and ic.cod_idioma     = im.codigo',
'           and ic.cod_nivel_conh = ni.codigo',
'       )||''<br><br>''||replace(p.idioma_obs,chr(10),''<br>'') as idiomas,',
'      -- p.idioma_obs,',
unistr('       (select listagg(''- '' ||initcap(hb.descricao) || '' - N\00EDvel: '' || initcap(nh.descricao), ''<br>'')'),
'               within group (order by initcap(hb.descricao))',
'          from habilidade_candidato hc,',
'               habilidade           hb,',
'               nivel_conhecimento   nh',
'         where hc.cod_empresa    = p.empresa',
'           and hc.cod_candidato  = p.cod_candidato',
'           and hc.cod_habilidade = hb.codigo',
'           and hc.cod_nivel_conh = nh.codigo',
'       )||''<br><br>''||replace(p.habilidade_obs,chr(10),''<br>'') as habilidade,',
'      -- habilidade_obs,',
unistr('       (select listagg(''- '' ||initcap(a.nome_empresa)||'' | ''||a.cargo||'' ''||a.data_adm_emp||'' \00E0 ''||a.data_desl_emp||''<br>'')'),
'        within group (order by a.data_adm_emp desc)',
'          from empregos_anteriores a',
'         where a.nome_empresa is not null',
'           and a.cod_candidato = p.cod_candidato) empregos_anteriores,',
'       p.empresa cod_empresa,',
'       /*',
'       CASE WHEN :P_BASE in (''STEFANINI'') THEN',
'       ''f?p=CONHECENDO_VOCE_''||:P_BASE||'':1:''||:APP_SESSION||''::NO:RP,1:P1_USUARIO,P1_EMPRESA,P1_CANDIDATO,P1_EMPRESA_USER,P1_MATRICULA_USER,P1_VAGA,P1_FILIAL_VAGA,P1_EMPRESA_VAGA,P1_DT_CONTRATACAO:''||:P_USUARIO||'',''||P."EMPRESA"||'',''||P."COD_CANDIDA'
||'TO"||'',''||:P_EMPRESA_GESTOR||'',''||:P_MATRICULA_USER||'',''||C.COD_VAGA||'',''||C.COD_FILIAL||'',''||C.COD_EMPRESA||'',''||C.DT_CONTRATACAO ',
'       ELSE',
'       ''f?p=CV_''||:P_BASE||'':1:''||:APP_SESSION||''::::P_USUARIO,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_VAGA,P_FILIAL_VAGA,P_EMPRESA_VAGA,P_DT_CONTRATACAO:''||:P_USUARIO||'',''||P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||:P_EMPRESA_GESTOR|'
||'|'',''||:P_MATRICULA_USER||'',''||C.COD_VAGA||'',''||C.COD_FILIAL||'',''||C.COD_EMPRESA||'',''||C.DT_CONTRATACAO ',
'       END LINK,',
'       */',
'        ',
'apex_page.get_url (',
'         p_application => ''RS_PRC_''||:P_BASE,',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO,P39_VAGA,P39_FILIAL_VAGA,P39_EMPRESA_VAGA,P39_DT_CONTRATACAO,P39_SELECIONADO'',',
'         p_values      => P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||C.COD_VAGA||'',''||C.COD_FILIAL||'',''||C.COD_EMPRESA||'',''||C.DT_CONTRATACAO||'',''||''S'',',
'         p_clear_cache => 39',
'        ) LINK,',
'       CASE WHEN :P_BASE in (''STEFANINI'') THEN',
'       ''f?p=CONHECENDO_VOCE_''||:P_BASE||'':1:''||:APP_SESSION||''::NO:RP,1:P1_USUARIO,P1_EMPRESA,P1_CANDIDATO,P1_EMPRESA_USER,P1_MATRICULA_USER,P1_VAGA,P1_FILIAL_VAGA,P1_EMPRESA_VAGA,P1_DT_CONTRATACAO:''||:P_USUARIO||'',''||P."EMPRESA"||'',''||P."COD_CANDIDA'
||'TO"||'',''||:P_EMPRESA_GESTOR||'',''||:P_MATRICULA_USER||'',''||C.COD_VAGA||'',''||C.COD_FILIAL||'',''||C.COD_EMPRESA||'',''||C.DT_CONTRATACAO ',
'       ELSE',
'       apex_page.get_url (',
'         p_application => ''RS_PRC_''||:P_BASE,',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO,P39_VAGA,P39_FILIAL_VAGA,P39_EMPRESA_VAGA,P39_DT_CONTRATACAO,P39_SELECIONADO'',',
'         p_values      => P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||C.COD_VAGA||'',''||C.COD_FILIAL||'',''||C.COD_EMPRESA||'',''||C.DT_CONTRATACAO||'',''||''S'',',
'         p_clear_cache => 39',
'      ) end LINK_S,',
'       p.data_cadastro,',
'       case when p.dt_atualizacao > f.dt_atualizacao then p.dt_atualizacao else f.dt_atualizacao end dt_atualizacao,',
'       (select ''<a href="f?p=&APP_ID.:1:&APP_SESSION.:APPLICATION_PROCESS=GET_UPLOAD_FILES:::GET_TIPO_ITEM,GET_EMP,GET_COD_ITEM,GET_TIPO_ARQ,GET_COD_SUB_ITEM,GET_SEQ_ITEM:''||U.TIPO_COD_ITEM||'',''||U.COD_EMPRESA||'',''||U.COD_ITEM||'',''||U.TIPO_ARQUIVO||'''
||',''||U.COD_SUB_ITEM||'',''||U.SEQ_ITEM||'':''||''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="30" height="30">',
'  <path data-name="layer2"',
'  fill="none" stroke="#202020" stroke-miterlimit="10" stroke-width="2" d="M10 2v60h44V18L38 2H10z"',
'  stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer2" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M38 2v16h16" stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer1" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M32 25v22m-7.6-9l7.6 9 7.6-9" stroke-linejoin="round"',
'  stroke-linecap="round"></path>',
'</svg></a>''',
'          from upload_files u, ',
'               tipo_arquivo_upload t',
'         where u.tipo_arquivo = t.cod',
'           and u.cod_sub_item = t.cod_tipo_sub_item',
'           and t.cod = 8',
'           and u.tipo_cod_item = ''CANDIDATO''',
'           and u.cod_empresa = p.empresa',
'           and u.cod_item = p.cod_candidato',
'           and u.seq_item = (select max(ux.seq_item) ',
'                               from upload_files ux ',
'                              where ux.tipo_cod_item = u.tipo_cod_item',
'                                and ux.cod_empresa = u.cod_empresa',
'                                and ux.cod_item = u.cod_item',
'                                and ux.cod_sub_item = u.cod_sub_item',
'                                and ux.tipo_arquivo = u.tipo_arquivo)',
'           AND ROWNUM = 1) arq_curriculo,',
'           p.cod_candidato,',
'           i.cod_sindicato||'' - ''||fnct_nome_sindicato(i.cod_empresa, i.cod_sindicato, ''S'') sindicato,',
'       CASE WHEN P.IND_DEF_FIS = ''S'' THEN '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD, ',
'       CASE WHEN p.TELEFONE_CELULAR IS NOT NULL THEN ''https://api.whatsapp.com/send?phone=55''||p.DDD_CELULAR||p.TELEFONE_CELULAR ',
'        ELSE ''https://api.whatsapp.com/send?phone=55''||P.DDD||P.TELEFONE',
'        END WHATSAPP,',
'        ''EMAIL'' EMAIL,',
'            apex_item.checkbox2 (',
'                     p_idx                      => 1,',
'                     p_value                    => P.cod_candidato,',
'                     p_attributes               => ''class="checkbox_item"'',',
'                     p_checked_values           => (select listagg (n001, '':'') within group (order by n001)',
'                                                      from apex_collections',
'                                                     where collection_name = :P183_COLLECTION_NAME),',
'                     p_checked_values_delimiter => '':''',
'                   ) as "Select"',
'  from inf_pessoais_candidato p,',
'       inf_func_candidato     f,',
'       requisicao i,',
'       CANDIDATO_APROVADO C,',
'       configuracoes s',
' where p.cod_candidato   = f.cod_candidato',
'   and p.cod_candidato = c.cod_candidato (+)',
'   AND C.COD_SOLICITACAO = i.COD_REQ (+)',
'   --',
'   and (:P182_PS               is null or p.ps = :P182_PS)',
'   and (:P182_VAGA_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_EMPRESA, '':'')) t))',
'   and (:P182_VAGA_FILIAL      is null or i.cod_filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_FILIAL, '':'')) t))',
'   and (:P182_VAGA_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_CCUSTO, '':'')) t))',
'   and (:P182_VAGA_UNIDADE_ADM is null or i.cod_unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_UNIDADE_ADM, '':'')) t))',
'   and (:P182_VAGA_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_ATIVIDADE, '':'')) t))',
'   and (:P182_VAGA_CARGO       is null or i.cod_cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_CARGO, '':'')) t))',
'   --',
'   and (:P182_PESS_IDADE_MIN    is null or p.dt_nac <= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MIN) * 365.25))',
'   and (:P182_PESS_IDADE_MAX    is null or p.dt_nac >= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MAX) * 365.25))',
'   and (:P182_PESS_COD_CANDIDATO is null or p.cod_candidato in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_PESS_COD_CANDIDATO, '':'')) t))',
'   and (:P182_PESS_NOME  is null or ((upper(p.nome) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') or (upper(p.nome_social) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') ))',
'   and (:P182_PESS_EMAIL is null or upper(p.e_mail) = upper(:P182_PESS_EMAIL))',
'   and (:P182_PESS_SEXO         is null or p.sexo = :P182_PESS_SEXO)',
'   and (:P182_PESS_ESTADO_CIVIL is null or p.estado_civil in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_PESS_ESTADO_CIVIL, '':'')) t))',
'   and (:P182_PESS_DEPENDENTE   is null or p.possui_dependente = :P182_PESS_DEPENDENTE)',
'   --',
'   and (:P182_FORM_INSTRUCAO is null or p.instrucao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_INSTRUCAO, '':'')) t))',
'   and ((:P182_FORM_DESC is null and :P182_FORM_ENTIDADE is null and :P182_FORM_TURNO is null and :P182_PESS_STATUS is null) or exists (',
'         select 1',
'           from formacao_escolar_candidato fe',
'          where fe.cod_empresa   = p.empresa',
'            and fe.cod_candidato = p.cod_candidato',
'            and ((:P182_FORM_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                          from table(apex_string.split(:P182_FORM_DESC, '':'')) t',
'                                                         where upper(fe.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_FORM_ENTIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                              from table(apex_string.split(:P182_FORM_ENTIDADE, '':'')) t',
'                                                             where upper(fe.entidade) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_FORM_TURNO    is null or fe.turno     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_TURNO, '':'')) t))',
'            and (:P182_PESS_STATUS   is null or fe.status     = :P182_PESS_STATUS)',
'       ))',
'   --',
'   and ((:P182_CURSO_DESC is null and :P182_CURSO_LOCAL is null and :P182_CURSO_CONCLUSAO is null) or exists (',
'         select 1',
'           from curso_candidato cc',
'          where cc.cod_empresa   = p.empresa',
'            and cc.cod_candidato = p.cod_candidato',
'            and ((:P182_CURSO_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                           from table(apex_string.split(:P182_CURSO_DESC, '':'')) t',
'                                                          where upper(cc.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_CURSO_LOCAL is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                            from table(apex_string.split(:P182_CURSO_LOCAL, '':'')) t',
'                                                           where upper(cc.local) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_CURSO_CONCLUSAO is null or cc.conclusao  = :P182_CURSO_CONCLUSAO)',
'       ))',
'   --',
'   and ((:P182_IDIOMA is null and :P182_IDIOMA_NIVEL is null) or exists (',
'         select 1',
'           from idioma_candidato ic',
'          where ic.cod_empresa   = p.empresa',
'            and ic.cod_candidato = p.cod_candidato',
'            and (:P182_IDIOMA       is null or ic.cod_idioma     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA, '':'')) t))',
'            and (:P182_IDIOMA_NIVEL is null or ic.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and ((:P182_HABILIDADE is null and :P182_HABILIDADE_NIVEL is null) or exists (',
'         select 1',
'           from habilidade_candidato hc',
'          where hc.cod_empresa   = p.empresa',
'            and hc.cod_candidato = p.cod_candidato',
'            and (:P182_HABILIDADE       is null or hc.cod_habilidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE, '':'')) t))',
'            and (:P182_HABILIDADE_NIVEL is null or hc.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and (:P182_RESID_UF      is null or p.uf            in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_RESID_UF, '':'')) t))',
'   and ((:P182_RESID_CIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_CIDADE, '':'')) t',
'                                                  where upper(p.cidade) like ''%''||upper(column_value)||''%''))))',
'   and ((:P182_RESID_BAIRRO is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_BAIRRO, '':'')) t',
'                                                  where upper(p.bairro) like ''%''||upper(column_value)||''%''))))',
'   and (:P182_NACIONAL_PAIS is null or p.nacionalidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_NACIONAL_PAIS, '':'')) t))',
'   --',
'   and (:P182_PCD_POSSUI IS NULL or p.ind_def_fis = :P182_PCD_POSSUI)',
'   --',
'   AND P.PS IS NOT NULL',
'   --',
'   and (((trunc(sysdate) - trunc(p.data_cadastro)) <= :p182_periodo) or (:p182_periodo = 0))',
'   and :P182_PESQUISA = ''S''',
' order by 1 desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':p182_tipo = ''S'' and :p182_Pesquisa = ''S'''
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(17046056433499373985)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Para ver os resultados, filtre as informa\00E7\00F5es.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'#LINK_S#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_detail_link_attr=>'target="_blank"'
,p_owner=>'IGOR'
,p_internal_uid=>8773938443626623530
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343679918623806106)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343680328998806107)
,p_db_column_name=>'HABILIDADE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Habilidade'
,p_column_html_expression=>'<span class="nobr">#HABILIDADE#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343680789288806108)
,p_db_column_name=>'FILIAL'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343681155700806108)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343681546126806109)
,p_db_column_name=>'LINK'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Consultar'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8049044293730478735)
,p_db_column_name=>'LINK_S'
,p_display_order=>100
,p_column_identifier=>'AW'
,p_column_label=>'Link'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343681974993806110)
,p_db_column_name=>'FORMACAO'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>unistr('Forma\00E7\00E3o')
,p_column_html_expression=>'<span class="nobr">#FORMACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343682301554806110)
,p_db_column_name=>'CURSOS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>'Cursos'
,p_column_html_expression=>'<span class="nobr">#CURSOS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343682722232806110)
,p_db_column_name=>'IDIOMAS'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>'Idiomas'
,p_column_html_expression=>'<span class="nobr">#IDIOMAS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343683167390806111)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343683544375806111)
,p_db_column_name=>'DATA_CADASTRO'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Data de Cadastro'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343683950734806113)
,p_db_column_name=>'EMPREGOS_ANTERIORES'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>'Empregos Anteriores'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343684294320806113)
,p_db_column_name=>'ARQ_CURRICULO'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>unistr('Arquivo Curr\00EDculo')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343684690755806114)
,p_db_column_name=>'CCUSTO'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>unistr('Centro de Custo (C\00E9lula)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343685189391806114)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>190
,p_column_identifier=>'R'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343685577232806115)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>200
,p_column_identifier=>'S'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343685955620806115)
,p_db_column_name=>'COD_VAGA'
,p_display_order=>210
,p_column_identifier=>'T'
,p_column_label=>unistr('C\00F3d. Vaga')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343686333132806115)
,p_db_column_name=>'CARGO'
,p_display_order=>220
,p_column_identifier=>'U'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343686783995806116)
,p_db_column_name=>'ENDERECO'
,p_display_order=>230
,p_column_identifier=>'V'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343687113870806116)
,p_db_column_name=>'BAIRRO'
,p_display_order=>240
,p_column_identifier=>'W'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343687510975806117)
,p_db_column_name=>'CIDADE'
,p_display_order=>250
,p_column_identifier=>'X'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343687976580806117)
,p_db_column_name=>'UF'
,p_display_order=>260
,p_column_identifier=>'Y'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343688365749806118)
,p_db_column_name=>'IDADE'
,p_display_order=>270
,p_column_identifier=>'Z'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343688703268806119)
,p_db_column_name=>'SEXO'
,p_display_order=>280
,p_column_identifier=>'AA'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343689043219806119)
,p_db_column_name=>'TELEFONE_RECADOS'
,p_display_order=>290
,p_column_identifier=>'AB'
,p_column_label=>'Telefone Recados'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343689449173806120)
,p_db_column_name=>'CELULAR'
,p_display_order=>300
,p_column_identifier=>'AC'
,p_column_label=>'Celular'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343689811867806120)
,p_db_column_name=>'E_MAIL_PESSOAL'
,p_display_order=>310
,p_column_identifier=>'AD'
,p_column_label=>'E-Mail Pessoal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343690248974806121)
,p_db_column_name=>'URL_LINKEDIN'
,p_display_order=>320
,p_column_identifier=>'AE'
,p_column_label=>'Linkedin'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343690688333806121)
,p_db_column_name=>'CNH'
,p_display_order=>330
,p_column_identifier=>'AF'
,p_column_label=>'CNH'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343690992162806121)
,p_db_column_name=>'QUALIFICACAO'
,p_display_order=>340
,p_column_identifier=>'AG'
,p_column_label=>unistr('Qualifica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343691390462806122)
,p_db_column_name=>'GRAU_INSTRUCAO'
,p_display_order=>350
,p_column_identifier=>'AH'
,p_column_label=>unistr('Grau de Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343691882751806122)
,p_db_column_name=>'PS'
,p_display_order=>360
,p_column_identifier=>'AI'
,p_column_label=>unistr('N\00BA Processo Seletivo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343692280889806123)
,p_db_column_name=>'NOME'
,p_display_order=>370
,p_column_identifier=>'AJ'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343692601027806123)
,p_db_column_name=>'DT_CONTRATACAO'
,p_display_order=>380
,p_column_identifier=>'AK'
,p_column_label=>unistr('Data de Contrata\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343693023885806123)
,p_db_column_name=>'STATUS_CANDIDATO'
,p_display_order=>390
,p_column_identifier=>'AL'
,p_column_label=>'Status Candidato'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343693432233806124)
,p_db_column_name=>'DOCUMENTOS'
,p_display_order=>400
,p_column_identifier=>'AM'
,p_column_label=>'Documentos'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343693833290806124)
,p_db_column_name=>unistr('BENEF\00CDCIOS')
,p_display_order=>410
,p_column_identifier=>'AN'
,p_column_label=>unistr('Benef\00EDcios')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343694210681806125)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>420
,p_column_identifier=>'AO'
,p_column_label=>unistr('C\00F3d. Candidato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343694594222806125)
,p_db_column_name=>'NOME_SOCIAL'
,p_display_order=>430
,p_column_identifier=>'AP'
,p_column_label=>'Nome Social'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343695042775806125)
,p_db_column_name=>'GENERO'
,p_display_order=>440
,p_column_identifier=>'AQ'
,p_column_label=>unistr('G\00EAnero')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343679561707806104)
,p_db_column_name=>'SINDICATO'
,p_display_order=>450
,p_column_identifier=>'AR'
,p_column_label=>'Sindicato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8201355478718255532)
,p_db_column_name=>'PCD'
,p_display_order=>460
,p_column_identifier=>'AS'
,p_column_label=>'PCD'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8201355600535255533)
,p_db_column_name=>'WHATSAPP'
,p_display_order=>470
,p_column_identifier=>'AT'
,p_column_label=>'Whatsapp'
,p_column_link=>'#WHATSAPP#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-alert fa-2x"></span>'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8201355681476255534)
,p_db_column_name=>'EMAIL'
,p_display_order=>480
,p_column_identifier=>'AU'
,p_column_label=>'Enviar E-mail'
,p_column_link=>'f?p=RS_PRC_&P_BASE.:35:&SESSION.::&DEBUG.:RP,35:P35_EMP,P35_COD_CANDIDATO:#COD_EMPRESA#,#COD_CANDIDATO#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-envelope-o fa-2x fam-warning fam-is-info"></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8201355812060255535)
,p_db_column_name=>'Select'
,p_display_order=>490
,p_column_identifier=>'AV'
,p_column_label=>'Selecione<div style="text-align:center;margin-top: 7px"><input type="checkbox" id="SELECT_CI_ALL"></div>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_static_id=>'SELECT_CS'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(17048095428892189169)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'715774'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('LINK:PS:COD_CANDIDATO:NOME:NOME_SOCIAL:STATUS_CANDIDATO:ARQ_CURRICULO:URL_LINKEDIN:EMAIL:WHATSAPP:DOCUMENTOS:BENEF\00CDCIOS:DT_CONTRATACAO:PCD:E_MAIL_PESSOAL:CELULAR:TELEFONE_RECADOS:COD_VAGA:EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:CARGO:SINDICATO:SE')
||'XO:GENERO:ENDERECO:BAIRRO:CIDADE:UF:IDADE:GRAU_INSTRUCAO:FORMACAO:CURSOS:IDIOMAS:HABILIDADE:CNH:QUALIFICACAO:EMPREGOS_ANTERIORES:DT_ATUALIZACAO:DATA_CADASTRO:Select:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(17048067034981046591)
,p_plug_name=>'<center>Filtre sua consulta e clique em <b>Pesquisar</b></center>'
,p_region_template_options=>'#DEFAULT#:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34420044053019074842)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>6
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_HELP_TEXT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_plug_display_when_condition=>'P182_PESQUISA'
,p_plug_display_when_cond2=>'S'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164112909262577738)
,p_plug_name=>'Filtros'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(34420053620930074880)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670310199816397)
,p_plug_name=>unistr('Forma\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670445008816398)
,p_plug_name=>'Cursos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670600784816399)
,p_plug_name=>'Idioma'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670616503816400)
,p_plug_name=>'Habilidade'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670740577816401)
,p_plug_name=>unistr('Resid\00EAncia')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670858171816402)
,p_plug_name=>'Nacionalidade'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164670936477816403)
,p_plug_name=>'PCD'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26164671126044816405)
,p_plug_name=>'Dados Pessoais'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26165355174515487594)
,p_plug_name=>'Candidatos Externos'
,p_region_name=>'candidatos_externos'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34420053100889074878)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.cod_candidato,',
'       initcap(p.nome) nome,',
'       initcap(p.nome_social) nome_social,',
'       p.endereco, ',
'       p.bairro, ',
'       p.cidade,',
'       p.uf,',
'       FLOOR(months_between(sysdate,p.Dt_nac)/12) idade, ',
'       decode(p.sexo,''M'',''Masculino'',''F'',''Feminino'') sexo, ',
'       (select g.nome from genero_sexual g where g.cod = p.genero) genero, ',
'       ''(''||p.ddd_recados||'') ''||p.telefone_recados telefone_recados, ',
'       ''(''||p.ddd_celular||'') ''||p.telefone_celular celular, ',
'       p.e_mail e_mail_pessoal,',
'       case when p.url_linkedin is not null then',
'         ''<a href="'' || p.url_linkedin || ''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="20" height="20">',
'  <path data-name="layer1"',
'  fill="#0077b7" d="M1.15 21.7h13V61h-13zm46.55-1.3c-5.7 0-9.1 2.1-12.7 6.7v-5.4H22V61h13.1V39.7c0-4.5 2.3-8.9 7.5-8.9s8.3 4.4 8.3 8.8V61H64V38.7c0-15.5-10.5-18.3-16.3-18.3zM7.7 2.6C3.4 2.6 0 5.7 0 9.5s3.4 6.9 7.7 6.9 7.7-3.1 7.7-6.9S12 2.6 7.7 2.6z"'
||'></path>',
'</svg></a>''',
'       end as url_linkedin,',
'       CASE WHEN p.CNH IS NOT NULL THEN ''Categoria '' || p.categoria_cnh end CNH,',
'       substr(desc_qualific_func,0,200)||''...'' qualificacao,  ',
'       --',
'       (select nome',
'          from instrucao fi',
'         where p.instrucao = fi.cod) grau_instrucao,',
unistr('       (select listagg(''- '' || initcap(fe.descricao) || '' - Entidade: '' || initcap(fe.entidade) || '' - '' || case when fe.status = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cod_formacao_escolar)',
'          from formacao_escolar_candidato fe',
'         where fe.cod_empresa   = p.empresa',
'           and fe.cod_candidato = p.cod_candidato',
'           and ppess.formacao = ''S'')||''<br><br>''||replace(p.formacao_escolar_obs,chr(10),''<br>'') as formacao,',
'       -- formacao_escolar_obs,',
unistr('       /*(select listagg(''Curso: '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br>'')'),
'               within group (order by cc.data_inic desc)',
'          from (',
'           select initcap(cc.descricao) as descricao,',
'                  initcap(cc.local) as local,',
'                  cc.conclusao,',
'                  cc.data_inic,',
'                  row_number() over (order by cc.data_inic desc) rn',
'              from curso_candidato cc',
'             where cc.cod_empresa   = p.empresa',
'               and cc.cod_candidato = p.cod_candidato',
'          ) cc',
'         where rn <= 10 -- Limite',
'       ) as cursos,*/',
unistr('       (select listagg(''- '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cc.data_inic desc)',
'          from curso_candidato cc',
'         where cc.cod_empresa   = p.empresa',
'           and cc.cod_candidato = p.cod_candidato',
'           and ppess.cursos = ''S''',
'           and rownum <= 10 -- Limite',
'       )||''<br><br>''||replace(p.curso_obs,chr(10),''<br>'') as cursos,',
'      -- p.curso_obs,',
unistr('       (select listagg(''- '' ||initcap(im.descricao) || '' - N\00EDvel: '' || initcap(ni.descricao), ''<br>'')'),
'               within group (order by initcap(im.descricao))',
'          from idioma_candidato   ic,',
'               idioma             im,',
'               nivel_conhecimento ni',
'         where ic.cod_empresa    = p.empresa',
'           and ic.cod_candidato  = p.cod_candidato',
'           and ic.cod_idioma     = im.codigo',
'           and ic.cod_nivel_conh = ni.codigo',
'           and ppess.idiomas = ''S''',
'       )||''<br><br>''||replace(p.idioma_obs,chr(10),''<br>'') as idiomas,',
'      -- p.idioma_obs,',
unistr('       (select listagg(''- '' ||initcap(hb.descricao) || '' - N\00EDvel: '' || initcap(nh.descricao), ''<br>'')'),
'               within group (order by initcap(hb.descricao))',
'          from habilidade_candidato hc,',
'               habilidade           hb,',
'               nivel_conhecimento   nh',
'         where hc.cod_empresa    = p.empresa',
'           and hc.cod_candidato  = p.cod_candidato',
'           and hc.cod_habilidade = hb.codigo',
'           and hc.cod_nivel_conh = nh.codigo',
'           and ppess.habilidades = ''S''',
'       )||''<br><br>''||replace(p.habilidade_obs,chr(10),''<br>'') as habilidade,',
'       -- habilidade_obs,',
unistr('       (select listagg(''- '' ||initcap(a.nome_empresa)||'' | ''||a.cargo||'' ''||a.data_adm_emp||'' \00E0 ''||a.data_desl_emp||''<br>'')'),
'        within group (order by a.data_adm_emp desc)',
'          from empregos_anteriores a',
'         where a.nome_empresa is not null',
'           and a.cod_candidato = p.cod_candidato',
'           and ppess.empregos_ant = ''S'') empregos_anteriores,',
'       p.empresa cod_empresa,',
'       /*',
'       CASE WHEN :P_BASE in (''STEFANINI'') THEN',
'       ''f?p=CONHECENDO_VOCE_''||:P_BASE||'':1:''||:APP_SESSION||''::NO:RP,1:P1_USUARIO,P1_EMPRESA,P1_CANDIDATO,P1_EMPRESA_USER,P1_MATRICULA_USER:''||:P_USUARIO||'',''||P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||:P_EMPRESA_GESTOR||'',''||:P_MATRICULA_USER',
'       ELSE',
'       ''f?p=CV_''||:P_BASE||'':1:''||:APP_SESSION||''::::P_USUARIO,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER:''||:P_USUARIO||'',''||P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||:P_EMPRESA_GESTOR||'',''||:P_MATRICULA_USER',
'       END LINK,',
'       */',
'/*       ',
'apex_page.get_url (',
'         p_application => ''RS_PRC_''||:P_BASE,',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO'',',
'         p_values      => P."EMPRESA"||'',''||P."COD_CANDIDATO"',
'         ) LINK,',
'*/         ',
'apex_page.get_url (',
'         p_application => ''CV_''||:P_BASE,',
'         p_page        => 1,',
'         p_items       => ''P_USUARIO,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMPRESA,P_EMP,P_MATRICULA,P_MAT,P_VAGA,P_PAINEL'',',
'         p_values      => :P_USUARIO||'',''||P."COD_CANDIDATO"||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||P."EMPRESA"||'',''||P."EMPRESA"||'',''||NULL||'',''||NULL||'',''||NULL||'',''||:P_PAINEL',
'         ) LINK,  ',
'       (select ''<a href="''||''f?p=&APP_ID.:1:&APP_SESSION.:APPLICATION_PROCESS=GET_UPLOAD_FILES:::GET_TIPO_ITEM,GET_EMP,GET_COD_ITEM,GET_TIPO_ARQ,GET_COD_SUB_ITEM,GET_SEQ_ITEM:''||U.TIPO_COD_ITEM||'',''||U.COD_EMPRESA||'',''||U.COD_ITEM||'',''||U.TIPO_ARQUIV'
||'O||'',''||U.COD_SUB_ITEM||'',''||U.SEQ_ITEM||'':''||''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="30" height="30">',
'  <path data-name="layer2"',
'  fill="none" stroke="#202020" stroke-miterlimit="10" stroke-width="2" d="M10 2v60h44V18L38 2H10z"',
'  stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer2" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M38 2v16h16" stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer1" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M32 25v22m-7.6-9l7.6 9 7.6-9" stroke-linejoin="round"',
'  stroke-linecap="round"></path>',
'</svg></a>''',
'          from upload_files u, ',
'               tipo_arquivo_upload t',
'         where u.tipo_arquivo = t.cod',
'           and u.cod_sub_item = t.cod_tipo_sub_item',
'           and t.cod = 8',
'           and u.tipo_cod_item = ''CANDIDATO''',
'           and u.cod_empresa = p.empresa',
'           and u.cod_item = p.cod_candidato',
'           and u.seq_item = (select max(ux.seq_item) ',
'                               from upload_files ux ',
'                              where ux.tipo_cod_item = u.tipo_cod_item',
'                                and ux.cod_empresa = u.cod_empresa',
'                                and ux.cod_item = u.cod_item',
'                                and ux.cod_sub_item = u.cod_sub_item',
'                                and ux.tipo_arquivo = u.tipo_arquivo)',
'           AND ROWNUM = 1) arq_curriculo,',
'  fnct_nome_cargo(f.cargo_pretendido) cargo_pretendido,',
'  fnct_nome_local_trab(f.LOCAL_PRETENDIDO) LOCAL_PRETENDIDO,',
'  fnct_nome_funcao(f.cargo_pretendido, f.funcao_pretendida) funcao_pretendida,',
'       (select listagg(Initcap(a.descricao_area), ''<br>'')',
'               within group (order by initcap(a.descricao_area))',
'          from AREAS_INTERESSE_CANDIDATO c, areas_interesse a',
'         where c.cod_area_interesse = a.cod_area_interesse',
'           and c.cod_candidato = p.cod_candidato',
'       ) as areas_interesse,',
'       p.data_cadastro,',
'       case when p.dt_atualizacao > f.dt_atualizacao then p.dt_atualizacao else f.dt_atualizacao end dt_atualizacao,',
'       CASE WHEN P.IND_DEF_FIS = ''S'' THEN '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD, ',
'       CASE WHEN p.TELEFONE_CELULAR IS NOT NULL THEN ''https://api.whatsapp.com/send?phone=55''||p.DDD_CELULAR||p.TELEFONE_CELULAR ',
'        ELSE ''https://api.whatsapp.com/send?phone=55''||P.DDD||P.TELEFONE',
'        END WHATSAPP,',
'        ''EMAIL'' EMAIL,',
'        p.empresa,',
'nvl((',
' select ''Sim''',
'  from RP_CAND_INSCRITOS rx, inf_func_candidato ix, inf_pessoais_candidato px, requisicao reqx',
' where rx.cod_candidato = ix.cod_candidato',
'   and rx.cod_candidato = px.cod_candidato',
'   and rx.cod_candidato = px.cod_candidato',
'   and reqx.cod_sit_req in (1,5)',
'   and reqx.cod_req = rx.cod_req',
'   and px.cod_candidato = p.cod_candidato',
'   and rownum = 1',
unistr('   ),''N\00E3o'') part_processo_seletivo,    '),
'apex_item.checkbox2 (',
'         p_idx                      => 1,',
'         p_value                    => P.cod_candidato,',
'         p_attributes               => ''class="checkbox_item"'',',
'         p_checked_values           => (select listagg (n001, '':'') within group (order by n001)',
'                                          from apex_collections',
'                                         where collection_name = :P182_COLLECTION_NAME),',
'         p_checked_values_delimiter => '':''',
'       ) as "Select"',
'       ,case when f.STATUS_CANDIDATO = ''P'' THEN ''Pendente''',
'           when f.STATUS_CANDIDATO = ''A'' THEN ''Ativo''',
'           when f.STATUS_CANDIDATO = ''R'' THEN ''Reprovado''',
'        end STATUS_CANDIDATO',
'  from inf_pessoais_candidato p,',
'       inf_func_candidato f,',
'       permissao_pess_cand ppess',
' where p.cod_candidato = f.cod_candidato',
'   and ppess.id_usuario = usuario.busca_user',
'   --',
'   and (:P182_PESS_IDADE_MIN    is null or p.dt_nac <= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MIN) * 365.25))',
'   and (:P182_PESS_IDADE_MAX    is null or p.dt_nac >= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MAX) * 365.25))',
'   and (:P182_PESS_NOME  is null or ((upper(p.nome) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') or (upper(p.nome_social) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') ))',
'   and (:P182_PESS_EMAIL is null or upper(p.e_mail) = upper(:P182_PESS_EMAIL))',
'   and (:P182_PESS_SEXO         is null or p.sexo = :P182_PESS_SEXO)',
'   and (:P182_PESS_ESTADO_CIVIL is null or p.estado_civil in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_PESS_ESTADO_CIVIL, '':'')) t))',
'   and (:P182_PESS_DEPENDENTE   is null or p.possui_dependente = :P182_PESS_DEPENDENTE)',
'   --',
'   and (:P182_FORM_INSTRUCAO is null or p.instrucao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_INSTRUCAO, '':'')) t))',
'   and ((:P182_FORM_DESC is null and :P182_FORM_ENTIDADE is null and :P182_FORM_TURNO is null and :P182_PESS_STATUS is null) or exists (',
'         select 1',
'           from formacao_escolar_candidato fe',
'          where fe.cod_empresa   = p.empresa',
'            and fe.cod_candidato = p.cod_candidato',
'            and ((:P182_FORM_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                          from table(apex_string.split(:P182_FORM_DESC, '':'')) t',
'                                                         where upper(fe.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_FORM_ENTIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                              from table(apex_string.split(:P182_FORM_ENTIDADE, '':'')) t',
'                                                             where upper(fe.entidade) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_FORM_TURNO    is null or fe.turno     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_TURNO, '':'')) t))',
'            and (:P182_PESS_STATUS   is null or fe.status     = :P182_PESS_STATUS)',
'       ))',
'   --',
'   and ((:P182_CURSO_DESC is null and :P182_CURSO_LOCAL is null and :P182_CURSO_CONCLUSAO is null) or exists (',
'         select 1',
'           from curso_candidato cc',
'          where cc.cod_empresa   = p.empresa',
'            and cc.cod_candidato = p.cod_candidato',
'            and ((:P182_CURSO_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                           from table(apex_string.split(:P182_CURSO_DESC, '':'')) t',
'                                                          where upper(cc.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_CURSO_LOCAL is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                            from table(apex_string.split(:P182_CURSO_LOCAL, '':'')) t',
'                                                           where upper(cc.local) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_CURSO_CONCLUSAO is null or cc.conclusao  = :P182_CURSO_CONCLUSAO)',
'       ))',
'   --',
'   and ((:P182_IDIOMA is null and :P182_IDIOMA_NIVEL is null) or exists (',
'         select 1',
'           from idioma_candidato ic',
'          where ic.cod_empresa   = p.empresa',
'            and ic.cod_candidato = p.cod_candidato',
'            and (:P182_IDIOMA       is null or ic.cod_idioma     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA, '':'')) t))',
'            and (:P182_IDIOMA_NIVEL is null or ic.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and ((:P182_HABILIDADE is null and :P182_HABILIDADE_NIVEL is null) or exists (',
'         select 1',
'           from habilidade_candidato hc',
'          where hc.cod_empresa   = p.empresa',
'            and hc.cod_candidato = p.cod_candidato',
'            and (:P182_HABILIDADE       is null or hc.cod_habilidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE, '':'')) t))',
'            and (:P182_HABILIDADE_NIVEL is null or hc.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and (:P182_RESID_UF      is null or p.uf            in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_RESID_UF, '':'')) t))',
'   and ((:P182_RESID_CIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_CIDADE, '':'')) t',
'                                                  where upper(p.cidade) like ''%''||upper(column_value)||''%''))))',
'   and ((:P182_RESID_BAIRRO is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_BAIRRO, '':'')) t',
'                                                  where upper(p.bairro) like ''%''||upper(column_value)||''%''))))',
'   and (:P182_NACIONAL_PAIS is null or p.nacionalidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_NACIONAL_PAIS, '':'')) t))',
'   --',
'   and (:P182_PCD_POSSUI IS NULL or p.ind_def_fis = :P182_PCD_POSSUI)',
'   and not exists (select 1 ',
'                     from inf_pessoais pp, ',
'                          informacoes_funcionais if ',
'                    where pp.cod_empresa = if.cod_empresa ',
'                      and pp.matricula = if.matricula',
'                      and if.situacao < ''90''',
'                      and pp.cod_candidato = p.cod_candidato)',
'   and :P182_PESQUISA = ''S''',
'   and (((trunc(sysdate) - trunc(p.dt_atualizacao)) <= :p182_periodo) or (:p182_periodo = 0))',
'   and ((:P182_INDICADO is null) or (exists (select 1 from requisicao r where r.candidato_indicado = p.cod_candidato)))',
' order by 1 desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':p182_tipo = ''E'' and :p182_Pesquisa = ''S'''
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(26165355303575487595)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Para ver os resultados, filtre as informa\00E7\00F5es.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'#LINK#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_detail_link_attr=>'target="_blank"'
,p_owner=>'IGOR'
,p_internal_uid=>17893237313702737140
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343732341997806204)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('C\00F3d. Candidato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343732742917806204)
,p_db_column_name=>'ENDERECO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343733125488806205)
,p_db_column_name=>'BAIRRO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343733574842806205)
,p_db_column_name=>'CIDADE'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343733955212806206)
,p_db_column_name=>'UF'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343734298697806206)
,p_db_column_name=>'IDADE'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343734763196806207)
,p_db_column_name=>'SEXO'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343735103491806208)
,p_db_column_name=>'TELEFONE_RECADOS'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Telefone Recados'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343735588754806208)
,p_db_column_name=>'CELULAR'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Celular'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343735931565806208)
,p_db_column_name=>'E_MAIL_PESSOAL'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'E-Mail Pessoal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343739167298806212)
,p_db_column_name=>'ARQ_CURRICULO'
,p_display_order=>220
,p_column_identifier=>'BV'
,p_column_label=>unistr('Arquivo Curr\00EDculo')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343736329492806209)
,p_db_column_name=>'URL_LINKEDIN'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Linkedin'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343736778009806209)
,p_db_column_name=>'CNH'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'CNH'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343737174531806210)
,p_db_column_name=>'QUALIFICACAO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>unistr('Qualifica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343737500761806210)
,p_db_column_name=>'GRAU_INSTRUCAO'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Grau de Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343737925671806210)
,p_db_column_name=>'HABILIDADE'
,p_display_order=>300
,p_column_identifier=>'AL'
,p_column_label=>'Habilidade'
,p_column_html_expression=>'<span class="nobr">#HABILIDADE#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343738294304806211)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>590
,p_column_identifier=>'BP'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343738713866806211)
,p_db_column_name=>'LINK'
,p_display_order=>600
,p_column_identifier=>'BQ'
,p_column_label=>'Consultar'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343731095497806203)
,p_db_column_name=>'FORMACAO'
,p_display_order=>610
,p_column_identifier=>'BR'
,p_column_label=>unistr('Forma\00E7\00E3o')
,p_column_html_expression=>'<span class="nobr">#FORMACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343731548048806203)
,p_db_column_name=>'CURSOS'
,p_display_order=>620
,p_column_identifier=>'BS'
,p_column_label=>'Cursos'
,p_column_html_expression=>'<span class="nobr">#CURSOS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343731935676806204)
,p_db_column_name=>'IDIOMAS'
,p_display_order=>630
,p_column_identifier=>'BT'
,p_column_label=>'Idiomas'
,p_column_html_expression=>'<span class="nobr">#IDIOMAS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343730788139806202)
,p_db_column_name=>'NOME'
,p_display_order=>640
,p_column_identifier=>'BU'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343727511889806199)
,p_db_column_name=>'EMPREGOS_ANTERIORES'
,p_display_order=>650
,p_column_identifier=>'BW'
,p_column_label=>'Empregos Anteriores'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343727902530806200)
,p_db_column_name=>'CARGO_PRETENDIDO'
,p_display_order=>660
,p_column_identifier=>'BX'
,p_column_label=>'Cargo Pretendido'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343728379100806200)
,p_db_column_name=>'FUNCAO_PRETENDIDA'
,p_display_order=>670
,p_column_identifier=>'BY'
,p_column_label=>unistr('Fun\00E7\00E3o Pretendida')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343728760353806200)
,p_db_column_name=>'AREAS_INTERESSE'
,p_display_order=>680
,p_column_identifier=>'BZ'
,p_column_label=>unistr('\00C1reas de Interesse')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343729168655806201)
,p_db_column_name=>'NOME_SOCIAL'
,p_display_order=>690
,p_column_identifier=>'CA'
,p_column_label=>'Nome Social'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343729518188806201)
,p_db_column_name=>'GENERO'
,p_display_order=>700
,p_column_identifier=>'CB'
,p_column_label=>unistr('G\00EAnero')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343729931088806202)
,p_db_column_name=>'DATA_CADASTRO'
,p_display_order=>710
,p_column_identifier=>'CC'
,p_column_label=>'Data de Cadastro'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343730369440806202)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>720
,p_column_identifier=>'CD'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343725166539806192)
,p_db_column_name=>'PCD'
,p_display_order=>730
,p_column_identifier=>'CE'
,p_column_label=>'PCD'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343725493647806194)
,p_db_column_name=>'WHATSAPP'
,p_display_order=>740
,p_column_identifier=>'CF'
,p_column_label=>'Whatsapp'
,p_column_link=>'#WHATSAPP#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-alert fa-2x"></span>'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343725915647806195)
,p_db_column_name=>'Select'
,p_display_order=>750
,p_column_identifier=>'CG'
,p_column_label=>'Selecione<div style="text-align:center;margin-top: 7px"><input type="checkbox" id="SELECT_CE_ALL"></div>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_static_id=>'SELECT_CE'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343726309817806198)
,p_db_column_name=>'EMAIL'
,p_display_order=>760
,p_column_identifier=>'CH'
,p_column_label=>'Enviar E-mail'
,p_column_link=>'f?p=RS_PRC_&P_BASE.:35:&SESSION.::&DEBUG.:RP,35:P35_EMP,P35_COD_CANDIDATO:#EMPRESA#,#COD_CANDIDATO#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-envelope-o fa-2x fam-warning fam-is-info"></span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343726749305806198)
,p_db_column_name=>'EMPRESA'
,p_display_order=>770
,p_column_identifier=>'CI'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343727167075806199)
,p_db_column_name=>'PART_PROCESSO_SELETIVO'
,p_display_order=>780
,p_column_identifier=>'CJ'
,p_column_label=>'Em Processo Seletivo?'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4422672196249378492)
,p_db_column_name=>'STATUS_CANDIDATO'
,p_display_order=>790
,p_column_identifier=>'CK'
,p_column_label=>'Status Candidato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(1935276373866318726)
,p_db_column_name=>'LOCAL_PRETENDIDO'
,p_display_order=>800
,p_column_identifier=>'CL'
,p_column_label=>'Local Pretendido'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(26165605240684730830)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'716215'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'Select:COD_CANDIDATO:NOME:NOME_SOCIAL:ARQ_CURRICULO:URL_LINKEDIN:EMAIL:WHATSAPP:E_MAIL_PESSOAL:PCD:PART_PROCESSO_SELETIVO:DATA_CADASTRO:DT_ATUALIZACAO:CELULAR:TELEFONE_RECADOS:IDADE:GENERO:SEXO:ENDERECO:BAIRRO:CIDADE:UF:CNH:QUALIFICACAO:GRAU_INSTRUCA'
||'O:FORMACAO:CURSOS:IDIOMAS:HABILIDADE:EMPREGOS_ANTERIORES:CARGO_PRETENDIDO:LOCAL_PRETENDIDO:FUNCAO_PRETENDIDA:AREAS_INTERESSE:STATUS_CANDIDATO:'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(26171369418697185686)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Relat\00F3rio Resumido')
,p_report_seq=>10
,p_report_alias=>'716219'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK:IDADE:SEXO:URL_LINKEDIN:QUALIFICACAO:GRAU_INSTRUCAO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26165578985853721618)
,p_plug_name=>'Vaga'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(34420052190251074877)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26475633320753203035)
,p_plug_name=>'Candidatos Internos'
,p_region_name=>'candidatos_internos'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34420053100889074878)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa,''S'')) empresa,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa,i.cod_ccusto)) ccusto,',
'       i.unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cad_vaga cod_vaga,',
'       i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo,',
'       i.matricula,',
'       initcap(TRIM(S.nome)) colaborador,',
'       initcap(p.nome_social) nome_social,',
'       s.cod_candidato,',
'       i.dt_admissao dt_admissao,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) situacao,',
'       s.endereco, ',
'       s.bairro, ',
'       s.cidade,',
'       s.uf,',
'       FLOOR(months_between(sysdate,S.Dt_nasc)/12) idade, ',
'       decode(s.sexo,''M'',''Masculino'',''F'',''Feminino'') sexo, ',
'       (select g.nome from genero_sexual g where g.cod = p.genero) genero,',
'       ''(''||p.ddd_recados||'') ''||p.telefone_recados telefone_recados, ',
'       ''(''||p.ddd_celular||'') ''||p.telefone_celular celular, ',
'       s.e_mail e_mail_pessoal,',
'       i.e_mail e_mail_funcional,',
'       case when p.url_linkedin is not null then',
'         ''<a href="'' || p.url_linkedin || ''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'          aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'          width="20" height="20">',
'            <path data-name="layer1"',
'            fill="#0077b7" d="M1.15 21.7h13V61h-13zm46.55-1.3c-5.7 0-9.1 2.1-12.7 6.7v-5.4H22V61h13.1V39.7c0-4.5 2.3-8.9 7.5-8.9s8.3 4.4 8.3 8.8V61H64V38.7c0-15.5-10.5-18.3-16.3-18.3zM7.7 2.6C3.4 2.6 0 5.7 0 9.5s3.4 6.9 7.7 6.9 7.7-3.1 7.7-6.9S12 2.6'
||' 7.7 2.6z"></path>',
'          </svg></a>''',
'       end as url_linkedin,',
'       CASE WHEN S.CNH IS NOT NULL THEN ''Categoria '' || p.categoria_cnh end CNH,',
'       substr(desc_qualific_func,0,200)||''...'' qualificacao,  ',
'       --',
'       (select nome',
'          from instrucao f',
'         where s.instrucao = f.cod) grau_instrucao,',
unistr('       (select listagg(''- '' || initcap(fe.descricao) || '' - Entidade: '' || initcap(fe.entidade) || '' - '' || case when fe.status = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cod_formacao_escolar)',
'          from formacao_escolar_candidato fe',
'         where fe.cod_empresa   = p.empresa',
'           and fe.cod_candidato = p.cod_candidato)||''<br><br>''||replace(formacao_escolar_obs,chr(10),''<br>'') as formacao,',
'      -- formacao_escolar_obs,',
unistr('       /*(select listagg(''Curso: '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br>'')'),
'               within group (order by cc.data_inic desc)',
'          from (',
'           select initcap(cc.descricao) as descricao,',
'                  initcap(cc.local) as local,',
'                  cc.conclusao,',
'                  cc.data_inic,',
'                  row_number() over (order by cc.data_inic desc) rn',
'              from curso_candidato cc',
'             where cc.cod_empresa   = p.empresa',
'               and cc.cod_candidato = p.cod_candidato',
'          ) cc',
'         where rn <= 10 -- Limite',
'       ) as cursos,*/',
unistr('       (select listagg(''- '' || initcap(cc.descricao) || '' - Local: '' || initcap(cc.local) || '' - '' || case when cc.conclusao = ''N'' then ''N\00E3o '' end || ''conclu\00EDdo'', ''<br><br>'')'),
'               within group (order by cc.data_inic desc)',
'          from curso_candidato cc',
'         where cc.cod_empresa   = p.empresa',
'           and cc.cod_candidato = p.cod_candidato',
'           and rownum <= 10 -- Limite',
'       )||''<br><br>''||replace(p.curso_obs,chr(10),''<br>'') as cursos,',
'      -- p.curso_obs,',
unistr('       (select listagg(''- '' ||initcap(im.descricao) || '' - N\00EDvel: '' || initcap(ni.descricao), ''<br>'')'),
'               within group (order by initcap(im.descricao))',
'          from idioma_candidato   ic,',
'               idioma             im,',
'               nivel_conhecimento ni',
'         where ic.cod_empresa    = p.empresa',
'           and ic.cod_candidato  = p.cod_candidato',
'           and ic.cod_idioma     = im.codigo',
'           and ic.cod_nivel_conh = ni.codigo',
'       )||''<br><br>''||replace(p.idioma_obs,chr(10),''<br>'') as idiomas,',
'       --p.idioma_obs,',
unistr('       (select listagg(''- '' ||initcap(hb.descricao) || '' - N\00EDvel: '' || initcap(nh.descricao), ''<br>'')'),
'               within group (order by initcap(hb.descricao))',
'          from habilidade_candidato hc,',
'               habilidade           hb,',
'               nivel_conhecimento   nh',
'         where hc.cod_empresa    = p.empresa',
'           and hc.cod_candidato  = p.cod_candidato',
'           and hc.cod_habilidade = hb.codigo',
'           and hc.cod_nivel_conh = nh.codigo',
'       )||''<br><br>''||replace(p.habilidade_obs,chr(10),''<br>'') as habilidade,',
'       --habilidade_obs,',
unistr('       (select listagg(''- '' ||initcap(a.nome_empresa)||'' | ''||a.cargo||'' ''||a.data_adm_emp||'' \00E0 ''||a.data_desl_emp||''<br>'')'),
'        within group (order by a.data_adm_emp desc)',
'          from empregos_anteriores a',
'         where a.nome_empresa is not null',
'           and a.cod_candidato = p.cod_candidato) empregos_anteriores,',
'       -- p.empresa cod_empresa,',
'       /*',
'       apex_page.get_url (',
'         p_application => ''CV_''||:P_BASE,',
'         p_page        => 1,',
'         p_items       => ''P_USUARIO,P_EMPRESA,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMP,P_MAT,P_VAGA,P_FILIAL_VAGA,P_EMPRESA_VAGA,P_DT_CONTRATACAO'',',
'         p_values      => :P_USUARIO||'',''||P.EMPRESA||'',''||P.COD_CANDIDATO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||I.COD_EMPRESA||'',''||I.MATRICULA||'',''||I.CAD_VAGA||'',''||I.FILIAL||'',''||I.COD_EMPRESA||'',''||I.DT_ADMISSAO',
'       ) LINK,',
'       */',
'/*',
'apex_page.get_url (',
'         p_application => ''RS_PRC_''||:P_BASE,',
'         p_page        => 39,',
'         p_items       => ''P39_COD_EMPRESA,P39_COD_CANDIDATO,P39_MATRICULA'',',
'         p_values      => P."EMPRESA"||'',''||P."COD_CANDIDATO"||'',''||I."MATRICULA"',
'         ) LINK,',
'*/         ',
'apex_page.get_url (',
'         p_application => ''CV_''||:P_BASE,',
'         p_page        => 1,',
'         p_items       => ''P_USUARIO,P_CANDIDATO,P_EMPRESA_USER,P_MATRICULA_USER,P_EMPRESA,P_EMP,P_MATRICULA,P_MAT,P_VAGA,P_PAINEL'',',
'         p_values      => :P_USUARIO||'',''||P."COD_CANDIDATO"||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||P."EMPRESA"||'',''||P."EMPRESA"||'',''||I.MATRICULA||'',''||I.MATRICULA||'',''||NULL||'',''||:P_PAINEL',
'         ) LINK,  ',
'         ',
'       p.data_cadastro,',
'       case when p.dt_atualizacao > f.dt_atualizacao then p.dt_atualizacao else f.dt_atualizacao end dt_atualizacao,',
'       (select ''<a href="''||''f?p=&APP_ID.:1:&APP_SESSION.:APPLICATION_PROCESS=GET_UPLOAD_FILES:::GET_TIPO_ITEM,GET_EMP,GET_COD_ITEM,GET_TIPO_ARQ,GET_COD_SUB_ITEM,GET_SEQ_ITEM:''||U.TIPO_COD_ITEM||'',''||U.COD_EMPRESA||'',''||U.COD_ITEM||'',''||U.TIPO_ARQUIV'
||'O||'',''||U.COD_SUB_ITEM||'',''||U.SEQ_ITEM||'':''||''" target="_blank"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" aria-labelledby="title"',
'aria-describedby="desc" role="img" xmlns:xlink="http://www.w3.org/1999/xlink"',
'width="30" height="30">',
'  <path data-name="layer2"',
'  fill="none" stroke="#202020" stroke-miterlimit="10" stroke-width="2" d="M10 2v60h44V18L38 2H10z"',
'  stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer2" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M38 2v16h16" stroke-linejoin="round" stroke-linecap="round"></path>',
'  <path data-name="layer1" fill="none" stroke="#202020" stroke-miterlimit="10"',
'  stroke-width="2" d="M32 25v22m-7.6-9l7.6 9 7.6-9" stroke-linejoin="round"',
'  stroke-linecap="round"></path>',
'</svg></a>''',
'          from upload_files u, ',
'               tipo_arquivo_upload t',
'         where u.tipo_arquivo = t.cod',
'           and u.cod_sub_item = t.cod_tipo_sub_item',
'           and t.cod = 8',
'           and u.tipo_cod_item = ''COLABORADOR''',
'           and u.cod_empresa = p.empresa',
'           and u.cod_item = p.cod_candidato',
'           and u.seq_item = (select max(ux.seq_item) ',
'                               from upload_files ux ',
'                              where ux.tipo_cod_item = u.tipo_cod_item',
'                                and ux.cod_empresa = u.cod_empresa',
'                                and ux.cod_item = u.cod_item',
'                                and ux.cod_sub_item = u.cod_sub_item',
'                                and ux.tipo_arquivo = u.tipo_arquivo)',
'           AND ROWNUM = 1) arq_curriculo,',
'       CASE WHEN P.IND_DEF_FIS = ''S'' THEN '' <span aria-hidden="true" class="fa fa-wheelchair-alt"></span>'' end PCD, ',
'       CASE WHEN p.TELEFONE_CELULAR IS NOT NULL THEN ''https://api.whatsapp.com/send?phone=55''||p.DDD_CELULAR||p.TELEFONE_CELULAR ',
'        ELSE ''https://api.whatsapp.com/send?phone=55''||P.DDD||P.TELEFONE',
'        END WHATSAPP,',
'        ''EMAIL'' EMAIL,',
'        p.empresa cod_empresa,',
'nvl((',
' select ''Sim''',
'  from RP_FUNC_INSCRITOS rx, informacoes_funcionais_cad ix, inf_pessoais_cad px, requisicao reqx',
' where rx.cod_empresa = ix.cod_empresa',
'   and rx.cod_empresa = px.cod_empresa',
'   and rx.matricula = ix.matricula',
'   and rx.matricula = px.matricula',
'   and reqx.cod_sit_req in (1,5)',
'   and reqx.cod_req = rx.cod_req',
'   and px.cod_candidato = p.cod_candidato',
'   and rownum = 1',
unistr('   ),''N\00E3o'') part_processo_seletivo,    '),
'apex_item.checkbox2 (',
'         p_idx                      => 1,',
'         p_value                    => P.cod_candidato,',
'         p_attributes               => ''class="checkbox_item"'',',
'         p_checked_values           => (select listagg (n001, '':'') within group (order by n001)',
'                                          from apex_collections',
'                                         where collection_name = :P182_COLLECTION_NAME),',
'         p_checked_values_delimiter => '':''',
'       ) as "Select",',
'       NVL(( select ''Sim''',
'          FROM DESLIGAMENTO D, LOTE_RESCISAO L',
'         WHERE d.cod_empresa = i.cod_empresa',
'           and d.cod_empresa = l.cod_empresa',
'           and d.mat_solicitado = l.matricula',
'           and d.mat_solicitado = i.matricula',
'           and l.dt_aviso is not null',
'           and nvl((trunc(sysdate) - trunc(l.data_retencao)),0) between 0 and 10',
'           and d.cod_sit_desligamento in (1,5)',
'           and d.ind_realocacao = ''S''',
unistr('           ),''N\00E3o'') disponivel'),
'       ,case when f.STATUS_CANDIDATO = ''P'' THEN ''Pendente''',
'           when f.STATUS_CANDIDATO = ''A'' THEN ''Ativo''',
'           when f.STATUS_CANDIDATO = ''R'' THEN ''Reprovado''',
'        end STATUS_CANDIDATO           ',
'  from inf_pessoais_candidato_cad p,',
'       inf_func_candidato_cad     f,',
'       inf_pessoais_cad           s,',
'       informacoes_funcionais_cad i',
' where s.cod_empresa   = i.cod_empresa',
'   and s.matricula     = i.matricula',
'   and s.cod_candidato  = p.cod_candidato (+)',
'   and s.cod_candidato  = f.cod_candidato (+)',
'   and ((i.situacao      < ''90'') or (i.situacao >= ''90'' and exists ( select 1',
'                                                                      from RP_FUNC_INSCRITOS rx, informacoes_funcionais_cad ix, inf_pessoais_cad px, requisicao reqx',
'                                                                     where rx.cod_empresa = ix.cod_empresa',
'                                                                       and rx.cod_empresa = px.cod_empresa',
'                                                                       and rx.matricula = ix.matricula',
'                                                                       and rx.matricula = px.matricula',
'                                                                       and reqx.cod_sit_req in (1,5)',
'                                                                       and reqx.cod_req = rx.cod_req',
'                                                                       and px.cod_candidato = p.cod_candidato',
'                                                                       and rownum = 1)))',
'   --',
'   and (:P182_VAGA_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_EMPRESA, '':'')) t))',
'   and (:P182_VAGA_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_FILIAL, '':'')) t))',
'   and (:P182_VAGA_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_CCUSTO, '':'')) t))',
'   and (:P182_VAGA_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_UNIDADE_ADM, '':'')) t))',
'   and (:P182_VAGA_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_ATIVIDADE, '':'')) t))',
'   and (:P182_VAGA_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_VAGA_CARGO, '':'')) t))',
'   --',
'   and (:P182_PESS_IDADE_MIN    is null or p.dt_nac <= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MIN) * 365.25))',
'   and (:P182_PESS_IDADE_MAX    is null or p.dt_nac >= trunc(sysdate) - (to_number(:P182_PESS_IDADE_MAX) * 365.25))',
'   and (:P182_PESS_NOME  is null or ((upper(p.nome) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') or (upper(p.nome_social) like ''%''||replace(upper(:P182_PESS_NOME),'' '',''%'')||''%'') ))',
'   and (:P182_PESS_EMAIL is null or upper(p.e_mail) = upper(:P182_PESS_EMAIL))',
'   and (:P182_PESS_SEXO         is null or p.sexo = :P182_PESS_SEXO)',
'   and (:P182_PESS_ESTADO_CIVIL is null or p.estado_civil in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_PESS_ESTADO_CIVIL, '':'')) t))',
'   and (:P182_PESS_DEPENDENTE   is null or p.possui_dependente = :P182_PESS_DEPENDENTE)',
'   --',
'   and (:P182_FORM_INSTRUCAO is null or p.instrucao in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_INSTRUCAO, '':'')) t))',
'   and ((:P182_FORM_DESC is null and :P182_FORM_ENTIDADE is null and :P182_FORM_TURNO is null and :P182_PESS_STATUS is null) or exists (',
'         select 1',
'           from formacao_escolar_candidato fe',
'          where fe.cod_empresa   = p.empresa',
'            and fe.cod_candidato = p.cod_candidato',
'            and ((:P182_FORM_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                          from table(apex_string.split(:P182_FORM_DESC, '':'')) t',
'                                                         where upper(fe.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_FORM_ENTIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                              from table(apex_string.split(:P182_FORM_ENTIDADE, '':'')) t',
'                                                             where upper(fe.entidade) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_FORM_TURNO    is null or fe.turno     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_FORM_TURNO, '':'')) t))',
'            and (:P182_PESS_STATUS   is null or fe.status     = :P182_PESS_STATUS)',
'       ))',
'   --',
'   and ((:P182_CURSO_DESC is null and :P182_CURSO_LOCAL is null and :P182_CURSO_CONCLUSAO is null) or exists (',
'         select 1',
'           from curso_candidato cc',
'          where cc.cod_empresa   = p.empresa',
'            and cc.cod_candidato = p.cod_candidato',
'            and ((:P182_CURSO_DESC is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                           from table(apex_string.split(:P182_CURSO_DESC, '':'')) t',
'                                                          where upper(cc.descricao) like ''%''||upper(column_value)||''%''))))',
'            and ((:P182_CURSO_LOCAL is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                            from table(apex_string.split(:P182_CURSO_LOCAL, '':'')) t',
'                                                           where upper(cc.local) like ''%''||upper(column_value)||''%''))))',
'            and (:P182_CURSO_CONCLUSAO is null or cc.conclusao  = :P182_CURSO_CONCLUSAO)',
'       ))',
'   --',
'   and ((:P182_IDIOMA is null and :P182_IDIOMA_NIVEL is null) or exists (',
'         select 1',
'           from idioma_candidato ic',
'          where ic.cod_empresa   = p.empresa',
'            and ic.cod_candidato = p.cod_candidato',
'            and (:P182_IDIOMA       is null or ic.cod_idioma     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA, '':'')) t))',
'            and (:P182_IDIOMA_NIVEL is null or ic.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_IDIOMA_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and ((:P182_HABILIDADE is null and :P182_HABILIDADE_NIVEL is null) or exists (',
'         select 1',
'           from habilidade_candidato hc',
'          where hc.cod_empresa   = p.empresa',
'            and hc.cod_candidato = p.cod_candidato',
'            and (:P182_HABILIDADE       is null or hc.cod_habilidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE, '':'')) t))',
'            and (:P182_HABILIDADE_NIVEL is null or hc.cod_nivel_conh in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_HABILIDADE_NIVEL, '':'')) t))',
'       ))',
'   --',
'   and (:P182_RESID_UF      is null or p.uf            in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_RESID_UF, '':'')) t))',
'   and ((:P182_RESID_CIDADE is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_CIDADE, '':'')) t',
'                                                  where upper(p.cidade) like ''%''||upper(column_value)||''%''))))',
'   and ((:P182_RESID_BAIRRO is null) or ((exists (select /*+ cardinality (t 1)*/ upper(column_value) ',
'                                                   from table(apex_string.split(:P182_RESID_BAIRRO, '':'')) t',
'                                                  where upper(p.bairro) like ''%''||upper(column_value)||''%''))))',
'   and (:P182_NACIONAL_PAIS is null or p.nacionalidade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P182_NACIONAL_PAIS, '':'')) t))',
'   --',
'   and (:P182_PCD_POSSUI IS NULL or p.ind_def_fis = :P182_PCD_POSSUI)',
'   --',
'   and :P182_PESQUISA = ''S''',
' order by initcap(TRIM(S.nome))'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':p182_tipo = ''I'' and :p182_Pesquisa = ''S'''
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(26475633449813203036)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>unistr('Para ver os resultados, filtre as informa\00E7\00F5es.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'#LINK#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_detail_link_attr=>'target="_blank"'
,p_owner=>'IGOR'
,p_internal_uid=>18203515459940452581
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343750425145806231)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343750810571806231)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343751281340806232)
,p_db_column_name=>'CCUSTO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Centro de Custo (C\00E9lula)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343751635600806232)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Unidade Adm. (Cliente)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343752051207806233)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>unistr('Atividade (Servi\00E7o)')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343752466839806233)
,p_db_column_name=>'COD_VAGA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('C\00F3d. Vaga')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343752849506806233)
,p_db_column_name=>'CARGO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343753233770806234)
,p_db_column_name=>'MATRICULA'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343753597559806234)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343754008925806235)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('C\00F3d. Candidato')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343754453986806235)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('Data de Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343754869532806236)
,p_db_column_name=>'SITUACAO'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343755263131806237)
,p_db_column_name=>'ENDERECO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343755672099806237)
,p_db_column_name=>'BAIRRO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343756082241806238)
,p_db_column_name=>'CIDADE'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343756421917806238)
,p_db_column_name=>'UF'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343756820453806239)
,p_db_column_name=>'IDADE'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343757219943806239)
,p_db_column_name=>'SEXO'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Sexo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343757614936806239)
,p_db_column_name=>'TELEFONE_RECADOS'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Telefone Recados'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343758084732806240)
,p_db_column_name=>'CELULAR'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Celular'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343758406432806240)
,p_db_column_name=>'E_MAIL_PESSOAL'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'E-Mail Pessoal'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343758846153806241)
,p_db_column_name=>'E_MAIL_FUNCIONAL'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'E-Mail Funcional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343759232303806241)
,p_db_column_name=>'URL_LINKEDIN'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Linkedin'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343759652146806242)
,p_db_column_name=>'CNH'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'CNH'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343760064541806242)
,p_db_column_name=>'QUALIFICACAO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>unistr('Qualifica\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343760389901806243)
,p_db_column_name=>'GRAU_INSTRUCAO'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Grau de Instru\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343760835419806243)
,p_db_column_name=>'HABILIDADE'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>'Habilidade'
,p_column_html_expression=>'<span class="nobr">#HABILIDADE#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343761225336806244)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>680
,p_column_identifier=>'BP'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343761651473806244)
,p_db_column_name=>'LINK'
,p_display_order=>690
,p_column_identifier=>'BQ'
,p_column_label=>'Consultar'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343749246141806230)
,p_db_column_name=>'FORMACAO'
,p_display_order=>700
,p_column_identifier=>'BR'
,p_column_label=>unistr('Forma\00E7\00E3o')
,p_column_html_expression=>'<span class="nobr">#FORMACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343749657382806230)
,p_db_column_name=>'CURSOS'
,p_display_order=>710
,p_column_identifier=>'BS'
,p_column_label=>'Cursos'
,p_column_html_expression=>'<span class="nobr">#CURSOS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343750016282806230)
,p_db_column_name=>'IDIOMAS'
,p_display_order=>720
,p_column_identifier=>'BT'
,p_column_label=>'Idiomas'
,p_column_html_expression=>'<span class="nobr">#IDIOMAS#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343762052158806244)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>740
,p_column_identifier=>'BW'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343748088185806228)
,p_db_column_name=>'DATA_CADASTRO'
,p_display_order=>750
,p_column_identifier=>'BX'
,p_column_label=>'Data de Cadastro'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343748485052806229)
,p_db_column_name=>'EMPREGOS_ANTERIORES'
,p_display_order=>760
,p_column_identifier=>'BY'
,p_column_label=>'Empregos Anteriores'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343748861447806229)
,p_db_column_name=>'ARQ_CURRICULO'
,p_display_order=>770
,p_column_identifier=>'BZ'
,p_column_label=>unistr('Arquivo Curr\00EDculo')
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343762436320806245)
,p_db_column_name=>'NOME_SOCIAL'
,p_display_order=>780
,p_column_identifier=>'CA'
,p_column_label=>'Nome Social'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343762806859806246)
,p_db_column_name=>'GENERO'
,p_display_order=>790
,p_column_identifier=>'CB'
,p_column_label=>unistr('G\00EAnero')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343746086627806222)
,p_db_column_name=>'PCD'
,p_display_order=>800
,p_column_identifier=>'CC'
,p_column_label=>'PCD'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343746449485806223)
,p_db_column_name=>'WHATSAPP'
,p_display_order=>810
,p_column_identifier=>'CD'
,p_column_label=>'Whatsapp'
,p_column_link=>'#WHATSAPP#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-alert fa-2x"></span>'
,p_column_link_attr=>'target="_blank"'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343746822541806223)
,p_db_column_name=>'EMAIL'
,p_display_order=>820
,p_column_identifier=>'CE'
,p_column_label=>'Enviar E-mail'
,p_column_link=>'f?p=RS_PRC_&P_BASE.:35:&SESSION.::&DEBUG.:RP,35:P35_EMP,P35_COD_CANDIDATO:#COD_EMPRESA#,#COD_CANDIDATO#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-envelope-o fa-2x fam-warning fam-is-info"></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343747289550806225)
,p_db_column_name=>'PART_PROCESSO_SELETIVO'
,p_display_order=>830
,p_column_identifier=>'CF'
,p_column_label=>'Em Processo Seletivo?'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(8343747671221806226)
,p_db_column_name=>'Select'
,p_display_order=>840
,p_column_identifier=>'CG'
,p_column_label=>'Selecione<div style="text-align:center;margin-top: 7px"><input type="checkbox" id="SELECT_CI_ALL"></div>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
,p_static_id=>'SELECT_CI'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7911889216262472354)
,p_db_column_name=>'DISPONIVEL'
,p_display_order=>850
,p_column_identifier=>'CH'
,p_column_label=>unistr('Dispon\00EDvel')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4459985223235463955)
,p_db_column_name=>'STATUS_CANDIDATO'
,p_display_order=>860
,p_column_identifier=>'CI'
,p_column_label=>'Status Candidato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(26475883386922446271)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'716452'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK:Select:COD_CANDIDATO:MATRICULA:COLABORADOR:NOME_SOCIAL:DISPONIVEL:PART_PROCESSO_SELETIVO:ARQ_CURRICULO:URL_LINKEDIN:EMAIL:WHATSAPP:E_MAIL_PESSOAL:E_MAIL_FUNCIONAL:PCD:CELULAR:TELEFONE_RECADOS:COD_VAGA:EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:'
||'CARGO:DT_ADMISSAO:SITUACAO:ENDERECO:BAIRRO:CIDADE:UF:IDADE:SEXO:GENERO:CNH:QUALIFICACAO:GRAU_INSTRUCAO:FORMACAO:CURSOS:IDIOMAS:HABILIDADE:EMPREGOS_ANTERIORES:DATA_CADASTRO:DT_ATUALIZACAO::STATUS_CANDIDATO'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(26481647564934901127)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Relat\00F3rio Resumido')
,p_report_seq=>10
,p_report_alias=>'716456'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK:EMPRESA:FILIAL:CCUSTO:UNIDADE_ADM:ATIVIDADE:COD_VAGA:CARGO:COLABORADOR:DT_ADMISSAO:SITUACAO:IDADE:SEXO:URL_LINKEDIN:QUALIFICACAO:GRAU_INSTRUCAO'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(8343764040393806249)
,p_report_id=>wwv_flow_api.id(26481647564934901127)
,p_name=>unistr('Destacar N\00E3o Cadastrados')
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'STATUS'
,p_operator=>'='
,p_expr=>unistr('N\00E3o Cadastrado')
,p_condition_sql=>' (case when ("STATUS" = #APXWS_EXPR#) then #APXWS_HL_ID# end) '
,p_condition_display=>unistr('#APXWS_COL_NAME# = ''N\00E3o Cadastrado''  ')
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_bg_color=>'#FFDD44'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28187029653224156732)
,p_plug_name=>'Candidatos'
,p_icon_css_classes=>'fa-search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34420052045842074877)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('<p>Pesquise os candidatos que est\00E3o no Banco de Talentos</p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343696461558806153)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'VAGA'
,p_button_static_id=>'VAGA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Vaga'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-cube'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343696886352806154)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'DADOS_PESSOAIS'
,p_button_static_id=>'DADOS_PESSOAIS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Dados Pessoais'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343697253844806155)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'FORMACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>unistr('Forma\00E7\00E3o')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-user-graduate'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343697631348806155)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'CURSOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Cursos'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-book'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343698050685806157)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'IDIOMA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Idioma'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-language'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343698455561806158)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'HABILIDADE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Habilidade'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-heart-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343698809145806158)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'RESIDENCIA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>unistr('Resid\00EAncia')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-home'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343699276667806158)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'NACIONALIDADE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'Nacionalidade'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-flag-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343699635933806158)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'PCD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_image_alt=>'PCD'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-universal-access'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343700055915806159)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_button_name=>'APPLY_FILTER'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343765797824806255)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(8415090079819324871)
,p_button_name=>'PS_VOLTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343741432956806215)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_button_name=>'VAGA_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343702767999806167)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_button_name=>'FORM_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343706265667806170)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_button_name=>'CURSO_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343708975466806173)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670600784816399)
,p_button_name=>'IDIOMA_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343711191383806175)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670616503816400)
,p_button_name=>'HABILIDADE_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343713497476806177)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_button_name=>'RESID_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343716602695806183)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26164670858171816402)
,p_button_name=>'NACIONAL_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343765423620806254)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(8415090079819324871)
,p_button_name=>'PS_INCLUIR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Incluir'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343718553686806185)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670936477816403)
,p_button_name=>'PCD_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343720433407806187)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_button_name=>'PESS_CLEAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Limpar Filtro'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343703102672806168)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_button_name=>'FORM_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343706677552806171)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_button_name=>'CURSO_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343709326171806173)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670600784816399)
,p_button_name=>'IDIOMA_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343711627797806175)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670616503816400)
,p_button_name=>'HABILIDADE_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343713899173806177)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_button_name=>'RESID_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343717046333806183)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670858171816402)
,p_button_name=>'NACIONAL_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343718950066806185)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164670936477816403)
,p_button_name=>'PCD_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343741798952806215)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_button_name=>'VAGA_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343720797749806187)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_button_name=>'PESS_OK'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343721221137806187)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_button_name=>'PESS_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343703509224806168)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_button_name=>'FORM_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343707066530806171)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_button_name=>'CURSO_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343709697956806174)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670600784816399)
,p_button_name=>'IDIOMA_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343712014760806175)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670616503816400)
,p_button_name=>'HABILIDADE_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343714350074806178)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_button_name=>'RESID_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343717431046806184)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26164670858171816402)
,p_button_name=>'NACIONAL_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343742228426806216)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_button_name=>'VAGA_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343719290742806186)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(26164670936477816403)
,p_button_name=>'PCD_CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34420074412528074924)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343740314515806214)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26165355174515487594)
,p_button_name=>'ADD_CANDIDATOS_PS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Incluir em Processo'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8343764422478806249)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(26475633320753203035)
,p_button_name=>'ADD_FUNC_PS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Incluir em Processo'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8344688423872225910)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(26165355174515487594)
,p_button_name=>'Cadastrar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(34420074586248074924)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cadastrar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=RS_PRC_&P_BASE.:39:&SESSION.::&DEBUG.:RP,39::'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT NVL(per_alt_dados_cand,''N'') PERMITE',
'  FROM CONFIGURACOES;',
'  ',
'V_C1 C1%ROWTYPE;',
'',
'BEGIN',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF V_C1.PERMITE = ''S'' THEN',
'   RETURN TRUE;',
'  ELSE',
'   RETURN FALSE;',
'  END IF;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343700406345806159)
,p_name=>'P182_COLLECTION_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343700821815806164)
,p_name=>'P182_SELECTED_N'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343701261036806165)
,p_name=>'P182_TIPO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_prompt=>'Tipo de Candidato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Externo;E,Interno;I,Selecionados;S'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-bottom-sm'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343701658454806166)
,p_name=>'P182_PERIODO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_item_default=>'7'
,p_prompt=>'Cadastrado / Atualizado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:\00DAltimos 7 Dias;7,\00DAltimos 15 Dias;15,\00DAltimos 30 Dias;30,\00DAltimos 60 dias;60,\00DAltimos 90 Dias;90,Todo o Per\00EDodo;0')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large:margin-bottom-md'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343702042591806166)
,p_name=>'P182_INDICADO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26164112909262577738)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Indicados;S'
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343703927234806168)
,p_name=>'P182_FORM_INSTRUCAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_prompt=>unistr('Grau de Instru\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome), cod',
' from instrucao ',
'order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343704323665806168)
,p_name=>'P182_FORM_DESC'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_prompt=>unistr('Forma\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct trim(initcap(descricao)) d, upper(descricao) c',
'  from FORMACAO_ESCOLAR_CANDIDATO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343704697697806169)
,p_name=>'P182_FORM_ENTIDADE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_prompt=>'Entidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct trim(initcap(entidade)) d, upper(entidade) c',
'  from FORMACAO_ESCOLAR_CANDIDATO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343705171781806169)
,p_name=>'P182_FORM_TURNO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_prompt=>'Turno'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>unistr('STATIC:Manh\00E3;M,Tarde;T,Noite;N,Integral;I')
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343705555501806170)
,p_name=>'P182_FORM_STATUS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(26164670310199816397)
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343707394957806171)
,p_name=>'P182_CURSO_DESC'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_prompt=>'Curso'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct trim(initcap(descricao)) d, upper(descricao) c',
'  from CURSO_CANDIDATO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343707820811806172)
,p_name=>'P182_CURSO_LOCAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_prompt=>'Entidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct trim(initcap(LOCAL)) d, upper(LOCAL) c',
'  from CURSO_CANDIDATO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343708230154806172)
,p_name=>'P182_CURSO_CONCLUSAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(26164670445008816398)
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343710111132806174)
,p_name=>'P182_IDIOMA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670600784816399)
,p_prompt=>'Idioma'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(descricao), codigo',
'  from idioma',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343710506185806174)
,p_name=>'P182_IDIOMA_NIVEL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26164670600784816399)
,p_prompt=>unistr('N\00EDvel de Conhecimento')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(DESCRICAO), CODIGO ',
'  FROM NIVEL_CONHECIMENTO',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343712395751806176)
,p_name=>'P182_HABILIDADE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670616503816400)
,p_prompt=>'Habilidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(DESCRICAO) descricao, CODIGO',
'  FROM HABILIDADE',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343712884985806176)
,p_name=>'P182_HABILIDADE_NIVEL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26164670616503816400)
,p_prompt=>unistr('N\00EDvel de Conhecimento')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(DESCRICAO), CODIGO ',
'  FROM NIVEL_CONHECIMENTO',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343714750259806178)
,p_name=>'P182_RESID_PAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_prompt=>unistr('Pa\00EDs')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao, codigo',
'  from paises_es',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>7
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343715099977806180)
,p_name=>'P182_RESID_UF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_prompt=>'UF'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(nome)||'' (''||sigla||'')'' descricao, sigla',
'  FROM UF',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343715526031806180)
,p_name=>'P182_RESID_CIDADE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_prompt=>'Cidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(c.cidade) d, upper(c.cidade) c',
'  from tabela_cep c',
'where ((instr('',''||:p182_resid_uf||'','','',''||c.uf||'','') > 0) or (:p182_resid_uf is null))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_RESID_UF'
,p_ajax_items_to_submit=>'P182_RESID_UF'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343715956554806181)
,p_name=>'P182_RESID_BAIRRO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26164670740577816401)
,p_prompt=>'Bairro'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(c.bairro) d, upper(c.bairro) c',
'  from tabela_cep c',
'where ((instr('',''||:p182_resid_uf||'','','',''||c.uf||'','') > 0) or (:p182_resid_uf is null))',
'  and ((instr('',''||:p182_resid_cidade||'','','',''||c.cidade||'','') > 0) or (:p182_resid_cidade is null))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_RESID_UF,P182_RESID_CIDADE'
,p_ajax_items_to_submit=>'P182_RESID_UF,P182_RESID_CIDADE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343717827968806184)
,p_name=>'P182_NACIONAL_PAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670858171816402)
,p_prompt=>'Nacionalidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descricao), codigo',
'  from paises_es',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343719696308806186)
,p_name=>'P182_PCD_POSSUI'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164670936477816403)
,p_prompt=>'Possui PCD'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343721679476806187)
,p_name=>'P182_PESS_COD_CANDIDATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'Codigo Candidato'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(p.nome)||'' (''||p.cod_candidato||'')''||case when p.e_mail is not null then '' - ''||lower(p.e_mail) end||'' - Dt. Cadastro: ''||p.data_cadastro descricao, p.cod_candidato cod',
'  from inf_pessoais_candidato_cad p',
' order by P.NOME'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343722036070806188)
,p_name=>'P182_PESS_NOME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'Nome'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343722435023806188)
,p_name=>'P182_PESS_EMAIL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'E-Mail'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343722802981806188)
,p_name=>'P182_PESS_IDADE_MIN'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>unistr('Idade M\00EDnima')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343723271774806189)
,p_name=>'P182_PESS_IDADE_MAX'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>unistr('Idade M\00E1xima')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343723612326806189)
,p_name=>'P182_PESS_SEXO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'Sexo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Masculino;M,Feminino;F'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>7
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343724026863806189)
,p_name=>'P182_PESS_ESTADO_CIVIL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'Estado Civil'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome), cod',
'  from estado_civil',
'  order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343724453843806190)
,p_name=>'P182_PESS_DEPENDENTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(26164671126044816405)
,p_prompt=>'Possui Dependente'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>7
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343740733707806214)
,p_name=>'P182_PESQUISA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26165355174515487594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343742677249806216)
,p_name=>'P182_PS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>unistr('N\00BA Processo Seletivo')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'9999999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343742993690806216)
,p_name=>'P182_UTILIZA_SECAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343743429703806217)
,p_name=>'P182_VAGA_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343743840294806217)
,p_name=>'P182_VAGA_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(sigla) descricao, cod_filial',
'  from filiais ',
'where ((instr('';''||:p182_vaga_empresa||'';'','';''||cod_empresa||'';'') > 0) or (:p182_vaga_empresa is null))',
'and encer_ativ = ''N''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_VAGA_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343744262378806217)
,p_name=>'P182_VAGA_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(cod_empresa, cod_ccusto)) descricao, cod_ccusto ',
'from filial_ccusto',
'where ((instr('';''||:p182_vaga_empresa||'';'','';''||cod_empresa||'';'') > 0) or (:p182_vaga_empresa is null))',
'and ((instr('';''||:p182_vaga_filial||'';'','';''||cod_filial||'';'') > 0) or (:p182_vaga_filial is null))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343744611980806218)
,p_name=>'P182_VAGA_UNIDADE_ADM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('';''||:p182_vaga_empresa||'';'','';''||a.cod_empresa||'';'') > 0) or (:p182_vaga_empresa is null))',
'       and ((instr('';''||:p182_vaga_filial||'';'','';''||a.cod_filial||'';'') > 0) or (:p182_vaga_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p182_vaga_ccusto',
'       and ((instr('';''||:p182_vaga_ccusto||'';'','';''||s.cod_ccusto||'';'') > 0) or (:p182_vaga_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p182_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('';''||:p182_vaga_empresa||'';'','';''||a.cod_empresa||'';'') > 0) or (:p182_vaga_empresa is null))',
'       and ((instr('';''||:p182_vaga_filial||'';'','';''||a.cod_filial||'';'') > 0) or (:p182_vaga_filial is null))',
'       and :p182_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL,P182_VAGA_CCUSTO,P182_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343745083180806219)
,p_name=>'P182_VAGA_ATIVIDADE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('';''||:p182_vaga_ccusto||'';'','';''||s.cod_ccusto||'';'') > 0) or (:p182_vaga_empresa is null))',
'   and ((instr('';''||:p182_vaga_unidade_adm||'';'','';''||s.cod_unid_adm||'';'') > 0) or (:p182_vaga_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p182_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p182_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P182_VAGA_CCUSTO,P182_VAGA_UNIDADE_ADM,P182_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343745402751806219)
,p_name=>'P182_VAGA_CARGO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(26165578985853721618)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.nome) descricao, t.cod cod',
'  from cargos t',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>12
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(34420073971924074917)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(8343766218352806255)
,p_name=>'P182_PROCESSO_SELETIVO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(8415090079819324871)
,p_prompt=>'Processo Seletivo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_PS_ABERTOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sele.COD_PROCESSO',
'      ,sele.cod_processo processo_seletivo',
'      , INITCAP(FNC_RETORNA_DADOS_CARGO(SELE.COD_CARGO,''NOME''))||'' (''||sele.COD_PROCESSO||'')'' CARGO',
'      ,SELE.COD_EMPRESA',
'      ,(SELECT l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end descricao',
'      FROM local_trab l',
'      , filial_local f',
'     WHERE l.cod_local_trab = f.cod_local_filial',
'       and l.cod_local_trab = r.COD_LOCAL_TRAB',
'       and f.COD_EMPRESA = sele.COD_EMPRESA',
'       fetch first 1 rows only) COD_LOCAL_TRAB',
'      ,INITCAP(FNCT_NOME_EMPRESA(SELE.COD_EMPRESA,''S'')) Empresa',
'      ,INITCAP(FNCT_NOME_FILIAL(SELE.COD_EMPRESA,SELE.COD_FILIAL,''S'')) Filial',
'      ,SELE.COD_CCUSTO||''-''||initcap(fnct_nome_ccusto(sele.cod_empresa, SELE.COD_CCUSTO)) Centro_Custo',
'      ,R.COD_UNIDADE_ADM||'' - ''||initcap(fnct_nome_unidade_adm(r.cod_empresa, r.cod_filial, R.COD_UNIDADE_ADM)) Unidade_Adm',
'      ,case when sele.cod_prest_serv is not null then sele.cod_prest_serv||'' - ''|| (SELECT p2.nome FROM prestador_servico p2 WHERE p2.tipo_prest_serv = sele.tipo_prest_serv AND p2.cod_prest_serv = sele.cod_prest_serv) end selecionador',
'      ,INITCAP((SELECT pkg_Selecao.fnc_RetFaseProcessoAtual(sele.COD_PROCESSO, ''D'') FROM dual)) Fase_Processo',
'      ,((SELECT COUNT(COD_CANDIDATO) COD_CANDIDATO FROM (SELECT MAX(COD_FASE) COD_FASE ,COD_CANDIDATO FROM candidato cand where cand.cod_processo = SELE.COD_PROCESSO GROUP BY COD_CANDIDATO) cand)) Quantidade_Candidatos',
'	  , case when R.TIPO_PUBLICACAO = ''I'' THEN ''Interna''',
'             when R.TIPO_PUBLICACAO = ''E'' THEN ''Externa'' else ''Todas'' end TIPO_PUBLICACAO',
', (SELECT INITCAP(MOTR.DESCRICAO) DESCRICAO FROM TIPO_MODALIDADE_TRAB  MOTR WHERE ATIVO = ''S'' AND r.TIPO_MODALIDADE = motr.TIPO_MODALIDADE fetch first 1 rows only)  TIPO_MODALIDADE',
'      ,(select a.cod||'' - ''||Initcap(a.nome) descricao from vinculo_empreg a WHERE a.cod = R.vinculo fetch first 1 rows only) VINCULO_REQ',
'      ,to_char(SELE.DT_APROVACAO,''dd/mm/rrrr'') Prazo_Inicial',
'      ,case when r.VINCULO is not null then (select distinct a.cod||'' - ''||Initcap(a.nome) descricao',
'                                                from vinculo_empreg a',
'                                                where A.COD = r.VINCULO) end vinculo',
unistr('      ,to_char(SELE.DT_FECHAMENTO,''dd/mm/rrrr'') Prazo_Contrata\00E7\00E3o'),
' from PS_PROCESSO_SELETIVO SELE',
'    , requisicao R ',
'where  R.COD_REQ = SELE.COD_PROCESSO',
'  AND  R.COD_SIT_REQ = 5',
'  AND  NVL(R.VAGA_CONFIDENCIAL,''N'') = ''N''',
'ORDER BY SELE.COD_REQ DESC'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25105369466273054084)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'700'
);
end;
/
begin
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(8343766712762806261)
,p_computation_sequence=>10
,p_computation_item=>'P182_COLLECTION_NAME'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'CHECKBOX_182'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343773775532806272)
,p_name=>'Open Dados Pessoais'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343696886352806154)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343774281516806273)
,p_event_id=>wwv_flow_api.id(8343773775532806272)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164671126044816405)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343774649406806274)
,p_name=>'Open Vaga'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343696461558806153)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343775137996806274)
,p_event_id=>wwv_flow_api.id(8343774649406806274)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26165578985853721618)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343834428474806314)
,p_name=>'Open PS'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343740314515806214)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343834929235806314)
,p_event_id=>wwv_flow_api.id(8343834428474806314)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(8415090079819324871)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343831765267806312)
,p_name=>'Open PS Func'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343764422478806249)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343832281920806313)
,p_event_id=>wwv_flow_api.id(8343831765267806312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(8415090079819324871)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343775556264806274)
,p_name=>'Open PCD'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343699635933806158)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343776023523806275)
,p_event_id=>wwv_flow_api.id(8343775556264806274)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670936477816403)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343776467046806275)
,p_name=>'Open Nacionalidade'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343699276667806158)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343776902837806275)
,p_event_id=>wwv_flow_api.id(8343776467046806275)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670858171816402)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343777337730806275)
,p_name=>'Open Residencia'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343698809145806158)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343777882482806276)
,p_event_id=>wwv_flow_api.id(8343777337730806275)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670740577816401)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343778239457806276)
,p_name=>'Open Habilidade'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343698455561806158)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343778732374806276)
,p_event_id=>wwv_flow_api.id(8343778239457806276)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670616503816400)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343779105107806276)
,p_name=>'Open Idioma'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343698050685806157)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343779629751806277)
,p_event_id=>wwv_flow_api.id(8343779105107806276)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670600784816399)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343780045362806277)
,p_name=>'Open Cursos'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343697631348806155)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343780577909806277)
,p_event_id=>wwv_flow_api.id(8343780045362806277)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670445008816398)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343780939306806277)
,p_name=>'Open Formacao'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343697253844806155)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343781483511806278)
,p_event_id=>wwv_flow_api.id(8343780939306806277)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670310199816397)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343781824925806278)
,p_name=>'CLEAR_PESS'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343720433407806187)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343782323770806279)
,p_event_id=>wwv_flow_api.id(8343781824925806278)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PESS_IDADE_MIN,P182_PESS_IDADE_MAX,P182_PESS_SEXO,P182_PESS_ESTADO_CIVIL,P182_PESS_DEPENDENTE,P182_PESS_NOME,P182_PESS_EMAIL,P182_PESS_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343782727303806279)
,p_name=>'CLEAR_VAGA'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343741432956806215)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343783248888806280)
,p_event_id=>wwv_flow_api.id(8343782727303806279)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL,P182_VAGA_CCUSTO,P182_VAGA_UNIDADE_ADM,P182_VAGA_ATIVIDADE,P182_UTILIZA_SECAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343783644599806280)
,p_name=>'CLOSE_PESS'
,p_event_sequence=>140
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343721221137806187)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343784151453806280)
,p_event_id=>wwv_flow_api.id(8343783644599806280)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PESS_IDADE_MIN,P182_PESS_IDADE_MAX,P182_PESS_SEXO,P182_PESS_ESTADO_CIVIL,P182_PESS_DEPENDENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343784609053806280)
,p_event_id=>wwv_flow_api.id(8343783644599806280)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164671126044816405)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343785005063806281)
,p_name=>'CLOSE_VAGA'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343742228426806216)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343785573059806281)
,p_event_id=>wwv_flow_api.id(8343785005063806281)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26165578985853721618)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343786050869806281)
,p_event_id=>wwv_flow_api.id(8343785005063806281)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL,P182_VAGA_CCUSTO,P182_VAGA_UNIDADE_ADM,P182_VAGA_ATIVIDADE,P182_UTILIZA_SECAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343786393446806281)
,p_name=>'CLOSE_FORM'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343703509224806168)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343786937888806282)
,p_event_id=>wwv_flow_api.id(8343786393446806281)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670310199816397)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343787419288806282)
,p_event_id=>wwv_flow_api.id(8343786393446806281)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_FORM_INSTRUCAO,P182_FORM_DESC,P182_FORM_ENTIDADE,P182_FORM_TURNO,P182_FORM_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343787851181806282)
,p_name=>'CLOSE_CURSO'
,p_event_sequence=>170
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343707066530806171)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343788299871806282)
,p_event_id=>wwv_flow_api.id(8343787851181806282)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670445008816398)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343788856762806283)
,p_event_id=>wwv_flow_api.id(8343787851181806282)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_CURSO_DESC,P182_CURSO_LOCAL,P182_CURSO_CONCLUSAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343789198951806283)
,p_name=>'CLOSE_IDIOMA'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343709697956806174)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343789751484806283)
,p_event_id=>wwv_flow_api.id(8343789198951806283)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670600784816399)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343790214826806283)
,p_event_id=>wwv_flow_api.id(8343789198951806283)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_IDIOMA,P182_IDIOMA_NIVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343790603730806284)
,p_name=>'CLOSE_HABILIDADE'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343712014760806175)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343791122293806284)
,p_event_id=>wwv_flow_api.id(8343790603730806284)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670616503816400)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343791641504806284)
,p_event_id=>wwv_flow_api.id(8343790603730806284)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_HABILIDADE,P182_HABILIDADE_NIVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343791997021806284)
,p_name=>'CLOSE_RESIDENCIA'
,p_event_sequence=>200
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343714350074806178)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343792576927806285)
,p_event_id=>wwv_flow_api.id(8343791997021806284)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670740577816401)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343793057611806286)
,p_event_id=>wwv_flow_api.id(8343791997021806284)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_RESID_UF,P182_RESID_CIDADE,P182_RESID_BAIRRO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343793483094806286)
,p_name=>'CLOSE_NACIONALIDADE'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343717431046806184)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343793971212806286)
,p_event_id=>wwv_flow_api.id(8343793483094806286)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670858171816402)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343794479305806286)
,p_event_id=>wwv_flow_api.id(8343793483094806286)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_NACIONAL_PAIS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343794831220806287)
,p_name=>'CLOSE_PCD'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343719290742806186)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343795293664806287)
,p_event_id=>wwv_flow_api.id(8343794831220806287)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670936477816403)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343795883784806287)
,p_event_id=>wwv_flow_api.id(8343794831220806287)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PCD_POSSUI'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343770463372806269)
,p_name=>'CLOSE_PS'
,p_event_sequence=>230
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343765797824806255)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343770915306806269)
,p_event_id=>wwv_flow_api.id(8343770463372806269)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(8415090079819324871)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343796208328806287)
,p_name=>'OK_PESS'
,p_event_sequence=>240
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343720797749806187)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343796762680806288)
,p_event_id=>wwv_flow_api.id(8343796208328806287)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164671126044816405)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*apex.item( "DADOS_PESSOAIS" ).setStyle( "backgroundColor", "blue" );',
'apex.item( "DADOS_PESSOAIS" ).setStyle( "color", "white" );*/',
'this.affectedElements.dialog(''close'');'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343797126800806289)
,p_name=>'OK_VAGA'
,p_event_sequence=>250
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343741798952806215)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343797679744806289)
,p_event_id=>wwv_flow_api.id(8343797126800806289)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26165578985853721618)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*apex.item( "DADOS_PESSOAIS" ).setStyle( "backgroundColor", "blue" );',
'apex.item( "DADOS_PESSOAIS" ).setStyle( "color", "white" );*/',
'this.affectedElements.dialog(''close'');'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343798012507806289)
,p_name=>'CLEAR_FORM'
,p_event_sequence=>260
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343702767999806167)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343798554738806289)
,p_event_id=>wwv_flow_api.id(8343798012507806289)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_FORM_INSTRUCAO,P182_FORM_DESC,P182_FORM_ENTIDADE,P182_FORM_TURNO,P182_FORM_STATUS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343798962414806290)
,p_name=>'OK_FORM'
,p_event_sequence=>270
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343703102672806168)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343799481415806290)
,p_event_id=>wwv_flow_api.id(8343798962414806290)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670310199816397)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343799831143806291)
,p_name=>'CLEAR_CURSO'
,p_event_sequence=>280
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343706265667806170)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343800316154806291)
,p_event_id=>wwv_flow_api.id(8343799831143806291)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_CURSO_DESC,P182_CURSO_LOCAL,P182_CURSO_CONCLUSAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343800718084806292)
,p_name=>'OK_CURSO'
,p_event_sequence=>290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343706677552806171)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343801209561806292)
,p_event_id=>wwv_flow_api.id(8343800718084806292)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670445008816398)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343801654146806292)
,p_name=>'OK_IDIOMA'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343709326171806173)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343802108969806293)
,p_event_id=>wwv_flow_api.id(8343801654146806292)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670600784816399)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343802522329806293)
,p_name=>'CLEAR_IDIOMA'
,p_event_sequence=>310
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343708975466806173)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343803029029806293)
,p_event_id=>wwv_flow_api.id(8343802522329806293)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_IDIOMA,P182_IDIOMA_NIVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343803417571806293)
,p_name=>'OK_HABILIDADE'
,p_event_sequence=>320
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343711627797806175)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343803987721806294)
,p_event_id=>wwv_flow_api.id(8343803417571806293)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670616503816400)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343804339789806294)
,p_name=>'CLEAR_HABILIDADE'
,p_event_sequence=>330
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343711191383806175)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343804819502806294)
,p_event_id=>wwv_flow_api.id(8343804339789806294)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_HABILIDADE,P182_HABILIDADE_NIVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343805197204806295)
,p_name=>'OK_RESID'
,p_event_sequence=>340
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343713899173806177)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343805716488806295)
,p_event_id=>wwv_flow_api.id(8343805197204806295)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670740577816401)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343806166255806295)
,p_name=>'CLEAR_RESID'
,p_event_sequence=>350
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343713497476806177)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343806628019806295)
,p_event_id=>wwv_flow_api.id(8343806166255806295)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_RESID_UF,P182_RESID_CIDADE,P182_RESID_BAIRRO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343807067017806296)
,p_name=>'OK_NACIONAL'
,p_event_sequence=>360
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343717046333806183)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343807569705806296)
,p_event_id=>wwv_flow_api.id(8343807067017806296)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670858171816402)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343807918601806297)
,p_name=>'CLEAR_NACIONAL'
,p_event_sequence=>370
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343716602695806183)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343808468765806297)
,p_event_id=>wwv_flow_api.id(8343807918601806297)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_NACIONAL_PAIS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343808820199806297)
,p_name=>'CLEAR_PCD'
,p_event_sequence=>380
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343718553686806185)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343809353806806297)
,p_event_id=>wwv_flow_api.id(8343808820199806297)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PCD_POSSUI'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343809774423806298)
,p_name=>'OK_PCD'
,p_event_sequence=>390
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343718950066806185)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343810190405806298)
,p_event_id=>wwv_flow_api.id(8343809774423806298)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26164670936477816403)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343810634675806299)
,p_name=>'Pesquisa'
,p_event_sequence=>400
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343700055915806159)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343811098720806299)
,p_event_id=>wwv_flow_api.id(8343810634675806299)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p182_pesquisa := ''S'';'
,p_attribute_03=>'P182_PESQUISA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343811657747806299)
,p_event_id=>wwv_flow_api.id(8343810634675806299)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343812065319806299)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>410
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P182_VAGA_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343812524529806300)
,p_event_id=>wwv_flow_api.id(8343812065319806299)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p182_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p182_vaga_empresa||'','','',''||cod_empresa||'','') > 0) or (:p182_vaga_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P182_VAGA_EMPRESA'
,p_attribute_03=>'P182_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343812922114806300)
,p_name=>'Button Hot Vaga'
,p_event_sequence=>420
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(13295755959009163060)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_VAGA"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343813484705806300)
,p_event_id=>wwv_flow_api.id(8343812922114806300)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343813915317806301)
,p_event_id=>wwv_flow_api.id(8343812922114806300)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343814339876806301)
,p_name=>'Button Hot Dados Pessoais'
,p_event_sequence=>430
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060846812108044377)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_PESS"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343814864492806301)
,p_event_id=>wwv_flow_api.id(8343814339876806301)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343815347482806302)
,p_event_id=>wwv_flow_api.id(8343814339876806301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343815748221806302)
,p_name=>unistr('Button Hot Forma\00E7\00E3o')
,p_event_sequence=>440
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060829492193044363)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_FORM"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343816278098806302)
,p_event_id=>wwv_flow_api.id(8343815748221806302)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343816789693806302)
,p_event_id=>wwv_flow_api.id(8343815748221806302)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343817125124806303)
,p_name=>'Button Hot Cursos'
,p_event_sequence=>450
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060833041054044367)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_CURSO"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343817635956806303)
,p_event_id=>wwv_flow_api.id(8343817125124806303)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343697631348806155)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343818157695806303)
,p_event_id=>wwv_flow_api.id(8343817125124806303)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343697631348806155)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343818529989806303)
,p_name=>'Button Hot Idioma'
,p_event_sequence=>460
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060835686905044368)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_IDIOMA"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343819018307806304)
,p_event_id=>wwv_flow_api.id(8343818529989806303)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343698050685806157)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343819549685806304)
,p_event_id=>wwv_flow_api.id(8343818529989806303)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343698050685806157)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343819914451806304)
,p_name=>'Button Hot Habilidade'
,p_event_sequence=>470
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060837965618044371)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_HABILIDADE"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343820421140806305)
,p_event_id=>wwv_flow_api.id(8343819914451806304)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343698455561806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343820967390806305)
,p_event_id=>wwv_flow_api.id(8343819914451806304)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343698455561806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343821374107806305)
,p_name=>'Button Hot Residencia'
,p_event_sequence=>480
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060840260463044372)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_RESID"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343821794827806305)
,p_event_id=>wwv_flow_api.id(8343821374107806305)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343822318075806306)
,p_event_id=>wwv_flow_api.id(8343821374107806305)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343822783483806306)
,p_name=>'Button Hot Nacionalidade'
,p_event_sequence=>490
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060842965266044374)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_NACIONAL"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343823276505806306)
,p_event_id=>wwv_flow_api.id(8343822783483806306)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343699276667806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343823771878806307)
,p_event_id=>wwv_flow_api.id(8343822783483806306)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343699276667806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343824091043806307)
,p_name=>'Button Hot PCD'
,p_event_sequence=>500
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(19060844865347044375)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'!!$(''[id^="P182_PCD"]'').map(function(){',
'  return !!$(this).val() ? $(this) : undefined',
'}).length'))
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343824636178806307)
,p_event_id=>wwv_flow_api.id(8343824091043806307)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REMOVE_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343699635933806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343825103507806307)
,p_event_id=>wwv_flow_api.id(8343824091043806307)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ADD_CLASS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343699635933806158)
,p_attribute_01=>'t-Button--hot'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343825496004806308)
,p_name=>'Tipo'
,p_event_sequence=>510
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P182_TIPO'
,p_condition_element=>'P182_TIPO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'E'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343826019087806308)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343826533616806309)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343827028336806309)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL,P182_VAGA_CCUSTO,P182_VAGA_UNIDADE_ADM,P182_VAGA_ATIVIDADE,P182_PS,P182_INDICADO,P182_PESS_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343827544474806310)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_VAGA_EMPRESA,P182_VAGA_FILIAL,P182_VAGA_CCUSTO,P182_VAGA_UNIDADE_ADM,P182_VAGA_ATIVIDADE,P182_PS,P182_INDICADO,P182_PESS_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343828088583806310)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PERIODO,P182_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343828496759806310)
,p_event_id=>wwv_flow_api.id(8343825496004806308)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PERIODO,P182_INDICADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343828942171806311)
,p_name=>'Tipo - Selecionados'
,p_event_sequence=>520
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P182_TIPO'
,p_condition_element=>'P182_TIPO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343829413521806311)
,p_event_id=>wwv_flow_api.id(8343828942171806311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PS,P182_PESS_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343829940180806311)
,p_event_id=>wwv_flow_api.id(8343828942171806311)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PS,P182_PESS_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343830446855806312)
,p_event_id=>wwv_flow_api.id(8343828942171806311)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_PERIODO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343768618628806266)
,p_name=>'SELECT_CE_ALL Javascript'
,p_event_sequence=>530
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#SELECT_CE_ALL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343769135472806267)
,p_event_id=>wwv_flow_api.id(8343768618628806266)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'cb_array = document.getElementsByName(''f01'');',
'for (i=0; i<cb_array.length; i++){',
'  if ( cb_array[i].disabled == false ){',
'    cb_array[i].checked = document.getElementById("SELECT_CE_ALL").checked;',
'  }',
'}',
'$(''.checkbox_item:first'').trigger(''change'')'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343833522446806314)
,p_name=>'SELECT_CI_ALL Javascript'
,p_event_sequence=>540
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'#SELECT_CI_ALL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343834022072806314)
,p_event_id=>wwv_flow_api.id(8343833522446806314)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'cb_array = document.getElementsByName(''f01'');',
'for (i=0; i<cb_array.length; i++){',
'  if ( cb_array[i].disabled == false ){',
'    cb_array[i].checked = document.getElementById("SELECT_CI_ALL").checked;',
'  }',
'}',
'$(''.checkbox_item:first'').trigger(''change'')'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343769587907806268)
,p_name=>'Total de Selecionados'
,p_event_sequence=>550
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(26165355174515487594)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343770000536806268)
,p_event_id=>wwv_flow_api.id(8343769587907806268)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_SELECTED_N'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = :P182_COLLECTION_NAME'))
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343832610306806313)
,p_name=>'Total de Selecionados Colab'
,p_event_sequence=>560
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(26475633320753203035)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343833187467806313)
,p_event_id=>wwv_flow_api.id(8343832610306806313)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P182_SELECTED_N'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = :P182_COLLECTION_NAME'))
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343771343055806269)
,p_name=>'(Show/Hide) Add Candidato PS'
,p_event_sequence=>570
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P182_SELECTED_N'
,p_condition_element=>'P182_SELECTED_N'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343772838510806271)
,p_event_id=>wwv_flow_api.id(8343771343055806269)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343740314515806214)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343773328446806271)
,p_event_id=>wwv_flow_api.id(8343771343055806269)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343740314515806214)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343771857628806270)
,p_event_id=>wwv_flow_api.id(8343771343055806269)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343764422478806249)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343772329583806271)
,p_event_id=>wwv_flow_api.id(8343771343055806269)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(8343764422478806249)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8343830876485806312)
,p_name=>'ADD_CANDIDATO_PS'
,p_event_sequence=>580
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(8343765423620806254)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8343831367604806312)
,p_event_id=>wwv_flow_api.id(8343830876485806312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'ADD_CANDIDATO_PS'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(8201355906874255536)
,p_name=>'Total de Selecionados Cand Selec'
,p_event_sequence=>590
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(17046056391182373984)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(8201356019424255537)
,p_event_id=>wwv_flow_api.id(8201355906874255536)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P183_SELECTED_N'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select count(*)',
'  from apex_collections',
' where collection_name = :P183_COLLECTION_NAME'))
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8343767834626806264)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ADD CANDIDATO PS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_COD_CANDIDATO VARCHAR2(2000);',
'V_ROWID_CAND    VARCHAR2(4000);',
'V_ULT_COD_FASE  VARCHAR2(2000);',
'V_CAND_ERROR    VARCHAR2(4000) := NULL;',
'V_NOME_CANDIDATO   VARCHAR2(4000) := NULL;',
'',
'V_ERRO VARCHAR2(4000);',
'',
'CURSOR C_REQ (V_PS NUMBER) is',
'select cod_req, cod_empresa, cod_cargo cargo',
'  from requisicao',
' where cod_req = v_ps;',
' ',
'v_req c_req%rowtype;',
'',
'cursor c0 (v_cod number) is',
'select ''S'' existe',
'  from candidato',
' where cod_candidato = v_cod',
'   and cod_processo = :p182_processo_seletivo;',
'   ',
'v_c0 c0%rowtype;',
'',
'cursor c1 (v_cod number) is',
'select i.cod_empresa, i.matricula, p.cod_candidato',
'  from inf_pessoais_cad p,',
'       informacoes_funcionais_cad i',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.situacao < ''90''',
'   and p.cod_candidato = v_cod;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_cod number) is',
'select empresa cod_empresa, cod_candidato',
'  from inf_pessoais_candidato p',
' where cod_candidato = v_cod;',
'   ',
'v_c2 c2%rowtype;',
'',
'BEGIN',
'',
'open c_req(:p182_processo_seletivo);',
'fetch c_req into v_req;',
'close c_req;',
'',
'   for i in (',
'    select n001 as cod_candidato',
'      from apex_collections',
'     where collection_name = :P182_COLLECTION_NAME',
'  ) loop',
'      ',
'      v_c0 := null;',
'      ',
'      open c0(i.cod_candidato);',
'      fetch c0 into v_c0;',
'      close c0;',
'',
'      if nvl(v_c0.existe,''N'') = ''N'' then',
'',
'      v_c1 := null;',
'      ',
'      open c1(i.cod_candidato);',
'      fetch c1 into v_c1;',
'      close c1;',
'      ',
'      if v_c1.matricula is null then',
'      ',
'        v_c2 := null;',
'',
'        open c2(i.cod_candidato);',
'        fetch c2 into v_c2;',
'        close c2;',
'',
'          UPDATE INF_FUNC_CANDIDATO',
'             SET COD_EMPRESA = v_req.cod_empresa',
'           WHERE COD_CANDIDATO = v_c2.cod_candidato;',
'',
'          COMMIT;',
'',
'          UPDATE INF_PESSOAIS_CANDIDATO',
'             SET EMPRESA = v_req.cod_empresa',
'           WHERE COD_CANDIDATO = v_c2.cod_candidato;',
'',
'          COMMIT;',
'',
'          insert into RP_CAND_INSCRITOS (cod_req, cod_empresa, cod_candidato, cod_cargo, usuario, dt_atualizacao)',
'          values',
'          (:P182_PROCESSO_SELETIVO, v_req.cod_empresa, v_c2.cod_candidato, v_req.CARGO, :p_usuario, sysdate);',
'',
'          commit;',
'',
'          BEGIN',
'               Insert into CANDIDATO (COD_EMPRESA',
'                                 ,    COD_CANDIDATO',
'                                 ,    COD_FASE',
'                                 ,    DATE_FASE',
'                                 ,    COD_PREST_SERV_AVALIADOR',
'                                 ,    USUARIO',
'                                 ,    DT_ATUALIZACAO',
'                                 ,    COD_AVAL_FASE',
'                                 ,    DATA_AVAL_FASE',
'                                 ,    IND_AVAL_FASE',
'                                 ,    MOT_AVAL_FASE',
'                                 ,    RESULTADO_FASE',
'                                 ,    COD_REQ',
'                                 ,    COD_PROCESSO',
'                                 ,    COD_VAGA',
'                                 ,    COD_EMP_CAND',
'                                 ,    CHECK_APROV) ',
'               values (v_req.cod_empresa--COD_EMPRESA',
'                ,      v_c2.cod_candidato				--COD_CANDIDATO',
'                ,      ''1''						--COD_FASE',
'                ,      to_date(SYSDATE,''DD/MM/RR'') --DATE_FASE',
'                ,      NULL			             --COD_PREST_SERV_AVALIADOR',
'                ,      :P_USUARIO		             --USUARIO',
'                ,      to_date(SYSDATE,''DD/MM/RR'')--DT_ATUALIZACAO',
'                ,      ''01''						--COD_AVAL_FASE',
'                ,      to_date(SYSDATE,''DD/MM/RR'')--DATA_AVAL_FASE',
'                ,      ''9''						--IND_AVAL_FASE',
'                ,      null						--MOT_AVAL_FASE',
'                ,      ''OK''						--RESULTADO_FASE',
'                ,      :P182_PROCESSO_SELETIVO			--COD_REQ',
'                ,      :P182_PROCESSO_SELETIVO			--COD_PROCESSO',
'                ,      null						--COD_VAGA',
'                ,      V_REQ.COD_EMPRESA				--COD_EMP_CAND',
'                ,      ''N'');						--CHECK_APROV',
'            COMMIT;',
'',
'          END;',
'    ',
'      else',
'      ',
'',
'    UPDATE INF_FUNC_CANDIDATO',
'       SET COD_EMPRESA = V_REQ.COD_EMPRESA',
'     WHERE COD_CANDIDATO = V_C1.COD_CANDIDATO;',
'',
'    COMMIT;',
'',
'    UPDATE INF_PESSOAIS_CANDIDATO',
'       SET EMPRESA = V_REQ.COD_EMPRESA',
'     WHERE COD_CANDIDATO = V_C1.COD_CANDIDATO;',
'',
'    COMMIT;',
'',
'    ',
'    insert into RP_FUNC_INSCRITOS (cod_req, cod_empresa, matricula, dt_inscricao, cod_cargo, usuario, dt_atualizacao)',
'    values',
'    (:P182_PROCESSO_SELETIVO, v_c1.cod_empresa, v_c1.matricula, sysdate, V_REQ.cargo, :p_usuario, sysdate);',
'',
'    commit;',
'    ',
'',
'    BEGIN',
'         Insert into CANDIDATO (COD_EMPRESA',
'                           ,    COD_CANDIDATO',
'                           ,    COD_FASE',
'                           ,    DATE_FASE',
'                           ,    COD_PREST_SERV_AVALIADOR',
'                           ,    USUARIO',
'                           ,    DT_ATUALIZACAO',
'                           ,    COD_AVAL_FASE',
'                           ,    DATA_AVAL_FASE',
'                           ,    IND_AVAL_FASE',
'                           ,    MOT_AVAL_FASE',
'                           ,    RESULTADO_FASE',
'                           ,    COD_REQ',
'                           ,    COD_PROCESSO',
'                           ,    COD_VAGA',
'                           ,    COD_EMP_CAND',
'                           ,    CHECK_APROV) ',
'         values (v_req.cod_empresa--COD_EMPRESA',
'          ,      v_c1.cod_candidato				--COD_CANDIDATO',
'          ,      ''1''						--COD_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'') --DATE_FASE',
'          ,      NULL			             --COD_PREST_SERV_AVALIADOR',
'          ,      :P_USUARIO		             --USUARIO',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DT_ATUALIZACAO',
'          ,      ''01''						--COD_AVAL_FASE',
'          ,      to_date(SYSDATE,''DD/MM/RR'')--DATA_AVAL_FASE',
'          ,      ''9''						--IND_AVAL_FASE',
'          ,      null						--MOT_AVAL_FASE',
'          ,      ''OK''						--RESULTADO_FASE',
'          ,      :p182_processo_seletivo			--COD_REQ',
'          ,      :p182_processo_seletivo			--COD_PROCESSO',
'          ,      null						--COD_VAGA',
'          ,      v_req.cod_empresa				--COD_EMP_CAND',
'          ,      ''N'');						--CHECK_APROV',
'      COMMIT;',
'',
'    END;',
'',
'      end if;',
'   ',
'   end if;',
'   ',
'       pkg_Selecao.prc_InsCandidatosEscolhidos_PS(pCodProcesso     => :P182_processo_seletivo',
'                                              ,pCodSelecionador => null',
'                                              ,pUser            => :P_USUARIO',
'                                              ,pMsg             => V_ERRO);',
'   ',
'  end loop;',
'  ',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'ADD_CANDIDATO_PS'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Adicionado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8343768244866806265)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Itens'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p182_tipo is null then ',
':p182_tipo := ''E'';',
'end if;',
'',
'if :P182_PESQUISA is null then',
'-- :P182_PESQUISA := ''N'';',
':P182_PESQUISA := ''S'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8343767476357806264)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Clear Collection'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'apex_collection.create_or_truncate_collection(p_collection_name => :P182_COLLECTION_NAME);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(8343767050510806263)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'salvar_ids'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_json    varchar2(32767) := apex_application.g_x01;',
'  l_id      varchar2(255);',
'  l_checked varchar2(255);',
'  --',
'  l_seq_id     apex_collections.seq_id%type;',
'  l_collection apex_collections.collection_name%type := :P182_COLLECTION_NAME;',
'begin',
'  if l_json is not null then',
'    apex_json.parse(l_json);',
'    for i in 1 .. apex_json.get_count(p_path => ''.'') loop',
'      l_id      := apex_json.get_varchar2(p_path => ''[%d].id'', p0 => i);',
'      l_checked := apex_json.get_varchar2(p_path => ''[%d].checked'', p0 => i);',
'',
'      begin',
'        select seq_id',
'          into l_seq_id',
'          from apex_collections',
'         where collection_name = l_collection',
'           and n001            = l_id;',
'',
'        -- existe',
'        if l_checked = ''false'' then',
'          apex_collection.delete_member (',
'            p_collection_name => l_collection,',
'            p_seq             => l_seq_id',
'          );',
'        end if;',
'      exception when no_data_found then',
'        if l_checked = ''true'' then',
'          apex_collection.add_member (',
'            p_collection_name => l_collection,',
'            p_n001            => l_id',
'          );',
'        end if;',
'      end;',
'    end loop;',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
