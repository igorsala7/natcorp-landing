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
--   Date and Time:   13:21 Monday September 28, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 168
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00168
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>168);
end;
/
prompt --application/pages/page_00168
begin
wwv_flow_api.create_page(
 p_id=>168
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Benef\00EDcios')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Benef\00EDcios')
,p_allow_duplicate_submissions=>'N'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'img { height: 100px }',
'',
'.t-Report-colHead {',
'vertical-align: bottom;',
'padding: 10px;',
'font-weight: 700;',
'-webkit-font-smoothing: antialiased;',
'}',
'',
'.t-Report-cell, .t-Report-colHead {',
'padding: 7px;',
'border-left: 1px solid #dadada;',
'border-top: 1px solid #dadada;',
'}',
'',
'.t-Region-headerItems {padding: 4px;}',
'.t-Region-headerItems--title {padding: 4px;}',
'.t-Button {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--icon {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--iconRight {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--noLabel {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--iconOnly {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.t-Button--noUI {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px;}',
'.a-IRR-toolbar {margin: 0px; 0px; 0px; 0px; margin-bottom: 0px; padding: 2px; 2px; 2px; 2px;}',
'',
'.a-IRR-buttons .t-Button {',
'    margin-bottom: 0px;',
'}',
'',
'.a-IRR-controlGroup {',
'    margin-bottom: 0px;',
'}',
'',
'.t-Button--hideShow.t-Button {',
'    margin-bottom: 4px;',
'    margin-top: 4px;',
'}',
'',
'.t-Button--hideShow {',
'    margin-bottom: 4px;',
'    margin-top: 4px;',
'}',
'*/'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ANDRE.BONI'
,p_last_upd_yyyymmddhh24miss=>'20260610135836'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281325453205178023061)
,p_plug_name=>unistr('Escolha os Benef\00EDcios')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P168_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281325513404095091448)
,p_name=>unistr('Benef\00EDcios Escolhidos')
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'   select DISTINCT case when b.req_colab = ''S'' and t.req_colab = ''S'' and PKG_REQ_BENEFICIO.Benef_Prazo_Permitido(r.cod_empresa, r.matricula,b.cod_familia, t.tipo_cod_familia,to_date(:p168_dt_vigencia,''dd/mm/rrrr'') -1,''D'') = ''S''',
'   then ''Remover'' end REMOVER, ',
'          R.COD_EMPRESA, ',
'          R.MATRICULA, ',
'          R.COD_FAMILIA, ',
'          initcap(B.DESCRICAO_FAMILIA) BENEFICIO, ',
'          R.TIPO_COD_FAMILIA, ',
'          initcap(T.DESCRICAO_TIPO) TIPO_BENEFICIO, ',
'          R.VALOR_TIPO VALOR_MINIMO, ',
'          R.VALOR_TETO VALOR_MAXIMO, ',
'          R.VALOR valor_escolhido, ',
'          r.quantidade, ',
'          nvl(r.quantidade,1)*r.valor valor_total,',
'          r.dt_vigencia_ini',
'     from REQ_BENEFICIOS_ITENS_TEMP R, BENEFICIOS_FAMILIA B, BENEFICIOS_FAMILIA_TIPO T',
'    where r.cod_empresa = b.cod_empresa',
'      and r.cod_empresa = t.cod_empresa',
'      and r.cod_familia = b.cod_familia',
'      and r.cod_familia = t.cod_familia',
'      and r.tipo_cod_familia = t.tipo_cod_familia',
'      and R.cod_empresa = :p168_cod_empresa',
'      and R.matricula = :p168_matricula',
'      AND nvl(R.OPERACAO,''Z'') <> ''D''',
'order by R.COD_FAMILIA, R.TIPO_COD_FAMILIA, 12'))
,p_display_when_condition=>'P168_ROWID'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P168_COD_EMPRESA,P168_MATRICULA,P168_DT_VIGENCIA'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('Escolha um benef\00EDcio e clique em Adicionar.')
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281315913459530037232)
,p_query_column_id=>1
,p_column_alias=>'REMOVER'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:167:&SESSION.::&DEBUG.:RP,167:P167_COD_EMPRESA,P167_COD_FAMILIA,P167_DT_VIGENCIA_FIM,P167_MATRICULA,P167_TIPO_COD_FAMILIA,P167_REMOVER,P167_DT_VIGENCIA_INI:#COD_EMPRESA#,#COD_FAMILIA#,&P168_DT_VIGENCIA.,#MATRICULA#,#TIPO_COD_FAMILIA#,#RE'
||'MOVER#,#DT_VIGENCIA_INI#'
,p_column_linktext=>'#REMOVER#'
,p_column_link_attr=>'data-id="#BENEFICIO#" class="apagarBeneficio t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325513500743091449)
,p_query_column_id=>2
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325514080538091455)
,p_query_column_id=>3
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325513660813091450)
,p_query_column_id=>4
,p_column_alias=>'COD_FAMILIA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325514188683091456)
,p_query_column_id=>5
,p_column_alias=>'BENEFICIO'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325513691624091451)
,p_query_column_id=>6
,p_column_alias=>'TIPO_COD_FAMILIA'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325514375214091457)
,p_query_column_id=>7
,p_column_alias=>'TIPO_BENEFICIO'
,p_column_display_sequence=>5
,p_column_heading=>unistr('Tipo de Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325513778703091452)
,p_query_column_id=>8
,p_column_alias=>'VALOR_MINIMO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281325513901095091453)
,p_query_column_id=>9
,p_column_alias=>'VALOR_MAXIMO'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281295546809648290249)
,p_query_column_id=>10
,p_column_alias=>'VALOR_ESCOLHIDO'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281295546888244290250)
,p_query_column_id=>11
,p_column_alias=>'QUANTIDADE'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281295546988788290251)
,p_query_column_id=>12
,p_column_alias=>'VALOR_TOTAL'
,p_column_display_sequence=>12
,p_column_heading=>'Valor total'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_column_alignment=>'CENTER'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(268848281571120303459)
,p_query_column_id=>13
,p_column_alias=>'DT_VIGENCIA_INI'
,p_column_display_sequence=>13
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281341952875149865244)
,p_plug_name=>unistr('Par\00E2metros')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281346346676323431321)
,p_name=>unistr('Benef\00EDcios Requisitados')
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>90
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_new_grid_column=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select DISTINCT initcap(b.descricao_familia) Benef\00EDcio, '),
unistr('                initcap(t.descricao_tipo)||decode(v.desconta_saldo,''N'','' (N\00E3o Desconta Saldo)'') Tipo_Benef\00EDcio, '),
'                case when v.desconta_saldo = ''S'' then ',
'                          DECODE(i.operacao,''D'',0,''I'',(nvl(i.quantidade,1)*i.valor),(nvl(i.quantidade,1)*i.valor)) ',
'                     when v.desconta_saldo = ''N'' then ',
'                          null ',
'                     end Valor_Total,  ',
'                DECODE(i.operacao,''D'',(nvl(i.quantidade,1)*i.valor),null) valor_anterior, ',
'                DECODE(i.operacao,''D'',''Removido'',''I'',''Inserido'',''-'') Tipo',
'  from beneficios_familia b, beneficios_familia_tipo t, beneficios_fam_tipo_vlr v, req_beneficios_itens i, req_beneficios r',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_familia = i.cod_familia',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and t.tipo_cod_familia = i.tipo_cod_familia',
'   and r.dt_req between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and r.dt_req between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate) ',
'   and r.dt_req between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and b.cod_empresa = r.cod_empresa',
'   and r.cod_req = i.cod_req',
'   and r.cod_req = :p168_cod_req',
'   and r.cod_empresa = :p168_cod_empresa',
'   and r.matricula = :p168_matricula',
' order by 1,2,3'))
,p_display_when_condition=>'P168_ROWID'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P168_COD_EMPRESA,P168_MATRICULA,P168_COD_REQ'
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
 p_id=>wwv_flow_api.id(281324563061265863827)
