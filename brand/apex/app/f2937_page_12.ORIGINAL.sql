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
,p_default_application_id=>2937
,p_default_id_offset=>795299883281732340
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   04:35 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 12
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00012
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>12);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_api.create_page(
 p_id=>12
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Manuten\00E7\00E3o de Atestados M\00E9dicos')
,p_step_title=>unistr('Manuten\00E7\00E3o de Atestados M\00E9dicos')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'MARCELO.SENA'
,p_last_upd_yyyymmddhh24miss=>'20260911112248'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(38607704786752966949)
,p_plug_name=>'Atestados2'
,p_region_name=>'ATESTADO'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_empresa',
'      ,a.matricula',
'      ,a.dc_matricula',
'      ,a.dt_atestado_medico',
'      ,a.cod_atestado_medico',
'      ,a.ocupacional       ',
'      ,a.cod_motivo     ',
'      ,a.desc_motivo',
'      ,a.tipo_acidente_es',
'      ,(select rowidtochar(e.rowid)',
'          from entidade e',
'         where e.tipo_entidade = a.tipo_entidade',
'           and e.cod_entidade = a.cod_entidade) entidade_lov',
'      ,a.cod_entidade',
'      ,a.tipo_entidade',
'      ,a.cod_prest_serv',
'      ,a.tipo_prest_serv',
'      ,a.cod_doenca ',
'      ,a.dt_inicio_afastamento',
'      ,a.hora_inicio_afastamento',
'      ,a.qtde_dias_afastamento    ',
'      ,a.dt_termino_afastamento',
'      ,a.hora_termino_afastamento',
'      ,a.dt_alt_prog',
'      ,a.dt_pericia                 ',
'      ,a.cod_justificativa',
'      ,a.observacao                ',
'      ,a.usuario                ',
'      ,a.dt_atualizacao',
'      ,a.qtde_horas_abonadas',
'      ,a.cid_familia',
'      ,a.origem_med',
'      ,a.cod_motivo_es',
'      ,a.crm_prest_serv_resp',
'      ,a.uf_crm_prest_resp',
'      ,a.infomesmomtv',
'      ,a.ROWID',
'       , null cod_sit_func  ',
'       , null dt_inicio_afastamento2  ',
'       , null dt_termino_afastamento2',
'       ',
'      ',
'  from atestado_funcionario a, informacoes_funcionais_cad i ',
' where a.cod_empresa = i.cod_empresa',
'   and a.matricula = i.matricula',
'   and a.cod_empresa = :P12_COD_EMPRESA ',
'   and a.matricula = :P12_MATRICULA',
'   and f_acesso(i.cod_empresa, i.matricula, i.filial, i.cd_nivel) = ''S'''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P12_COD_EMPRESA,P12_MATRICULA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P12_COD_EMPRESA is not null and :P12_MATRICULA is not null'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607704900142966951)
,p_name=>'DT_INICIO_AFASTAMENTO2'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>410
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705050681966952)
,p_name=>'DT_TERMINO_AFASTAMENTO2'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>420
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705141615966953)
,p_name=>'COD_SIT_FUNC'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>430
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2
,p_use_as_row_header=>false
,p_enable_hide=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705253247966954)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P12_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705383424966955)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P12_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705486884966956)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P12_COD_EMPRESA',
'   and matricula = :P12_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705567322966957)
,p_name=>'DT_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATESTADO_MEDICO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Data do Lan\00E7amento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'TRUNC(SYSDATE)'
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705640874966958)
,p_name=>'COD_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ATESTADO_MEDICO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Cod. Atestado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' Select  a.cod_atestado_medico||'' - ''||a.descricao descr_atest,',
' a.cod_atestado_medico',
' From Atestado_Medico A,',
'               Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'order by a.cod_atestado_medico'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':ROWID IS NOT NULL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705732919966959)
,p_name=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OCUPACIONAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ocupacional'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663252488110389885)
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
 p_id=>wwv_flow_api.id(38607705880737966960)
,p_name=>'COD_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_MOTIVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Motivo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>3
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' Select M.Cod||'' - ''||M.Descricao descr_mot, M.Cod ',
' From Atestado_Medico A,',
'      Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'and A.cod_atestado_medico = :COD_ATESTADO_MEDICO',
'order by a.cod_atestado_medico'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_cascade_parent_items=>'COD_ATESTADO_MEDICO'
,p_ajax_optimize_refresh=>true
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':ROWID IS NOT NULL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607705983678966961)
,p_name=>'DESC_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESC_MOTIVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38607706028604966962)
,p_name=>'TIPO_ACIDENTE_ES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ACIDENTE_ES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo Acidente'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'RIGHT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166667403330642462450)
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
 p_id=>wwv_flow_api.id(38608261788320394213)
,p_name=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608261814983394214)
,p_name=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>140
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608261911456394215)
,p_name=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('M\00E9dico')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome||'' ''||sigla||'' ''||nr_documento||''-''||uf_documento||case when nit is not null then '' NIT: ''||nit end d',
'       ,cod r',
'  from vw_medicos',
'  WHERE origem = nvl(:ORIGEM_MED,origem)',
' order by 1'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
 p_id=>wwv_flow_api.id(38608262073343394216)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'1'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608262132968394217)
,p_name=>'COD_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_DOENCA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'C.I.D.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166662468646390256708)
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
 p_id=>wwv_flow_api.id(38608262229084394218)
,p_name=>'DT_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INICIO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data In\00EDcio Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/RRRR'
,p_is_required=>true
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
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':ROWID IS NOT NULL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608262365752394219)
,p_name=>'HORA_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INICIO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora In\00EDcio Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'HH24:MI'
,p_is_required=>false
,p_max_length=>5
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
 p_id=>wwv_flow_api.id(38608262478764394220)
,p_name=>'QTDE_DIAS_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_DIAS_AFASTAMENTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Qtde. Dias Afastamento'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
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
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':QTDE_DIAS_AFASTAMENTO IS NOT NULL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608262586171394221)
,p_name=>'DT_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_TERMINO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data T\00E9rmino Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'CENTER'
,p_attribute_02=>'01/01/1900'
,p_attribute_03=>'31/12/2099'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/YYYY'
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
,p_readonly_condition_type=>'PLSQL_EXPRESSION'
,p_readonly_condition=>':DT_TERMINO_AFASTAMENTO IS NOT NULL'
,p_readonly_for_each_row=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608262629561394222)
,p_name=>'HORA_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_TERMINO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora T\00E9rmino Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>5
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
 p_id=>wwv_flow_api.id(38608262781832394223)
,p_name=>'DT_ALT_PROG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ALT_PROG'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data de Alta Programada'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(38608262865192394224)
,p_name=>'DT_PERICIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_PERICIA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data Per\00EDcia')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(38608262978457394225)
,p_name=>'COD_JUSTIFICATIVA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_JUSTIFICATIVA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Justificativa'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select cod_justificativa||'' - ''||descricao d',
'       ,cod_justificativa r',
'  from pe_tipo_justificativa ',
' where cod_empresa = :P12_COD_EMPRESA ',
' order by cod_justificativa'))
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
 p_id=>wwv_flow_api.id(38608263043491394226)
,p_name=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBSERVACAO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Observa\00E7\00E3o')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
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
 p_id=>wwv_flow_api.id(38608263108310394227)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Usu\00E1rio')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>270
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
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
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263239887394228)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Dt. Atualiza\00E7\00E3o')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>280
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263377785394229)
,p_name=>'QTDE_HORAS_ABONADAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_HORAS_ABONADAS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>290
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263480804394230)
,p_name=>'CID_FAMILIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CID_FAMILIA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>300
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263573088394231)
,p_name=>'ORIGEM_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORIGEM_MED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>310
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263657281394232)
,p_name=>'COD_MOTIVO_ES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_MOTIVO_ES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>320
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263790874394233)
,p_name=>'CRM_PREST_SERV_RESP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CRM_PREST_SERV_RESP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>330
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263877227394234)
,p_name=>'UF_CRM_PREST_RESP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UF_CRM_PREST_RESP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>340
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608263952207394235)
,p_name=>'INFOMESMOMTV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INFOMESMOMTV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>350
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608264092853394236)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>360
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608264118384394237)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>370
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608264285640394238)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>380
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608264305724394239)
,p_name=>'ENTIDADE_LOV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ENTIDADE_LOV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Entidade'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>390
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>18
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,e.rowid r',
'  from entidade e',
' where e.tipo_entidade in (1,7)',
' order by e.cod_entidade'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(38608264401311394240)
,p_name=>'RESULTADO'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_COLOR_PICKER'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>400
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(38607704851933966950)
,p_internal_uid=>1394839055140475538
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(161347559215439747726)
,p_update_authorization_scheme=>wwv_flow_api.id(161347559704688747727)
,p_delete_authorization_scheme=>wwv_flow_api.id(161347559474643747726)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_add_button_label=>'Adicionar Atestado'
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
 p_id=>wwv_flow_api.id(38608267694856396402)
