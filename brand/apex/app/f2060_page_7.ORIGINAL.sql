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
--   Date and Time:   16:24 Wednesday September 30, 2026
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
,p_user_interface_id=>wwv_flow_api.id(19041533386153604874)
,p_name=>unistr('Lan\00E7amentos Diversos')
,p_step_title=>unistr('Lan\00E7amentos Diversos')
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.apex-item-multi{',
'max-width: 100% !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20260930162307'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1914133984654303348)
,p_plug_name=>'Anexos'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2109527642241109719)
,p_plug_name=>unistr('Lan\00E7amentos')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P7_PESQUISA'
,p_plug_display_when_cond2=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1135245059910641881)
,p_plug_name=>'Metragem'
,p_parent_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P7_USA_METRAGEM'
,p_plug_display_when_cond2=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1139940477802901338)
,p_plug_name=>'Valores'
,p_parent_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1139940597492901339)
,p_plug_name=>'Datas'
,p_parent_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1139943571007901369)
,p_plug_name=>unistr('Observa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1139943946984901373)
,p_plug_name=>'Eventos e Motivos'
,p_parent_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2115600818757174435)
,p_plug_name=>'Matriculas Elegiveis'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P7_PESQUISA'
,p_plug_display_when_cond2=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2113861210023616049)
,p_plug_name=>'Resultado'
,p_region_name=>'RESULTADO'
,p_parent_plug_id=>wwv_flow_api.id(2115600818757174435)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19041506869274604778)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  DECODE(:P7_COD_REQ, NULL, APEX_ITEM.CHECKBOX(1,MATRICULA, ''CHECKED''), ''-'') "Selecionar"',
'    , ROWID "UPLOAD"',
'    , ROWID "DOWNLOAD"',
'    , COD_EMPRESA||'' - ''||(SELECT NOME FROM EMPRESAS WHERE COD_EMPRESA = T.COD_EMPRESA) "Empresa"',
'    , MATRICULA||'' - ''||(SELECT NOME FROM INF_PESSOAIS ',
'                         WHERE  COD_EMPRESA = T.COD_EMPRESA AND MATRICULA = T.MATRICULA) "Colaborador"',
'    , COD_EVENTO||'' - ''||(SELECT NOME FROM OCORR_PAGTO                       ',
'                          WHERE  COD_EMPRESA = T.COD_EMPRESA AND COD = T.COD_EVENTO) "Evento"',
'    , COD_EVENTO||'' - ''||(SELECT descricao FROM motivo_alteracoes                       ',
'                          WHERE  COD = T.COD_MOTIVO) "Motivo"                    ',
'    , COD_EMPRESA',
'    , MATRICULA',
'    , COD_EVENTO',
'    , COD_MOTIVO',
'    , QTD_HORAS',
'    , QTD_MINUTOS',
'    , QTD_DIAS',
'    , VALOR',
'    , DATA_VIGENCIA',
'    , DATA_VIGENCIA_EFETIVACAO',
'    , DATA_VALIDADE_INICIAL',
'    , DATA_VALIDADE_FINAL',
'    , DIA_LIMITE_LANCTO',
'    , QTD_PARCELAS',
'    , METRAGEM',
'    , VALOR_METRAGEM',
'    , FILIAL||'' - ''||(SELECT NOME_FILIAL FROM FILIAIS WHERE COD_FILIAL = T.FILIAL AND COD_EMPRESA = T.COD_EMPRESA) FILIAL',
'FROM REQ_REEMBOLSO_MATRICULAS_TMP T',
'WHERE SEQ_ID = :P7_SEQ_ID'))
,p_plug_source_type=>'NATIVE_IR'
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
 p_id=>wwv_flow_api.id(2115598880446174416)
,p_max_row_count=>'1000000'
,p_max_rows_per_page=>'20'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'ANDRE.BONI'
,p_internal_uid=>976168058033235311
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599019799174417)
,p_db_column_name=>'Empresa'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599117723174418)
,p_db_column_name=>'Colaborador'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599173236174419)
,p_db_column_name=>'Evento'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Evento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599244207174420)
,p_db_column_name=>'Motivo'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Motivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599381495174421)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599518579174422)
,p_db_column_name=>'MATRICULA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599580223174423)
,p_db_column_name=>'COD_EVENTO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cod Evento'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599706226174424)
,p_db_column_name=>'COD_MOTIVO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Cod Motivo'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599723267174425)
,p_db_column_name=>'QTD_HORAS'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Qtd Horas'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599845245174426)
,p_db_column_name=>'QTD_MINUTOS'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Qtd Minutos'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115599946513174427)
,p_db_column_name=>'QTD_DIAS'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Qtd Dias'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600065279174428)
,p_db_column_name=>'VALOR'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600200030174429)
,p_db_column_name=>'DATA_VIGENCIA'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Data Vigencia'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600227761174430)
,p_db_column_name=>'DATA_VIGENCIA_EFETIVACAO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Data Vigencia Efetivacao'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600406614174431)
,p_db_column_name=>'DATA_VALIDADE_INICIAL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Data Validade Inicial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600513287174432)
,p_db_column_name=>'DATA_VALIDADE_FINAL'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Data Validade Final'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600615005174433)
,p_db_column_name=>'DIA_LIMITE_LANCTO'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Dia Limite Lancto'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600716246174434)
,p_db_column_name=>'QTD_PARCELAS'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Qtd Parcelas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115600991565174437)
,p_db_column_name=>'Selecionar'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Selecionar'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115602397399174451)
,p_db_column_name=>'UPLOAD'
,p_display_order=>200
,p_column_identifier=>'V'
,p_column_label=>'Upload'
,p_column_link=>'f?p=&APP_ID.:8:&SESSION.::&DEBUG.:RP,8:P8_ROWID:#UPLOAD#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-cloud-upload"></span>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'OTHER'
,p_column_alignment=>'CENTER'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115602469985174452)
,p_db_column_name=>'DOWNLOAD'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>'Download'
,p_column_link=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP::'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-cloud-download"></span>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'OTHER'
,p_column_alignment=>'CENTER'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2115936751150856953)
,p_db_column_name=>'FILIAL'
,p_display_order=>220
,p_column_identifier=>'Y'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(1139941032058901344)
,p_db_column_name=>'METRAGEM'
,p_display_order=>230
,p_column_identifier=>'Z'
,p_column_label=>'Metragem'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(1139941136386901345)
,p_db_column_name=>'VALOR_METRAGEM'
,p_display_order=>240
,p_column_identifier=>'AA'
,p_column_label=>'Valor Metragem'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(2115651676781283303)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9762209'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_display_rows=>20
,p_report_columns=>'Selecionar:UPLOAD:DOWNLOAD:Empresa:Colaborador:Evento:Motivo:QTD_HORAS:QTD_MINUTOS:QTD_DIAS:VALOR:DATA_VIGENCIA:DATA_VIGENCIA_EFETIVACAO:DATA_VALIDADE_INICIAL:DATA_VALIDADE_FINAL:DIA_LIMITE_LANCTO:QTD_PARCELAS:||(SELECTNOME_FILIALFROMFILIAISWHERECOD_'
||'FILIAL=T.FILIAL):FILIAL:METRAGEM:VALOR_METRAGEM'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2115936527193856951)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P7_COD_REQ'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6173755951141278930)
,p_plug_name=>'Parametros'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(41434619067480116546)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding'
,p_plug_template=>wwv_flow_api.id(19041499394993604767)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(59714987934838595287)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(19041507389315604780)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.cod_mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.cod_mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.cod_mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_REEMBOLSO a, usuario_oracle u',
' where a.cod_req = :P7_COD_REQ --:p714_cod_req ',
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
' where a.cod_req = :P7_COD_REQ --:p714_cod_req ',
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
' where cod_req = :p7_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
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
 p_id=>wwv_flow_api.id(1518710773343836819)
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
 p_id=>wwv_flow_api.id(1518711199800836820)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(1518711622358836820)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(1518711989620836820)
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
 p_id=>wwv_flow_api.id(1518712401963836820)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(1518712818037836820)
