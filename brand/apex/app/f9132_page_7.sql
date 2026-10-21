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
,p_default_application_id=>9132
,p_default_id_offset=>697006730928911864
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9132 - Movimentações Financeiro - Menu
--
-- Application Export:
--   Application:     9132
--   Name:            Movimentações Financeiro - Menu
--   Date and Time:   11:37 Friday October 9, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 7
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00007
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>7);
end;
/
prompt --application/pages/page_00007
begin
wwv_flow_api.create_page(
 p_id=>7
,p_user_interface_id=>wwv_flow_api.id(34587025913134988484)
,p_name=>unistr('Lan\00E7amentos de Ocorr\00EAncias')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Lan\00E7amentos de Ocorr\00EAncias')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LancFicha.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LancFicha.css'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'button.hide(); //hide the button',
'',
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
'    if (!e.key.match(/[0-9.,]/)) {',
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
'    el.value = el.value.replace(/[^0-9.,]/g, '''');',
'  });',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.apex-item-multi{',
'max-width: 100% !important;',
'}'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_last_updated_by=>'YLEM.ARNALDO'
,p_last_upd_yyyymmddhh24miss=>'20250911101934'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12726967674887233684)
,p_plug_name=>unistr('Ocorr\00EAncias -  &P7_PROC_TXT.')
,p_region_name=>'IGOCORR'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999916296988390)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'LANCTO_OCORR_TMP'
,p_query_where=>'seqId = :P7_SEQ_OCORR'
,p_query_order_by=>'cod_ocorr, cod_empresa, data_ref'
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P7_SEQ_OCORR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727160898746000252)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>160
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727160950956000253)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>170
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727161668867000260)
,p_name=>'SEQID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SEQID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>190
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P7_SEQ_OCORR'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727161816172000261)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'EMPRESA'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>200
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(e.cod,3,''0'')||'' - ''||e.nome det',
'      ,e.cod              ret',
'  FROM empresas e',
' WHERE (e.cod = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'   AND e.cod IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_EMPRESAS, '':'')) t)',
'ORDER BY 2'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_FUNCTION_BODY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  NUMBER DEFAULT NULL;',
'BEGIN',
'  IF INSTR(:P7_EMPRESAS,'':'') = 0 THEN',
'    vReturn := :P7_EMPRESAS;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727161907616000262)
,p_name=>'COD_OCORR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_OCORR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('OCORR\00CANCIA')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Ocorr\00EAncias')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(o.cod,4,''0'')||'' ''||o.dc_cod||'' - ''||o.nome det',
'       ,o.cod                                          ret',
'  FROM ocorr_pagto o',
' WHERE o.cod_empresa = :COD_EMPRESA',
'   AND (o.cod        = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'   AND o.incid_aceita_manual = ''S''',
'ORDER BY o.cod, o.cod_empresa'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'COD_EMPRESA'
,p_ajax_items_to_submit=>'COD_EMPRESA'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162037861000263)
,p_name=>'DC_OCORR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_OCORR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_03=>'left'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162141864000264)
,p_name=>'VALOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VALOR'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'VALOR'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>230
,p_value_alignment=>'LEFT'
,p_attribute_01=>'0.00'
,p_attribute_02=>'9999999999999.99'
,p_attribute_03=>'left'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_item_placeholder=>'-'
,p_item_css_classes=>'no-space'
,p_is_required=>false
,p_max_length=>16
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
 p_id=>wwv_flow_api.id(12727162172714000265)
,p_name=>'DATA_REF'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATA_REF'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('DT. REFER\00CANCIA')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>240
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Datas de Refer\00EAncia')
,p_attribute_08=>'250'
,p_attribute_09=>'380'
,p_format_mask=>'DD/MM/RRRR'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT l.display  det',
'      ,l.data_ref ret',
'  FROM list_hist_finan_datas l',
' WHERE TRUNC(l.data_ref,''month'') >= ADD_MONTHS(TRUNC(SYSDATE,''month''),-60)',
'ORDER BY 2 DESC ',
''))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_is_required=>false
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
 p_id=>wwv_flow_api.id(12727162336637000266)
,p_name=>'DT_INIC_VAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INIC_VAL'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('DT. IN\00CDCIO VALIDADE')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>250
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
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
 p_id=>wwv_flow_api.id(12727162419265000267)
,p_name=>'DT_FIN_VAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_FIN_VAL'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'DT. FIM VALIDADE'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>260
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/RRRR'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
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
 p_id=>wwv_flow_api.id(12727162468309000268)
,p_name=>'DT_INIC_EVENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INIC_EVENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('DT. IN\00CDCIO EVENTO')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>280
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P7_PROCESSO'
,p_display_condition2=>'1:6'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162586991000269)
,p_name=>'DT_FIN_EVENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_FIN_EVENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'DT. FIM EVENTO'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>290
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P7_PROCESSO'
,p_display_condition2=>'1:6'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162707493000270)
,p_name=>'UNIDADE1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UNIDADE1'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>300
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162815192000271)
,p_name=>'UNIDADE2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UNIDADE2'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>310
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727162913559000272)
,p_name=>'HORAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORAS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>320
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727163010624000273)
,p_name=>'MINUTOS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MINUTOS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>330
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727163136648000274)
,p_name=>'FAIXA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FAIXA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'FAIXA'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>340
,p_value_alignment=>'LEFT'
,p_attribute_03=>'left'
,p_item_placeholder=>'-'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(12727163186060000275)
,p_name=>'PARC_ORIG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARC_ORIG'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('N\00BA PARCELA ORIG.')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>350
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_placeholder=>'-'
,p_item_attributes=>'readonly'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(12727163296669000276)
,p_name=>'PARC_NOVA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARC_NOVA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>unistr('N\00BA PARCELA NOVA')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>360
,p_value_alignment=>'LEFT'
,p_attribute_03=>'left'
,p_item_placeholder=>'-'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(12727163377991000277)
,p_name=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBSERVACAO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'OBS.'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>370
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_item_width=>4000
,p_item_height=>10
,p_item_placeholder=>'-'
,p_is_required=>false
,p_max_length=>4000
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
 p_id=>wwv_flow_api.id(12727163452399000278)
,p_name=>'HORA_QTD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_QTD'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'HORA / QTD.'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>380
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_max_length=>10
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
 p_id=>wwv_flow_api.id(12727163617482000279)
,p_name=>'MIN_DIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MIN_DIA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'MINUTO / DIA'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>390
,p_value_alignment=>'LEFT'
,p_attribute_03=>'left'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_max_length=>10
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
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
 p_id=>wwv_flow_api.id(12727163823155000281)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727219563038374679)
,p_name=>'IND_DUPLIC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IND_DUPLIC'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>400
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727220290377374686)
,p_name=>'IND_VALOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IND_VALOR'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>410
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_static_id=>'VAL'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12727220406003374687)
,p_name=>'IND_FAIXA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IND_FAIXA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>420
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly'
,p_is_required=>false
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
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12729970660171973084)
,p_name=>'IND_UNID1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IND_UNID1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>430
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(12729970830464973085)
,p_name=>'IND_UNID2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IND_UNID2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>440
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_attributes=>'readonly'
,p_is_required=>false
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
 p_id=>wwv_flow_api.id(12730103378625959167)
