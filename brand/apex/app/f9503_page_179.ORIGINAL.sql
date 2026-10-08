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
,p_default_application_id=>9503
,p_default_id_offset=>777366879312119448
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   23:08 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 179
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00179
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>179);
end;
/
prompt --application/pages/page_00179
begin
wwv_flow_api.create_page(
 p_id=>179
,p_user_interface_id=>wwv_flow_api.id(199995603908188555028)
,p_name=>unistr('Criar/Editar: Requisi\00E7\00E3o Escala para Colaborador')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Criar/Editar: Requisi\00E7\00E3o Escala para Colaborador')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'ANDRE.BONI'
,p_last_upd_yyyymmddhh24miss=>'20250509153539'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(180215433005420362563)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(180217186935116494933)
,p_plug_name=>'MENU'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(180215434090114362574)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(180217186935116494933)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>31
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_ESCALA a, usuario_oracle u',
' where a.cod_req = :p179_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil)/* or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))*/)',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_ESCALA a, usuario_oracle u',
' where a.cod_req = :p179_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'      /*and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)) */',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554814770212373443)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554815204666373474)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554815608400373474)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554815991651373475)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_inline_lov=>'STATIC2:Aprovado;A,Pendente;P,Reprovado;R'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554816408837373475)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554816775589373475)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554817170963373475)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(176554817625575373482)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(208296345939470260795)
,p_plug_name=>'Escala'
,p_parent_plug_id=>wwv_flow_api.id(180217186935116494933)
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(199995569833856554920)
,p_plug_display_sequence=>21
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_plug_read_only_when=>'P179_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(208296346630452260797)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(199995569917028554921)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(144249249987381193727)
,p_button_sequence=>210
,p_button_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_button_name=>'Disponibilizar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Disponibilizar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(144249250045342193728)
,p_button_sequence=>220
,p_button_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_button_name=>'Transferir'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Transferir'
,p_button_position=>'BODY'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-exchange'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554817971598373482)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(180215434090114362574)
,p_button_name=>'REPROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P179_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_ESCALA',
' where cod_req = :p179_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'PKG_REQ_ESCALA.Valida_Sequencia (:p179_cod_empresa, :p179_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554826122560373553)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(208296346630452260797)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554818421480373514)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(180215434090114362574)
,p_button_name=>'APROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P179_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_ESCALA',
' where cod_req = :p179_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'V_TERMO_PENDENTE VARCHAR2(1) := ''N'';',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'PKG_REQ_ESCALA.Valida_Sequencia (:p179_cod_empresa, :p179_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        ',
'      V_TERMO_PENDENTE := PKG_TERMOS.fnct_termo_pendente (p_app => :APP_ID,',
'                                                          p_page => :PAGE_ID,',
'                                                          p_publico => ''F'',',
'                                                          p_cod_empresa => :P_EMPRESA_USER,',
'                                                          p_matricula => :P_MATRICULA_USER,',
'                                                          p_cod_candidato => NULL,',
'                                                          p_tipo_documento => NULL,',
'                                                          p_documento => NULL,',
'                                                          p_cod_req => :P179_COD_REQ);',
'                                                          ',
'        ',
'        IF NVL(V_TERMO_PENDENTE,''N'') = ''S'' THEN',
'          RETURN FALSE;',
'        ELSE',
'          RETURN TRUE;',
'        END IF;',
'        ',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167357696137992838647)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(180215434090114362574)
,p_button_name=>'APROVAR_TERMO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=TERMOS_&P_BASE.:1000:&SESSION.::&DEBUG.:RP,1000:P1000_COD_REQ,P1000_COD_EMPRESA,P1000_MATRICULA,P1000_APP,P1000_PAGE:&P179_COD_REQ.,&P_EMPRESA_USER.,&P_MATRICULA_USER.,&APP_ID.,&PAGE_ID.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_ESCALA',
' where cod_req = :p179_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'V_TERMO_PENDENTE VARCHAR2(1) := ''N'';',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'PKG_REQ_ESCALA.Valida_Sequencia (:p179_cod_empresa, :p179_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        ',
'      V_TERMO_PENDENTE := PKG_TERMOS.fnct_termo_pendente (p_app => :APP_ID,',
'                                                          p_page => :PAGE_ID,',
'                                                          p_publico => ''F'',',
'                                                          p_cod_empresa => :P_EMPRESA_USER,',
'                                                          p_matricula => :P_MATRICULA_USER,',
'                                                          p_cod_candidato => NULL,',
'                                                          p_tipo_documento => NULL,',
'                                                          p_documento => NULL,',
'                                                          p_cod_req => :P179_COD_REQ);',
'                                                          ',
'        ',
'        IF NVL(V_TERMO_PENDENTE,''N'') = ''S'' THEN',
'          RETURN TRUE;',
'        ELSE',
'          RETURN FALSE;',
'        END IF;',
'        ',
'    ELSE',
'      RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554826491548373571)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(208296346630452260797)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554827256416373586)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(208296346630452260797)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P179_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(176554826878732373586)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(208296346630452260797)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P179_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(120626511743030417571)
,p_name=>'P179_MOSTRA_CRIAR'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144150854289962994414)
,p_name=>'P179_TOTAL_CENTRO_CUSTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(144155708833307728975)
,p_name=>'P179_CCUSTO_PLANTAO_DSP'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554811852358373402)
,p_name=>'P179_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P179_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554812316633373423)
,p_name=>'P179_DT_REQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Requisi\00E7\00E3o')
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P179_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554812636437373423)
,p_name=>'P179_COD_SIT_REQ'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ_PLANTAO',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554812949569373424)
,p_name=>'P179_DT_SIT_REQ'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Situa\00E7\00E3o')
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P179_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554813434839373424)
,p_name=>'P179_COD_EMP_SOLICITANTE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554813819217373424)
,p_name=>'P179_MAT_SOLICITANTE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(180215433005420362563)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554819123823373515)
,p_name=>'P179_ERR_MSG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554819480279373536)
,p_name=>'P179_SEMCONSELHO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554819775037373536)
,p_name=>'P179_ROWID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554820186377373536)
,p_name=>'P179_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) as d,',
'       cod as r',
'  from empresas',
' order by cod'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(199995598444609554972)
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
 p_id=>wwv_flow_api.id(176554820587118373537)