,p_query_column_id=>6
,p_column_alias=>'COD_MAT_APROV'
,p_column_display_sequence=>8
,p_column_heading=>'Cod Mat Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(1518713197025836820)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>6
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(1518713538614836820)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>7
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2114405314688866918)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2113861210023616049)
,p_button_name=>'ANEXOS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--padTop'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anexos'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-cloud-upload'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2114406576322866931)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_button_name=>'CRIAR_REQUISICAO'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar Requisicao'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1 FROM DUAL',
'WHERE :P7_COD_REQ IS NULL ',
'AND :P7_PROCESSAR = ''S'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2115932973467856915)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_button_name=>'SALVAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2115934085969856926)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'FROM DUAL',
'WHERE :P7_COD_REQ IS NOT NULL',
'AND :P7_REQ_SIT NOT IN (2,3)'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-trash-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1517035898336887636)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_button_name=>'VOLTAR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(19041528180913604824)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP,2::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1518713984744836821)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(59714987934838595287)
,p_button_name=>'p7_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P7_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :P7_PAINEL = ''PC'' then',
'    return false;',
'end if;',
'/*',
'PKG_REQ_REEMBOLSO.Valida_Sequencia(:p7_cod_empresa, :p7_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
'*/ ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2113859884956616036)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_button_name=>'PROCESSAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Confirmar Matriculas'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-gears'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1518714387002836821)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(59714987934838595287)
,p_button_name=>'p7_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P7_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'if :P7_PAINEL = ''PC'' then',
'    return false;',
'end if;',
'/*',
'PKG_REQ_REEMBOLSO.Valida_Sequencia(:p7_cod_empresa, :p7_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
'*/ ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2109527289689109715)
,p_button_sequence=>540
,p_button_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_button_name=>'PESQUISAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P7_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2158794892396002108)
,p_button_sequence=>550
,p_button_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_button_name=>'BACK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--hoverIconPush'
,p_button_template_id=>wwv_flow_api.id(19041528064842604821)
,p_button_image_alt=>'Back'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP,2::'
,p_icon_css_classes=>'fa-undo-arrow'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(2052224722802041211)
,p_branch_name=>'GoTo 2'
,p_branch_action=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP,2::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'VOLTAR,CRIAR_REQUISICAO,SALVAR,CANCELAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1135245156129641882)
,p_name=>'P7_METRAGEM'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(1135245059910641881)
,p_prompt=>'Metragem'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1135245317228641884)
,p_name=>'P7_USA_METRAGEM'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139940829261901342)
,p_name=>'P7_METRAGEM_MINIMA'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139940939104901343)
,p_name=>'P7_METRAGEM_MAXIMA'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1139944048640901374)
,p_name=>'P7_VALOR_METRAGEM'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(1135245059910641881)
,p_prompt=>'Valor Metragem (R$)'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1516281114854609918)
,p_name=>'P7_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa||'' - ''||nome, cod_empresa',
'from empresas',
'order by cod_empresa'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527999745604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1516281194527609919)
,p_name=>'P7_COD_PROCESSO'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Processo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||desc_processo, cod ',
'from REEMBOLSO_PROCESSOS',
'order by cod '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527999745604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517019811285887630)
,p_name=>'P7_ERR_MSG'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517023815702887631)
,p_name=>'P7_FILIAIS'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Filiais'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_filiais( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517024550601887631)
,p_name=>'P7_CARGOS'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Cargos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_cargos( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE',
'                                          , p_class_cargo => :P7_CLASSIFICACAO_CARGO) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE,P7_CLASSIFICACAO_CARGO'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE,P7_CLASSIFICACAO_CARGO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517026569508887632)
,p_name=>'P7_SINDICATOS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Sindicatos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_sindicatos( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA, P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517037034624887637)
,p_name=>'P7_DEMITIDOS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Processar Demitidos?;S'
,p_tag_css_classes=>'u-bold'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1517037446574887637)
,p_name=>'P7_TRANSFERIDOS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(41434619067480116546)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Processar Transferidos?;S'
,p_tag_css_classes=>'u-bold'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1518709538728835345)
,p_name=>'P7_ARQ_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(1914133984654303348)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Arquivo 1'
,p_source=>'ARQ_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_display_when=>'P7_PESQUISA'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(1518710004501835345)
,p_name=>'P7_ARQ_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(1914133984654303348)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Arquivo 2'
,p_source=>'ARQ_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_display_when=>'P7_PESQUISA'
,p_display_when_type=>'ITEM_IS_NULL'
,p_read_only_when=>'P7_ROWID'
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
 p_id=>wwv_flow_api.id(1518750819183679008)
