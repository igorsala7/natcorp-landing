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
,p_default_application_id=>9104
,p_default_id_offset=>17701478678126781
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9104 - Treinamento - Processos
--
-- Application Export:
--   Application:     9104
--   Name:            Treinamento - Processos
--   Date and Time:   01:27 Sunday October 4, 2026
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
,p_user_interface_id=>wwv_flow_api.id(24253223456140525237)
,p_name=>unistr('Cadastro Resposta Question\00E1rio Participante')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('RESPOSTAS  DO QUESTION\00C1RIO - PARTICIPANTE')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'MARCELO.SENA'
,p_last_upd_yyyymmddhh24miss=>'20200707171502'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(5935451513719673419)
,p_plug_name=>unistr('Cadastro Resposta Question\00E1rio Participante')
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:t-Form--stretchInputs:t-Form--leftLabels:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(24253189381808525129)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'TR_QUESTIONARIO_PARTICIPANTE'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(5935460913880673109)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(24253189464980525130)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5935461321794673109)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(5935460913880673109)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218250900525187)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5935462845141673091)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(5935460913880673109)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(24253218250900525187)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5935463279425673091)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(5935460913880673109)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218250900525187)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5935463700689673091)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(5935460913880673109)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218250900525187)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'&nbsp&nbspCriar&nbsp&nbsp'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P3_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924982427543569410)
,p_name=>'P3_QUESTIONARIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_prompt=>unistr('QUESTION\00C1RIO')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT LPAD(q.cod_questionario,4,0)||'' - ''||INITCAP(q.descricao) dsc',
'  FROM tr_questionarios q',
'WHERE q.cod_questionario = :P3_COD_QUESTIONARIO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-clipboard-list'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924982468427569411)
,p_name=>'P3_PERGUNTA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_prompt=>'PERGUNTA'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(x.cod_pergunta,6,0)||'' - ''||x.descricao dsc --INITCAP(x.descricao)  dsc',
'  FROM tr_perguntas x ',
' WHERE x.cod_pergunta = :P3_COD_PERGUNTA'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-question'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924983148408569418)
,p_name=>'P3_TIPO_PERGUNTA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.tipo_pergunta',
'  FROM tr_perguntas x ',
' WHERE x.cod_pergunta  = :P3_COD_PERGUNTA'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924983991822569426)
,p_name=>'P3_CODEMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924984099019569427)
,p_name=>'P3_CODCURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935451927460673416)
,p_name=>'P3_ROWID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Rowid'
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_api.id(24253217810296525180)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935452311424673409)
,p_name=>'P3_COD_EMPRESA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'P3_CODEMPRESA'
,p_item_default_type=>'ITEM'
,p_prompt=>'EMPRESA'
,p_format_mask=>'099'
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>3
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-building-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935452617571673141)
,p_name=>'P3_MATRICULA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'P3_CODMATRICULA'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('MATR\00CDCULA')
,p_format_mask=>'099999'
,p_source=>'MATRICULA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>6
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'999999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935452958682673141)
,p_name=>'P3_COD_TURMA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'P3_CODTURMA'
,p_item_default_type=>'ITEM'
,p_prompt=>'TURMA'
,p_format_mask=>'099999'
,p_source=>'COD_TURMA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>6
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-user-graduate'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'999999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935453407668673140)
,p_name=>'P3_COD_QUESTIONARIO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_source=>'COD_QUESTIONARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935453820860673140)
,p_name=>'P3_COD_PERGUNTA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_source=>'COD_PERGUNTA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935454218850673140)
,p_name=>'P3_RESPOSTA_ALT'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_prompt=>'RESPOSTA'
,p_source=>'RESPOSTA_ALT'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (SELECT /*UPPER(r.descricao)*/ r.descricao FROM tr_respostas r WHERE r.cod_resposta = qr.cod_resposta) dsc',
'      ,(SELECT r.cod_resposta FROM tr_respostas r WHERE r.cod_resposta = qr.cod_resposta) ret',
'  FROM tr_questionario_respostas qr',
' WHERE qr.cod_questionario = :P3_COD_QUESTIONARIO',
'   AND qr.cod_pergunta     = :P3_COD_PERGUNTA',
'ORDER BY 2 '))
,p_lov_cascade_parent_items=>'P3_COD_PERGUNTA'
,p_ajax_items_to_submit=>'P3_COD_QUESTIONARIO,P3_COD_PERGUNTA'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(24253217810296525180)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large:margin-bottom-none'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935454557305673140)
,p_name=>'P3_RESPOSTA_DIS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_prompt=>'RESPOSTA'
,p_source=>'RESPOSTA_DIS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>1000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(7105154798914642160)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935454940755673138)
,p_name=>'P3_DATA_RESPOSTA'
,p_source_data_type=>'DATE'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_source=>'DATA_RESPOSTA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935455405835673136)
,p_name=>'P3_NOTA_RESPOSTA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_source=>'NOTA_RESPOSTA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935455788416673136)
,p_name=>'P3_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>':APP_USER'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935456228734673132)
,p_name=>'P3_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935456601316673129)
,p_name=>'P3_COD_CURSO'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_source_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_item_default=>'P3_CODCURSO'
,p_item_default_type=>'ITEM'
,p_prompt=>'CURSO'
,p_format_mask=>'09999'
,p_source=>'COD_CURSO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>5
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_icon_css_classes=>'fa-lg fa-graduation-cap'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'99999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935781130392302878)
,p_name=>'P3_CODTURMA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5935781173825302879)
,p_name=>'P3_CODMATRICULA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(5935451513719673419)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5935461381309673109)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(5935461321794673109)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5935462225127673099)
,p_event_id=>wwv_flow_api.id(5935461381309673109)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924982615611569412)
,p_name=>'HideShowReposta'
,p_event_sequence=>20
,p_condition_element=>'P3_TIPO_PERGUNTA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'M'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924982645934569413)
,p_event_id=>wwv_flow_api.id(5924982615611569412)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_RESPOSTA_ALT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924982790922569414)
,p_event_id=>wwv_flow_api.id(5924982615611569412)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_RESPOSTA_DIS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924983018057569416)
,p_event_id=>wwv_flow_api.id(5924982615611569412)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_RESPOSTA_ALT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924982892286569415)
,p_event_id=>wwv_flow_api.id(5924982615611569412)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_RESPOSTA_DIS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924983635479569423)
,p_name=>'SetNotaResposta'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_RESPOSTA_ALT'
,p_condition_element=>'P3_RESPOSTA_ALT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924983776129569424)
,p_event_id=>wwv_flow_api.id(5924983635479569423)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_NOTA_RESPOSTA'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT qr.valor_resposta',
'  FROM tr_questionario_respostas qr',
' WHERE qr.cod_questionario = :P3_COD_QUESTIONARIO',
'   AND qr.cod_pergunta     = :P3_COD_PERGUNTA',
'   AND qr.cod_resposta     = :P3_RESPOSTA_ALT',
''))
,p_attribute_07=>'P3_COD_QUESTIONARIO,P3_COD_PERGUNTA,P3_RESPOSTA_ALT'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924983887307569425)
,p_event_id=>wwv_flow_api.id(5924983635479569423)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_NOTA_RESPOSTA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5935464498678673088)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(5935451513719673419)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form Cadastro Resposta Question\00E1rio Participante')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5935464839495673088)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5935464048628673090)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(5935451513719673419)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form Cadastro Resposta Question\00E1rio Participante')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(5924982313703569409)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atualiza\00E7\00E3o Gen\00E9rica de Dados')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Atualiza\00E7\00E3o Gen\00E9rica de Dados'),
'BEGIN',
'  :P3_USUARIO        := :APP_USER;',
'  :P3_DT_ATUALIZACAO := TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'');',
'  --',
'  :P3_DATA_RESPOSTA  := TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'');',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P3_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
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
