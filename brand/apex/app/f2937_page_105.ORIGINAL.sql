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
,p_default_application_id=>2937
,p_default_id_offset=>795299883281732340
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   03:22 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 105
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00105
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>105);
end;
/
prompt --application/pages/page_00105
begin
wwv_flow_api.create_page(
 p_id=>105
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Avalia\00E7\00E3o M\00E9dica')
,p_step_title=>unistr('Avalia\00E7\00E3o M\00E9dica')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20231018161655'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167570576208812430849)
,p_plug_name=>unistr('Question\00E1rio')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P105_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(137347993139342725378)
,p_plug_name=>'Perguntas '
,p_parent_plug_id=>wwv_flow_api.id(167570576208812430849)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noBorder:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.ROWID IdRow1',
'      ,x.numero_ordem',
'      ,x.cod_questionario',
'      ,x.cod_questao',
'      ,x.cod_formacao',
'      ,CASE WHEN LENGTH(X.NUMERO_ORDEM) = 2 THEN ',
'      (SELECT LPAD(x.numero_ordem,2,''0'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_questao,1,150)||''[...]'' ELSE q.nome_questao END) FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO) ',
'     ',
'      WHEN LENGTH(X.NUMERO_ORDEM) = 4 THEN ',
'      (SELECT SUBSTR(x.numero_ordem,0,''2'')||''.''||SUBSTR(x.numero_ordem,3,''2'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_questao,1,150)||''[...]'' ELSE q.nome_questao END) FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AN'
||'D Q.COD_FORMACAO = X.COD_FORMACAO) ',
'     ',
'      WHEN LENGTH(X.NUMERO_ORDEM) = 6 THEN ',
'      (SELECT SUBSTR(x.numero_ordem,0,''2'')||''.''||SUBSTR(x.numero_ordem,3,''2'')||''.''||SUBSTR(x.numero_ordem,5,''2'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_questao,1,150)||''[...]'' ELSE q.nome_questao END) FROM questoes_1 q WHE'
||'RE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO) ',
'     ',
'     WHEN LENGTH(X.NUMERO_ORDEM) = 8 THEN ',
'      (SELECT SUBSTR(x.numero_ordem,0,''2'')||''.''||SUBSTR(x.numero_ordem,3,''2'')||''.''||SUBSTR(x.numero_ordem,5,''2'')||''.''||SUBSTR(x.numero_ordem,7,''2'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_questao,1,150)||''[...]'' ELSE q.nome'
||'_questao END) FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO) ',
'     ',
'     WHEN LENGTH(X.NUMERO_ORDEM) = 10 THEN ',
'      (SELECT SUBSTR(x.numero_ordem,0,''2'')||''.''||SUBSTR(x.numero_ordem,3,''2'')||''.''||SUBSTR(x.numero_ordem,5,''2'')||''.''||SUBSTR(x.numero_ordem,7,''2'')||''.''||SUBSTR(x.numero_ordem,9,''2'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_'
||'questao,1,150)||''[...]'' ELSE q.nome_questao END) FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO) ',
'     ',
'       END questao',
'      --,(SELECT LPAD(x.numero_ordem,2,''0'')||'' - ''||(CASE WHEN LENGTH(q.nome_questao) > 150 THEN SUBSTR(q.nome_questao,1,150)||''[...]'' ELSE q.nome_questao END) FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO)'
||' questao',
unistr('      ,(SELECT DECODE(q.IND_LIVRE, ''N'',''M\00FAltipla Escolha'', ''S'',''Dissertativa'') FROM questoes_1 q WHERE q.cod_questao = x.cod_questao AND Q.COD_FORMACAO = X.COD_FORMACAO) tipo'),
'      ,NVL((SELECT''Resposta: ''||NVL(DECODE((SELECT NVL(q.IND_LIVRE,''N'') FROM questoes_1 q WHERE q.cod_questao = r.cod_questao AND Q.COD_FORMACAO = R.COD_FORMACAO)',
'                                  ,''N'',(SELECT UPPER(r1.nome_resposta) FROM RESPOSTA_1 r1 WHERE r1.cod_resposta = r.cod_resposta AND r1.COD_FORMACAO = R.COD_FORMACAO)',
'                                  ,''S'',(CASE WHEN LENGTH(r.RESP_TEXTO_LIVRE) > 70 THEN SUBSTR(r.RESP_TEXTO_LIVRE,1,70)||''[...]'' ELSE r.RESP_TEXTO_LIVRE END)),''-'')',
'          FROM avaliacao_medica_respostas r',
'         WHERE r.cod_formacao         = :P105_COD_FORMACAO',
'           AND r.cod_questionario = :P105_COD_QUESTIONARIO',
'           AND r.cod_questao      = x.cod_questao',
'           AND R.MATRICULA        = :P105_MATRICULA',
'           AND R.DATA_AVALIACAO   = :P105_DATA_AVALIACAO),''-'') resposta',
'           ,(SELECT COD_RESPOSTA ',
'           FROM avaliacao_medica_respostas r',
'         WHERE r.cod_formacao         = :P105_COD_FORMACAO',
'           AND r.cod_questionario = :P105_COD_QUESTIONARIO',
'           AND r.cod_questao      = x.cod_questao',
'           AND R.MATRICULA        = :P105_MATRICULA',
'           AND R.DATA_AVALIACAO   = :P105_DATA_AVALIACAO) COD_RESPOSTA',
'      ,(SELECT r2.ROWID',
'        FROM avaliacao_medica_respostas R2',
'       WHERE r2.cod_formacao         = :P105_COD_FORMACAO',
'         AND r2.cod_questionario = :P105_COD_QUESTIONARIO',
'         AND r2.cod_questao      = x.cod_questao',
'         AND R2.MATRICULA        = :P105_MATRICULA',
'         AND R2.DATA_AVALIACAO   = :P105_DATA_AVALIACAO) IdRow6   ',
'  FROM questionario_questoes2_1 x',
' WHERE x.cod_questionario = :P105_COD_QUESTIONARIO',
'   AND x.cod_formacao         = :P105_COD_FORMACAO',
'ORDER BY 2;'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_ajax_items_to_submit=>'P105_COD_FORMACAO,P105_COD_QUESTIONARIO,P105_MATRICULA,P105_DATA_AVALIACAO'
,p_plug_query_num_rows=>25
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'QUESTAO'
,p_attribute_06=>'RESPOSTA'
,p_attribute_08=>'TIPO'
,p_attribute_16=>'f?p=&APP_ID.:102:&SESSION.::&DEBUG.:RP,102:P102_ROWID_QUESTQ2,P102_COD_EMPRESA,P102_COD_FORMACAO,P102_COD_QUESTAO,P102_COD_QUESTIONARIO,P102_DATA_AVALIACAO,P102_MATRICULA,P102_TIPO_AVALIADO,P102_NUMERO_ORDEM,P102_ROWID_PAG_105:&IDROW1.,&P105_COD_EMPR'
||'ESA.,&P105_COD_FORMACAO.,&COD_QUESTAO.,&P105_COD_QUESTIONARIO.,&P105_DATA_AVALIACAO.,&P105_MATRICULA.,&P105_TIPO_AVALIADO.,&NUMERO_ORDEM.,&P105_ROWID.'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167570715913475175085)
,p_plug_name=>unistr('Cadastro de Avalia\00E7\00F5es M\00E9dicas')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517713189812897166)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167570576208812430849)
,p_button_name=>'SAVE_QUEST'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition_type=>'NEVER'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_button_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'    from avaliacao_medica_respostas',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO'))
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517713610453897168)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(167570576208812430849)
,p_button_name=>'ATUALIZAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualizar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition_type=>'NEVER'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_button_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'    from avaliacao_medica_respostas',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO'))
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517716997724897177)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517715385055897176)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517715819025897176)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P105_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517716176534897176)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P105_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_security_scheme=>wwv_flow_api.id(161347559474643747726)
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(136517716570783897176)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_button_name=>'REL_AVAL_MED'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Relat\00F3rio Avalia\00E7\00E3o M\00E9dica')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:25:&SESSION.::&DEBUG.:RP,25:P25_COD_EMPRESA,P25_COD_FORMACAO,P25_MATRICULA,P25_DATA_AVALIACAO:&P105_COD_EMPRESA.,&P105_COD_FORMACAO.,&P105_MATRICULA.,&P105_DATA_AVALIACAO.'
,p_button_condition=>'P105_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(136517729092473897203)
,p_branch_name=>'LOAD'
,p_branch_action=>'f?p=&APP_ID.:105:&SESSION.::&DEBUG.:RP,22:P105_ROWID:&P105_ROWID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'LOAD'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(136561730950797244793)
,p_branch_name=>'Go to 21'
,p_branch_action=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
,p_branch_condition_type=>'NEVER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517714040849897168)
,p_name=>'P105_COD_QUESTIONARIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167570576208812430849)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517714403691897171)
,p_name=>'P105_QUESTIONARIO_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167570576208812430849)
,p_prompt=>unistr('Question\00E1rio')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ques.cod_questionario||'' - ''||ques.nome_questionario nome_questionario',
'  from questionario_1 ques',
' where ques.cod_formacao = :P105_COD_FORMACAO',
'   and ques.cod_questionario = :P105_COD_QUESTIONARIO;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517717421913897177)
,p_name=>'P105_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517717797213897177)
,p_name=>'P105_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cSize=>35
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863108609886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517718245856897178)
,p_name=>'P105_MATRICULA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Avaliado'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''|| p.nome d',
'      ,p.matricula r',
'  from inf_pessoais p, informacoes_funcionais f',
' where p.cod_empresa = :P105_COD_EMPRESA',
'   and p.cod_empresa = f.cod_empresa',
'   and p.matricula = f.matricula',
'   and ((:p105_rowid is null and f.situacao < ''90'') or (:p105_rowid is not null))',
'   and :P105_TIPO_AVALIADO = ''F''',
' union',
'select cod_candidato||'' - ''|| nome d',
'      ,cod_candidato r',
'  from inf_pessoais_candidato',
' where empresa = :P105_COD_EMPRESA',
'   and :P105_TIPO_AVALIADO = ''C'';'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P105_COD_EMPRESA,P105_ROWID,P105_TIPO_AVALIADO'
,p_ajax_items_to_submit=>'P105_TIPO_AVALIADO,P105_COD_EMPRESA,P105_ROWID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>35
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863108609886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517718612035897178)
,p_name=>'P105_TIPO_AVALIADO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Avaliado'
,p_source=>'TIPO_AVALIADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_AVALIADO'
,p_lov=>'.'||wwv_flow_api.id(166668472192912702652)||'.'
,p_cHeight=>1
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517718988190897179)
,p_name=>'P105_COD_CARGO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517719383454897179)
,p_name=>'P105_COD_FORMACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Avalia\00E7\00E3o')
,p_source=>'COD_FORMACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_FORMACAO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_formacao||'' - ''||descricao d',
'      ,cod_formacao r',
'  from formacao',
' order by cod_formacao;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863108609886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517719810050897180)
,p_name=>'P105_DATA_AVALIACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Avalia\00E7\00E3o')
,p_source=>'DATA_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863108609886910)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517720222204897180)
,p_name=>'P105_COD_PREST_SERV'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Avaliador'
,p_source=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select prse.cod_prest_serv||'' - ''||prse.nome d',
'      ,prse.cod_prest_serv r',
'  from prestador_servico prse',
' where prse.tipo_prest_serv = ''1''',
'   and prse.dt_vigencia_fin > sysdate',
'   --and prse.cod_prest_serv = :P105_COD_PREST_SERV'))
,p_lov_display_null=>'YES'
,p_cSize=>35
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P105_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517720610035897180)
,p_name=>'P105_DATA_VENCIMENTO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_source=>'DATA_VENCIMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517721054927897180)
,p_name=>'P105_COD_FILIAL'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517721418112897181)
,p_name=>'P105_COD_CCUSTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(136517721819074897181)
,p_name=>'P105_PAGE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(167570715913475175085)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(136517722861071897197)
,p_computation_sequence=>10
,p_computation_item=>'P105_COD_CARGO'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cargo',
'  from informacoes_funcionais',
'  where cod_empresa = :P105_COD_EMPRESA',
'    and matricula   = :P105_MATRICULA',
'    and :P105_TIPO_AVALIADO = ''F''',
'  union',
'select cargo_pretendido cargo',
'  from inf_func_candidato ',
'  where cod_empresa = :P105_COD_EMPRESA',
'    and cod_candidato = :P105_MATRICULA',
'    and :P105_TIPO_AVALIADO = ''C'';'))
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(136517723194867897198)
,p_computation_sequence=>10
,p_computation_item=>'P105_COD_FILIAL'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select filial',
'  from informacoes_funcionais',
'  where cod_empresa = :P105_COD_EMPRESA',
'    and matricula   = :P105_MATRICULA',
'    and :P105_TIPO_AVALIADO = ''F''',
'  union',
'select cod_filial filial',
'  from inf_func_candidato ',
'  where cod_empresa = :P105_COD_EMPRESA',
'    and cod_candidato = :P105_MATRICULA',
'    and :P105_TIPO_AVALIADO = ''C'';'))
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(136517723572857897199)
,p_computation_sequence=>10
,p_computation_item=>'P105_COD_CCUSTO'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_ccusto',
'  from informacoes_funcionais',
'  where cod_empresa = :P105_COD_EMPRESA',
'    and matricula   = :P105_MATRICULA',
'    and :P105_TIPO_AVALIADO = ''F'''))
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(136517723982989897199)
,p_computation_sequence=>10
,p_computation_item=>'P105_COD_QUESTIONARIO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ques.cod_questionario',
'  from questionario_1 ques',
'      ,formacao       form',
' where ques.cod_formacao = form.cod_formacao ',
'   and form.cod_formacao = :P105_COD_FORMACAO;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(136517727616281897202)
,p_name=>'Submit Page'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P105_COD_FORMACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P105_PAGE'
,p_display_when_cond2=>'10'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136517728066141897203)
,p_event_id=>wwv_flow_api.id(136517727616281897202)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cargo  informacoes_funcionais.cargo%type;',
'  l_filial informacoes_funcionais.filial%type;',
'  l_ccusto informacoes_funcionais.cod_ccusto%type;',
'begin',
'  select rowid',
'    into :P105_ROWID',
'    from avaliacao_medica',
'   where cod_empresa    = :P105_COD_EMPRESA',
'     and matricula      = :P105_MATRICULA',
'     and data_avaliacao = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'     and cod_formacao   = :P105_COD_FORMACAO;',
'exception when no_data_found then',
'',
'  begin',
'    select cargo',
'      into l_cargo',
'      from informacoes_funcionais',
'     where cod_empresa = :P105_COD_EMPRESA',
'       and matricula   = :P105_MATRICULA',
'       and :P105_TIPO_AVALIADO = ''F''',
'     union',
'    select cargo_pretendido cargo',
'      from inf_func_candidato ',
'     where cod_empresa   = :P105_COD_EMPRESA',
'       and cod_candidato = :P105_MATRICULA',
'       and :P105_TIPO_AVALIADO = ''C'';',
'  exception when others then null;',
'  end;',
'',
'  begin',
'    select filial',
'      into l_filial',
'      from informacoes_funcionais',
'     where cod_empresa = :P105_COD_EMPRESA',
'       and matricula   = :P105_MATRICULA',
'       and :P105_TIPO_AVALIADO = ''F''',
'     union',
'    select cod_filial filial',
'      from inf_func_candidato ',
'     where cod_empresa   = :P105_COD_EMPRESA',
'       and cod_candidato = :P105_MATRICULA',
'       and :P105_TIPO_AVALIADO = ''C'';',
'  exception when others then null;',
'  end;',
'',
'  begin',
'    select cod_ccusto',
'      into l_ccusto',
'      from informacoes_funcionais',
'     where cod_empresa = :P105_COD_EMPRESA',
'       and matricula   = :P105_MATRICULA',
'       and :P105_TIPO_AVALIADO = ''F'';',
'  exception when others then null;',
'  end;',
'',
'  begin',
'    select ques.cod_questionario',
'      into :P105_COD_QUESTIONARIO',
'      from questionario_1 ques',
'          ,formacao       form',
'     where ques.cod_formacao = form.cod_formacao ',
'       and form.cod_formacao = :P105_COD_FORMACAO;',
'  exception when others then null;',
'  end;',
'',
'  insert into avaliacao_medica (',
'    cod_empresa,',
'    matricula,',
'    data_avaliacao,',
'    cod_formacao,',
'    data_vencimento,',
'    cod_cargo,',
'    cod_filial,',
'    cod_ccusto,',
'    tipo_avaliado,',
'    cod_prest_serv',
'  ) values (',
'    :P105_COD_EMPRESA,',
'    :P105_MATRICULA,',
'    to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy''),',
'    :P105_COD_FORMACAO,',
'    null,',
'    l_cargo,',
'    l_filial,',
'    l_ccusto,',
'    :P105_TIPO_AVALIADO,',
'    :P105_COD_PREST_SERV',
'  ) returning rowid into :P105_ROWID;',
'end;'))
,p_attribute_02=>'P105_COD_FORMACAO'
,p_attribute_03=>'P105_ROWID,P105_MATRICULA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136517728574763897203)
,p_event_id=>wwv_flow_api.id(136517727616281897202)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'LOAD'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(132469321555909503107)
,p_name=>'REFRESH'
,p_event_sequence=>30
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(132469321690280503108)
,p_event_id=>wwv_flow_api.id(132469321555909503107)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517724348269897199)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from AVALIACAO_MEDICA'
,p_attribute_02=>'AVALIACAO_MEDICA'
,p_attribute_03=>'P105_ROWID'
,p_attribute_04=>'ROWID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517726312373897200)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete AVALIACAO_MEDICA_RESPOSTAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete from avaliacao_medica_respostas',
'where cod_empresa = :P105_COD_EMPRESA',
'  and matricula = :P105_MATRICULA ',
'  and data_avaliacao = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'  and cod_formacao = :P105_COD_FORMACAO',
'  and cod_questionario = :P105_COD_QUESTIONARIO',
'  ;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(136517716176534897176)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517724656777897199)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of AVALIACAO_MEDICA'
,p_attribute_02=>'AVALIACAO_MEDICA'
,p_attribute_03=>'P105_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_09=>'P105_ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('A\00E7\00E3o Processada.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517725465577897200)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert AVALIACAO_MEDICA_RESPOSTAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    for i in (select ques.cod_questionario',
'                    ,perg.cod_questao',
'                    ,qupe.numero_ordem  ',
'                from questionario_1           ques',
'                    ,formacao                 form',
'                    ,questionario_questoes2_1 qupe',
'                    ,questoes_1               perg ',
'               where ques.cod_formacao = form.cod_formacao',
'                 and qupe.cod_formacao = ques.cod_formacao',
'                 and qupe.cod_questionario = ques.cod_questionario',
'                 and perg.cod_formacao = qupe.cod_formacao',
'                 and perg.cod_questao = qupe.cod_questao',
'                 and form.cod_formacao = :P105_COD_FORMACAO',
'                 and ques.cod_questionario = :P105_COD_QUESTIONARIO',
'               order by qupe.numero_ordem)',
'        loop',
'       ',
'            insert into avaliacao_medica_respostas',
'                    (cod_empresa',
'                    ,matricula',
'                    ,data_avaliacao',
'                    ,cod_formacao',
'                    ,cod_questionario',
'                    ,cod_questao',
'                    ,cod_resposta',
'                    ,resp_texto_livre',
'                    ,requer_atencao',
'                    ,observacao',
'                    ,ordem_pergunta',
'                    ,tipo_avaliado)',
'            values(:P105_COD_EMPRESA',
'                  ,:P105_MATRICULA',
'                  ,to_date(:P105_DATA_AVALIACAO,''dd/mm/yyyy'')',
'                  ,:P105_COD_FORMACAO',
'                  ,i.cod_questionario',
'                  ,i.cod_questao',
'                  ,NULL',
'                  ,NULL',
'                  ,''N''',
'                  ,null',
'                  ,i.numero_ordem',
'                  ,:P105_TIPO_AVALIADO);',
'',
'        ',
'        end loop;',
'        ',
'        commit;',
'        ',
'      END;',
'',
'begin',
'',
'    for i in 1..apex_application.g_f01.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(apex_application.g_f03(i),null)',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f01(i);',
'               ',
'      ',
'	',
'',
'     end loop;',
'     ',
'      commit;',
'end;     ',
'',
'',
'',
'begin',
'',
'    for i in 1..apex_application.g_f10.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set ',
'                  resp_texto_livre = nvl(apex_application.g_f40(i),null)',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f10(i);',
'               ',
'    ',
'	',
'          end loop;',
'          commit;',
'end;      ',
'',
''))
,p_process_error_message=>'#SQLERRM#-ERRO'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(136445757848020316969)
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Question\00E1rio Salvo')
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517725917813897200)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update AVALIACAO_MEDICA_RESPOSTAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'',
'    for i in 1..apex_application.g_f01.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set cod_resposta = nvl(apex_application.g_f03(i),null)',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f01(i);',
'               ',
'      ',
'	',
'',
'     end loop;',
'     ',
'      commit;',
'end;     ',
'',
'',
'',
'begin',
'',
'    for i in 1..apex_application.g_f10.count',
'        loop',
'',
'',
'            update avaliacao_medica_respostas',
'               set ',
'                  resp_texto_livre = nvl(apex_application.g_f40(i),null)',
'             where cod_empresa      = :P105_COD_EMPRESA',
'               and matricula        = :P105_MATRICULA ',
'               and to_date(data_avaliacao, ''dd/mm/yyyy'')   = to_date(:P105_DATA_AVALIACAO, ''dd/mm/yyyy'')',
'               and cod_formacao     = :P105_COD_FORMACAO',
'               and cod_questionario = :P105_COD_QUESTIONARIO',
'               and cod_questao      = apex_application.g_f10(i);',
'               ',
'    ',
'	',
'          end loop;',
'          commit;',
'end;      ',
'',
''))
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(136445757981620316971)
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Question\00E1rio Atualizado!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(136517725091569897200)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(136517716176534897176)
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
