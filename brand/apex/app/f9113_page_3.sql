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
,p_default_application_id=>9113
,p_default_id_offset=>696776033023734483
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9113 - Recrutamento e Seleção - Processos
--
-- Application Export:
--   Application:     9113
--   Name:            Recrutamento e Seleção - Processos
--   Date and Time:   19:32 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 3
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00003
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_api.create_page(
 p_id=>3
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>'Candidato Aprovado'
,p_page_mode=>'MODAL'
,p_step_title=>'Candidato Aprovado'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.css'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_ProcessoJanelas.css / Natcorp_ProcessoJanelas.js)',
'',
unistr('Janela Aprovar candidato: quem est\00E1 sendo aprovado; data de contrata\00E7\00E3o em destaque; "Confirmar'),
unistr('aprova\00E7\00E3o"; aviso se abrir sem o candidato. Processo "Atualiza Data" com NVL (n\00E3o apaga a data gravada).'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSOJANELAS-MANUTENCAO.md.',
unistr('---- (fim do bloco Natcorp; abaixo, o coment\00E1rio que a p\00E1gina j\00E1 tinha) ----')))
,p_protection_level=>'C'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20250829132031'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52837063381818647565)
,p_plug_name=>'Candidato Aprovado'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(72951023803503200621)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'CANDIDATO_APROVADO'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52837071956701647793)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52837157988029620481)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52837071956701647793)
,p_button_name=>'BT_EMAIL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--iconLeft:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'E-mail'
,p_button_position=>'BOTTOM'
,p_button_redirect_url=>'f?p=&APP_ID.:35:&SESSION.::&DEBUG.:35:P35_COD_CANDIDATO,P35_COD_REQUIMENTO:&P3_COD_CANDIDATO.,&P3_COD_REQ.'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-envelope-arrow-up'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52837072331103647793)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(52837071956701647793)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52837073979614647797)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(52837071956701647793)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52837074392816647797)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(52837071956701647793)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52837074734840647797)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(52837071956701647793)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(50623940812879250351)
,p_branch_name=>'create -> email'
,p_branch_action=>'f?p=&APP_ID.:35:&SESSION.:EMAIL_APROVADO:&DEBUG.:RP,35:P35_COD_CANDIDATO,P35_COD_REQUIMENTO:&P3_COD_CANDIDATO.,&P3_COD_REQ.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'CREATE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50988469368436493269)
,p_name=>'P3_TIPO_PARTICIPANTE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_source=>'TIPO_PARTICIPANTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439139871247755335)
,p_name=>'P3_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439140004083755336)
,p_name=>'P3_CANDIDATO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>'CANDIDATO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(c.cod_candidato,6,0)||'' - ''||(SELECT x.nome FROM inf_pessoais_candidato x WHERE x.cod_candidato = c.cod_candidato) det',
'  FROM candidato c',
' WHERE c.cod_candidato   = :P3_COD_CANDIDATO',
' AND C.COD_REQ = :P3_COD_SOLICITACAO;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52826897662155718987)
,p_name=>'P3_COD_PRESTADOR_SERV_AUX'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52826897915498718989)
,p_name=>'P3_COD_SIT_REQ'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52826898022783718990)
,p_name=>'P3_CODSOLICITACAO_TXT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('SOLICITA\00C7\00C3O')
,p_source=>'P3_COD_SOLICITACAO'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_icon_css_classes=>'fa-lg fa-list-ol'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52826898548243718996)
,p_name=>'P3_CODSITREQ_TXT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>unistr('SITUA\00C7\00C3O')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DECODE(:P3_COD_SIT_REQ',
'             ,1, ''1 - Prevista''',
'             ,2, ''2 - Fechada''',
'             ,3, ''3 - Cancelada''',
'             ,4, ''4 - Reprovada''',
'             ,5, ''5 - Aberta''',
'             ,''-'') ret',
'  FROM DUAL'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-wizard'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837063689404647764)
,p_name=>'P3_ROWID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837064044334647776)
,p_name=>'P3_COD_EMPRESA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>'EMPRESA'
,p_placeholder=>'-'
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_icon_css_classes=>'fa-building-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837064505890647785)
,p_name=>'P3_COD_FILIAL'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>'FILIAL'
,p_placeholder=>'-'
,p_source=>'COD_FILIAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_icon_css_classes=>'fa-home'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837064832298647785)
,p_name=>'P3_COD_CANDIDATO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_source=>'COD_CANDIDATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837065291834647785)
,p_name=>'P3_COD_SOLICITACAO'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>unistr('SOLICITA\00C7\00C3O')
,p_source=>'COD_SOLICITACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837065628254647786)
,p_name=>'P3_DT_CONTRATACAO'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>unistr('DATA CONTRATA\00C7\00C3O')
,p_placeholder=>'-'
,p_source=>'DT_CONTRATACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837066082901647786)
,p_name=>'P3_OBSERVACAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>unistr('OBSERVA\00C7\00C3O')
,p_placeholder=>'-'
,p_source=>'OBSERVACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>4000
,p_cMaxlength=>4000
,p_cHeight=>8
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837066518658647786)
,p_name=>'P3_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_default=>':APP_USER'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837066894436647786)
,p_name=>'P3_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_default=>'TO_CHAR(SYSDATE, ''DD/MM/YYYY HH24:MI:SS'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837157717921620478)
,p_name=>'P3_CODCANDIDATO_TXT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>'CANDIDATO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(c.cod_candidato,6,0)||'' - ''||(SELECT x.nome FROM inf_pessoais_candidato x WHERE x.cod_candidato = c.cod_candidato) det',
'  FROM candidato_aprovado c',
' WHERE c.cod_candidato   = :P3_COD_CANDIDATO',
'   AND c.cod_solicitacao = :P3_COD_SOLICITACAO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_icon_css_classes=>'fa-user-check'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837157891886620480)
,p_name=>'P3_COD_VAGA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_item_source_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_prompt=>'VAGA'
,p_placeholder=>'-'
,p_source=>'COD_VAGA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>6
,p_cMaxlength=>6
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-bullseye'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52837159742152620499)
,p_name=>'P3_CODCARGO_AUX'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52847250284441592799)
,p_name=>'P3_ERR_MSG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52837063381818647565)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52837157291725620474)
,p_validation_name=>'ValidaCandidato'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vProcesso   candidato_aprovado.cod_solicitacao%TYPE;',
'BEGIN',
'  IF :P3_COD_CANDIDATO IS NOT NULL THEN',
'    vProcesso := pkg_Selecao.F_RETORNA_PROC_EM_ANDAMENTO(pCodCandidato => :P3_COD_CANDIDATO);',
'    --',
'    IF vProcesso IS NOT NULL THEN',
unistr('      vMsg := ''O candidato j\00E1 participa da solicitacao [''||vProcesso||'']!'';'),
'    END IF;',
'  ELSE',
'     vMsg := ''CANDIDATO deve ser informado!'';',
'  END IF;',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(52837074734840647797)
,p_associated_item=>wwv_flow_api.id(52439140004083755336)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52837159959806620501)
,p_validation_name=>'ValDELCandidatoAprov'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  ErrExcpt    EXCEPTION;',
'BEGIN',
'  pkg_Selecao.prc_DEL_CandAprov(pCodCand   => :P3_COD_CANDIDATO',
'                               ,pCodSolic  => :P3_COD_SOLICITACAO',
'                               ,pCodEmp    => :P3_COD_EMPRESA',
'                               ,pCodFil    => :P3_COD_FILIAL',
'                               ,pCodVaga   => :P3_COD_VAGA',
'                               ,pCodSitReq => :P3_COD_SIT_REQ',
'                               ,pUser      => :APP_USER',
'                               ,pMsg       => vMsg);                                  ',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(52837073979614647797)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52837160099521620502)
,p_validation_name=>'ValPreINSCandidatoAprov'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  ErrExcpt    EXCEPTION;',
'BEGIN',
'  pkg_Selecao.prc_PreINS_CandAprov(pCodCand  => :P3_COD_CANDIDATO',
'                                  ,pCodSolic => :P3_COD_SOLICITACAO',
'                                  ,pCodEmp   => :P3_COD_EMPRESA',
'                                  ,pCodFil   => :P3_COD_FILIAL',
'                                  ,pCodCargo => :P3_CODCARGO_AUX',
'                                  ,pCodVaga  => :P3_COD_VAGA',
'                                  ,pUser     => :APP_USER',
'                                  ,pMsg      => vMsg);                                 ',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(52837074734840647797)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52837160193449620503)
,p_validation_name=>'ValPreUPDCandidatoAprov'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  ErrExcpt    EXCEPTION;',
'BEGIN',
'  pkg_Selecao.prc_PreUPD_CandAprov(pCodCand  => :P3_COD_CANDIDATO',
'                                  ,pCodSolic => :P3_COD_SOLICITACAO',
'                                  ,pCodEmp   => :P3_COD_EMPRESA',
'                                  ,pCodFil   => :P3_COD_FILIAL',
'                                  ,pCodCargo => :P3_CODCARGO_AUX',
'                                  ,pUser     => :APP_USER',
'                                  ,pMsg      => vMsg);      ',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(52837074392816647797)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(51813332694858986418)
,p_validation_name=>unistr('Verifica Data Contrata\00E7\00E3o')
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  RETURN(pkg_Selecao.fnc_ValDataContratacao(:P3_DT_CONTRATACAO));',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(52837065628254647786)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52837072498387647794)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52837072331103647793)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837073281057647796)
,p_event_id=>wwv_flow_api.id(52837072498387647794)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52826898057663718991)
,p_name=>unistr('VerificaSitua\00E7\00E3oRequisi\00E7\00E3o')
,p_event_sequence=>20
,p_condition_element=>'P3_COD_SIT_REQ'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'1,3,4'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899469034719005)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_CODSOLICITACAO_TXT,P3_CODCANDIDATO_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899634567719007)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_COD_SOLICITACAO,P3_TIPO_PARTICIPANTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899758181719008)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_CODSOLICITACAO_TXT,P3_CODCANDIDATO_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899556398719006)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_COD_SOLICITACAO,P3_TIPO_PARTICIPANTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899230684719003)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('A solicita\00E7\00E3o [&P3_COD_SOLICITACAO.]  est\00E1 na situa\00E7\00E3o [&P3_CODSITREQ_TXT.]<br>N\00E3o h\00E1 registro para ser exibido!')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826899412769719004)
,p_event_id=>wwv_flow_api.id(52826898057663718991)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52826899827527719009)
,p_name=>'HideShowItens'
,p_event_sequence=>30
,p_condition_element=>'P3_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_IN_LIST'
,p_triggering_expression=>'1,3,4'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P3_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826900039081719011)
,p_event_id=>wwv_flow_api.id(52826899827527719009)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_CODSOLICITACAO_TXT,P3_CODCANDIDATO_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826900161093719012)
,p_event_id=>wwv_flow_api.id(52826899827527719009)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_COD_SOLICITACAO,P3_TIPO_PARTICIPANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52826900547906719016)
,p_name=>unistr('ShowSolicita\00E7\00E3oNULL')
,p_event_sequence=>40
,p_condition_element=>'P3_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_IN_LIST'
,p_triggering_expression=>'1,3,4'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>'(:P3_ROWID IS NULL AND :P3_COD_SOLICITACAO IS NULL)'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837156718416620468)
,p_event_id=>wwv_flow_api.id(52826900547906719016)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_CODSOLICITACAO_TXT,P3_CODCANDIDATO_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837156743212620469)
,p_event_id=>wwv_flow_api.id(52826900547906719016)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_COD_SOLICITACAO,P3_TIPO_PARTICIPANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52837156961692620471)
,p_name=>unistr('HideSolicita\00E7\00E3oNOTNULL')
,p_event_sequence=>50
,p_condition_element=>'P3_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_IN_LIST'
,p_triggering_expression=>'1,3,4'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>'(:P3_ROWID IS NULL AND :P3_COD_SOLICITACAO IS NOT NULL)'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837157123448620472)
,p_event_id=>wwv_flow_api.id(52837156961692620471)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_CODSOLICITACAO_TXT,P3_TIPO_PARTICIPANTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837157190154620473)
,p_event_id=>wwv_flow_api.id(52837156961692620471)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_COD_SOLICITACAO,P3_CODCANDIDATO_TXT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52826900388925719014)
,p_name=>'AtribuiItensSolicitacao'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_COD_SOLICITACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52826900488924719015)
,p_event_id=>wwv_flow_api.id(52826900388925719014)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vSolicitacao  vw_requisicao.solicitacao%TYPE DEFAULT :P3_COD_SOLICITACAO;',
'  --',
'  CURSOR cDados(pCodSolic IN vw_requisicao.solicitacao%TYPE) IS',
'    SELECT solicitacao',
'          ,tipo_req',
'          ,dt_solicitacao',
'          ,cod_sit_req',
'          ,dt_sit_req',
'          ,desc_sit_req',
'          ,cod_empresa',
'          ,cod_filial',
'          ,cod_vaga',
'          ,cod_cargo',
'      FROM TABLE(pkg_Selecao.fnc_TabDadosVWReqPipe(pSolicitacao => pCodSolic)); ',
'  --        ',
'  rDados cDados%ROWTYPE;   ',
'  --',
'  CURSOR cSituacao(pSit IN VARCHAR2) IS',
'    SELECT DECODE(pSit',
'                 ,1, ''1 - Prevista''',
'                 ,2, ''2 - Fechada''',
'                 ,3, ''3 - Cancelada''',
'                 ,4, ''4 - Reprovada''',
'                 ,5, ''5 - Aberta''',
'                 ,''-'') ret',
'      FROM DUAL;',
'BEGIN',
'  OPEN cDados(vSolicitacao);',
'  FETCH cDados INTO rDados;',
'  CLOSE cDados;',
'  --',
'  :P3_COD_SIT_REQ  := rDados.cod_sit_req;',
'  :P3_COD_EMPRESA  := rDados.cod_empresa;',
'  :P3_COD_FILIAL   := rDados.cod_filial;',
'  :P3_COD_VAGA     := rDados.cod_vaga;',
'  :P3_COD_REQ      := rDados.cod_vaga;',
'  ',
'  :P3_CODCARGO_AUX := rDados.cod_cargo;',
'  --',
'  OPEN cSituacao(:P3_COD_SIT_REQ);',
'  FETCH cSituacao INTO :P3_CODSITREQ_TXT;',
'  CLOSE cSituacao;  ',
'  --:P3_CODSITREQ_TXT := :P3_COD_SIT_REQ;',
'END;',
''))
,p_attribute_02=>'P3_COD_SOLICITACAO,P3_COD_SIT_REQ,P3_COD_EMPRESA,P3_COD_FILIAL,P3_CODSITREQ_TXT,P3_CODCARGO_AUX'
,p_attribute_03=>'P3_COD_SIT_REQ,P3_COD_EMPRESA,P3_COD_FILIAL,P3_CODSITREQ_TXT,P3_CODCARGO_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52837157379107620475)
,p_name=>unistr('AtribuiDataContrata\00E7\00E3o')
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_TIPO_PARTICIPANTE'
,p_condition_element=>'P3_COD_SOLICITACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837157489951620476)
,p_event_id=>wwv_flow_api.id(52837157379107620475)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P3_DT_CONTRATACAO IS NULL THEN',
'    :P3_DT_CONTRATACAO := pkg_Selecao.fnc_RetDtContratacaoCandAprov(pCodSolicitacao => :P3_COD_SOLICITACAO',
'                                                                   ,pCodCandAprov   => :P3_COD_CANDIDATO',
'                                                                   ,pCodEmpresa     => :P3_COD_EMPRESA',
'                                                                   ,pCodFilial      => :P3_COD_FILIAL);',
'  END IF;                                                                 ',
'END;'))
,p_attribute_02=>'P3_COD_SOLICITACAO,P3_TIPO_PARTICIPANTE,P3_COD_EMPRESA,P3_COD_FILIAL,P3_DT_CONTRATACAO'
,p_attribute_03=>'P3_DT_CONTRATACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52847254190008605893)
,p_name=>'DisparaAlerta'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_ERR_MSG'
,p_condition_element=>'P3_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52847254590014605895)
,p_event_id=>wwv_flow_api.id(52847254190008605893)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P3_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P3_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }',
'  ',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52847255569458617471)
,p_name=>'Inicia Alertify'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52847255927993617472)
,p_event_id=>wwv_flow_api.id(52847255569458617471)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52837158155048620483)
,p_name=>unistr('ValDtContrata\00E7\00E3o')
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_DT_CONTRATACAO'
,p_condition_element=>'P3_DT_CONTRATACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52837158248839620484)
,p_event_id=>wwv_flow_api.id(52837158155048620483)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P3_ERR_MSG := NULL;',
'  --',
'  vMsg := pkg_Selecao.fnc_ValDataContratacao(:P3_DT_CONTRATACAO);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P3_ERR_MSG := vMsg;',
'  END IF;',
'END;'))
,p_attribute_02=>'P3_ERR_MSG,P3_DT_CONTRATACAO'
,p_attribute_03=>'P3_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(50625189249209440642)
,p_name=>'Dialog Closed'
,p_event_sequence=>110
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52837063381818647565)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'EMAIL_APROVADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(50625189335422440643)
,p_event_id=>wwv_flow_api.id(50625189249209440642)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'EMAIL_REPROVADOS'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(47009584740922668470)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Data'
,p_process_sql_clob=>':P3_DT_CONTRATACAO := NVL(:P3_DT_CONTRATACAO, to_date(sysdate)+7);'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52837159703303620498)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-INS Candidato Aprovado'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  ErrExcpt    EXCEPTION;',
'BEGIN',
'  :P3_ERR_MSG := NULL;',
'  --',
'  pkg_Selecao.prc_PreINS_CandAprov(pCodCand  => :P3_COD_CANDIDATO',
'                                  ,pCodSolic => :P3_COD_SOLICITACAO',
'                                  ,pCodEmp   => :P3_COD_EMPRESA',
'                                  ,pCodFil   => :P3_COD_FILIAL',
'                                  ,pCodCargo => :P3_CODCARGO_AUX',
'                                  ,pCodVaga  => :P3_COD_VAGA',
'                                  ,pUser     => :APP_USER',
'                                  ,pMsg      => vMsg);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P3_ERR_MSG := vMsg;',
'    RAISE ErrExcpt;',
'  END IF;',
'EXCEPTION',
'  WHEN ErrExcpt THEN',
'    RAISE_APPLICATION_ERROR(-20901, :P3_ERR_MSG);',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52837159882328620500)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'DELETE Candidato Aprovado'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'  --',
'  ErrExcpt    EXCEPTION;',
'BEGIN',
'  :P3_ERR_MSG := NULL;',
'  --',
'  pkg_Selecao.prc_DEL_CandAprov(pCodCand   => :P3_COD_CANDIDATO',
'                               ,pCodSolic  => :P3_COD_SOLICITACAO',
'                               ,pCodEmp    => :P3_COD_EMPRESA',
'                               ,pCodFil    => :P3_COD_FILIAL',
'                               ,pCodVaga   => :P3_COD_VAGA',
'                               ,pCodSitReq => :P3_COD_SIT_REQ',
'                               ,pUser      => :APP_USER',
'                               ,pMsg       => vMsg);                                  ',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P3_ERR_MSG := vMsg;',
'    --RAISE ErrExcpt;',
'  END IF;',
'--EXCEPTION',
'--  WHEN ErrExcpt THEN',
'--    RAISE_APPLICATION_ERROR(-20901, :P3_ERR_MSG);',
'END;'))
,p_process_error_message=>'AQUI ERRO: &P3_ERR_MSG.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52837075586525647799)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(52837063381818647565)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Candidato Aprovado'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_process_error_message=>'ERRO AO GRAVAR NA TABELA - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Candidato(a) aprovado(a) com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52837076014800647800)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52837075144354647798)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(52837063381818647565)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Candidato Aprovado'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52847259083276984622)
,p_process_sequence=>60
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atualiza\00E7\00E3o Gen\00E9rica de Dados')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Atualiza\00E7\00E3o Gen\00E9rica de Dados'),
'BEGIN',
'  :P3_USUARIO        := :APP_USER;',
'  :P3_DT_ATUALIZACAO := TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'');',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52837074392816647797)
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