,p_name=>'P179_MATRICULA'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct I.MATRICULA||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) as d, I.MATRICULA as r',
'    FROM INFORMACOES_FUNCIONAIS_CAD I, PE_ESCALAS_EXCECOES E, CENTRO_DE_CUSTO C',
'    WHERE I.COD_EMPRESA = E.COD_EMPRESA',
'      AND I.COD_EMPRESA = C.COD_EMPRESA',
'      AND I.COD_CCUSTO = C.COD',
'      AND I.MATRICULA = E.MATRICULA',
'      AND I.COD_EMPRESA = nvl( :P179_COD_EMPRESA, :P_EMPRESA_USER)',
'      and (c.matricula_gestor = :P_MATRICULA_USER or c.matricula_suplente  = :P_MATRICULA_USER )',
'      AND i.marca_ponto = ''S''',
'      AND i.situacao < ''90''',
'      and :P_PAINEL = ''PG'' ',
'    UNION  ',
'    SELECT distinct I.MATRICULA||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) as d, I.MATRICULA as r',
'    FROM INFORMACOES_FUNCIONAIS_CAD I, PE_ESCALAS_EXCECOES E',
'    WHERE I.COD_EMPRESA = E.COD_EMPRESA',
'      AND I.MATRICULA = E.MATRICULA',
'      AND I.COD_EMPRESA = nvl( :P179_COD_EMPRESA, :P_EMPRESA_USER)',
'      AND i.marca_ponto = ''S''',
'      AND i.situacao < ''90''',
'      and :P_PAINEL = ''PO'' ',
'order by 2 asc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P179_COD_EMPRESA,P179_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(199995598444609554972)
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
 p_id=>wwv_flow_api.id(176554821002219373537)
