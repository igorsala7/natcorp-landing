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
--   Date and Time:   01:42 Saturday October 3, 2026
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
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Manuten\00E7\00E3o de Exames M\00E9dicos ')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Manuten\00E7\00E3o de Exames M\00E9dicos')
,p_autocomplete_on_off=>'OFF'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_LancamentoExames.css / Natcorp_LancamentoExames.js)',
'',
unistr('Por cima do grid "Exames": o paciente fixo no alto (c\00F3digo - nome, idade, cargo, setor, local, sangue),'),
unistr('"Trocar paciente" (empresa e matr\00EDcula) e os cadastros de m\00E9dico e entidade; a SITUA\00C7\00C3O de cada exame'),
unistr('(o \00FAltimo, com o pr\00F3ximo: vencido, vence em breve, em dia) com "Lan\00E7ar de novo"; o HIST\00D3RICO do mais'),
unistr('novo ao mais antigo (data, exame, tipo, resultado com cor, pr\00F3ximo, m\00E9dico, procedimento), com busca e'),
unistr('filtro por exame. Tocar num exame abre o resumo (s\00F3 leitura); Editar, Lan\00E7ar exame e Lan\00E7ar de novo'),
unistr('abrem a vista de um registro do pr\00F3prio grid numa gaveta, em quatro partes, com atalhos para o pr\00F3ximo'),
unistr('exame (+6 meses, +1 ano, +2 anos). Salvar grava s\00F3 o exame da ficha, pelo salvar do grid (processos e'),
unistr('valida\00E7\00F5es de sempre). Para desligar: tire as duas URLs de arquivo. Guia: LANCAMENTOEXAMES-MANUTENCAO.md.')))
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LancamentoExames.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LancamentoExames.css'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_chained=>'N'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20240822122754'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166666022968315997234)
,p_plug_name=>'Exames'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select  ef."ROWID"',
'        ,ef.cod_empresa	   ',
'        ,ef.matricula	   ',
'        ,ef.dc_matricula  	',
'        ,ef.cod_exame	   ',
'        ,ef.dt_exame	   ',
'        ,ef.cod_resultado	',
'        ,ef.cod_prest_serv_origem	',
'        ,ef.cod_prest_serv',
'        ,lpad(ef.cod_entidade,5,''*'')||lpad(ef.tipo_entidade,2,''*'') cod_entidade_lov',
'        ,ef.ordem_exame',
'        ,ef.dt_prox_exame_period 	',
'        ,ef.usuario	',
'        ,ef.dt_atualizacao	',
'        ,ef.tipo_prest_serv ',
'        ,ef.cod_entidade',
'        ,ef.tipo_entidade 	',
'        ,ef.tipo_exame	',
'        ,ef.ocupacional 	',
'        ,ef.complemento_exame 	',
'        ,ef.cod_exame_lab',
'        ,ef.cod_procedimento',
'        ,ef.obs_procedimento',
'        ,EF.AUDIOMETRIA          ',
'        ,EF.CGC_LAB',
'        ,EF.DC_CGC_LAB',
'from exame_func ef, informacoes_funcionais_cad i',
'where ef.cod_empresa = i.cod_empresa',
'  and ef.matricula = i.matricula',
'  and ef.cod_empresa = :P11_COD_EMPRESA',
'  and ef.matricula = :P11_MATRICULA'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130885883424242896714)
,p_name=>'CGC_LAB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CGC_LAB'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'CGC'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>490
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
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
 p_id=>wwv_flow_api.id(130885883536554896715)
,p_name=>'DC_CGC_LAB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DC_CGC_LAB'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'DC'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>500
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
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
 p_id=>wwv_flow_api.id(130937660278445691878)
,p_name=>'COD_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'LEFT'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>true
,p_max_length=>5
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663137504590817270)
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
 p_id=>wwv_flow_api.id(130937660360814691879)
,p_name=>'DT_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_EXAME'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>290
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
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
 p_id=>wwv_flow_api.id(130937660452988691880)
