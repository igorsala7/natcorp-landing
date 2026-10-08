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
,p_default_id_offset=>784797347607055121
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   23:13 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 126
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00126
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>126);
end;
/
prompt --application/pages/page_00126
begin
wwv_flow_api.create_page(
 p_id=>126
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Indica\00E7\00E3o de Curso')
,p_step_title=>unistr('Editar: Indica\00E7\00E3o de Curso')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_upd_yyyymmddhh24miss=>'20240624131252'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395399587677131485)
,p_plug_name=>'Curso'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395401515204131486)
,p_plug_name=>'&P126_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395404798772131491)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281395408347652131496)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.empresa_aprov||'' - ''||a.matricula_aprov||'' - ''||initcap(fnct_nome_func(a.empresa_aprov,a.matricula_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.empresa_aprov, a.matricula_aprov, A.SEQ_APROV, a.justificativa',
'  from TR_APROVA_INDICACAO_CURSO a, usuario_oracle u',
' where a.cod_requisicao = :p118_cod_requisicao',
'   and a.empresa_aprov = u.cd_empresa',
'   and a.matricula_aprov = u.cd_matricula',
'   --and u.cd_perfil NOT IN (''BUSINESS PARTNER'',''REMUNERACAO'',''CONT DE NEGOCIOS'')',
'   and not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil)',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL empresa_aprov, NULL matricula_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from TR_APROVA_INDICACAO_CURSO a, usuario_oracle u',
' where a.cod_requisicao = :p118_cod_requisicao',
'   and a.empresa_aprov = u.cd_empresa',
'   and a.matricula_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_requisicao',
'  from TR_APROVA_INDICACAO_CURSO',
' where cod_requisicao = :p126_cod_indicacao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281395408725659131497)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#EMPRESA_APROV#,#MATRICULA_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281395409195749131497)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281395409587141131498)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281395409994676131498)
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
 p_id=>wwv_flow_api.id(281395410368143131498)