,p_name=>'P7_PESQUISA'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1518751532349679016)
,p_name=>'P7_ARQ1_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(1914133984654303348)
,p_prompt=>'Arquivo 1'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P7_PESQUISA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1518751642905679017)
,p_name=>'P7_ARQ2_DSP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(1914133984654303348)
,p_prompt=>'Arquivo 2'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P7_PESQUISA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2052225084204041214)
,p_name=>'P7_COD_ELEGIBILIDADE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068447240471161954)
,p_name=>'P7_CLASSIFICACAO_CENTRO_CUSTO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>unistr('Classifica\00E7\00E3o Centro de Custo')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_class_ccusto( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2068447375729161955)
,p_name=>'P7_CENTRO_CUSTO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>unistr('Centro Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_ccusto( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE',
'                                          , p_class_cargo => :P7_CLASSIFICACAO_CENTRO_CUSTO) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_CLASSIFICACAO_CENTRO_CUSTO'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_CLASSIFICACAO_CENTRO_CUSTO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526386291109706)
,p_name=>'P7_UNIDADE_ADMINISTRATIVA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Unidade Administrativa (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_filiais( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526451794109707)
,p_name=>'P7_ATIVIDADE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Atividade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_atividades( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526532031109708)
,p_name=>'P7_CLASSIFICACAO_CARGO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>unistr('Classifica\00E7\00E3o Cargos')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_class_cargos( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE) order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526787650109710)
,p_name=>'P7_SITUACAO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Ativos;A,Demitidos;D,Todos;T'
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526825201109711)
,p_name=>'P7_EMP'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109526971863109712)
,p_name=>'P7_MAT'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109527117502109713)
,p_name=>'P7_PAINEL'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109527537928109718)
,p_name=>'P7_PERFIL'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_prompt=>'Perfil'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ds_perfil d, cd_perfil r',
'from perfil_acesso',
'order by ds_perfil'))
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527999745604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109528598355109728)
,p_name=>'P7_EVENTOS'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(1139943946984901373)
,p_prompt=>'Eventos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_eventos( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE)'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527999745604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109528653691109729)
,p_name=>'P7_MOTIVOS'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(1139943946984901373)
,p_prompt=>'Motivos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * FROM PKG_LIST_REEMBOLSO.fnc_list_motivos( p_cod_empresa       => :P7_COD_EMPRESA',
'                                          , p_cod_elegibilidade => :P7_COD_ELEGIBILIDADE',
'                                          , p_cod_evento => :P7_EVENTOS)'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE,P7_EVENTOS'
,p_ajax_items_to_submit=>'P7_COD_EMPRESA,P7_COD_ELEGIBILIDADE,P7_EVENTOS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527999745604818)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109528818377109730)
,p_name=>'P7_QTD_HORAS'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(1139940477802901338)
,p_prompt=>'Qtd.Horas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109528898286109731)
,p_name=>'P7_QTD_DIAS'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(1139940477802901338)
,p_prompt=>'Qtd Dias'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109528996057109732)
,p_name=>'P7_VALOR'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(1139940477802901338)
,p_prompt=>'Valor (R$)'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529025702109733)
,p_name=>'P7_DATA_VIGENCIA'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Data Vigencia'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529199926109734)
,p_name=>'P7_DIA_LIMITE_LANCTO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Dia Limite Lancto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529305567109735)
,p_name=>'P7_DATA_VIGENCIA_EFETIVACAO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Data Vigencia Efetivacao'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529322971109736)
,p_name=>'P7_DATA_VALIDADE_INICIAL'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Data Validade Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529450048109737)
,p_name=>'P7_DATA_VALIDADE_FINAL'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Data Validade Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529616822109738)
,p_name=>'P7_QTD_PARCELAS'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(1139940597492901339)
,p_prompt=>'Qtd Parcelas'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2109529694909109739)
,p_name=>'P7_OBSERVACOES'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(1139943571007901369)
,p_prompt=>'Observacoes'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>165
,p_cMaxlength=>2000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2113857383827616011)
,p_name=>'P7_POR_VALOR'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2113858527494616023)
,p_name=>'P7_POR_UNIDADES'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2113858667073616024)
,p_name=>'P7_POR_DIA'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2113860932274616047)
,p_name=>'P7_PROCESSAR'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2114405010835866915)
,p_name=>'P7_TEM_ANEXO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(6173755951141278930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2114407970090866945)
,p_name=>'P7_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P7_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2114408238892866948)
,p_name=>'P7_SEQ_ID'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115193243153245014)
,p_name=>'P7_QTD_MINUTOS'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(1139940477802901338)
,p_prompt=>'Qtd.Minutos'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115933125235856917)
,p_name=>'P7_REQ_SIT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115933288999856918)
,p_name=>'P7_REQ_DATA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115933323591856919)
,p_name=>'P7_REQ_DATA_SIT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115933554480856921)
,p_name=>'P7_REQ_SIT_DSP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2115936499883856950)
,p_name=>'P7_EFETIVACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2115936527193856951)
,p_prompt=>'Efetivacao'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(19041527838037604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2121764597225909324)
,p_name=>'P7_CONTA_ELEG'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2121764872756909327)
,p_name=>'P7_VALOR_MIN'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(2121764971454909328)
,p_name=>'P7_VALOR_MAX'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(2109527642241109719)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113859989507616037)
,p_validation_name=>'Valida empresa nula'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_COD_EMPRESA is null then',
'    return ''Informe a empresa'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(2109527289689109715)
,p_associated_item=>wwv_flow_api.id(1516281114854609918)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860068134616038)
,p_validation_name=>'Valida processo nulo'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_COD_PROCESSO is null then',
'    return ''Informe o processo de reembolso'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(2109527289689109715)
,p_associated_item=>wwv_flow_api.id(1516281194527609919)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860253929616040)
,p_validation_name=>'Valida evento nulo'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_EVENTOS is null then',
'    return ''Selecione um evento'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2109528598355109728)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860350971616041)
,p_validation_name=>'Valida motivo nulo'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_MOTIVOS is null then',
'    return ''Selecione um motivo'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2109528653691109729)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860452949616042)
,p_validation_name=>'Valida horas nulas'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_POR_UNIDADES is not null then',
'    if :P7_QTD_HORAS is null then',
'        return ''Informe as horas'';',
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2109528818377109730)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2115193389470245015)
,p_validation_name=>'Valida minutos nulos'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_POR_UNIDADES is not null then',
'    if :P7_QTD_MINUTOS is null then',
'        return ''Informe os minutos'';',
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2115193243153245014)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860537004616043)
,p_validation_name=>'Valida Qtd DIas nulo'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_POR_DIA is not null then',
'    if :P7_QTD_DIAS is null then',
'        return ''Informe as quantidade de dias'';',
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2109528898286109731)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(2113860904786616046)
,p_validation_name=>'Valida valor nulo'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P7_POR_VALOR is not null then',
'    if :P7_VALOR is null then',
'        return ''Informe o valor'';',
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(2114406576322866931)
,p_associated_item=>wwv_flow_api.id(2109528996057109732)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1517056216273887643)
,p_name=>'Inicia Alertify'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1517056705739887644)
,p_event_id=>wwv_flow_api.id(1517056216273887643)
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
 p_id=>wwv_flow_api.id(2109528348732109726)