,p_name=>'DT_RETENCAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_RETENCAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('DT. RETEN\00C7\00C3O')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>270
,p_value_alignment=>'LEFT'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/RRRR'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P7_PROCESSO'
,p_display_condition2=>'1:2:5:6'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12730103765082959171)
,p_name=>'COD_FAMILIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_FAMILIA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('FAM\00CDLIA')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>450
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Fam\00EDlias')
,p_attribute_08=>'350'
,p_attribute_09=>'380'
,p_item_placeholder=>'-'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT b.cod_familia||''-''||b.descricao_familia det',
'      ,b.cod_familia                           ret',
'  FROM beneficios_familia b',
' WHERE b.cod_empresa = :COD_EMPRESA',
'   AND (b.cod_familia = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'   AND (b.dt_inicio_familia <= TRUNC(SYSDATE) AND (b.dt_fim_familia >= TRUNC(SYSDATE) OR b.dt_fim_familia IS NULL))',
'ORDER BY 2'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'COD_EMPRESA'
,p_ajax_items_to_submit=>'COD_EMPRESA'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_condition=>'P7_PROCESSO'
,p_display_condition2=>'6'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12730103888453959172)
,p_name=>'SIT_FECHAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SIT_FECHAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'FECHAMENTO'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>460
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:N-Pendente;N'
,p_lov_display_extra=>false
,p_lov_display_null=>false
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
,p_default_type=>'STATIC'
,p_default_expression=>'N'
,p_duplicate_value=>true
,p_include_in_export=>false
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_condition=>'P7_PROCESSO'
,p_display_condition2=>'6'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12846465701688144481)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('MATR\00CDCULAS')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>480
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Matr\00EDculas')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
,p_item_placeholder=>'- Todas -'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.matricula||''-''||p.nome det  --LPAD(p.matricula,6,''0'')||''-''||p.nome det',
'      ,p.matricula              ret',
'  FROM inf_pessoais p',
' WHERE p.cod_empresa = :COD_EMPRESA',
'   AND (p.matricula  = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'   AND EXISTS(SELECT 1',
'                FROM informacoes_funcionais f',
'               WHERE f.cod_empresa  = p.cod_empresa',
'                 AND f.matricula    = p.matricula',
'                 AND f.dc_matricula = p.dc_matricula',
'                 AND (:P7_FILIAIS IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_FILIAIS, '':'')) t))',
'                 AND (:P7_CCUSTOS IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_CCUSTOS, '':'')) t))',
'                 AND (:P7_CARGOS  IS NULL OR f.cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_CARGOS, '':'')) t))',
'                 AND ((:P7_DTADMINI IS NULL AND :P7_DTADMFIM IS NULL) OR (f.dt_admissao_basica BETWEEN TO_DATE(:P7_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P7_DTADMFIM,''DD/MM/RRRR''))) ',
'                 AND (:P7_SITUACOES IS NULL OR f.situacao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_SITUACOES, '':'')) t))',
'                 AND (:P7_VINCULOS  IS NULL OR f.vinculo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_VINCULOS, '':'')) t))',
'                 AND (:P7_SINDICATOS  IS NULL OR f.num_sind_diss IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_SINDICATOS, '':'')) t))',
'                 AND (:P7_TIPOSAL  IS NULL OR f.tipo_salario IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_TIPOSAL, '':'')) t))',
'                 AND (:P7_TIPOPAG  IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_TIPOPAG, '':'')) t))',
'                 AND (:P7_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_MATRICULAS, '':'')) t)) ',
'                 AND ((f.situacao < ''90'' OR f.situacao = ''98'') OR ((f.situacao >= ''90'' AND f.situacao <> ''98'') AND',
'                      (:P7_DATASIT   IS NULL OR (f.dt_situacao = TO_DATE(:P7_DATASIT,''DD/MM/RRRR''))) AND',
'                      (:P7_MESANOSIT IS NULL OR (:P5_MESANOSIT IS NOT NULL AND (pkg_MovtFinanceiro.fnc_VerifDtSitDemtido(:P7_MESANOSIT, f.situacao, f.dt_situacao) = ''S'')) )))          ',
'              ',
'             )         ',
'ORDER BY p.matricula, p.cod_empresa'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'COD_EMPRESA'
,p_ajax_items_to_submit=>'COD_EMPRESA'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_help_text=>unistr('Somente informe a matr\00EDcula para lan\00E7amento individual. Se a matr\00EDcula n\00E3o for informada, o lan\00E7amento ser\00E1 atribu\00EDdo a TODAS as matr\00EDculas da sua lista de valores.')
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(12846465794833144482)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>490
,p_value_alignment=>'LEFT'
,p_attribute_03=>'left'
,p_item_placeholder=>'-'
,p_is_required=>false
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
end;
/
begin
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(12726967873319233686)
,p_internal_uid=>15790328585748647
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
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
,p_no_data_found_message=>'Nenhum Dado Retornado!'
,p_show_toolbar=>true
,p_toolbar_buttons=>'ACTIONS_MENU:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_enable_mail_download=>true
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>375
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(12727165826121018224)
,p_interactive_grid_id=>wwv_flow_api.id(12726967873319233686)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(12727165850434018224)
,p_report_id=>wwv_flow_api.id(12727165826121018224)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727167262046018231)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(12727160950956000253)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727167767127018233)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(12727161668867000260)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727168323217018234)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(12727161816172000261)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>260
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727168750901018236)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(12727161907616000262)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>340
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727169344486018238)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(12727162037861000263)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727169818391018239)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(12727162141864000264)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727170286661018241)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(12727162172714000265)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>125
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727170772717018243)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(12727162336637000266)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727171320109018245)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(12727162419265000267)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727171829818018246)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(12727162468309000268)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727172331315018248)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(12727162586991000269)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727172784989018250)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(12727162707493000270)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727173250143018251)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(12727162815192000271)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727173817842018253)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(12727162913559000272)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727174292919018254)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(12727163010624000273)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727174791963018256)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(12727163136648000274)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>60
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727175290437018257)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(12727163186060000275)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>125
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727175830918018259)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(12727163296669000276)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>125
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727176247528018260)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(12727163377991000277)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727176823519018262)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(12727163452399000278)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727177259199018263)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(12727163617482000279)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>100
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12727179546544053511)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(12727163823155000281)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12729941808419674048)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>26
,p_column_id=>wwv_flow_api.id(12727219563038374679)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12729999358383998505)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(12727220290377374686)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12729999904125998508)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>28
,p_column_id=>wwv_flow_api.id(12727220406003374687)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12730089620985763757)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(12729970660171973084)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12730090204411763761)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>30
,p_column_id=>wwv_flow_api.id(12729970830464973085)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12733436859440934874)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(12730103378625959167)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12741465287216242095)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(12730103765082959171)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>260
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12741465756348242106)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(12730103888453959172)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12917532064073078861)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(12846465701688144481)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>360
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(12917532533929079049)
,p_view_id=>wwv_flow_api.id(12727165850434018224)
,p_display_seq=>31
,p_column_id=>wwv_flow_api.id(12846465794833144482)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12739779043290500662)
,p_plug_name=>'Parametros'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586991838802988376)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12741899099430227756)
,p_plug_name=>unistr('LOG Lan\00E7amentos - &P7_PROC_TXT.')
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noBorder:t-Region--hiddenOverflow:t-Form--noPadding:t-Form--leftLabels:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586999916296988390)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(12741897457743227740)
,p_name=>unistr('Log Ocorr\00EAncias Func')
,p_parent_plug_id=>wwv_flow_api.id(12741899099430227756)
,p_template=>wwv_flow_api.id(34586999396255988388)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:t-Form--noPadding:margin-top-sm:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.seqId seq_id',
'      ,x.id    idx',
'      ,x.cod_empresa',
'      ,x.cod_matricula',
'      ,x.erro',
'      ,LPAD(TO_CHAR(x.id), 7, ''0'') Id',
'      ,(SELECT e.cod||''-''||e.nome FROM empresas e WHERE e.cod = x.cod_empresa) empresa',
'      ,(SELECT p.matricula||''-''||p.nome FROM inf_pessoais p WHERE p.cod_empresa = x.cod_empresa AND p.matricula = x.cod_matricula) matricula',
'  FROM log_lancto_ocorr_tmp x',
' WHERE x.seqId = :P7_SEQ_OCORR',
'ORDER BY 2'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P7_SEQ_OCORR'
,p_query_row_template=>wwv_flow_api.id(34587008727850988406)
,p_query_num_rows=>50
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Dado Encontrado!!'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'Y'
,p_csv_output_link_text=>'Download'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12741898277512227748)
,p_query_column_id=>1
,p_column_alias=>'SEQ_ID'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12742244153266555965)
,p_query_column_id=>2
,p_column_alias=>'IDX'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12742244262790555966)
,p_query_column_id=>3
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12742244361130555967)
,p_query_column_id=>4
,p_column_alias=>'COD_MATRICULA'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12742244533151555968)
,p_query_column_id=>5
,p_column_alias=>'ERRO'
,p_column_display_sequence=>8
,p_column_heading=>'ERRO'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<nobr>#ERRO#</nobr>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12741900018517227765)
,p_query_column_id=>6
,p_column_alias=>'ID'
,p_column_display_sequence=>5
,p_column_heading=>'ID'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<nobr>#ID#</nobr>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12741898687378227752)
,p_query_column_id=>7
,p_column_alias=>'EMPRESA'
,p_column_display_sequence=>6
,p_column_heading=>'EMPRESA'
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(12741898819330227753)
,p_query_column_id=>8
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>7
,p_column_heading=>unistr('MATR\00CDCULA')
,p_use_as_row_header=>'N'
,p_column_html_expression=>'<nobr>#MATRICULA#</nobr>'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(48000642159629338278)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding'
,p_plug_template=>wwv_flow_api.id(34586991921974988377)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12739991177086494872)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(48000642159629338278)
,p_button_name=>'Cancelar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34587020707894988434)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12742242662912555950)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(48000642159629338278)
,p_button_name=>'Close'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34587020707894988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12739991934892494872)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(48000642159629338278)
,p_button_name=>'Create'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34587020707894988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Processar Lan\00E7amentos')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10018367658055909690)
,p_name=>'P7_DTVALINI'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10018367717780909691)
,p_name=>'P7_DTVALFIM'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12727216274139374646)
,p_name=>'P7_SEQ_OCORR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12727216842164374651)
,p_name=>'P7_EXISTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12727218132023374664)
,p_name=>'P7_CONFIRMA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12730102296670959156)
,p_name=>'P7_ERR_MSG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12730103474039959168)
,p_name=>'P7_DEMITIDOS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(48000642159629338278)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Processar Demitidos?;S'
,p_tag_css_classes=>'u-bold'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P7_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P7_SITUACOES, '':''))) t',
'                                 WHERE COLUMN_VALUE >= ''90'' AND COLUMN_VALUE <> ''98'')'))
,p_display_when_type=>'SQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(34587020267290988427)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12730103553849959169)
,p_name=>'P7_TRANSFERIDOS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(48000642159629338278)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Processar Transferidos?;S'
,p_tag_css_classes=>'u-bold'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P7_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P7_SITUACOES, '':''))) t',
'                                 WHERE COLUMN_VALUE = ''98'')'))
,p_display_when_type=>'SQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(34587020267290988427)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12739779151036500663)
,p_name=>'P7_ACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12739779290544500664)
,p_name=>'P7_PROCESSO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12739780274070500674)
,p_name=>'P7_EMPRESAS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12739780372308500675)
,p_name=>'P7_CODAUX'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12739781841776500690)
,p_name=>'P7_PROC_TXT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741488808625585756)
,p_name=>'P7_FILIAIS'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741489212825585758)
,p_name=>'P7_CCUSTOS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741489531549585758)
,p_name=>'P7_CARGOS'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741489957110585758)
,p_name=>'P7_DTADMINI'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741490368685585759)
,p_name=>'P7_DTADMFIM'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741490749265585759)
,p_name=>'P7_SITUACOES'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741491132148585759)
,p_name=>'P7_VINCULOS'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741491609591585759)
,p_name=>'P7_SINDICATOS'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741491935463585759)
,p_name=>'P7_TIPOSAL'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741492338867585760)
,p_name=>'P7_TIPOPAG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741492806936585760)
,p_name=>'P7_MATRICULAS'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741493115984585761)
,p_name=>'P7_DATAREF'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741493577685585761)
,p_name=>'P7_TIPOEVENT'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741493992754585761)
,p_name=>'P7_OCORRPAGTO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741899155131227757)
,p_name=>'P7_EXEC_PROCESSO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741899492400227760)
,p_name=>'P7_CTRL_PROCESSO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12741899559778227761)
,p_name=>'P7_LOG_PROCESSO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13015221667998361464)
,p_name=>'P7_USUARIO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13015221852446361466)
,p_name=>'P7_DTATLZ'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13015221949299361467)
,p_name=>'P7_DATASIT'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13015222132446361468)
,p_name=>'P7_MESANOSIT'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(12739779043290500662)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12727218613923374669)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Empresa'
,p_validation_sequence=>10
,p_validation=>'COD_EMPRESA'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'#COLUMN_HEADER# deve ser informada!'
,p_associated_column=>'COD_EMPRESA'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12727218680755374670)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>unistr('Valida Ocorr\00EAncia')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :COD_OCORR IS NULL THEN',
unistr('    vReturn := ''OCORR\00CANCIA deve ser informada!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'COD_OCORR'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12730104278071959176)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>unistr('Valida DT. Reten\00E7\00E3o')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P7_PROCESSO IN(1,2,5,6) AND :DT_RETENCAO IS NULL THEN',
'    IF :P7_PROCESSO  = 6  THEN',
unistr('      vReturn := ''DT. RETEN\00C7\00C3O deve ser informada!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P7_PROCESSO'
,p_validation_condition2=>'1:2:5:6'
,p_validation_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_RETENCAO'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12727218769480374671)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Data Ref'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  CURSOR cMatr IS',
'    SELECT COLUMN_VALUE matricula',
'      FROM TABLE(APEX_STRING.split(:MATRICULA, '':''))',
'    ORDER BY TO_NUMBER(COLUMN_VALUE);   ',
'BEGIN',
'  IF :DATA_REF IS NULL THEN',
unistr('    vReturn := ''DT. REFER\00CANCIUA deve ser informada!'';'),
'  ELSE',
'    IF :P7_PROCESSO IN(1,2,3,4,5,6) THEN',
'      vReturn := pkg_MovtFinanceiro.fnc_VerifDtRefParamRH(pEmp      => :COD_EMPRESA',
'                                                         ,pDtRef    => :DATA_REF',
'                                                         ,pProcesso => :P7_PROCESSO);',
'      --',
'      IF :P7_PROCESSO = 3 THEN',
'        IF vReturn IS NULL AND :MATRICULA IS NOT NULL THEN',
'          FOR r IN cMatr LOOP',
'            vReturn := pkg_MovtFinanceiro.fnc_VerifDtRefFerias(pEmp   => :COD_EMPRESA',
'                                                              ,pMatr  => r.matricula --:MATRICULA',
'                                                              ,pDtRef => :DATA_REF);',
'            IF vReturn IS NOT NULL THEN',
'              EXIT;',
'            END IF;                                                              ',
'          END LOOP;                                                  ',
'        END IF;',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'DATA_REF'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12729970061218973078)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Valor'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  CURSOR cValMax IS',
'    SELECT o.alerta_valor_max',
'      FROM ocorr_pagto o',
'     WHERE o.cod_empresa = :COD_EMPRESA',
'       AND O.cod         = :COD_OCORR;',
'  --',
'  vValMax    ocorr_pagto.alerta_valor_max%TYPE DEFAULT 0;',
'  vValorC    VARCHAR2(25) DEFAULT :VALOR;',
'  vValor     ocorr_pagto.alerta_valor_max%TYPE;   ',
'BEGIN',
'  IF :VALOR IS NOT NULL THEN',
'    vValorC := REPLACE(REPLACE(vValorC,''R$''),''.''); ',
'    vValor  := TO_NUMBER(vValorC, ''9999999999999D99'');',
'    --',
'    IF :IND_VALOR = ''N'' THEN',
unistr('      vReturn := ''VALOR n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'    ELSIF :IND_VALOR = ''S'' THEN',
'      OPEN cValMax;',
'      FETCH cValMax INTO vValMax;',
'      CLOSE cValMax;',
'      --',
'      --IF vValMax IS NOT NULL AND :VALOR > NVL(vValMax, 0) THEN',
'      IF vValMax IS NOT NULL AND vValor > NVL(vValMax, 0) THEN',
unistr('        --vReturn := ''VALOR superior ao m\00E1ximo parametrizado [''||vValMax||'']!'';'),
unistr('        vReturn := ''VALOR superior ao m\00E1ximo parametrizado [''||TO_CHAR(vValMax, ''FML999999999D90'')||'']!'';'),
'      END IF;',
'    END IF;',
'  ELSE',
'    IF :IND_VALOR = ''S'' THEN',
'       IF (NVL(:IND_UNID1,''N'') = ''N'') AND (NVL(:IND_UNID2,''N'') = ''N'') THEN',
'        vReturn := ''VALOR deve ser informado!'';',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'VALOR'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12729970173489973079)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Faixa'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :FAIXA IS NOT NULL AND :IND_FAIXA = ''N'' THEN',
unistr('    vReturn := ''FAIXA n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'FAIXA'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12729970908965973086)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Hora Qtd.'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :HORA_QTD IS NOT NULL THEN',
'    IF :IND_UNID1 = ''N'' THEN',
unistr('      vReturn := ''HORA/QTD. n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'    END IF;',
'  ELSE',
'    IF :IND_UNID1 = ''S'' THEN',
'      IF :IND_VALOR = ''N'' OR :IND_VALOR IS NULL THEN',
'        vReturn := ''HORA/QTD. deve ser informado!'';',
'      END IF;',
'    END IF;  ',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'HORA_QTD'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12729971230608973089)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Min. Dia'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :MIN_DIA IS NOT NULL THEN',
'    IF :IND_UNID2 = ''N'' THEN',
unistr('      vReturn := ''MINUTO/DIA. n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'    ELSIF :IND_UNID2 = ''S'' THEN ',
'      IF :MIN_DIA > 59 THEN',
unistr('        vReturn := ''MINUTO n\00E3o deve ser maior que 59!'';'),
'      END IF;',
'    END IF; ',
'  ELSE',
'    IF :IND_UNID2 = ''S'' THEN',
'      IF :IND_VALOR = ''N'' OR :IND_VALOR IS NULL THEN',
'        vReturn := ''MINUTO/DIA. deve ser informado!'';',
'      END IF;',
'    END IF;     ',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'MIN_DIA'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12730101123045959144)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Dt. Inicial Val.'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :DT_INIC_VAL IS NULL AND :DT_FIN_VAL IS NOT NULL THEN',
unistr('    vReturn := ''DT. IN\00CDCIO VALIDADE deve ser informada!'';'),
'  ELSIF :DT_INIC_VAL IS NOT NULL AND :DT_FIN_VAL IS NOT NULL THEN',
'    IF TO_DATE(:DT_INIC_VAL, ''DD/MM/RRRR'') > TO_DATE(:DT_FIN_VAL, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DT. IN\00CDCIO VALIDADE n\00E3o deve ser maior que fim!'';'),
'    END IF;',
'  ELSIF :DT_INIC_VAL IS NULL THEN',
unistr('    vReturn := ''DT. IN\00CDCIO VALIDADE deve ser informada!'';'),
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN',
'    IF TO_DATE(:DT_INIC_VAL, ''DD/MM/RRRR'') < TO_DATE(:DATA_REF, ''DD/MM/RRRR'') THEN',
unistr('       vReturn := ''DT. IN\00CDCIO VALIDADE n\00E3o pode ser menor que a Dt. Refer\00EAncia!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'DT_INIC_VAL'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12730102111851959154)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Dt. Inicial Evento'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  CURSOR cFaltas IS',
'    SELECT COUNT(1)',
'      FROM ferias_parametros fp',
'     WHERE fp.cod_empresa = :COD_EMPRESA',
'       AND (fp.cod_filial = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'       AND (:P7_FILIAIS IS NULL OR fp.cod_filial||''#''||fp.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_FILIAIS, '':'')) t))',
'       AND fp.apura_faltas = 2 ',
'       AND EXISTS(SELECT 1',
'                    FROM ocorr_pagto o',
'                   WHERE o.cod_empresa = :COD_EMPRESA',
'                     AND o.cod = :COD_OCORR',
'                     AND o.incid_falta_ferias = ''S'');  ',
'  --',
'  vCont    NUMBER DEFAULT NULL;',
'BEGIN',
'  IF :DT_INIC_EVENTO IS NOT NULL THEN',
'    OPEN cFaltas;',
'    FETCH cFaltas INTO vCont;',
'    CLOSE cFaltas;',
'    --',
'    IF vCont = 0 THEN',
unistr('      vReturn := ''DT. IN\00CDCIO EVENTO n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'    END IF;',
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :DT_INIC_EVENTO IS NULL AND :DT_FIN_EVENTO IS NOT NULL THEN',
unistr('      vReturn := ''DT. IN\00CDCIO EVENTO deve ser informada!'';'),
'    ELSIF :DT_INIC_EVENTO IS NOT NULL AND :DT_FIN_EVENTO IS NOT NULL THEN',
'      IF TO_DATE(:DT_INIC_EVENTO, ''DD/MM/RRRR'') > TO_DATE(:DT_FIN_EVENTO, ''DD/MM/RRRR'') THEN',
unistr('        vReturn := ''DT. IN\00CDCIO EVENTO n\00E3o deve ser maior que fim!'';'),
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P7_PROCESSO'
,p_validation_condition2=>'1:6'
,p_validation_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_INIC_EVENTO'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12730101220581959145)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Dt. Fim Val.'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :DT_INIC_VAL IS NOT NULL AND :DT_FIN_VAL IS NULL THEN',
'    vReturn := ''DT. FIM VALIDADE deve ser informada!'';',
'  ELSIF :DT_INIC_VAL IS NOT NULL AND :DT_FIN_VAL IS NOT NULL THEN',
'    IF TO_DATE(:DT_FIN_VAL, ''DD/MM/RRRR'') < TO_DATE(:DT_INIC_VAL, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DT. FIM VALIDADE n\00E3o deve ser menor que in\00EDcio!'';'),
'    END IF;',
'  ELSIF :DT_FIN_VAL IS NULL THEN',
'    vReturn := ''DT. FIM VALIDADE deve ser informada!'';  ',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'DT_FIN_VAL'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12730102178043959155)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>'Valida Dt. Fim Evento'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  CURSOR cFaltas IS',
'    SELECT COUNT(1)',
'      FROM ferias_parametros fp',
'     WHERE fp.cod_empresa = :COD_EMPRESA',
'       AND (fp.cod_filial = :P7_CODAUX OR :P7_CODAUX IS NULL)',
'       AND (:P7_FILIAIS IS NULL OR fp.cod_filial||''#''||fp.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P7_FILIAIS, '':'')) t))',
'       AND fp.apura_faltas = 2 ',
'       AND EXISTS(SELECT 1',
'                    FROM ocorr_pagto o',
'                   WHERE o.cod_empresa = :COD_EMPRESA',
'                     AND o.cod = :COD_OCORR',
'                     AND o.incid_falta_ferias = ''S'');  ',
'  --',
'  vCont    NUMBER DEFAULT NULL;  ',
'BEGIN',
'  IF :DT_FIN_EVENTO IS NOT NULL THEN',
'    OPEN cFaltas;',
'    FETCH cFaltas INTO vCont;',
'    CLOSE cFaltas;',
'    --',
'    IF vCont = 0 THEN',
unistr('      vReturn := ''DT. FIM EVENTO n\00E3o deve ser informado para ocorr\00EAncia [''||:COD_OCORR||'']!'';'),
'    END IF;',
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :DT_INIC_EVENTO IS NOT NULL AND :DT_FIN_EVENTO IS NULL THEN',
'      vReturn := ''DT. FIM EVENTO deve ser informada!'';',
'    ELSIF :DT_INIC_EVENTO IS NOT NULL AND :DT_FIN_EVENTO IS NOT NULL THEN',
'      IF TO_DATE(:DT_FIN_EVENTO, ''DD/MM/RRRR'') < TO_DATE(:DT_INIC_EVENTO, ''DD/MM/RRRR'') THEN',
unistr('        vReturn := ''DT. FIM EVENTO n\00E3o deve ser menor que in\00EDcio!'';'),
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P7_PROCESSO'
,p_validation_condition2=>'1:6'
,p_validation_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_FIN_EVENTO'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12943002040250183666)
,p_tabular_form_region_id=>wwv_flow_api.id(12726967674887233684)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  CURSOR cMatr IS',
'    SELECT COLUMN_VALUE matricula',
'      FROM TABLE(APEX_STRING.split(:MATRICULA, '':''))',
'    ORDER BY TO_NUMBER(COLUMN_VALUE); ',
'BEGIN',
'  IF :MATRICULA IS NOT NULL THEN',
'    IF :P7_PROCESSO IN(1,2,3,4,5,6) THEN',
'      FOR r IN cMatr LOOP',
'        vReturn := pkg_MovtFinanceiro.fnc_VerifDtsAdmRef(pEmp   => :COD_EMPRESA',
'                                                        ,pMatr  => r.matricula --:MATRICULA',
'                                                        ,pDtRef => :DATA_REF);',
'        IF vReturn IS NOT NULL THEN',
'          EXIT;',
'        END IF;',
'      END LOOP;                                                ',
'    END IF;                                                ',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'MATRICULA'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739780902662500680)
,p_name=>'Edit Mode'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739780991255500681)
,p_event_id=>wwv_flow_api.id(12739780902662500680)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region("IGOCORR").widget().interactiveGrid("getActions").set("edit", true);'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12742243324821555956)
,p_name=>'Hide Close'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742243383468555957)
,p_event_id=>wwv_flow_api.id(12742243324821555956)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12742242662912555950)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12741911023343574106)
,p_name=>'Limpa Lancto Ocorr'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12739991177086494872)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741911462759574151)
,p_event_id=>wwv_flow_api.id(12741911023343574106)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_MovtFinanceiro.prc_DEL_LanctoOcorrSeq(pSeq => :P7_SEQ_OCORR);',
'END;'))
,p_attribute_02=>'P7_SEQ_OCORR'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12790084291790498688)
,p_name=>'Cancel Dialog'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12739991177086494872)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10018366717563909681)
,p_event_id=>wwv_flow_api.id(12790084291790498688)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'button.show(); //show the button'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12790084385828498689)
,p_event_id=>wwv_flow_api.id(12790084291790498688)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12727217073302374654)
,p_name=>'Enable Disable BT Create'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_EXISTE'
,p_condition_element=>'P7_EXISTE'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727217207898374655)
,p_event_id=>wwv_flow_api.id(12727217073302374654)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727217298397374656)
,p_event_id=>wwv_flow_api.id(12727217073302374654)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742242322245555946)
,p_event_id=>wwv_flow_api.id(12727217073302374654)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742242377065555947)
,p_event_id=>wwv_flow_api.id(12727217073302374654)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12727217778285374661)
,p_name=>'Processar'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12739991934892494872)
,p_condition_element=>'P7_CONFIRMA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727217863375374662)
,p_event_id=>wwv_flow_api.id(12727217778285374661)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Confirma o Processamento dos Lan\00E7amentos?')
,p_attribute_07=>'SIM'
,p_attribute_08=>unistr('N\00C3O')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'CANCEL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727218228583374665)
,p_event_id=>wwv_flow_api.id(12727217778285374661)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P7_CONFIRMA := ''S'';',
'END;  ',
''))
,p_attribute_02=>'P7_CONFIRMA'
,p_attribute_03=>'P7_CONFIRMA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727217994874374663)
,p_event_id=>wwv_flow_api.id(12727217778285374661)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12727218898936374672)
,p_name=>unistr('Atribui D\00EDgito Ocorr.')
,p_event_sequence=>70
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'COD_OCORR'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'COD_OCORR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727219010046374673)
,p_event_id=>wwv_flow_api.id(12727218898936374672)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'DC_OCORR'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT o.dc_cod',
'  FROM ocorr_pagto o',
' WHERE o.cod_empresa = :COD_EMPRESA',
'   AND o.cod         = :COD_OCORR'))
,p_attribute_07=>'COD_EMPRESA,COD_OCORR'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12727219144255374674)
,p_event_id=>wwv_flow_api.id(12727218898936374672)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'DC_OCORR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12729967625945973053)
,p_name=>'Atribui Indicadores'
,p_event_sequence=>80
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'COD_OCORR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12729967710695973054)
,p_event_id=>wwv_flow_api.id(12729967625945973053)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cOcorrPgto IS',
'    SELECT o.ind_duplicidade, o.ind_pres_valor, o.ind_pres_fx, o.ind_pres_unid1, o.ind_pres_unid2',
'  FROM ocorr_pagto o',
' WHERE o.cod_empresa = :COD_EMPRESA',
'   AND o.cod         = :COD_OCORR;',
'  --',
'  rOcorrPgto    cOcorrPgto%ROWTYPE;',
'BEGIN',
'  IF :COD_OCORR IS NOT NULL THEN',
'    OPEN cOcorrPgto;',
'    FETCH cOcorrPgto INTO rOcorrPgto;',
'    CLOSE cOcorrPgto;',
'    --',
'    :IND_DUPLIC := rOcorrPgto.ind_duplicidade;',
'    :IND_VALOR  := rOcorrPgto.ind_pres_valor;',
'    :IND_FAIXA  := rOcorrPgto.ind_pres_fx;',
'    :IND_UNID1  := rOcorrPgto.ind_pres_unid1;',
'    :IND_UNID2  := rOcorrPgto.ind_pres_unid2;',
'  ELSE',
'    :IND_DUPLIC := NULL;',
'    :IND_VALOR  := NULL;',
'    :IND_FAIXA  := NULL;',
'    :IND_UNID1  := NULL;',
'    :IND_UNID2  := NULL;',
'  END IF;',
'END;   '))
,p_attribute_02=>'COD_EMPRESA,COD_OCORR,IND_DUPLIC,IND_VALOR,IND_FAIXA,IND_UNID1,IND_UNID2'
,p_attribute_03=>'IND_DUPLIC,IND_VALOR,IND_FAIXA,IND_UNID1,IND_UNID2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730103048231959164)
,p_name=>'Atribui Dts. Val.'
,p_event_sequence=>90
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'COD_OCORR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730103180263959165)
,p_event_id=>wwv_flow_api.id(12730103048231959164)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'BEGIN',
'  IF :COD_OCORR IS NOT NULL AND INSTR(:P7_DATAREF,'':'') = 0 THEN',
'    :DT_INIC_VAL := TO_DATE(:DATA_REF, ''DD/MM/RRRR'');',
'    :DT_FIN_VAL  := LAST_DAY(TO_DATE(:DATA_REF, ''DD/MM/RRRR''));',
'  END IF;',
'END;   '))
,p_attribute_02=>'COD_OCORR,P7_DATAREF,DT_INIC_VAL,DT_FIN_VAL,DATA_REF'
,p_attribute_03=>'DT_INIC_VAL,DT_FIN_VAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12729970332586973080)
,p_name=>'Verifica Hora Qtd.'
,p_event_sequence=>100
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'HORA_QTD'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12729970436650973081)
,p_event_id=>wwv_flow_api.id(12729970332586973080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cEmp IS',
'    SELECT e.tipo_lancamento_manual FROM empresas e WHERE e.cod = :COD_EMPRESA;',
'  --',
'  rEmp    cEmp%ROWTYPE;',
'BEGIN',
'  IF :HORA_QTD IS NOT NULL THEN',
'    OPEN cEmp;',
'    FETCH cEmp INTO rEmp;',
'    CLOSE cEmp;',
'    --',
'    IF NVL(rEmp.tipo_lancamento_manual, 1) = 1 THEN',
'      :UNIDADE1 := :HORA_QTD;',
'      :HORAS    := NULL;',
'    ELSIF rEmp.tipo_lancamento_manual = 2 THEN',
'      IF :MIN_DIA IS NOT NULL THEN',
'        :UNIDADE1 := :HORA_QTD;',
'      ELSE',
'        :UNIDADE1 := NULL;',
'      END IF;',
'      :HORAS    := :HORA_QTD;  ',
'    ELSE',
'      :UNIDADE1 := NULL;',
'      :HORAS    := NULL;   ',
'    END IF;',
'  ELSE',
'      :UNIDADE1 := NULL;',
'      :HORAS    := NULL;   ',
'  END IF;',
'END;'))
,p_attribute_02=>'COD_EMPRESA,UNIDADE1,HORAS,MIN_DIA,HORA_QTD'
,p_attribute_03=>'UNIDADE1,HORAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12729970513665973082)
,p_name=>'Verifica Min. Dia'
,p_event_sequence=>110
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'MIN_DIA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12729970590565973083)
,p_event_id=>wwv_flow_api.id(12729970513665973082)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cEmp IS',
'    SELECT e.tipo_lancamento_manual FROM empresas e WHERE e.cod = :COD_EMPRESA;',
'  --',
'  rEmp    cEmp%ROWTYPE;',
'BEGIN',
'  IF :MIN_DIA IS NOT NULL THEN',
'    OPEN cEmp;',
'    FETCH cEmp INTO rEmp;',
'    CLOSE cEmp;',
'    --',
'    IF NVL(rEmp.tipo_lancamento_manual,1) = 1 THEN',
'      :UNIDADE2 := :MIN_DIA;',
'      :MINUTOS  := NULL;',
'    ELSIF rEmp.tipo_lancamento_manual = 2 THEN',
'      :UNIDADE1 := :HORA_QTD;',
'      :UNIDADE2 := :MIN_DIA/60*100;',
'      :MINUTOS  := :MIN_DIA;  ',
'    ELSE',
'      :UNIDADE2 := NULL;',
'      :MINUTOS  := NULL;   ',
'    END IF;',
'  ELSE',
'      :UNIDADE2 := NULL;',
'      :MINUTOS  := NULL;   ',
'  END IF;',
'END;'))
,p_attribute_02=>'COD_EMPRESA,UNIDADE1,UNIDADE2,HORAS,MINUTOS,HORA_QTD,MIN_DIA'
,p_attribute_03=>'UNIDADE1,UNIDADE2,MINUTOS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730100653233959140)
,p_name=>'Atribui Parc. Origem'
,p_event_sequence=>120
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'DT_FIN_VAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730100801157959141)
,p_event_id=>wwv_flow_api.id(12730100653233959140)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :DT_INIC_VAL IS NOT NULL AND :DT_FIN_VAL IS NOT NULL THEN',
'    :PARC_ORIG := ROUND(TO_NUMBER(TRUNC(TO_DATE(:DT_FIN_VAL,''DD/MM/RRRR''),''MM'') - TO_DATE(:DT_INIC_VAL,''DD/MM/RRRR''))/30);',
'  END IF;',
'  --',
'  IF :PARC_ORIG < 1 THEN',
'    :PARC_ORIG  :=  1;',
'  END IF;',
'END;'))
,p_attribute_02=>'DT_INIC_VAL,DT_FIN_VAL,PARC_ORIG'
,p_attribute_03=>'PARC_ORIG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730100919830959142)
,p_name=>'Atribui Data Fim Val.'
,p_event_sequence=>130
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'DT_INIC_VAL'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'PARC_NOVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730101025955959143)
,p_event_id=>wwv_flow_api.id(12730100919830959142)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :DT_INIC_VAL IS NOT NULL AND :PARC_NOVA IS NOT NULL THEN',
'    :DT_FIN_VAL := ADD_MONTHS(TO_DATE(:DT_FIN_VAL,''DD/MM/RRRR''),:PARC_NOVA) - 1;',
'  END IF;',
'END;'))
,p_attribute_02=>'DT_INIC_VAL,DT_FIN_VAL,PARC_NOVA'
,p_attribute_03=>'DT_FIN_VAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730101317727959146)
,p_name=>'Atribui Datas Validade'
,p_event_sequence=>140
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'PARC_NOVA'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'PARC_NOVA'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730101350226959147)
,p_event_id=>wwv_flow_api.id(12730101317727959146)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :PARC_NOVA > 1 THEN',
'    :DT_FIN_VAL := LAST_DAY(ADD_MONTHS(TO_DATE(:DT_INIC_VAL,''DD/MM/RRRR''),(:PARC_NOVA -1)));',
'  ELSIF :PARC_NOVA = 1 THEN',
'    :DT_FIN_VAL := LAST_DAY(TO_DATE(:DT_INIC_VAL,''DD/MM/RRRR''));',
'  END IF;',
'END;'))
,p_attribute_02=>'PARC_NOVA,DT_INIC_VAL,DT_FIN_VAL'
,p_attribute_03=>'DT_FIN_VAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730101918013959152)
,p_name=>'Atribui Dts Validade Inicial'
,p_event_sequence=>150
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_triggering_element=>'DATA_REF'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730102013999959153)
,p_event_id=>wwv_flow_api.id(12730101918013959152)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :DATA_REF IS NOT NULL AND :PARC_NOVA IS NULL AND :DT_INIC_VAL IS NULL AND :DT_FIN_VAL IS NULL THEN',
'    :DT_INIC_VAL := TO_DATE(:DATA_REF, ''DD/MM/RRRR'');',
'    :DT_FIN_VAL  := LAST_DAY(TO_DATE(:DATA_REF, ''DD/MM/RRRR''));',
'  END IF;',
'END;',
''))
,p_attribute_02=>'DATA_REF,DT_INIC_VAL,DT_FIN_VAL,PARC_NOVA'
,p_attribute_03=>'DT_INIC_VAL,DT_FIN_VAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730102444315959157)
,p_name=>'Dispara Alerta'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_ERR_MSG'
,p_condition_element=>'P7_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730102488355959158)
,p_event_id=>wwv_flow_api.id(12730102444315959157)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//if (apex.item( "P7_ERR_MSG" ).getValue().length > 0){',
'//  alertify.set({labels:{ok:"OK",cancel:"Cancela"},buttonReverse:false,buttonFocus:"ok"});',
'//  alertify.alert(apex.item( "P7_ERR_MSG" ).getValue());',
'',
'//    document.getElementById("alertify-cover").style.position="static";',
'//  }',
'',
'if (apex.item( "P7_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P7_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730102590682959159)
,p_name=>'Inicia Alertify'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730102730187959160)
,p_event_id=>wwv_flow_api.id(12730102590682959159)
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
 p_id=>wwv_flow_api.id(12730104592783959179)