,p_name=>'COD_RESULTADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_RESULTADO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Resultado'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>350
,p_value_alignment=>'LEFT'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descricao) ||'' - eSocial: ''||cod_resultado_es d',
'      ,cod_resultado r',
'  from resultado',
'--* where tipo_resultado = ''E''',
' order by tipo_resultado, cod_resultado'))
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
 p_id=>wwv_flow_api.id(130937660600086691881)
,p_name=>'COD_PREST_SERV_ORIGEM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV_ORIGEM'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Origem'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>310
,p_value_alignment=>'LEFT'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>5
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,e.cod_entidade r',
'  from entidade e',
' where e.tipo_entidade = ''1'' --nvl(:TIPO_PREST_SERV, e.tipo_entidade) '))
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
 p_id=>wwv_flow_api.id(130937660669067691882)
,p_name=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>unistr('M\00E9dico')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>340
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
' select cod||'' - ''||nome d',
'      ,cod r',
'  from vw_medicos',
'--where cod_empresa = nvl(:COD_EMPRESA, cod_empresa) ',
' order by 1 '))
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
 p_id=>wwv_flow_api.id(130937660849256691884)
,p_name=>'ORDEM_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDEM_EXAME'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ordem Exame'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>330
,p_value_alignment=>'RIGHT'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:1 - Inicial;1,2 - Sequencial;2'
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
 p_id=>wwv_flow_api.id(130937660992333691885)
,p_name=>'DT_PROX_EXAME_PERIOD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_PROX_EXAME_PERIOD'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>unistr('Data Pr\00F3ximo Exame')
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130937661031282691886)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>460
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':APP_USER'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130937661159807691887)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>470
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(130937661306032691888)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>450
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
 p_id=>wwv_flow_api.id(130937661381945691889)
,p_name=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>430
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
 p_id=>wwv_flow_api.id(130937661428322691890)
,p_name=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_ENTIDADE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>440
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
 p_id=>wwv_flow_api.id(130937661538891691891)
,p_name=>'TIPO_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo Exame'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>400
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166663244795284334940)
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
 p_id=>wwv_flow_api.id(130937661688758691892)
,p_name=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OCUPACIONAL'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Ocupacional'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>410
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
 p_id=>wwv_flow_api.id(130937661781024691893)
,p_name=>'COMPLEMENTO_EXAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPLEMENTO_EXAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Complemento Exame'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>360
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>200
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
 p_id=>wwv_flow_api.id(130937661849111691894)
,p_name=>'COD_EXAME_LAB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EXAME_LAB'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Cod. Exame Lab.'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>370
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>17
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
 p_id=>wwv_flow_api.id(130937661983058691895)
,p_name=>'COD_PROCEDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PROCEDIMENTO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Procedimento'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>380
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166664169820669840846)
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
 p_id=>wwv_flow_api.id(130937662102209691896)
,p_name=>'OBS_PROCEDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBS_PROCEDIMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Observa\00E7\00E3o Procedimento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>390
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>800
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
 p_id=>wwv_flow_api.id(130937662171407691897)
,p_name=>'AUDIOMETRIA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AUDIOMETRIA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Audiometria'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>420
,p_value_alignment=>'LEFT'
,p_link_target=>'f?p=&APP_ID.:95:&SESSION.::&DEBUG.:RP,95:P95_COD_EMPRESA,P95_FILIAL,P95_COD_CCUSTO,P95_MATRICULA,P95_DATA_REF:&P11_COD_EMPRESA.,&P11_FILIAL.,&P11_COD_LOCALIZACAO_AUX.,&P11_MATRICULA.,&DT_EXAME.'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
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
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(131094596151214126816)
,p_name=>'COD_ENTIDADE_LOV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ENTIDADE_LOV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Entidade'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>300
,p_value_alignment=>'LEFT'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>7
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select e.cod_entidade||'' - ''||e.nome_entidade d',
'      ,lpad(e.cod_entidade,5,''*'')||lpad(e.tipo_entidade,2,''*'') r',
'  from entidade e',
' where e.tipo_entidade in (1, 7)'))
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
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(131446177520177540355)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>480
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666023204955997236)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
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
,p_default_expression=>'P11_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666023309138997237)
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
,p_default_expression=>'P11_MATRICULA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666023387550997238)
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
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select dc_matricula',
'  from informacoes_funcionais',
' where cod_empresa = :P11_COD_EMPRESA',
'   and matricula = :P11_MATRICULA'))
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666025573288997260)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166666025697654997261)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166666023114938997235)
,p_internal_uid=>645171955310742416
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
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SAVE'
,p_add_button_label=>'Adicionar Exame'
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
 p_id=>wwv_flow_api.id(166666180557604528929)