,p_name=>'P179_ESCALA_PLANTAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>unistr('Plant\00E3o?')
,p_source=>'ESCALA_PLANTAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554821353977373537)
,p_name=>'P179_MOT_ALT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo'
,p_source=>'MOT_ALT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod||'' - ''||initcap(a.descricao) decricao, a.cod codigo ',
'  from motivo_alteracoes a ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>3
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554821822483373537)
,p_name=>'P179_COD_LOCAL_TRAB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local de Trabalho'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT L.COD_LOCAL_TRAB||'' - ''||initcap(L.DESCRICAO) AS D, ',
'       L.COD_LOCAL_TRAB AS R ',
'  FROM LOCAL_TRAB L, FILIAL_LOCAL F',
' WHERE F.COD_EMPRESA = :P179_COD_EMPRESA',
' ORDER BY L.COD_LOCAL_TRAB ASC'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P179_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>32
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554822196632373537)
,p_name=>'P179_COD_JORNADA'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Jornada'
,p_source=>'COD_JORNADA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_sql    varchar2(4000);',
'begin',
'    if :P179_ESCALA_PLANTAO = ''N'' then',
unistr('        v_sql := ''SELECT distinct ''''Empresa = ''''||j.cod_empresa||'''' - C\00F3d.Jornada = ''''||j.cod_jornada||''''- Descri\00E7\00E3o = ''''||j.nome_jornada det,j.cod_jornada ret'';'),
'        v_sql := v_sql||'' FROM pe_jornadas j, INFORMACOES_FUNCIONAIS_CAD I, REG_TRABALHO rt'';',
'        v_sql := v_sql||'' WHERE ''''N'''' = ''''''|| :P179_ESCALA_PLANTAO  ||'''''''';',
'        v_sql := v_sql||'' AND I.COD_EMPRESA = ''||nvl( :P179_COD_EMPRESA, :P_EMPRESA_USER); ',
'        --v_sql := v_sql||'' AND i.matricula = nvl(''||:P99179_MATRICULA||'',i.matricula) '';',
'        v_sql := v_sql||'' AND rt.cod(+) = i.reg_trab'';   ',
'        v_sql := v_sql||'' AND RT.COD_EMPRESA(+) = I.COD_EMPRESA'';',
'        v_sql := v_sql||'' AND ''||nvl(:P179_CCUSTO_PLANTAO, 0)||'' = 0'';        ',
'        v_sql := v_sql||'' AND j.total_horas_mensais =  rt.jornada_mensal_h||'''':''''||lpad(rt.jornada_mensal_m,2, ''''0'''') '';',
'        v_sql := v_sql||'' AND EXISTS '';',
'        v_sql := v_sql||''  (SELECT 1 FROM PE_JORNADAS WHERE ALTERA_JORNADA = DECODE(''''''||:P_PAINEL||'''''', ''''PG'''', ''''S'''', ''''N'''') AND COD_JORNADA = J.COD_JORNADA)'';',
'        v_sql := v_sql||'' order by 2'';',
'    else',
unistr('        v_sql := ''SELECT distinct  ''''Empresa = ''''||j.cod_empresa||'''' - C\00F3d.Jornada = ''''||j.cod_jornada||''''- Descri\00E7\00E3o = ''''||j.nome_jornada det,j.cod_jornada ret'';'),
'        v_sql := v_sql||'' FROM PE_CCUSTO_PLANTAO_COLAB P , PE_JORNADAS J '';',
'        v_sql := v_sql||'' WHERE ''''S'''' = ''''''||:P179_ESCALA_PLANTAO  ||'''''''';',
'        v_sql := v_sql||'' AND P.COD_EMPRESA = ''''''||nvl( :P179_COD_EMPRESA, :P_EMPRESA_USER) ||'''''''';',
'--        v_sql := v_sql||'' AND P.matricula = ''''''||:P99179_MATRICULA||'''''''';',
'        --v_sql := v_sql||'' AND i.matricula = nvl(''||:P99179_MATRICULA||'',i.matricula) '';',
'        v_sql := v_sql||'' AND COD_CCUSTO = ''''''||:P179_CCUSTO_PLANTAO||'''''''';',
'        v_sql := v_sql||'' AND P.COD_EMPRESA = J.COD_empresa'';',
'        v_sql := v_sql||'' and P.cod_jornada = j.cod_jornada'';',
'        v_sql := v_sql||'' AND EXISTS '';',
'        v_sql := v_sql||''  (SELECT 1 FROM PE_JORNADAS WHERE ALTERA_JORNADA = DECODE(''''''||:P_PAINEL||'''''', ''''PG'''', ''''S'''', ''''N'''') AND COD_JORNADA = J.COD_JORNADA)'';',
'        v_sql := v_sql||'' ORDER BY 2 '';',
'    end if;',
'insert into testex values (-101, ''ANDRE = ''||v_sql);',
'COMMIT;',
'    return v_sql;',
'end;'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P179_ESCALA_PLANTAO,P179_COD_EMPRESA,P179_ESCALA_PLANTAO,P179_CCUSTO_PLANTAO'
,p_ajax_items_to_submit=>'P179_ESCALA_PLANTAO,P179_COD_EMPRESA,P179_ESCALA_PLANTAO,P179_CCUSTO_PLANTAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554822603117373537)
,p_name=>'P179_COD_ESCALA'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Escala'
,p_source=>'COD_ESCALA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct p.cod_escala||'' - ''||p.descricao descr, p.cod_escala',
' from PE_ESCALAS p, pe_escalas_jornadas j',
'where p.cod_escala = j.cod_escala',
'  and j.cod_jornada = :p179_cod_jornada',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P179_COD_JORNADA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554822966996373551)
,p_name=>'P179_CCUSTO_PLANTAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C.Custo Plant\00E3o')
,p_placeholder=>'-'
,p_source=>'CCUSTO_PLANTAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT cc.cod||''-''||cc.nome det',
'      ,cc.cod               ret',
'  FROM centro_de_custo cc',
' WHERE cc.cod_empresa = :P179_COD_EMPRESA',
'   AND ((EXISTS(SELECT 1',
'                  FROM informacoes_funcionais f',
'                 WHERE f.cod_empresa = cc.cod_empresa',
'                   AND f.matricula   = :P179_MATRICULA',
'                   AND f.cod_ccusto  = cc.cod)) OR ',
'        (EXISTS(SELECT 1',
'                 FROM pe_ccusto_plantao_colab cp',
'                WHERE cp.cod_empresa = cc.cod_empresa',
'                  AND cp.matricula   = :P179_MATRICULA',
'                  AND cp.cod_ccusto  = cc.cod))) ',
'   AND :P179_ESCALA_PLANTAO = ''S''             ',
'ORDER BY 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P179_ESCALA_PLANTAO'
,p_ajax_items_to_submit=>'P179_ESCALA_PLANTAO,P179_COD_EMPRESA,P179_MATRICULA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>32
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Centros de Custo - Plant\00E3o')
,p_attribute_08=>'430'
,p_attribute_09=>'450'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554823409852373552)
,p_name=>'P179_INICIO'
,p_is_required=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('In\00EDcio')
,p_source=>'INICIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554823838691373552)
,p_name=>'P179_FIM'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fim'
,p_source=>'FIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554824180656373552)
,p_name=>'P179_EXCECAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>unistr('Exce\00E7\00E3o')
,p_source=>'EXCECAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554824599862373552)
,p_name=>'P179_JUSTIFICATIVA'
,p_is_required=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Justificativa'
,p_source=>'JUSTIFICATIVA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554824972649373552)
,p_name=>'P179_USUARIO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(176554825394320373553)
,p_name=>'P179_DT_ATUALIZACAO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(208296345939470260795)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(176554827816437373586)
,p_computation_sequence=>10
,p_computation_item=>'P179_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_USUARIO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(176554828222514373601)
,p_computation_sequence=>10
,p_computation_item=>'P179_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'sysdate'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(176554830063487373666)
,p_validation_name=>'Verifica Processo Trabalhista'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P179_COD_EMPRESA IS NOT NULL AND :P179_MATRICULA IS NOT NULL THEN',
'    vReturn := PKG_PE_ABONO.fnc_VerExistProcessTrab(pEmpresa   => :P179_COD_EMPRESA',
'                                                   ,pmatricula => :P179_MATRICULA',
'                                                   ,pCod_Escala  => :P179_COD_ESCALA',
'                                                  ,pCod_Jornada => :P179_COD_JORNADA',
'                                                  ,pDt_Ini_Proc => :P179_INICIO',
'                                                  ,pDt_Fim_Proc => :P179_FIM);',
'                                                   ',
'  END IF; ',
'  --',
'  IF vReturn IS NOT NULL THEN',
'    IF :P179_ROWID IS NULL THEN',
unistr('      vReturn := ''<strong>Inclus\00E3o N\00C3O Permitida nesta Jornada!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
'    ELSE',
unistr('       vReturn := ''<strong>Altera\00E7\00E3o N\00C3O Permitida nesta Jornada!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(176554829679281373666)
,p_validation_name=>'Valida Escala'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(2500) DEFAULT NULL;',
'  vMsg     VARCHAR2(2500) DEFAULT NULL;',
'BEGIN',
'IF :P179_ESCALA_PLANTAO = ''N'' THEN',
'  IF :P179_COD_ESCALA IS NOT NULL THEN',
'    PKG_PE_ABONO.prc_ValidaJornada(pEmpresa   => :P179_COD_EMPRESA',
'                                  ,pmatricula => :P179_MATRICULA',
'                                  ,pEscala    => :P179_COD_ESCALA',
'                                  ,pJornada   => :P179_COD_JORNADA',
'                                  ,pPlantao   => :P179_ESCALA_PLANTAO',
'                                  ,pValida    => ''S''',
'                                  ,pMsgRet    => vMsg);',
'    --',
'    IF vMsg IS NOT NULL THEN',
unistr('      vReturn := ''<strong>Escala N\00C3O Permitida para a Jornada!</strong><br>''||REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
'    END IF;',
'  END IF;',
'  --',
'END IF;  ',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(176554822603117373537)
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(176554829335804373666)
,p_validation_name=>unistr('Valida C.Custo Plant\00E3o')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF NVL(:P179_ESCALA_PLANTAO, ''N'') = ''S'' THEN',
'    IF :P179_CCUSTO_PLANTAO IS NULL THEN',
unistr('      vReturn := ''C.CUSTO PLANT\00C3O deve ser informado!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(176554822966996373551)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(176554828619916373601)
,p_validation_name=>unistr('Valida Exce\00E7\00E3o')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P179_EXCECAO IS NULL THEN',
unistr('    vReturn := ''EXCE\00C7\00C3O deve ser informada!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(176554824180656373552)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(176554829006514373666)
,p_validation_name=>'Sobreposicao de Horario'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  A.*',
'from    PE_ESCALAS_EXCECOES A',
'where   A.EXCECAO = ''S''',
'and     A.MATRICULA = :P179_MATRICULA',
'and     (:P179_ROWID is null or A.ROWID != :P179_ROWID)',
'and     (',
'            to_date(A.INICIO,''DD/MM/RRRR'') between to_date(:P179_INICIO,''DD/MM/YYYY'') and to_date(:P179_FIM,''DD/MM/YYYY'') or',
'            A.FIM between to_date(:P179_INICIO,''DD/MM/YYYY'') and to_date(:P179_FIM,''DD/MM/YYYY'') or',
'            ',
'            to_date(:P179_INICIO,''DD/MM/YYYY'') between A.INICIO and A.FIM or',
'            to_date(:P179_FIM,''DD/MM/YYYY'') between A.INICIO and A.FIM ',
'        )'))
,p_validation_type=>'NOT_EXISTS'
,p_error_message=>'Foi constatado sobreposicao de horario'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(119966453710527879976)
,p_validation_name=>unistr('Valida data admiss\00E3o x data escala')
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    return FNC_ADMISSAO_ESCALA(p_codempresa    => :P179_COD_EMPRESA',
'                               ,p_matricula    => :P179_MATRICULA',
'                               ,p_data_escala  => :P179_INICIO);',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(176554823409852373552)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554833207541373668)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(176554826122560373553)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554833698892373691)
,p_event_id=>wwv_flow_api.id(176554833207541373668)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554834073146373696)
,p_name=>'DisparaAlerta'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_ERR_MSG'
,p_condition_element=>'P179_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554834590000373696)
,p_event_id=>wwv_flow_api.id(176554834073146373696)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P179_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P179_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554835005877373696)
,p_name=>'Inicia Alertify'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554835543653373696)
,p_event_id=>wwv_flow_api.id(176554835005877373696)
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
 p_id=>wwv_flow_api.id(176554835942886373696)