,p_name=>'Verifica Save'
,p_event_sequence=>190
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridsave'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730104678827959180)
,p_event_id=>wwv_flow_api.id(12730104592783959179)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P7_EXISTE := pkg_MovtFinanceiro.fnc_VerifLanctoOcorrTmpExiste(pSeq => :P7_SEQ_OCORR);',
'END;'))
,p_attribute_02=>'P7_SEQ_OCORR,P7_EXISTE'
,p_attribute_03=>'P7_EXISTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12846464536813144469)
,p_name=>'Disable PROCESSA'
,p_event_sequence=>210
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12726967674887233684)
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12846464574374144470)
,p_event_id=>wwv_flow_api.id(12846464536813144469)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12846464652727144471)
,p_event_id=>wwv_flow_api.id(12846464536813144469)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12730105500389959188)
,p_name=>'Atribui Existe'
,p_event_sequence=>220
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12730105616859959189)
,p_event_id=>wwv_flow_api.id(12730105500389959188)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P7_EXISTE := pkg_MovtFinanceiro.fnc_VerifLanctoOcorrTmpExiste(pSeq => :P7_SEQ_OCORR);',
'END;'))
,p_attribute_02=>'P7_SEQ_OCORR,P7_EXISTE'
,p_attribute_03=>'P7_EXISTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12741899330924227758)
,p_name=>unistr('Verifica Execu\00E7\00E3o Processo')
,p_event_sequence=>250
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741899379897227759)
,p_event_id=>wwv_flow_api.id(12741899330924227758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P7_CONFIRMA = ''S'' THEN',
'    :P7_EXEC_PROCESSO := ''S'';',
'  ELSE',
'    :P7_EXEC_PROCESSO := ''N'';',
'  END IF;',
'END;',
'',
''))
,p_attribute_02=>'P7_CONFIRMA,P7_EXEC_PROCESSO,P7_SEQ_OCORR,P7_ERR_MSG'
,p_attribute_03=>'P7_EXEC_PROCESSO,P7_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12741899657835227762)
,p_name=>'Executa Processo'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_EXEC_PROCESSO'
,p_condition_element=>'P7_EXEC_PROCESSO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857153494909552)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#IGOCORR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857384105909554)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857595393909556)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442856936941909550)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741899783261227763)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vQtLog NUMBER DEFAULT NULL;',
'BEGIN',
'  :P7_ERR_MSG       := NULL;',
'  :P7_CTRL_PROCESSO := NULL;',
'  :P7_LOG_PROCESSO  := NULL;',
'  --',
'  pkg_MovtFinanceiro.prc_INS_OcorrProcesso(pSeq        => :P7_SEQ_OCORR',
'                                          ,pProcesso   => :P7_PROCESSO ',
'                                          ,pEmpresas   => :P7_EMPRESAS',
'                                          ,pFiliais    => :P7_FILIAIS',
'                                          ,pCCustos    => :P7_CCUSTOS',
'                                          ,pCargos     => :P7_CARGOS',
'                                          ,pSituacoes  => :P7_SITUACOES',
'                                          ,pVinculos   => :P7_VINCULOS',
'                                          ,pSindicatos => :P7_SINDICATOS',
'                                          ,pTiposSal   => :P7_TIPOSAL',
'                                          ,pTiposPagto => :P7_TIPOPAG',
'                                          ,pMatriculas => :P7_MATRICULAS',
'                                          ,pDtIniAdm   => :P7_DTADMINI',
'                                          ,pDtFimAdm   => :P7_DTADMFIM',
'                                          ,pDemitidos  => :P7_DEMITIDOS',
'                                          ,pTransfer   => :P7_TRANSFERIDOS',
'                                          ,pUser       => :APP_USER',
'                                          ,pMsgRet     => vMsg',
'                                          ,pQtdLog     => vQtLog);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P7_ERR_MSG       := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''['', ''<strong>''), '']'',''</strong>''), ''|'',''<br>''), ''('',''<i>''), '')'',''</i>'');',
'    :P7_CTRL_PROCESSO := NULL;',
'  ELSE  ',
'    :P7_CTRL_PROCESSO := ''S'';',
'  END IF;',
'  --',
'  IF vQtLog > 0 THEN',
'    :P7_CTRL_PROCESSO := NULL;',
'    :P7_LOG_PROCESSO  := ''S'';',
'  ELSE',
'    :P7_LOG_PROCESSO := NULL;',
'  END IF;',
'  --',
'  pkg_MovtFinanceiro.prc_DEL_LanctoOcorrSeq(pSeq => :P7_SEQ_OCORR);',
'END;'))
,p_attribute_02=>'P7_SEQ_OCORR,P7_PROCESSO,P7_EMPRESAS,P7_FILIAIS,P7_CCUSTOS,P7_CARGOS,P7_SITUACOES,P7_VINCULOS,P7_SINDICATOS,P7_TIPOSAL,P7_TIPOPAG,P7_MATRICULAS,P7_DTADMINI,P7_DTADMFIM,P7_DEMITIDOS,P7_TRANSFERIDOS,P7_ERR_MSG,P7_CTRL_PROCESSO,P7_LOG_PROCESSO'
,p_attribute_03=>'P7_ERR_MSG,P7_CTRL_PROCESSO,P7_LOG_PROCESSO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857098320909551)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$.remove();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857291304909553)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#IGOCORR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857467804909555)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12442857625619909557)
,p_event_id=>wwv_flow_api.id(12741899657835227762)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12741900131244227766)
,p_name=>unistr('Finaliza Execu\00E7\00E3o Processo Sem Log')
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_CTRL_PROCESSO'
,p_condition_element=>'P7_CTRL_PROCESSO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741900266171227768)
,p_event_id=>wwv_flow_api.id(12741900131244227766)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>&P7_PROC_TXT.</strong><br><i>Lan\00E7amento de Ocorr\00EAncias realizado com sucesso!!</i>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741900435496227769)
,p_event_id=>wwv_flow_api.id(12741900131244227766)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12741900516112227770)
,p_name=>unistr('Finaliza Execu\00E7\00E3o Processo com Log')
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_LOG_PROCESSO'
,p_condition_element=>'P7_LOG_PROCESSO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741901126585227776)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Lan\00E7amento de Ocorr\00EAncias realizado</strong><br> Verifique o LOG de Erros</i>!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741901286830227778)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12741899099430227756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741902244629227787)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12726967674887233684)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742242470067555948)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991934892494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742243131577555954)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12739991177086494872)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742242551173555949)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_DEMITIDOS,P7_TRANSFERIDOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742243177865555955)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12742242662912555950)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741900632622227771)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12741899099430227756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12741900689351227772)
,p_event_id=>wwv_flow_api.id(12741900516112227770)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12741897457743227740)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12742242835606555951)
,p_name=>'Limpa Log'
,p_event_sequence=>290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12742242662912555950)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742242902533555952)
,p_event_id=>wwv_flow_api.id(12742242835606555951)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  pkg_MovtFinanceiro.prc_DEL_LogLanctoOcorrSeq(pSeq => :P7_SEQ_OCORR);',
'END;'))
,p_attribute_02=>'P7_SEQ_OCORR'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(10018366882977909682)
,p_event_id=>wwv_flow_api.id(12742242835606555951)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'button.show(); //show the button'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12742243026258555953)
,p_event_id=>wwv_flow_api.id(12742242835606555951)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(12727163710284000280)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(12726967674887233684)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>unistr('Lan\00E7amentos de Ocorr\00EAncias - Save Interactive Grid Data')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(12739781212238500683)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atribui Valores Filtro'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cCollection IS',
'    SELECT x.seq_id',
'          ,x.C001, x.C002, x.C003, x.C004, x.C005',
'          ,x.C006, x.C007, x.C008, x.C009, x.C010',
'          ,x.C011, x.C012, x.C013, x.C014, x.C015',
'          ,x.C016, x.C017, x.c018, x.d001, x.d002, x.d003',
'      FROM apex_collections x WHERE x.collection_name = ''LANCTO_FILTRO'';',
'  --',
'  rCollection    cCollection%ROWTYPE;',
'BEGIN',
'  OPEN cCollection;',
'  FETCH cCollection INTO rCollection;',
'  CLOSE cCollection;',
'  --',
'  :P7_EMPRESAS   := rCollection.C001;',
'  :P7_FILIAIS    := rCollection.C002;',
'  :P7_CCUSTOS    := rCollection.C003;',
'  :P7_CARGOS     := rCollection.C004;',
'  :P7_DTADMINI   := rCollection.C005;',
'  :P7_DTADMFIM   := rCollection.C006;',
'  :P7_SITUACOES  := rCollection.C007;',
'  :P7_VINCULOS   := rCollection.C008;',
'  :P7_SINDICATOS := rCollection.C009;',
'  :P7_TIPOSAL    := rCollection.C010;',
'  :P7_TIPOPAG    := rCollection.C011;',
'  :P7_MATRICULAS := rCollection.C012;',
'  :P7_DATAREF    := rCollection.C013;',
'  :P7_TIPOEVENT  := rCollection.C014;',
'  :P7_OCORRPAGTO := rCollection.C015;',
'  :P7_USUARIO    := rCollection.C016;',
'  :P7_DTATLZ     := rCollection.C017;',
'  :P7_MESANOSIT  := rCollection.C018;',
'  :P7_DATASIT    := rCollection.D001;  ',
'  :P7_DTVALINI   := rCollection.D002;  ',
'  :P7_DTVALFIM   := rCollection.D003;  ',
'  --',
'  IF :P7_PROCESSO IS NULL THEN',
'    :P7_PROC_TXT := NULL;',
'  ELSE',
'    :P7_PROC_TXT := CASE :P7_PROCESSO',
unistr('                      WHEN 1 THEN ''Folha | Rescis\00E3o'''),
'                      WHEN 2 THEN ''Adiantamento''',
unistr('                      WHEN 3 THEN ''F\00E9rias'''),
unistr('                      WHEN 4 THEN ''13\00BA Sal\00E1rio'''),
unistr('                      WHEN 5 THEN ''Participa\00E7\00E3o nos Lucros - PLR'''),
'                      WHEN 6 THEN ''Pagamentos Diversos''',
'                    ELSE NULL',
'                    END;',
'  END IF;',
'  --',
'  --:P7_CONFIRMA := NULL;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(12959617530758685182)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_region_id=>wwv_flow_api.id(12726967674887233684)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atualiza\00E7\00E3o Gen\00E9rica de Dados')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cDigito IS',
'    SELECT p.dc_matricula',
'      FROM inf_pessoais p',
'     WHERE p.cod_empresa = :COD_EMPRESA',
'       AND p.matricula   = :MATRICULA;',
'  --',
'  vDigito   NUMBER DEFAULT NULL;',
'BEGIN',
'  IF :APEX$ROW_STATUS IN(''C'',''U'') THEN',
'    IF :MATRICULA IS NOT NULL THEN',
'      IF INSTR(:MATRICULA, '':'') = 0 THEN',
'        OPEN cDigito;',
'        FETCH cDigito INTO vDigito;',
'        CLOSE cDigito;',
'        --',
'        :DC_MATRICULA := vDigito;',
'      ELSE',
'        :DC_MATRICULA := vDigito;',
'      END IF;',
'    ELSE',
'      :DC_MATRICULA := vDigito;',
'    END IF;',
'  END IF;',
'END;'))
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