,p_interactive_grid_id=>wwv_flow_api.id(38607704851933966950)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(38608267763801396403)
,p_report_id=>wwv_flow_api.id(38608267694856396402)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608268294540396415)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>37
,p_column_id=>wwv_flow_api.id(38607704900142966951)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608268743787396435)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>38
,p_column_id=>wwv_flow_api.id(38607705050681966952)
,p_is_visible=>false
,p_is_frozen=>false
);
end;
/
begin
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608269157830397432)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>34
,p_column_id=>wwv_flow_api.id(38607705141615966953)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608269634913397434)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(38607705253247966954)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608270105419397436)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(38607705383424966955)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608270633385397439)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(38607705486884966956)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608271014927397443)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(38607705567322966957)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608271564278397453)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(38607705640874966958)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608272032571397462)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(38607705732919966959)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608272507759397465)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(38607705880737966960)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608273033768397468)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(38607705983678966961)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608273402748398117)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(38607706028604966962)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608273917351398120)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(38608261788320394213)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608274493986398124)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(38608261814983394214)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608274993833398129)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(38608261911456394215)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608275484507398132)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(38608262073343394216)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608275914078398134)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(38608262132968394217)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608276430804398136)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(38608262229084394218)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608276873824398144)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(38608262365752394219)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608277327308398147)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(38608262478764394220)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608277857967398164)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(38608262586171394221)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608278329906398166)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(38608262629561394222)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608278804690398167)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(38608262781832394223)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608279325847398169)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(38608262865192394224)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608279872328398170)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(38608262978457394225)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608280318391398171)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(38608263043491394226)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608280825101398173)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(38608263108310394227)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608281333514398174)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>26
,p_column_id=>wwv_flow_api.id(38608263239887394228)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608281891163398176)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(38608263377785394229)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608282337187398177)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>30
,p_column_id=>wwv_flow_api.id(38608263480804394230)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608282892046398178)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>31
,p_column_id=>wwv_flow_api.id(38608263573088394231)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608283345465398179)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>32
,p_column_id=>wwv_flow_api.id(38608263657281394232)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608283826300398180)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>33
,p_column_id=>wwv_flow_api.id(38608263790874394233)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608284366815398182)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>34
,p_column_id=>wwv_flow_api.id(38608263877227394234)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608284870838398183)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>35
,p_column_id=>wwv_flow_api.id(38608263952207394235)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608285393671398184)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>36
,p_column_id=>wwv_flow_api.id(38608264092853394236)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608285812034398185)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(38608264118384394237)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608286726322398188)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(38608264305724394239)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>200
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(38608287250711398189)
,p_view_id=>wwv_flow_api.id(38608267763801396403)
,p_display_seq=>33
,p_column_id=>wwv_flow_api.id(38608264401311394240)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166666300874161982823)
,p_plug_name=>'Atestados'
,p_region_name=>'ATESTADO2'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_empresa',
'      ,a.matricula',
'      ,a.dc_matricula',
'      ,a.dt_atestado_medico',
'      ,a.cod_atestado_medico',
'      ,a.ocupacional       ',
'      ,a.cod_motivo     ',
'      ,a.desc_motivo',
'      ,a.tipo_acidente_es',
'      ,(select rowidtochar(e.rowid)',
'          from entidade e',
'         where e.tipo_entidade = a.tipo_entidade',
'           and e.cod_entidade = a.cod_entidade) entidade_lov',
'      ,a.cod_entidade',
'      ,a.tipo_entidade',
'      ,a.cod_prest_serv',
'      ,a.tipo_prest_serv',
'      ,a.cod_doenca ',
'      ,a.dt_inicio_afastamento',
'      ,a.hora_inicio_afastamento',
'      ,a.qtde_dias_afastamento    ',
'      ,a.dt_termino_afastamento',
'      ,a.hora_termino_afastamento',
'      ,a.dt_alt_prog',
'      ,a.dt_pericia                 ',
'      ,a.cod_justificativa',
'      ,a.observacao                ',
'      ,a.usuario                ',
'      ,a.dt_atualizacao',
'      ,a.qtde_horas_abonadas',
'      ,a.cid_familia',
'      ,a.origem_med',
'      ,a.cod_motivo_es',
'      ,a.crm_prest_serv_resp',
'      ,a.uf_crm_prest_resp',
'      ,a.infomesmomtv',
'      ,a.ROWID',
'       , null cod_sit_func  ',
'       , null dt_inicio_afastamento2  ',
'       , null dt_termino_afastamento2',
'       ',
'      ',
'  from atestado_funcionario a, informacoes_funcionais_cad i ',
' where a.cod_empresa = i.cod_empresa',
'   and a.matricula = i.matricula',
'   and a.cod_empresa = :P12_COD_EMPRESA ',
'   and a.matricula = :P12_MATRICULA',
'   and f_acesso(i.cod_empresa, i.matricula, i.filial, i.cd_nivel) = ''S'''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P12_COD_EMPRESA,P12_MATRICULA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(117726447799763038361)
,p_name=>'DT_INICIO_AFASTAMENTO2'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>430
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(117726447860104038362)
,p_name=>'DT_TERMINO_AFASTAMENTO2'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>440
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(142046991463190124065)
,p_name=>'COD_SIT_FUNC'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>410
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301152170982825)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
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
,p_default_expression=>'P12_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301252678982826)
,p_name=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MATRICULA'
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
,p_default_type=>'ITEM'
,p_default_expression=>'P12_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301260699982827)
,p_name=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_MATRICULA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P12_COD_EMPRESA',
'   and matricula = :P12_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301417727982828)
,p_name=>'DT_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATESTADO_MEDICO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('Data do Lan\00E7amento')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'TRUNC(SYSDATE)'
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301472624982829)
,p_name=>'COD_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ATESTADO_MEDICO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Cod. Atestado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' Select  a.cod_atestado_medico||'' - ''||a.descricao descr_atest,',
' a.cod_atestado_medico',
' From Atestado_Medico A,',
'               Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'order by a.cod_atestado_medico'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
 p_id=>wwv_flow_api.id(166666301578665982830)
,p_name=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OCUPACIONAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ocupacional'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663252488110389885)
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
 p_id=>wwv_flow_api.id(166666301696605982831)
,p_name=>'COD_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_MOTIVO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Motivo'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>3
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' Select M.Cod||'' - ''||M.Descricao descr_mot, M.Cod ',
' From Atestado_Medico A,',
'      Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'and A.cod_atestado_medico = :COD_ATESTADO_MEDICO',
'order by a.cod_atestado_medico'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_cascade_parent_items=>'COD_ATESTADO_MEDICO'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301847453982832)
,p_name=>'DESC_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESC_MOTIVO'
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
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666301874789982833)
,p_name=>'TIPO_ACIDENTE_ES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ACIDENTE_ES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo Acidente'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'RIGHT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166667403330642462450)
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
 p_id=>wwv_flow_api.id(166666301972871982834)
,p_name=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666302128437982835)
,p_name=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
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
 p_id=>wwv_flow_api.id(166666302171855982836)
,p_name=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('M\00E9dico')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome||'' ''||sigla||'' ''||nr_documento||''-''||uf_documento||case when nit is not null then '' NIT: ''||nit end d',
'       ,cod r',
'  from vw_medicos',
'  WHERE origem = nvl(:ORIGEM_MED,origem)',
' order by 1'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
 p_id=>wwv_flow_api.id(166666302266694982837)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'1'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666302361688982838)