,p_name=>'Verifica Escala'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_COD_ESCALA'
,p_condition_element=>'P179_COD_ESCALA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554836412734373697)
,p_event_id=>wwv_flow_api.id(176554835942886373696)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(2500) DEFAULT NULL;',
'  vMsg     VARCHAR2(2500) DEFAULT NULL;',
'BEGIN',
'  :P179_ERR_MSG := NULL;',
'  --',
'  PKG_PE_ABONO.prc_ValidaJornada(pEmpresa   => :P179_COD_EMPRESA',
'                                ,pmatricula => :P179_MATRICULA',
'                                ,pEscala    => :P179_COD_ESCALA',
'                                ,pJornada   => :P179_COD_JORNADA',
'                                ,pPlantao   => :P179_ESCALA_PLANTAO ',
'                                ,pValida    => ''N''',
'                                ,pMsgRet    => vMsg);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    vReturn := REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>''), ''- '');',
'  END IF;',
'  --',
'  :P179_ERR_MSG := vReturn;',
'END;'))
,p_attribute_02=>'P179_COD_EMPRESA,P179_MATRICULA,P179_COD_ESCALA,P179_COD_JORNADA,P179_ERR_MSG,P179_ESCALA_PLANTAO'
,p_attribute_03=>'P179_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554836777801373697)
,p_name=>unistr('Verifica Conselho Colaborador - Plant\00E3o')
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_ESCALA_PLANTAO'
,p_condition_element=>'P179_ESCALA_PLANTAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554837253898373698)
,p_event_id=>wwv_flow_api.id(176554836777801373697)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vCont    NUMBER DEFAULT 0;',
'  --',
'  CURSOR cConselho IS',
'    SELECT r.sigla, r.nome, r.num_ordem',
'      FROM conselho_regional r',
'     WHERE r.num_ordem = (SELECT p.sigla_cons_reg FROM inf_pessoais p WHERE p.cod_empresa = :P179_COD_EMPRESA AND p.matricula = :P179_MATRICULA);',
'  --',
'  rConselho    cConselho%ROWTYPE;',
'BEGIN',
'  :P179_SEMCONSELHO := NULL;',
'  :P179_ERR_MSG     := NULL;',
'  --',
'  IF :P179_ESCALA_PLANTAO = ''S'' THEN',
'    vCont := pkg_PontoPerfil.fnc_VerifConselhoColab(pEmpresa   => :P179_COD_EMPRESA',
'                                                   ,pMatricula => :P179_MATRICULA);',
'    --',
'    IF vCont = 0 THEN',
'      :P179_SEMCONSELHO := ''S'';',
'    ELSE',
'      vCont := pkg_PontoPerfil.fnc_VerifConselhoJornadaColab(pEmpresa   => :P179_COD_EMPRESA',
'                                                            ,pMatricula => :P179_MATRICULA);',
'      --',
'      IF vCont = 0 THEN',
'        OPEN cConselho;',
'        FETCH cConselho INTO rConselho;',
'        CLOSE cConselho;',
'        --',
unistr('        :P179_ERR_MSG := ''<strong>N\00E3o existe jornada para o conselho [''||rConselho.sigla||''] do colaborador</strong>!<br>.<i>Cadastre em Ponto Perfil e tente novamente</i>.'';'),
'      END IF;',
'    END IF;',
'  END IF;',
'END;'))
,p_attribute_02=>'P179_COD_EMPRESA,P179_MATRICULA,P179_SEMCONSELHO,P179_ESCALA_PLANTAO,P179_ERR_MSG'
,p_attribute_03=>'P179_SEMCONSELHO,P179_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554837822402373698)
,p_event_id=>wwv_flow_api.id(176554836777801373697)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_SEMCONSELHO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554838165941373698)
,p_name=>unistr('Desabilita C.Custo Plant\00E3o')
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_ESCALA_PLANTAO'
,p_condition_element=>'P179_ESCALA_PLANTAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554838711560373711)
,p_event_id=>wwv_flow_api.id(176554838165941373698)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554839180747373712)
,p_event_id=>wwv_flow_api.id(176554838165941373698)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554839711044373712)
,p_event_id=>wwv_flow_api.id(176554838165941373698)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(176554840097212373712)
,p_name=>'Nova Requisicao'
,p_event_sequence=>70
,p_condition_element=>'P179_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P179_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554840599781373712)
,p_event_id=>wwv_flow_api.id(176554840097212373712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(180215433005420362563)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554841313661373756)
,p_event_id=>wwv_flow_api.id(176554840097212373712)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(180215434090114362574)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554841698300373756)
,p_event_id=>wwv_flow_api.id(176554840097212373712)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(180215434090114362574)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(176554842192550373756)
,p_event_id=>wwv_flow_api.id(176554840097212373712)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(180215433005420362563)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(144249250178349193729)
,p_name=>'Disponibilizar'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(144249249987381193727)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144249250259713193730)
,p_event_id=>wwv_flow_api.id(144249250178349193729)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Deseja Disponibilizar Esta Escala ?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'REVERSE'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144249250343627193731)
,p_event_id=>wwv_flow_api.id(144249250178349193729)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_hist_id    number := 0;',
'begin',
'    select SEQ_REQ_PE_ESCALAS_TRANSFER_HIST.nextval',
'        into l_hist_id',
'    from dual;',
'    --',
'    insert into REQ_PE_ESCALAS_TRANSFER_HIST ',
'        (cod_transfer',
'        ,cod_req_origem',
'        ,cod_empresa_origem',
'        ,matricula_origem',
'        ,cod_escala',
'        ,cod_jornada',
'        ,situacao)',
'        values ',
'            (l_hist_id',
'            , :P179_COD_REQ',
'            , :P179_COD_EMPRESA',
'            , :P179_MATRICULA',
'            , :P179_COD_ESCALA',
'            , :P179_COD_JORNADA',
'            ,''DISPONIBILIZADA'');',
'    --',
'    UPDATE REQ_PE_ESCALAS_EXCECOES ',
'    SET COD_SIT_REQ = (SELECT COD_SIT_REQ FROM SIT_REQ WHERE DESC_SIT_REQ = ''DISPONIBILIZADA'')',
'        , DT_SIT_REQ = SYSDATE',
'    WHERE COD_REQ =  :P179_COD_REQ;   ',
'end;'))
,p_attribute_02=>'P179_COD_REQ, P179_COD_EMPRESA, P179_MATRICULA, P179_COD_ESCALA, P179_COD_JORNADA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144249250427684193732)
,p_event_id=>wwv_flow_api.id(144249250178349193729)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(144150854884835994420)
,p_name=>'Verifica Total de Centro de Custos'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_COD_ESCALA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144150855066394994421)
,p_event_id=>wwv_flow_api.id(144150854884835994420)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  cursor c_cc is',
'  SELECT cc.cod||''-''||cc.nome det',
'        ,cc.cod               ret',
'    FROM centro_de_custo cc',
'   WHERE cc.cod_empresa = :P179_COD_EMPRESA',
'     AND ((EXISTS(SELECT 1',
'                    FROM informacoes_funcionais f',
'                   WHERE f.cod_empresa = cc.cod_empresa',
'                     AND f.matricula   = :P179_MATRICULA',
'                     AND f.cod_ccusto  = cc.cod)) OR ',
'          (EXISTS(SELECT 1',
'                   FROM pe_ccusto_plantao_colab cp',
'                  WHERE cp.cod_empresa = cc.cod_empresa',
'                    AND cp.matricula   = :P179_MATRICULA',
'                    AND cp.cod_ccusto  = cc.cod))) ',
'     AND :P179_ESCALA_PLANTAO = ''S''             ',
'  ORDER BY 2;',
'  ',
'  r_cc c_cc%rowtype;',
'begin',
'   open c_cc;',
'   fetch c_cc into r_cc;',
'   :P179_TOTAL_CENTRO_CUSTO := c_cc%rowcount;',
'   close c_cc;',
'end; '))
,p_attribute_02=>'P179_COD_EMPRESA,P179_MATRICULA,P179_ESCALA_PLANTAO'
,p_attribute_03=>'P179_TOTAL_CENTRO_CUSTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(144150855172560994422)
,p_name=>unistr('Muda para Apenas um plant\00E3o')
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_TOTAL_CENTRO_CUSTO'
,p_condition_element=>'P179_TOTAL_CENTRO_CUSTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144150855239841994423)
,p_event_id=>wwv_flow_api.id(144150855172560994422)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144155709043314728977)
,p_event_id=>wwv_flow_api.id(144150855172560994422)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144150855364593994424)
,p_event_id=>wwv_flow_api.id(144150855172560994422)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144155708967841728976)
,p_event_id=>wwv_flow_api.id(144150855172560994422)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_CCUSTO_PLANTAO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144155709120235728978)
,p_event_id=>wwv_flow_api.id(144150855172560994422)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'SELECT cc.cod||''-''||cc.nome det',
'        , cc.cod cod',
'       into :P179_CCUSTO_PLANTAO_DSP, :P179_CCUSTO_PLANTAO',
'    FROM centro_de_custo cc',
'   WHERE cc.cod_empresa = :P179_COD_EMPRESA',
'     AND ((EXISTS(SELECT 1',
'                    FROM informacoes_funcionais f',
'                   WHERE f.cod_empresa = cc.cod_empresa',
'                     AND f.matricula   = :P179_MATRICULA',
'                     AND f.cod_ccusto  = cc.cod)) OR ',
'          (EXISTS(SELECT 1',
'                   FROM pe_ccusto_plantao_colab cp',
'                  WHERE cp.cod_empresa = cc.cod_empresa',
'                    AND cp.matricula   = :P179_MATRICULA',
'                    AND cp.cod_ccusto  = cc.cod))) ',
'   AND :P179_ESCALA_PLANTAO = ''S'';',
'end;     '))
,p_attribute_02=>'P179_COD_EMPRESA,P179_MATRICULA,P179_ESCALA_PLANTAO'
,p_attribute_03=>'P179_CCUSTO_PLANTAO_DSP,P179_CCUSTO_PLANTAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(120626511876250417572)
,p_name=>unistr('Mostra/Oculta Bot\00F5es')
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_MOSTRA_CRIAR'
,p_condition_element=>'P179_MOSTRA_CRIAR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120626511973637417573)
,p_event_id=>wwv_flow_api.id(120626511876250417572)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(176554826878732373586)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120626511983308417574)
,p_event_id=>wwv_flow_api.id(120626511876250417572)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(176554826878732373586)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120691959495065148845)
,p_event_id=>wwv_flow_api.id(120626511876250417572)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P179_EXCECAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(120626512121595417575)
,p_name=>unistr('Ao mudar revalida bot\00E3o criar Mudou empresa')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_COD_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120626512208407417576)
,p_event_id=>wwv_flow_api.id(120626512121595417575)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P179_MOSTRA_CRIAR := FNC_GESTOR_ALTERA_EXCECAO_NAO(p_cod_empresa => :P179_COD_EMPRESA,',
'                                                       p_excecao => :P179_EXCECAO,',
'                                                       p_painel => :p_painel);',
'end;'))
,p_attribute_02=>'P179_COD_EMPRESA,P179_EXCECAO'
,p_attribute_03=>'P179_MOSTRA_CRIAR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(120626512338736417577)
,p_name=>unistr('Ao mudar revalida bot\00E3o criar Mudou exce\00E7\00E3o')
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P179_EXCECAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120691957838856148828)
,p_event_id=>wwv_flow_api.id(120626512338736417577)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P179_MOSTRA_CRIAR := FNC_GESTOR_ALTERA_EXCECAO_NAO(p_cod_empresa => :P179_COD_EMPRESA,',
'                                                       p_excecao => :P179_EXCECAO,',
'                                                       p_painel => :p_painel);',
'end;'))
,p_attribute_02=>'P179_COD_EMPRESA,P179_EXCECAO'
,p_attribute_03=>'P179_MOSTRA_CRIAR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554830790624373667)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from REQ_PE_ESCALAS_EXCECOES'
,p_attribute_02=>'REQ_PE_ESCALAS_EXCECOES'
,p_attribute_03=>'P179_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P179_COD_REQ'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(120691959406228148844)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Setar valor plant\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P179_ESCALA_PLANTAO is null then',
'    :P179_ESCALA_PLANTAO := ''N'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(120626511642696417570)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida Gestor Cria com Excecao igual a N'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P179_MOSTRA_CRIAR := FNC_GESTOR_ALTERA_EXCECAO_NAO(p_cod_empresa => :P_EMPRESA_USER,',
'                                                       p_excecao => :P179_EXCECAO,',
'                                                       p_painel => :p_painel);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554830391431373666)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT/UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P179_ROWID IS NULL THEN',
'',
':P179_COD_REQ := seq_requisicao.NEXTVAL;',
':p179_cod_emp_solicitante := :P_EMPRESA_USER;',
':p179_mat_solicitante := :P_MATRICULA_USER;',
':P179_DT_REQ := SYSDATE;',
':P179_COD_SIT_REQ := 1;',
':P179_DT_SIT_REQ := SYSDATE;',
'',
'END IF;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554831173859373667)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQ_PE_ESCALAS_EXCECOES'
,p_attribute_02=>'REQ_PE_ESCALAS_EXCECOES'
,p_attribute_03=>'P179_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Action Processed.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554832354923373668)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_ESCALA.Post_Insert(:P179_cod_empresa          ,',
'                         :P179_cod_req      ,',
'                         V_flg_retorno             ,',
'                         V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    --:p179_ok       := ''N'';',
'    --:p179_flag     := v_flg_retorno;',
'    --:p179_mensagem := v_msg_retorno;',
'    :P179_ERR_MSG := v_msg_retorno;',
' else',
'    --:p179_flag     := null;',
'    --:p179_mensagem := null;',
'    --:p179_ok       := ''S'';',
'    :P179_ERR_MSG := null;',
' end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(176554826878732373586)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554832765781373668)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_ESCALA.Post_Update(:P179_cod_empresa,',
'                         :P179_cod_req,',
'                         V_flg_retorno,',
'                         V_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    --:p179_ok       := ''N'';',
'    --:p179_flag     := v_flg_retorno;',
'    --:p179_mensagem := v_msg_retorno;',
'    :P179_ERR_MSG := v_msg_retorno;',
' else',
'    --:p179_flag     := null;',
'    --:p179_mensagem := null;',
'    --:p179_ok       := ''S'';',
'    :P179_ERR_MSG := null;',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(176554827256416373586)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554831603105373667)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(176554826491548373571)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(176554832043357373668)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
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