,p_query_column_id=>1
,p_column_alias=>unistr('BENEF\00CDCIO')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324563443346863827)
,p_query_column_id=>2
,p_column_alias=>unistr('TIPO_BENEF\00CDCIO')
,p_column_display_sequence=>3
,p_column_heading=>unistr('Tipo de Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281295546735875290248)
,p_query_column_id=>3
,p_column_alias=>'VALOR_TOTAL'
,p_column_display_sequence=>4
,p_column_heading=>'Valor Total'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281255053431816215382)
,p_query_column_id=>4
,p_column_alias=>'VALOR_ANTERIOR'
,p_column_display_sequence=>5
,p_column_heading=>'Valor Ant.'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_print_col_width=>'300'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281255053345328215381)
,p_query_column_id=>5
,p_column_alias=>'TIPO'
,p_column_display_sequence=>1
,p_column_heading=>unistr('Opera\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_report_column_width=>100
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281346349021292431344)
,p_name=>unistr('Benef\00EDcios Atuais')
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>60
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select DISTINCT initcap(b.descricao_familia) Benef\00EDcio, '),
unistr('                initcap(t.descricao_tipo)||decode(v.desconta_saldo,''N'','' (N\00E3o Desconta Saldo)'') Tipo_Benef\00EDcio, '),
'                CASE WHEN v.desconta_saldo = ''S'' THEN ',
'                          to_number(decode((nvl(i.quantidade,1)*nvl(i.valor_beneficio,0)),0,(v.valor_tipo * nvl(v.quantidade,1)),(nvl(i.quantidade,1)*i.valor_beneficio))) ',
'                     WHEN v.desconta_saldo = ''N'' THEN ',
'                          null ',
'                end Valor_Total',
'  from beneficios_familia b, beneficios_familia_tipo t, beneficios_fam_tipo_vlr v, incor_beneficios_funcionais i',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_empresa = i.cod_empresa',
'   and b.cod_familia = i.flag',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and t.tipo_cod_familia = i.tipo',
'   and v.desconta_saldo = ''S''',
'   and nvl(:P168_DT_REQ,sysdate) between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and nvl(:P168_DT_REQ,sysdate) between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate)',
'   and nvl(:P168_DT_REQ,sysdate) between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and nvl(:P168_DT_REQ,sysdate) between i.dt_inicio and nvl(i.dt_fim,sysdate)',
'   and i.cod_empresa = :p168_cod_empresa',
'   and i.matricula = :p168_matricula',
' order by 1,2,3'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P168_COD_EMPRESA,P168_MATRICULA,P168_DT_REQ'
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
 p_id=>wwv_flow_api.id(281282196328690054157)
,p_query_column_id=>1
,p_column_alias=>unistr('BENEF\00CDCIO')
,p_column_display_sequence=>1
,p_column_heading=>unistr('Benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281282196474279054158)
,p_query_column_id=>2
,p_column_alias=>unistr('TIPO_BENEF\00CDCIO')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Tipo benef\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281282196551987054159)
,p_query_column_id=>3
,p_column_alias=>'VALOR_TOTAL'
,p_column_display_sequence=>3
,p_column_heading=>'Valor Total'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281392645368343390645)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_BENEFICIOS a, usuario_oracle u',
' where a.cod_solicitacao = :p168_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa (+)',
'   and a.mat_aprov = u.cd_matricula (+)',
'   --and u.cd_perfil NOT IN (''BUSINESS PARTNER'',''REMUNERACAO'',''CONT DE NEGOCIOS'')',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_BENEFICIOS a, usuario_oracle u',
' where a.cod_solicitacao = :p168_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_BENEFICIOS',
' where cod_Solicitacao = :p168_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P168_COD_REQ'
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
 p_id=>wwv_flow_api.id(281324573635716863843)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_lov_show_nulls=>'YES'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324573987023863843)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324574380185863843)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324574829465863844)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>5
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_inline_lov=>'STATIC:Pendente;P,Aprovado;A,Reprovado;R'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324575215386863844)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281324575618192863844)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(280858781797382338717)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(280915453380399284170)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>4
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392648941596390649)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392650570336390650)
,p_plug_name=>'&P168_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392656537764390654)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392657311657390657)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281392656537764390654)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392658169990390658)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281392656537764390654)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281392752285506930413)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>1
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281404529436169682497)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324578593265863847)
,p_button_sequence=>270
,p_button_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_button_name=>'p168_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P168 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P168_COD_EMP_REQ.,&P168_MAT_REQ.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324576070381863845)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281392645368343390645)
,p_button_name=>'p168_btn_reprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_beneficios',
' where cod_solicitacao = :p168_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P''',
'and 1 = 2'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940536234126165770)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281392645368343390645)
,p_button_name=>'p168_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P168_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.Valida_Sequencia(:p168_cod_empresa, :p168_cod_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'return false;',
'else',
'return true;',
'end if; ',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324577100961863846)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281392648941596390649)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:166:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(280612097039974543111)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281392648941596390649)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.:RP:P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324577529179863846)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281392648941596390649)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P168_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281325512580508091440)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_button_name=>'ADICIONAR'
,p_button_static_id=>'ADICIONAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324577910597863846)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281392648941596390649)
,p_button_name=>'CREATE'
,p_button_static_id=>'P168_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P168_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324576467509863845)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281392645368343390645)
,p_button_name=>'p168_btn_aprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_beneficios',
' where cod_solicitacao = :p168_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P''',
'and 1 = 2'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940536396014165771)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281392645368343390645)
,p_button_name=>'p168_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P168_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.Valida_Sequencia(:p168_cod_empresa, :p168_cod_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'return false;',
'else',
'return true;',
'end if; ',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324585736967863851)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281392656537764390654)
,p_button_name=>'ALTERA_COLAB'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Alterar Colaborador'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p168_rowid is null and :P_PAINEL <> ''PC'' then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281324586118492863851)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281392656537764390654)
,p_button_name=>'p168_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P168_COD_EMPRESA.,&P168_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281324631950162863876)
,p_branch_name=>'Go To Page 166'
,p_branch_action=>'f?p=&APP_ID.:166:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(281324577910597863846)
,p_branch_sequence=>10
,p_branch_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_branch_condition=>'P168_OK'
,p_branch_condition_text=>'S'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(280866961546909804116)
,p_branch_name=>'Go To Page 166'
,p_branch_action=>'f?p=&APP_ID.:166:&SESSION.::&DEBUG.:RP::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(281324577529179863846)
,p_branch_sequence=>20
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(280868941423207455116)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>30
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(280915453169184284168)
,p_name=>'P168_JUSTIFICATIVA_APROV'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281392645368343390645)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281195981093351918879)
,p_name=>'P168_OPCAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>unistr('Op\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Complementares;C,Obrigat\00F3rios;O')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281195981164269918880)
,p_name=>'P168_TOT_MULTIPLO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Total'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
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
 p_id=>wwv_flow_api.id(281255053853697215386)
,p_name=>'P168_COD_REQ_ALT_FUNC'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281295547101820290252)
,p_name=>'P168_QUANTIDADE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Quantidade'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
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
 p_id=>wwv_flow_api.id(281315913372422037231)
,p_name=>'P168_DT_VIGENCIA'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281392658169990390658)
,p_prompt=>unistr('Data de Vig\00EAncia')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324561906198863824)
,p_name=>'P168_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281341952875149865244)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod',
'from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P168_COD_REQ is null) or ',
'        (:P168_COD_REQ is not null))',
'UNION',
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod',
'  from empresas',
' where COD = :P_EMPRESA_USER',
'   and :p_painel = ''PC''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P168_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324562365025863825)
,p_name=>'P168_MATRICULA'
,p_is_required=>true
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281341952875149865244)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p168_cod_empresa',
'   and i.situacao < ''90''',
'   and :p_painel in (''PG'',''PO'')',
'union',
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
'  from informacoes_funcionais i',
' where i.cod_empresa = :P_EMPRESA_USER',
'   and i.matricula = :P_MATRICULA_USER',
'   and i.situacao < ''90''',
'   and :p_painel = ''PC''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P168_COD_EMPRESA'
,p_ajax_items_to_submit=>'P168_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324572202800863841)
,p_name=>'P168_TOTAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Total a Distribuir'
,p_format_mask=>'FML999G999G999G999G990D00'
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
 p_id=>wwv_flow_api.id(281324572649035863841)
,p_name=>'P168_SALDO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Saldo a Distribuir'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324579017745863847)
,p_name=>'P168_TITULO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324579434025863848)
,p_name=>'P168_ROWID'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324579843028863848)
,p_name=>'P168_FLAG'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324580238959863848)
,p_name=>'P168_MENSAGEM'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324580672773863848)
,p_name=>'P168_OK'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324581028562863849)
,p_name=>'P168_COD_REQ'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_grid_label_column_span=>2
,p_read_only_when=>'P168_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324581465389863849)
,p_name=>'P168_COD_SIT_REQ'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select Initcap(desc_sit_REQ) descricao, cod_sit_req',
'   from SIT_REQ',
'   order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324581826036863849)
,p_name=>'P168_DT_REQ'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Abertura'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_read_only_when=>'P168_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324582258927863849)
,p_name=>'P168_SOLICITANTE'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
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
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324582670875863849)
,p_name=>'P168_ITEM_VALIDACAO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324583066931863850)
,p_name=>'P168_USUARIO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324583444686863850)
,p_name=>'P168_DT_ATUALIZACAO'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324583872037863850)
,p_name=>'P168_DT_SIT_REQ'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324584263795863850)
,p_name=>'P168_COD_EMP_REQ'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324584651264863851)
,p_name=>'P168_MAT_REQ'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324584986269863851)
,p_name=>'P168_FIL_REQ'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(281392650570336390650)
,p_use_cache_before_default=>'NO'
,p_source=>'FIL_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324586871569863852)
,p_name=>'P168_FOTO_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281392657311657390657)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P168_COD_EMPRESA',
'   and matricula = :P168_MATRICULA'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281324587549255863853)
,p_name=>'P168_COD_EMPRESA_DISPLAY'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281392658169990390658)
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
 p_id=>wwv_flow_api.id(281324587912353863853)
