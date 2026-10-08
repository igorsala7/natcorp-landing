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
,p_default_application_id=>2943
,p_default_id_offset=>789695335995812157
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2943 - Segurança do Trabalho - Controles
--
-- Application Export:
--   Application:     2943
--   Name:            Segurança do Trabalho - Controles
--   Date and Time:   05:25 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 31
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00031
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>31);
end;
/
prompt --application/pages/page_00031
begin
wwv_flow_api.create_page(
 p_id=>31
,p_user_interface_id=>wwv_flow_api.id(137647235592464344980)
,p_name=>unistr('Criar/Editar: Comunica\00E7\00E3o de Acidente de Trabalho')
,p_step_title=>unistr('Criar/Editar: Comunica\00E7\00E3o de Acidente de Trabalho')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APP_IMAGES#jquery.maskedinput.min.js',
'#APP_IMAGES#forms-functions.js',
'#APP_IMAGES#cards.js'))
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(function() {',
'        $.mask.definitions[''~''] = "[+-]";                       ',
'',
'        $("#P31_CEP_DSP").attr("type", "tel");',
'  ',
'',
'  ',
'        $("#P31_CEP_DSP").mask(''99999-999'', {reverse: true});',
'  ',
'       ',
'    ',
'  });',
'',
'document.querySelectorAll(''.no-space'').forEach(function(el) {',
unistr('  // Bloqueia letras e espa\00E7os ao digitar'),
'  el.addEventListener(''keydown'', function(e) {',
'    const allowedKeys = [',
'      ''Backspace'', ''Delete'', ''ArrowLeft'', ''ArrowRight'', ''Tab'',',
'      ''Home'', ''End'', ''Enter''',
'    ];',
'',
'    // Permitir teclas de controle',
'    if (allowedKeys.includes(e.key)) return;',
'',
unistr('    // Permitir apenas n\00FAmeros (e ponto ou v\00EDrgula, se quiser)'),
'    if (!e.key.match(/[0-9:]/)) {',
'      e.preventDefault();',
'    }',
'',
unistr('    // Bloqueia espa\00E7o especificamente'),
'    if (e.key === '' '' || e.code === ''Space'') {',
'      e.preventDefault();',
'    }',
'  });',
'',
unistr('  // Tamb\00E9m remove caracteres inv\00E1lidos se forem colados (ex: Ctrl+V)'),
'  el.addEventListener(''input'', function(e) {',
unistr('    // Permite apenas d\00EDgitos, ponto e v\00EDrgula'),
'    el.value = el.value.replace(/[^0-9:]/g, '''');',
'  });',
'});'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'PAULO.MARCONATO'
,p_last_upd_yyyymmddhh24miss=>'20260910143013'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(29868527978306113674)
,p_plug_name=>'Parte do Corpo Atingida'
,p_region_name=>'PARTE'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>'Informar a Parte do Corpo Atingida no acidente/incidente.'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(29872839526896898332)
,p_plug_name=>'Parte do Corpo Atingida'
,p_region_name=>'PARTE_LESADA'
,p_parent_plug_id=>wwv_flow_api.id(29868527978306113674)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647209075585344884)
,p_plug_display_sequence=>162
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT rowid AS row_id_banco,',
'       cod_empresa,',
'       matricula,',
'       dc_matricula,',
'       cod_parte_lesada,',
'       descricao_parte_lesada,',
'       lateralidade,',
'       cod_natureza_lesao,',
'       cod_analise_acidente,',
'       USUARIO,',
'       DT_ATUALIZACAO',
'  FROM analise_func_parte_lesada',
' WHERE cod_analise_acidente = :P31_COD_ANALISE_ACIDENTE',
'   and MATRICULA = :P31_MATRICULA',
'   and COD_EMPRESA = :P31_COD_EMPRESA'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P31_COD_ANALISE_ACIDENTE,P31_MATRICULA,P31_COD_EMPRESA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872839698773898334)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872839797082898335)
,p_name=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ANALISE_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_ANALISE_ACIDENTE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872839926086898336)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840048510898337)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'nvl(:P31_DC_MATRICULA,0)'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840090502898338)
,p_name=>'COD_PARTE_LESADA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PARTE_LESADA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('C\00F3d. Parte Lesada')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>10
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ds_parte_lesada||'' (''||cod_parte_lesada||'')'' d, cod_parte_lesada',
'  from parte_lesada',
' order by 1'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840449390898341)
,p_name=>'DESCRICAO_PARTE_LESADA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCRICAO_PARTE_LESADA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>unistr('Descri\00E7\00E3o Parte Lesada')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>500
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840581638898342)
,p_name=>'LATERALIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LATERALIDADE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Lateralidade'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>unistr('STATIC2:N\00E3o Aplic\00E1vel - 0;0,Esquerda - 1;1,Direita - 2;2,Ambas - 3;3')
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840652386898343)
,p_name=>'COD_NATUREZA_LESAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_NATUREZA_LESAO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840776325898344)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872840813838898345)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872841017511898347)
,p_name=>'ROW_ID_BANCO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROW_ID_BANCO'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872841197525898349)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>120
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_USUARIO'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(29872841310483898350)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_DT_ATUALIZACAO'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(29872839651577898333)
,p_internal_uid=>1403193864695873509
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(120992487352705511168)
,p_update_authorization_scheme=>wwv_flow_api.id(120992487859162511168)
,p_delete_authorization_scheme=>wwv_flow_api.id(120992487626810511168)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(29872844778730917834)
,p_interactive_grid_id=>wwv_flow_api.id(29872839651577898333)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(29872844845613917835)
,p_report_id=>wwv_flow_api.id(29872844778730917834)
,p_view_type=>'GRID'
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872845338230917835)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(29872839698773898334)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872845801332917836)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(29872839797082898335)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872846310504917837)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(29872839926086898336)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872846870477917838)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(29872840048510898337)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872847345805917840)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(29872840090502898338)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872847805119917840)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(29872840449390898341)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872848351628917841)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(29872840581638898342)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872848821746917842)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(29872840652386898343)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872849302650917843)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(29872840776325898344)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872850199614917845)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(29872841017511898347)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872985538324008229)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(29872841197525898349)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(29872986019417008230)
,p_view_id=>wwv_flow_api.id(29872844845613917835)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(29872841310483898350)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070466783867778)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>wwv_flow_api.id(137647201601304344873)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_08'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070585256867779)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>22
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_plug_read_only_when=>'P31_NUM_PROTOCOLO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'ALTERADO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070778783867781)
,p_plug_name=>unistr('Servi\00E7o / Provid\00EAncia')
,p_region_name=>'SERVICO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>52
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070891240867782)
,p_plug_name=>unistr('Descri\00E7\00E3o do Acidente')
,p_region_name=>'ACIDENTE'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>32
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070992557867783)
,p_plug_name=>unistr('Consequ\00EAncia')
,p_region_name=>'CONSEQUENCIA'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>62
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126070998776867784)
,p_plug_name=>'Testemunha'
,p_region_name=>'TESTEMUNHA'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>72
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125128207747267328575)
,p_plug_name=>'IR - Testemunha'
,p_parent_plug_id=>wwv_flow_api.id(125126070998776867784)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647209075585344884)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a."ROWID",',
'       a.num_analise_acidente_testemun,',
'       a.cod_empresa||'' - ''||initcap(fnct_nome_empresa(a.cod_empresa, ''S'')) cod_empresa,',
'       case when a.matricula is not null then a.matricula||'' - ''||initcap(fnct_nome_func(a.cod_empresa, a.matricula)) ',
'            when a.matricula is null then a.nome end testemunha,',
'       a.endereco,',
'       a.numero,',
'       a.complem,',
'       a.bairro,',
'       lpad(a.cep,5,0)||''-''||lpad(a.complemento_cep,3,0) cep,',
'       a.cidade,',
'       a.uf,',
'       ''(''||a.ddd||'') ''||a.telefone telefone,',
'       a.depoimento_testemunha',
'  from ANALISE_ACIDENTE_TESTEMUNHA a',
' where a.cod_empresa = :p31_cod_empresa',
'   and a.cod_analise_acidente = :p31_cod_analise_acidente',
' order by a.num_analise_acidente_testemun'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P31_COD_EMPRESA,P31_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
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
 p_id=>wwv_flow_api.id(125128207841423328576)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_ROWID:#ROWID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_detail_link_condition_type=>'NOT_EXISTS'
,p_detail_link_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from ANALISE_ACIDENTE_TESTEMUNHA a',
' where a.cod_empresa = :p31_cod_empresa',
'   and a.cod_analise_acidente = :p31_cod_analise_acidente;'))
,p_owner=>'IGOR'
,p_internal_uid=>656797243996715941
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128207929629328577)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128208002475328578)
,p_db_column_name=>'NUM_ANALISE_ACIDENTE_TESTEMUN'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Ordem'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128319468813846541)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128319643598846543)
,p_db_column_name=>'TESTEMUNHA'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Testemunha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128208406356328582)
,p_db_column_name=>'ENDERECO'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128208542150328583)
,p_db_column_name=>'NUMERO'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>unistr('N\00BA')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128208656071328584)
,p_db_column_name=>'COMPLEM'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128208704442328585)
,p_db_column_name=>'BAIRRO'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128318970605846536)
,p_db_column_name=>'CEP'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'CEP'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128318999817846537)
,p_db_column_name=>'CIDADE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128319112492846538)
,p_db_column_name=>'UF'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128319284099846539)
,p_db_column_name=>'TELEFONE'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Telefone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128319318047846540)
,p_db_column_name=>'DEPOIMENTO_TESTEMUNHA'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Depoimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(125128353638072879167)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6569431'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TESTEMUNHA:CEP:ENDERECO:NUMERO:COMPLEM:BAIRRO:CIDADE:UF:TELEFONE:DEPOIMENTO_TESTEMUNHA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126071179858867785)
,p_plug_name=>'Terceiros'
,p_region_name=>'TERCEIROS'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>82
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125128321716451846564)
,p_plug_name=>'IR - Terceiros'
,p_parent_plug_id=>wwv_flow_api.id(125126071179858867785)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647209075585344884)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a."ROWID",',
'       a.cod_empresa||'' - ''||initcap(fnct_nome_empresa(a.cod_empresa, ''S'')) cod_empresa,',
'       a.nome testemunha,',
'       a.endereco,',
'       a.numero,',
'       a.complemento,',
'       a.bairro,',
'       lpad(a.cep,5,0)||''-''||lpad(a.complemento_cep,3,0) cep,',
'       a.cidade,',
'       a.uf,',
'       ''(''||a.ddd||'') ''||a.telefone telefone,',
'       a.depoimento_testemunha',
'  from ACID_TESTEMUNHA_EXTERNA a',
' where a.cod_empresa = :p31_cod_empresa',
'   and a.cod_analise_acidente = :p31_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P31_COD_EMPRESA,P31_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
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
,p_plug_header=>unistr('Informar testemunhas que n\00E3o fa\00E7am parte da empresa.')
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(125128321953296846566)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:RP,34:P34_ROWID:#ROWID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>656911355870233931
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322088013846567)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322225602846569)
,p_db_column_name=>'ENDERECO'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322346716846570)
,p_db_column_name=>'NUMERO'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>unistr('N\00BA')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322536733846572)
,p_db_column_name=>'BAIRRO'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322677671846573)
,p_db_column_name=>'CEP'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'CEP'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322776419846574)
,p_db_column_name=>'CIDADE'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322854841846575)
,p_db_column_name=>'UF'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128322910301846576)
,p_db_column_name=>'TELEFONE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Telefone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128323043917846577)
,p_db_column_name=>'DEPOIMENTO_TESTEMUNHA'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Depoimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128323150442846578)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128323291507846579)
,p_db_column_name=>'TESTEMUNHA'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Testemunha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(125128323373129846580)
,p_db_column_name=>'COMPLEMENTO'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(125128475346575289282)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6570648'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TESTEMUNHA:CEP:ENDERECO:NUMERO:COMPLEMENTO:BAIRRO:CIDADE:UF:TELEFONE:DEPOIMENTO_TESTEMUNHA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125126959152577840835)
,p_plug_name=>unistr('Comunica\00E7\00E3o Acidente')
,p_region_name=>'ANALISE'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>12
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036101203876241)
,p_plug_name=>'Dados do Acidente'
,p_parent_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'PLSQL_EXPRESSION'
,p_plug_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'ALTERADO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036257169876242)
,p_plug_name=>'Local do Acidente'
,p_region_name=>'LOCAL'
,p_parent_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'ALTERADO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036309215876243)
,p_plug_name=>unistr('Atendimento M\00E9dico')
,p_region_name=>'ATENDIMENTO'
,p_parent_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'PLSQL_EXPRESSION'
,p_plug_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>'ALTERADO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036468219876244)
,p_plug_name=>'Avaliador'
,p_region_name=>'AVALIADOR'
,p_parent_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P31_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036681663876246)
,p_plug_name=>unistr('T\00E9cnico')
,p_parent_plug_id=>wwv_flow_api.id(125127036468219876244)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036708312876247)
,p_plug_name=>'Engenheiro'
,p_parent_plug_id=>wwv_flow_api.id(125127036468219876244)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127027467104840958)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--compactTitle:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647212887289344888)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(127440232984304353985)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(137647230883221344931)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127035636804876236)
,p_plug_name=>'EPIs'
,p_region_name=>'EPI'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>92
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>'Informar os EPIs que o colaborador utilizava no momento do acidente/incidente.'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125128205276121328550)
,p_plug_name=>'IG - EPIs'
,p_parent_plug_id=>wwv_flow_api.id(125127035636804876236)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647209075585344884)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa,',
'       cod_analise_acidente,',
'       cod_equip,',
'       usuario,',
'       dt_atualizacao',
'  from ANALISE_ACID_EQUIP_PROT_INDIV',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P31_COD_EMPRESA,P31_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205488655328552)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205519858328553)
,p_name=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ANALISE_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_ANALISE_ACIDENTE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205634305328554)
,p_name=>'COD_EQUIP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EQUIP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'EPI'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_equip||'' - ''||descricao d, cod_equip',
'  from equip_prot_indiv',
' order by descricao'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205709997328555)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':p_usuario'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205802471328556)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128205956860328557)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206082523328558)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206160390328559)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(125128205312979328551)
,p_internal_uid=>656794715552715916
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(120992487352705511168)
,p_update_authorization_scheme=>wwv_flow_api.id(120992487859162511168)
,p_delete_authorization_scheme=>wwv_flow_api.id(120992487626810511168)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(125128269602118570395)
,p_interactive_grid_id=>wwv_flow_api.id(125128205312979328551)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(125128269792179570398)
,p_report_id=>wwv_flow_api.id(125128269602118570395)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128270407931570412)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(125128205488655328552)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128270960931570421)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(125128205519858328553)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128271456510570424)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(125128205634305328554)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>1149
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128271899812570427)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(125128205709997328555)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128272482901570429)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(125128205802471328556)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128279239988599677)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(125128205956860328557)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128279724227599680)
,p_view_id=>wwv_flow_api.id(125128269792179570398)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(125128206082523328558)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127035752729876237)
,p_plug_name=>'Custo'
,p_region_name=>'CUSTO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>112
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>unistr('Indicar se houve custo para empresa em fun\00E7\00E3o do acidente.')
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125128206406133328562)
,p_plug_name=>'IG - Custo'
,p_parent_plug_id=>wwv_flow_api.id(125127035752729876237)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647209075585344884)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa, ',
'       cod_analise_acidente,',
'       cod_custo_acidente,',
'       descricao_custo,',
'       valor_custo_acidente,',
'       usuario,',
'       dt_atualizacao',
'  from CUSTO_ACIDENTE',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206682963328564)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206793438328565)
,p_name=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ANALISE_ACIDENTE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_COD_ANALISE_ACIDENTE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206812277328566)
,p_name=>'COD_CUSTO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_CUSTO_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P31_NUM_ANAL'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128206936864328567)
,p_name=>'DESCRICAO_CUSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCRICAO_CUSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Descri\00E7\00E3o')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_width=>40
,p_is_required=>true
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207056961328568)
,p_name=>'VALOR_CUSTO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VALOR_CUSTO_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Valor'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207152034328569)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>90
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':p_usuario'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207270887328570)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207365848328571)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207468504328572)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(125128207541337328573)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(125128206531196328563)
,p_internal_uid=>656795933769715928
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(120992487352705511168)
,p_update_authorization_scheme=>wwv_flow_api.id(120992487859162511168)
,p_delete_authorization_scheme=>wwv_flow_api.id(120992487626810511168)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(125128290579468656500)
,p_interactive_grid_id=>wwv_flow_api.id(125128206531196328563)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(125128290628711656500)
,p_report_id=>wwv_flow_api.id(125128290579468656500)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128291192320656502)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(125128206682963328564)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128291629040656505)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(125128206793438328565)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128292159440656507)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(125128206812277328566)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128292625919656509)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(125128206936864328567)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>637
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128293180577656511)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(125128207056961328568)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>222
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128293618182656513)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(125128207152034328569)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128294184216656515)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(125128207270887328570)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128294605284656517)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(125128207365848328571)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(125128295115112656519)
,p_view_id=>wwv_flow_api.id(125128290628711656500)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(125128207468504328572)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127035889066876238)
,p_plug_name=>unistr('Plano e A\00E7\00E3o')
,p_region_name=>'PLANO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>122
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127035926703876239)
,p_plug_name=>'Diagrama de Causa/Efeito (6Ms)'
,p_region_name=>'DIAGRAMA'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>132
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036052846876240)
,p_plug_name=>unistr('Conclus\00E3o')
,p_region_name=>'CONCLUSAO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>142
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>unistr('Informar a conclus\00E3o da an\00E1lise do acidente/incidente.')
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(125127036567985876245)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125129337066725488953)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_button_name=>'btn_add_medico'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cadastro de M\00E9dico')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:39:&SESSION.::&DEBUG.:RP,39::'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_api.id(120992487859162511168)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125126959879720840839)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(125126070466783867778)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:30:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(17086524662071229679)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125126070891240867782)
,p_button_name=>'ARQUIVOS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Arquivos/Fotos'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:RP,36:P36_COD_EMPRESA,P36_MATRICULA,P36_COD_ANALISE_ACIDENTE,P36_DT_ACIDENTE:&P31_COD_EMPRESA.,&P31_MATRICULA.,&P31_COD_ANALISE_ACIDENTE.,&P31_DT_ACIDENTE.'
,p_button_condition=>'P31_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125126959660278840839)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125126070466783867778)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P31_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_security_scheme=>wwv_flow_api.id(120992487859162511168)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125126959536692840839)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(125126070466783867778)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P31_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_security_scheme=>wwv_flow_api.id(120992487352705511168)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125126959719630840839)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(125126070466783867778)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P31_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_security_scheme=>wwv_flow_api.id(120992487626810511168)
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125128787121868457739)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_button_name=>'RELATORIO_CAT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Relat\00F3rio CAT')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125128787684342457744)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_button_name=>'REL_INVESTIGACAO_ACIDENTE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Investiga\00E7\00E3o de Acidente')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125128319768209846544)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125128207747267328575)
,p_button_name=>'ADD_TESTEMUNHA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_COD_EMPRESA,P33_COD_ANALISE_ACIDENTE,P33_NUM_ANALISE_ACIDENTE_TESTE:&P31_COD_EMPRESA.,&P31_COD_ANALISE_ACIDENTE.,&P31_NUM_ANAL.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from ANALISE_ACIDENTE_TESTEMUNHA a',
' where a.cod_empresa = :p31_cod_empresa',
'   and a.cod_analise_acidente = :p31_cod_analise_acidente;'))
,p_button_condition_type=>'NOT_EXISTS'
,p_security_scheme=>wwv_flow_api.id(120992487859162511168)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(125128321842610846565)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(125128321716451846564)
,p_button_name=>'ADD_TERCEIRO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:RP,34:P34_COD_EMPRESA,P34_COD_ANALISE_ACIDENTE:&P31_COD_EMPRESA.,&P31_COD_ANALISE_ACIDENTE.'
,p_security_scheme=>wwv_flow_api.id(120992487859162511168)
);
end;
/
begin
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(125126961423028840843)
,p_branch_action=>'f?p=&APP_ID.:30:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9727983514622195120)
,p_name=>'P31_COD_MED_EMIT_CAT_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('M\00E9dico')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NOME||'' - ''||SIGLA||'' ''||NR_DOCUMENTO D, COD||''/''||NR_DOCUMENTO C',
'FROM   VW_MEDICOS',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29870677484598526754)
,p_name=>'P31_COD_EMPRESA_DSP_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(29868527978306113674)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29870677494714526755)
,p_name=>'P31_MATRICULA_DSP_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(29868527978306113674)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29872842424894898361)
,p_name=>'P31_HAS_ROWS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(29872839526896898332)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52235437143996305339)
,p_name=>'P31_TIPO_ACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_prompt=>unistr('Tipo de A\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Adapta\00E7\00E3o;A,Orienta\00E7\00E3o;O')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54661833425310835607)
,p_name=>'P31_CEP_DSP'
,p_item_sequence=>105
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_prompt=>'CEP'
,p_source=>'regexp_replace(LPAD(lpad(:P31_CEP_LOCAL,5,0)||lpad(:P31_COMPLEMENTO_CEP_LOC,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'')'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(59429827126588523994)
,p_name=>'P31_COD_SISAN'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Registro SINAN'
,p_source=>'COD_SISAN'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(59429827210053523995)
,p_name=>'P31_DT_CONCLUSAO_SISAN'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Conclus\00E3o SINAN')
,p_source=>'DT_CONCLUSAO_SISAN'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(83928543530348129946)
,p_name=>'P31_HORA_ATEND_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora de Atendimento'
,p_source=>'P31_HORA_ATEND'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(86494071657649379435)
,p_name=>'P31_HORAS_TRAB'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_item_default=>'00:00'
,p_prompt=>'Qtd. Horas Trabalhadas'
,p_source=>'HORAS_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>5
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(86518290400480424494)
,p_name=>'P31_HORA_ATEND'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora de Atendimento'
,p_source=>'HORA_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>5
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(91208652480915749975)
,p_name=>'P31_EMPRESA_NEW'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(121237734689582671845)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97985302747452156218)
,p_name=>'P31_ARQ_BO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Documento B.O.'
,p_source=>'ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'MIMETYPE_ARQ_BO'
,p_attribute_03=>'NOME_ARQ_BO'
,p_attribute_04=>'CHARSET_ARQ_BO'
,p_attribute_06=>'Y'
,p_attribute_07=>'Fazer Download'
,p_attribute_08=>'attachment'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97985302823247156219)
,p_name=>'P31_NOME_ARQ_BO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97985302977136156220)
,p_name=>'P31_MIMETYPE_ARQ_BO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_source=>'MIMETYPE_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97985303027598156221)
,p_name=>'P31_CHARSET_ARQ_BO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_item_default=>'UTF-8'
,p_source=>'CHARSET_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98012355522957883632)
,p_name=>'P31_TIPO_ACIDENTE_AUX'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(98016990601475844793)
,p_name=>'P31_IND_TRAJETO_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_source=>'P31_IND_TRAJETO'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121064820574623206332)
,p_name=>'P31_ORIGEM_MED_CAT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_source=>'ORIGEM_MED_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348093689508727406)
,p_name=>'P31_IND_DEPTO_POLICIAL'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_prompt=>'D.P.:'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348093817087727407)
,p_name=>'P31_DATA_BOLETIM_OCORR'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_prompt=>'Data:'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348093883106727408)
,p_name=>'P31_NUM_BOLETIM_OCORR'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_prompt=>'B.O.:'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348095618922727425)
,p_name=>'P31_ARQ'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Documento'
,p_source=>'ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'MIMETYPE_ARQ'
,p_attribute_03=>'NOME_ARQ'
,p_attribute_04=>'CHARSET_ARQ'
,p_attribute_06=>'Y'
,p_attribute_07=>'Fazer Download'
,p_attribute_08=>'attachment'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348095693216727426)
,p_name=>'P31_NOME_ARQ'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348095762183727427)
,p_name=>'P31_MIMETYPE_ARQ'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_source=>'MIMETYPE_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121348095885253727428)
,p_name=>'P31_CHARSET_ARQ'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_item_default=>'UTF-8'
,p_source=>'CHARSET_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126961819954840848)
,p_name=>'P31_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126962279966840852)
,p_name=>'P31_COD_EMPRESA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas_cad ',
' WHERE ((F_Acesso_Emp_PG_APEX(cod, :P_USUARIO) = ''S'' and :p31_rowid is null) or ',
'         (:p31_rowid is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID'
,p_ajax_items_to_submit=>'P31_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126962674235840853)
,p_name=>'P31_COD_ANALISE_ACIDENTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo')
,p_source=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P31_COD_ANALISE_ACIDENTE'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126963010348840854)
,p_name=>'P31_DT_ACIDENTE'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data do Acidente'
,p_source=>'DT_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126963410147840855)
,p_name=>'P31_DT_ANALISE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ANALISE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126963835455840855)
,p_name=>'P31_HOR_ACIDENTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora do Acidente'
,p_format_mask=>'HH24:MI'
,p_source=>'HOR_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126964249394840855)
,p_name=>'P31_COD_LOCAL_TRAB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local de Trabalho'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('SELECT l.cod_local_trab||'' - ''||initcap(l.descricao)||'' - Pr\00E9dio: ''||l.predio||'' - Bloco: ''||l.bloco||'' - Andar: ''||l.andar||'' - Sala: ''||l.sala descricao, l.cod_local_trab'),
'FROM LOCAL_TRAB L, ',
'     FILIAL_LOCAL F',
'WHERE L.COD_LOCAL_TRAB = F.COD_LOCAL_FILIAL',
' AND F.COD_EMPRESA    = :p31_COD_EMP_ACIDENTE',
' AND F.COD_FILIAL     = :p31_cod_FIL_ACIDENTE',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_COD_EMP_ACIDENTE,P31_COD_FIL_ACIDENTE'
,p_ajax_items_to_submit=>'P31_COD_EMP_ACIDENTE,P31_COD_FIL_ACIDENTE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126964643418840856)
,p_name=>'P31_DS_LOCAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_source=>'DS_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126965022597840856)
,p_name=>'P31_COD_EMPRESA_TEC_SEGURANCA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125127036681663876246)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126965443203840859)
,p_name=>'P31_MATRICULA_TEC_SEGURANCA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(125127036681663876246)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, to_char(p.matricula) codigo',
'from inf_pessoais p,informacoes_funcionais f, prestador_servico s',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.matricula   = s.cod_prest_serv',
'  and s.tipo_prest_serv = 3',
'  and p.cod_empresa = :P31_COD_EMPRESA_TEC_SEGURANCA',
'  and ((:p31_rowid is not null ) or (:p31_rowid is null and f.situacao < ''90''))',
'union',
'select s.cod_prest_serv||'' - ''||initcap(s.nome) descricao, s.cod_prest_serv codigo',
'  from prestador_servico s',
' where s.tipo_prest_serv = 3',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_COD_EMPRESA_TEC_SEGURANCA,P31_ROWID'
,p_ajax_items_to_submit=>'P31_COD_EMPRESA_TEC_SEGURANCA,P31_ROWID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>32
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126965897321840860)
,p_name=>'P31_DC_MATRICULA_TEC_SEGURANCA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(125127036681663876246)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126966216949840861)
,p_name=>'P31_COD_EMPRESA_ENG_SEGURANCA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(125127036708312876247)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126966659651840861)
,p_name=>'P31_MATRICULA_ENG_SEGURANCA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(125127036708312876247)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, to_char(p.matricula) codigo',
'from inf_pessoais p,informacoes_funcionais f, prestador_servico s',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.matricula   = s.cod_prest_serv',
'  and s.tipo_prest_serv = 3',
'  and p.cod_empresa = :P31_COD_EMPRESA_ENG_SEGURANCA',
'  and ((:p31_rowid is not null ) or (:p31_rowid is null and f.situacao < ''90''))',
'union',
'select s.cod_prest_serv||'' - ''||initcap(s.nome) descricao, s.cod_prest_serv codigo',
'  from prestador_servico s',
' where s.tipo_prest_serv = 3',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID,P31_COD_EMPRESA_ENG_SEGURANCA'
,p_ajax_items_to_submit=>'P31_ROWID,P31_COD_EMPRESA_ENG_SEGURANCA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126967091404840862)
,p_name=>'P31_DC_MATRICULA_ENG_SEGURANCA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(125127036708312876247)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126967483907840862)
,p_name=>'P31_COD_ACIDENTE_TIPO'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_item_default=>'4'
,p_prompt=>'Tipo Acidente'
,p_source=>'COD_ACIDENTE_TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_acidente_tipo ||'' - ''||initcap(descricao) d, cod_acidente_tipo',
'  from acidente_tipo',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126967829711840862)
,p_name=>'P31_USUARIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126968275494840862)
,p_name=>'P31_DT_ATUALIZACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126968647177840863)
,p_name=>'P31_IND_TRAJETO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VIND_TRAJETO ANALISE_ACIDENTE.IND_TRAJETO%TYPE;',
'BEGIN',
'  SELECT IND_TRAJETO INTO VIND_TRAJETO FROM ANALISE_ACIDENTE WHERE COD_ANALISE_ACIDENTE = :P31_COD_ANALISE_ACIDENTE;',
'  RETURN(VIND_TRAJETO);',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    RETURN(NULL);',
'END;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>'Trajeto'
,p_source=>'IND_TRAJETO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:Sim;S,',
unistr('N\00E3o;N')))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-Selecione-'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126969024684840863)
,p_name=>'P31_MATRICULA_ANALIZADOR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_use_cache_before_default=>'NO'
,p_source=>'MATRICULA_ANALIZADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126969486152840864)
,p_name=>'P31_ESPEC_LOCAL_ACIDENTE'
,p_is_required=>true
,p_item_sequence=>245
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Especifica\00E7\00E3o do Local do Acidente')
,p_source=>'ESPEC_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>200
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126969889848840865)
,p_name=>'P31_LOCAL_ACIDENTE'
,p_item_sequence=>185
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Munic\00EDpio')
,p_source=>'LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126970249536840865)
,p_name=>'P31_UF_LOCAL_ACIDENTE'
,p_item_sequence=>205
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'UF'
,p_source=>'UF_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT SIGLA d, sigla c FROM UF ORDER BY NOME'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126970653991840865)
,p_name=>'P31_DT_EMISSAO_CAT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Registro Prev.'
,p_source=>'DT_EMISSAO_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126971061792840866)
,p_name=>'P31_NUM_PROTOCOLO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero da CAT')
,p_source=>'NUM_PROTOCOLO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126971494904840867)
,p_name=>'P31_CIPEIRO_AREA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(125127036468219876244)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Cipeiro \00C1rea')
,p_source=>'CIPEIRO_AREA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126972241601840867)
,p_name=>'P31_SERV_MED_ATEND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Unidade M\00E9dica de Atendimento')
,p_placeholder=>unistr('Ex.: Hospital das Cl\00EDnicas')
,p_source=>'SERV_MED_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
,p_item_comment=>'ALTERADO'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126972606644840867)
,p_name=>'P31_DT_ATEND'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Atendimento'
,p_source=>'DT_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126973434652840868)
,p_name=>'P31_OBSERVACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o M\00E9dica')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126973842812840868)
,p_name=>'P31_CNPJ_LOCAL_ACIDENTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CNPJ'
,p_placeholder=>unistr('CNPJ Apenas num\00E9ricos')
,p_source=>'CNPJ_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>5
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126974291768840868)
,p_name=>'P31_STATUS_CAT'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_item_default=>'P'
,p_prompt=>unistr('Status Investiga\00E7\00E3o')
,p_source=>'STATUS_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Pendente;P,Conclu\00EDdo;C,Cancelado;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_read_only_when=>':P31_ROWID IS NOT NULL'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'READ ONLY ANTERIOR -- :P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126974623048840869)
,p_name=>'P31_DT_ULT_DIA_TRAB'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('\00DAltimo Dia Trabalhado')
,p_source=>'DT_ULT_DIA_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126975001315840869)
,p_name=>'P31_QTDE_DIAS_TRATAMENTO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Dura\00E7\00E3o Prov\00E1vel de Tratamento (Dias)')
,p_source=>'QTDE_DIAS_TRATAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>3
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126975428833840869)
,p_name=>'P31_AFASTAMENTO_IMEDIATO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Afastamento Imediato'
,p_source=>'AFASTAMENTO_IMEDIATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126975851320840869)
,p_name=>'P31_COD_ANALISE_2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ANALISE_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126976291460840870)
,p_name=>'P31_MATRICULA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, p.matricula',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p31_cod_empresa',
'  --and ((:p31_rowid is not null ) or (:p31_rowid is null and f.situacao < ''90''))  // Comentado 22/07/2025 - Chamado 39479 - Guilherme/Camila.',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID,P31_COD_EMPRESA'
,p_ajax_items_to_submit=>'P31_ROWID,P31_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126976644523840870)
,p_name=>'P31_TIPO_LOCAL_ACIDENTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Local'
,p_source=>'TIPO_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:',
'1 - Estabelecimento do empregador no Brasil;1,',
'2 - Estabelecimento do empregador no exterior;2,',
unistr('3 - Estabelecimento de terceiros onde o empregador presta servi\00E7os;3,'),
unistr('4 - Via P\00FAblica;4,'),
unistr('5 - \00C1rea Rural;5,'),
unistr('6 - Embarca\00E7\00E3o;6,'),
'9 - Outros;9'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>7
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126977077807840870)
,p_name=>'P31_NUM_LOCAL_ACIDENTE'
,p_item_sequence=>155
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero')
,p_source=>'NUM_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126977412515840870)
,p_name=>'P31_COD_CNES'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CNES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126977887772840871)
,p_name=>'P31_TP_REGISTRO_CAT'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'Iniciativa'
,p_source=>'TP_REGISTRO_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:1 - Iniciativa do Empregador;1,2 - Ordem Judicial;2,3 - Determina\00E7\00E3o de \00D3rg\00E3o Fiscalizador;3')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126978208593840871)
,p_name=>'P31_COD_MED_EMIT_CAT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MED_EMIT_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126978656396840871)
,p_name=>'P31_CEP_LOCAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_source=>'CEP_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126979067245840871)
,p_name=>'P31_COMPLEMENTO_CEP_LOC'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_source=>'COMPLEMENTO_CEP_LOC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126979465996840872)
,p_name=>'P31_BAIRRO_ACIDENTE'
,p_item_sequence=>175
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bairro'
,p_source=>'BAIRRO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126979853554840872)
,p_name=>'P31_CIDADE_ACIDENTE'
,p_item_sequence=>195
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_source=>'CIDADE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126980274487840872)
,p_name=>'P31_COD_ACIDENTE_TIPO_ES'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ACIDENTE_TIPO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126980600044840872)
,p_name=>'P31_ENDERECO_ACIDENTE'
,p_item_sequence=>145
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Endere\00E7o')
,p_source=>'ENDERECO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126981084376840873)
,p_name=>'P31_COD_MUN_IBGE'
,p_item_sequence=>215
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MUN_IBGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126981429018840873)
,p_name=>'P31_PAIS_ACIDENTE'
,p_item_sequence=>225
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.codigo CODIGO , e.descricao DESCRICAO',
'  from paises_es e ',
'  WHERE CODIGO = 105'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('Pa\00EDs')
,p_source=>'PAIS_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.descricao DESCRICAO, TO_CHAR(e.codigo) CODIGO',
'  from paises_es e ',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126981879604840873)
,p_name=>'P31_COD_TP_LOGR'
,p_item_sequence=>125
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Logradouro'
,p_source=>'COD_TP_LOGR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(a.nome_logr) d, a.cod_tp_logr',
'  from tipo_logradouro a',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-- Selecione --'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126982244041840875)
,p_name=>'P31_COMPLEMENTO'
,p_item_sequence=>165
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Complemento'
,p_source=>'COMPLEMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126982604464840875)
,p_name=>'P31_CX_POSTAL'
,p_item_sequence=>235
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Caixa Postal'
,p_source=>'CX_POSTAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>12
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126983036324840875)
,p_name=>'P31_TP_LOGR_CODIGO_ES'
,p_item_sequence=>135
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CODIGO_ES FROM TIPO_LOGRADOURO',
'WHERE COD_TP_LOGR= :P31_COD_TP_LOGR;'))
,p_item_default_type=>'SQL_QUERY'
,p_source=>'TP_LOGR_CODIGO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126983415483840876)
,p_name=>'P31_COD_EMP_ACIDENTE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa (Local)'
,p_source=>'COD_EMP_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125126983876517840876)
,p_name=>'P31_COD_FIL_ACIDENTE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125127036257169876242)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial (Local)'
,p_source=>'COD_FIL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(sigla) descricao, cod_filial',
'  from filiais ',
'where cod_empresa = :p31_cod_emp_acidente',
'AND (((encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')) AND :p31_rowid IS NULL) or (:p31_rowid IS not NULL))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID,P31_COD_EMP_ACIDENTE'
,p_ajax_items_to_submit=>'P31_ROWID,P31_COD_EMP_ACIDENTE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127037694104876256)
,p_name=>'P31_NUM_ANALISE_ACIDENTE_SERVICO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125126070778783867781)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127037745569876257)
,p_name=>'P31_SERVICO_TEXTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125126070778783867781)
,p_prompt=>'Tarefa Executada'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('O que o acidentado executava no momento da ocorr\00EAncia.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127037829300876258)
,p_name=>'P31_TEXTO_PROV_MEDIATAS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125126070778783867781)
,p_prompt=>'Mediatas'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('A\00E7\00E3o realizada logo ap\00F3s a ocorr\00EAncia.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127037919303876259)
,p_name=>'P31_TEXTO_PROV_IMEDIATAS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125126070778783867781)
,p_prompt=>'Imediatas'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('A\00E7\00F5es corretivas ap\00F3s o acidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038045857876260)
,p_name=>'P31_DESCRICAO_TEXTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125126070891240867782)
,p_prompt=>'Detalhar conforme relato do Acidentado'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Detalhar conforme relato do acidentado.'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038319199876263)
,p_name=>'P31_NUM_ANALISE_ACIDENTE_DESCRICAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125126070891240867782)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038421834876264)
,p_name=>'P31_DESCRICAO_OBSERVACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125126070891240867782)
,p_prompt=>unistr('Cadastrar informa\00E7\00F5es complementares do Acidente')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Cadastrar informa\00E7\00F5es complementares do acidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038581855876265)
,p_name=>'P31_TEXTO_DADOS_PESSOAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125126070992557867783)
,p_prompt=>'Texto: Danos Pessoais'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Indicar se houve danos pessoais em fun\00E7\00E3o do acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038816358876268)
,p_name=>'P31_TEXTO_DADOS_MATERIAIS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125126070992557867783)
,p_prompt=>'Texto: Danos Materiais'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Indicar se houve danos na linha de produ\00E7\00E3o em fun\00E7\00E3o do acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127038924909876269)
,p_name=>'P31_TEXTO_DADOS_PRODUCAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125126070992557867783)
,p_prompt=>unistr('Texto: Danos Produ\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Indicar se houve danos materiais em fun\00E7\00E3o do acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039080323876270)
,p_name=>'P31_PLANO_TEXTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Descreva o plano de a\00E7\00E3o referente ao acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039191782876271)
,p_name=>'P31_PLANO_OQUE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_prompt=>unistr('O Qu\00EA')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Informar o qu\00EA ser\00E1 feito referente ao acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039241928876272)
,p_name=>'P31_PLANO_COMO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_prompt=>'Como'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Informar como ser\00E1 executado o plano de a\00E7\00E3o referente ao acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039361495876273)
,p_name=>'P31_PLANO_QUANDO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_prompt=>'Quando'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Informar quando ser\00E1 executado o plano de a\00E7\00E3o referente ao acidente/incidente.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039481455876274)
,p_name=>'P31_NUM_ANALISE_ACIDENTE_PROVIDEN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125127035889066876238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039504692876275)
,p_name=>'P31_ITEM_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>'Meio-Ambiente'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Analisar o ambiente interno e externo da empresa e identificar quais s\00E3o os fatores que favorecem a ocorr\00EAncia dos problemas.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039658707876276)
,p_name=>'P31_ITEM_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>unistr('M\00E1quina')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Considerar todas as causas originadas de falhas no maquin\00E1rio usado durante o processo, como funcionamento incorreto, falha mec\00E2nica e etc.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039736860876277)
,p_name=>'P31_ITEM_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>unistr('Mat\00E9ria Prima')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Mat\00E9ria-Prima ou material que foi utilizado no processo e n\00E3o est\00E1 em conformidade com as exig\00EAncias para a realiza\00E7\00E3o do trabalho, ou seja est\00E1 fora das especifica\00E7\00F5es necess\00E1rias para ser usado, como produto em tamanho incorreto, vencido, fora de t')
||'emperatura ideal e etc. '
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039826990876278)
,p_name=>'P31_ITEM_4'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>unistr('M\00E3o de Obra')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Podem envolver atitudes e dificuldades das pessoas na execu\00E7\00E3o do processo e podem incluir: pressa, imprud\00EAncia, falta de qualifica\00E7\00E3o, falta de compet\00EAncia e etc.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127039985017876279)
,p_name=>'P31_ITEM_5'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>unistr('M\00E9todo')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Procedimentos e m\00E9todos usados durante as atividades tamb\00E9m podem influenciar para que o problema ocorra, ou seja, devemos analisar o quanto a forma de trabalhar influenciou o problema.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127040065044876280)
,p_name=>'P31_ITEM_6'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>'Medida'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Causas que envolvem as m\00E9tricas que s\00E3o usadas para medir, monitorar e controlar o trabalho. ')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127040161868876281)
,p_name=>'P31_EFEITO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125127035926703876239)
,p_prompt=>'Efeito'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRICAO name, DESCRICAO id',
'FROM ATO_INSEGURO',
'ORDER BY DESCRICAO'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>600
,p_cMaxlength=>600
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127040203559876282)
,p_name=>'P31_NUM_ANALISE_ACIDENTE_CONCLUSAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(125127036052846876240)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125127040356692876283)
,p_name=>'P31_CONCLUSAO_TEXTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(125127036052846876240)
,p_prompt=>'Acompanhamento'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128502277630447438)
,p_name=>'P31_NUM_ANAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503160557447447)
,p_name=>'P31_COD_EMPRESA_DSP'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503271023447448)
,p_name=>'P31_MATRICULA_DSP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503673167447452)
,p_name=>'P31_COD_ANALISE_ACIDENTE_DSP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503780798447453)
,p_name=>'P31_TIPO_ANALISE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_item_default=>'1'
,p_prompt=>'Tipo CAT'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:',
'Inicial;1,',
'Reabertura;2,',
unistr('Com \00D3bito;3')))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503821171447454)
,p_name=>'P31_COD_CCUSTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128503919357447455)
,p_name=>'P31_VA_COD_DC'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504056119447456)
,p_name=>'P31_IND_OBITO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_item_default=>'N'
,p_prompt=>unistr('Indicativo de \00D3bito')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(126351644086180270657)||'.'
,p_cHeight=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504164791447457)
,p_name=>'P31_DT_OBITO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_prompt=>unistr('Data de \00D3bito')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504227549447458)
,p_name=>'P31_COD_FATOR_PESSOAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>'Fator Pessoal'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_fator_pessoal||'' - ''||descricao d, cod_fator_pessoal',
'  from fator_pessoal',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504395628447459)
,p_name=>'P31_IND_ACIDENTE_ANTERIOR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_item_default=>'N'
,p_prompt=>'Acidente Anterior'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(126351644086180270657)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504468538447460)
,p_name=>'P31_COD_ATO_INSEGURO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>'Ato Inseguro'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_ato_inseguro||'' - ''||initcap(descricao) d, cod_ato_inseguro',
'  from ato_inseguro',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504576490447461)
,p_name=>'P31_IND_EXPERIENCIA_OPERACAO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_item_default=>'N'
,p_prompt=>'Houve Registro Policial'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(126351644086180270657)||'.'
,p_cHeight=>1
,p_colspan=>3
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504612849447462)
,p_name=>'P31_COD_CONDICAO_INSEGURA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_prompt=>unistr('Condi\00E7\00E3o Insegura')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_condicao_insegura||'' - ''||initcap(descricao) d,cod_condicao_insegura c',
'  from condicao_insegura',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504764989447463)
,p_name=>'P31_COD_AGENTE_LESAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('Agente Les\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_agente_lesao||'' - ''||initcap(a.descricao) d, a.cod_agente_lesao',
'  from agente_lesao a',
' where ((:p31_rowid is null and a.ativo = ''S'') or ',
'        (:p31_rowid is not null))',
'   and ((:P31_COD_ACIDENTE_TIPO in (1,3) and TABELA_ES = 14)',
'    or (:P31_COD_ACIDENTE_TIPO in (2)))   ',
' order by a.descricao;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID,P31_COD_ACIDENTE_TIPO'
,p_ajax_items_to_submit=>'P31_ROWID,P31_COD_ACIDENTE_TIPO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504851580447464)
,p_name=>'P31_COD_FATOR_TRABALHO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('Situa\00E7\00E3o Geradora')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_FATOR_TRABALHO||'' - ''||initcap(f.descricao) d, f.cod_FATOR_TRABALHO',
'  from FATOR_TRABALHO f',
'  where ((:p31_rowid is null and f.ativo = ''S'') or ',
'         (:p31_rowid is not null))',
' order by f.descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P31_ROWID'
,p_ajax_items_to_submit=>'P31_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128504934987447465)
,p_name=>'P31_IND_PROT_TIPO_ACIDENTE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_item_default=>'N'
,p_prompt=>unistr('Interna\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(126351644086180270657)||'.'
,p_cHeight=>1
,p_colspan=>3
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505037045447466)
,p_name=>'P31_IND_AFASTAMENTO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_item_default=>'N'
,p_prompt=>'Afastamento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(126351644086180270657)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505153435447467)
,p_name=>'P31_QTD_DIAS_AFASTAMENTO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>'Qtde. Dias'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505237935447468)
,p_name=>'P31_DT_RETORNO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>'Data de Alta'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505375997447469)
,p_name=>'P31_CID'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>'CID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_DOENCA||'' - ''||UPPER(DESCRICAO) DESCRICAO, COD_DOENCA',
'  FROM DOENCA',
'ORDER BY descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505477055447470)
,p_name=>'P31_CODIGO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('Descri\00E7\00E3o da Les\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select codigo||'' - ''||descricao d, codigo',
'  from descricao_nat_lesao_es',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505592438447471)
,p_name=>'P31_MATRICULA_SUP_IMEDIATO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505671442447472)
,p_name=>'P31_DIAGNO_PROVAVEL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('Diagn\00F3stico Prov\00E1vel')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505740007447473)
,p_name=>'P31_DC_MATRICULA_SUP_IMEDIATO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128505850703447474)
,p_name=>'P31_OBSERVACAO_CAT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(125127036309215876243)
,p_prompt=>unistr('Observa\00E7\00E3o CAT')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128787228266457740)
,p_name=>'P31_COD_EMPRESA_SUP_IMEDIATO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(125126070585256867779)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125128787520543457743)
,p_name=>'P31_DC_MATRICULA'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125173240656476239971)
,p_name=>'P31_CLASS_ACIDENTE'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Classifica\00E7\00E3o Acidente')
,p_source=>'CLASS_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao||'' (''||codigo||'') '' d, codigo c',
'  from classificacao_acidente',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_cMaxlength=>5
,p_colspan=>6
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125292615453806041464)
,p_name=>'P31_COD_EMP_SOLICITANTE'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Solicitante'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) d, cod',
'  from empresas e',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125292615541323041465)
,p_name=>'P31_MAT_SOLICITANTE'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(125127036101203876241)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula Solicitante')
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(nome) d, matricula',
'  from inf_pessoais',
' where cod_empresa = :p31_cod_emp_solicitante',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P31_COD_EMP_SOLICITANTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>'ALTERADO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125292616071199041470)
,p_name=>'P31_AREA_SEGURANCA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(125292616138246041471)
,p_name=>'P31_AREA_MEDICA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(125126959152577840835)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(125283219582079179264)
,p_computation_sequence=>10
,p_computation_item=>'P31_COD_ANALISE_ACIDENTE'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nvl(max(cod_analise_acidente),0) + 1 cod',
'  from ANALISE_ACIDENTE',
' where cod_empresa = :p31_cod_empresa;',
'           ',
'v_c1 c1%rowtype;',
'           ',
'begin',
' ',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  return nvl(v_c1.cod,1); ',
'',
'end;'))
,p_compute_when=>'P31_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(125128206309224328561)
,p_tabular_form_region_id=>wwv_flow_api.id(125128205276121328550)
,p_validation_name=>'Valida COD_EQUIP'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_existe varchar2(1);',
'',
'begin',
'',
'  if :rowid is null then',
'',
'    begin',
'',
'    select ''S'' into v_existe',
'    from analise_acid_equip_prot_indiv',
'    where cod_equip = :cod_equip',
'      and cod_analise_acidente = :cod_analise_acidente;',
'',
unistr('    return ''EPI j\00E1 cadastrado!'';'),
'',
'    exception',
'    when no_data_found then',
'    return null;',
'',
'    end;',
'',
'  else',
'  return null;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'COD_EQUIP'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(125129336893193488951)
,p_validation_name=>'Valida CEP_LOCAL'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P31_COD_ACIDENTE_TIPO in (1,2,3) then',
'',
'  IF :P31_TIPO_LOCAL_ACIDENTE  IS NULL OR ',
'  :P31_TIPO_LOCAL_ACIDENTE IN (1,3) THEN',
'',
'          if :p31_cep_local is null then',
unistr('          return ''Campo CEP \00E9 Obrigat\00F3rio!'';'),
'          else',
'          return null;',
'          end if;',
'',
'  ELSIF     :P31_TIPO_LOCAL_ACIDENTE = 2 THEN',
'    return null;',
'          /*',
'          if :p31_cx_postal is null then',
unistr('          return ''Caixa Postal \00E9 Obrigat\00F3rio!'';'),
'          else',
'          return null;',
'          end if;',
'          */',
'  ELSE',
'          return null;',
'  END IF;',
'',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(125126978656396840871)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(125129336951192488952)
,p_validation_name=>'Valida CX_POSTAL'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P31_TIPO_LOCAL_ACIDENTE  IS NULL OR ',
':P31_TIPO_LOCAL_ACIDENTE IN (1,3) THEN',
'/*',
'        if :p31_cep_local is null then',
unistr('        return ''Campo CEP \00E9 Obrigat\00F3rio!'';'),
'        else',
'        return null;',
'        end if;',
'*/',
'return null;',
'ELSIF     :P31_TIPO_LOCAL_ACIDENTE = 2 THEN',
'',
'        ',
'        if :p31_cx_postal is null then',
unistr('        return ''Caixa Postal \00E9 Obrigat\00F3rio!'';'),
'        else',
'        return null;',
'        end if;',
'        ',
'ELSE',
'        return null;',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(125126982604464840875)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(125292615137766041461)
,p_validation_name=>'Valida COD_ACIDENTE_TIPO_ES'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p31_cod_acidente_tipo = 1 and :p31_cod_acidente_tipo_es is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Preencha o campo C\00F3d. Acidente eSocial.')
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(125126980274487840872)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(121064821058652206337)
,p_validation_name=>'Valida_Dt_Obito'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P31_TIPO_ANALISE,1) = 3 AND :P31_DT_OBITO IS NULL THEN',
unistr('  RETURN(''Para \00F3bito, \00E9 necess\00E1rio informar a data.'');'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(125128504164791447457)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(121348096437180727434)
,p_validation_name=>'IMPEDE CARACTERES ALPHA'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VTEXTO VARCHAR2(10) := :P31_QTDE_DIAS_TRATAMENTO;',
'BEGIN',
'  --',
'  IF VTEXTO IS NOT NULL THEN',
'  FOR X IN 1..LENGTH(VTEXTO) LOOP',
'    IF LTRIM(SUBSTR(VTEXTO,1,X)) IS NOT NULL AND LTRIM(SUBSTR(VTEXTO,1,X)) NOT IN (''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''0'') THEN',
unistr('      RETURN(''Este campo aceita somente caracteres num\00E9ricos!'');'),
'    END IF;',
'  END LOOP;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(125126975001315840869)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(98012355434828883631)
,p_validation_name=>'Valida Tipo Acidente'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_TIPO_ACIDENTE_AUX;',
'',
'    IF V_TIPO = 4 ',
'        AND :P31_CID IS NOT NULL    ',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O tipo de ocorr\00EAncia n\00E3o pode ser "4 - Cadastro de Ocorr\00EAncia" quando o campo CID estiver preenchido!')
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(125126959660278840839)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(97740366766832803756)
,p_validation_name=>unistr('Valida Classifica\00E7\00E3o Acidente')
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_TIPO_ACIDENTE_AUX;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_CLASS_ACIDENTE IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O Campo ''Classifica\00E7\00E3o de Acidente'' deve ser preenchido!')
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(125126959660278840839)
,p_associated_item=>wwv_flow_api.id(125173240656476239971)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(97740928475778270263)
,p_validation_name=>'Valida CID'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_TIPO_ACIDENTE_AUX;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_CID IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'O Campo ''CID'' deve ser preenchido!'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(125126959660278840839)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(92244501609289933530)
,p_validation_name=>unistr('Valida Les\00E3o')
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_CODIGO IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O Campo ''Descri\00E7\00E3o da Les\00E3o'' deve ser preenchido!')
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(125128505477055447470)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(92244501786901933532)
,p_validation_name=>'Valida Especificacao'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_ESPEC_LOCAL_ACIDENTE IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O Campo ''Especifica\00E7\00E3o'' deve ser preenchido!')
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(125126969486152840864)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(92244501658450933531)
,p_validation_name=>'Valida Agente'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_TIPO_ACIDENTE_AUX;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_COD_AGENTE_LESAO IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O Campo ''Agente Les\00E3o'' deve ser preenchido!')
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(125128504764989447463)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(94628828897547802241)
,p_validation_name=>'valida_agenda_lesao'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_existe varchar2(1);',
'',
'begin',
'',
'  if :p31_dt_acidente >= to_date(''22/01/2024'') and :p31_cod_acidente_tipo in (1,3) and :p31_cod_agente_lesao is not null then',
'  ',
'     select count(*)',
'     into v_existe',
'     from ag_causador_acid_trab_es',
'     where codigo = :p31_cod_agente_lesao;',
'     ',
'     if nvl(v_existe,0) = 0 then',
unistr('        return ''O c\00F3digo do agente les\00E3o tem que estar cadastrato na tabela 14!'';'),
'     else',
'        return null; ',
'     end if;',
'',
'  end if;',
'   ',
'  if :p31_dt_acidente < to_date(''22/01/2024'') and :p31_cod_acidente_tipo = 2 and :p31_cod_agente_lesao is not null then',
'  ',
'     select count(*)',
'     into v_existe',
'     from ag_causador_acid_trab_es',
'     where codigo = :p31_cod_agente_lesao;',
'     ',
'     if nvl(v_existe,0) = 0 then',
'        select count(*)',
'        into v_existe',
'        from ag_causador_doenca_prof_es',
'        where codigo = :p31_cod_agente_lesao;',
'     ',
'        if nvl(v_existe,0) = 0 then             ',
unistr('           return ''O c\00F3digo do agente les\00E3o tem que estar cadastrato na tabela 14 ou na tabela 15!'';'),
'        else',
'           return null; ',
'        end if;',
'     else',
'        return null; ',
'     end if;',
'     ',
'  end if;',
'  return null; ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(125128504764989447463)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(59429827538536523998)
,p_validation_name=>'Valida Medico'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_COD_MED_EMIT_CAT_1 IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('O Campo ''M\00E9dico'' deve ser preenchido!')
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(9727983514622195120)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(25658232849355663580)
,p_validation_name=>'Valida P31_DT_ATEND '
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_DT_ATEND IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Data de Atendimento deve ser preenchido!'
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(125126972606644840867)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(25658233046752663582)
,p_validation_name=>'Valida P31_OBSERVACAO'
,p_validation_sequence=>170
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_OBSERVACAO IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Observa\00E7\00E3o M\00E9dica deve ser preenchida!')
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(125126973434652840868)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(25663892595145528733)
,p_validation_name=>'Valida P31_ESPEC_LOCAL_ACIDENTE'
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_ESPEC_LOCAL_ACIDENTE IS NULL',
'            THEN ',
'            ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Especifica\00E7\00E3o do Local do Acidente deve ser preenchido!')
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(125126969486152840864)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(25658233011396663581)
,p_validation_name=>'Valida P31_HORA_ATEND'
,p_validation_sequence=>190
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'',
'V_TIPO VARCHAR2(30);',
'',
'BEGIN',
'V_TIPO := :P31_COD_ACIDENTE_TIPO;',
'',
'    IF V_TIPO <> 4 ',
'          AND :P31_HORA_ATEND IS NULL',
'            THEN ',
'            RETURN FALSE;',
'    ELSE',
'            RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Hora de Atendimento deve ser preenchida!'
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(86518290400480424494)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(41938657682187905882)
,p_validation_name=>'valida COD_ACIDENTE_TIPO'
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
unistr('if :P31_COD_ACIDENTE_TIPO <> 4 and :P31_DIAGNO_PROVAVEL is null then return(''Diagn\00F3stico Prov\00E1vel deve ter algum valor.'');'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(125128505671442447472)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(29872842737207898364)
,p_validation_name=>'Validar Grid na Criacao (PARTE_LESADA)'
,p_validation_sequence=>210
,p_validation=>'P31_HAS_ROWS'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\00C9 obrigat\00F3rio informar ao menos uma Parte Lesada antes de criar o acidente.')
,p_validation_condition=>'P31_COD_ACIDENTE_TIPO'
,p_validation_condition2=>'4'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_api.id(125126959536692840839)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(27064056319572032197)
,p_validation_name=>'Validar Grid na SAVE (PARTE_LESADA)'
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_QTD NUMBER := 0;',
'',
'BEGIN',
'   IF :P31_COD_ANALISE_ACIDENTE IS NOT NULL THEN ',
'',
'     BEGIN ',
'	 SELECT COUNT(1)',
'       INTO V_QTD',
'       FROM ANALISE_FUNC_PARTE_LESADA',
'      WHERE COD_ANALISE_ACIDENTE = :P31_COD_ANALISE_ACIDENTE',
'        AND COD_EMPRESA = NVL(:P31_COD_EMPRESA,:P31_EMPRESA_NEW);',
'     EXCEPTION WHEN OTHERS THEN',
'       V_QTD := 0;',
'     END;',
'	',
'	IF V_QTD = 0 AND NVL(:P31_HAS_ROWS,''N'') <> ''S'' AND :P31_COD_ACIDENTE_TIPO <> 4 THEN',
'		RETURN false;',
'	END IF;',
'  ',
'   END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('\00C9 obrigat\00F3rio informar ao menos uma Parte Lesada antes de criar o acidente.')
,p_when_button_pressed=>wwv_flow_api.id(125126959660278840839)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125127036883563876248)
,p_name=>'Popula TP_LOGR_CODIGO_ES'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_TP_LOGR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125127036948143876249)
,p_event_id=>wwv_flow_api.id(125127036883563876248)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select a.codigo_es',
'  from tipo_logradouro a',
' where a.cod_tp_logr = :p31_cod_tp_logr;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p31_tp_logr_codigo_es := v_c1.codigo_es;',
'',
'end;'))
,p_attribute_02=>'P31_COD_TP_LOGR'
,p_attribute_03=>'P31_TP_LOGR_CODIGO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125127037075602876250)
,p_name=>unistr('CEP: Popula Endere\00E7o')
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_CEP_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125127037104934876251)
,p_event_id=>wwv_flow_api.id(125127037075602876250)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*BEGIN',
'	',
'	if :P31_complemento_cep_loc is not null and :P31_cep_local is not null then',
'				begin',
'				 select c.endereco,',
'		            c.bairro,',
'		            c.cidade,',
'		            c.cod_mun_ibge,',
'		            c.uf,',
'		            t.cod_tp_logr,',
'		            c.cidade,',
'                t.codigo_es',
'		       into :P31_endereco_acidente,',
'		            :P31_bairro_acidente,',
'		            :P31_cidade_acidente,',
'		            :P31_COD_MUN_IBGE,',
'		            :P31_UF_LOCAL_ACIDENTE,',
'		            :P31_cod_tp_logr,',
'		            :P31_local_acidente,',
'                :P31_tp_logr_codigo_es',
'		       from tabela_cep c, tipo_logradouro t',
'		      where c.cep = :P31_cep_local',
'		        and c.complemento_cep = :P31_complemento_cep_loc',
'		        and c.cod_tp_logr = t.cod_tp_logr;',
'',
'					exception',
'						 when no_data_found then',
'						    null;',
'					end;',
'  else',
'      :P31_endereco_acidente := null;',
'      :P31_bairro_acidente := null;',
'      :P31_cidade_acidente := null;',
'      :P31_COD_MUN_IBGE := null;',
'      :P31_UF_LOCAL_ACIDENTE := null;',
'      :P31_cod_tp_logr := null;',
'      :P31_local_acidente := null;',
'      :P31_tp_logr_codigo_es := null;',
'  end if;',
'',
'end;*/',
'',
'',
'declare',
'',
'v_cep number(5);',
'v_dc_cep number(3);',
'',
'begin',
'',
'if :P31_CEP_DSP is not null then ',
' V_CEP := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' V_DC_CEP  := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'else',
' V_CEP := null;',
' V_DC_CEP := null;',
'end if;',
'',
' :P31_CEP_LOCAL := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' :P31_COMPLEMENTO_CEP_LOC  := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'',
'prc_api_busca_cep(p_cep => v_cep,',
'                  p_complem_cep => v_dc_cep, ',
'                  p_endereco => :P31_endereco_acidente, ',
'                  p_bairro => :P31_bairro_acidente, ',
'                  p_cidade => :P31_cidade_acidente, ',
'                  p_uf => :P31_uf_local_acidente,',
'                  p_cod_tipo_logradouro => :P31_cod_tp_logr,',
'                  p_cod_tipo_logradouro_es => :P31_tp_logr_codigo_es,',
'                  p_ibge => :P31_cod_mun_ibge);',
'',
':P31_LOCAL_ACIDENTE := :P31_cidade_acidente;',
'',
':P31_num_local_acidente := null;',
':P31_complemento := null;',
'',
'end;'))
,p_attribute_02=>'P31_CEP_DSP,P31_CIDADE_ACIDENTE'
,p_attribute_03=>'P31_ENDERECO_ACIDENTE,P31_BAIRRO_ACIDENTE,P31_CIDADE_ACIDENTE,P31_COD_MUN_IBGE,P31_UF_LOCAL_ACIDENTE,P31_COD_TP_LOGR,P31_LOCAL_ACIDENTE,P31_TP_LOGR_CODIGO_ES,P31_CEP_LOCAL,P31_COMPLEMENTO_CEP_LOC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125127037204083876252)
,p_name=>unistr('Popula Dados de Endere\00E7o (Local)')
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_LOCAL_TRAB'
,p_condition_element=>'P31_COD_LOCAL_TRAB'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125127037330062876253)
,p_event_id=>wwv_flow_api.id(125127037204083876252)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  /*cursor c1 is',
'  select l.endereco,',
'         l.numero,',
'         l.complemento,',
'         l.bairro,',
'         l.cidade,',
'         l.uf,',
'         l.cep, ',
'         l.complemento_cep,',
'         c.cod_mun_ibge,',
'         t.cod_tp_logr,',
'         t.codigo_es',
'    from local_trab l, tabela_cep c, tipo_logradouro t',
'   where l.cod_local_trab = :p31_cod_local_trab',
'     and l.cep = c.cep',
'     and l.complemento_cep = c.complemento_cep',
'     and c.cod_tp_logr = t.cod_tp_logr;',
'',
'  v_c1 c1%rowtype;*/',
'',
'  cursor c2 is',
'  select lpad(cgc,12,0)||lpad(dc_cgc,2,0) cnpj',
'    from filiais',
'   where cod_empresa = :p31_cod_emp_acidente',
'     and cod_filial = :p31_cod_fil_acidente;',
'     ',
'  v_c2 c2%rowtype;',
'',
'begin',
'',
'  /*open c1;',
'  fetch c1 into v_c1;',
'  close c1;*/',
'',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'',
' -- if v_c1.endereco is not null then',
'',
'  /*:p31_cep_local := v_c1.cep;',
'  :p31_complemento_cep_loc := v_c1.complemento_cep;',
'  :P31_endereco_acidente := v_c1.endereco;',
'  :p31_num_local_acidente := v_c1.numero;',
'  :p31_complemento := v_c1.complemento;',
'  :P31_bairro_acidente := v_c1.bairro;',
'  :P31_cidade_acidente := v_c1.cidade;',
'  :P31_COD_MUN_IBGE := v_c1.cod_mun_ibge;',
'  :P31_UF_LOCAL_ACIDENTE := v_c1.uf;',
'  :P31_cod_tp_logr := v_c1.cod_tp_logr;',
'  :P31_local_acidente := v_c1.cidade;',
'  :P31_tp_logr_codigo_es := v_c1.codigo_es;*/',
'',
' -- end if;',
'  ',
'  :p31_cnpj_local_acidente := v_c2.cnpj;',
'',
'end;'))
,p_attribute_02=>'P31_COD_LOCAL_TRAB'
,p_attribute_03=>'P31_CNPJ_LOCAL_ACIDENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128321132751846558)
,p_name=>'Btn - Testemunha - Dialog Closed'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125128319768209846544)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128321221093846559)
,p_event_id=>wwv_flow_api.id(125128321132751846558)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(125128207747267328575)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128323664570846583)
,p_name=>'Btn - Terceiro - Dialog Closed'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125128321842610846565)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128323754445846584)
,p_event_id=>wwv_flow_api.id(125128323664570846583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(125128321716451846564)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128321305518846560)
,p_name=>'IR - Testemunha - Dialog Closed'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(125128207747267328575)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128321403900846561)
,p_event_id=>wwv_flow_api.id(125128321305518846560)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(125128207747267328575)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128323429956846581)
,p_name=>'IR - Terceiros - Dialog Closed'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(125128321716451846564)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128323595982846582)
,p_event_id=>wwv_flow_api.id(125128323429956846581)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(125128321716451846564)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128503378052447449)
,p_name=>'Popula Colaborador'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_EMPRESA,P31_MATRICULA'
,p_condition_element=>'P31_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128503466357447450)
,p_event_id=>wwv_flow_api.id(125128503378052447449)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select p.cod_empresa||'' - ''||INITCAP(nvl(e.nome_abrev,e.nome)),',
'       p.matricula||'' - ''||initcap(p.nome),',
'       :p31_cod_analise_acidente,',
'       i.cod_ccusto,',
'       c.cod_dc,',
'       i.dc_matricula',
'  into :p31_cod_empresa_dsp,',
'       :p31_matricula_dsp,',
'       :p31_cod_analise_acidente_dsp,',
'       :p31_cod_ccusto,',
'       :p31_va_cod_dc,',
'       :p31_dc_matricula',
'  from inf_pessoais p,',
'       informacoes_funcionais i,',
'       empresas e,',
'       centro_de_custo c',
' where p.cod_empresa = e.cod',
'   and p.cod_empresa = i.cod_empresa',
'   and p.cod_empresa = c.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and p.matricula = i.matricula',
'   and p.cod_empresa = :p31_cod_empresa',
'   and p.matricula = :p31_matricula;',
'',
'',
':P31_EMPRESA_NEW := :p31_cod_empresa;',
'',
'exception',
'when no_data_found then',
'null;',
'end;'))
,p_attribute_02=>'P31_COD_EMPRESA,P31_MATRICULA,P31_COD_ANALISE_ACIDENTE'
,p_attribute_03=>'P31_COD_EMPRESA_DSP,P31_MATRICULA_DSP,P31_COD_ANALISE_ACIDENTE_DSP,P31_COD_CCUSTO,P31_VA_COD_DC,P31_DC_MATRICULA,P31_EMPRESA_NEW'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128503557251447451)
,p_event_id=>wwv_flow_api.id(125128503378052447449)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_COD_EMPRESA_DSP,P31_MATRICULA_DSP,P31_COD_ANALISE_ACIDENTE_DSP,P31_COD_CCUSTO,P31_VA_COD_DC,P31_EMPRESA_NEW'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128505992782447475)
,p_name=>unistr('\00D3bito: DT_RETORNO e QTD_DIAS_AFAST')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_IND_OBITO'
,p_condition_element=>'P31_IND_OBITO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506001961447476)
,p_event_id=>wwv_flow_api.id(125128505992782447475)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_DT_RETORNO,P31_QTD_DIAS_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506237825447478)
,p_event_id=>wwv_flow_api.id(125128505992782447475)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_DT_OBITO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506134082447477)
,p_event_id=>wwv_flow_api.id(125128505992782447475)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_DT_OBITO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128506366989447479)
,p_name=>'Ind_Afastamento: Seta qtd_dias_afast'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_IND_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506472277447480)
,p_event_id=>wwv_flow_api.id(125128506366989447479)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p31_tipo_analise = 2 then',
'',
'  if :p31_ind_obito = ''S'' then',
'  ',
'    :p31_qtd_dias_afastamento := null;',
'    :p31_dt_retorno := null;',
'    ',
'  else',
'',
'    if :p31_ind_afastamento = ''N'' then',
'    :p31_qtd_dias_afastamento := 0;',
'    :p31_dt_retorno := null;',
'    else',
'    :p31_qtd_dias_afastamento := null;',
'    end if;',
'    ',
'  end if;',
'end if;'))
,p_attribute_02=>'P31_TIPO_ANALISE,P31_IND_OBITO,P31_IND_AFASTAMENTO'
,p_attribute_03=>'P31_QTD_DIAS_AFASTAMENTO,P31_DT_RETORNO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128506543224447481)
,p_name=>'Qtd. Dias. Afast.: Seta Dt_Retorno'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_QTD_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506611117447482)
,p_event_id=>wwv_flow_api.id(125128506543224447481)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
' ',
'if :p31_ind_obito = ''S'' then',
'',
'   :p31_dt_retorno := null ;',
'',
'end if ;',
' ',
'if :p31_ind_obito = ''N'' and ',
'   :p31_ind_afastamento = ''S'' then',
'',
'      :p31_dt_retorno := TO_DATE(:p31_dt_acidente) + :P31_QTD_DIAS_AFASTAMENTO; ',
'       ',
'end if ;',
'END ;'))
,p_attribute_02=>'P31_IND_OBITO,P31_IND_AFASTAMENTO,P31_DT_ACIDENTE,P31_QTD_DIAS_AFASTAMENTO'
,p_attribute_03=>'P31_DT_RETORNO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128506786407447483)
,p_name=>'Popula dc_mat_sup_imediato'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_MATRICULA_SUP_IMEDIATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128506801048447484)
,p_event_id=>wwv_flow_api.id(125128506786407447483)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p31_dc_matricula_sup_imediato',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p31_cod_empresa',
'  and p.matricula = :p31_matricula_sup_imediato;',
'  ',
'exception',
'when no_data_found then',
':p31_dc_matricula_sup_imediato := null;',
'',
'end;'))
,p_attribute_02=>'P31_COD_EMPRESA,P31_MATRICULA_SUP_IMEDIATO'
,p_attribute_03=>'P31_DC_MATRICULA_SUP_IMEDIATO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128506929414447485)
,p_name=>'Popula dc_mat_eng'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_MATRICULA_ENG_SEGURANCA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128786800730457736)
,p_event_id=>wwv_flow_api.id(125128506929414447485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p31_dc_matricula_ENG_SEGURANCA',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P31_COD_EMPRESA_ENG_SEGURANCA',
'  and p.matricula = :p31_matricula_ENG_SEGURANCA;',
'  ',
'exception',
'when no_data_found then',
':p31_dc_matricula_ENG_SEGURANCA := null;',
'WHEN OTHERS THEN',
':p31_dc_matricula_ENG_SEGURANCA := null;',
'',
'end;'))
,p_attribute_02=>'P31_COD_EMPRESA_ENG_SEGURANCA,P31_MATRICULA_ENG_SEGURANCA'
,p_attribute_03=>'P31_DC_MATRICULA_ENG_SEGURANCA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128786957563457737)
,p_name=>'Popula dc_mat_tec'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_MATRICULA_TEC_SEGURANCA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128787045605457738)
,p_event_id=>wwv_flow_api.id(125128786957563457737)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p31_dc_matricula_TEC_SEGURANCA',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P31_COD_EMPRESA_TEC_SEGURANCA',
'  and p.matricula = :p31_matricula_TEC_SEGURANCA;',
'  ',
'exception',
'when no_data_found then',
':p31_dc_matricula_TEC_SEGURANCA := null;',
'',
'end;'))
,p_attribute_02=>'P31_COD_EMPRESA_TEC_SEGURANCA,P31_MATRICULA_TEC_SEGURANCA'
,p_attribute_03=>'P31_DC_MATRICULA_TEC_SEGURANCA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128787765134457745)
,p_name=>'Chama Report RP20537'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125128787684342457744)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128787842313457746)
,p_event_id=>wwv_flow_api.id(125128787765134457745)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP20537'
,p_attribute_02=>'INVESTIGACAO_ACIDENTE.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P31_COD_EMPRESA,P31_MATRICULA,P31_COD_ANALISE_ACIDENTE,P_USUARIO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return(',
'''&P_DATA_EMISSAO=''||To_Char(Sysdate,''DD/MM/RRRR'')||',
'''&P_EMPRESA=''||:P31_COD_EMPRESA||',
'''&P_MATRICULA=''||:P31_MATRICULA||',
'''&P_ANALISE_ACIDENTE=''||:P31_COD_ANALISE_ACIDENTE||',
'''&P_USUARIO=''     ||:P_USUARIO);'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125128788111699457749)
,p_name=>'Chama Report RP10401'
,p_event_sequence=>200
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125128787121868457739)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125128788255800457750)
,p_event_id=>wwv_flow_api.id(125128788111699457749)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP10401'
,p_attribute_02=>'CAT.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P31_COD_EMPRESA,P31_MATRICULA,P31_COD_ANALISE_ACIDENTE,P_USUARIO,P31_DT_ACIDENTE,P31_OBSERVACAO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return(',
'''&P_DATA_EMISSAO=''||To_Char(Sysdate,''DD/MM/RRRR'')||',
'''&P_COD_EMPRESA=''||:P31_COD_EMPRESA||',
'''&P_MATRICULA=''||:P31_MATRICULA||',
'''&P_DT_INICIO=''||:P31_DT_ACIDENTE||',
'''&P_DT_FIM=''||:P31_DT_ACIDENTE||',
'''&P_OBSERVACOES=''||:P31_OBSERVACAO||',
'''&P_CODIGO=''||:P31_COD_ANALISE_ACIDENTE||',
'''&P_USUARIO=''     ||:P_USUARIO);'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125129337160427488954)
,p_name=>'ADD_MEDICO DIALOG CLOSED'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125129337066725488953)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125129337248948488955)
,p_event_id=>wwv_flow_api.id(125129337160427488954)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_COD_MED_EMIT_CAT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(86518291566366424506)
,p_name=>'Habilita/Desabilita Campos                                                                                                                         '
,p_event_sequence=>218
,p_condition_element=>'P31_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86518291997266424510)
,p_event_id=>wwv_flow_api.id(86518291566366424506)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_STATUS_CAT,P31_COD_EMPRESA,P31_MATRICULA,P31_DT_ACIDENTE,P31_HOR_ACIDENTE,P31_DT_ANALISE,P31_COD_ACIDENTE_TIPO,P31_TIPO_ANALISE,P31_COD_ACIDENTE_TIPO_ES,P31_AFASTAMENTO_IMEDIATO,P31_DT_ULT_DIA_TRAB,P31_IND_OBITO,P31_DT_OBITO,P31_IND_EXPERIENCIA_O'
||'PERACAO,P31_IND_DEPTO_POLICIAL,P31_NUM_BOLETIM_OCORR,P31_DATA_BOLETIM_OCORR,P31_ARQ_BO,P31_NOME_ARQ_BO,P31_MIMETYPE_ARQ_BO,P31_CHARSET_ARQ_BO,P31_CLASS_ACIDENTE,P31_TP_REGISTRO_CAT,P31_COD_EMP_SOLICITANTE,P31_MAT_SOLICITANTE,P31_DC_MATRICULA,P31_TIPO'
||'_ACIDENTE_AUX,P31_HORAS_TRAB,P31_SERV_MED_ATEND,P31_COD_MED_EMIT_CAT,P31_DT_ATEND,P31_QTDE_DIAS_TRATAMENTO,P31_COD_AGENTE_LESAO,P31_COD_FATOR_TRABALHO,P31_IND_PROT_TIPO_ACIDENTE,P31_IND_AFASTAMENTO,P31_QTD_DIAS_AFASTAMENTO,P31_DT_RETORNO,P31_CID,P31_'
||'CODIGO,P31_DIAGNO_PROVAVEL,P31_OBSERVACAO_CAT,P31_COD_CNES,P31_OBSERVACAO,P31_ORIGEM_MED_CAT,P31_NOME_ARQ,P31_MIMETYPE_ARQ,P31_CHARSET_ARQ,P31_HORA_ATEND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125283219725616179266)
,p_name=>'SHOW/HIDE Campos'
,p_event_sequence=>239
,p_condition_element=>'P31_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125283219844313179267)
,p_event_id=>wwv_flow_api.id(125283219725616179266)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_COD_ANALISE_ACIDENTE,P31_STATUS_CAT,P31_COD_EMP_SOLICITANTE,P31_MAT_SOLICITANTE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125283219957054179268)
,p_event_id=>wwv_flow_api.id(125283219725616179266)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_COD_ANALISE_ACIDENTE,P31_STATUS_CAT,P31_COD_EMP_SOLICITANTE,P31_MAT_SOLICITANTE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(125292615853703041468)
,p_name=>unistr('Area Seguran\00E7a / M\00E9dica')
,p_event_sequence=>249
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125292615985070041469)
,p_event_id=>wwv_flow_api.id(125292615853703041468)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select area_medica, area_seguranca',
'  from analise_acidente_perfil',
' where ((CD_PERFIL IS NULL) OR (:P_PERFIL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(CD_PERFIL, '':'')) t)));',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    :p31_area_seguranca := v_c1.area_seguranca;',
'    :p31_area_medica := v_c1.area_medica;',
'',
'end;'))
,p_attribute_02=>'P_PERFIL'
,p_attribute_03=>'P31_AREA_SEGURANCA,P31_AREA_MEDICA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(125292616812833041478)
,p_event_id=>wwv_flow_api.id(125292615853703041468)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//if (apex.item( "P31_ROWID" ).getValue().length == 0)',
'{',
'    $("#AVALIADOR").hide();',
'    $("#SERVICO_tab").hide();',
'    $("#CONSEQUENCIA_tab").hide();',
'    $("#TESTEMUNHA_tab").hide();',
'    $("#TERCEIROS_tab").hide();',
'    $("#EPI_tab").hide();',
'    $("#CUSTO_tab").hide();',
'    $("#PLANO_tab").hide();',
'    $("#DIAGRAMA_tab").hide();',
'    $("#CONCLUSAO_tab").hide();',
'    $("#COLABORADOR_tab").hide();',
'    $("#ACIDENTE_tab").hide();',
'    $("#PARTE_CORPO_tab").hide();',
'}',
'',
'if (apex.item( "P31_AREA_SEGURANCA" ).getValue() == ''S''){',
'  ',
'    $("#AVALIADOR").show();',
'    $("#SERVICO_tab").show();',
'    $("#CONSEQUENCIA_tab").show();',
'    $("#TESTEMUNHA_tab").show();',
'    $("#TERCEIROS_tab").show();',
'    $("#EPI_tab").show();',
'    $("#CUSTO_tab").show();',
'    $("#PLANO_tab").show();',
'    $("#DIAGRAMA_tab").show();',
'    $("#CONCLUSAO_tab").show();',
'    ',
'   /* if (apex.item( "P31_COD_ACIDENTE_TIPO" ).getValue() == ''2'') {',
'     apex.item( "P31_CID" ).hide();',
'    apex.item( "P31_CODIGO" ).hide();',
'    apex.item( "P31_DIAGNO_PROVAVEL" ).hide();',
'     }*/',
'  }',
'',
'if (apex.item( "P31_AREA_MEDICA" ).getValue() == ''S''){',
'    ',
'    apex.item( "P31_COD_FATOR_PESSOAL" ).hide();',
'    apex.item( "P31_COD_ATO_INSEGURO" ).hide();',
'    apex.item( "P31_COD_CONDICAO_INSEGURA" ).hide();',
'    ',
'    $("#ANALISE_tab").show();',
'    $("#ACIDENTE_tab").show();',
'    $("#COLABORADOR_tab").show();',
'    $("#PARTE_CORPO_tab").show();',
'  ',
'}'))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121064820662629206333)
,p_name=>'Popula ORIGEM_MED_CAT'
,p_event_sequence=>259
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_MED_EMIT_CAT_1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121064820774685206334)
,p_event_id=>wwv_flow_api.id(121064820662629206333)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  SELECT COD, ORIGEM',
'  INTO   :P31_COD_MED_EMIT_CAT,:P31_ORIGEM_MED_CAT',
'  FROM   VW_MEDICOS',
'  WHERE  NR_DOCUMENTO = SUBSTR(:P31_COD_MED_EMIT_CAT_1,INSTR(:P31_COD_MED_EMIT_CAT_1,''/'')+1)',
'  AND    COD = SUBSTR(:P31_COD_MED_EMIT_CAT_1,1,INSTR(:P31_COD_MED_EMIT_CAT_1,''/'')-1);',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    :P31_COD_MED_EMIT_CAT := NULL;',
'    :P31_ORIGEM_MED_CAT   := NULL;',
'END;'))
,p_attribute_02=>'P31_COD_MED_EMIT_CAT_1'
,p_attribute_03=>'P31_COD_MED_EMIT_CAT,P31_ORIGEM_MED_CAT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98273373687450198824)
,p_name=>unistr('SET dura\00E7\00E3o provavel')
,p_event_sequence=>269
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_QTD_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98273373804254198825)
,p_event_id=>wwv_flow_api.id(98273373687450198824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P31_QTDE_DIAS_TRATAMENTO := TO_CHAR(:P31_QTD_DIAS_AFASTAMENTO);',
'END;'))
,p_attribute_02=>'P31_QTD_DIAS_AFASTAMENTO'
,p_attribute_03=>'P31_QTDE_DIAS_TRATAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98283062721565260283)
,p_name=>unistr('SET dura\00E7\00E3o provavel_1')
,p_event_sequence=>279
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_QTDE_DIAS_TRATAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98283062785153260284)
,p_event_id=>wwv_flow_api.id(98283062721565260283)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P31_QTD_DIAS_AFASTAMENTO := TO_NUMBER(:P31_QTDE_DIAS_TRATAMENTO);',
'END;'))
,p_attribute_02=>'P31_QTDE_DIAS_TRATAMENTO'
,p_attribute_03=>'P31_QTD_DIAS_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98132415761676896937)
,p_name=>unistr('SET_endere\00E7o/Trajeto N')
,p_event_sequence=>289
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_FIL_ACIDENTE'
,p_condition_element=>'P31_COD_FIL_ACIDENTE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98132415911392896938)
,p_event_id=>wwv_flow_api.id(98132415761676896937)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'		DECLARE ',
'		V_CEP                   NUMBER(8);',
'		V_TIPO                  VARCHAR2(50);',
'		V_ENDERECO              VARCHAR2(100);',
'		V_NUMERO                NUMBER(5);',
'		V_COMPLEMENTO           VARCHAR2(200);',
'		V_BAIRRO                VARCHAR2(100);',
'		V_CIDADE                VARCHAR2(100);',
'		V_UF                    VARCHAR2(2);',
'        V_COMP_CEP              NUMBER(3);',
'		',
'		BEGIN',
'		',
'		BEGIN',
'		',
'				SELECT CEP, COD_TP_LOGR, ENDERECO, NUMERO, COMPLEM, BAIRRO, CIDADE, UF , COMPLEMENTO_CEP',
'					INTO    V_CEP           ,',
'							V_TIPO          ,',
'							V_ENDERECO      ,',
'							V_NUMERO        ,',
'							V_COMPLEMENTO   ,',
'							V_BAIRRO        ,',
'							V_CIDADE        ,',
'							V_UF            ,',
'                            V_COMP_CEP',
'				FROM VW_ENDERECO_FILIAL',
'					WHERE COD_EMPRESA 	=   :P31_COD_EMP_ACIDENTE',
'					AND COD_FILIAL    	=	:P31_COD_FIL_ACIDENTE;',
'		END;',
'	  :p31_cep_dsp := regexp_replace(LPAD(lpad(V_CEP,5,0)||lpad(V_COMP_CEP,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'');',
'	 -- :P31_CEP_LOCAL			:= V_CEP      		;',
'	  :P31_COD_TP_LOGR 			:= V_TIPO 			;',
'	  :P31_ENDERECO_ACIDENTE 	:= V_ENDERECO  		;',
'	  :P31_NUM_LOCAL_ACIDENTE	:= V_NUMERO			;',
'	  :P31_COMPLEMENTO			:= V_COMPLEMENTO	;',
'      :P31_BAIRRO_ACIDENTE		:= V_BAIRRO			;',
'	  :P31_LOCAL_ACIDENTE		:= V_CIDADE			;',
'	  :P31_UF_LOCAL_ACIDENTE 	:= V_UF				;',
'     -- :P31_COMPLEMENTO_CEP_LOC   := V_COMP_CEP       ;',
'		',
'		END;'))
,p_attribute_02=>'P31_COD_EMP_ACIDENTE,P31_COD_FIL_ACIDENTE'
,p_attribute_03=>'P31_CEP_LOCAL,P31_COD_TP_LOGR,P31_ENDERECO_ACIDENTE,P31_NUM_LOCAL_ACIDENTE,P31_COMPLEMENTO,P31_BAIRRO_ACIDENTE,P31_LOCAL_ACIDENTE,P31_UF_LOCAL_ACIDENTE,P31_COMPLEMENTO_CEP_LOC,P31_CEP_DSP'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54670530343479995670)
,p_event_id=>wwv_flow_api.id(98132415761676896937)
,p_event_result=>'TRUE'
,p_action_sequence=>15
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  IF :P31_CEP_DSP IS NOT NULL THEN ',
' :P31_CEP_LOCAL := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' :P31_COMPLEMENTO_CEP_LOC  := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
' END IF;',
' exception',
'  when no_data_found then',
'  null;'))
,p_attribute_02=>'P31_CEP_DSP'
,p_attribute_03=>'P31_CEP_LOCAL,P31_COMPLEMENTO_CEP_LOC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(91363347034449529709)
,p_event_id=>wwv_flow_api.id(98132415761676896937)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.codigo_es',
'into :p31_tp_logr_codigo_es',
'  from tipo_logradouro a',
' where a.cod_tp_logr = :p31_cod_tp_logr;'))
,p_attribute_02=>'P31_COD_TP_LOGR'
,p_attribute_03=>'P31_TP_LOGR_CODIGO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(91188250830532785483)
,p_event_id=>wwv_flow_api.id(98132415761676896937)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.endereco,',
'		            c.bairro,',
'		            c.cidade,',
'		            c.cod_mun_ibge,',
'		            c.uf,',
'		            t.cod_tp_logr,',
'		            c.cidade--,',
'             --   t.codigo_es',
'		       into :P31_endereco_acidente,',
'		            :P31_bairro_acidente,',
'		            :P31_cidade_acidente,',
'		            :P31_COD_MUN_IBGE,',
'		            :P31_UF_LOCAL_ACIDENTE,',
'		            :P31_cod_tp_logr,',
'		            :P31_local_acidente--,',
'               -- :P31_tp_logr_codigo_es',
'		       from tabela_cep c, tipo_logradouro t',
'		      where c.cep = :P31_cep_local',
'		        and c.complemento_cep = :P31_complemento_cep_loc',
'		        and c.cod_tp_logr = t.cod_tp_logr;',
'',
'					exception',
'						 when no_data_found then',
'						    null;'))
,p_attribute_02=>'P31_CEP_LOCAL,P31_COMPLEMENTO_CEP_LOC'
,p_attribute_03=>'P31_ENDERECO_ACIDENTE,P31_BAIRRO_ACIDENTE,P31_CIDADE_ACIDENTE,P31_COD_MUN_IBGE,P31_UF_LOCAL_ACIDENTE,P31_COD_TP_LOGR,P31_LOCAL_ACIDENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98132415946939896939)
,p_name=>unistr('SET_endere\00E7o/Trajeto S')
,p_event_sequence=>299
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_CEP_LOCAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98132416066552896940)
,p_event_id=>wwv_flow_api.id(98132415946939896939)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cep number(5);',
'v_dc_cep number(3);',
'v_ibge number(10) null;',
'v_log_es number(10)null;',
'',
'begin',
'',
'if :P31_CEP_DSP is not null then ',
' V_CEP := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' V_DC_CEP  := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'else',
' V_CEP := null;',
' V_DC_CEP := null;',
'end if;',
'',
' :P31_CEP_LOCAL := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' :P31_COMPLEMENTO_CEP_LOC  := substr(trim(replace(translate(:P31_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'',
'prc_api_busca_cep(p_cep => v_cep,',
'                  p_complem_cep => v_dc_cep, ',
'                  p_endereco => :P31_ENDERECO_ACIDENTE, ',
'                  p_bairro => :P31_BAIRRO_ACIDENTE, ',
'                  p_cidade => :P31_LOCAL_ACIDENTE, ',
'                  p_uf => :P31_UF_LOCAL_ACIDENTE,',
'                  p_cod_tipo_logradouro => :P31_COD_TP_LOGR,',
'                  p_cod_tipo_logradouro_es => v_log_es,',
'                  p_ibge => v_ibge);',
'',
':P31_LOCAL_ACIDENTE := :p31_cidade_acidente;',
'',
':P31_NUM_LOCAL_ACIDENTE := null;',
':P31_COMPLEMENTO := null;',
'',
'end;'))
,p_attribute_02=>'P31_CEP_DSP'
,p_attribute_03=>'P31_COD_TP_LOGR,P31_ENDERECO_ACIDENTE,P31_NUM_LOCAL_ACIDENTE,P31_COMPLEMENTO,P31_BAIRRO_ACIDENTE,P31_LOCAL_ACIDENTE,P31_UF_LOCAL_ACIDENTE,P31_CEP_LOCAL,P31_COMPLEMENTO_CEP_LOC'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98132416190339896941)
,p_name=>'SET_TRAJETO'
,p_event_sequence=>309
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_CEP_LOCAL,P31_IND_TRAJETO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98016990483350844792)
,p_event_id=>wwv_flow_api.id(98132416190339896941)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P31_IND_TRAJETO_1 := :P31_IND_TRAJETO;'
,p_attribute_02=>'P31_IND_TRAJETO'
,p_attribute_03=>'P31_IND_TRAJETO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(98012355631783883633)
,p_name=>'Set tipo_aux'
,p_event_sequence=>319
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_ACIDENTE_TIPO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98012355758748883634)
,p_event_id=>wwv_flow_api.id(98012355631783883633)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P31_TIPO_ACIDENTE_AUX := :P31_COD_ACIDENTE_TIPO;'
,p_attribute_02=>'P31_COD_ACIDENTE_TIPO'
,p_attribute_03=>'P31_TIPO_ACIDENTE_AUX'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92347129131631719842)
,p_name=>'VALIDA_CID'
,p_event_sequence=>329
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125126959660278840839)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P31_CID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92354690868210734107)
,p_event_id=>wwv_flow_api.id(92347129131631719842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_TIPO_LOCAL_ACIDENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92347129200572719843)
,p_event_id=>wwv_flow_api.id(92347129131631719842)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'<strong>Verifique o tipo de acidente.</strong>'
,p_attribute_07=>'Confirmar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92347129270725719844)
,p_event_id=>wwv_flow_api.id(92347129131631719842)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92347129770015719849)
,p_name=>'VALIDA_SEM_CID'
,p_event_sequence=>349
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125126959660278840839)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P31_CID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92347130026960719851)
,p_event_id=>wwv_flow_api.id(92347129770015719849)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92347129390370719845)
,p_name=>'VALIDA_CID_CREATE'
,p_event_sequence=>359
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125126959536692840839)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P31_CID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92354690808040734106)
,p_event_id=>wwv_flow_api.id(92347129390370719845)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_TIPO_LOCAL_ACIDENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92347129521322719846)
,p_event_id=>wwv_flow_api.id(92347129390370719845)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'<strong>Verifique o tipo de acidente.</strong>'
,p_attribute_07=>'Confirmar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92347129610891719847)
,p_event_id=>wwv_flow_api.id(92347129390370719845)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92354690493751734103)
,p_name=>'VALIDA_SEM_CID_CREATE'
,p_event_sequence=>389
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(125126959536692840839)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P31_CID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92354690706941734105)
,p_event_id=>wwv_flow_api.id(92354690493751734103)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92091876538225812972)
,p_name=>'SET DATA ANALISE'
,p_event_sequence=>399
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_CONCLUSAO_TEXTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92091876602874812973)
,p_event_id=>wwv_flow_api.id(92091876538225812972)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P31_DT_ANALISE := SYSDATE;'
,p_attribute_03=>'P31_DT_ANALISE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(83928543462907129945)
,p_name=>'Ocultar Hora de Atendimento '
,p_event_sequence=>409
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P31_NUM_PROTOCOLO'
,p_da_event_comment=>'ALTERADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(83928543296605129944)
,p_event_id=>wwv_flow_api.id(83928543462907129945)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_HORA_ATEND_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(83928543202165129943)
,p_event_id=>wwv_flow_api.id(83928543462907129945)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_HORA_ATEND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(83928543110671129942)
,p_name=>'Exibir Hora de Atendimento'
,p_event_sequence=>419
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P31_NUM_PROTOCOLO'
,p_da_event_comment=>'ALTERADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(83928543025820129941)
,p_event_id=>wwv_flow_api.id(83928543110671129942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_HORA_ATEND_TXT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(83928542983336129940)
,p_event_id=>wwv_flow_api.id(83928543110671129942)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_HORA_ATEND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(74065372075093272963)
,p_name=>'MUDANCA_TRAJETO'
,p_event_sequence=>429
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_TIPO_LOCAL_ACIDENTE'
,p_condition_element=>'P31_TIPO_LOCAL_ACIDENTE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'4'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(74065372361505272966)
,p_event_id=>wwv_flow_api.id(74065372075093272963)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P31_TIPO_LOCAL_ACIDENTE = 4 THEN',
'  :P31_IND_TRAJETO        :=''S'';',
'END IF;'))
,p_attribute_02=>'P31_TIPO_LOCAL_ACIDENTE'
,p_attribute_03=>'P31_IND_TRAJETO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(74065372466548272967)
,p_event_id=>wwv_flow_api.id(74065372075093272963)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_IND_TRAJETO,P31_COD_EMP_ACIDENTE,P31_COD_FIL_ACIDENTE,P31_COD_LOCAL_TRAB,P31_CNPJ_LOCAL_ACIDENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(74065372306574272965)
,p_event_id=>wwv_flow_api.id(74065372075093272963)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_IND_TRAJETO,P31_COD_EMP_ACIDENTE,P31_COD_FIL_ACIDENTE,P31_COD_LOCAL_TRAB,P31_CNPJ_LOCAL_ACIDENTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(44496673444819696817)
,p_name=>'Read Only Local Acidente'
,p_event_sequence=>439
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>':P31_NUM_PROTOCOLO IS NOT NULL AND :P31_DT_EMISSAO_CAT < TRUNC(SYSDATE) - 45'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(44496673498726696818)
,p_event_id=>wwv_flow_api.id(44496673444819696817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(125127036257169876242)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var regionSelector = ''#LOCAL'';',
'',
'$(regionSelector + '' .t-Form-fieldContainer'').each(function() {',
'    var $container = $(this);',
'    ',
'    var $item = $container.find(''input:not([type="hidden"]), select, textarea'');',
'    ',
'    if ($item.length > 0) {',
'        ',
'        var val = '''';',
'        if ($item.is(''select'')) {',
'            val = $item.find(''option:selected'').text();',
'        } else {',
'            val = $item.val();',
'        }',
'',
'       ',
'        $item.hide();',
'        ',
'        ',
'        $container.find(''.a-Button--popupLOV, .t-Form-inputContainer .a-Button'').hide();',
'',
'        ',
'        if ($container.find(''.temp-readonly-text'').length === 0) {',
'            $container.find(''.t-Form-itemWrapper'').append(',
'                ''<span class="temp-readonly-text" style="font-weight: bold; padding-top: 4px; display: block;">'' + (val ? val : ''-'') + ''</span>''',
'            );',
'        }',
'    }',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31269244656728183825)
,p_name=>'MASCARA_HORA'
,p_event_sequence=>449
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_HORAS_TRAB'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31269244788688183826)
,p_event_id=>wwv_flow_api.id(31269244656728183825)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P31_HORAS_TRAB");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31269245055253183829)
,p_name=>'MASCARA_HORA_P31_HORA_ATEND'
,p_event_sequence=>459
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_HORA_ATEND'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31269245193219183830)
,p_event_id=>wwv_flow_api.id(31269245055253183829)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P31_HORA_ATEND");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(31269244842973183827)
,p_name=>'MASCARA_P31_HOR_ACIDENTE'
,p_event_sequence=>469
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_HOR_ACIDENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31269244977508183828)
,p_event_id=>wwv_flow_api.id(31269244842973183827)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P31_HOR_ACIDENTE");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29870677632323526756)
,p_name=>'Atualiza duplicidade Empresa'
,p_event_sequence=>479
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_COD_EMPRESA_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29870677757713526757)
,p_event_id=>wwv_flow_api.id(29870677632323526756)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p31_cod_empresa_dsp_1 := :p31_cod_empresa_dsp;'
,p_attribute_02=>'P31_COD_EMPRESA_DSP'
,p_attribute_03=>'P31_COD_EMPRESA_DSP_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29870677819117526758)
,p_name=>'Atualiza duplicidade matricula'
,p_event_sequence=>489
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P31_MATRICULA_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29870677901835526759)
,p_event_id=>wwv_flow_api.id(29870677819117526758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P31_MATRICULA_DSP_1 := :P31_MATRICULA_DSP;'
,p_attribute_02=>'P31_MATRICULA_DSP'
,p_attribute_03=>'P31_MATRICULA_DSP_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(27064056481990032198)
,p_name=>'New'
,p_event_sequence=>499
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(29872839526896898332)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|apexbeginrecordedit'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(27064056580198032199)
,p_event_id=>wwv_flow_api.id(27064056481990032198)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P31_HAS_ROWS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125127001141660840888)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from ANALISE_ACIDENTE'
,p_attribute_02=>'ANALISE_ACIDENTE'
,p_attribute_03=>'P31_COD_EMPRESA'
,p_attribute_04=>'COD_EMPRESA'
,p_attribute_05=>'P31_COD_ANALISE_ACIDENTE'
,p_attribute_06=>'COD_ANALISE_ACIDENTE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502172627447437)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sequence'
,p_process_sql_clob=>'select sequencia_num_testemunha.nextval into :p31_num_anal from dual;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128787342268457741)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preenche Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select ',
'TIPO_ANALISE,',
'COD_CCUSTO,',
'--VA_COD_DC,',
'IND_OBITO,',
'DT_OBITO,',
'COD_FATOR_PESSOAL,',
'IND_ACIDENTE_ANTERIOR,',
'COD_ATO_INSEGURO,',
'IND_EXPERIENCIA_OPERACAO,',
'COD_CONDICAO_INSEGURA,',
'COD_AGENTE_LESAO,',
'COD_FATOR_TRABALHO,',
'IND_PROT_TIPO_ACIDENTE,',
'IND_AFASTAMENTO,',
'QUANTIDADE_DIAS_AFASTAMENTO,',
'DT_RETORNO,',
'CID,',
'CODIGO,',
'COD_EMPRESA_SUP_IMEDIATO,',
'MATRICULA_SUP_IMEDIATO,',
'DC_MATRICULA_SUP_IMEDIATO,',
'DIAGNO_PROVAVEL,',
'OBSERVACAO_CAT,',
'IND_DEPTO_POLICIAL,',
'NUM_BOLETIM_OCORR,',
'DATA_BOLETIM_OCORR',
' into',
':P31_TIPO_ANALISE,',
':P31_COD_CCUSTO,',
'--:P31_VA_COD_DC,',
':P31_IND_OBITO,',
':P31_DT_OBITO,',
':P31_COD_FATOR_PESSOAL,',
':P31_IND_ACIDENTE_ANTERIOR,',
':P31_COD_ATO_INSEGURO,',
':P31_IND_EXPERIENCIA_OPERACAO,',
':P31_COD_CONDICAO_INSEGURA,',
':P31_COD_AGENTE_LESAO,',
':P31_COD_FATOR_TRABALHO,',
':P31_IND_PROT_TIPO_ACIDENTE,',
':P31_IND_AFASTAMENTO,',
':P31_QTD_DIAS_AFASTAMENTO,',
':P31_DT_RETORNO,',
':P31_CID,',
':P31_CODIGO,',
':P31_COD_EMPRESA_SUP_IMEDIATO,',
':P31_MATRICULA_SUP_IMEDIATO,',
':P31_DC_MATRICULA_SUP_IMEDIATO,',
':P31_DIAGNO_PROVAVEL,',
':P31_OBSERVACAO_CAT,',
':P31_IND_DEPTO_POLICIAL,',
':P31_NUM_BOLETIM_OCORR,',
':P31_DATA_BOLETIM_OCORR',
'from ANALISE_FUNC',
' where cod_empresa = :P31_cod_empresa',
'   and cod_analise_acidente = :P31_cod_analise_acidente',
'   and matricula = :P31_MATRICULA;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P31_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502927019447445)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preenche Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'SELECT COD||''/''||NR_DOCUMENTO',
'INTO   :P31_COD_MED_EMIT_CAT_1',
'FROM   ANALISE_ACIDENTE A',
'      ,VW_MEDICOS V',
'WHERE  V.ORIGEM = A.ORIGEM_MED_CAT',
'AND    V.COD = A.COD_MED_EMIT_CAT',
'AND    A.COD_ANALISE_ACIDENTE = :p31_cod_analise_acidente',
'AND    A.COD_EMPRESA = :p31_cod_empresa;',
'EXCEPTION',
'WHEN OTHERS THEN',
'  NULL;',
'END;',
'',
'begin',
'',
'select ',
' texto,',
' texto_prov_mediatas,',
' texto_prov_imediatas,',
' num_analise_acidente_servico',
' into',
' :p31_servico_texto,',
' :p31_texto_prov_mediatas,',
' :p31_texto_prov_imediatas,',
' :p31_num_analise_acidente_servico',
'from ANALISE_ACIDENTE_SERVICO',
' where cod_empresa = :p31_cod_empresa',
' and cod_analise_acidente = :p31_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select texto,',
' observacao ',
' into  :p31_descricao_texto,',
' :p31_descricao_observacao',
' from ANALISE_ACIDENTE_DESCRICAO',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'-- ch45802   and NUM_ANALISE_ACIDENTE_DESCRICAO = :p31_num_analise_acidente_servico;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select  texto_dados_pessoais,',
' texto_dados_materiais,',
' texto_dados_producao',
' into  :p31_texto_dados_pessoais,',
' :p31_texto_dados_materiais,',
' :p31_texto_dados_producao',
'from ANALISE_ACIDENTE_CONSEQUENCIA',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'begin',
'',
'select texto,',
' plano_oque,',
' plano_como,',
' plano_quando,',
' tipo_acao',
' into ',
'  :p31_plano_texto,',
' :p31_plano_oque,',
' :p31_plano_como,',
' :p31_plano_quando,',
' :p31_tipo_acao',
'from ANALISE_ACIDENTE_PROVIDENCIA',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select item_1,',
'		item_2,',
'		item_3,',
'		item_4,',
'		item_5,',
'		item_6,',
'		efeito',
'  into  :p31_item_1,',
' :p31_item_2,',
' :p31_item_3,',
' :p31_item_4,',
' :p31_item_5,',
' :p31_item_6,',
' :p31_efeito',
'  from causa_efeito',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select texto',
'  into :p31_conclusao_texto',
'  from analise_acidente_conclusao',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
':P31_HORAS_TRAB := nvl(:P31_HORAS_TRAB,''00:00'');',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P31_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29870678306499526763)
,p_process_sequence=>60
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Apex_collections COL_PARTE_LESADA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_collection_name VARCHAR2(30) := ''COL_PARTE_LESADA'';',
'BEGIN',
'    IF APEX_COLLECTION.COLLECTION_EXISTS(v_collection_name) THEN',
'        APEX_COLLECTION.TRUNCATE_COLLECTION(v_collection_name);',
'    ELSE',
'        APEX_COLLECTION.CREATE_COLLECTION(v_collection_name);',
'    END IF;',
'',
'    IF :P31_COD_ANALISE_ACIDENTE IS NOT NULL THEN',
'        -- Trazemos o ROWID do banco convertido para string (ROWIDTOCHAR)',
'        FOR r IN (SELECT ROWIDTOCHAR(rowid) as id_linha,',
'                         cod_empresa,',
'                         matricula,',
'                         dc_matricula,',
'                         cod_parte_lesada,',
'                         descricao_parte_lesada,',
'                         lateralidade,',
'                         cod_natureza_lesao',
'                    FROM analise_func_parte_lesada',
'                   WHERE cod_analise_acidente = :P31_COD_ANALISE_ACIDENTE)',
'        LOOP',
'            APEX_COLLECTION.ADD_MEMBER (',
'                p_collection_name => v_collection_name,',
'                p_n001            => r.matricula,',
'                p_c001            => r.dc_matricula,',
'                p_n002            => r.cod_parte_lesada,',
'                p_c002            => r.descricao_parte_lesada,',
'                p_c003            => r.lateralidade,',
'                p_n003            => r.cod_natureza_lesao,',
'                p_n004            => r.cod_empresa,',
'                p_c050            => r.id_linha -- Guardado aqui!',
'            );',
'        END LOOP;',
'    END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125283219639794179265)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ltrim(to_char(nvl(max(to_number(cod_analise_acidente)),0) + 1)) cod',
'  from ANALISE_ACIDENTE',
' where cod_empresa = :p31_cod_empresa; ',
'           ',
'v_c1 c1%rowtype;',
'           ',
'begin',
' ',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  :p31_cod_analise_acidente := nvl(v_c1.cod,1); ',
'',
'  :p31_status_cat := ''P'';',
'',
'  :p31_cod_emp_solicitante := :p_empresa_user;',
'  :p31_mat_solicitante := :p_matricula_user;',
'  ',
'',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(74065372792462272970)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'AtualizaCampo '
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P31_TIPO_LOCAL_ACIDENTE = 4 THEN',
'  :P31_IND_TRAJETO        :=''S'';',
'END IF;',
'',
':P31_DC_MATRICULA := nvl(:P31_DC_MATRICULA,0);'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125127001556999840889)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of ANALISE_ACIDENTE'
,p_attribute_02=>'ANALISE_ACIDENTE'
,p_attribute_03=>'P31_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'N'
,p_process_error_message=>'#SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('A\00E7\00E3o realizada com sucesso!')
,p_process_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'cod_empresa = :p31_cod_empresa',
'rutime where clause'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128206229450328560)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(125128205276121328550)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'IG - EPIs - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128207648509328574)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(125128206406133328562)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'IG - Custo - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29872841437847898351)
,p_process_sequence=>69
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(29872839526896898332)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('For\00E7ar Valores Grid')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    :COD_EMPRESA         := COALESCE(:P31_COD_EMPRESA, :COD_EMPRESA);',
'    :MATRICULA           := COALESCE(:P31_MATRICULA, :MATRICULA);',
'    :DC_MATRICULA        := NVL(COALESCE(:P31_DC_MATRICULA, :DC_MATRICULA),0);',
'    :COD_ANALISE_ACIDENTE     := :P31_COD_ANALISE_ACIDENTE;',
'    :USUARIO                  := :P_USUARIO;',
'    :DT_ATUALIZACAO            := SYSDATE;',
'   ',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29872841160083898348)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(29872839526896898332)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'IG - Parte Corpo Atingida - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128787468764457742)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from ANALISE_FUNC',
' where cod_empresa = :P31_cod_empresa',
'   and cod_analise_acidente = :P31_cod_analise_acidente;',
'',
'insert into ANALISE_FUNC',
'(COD_EMPRESA,',
' COD_ANALISE_ACIDENTE,',
' MATRICULA,',
' DC_MATRICULA,',
'TIPO_ANALISE,',
'COD_CCUSTO,',
'IND_OBITO,',
'DT_OBITO,',
'COD_FATOR_PESSOAL,',
'IND_ACIDENTE_ANTERIOR,',
'COD_ATO_INSEGURO,',
'IND_EXPERIENCIA_OPERACAO,',
'COD_CONDICAO_INSEGURA,',
'COD_AGENTE_LESAO,',
'COD_FATOR_TRABALHO,',
'IND_PROT_TIPO_ACIDENTE,',
'IND_AFASTAMENTO,',
'QUANTIDADE_DIAS_AFASTAMENTO,',
'DT_RETORNO,',
'CID,',
'CODIGO,',
'COD_EMPRESA_SUP_IMEDIATO,',
'MATRICULA_SUP_IMEDIATO,',
'DC_MATRICULA_SUP_IMEDIATO,',
'DIAGNO_PROVAVEL,',
'OBSERVACAO_CAT,',
'IND_DEPTO_POLICIAL,                      ',
'NUM_BOLETIM_OCORR,                    ',
'DATA_BOLETIM_OCORR,',
'usuario,',
'dt_atualizacao)',
' values(',
':P31_COD_EMPRESA,',
':P31_COD_ANALISE_ACIDENTE,',
':P31_MATRICULA,',
':P31_DC_MATRICULA,',
':P31_TIPO_ANALISE,',
':P31_COD_CCUSTO,',
':P31_IND_OBITO,',
':P31_DT_OBITO,',
':P31_COD_FATOR_PESSOAL,',
':P31_IND_ACIDENTE_ANTERIOR,',
':P31_COD_ATO_INSEGURO,',
':P31_IND_EXPERIENCIA_OPERACAO,',
':P31_COD_CONDICAO_INSEGURA,',
':P31_COD_AGENTE_LESAO,',
':P31_COD_FATOR_TRABALHO,',
':P31_IND_PROT_TIPO_ACIDENTE,',
':P31_IND_AFASTAMENTO,',
':P31_QTD_DIAS_AFASTAMENTO,',
':P31_DT_RETORNO,',
':P31_CID,',
':P31_CODIGO,',
':P31_COD_EMPRESA_SUP_IMEDIATO,',
':P31_MATRICULA_SUP_IMEDIATO,',
':P31_DC_MATRICULA_SUP_IMEDIATO,',
':P31_DIAGNO_PROVAVEL,',
':P31_OBSERVACAO_CAT,',
':P31_IND_DEPTO_POLICIAL,                      ',
':P31_NUM_BOLETIM_OCORR,                    ',
':P31_DATA_BOLETIM_OCORR,',
' :p_usuario,',
' sysdate);',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502361545447439)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Servi\00E7o / Provid\00EAncia')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from ANALISE_ACIDENTE_SERVICO',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'ANALISE_ACIDENTE_SERVICO',
'(cod_empresa,',
' cod_analise_acidente,',
' num_analise_acidente_servico,',
' texto,',
' texto_prov_mediatas,',
' texto_prov_imediatas,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_num_anal,',
' :p31_servico_texto,',
' :p31_texto_prov_mediatas,',
' :p31_texto_prov_imediatas,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Servi\00E7o/Provid\00EAncia: ''||sqlerrm);'),
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502494864447440)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Descri\00E7\00E3o do Acidente')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from ANALISE_ACIDENTE_DESCRICAO',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'ANALISE_ACIDENTE_DESCRICAO',
'(cod_empresa,',
' cod_analise_acidente,',
' num_ANALISE_ACIDENTE_DESCRICAO,',
' texto,',
' observacao,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_num_anal,',
' :p31_descricao_texto,',
' :p31_descricao_observacao,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Descri\00E7\00E3o do Acidente: ''||sqlerrm);'),
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502544682447441)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Consequ\00EAncia')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from ANALISE_ACIDENTE_CONSEQUENCIA',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'ANALISE_ACIDENTE_CONSEQUENCIA',
'(cod_empresa,',
' cod_analise_acidente,',
' texto_dados_pessoais,',
' texto_dados_materiais,',
' texto_dados_producao,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_texto_dados_pessoais,',
' :p31_texto_dados_materiais, ',
' :p31_texto_dados_producao,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Consequ\00EAncias: ''||sqlerrm);'),
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502689140447442)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Plano e A\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*begin',
'',
'delete from ANALISE_ACIDENTE_PROVIDENCIA',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'ANALISE_ACIDENTE_PROVIDENCIA',
'(cod_empresa,',
' cod_analise_acidente,',
' num_ANALISE_ACIDENTE_PROVIDEN,',
' texto,',
' plano_oque,',
' plano_como,',
' plano_quando,',
' tipo_acao,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_num_anal,',
' :p31_plano_texto,',
' :p31_plano_oque,',
' :p31_plano_como,',
' :p31_plano_quando,',
' :p31_tipo_acao,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Plano e A\00E7\00E3o: ''||sqlerrm);'),
'rollback;',
'end;*/',
'',
'declare',
' v_cont number;',
'begin ',
'  select count(*)',
'    into v_cont',
'    from ANALISE_ACIDENTE_PROVIDENCIA',
'   where cod_empresa = :p31_cod_empresa',
'     and cod_analise_acidente = :p31_cod_analise_acidente;',
'   if v_cont = 0 then  ',
'       insert into ',
'        ANALISE_ACIDENTE_PROVIDENCIA',
'        (cod_empresa,',
'         cod_analise_acidente,',
'         num_ANALISE_ACIDENTE_PROVIDEN,',
'         texto,',
'         plano_oque,',
'         plano_como,',
'         plano_quando,',
'         tipo_acao,',
'         usuario,',
'         dt_atualizacao)',
'        values',
'        (:p31_cod_empresa,',
'         :p31_cod_analise_acidente,',
'         :p31_num_anal,',
'         :p31_plano_texto,',
'         :p31_plano_oque,',
'         :p31_plano_como,',
'         :p31_plano_quando,',
'         :p31_tipo_acao,',
'         :p_usuario,',
'         sysdate',
'        );',
'    else',
'     update ANALISE_ACIDENTE_PROVIDENCIA',
'        set num_ANALISE_ACIDENTE_PROVIDEN = :p31_num_anal,',
'            texto = :p31_plano_texto,',
'            plano_oque = :p31_plano_oque,',
'            plano_como = :p31_plano_como,',
'            plano_quando = :p31_plano_quando,',
'            tipo_acao = :p31_tipo_acao,',
'            usuario = :p_usuario,',
'            dt_atualizacao = sysdate',
'      where cod_empresa = :p31_cod_empresa',
'        and cod_analise_acidente = :p31_cod_analise_acidente;',
'   end if; ',
'   ',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(-20000,''Erro ao gravar Plano e A\00E7\00E3o: ''||sqlerrm);'),
'rollback;',
'end;   '))
,p_process_error_message=>unistr('Erro no processo a\00E7\00E3o - #SQLERRM#')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502768976447443)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Diagrama de Causa/Efeito (6Ms)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from causa_efeito',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'causa_efeito',
'(cod_empresa,',
' cod_analise_acidente,',
' item_1,',
' item_2,',
' item_3,',
' item_4,',
' item_5,',
' item_6,',
' efeito)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_item_1,',
' :p31_item_2,',
' :p31_item_3,',
' :p31_item_4,',
' :p31_item_5,',
' :p31_item_6,',
' :p31_efeito',
');',
'',
'commit;',
'',
'exception',
'when others then',
'raise_application_error(20000,''Erro ao gravar Diagrama de Causa/Efeito (6Ms): ''||sqlerrm);',
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125128502852025447444)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Conclus\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from analise_acidente_conclusao',
' where cod_empresa = :p31_cod_empresa',
'   and cod_analise_acidente = :p31_cod_analise_acidente;',
'',
'insert into ',
'analise_acidente_conclusao',
'(cod_empresa,',
' cod_analise_acidente,',
' num_ANALISE_ACIDENTE_conclusao,',
' texto,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p31_cod_empresa,',
' :p31_cod_analise_acidente,',
' :p31_num_anal,',
' :p31_conclusao_texto,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Conclus\00E3o: ''||sqlerrm);'),
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125127001991591840889)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(125126959719630840839)
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