,p_query_column_id=>5
,p_column_alias=>'EMPRESA_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281395410738616131499)
,p_query_column_id=>6
,p_column_alias=>'MATRICULA_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068788827229883)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068928159229884)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395411926009131500)
,p_plug_name=>'Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395413595349131501)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281395411926009131500)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P126_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395414361245131502)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281395411926009131500)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P126_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281395472208525058803)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281404529436169682497)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395435325630187083)
,p_button_sequence=>1000
,p_button_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_button_name=>'p126_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P126_btn_solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P_EMPRESA_USER.,&P_MATRICULA_USER.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395405186445131491)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:125:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395411189774131499)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281395408347652131496)
,p_button_name=>'p126_btn_reprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_requisicao',
'  from TR_APROVA_INDICACAO_CURSO',
' where cod_requisicao = :p126_cod_indicacao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395405970529131492)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select situacao',
'  from TR_INDICACAO_CURSOS',
' where cod_indicacao = :p126_cod_indicacao;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.situacao = 1 and :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395411560164131499)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281395408347652131496)
,p_button_name=>'p126_btn_aprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_requisicao',
'  from TR_APROVA_INDICACAO_CURSO',
' where cod_requisicao = :p126_cod_indicacao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395406331542131492)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P126_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395405547724131492)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281395412315659131500)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281395411926009131500)
,p_button_name=>'p126_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P126_COD_EMPRESA.,&P126_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281395429883868131516)
,p_branch_action=>'f?p=&APP_ID.:125:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375968242526181634)
,p_name=>'P126_EMP_SOLICITANTE'
,p_item_sequence=>1010
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_source=>'EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375968330427181635)
,p_name=>'P126_MAT_SOLICITANTE'
,p_item_sequence=>1020
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375968418048181636)
,p_name=>'P126_INFORMACOES_CONTATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Informa\00E7\00F5es do Contato')
,p_placeholder=>'Descreva o contato para o curso.'
,p_source=>'INFORMACOES_CONTATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null and :p126_situacao <> 1 then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375968837746181640)
,p_name=>'P126_CURSO_EXISTENTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Curso Existente?'
,p_source=>'CURSO_EXISTENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_colspan=>3
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395399924878131485)
,p_name=>'P126_COD_CURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Curso'
,p_source=>'COD_CURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select cod_curso||'' - ''||initcap(nome_curso) descricao, cod_curso',
'   from tr_cursos',
'where cod_tipo = nvl(:p126_cod_tipo,cod_tipo)',
'  order by nome_curso'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P126_COD_TIPO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_08=>'600'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395400378416131485)
,p_name=>'P126_NOME_CURSO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nome do Curso'
,p_placeholder=>'Informe o nome do curso.'
,p_source=>'NOME_CURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395400765143131486)
,p_name=>'P126_COD_TIPO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo'
,p_source=>'COD_TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select to_char(cod_tipo)||'' - ''||Initcap(nome_tipo) descricao, to_char(cod_tipo) codigo from tr_tipo_curso order by cod_tipo'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>3
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395401114162131486)
,p_name=>'P126_MOTIVO_INDICACAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281395399587677131485)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Motivo da Indica\00E7\00E3o')
,p_placeholder=>unistr('Descreva o motivo da indica\00E7\00E3o.')
,p_source=>'MOTIVO_INDICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395401996772131487)
,p_name=>'P126_COD_INDICACAO'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Indica\00E7\00E3o')
,p_source=>'COD_INDICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>2
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395402386321131487)
,p_name=>'P126_DATA_INDICACAO'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_source=>'DATA_INDICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395402775590131487)
,p_name=>'P126_TITULO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395403124333131489)
,p_name=>'P126_ROWID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395403582803131490)
,p_name=>'P126_SITUACAO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'SITUACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Aberta;1,Conclu\00EDda;2,Cancelada;3,Reprovada;4,Aprovada;5')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select situacao',
'  from TR_INDICACAO_CURSOS',
' where cod_indicacao = :p126_cod_indicacao;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.situacao <> 1 then',
'return true;',
'else',
'return false;',
'end if;',
'',
'end;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395403917505131490)
,p_name=>'P126_USUARIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395404361892131491)
,p_name=>'P126_DT_ATUALIZACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395406729198131493)
,p_name=>'P126_FLAG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395407186268131493)
,p_name=>'P126_MENSAGEM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395407596485131495)
,p_name=>'P126_ITEM_VALIDACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395408004235131496)
,p_name=>'P126_OK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281395404798772131491)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395412778501131500)
,p_name=>'P126_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281395411926009131500)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod',
'from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P126_COD_INDICACAO is null) or ',
'        (:P126_COD_INDICACAO is not null)) ',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P126_COD_INDICACAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395413183786131501)
,p_name=>'P126_MATRICULA'
,p_is_required=>true
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281395411926009131500)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
' from informacoes_funcionais i, centro_de_custo c',
'where i.cod_empresa = c.cod_empresa',
'  and i.cod_ccusto = c.cod',
'  and i.situacao < ''90''',
'  and i.cod_empresa = :p126_cod_empresa',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P126_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p126_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395413985698131502)
,p_name=>'P126_FOTO_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281395413595349131501)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P126_COD_EMPRESA',
'   and matricula = :P126_MATRICULA;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395414735223131502)
,p_name=>'P126_COD_EMPRESA_DISPLAY'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281395414361245131502)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395415178416131503)
,p_name=>'P126_MATRICULA_DISPLAY'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281395414361245131502)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395415529984131503)
,p_name=>'P126_SITUACAO_COLAB'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281395414361245131502)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395415935604131503)
,p_name=>'P126_DT_ADMISSAO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281395414361245131502)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281395435086996183942)
,p_name=>'P126_SOLICITANTE'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(281395401515204131486)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(269588270633503532671)
,p_computation_sequence=>10
,p_computation_item=>'P126_COD_INDICACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'seq_requisicao.NEXTVAL'
,p_compute_when=>'P126_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(269588270749717532673)
,p_computation_sequence=>10
,p_computation_item=>'P126_DATA_INDICACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'SYSDATE'
,p_compute_when=>'P126_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269588271383797532679)
,p_validation_name=>unistr('Valida Situa\00E7\00E3o')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select situacao',
'  from TR_INDICACAO_CURSOS',
' where cod_indicacao = :p126_cod_indicacao;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.situacao = 1 and :p126_situacao <> 3 then',
unistr('return ''N\00E3o \00E9 poss\00EDvel alterar a situa\00E7\00E3o'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281395405970529131492)
,p_associated_item=>wwv_flow_api.id(281395403582803131490)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395422133012131511)
,p_name=>'Inicia Alertify'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395422687282131511)
,p_event_id=>wwv_flow_api.id(281395422133012131511)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395423098479131511)
,p_name=>'Aprovar'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395411560164131499)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P126_OK = ''S'' THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395464847577879502)
,p_event_id=>wwv_flow_api.id(281395423098479131511)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_CURSO_EXISTENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395423536532131512)
,p_event_id=>wwv_flow_api.id(281395423098479131511)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P126_OK = ''S'' THEN',
'',
'begin',
'',
'update TR_APROVA_INDICACAO_CURSO',
'   set status_aprov = ''A'', dt_aprov = sysdate',
' where empresa_aprov = :p126_cod_empresa',
'   and cod_requisicao = :p126_cod_indicacao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER;',
'',
'commit;',
'',
'end;',
'',
'declare',
'	cursor c1 is',
'	  select status_aprov',
'	    from tr_aprova_INDICACAO_curso',
'	   where cod_requisicao  = :p126_cod_indicacao',
'	     and empresa_aprov   = :P_EMPRESA_USER',
'	     and matricula_aprov = :P_MATRICULA_USER;',
'	v_c1 c1%rowtype;  ',
'	v_total_aprovado number := 0;',
'	  ',
' saida exception;',
'      ',
'  v_cod_curso  TR_REQUISICOES_CURSOS.cod_curso%type;    ',
'      ',
'begin',
'',
'	open  c1;',
'	fetch c1 into v_c1;',
'	close c1;',
'    ',
'	if v_c1.status_aprov in(''R'', ''A'') then     ',
'     :p126_flag := ''N'';',
'     :p126_ok := ''N'';',
unistr('     :p126_mensagem := ''Status da aprova\00E7\00E3o n\00E3o pode ser alterado!'';	 '),
'	   raise saida;',
'    end if;',
'  ',
'    :p126_dt_aprov := sysdate;     ',
'     ',
'    commit;',
'     ',
'		BEGIN',
'			select count(*)',
'			  into v_total_aprovado',
'			  from tr_aprova_INDICACAO_curso',
'			 where cod_requisicao = :p126_cod_indicacao',
'				 and empresa_aprov = :P_EMPRESA_USER',
'				 and status_aprov <> ''A'';',
'					',
'			IF v_total_aprovado = 0 then',
'					',
'              if nvl(:p126_cursos_existente,''N'') = ''N'' then',
'                    ',
'			  select max(cod_curso)+1 ',
'					into v_cod_curso',
'					from tr_cursos;',
'							',
'				insert into tr_cursos (cod_curso, ',
'															 nome_curso, ',
'															 cod_tipo,',
'															 observacao) ',
'				               values (v_cod_curso,',
'								               :p126_nome_curso, ',
'								               :p126_cod_tipo,',
'								               :p126_informacoes_contato);',
'                                               ',
'                                               commit;',
'                                       ',
'                 update tr_INDICACAO_cursos',
'                    set cod_curso = v_cod_curso, situacao = 2',
'                  where cod_INDICACAO = :p126_cod_INDICACAO;',
'                  ',
'                  commit;',
'                  ',
'              end if;',
'              ',
'               begin',
'                 update tr_INDICACAO_cursos',
'                    set situacao = 2',
'                  where cod_INDICACAO = :p126_cod_INDICACAO;',
'                  ',
'                  commit;',
'               end;',
'              ',
'			END IF;',
'			',
'		exception',
'		  when no_data_found then',
'				null;',
'		  when others then',
'             :p126_flag := ''N'';',
'             :p126_ok := ''N'';',
unistr('             :p126_mensagem := ''N\00E3o foi poss\00EDvel inserir o Curso. '' || sqlerrm(sqlcode);	 '),
'	         raise saida;',
'		END;',
'      ',
'exception',
'when saida then',
'null;',
'end;',
'',
'end if;'))
,p_attribute_02=>'P126_COD_EMPRESA,P126_COD_INDICACAO,P_EMPRESA_USER,P_MATRICULA_USER,P126_NOME_CURSO,P126_COD_TIPO,P126_INFORMACOES_CONTATO,P126_CURSO_EXISTENTE'
,p_attribute_03=>'P126_FLAG,P126_OK,P126_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395424048399131512)
,p_event_id=>wwv_flow_api.id(281395423098479131511)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395424424697131512)
,p_name=>'Reprovar'
,p_event_sequence=>320
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395411189774131499)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P126_OK = ''S'' THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395424933606131513)
,p_event_id=>wwv_flow_api.id(281395424424697131512)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P126_OK = ''S'' THEN',
'',
'begin',
'',
'update TR_APROVA_INDICACAO_CURSO',
'   set status_aprov = ''R'', dt_aprov = sysdate',
' where empresa_aprov = :p126_cod_empresa',
'   and cod_requisicao = :p126_cod_INDICACAO',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER;',
'',
'commit;',
'',
'end;',
'',
'begin',
' update tr_INDICACAO_cursos',
'    set situacao = 4',
'  where cod_INDICACAO = :p126_cod_INDICACAO;',
'',
'  commit;',
'end;',
'',
'end if;'))
,p_attribute_02=>'P126_COD_EMPRESA,P126_COD_INDICACAO,P_EMPRESA_USER,P_MATRICULA_USER'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395425504531131513)
,p_event_id=>wwv_flow_api.id(281395424424697131512)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395426788933131514)
,p_name=>'OK: Show Create'
,p_event_sequence=>330
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_ITEM_VALIDACAO'
,p_condition_element=>'P126_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395427152676131514)
,p_name=>'Dispara Alerta'
,p_event_sequence=>340
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_MENSAGEM'
,p_condition_element=>'P126_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395427582650131514)
,p_event_id=>wwv_flow_api.id(281395427152676131514)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P126_FLAG'').value == "Q") {',
'alertify.confirm($v(''P126_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P126_FLAG'').value = ''S'';',
'        $x(''P126_MENSAGEM'').value = '''';',
'        $x(''P126_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P126_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P126_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P126_FLAG'').value == "N") {',
'            $x(''P126_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P126_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P126_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P126_MENSAGEM''));',
'    }else{',
'            if ($x(''P126_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P126_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395421224413131510)
,p_name=>'Enable Fields (Create)'
,p_event_sequence=>350
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395406331542131492)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395421735592131510)
,p_event_id=>wwv_flow_api.id(281395421224413131510)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_COD_INDICACAO,P126_DATA_INDICACAO,P126_SITUACAO,P126_COD_CURSO,P126_COD_TIPO,P126_MOTIVO_INDICACAO,P126_COD_EMPRESA,P126_MATRICULA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395425847495131513)
,p_name=>'CARREGA_USUARIO'
,p_event_sequence=>360
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395406331542131492)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395426358770131513)
,p_event_id=>wwv_flow_api.id(281395425847495131513)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p126_data_indicacao := sysdate;',
':p126_situacao		 := 1;',
'',
':p126_dt_atualizacao  := SYSDATE;',
':p126_usuario		  := :p_usuario;'))
,p_attribute_02=>'P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P126_DATA_INDICACAO,P126_SITUACAO,P126_DT_ATUALIZACAO,P126_USUARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395428901111131515)
,p_name=>'PRE-INSERT'
,p_event_sequence=>370
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395406331542131492)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969622910181648)
,p_event_id=>wwv_flow_api.id(281395428901111131515)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_COD_EMPRESA,P126_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395429386324131515)
,p_event_id=>wwv_flow_api.id(281395428901111131515)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'   Select Seq_Indicacao_Curso.NextVal',
'     Into :P126_Cod_Indicacao',
'     From Dual;'))
,p_attribute_03=>'P126_COD_INDICACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281395427973633131514)
,p_name=>'PRCD_INSERE_APROVADORES'
,p_event_sequence=>380
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281395406331542131492)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281395428437045131515)
,p_event_id=>wwv_flow_api.id(281395427973633131514)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  --',
'  CURSOR c_aprov IS',
'    SELECT a.cod_empresa, a.matricula, a.seq_aprov',
'      FROM aprovacao_ccusto a, informacoes_funcionais i',
'     WHERE a.cod_empresa = :p126_cod_empresa',
'       AND a.cod_filial = i.filial',
'       AND a.cod_ccusto = i.cod_ccusto',
'       AND a.matricula <> :p126_matricula',
'       and a.cod_empresa = i.cod_empresa',
'       and i.cod_empresa = :p126_cod_empresa',
'       and i.matricula = :p126_matricula',
'       AND a.per_treinamentos = ''S'';',
'  --',
'  saida exception;',
'  ',
'BEGIN',
'  --',
'  BEGIN',
'    --',
'    INSERT INTO tr_aprova_indicacao_curso',
'      (cod_requisicao, --1',
'       empresa_aprov, --2',
'       matricula_aprov, --3',
'       status_aprov, --4',
'       dt_aprov, --5',
'       seq_aprov, --6',
'       usuario, --7',
'       dt_atualizacao) --8',
'    VALUES',
'      (:p126_cod_indicacao, --1',
'       :p126_emp_solicitante, --2',
'       :p126_mat_solicitante, --3',
'       ''A'', --4',
'       SYSDATE, --5',
'       1, --6',
'       :p_usuario, --7',
'       SYSDATE); --8',
'    --',
'  EXCEPTION',
'    --',
'    WHEN OTHERS THEN',
'      --',
'      :p126_flag := ''N'';',
'      :p126_ok := ''N'';',
'      :p126_mensagem := ''1 - Erro ao inserir dados na tr_aprova_indicacao_curso: '' ||SQLERRM;',
'      raise saida;',
'      --',
'  END;',
'  --',
'  FOR r_aprov in c_aprov LOOP',
'    --',
'    BEGIN',
'      --',
'      INSERT INTO tr_aprova_indicacao_curso',
'        (cod_requisicao, --1',
'         empresa_aprov, --2',
'         matricula_aprov, --3',
'         status_aprov, --4',
'         dt_aprov, --5',
'         seq_aprov, --6',
'         usuario, --7',
'         dt_atualizacao) --8',
'      VALUES',
'        (:p126_cod_indicacao, --1',
'         r_aprov.cod_empresa, --2',
'         r_aprov.matricula, --3',
'         ''P'', --4',
'         NULL, --5',
'         r_aprov.seq_aprov, --6',
'         :p_usuario, --7',
'         SYSDATE); --8',
'      --',
'    EXCEPTION',
'      --',
'      WHEN OTHERS THEN',
'',
'      :p126_flag := ''N'';',
'      :p126_ok := ''N'';',
'      :p126_mensagem := ''2 - Erro ao inserir dados na tr_aprova_indicacao_curso: '' ||SQLERRM;',
'      raise saida;',
'    END;',
'    --',
'  END LOOP;',
'  --',
'exception',
'when saida then',
'null;',
'END;'))
,p_attribute_02=>'P126_COD_EMPRESA,P126_MATRICULA,P126_COD_INDICACAO,P_USUARIO'
,p_attribute_03=>'P126_FLAG,P126_OK,P126_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375968571167181637)
,p_name=>'popula nome_curso'
,p_event_sequence=>420
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_COD_CURSO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375968615472181638)
,p_event_id=>wwv_flow_api.id(281375968571167181637)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
' select initcap(nome_curso) descricao',
'   into :p126_nome_curso',
'   from tr_cursos',
'  where cod_curso = :p126_cod_curso;',
'',
'exception',
'when others then',
'',
':p126_nome_curso := null;',
'end;'))
,p_attribute_02=>'P126_COD_CURSO'
,p_attribute_03=>'P126_NOME_CURSO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375969002501181641)
,p_name=>'Curso Existente'
,p_event_sequence=>430
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_CURSO_EXISTENTE'
,p_condition_element=>'P126_CURSO_EXISTENTE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969073664181642)
,p_event_id=>wwv_flow_api.id(281375969002501181641)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_COD_CURSO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969123225181643)
,p_event_id=>wwv_flow_api.id(281375969002501181641)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_COD_CURSO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969261328181644)
,p_event_id=>wwv_flow_api.id(281375969002501181641)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_NOME_CURSO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969393139181645)
,p_event_id=>wwv_flow_api.id(281375969002501181641)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_NOME_CURSO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375969480208181646)
,p_name=>'MAT IS NOT NULL'
,p_event_sequence=>440
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P126_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375969560806181647)
,p_event_id=>wwv_flow_api.id(281375969480208181646)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P126_COD_EMPRESA,P126_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375681885321620745)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>450
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P126_SITUACAO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375681940792620746)
,p_event_id=>wwv_flow_api.id(281375681885321620745)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411560164131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375682043632620747)
,p_event_id=>wwv_flow_api.id(281375681885321620745)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411189774131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281068129243389697833)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>460
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P126_SITUACAO'
,p_condition_element=>'P126_SITUACAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P126_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129308928697834)
,p_event_id=>wwv_flow_api.id(281068129243389697833)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411560164131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129641254697837)
,p_event_id=>wwv_flow_api.id(281068129243389697833)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411189774131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129464374697835)
,p_event_id=>wwv_flow_api.id(281068129243389697833)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411189774131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129533744697836)
,p_event_id=>wwv_flow_api.id(281068129243389697833)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281395411560164131499)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395417890266131508)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'begin',
'',
'   if :P126_SITUACAO = 1 then',
'      v_sit := ''Aberta'';',
'elsif :P126_SITUACAO = 2 then',
unistr('      v_sit := ''Conclu\00EDda'';'),
'elsif :P126_SITUACAO = 3 then',
'      v_sit := ''Cancelada'';',
'elsif :P126_SITUACAO = 4 then',
'      v_sit := ''Reprovada'';',
'elsif :P126_SITUACAO = 5 then',
'      v_sit := ''Aprovada'';',
'end if;',
'',
'',
'if :p126_rowid is not null then',
unistr('   :p126_titulo := ''Indica\00E7\00E3o de Curso: N\00BA ''||:p126_cod_indicacao||'' - ''||:P126_DATA_indicacao||'' (''||v_sit||'')'';'),
'else',
unistr('   :p126_titulo := ''Indica\00E7\00E3o de Curso'';'),
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395436150794211896)
,p_process_sequence=>60
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Solicitante'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa))||'' / ''||',
'        matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula))||'' / ''||',
'        cargo||'' - ''||initcap(fnct_nome_cargo(cargo)) colaborador',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p126_emp_solicitante',
'    and matricula   = :p126_mat_solicitante;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
'IF :P126_COD_REQUISICAO IS NULL THEN',
':p126_emp_solicitante := :P_EMPRESA_USER;',
':p126_mat_solicitante := :P_MATRICULA_USER;',
'END IF;',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p126_solicitante := v_c1.colaborador;',
' end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269588270252187532668)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p126_data_indicacao := sysdate;',
':p126_situacao		 := 1;',
'',
':p126_dt_atualizacao  := SYSDATE;',
':p126_usuario		  := :p_usuario;',
'',
'/*',
'BEGIN',
'   Select seq_requisicao.NEXTVAL',
'     Into :P126_Cod_Indicacao',
'     From Dual;',
'END;',
'*/',
'',
'null;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281395406331542131492)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269588270532061532670)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p126_dt_atualizacao  := SYSDATE;',
':p126_usuario		  := :p_usuario;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281395405970529131492)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395417009857131505)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of TR_INDICACAO_CURSOS'
,p_attribute_02=>'TR_INDICACAO_CURSOS'
,p_attribute_03=>'P126_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Processada com Sucesso.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269588270430768532669)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRCD_INSERE_APROVADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  --',
'  CURSOR c_aprov IS',
'    SELECT a.cod_empresa, a.matricula, a.seq_aprov',
'      FROM aprovacao_ccusto a, informacoes_funcionais i',
'     WHERE a.cod_empresa = :p126_cod_empresa',
'       AND a.cod_filial = i.filial',
'       AND a.cod_ccusto = i.cod_ccusto',
'       AND a.matricula <> :p126_matricula',
'       and a.cod_empresa = i.cod_empresa',
'       and i.cod_empresa = :p126_cod_empresa',
'       and i.matricula = :p126_matricula',
'       AND a.per_treinamentos = ''S'';',
'  --',
'  saida exception;',
'  ',
'BEGIN',
'  --',
'  BEGIN',
'    --',
'    INSERT INTO tr_aprova_indicacao_curso',
'      (cod_requisicao, --1',
'       empresa_aprov, --2',
'       matricula_aprov, --3',
'       status_aprov, --4',
'       dt_aprov, --5',
'       seq_aprov, --6',
'       usuario, --7',
'       dt_atualizacao) --8',
'    VALUES',
'      (:p126_cod_indicacao, --1',
'       :p126_emp_solicitante, --2',
'       :p126_mat_solicitante, --3',
'       ''A'', --4',
'       SYSDATE, --5',
'       1, --6',
'       :p_usuario, --7',
'       SYSDATE); --8',
'    --',
'  EXCEPTION',
'    --',
'    WHEN OTHERS THEN',
'      --',
'      :p126_flag := ''N'';',
'      :p126_ok := ''N'';',
'      :p126_mensagem := ''1 - Erro ao inserir dados na tr_aprova_indicacao_curso: '' ||SQLERRM;',
'      raise saida;',
'      --',
'  END;',
'  --',
'  FOR r_aprov in c_aprov LOOP',
'    --',
'    BEGIN',
'      --',
'      INSERT INTO tr_aprova_indicacao_curso',
'        (cod_requisicao, --1',
'         empresa_aprov, --2',
'         matricula_aprov, --3',
'         status_aprov, --4',
'         dt_aprov, --5',
'         seq_aprov, --6',
'         usuario, --7',
'         dt_atualizacao) --8',
'      VALUES',
'        (:p126_cod_indicacao, --1',
'         r_aprov.cod_empresa, --2',
'         r_aprov.matricula, --3',
'         ''P'', --4',
'         NULL, --5',
'         r_aprov.seq_aprov, --6',
'         :p_usuario, --7',
'         SYSDATE); --8',
'      --',
'    EXCEPTION',
'      --',
'      WHEN OTHERS THEN',
'',
'      :p126_flag := ''N'';',
'      :p126_ok := ''N'';',
'      :p126_mensagem := ''2 - Erro ao inserir dados na tr_aprova_indicacao_curso: '' ||SQLERRM;',
'      raise saida;',
'    END;',
'    --',
'  END LOOP;',
'  --',
'exception',
'when saida then',
'null;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281395406331542131492)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395566407263420316)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Aprovar_2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update TR_APROVA_INDICACAO_CURSO',
'   set status_aprov = ''A'', dt_aprov = sysdate',
' where empresa_aprov = :p126_cod_empresa',
'   and cod_requisicao = :p126_cod_indicacao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER;',
'',
'commit;',
'',
'exception',
'when others then',
'null;',
'',
'end;',
'',
'declare',
'',
'	v_total_aprovado number := 0;',
'	  ',
' saida exception;',
'      ',
'  v_cod_curso  TR_REQUISICOES_CURSOS.cod_curso%type;    ',
'      ',
'begin',
'',
'		BEGIN',
'			select count(*)',
'			  into v_total_aprovado',
'			  from tr_aprova_INDICACAO_curso',
'			 where cod_requisicao = :p126_cod_indicacao',
'				 and empresa_aprov = :P_EMPRESA_USER',
'				 and status_aprov <> ''A'';',
'					',
'			IF nvl(v_total_aprovado,0) = 0 then',
'					',
'              if nvl(:p126_cursos_existente,''N'') = ''N'' then',
'              ',
'              begin',
'              ',
'			  select max(cod_curso)+1 ',
'					into v_cod_curso',
'					from tr_cursos;',
'							',
'				insert into tr_cursos (cod_curso, ',
'															 nome_curso, ',
'															 cod_tipo,',
'															 observacao,',
'                                      usuario,',
'                                      dt_atualizacao) ',
'				               values (v_cod_curso,',
'								               :p126_nome_curso, ',
'								               :p126_cod_tipo,',
'								               :p126_informacoes_contato,',
'                                      :p_usuario,',
'                                      sysdate);',
'                                               ',
'                                               commit;',
'                                       ',
'                 update tr_INDICACAO_cursos',
'                    set cod_curso = v_cod_curso, situacao = 2',
'                  where cod_INDICACAO = :p126_cod_INDICACAO;',
'                  ',
'                  commit;',
'               end;  ',
'              end if;',
'              ',
'              begin',
'                 update tr_INDICACAO_cursos',
'                    set situacao = 2',
'                  where cod_INDICACAO = :p126_cod_INDICACAO;',
'                  ',
'                  commit;',
'              end;',
'			END IF;',
'			',
'		exception',
'		  when no_data_found then',
'				null;',
'		  when others then',
'             :p126_flag := ''N'';',
'             :p126_ok := ''N'';',
unistr('             :p126_mensagem := ''N\00E3o foi poss\00EDvel inserir o Curso. '' || sqlerrm(sqlcode);	 '),
'	         raise saida;',
'		END;',
'      ',
'exception',
'when saida then',
'null;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395417413250131505)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281395405547724131492)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395419034056131508)
,p_process_sequence=>10
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
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395418221808131508)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from TR_INDICACAO_CURSOS'
,p_attribute_02=>'TR_INDICACAO_CURSOS'
,p_attribute_03=>'P126_COD_INDICACAO'
,p_attribute_04=>'COD_INDICACAO'
,p_process_when=>'P126_COD_INDICACAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281395418646212131508)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       I.FILIAL',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p126_COD_EMPRESA',
'   and i.matricula = :p126_MATRICULA;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p126_cod_requisicao is null then',
' :p126_emp_solicitante := :P_EMPRESA_USER;',
' :p126_MAT_solicitante := :P_MATRICULA_USER;',
'end if;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p126_cod_empresa_display := v_c1.empresa;',
':p126_matricula_display := v_c1.matricula;',
':p126_situacao_colab := v_c1.situacao;',
':p126_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p126_cod_empresa_display := :p126_empresa;',
':p126_matricula_display := :p126_matricula;',
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
