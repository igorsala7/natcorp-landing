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
--     PAGE: 35
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00035
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>35);
end;
/
prompt --application/pages/page_00035
begin
wwv_flow_api.create_page(
 p_id=>35
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>'Enviar E-Mail'
,p_page_mode=>'MODAL'
,p_step_title=>'Enviar E-Mail'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.css'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var button = parent.$(''.ui-dialog-titlebar-close''); ',
'button.hide(); '))
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_ProcessoJanelas.css / Natcorp_ProcessoJanelas.js)',
'',
unistr('Janela Enviar e-mail como "nova mensagem" do Mail: barra no alto (assunto, Fechar, Enviar \2014 os bot\00F5es'),
'originais, movidos), linhas Para / Modelo / Assunto sem caixa, e o corpo ocupando o resto da janela.',
unistr('O editor (CKEditor) ganha o desenho GERAL do Natcorp_Editor (Style_Min + pe\00E7a do Temas).'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSOJANELAS-MANUTENCAO.md.',
unistr('---- (fim do bloco Natcorp; abaixo, o coment\00E1rio que a p\00E1gina j\00E1 tinha) ----')))
,p_dialog_css_classes=>'modal'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260817102427'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(209690944610430816998)
,p_plug_name=>'Mensagem E-mail'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(209691287496812766572)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(219213760782707556287)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P35_COD_CANDIDATO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(219213761556600556290)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(219213762414933556291)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(16430895645188107106)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(209691287496812766572)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-window-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52439170690891838707)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(209691287496812766572)
,p_button_name=>'ENVIAR_EMAIL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(72951052846315200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Enviar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-angle-right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50989883052834257550)
,p_name=>'P35_NOME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(219213762414933556291)
,p_prompt=>'Nome'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51058399906642981972)
,p_name=>'P35_TEMPLATE_EMAIL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(209690944610430816998)
,p_prompt=>'Template de E-mail'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DESCRICAO D,',
'       COD C',
'  from RS_TEMPLATE_EMAIL',
' where ativo = ''S''',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439135988277755296)
,p_name=>'P35_DESC_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439136233750755298)
,p_name=>'P35_COD_REQUIMENTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439169629949838698)
,p_name=>'P35_SUBJECT_EMAIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(209690944610430816998)
,p_item_default=>'''Processo Seletivo ''||:P35_DESC_PROCESSO'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Assunto'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439170003685838704)
,p_name=>'P35_MESSAGE_EMAIL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(209690944610430816998)
,p_prompt=>'Mensagem'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cSize=>120
,p_cHeight=>20
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_02=>'Full'
,p_attribute_03=>'Y'
,p_attribute_05=>'top'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439171417495838710)
,p_name=>'P35_EMP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439171772988838711)
,p_name=>'P35_COD_CANDIDATO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439172212315838712)
,p_name=>'P35_FLG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439172621707838712)
,p_name=>'P35_MSG'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(219213760782707556287)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439173279417838712)
,p_name=>'P35_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(219213761556600556290)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'height="100" width="80"'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P35_emp',
'   and matricula = :P35_MAT'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439173978172838713)
,p_name=>'P35_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(219213762414933556291)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P35_COD_EMPRESA_DISPLAY'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439174354732838714)
,p_name=>'P35_CANDIDATO_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(219213762414933556291)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439174774747838714)
,p_name=>'P35_FASE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(219213762414933556291)
,p_prompt=>'Fase'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_display_when=>'P35_FASE'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52439175584365838718)
,p_name=>'P35_TO_EMAIL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(219213762414933556291)
,p_prompt=>'E-mail'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(72951052231991200672)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52439137147493755307)
,p_validation_name=>'P35_TO_EMAIL'
,p_validation_sequence=>10
,p_validation=>'P35_TO_EMAIL'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('E-mail n\00E3o informado. Favor verificar o cadastro do candidato.')
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52439176405393838726)
,p_name=>'enviar_email'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52439170690891838707)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52439136594633755302)
,p_event_id=>wwv_flow_api.id(52439176405393838726)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>'Deseja Enviar o E-mail ao Candidato ?'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52439136969375755306)
,p_event_id=>wwv_flow_api.id(52439176405393838726)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'ENVIAR_EMAIL'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52439136718221755303)
,p_name=>'enviar_email_bkp'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52439170690891838707)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52439136797219755304)
,p_event_id=>wwv_flow_api.id(52439136718221755303)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'begin',
'',
'PRC_ENVIA_EMAIL (:P35_TO_EMAIL, :p35_subject_email, :p35_message_email, v_flg, v_msg);',
'',
':p35_flg := v_flg;',
':p35_msg := v_msg;',
'',
'end;'))
,p_attribute_02=>'P35_EMP,P35_COD_CANDIDATO,P35_SUBJECT_EMAIL,P35_MESSAGE_EMAIL,P35_TO_EMAIL'
,p_attribute_03=>'P35_FLG,P35_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52439177167682838729)
,p_name=>'Alert'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P35_MSG'
,p_condition_element=>'P35_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52439177690143838729)
,p_event_id=>wwv_flow_api.id(52439177167682838729)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'alert(apex.item(''P35_MSG'').getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(51058399969011981973)
,p_name=>'Set Template Email'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P35_TEMPLATE_EMAIL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(51058400098356981974)
,p_event_id=>wwv_flow_api.id(51058399969011981973)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT COD,',
'       ASSUNTO,',
'       MENSAGEM',
'  from RS_TEMPLATE_EMAIL',
' where COD = :P35_TEMPLATE_EMAIL;',
' ',
'V_C1 C1%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.COD IS NOT NULL THEN',
'  :P35_SUBJECT_EMAIL := V_C1.ASSUNTO;',
'  :P35_MESSAGE_EMAIL := V_C1.MENSAGEM;',
'ELSE',
'  :P35_SUBJECT_EMAIL := NULL;',
'  :P35_MESSAGE_EMAIL := NULL;',
'END IF;',
'',
'END;'))
,p_attribute_02=>'P35_TEMPLATE_EMAIL'
,p_attribute_03=>'P35_SUBJECT_EMAIL,P35_MESSAGE_EMAIL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16430896079673107111)
,p_name=>'Close Dialog'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(16430895645188107106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16430896261902107112)
,p_event_id=>wwv_flow_api.id(16430896079673107111)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
,p_attribute_01=>'CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439136470461755301)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Processo Envia E-mail'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'begin',
'',
'',
'if :P35_TO_EMAIL is not null then ',
'  PRC_ENVIA_EMAIL (:P35_TO_EMAIL, :p35_subject_email, :p35_message_email, v_flg, v_msg);',
'    ',
'   INSERT INTO CANDIDATO_LOG (COD_CAND_LOG',
'                           ,  COD_REQUISICAO ',
'                           ,  COD_EMPRESA    ',
'                           ,  COD_CANDIDATO  ',
'                           ,  USUARIO        ',
'                           ,  DATA           ',
'                           ,  TEMPLATE_ENVIO ',
'                           ,  FASE           ',
'                           ,  MENSAGEM       ',
'                           ,  OBSERVACAO)',
'   VALUES (nvl((SELECT MAX(COD_CAND_LOG)+1 FROM CANDIDATO_LOG WHERE COD_EMPRESA = :P35_EMP),1) /*CANDIDADO_LOG_SEQ.NEXTVAL*/',
'        ,  :P35_COD_REQUIMENTO			--COD_REQUISICAO ',
'        ,  :P35_EMP						--COD_EMPRESA    ',
'        ,  :P35_COD_CANDIDATO			--COD_CANDIDATO  ',
'        ,  :P_USUARIO 			--USUARIO        ',
'        ,  TO_DATE(SYSDATE,''DD/MM/RRRR'')--DATA           ',
'        ,  :P35_SUBJECT_EMAIL			--TEMPLATE_ENVIO ',
'        ,  :P35_FASE					--FASE           ',
'        ,  :P35_MESSAGE_EMAIL			--MENSAGEM       ',
'        ,  ''E-mail enviado para ''||:P35_TO_EMAIL);--OBSERVACAO',
'  Commit;',
'ELSE ',
'  ',
'   INSERT INTO CANDIDATO_LOG (COD_CAND_LOG',
'                           ,  COD_REQUISICAO ',
'                           ,  COD_EMPRESA    ',
'                           ,  COD_CANDIDATO  ',
'                           ,  USUARIO        ',
'                           ,  DATA           ',
'                           ,  TEMPLATE_ENVIO ',
'                           ,  FASE           ',
'                           ,  MENSAGEM       ',
'                           ,  OBSERVACAO)',
'   VALUES (nvl((SELECT MAX(COD_CAND_LOG)+1 FROM CANDIDATO_LOG WHERE COD_EMPRESA = :P35_EMP),1) /*CANDIDADO_LOG_SEQ.NEXTVAL*/',
'        ,  :P35_COD_REQUIMENTO			--COD_REQUISICAO ',
'        ,  :P35_EMP						--COD_EMPRESA    ',
'        ,  :P35_COD_CANDIDATO			--COD_CANDIDATO  ',
'        ,  :P_USUARIO 			--USUARIO        ',
'        ,  TO_DATE(SYSDATE,''DD/MM/RRRR'')--DATA           ',
'        ,  :P35_SUBJECT_EMAIL			--TEMPLATE_ENVIO ',
'        ,  :P35_FASE					--FASE           ',
'        ,  :P35_MESSAGE_EMAIL			--MENSAGEM       ',
unistr('        ,  ''Erro ao enviar E-mail. Mensagem n\00E3o pode ser enviada.'');--OBSERVACAO'),
'  Commit;',
'end if;',
'',
'',
':p35_flg := v_flg;',
':p35_msg := v_msg;',
'',
'end;'))
,p_process_error_message=>'Erro ao enviar o e-mail - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'ENVIAR_EMAIL'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'E-mail Enviado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(50623940999945250353)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16430895483837107105)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'CLOSE_MODAL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52439176044074838725)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_candidato'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select INITCAP(fnct_nome_cand(cand.COD_EMPRESA,cand.COD_CANDIDATO))||'' (''||pess.COD_CANDIDATO||'')'' CANDIDATO',
',      INITCAP(PESS.NOME) NOME',
',      INITCAP(PESS.NOME_SOCIAL) NOME_SOCIAL',
',      cand.COD_CANDIDATO',
',      cand.COD_FASE||'' - ''||(SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = cand.cod_fase) COD_FASE',
',      cand.COD_EMPRESA||'' - ''||INITCAP(FNCT_NOME_EMPRESA(cand.COD_EMPRESA,''S'')) EMPRESA',
',      LOWER(PESS.E_MAIL) E_MAIL',
' FROM CANDIDATO CAND',
'    , INF_FUNC_CANDIDATO_CAD FUNC',
'    , INF_PESSOAIS_CANDIDATO_CAD PESS',
'WHERE CAND.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND CAND.COD_CANDIDATO = PESS.COD_CANDIDATO',
'  AND CAND.COD_REQ       = :P35_COD_REQUIMENTO',
'  AND CAND.COD_CANDIDATO = :P35_COD_CANDIDATO',
'  AND CAND.COD_FASE = (SELECT MAX(COD_FASE)',
'                    FROM CANDIDATO cand2 ',
'                   WHERE CAND2.COD_CANDIDATO = CAND.COD_CANDIDATO',
'                     AND CAND2.COD_EMPRESA = CAND.COD_EMPRESA',
'                     AND CAND2.COD_REQ = CAND.COD_REQ);',
'                     ',
'                   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select INITCAP(fnct_nome_cand(PESS.EMPRESA,PESS.COD_CANDIDATO))||'' (''||PESS.COD_CANDIDATO||'')'' CANDIDATO',
',      INITCAP(PESS.NOME) NOME',
',      INITCAP(PESS.NOME_SOCIAL) NOME_SOCIAL',
',      NULL /*cand.COD_FASE||'' - ''||(SELECT f.desc_fase FROM fase_candidato f WHERE f.cod_fase = cand.cod_fase)*/ COD_FASE',
',      PESS.COD_CANDIDATO',
',      NULL /*PESS.COD_EMPRESA||'' - ''||INITCAP(FNCT_NOME_EMPRESA(PESS.COD_EMPRESA,''S''))*/ EMPRESA',
',      LOWER(PESS.E_MAIL) E_MAIL',
' FROM INF_FUNC_CANDIDATO_CAD FUNC',
'    , INF_PESSOAIS_CANDIDATO_CAD PESS',
'WHERE PESS.COD_CANDIDATO = FUNC.COD_CANDIDATO',
'  AND PESS.COD_CANDIDATO = :P35_COD_CANDIDATO;  ',
'                   ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF V_C1.COD_CANDIDATO IS NOT NULL THEN',
'',
':p35_cod_empresa_DISPLAY := v_c1.EMPRESA;',
':P35_CANDIDATO_DISPLAY := v_c1.nome;',
':P35_FASE:= v_c1.COD_FASE;',
':P35_TO_EMAIL := v_c1.e_mail;',
':P35_NOME := NVL(V_C1.NOME_SOCIAL,V_C1.NOME);',
'',
'ELSE',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
':p35_cod_empresa_DISPLAY := v_c2.EMPRESA;',
':P35_CANDIDATO_DISPLAY := v_c2.nome;',
':P35_FASE:= v_c2.COD_FASE;',
':P35_TO_EMAIL := v_c2.e_mail;',
'',
'if v_c2.nome_social is not null then',
':P35_NOME := V_C2.NOME_SOCIAL||'' (Nome Social)'';',
'else',
':P35_NOME := V_C2.NOME;',
'end if;',
'',
'END IF;',
'',
'exception',
'when others then',
':p35_cod_empresa_DISPLAY := :p35_emp;',
':p35_matricula_DISPLAY := :p35_mat;',
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