,p_interactive_grid_id=>wwv_flow_api.id(166666023114938997235)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166666180603297528929)
,p_report_id=>wwv_flow_api.id(166666180557604528929)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130895666403573739062)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>39
,p_column_id=>wwv_flow_api.id(130885883424242896714)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130895667042519739064)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>40
,p_column_id=>wwv_flow_api.id(130885883536554896715)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937684097734806851)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(130937660278445691878)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>183
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937686202226822843)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(130937660360814691879)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937686700999822844)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(130937660452988691880)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937687118966822845)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(130937660600086691881)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937687650765822846)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(130937660669067691882)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937688709312822849)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(130937660849256691884)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937689195574822851)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(130937660992333691885)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937689684939822852)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>34
,p_column_id=>wwv_flow_api.id(130937661031282691886)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937690137200822854)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>35
,p_column_id=>wwv_flow_api.id(130937661159807691887)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937690653174822855)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>36
,p_column_id=>wwv_flow_api.id(130937661306032691888)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937691172522822856)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>37
,p_column_id=>wwv_flow_api.id(130937661381945691889)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937691711734822857)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>38
,p_column_id=>wwv_flow_api.id(130937661428322691890)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937692125979822858)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(130937661538891691891)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937692661218822859)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(130937661688758691892)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937693185104822860)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(130937661781024691893)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937693630210822861)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(130937661849111691894)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937694122913822862)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(130937661983058691895)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937694612969822864)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(130937662102209691896)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>162
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937695138659822865)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(130937662171407691897)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(130937710359187873157)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(131094596151214126816)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>108
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(131447430668088702082)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(131446177520177540355)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166666181033569528934)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166666023204955997236)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>162
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166666181504386528938)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166666023309138997237)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>188
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166666182042171528941)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166666023387550997238)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>139
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166666248295131705322)
,p_view_id=>wwv_flow_api.id(166666180603297528929)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166666025573288997260)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167303438208292731052)
,p_plug_name=>unistr('Pesquisar Funcion\00E1rio')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167944961316642324996)
,p_plug_name=>unistr('Manuten\00E7\00E3o de Exames M\00E9dicos - Medicina do Trabalho')
,p_icon_css_classes=>'fa-address-book-o'
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
,p_plug_display_condition_type=>'NEVER'
,p_plug_header=>unistr('<p>Manuten\00E7\00E3o de Exames M\00E9dicos</p>')
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664088786160591338)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&SESSION.::&DEBUG.:RP,11::'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166663262669232578951)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_button_name=>'MEDICO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cadastro de M\00E9dico')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:39:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166663262816040578952)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664089211845591338)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_button_name=>'PESQUISAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(166685297746946052863)
,p_branch_name=>'Back to Request Page'
,p_branch_action=>'f?p=&APP_ID.:&P11_PAGE_REQUEST.:&SESSION.::&DEBUG.:RP,11::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'NEVER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140147305389543450640)
,p_name=>'P11_FILIAL'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140147306879435450655)
,p_name=>'P11_COD_LOCALIZACAO_AUX'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166664089570137591339)
,p_name=>'P11_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166664090451626591340)
,p_name=>'P11_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_prompt=>unistr('Matr\00EDcula')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select infu.matricula||''-''||infu.dc_matricula||'' - ''||inpe.nome d',
'       ,infu.matricula',
'   from informacoes_funcionais infu',
'       ,inf_pessoais inpe',
' where infu.cod_empresa = inpe.cod_empresa',
'   and infu.matricula = inpe.matricula',
'   and inpe.cod_empresa = :P11_COD_EMPRESA',
' order by infu.matricula;'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P11_COD_EMPRESA'
,p_ajax_items_to_submit=>'P11_COD_EMPRESA'
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
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166664091251389591341)
,p_name=>'P11_CARGO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664091565185591341)
,p_name=>'P11_COD_CCUSTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664091972029591341)
,p_name=>'P11_COD_LOCALIZACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664092372879591342)
,p_name=>'P11_PREDIO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_prompt=>'Predio'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166664092822007591342)
,p_name=>'P11_ANDAR'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664093170819591342)
,p_name=>'P11_SALA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664093597056591342)
,p_name=>'P11_TIPO_SANGUINEO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
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
 p_id=>wwv_flow_api.id(166664094003997591343)
