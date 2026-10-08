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
,p_default_application_id=>2060
,p_default_id_offset=>115876803710578836
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2060 - Requisição de Reembolso - Natcorp
--
-- Application Export:
--   Application:     2060
--   Name:            Requisição de Reembolso - Natcorp
--   Date and Time:   22:38 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 11
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00011
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_api.create_page(
 p_id=>11
,p_user_interface_id=>wwv_flow_api.id(19041533386153604874)
,p_name=>unistr('Criar/Editar: Lan\00E7amentos Diversos')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Criar/Editar: Lan\00E7amentos Diversos')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P3_VALOR_DSP {',
'  color: #08a908 !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ANDRE.BONI'
,p_last_upd_yyyymmddhh24miss=>'20250916151052'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(58515027432457119028)
,p_plug_name=>unistr('BOT\00D5ES')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19041499394993604767)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(60935886123133286919)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2126730609984869637)
,p_plug_name=>unistr('Dados da Requisi\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(58515027811510119032)
,p_plug_name=>'MENU'
,p_parent_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3135044592811996465)
,p_plug_name=>'Anexos'
,p_parent_plug_id=>wwv_flow_api.id(58515027811510119032)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(60935894934317286930)
,p_plug_name=>unistr('Lan\00E7amentos')
,p_parent_plug_id=>wwv_flow_api.id(58515027811510119032)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(60935897344364286932)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(58515027811510119032)
,p_template=>wwv_flow_api.id(19041507389315604780)
,p_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.cod_mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.cod_mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.cod_mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_REEMBOLSO a, usuario_oracle u',
' where a.cod_req = :P11_COD_REQ --:p714_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.cod_mat_aprov = u.cd_matricula',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.cod_mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_REEMBOLSO a, usuario_oracle u',
' where a.cod_req = :P11_COD_REQ --:p714_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.cod_mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'      and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.cod_mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from APROVA_reembolso',
' where cod_req = :p11_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P11_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(19041516200869604796)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Aprovador Encontrado.'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068561065391004701)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=PO_&P_BASE.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068561488207004702)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068561883297004702)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068562229834004702)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_inline_lov=>'STATIC:Pendente;P,Aprovado;A,Reprovado;R'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068562638137004702)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068563106416004702)
,p_query_column_id=>6
,p_column_alias=>'COD_MAT_APROV'
,p_column_display_sequence=>8
,p_column_heading=>'Cod Mat Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068563476106004702)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>6
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(2068563917182004702)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>7
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2068547551621004694)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(58515027432457119028)
,p_button_name=>'p11_btn_cancelar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(19041528180913604824)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2068564287319004702)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(60935897344364286932)
,p_button_name=>'p11_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P11_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_HE.Valida_Sequencia(:p11_cod_empresa, :p11_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
' ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2068547948784004695)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(58515027432457119028)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(19041528180913604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p11_rowid is not null and :p11_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2068548403014004695)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(58515027432457119028)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(19041528180913604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P11_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2068564665744004703)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(60935897344364286932)
,p_button_name=>'p11_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P11_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_HE.Valida_Sequencia(:p11_cod_empresa, :p11_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
' ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2068589937050004710)
,p_branch_name=>'Voltar'
,p_branch_action=>'f?p=&APP_ID.:138:&SESSION.::&DEBUG.:RP,138:P138_EMP,P138_MAT:&P716_EMP.,&P716_MAT.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139941234773901346)
,p_name=>'P11_USA_METRAGEM'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139941307947901347)
,p_name=>'P11_METRAGEM'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Metragem  (Mts)'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_display_when=>'P11_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139941925727901353)
,p_name=>'P11_METRAGEM_MINIMA'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139942005084901354)
,p_name=>'P11_METRAGEM_MAXIMA'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139942332193901357)
,p_name=>'P11_METRAGEM_DSP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Metragem  (Mts)'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>3
,p_display_when=>'P11_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139942434365901358)
,p_name=>'P11_VALOR_APRESENTADO_DSP'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Valor Apresentado (R$)'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>3
,p_display_when=>'P11_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139942586855901359)
,p_name=>'P11_VALOR_RS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Valor Rs (1)'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139942895484901362)
,p_name=>'P11_VALOR_APRESENTADO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Valor Apresentado'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_display_when=>'P11_COD_REQ'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139944314752901377)
,p_name=>'P11_VALOR_METRAGEM'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139944643832901380)
,p_name=>'P11_VALOR_METRO_DSP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Valor/Metro (R$)'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068443432215161916)
,p_name=>'P11_TEM_ANEXO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068444010800161921)
,p_name=>'P11_COD_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Processo'
,p_source=>'COD_PROCESSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rpp.cod_processo||'' - ''||rp.desc_processo, rpp.cod_processo  ',
'from reembolso_perfis_processos rpp, reembolso_processos rp',
'where cod_empresa = :P11_EMP',
'and cod_perfil = :P_PERFIL',
'and rp.cod = rpp.cod_processo',
'order by rpp.cod_processo  '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P11_EMP'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527922574604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068444036372161922)
,p_name=>'P11_COD_ELEGIBILIDADE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ELEGIBILIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068444637690161928)
,p_name=>'P11_VALIDA_PAINEL'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068445088233161932)
,p_name=>'P11_COD_EMPRESA_DSP'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068445186211161933)
,p_name=>'P11_MATRICULA_DSP'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068549025759004697)
,p_name=>'P11_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068549444103004697)
,p_name=>'P11_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068549907861004697)
,p_name=>'P11_MENSAGEM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068550304495004697)
,p_name=>'P11_OK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068550662755004698)
,p_name=>'P11_ITEM_VALIDACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068551062945004698)
,p_name=>'P11_COD_REQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2126730609984869637)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068551514250004698)
,p_name=>'P11_DT_REQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2126730609984869637)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068551883455004698)
,p_name=>'P11_COD_SIT_REQ'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2126730609984869637)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068552300321004698)
,p_name=>'P11_DT_SIT_REQ'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2126730609984869637)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068552631602004698)
,p_name=>'P11_SOLICITANTE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(2126730609984869637)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cargo ',
'  from informacoes_funcionais',
' where cod_empresa = :p11_cod_emp_req',
'   and matricula = :p11_mat_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'return :p11_cod_emp_req||'' - ''||initcap(fnct_nome_empresa(:p11_cod_emp_req))||'' / ''||:p11_mat_req||'' - ''||initcap(fnct_nome_func(:p11_cod_emp_req,:p11_mat_req));',
'',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068553029648004698)
,p_name=>'P11_EMP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068553464684004698)
,p_name=>'P11_MAT'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068553845437004699)
,p_name=>'P11_COD_EMP_SOLICITANTE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068554310867004699)
,p_name=>'P11_COD_MAT_SOLICITANTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068554624993004699)
,p_name=>'P11_COD_EMPRESA'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from empresas_cad',
' where (((COD IN (SELECT X.COD_EMPRESA',
'                           FROM CENTRO_DE_CUSTO X',
'                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                         FROM USUARIO_ORACLE U  ',
'                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO))) and :p_painel = ''PG'') or ',
'        (f_acesso_emp_pg_apex(cod, :p_usuario, :p_painel) = ''S'' and :p_painel = ''PO'') or ',
'       (cod = :P_EMPRESA_USER and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068555072258004699)
,p_name=>'P11_MATRICULA'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) descricao, matricula cod',
'  from informacoes_funcionais_cad i',
' where cod_empresa = :p11_cod_empresa',
'   and i.situacao < ''90''',
'   and i.marca_ponto = ''S''',
'    AND ((f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel, ''PONTO'') = ''S'' and :p_painel in (''PO'',''PG'')) or ',
'         (i.cod_empresa = :P_EMPRESA_USER',
'         and i.matricula = :P_MATRICULA_USER',
'         and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P11_COD_EMPRESA'
,p_ajax_items_to_submit=>'P11_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068555480551004699)
,p_name=>'P11_USUARIO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068555898965004699)
,p_name=>'P11_DT_ATUALIZACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(60935886123133286919)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068556846314004700)
,p_name=>'P11_ARQ_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(3135044592811996465)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Arquivo 1'
,p_source=>'ARQ_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ARQ_1_MIMETYPE'
,p_attribute_03=>'ARQ_1_NOME'
,p_attribute_04=>'ARQ_1_CHARSET'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068557251241004700)
,p_name=>'P11_ARQ_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(3135044592811996465)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Arquivo 2'
,p_source=>'ARQ_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p11_rowid is not null and :p11_Arq_2 is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ARQ_2_MIMETYPE'
,p_attribute_03=>'ARQ_2_NOME'
,p_attribute_04=>'ARQ_2_CHARSET'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068557947618004700)
,p_name=>'P11_DATA'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data da Nota'
,p_source=>'DATA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527922574604818)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068558339437004700)
,p_name=>'P11_TIPO'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Reembolso'
,p_source=>'TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_FAMILIA||'' - ''||DESCRICAO_FAMILIA, COD_FAMILIA',
'FROM BENEFICIOS_FAMILIA',
'WHERE PGT_DIVERSOS = ''S''',
'AND COD_EMPRESA = :P11_EMP',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P11_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527922574604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068558733890004700)
,p_name=>'P11_MOTIVO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo de Reembolso'
,p_source=>'MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descricao) d, cod c',
'  from motivo_alteracoes',
' where ind_reembolso = ''S''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527922574604818)
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
 p_id=>wwv_flow_api.id(2068559605603004701)