,p_name=>'P168_MATRICULA_DISPLAY'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281392658169990390658)
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
 p_id=>wwv_flow_api.id(281324588277401863853)
,p_name=>'P168_SITUACAO_COLAB'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281392658169990390658)
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
 p_id=>wwv_flow_api.id(281324588746964863853)
,p_name=>'P168_DT_ADMISSAO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281392658169990390658)
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
 p_id=>wwv_flow_api.id(281325453282942023062)
,p_name=>'P168_BENEFICIO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>unistr('Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(b.descricao_familia) descricao, b.cod_familia',
'  from beneficios_familia b, beneficios_familia_tipo t, beneficios_fam_tipo_vlr v, informacoes_funcionais i, cargos c, centro_de_custo cc',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_empresa = i.cod_empresa',
'   and b.cod_empresa = cc.cod_empresa',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and i.cargo = c.cod',
'   and i.cod_ccusto = cc.cod',
'   and sysdate between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and sysdate between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate)',
'   and sysdate between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and b.req_colab = ''S''',
'   and t.req_colab = ''S''',
'   and i.cod_empresa = :p168_cod_empresa',
'   and i.matricula = :p168_matricula',
'   and fnct_valida_eleg_beneficio(i.cod_empresa, ',
'                                  i.matricula, ',
'                                  i.cad_vaga, ',
'                                  b.cod_familia, ',
'                                  t.tipo_cod_familia,',
'                                  sysdate,',
'                                  i.filial,',
'                                  c.class_cargo,',
'                                  i.grupo_salarial,',
'                                  i.num_sind_diss,',
'                                  i.cod_ccusto,',
'                                  i.unidade_adm,',
'                                  cc.cod_un_negocio, ',
'                                  i.cod_atividade,',
'                                  null,',
'                                  null,',
'                                  i.cargo,',
'                                  i.reg_trab,',
'                                  i.vinculo,',
'                                  null,',
'                                  i.cod_horario',
'                                 ) = ''S''',
'   and PKG_REQ_BENEFICIO.Benef_Prazo_Permitido(i.cod_empresa, i.matricula,b.cod_familia, t.tipo_cod_familia,:p168_dt_vigencia,''I'') = ''S''',
'   and ((b.cod_familia = ''BC'' and :p168_opcao = ''C'') or (:p168_opcao = ''O'' and b.cod_familia <> ''BC''))',
'   AND ((FNCT_BENEF_VALIDA_FORN_DIF (:p168_cod_empresa,',
'                                   :p168_matricula,',
'                                   ''O'',',
'                                   T.FORNECEDOR) = ''S'' and :p168_opcao = ''C'') or ',
'        (FNCT_BENEF_VALIDA_FORN_DIF (:p168_cod_empresa,',
'                                   :p168_matricula,',
'                                   ''BC'',',
'                                   b.cod_familia) = ''S'' and :p168_opcao = ''O''))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P168_COD_EMPRESA,P168_MATRICULA, P168_OPCAO,P168_DT_VIGENCIA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281325453440689023063)
,p_name=>'P168_TIPO_BENEFICIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>unistr('Tipo de Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('   SELECT t.descricao_tipo||decode(v.desconta_saldo,''N'','' (N\00E3o Desconta Saldo)'') descricao, t.tipo_cod_familia'),
'     FROM beneficios_familia b, beneficios_familia_tipo t, beneficios_fam_tipo_vlr v, informacoes_funcionais i, cargos c, centro_de_custo cc',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_empresa = i.cod_empresa',
'   and b.cod_empresa = cc.cod_empresa',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and i.cargo = c.cod',
'   and i.cod_ccusto = cc.cod',
'   and sysdate between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and sysdate between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate)',
'   and sysdate between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and b.req_colab = ''S''',
'   and t.req_colab = ''S''',
'   and i.cod_empresa = :p168_cod_empresa',
'   and i.matricula = :p168_matricula',
'   and fnct_valida_eleg_beneficio(i.cod_empresa, ',
'                                  i.matricula, ',
'                                  i.cad_vaga, ',
'                                  b.cod_familia, ',
'                                  t.tipo_cod_familia,',
'                                  sysdate,',
'                                  i.filial,',
'                                  c.class_cargo,',
'                                  i.grupo_salarial,',
'                                  i.num_sind_diss,',
'                                  i.cod_ccusto,',
'                                  i.unidade_adm,',
'                                  cc.cod_un_negocio,',
'                                  i.cod_atividade,',
'                                  null,',
'                                  null,',
'                                  i.cargo,',
'                                  i.reg_trab,',
'                                  i.vinculo,',
'                                  null,',
'                                  i.cod_horario) = ''S''',
'   and PKG_REQ_BENEFICIO.Benef_Prazo_Permitido(i.cod_empresa, i.matricula,b.cod_familia, t.tipo_cod_familia,:p168_dt_vigencia,''I'') = ''S''',
'   AND B.COD_EMPRESA = :P168_COD_EMPRESA',
'   AND B.COD_FAMILIA = :P168_BENEFICIO',
'   and (t.COD_EMPRESA, t.COD_FAMILIA, t.TIPO_COD_FAMILIA) not in ',
'   (select R.COD_EMPRESA, R.COD_FAMILIA, R.TIPO_COD_FAMILIA',
'      from REQ_BENEFICIOS_ITENS_TEMP R',
'     where R.cod_empresa = :p168_cod_empresa',
'       and R.matricula = :p168_matricula',
'       and (R.operacao is null or r.operacao = ''I'')',
'     UNION ',
'    select TX.COD_EMPRESA, TX.COD_FAMILIA, TX.TIPO_COD_FAMILIA',
'      from REQ_BENEFICIOS_ITENS_TEMP TX, BENEFICIOS_FAMILIA B',
'     where TX.cod_empresa = :p168_cod_empresa',
'       and TX.matricula = :p168_matricula',
'       AND TX.COD_EMPRESA = B.COD_EMPRESA',
'       AND TX.COD_FAMILIA = B.COD_FAMILIA',
'       AND B.CATEGORIA IN (''A'',''R'',''AR'')',
'       and (TX.operacao is null or TX.operacao = ''I''))',
'   AND (((FNCT_BENEF_VALIDA_FORN_DIF (:p168_cod_empresa,',
'                                   :p168_matricula,',
'                                   ''O'',',
'                                   T.FORNECEDOR) = ''S'' AND :p168_opcao = ''C'') AND (FNCT_BENEF_VALIDA_FORN_DIF (:p168_cod_empresa,',
'                                   :p168_matricula,',
'                                   ''C'',',
'                                   T.FORNECEDOR) = ''S'' AND :p168_opcao = ''C'')) OR ',
'        (FNCT_BENEF_VALIDA_FORN_DIF (:p168_cod_empresa,',
'                                   :p168_matricula,',
'                                   ''C'',',
'                                   b.cod_familia) = ''S'' AND :p168_opcao = ''O''))',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P168_COD_EMPRESA,P168_MATRICULA,P168_OPCAO,P168_BENEFICIO,P168_DT_VIGENCIA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281325453558492023064)
,p_name=>'P168_VALOR_MIN'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Valor'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281325453582519023065)
,p_name=>'P168_VALOR_MAX'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>unistr('Valor M\00E1ximo')
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281325453749966023066)
,p_name=>'P168_VALOR'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_prompt=>'Valor Escolhido'
,p_format_mask=>'999G999G999G999G990D00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281328163278517910755)
,p_name=>'P168_OK_VALOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281325453205178023061)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(280877755470544483570)
,p_validation_name=>'Valida Remanejamento'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.operacao',
'  from req_beneficios_itens_temp i',
' where i.cod_empresa = :P168_COD_EMPRESA',
'   and i.matricula = :p168_matricula',
'   and i.operacao in (''I'',''D'');',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.operacao is null then',
unistr('    return(''N\00E3o foi realizado nenhum remanejamento pelo usu\00E1rio. Reveja as op\00E7\00F5es antes de criar a requisi\00E7\00E3o.'');'),
'    end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281295547920521290260)
,p_validation_name=>unistr('Benef\00EDcios Obrigat\00F3rios')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p_Perfil <> ''REMUNERACAO'' then',
'',
'pkg_req_beneficio.valida_benef_obrigatorio(:p168_cod_empresa, :p168_matricula, 0, v_flg_retorno, v_msg_retorno);',
'',
'if trim(v_msg_retorno) is not null then',
'return trim(v_msg_retorno);',
'end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281255762238912675415)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_req_beneficio.valida_matricula(:p168_cod_empresa, :p168_MATRICULA, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'if trim(v_msg_retorno) is not null then',
'return trim(v_msg_retorno);',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281295547841331290259)
,p_validation_name=>'Possui Saldo'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
'pkg_req_beneficio.valida_saldo(:p168_saldo, ''CREATE'', v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    return trim(v_msg_retorno);',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_associated_item=>wwv_flow_api.id(281324572649035863841)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281326758685775712780)
,p_validation_name=>'Algo Errado'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_Perfil <> ''REMUNERACAO'' then',
'',
'if :p168_ok = ''N'' then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Corrija as informa\00E7\00F5es para poder continuar.')
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_associated_item=>wwv_flow_api.id(281324580672773863848)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281328163886095910761)
,p_validation_name=>'Algo Errado 2'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_Perfil <> ''REMUNERACAO'' then',
'',
'',
'if :p168_ok_valor = ''N'' then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Corrija as informa\00E7\00F5es para poder continuar.')
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_associated_item=>wwv_flow_api.id(281328163278517910755)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(280915453291665284169)
,p_validation_name=>unistr('Obrigat\00F3rio Justificativa')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P168_JUSTIFICATIVA_APROV is null and :P168_ROWID is not null then',
unistr('return(''A Justificativa \00E9 Obrigat\00F3ria!'');'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(280915453543266284171)
,p_validation_name=>unistr('Valida se Inseriu Benef\00EDcios')
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'   select DISTINCT R.COD_EMPRESA, R.MATRICULA, R.COD_FAMILIA, R.TIPO_COD_FAMILIA',
'     from REQ_BENEFICIOS_ITENS_TEMP R, BENEFICIOS_FAMILIA B, BENEFICIOS_FAMILIA_TIPO T',
'    where r.cod_empresa = b.cod_empresa',
'      and r.cod_empresa = t.cod_empresa',
'      and r.cod_familia = b.cod_familia',
'      and r.cod_familia = t.cod_familia',
'      and r.tipo_cod_familia = t.tipo_cod_familia',
'      and R.cod_empresa = :p168_cod_empresa',
'      and R.matricula = :p168_matricula',
'      AND nvl(R.OPERACAO,''Z'') in (''I'',''D'')',
'order by 1,2,3,4;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.TIPO_COD_FAMILIA is null then',
unistr('return ''Para criar a requisi\00E7\00E3o, deve-se remanejar os benef\00EDcios!'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269412085467923065354)
,p_validation_name=>'Valida Valores Escolhidos'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'  for l1 in (',
'     select DISTINCT',
'            R.COD_EMPRESA, ',
'            R.MATRICULA, ',
'            R.COD_FAMILIA, ',
'            initcap(B.DESCRICAO_FAMILIA) BENEFICIO, ',
'            R.TIPO_COD_FAMILIA, ',
'            initcap(T.DESCRICAO_TIPO) TIPO_BENEFICIO, ',
'            R.VALOR_TIPO VALOR_MIN,',
'            R.VALOR_TETO VALOR_MAX,',
'            R.VALOR valor_escolhido, ',
'            r.quantidade, ',
'            nvl(r.quantidade,1)*r.valor valor_total',
'       from REQ_BENEFICIOS_ITENS_TEMP R, BENEFICIOS_FAMILIA B, BENEFICIOS_FAMILIA_TIPO T',
'      where r.cod_empresa = b.cod_empresa',
'        and r.cod_empresa = t.cod_empresa',
'        and r.cod_familia = b.cod_familia',
'        and r.cod_familia = t.cod_familia',
'        and r.tipo_cod_familia = t.tipo_cod_familia',
'        and R.cod_empresa = :p168_cod_empresa',
'        and R.matricula = :p168_matricula',
'        AND nvl(R.OPERACAO,''Z'') = ''I''',
'  order by R.COD_FAMILIA, R.TIPO_COD_FAMILIA)',
'  loop',
'',
'   -- pkg_req_beneficio.valida_valor(l1.valor_escolhido, l1.quantidade, l1.valor_min, l1.valor_max, :p168_saldo, v_flg_retorno, v_msg_retorno);',
'',
'    if ( nvl(l1.valor_escolhido,0) not between nvl(l1.valor_min,0) and nvl(l1.valor_max,0) ) and l1.valor_max is not null then',
'      v_flg_retorno := ''N'';',
'      v_msg_retorno := ''O Valor escolhido deve estar entre ''||nvl(l1.valor_min,0)||'' e ''||nvl(l1.valor_max,0);',
'    elsif  nvl(l1.valor_escolhido,0) <> nvl(l1.valor_min,0) and l1.valor_max is null then',
'      v_flg_retorno := ''N'';',
'      v_msg_retorno := ''O Valor escolhido deve ser ''||nvl(l1.valor_min,0)||'' -> l1.valor_max: ''||l1.valor_max;',
'    end if;',
'',
'    if v_flg_retorno = ''N'' and v_msg_retorno is not null then',
'      return v_msg_retorno;',
'    end if;',
'',
'',
'  end loop;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281324577910597863846)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324630011059863875)
,p_name=>'Hide Region'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P168_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324630502012863875)
,p_event_id=>wwv_flow_api.id(281324630011059863875)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281392650570336390650)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324630905063863875)
,p_name=>unistr('Valida Sequ\00EAncia Aprov')
,p_event_sequence=>1031
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324576467509863845)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324631414296863876)
,p_event_id=>wwv_flow_api.id(281324630905063863875)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.Valida_Sequencia(:p168_cod_empresa, :p168_cod_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_SEQUENCIA''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''VALIDA_SEQUENCIA'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK := ''N'';',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P168_MATRICULA,P168_ITEM_VALIDACAO'
,p_attribute_03=>'P168_MENSAGEM,P168_FLAG,P168_OK,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324593050127863857)
,p_name=>unistr('Confirma Aprova\00E7\00E3o')
,p_event_sequence=>1041
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324576467509863845)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P168_OK'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324593568767863858)
,p_event_id=>wwv_flow_api.id(281324593050127863857)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'PROMPT'
,p_attribute_04=>unistr('Deseja Continuar com a Aprova\00E7\00E3o? Digite uma Justificativa.')
,p_attribute_06=>'P168_JUSTIFICATIVA_APROV'
,p_attribute_07=>'Aprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324593983749863858)
,p_event_id=>wwv_flow_api.id(281324593050127863857)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p168_justificativa_aprov is not null then',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_beneficios',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate, justificativa = :p168_justificativa_aprov',
'          where cod_solicitacao = :p168_cod_req',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'        end;',
'    ELSE',
'        begin',
'',
'         update aprova_beneficios',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_solicitacao = :p168_cod_req',
'          and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'',
' pkg_req_beneficio.post_update(:p168_cod_empresa, :p168_cod_req, v_flg_retorno, v_msg_retorno);',
' ',
'else',
'',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''\00C9 obrigat\00F3rio informar uma justificativa!'';'),
'',
'end if;',
'',
' if v_msg_retorno is not null then',
'    :p168_ok       := ''N'';',
'    :p168_flag     := v_flg_retorno;',
'    :p168_mensagem := v_msg_retorno;',
' else',
'    :p168_flag     := null;',
'    :p168_mensagem := null;',
'    :p168_ok       := ''S'';',
' end if;',
'',
'end;',
''))
,p_attribute_02=>'P_USUARIO,P168_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P168_COD_EMPRESA,P_PERFIL,P168_JUSTIFICATIVA_APROV'
,p_attribute_03=>'P168_MENSAGEM,P168_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324594496478863858)
,p_event_id=>wwv_flow_api.id(281324593050127863857)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'success'
,p_attribute_02=>unistr('Requisi\00E7\00E3o Aprovada com Sucesso!')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'true'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'10000'
,p_attribute_11=>'2000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324595012219863859)
,p_event_id=>wwv_flow_api.id(281324593050127863857)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324595422890863859)
,p_name=>unistr('Valida Sequ\00EAncia Reprov')
,p_event_sequence=>1051
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324576070381863845)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324595918561863859)
,p_event_id=>wwv_flow_api.id(281324595422890863859)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.Valida_Sequencia(:p168_cod_empresa, :p168_cod_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_SEQUENCIA''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''VALIDA_SEQUENCIA'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK := ''N'';',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P168_ITEM_VALIDACAO,P168_COD_EMPRESA'
,p_attribute_03=>'P168_MENSAGEM,P168_FLAG,P168_OK,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324596324733863859)
,p_name=>unistr('Valida Matr\00EDcula')
,p_event_sequence=>1061
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324596868960863860)
,p_event_id=>wwv_flow_api.id(281324596324733863859)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'IF :p168_cod_empresa IS NOT NULL AND :p168_MATRICULA IS NOT NULL THEN',
'',
'pkg_req_beneficio.valida_matricula(:p168_cod_empresa, :p168_MATRICULA, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'end if;',
'',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''P168_MATRICULA''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P168_MATRICULA'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_ITEM_VALIDACAO'
,p_attribute_03=>'P168_FLAG,P168_MENSAGEM,P168_OK,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324597268867863860)
,p_name=>unistr('Confirma Reprova\00E7\00E3o')
,p_event_sequence=>1061
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324576070381863845)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P168_OK'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324597677914863860)
,p_event_id=>wwv_flow_api.id(281324597268867863860)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'PROMPT'
,p_attribute_04=>unistr('Deseja Continuar com a Reprova\00E7\00E3o? Digite uma Justificativa.')
,p_attribute_06=>'P168_JUSTIFICATIVA_APROV'
,p_attribute_07=>'Reprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324598210630863860)
,p_event_id=>wwv_flow_api.id(281324597268867863860)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p168_justificativa_aprov is not null then',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_beneficios',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate, justificativa = :p168_justificativa_aprov',
'          where cod_solicitacao = :p168_cod_req',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'        end;',
'    ELSE',
'        begin',
'',
'         update aprova_beneficios',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate, justificativa = :p168_justificativa_aprov',
'          where cod_solicitacao = :p168_cod_req',
'          and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'',
' pkg_req_beneficio.post_update(:p168_cod_empresa, :p168_cod_req, v_flg_retorno, v_msg_retorno);',
' ',
'else',
'',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''\00C9 obrigat\00F3rio informar uma justificativa!'';'),
'',
'end if;',
'',
' if v_msg_retorno is not null then',
'    :p168_ok       := ''N'';',
'    :p168_flag     := v_flg_retorno;',
'    :p168_mensagem := v_msg_retorno;',
' else',
'    :p168_flag     := null;',
'    :p168_mensagem := null;',
'    :p168_ok       := ''S'';',
' end if;',
'',
'end;',
''))
,p_attribute_02=>'P_USUARIO,P168_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P168_COD_EMPRESA,P168_JUSTIFICATIVA_APROV'
,p_attribute_03=>'P168_MENSAGEM,P168_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324598752363863860)
,p_event_id=>wwv_flow_api.id(281324597268867863860)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'error'
,p_attribute_02=>unistr('Requisi\00E7\00E3o Reprovada com Sucesso!')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'true'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'10000'
,p_attribute_11=>'2000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324599216283863861)
,p_event_id=>wwv_flow_api.id(281324597268867863860)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324599676826863861)
,p_name=>'Dispara Alerta'
,p_event_sequence=>1071
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_MENSAGEM'
,p_condition_element=>'P168_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324600078036863861)
,p_event_id=>wwv_flow_api.id(281324599676826863861)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P168_FLAG'').value == "Q") {',
'alertify.confirm($v(''P168_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P168_FLAG'').value = ''S'';',
'        $x(''P168_MENSAGEM'').value = '''';',
'        $x(''P168_OK'').value = ''S'';',
'       // $(''#P168_CREATE'').show();',
'       // $(''#ADICIONAR'').show();',
'    } else {',
'        $x(''P168_OK'').value = ''N'';',
'      //  $(''#P168_CREATE'').hide();',
'      //  $(''#ADICIONAR'').hide();',
'    }',
'});',
'    ',
'     document.getElementById("alertify-cover").style.position="static";',
'    ',
'} else {',
'',
'    if ($x(''P168_MENSAGEM'').value.length  > 0 ) {',
'        /*',
'        if ($x(''P168_FLAG'').value == "N") {',
'          //  $(''#P168_CREATE'').hide();',
'          //  $(''#ADICIONAR'').hide();',
'        } else {',
'          //  $(''#P168_CREATE'').show();',
'         //   $(''#SHOW'').hide();',
'        }',
'           */ ',
'       ',
'        ',
'        //alertify.alert($v(''P168_MENSAGEM''));',
'        alert($v(''P168_MENSAGEM''));',
'        document.getElementById(''P168_BENEFICIO'').focus();',
'    }',
'',
'    // document.getElementById("alertify-cover").style.position="static";',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324600513414863861)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1101
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324600987098863862)
,p_event_id=>wwv_flow_api.id(281324600513414863861)
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
 p_id=>wwv_flow_api.id(281324603275195863863)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>1161
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P168_COD_SIT_REQ'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324603687155863863)
,p_event_id=>wwv_flow_api.id(281324603275195863863)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324604200416863863)
,p_event_id=>wwv_flow_api.id(281324603275195863863)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324616038803863869)
,p_name=>'Alterar Colaborador'
,p_event_sequence=>1241
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324585736967863851)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324616506281863869)
,p_event_id=>wwv_flow_api.id(281324616038803863869)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'delete from req_beneficios_itens_temp where cod_empresa = :p168_cod_empresa and matricula = :p168_matricula;',
'commit;',
'end;',
'',
':p168_cod_empresa := null;',
':p168_matricula := null;',
'',
':p168_ok := ''S'';',
':p168_total := null;',
':p168_saldo := null;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA'
,p_attribute_03=>'P168_COD_EMPRESA,P168_MATRICULA,P168_OK,P168_TOTAL,P168_SALDO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324617017558863869)
,p_event_id=>wwv_flow_api.id(281324616038803863869)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281392656537764390654)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324617555343863869)
,p_event_id=>wwv_flow_api.id(281324616038803863869)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281341952875149865244)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281326758011259712773)
,p_name=>'Valida_Saldo 1'
,p_event_sequence=>1271
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_SALDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281326758162606712774)
,p_event_id=>wwv_flow_api.id(281326758011259712773)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.valida_saldo(:p168_saldo, NULL, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_SALDO 1''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''VALIDA_SALDO 1'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK := ''N'';',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_SALDO,P168_ITEM_VALIDACAO'
,p_attribute_03=>'P168_OK,P168_MENSAGEM,P168_FLAG,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(278797043845470673776)
,p_name=>'Valida_Saldo (Create)'
,p_event_sequence=>1290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324577910597863846)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(278797043973669673777)
,p_event_id=>wwv_flow_api.id(278797043845470673776)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
':P168_OK_valor := ''S'';',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.valida_saldo(:p168_saldo, ''CREATE'', v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    --:P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_SALDO''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''VALIDA_SALDO'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_OK := ''N'';',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_SALDO,P168_ITEM_VALIDACAO'
,p_attribute_03=>'P168_OK,P168_MENSAGEM,P168_FLAG,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324620213957863870)
,p_name=>'show_itens'
,p_event_sequence=>1292
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324577910597863846)
,p_condition_element=>'P168_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324620765634863871)
,p_event_id=>wwv_flow_api.id(281324620213957863870)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_COD_REQ,P168_COD_SIT_REQ,P168_COD_EMP_REQ,P168_COD_EMPRESA,P168_MAT_REQ,P168_MATRICULA,P168_DT_REQ,P168_DT_ATUALIZACAO,P168_USUARIO,P168_DT_SIT_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280877755293905483568)
,p_event_id=>wwv_flow_api.id(281324620213957863870)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$x(''P168_DT_VIGENCIA'').disabled = false;'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324627691928863874)
,p_name=>'Show Solicitado'
,p_event_sequence=>1301
,p_condition_element=>'P168_COD_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324628191793863874)
,p_event_id=>wwv_flow_api.id(281324627691928863874)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281392656537764390654)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324628769748863874)
,p_event_id=>wwv_flow_api.id(281324627691928863874)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281341952875149865244)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324629123235863875)
,p_name=>'valida_sit_req'
,p_event_sequence=>1311
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324629579317863875)
,p_event_id=>wwv_flow_api.id(281324629123235863875)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p168_matricula is not null and :P168_cod_SIT_REQ is not null and :p168_rowid is not null then',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
' pkg_req_beneficio.Valida_Cod_Sit_Solicitacao(:p168_cod_empresa, :p168_cod_req, :P168_COD_SIT_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is null then ',
' goto valida; ',
' end if;',
' ',
' <<valida>>',
'NULL;',
'',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''Valida_Cod_Sit''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''Valida_Cod_Sit'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK := ''N'';',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P168_MATRICULA,P168_ROWID,P168_COD_SIT_REQ,P168_COD_EMPRESA,P168_COD_REQ,P_USUARIO,P168_ITEM_VALIDACAO'
,p_attribute_03=>'P168_FLAG,P168_MENSAGEM,P168_OK,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325455294948023082)
,p_name=>'Valida Valor'
,p_event_sequence=>1321
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_VALOR'
,p_condition_element=>'P168_VALOR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455401057023083)
,p_event_id=>wwv_flow_api.id(281325455294948023082)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.valida_valor(:p168_valor, :p168_quantidade, :p168_valor_min, :p168_valor_max, :p168_saldo, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_VALOR''));',
'    :P168_ok_valor       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''VALIDA_VALOR'')) OR v_item_validacao IS NULL then',
'       :P168_ok_valor := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_ok_valor := ''N'';',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_SALDO,P168_ITEM_VALIDACAO,P168_QUANTIDADE'
,p_attribute_03=>'P168_OK_VALOR,P168_MENSAGEM,P168_FLAG,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281328163379410910756)
,p_name=>'Valida Campos em Branco'
,p_event_sequence=>1330
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281325512580508091440)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281328163565022910757)
,p_event_id=>wwv_flow_api.id(281328163379410910756)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
':P168_OK_VALOR := ''S'';',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
' if :p168_beneficio is null then',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O Campo de Benef\00EDcio n\00E3o pode estar em branco.'';'),
' elsif :p168_tipo_beneficio is null then',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O Campo de Tipo de Benef\00EDcio n\00E3o pode estar em branco.'';'),
' end if;',
'',
' if trim(v_msg_retorno) is not null then',
'   -- :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_CAMPOS''));',
'    :P168_ok_valor       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'   -- if v_item_validacao = TRIM(UPPER(''VALIDA_CAMPOS'')) OR v_item_validacao IS NULL then',
'       :P168_OK_VALOR := ''S''; ',
'       :P168_ITEM_VALIDACAO := null;',
'   /* else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK_VALOR := ''N'';',
'    end if;*/',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_ITEM_VALIDACAO,P168_OPCAO,P168_TIPO_BENEFICIO,P168_BENEFICIO'
,p_attribute_03=>'P168_OK_VALOR,P168_ITEM_VALIDACAO,P168_FLAG,P168_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281328163159439910753)
,p_name=>'Valida Valor (Adicionar)'
,p_event_sequence=>1331
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281325512580508091440)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281328163211318910754)
,p_event_id=>wwv_flow_api.id(281328163159439910753)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
':P168_OK_VALOR := ''S'';',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'pkg_req_beneficio.valida_valor(:p168_valor, :p168_quantidade,:p168_valor_min, :P168_VALOR_MAX, :p168_saldo, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'   -- :P168_ITEM_VALIDACAO := TRIM(UPPER(''VALIDA_VALOR''));',
'    :P168_ok_valor       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'   -- if v_item_validacao = TRIM(UPPER(''VALIDA_VALOR'')) OR v_item_validacao IS NULL then',
'       :P168_OK_VALOR := ''S''; ',
'       :P168_ITEM_VALIDACAO := null;',
'   /* else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK_VALOR := ''N'';',
'    end if;*/',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_SALDO,P168_ITEM_VALIDACAO,P168_QUANTIDADE'
,p_attribute_03=>'P168_OK_VALOR,P168_MENSAGEM,P168_FLAG,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325453839509023067)
,p_name=>'Popula Valor'
,p_event_sequence=>1341
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TIPO_BENEFICIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325453902168023068)
,p_event_id=>wwv_flow_api.id(281325453839509023067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'pkg_req_beneficio.Popula_Valor (:p168_cod_empresa,',
'                        :p168_matricula,',
'                        :p168_beneficio,',
'                        :p168_tipo_beneficio,',
'                        :p168_valor_min,',
'                        :p168_valor_max,',
'                        :p168_valor,',
'                        :p168_quantidade);',
'',
':p168_tot_multiplo := (nvl(:p168_valor,0) * nvl(:p168_quantidade,1));',
'',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_OPCAO,P168_TIPO_BENEFICIO,P168_BENEFICIO'
,p_attribute_03=>'P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_QUANTIDADE,P168_TOT_MULTIPLO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281195981651870918884)
,p_name=>unistr('Popula Somat\00F3ria')
,p_event_sequence=>1351
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TIPO_BENEFICIO,P168_VALOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281195981725027918885)
,p_event_id=>wwv_flow_api.id(281195981651870918884)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor number := :p168_valor;',
'v_qtde  number := :p168_quantidade;',
'',
'begin',
'',
':p168_tot_multiplo := (nvl(v_valor,0) * nvl(v_qtde,1));',
'',
'end;'))
,p_attribute_02=>'P168_VALOR,P168_QUANTIDADE'
,p_attribute_03=>'P168_TOT_MULTIPLO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325454353960023072)
,p_name=>'Esconde Valor Max se Null'
,p_event_sequence=>1361
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TIPO_BENEFICIO'
,p_condition_element=>'P168_VALOR_MAX'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325454446287023073)
,p_event_id=>wwv_flow_api.id(281325454353960023072)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MAX'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325454522338023074)
,p_event_id=>wwv_flow_api.id(281325454353960023072)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MAX'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325454579803023075)
,p_name=>'Esconde Valor Min se 0'
,p_event_sequence=>1371
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TIPO_BENEFICIO'
,p_condition_element=>'P168_TIPO_BENEFICIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(278901604085622941480)
,p_event_id=>wwv_flow_api.id(281325454579803023075)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MIN,P168_VALOR,P168_QUANTIDADE,P168_TOT_MULTIPLO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325454824506023077)
,p_event_id=>wwv_flow_api.id(281325454579803023075)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MIN,P168_VALOR,P168_QUANTIDADE,P168_TOT_MULTIPLO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325454928757023078)
,p_name=>'Clear Itens'
,p_event_sequence=>1381
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_BENEFICIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455024200023079)
,p_event_id=>wwv_flow_api.id(281325454928757023078)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_QUANTIDADE,P168_TOT_MULTIPLO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325455156345023080)
,p_name=>'Esconde Valores'
,p_event_sequence=>1401
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_TIPO_BENEFICIO'
,p_condition_element=>'P168_TIPO_BENEFICIO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455267581023081)
,p_event_id=>wwv_flow_api.id(281325455156345023080)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_QUANTIDADE,P168_TOT_MULTIPLO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325512821633091442)
,p_name=>'Inserir na Temp'
,p_event_sequence=>1411
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281325512580508091440)
,p_condition_element=>'P168_OK_VALOR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325512972057091443)
,p_event_id=>wwv_flow_api.id(281325512821633091442)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into REQ_BENEFICIOS_ITENS_TEMP (COD_EMPRESA, MATRICULA, COD_FAMILIA, TIPO_COD_FAMILIA, VALOR_TIPO, VALOR_TETO, VALOR, DT_VIGENCIA_INI, operacao, quantidade)',
'values (:p168_cod_empresa,:P168_MATRICULA, :p168_beneficio, :p168_tipo_beneficio, :p168_valor_min, :p168_valor_max, :p168_valor, :p168_dt_vigencia, ''I'', :p168_quantidade); ',
'commit;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_OPCAO,P168_TIPO_BENEFICIO,P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR,P168_QUANTIDADE,P168_BENEFICIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325512989562091444)
,p_event_id=>wwv_flow_api.id(281325512821633091442)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325513404095091448)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325513331041091447)
,p_event_id=>wwv_flow_api.id(281325512821633091442)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_OPCAO,P168_TIPO_BENEFICIO,P168_VALOR_MIN,P168_VALOR_MAX,P168_VALOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325455502766023084)
,p_name=>'Change Valor'
,p_event_sequence=>1421
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281325512580508091440)
,p_condition_element=>'P168_OK_VALOR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455648953023085)
,p_event_id=>wwv_flow_api.id(281325455502766023084)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update req_beneficios_itens_temp',
'   set valor = :p168_valor, quantidade = :p168_quantidade',
' where cod_empresa = :p168_cod_empresa',
'   and matricula = :p168_matricula',
'   and cod_familia = :p168_beneficio',
'   and tipo_cod_familia = :p168_tipo_beneficio;',
'   ',
'commit;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_OPCAO,P168_TIPO_BENEFICIO,P168_VALOR,P168_QUANTIDADE,P168_BENEFICIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325455695830023086)
,p_name=>'Atualiza Saldo'
,p_event_sequence=>1431
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281325512580508091440)
,p_condition_element=>'P168_OK_VALOR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455810157023087)
,p_event_id=>wwv_flow_api.id(281325455695830023086)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select sum(nvl(b.valor,0) * nvl(b.quantidade,1)) soma',
'  from REQ_BENEFICIOS_ITENS_TEMP B, beneficios_fam_tipo_vlr v',
' where b.cod_empresa = v.cod_empresa',
'   and b.cod_familia = v.cod_familia',
'   and b.tipo_cod_familia = v.tipo_cod_familia',
'   and v.desconta_saldo = ''S''',
'   and b.cod_empresa = :p168_cod_empresa',
'   and b.matricula = :p168_matricula',
'   and nvl(b.operacao,''Z'') <> ''D'';',
'   ',
'v_c1 c1%rowtype;',
'  ',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p168_saldo := :p168_total - nvl(v_c1.soma,0);',
'',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_TOTAL'
,p_attribute_03=>'P168_SALDO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281325516301016091477)
,p_name=>'DIalog Closed'
,p_event_sequence=>1441
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281325513404095091448)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325516441085091478)
,p_event_id=>wwv_flow_api.id(281325516301016091477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325513404095091448)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325516576659091479)
,p_event_id=>wwv_flow_api.id(281325516301016091477)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select sum(nvl(b.valor,0) * nvl(b.quantidade,1)) soma',
'  from REQ_BENEFICIOS_ITENS_TEMP B, beneficios_fam_tipo_vlr v',
' where b.cod_empresa = v.cod_empresa',
'   and b.cod_familia = v.cod_familia',
'   and b.tipo_cod_familia = v.tipo_cod_familia',
'   and v.desconta_saldo = ''S''',
'   and b.cod_empresa = :p168_cod_empresa',
'   and b.matricula = :p168_matricula',
'   and nvl(b.operacao,''Z'') <> ''D'';',
'   ',
'v_c1 c1%rowtype;',
'  ',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p168_saldo := :p168_total - nvl(v_c1.soma,0);',
'',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_TOTAL'
,p_attribute_03=>'P168_SALDO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280858778292331338682)
,p_event_id=>wwv_flow_api.id(281325516301016091477)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_BENEFICIO,P168_TIPO_BENEFICIO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281328163608617910758)
,p_name=>'Seta Ok'
,p_event_sequence=>1451
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_OK_VALOR'
,p_condition_element=>'P168_OK_VALOR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281328163696587910759)
,p_event_id=>wwv_flow_api.id(281328163608617910758)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p168_ok := ''S'';',
':p168_item_validacao := null;'))
,p_attribute_03=>'P168_OK,P168_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281328163864885910760)
,p_event_id=>wwv_flow_api.id(281328163608617910758)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p168_ok := ''N'';'
,p_attribute_03=>'P168_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281315913075364037228)
,p_name=>'Alerta Dia Limite'
,p_event_sequence=>1461
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_MATRICULA'
,p_condition_element=>'P168_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P168_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281315913158579037229)
,p_event_id=>wwv_flow_api.id(281315913075364037228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'CURSOR C1 IS',
'SELECT NVL(DIA_LIMITE_BENEFICIOS,1) DIA_LIMITE_BENEFICIOS, nvl(req_benef_mes_seguinte,''S'') req_benef_mes_seguinte',
'  FROM PARAMETROS_RECURSOS_HUMANOS',
' WHERE COD_EMPRESA = :P168_COD_EMPRESA;',
' ',
'V_C1 C1%ROWTYPE;',
'',
'v_data date;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF to_number(to_char(TRUNC(SYSDATE),''DD'')) > V_C1.DIA_LIMITE_BENEFICIOS THEN',
'    IF V_C1.REQ_BENEF_MES_SEGUINTE = ''S'' THEN',
'      V_DATA := TO_DATE(TO_CHAR(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),2),''MON-RRRR'')));',
'    ELSE',
'      V_DATA := TO_DATE(TO_CHAR(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),1),''MON-RRRR'')));',
'    END IF;',
'  ELSE',
'    IF V_C1.REQ_BENEF_MES_SEGUINTE = ''S'' THEN',
'      V_DATA := TO_DATE(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),1),''MON-RRRR''));',
'    ELSE',
'      V_DATA := TO_DATE(''01-''||TO_CHAR(TRUNC(SYSDATE),''MON-RRRR''));',
'    END IF;',
'  END IF;',
'',
'  :P168_DT_VIGENCIA := V_DATA;',
'',
'  IF :p168_cod_empresa IS NOT NULL AND :p168_MATRICULA IS NOT NULL THEN',
'',
unistr('      v_msg_retorno := ''O pedido de benef\00EDcios ser\00E1 validado para o dia ''||V_DATA||'', com recebimento no m\00EAs subsequente.'';'),
'',
'      :P168_ok       := ''S'';',
'      :P168_flag     := ''N'';',
'      :P168_mensagem := v_msg_retorno;',
'',
'  end if;',
' ',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA'
,p_attribute_03=>'P168_OK,P168_FLAG,P168_MENSAGEM,P168_DT_VIGENCIA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324604620015863863)
,p_name=>'Change Matricula'
,p_event_sequence=>1471
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_MATRICULA'
,p_condition_element=>'P168_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324605090421863863)
,p_event_id=>wwv_flow_api.id(281324604620015863863)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p168_rowid is null then',
'',
'pkg_req_beneficio.insere_benef_obrigatorio (:p168_cod_empresa,',
'                                    :p168_matricula,',
'                                    :p168_total,',
'                                    :p168_saldo);',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA,P168_ROWID'
,p_attribute_03=>'P168_TOTAL,P168_SALDO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324605665741863864)
,p_event_id=>wwv_flow_api.id(281324604620015863863)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       i.filial,',
'       i.cod_ccusto,',
'       i.cargo',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p168_cod_empresa',
'   and i.matricula = :p168_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'',
':p168_cod_empresa_DISPLAY := v_c1.empresa;',
':p168_matricula_DISPLAY := v_c1.matricula;',
':p168_situacao_colab := v_c1.situacao;',
':p168_dt_admissao := v_c1.dt_admissao;',
'',
':P168_MENSAGEM := '' '';',
'',
'',
'exception',
'when others then',
':p168_cod_empresa_DISPLAY := :p168_cod_empresa;',
':p168_matricula_DISPLAY := :p168_matricula;',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA'
,p_attribute_03=>'P168_COD_EMPRESA_DISPLAY,P168_MATRICULA_DISPLAY,P168_SITUACAO_COLAB,P168_DT_ADMISSAO,P168_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281324609666505863866)
,p_name=>'Show Region'
,p_event_sequence=>1481
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_MATRICULA'
,p_condition_element=>'P168_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325516697736091481)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325513404095091448)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325456035829023089)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325453205178023061)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324610602294863866)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281346349021292431344)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324611650464863867)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281346349021292431344)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324611132529863866)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281392656537764390654)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324612099137863867)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_TOTAL,P168_SALDO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324612593729863867)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_TOTAL,P168_SALDO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324614091855863868)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'FALSE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281341952875149865244)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324614611806863868)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281346349021292431344)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325517058771091484)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325513404095091448)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324615095953863868)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281392656537764390654)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281324615584406863868)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281341952875149865244)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325455905581023088)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325453205178023061)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281325516660490091480)
,p_event_id=>wwv_flow_api.id(281324609666505863866)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281325513404095091448)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281282196665749054160)
,p_name=>'Deleta temp'
,p_event_sequence=>1491
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281324577100961863846)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281282196779741054161)
,p_event_id=>wwv_flow_api.id(281282196665749054160)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from req_beneficios_itens_temp',
'where cod_empresa = :p168_cod_empresa',
'and matricula = :p168_matricula;',
'',
'commit;',
'',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280612097147147543112)
,p_name=>'Deleta temp_1'
,p_event_sequence=>1501
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(280612097039974543111)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280612097308667543113)
,p_event_id=>wwv_flow_api.id(280612097147147543112)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from req_beneficios_itens_temp',
'where cod_empresa = :p168_cod_empresa',
'and matricula = :p168_matricula;',
'',
'commit;',
'',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P168_COD_EMPRESA,P168_MATRICULA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281255053166819215379)
,p_name=>'Pintar Registro'
,p_event_sequence=>1511
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281346346676323431321)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281255053229103215380)
,p_event_id=>wwv_flow_api.id(281255053166819215379)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''td[headers="TIPO"]'').each(function() {  ',
'  if ( $(this).text() === ''Removido'' ) {  ',
'    $(this).closest(''tr'').find(''td'').css({"color":"red"});  ',
'  }  ',
'  if ( $(this).text() === ''Inserido'' ) {  ',
'    $(this).closest(''tr'').find(''td'').css({"color":"green"});  ',
'  }  ',
'  /*if ( $(this).text() === ''CLERK'' ) {',
'    $(this).closest(''tr'').find(''td'').css({"color":"blue"});',
'  }  */',
'}); '))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281157630661151152613)
,p_name=>'Show / Hide Beneficios'
,p_event_sequence=>1521
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_OPCAO'
,p_condition_element=>'P168_OPCAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281157630748524152614)
,p_event_id=>wwv_flow_api.id(281157630661151152613)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281157630840763152615)
,p_event_id=>wwv_flow_api.id(281157630661151152613)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281157630936992152616)
,p_event_id=>wwv_flow_api.id(281157630661151152613)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_BENEFICIO,P168_TIPO_BENEFICIO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281157631134763152618)
,p_name=>unistr('Show / Hide Tipo Benef\00EDcios')
,p_event_sequence=>1531
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_BENEFICIO'
,p_condition_element=>'P168_BENEFICIO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281157631247792152619)
,p_event_id=>wwv_flow_api.id(281157631134763152618)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_TIPO_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158025923213844970)
,p_event_id=>wwv_flow_api.id(281157631134763152618)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_TIPO_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281066035020945683368)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>1541
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P168_COD_SIT_REQ'
,p_condition_element=>'P168_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P168_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281066035112890683369)
,p_event_id=>wwv_flow_api.id(281066035020945683368)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281324576467509863845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281066035411868683372)
,p_event_id=>wwv_flow_api.id(281066035020945683368)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281324576070381863845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281066035221348683370)
,p_event_id=>wwv_flow_api.id(281066035020945683368)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281324576070381863845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281066035390734683371)
,p_event_id=>wwv_flow_api.id(281066035020945683368)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281324576467509863845)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280871935422895162368)
,p_name=>'Perfil = REMUNERACAOX'
,p_event_sequence=>1551
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P_PERFIL'
,p_display_when_cond2=>'REMUNERACAOX'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280871935480515162369)
,p_event_id=>wwv_flow_api.id(280871935422895162368)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//$x(''P168_DT_VIGENCIA'').disabled = false;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270247033733371744054)
,p_event_id=>wwv_flow_api.id(280871935422895162368)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_DT_VIGENCIA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280871935567249162370)
,p_name=>'Perfil <> REMUNERACAOX'
,p_event_sequence=>1561
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P_PERFIL'
,p_display_when_cond2=>'REMUNERACAOX'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280871935711483162371)
,p_event_id=>wwv_flow_api.id(280871935567249162370)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//$x(''P168_DT_VIGENCIA'').disabled = true;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270247033804097744055)
,p_event_id=>wwv_flow_api.id(280871935567249162370)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P168_DT_VIGENCIA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940536452863165772)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1571
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940536396014165771)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940709013465498023)
,p_event_id=>wwv_flow_api.id(269940536452863165772)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940709057888498024)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1581
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940536234126165770)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940709195804498025)
,p_event_id=>wwv_flow_api.id(269940709057888498024)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940711829444498052)
,p_name=>unistr('(Situa\00E7\00E3o) Show Aprovar')
,p_event_sequence=>1591
,p_condition_element=>'P168_COD_SIT_REQ'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940711989872498053)
,p_event_id=>wwv_flow_api.id(269940711829444498052)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(269940536396014165771)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940712089350498054)
,p_event_id=>wwv_flow_api.id(269940711829444498052)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(269940536234126165770)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940712195992498055)
,p_event_id=>wwv_flow_api.id(269940711829444498052)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(269940536396014165771)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940712266366498056)
,p_event_id=>wwv_flow_api.id(269940711829444498052)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(269940536234126165770)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324592219085863857)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from REQ_BENEFICIOS'
,p_attribute_02=>'REQ_BENEFICIOS'
,p_attribute_03=>'P168_COD_REQ'
,p_attribute_04=>'COD_REQ'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324589822985863855)
,p_process_sequence=>40
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
'  where cod_empresa = :p168_COD_EMP_REQ',
'    and matricula   = :p168_MAT_REQ;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p168_solicitante := v_c1.colaborador;',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324590219956863856)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'cursor c1 is',
' select Initcap(desc_sit_REQ) sit',
'   from SIT_REQ',
'  where cod_sit_req = :p168_cod_sit_REQ;',
'  ',
'  v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p168_rowid is not null then',
unistr('   :p168_titulo := ''Requisi\00E7\00E3o de Benef\00EDcios: N\00BA ''||:p168_cod_req||'' - ''||:p168_dt_req||'' (''||v_c1.sit||'')'';'),
'else',
unistr('   :p168_titulo := ''Requisi\00E7\00E3o de Benef\00EDcios'';'),
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(280877755450423483569)
,p_process_sequence=>60
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Popula Dt_Vig\00EAncia')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select min(i.dt_vigencia_ini) data',
'  from req_beneficios_itens i',
' where i.cod_req = :p168_cod_req',
'and i.operacao = ''I'';',
'   ',
'v_c1 c1%rowtype;',
'',
'CURSOR C2 IS',
'SELECT NVL(DIA_LIMITE_BENEFICIOS,1) DIA_LIMITE_BENEFICIOS, nvl(req_benef_mes_seguinte,''S'') req_benef_mes_seguinte',
'  FROM PARAMETROS_RECURSOS_HUMANOS',
' WHERE COD_EMPRESA = :P168_COD_EMPRESA;',
' ',
'V_C2 C2%ROWTYPE;',
'',
'v_data date;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.data is not null then',
':p168_dt_vigencia := v_c1.data;',
'else',
'',
'OPEN C2;',
'FETCH C2 INTO V_C2;',
'CLOSE C2;',
'',
'  IF to_number(to_char(TRUNC(SYSDATE),''DD'')) > V_C2.DIA_LIMITE_BENEFICIOS THEN',
'    IF V_C2.REQ_BENEF_MES_SEGUINTE = ''S'' THEN',
'      V_DATA := TO_DATE(TO_CHAR(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),2),''MON-RRRR'')));',
'    ELSE',
'      V_DATA := TO_DATE(TO_CHAR(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),1),''MON-RRRR'')));',
'    END IF;',
'  ELSE',
'    IF V_C2.REQ_BENEF_MES_SEGUINTE = ''S'' THEN',
'      V_DATA := TO_DATE(''01-''||TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),1),''MON-RRRR''));',
'    ELSE',
'      V_DATA := TO_DATE(''01-''||TO_CHAR(TRUNC(SYSDATE),''MON-RRRR''));',
'    END IF;',
'  END IF;',
'',
':P168_DT_VIGENCIA := V_DATA;',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P168_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324591077078863856)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'',
'cursor c1 is',
'select i.filial',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :P_EMPRESA_USER',
'   and i.matricula = :P_MATRICULA_USER;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p168_fil_req := v_c1.filial;',
'',
'/*',
'if :p168_cod_filial is null then',
':p168_cod_filial := v_c1.filial;',
':p168_cod_ccusto := v_c1.cod_ccusto;',
':p168_cod_cargo  := v_c1.cargo;',
'end if;',
'*/',
'    BEGIN',
'  	SELECT seq_requisicao.NEXTVAL INTO v_seq FROM dual;',
'    END;',
'        ',
'    :p168_cod_req := v_seq;',
'',
'    :p168_cod_SIT_req := 1;',
'',
'  :p168_usuario         := :p_usuario;',
'  :p168_dt_atualizacao  := sysdate;',
'',
'    :p168_cod_emp_req := :P_EMPRESA_USER;',
'    :p168_mat_req     := :P_MATRICULA_USER;',
'    ',
'      :p168_dt_REQ  := sysdate;',
'       :p168_dt_SIT_REQ  := sysdate;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281324577910597863846)
,p_process_when=>'P168_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324591383988863856)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  :p168_usuario := :p_usuario;',
'  :p168_dt_atualizacao := sysdate;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281324577529179863846)
,p_process_when=>'P168_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324592661404863857)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQ_BENEFICIOS'
,p_attribute_02=>'REQ_BENEFICIOS'
,p_attribute_03=>'P168_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324590619058863856)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_item_validacao varchar2(100) := :P168_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p168_flag     := null;',
' :p168_mensagem := null;',
'',
' pkg_req_beneficio.post_insert(:p168_cod_empresa, :P168_MATRICULA, :p168_cod_req, null, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P168_ITEM_VALIDACAO := TRIM(UPPER(''POST_INSERT''));',
'    :P168_ok       := ''N'';',
'    :P168_flag     := v_flg_retorno;',
'    :P168_mensagem := v_msg_retorno;',
' else',
'    :P168_flag     := null;',
'    :P168_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''POST_INSERT'')) OR v_item_validacao IS NULL then',
'       :P168_OK := ''S'';',
'       :P168_ITEM_VALIDACAO := null;',
'    else',
'       :P168_ITEM_VALIDACAO := v_item_validacao;',
'       :P168_OK := ''N'';',
'    end if;',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281324577910597863846)
,p_process_when=>'P168_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(280877755586560483571)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_data date := :p168_dt_vigencia;',
'',
'begin',
'',
'update req_beneficios_itens i',
'   set dt_vigencia_ini = v_data',
' where i.operacao = ''I''',
'   and i.cod_req = :p168_cod_req',
'   and dt_vigencia_ini <> v_data;',
'   ',
'   commit;',
'   ',
'    update REQ_BENEFICIOS_ITENS',
'      set dt_vigencia_fim = v_data -1',
'    where operacao = ''D''',
'      and cod_req = :p168_cod_req',
'      and (dt_vigencia_fim <> v_data -1',
'            or dt_vigencia_fim is null); -- Ajustado em 18/06/2021 Cibele',
'      ',
'    commit;',
'   ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281324577529179863846)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(272379462118032004525)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Apagar Req_Beneficios_Itens_Temp'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete ',
'  from Req_Beneficios_Itens_Temp ',
' where cod_empresa = :p168_cod_empresa',
'   and matricula = :p168_matricula;',
'   ',
'commit;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324589464548863855)
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
'end;',
'',
':P168_TOTAL := NULL;',
':P168_SALDO := NULL;',
'',
':p168_ok_valor := ''S'';',
'',
'if :p168_OK is null then',
':p168_OK := ''S'';',
':p168_ok_valor := ''S'';',
':p168_mensagem := null;',
':p168_flag := null;',
'end if;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281324591844230863857)
,p_process_sequence=>50
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
'       i.filial,',
'       i.cod_ccusto,',
'       i.cargo',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p168_cod_empresa',
'   and i.matricula = :p168_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'',
':p168_cod_empresa_DISPLAY := v_c1.empresa;',
':p168_matricula_DISPLAY := v_c1.matricula;',
':p168_situacao_colab := v_c1.situacao;',
':p168_dt_admissao := v_c1.dt_admissao;',
'',
':P168_MENSAGEM := '' '';',
'',
'',
'exception',
'when others then',
':p168_cod_empresa_DISPLAY := :p168_cod_empresa;',
':p168_matricula_DISPLAY := :p168_matricula;',
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