,p_name=>'Dispara Alerta'
,p_event_sequence=>300
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_ERR_MSG'
,p_condition_element=>'P7_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2109528463165109727)
,p_event_id=>wwv_flow_api.id(2109528348732109726)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    if ($x(''P7_ERR_MSG'').value.length  > 0 ) {',
'        ',
'       // if ($x(''P55_FLAG'').value == "N") {',
'      //      $(''#P55_CREATE'').hide();',
'       // } else {',
'      //      $(''#P55_CREATE'').show();',
'       // }',
'            ',
'        alertify.alert($v(''P7_ERR_MSG''));',
'    }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2109529801558109740)
,p_name=>'Selecione Elegibilidade'
,p_event_sequence=>310
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_COD_PROCESSO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2114404921596866914)
,p_event_id=>wwv_flow_api.id(2109529801558109740)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select tem_anexo',
'      into :P7_TEM_ANEXO',
'    from REEMBOLSO_PROCESSOS',
'      where cod = :P7_COD_PROCESSO;',
' ',
'exception',
'    when others then ',
'    :P7_TEM_ANEXO := ''N'';  ',
'end;',
'begin',
'    select USA_METRAGEM        --, TO_CHAR(NVL(VALOR_METRO, 0) , ''L999G999G999D00'') AS "VALOR_METRO"',
'      into :P7_USA_METRAGEM    --, :P7_VALOR_METRAGEM',
'    from REEMBOLSO_PERFIS_PROCESSOS',
'      where cod_processo = :P7_COD_PROCESSO',
'      and cod_empresa = :P7_COD_EMPRESA',
'      and cod_perfil = :P_PERFIL;',
'exception',
'    when others then ',
'    :P7_USA_METRAGEM := ''N'';  ',
'end;',
'begin',
'    select  TO_CHAR(NVL(VALOR_METRO, 0) , ''L999G999G999D00'') AS "VALOR_METRO"',
'      into :P7_VALOR_METRAGEM',
'    from REEMBOLSO_PERFIS_EVENTOS',
'      where cod_processo = :P7_COD_PROCESSO',
'      and cod_empresa = :P7_COD_EMPRESA;',
'exception',
'    when others then ',
'    :P7_VALOR_METRAGEM := 0;  ',
'end;',
''))
,p_attribute_02=>'P7_COD_PROCESSO,P7_COD_EMPRESA'
,p_attribute_03=>'P7_TEM_ANEXO,P7_USA_METRAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2109529892069109741)
,p_event_id=>wwv_flow_api.id(2109529801558109740)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_ERR_MSG := null;',
'    :P7_COD_ELEGIBILIDADE := PKG_REQ_REEMBOLSO.valida_processo_perfil(p_cod_empresa   => :P7_COD_EMPRESA',
'                                                                    , p_cod_processo  => :P7_COD_PROCESSO',
'                                                                    , p_perfil        => :P_PERFIL ); ',
'    if :P7_COD_ELEGIBILIDADE is null then',
unistr('        :P7_ERR_MSG := ''N\00E3o existe elegibilidade para Empresa = ''||:P7_COD_EMPRESA||'),
'                        '', Processo = ''||:P7_COD_PROCESSO||',
'                        '' e Perfil = ''||:P_PERFIL;',
'    end if;',
'end;'))
,p_attribute_02=>'P7_COD_EMPRESA,P7_COD_PROCESSO'
,p_attribute_03=>'P7_COD_ELEGIBILIDADE,P7_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113858043662616018)
,p_event_id=>wwv_flow_api.id(2109529801558109740)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    PKG_LIST_REEMBOLSO.recupera_datas(p_cod_empresa => :P7_COD_EMPRESA,',
'                                        p_cod_processo => :P7_COD_PROCESSO,',
'                                        p_data_validade_ini => :P7_DATA_VALIDADE_INICIAL,',
'                                        p_data_validade_fim => :P7_DATA_VALIDADE_FINAL,',
'                                        p_data_ref => :P7_DATA_VIGENCIA,',
'                                        p_data_efetivacao => :P7_DATA_VIGENCIA_EFETIVACAO,',
'                                        p_dia_limite => :P7_DIA_LIMITE_LANCTO,',
'                                        p_parcelas => :P7_QTD_PARCELAS);',
'end;',
''))
,p_attribute_02=>'P7_COD_EMPRESA,P7_COD_PROCESSO,P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL'
,p_attribute_03=>'P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL,P7_DATA_VIGENCIA,P7_DATA_VIGENCIA_EFETIVACAO,P7_DIA_LIMITE_LANCTO,P7_QTD_PARCELAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2109530005772109742)
,p_event_id=>wwv_flow_api.id(2109529801558109740)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_FILIAIS,P7_UNIDADE_ADMINISTRATIVA,P7_SINDICATOS,P7_CLASSIFICACAO_CENTRO_CUSTO,P7_ATIVIDADE,P7_CLASSIFICACAO_CARGO,P7_CARGOS,P7_CENTRO_CUSTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2113857203729616009)
,p_name=>'Mostra / Oculta campos Evento'
,p_event_sequence=>320
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_EVENTOS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113857293569616010)
,p_event_id=>wwv_flow_api.id(2113857203729616009)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'null;'
,p_attribute_02=>'P7_COD_EMPRESA,P7_EVENTOS'
,p_attribute_03=>'P7_POR_VALOR,P7_POR_UNIDADES,P7_POR_DIA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2121765062209909329)
,p_event_id=>wwv_flow_api.id(2113857203729616009)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select DISTINCT  valor_minimo, valor_maximo, METROS_MINIMOS, METROS_MAXIMOS',
'        into :P7_VALOR_MIN, :P7_VALOR_MAX, :P7_METRAGEM_MINIMA, :P7_METRAGEM_MAXIMA',
'        from reembolso_perfis_eventos',
'        where cod = :P7_COD_ELEGIBILIDADE',
'        and cod_evento = :P7_EVENTOS;',
'exception',
'    when others then',
'        :P7_VALOR_MIN := 0;',
'        :P7_VALOR_MAX := 0;',
'end;'))
,p_attribute_02=>'P7_EVENTOS,P7_COD_ELEGIBILIDADE'
,p_attribute_03=>'P7_VALOR_MIN,P7_VALOR_MAX, P7_METRAGEM_MINIMA, P7_METRAGEM_MAXIMA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2113858177402616019)
,p_name=>'Calcula parcelas x data validade'
,p_event_sequence=>340
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113858282949616020)
,p_event_id=>wwv_flow_api.id(2113858177402616019)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  PKG_LIST_REEMBOLSO.recupera_datas( p_data_validade_ini => :P7_DATA_VALIDADE_INICIAL',
'                          , p_data_validade_fim => :P7_DATA_VALIDADE_FINAL',
'                          , p_parcelas          => :P7_QTD_PARCELAS);'))
,p_attribute_02=>'P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL'
,p_attribute_03=>'P7_QTD_PARCELAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2113858733635616025)
,p_name=>'Mostra para valor'
,p_event_sequence=>350
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_POR_VALOR'
,p_condition_element=>'P7_POR_VALOR'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113858827897616026)
,p_event_id=>wwv_flow_api.id(2113858733635616025)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_VALOR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113858981931616027)
,p_event_id=>wwv_flow_api.id(2113858733635616025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_QTD_HORAS,P7_QTD_DIAS,P7_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2113859023982616028)
,p_name=>'Mostra para hora e min'
,p_event_sequence=>360
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_POR_UNIDADES'
,p_condition_element=>'P7_POR_UNIDADES'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113859140009616029)
,p_event_id=>wwv_flow_api.id(2113859023982616028)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_QTD_HORAS,P7_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113859275476616030)
,p_event_id=>wwv_flow_api.id(2113859023982616028)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_QTD_DIAS,P7_VALOR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2113859403237616031)
,p_name=>'Mostra para qtd dias'
,p_event_sequence=>370
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_POR_DIA'
,p_condition_element=>'P7_POR_DIA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113859506975616032)
,p_event_id=>wwv_flow_api.id(2113859403237616031)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_QTD_DIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2113859595469616033)
,p_event_id=>wwv_flow_api.id(2113859403237616031)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P7_QTD_HORAS,P7_VALOR,P7_QTD_MINUTOS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2114404246844866908)
,p_name=>'Oculta anexo'
,p_event_sequence=>390
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2114404358514866909)
,p_event_id=>wwv_flow_api.id(2114404246844866908)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1914133984654303348)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2121765168333909330)
,p_name=>'Valida valor'
,p_event_sequence=>400
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_VALOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2121765254508909331)
,p_event_id=>wwv_flow_api.id(2121765168333909330)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_ERR_MSG := null;',
'    if (:P7_VALOR_MIN is not null and :P7_VALOR_MAX is not null)',
'        or (:P7_VALOR_MIN != 0 and :P7_VALOR_MAX != 0) then',
'        if to_number(:P7_VALOR) < to_number(:P7_VALOR_MIN) or  to_number(:P7_VALOR) > to_number(:P7_VALOR_MAX) then',
unistr('            :P7_ERR_MSG :=''(2) - Valor informado est\00E1 fora dos valores m\00EDnimo e m\00E1ximo permitidos'';'),
'        end if;',
'    end if;    ',
'end;    '))
,p_attribute_02=>'P7_VALOR,P7_VALOR_MIN,P7_VALOR_MAX'
,p_attribute_03=>'P7_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2124962220716616928)
,p_name=>'Cancelar'
,p_event_sequence=>410
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2115934085969856926)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2124962309151616929)
,p_event_id=>wwv_flow_api.id(2124962220716616928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Confirma cancelar requisi\00E7\00E3o ?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2124962373948616930)
,p_event_id=>wwv_flow_api.id(2124962220716616928)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    update req_reembolso ',
'        set cod_sit_req = 3',
'        where cod_req = :P7_COD_REQ;',
'end;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2124962523581616932)
,p_event_id=>wwv_flow_api.id(2124962220716616928)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126731198038869643)
,p_name=>'Confirmar Matriculas e Reembolso'
,p_event_sequence=>420
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(2113859884956616036)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126731239448869644)
,p_event_id=>wwv_flow_api.id(2126731198038869643)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_PROCESSAR := ''S'' ;',
'    update req_reembolso_matriculas_tmp ',
'    set cod_evento               = :P7_EVENTOS',
'      , cod_motivo               = :P7_MOTIVOS ',
'      , qtd_horas                = :P7_QTD_HORAS ',
'      , qtd_minutos              = :P7_QTD_MINUTOS  ',
'      , qtd_dias                 = :P7_QTD_DIAS',
'      , valor                    = :P7_VALOR',
'      , observacoes              = :P7_OBSERVACOES  ',
'      ,  DATA_VIGENCIA           = :P7_DATA_VIGENCIA ',
'      ,  DATA_VIGENCIA_EFETIVACAO= :P7_DATA_VIGENCIA_EFETIVACAO',
'      ,  DATA_VALIDADE_INICIAL   = :P7_DATA_VALIDADE_INICIAL ',
'      ,  DATA_VALIDADE_FINAL     = :P7_DATA_VALIDADE_FINAL',
'      ,  DIA_LIMITE_LANCTO       = :P7_DIA_LIMITE_LANCTO',
'      ,  QTD_PARCELAS            = :P7_QTD_PARCELAS',
'      , METRAGEM                 = :P7_METRAGEM    ',
'    where seq_id =:P7_SEQ_ID;',
'commit;',
'end;'))
,p_attribute_02=>'P7_EVENTOS,P7_MOTIVOS ,P7_QTD_HORAS ,P7_QTD_MINUTOS,P7_QTD_DIAS,P7_VALOR,P7_OBSERVACOES,P7_DATA_VIGENCIA,P7_DATA_VIGENCIA_EFETIVACAO,P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL,P7_DIA_LIMITE_LANCTO,P7_QTD_PARCELAS,P7_SEQ_ID'
,p_attribute_03=>'P7_PROCESSAR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126731394775869645)
,p_event_id=>wwv_flow_api.id(2126731198038869643)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2115600818757174435)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126731466631869646)
,p_event_id=>wwv_flow_api.id(2126731198038869643)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(2114406576322866931)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2126731568938869647)
,p_name=>'Atualiza matriculas'
,p_event_sequence=>430
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_EVENTOS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126731644205869648)
,p_event_id=>wwv_flow_api.id(2126731568938869647)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_PROCESSAR := ''S'' ;',
'    update req_reembolso_matriculas_tmp ',
'    set cod_evento               = :P7_EVENTOS',
'      , cod_motivo               = :P7_MOTIVOS ',
'      , qtd_horas                = :P7_QTD_HORAS ',
'      , qtd_minutos              = :P7_QTD_MINUTOS  ',
'      , qtd_dias                 = :P7_QTD_DIAS',
'      , valor                    = :P7_VALOR',
'      , observacoes              = :P7_OBSERVACOES  ',
'      ,  DATA_VIGENCIA           = :P7_DATA_VIGENCIA ',
'      ,  DATA_VIGENCIA_EFETIVACAO= :P7_DATA_VIGENCIA_EFETIVACAO',
'      ,  DATA_VALIDADE_INICIAL   = :P7_DATA_VALIDADE_INICIAL ',
'      ,  DATA_VALIDADE_FINAL     = :P7_DATA_VALIDADE_FINAL',
'      ,  DIA_LIMITE_LANCTO       = :P7_DIA_LIMITE_LANCTO',
'      ,  QTD_PARCELAS            = :P7_QTD_PARCELAS',
'      , metragem                 = :P7_METRAGEM',
'    where seq_id =:P7_SEQ_ID;',
'commit;',
'end;'))
,p_attribute_02=>'P7_EVENTOS,P7_MOTIVOS ,P7_QTD_HORAS ,P7_QTD_MINUTOS,P7_QTD_DIAS,P7_VALOR,P7_OBSERVACOES,P7_DATA_VIGENCIA,P7_DATA_VIGENCIA_EFETIVACAO,P7_DATA_VALIDADE_INICIAL,P7_DATA_VALIDADE_FINAL,P7_DIA_LIMITE_LANCTO,P7_QTD_PARCELAS,P7_SEQ_ID'
,p_attribute_03=>'P7_PROCESSAR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2126731900239869650)
,p_event_id=>wwv_flow_api.id(2126731568938869647)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(2115600818757174435)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1135245490953641885)
,p_name=>'Mostra/Oculta Metragem'
,p_event_sequence=>440
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_USA_METRAGEM'
,p_condition_element=>'P7_USA_METRAGEM'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1135245589792641886)
,p_event_id=>wwv_flow_api.id(1135245490953641885)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1135245059910641881)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139940374016901337)
,p_event_id=>wwv_flow_api.id(1135245490953641885)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1135245059910641881)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139940626741901340)
,p_name=>'Valida Metragem'
,p_event_sequence=>450
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_METRAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139940739381901341)
,p_event_id=>wwv_flow_api.id(1139940626741901340)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_ERR_MSG := null;',
'    if :P7_METRAGEM is not null then',
'        if to_number(:P7_METRAGEM) < to_number(:P7_METRAGEM_MINIMA) ',
'            or  to_number(:P7_METRAGEM) > to_number(:P7_METRAGEM_MAXIMA) then',
unistr('            :P7_ERR_MSG :=''(1) - Valor de metragem informado est\00E1 fora dos valores m\00EDmino e m\00E1ximo permitidos'';'),
'        end if;',
'    end if;    ',
'end;  ',
''))
,p_attribute_02=>'P7_METRAGEM,P7_METRAGEM_MINIMA,P7_METRAGEM_MAXIMA'
,p_attribute_03=>'P7_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139943654228901370)
,p_name=>'Mostra Metragem'
,p_event_sequence=>460
,p_condition_element=>'P7_USA_METRAGEM'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139943745277901371)
,p_event_id=>wwv_flow_api.id(1139943654228901370)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1135245059910641881)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139943883926901372)
,p_event_id=>wwv_flow_api.id(1139943654228901370)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(1135245059910641881)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1139944153596901375)
,p_name=>'Calcula valor metragem'
,p_event_sequence=>470
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P7_METRAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1139944275035901376)
,p_event_id=>wwv_flow_api.id(1139944153596901375)
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
'          into  :P7_USA_METRAGEM',
'        from REEMBOLSO_PERFIS_PROCESSOS',
'          where cod_processo = :P7_COD_PROCESSO',
'          and cod_empresa = :P7_COD_EMPRESA',
'          and cod_perfil = :P_PERFIL;',
'    exception',
'        when others then ',
'        :P7_USA_METRAGEM := ''N'';  ',
'    end;',
'    --',
'    begin',
'        SELECT VALOR_METRO',
'          INTO v_valor',
'        FROM REEMBOLSO_PERFIS_EVENTOS t',
'        WHERE COD_EMPRESA = :P7_COD_EMPRESA',
'        AND COD_PROCESSO = :P7_COD_PROCESSO',
'        AND COD_EVENTO = :P7_EVENTOS;',
'    end;',
'    :P7_VALOR := :P7_METRAGEM * v_valor;',
'',
'end ;'))
,p_attribute_02=>'P7_METRAGEM,P7_VALOR_METRAGEM,P7_COD_EMPRESA,P7_COD_PROCESSO,P7_EVENTOS'
,p_attribute_03=>'P7_VALOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2109527185583109714)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P7_SITUACAO := ''T'';',
':P7_PERFIL   := :P_PERFIL;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2115193024501245012)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Recupera Requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_req is',
'    select * from req_reembolso ',
'    where cod_req = :P7_COD_REQ;',
'    ',
'    cursor c_req_mat is',
'    select * from req_reembolso_matriculas ',
'    where cod_req = :P7_COD_REQ;',
'    ',
'    r_req         c_req%rowtype;',
'    r_req_mat     c_req_mat%rowtype;',
'    v_nome        inf_pessoais.nome%type;',
'    v_desc_op     ocorr_pagto.nome%type;',
'    v_desc_mot    motivo_alteracoes.descricao%type;',
'begin',
'    if :P7_COD_REQ is not null then',
'        :P7_PESQUISA := ''S'';',
'        open c_req;',
'        fetch c_req into r_req;',
'        close c_req;',
'        ',
'        select cod_sit_req||'' - ''||upper(desc_sit_req) ',
'           into :P7_REQ_SIT_DSP',
'        from sit_req',
'        where cod_sit_req = r_req.cod_sit_req;',
'',
'        begin',
'            select tem_anexo',
'              into :P7_TEM_ANEXO',
'            from REEMBOLSO_PROCESSOS',
'            where cod = r_req.cod_processo;',
'        exception',
'           when others then',
'               :P7_TEM_ANEXO := ''N'';',
'        end;',
'        begin',
'            select USA_METRAGEM',
'              into :P7_USA_METRAGEM',
'            from REEMBOLSO_PERFIS_PROCESSOS',
'            where cod_processo = r_req.cod_processo',
'            and cod_empresa = :P7_COD_EMPRESA',
'            and cod_perfil = :P_PERFIL;',
'        exception',
'           when others then',
'               :P7_USA_METRAGEM := ''N'';',
'        end;',
'',
'        :P7_REQ_SIT                        := r_req.cod_sit_req;',
'        :P7_REQ_DATA_SIT                   := r_req.dt_req;  ',
'        :P7_REQ_DATA                       := r_req.dt_sit_req; ',
'        :P7_COD_EMPRESA                    := r_req.cod_empresa;',
'        :P7_COD_PROCESSO                   := r_req.cod_processo;',
'        :P7_FILIAIS                        := r_req.filiais;',
'        :P7_SINDICATOS                     := r_req.sindicatos;',
'        :P7_CLASSIFICACAO_CENTRO_CUSTO     := r_req.CLASSIFICACAO_CENTRO_CUSTO;',
'        :P7_CENTRO_CUSTO                   := r_req.CENTRO_CUSTO;',
'        :P7_UNIDADE_ADMINISTRATIVA         := r_req.UNIDADE_ADMINISTRATIVA;',
'        :P7_ATIVIDADE                      := r_req.ATIVIDADE;',
'        :P7_CLASSIFICACAO_CARGO            := r_req.CLASSIFICACAO_CARGO;',
'        :P7_CARGOS                         := r_req.CARGOS;',
'        :P7_SITUACAO                       := r_req.SITUACAO;',
'        ',
'        SELECT DECODE (NVL (r_req.efetivacao, ''N''),',
'                              ''S'', ''SIM'',',
'                              ''N'', ''NAO''',
'                             ) INTO :P7_EFETIVACAO',
'        FROM DUAL;                     ',
'        ',
'        --if :P7_SEQ_ID is null then',
'            :P7_SEQ_ID := to_char(sysdate, ''yyyymmddhh24miss'');',
'        --end if;',
'        ',
'        open c_req_mat;',
'        fetch c_req_mat into r_req_mat;',
'        close c_req_mat;',
'        ',
'        --',
'        :P7_EVENTOS               :=  r_req_mat.cod_evento;',
'        :P7_MOTIVOS               :=  r_req_mat.cod_motivo;',
'        :P7_QTD_HORAS             :=  r_req_mat.qtd_horas;',
'        :P7_QTD_MINUTOS           := r_req_mat.qtd_minutos;',
'        :P7_QTD_DIAS              :=  r_req_mat.qtd_dias;',
'        :P7_VALOR                 :=  r_req_mat.valor;',
'        :P7_DATA_VIGENCIA         :=  r_req_mat.data_vigencia;',
'        :P7_DIA_LIMITE_LANCTO        := r_req_mat.dia_limite_lancto;',
'        :P7_DATA_VIGENCIA_EFETIVACAO := r_req_mat.data_vigencia_efetivacao;',
'        :P7_DATA_VALIDADE_INICIAL    := r_req_mat.data_validade_inicial;',
'        :P7_DATA_VALIDADE_FINAL      := r_req_mat.data_validade_final;',
'        :P7_QTD_PARCELAS             := r_req_mat.qtd_parcelas;',
'        :P7_OBSERVACOES              := r_req_mat.observacoes;',
'        :P7_EVENTOS                  := r_req_mat.cod_evento;',
'        :P7_MOTIVOS                  := r_req_mat.cod_motivo;',
'        :P7_METRAGEM                 := r_req_mat.metragem;',
'        ',
'        --',
'        open c_req_mat;        ',
'        loop',
'        fetch c_req_mat into r_req_mat;',
'           exit when c_req_mat%NOTFOUND;',
'                begin',
'                    select nome ',
'                       into v_nome',
'                       from inf_pessoais',
'                    where cod_empresa = :P7_COD_EMPRESA',
'                    and matricula = r_req_mat.matricula;',
'                exception',
'                    when others then',
'                        v_nome := null;',
'                end;',
'                --',
'                begin',
'                    select nome',
'                    into v_desc_op',
'                    from ocorr_pagto',
'                    where cod = :P7_EVENTOS',
'                    and cod_empresa = :P7_COD_EMPRESA;',
'                exception',
'                    when others then',
'                        v_desc_op := null;',
'                end;',
'                --',
'                begin',
'                    select descricao',
'                    into  v_desc_mot',
'                    from motivo_alteracoes',
'                    where cod = :P7_MOTIVOS;',
'                exception',
'                    when others then',
'                        v_desc_op := null;',
'                end;',
'',
'                insert into req_reembolso_matriculas_tmp( cod_empresa',
'                                                          , matricula',
'                                                          , cod_evento',
'                                                          , cod_motivo',
'                                                          , qtd_horas',
'                                                          , qtd_minutos',
'                                                          , qtd_dias',
'                                                          , valor',
'                                                          , seq_id',
'                                                          , observacoes',
'                                                          ,  data_vigencia',
'                                                          ,  data_vigencia_efetivacao',
'                                                          ,  data_validade_inicial',
'                                                          ,  data_validade_final',
'                                                          ,  dia_limite_lancto',
'                                                          ,  qtd_parcelas',
'                                                          ,  filial',
'                                                            )',
'                    values (:P7_COD_EMPRESA',
'                           , r_req_mat.matricula',
'                           , r_req_mat.cod_evento',
'                           , r_req_mat.cod_motivo',
'                           , r_req_mat.qtd_horas',
'                           , r_req_mat.qtd_minutos',
'                           , r_req_mat.qtd_dias',
'                           , r_req_mat.valor',
'                           , :P7_SEQ_ID',
'                           , r_req_mat.observacoes',
'                           , r_req_mat.data_vigencia',
'                           , r_req_mat.data_vigencia_efetivacao',
'                           , r_req_mat.data_validade_inicial',
'                           , r_req_mat.data_validade_final',
'                           , r_req_mat.dia_limite_lancto',
'                           , r_req_mat.qtd_parcelas',
'                           , r_req_mat.filial',
'                        );',
'        end loop;',
'        close c_req_mat;',
'        commit;      ',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2109527781077109720)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pesquisar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_conta number := 0;',
'begin',
'',
'    if :P7_SEQ_ID is null then',
'        :P7_SEQ_ID := to_char(sysdate, ''yyyymmddhh24miss'');',
'    end if;',
'    DELETE FROM req_reembolso_matriculas_tmp WHERE SEQ_ID = :P7_SEQ_ID;',
'    ',
'    for i in (select distinct i.cod_empresa, p.matricula, p.nome, i.filial',
'                from informacoes_funcionais i',
'                     , inf_pessoais p',
'                     , CLASS_CARGO c_cargo',
'                     , cargos c',
'                     , class_ccusto c_custo ',
'                     , centro_de_custo cc',
'                where i.cod_empresa = p.cod_empresa',
'                and i.matricula = p.matricula ',
'                and i.cod_empresa = 700',
'                and c_cargo.cod = c.class_cargo',
'                and c.cod = i.cargo',
'                and c_custo.cod = cc.class_ccusto',
'                and cc.cod = i.cod_ccusto',
'                and (exists (select 1 ',
'                                   from reembolso_perfis_filiais ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_filial = i.filial',
'                                       and cod_filial = :P7_FILIAIS',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or i.filial = NVL(:P7_FILIAIS, i.filial))',
'                and (exists (select 1 ',
'                                   from REEMBOLSO_PERFIS_CCUSTO ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_ccusto = i.cod_ccusto',
'                                       and cod_ccusto = :P7_CENTRO_CUSTO',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or I.COD_CCUSTO = NVL(:P7_CENTRO_CUSTO, I.COD_CCUSTO))',
'                and (exists (select 1 ',
'                                   from REEMBOLSO_PERFIS_CARGOS ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_ccusto = i.cargo',
'                                       and cod_ccusto = :P7_CARGOS',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or I.cargo = NVL(:P7_CARGOS, I.cargo))',
'                and (exists (select 1 ',
'                                   from REEMBOLSO_UNID_ADMINISTRATIVAS ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_unidade_adm = i.unidade_adm',
'                                       and cod_unidade_adm = :P7_UNIDADE_ADMINISTRATIVA',
'                                       and cod = :P7_COD_ELEGIBILIDADE)   ',
'                    or I.unidade_adm = NVL(:P7_UNIDADE_ADMINISTRATIVA, I.unidade_adm))',
'                and (exists (select 1 ',
'                                   from REEMBOLSO_ATIVIDADES ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_atividade = i.cod_atividade',
'                                       and cod_atividade = :P7_ATIVIDADE',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or I.cod_atividade = NVL(:P7_ATIVIDADE, I.cod_atividade))',
'                 and (exists (select 1 ',
'                                   from REEMBOLSO_CATEGORIA_CARGOS ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and COD_CATEGORIA_CARGO = c_cargo.cod',
'                                       and COD_CATEGORIA_CARGO = :P7_CLASSIFICACAO_CARGO',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or c_cargo.cod = NVL(:P7_CLASSIFICACAO_CARGO, c_cargo.cod))',
'                 and (exists (select 1 ',
'                                   from REEMBOLSO_CATEGORIA_CENTRO_CUSTO ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_categoria_ccusto = c_custo.cod',
'                                       and cod_categoria_ccusto = :P7_CLASSIFICACAO_CENTRO_CUSTO',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or c_custo.cod = NVL(:P7_CLASSIFICACAO_CENTRO_CUSTO, c_custo.cod))',
'                 and (exists (select 1 ',
'                                   from REEMBOLSO_SINDICATOS ',
'                                   where cod_empresa = i.cod_empresa',
'                                       and cod_sindicato = i.num_sind_diss',
'                                       and cod_sindicato = :P7_SINDICATOS',
'                                       and cod = :P7_COD_ELEGIBILIDADE)  ',
'                    or i.num_sind_diss = NVL( :P7_SINDICATOS, i.num_sind_diss))',
'               and ((i.situacao < ''90'' and :P7_SITUACAO = ''A'') ',
'                   or (situacao >= ''90'' and :P7_SITUACAO = ''D'') or (:P7_SITUACAO = ''T'')) )',
'    loop',
'        v_conta := v_conta + 1;',
'        insert into req_reembolso_matriculas_tmp( cod_empresa',
'                                                  , matricula',
'                                                  , cod_evento',
'                                                  , cod_motivo',
'                                                  , qtd_horas',
'                                                  , qtd_minutos',
'                                                  , qtd_dias',
'                                                  , valor',
'                                                  , DOCUMENTO1',
'                                                  , DOCUMENTO2',
'                                                  , seq_id',
'                                                  , observacoes',
'                                                  ,  DATA_VIGENCIA',
'                                                  ,  DATA_VIGENCIA_EFETIVACAO',
'                                                  ,  DATA_VALIDADE_INICIAL',
'                                                  ,  DATA_VALIDADE_FINAL',
'                                                  ,  DIA_LIMITE_LANCTO',
'                                                  ,  QTD_PARCELAS',
'                                                  ,  FILIAL',
'                                                )',
'            values (:P7_COD_EMPRESA',
'                   , i.matricula',
'                   , :P7_EVENTOS',
'                   , :P7_MOTIVOS',
'                   , :P7_QTD_HORAS',
'                   , :P7_QTD_MINUTOS',
'                   , :P7_QTD_DIAS',
'                   , :P7_VALOR',
'                   , null',
'                   , null',
'                   , :P7_SEQ_ID',
'                   , :P7_OBSERVACOES',
'                   , :P7_DATA_VIGENCIA',
'                   , :P7_DATA_VIGENCIA_EFETIVACAO',
'                   , :P7_DATA_VALIDADE_INICIAL',
'                   , :P7_DATA_VALIDADE_FINAL',
'                   , :P7_DIA_LIMITE_LANCTO',
'                   , :P7_QTD_PARCELAS',
'                   , i.filial',
'                );',
'    end loop;',
'    :P7_CONTA_ELEG := v_conta;',
'    :P7_PROCESSAR := ''S'';',
'    :P7_PESQUISA := ''S'';',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2109527289689109715)
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2126731805802869649)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Confirmar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P7_PROCESSAR := ''S'' ;',
'    update req_reembolso_matriculas_tmp ',
'    set cod_evento               = :P7_EVENTOS',
'      , cod_motivo               = :P7_MOTIVOS ',
'      , qtd_horas                = :P7_QTD_HORAS ',
'      , qtd_minutos              = :P7_QTD_MINUTOS  ',
'      , qtd_dias                 = :P7_QTD_DIAS',
'      , valor                    = :P7_VALOR',
'      , observacoes              = :P7_OBSERVACOES  ',
'      ,  DATA_VIGENCIA           = :P7_DATA_VIGENCIA ',
'      ,  DATA_VIGENCIA_EFETIVACAO= :P7_DATA_VIGENCIA_EFETIVACAO',
'      ,  DATA_VALIDADE_INICIAL   = :P7_DATA_VALIDADE_INICIAL ',
'      ,  DATA_VALIDADE_FINAL     = :P7_DATA_VALIDADE_FINAL',
'      ,  DIA_LIMITE_LANCTO       = :P7_DIA_LIMITE_LANCTO',
'      ,  QTD_PARCELAS            = :P7_QTD_PARCELAS',
'      ,  METRAGEM                = :P7_METRAGEM   ',
'    where seq_id =:P7_SEQ_ID;',
'commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2114406576322866931)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2114407912805866944)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Salvar requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_flagOK     varchar2(1);',
'    v_msg        varchar2(4000);    ',
'    v_cod_req    REQ_REEMBOLSO.COD_REQ%TYPE; ',
'begin',
'  if :P7_CONTA_ELEG = 0 then',
'      apex_error.add_error (',
unistr('        p_message          => ''N\00E3o foram selecionadas matriculas ou a elegibilidade n\00E3o retornou matriculas'','),
'        p_display_location => apex_error.c_inline_in_notification );',
'  end if;',
'  --',
'  PKG_REQ_REEMBOLSO.Criar_Requisicao( p_cod_empresa         => :P7_COD_EMPRESA',
'                                    ,  p_mat_solicitante    => :P_MATRICULA_USER',
'                                    ,  p_cod_processo       => :P7_COD_PROCESSO',
'                                    ,  p_cod_elegibilidade  => :P7_COD_ELEGIBILIDADE',
'                                    ,  p_filiais            => :P7_FILIAIS',
'                                    ,  p_sindicatos         => :P7_SINDICATOS',
'                                    ,  p_class_centro_custo => :P7_CLASSIFICACAO_CENTRO_CUSTO',
'                                    ,  p_centro_custo       => :P7_CENTRO_CUSTO',
'                                    ,  p_unidade_admin      => :P7_UNIDADE_ADMINISTRATIVA',
'                                    ,  p_atividade          => :P7_ATIVIDADE',
'                                    ,  p_class_cargo        => :P7_CLASSIFICACAO_CARGO',
'                                    ,  p_cargo              => :P7_CARGOS',
'                                    ,  p_situacao           => :P7_SITUACAO',
'                                    ,  p_cod_evento         => :P7_EVENTOS',
'                                    ,  p_usuario            => :P_USUARIO',
'                                    ,  p_cod_req            => :P7_COD_REQ',
'                                    ,  pflg_retorno         => v_flagOK',
'                                    ,  pmsg_retorno         => v_msg);',
'                                    ',
'                                   ',
'                                    ',
'    if v_msg is null then',
'      PKG_REQ_REEMBOLSO.Post_Insert(pcod_empresa => :P7_COD_EMPRESA',
'                            , psolicitacao         => :P7_COD_REQ',
'                            , pflg_retorno         => v_flagOK',
'                            , pmsg_retorno         => v_msg);',
'',
'  ',
'    else',
'        apex_error.add_error (',
'            p_message          => v_msg,',
'            p_display_location => apex_error.c_inline_in_notification );                                    ',
'  ',
'  end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2114406576322866931)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2114407751426866943)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Salva Matriculas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_flag varchar2(4000);    ',
'    v_erro varchar2(4000);',
'    l_checked_value VARCHAR2(4000);',
'begin    ',
'    IF APEX_APPLICATION.G_F01.COUNT > 0 THEN',
'        FOR i IN 1..APEX_APPLICATION.G_F01.COUNT LOOP',
'            l_checked_value := APEX_APPLICATION.G_F01(i);',
'            update req_reembolso_matriculas_tmp set status = ''S'' where matricula = l_checked_value and seq_id = :P7_SEQ_ID;',
'            commit;',
'        END LOOP;',
'    END IF;',
'',
'    --delete from  req_reembolso_matriculas_tmp  where seq_id = :P7_SEQ_ID AND STATUS IS NULL;',
'    --commit;',
'        ',
'    PKG_REQ_REEMBOLSO.Criar_Requisicao_Matriculas(p_cod_empresa        => :P7_COD_EMPRESA',
'                                              , p_cod_processo       => :P7_COD_PROCESSO',
'                                              , p_seqid              => :P7_SEQ_ID',
'                                              , p_cod_elegibilidade  => :P7_COD_ELEGIBILIDADE',
'                                              , p_usuario            => :P_USUARIO',
'                                              , p_cod_req            => :P7_COD_REQ',
'                                              , pflg_retorno         => v_flag',
'                                              , pmsg_retorno         => v_erro);',
'',
'    delete from  req_reembolso_matriculas_tmp  where seq_id = :P7_SEQ_ID;',
'    commit;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(2114406576322866931)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(2115933038148856916)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Alterar requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    update REQ_REEMBOLSO',
'    set COD_EMPRESA = :P7_COD_EMPRESA',
'        , COD_PROCESSO = :P7_COD_PROCESSO',
'        , COD_SIT_REQ = 1',
'        , DT_SIT_REQ = SYSDATE',
'        , DT_ATUALIZACAO = SYSDATE',
'        , USUARIO = :P_USUARIO',
'        , FILIAIS = :P7_FILIAIS',
'        , SINDICATOS = :P7_SINDICATOS',
'        , CLASSIFICACAO_CENTRO_CUSTO = :P7_CLASSIFICACAO_CENTRO_CUSTO',
'        , CENTRO_CUSTO =  :P7_CENTRO_CUSTO',
'        , UNIDADE_ADMINISTRATIVA = :P7_UNIDADE_ADMINISTRATIVA',
'        , ATIVIDADE = :P7_ATIVIDADE',
'        , CLASSIFICACAO_CARGO = :P7_CLASSIFICACAO_CARGO',
'        , CARGOS = :P7_CARGOS',
'        , SITUACAO = :P7_SITUACAO',
'    where cod_req = :P7_COD_REQ;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
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