,p_name=>'P11_FATOR_RH'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_prompt=>'Fator RH'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_named_lov=>'LOV_FATOR_RH'
,p_lov=>'.'||wwv_flow_api.id(166662305668566490472)||'.'
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166664094411517591343)
,p_name=>'P11_IDADE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_prompt=>'Idade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166685297579380052862)
,p_name=>'P11_PAGE_REQUEST'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167303438208292731052)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166695039237679598044)
,p_tabular_form_region_id=>wwv_flow_api.id(166666022968315997234)
,p_validation_name=>unistr('Obriga se Toxicol\00F3gico')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :COD_EXAME = ''TO'' and :COD_EXAME_LAB is null then',
unistr('return ''Informa\00E7\00E3o obrigat\00F3ria para exame Toxicol\00F3gico!'';'),
'else',
'return null;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'COD_EXAME_LAB'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165222930376814634639)
,p_name=>unistr('Retorna Informa\00E7\00F5es Funcion\00E1rio')
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P11_MATRICULA'
,p_condition_element=>'P11_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165222930478162634640)
,p_event_id=>wwv_flow_api.id(165222930376814634639)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140147305523878450641)
,p_name=>'SET FILIAL'
,p_event_sequence=>30
,p_condition_element=>'P11_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140147305658005450642)
,p_event_id=>wwv_flow_api.id(140147305523878450641)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT FILIAL ',
'INTO :P11_FILIAL',
'FROM INFORMACOES_FUNCIONAIS',
'WHERE COD_EMPRESA = :P11_COD_EMPRESA',
'AND MATRICULA = :P11_MATRICULA;'))
,p_attribute_02=>'P11_COD_EMPRESA,P11_MATRICULA'
,p_attribute_03=>'P11_FILIAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(130885883866106896718)
,p_name=>'SET CGC'
,p_event_sequence=>40
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166666022968315997234)
,p_triggering_element=>'COD_ENTIDADE_LOV'
,p_condition_element_type=>'COLUMN'
,p_condition_element=>'COD_ENTIDADE_LOV'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130885883984234896719)
,p_event_id=>wwv_flow_api.id(130885883866106896718)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CGC ',
'INTO :CGC_LAB',
'FROM ENTIDADE WHERE COD_ENTIDADE = replace(substr(:COD_ENTIDADE_LOV,1,5),''*'')',
'AND TIPO_ENTIDADE = replace(substr(:COD_ENTIDADE_LOV,6,7),''*'');',
'',
'SELECT DC_CGC ',
'INTO :DC_CGC_LAB',
'FROM ENTIDADE WHERE COD_ENTIDADE = replace(substr(:COD_ENTIDADE_LOV,1,5),''*'')',
'AND TIPO_ENTIDADE = replace(substr(:COD_ENTIDADE_LOV,6,7),''*'');'))
,p_attribute_02=>'COD_ENTIDADE_LOV'
,p_attribute_03=>'CGC_LAB,DC_CGC_LAB'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130895679169252933572)
,p_event_id=>wwv_flow_api.id(130885883866106896718)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'CGC_LAB,DC_CGC_LAB'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663263079838578955)
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
'      -- ,trunc(trunc(sysdate - inpe.dt_nasc)/360) idade',
'      ,TRUNC((MONTHS_BETWEEN(sysdate,inpe.dt_nasc)/12)) IDADE',
'       ,(select distinct infu.cod_ccusto',
'           from centro_de_custo cc',
'          where infu.cod_empresa = cc.cod_empresa ',
'            and infu.cod_ccusto = cc.cod) setor_aux',
'    ',
'   into :P11_CARGO',
'       ,:P11_COD_CCUSTO',
'       ,:P11_COD_LOCALIZACAO',
'       ,:P11_PREDIO',
'       ,:P11_ANDAR',
'       ,:P11_SALA',
'       ,:P11_TIPO_SANGUINEO',
'       ,:P11_FATOR_RH',
'       ,:P11_IDADE   ',
'       ,:P11_COD_LOCALIZACAO_AUX',
'',
'   from informacoes_funcionais infu',
'       ,inf_pessoais inpe',
'       ,local_trab lotr       ',
'  where infu.cod_empresa = inpe.cod_empresa',
'    and infu.matricula = inpe.matricula',
'    and lotr.cod_local_trab = infu.cod_localizacao',
'    and inpe.cod_empresa = :P11_COD_EMPRESA ',
'    and inpe.matricula = :P11_MATRICULA;',
'',
'exception',
' when no_data_found then',
'  :P11_CARGO := null;',
'  :P11_COD_CCUSTO := null;',
'  :P11_COD_LOCALIZACAO := null;',
'  :P11_PREDIO := null;',
'  :P11_ANDAR := null;',
'  :P11_SALA := null;',
'  :P11_TIPO_SANGUINEO := null;',
'  :P11_FATOR_RH := null;',
'  :P11_IDADE := null;',
'  :P11_COD_LOCALIZACAO_AUX := NULL;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>':P11_COD_EMPRESA is not null and :P11_MATRICULA is not null'
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166666026443950997268)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166666022968315997234)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set ENTIDADE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':COD_ENTIDADE := replace(substr(:COD_ENTIDADE_LOV,1,5),''*'');',
':TIPO_ENTIDADE :=replace(substr(:COD_ENTIDADE_LOV,6,7),''*'');',
':dt_exame := to_date(:dt_exame,''dd/mm/rrrr'');',
':dt_prox_exame_period := to_date(:dt_prox_exame_period,''dd/mm/rrrr'');',
':dt_atualizacao := to_date(:dt_atualizacao,''dd/mm/rrrr'');',
''))
,p_process_error_message=>'Set ENTIDADE - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166666025807565997262)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166666022968315997234)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Exames - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_process_error_message=>'Exames - Save Interactive Grid Data - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143047155350042409268)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_region_id=>wwv_flow_api.id(166666022968315997234)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Tipo Prest Serv'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cWMMed IS',
'    SELECT vm.origem',
'          ,DECODE(vm.origem, ''MI'',''1'', ''ME'',''7'') tip_prest_serv',
'      FROM vw_medicos vm',
'     WHERE vm.cod = :COD_PREST_SERV;',
'  --',
'  rWMMed    cWMMed%ROWTYPE;',
'BEGIN',
'  IF :APEX$ROW_STATUS IN(''C'', ''U'') THEN',
'    OPEN cWMMed;',
'    FETCH cWMMed INTO rWMMed;',
'    CLOSE cWMMed;',
'    --',
'    :TIPO_PREST_SERV := rWMMed.tip_prest_serv;',
'  END IF;',
'END;',
'',
''))
,p_process_error_message=>'Atualiza Tipo Prest Serv - #SQLERRM#'
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