,p_name=>'P11_VALOR_DSP'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Valor Efetivo (R$)'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068559994327004701)
,p_name=>'P11_VALOR'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068560356688004701)
,p_name=>'P11_OBS'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Coment\00E1rio')
,p_source=>'OBS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>2
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115936378702856949)
,p_name=>'P11_VALOR_MINIMO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963007109616936)
,p_name=>'P11_VALOR_MAXIMO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963166767616938)
,p_name=>'P11_DATA_VIGENCIA'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963319567616939)
,p_name=>'P11_DATA_VIGENCIA_EFETIVACAO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963382204616940)
,p_name=>'P11_DATA_VALIDADE_INICIAL'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963453928616941)
,p_name=>'P11_DATA_VALIDADE_FINAL'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963578145616942)
,p_name=>'P11_DIA_LIMITE_LANCTO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963699283616943)
,p_name=>'P11_QTD_PARCELAS'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124963769408616944)
,p_name=>'P11_COD_EVENTO'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Evento'
,p_source=>'COD_EVENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_evento||'' - ''||op.nome, rpe.cod_evento',
'from reembolso_perfis_eventos rpe, ocorr_pagto op',
'where rpe.cod = :P11_COD_ELEGIBILIDADE',
'and rpe.cod_empresa = :P11_EMP',
'and rpe.cod_evento = op.cod',
'and rpe.cod_empresa = op.cod_empresa',
'and rownum = 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P11_EMP,P11_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527922574604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124964330724616950)
,p_name=>'P11_QTD_HORAS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Qtd Horas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124964451208616951)
,p_name=>'P11_QTD_MINUTOS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Qtd Minutos'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2124964535501616952)
,p_name=>'P11_QTD_DIAS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_prompt=>'Qtd Dias'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_read_only_when=>'P11_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2126728146150869613)
,p_name=>'P11_POR_VALOR'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2126728278479869614)
,p_name=>'P11_POR_UNIDADES'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2126728391600869615)
,p_name=>'P11_POR_DIA'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(60935894934317286930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2068565173382004704)
,p_validation_name=>'Valida_Cod_Sit_Req'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_req',
'  from REQ_REEMBOLSO',
' where cod_req = :p11_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_req is not null then',
'',
' pkg_req_reembolso.Valida_Sit_Req(:p11_cod_empresa, :p11_cod_req, :p11_matricula, :p11_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'end if;',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'  return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(2068551883455004698)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2127299552573579211)
,p_validation_name=>'New'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P11_TEM_ANEXO = ''S'' and :P11_ARQ_1 is null then',
'    return ''Tipo de Processo e evento exige anexo como comprovante'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068569109607004706)
,p_name=>'Hide Fields'
,p_event_sequence=>35
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068569531120004706)
,p_event_id=>wwv_flow_api.id(2068569109607004706)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_REQ,P11_DT_REQ,P11_COD_SIT_REQ,P11_DT_SIT_REQ,P11_COD_EMP_SOLICITANTE,P11_COD_MAT_SOLICITANTE,P11_SOLICITANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068570012961004706)
,p_name=>'Hide Fields_1'
,p_event_sequence=>45
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068570500534004706)
,p_event_id=>wwv_flow_api.id(2068570012961004706)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_EMP_SOLICITANTE,P11_COD_MAT_SOLICITANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068570908072004706)
,p_name=>'Enable Fields (Create)'
,p_event_sequence=>105
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2068548403014004695)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068571360617004706)
,p_event_id=>wwv_flow_api.id(2068570908072004706)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$x(''P11_HORA_BATIDA'').disabled = false;',
'//$x(''P11_DATA_PONTO'').disabled = false;',
'$x(''P11_COD_REQ'').disabled = false;',
'$x(''P11_DT_REQ'').disabled = false;',
'$x(''P11_COD_SIT_REQ'').disabled = false;',
'$x(''P11_DT_SIT_REQ'').disabled = false;',
'$x(''P11_COD_EMP_REQ'').disabled = false;',
'$x(''P11_MAT_REQ'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068571859704004707)
,p_event_id=>wwv_flow_api.id(2068570908072004706)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068572254972004707)
,p_name=>'Enable Fields (Save)'
,p_event_sequence=>115
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2111803080151926701)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068572757508004707)
,p_event_id=>wwv_flow_api.id(2068572254972004707)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_HORA_INICIAL,P11_HORA_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068573230524004707)
,p_event_id=>wwv_flow_api.id(2068572254972004707)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068573659552004707)
,p_name=>'Dispara Alerta'
,p_event_sequence=>205
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_MENSAGEM'
,p_condition_element=>'P11_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068574172330004707)
,p_event_id=>wwv_flow_api.id(2068573659552004707)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P11_FLAG'').value == "Q") {',
'alertify.confirm($v(''P11_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P11_FLAG'').value = ''S'';',
'        $x(''P11_MENSAGEM'').value = '''';',
'        $x(''P11_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P11_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P11_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P11_FLAG'').value == "N") {',
'            $x(''P11_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P11_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P11_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P11_MENSAGEM''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P11_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P11_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P11_ITEM_VALIDACAO'').value == ''P11_CREATE''){',
'            $x(''P11_OK'').value = ''S'';',
'        $x(''P11_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068574594769004707)
,p_name=>'OK: Show Create'
,p_event_sequence=>215
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_ITEM_VALIDACAO'
,p_condition_element=>'P11_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068575055546004707)
,p_event_id=>wwv_flow_api.id(2068574594769004707)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068575573556004707)
,p_event_id=>wwv_flow_api.id(2068574594769004707)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068576101772004707)
,p_event_id=>wwv_flow_api.id(2068574594769004707)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068576550210004707)
,p_event_id=>wwv_flow_api.id(2068574594769004707)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068576993944004707)
,p_name=>'Ativa Alertify'
,p_event_sequence=>225
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068577452117004708)
,p_event_id=>wwv_flow_api.id(2068576993944004707)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Teste'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068577868711004708)
,p_name=>'Valida Sit Req'
,p_event_sequence=>245
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068578420310004708)
,p_event_id=>wwv_flow_api.id(2068577868711004708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_req',
'  from PE_REQ_HORA_EXTRA',
' where cod_req = :p11_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_req is not null then',
'',
' pkg_req_he.Valida_Sit_Req(:p11_cod_empresa, :p11_cod_req, :p11_matricula, :p11_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'NULL;',
'',
'end if;',
'',
' if v_msg_retorno is not null then',
'    :p11_ok       := ''N'';',
'    :p11_flag     := v_flg_retorno;',
'    :p11_mensagem := v_msg_retorno;',
' else',
'    :p11_flag     := null;',
'    :p11_mensagem := null;',
'    :p11_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P11_COD_EMPRESA,P11_COD_REQ,P11_COD_SIT_REQ,P_USUARIO,P11_MATRICULA'
,p_attribute_03=>'P11_FLAG,P11_MENSAGEM,P11_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068578724462004708)
,p_name=>'Valida_Data'
,p_event_sequence=>255
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_DATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068579229054004708)
,p_event_id=>wwv_flow_api.id(2068578724462004708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P11_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p11_mensagem := null;',
' ',
'  pkg_req_he.Valida_Data(:p11_cod_empresa',
'                                 ,:p11_matricula',
'                                 ,:p11_data_ponto',
'                                 ,v_flg_retorno',
'                                 ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P11_ITEM_VALIDACAO := TRIM(UPPER(''p11_data_ponto''));',
'    :p11_ok       := ''N'';',
'    :p11_flag     := v_flg_retorno;',
'    :p11_mensagem := v_msg_retorno;',
' else',
'    :p11_flag     := null;',
'    :p11_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p11_data_ponto'')) OR v_item_validacao IS NULL then',
'       :P11_OK := ''S'';',
'       :P11_ITEM_VALIDACAO := null;',
'    else',
'       :P11_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P11_ITEM_VALIDACAO,P11_COD_EMPRESA,P11_MATRICULA,P11_DATA'
,p_attribute_03=>'P11_ITEM_VALIDACAO,P11_MENSAGEM,P11_OK,P11_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068579693444004708)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>265
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_SIT_REQ'
,p_condition_element=>'P11_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068580166256004708)
,p_event_id=>wwv_flow_api.id(2068579693444004708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068580710089004708)
,p_event_id=>wwv_flow_api.id(2068579693444004708)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068581205628004708)
,p_event_id=>wwv_flow_api.id(2068579693444004708)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068581699414004708)
,p_event_id=>wwv_flow_api.id(2068579693444004708)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068583502226004709)
,p_name=>'Close Dialog'
,p_event_sequence=>285
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2111802716794926700)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068584020432004709)
,p_event_id=>wwv_flow_api.id(2068583502226004709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068584390435004709)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>295
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2068564665744004703)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068584856909004709)
,p_event_id=>wwv_flow_api.id(2068584390435004709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068585235681004709)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>305
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2068564287319004702)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068585752854004709)
,p_event_id=>wwv_flow_api.id(2068585235681004709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068586140749004709)
,p_name=>'Show/Hide ARQ_2'
,p_event_sequence=>315
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_ARQ_1'
,p_condition_element=>'P11_ARQ_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068586701420004709)
,p_event_id=>wwv_flow_api.id(2068586140749004709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_ARQ_2'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068587196116004710)
,p_event_id=>wwv_flow_api.id(2068586140749004709)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_ARQ_2'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068442904100161910)
,p_name=>'Verifica elegibilidade'
,p_event_sequence=>345
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_MATRICULA'
,p_condition_element=>'P11_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068442957917161911)
,p_event_id=>wwv_flow_api.id(2068442904100161910)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_processo         number;',
'    v_elegibilidade    number;',
'    v_flag             varchar2(1);',
'    v_mensagem         varchar2(4000);',
'begin',
'    begin',
'        select cod',
'           into v_processo',
'        from REEMBOLSO_PROCESSOS',
'        where upper(desc_processo) = upper(''Pagamentos Diversos'');',
'    end;',
'    --',
'    prc_valida_elegibilidade_reembolso( p_mat         => :P11_MATRICULA',
'                                    , p_emp           => :P11_COD_EMPRESA',
'                                    , p_perfil        => :P_PERFIL',
'                                    , p_cod_processo  => v_processo',
'                                    , p_seq_id        => null',
'                                    , p_elegibilidade => v_elegibilidade',
'                                    , p_retorno       => v_flag',
'                                    , p_mensagem      => v_mensagem);',
'    if v_mensagem is not null then',
'        :P11_MENSAGEM := v_mensagem;',
'    end if;',
'    :P11_COD_PROCESSO := v_processo;',
'    :P11_COD_ELEGIBILIDADE := v_elegibilidade;',
'end;                                        '))
,p_attribute_02=>'P11_COD_EMPRESA,P11_MATRICULA'
,p_attribute_03=>'P11_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068443619728161917)
,p_name=>'Mostra/Oculta Anexos'
,p_event_sequence=>355
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_TEM_ANEXO'
,p_condition_element=>'P11_TEM_ANEXO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068443632265161918)
,p_event_id=>wwv_flow_api.id(2068443619728161917)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(3135044592811996465)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068443764358161919)
,p_event_id=>wwv_flow_api.id(2068443619728161917)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(3135044592811996465)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068445296287161934)
,p_name=>'Fechar janela'
,p_event_sequence=>365
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2068547551621004694)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068445351774161935)
,p_event_id=>wwv_flow_api.id(2068445296287161934)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2068446149802161943)
,p_name=>'Valida Painel'
,p_event_sequence=>375
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_VALIDA_PAINEL'
,p_condition_element=>'P11_VALIDA_PAINEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'PC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068446265666161944)
,p_event_id=>wwv_flow_api.id(2068446149802161943)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_EMPRESA_DSP,P11_MATRICULA_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068446614266161947)
,p_event_id=>wwv_flow_api.id(2068446149802161943)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_EMPRESA,P11_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068446323619161945)
,p_event_id=>wwv_flow_api.id(2068446149802161943)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_EMPRESA_DSP,P11_MATRICULA_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2068446449679161946)
,p_event_id=>wwv_flow_api.id(2068446149802161943)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_COD_EMPRESA,P11_MATRICULA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2115936146474856947)
,p_name=>'Colaborador na Elegibilidade'
,p_event_sequence=>385
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2115936225746856948)
,p_event_id=>wwv_flow_api.id(2115936146474856947)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2124964205055616948)
,p_name=>'Recupera dados do processo'
,p_event_sequence=>405
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_PROCESSO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2124964305461616949)
,p_event_id=>wwv_flow_api.id(2124964205055616948)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    begin',
'        select rpp.cod elegibilidade, tem_anexo, USA_METRAGEM',
'            into :P11_COD_ELEGIBILIDADE, :P11_TEM_ANEXO, :P11_USA_METRAGEM ',
'        from reembolso_perfis_processos rpp, reembolso_processos rp',
'        where rp.cod = rpp.cod_processo',
'        and cod_empresa = :P11_EMP',
'        and cod_perfil = :P_PERFIL',
'        and cod_processo =  :P11_COD_PROCESSO;',
'    exception',
'        when others then    ',
'            null;',
'    end; ',
'    --',
'    DELETE FROM TESTEX WHERE TEXTO LIKE ''ANDRE%'';',
'    INSERT INTO TESTEX VALUES (-1, ''ANDRE P11_EMP = ''||:P11_EMP);',
'    INSERT INTO TESTEX VALUES (-2, ''ANDRE P_PERFIL = ''||:P_PERFIL);',
'    INSERT INTO TESTEX VALUES (-3, ''ANDRE P11_COD_PROCESSO = ''||:P11_COD_PROCESSO);',
'    INSERT INTO TESTEX VALUES (-4, ''ANDRE P11_COD_ELEGIBILIDADE = ''||:P11_COD_ELEGIBILIDADE);',
'COMMIT;',
'',
'    begin',
'        SELECT valor_minimo, valor_maximo, METROS_MINIMOS, METROS_MAXIMOS ',
'        into :P11_VALOR_MINIMO, :P11_VALOR_MAXIMO, :P11_METRAGEM_MINIMA, :P11_METRAGEM_MAXIMA',
'         FROM REEMBOLSO_PERFIS_EVENTOS',
'               where cod =  :P11_COD_ELEGIBILIDADE',
'        and rownum = 1;',
'    end;    ',
'    --',
'    INSERT INTO TESTEX VALUES (-5, ''ANDRE P11_METRAGEM_MINIMA = ''||:P11_METRAGEM_MINIMA);',
'    INSERT INTO TESTEX VALUES (-6, ''ANDRE P11_METRAGEM_MAXIMA = ''||:P11_METRAGEM_MAXIMA);',
'COMMIT;',
'    begin',
'        PKG_LIST_REEMBOLSO.recupera_datas(  p_cod_empresa       => :P11_EMP',
'                                          , p_cod_processo      => :P11_COD_PROCESSO',
'                                          , p_data_validade_ini => :P11_DATA_VALIDADE_INICIAL',
'                                          , p_data_validade_fim => :P11_DATA_VALIDADE_FINAL',
'                                          , p_data_ref          => :P11_DATA_VIGENCIA',
'                                          , p_data_efetivacao   => :P11_DATA_VIGENCIA_EFETIVACAO',
'                                          , p_dia_limite        => :P11_DIA_LIMITE_LANCTO',
'                                          , p_parcelas          => :P11_QTD_PARCELAS',
'                                          );',
'    end;',
'end;'))
,p_attribute_02=>'P11_EMP,P11_COD_PROCESSO'
,p_attribute_03=>'P11_DATA_VALIDADE_INICIAL,P11_DATA_VALIDADE_FINAL,P11_DATA_VIGENCIA,P11_DATA_VIGENCIA_EFETIVACAO,P11_DIA_LIMITE_LANCTO,P11_QTD_PARCELAS,P11_COD_ELEGIBILIDADE,P11_TEM_ANEXO,P11_METRAGEM_MINIMA,P11_METRAGEM_MAXIMA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126727516023869606)
,p_name=>'Recupera valores'
,p_event_sequence=>415
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_EVENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126727533423869607)
,p_event_id=>wwv_flow_api.id(2126727516023869606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    SELECT valor_minimo, valor_maximo',
'    into :P11_VALOR_MINIMO, :P11_VALOR_MAXIMO',
'     FROM REEMBOLSO_PERFIS_EVENTOS',
'           where cod = :P11_COD_ELEGIBILIDADE',
'    and rownum = 1;',
'exception',
'    when others then',
'        :P11_VALOR_MINIMO    := null;',
'        :P11_VALOR_MAXIMO    := null;',
'end;',
''))
,p_attribute_02=>'P11_COD_ELEGIBILIDADE'
,p_attribute_03=>'P11_VALOR_MINIMO,P11_VALOR_MAXIMO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126728016703869611)
,p_name=>'Recupera tipo de unidade'
,p_event_sequence=>425
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_EVENTO'
,p_condition_element=>'P11_COD_EVENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126728090352869612)
,p_event_id=>wwv_flow_api.id(2126728016703869611)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_op is ',
'    select unid1, unid2',
'    from ocorr_pagto',
'    where cod_empresa = :P11_EMP',
'       and cod = :P11_COD_EVENTO;',
'       ',
'    r_op c_op%rowtype;   ',
'begin',
'    :P11_QTD_HORAS := NULL;',
'    :P11_QTD_MINUTOS:= NULL;',
'    :P11_QTD_DIAS:= NULL;',
'    :P11_VALOR := NULL;',
'',
'    :P11_POR_VALOR        := NULL;',
'    :P11_POR_UNIDADES     := NULL;',
'    :P11_POR_DIA          := NULL;',
'    ',
'    open c_op;',
'    fetch c_op into r_op; ',
'    close c_op;',
'    -- mostar valor',
'    if  r_op.unid1 = ''QTDE'' and r_op.unid2 is null then',
'        :P11_POR_VALOR := ''S'';',
'        :P11_POR_UNIDADES     := NULL;',
'        :P11_POR_DIA          := NULL;',
'    -- mostrar unidades',
'    elsif  r_op.unid1 = ''HORA'' and r_op.unid2 = ''MIN'' then',
'        :P11_POR_VALOR        := NULL;',
'        :P11_POR_UNIDADES     := ''S'';',
'        :P11_POR_DIA          := NULL;',
'    -- mostrar dias',
'    elsif  r_op.unid1 = ''QTDE'' and r_op.unid2 = ''DIA'' then',
'        :P11_POR_VALOR        := NULL;',
'        :P11_POR_UNIDADES     := NULL;',
'        :P11_POR_DIA          := ''S'';',
'    else',
'        :P11_POR_VALOR := ''S'';',
'        :P11_POR_UNIDADES     := NULL;',
'        :P11_POR_DIA          := NULL;    ',
'    end if;',
'end;'))
,p_attribute_02=>'P11_EMP,P11_COD_EVENTO'
,p_attribute_03=>'P11_POR_VALOR,P11_POR_UNIDADES,P11_POR_DIA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126728433217869616)
,p_name=>'Mostra valor'
,p_event_sequence=>435
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_POR_VALOR'
,p_condition_element=>'P11_POR_VALOR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126728534852869617)
,p_event_id=>wwv_flow_api.id(2126728433217869616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126728674263869618)
,p_name=>'Mostra unidades'
,p_event_sequence=>445
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_POR_UNIDADES'
,p_condition_element=>'P11_POR_UNIDADES'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126728729935869619)
,p_event_id=>wwv_flow_api.id(2126728674263869618)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126728877467869620)
,p_name=>'Oculta campos unidades'
,p_event_sequence=>455
,p_condition_element=>'P11_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126728968302869621)
,p_event_id=>wwv_flow_api.id(2126728877467869620)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS,P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126729093210869622)
,p_name=>'Mostra dia'
,p_event_sequence=>465
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_POR_DIA'
,p_condition_element=>'P11_POR_DIA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126729132506869623)
,p_event_id=>wwv_flow_api.id(2126729093210869622)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126729313540869624)
,p_name=>'Checagem de valor'
,p_event_sequence=>475
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_VALOR_APRESENTADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139942748695901361)
,p_event_id=>wwv_flow_api.id(2126729313540869624)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_valor_apresentado number;',
'    v_valor_maximo      number;',
'    v_valor_minimo      number;',
'    v_valor_novo        number;',
'    v_mensagem varchar2(1) := ''N'';',
'begin',
'    :P11_MENSAGEM    := null;',
'    :P11_VALOR_DSP   := null;',
'    v_valor_apresentado := :P11_VALOR_APRESENTADO; -- to_number(replace(:P11_VALOR_APRESENTADO, '','', ''.''));',
'    v_valor_maximo := to_number(replace(:P11_VALOR_MAXIMO, '','', ''.''));',
'    v_valor_minimo := to_number(replace(:P11_VALOR_MINIMO, '','', ''.''));  ',
'',
'DELETE FROM TESTEX WHERE TEXTO LIKE ''ANDRE%'';',
'INSERT INTO TESTEX VALUES (-1,''ANDRE :P11_VALOR_APRESENTADO = ''||:P11_VALOR_APRESENTADO);',
'INSERT INTO TESTEX VALUES (-2,''ANDRE v_valor_minimo = ''||v_valor_minimo);',
'INSERT INTO TESTEX VALUES (-3,''ANDRE v_valor_maximo = ''||v_valor_maximo);',
'COMMIT;',
'    if v_valor_apresentado < v_valor_minimo or  v_valor_apresentado > v_valor_maximo then',
'        :P11_MENSAGEM := ''Valor Apresentado deve estar entre ''||:P11_VALOR_MINIMO||'' e ''||:P11_VALOR_MAXIMO;',
'    end if;',
'    if v_valor_apresentado < v_valor_minimo then',
'        v_valor_novo := v_valor_apresentado;',
'        :P11_VALOR_DSP := v_valor_apresentado;',
'    elsif v_valor_apresentado > v_valor_maximo then    ',
'        v_valor_novo := v_valor_maximo;',
'        :P11_VALOR_DSP := v_valor_maximo;',
'    else',
'        v_valor_novo := v_valor_apresentado;',
'        :P11_VALOR_DSP := v_valor_apresentado;     ',
'    end if;',
'    :P11_VALOR_DSP := to_char(:P11_VALOR_DSP,''FML999G999G999G999G990D00'');',
'    :P11_VALOR := v_valor_novo;',
'',
'    INSERT INTO TESTEX VALUES (-7,''ANDRE v_valor_novo = ''||v_valor_novo);',
'INSERT INTO TESTEX VALUES (-3,''ANDRE fim'');',
'COMMIT;',
'',
'end;'))
,p_attribute_02=>'P11_VALOR_APRESENTADO,P11_VALOR_MINIMO,P11_VALOR_MAXIMO'
,p_attribute_03=>'P11_VALOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126729602687869627)
,p_name=>'Mostra campos unidades valor'
,p_event_sequence=>485
,p_condition_element=>'P11_POR_VALOR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126729688338869628)
,p_event_id=>wwv_flow_api.id(2126729602687869627)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_APRESENTADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730171665869633)
,p_event_id=>wwv_flow_api.id(2126729602687869627)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS,P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126729822408869629)
,p_name=>'Mostra campos unidades qtd dias'
,p_event_sequence=>495
,p_condition_element=>'P11_POR_DIA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730267464869634)
,p_event_id=>wwv_flow_api.id(2126729822408869629)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730428177869636)
,p_event_id=>wwv_flow_api.id(2126729822408869629)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'alert(''OK'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126729907255869630)
,p_event_id=>wwv_flow_api.id(2126729822408869629)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126729940823869631)
,p_name=>'Mostra campos unidades qtd horas minutos'
,p_event_sequence=>505
,p_condition_element=>'P11_POR_UNIDADES'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730098675869632)
,p_event_id=>wwv_flow_api.id(2126729940823869631)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730382058869635)
,p_event_id=>wwv_flow_api.id(2126729940823869631)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126730717571869638)
,p_name=>unistr('Mostra oculta dados da requisi\00E7\00E3o')
,p_event_sequence=>515
,p_condition_element=>'P11_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730739136869639)
,p_event_id=>wwv_flow_api.id(2126730717571869638)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2126730609984869637)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126730859690869640)
,p_event_id=>wwv_flow_api.id(2126730717571869638)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2126730609984869637)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126732054996869652)
,p_name=>unistr('Oculta Valor da Requisi\00E7\00E3o')
,p_event_sequence=>525
,p_condition_element=>'P11_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126732187751869653)
,p_event_id=>wwv_flow_api.id(2126732054996869652)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126732317725869654)
,p_event_id=>wwv_flow_api.id(2126732054996869652)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126732356219869655)
,p_name=>'Mostra valores'
,p_event_sequence=>535
,p_condition_element=>'P11_POR_VALOR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127299067775579206)
,p_event_id=>wwv_flow_api.id(2126732356219869655)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127300395052579219)
,p_event_id=>wwv_flow_api.id(2126732356219869655)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_VALOR_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2127299192204579207)
,p_name=>'Mostra por dia'
,p_event_sequence=>545
,p_condition_element=>'P11_POR_DIA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127299222853579208)
,p_event_id=>wwv_flow_api.id(2127299192204579207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127300456962579220)
,p_event_id=>wwv_flow_api.id(2127299192204579207)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_DIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2127299327551579209)
,p_name=>'Mostra por unidade'
,p_event_sequence=>555
,p_condition_element=>'P11_POR_UNIDADES'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127299432967579210)
,p_event_id=>wwv_flow_api.id(2127299327551579209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127300529074579221)
,p_event_id=>wwv_flow_api.id(2127299327551579209)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_QTD_HORAS,P11_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2127299893335579214)
,p_name=>'Oculta anexo'
,p_event_sequence=>565
,p_condition_element=>'P11_TEM_ANEXO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127300015057579215)
,p_event_id=>wwv_flow_api.id(2127299893335579214)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(3135044592811996465)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2127300263157579218)
,p_event_id=>wwv_flow_api.id(2127299893335579214)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(3135044592811996465)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139941474483901348)
,p_name=>'New'
,p_event_sequence=>575
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_USA_METRAGEM'
,p_condition_element=>'P11_USA_METRAGEM'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139941563587901349)
,p_event_id=>wwv_flow_api.id(1139941474483901348)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_METRAGEM,P11_VALOR_METRO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139941687323901350)
,p_event_id=>wwv_flow_api.id(1139941474483901348)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P11_METRAGEM,P11_VALOR_METRO_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139941799809901351)
,p_name=>'Recupera se usa metragem'
,p_event_sequence=>585
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_COD_EVENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139941900494901352)
,p_event_id=>wwv_flow_api.id(1139941799809901351)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P11_COD_PROCESSO,P11_COD_EVENTO,P11_EMP'
,p_attribute_03=>'P11_USA_METRAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139942178659901355)
,p_name=>'Checa metragem'
,p_event_sequence=>595
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_METRAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139942257811901356)
,p_event_id=>wwv_flow_api.id(1139942178659901355)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P11_MENSAGEM := null;',
'if to_number(:P11_METRAGEM) < to_number(:P11_METRAGEM_MINIMA) ',
'        or to_number(:P11_METRAGEM) > to_number(:P11_METRAGEM_MAXIMA) then',
unistr('   :P11_MENSAGEM := ''Metragem informada inv\00E1lida. Metragem deve ser entre ''||:P11_METRAGEM_MINIMA'),
'                       ||'' e ''||:P11_METRAGEM_MAXIMA;',
'end if;'))
,p_attribute_02=>'P11_METRAGEM , P11_METRAGEM_MINIMA, P11_METRAGEM_MAXIMA'
,p_attribute_03=>'P11_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139942979545901363)
,p_name=>'Valida Valor'
,p_event_sequence=>605
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_VALOR_APRESENTADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139943052802901364)
,p_event_id=>wwv_flow_api.id(1139942979545901363)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_valor_novo        number;',
'    v_mensagem varchar2(1) := ''N'';',
'begin',
'    :P11_MENSAGEM    := null;',
'    :P11_VALOR_DSP   := null;',
'',
'    if :P11_VALOR_APRESENTADO < :P11_VALOR_MINIMO then',
'        v_valor_novo := :P11_VALOR_MINIMO ;',
'        :P11_VALOR_DSP := :P11_VALOR_MINIMO ;',
'    elsif :P11_VALOR_APRESENTADO > :P11_VALOR_MAXIMO then    ',
'        v_valor_novo :=  :P11_VALOR_MAXIMO;',
'        :P11_VALOR_DSP :=  :P11_VALOR_MAXIMO;',
'    else',
'        v_valor_novo := :P11_VALOR_APRESENTADO;',
'        :P11_VALOR_DSP := :P11_VALOR_APRESENTADO;     ',
'    end if;',
'    :P11_VALOR_DSP := to_char(:P11_VALOR_DSP,''FML999G999G999G999G990D00'');',
'    --:P11_VALOR := v_valor_novo;',
'    /*',
'    if TO_NUMBER(:P11_VALOR_APRESENTADO) < TO_NUMBER(:P11_VALOR_MINIMO) ',
'                                 or  TO_NUMBER(:P11_VALOR_APRESENTADO)  > TO_NUMBER(:P11_VALOR_MAXIMO) then',
'        :P11_MENSAGEM := ''Valor Apresentado deve estar entre ''||:P11_VALOR_MINIMO||'' e ''||:P11_VALOR_MAXIMO;',
'    end if;*/',
'',
'end;'))
,p_attribute_02=>'P11_VALOR_APRESENTADO'
,p_attribute_03=>'P11_MENSAGEM,P11_VALOR_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139944470738901378)
,p_name=>'Calcula valor'
,p_event_sequence=>615
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_METRAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139944582218901379)
,p_event_id=>wwv_flow_api.id(1139944470738901378)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_valor number;',
'begin',
'    begin',
'        select USA_METRAGEM',
'          into  :P11_USA_METRAGEM',
'        from REEMBOLSO_PERFIS_PROCESSOS',
'          where cod_processo = :P11_COD_PROCESSO',
'          and cod_empresa = :P11_COD_EMPRESA',
'          and cod_perfil = :P_PERFIL;',
'    exception',
'        when others then ',
'        :P11_USA_METRAGEM := ''N'';  ',
'    end;',
'    --',
'    begin',
'        SELECT VALOR_METRO',
'          INTO v_valor',
'        FROM REEMBOLSO_PERFIS_EVENTOS t',
'        WHERE COD_EMPRESA = :P11_EMP',
'        AND COD_PROCESSO = :P11_COD_PROCESSO',
'        AND COD_EVENTO = :P11_EVENTOS;',
'    end;',
'    :P11_VALOR := :P11_METRAGEM * v_valor;',
'',
'end ;'))
,p_attribute_02=>'P11_COD_PROCESSO,P11_EMP,P11_METRAGEM,P11_COD_EVENTO'
,p_attribute_03=>'P11_VALOR_APRESENTADO,P11_VALOR,P11_VALOR_METRO_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068565834619004705)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;   ',
'',
'v_data date := :p11_data;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  begin',
'	SELECT seq_requisicao.NEXTVAL',
'  INTO v_seq ',
'  FROM DUAL;',
'  end;',
'',
':p11_cod_req := v_seq;',
':p11_cod_sit_req := 1;',
':p11_dt_req := sysdate;',
':p11_dt_sit_req := sysdate;',
':P11_COD_EMP_SOLICITANTE := :P_EMPRESA_USER;',
':p11_cod_mat_solicitante := :P_MATRICULA_USER;',
':p11_usuario := :p_usuario;',
':p11_dt_atualizacao := sysdate;',
'',
'if :P_PAINEL = ''PC'' then',
'    :P11_COD_EMPRESA := :P_EMPRESA_USER;',
'    :P11_MATRICULA := :P_MATRICULA_USER;',
'end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2068548403014004695)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068568226645004705)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Process'
,p_attribute_02=>'REQ_REEMBOLSO'
,p_attribute_03=>'P11_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2124964058074616947)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inserir Matriculas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_filial     informacoes_funcionais.filial%type;',
'    v_erro       varchar2(4000);',
'begin',
'        delete from testex where texto like ''ANDRE%'';',
'        insert into testex values (-05, ''ANDRE INICIANDO SALVAR MATRICULA'');',
'        commit;',
'    begin',
'        SELECT FILIAL',
'        INTO v_filial',
'        FROM INFORMACOES_FUNCIONAIS',
'        WHERE COD_EMPRESA = :P11_EMP',
'            AND MATRICULA = :P11_MAT;',
'    exception',
'        when others then',
'            v_filial := null;',
'    end;',
'    ',
'    ',
'insert into testex values (-05, ''ANDRE P11_VALOR_DSP = ''||:P11_VALOR_DSP);',
'insert into testex values (-05, ''ANDRE P11_VALOR_RS = ''||:P11_VALOR_RS);',
'insert into testex values (-05, ''ANDRE P11_METRAGEM = ''||:P11_METRAGEM);',
'commit;',
'',
'    begin',
'        insert into req_reembolso_matriculas( cod_req, ',
'                                                cod_empresa, ',
'                                                matricula, ',
'                                                cod_evento, ',
'                                                cod_motivo, ',
'                                                valor, ',
'                                                qtd_horas, ',
'                                                qtd_minutos, ',
'                                                qtd_dias,',
'                                                observacoes, ',
'                                                data_vigencia, ',
'                                                data_vigencia_efetivacao, ',
'                                                data_validade_inicial, ',
'                                                data_validade_final, ',
'                                                dia_limite_lancto, ',
'                                                qtd_parcelas, ',
'                                                filial,',
'                                                valor_apresentado,',
'                                                metragem',
'                                            )',
'            values ( :P11_COD_REQ',
'                   , :P11_EMP',
'                   , :P11_MAT',
'                   , :P11_COD_EVENTO',
'                   , :P11_MOTIVO',
'                   , :P11_VALOR',
'                   , :P11_QTD_HORAS',
'                   , :P11_QTD_MINUTOS ',
'                   , :P11_QTD_DIAS',
'                   , :P11_OBS',
'                   , :P11_DATA_VIGENCIA',
'                   , :P11_DATA_VIGENCIA_EFETIVACAO',
'                   , :P11_DATA_VALIDADE_INICIAL',
'                   , :P11_DATA_VALIDADE_FINAL',
'                   , :P11_DIA_LIMITE_LANCTO',
'                   , :P11_QTD_PARCELAS',
'                   , v_filial',
'                   , :P11_VALOR_APRESENTADO',
'                   , :P11_METRAGEM',
'                   );',
'    ',
'    exception',
'        when others then',
'        v_erro := SQLERRM;',
'        apex_error.add_error (',
unistr('                                p_message          => ''Erro ao inserir matricula da requisi\00E7\00E3o.''||v_erro ,'),
'                                p_display_location => apex_error.c_inline_in_notification );',
'                                ',
'        delete from testex where texto like ''ANDRE%'';',
unistr('        insert into testex values (-11, ''ANDRE Erro ao inserir matricula da requisi\00E7\00E3o.''||v_erro);'),
'        commit;',
'    end;',
'',
'    begin ',
'       for r in (  select arq_1, arq_1_nome, ARQ_1_MIMETYPE, arq_1_charset,',
'                                 arq_2, arq_2_nome, ARQ_2_MIMETYPE, arq_2_charset',
'                  from req_reembolso',
'                WHERE cod_req = :P11_COD_REQ)',
'       loop',
'          begin',
'              UPDATE req_reembolso_matriculas rrm',
'              SET rrm.arq_1 = r.arq_1',
'                  ,  rrm.arq_1_nome = r.arq_1_nome ',
'                  , rrm.arq_1_mimetype = r.ARQ_1_MIMETYPE  ',
'                  , rrm.arq_1_charset  =  r.arq_1_charset   ',
'                  , rrm.arq_2 = r.arq_2',
'                  ,  rrm.arq_2_nome = r.arq_2_nome ',
'                  , rrm.arq_2_mimetype = r.ARQ_2_MIMETYPE  ',
'                  , rrm.arq_2_charset  =  r.arq_2_charset       ',
'              WHERE cod_req =  :P11_COD_REQ;',
'        exception',
'        when others then',
'            apex_error.add_error (',
unistr('                                    p_message          => ''Erro ao carregar arquivos da requisi\00E7\00E3o.''||SQLERRM,'),
'                                    p_display_location => apex_error.c_inline_in_notification );',
'        end;',
'       end loop;',
'    end;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068567866950004705)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    PKG_REQ_REEMBOLSO.Post_Insert(:P11_cod_empresa          ,',
'                         :P11_cod_req      ,',
'                         V_flg_retorno             ,',
'                         V_msg_retorno             );',
'',
'    if v_msg_retorno is not null then',
'        :p11_ok       := ''N'';',
'        :p11_flag     := v_flg_retorno;',
'        :p11_mensagem := v_msg_retorno;',
'    else',
'        :p11_flag     := null;',
'        :p11_mensagem := null;',
'        :p11_ok       := ''S'';',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2068548403014004695)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068566721899004705)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_REEMBOLSO.Post_Update(:P11_cod_empresa          ,',
'                       :P11_cod_req      ,',
'                      V_flg_retorno             ,',
'                      V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    :p11_ok       := ''N'';',
'    :p11_flag     := v_flg_retorno;',
'    :p11_mensagem := v_msg_retorno;',
' else',
'    :p11_flag     := null;',
'    :p11_mensagem := null;',
'    :p11_ok       := ''S'';',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2068547948784004695)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068566298395004705)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Processo executado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068567433110004705)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
':P11_OK := ''S'';',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068567046000004705)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c2 is',
'SELECT HORARIO, POSICAO',
'  FROM PE_JORNADAS_COMPOSICAO',
' WHERE COD_JORNADA = Fnct_Pe_Retorna_Jornada( nvl(:p11_emp,:p11_cod_empresa),nvl(:p11_mat,:p11_matricula),  NULL/*:P11_DATA*/ )',
'   --AND POSICAO = :p11_posicao',
' order by 2;',
' ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'    open  c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'',
'  --  :p11_jornada           := v_c2.horario;',
'    if :P_PAINEL = ''PC'' then',
'        select cod_empresa||'' - ''||nome ',
'        into :P11_COD_EMPRESA_DSP',
'        from empresas where cod_empresa = :P_EMPRESA_USER;',
'',
'        select matricula||'' - ''||nome ',
'        into :P11_MATRICULA_DSP',
'        from inf_pessoais',
'        where cod_empresa = :P_EMPRESA_USER',
'            and matricula = :P_MATRICULA_USER;',
'            ',
'            :P11_VALIDA_PAINEL := :P_PAINEL;',
'    else',
'        :P11_VALIDA_PAINEL := :P_PAINEL; ',
'    end if;',
'    :P11_TEM_ANEXO := ''N'';',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068568721904004705)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'REQ_REEMBOLSO'
,p_attribute_03=>'P11_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2068446692310161948)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Preenche campos requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'       ',
'    cursor c_mat is ',
'    select t.*, t.rowid from req_reembolso_matriculas t',
'    where cod_req = :P11_COD_REQ',
'    and cod_empresa = :P11_EMP;',
'',
'    cursor c_op is ',
'    select unid1, unid2',
'    from ocorr_pagto',
'    where cod_empresa = :P11_EMP',
'       and cod = :P11_COD_EVENTO;',
'       ',
'    r_op c_op%rowtype;   ',
'    r_mat c_mat%rowtype;   ',
'begin',
'',
'INSERT INTO TESTEX VALUES (-101, ''ANDRE - P11_COD_REQ = ''||:P11_COD_REQ);',
'INSERT INTO TESTEX VALUES (-102, ''ANDRE - P11_EMP = ''||:P11_EMP);',
'COMMIT;',
'    if :P11_COD_REQ is not null then',
'        select cod_emp_solicitante||'' - ''||e.nome||'' / ''||r.matricula||'' - ''||i.nome , cod_emp_solicitante||'' - ''||e.nome,  r.matricula||'' - ''||i.nome ',
'            into :P11_SOLICITANTE, :P11_COD_EMPRESA_DSP, :P11_MATRICULA_DSP',
'            from req_reembolso r, empresas e, inf_pessoais i',
'            where cod_req = :P11_COD_REQ',
'            and r.cod_empresa = :P11_COD_EMPRESA',
'            and e.cod_empresa = r.cod_empresa',
'            and i.cod_empresa = r.cod_empresa',
'            and i.matricula = r.matricula;',
'',
'            :P11_VALIDA_PAINEL := ''PC'';',
'',
'            begin',
'                select cod_processo, cod_evento, COD_ELEGIBILIDADE',
'                 into :P11_COD_PROCESSO, :P11_COD_EVENTO, :P11_COD_ELEGIBILIDADE',
'                    from req_reembolso',
'                    where cod_req = :P11_COD_REQ;',
'            exception',
'                when others then',
'                    :P11_COD_PROCESSO := NULL;',
'                    :P11_COD_EVENTO   := NULL; ',
'            end;',
'            ',
'            begin',
'                select tem_anexo ',
'                    into :P11_TEM_ANEXO',
'                    from REEMBOLSO_PROCESSOS',
'                    where cod = :P11_COD_PROCESSO;',
'            exception',
'                when others then',
'                    :P11_TEM_ANEXO := ''S'';',
'            end;',
'',
'            begin',
'                select valor_minimo, valor_maximo , METROS_MINIMOS, METROS_MAXIMOS ',
'                    into :P11_VALOR_MINIMO, :P11_VALOR_MAXIMO, :P11_METRAGEM_MINIMA, :P11_METRAGEM_MAXIMA',
'                from reembolso_perfis_eventos',
'                where cod_processo = :P11_COD_PROCESSO',
'                and cod =:P11_COD_ELEGIBILIDADE ',
'                and rownum = 1;             ',
'            exception',
'                when others then',
'                    :P11_VALOR_MINIMO := NULL;',
'                    :P11_VALOR_MAXIMO   := NULL; ',
'            end;',
'',
'            open c_op;',
'            fetch c_op into r_op;',
'            close c_op;',
'            ',
'            :P11_QTD_HORAS := NULL;',
'            :P11_QTD_MINUTOS:= NULL;',
'            :P11_QTD_DIAS:= NULL;',
'            :P11_VALOR := NULL;',
'',
'            :P11_POR_VALOR        := NULL;',
'            :P11_POR_UNIDADES     := NULL;',
'            :P11_POR_DIA          := NULL;',
'',
'            open c_op;',
'            fetch c_op into r_op; ',
'            close c_op;',
'            -- mostar valor',
'            if  r_op.unid1 = ''QTDE'' and r_op.unid2 is null then',
'                :P11_POR_VALOR := ''S'';',
'                :P11_POR_UNIDADES     := NULL;',
'                :P11_POR_DIA          := NULL;',
'            -- mostrar unidades',
'            elsif  r_op.unid1 = ''HORA'' and r_op.unid2 = ''MIN'' then',
'                :P11_POR_VALOR        := NULL;',
'                :P11_POR_UNIDADES     := ''S'';',
'                :P11_POR_DIA          := NULL;',
'            -- mostrar dias',
'            elsif  r_op.unid1 = ''QTDE'' and r_op.unid2 = ''DIA'' then',
'                :P11_POR_VALOR        := NULL;',
'                :P11_POR_UNIDADES     := NULL;',
'                :P11_POR_DIA          := ''S'';',
'            else',
'                :P11_POR_VALOR := ''S'';',
'                :P11_POR_UNIDADES     := NULL;',
'                :P11_POR_DIA          := NULL;    ',
'            end if;',
'            --',
'            open c_mat;',
'            fetch c_mat into r_mat;',
'            close c_mat;',
'            if r_mat.matricula is not null then',
'',
'                :P11_DATA_VIGENCIA := r_mat.DATA_VIGENCIA;',
'                :P11_DATA_VIGENCIA_EFETIVACAO := r_mat.DATA_VIGENCIA_EFETIVACAO;',
'                :P11_DATA_VALIDADE_INICIAL := r_mat.DATA_VALIDADE_INICIAL;',
'                :P11_DATA_VALIDADE_FINAL := r_mat.DATA_VALIDADE_FINAL;',
'                :P11_DIA_LIMITE_LANCTO := r_mat.DIA_LIMITE_LANCTO;',
'                :P11_QTD_PARCELAS := r_mat.QTD_PARCELAS;',
'                :P11_QTD_HORAS := nvl(to_char(r_mat.QTD_HORAS), ''-'');',
'                :P11_QTD_MINUTOS := nvl(to_char(r_mat.QTD_MINUTOS), ''-'');',
'                --:P11_VALOR_RS := TO_CHAR(nvl(r_mat.VALOR_APRESENTADO, 0), ''R$99,999.99'');',
'                --:P11_VALOR_DSP := TO_CHAR(nvl(r_mat.VALOR, 0), ''R$99,999.99'');',
'',
'                :P11_VALOR_RS := nvl(r_mat.VALOR_APRESENTADO, 0);',
'                :P11_VALOR_DSP := nvl(TO_CHAR(r_mat.VALOR, ''L9999D99''), ''-''); ',
'                :P11_QTD_DIAS := nvl(to_char(r_mat.QTD_DIAS), ''-'');',
'                :P11_VALOR_APRESENTADO_DSP := nvl(TO_CHAR(r_mat.VALOR_APRESENTADO, ''L9999D99''), ''-''); ',
'                :P11_METRAGEM_DSP := nvl(to_char(r_mat.metragem), ''-'');',
'            end if;            ',
'    end if;',
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