,p_name=>'COD_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_DOENCA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'C.I.D.'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>190
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166662468646390256708)
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
 p_id=>wwv_flow_api.id(166666302543200982839)
,p_name=>'DT_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_INICIO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data In\00EDcio Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/RRRR'
,p_is_required=>true
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
 p_id=>wwv_flow_api.id(166666302623624982840)
,p_name=>'HORA_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INICIO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora In\00EDcio Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_format_mask=>'HH24:MI'
,p_is_required=>false
,p_max_length=>5
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
 p_id=>wwv_flow_api.id(166666302721091982841)
,p_name=>'QTDE_DIAS_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_DIAS_AFASTAMENTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Qtde. Dias Afastamento'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
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
 p_id=>wwv_flow_api.id(166666302811452982842)
,p_name=>'DT_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_TERMINO_AFASTAMENTO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data T\00E9rmino Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_attribute_02=>'01/01/1900'
,p_attribute_03=>'31/12/2099'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_format_mask=>'DD/MM/YYYY'
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
 p_id=>wwv_flow_api.id(166666302873174982843)
,p_name=>'HORA_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_TERMINO_AFASTAMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Hora T\00E9rmino Afastamento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>5
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
 p_id=>wwv_flow_api.id(166666302966298982844)
,p_name=>'DT_ALT_PROG'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ALT_PROG'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data de Alta Programada'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(166666303103934982845)
,p_name=>'DT_PERICIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_PERICIA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data Per\00EDcia')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(166666303258526982846)
,p_name=>'COD_JUSTIFICATIVA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_JUSTIFICATIVA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Justificativa'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>290
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select cod_justificativa||'' - ''||descricao d',
'       ,cod_justificativa r',
'  from pe_tipo_justificativa ',
' where cod_empresa = :P12_COD_EMPRESA ',
' order by cod_justificativa'))
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
 p_id=>wwv_flow_api.id(166666303331748982847)
,p_name=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBSERVACAO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Observa\00E7\00E3o')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>300
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
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
 p_id=>wwv_flow_api.id(166666303389242982848)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Usuario'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>310
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>30
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
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>false
);
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666303508114982849)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Dt. Atualiza\00E7\00E3o')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>320
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666303628193982850)
,p_name=>'QTDE_HORAS_ABONADAS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'QTDE_HORAS_ABONADAS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>330
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
 p_id=>wwv_flow_api.id(166666303741965982851)
,p_name=>'CID_FAMILIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CID_FAMILIA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>340
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
 p_id=>wwv_flow_api.id(166666303795417982852)
,p_name=>'ORIGEM_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORIGEM_MED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>350
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
 p_id=>wwv_flow_api.id(166666303911355982853)
,p_name=>'COD_MOTIVO_ES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_MOTIVO_ES'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>360
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
 p_id=>wwv_flow_api.id(166666304055067982854)
,p_name=>'CRM_PREST_SERV_RESP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CRM_PREST_SERV_RESP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>370
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
 p_id=>wwv_flow_api.id(166666304127073982855)
,p_name=>'UF_CRM_PREST_RESP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UF_CRM_PREST_RESP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>380
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
 p_id=>wwv_flow_api.id(166666304178122982856)
,p_name=>'INFOMESMOMTV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'INFOMESMOMTV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>390
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
 p_id=>wwv_flow_api.id(166666304308143982857)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666304404731982858)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>30
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666304497446982859)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666304763356982862)
,p_name=>'ENTIDADE_LOV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ENTIDADE_LOV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Entidade'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>18
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,e.rowid r',
'  from entidade e',
' where e.tipo_entidade in (1,7)',
' order by e.cod_entidade'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166675435562106198840)
,p_name=>'RESULTADO'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_COLOR_PICKER'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>400
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166666301057717982824)
,p_internal_uid=>645449898089728005
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(161347559215439747726)
,p_update_authorization_scheme=>wwv_flow_api.id(161347559704688747727)
,p_delete_authorization_scheme=>wwv_flow_api.id(161347559474643747726)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_add_button_label=>'Adicionar Atestado'
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
 p_id=>wwv_flow_api.id(166667303978143313201)
