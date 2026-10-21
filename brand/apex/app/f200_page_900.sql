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
--     PAGE: 900
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00900
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>900);
end;
/
prompt --application/pages/page_00900
begin
wwv_flow_api.create_page(
 p_id=>900
,p_user_interface_id=>wwv_flow_api.id(284246223447282874847)
,p_name=>'NATCORP - Painel do Operador'
,p_alias=>'LOGIN_DESKTOP'
,p_step_title=>'&P_TITULO.'
,p_allow_duplicate_submissions=>'N'
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
'"',
''))
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Senha.js'
,p_html_page_header=>'  <div class="image"></div>'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (window.screen.width < 600){',
'  apex.item("P9999_SCREEN").setValue("MIN");',
'}else{',
'  apex.item("P9999_SCREEN").setValue("MAX");',
'}',
'',
'console.log(window.screen.width);'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Body{background-color: rgba(255, 255, 255, 0);',
'    position:absolute;',
'    margin:auto;',
'    top:0;',
'    left:0;',
'    right:0;',
'    bottom:0;}',
'/*',
'div.image {',
'   content:url(#WORKSPACE_IMAGES#LOGO.png);',
'    position:center;',
'margin: auto;',
'    margin-top: 80px;',
'        margin-bottom: 50px;',
'}',
'*/',
'span.t-Login-logo {',
'   background-image: url(#WORKSPACE_IMAGES#LOGO.png);',
'    position:center;',
'margin: auto;',
'  width: 100%;',
'  background-position: center;',
'  background-repeat: no-repeat;',
'  background-size: contain;',
'}',
'',
'',
'.t-Login-title{',
'   font-size: 20px !important;',
'   margin-bottom: 4px !important;',
'   margin-top: 4px !important;',
'   /* display: none; */',
'}',
'',
'.t-Login-header{',
'    padding-top: 8px !important;',
'    padding-bottom: 8px !important;',
'}'))
,p_step_template=>wwv_flow_api.id(284246183312554874704)
,p_page_template_options=>'#DEFAULT#'
,p_browser_cache=>'N'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261014150419'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(284098286916056344894)
,p_plug_name=>'&P_TITULO.'
,p_region_name=>'LOGIN'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(284246197273710874752)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(20385504947551077272)
,p_plug_name=>'Fazendo Login'
,p_region_name=>'FAZENDO_LOGIN'
,p_parent_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--wizard:t-Alert--defaultIcons:t-Alert--success'
,p_plug_template=>wwv_flow_api.id(284246187882533874715)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(284098288094812344896)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_button_name=>'p900_btn_entrar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Entrar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 ',
'  FROM tenant_auth_config',
' WHERE AUTH_METHOD IN (''BOTH'',''LOCAL'')',
'   AND IS_ACTIVE = ''Y'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-power-off'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21205031812895521613)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_button_name=>'btn_entrar_sso'
,p_button_static_id=>'SSO_MANUAL'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--simple:t-Button--iconRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Conta Microsoft'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 ',
'  FROM tenant_auth_config',
' WHERE AUTH_METHOD IN (''BOTH'',''SSO'')',
'   AND IS_ACTIVE = ''Y'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-power-off'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(284098287694885344896)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_button_name=>'p900_btn_alterar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--pillEnd'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_image_alt=>'Alterar Senha'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:901:&SESSION.::&DEBUG.:RP::'
,p_button_condition=>'select 1 from configuracoes where login_alterar_senha = ''S'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-key'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(284098287337058344895)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_button_name=>'P900_BTN_ESQUECI'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(284246218415762874797)
,p_button_image_alt=>'Esqueci Senha'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'select 1 from configuracoes where login_esqueci_senha = ''S'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-question'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(284098294645769344907)
,p_branch_name=>'Go to Home (1)'
,p_branch_action=>'f?p=TERMOS_&P_BASE.:1001:&SESSION.::&DEBUG.:RP,1001:P1001_APP,P1001_PAGE,P1001_COD_EMPRESA,P1001_MATRICULA,P1001_CONSULTA,P_EMPRESA_USER,P_MATRICULA_USER,P_PAINEL,P_USUARIO:&APP_ID.,1,&P_EMPRESA_USER.,&P_MATRICULA_USER.,N,&P_EMPRESA_USER.,&P_MATRICULA_USER.,&P_PAINEL.,&P_USUARIO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'NEVER'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(283974988770753820662)
,p_branch_name=>unistr('Login Autom\00E1tico')
,p_branch_action=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_HEADER'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'FUNCTION_BODY'
,p_branch_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'',
'    PKG_LOGIN_OPERADOR.PRC_VALIDA_ACESSO(:P_USUARIO, :P_SENHA, V_EXISTE_MSG, V_MENSAGEM, V_OK);',
'',
'    IF V_OK = ''S'' then',
'       return true;',
'    else',
'       return false;',
'    end if;',
'end;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21205030804819521603)
,p_name=>'P900_SSO_STATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21205030876649521604)
,p_name=>'P900_MODE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098288474083344897)
,p_name=>'P900_USUARIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_prompt=>unistr('Usu\00E1rio')
,p_placeholder=>unistr('Digite seu usu\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>30
,p_tag_attributes=>'autocomplete="off"'
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098289376401344898)
,p_name=>'P900_SENHA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_prompt=>'Senha'
,p_placeholder=>'Digite sua senha'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>40
,p_tag_attributes=>'autocomplete="off"'
,p_field_template=>wwv_flow_api.id(284246217801438874790)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098290349862344899)
,p_name=>'P900_MENSAGEM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098290673037344899)
,p_name=>'P900_SESSION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098291088797344899)
,p_name=>'P900_BUSCA_USER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(284098291548392344899)
,p_name=>'P900_OK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(284098286916056344894)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(274020446315828143643)
,p_validation_name=>'Senha em branco'
,p_validation_sequence=>10
,p_validation=>'P900_SENHA'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('Campo Obrigat\00F3rio: Senha')
,p_when_button_pressed=>wwv_flow_api.id(284098288094812344896)
,p_associated_item=>wwv_flow_api.id(284098289376401344898)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(284098292717664344904)
,p_name=>'Dispara Alerta'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P900_MENSAGEM'
,p_condition_element=>'P900_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(284098293221956344905)
,p_event_id=>wwv_flow_api.id(284098292717664344904)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P900_OK'').value == "OK") {',
'    if ($x(''P900_MENSAGEM'').value.length  > 0 ) {',
'        alertify.success($v(''P900_MENSAGEM''));',
'    }',
'} else {',
'        alertify.error($v(''P900_MENSAGEM''));',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(284098293603473344905)
,p_name=>'Inicia Alertify'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P900_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(284098294106422344906)
,p_event_id=>wwv_flow_api.id(284098293603473344905)
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(283601483504940866800)
,p_name=>'key-next-item'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P900_SENHA'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(283601483603509866801)
,p_event_id=>wwv_flow_api.id(283601483504940866800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098288094812344896)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281217619406365872703)
,p_name=>'Show Button'
,p_event_sequence=>40
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281217619564104872704)
,p_event_id=>wwv_flow_api.id(281217619406365872703)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287694885344896)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281271312375011179390)
,p_event_id=>wwv_flow_api.id(281217619406365872703)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098288094812344896)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281271312540390179391)
,p_event_id=>wwv_flow_api.id(281217619406365872703)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287337058344895)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281511741396275)
,p_event_id=>wwv_flow_api.id(281217619406365872703)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(21205031812895521613)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20385505096958077274)
,p_event_id=>wwv_flow_api.id(281217619406365872703)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(20385504947551077272)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281271312648534179392)
,p_name=>'Hide Button'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(284098288094812344896)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281271312756366179393)
,p_event_id=>wwv_flow_api.id(281271312648534179392)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287694885344896)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281271312802256179394)
,p_event_id=>wwv_flow_api.id(281271312648534179392)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098288094812344896)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281271312924490179395)
,p_event_id=>wwv_flow_api.id(281271312648534179392)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287337058344895)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6437734405095705597)
,p_event_id=>wwv_flow_api.id(281271312648534179392)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p_sso_azure := ''N'';'
,p_attribute_03=>'P_SSO_AZURE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386280827708396268)
,p_event_id=>wwv_flow_api.id(281271312648534179392)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'LOGIN'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21205032016345521615)
,p_name=>'Auto-submit retorno SSO'
,p_event_sequence=>60
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'SSO_RETURN'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281207320396272)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287694885344896)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281323424396273)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098288094812344896)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281401642396274)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287337058344895)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281578959396276)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(21205031812895521613)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20385504500026077268)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P900_SENHA,P900_USUARIO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20385504988765077273)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(20385504947551077272)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386280626837396266)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_user varchar2(255);',
'begin',
'  -- Busca pelo STATE (robusto; nao depende da sessao APEX, que muda no retorno).',
'  l_user := pkg_sso_session.username_for_state(p_state_id => :P900_SSO_STATE);',
' ',
'  if l_user is not null then',
'    :P900_USUARIO := l_user;',
'    :P900_SENHA := NULL;',
'  else',
'    -- complete_sso nao gravou marca para este state (falhou, expirou ou ja',
'    -- consumido). Nao popula; o submit nao acontece e o usuario ve a tela.',
'    :P900_USUARIO := null;',
'    :P900_SENHA := NULL;',
'    --null;',
'  end if;',
'  ',
'end;'))
,p_attribute_02=>'P900_SSO_STATE'
,p_attribute_03=>'P900_USUARIO,P900_SENHA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281115409396271)
,p_event_id=>wwv_flow_api.id(21205032016345521615)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'LOGIN'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(20386281706609396277)
,p_name=>'SSO - Hide Itens/Buttons'
,p_event_sequence=>70
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 ',
'  FROM tenant_auth_config',
' WHERE AUTH_METHOD = ''SSO''',
'   AND IS_ACTIVE = ''Y'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281814441396278)
,p_event_id=>wwv_flow_api.id(20386281706609396277)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P900_USUARIO,P900_SENHA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281959375396279)
,p_event_id=>wwv_flow_api.id(20386281706609396277)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287694885344896)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386281972294396280)
,p_event_id=>wwv_flow_api.id(20386281706609396277)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098287337058344895)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20386282114967396281)
,p_event_id=>wwv_flow_api.id(20386281706609396277)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(284098288094812344896)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(284098291886376344903)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'esqueci_senha'
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
'    :P900_OK := ''N'';',
'    :P900_MENSAGEM := NULL;',
'    ',
'    PKG_LOGIN_OPERADOR.PRC_ESQUECI_SENHA(:P900_USUARIO, V_EXISTE_MSG, V_MENSAGEM, V_OK);',
'',
'    :P900_OK := V_OK;',
'    :P900_MENSAGEM := V_MENSAGEM;',
'/*',
'    IF V_OK = ''S'' then',
'        if V_EXISTE_MSG = ''S'' THEN',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: ''|| V_MENSAGEM ||''! </span>'';',
'        end if;',
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
'    V_MENSAGEM := ''Erro ao Enviar E-Mail!'';',
'    V_OK := ''N'';',
'    ',
'    :P900_OK := V_OK;',
'    :P900_MENSAGEM := V_MENSAGEM;',
'    /*',
'        if V_EXISTE_MSG = ''S'' THEN',
'            apex_application.g_print_success_message := ''<span style="color:white">Mensagem: ''|| V_MENSAGEM ||''! </span>'';',
'        end if;',
'*/',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(284098287337058344895)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283387820670374118097)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_user varchar2(255) := :p900_usuario;',
'  l_pass varchar2(255) := :p900_senha;',
'begin',
'  /*',
'  l_user := pkg_sso_session.username_for_state(p_state_id => :P900_SSO_STATE);',
'  ',
'  if trim(l_user) is null then',
'     l_user := :p900_usuario;',
'  else',
'     l_pass := null;',
'  end if;',
'',
'insert into testex values (900, l_user ||'' ''||to_char(sysdate,''dd/mm/rrrr hh24:mi:ss'')); commit;',
'',
'  apex_authentication.login (',
'    p_username           => l_user,',
'    p_password           => l_pass,',
'    p_uppercase_username => false',
'  );',
'  */',
'  if :p900_usuario is not null then',
'  apex_authentication.login (',
'    p_username           => :P900_USUARIO,',
'    p_password           => :P900_SENHA,',
'    p_uppercase_username => false',
'  );',
'  end if;',
'  ',
'-- insert into testex values (910, l_user ||'' ''||to_char(sysdate,''dd/mm/rrrr hh24:mi:ss'')); commit;',
'',
'end;',
'',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'LOGIN'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281271315008456179416)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Define Painel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' v_painel_gestor varchar2(1) := ''N'';',
' v_painel_oper   varchar2(1) := ''N'';',
' ',
'begin',
'',
'    IF pkg_acesso_po.FNCT_BOTAO(',
'    P_PAGE => 1, ',
'    P_USUARIO => :P_USUARIO,',
'    P_PAGE_NAME => NULL,',
'    P_MODULO => ''HOME'', ',
'    P_SUB_MODULO => NULL,',
'    P_PAINEL => ''PG'')',
'    then',
'     v_painel_gestor := ''S'';',
'    end if;',
'    ',
'    IF pkg_acesso_po.FNCT_BOTAO(',
'    P_PAGE => 1, ',
'    P_USUARIO => :P_USUARIO,',
'    P_PAGE_NAME => NULL,',
'    P_MODULO => ''HOME'', ',
'    P_SUB_MODULO => NULL,',
'    P_PAINEL => ''PO'')',
'    then',
'     v_painel_oper := ''S'';',
'    end if;',
'    ',
'    if nvl(v_painel_gestor,''N'') = ''S'' and nvl(v_painel_oper,''N'') = ''S'' then',
'       null;',
'    elsif nvl(v_painel_gestor,''N'') = ''S'' and nvl(v_painel_oper,''N'') = ''N'' and :p_painel = ''PO'' then',
'       :p_painel := ''PG'';',
'    elsif nvl(v_painel_gestor,''N'') = ''N'' and nvl(v_painel_oper,''N'') = ''S'' and :p_painel = ''PG'' then',
'       :p_painel := ''PO'';',
'    end if;',
'    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(275127457942685833103)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>':P900_USUARIO := apex_authentication.get_login_username_cookie;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P900_SSO_STATE'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21205031487975521610)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SSO - Concluir Retorno'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  pkg_sso_auth.complete_sso(p_state => :P900_SSO_STATE);',
'exception when others then',
'  apex_error.add_error(',
'    p_message          => ''Falha no login SSO: '' || sqlerrm,',
'    p_display_location => apex_error.c_inline_in_notification);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SSO_RETURN'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21205031643011521611)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SSO - Erro Retorno'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  apex_error.add_error(',
'    p_message          => ''Nao foi possivel concluir o login com a Microsoft. Tente novamente.'',',
'    p_display_location => apex_error.c_inline_in_notification);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SSO_ERROR'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21205031391111521609)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SSO - Auto Redirect'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(4000);',
'begin',
'',
'  apex_debug.info(''AUTO-REDIRECT entrou. ALIAS=%s, REQUEST=%s, STATE=%s'',',
'                  :P_PAINEL, v(''REQUEST''), :P900_SSO_STATE);',
'',
'  -- So tenta auto-SSO se ainda nao ha state em jogo (carga "limpa" da 900).',
'  if :P900_SSO_STATE is null then',
'    l_url := pkg_sso_app.maybe_begin_sso(',
'               p_app_alias  => :p_painel,',
'               p_app_id     => :APP_ID,',
'               p_login_page => :APP_PAGE_ID);',
'               ',
'    apex_debug.info(''maybe_begin_sso retornou: %s'', substr(l_url,1,80));          ',
'               ',
'    if l_url is not null then',
'      apex_util.redirect_url(l_url);   -- vai para a Microsoft; encerra o engine',
'    end if;',
'    -- Se retornou NULL: cliente LOCAL/BOTH ou alias nao mapeado -> exibe a 900.',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SSO_RETURN,SSO_ERROR,LOGIN,LOGOUT'
,p_process_when_type=>'REQUEST_NOT_IN_CONDITION'
,p_process_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :REQUEST is null or :REQUEST not in (''SSO_RETURN'',''SSO_ERROR'',''LOGIN'') THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21205031333633521608)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login SSO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_route   varchar2(10);',
'  l_url     varchar2(4000);',
'  l_user    varchar2(200);',
'begin',
'',
'  l_user := pkg_sso_session.username_for_state(p_state_id => :P900_SSO_STATE);',
' ',
'  if l_user is null then',
'    apex_error.add_error(',
unistr('      p_message => ''Usu\00E1rio n\00E3o identificado'','),
'      p_display_location => apex_error.c_inline_in_notification);',
'    return;',
'  end if;',
'',
'  l_route := pkg_sso_auth.route_for_email(l_user);',
'',
'  if l_route = ''SSO'' then',
'    -- redirect_uri vem do callback_url do tenant (caminho ORDS por cliente).',
'    -- app_id/login_page sao gravados no estado p/ o callback devolver na app certa.',
'    l_url := pkg_sso_auth.begin_sso(',
'               p_email      => l_user,',
'               p_app_id     => :APP_ID,',
'               p_login_page => :APP_PAGE_ID);',
'    apex_util.redirect_url(l_url);   -- encerra o engine e redireciona',
' ',
'    :P900_MODE := ''SSO'';',
'',
'  elsif l_route in (''LOCAL'',''BOTH'') then',
'    -- Revela o campo de senha (segundo passo do login local)',
'    :P900_MODE := ''LOCAL'';',
'    -- Para BOTH voce tambem pode exibir um botao "Entrar com Microsoft"',
'    -- que dispara o ramo SSO chamando begin_sso.',
'',
'  else',
'    apex_error.add_error(',
'      p_message => ''Configuracao de login indisponivel para este e-mail.'',',
'      p_display_location => apex_error.c_inline_in_notification);',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SSO_RETURN'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21205031900544521614)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login SSO Manual'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(4000);',
'  l_tenant varchar2(50);',
'begin',
'',
'  apex_debug.info(''Login SSO Manual entrou. ALIAS=%s, REQUEST=%s, STATE=%s'',',
'                  :P_PAINEL, v(''REQUEST''), :P900_SSO_STATE);',
'',
':P900_MODE := ''SSO'';',
'',
'    l_tenant := pkg_sso_app.tenant_for_alias(:p_painel);',
'    l_url := pkg_sso_auth.begin_sso(',
'               p_email => null,',
'               p_app_id     => :APP_ID,',
'               p_login_page => :APP_PAGE_ID,',
'               p_tenant_id => l_tenant);',
'               ',
'    apex_debug.info(''pkg_sso_app.begin_sso retornou: %s'', substr(l_url,1,80));          ',
'               ',
'    if l_url is not null then',
'      apex_util.redirect_url(l_url);   -- vai para a Microsoft; encerra o engine',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(21205031812895521613)
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
