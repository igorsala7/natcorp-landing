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
,p_default_application_id=>200
,p_default_id_offset=>0
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   14:00 Monday October 19, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 901
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00901
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>901);
end;
/
prompt --application/pages/page_00901
begin
wwv_flow_api.create_page(
 p_id=>901
,p_user_interface_id=>wwv_flow_api.id(284246223447282874847)
,p_name=>'NATCORP - Alterar Senha'
,p_step_title=>'&P_TITULO.'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_html_page_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'style="background:url(#WORKSPACE_IMAGES#BACKGROUND.png) no-repeat center center fixed;   ',
'',
unistr('background-size: cover; /*Css padr\00E3o*/'),
'  -webkit-background-size: cover; /*Css safari e chrome*/',
'  -moz-background-size: cover; /*Css firefox*/',
unistr('  -ms-background-size: cover; /*Css IE n\00E3o use mer#^@%#*/'),
'  -o-background-size: cover; /*Css Opera*/',
'"'))
,p_autocomplete_on_off=>'ON'
,p_html_page_header=>'<div class="image"></div>'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Body{background-color: rgba(255, 255, 255, 0);',
'    position:absolute;',
'    margin:auto;',
'    top:0;',
'    left:0;',
'    right:0;',
'    bottom:0;}',
'',
'div.image {',
'   content:url(#WORKSPACE_IMAGES#LOGO.png);',
'    position:center;',
'    margin: auto;',
'    margin-top: 80px;',
'}',
''))
,p_step_template=>wwv_flow_api.id(284246183312554874704)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20181211163013'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(284098298265866347060)
,p_plug_name=>'Alterar Minha Senha'
,p_icon_css_classes=>'fa-lock-password'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(284246197273710874752)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(284098299122785347060)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_button_name=>'P901_BTN_CONFIRMAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(284098298746018347060)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_button_name=>'P901_BTN_VOLTAR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:900:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-angle-left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098299548020347061)
,p_name=>'P901_USUARIO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_prompt=>unistr('Usu\00E1rio')
,p_placeholder=>unistr('Digite seu usu\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>30
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098299892580347061)
,p_name=>'P901_SENHA_ATUAL'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_prompt=>'Senha Atual'
,p_placeholder=>'Digite sua senha atual'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>40
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098300259247347061)
,p_name=>'P901_NOVA_SENHA'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_prompt=>'Nova Senha'
,p_placeholder=>'Digite uma senha nova'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>40
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('A senha deve ter entre 6 e 30 caracteres, contendo letras mai\00FAsculas, min\00FAsculas e n\00FAmeros. N\00E3o deve conter seu Nome, RG, CPF, Data de Nascimento, Data de Admiss\00E3o, sua Matr\00EDcula e espa\00E7os em branco.')
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_item_comment=>unistr('A senha deve ter entre 6 e 30 caracteres, contendo letras mai\00FAsculas, min\00FAsculas e n\00FAmeros. N\00E3o deve conter seu Nome, RG, CPF, Data de Nascimento, Data de Admiss\00E3o, sua Matr\00EDcula e espa\00E7os em branco.')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098301199943347063)
,p_name=>'P901_CONFIRMAR_SENHA'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_prompt=>'Confirmar Senha'
,p_placeholder=>'Digite novamente sua nova senha'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>40
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098301621884347063)
,p_name=>'P901_OK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098301989661347063)
,p_name=>'P901_MENSAGEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(284098298265866347060)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(284098302469899347064)
,p_validation_name=>'Valida_Confirmar_Senha'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P901_NOVA_SENHA <> :P901_CONFIRMAR_SENHA THEN',
'RETURN(''O campo Confirmar Senha deve ser preenchido igual a Nova Senha!'');',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_message=>'O campo de Confirmar Senha deve ser igual ao campo de Nova Senha!'
,p_always_execute=>'Y'
,p_validation_condition=>'P901_CONFIRMAR_SENHA'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_when_button_pressed=>wwv_flow_api.id(284098299122785347060)
,p_associated_item=>wwv_flow_api.id(284098301199943347063)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(284098302937869347064)
,p_validation_name=>'Valida_Nova_Senha'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P901_NOVA_SENHA = :P901_SENHA_ATUAL THEN',
unistr('RETURN(''O campo Nova Senha n\00E3o pode ser igual ao campo Senha Atual!'');'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_message=>unistr('A nova senha n\00E3o pode ser igual a atual senha!')
,p_always_execute=>'Y'
,p_validation_condition=>'P901_NOVA_SENHA'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_when_button_pressed=>wwv_flow_api.id(284098299122785347060)
,p_associated_item=>wwv_flow_api.id(284098300259247347061)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(284098303623604347064)
,p_name=>'Dispara Alerta'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P901_MENSAGEM'
,p_condition_element=>'P901_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(284098304135311347066)
,p_event_id=>wwv_flow_api.id(284098303623604347064)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P901_OK'').value == "S") {',
'    if ($x(''P901_MENSAGEM'').value.length  > 0 ) {',
'        alertify.success($v(''P901_MENSAGEM''));',
'    }',
'} else {',
'        alertify.alert($v(''P901_MENSAGEM''));',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(284098304554363347066)
,p_name=>'Inicia Alertify'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P901_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(284098305012477347067)
,p_event_id=>wwv_flow_api.id(284098304554363347066)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(284098303217229347064)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Nova_Senha'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' v_existe_msg varchar2(1);',
' v_mensagem varchar2(4000);',
' v_ok varchar2(1);',
'',
'begin',
'',
'    V_EXISTE_MSG := ''N'';',
'    V_MENSAGEM := NULL;',
'    V_OK := ''N'';',
'    ',
'    :P901_OK := ''N'';',
'    :P901_MENSAGEM := NULL;',
'    ',
'    PKG_LOGIN_OPERADOR.PRC_PROCESSA_NOVA_SENHA(:P901_USUARIO, :P901_SENHA_ATUAL, :P901_NOVA_SENHA, V_EXISTE_MSG, V_MENSAGEM, V_OK);',
'',
'    :P901_OK := V_OK;',
'    :P901_MENSAGEM := V_MENSAGEM;',
'    /*',
'    IF V_OK = ''S'' then',
'        if V_EXISTE_MSG = ''S'' THEN',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: ''|| V_MENSAGEM ||''! </span>'';',
'        end if;',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: Senha Alterada Com Sucesso! </span>'';',
'    else',
'        if V_EXISTE_MSG = ''S'' THEN',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: ''|| V_MENSAGEM ||''! </span>'';',
'        end if;',
'    end if;',
'*/',
'EXCEPTION',
'WHEN OTHERS THEN',
'',
'    V_EXISTE_MSG := ''S'';',
'    V_MENSAGEM := ''Erro ao Alterar Senha'';',
'    V_OK := ''N'';',
'    ',
'        :P901_OK := V_OK;',
'    :P901_MENSAGEM := V_MENSAGEM;',
'    /*',
'        if V_EXISTE_MSG = ''S'' THEN',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: ''|| V_MENSAGEM ||''! </span>'';',
'        end if;',
'        */',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(284098299122785347060)
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