,p_interactive_grid_id=>wwv_flow_api.id(166666301057717982824)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_rows_per_page=>10
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166667304092706313201)
,p_report_id=>wwv_flow_api.id(166667303978143313201)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(117726878901265235876)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>40
,p_column_id=>wwv_flow_api.id(117726447799763038361)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(117726879416981235877)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>41
,p_column_id=>wwv_flow_api.id(117726447860104038362)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(142047201337949193149)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>37
,p_column_id=>wwv_flow_api.id(142046991463190124065)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667304655012313205)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(166666301152170982825)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667305144783313209)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166666301252678982826)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667305616272313212)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166666301260699982827)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667306141194313215)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(166666301417727982828)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>130
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667306636636313218)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166666301472624982829)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>135
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667307109871313222)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(166666301578665982830)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>102
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667307629336313225)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(166666301696605982831)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>222
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667308150476313229)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(166666301847453982832)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>179
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667308654491313232)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(166666301874789982833)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>123
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667309123512313234)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166666301972871982834)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>132
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667309646033313237)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166666302128437982835)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667310123570313240)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(166666302171855982836)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>158
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667310652430313243)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(166666302266694982837)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667311145728313246)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(166666302361688982838)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>333
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667311605607313249)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(166666302543200982839)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>190
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667312154790313252)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(166666302623624982840)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667312521032313255)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(166666302721091982841)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667312983251313257)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(166666302811452982842)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667313488322313260)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(166666302873174982843)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667314008273313263)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(166666302966298982844)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667314483776313266)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(166666303103934982845)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667315047449313269)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(166666303258526982846)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667315479212313273)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(166666303331748982847)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667316006326313276)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(166666303389242982848)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667316538569313280)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(166666303508114982849)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667316981384313283)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>26
,p_column_id=>wwv_flow_api.id(166666303628193982850)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667317492095313285)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(166666303741965982851)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667318000410313288)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>28
,p_column_id=>wwv_flow_api.id(166666303795417982852)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667318467489313291)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(166666303911355982853)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667318960155313294)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>30
,p_column_id=>wwv_flow_api.id(166666304055067982854)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667319471198313297)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>31
,p_column_id=>wwv_flow_api.id(166666304127073982855)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667320049190313300)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>32
,p_column_id=>wwv_flow_api.id(166666304178122982856)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667320529447313303)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>33
,p_column_id=>wwv_flow_api.id(166666304308143982857)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667321059508313306)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166666304404731982858)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166667436969361565658)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(166666304763356982862)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>174
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166679020156700757486)
,p_view_id=>wwv_flow_api.id(166667304092706313201)
,p_display_seq=>35
,p_column_id=>wwv_flow_api.id(166675435562106198840)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167948905652980593025)
,p_plug_name=>unistr('Pesquisar Funcion\00E1rio')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168590427472156177490)
,p_plug_name=>unistr('Manuten\00E7\00E3o de Atestados M\00E9dicos - Medicina do Trabalho')
,p_icon_css_classes=>'fa-files-o'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921841000262886869)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>unistr('<p>Manuten\00E7\00E3o de Atestados M\00E9dicos</p>')
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166666319726235116796)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,11::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166666318920036116794)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_button_name=>'MEDICO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cadastro de M\00E9dico')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:39:&SESSION.::&DEBUG.:RP,39::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166666319261895116796)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_button_name=>'ENTIDADE'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cadastro de Entidade'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:3:&SESSION.::&DEBUG.:RP:P3_TIPO_ENTIDADE:7'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166666320140806116797)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_button_name=>'PESQUISAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121660515034256232993)
,p_name=>'P12_DATA_REF'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166581791684933034132)
,p_name=>'P12_DESC_SITUACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666320504637116798)
,p_name=>'P12_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cSize=>50
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666320935201116803)
,p_name=>'P12_MATRICULA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>unistr('Matr\00EDcula')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select infu.matricula||''-''||infu.dc_matricula||'' - ''||inpe.nome||'' | ''||(SELECT s.cod||'' - ''||s.nome FROM sit_func s WHERE s.cod = infu.situacao) d',
'       ,infu.matricula',
'   from informacoes_funcionais infu',
'       ,inf_pessoais inpe',
' where infu.cod_empresa = inpe.cod_empresa',
'   and infu.matricula = inpe.matricula',
'   and inpe.cod_empresa = :P12_COD_EMPRESA',
'   --',
'   AND infu.situacao < ''90''',
' order by infu.matricula;'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P12_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>50
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>unistr('Matr\00EDculas')
,p_attribute_08=>'420'
,p_attribute_09=>'530'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666321340851116804)
,p_name=>'P12_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_CARGOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome',
'      ,cod',
'from cargos',
'order by 1'))
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666321751211116805)
,p_name=>'P12_COD_CCUSTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Setor de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666322107819116806)
,p_name=>'P12_COD_LOCALIZACAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Local Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666322516563116806)
,p_name=>'P12_PREDIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Predio'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666322932460116806)
,p_name=>'P12_ANDAR'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Andar'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666323277484116807)
,p_name=>'P12_SALA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Sala'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666323712022116807)
,p_name=>'P12_TIPO_SANGUINEO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>unistr('Tipo Sangu\00CDneo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_TIPO_SANGUINEO'
,p_lov=>'.'||wwv_flow_api.id(166662302930648483563)||'.'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666324109193116807)
,p_name=>'P12_FATOR_RH'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Fator RH'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_FATOR_RH'
,p_lov=>'.'||wwv_flow_api.id(166662305668566490472)||'.'
,p_begin_on_new_line=>'N'
,p_grid_column=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166666324498273116808)
,p_name=>'P12_IDADE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_prompt=>'Idade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_column=>9
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166723702868696716927)
,p_name=>'P12_MENSAGEM'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166775071821052163121)
,p_name=>'P12_SITUACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166775072960556163133)
,p_name=>'P12_FLAG'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166775073078553163134)
,p_name=>'P12_OK'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(167948905652980593025)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166675434020601198824)
,p_validation_name=>'valida_item'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_SITUACAO INFORMACOES_FUNCIONAIS.SITUACAO%TYPE;',
'',
'BEGIN',
'  ',
'   ---',
'   SELECT IFC.SITUACAO',
'     INTO  V_SITUACAO',
'   FROM   INFORMACOES_FUNCIONAIS_CAD IFC',
'    WHERE  IFC.MATRICULA   = :P12_MATRICULA',
'    AND    IFC.COD_EMPRESA = :P12_COD_EMPRESA;',
'',
'     ---',
'     IF TO_NUMBER(V_SITUACAO) >= 90 THEN',
unistr('         return ''Funcion\00E1rio desligado. Deseja continuar com o lan\00E7amento?'';'),
'     ELSE',
'         return NULL;',
'     END IF;',
' ---',
' exception',
'   when  no_data_found then',
'         return NULL;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(166666320935201116803)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166775073792976163141)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida Ferias'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'begin',
'',
'pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, v_flg, v_msg, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'if v_flg = ''N'' and trim(v_msg) is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'DT_TERMINO_AFASTAMENTO'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_ATESTADO_MEDICO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166775073888596163142)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida Dt_Inicio_Afastamento'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'begin',
'',
'pkg_mt_cad_atest_medico.prc_validar_dt_inicio(:p12_cod_empresa, :p12_matricula, :dt_inicio_afastamento, v_flg, v_msg); ',
'',
'if v_flg = ''N'' and trim(v_msg) is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'ROWID'
,p_validation_condition_type=>'ITEM_IS_NULL'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_INICIO_AFASTAMENTO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166775073968372163143)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida QTD_DIAS_AFASTAMENTO'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'begin',
'',
'  pkg_mt_cad_atest_medico.prc_valida_qtd(:p12_cod_empresa, :p12_matricula, :cod_doenca, v_flg, v_msg,:qtde_dias_afastamento); ',
'  ',
'  if v_flg = ''N'' and trim(v_msg) is not null then',
'    return v_msg;',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'QTDE_DIAS_AFASTAMENTO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(164888334071855930751)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida Ferias DTI'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'  CURSOR cAtestFunc IS',
'  SELECT af.dt_atestado_medico, af.dt_inicio_afastamento, af.dt_termino_afastamento',
'    FROM atestado_funcionario af',
'   WHERE ROWID = :ROWID;',
'   --WHERE af.cod_empresa = :P12_COD_EMPRESA',
'   --  AND af.matricula   = :P12_MATRICULA',
'   --  AND af.dt_inicio_afastamento = TO_DATE(:DT_INICIO_AFASTAMENTO,''DD/MM/RRRR'');',
'  --',
'  rAtestFunc    cAtestFunc%ROWTYPE;',
'  --',
'  vVerif     NUMBER DEFAULT 0;',
'begin',
'  OPEN cAtestFunc;',
'  FETCH cAtestFunc INTO rAtestFunc;',
'  CLOSE cAtestFunc;',
'  --',
'  IF rAtestFunc.dt_inicio_afastamento IS NOT NULL THEN',
'    IF rAtestFunc.dt_inicio_afastamento <> TO_DATE(:dt_inicio_afastamento, ''DD/MM/RRRR'') OR rAtestFunc.dt_termino_afastamento IS NOT NULL THEN',
'      vVerif := 1;',
'    END IF;',
'  END IF;',
'  --',
'  --pkg_mt_cad_atest_medico.prc_valida_feriasX(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento);',
'  IF vVerif = 1 THEN',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, v_flg, v_msg, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'  ',
'  /*if v_flg <> ''S'' and trim(v_msg) is not null then',
unistr('    v_msg := ''Colaborador em f\00E9rias!! [IN\00CDCO AFASTAMENTO]'';'),
'  ELSE',
'    v_msg := NULL;',
'    --return v_msg;',
'  end if;*/',
'  END IF;',
'  --',
'  return v_msg; ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'DT_TERMINO_AFASTAMENTO'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_INICIO_AFASTAMENTO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>'/* Server-Side OLD: item is NULL | DT_TERMINO_AFASTAMENTO */'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(164888334435282930754)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida Ferias DTF'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'  CURSOR cAtestFunc IS',
'  SELECT af.dt_atestado_medico, af.dt_inicio_afastamento, af.dt_termino_afastamento',
'    FROM atestado_funcionario af',
'   WHERE ROWID = :ROWID; ',
'   --WHERE af.cod_empresa = :P12_COD_EMPRESA',
'   --  AND af.matricula   = :P12_MATRICULA',
'   --  AND af.dt_inicio_afastamento = TO_DATE(:DT_INICIO_AFASTAMENTO,''DD/MM/RRRR'');',
'  --',
'  rAtestFunc    cAtestFunc%ROWTYPE;',
'  --',
'  vVerif     NUMBER DEFAULT 0;',
'begin',
'  OPEN cAtestFunc;',
'  FETCH cAtestFunc INTO rAtestFunc;',
'  CLOSE cAtestFunc;',
'  --',
'  IF rAtestFunc.dt_termino_afastamento IS NOT NULL THEN',
'    IF rAtestFunc.dt_termino_afastamento <> TO_DATE(:DT_TERMINO_AFASTAMENTO, ''DD/MM/RRRR'') OR ',
'       rAtestFunc.dt_inicio_afastamento <> TO_DATE(:DT_INICIO_AFASTAMENTO, ''DD/MM/RRRR'') THEN',
'      vVerif := 1;',
'    END IF;',
'  ELSE',
'    vVerif := 1;',
'  END IF;',
'  --',
'  --pkg_mt_cad_atest_medico.prc_valida_feriasX(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento);',
'  IF vVerif = 1 THEN',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, v_flg, v_msg, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'  ',
'  --if v_flg <> ''S'' and trim(v_msg) is not null then',
unistr('  --  v_msg := ''Colaborador em f\00E9rias!! [T\00C9RMINO AFASTAMENTO]'';'),
'  --ELSE',
'  --  v_msg := NULL;',
'    --return v_msg;',
'  --end if;',
'  END IF;',
'  --',
'  return v_msg; ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_TERMINO_AFASTAMENTO'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(164895417818135994530)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>'Valida Termino'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :DT_TERMINO_AFASTAMENTO IS NOT NULL THEN',
'    IF TO_DATE(:DT_TERMINO_AFASTAMENTO, ''DD/MM/RRRR'') < TO_DATE(:DT_INICIO_AFASTAMENTO, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''T\00C9RMINO menor que in\00EDcio!'';'),
'    END IF;',
'  END IF;',
'  --',
'  if vReturn is null then ',
'    pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, vReturn, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'  end if;',
'RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_exec_cond_for_each_row=>'Y'
,p_associated_column=>'DT_TERMINO_AFASTAMENTO'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(6854413362306514097)
,p_tabular_form_region_id=>wwv_flow_api.id(38607704786752966949)
,p_validation_name=>unistr('Valida Exclus\00E3o')
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :APEX$ROW_STATUS = ''D'' THEN',
'    vReturn := PKG_MT_CAD_ATEST_MEDICO.fnc_VerifDelAtestadoFunc(pRowid => :ROWID);',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166666326240765123360)
,p_name=>unistr('Retorna Informa\00E7\00F5es Funcion\00E1rioOLD')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_MATRICULA'
,p_condition_element=>'P12_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775071879884163122)
,p_event_id=>wwv_flow_api.id(166666326240765123360)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_SITUACAO INFORMACOES_FUNCIONAIS.SITUACAO%TYPE;',
'',
'BEGIN',
'  ',
'   ---',
'   SELECT IFC.SITUACAO',
'     INTO  V_SITUACAO',
'   FROM   INFORMACOES_FUNCIONAIS_CAD IFC',
'    WHERE  IFC.MATRICULA   = :P12_MATRICULA',
'    AND    IFC.COD_EMPRESA = :P12_COD_EMPRESA;',
'',
'     ---',
'     :p12_situacao := v_situacao;',
' ---',
' exception',
'   when  no_data_found then',
'         :p12_situacao := null;',
'',
'END;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA'
,p_attribute_03=>'P12_SITUACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775071716554163120)
,p_event_id=>wwv_flow_api.id(166666326240765123360)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P12_SITUACAO" ).getValue() >= 90){',
'  ',
unistr('    alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('    alertify.confirm(''Funcion\00E1rio desligado. Deseja continuar com o lan\00E7amento?'', function (e) {'),
'        if (e) {',
'        console.log(''Continua'');',
'        apex.submit({',
'          request:"",',
'          set:{"P12_COD_EMPRESA":apex.item( "P12_COD_EMPRESA" ).getValue(), "P12_MATRICULA":apex.item( "P12_MATRICULA" ).getValue()}',
'        });',
'',
'        } else {',
unistr('            console.log(''N\00E3o continua'');'),
'        }',
'    });',
'}else{',
'          apex.submit({',
'          request:"",',
'          set:{"P12_COD_EMPRESA":apex.item( "P12_COD_EMPRESA" ).getValue(), "P12_MATRICULA":apex.item( "P12_MATRICULA" ).getValue()}',
'        });',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166666305002092982864)
,p_name=>'Set QTD DIAS AFASTAMENTO'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_TERMINO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166666305140163982865)
,p_event_id=>wwv_flow_api.id(166666305002092982864)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :DT_TERMINO_AFASTAMENTO is not null then',
'  if length(:DT_TERMINO_AFASTAMENTO) = 8 then',
'    :DT_TERMINO_AFASTAMENTO2 := to_char(to_date(:DT_TERMINO_AFASTAMENTO,''dd/mm/yyyy''),''dd/mm'')||''/20''|| to_char(to_date(:DT_TERMINO_AFASTAMENTO,''dd/mm/yyyy''), ''yy'');',
'  else',
'    :DT_TERMINO_AFASTAMENTO2 := to_date(:DT_TERMINO_AFASTAMENTO,''dd/mm/yyyy'');',
'  end if;',
'end if;',
':QTDE_DIAS_AFASTAMENTO := to_number((to_date(:DT_TERMINO_AFASTAMENTO2,''dd/mm/yyyy'') - to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'')))+1;',
'',
'pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO2);'))
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO'
,p_attribute_03=>'QTDE_DIAS_AFASTAMENTO,DT_TERMINO_AFASTAMENTO2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166775072237020163125)
,p_name=>'Set DT_TERMINO_AFASTAMENTO'
,p_event_sequence=>30
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'QTDE_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775072281814163126)
,p_event_id=>wwv_flow_api.id(166775072237020163125)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :DT_TERMINO_AFASTAMENTO is null then',
'    :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'  end if;',
'end;'))
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,QTDE_DIAS_AFASTAMENTO'
,p_attribute_03=>'DT_TERMINO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(117726446715984038350)
,p_name=>'validar_dt'
,p_event_sequence=>50
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_INICIO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166675435334184198837)
,p_event_id=>wwv_flow_api.id(117726446715984038350)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :p12_flag     := null;',
'  :p12_mensagem := null;',
'',
'  if :DT_INICIO_AFASTAMENTO is not null then',
'    if length(:DT_INICIO_AFASTAMENTO) = 8 then',
'      :DT_INICIO_AFASTAMENTO2 := to_char(to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy''),''dd/mm'')||''/20''|| to_char(to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy''), ''yy'');',
'    else',
'      :DT_INICIO_AFASTAMENTO2 := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'');',
'    end if;',
'  end if;',
'',
unistr('  -- F\00C9RIAS PRIMEIRO (teste) - usando a mesma vari\00E1vel que funciona no QTDE'),
'  pkg_mt_cad_atest_medico.prc_valida_ferias(',
'     :p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem,',
'     :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO,P12_COD_EMPRESA,P12_MATRICULA'
,p_attribute_03=>'P12_FLAG,P12_MENSAGEM,DT_INICIO_AFASTAMENTO2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166723702697388716925)
,p_name=>'Popula MENSAGEM'
,p_event_sequence=>60
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'OBSERVACAO'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'OBSERVACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166723703171108716930)
,p_event_id=>wwv_flow_api.id(166723702697388716925)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P12_MENSAGEM := :observacao;'
,p_attribute_02=>'OBSERVACAO'
,p_attribute_03=>'P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166723703002754716928)
,p_name=>'Dispara Alerta'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_MENSAGEM'
,p_condition_element=>'P12_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166723703351068716931)
,p_event_id=>wwv_flow_api.id(166723703002754716928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P12_MENSAGEM" ).getValue().length > 0){',
'',
'  if (apex.item( "P12_FLAG" ).getValue() == ''Q''){',
'',
unistr('      alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
'      alertify.confirm(apex.item( "P12_MENSAGEM" ).getValue(), function (e) {',
'          if (e) {',
'              apex.item( "P12_OK" ).setValue("S");',
'          } else {',
'              apex.item( "P12_OK" ).setValue("N");',
'          }',
'      });',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'',
'  }else{',
'',
'    if (apex.item( "P12_FLAG" ).getValue() == ''N'') {',
'      apex.item( "P12_OK" ).setValue("N");',
'    } else {',
'      apex.item( "P12_OK" ).setValue("S");',
'    }',
'',
'    alertify.alert(apex.item( "P12_MENSAGEM" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }',
'  ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166775071974893163123)
,p_name=>'Inicia Alertify'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775072088832163124)
,p_event_id=>wwv_flow_api.id(166775071974893163123)
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
 p_id=>wwv_flow_api.id(166775073264555163136)
,p_name=>'prc_valida_qtd'
,p_event_sequence=>90
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'QTDE_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775073374900163137)
,p_event_id=>wwv_flow_api.id(166775073264555163136)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*begin',
'  pkg_mt_cad_atest_medico.prc_valida_qtd(:p12_cod_empresa, :p12_matricula, :cod_doenca, :p12_flag, :p12_mensagem,:qtde_dias_afastamento);',
'end;*/',
'',
'begin',
'  :p12_flag     := null;',
'  :p12_mensagem := null;',
'',
'  if :DT_TERMINO_AFASTAMENTO is null then',
'    :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'  end if;',
'',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(',
'     :p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem,',
'     :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA,COD_DOENCA,QTDE_DIAS_AFASTAMENTO,DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO'
,p_attribute_03=>'P12_FLAG,P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166775073513258163138)
,p_name=>'prc_valida_ferias'
,p_event_sequence=>100
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_ATESTADO_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166775073644744163139)
,p_event_id=>wwv_flow_api.id(166775073513258163138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  --pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_atestado_medico); ',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA,DT_ATESTADO_MEDICO'
,p_attribute_03=>'P12_FLAG,P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166475820428449251737)
,p_name=>'Atribui CodMoitvoES'
,p_event_sequence=>110
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'COD_MOTIVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166475820516746251738)
,p_event_id=>wwv_flow_api.id(166475820428449251737)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR c2 IS',
'    SELECT x2.cod_motivo_esocial',
'      FROM motivo_alteracoes x2',
'     WHERE x2.cod = :COD_MOTIVO;',
'  --',
'  r2   c2%ROWTYPE;   ',
'BEGIN',
'  IF :COD_MOTIVO IS NOT NULL THEN',
'    OPEN c2;',
'    FETCH c2 INTO r2;',
'    CLOSE c2; ',
'    --',
'    :COD_MOTIVO_ES := r2.cod_motivo_esocial;  ',
'  ELSE',
'    :COD_MOTIVO_ES := NULL;',
'  END IF;',
'END;'))
,p_attribute_02=>'COD_MOTIVO,COD_MOTIVO_ES'
,p_attribute_03=>'COD_MOTIVO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166581791494854034130)
,p_name=>unistr('Retorna Informa\00E7\00F5es Funcion\00E1rio')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166581791598801034131)
,p_event_id=>wwv_flow_api.id(166581791494854034130)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(164888333886886930749)
,p_name=>'prc_valida_ferias_DTI'
,p_event_sequence=>130
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_INICIO_AFASTAMENTO'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'DT_TERMINO_AFASTAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164888333974167930750)
,p_event_id=>wwv_flow_api.id(164888333886886930749)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA,DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO'
,p_attribute_03=>'P12_FLAG,P12_MENSAGEM,DT_INICIO_AFASTAMENTO2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(164888334257914930752)
,p_name=>'prc_valida_ferias_DTF'
,p_event_sequence=>140
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_TERMINO_AFASTAMENTO'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'DT_TERMINO_AFASTAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164888334282260930753)
,p_event_id=>wwv_flow_api.id(164888334257914930752)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_dt_ini   DATE := TO_DATE(:DT_INICIO_AFASTAMENTO, ''DD/MM/RRRR'');',
'  v_dt_fim   DATE := NVL(TO_DATE(:DT_TERMINO_AFASTAMENTO, ''DD/MM/RRRR''), TO_DATE(''31/12/2999'',''DD/MM/RRRR''));',
'  --',
'  v_saida    DATE;',
'  v_retorno  DATE;',
'  v_ind_sit  FERIAS.IND_SITUACAO_PERIODO%TYPE;',
'  --',
'  CURSOR FER IS',
'    SELECT CASE WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1 OR',
'                      DT_SAIDA_PARC1 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC1-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_SAIDA_PARC1',
'                WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1 OR',
'                      DT_SAIDA_PARC2 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC2-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_SAIDA_PARC2',
'                WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1 OR',
'                      DT_SAIDA_PARC4 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC4-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_SAIDA_PARC4',
'           END SAIDA,',
'           CASE WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1 OR',
'                      DT_SAIDA_PARC1 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC1-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_RETORNO_PARC1',
'                WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1 OR',
'                      DT_SAIDA_PARC2 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC2-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_RETORNO_PARC2',
'                WHEN (v_dt_ini BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1 OR',
'                      v_dt_fim BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1 OR',
'                      DT_SAIDA_PARC4 BETWEEN v_dt_ini AND v_dt_fim OR',
'                      DT_RETORNO_PARC4-1 BETWEEN v_dt_ini AND v_dt_fim) THEN DT_RETORNO_PARC4',
'           END RETORNO,',
'           F.IND_SITUACAO_PERIODO',
'      FROM FERIAS F',
'     WHERE ((v_dt_ini BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1)',
'        OR  (v_dt_ini BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1)',
'        OR  (v_dt_ini BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1)',
'        OR  (v_dt_fim BETWEEN DT_SAIDA_PARC1 AND DT_RETORNO_PARC1-1)',
'        OR  (v_dt_fim BETWEEN DT_SAIDA_PARC2 AND DT_RETORNO_PARC2-1)',
'        OR  (v_dt_fim BETWEEN DT_SAIDA_PARC4 AND DT_RETORNO_PARC4-1)',
'        OR  DT_SAIDA_PARC1 BETWEEN v_dt_ini AND v_dt_fim',
'        OR  DT_RETORNO_PARC1-1 BETWEEN v_dt_ini AND v_dt_fim',
'        OR  DT_SAIDA_PARC2 BETWEEN v_dt_ini AND v_dt_fim',
'        OR  DT_RETORNO_PARC2-1 BETWEEN v_dt_ini AND v_dt_fim',
'        OR  DT_SAIDA_PARC4 BETWEEN v_dt_ini AND v_dt_fim',
'        OR  DT_RETORNO_PARC4-1 BETWEEN v_dt_ini AND v_dt_fim)',
'       AND MATRICULA   = :P12_MATRICULA',
'       AND COD_EMPRESA = :P12_COD_EMPRESA',
'     ORDER BY 1;',
'BEGIN',
'  :P12_FLAG     := ''S'';',
'  :P12_MENSAGEM := NULL;',
'',
'  IF :DT_INICIO_AFASTAMENTO IS NULL THEN',
'    RETURN;',
'  END IF;',
'',
'  OPEN FER;',
'  FETCH FER INTO v_saida, v_retorno, v_ind_sit;',
'  CLOSE FER;',
'',
'  IF ((v_dt_ini <= v_retorno - 1)',
'      OR (v_saida IS NOT NULL',
'          AND NVL(v_ind_sit,''X'') IN (''G'',''P'',''R'')',
'          AND v_dt_ini + 15 > v_saida)) THEN',
'    :P12_FLAG     := ''A'';',
unistr('    :P12_MENSAGEM := ''COLABORADOR EM PER\00CDODO DE F\00C9RIAS DE '''),
unistr('                     || TO_CHAR(v_saida,''DD/MM/RRRR'') || '' \00C0 '''),
'                     || TO_CHAR(v_retorno - 1,''DD/MM/RRRR'') || ''.'';',
'  END IF;',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    :P12_FLAG     := ''S'';   -- nunca bloqueia por erro na consulta',
'    :P12_MENSAGEM := NULL;',
'END;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA,DT_INICIO_AFASTAMENTO,DT_TERMINO_AFASTAMENTO'
,p_attribute_03=>'P12_FLAG,P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*begin',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p12_cod_empresa, :p12_matricula, :p12_flag, :p12_mensagem, :dt_inicio_afastamento, :DT_TERMINO_AFASTAMENTO, :COD_MOTIVO);',
'end;*/'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(164895417588316994528)
,p_name=>'Verifica Termino'
,p_event_sequence=>150
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_INICIO_AFASTAMENTO'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'DT_TERMINO_AFASTAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164895417737718994529)
,p_event_id=>wwv_flow_api.id(164895417588316994528)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if length(:DT_INICIO_AFASTAMENTO) = 8 then',
'  ',
'    IF :DT_INICIO_AFASTAMENTO IS NOT NULL THEN',
'      IF :QTDE_DIAS_AFASTAMENTO IS NOT NULL THEN',
'      :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'      ELSE',
'      :DT_TERMINO_AFASTAMENTO := NULL;',
'      END IF;',
'    END IF;',
'  else',
'    IF :DT_INICIO_AFASTAMENTO IS NOT NULL THEN',
'      IF :QTDE_DIAS_AFASTAMENTO IS NOT NULL THEN',
'      :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'      ELSE',
'      :DT_TERMINO_AFASTAMENTO := NULL;',
'      END IF;',
'    END IF;',
'  end if;',
'end;',
'   '))
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,QTDE_DIAS_AFASTAMENTO'
,p_attribute_03=>'DT_TERMINO_AFASTAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145280854771428179694)
,p_name=>'alt_COD_ATESTADO_MEDICO'
,p_event_sequence=>160
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'COD_ATESTADO_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145280854869893179695)
,p_event_id=>wwv_flow_api.id(145280854771428179694)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select	max(A.COD_JUSTIFICATIVA)',
'into	:COD_JUSTIFICATIVA',
'from	ATESTADO_MEDICO_PD_JUS A',
'where	A.COD_EMPRESA = :P12_COD_EMPRESA',
'and		A.COD_ATESTADO_MEDICO = :COD_ATESTADO_MEDICO;',
''))
,p_attribute_02=>'P12_COD_EMPRESA,COD_ATESTADO_MEDICO'
,p_attribute_03=>'COD_JUSTIFICATIVA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046991434543124064)
,p_event_id=>wwv_flow_api.id(145280854771428179694)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_sit_func',
'    into :COD_SIT_FUNC',
'    from atestado_medico ',
'    where cod_atestado_medico = :COD_ATESTADO_MEDICO;'))
,p_attribute_02=>'COD_ATESTADO_MEDICO'
,p_attribute_03=>'COD_SIT_FUNC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142046993663151124087)
,p_name=>'Habilita e Desabilita'
,p_event_sequence=>170
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'COD_SIT_FUNC'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'COD_SIT_FUNC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'01'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046993756547124088)
,p_event_id=>wwv_flow_api.id(142046993663151124087)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046994054346124091)
,p_event_id=>wwv_flow_api.id(142046993663151124087)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046993884719124089)
,p_event_id=>wwv_flow_api.id(142046993663151124087)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046993949571124090)
,p_event_id=>wwv_flow_api.id(142046993663151124087)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'HORA_TERMINO_AFASTAMENTO'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142046992967539124080)
,p_name=>'New'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_COD_SIT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046993165296124082)
,p_event_id=>wwv_flow_api.id(142046992967539124080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142046993073819124081)
,p_event_id=>wwv_flow_api.id(142046992967539124080)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'HORA_INICIO_AFASTAMENTO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'12:00'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121660514679554232989)
,p_name=>'VALIDA DATA'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_VALIDA_DATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P12_VALIDA_DATA'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121660514696465232990)
,p_event_id=>wwv_flow_api.id(121660514679554232989)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>unistr('N\00E3o pode adicionar um atestado antes da data de refer\00EAncia.')
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121660514798589232991)
,p_name=>'Retorna  data ref'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P12_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121660514894210232992)
,p_event_id=>wwv_flow_api.id(121660514798589232991)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  select dt_ref_folha ',
'  into :p12_data_ref',
'  from parametros_recursos_humanos where cod_empresa= :p12_cod_empresa;',
'  ',
'  end;'))
,p_attribute_02=>'P12_COD_EMPRESA'
,p_attribute_03=>'P12_DATA_REF'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(117726447030423038353)
,p_name=>'Change DT INICIO 2'
,p_event_sequence=>210
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_INICIO_AFASTAMENTO2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(117726447092879038354)
,p_event_id=>wwv_flow_api.id(117726447030423038353)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':DT_INICIO_AFASTAMENTO := :DT_INICIO_AFASTAMENTO2;'
,p_attribute_02=>'DT_INICIO_AFASTAMENTO2'
,p_attribute_03=>'DT_INICIO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(117726447281879038356)
,p_name=>'Change DT TERMINO 2'
,p_event_sequence=>220
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_TERMINO_AFASTAMENTO2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(117726447368795038357)
,p_event_id=>wwv_flow_api.id(117726447281879038356)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':DT_TERMINO_AFASTAMENTO := :DT_TERMINO_AFASTAMENTO2;'
,p_attribute_02=>'DT_TERMINO_AFASTAMENTO2'
,p_attribute_03=>'DT_TERMINO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6854413460961514098)
,p_name=>unistr('Verifica Dt. T\00E9rmino NULL')
,p_event_sequence=>230
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(38607704786752966949)
,p_triggering_element=>'DT_ATESTADO_MEDICO'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'DT_TERMINO_AFASTAMENTO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6854414551828514109)
,p_event_id=>wwv_flow_api.id(6854413460961514098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn   VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P12_MENSAGEM := NULL;',
'  --',
'  IF :DT_INICIO_AFASTAMENTO IS NOT NULL THEN',
'    vReturn := PKG_MT_CAD_ATEST_MEDICO.fnc_VerifDtTerminoAtestadoFunc(:P12_COD_EMPRESA, :P12_MATRICULA, :DT_INICIO_AFASTAMENTO);',
'    --',
'    IF vReturn IS NOT NULL THEN',
unistr('      :P12_MENSAGEM := ''Afastamento n\00E3o possui data de t\00E9rmino informada!'';'),
'    END IF;',
'  END IF;',
'END;'))
,p_attribute_02=>'DT_INICIO_AFASTAMENTO,P12_MENSAGEM,P12_COD_EMPRESA,P12_MATRICULA'
,p_attribute_03=>'P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6854413706554514100)
,p_name=>unistr('Verifica Existe Dt. T\00E9rmino NULL')
,p_event_sequence=>240
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6854413745655514101)
,p_event_id=>wwv_flow_api.id(6854413706554514100)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn   VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P12_MENSAGEM := NULL;',
'  --',
'  vReturn := PKG_MT_CAD_ATEST_MEDICO.fnc_VerifDtTerminoAtestadoFunc(pEmp => :P12_COD_EMPRESA',
'                                                                   ,pMat => :P12_MATRICULA);',
'  --',
'  IF vReturn IS NOT NULL THEN',
'    :P12_MENSAGEM := REPLACE(REPLACE(vReturn,''['',''<strong>''),'']'',''</strong>'');',
'  END IF;',
'END;'))
,p_attribute_02=>'P12_COD_EMPRESA,P12_MATRICULA,P12_MENSAGEM'
,p_attribute_03=>'P12_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166666325822483122054)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Retorna Informa\00E7\00F5es Funcion\00E1rio')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
' select (select c.cod||'' - ''||c.nome',
'           from cargos c',
'          where c.cod = infu.cargo) cargo',
'       ,(select distinct infu.cod_ccusto||'' - ''||cc.nome ',
'           from centro_de_custo cc',
'          where infu.cod_empresa = cc.cod_empresa ',
'            and infu.cod_ccusto = cc.cod) setor',
'       ,cod_local_trab||'' - ''|| descricao local',
'       ,lotr.predio',
'       ,lotr.andar',
'       ,lotr.sala   ',
'       ,inpe.tipo_sanguineo',
'       ,inpe.fator_rh',
'       ,trunc(trunc(sysdate - inpe.dt_nasc)/360) idade',
'    ',
'   into :P12_CARGO',
'       ,:P12_COD_CCUSTO',
'       ,:P12_COD_LOCALIZACAO',
'       ,:P12_PREDIO',
'       ,:P12_ANDAR',
'       ,:P12_SALA',
'       ,:P12_TIPO_SANGUINEO',
'       ,:P12_FATOR_RH',
'       ,:P12_IDADE    ',
'',
'   from informacoes_funcionais infu',
'       ,inf_pessoais inpe',
'       ,local_trab lotr       ',
'  where infu.cod_empresa = inpe.cod_empresa',
'    and infu.matricula = inpe.matricula',
'    and lotr.cod_local_trab = infu.cod_localizacao',
'    and inpe.cod_empresa = :P12_COD_EMPRESA ',
'    and inpe.matricula = :P12_MATRICULA;',
'',
'exception',
' when no_data_found then',
'  :P12_CARGO := null;',
'  :P12_COD_CCUSTO := null;',
'  :P12_COD_LOCALIZACAO := null;',
'  :P12_PREDIO := null;',
'  :P12_ANDAR := null;',
'  :P12_SALA := null;',
'  :P12_TIPO_SANGUINEO := null;',
'  :P12_FATOR_RH := null;',
'  :P12_IDADE := null;',
'end;',
'',
'',
'DECLARE',
'',
'V_SITUACAO INFORMACOES_FUNCIONAIS.SITUACAO%TYPE;',
'  --',
'  CURSOR cSituacao IS',
'    SELECT s.cod||'' - ''||s.nome',
'      FROM sit_func s',
'     WHERE s.cod = :P12_SITUACAO; ',
'',
'BEGIN',
'  ',
'   ---',
'   SELECT IFC.SITUACAO',
'     INTO  V_SITUACAO',
'   FROM   INFORMACOES_FUNCIONAIS_CAD IFC',
'    WHERE  IFC.MATRICULA   = :P12_MATRICULA',
'    AND    IFC.COD_EMPRESA = :P12_COD_EMPRESA;',
'',
'   ---',
'   :p12_situacao := v_situacao;',
'   --',
'   OPEN cSituacao;',
'   FETCH cSituacao INTO :P12_DESC_SITUACAO;',
'   CLOSE cSituacao;',
'     ',
' ---',
' exception',
'   when  no_data_found then',
'         :p12_situacao := null;',
'         :P12_DESC_SITUACAO := NULL;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':P12_COD_EMPRESA is not null and :P12_MATRICULA is not null'
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166581791433866034129)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atribui NULL Itens Pesquisa'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P12_CARGO           := NULL;',
'  :P12_COD_CCUSTO      := NULL;',
'  :P12_COD_LOCALIZACAO := NULL;',
'  :P12_PREDIO          := NULL;',
'  :P12_ANDAR           := NULL;',
'  :P12_SALA            := NULL;',
'  :P12_TIPO_SANGUINEO  := NULL;',
'  :P12_FATOR_RH        := NULL;',
'  :P12_IDADE           := NULL;',
'  :P12_SITUACAO        := NULL;',
'  :P12_DESC_SITUACAO   := NULL;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P12_MATRICULA'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166666304884834982863)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set ENTIDADE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  select to_char(max(e.cod_entidade))',
'        ,to_char(max(e.tipo_entidade))',
'    into :COD_ENTIDADE',
'        ,:TIPO_ENTIDADE',
'    from entidade e',
'   where rowidtochar(e.rowid) = :ENTIDADE_LOV;',
'',
'  if length(:DT_INICIO_AFASTAMENTO) = 8 then',
'    IF :DT_TERMINO_AFASTAMENTO IS NULL THEN',
'      :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'    END IF;',
'  else',
'    IF :DT_TERMINO_AFASTAMENTO IS NULL THEN',
'      :DT_TERMINO_AFASTAMENTO := to_date(:DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + :QTDE_DIAS_AFASTAMENTO - 1;',
'    END IF;',
'  end if;',
'end;',
'   ',
'   '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166666305206686982866)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set DESC_MOTIVO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select max(mot.descricao)',
'  into :DESC_MOTIVO',
'  from motivo_alteracoes mot ',
' where mot.cod = :COD_MOTIVO;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166475820343058251736)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Dados Complementares'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR c1 IS ',
'    SELECT max(x1.origem) origem, max(x1.nr_documento) nr_documento, max(x1.uf_documento) uf_documento',
'      FROM vw_medicos x1',
'     WHERE x1.cod = :COD_PREST_SERV;',
'  --',
'  r1   c1%ROWTYPE;',
'  --',
'  CURSOR c2 IS',
'    SELECT max(x2.cod_motivo_esocial) cod_motivo_esocial',
'      FROM motivo_alteracoes x2',
'     WHERE x2.cod = :COD_MOTIVO;',
'  --',
'  r2   c2%ROWTYPE;   ',
'BEGIN',
'  IF /*:ORIGEM_MED IS NULL AND :CRM_PREST_SERV_RESP IS NULL AND :UF_CRM_PREST_RESP IS NULL AND*/ :COD_PREST_SERV IS NOT NULL THEN',
'    OPEN c1;',
'    FETCH c1 INTO r1;',
'    CLOSE c1;',
'    --',
'    :ORIGEM_MED          := r1.origem;',
'    :CRM_PREST_SERV_RESP := r1.nr_documento;',
'    :UF_CRM_PREST_RESP   := r1.uf_documento;',
'  END IF;',
'  --',
'  IF /*:COD_MOTIVO_ES IS NULL AND*/ :COD_MOTIVO IS NOT NULL THEN',
'    OPEN c2;',
'    FETCH c2 INTO r2;',
'    CLOSE c2; ',
'    --',
'    :COD_MOTIVO_ES := r2.cod_motivo_esocial;  ',
'  END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166475820707781251740)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atestado - Pre_DEL'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  errExcpt EXCEPTION;',
'BEGIN ',
'  :P12_MENSAGEM := NULL;',
'  --',
'  IF :APEX$ROW_STATUS = ''D'' THEN',
'    pkg_mt_cad_atest_medico.prc_PreDelete(:COD_EMPRESA ',
'                                         ,:MATRICULA',
'                                         ,:DC_MATRICULA',
'                                         ,:DT_INICIO_AFASTAMENTO',
'                                         ,:DT_TERMINO_AFASTAMENTO',
'                                         ,:COD_MOTIVO ',
'                                         ,:COD_ATESTADO_MEDICO ',
'                                         ,:USUARIO',
'                                         ,:P12_FLAG',
'                                         ,:P12_MENSAGEM);',
'  END IF;',
'  --',
'  IF :P12_MENSAGEM IS NOT NULL THEN',
'    RAISE errExcpt;',
'  END IF;',
'EXCEPTION',
'  WHEN errExcpt THEN',
'    RAISE_APPLICATION_ERROR(-20912, ''ERRO - Processamento PRE-DELETE - ATESTADO_FUNCIONARIO: ''||:P12_MENSAGEM);',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166475819753578251731)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Atestados - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166475820632878251739)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(38607704786752966949)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atestados - Post_INS_UPD'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  errExcpt EXCEPTION;',
'BEGIN ',
'  :P12_MENSAGEM := NULL;',
'    ',
'  --',
'  CASE :APEX$ROW_STATUS',
'    WHEN ''C'' THEN',
'      /*pkg_mt_cad_atest_medico.post_insert(:COD_EMPRESA ',
'                                         ,:MATRICULA',
'                                         ,:COD_ATESTADO_MEDICO',
'                                         ,:DT_INICIO_AFASTAMENTO',
'                                         ,:DT_TERMINO_AFASTAMENTO',
'                                         ,:COD_MOTIVO',
'                                         ,:USUARIO',
'                                         ,:P12_FLAG',
'                                         ,:P12_MENSAGEM);*/',
'      pkg_mt_cad_atest_medico.TRATA_LANCTO_ATEST_HISTCAD(:COD_EMPRESA ',
'                                                        ,:MATRICULA',
'                                                        ,:DT_INICIO_AFASTAMENTO',
'                                                        ,:P12_FLAG',
'                                                        ,:P12_MENSAGEM',
'                                                        ,:P_USUARIO);                                         ',
'    WHEN ''U'' THEN',
'      pkg_mt_cad_atest_medico.prc_PostUpdate(:COD_EMPRESA ',
'                                            ,:MATRICULA',
'                                            ,:COD_ATESTADO_MEDICO',
'                                            ,:DT_INICIO_AFASTAMENTO',
'                                            ,:DT_TERMINO_AFASTAMENTO',
'                                            ,:COD_MOTIVO',
'                                            ,:P_USUARIO',
'                                            ,:P12_FLAG',
'                                            ,:P12_MENSAGEM);',
'    WHEN ''D'' THEN',
'      NULL;',
'    ELSE',
'      NULL;',
'    END CASE;',
'    --',
'    IF :P12_MENSAGEM IS NOT NULL THEN',
'      RAISE errExcpt;',
'    END IF;',
'EXCEPTION',
'  WHEN errExcpt THEN',
'    RAISE_APPLICATION_ERROR(-20912, ''[''||:APEX$ROW_STATUS||''] ''||''ERRO - Processamento ATESTADO_FUNCIONARIO: ''||:P12_MENSAGEM);',
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
