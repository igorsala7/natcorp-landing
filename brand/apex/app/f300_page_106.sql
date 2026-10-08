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
,p_default_application_id=>300
,p_default_id_offset=>785128738853783604
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 300 - Painel do Colaborador - Natcorp
--
-- Application Export:
--   Application:     300
--   Name:            Painel do Colaborador - Natcorp
--   Date and Time:   23:13 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 106
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00106
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>106);
end;
/
prompt --application/pages/page_00106
begin
wwv_flow_api.create_page(
 p_id=>106
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>unistr('Contrato de Gest\00E3o: Avaliado')
,p_step_title=>unistr('Contrato de Gest\00E3o: Avaliado')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20250131115226'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145404784171224494040)
,p_plug_name=>'Avaliador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145404784509909494044)
,p_plug_name=>'Foto'
,p_parent_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145404784692309494046)
,p_plug_name=>'Dados'
,p_parent_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145404785203811494051)
,p_plug_name=>'Contrato'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405019214589789247)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405020740701789445)
,p_plug_name=>'Dados'
,p_parent_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405023520486789452)
,p_plug_name=>'Foto'
,p_parent_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405024356973789453)
,p_plug_name=>'Metas'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492016720374058578)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c."ROWID",',
'       c.cod_empresa,',
'       c.cod_contrato,',
'       c.matricula,',
'       c.sequencia,',
'       /*c.cod_objetivo||'' - ''||*/initcap(co.descr_objetivo) objetivo,     ',
'       /*c.cod_categoria||'' - ''||*/initcap(cc.descr_categoria) categoria,',
'       c.perc_peso perc_peso,',
'       c.acao,',
'       decode(c.tipo_meta,''V'',''Valor'',''P'',''Percentual'') Tipo_Meta,',
'       CASE WHEN c.tipo_meta = ''V'' THEN trim(to_char(c.meta))',
'            WHEN c.tipo_meta = ''P'' THEN trim(c.meta)||''%'' END meta,',
'       CASE WHEN c.tipo_meta = ''V'' THEN trim(to_char(c.valor_atingido))',
'            WHEN c.tipo_meta = ''P'' THEN trim(c.valor_atingido)||''%'' END valor_atingido,',
'       CASE WHEN c.tipo_meta = ''V'' THEN trim(to_char(c.perc_atingido))',
'            WHEN c.tipo_meta = ''P'' THEN trim(c.perc_atingido)||''%'' END perc_atingido,',
'       CASE WHEN c.tipo_meta = ''V'' THEN trim(to_char(c.desemp_atingido))',
'            WHEN c.tipo_meta = ''P'' THEN trim(c.desemp_atingido)||''%'' END desemp_atingido,',
'       c.perc_peso peso',
'  from cg_contratos c, cg_objetivos co, cg_categorias cc',
' where c.cod_objetivo = co.cod_objetivo (+)',
'   and c.cod_categoria = cc.cod_categoria (+)',
'   and c.cod_empresa = :p106_cod_empresa',
'   and c.cod_contrato = :p106_cod_contrato',
' order by 2,3,4,5'))
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
 p_id=>wwv_flow_api.id(145405024727644789455)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum Dado Encontrado'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:RP,109:P109_ROWID,P109_COD_EMPRESA,P109_COD_CONTRATO,P109_EMP_AVAL,P109_MAT_AVAL,P109_STATUS_CONTRATO:#ROWID#,#COD_EMPRESA#,#COD_CONTRATO#,&P106_EMP_AVAL.,&P106_MAT_AVAL.,&P106_STATUS_CONTRATO.'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>101402043529938854
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404781232033494011)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'T'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404781339110494012)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'U'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404781396121494013)
,p_db_column_name=>'COD_CONTRATO'
,p_display_order=>30
,p_column_identifier=>'V'
,p_column_label=>'Cod contrato'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404781571926494014)
,p_db_column_name=>'MATRICULA'
,p_display_order=>40
,p_column_identifier=>'W'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404781637086494015)
,p_db_column_name=>'SEQUENCIA'
,p_display_order=>50
,p_column_identifier=>'X'
,p_column_label=>unistr('N\00BA')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145405334008954280534)
,p_db_column_name=>'PERC_PESO'
,p_display_order=>60
,p_column_identifier=>'AP'
,p_column_label=>'Peso'
,p_column_html_expression=>'#PERC_PESO#%'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782047216494019)
,p_db_column_name=>'ACAO'
,p_display_order=>70
,p_column_identifier=>'AB'
,p_column_label=>unistr('A\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782176984494020)
,p_db_column_name=>'TIPO_META'
,p_display_order=>80
,p_column_identifier=>'AC'
,p_column_label=>'Tipo de Meta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782603825494025)
,p_db_column_name=>'OBJETIVO'
,p_display_order=>90
,p_column_identifier=>'AH'
,p_column_label=>'Objetivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782715006494026)
,p_db_column_name=>'CATEGORIA'
,p_display_order=>100
,p_column_identifier=>'AI'
,p_column_label=>'Categoria'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782872222494027)
,p_db_column_name=>'META'
,p_display_order=>110
,p_column_identifier=>'AJ'
,p_column_label=>'Meta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404782892649494028)
,p_db_column_name=>'VALOR_ATINGIDO'
,p_display_order=>120
,p_column_identifier=>'AK'
,p_column_label=>'Valor Atingido'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404783009505494029)
,p_db_column_name=>'PERC_ATINGIDO'
,p_display_order=>130
,p_column_identifier=>'AL'
,p_column_label=>'% Atingido'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145404783157256494030)
,p_db_column_name=>'DESEMP_ATINGIDO'
,p_display_order=>140
,p_column_identifier=>'AM'
,p_column_label=>'Desempenho Atingido'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145405094317297601549)
,p_db_column_name=>'PESO'
,p_display_order=>150
,p_column_identifier=>'AO'
,p_column_label=>'Peso'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(145405027931624789520)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1014053'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'SEQUENCIA:OBJETIVO:CATEGORIA:PERC_PESO:ACAO:TIPO_META:META:VALOR_ATINGIDO:PERC_ATINGIDO:DESEMP_ATINGIDO:'
,p_sum_columns_on_break=>'PERC_PESO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405091843700601524)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(145369630915962673642)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(145492038528010058625)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145404784458716494043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_button_name=>'p106_btn_aval'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P106_EMP_AVAL.,&P106_MAT_AVAL.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405174140201671465)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_button_name=>'p106_relatorio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Gerar Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-pdf-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405019636952789251)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_button_name=>'p106_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P106_EMP_COLAB.,&P106_MAT_COLAB.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405331472325280508)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_button_name=>'p106_concluir'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Concluir'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405333749849280531)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_button_name=>'p106_finalizar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Finalizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-mail-forward'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405334931687280543)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_button_name=>'p106_revisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Revisar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145406920131403856934)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_button_name=>'p106_indicador'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Indicador'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:100:&SESSION.::&DEBUG.:RP,100:P100_EMP,P100_MAT,P100_CICLO_IND,P100_CONTRATO_IND:&P106_EMP_COLAB.,&P106_MAT_COLAB.,&P106_COD_CICLO.,&P106_COD_CONTRATO.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-bar-chart'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405093635545601542)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(145405024356973789453)
,p_button_name=>'P106_BTN_ADICIONAR_META'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Adicionar Meta'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.:RP,109:P109_COD_EMPRESA,P109_COD_CONTRATO,P109_MATRICULA,P109_COD_DIMENSAO,P109_COD_CICLO,P109_CARGO_MAT,P109_CCUSTO_MAT,P109_FILIAL_MAT,P109_STATUS_CONTRATO:&P106_COD_EMPRESA.,&P106_COD_CONTRATO.,&P106_MAT_COLAB.,&P106_COD_DIMENSAO.,&P106_COD_CICLO.,&P106_COD_CARGO_COLAB.,&P106_CC_COLAB.,&P106_FIL_COLAB.,&P106_STATUS_CONTRATO.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145404784196525494041)
,p_name=>'P106_EMP_AVAL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145404784314453494042)
,p_name=>'P106_MAT_AVAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145404784664212494045)
,p_name=>'P106_FOTO_AVAL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145404784509909494044)
,p_prompt=>'Foto aval'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p106_emp_aval',
'                               and matricula   = :p106_mat_aval), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P106_EMP_AVAL || ''|'' || :P106_MAT_AVAL',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145404784797200494047)
,p_name=>'P106_EMPRESA_AVAL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145404784692309494046)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145404784890117494048)
,p_name=>'P106_MATRICULA_AVAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145404784692309494046)
,p_prompt=>'Avaliador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405020060851789434)
,p_name=>'P106_EMP_COLAB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405020363783789444)
,p_name=>'P106_MAT_COLAB'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405021142264789446)
,p_name=>'P106_EMPRESA_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145405020740701789445)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405021558543789446)
,p_name=>'P106_MATRICULA_COLAB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145405020740701789445)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405021945887789448)
,p_name=>'P106_CARGO_COLAB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(145405020740701789445)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405023912294789452)
,p_name=>'P106_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145405023520486789452)
,p_prompt=>'Foto colab'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p106_emp_colab',
'                               and matricula   = :p106_mat_colab), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P106_EMP_COLAB || ''|'' || :P106_MAT_COLAB',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405089743830601503)
,p_name=>'P106_COD_CICLO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090129262601507)
,p_name=>'P106_CICLO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>'Ciclo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090253979601508)
,p_name=>'P106_DIRETORIA'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>'Diretoria'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090291510601509)
,p_name=>'P106_COD_DIMENSAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090453899601510)
,p_name=>'P106_STATUS_CONTRATO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090506711601511)
,p_name=>'P106_RESULTADO_FINAL'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>'Resultado Final'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090771294601513)
,p_name=>'P106_COD_FILIAL_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145405020740701789445)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090787399601514)
,p_name=>'P106_COD_CCUSTO_COLAB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(145405020740701789445)
,p_prompt=>'Centro de Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405090934901601515)
,p_name=>'P106_COD_FILIAL_AVAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145404784692309494046)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091043729601516)
,p_name=>'P106_COD_CCUSTO_AVAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145404784692309494046)
,p_prompt=>'Centro de Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091171838601517)
,p_name=>'P106_CC_COLAB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091206204601518)
,p_name=>'P106_CC_AVAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091347877601519)
,p_name=>'P106_DIMENSAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>unistr('Dimens\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091565573601521)
,p_name=>'P106_DESC_STATUS_CONTRATO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>unistr('Per\00EDodo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091632343601522)
,p_name=>'P106_CANCELADO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091710479601523)
,p_name=>'P106_DESC_CANCELADO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_prompt=>'Cancelado'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_grid_label_column_span=>1
,p_display_when=>'P106_CANCELADO'
,p_display_when2=>'S'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405091924168601525)
,p_name=>'P106_CONTRATO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405093816919601544)
,p_name=>'P106_COD_CARGO_AVAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405093921476601545)
,p_name=>'P106_FIL_AVAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145404784171224494040)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405094016511601546)
,p_name=>'P106_FIL_COLAB'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405094162507601547)
,p_name=>'P106_COD_CARGO_COLAB'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(145405019214589789247)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405094426163601550)
,p_name=>'P106_SUM_PERC_PESO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145405024356973789453)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405094509728601551)
,p_name=>'P106_MENSAGEM'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405173789386668992)
,p_name=>'P106_ENDERECO_REL'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405330810468280502)
,p_name=>'P106_OK'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405330959012280503)
,p_name=>'P106_FLAG'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405334549024280539)
,p_name=>'P106_ID_COPIA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405503108905290129)
,p_name=>'P106_ALTERADO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405503246907290130)
,p_name=>'P106_BTN_CONCLUIR'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405503351610290131)
,p_name=>'P106_BTN_REVISAR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405587304559174313)
,p_name=>'P106_BTN_ADICIONAR_META'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145405024356973789453)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145406920383864856936)
,p_name=>'P106_COD_CONTRATO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145406920439521856937)
,p_name=>'P106_COD_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145404785203811494051)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405503660742290134)
,p_name=>unistr('Hab/Desab Bot\00E3o Concluir')
,p_event_sequence=>11
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_BTN_CONCLUIR'
,p_condition_element=>'P106_BTN_CONCLUIR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405503916156290137)
,p_event_id=>wwv_flow_api.id(145405503660742290134)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405331472325280508)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405503788601290136)
,p_event_id=>wwv_flow_api.id(145405503660742290134)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405331472325280508)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405503984766290138)
,p_name=>unistr('Hab/Desab Bot\00E3o Revisar')
,p_event_sequence=>21
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_BTN_REVISAR'
,p_condition_element=>'P106_BTN_REVISAR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405504114557290139)
,p_event_id=>wwv_flow_api.id(145405503984766290138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405334931687280543)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405504215776290140)
,p_event_id=>wwv_flow_api.id(145405503984766290138)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405334931687280543)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405587473959174314)
,p_name=>unistr('Hab/Desab Bot\00E3o Adicionar Meta')
,p_event_sequence=>31
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_BTN_ADICIONAR_META'
,p_condition_element=>'P106_BTN_ADICIONAR_META'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405587569123174315)
,p_event_id=>wwv_flow_api.id(145405587473959174314)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405093635545601542)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405587620143174316)
,p_event_id=>wwv_flow_api.id(145405587473959174314)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405093635545601542)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405174302792673555)
,p_name=>'Chama Report'
,p_event_sequence=>41
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145405174140201671465)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405175215291673563)
,p_event_id=>wwv_flow_api.id(145405174302792673555)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30);',
'  ',
'  v_parametros varchar2(4000);',
'  ',
'  V_BASE VARCHAR2(100);',
'  ',
'  v_ip varchar2(200);',
'  ',
'begin',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'    ',
'',
'V_BASE := :P_BASE;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;  ',
'',
'    v_report := ''RP21005'';',
'    ',
'        V_PARAMETROS := ',
'              ''&P_USUARIO=''          ||:p_usuario||',
'              ''&P_COD_EMPRESA=''      ||:P106_cod_EMPRESA||',
'              ''&P_MATRICULA=''        ||:P106_MAT_COLAB||',
'              ''&P_CCUSTO=''           ||:P106_cc_colab ||',
'              ''&P_COD_CICLO=''        ||:P106_cod_ciclo ||',
'              ''&P_COD_CONTRATO=''        ||:P106_cod_contrato; ',
'    ',
'    :P106_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'    ',
'end;'))
,p_attribute_02=>'P106_COD_EMPRESA,P106_MAT_COLAB,P106_CC_COLAB,P106_COD_CICLO,P106_COD_CONTRATO,P_USUARIO'
,p_attribute_03=>'P106_ENDERECO_REL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405174719650673563)
,p_event_id=>wwv_flow_api.id(145405174302792673555)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:void(window.open($v(''P106_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145337668965798083693)
,p_name=>'Gera Report'
,p_event_sequence=>51
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145405174140201671465)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145337669357061083696)
,p_event_id=>wwv_flow_api.id(145337668965798083693)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP21005'
,p_attribute_02=>'CG_Avaliado.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P106_COD_EMPRESA,P106_MAT_COLAB,P106_CC_COLAB,P106_COD_CICLO,P106_COD_CONTRATO,P_USUARIO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return ''P_USUARIO=''          ||:p_usuario||',
'              ''&P_COD_EMPRESA=''      ||:P_EMPRESA_USER||--:P106_cod_EMPRESA||',
'              ''&P_MATRICULA=''        ||:P_MATRICULA_USER||--:P106_MAT_COLAB||',
'              ''&P_CCUSTO=''           ||:P106_cc_colab ||',
'              ''&P_COD_CICLO=''        ||:P106_cod_ciclo ||',
'              ''&P_COD_CONTRATO=''        ||:P106_cod_contrato; '))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405336937272288426)
,p_name=>'Dispara Alerta'
,p_event_sequence=>61
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_MENSAGEM'
,p_condition_element=>'P106_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405337344000288438)
,p_event_id=>wwv_flow_api.id(145405336937272288426)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P106_FLAG'').value == "Q") {',
'alertify.confirm($v(''P106_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P106_FLAG'').value = ''S'';',
'        $x(''P106_MENSAGEM'').value = '''';',
'        $x(''P106_OK'').value = ''S'';',
'       // $(''#P106_CREATE'').show();',
'    } else {',
'        $x(''P106_OK'').value = ''N'';',
'       // $(''#P106_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P106_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P106_FLAG'').value == "N") {',
'            $x(''P106_OK'').value = ''N'';',
'           // $(''#P106_CREATE'').hide();',
'        } else {',
'            $x(''P106_OK'').value = ''S'';',
'           // $(''#P106_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P106_MENSAGEM''));',
'    }else{',
'            $x(''P106_OK'').value = ''S'';',
'           // $(''#P106_CREATE'').show();',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405331054469280504)
,p_name=>'Inicia Alertify'
,p_event_sequence=>71
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405331105846280505)
,p_event_id=>wwv_flow_api.id(145405331054469280504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Iniciando Alertify'
,p_attribute_07=>'Ok'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405331239390280506)
,p_name=>'Valida_Preenchimento'
,p_event_sequence=>81
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405331373607280507)
,p_event_id=>wwv_flow_api.id(145405331239390280506)
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
'begin',
'',
' :p106_mensagem := null;',
' :p106_ok       := ''S'';',
'',
'pkg_cg_contratos.Valida_Preenchimento(:p106_cod_empresa',
'                          ,:p106_mat_colab',
'                          ,:p106_cod_ciclo',
'                          ,:p106_cod_contrato',
'                          ,v_flg_retorno',
'                          ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :p106_ok       := ''N'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' else',
'    :p106_flag     := null;',
'    :p106_mensagem := null;',
'    :p106_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P106_COD_EMPRESA,P106_MAT_COLAB,P106_COD_CICLO,P106_COD_CONTRATO'
,p_attribute_03=>'P106_MENSAGEM,P106_FLAG,P106_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405333299417280527)
,p_name=>'Valida_Peso'
,p_event_sequence=>91
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P106_SUM_PERC_PESO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405333439728280528)
,p_event_id=>wwv_flow_api.id(145405333299417280527)
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
'begin',
'',
' :p106_mensagem := null;',
' :p106_ok       := ''S'';',
'',
'pkg_cg_contratos.Valida_Peso(''S''',
'                          ,:p106_Sum_perc_peso',
'                          ,v_flg_retorno',
'                          ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :p106_ok       := ''N'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' else',
'    :p106_flag     := null;',
'    :p106_mensagem := null;',
'    :p106_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P106_SUM_PERC_PESO'
,p_attribute_03=>'P106_FLAG,P106_MENSAGEM,P106_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405334157989280535)
,p_name=>'prc_concluir'
,p_event_sequence=>101
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145405331472325280508)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405334256563280536)
,p_event_id=>wwv_flow_api.id(145405334157989280535)
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
'begin',
'',
' :p106_mensagem := null;',
' :p106_ok       := ''S'';',
'',
'pkg_cg_contratos.prc_concluir_colab(:p106_cod_empresa',
'                              ,:p106_cod_contrato',
'                              --,:p106_sum_perc_peso',
'                          ,:p106_mat_colab',
'                          ,:p106_cod_ciclo',
'                          ,:p_usuario',
'                          ,v_flg_retorno',
'                          ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :p106_ok       := ''N'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' else',
'    :p106_flag     := null;',
'    :p106_mensagem := null;',
'    :p106_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P106_COD_EMPRESA,P106_COD_CONTRATO,P106_SUM_PERC_PESO,P106_MAT_COLAB,P106_COD_CICLO'
,p_attribute_03=>'P106_MENSAGEM,P106_FLAG,P106_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405334375724280537)
,p_name=>'prc_finalizar'
,p_event_sequence=>111
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145405333749849280531)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405334387332280538)
,p_event_id=>wwv_flow_api.id(145405334375724280537)
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
'begin',
'',
' :p106_mensagem := null;',
' :p106_ok       := ''S'';',
'',
'pkg_cg_contratos.prc_finalizar(:p106_cod_empresa',
'                              ,:p106_cod_contrato',
'                          ,:p106_mat_colab',
'                          ,:p106_id_copia',
'                          ,:p106_resultado_final',
'                          ,:p_usuario',
'                          ,:p106_status_contrato',
'                          ,v_flg_retorno',
'                          ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno in (''Q'',''N'') then',
'    :p106_ok       := ''N'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' elsif trim(v_msg_retorno) is not null and v_flg_retorno not in (''Q'',''N'') then',
'    :p106_ok       := ''S'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' else',
'    :p106_flag     := null;',
'    :p106_mensagem := null;',
'    :p106_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P106_COD_EMPRESA,P106_COD_CONTRATO,P106_MAT_COLAB,P106_RESULTADO_FINAL,P_USUARIO'
,p_attribute_03=>'P106_STATUS_CONTRATO,P106_FLAG,P106_MENSAGEM,P106_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405335036143280544)
,p_name=>'Prc_Revisar'
,p_event_sequence=>121
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145405334931687280543)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405335094805280545)
,p_event_id=>wwv_flow_api.id(145405335036143280544)
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
'begin',
'',
' :p106_mensagem := null;',
' :p106_ok       := ''S'';',
'',
'pkg_cg_contratos.prc_revisar(:p106_cod_empresa',
'                            ,:p106_cod_contrato',
'                            ,:p106_mat_colab',
'                            ,:p106_emp_aval',
'                            ,:p106_sum_perc_peso',
'                            ,:p_usuario',
'                            ,v_flg_retorno',
'                            ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno in (''Q'',''N'') then',
'    :p106_ok       := ''N'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' elsif trim(v_msg_retorno) is not null and v_flg_retorno not in (''Q'',''N'') then',
'    :p106_ok       := ''S'';',
'    :p106_flag     := v_flg_retorno;',
'    :p106_mensagem := v_msg_retorno;',
' else',
'    :p106_flag     := null;',
'    :p106_mensagem := null;',
'    :p106_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P106_COD_EMPRESA,P106_COD_CONTRATO,P106_MAT_COLAB,P106_EMP_AVAL,P106_SUM_PERC_PESO,P_USUARIO'
,p_attribute_03=>'P106_FLAG,P106_MENSAGEM,P106_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405363421827862985)
,p_process_sequence=>30
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicia OK'
,p_process_sql_clob=>':p106_ok := ''S'';'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405333637262280530)
,p_process_sequence=>40
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula sum_perc_peso'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select sum(c.perc_peso) peso',
'  into :p106_sum_perc_peso',
'  from cg_contratos c, cg_objetivos co, cg_categorias cc',
' where c.cod_objetivo = co.cod_objetivo (+)',
'   and c.cod_categoria = cc.cod_categoria (+)',
'   and c.cod_empresa = :p106_cod_empresa',
'   and c.cod_contrato = :p106_cod_contrato;',
'   ',
'exception',
'when others then null;',
'   ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145406920511753856938)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Contrato'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) empresa_colab, ',
'       c.cod_filial_avaliado||'' - ''||initcap(fnct_nome_filial(c.cod_empresa,c.cod_filial_avaliado)) filial_colab, ',
'       c.cod_ccusto_avaliado||'' - ''||initcap(fnct_nome_ccusto(c.cod_empresa,c.cod_ccusto_avaliado)) ccusto_colab, ',
'       c.matricula_avaliado||'' - ''||initcap(fnct_nome_func(c.cod_empresa,c.matricula_avaliado)) matricula_colab, ',
'       c.cod_cargo_avaliado||'' - ''||initcap(fnct_nome_cargo(c.cod_cargo_avaliado)) cargo_colab,',
'       c.cod_empresa,',
'       c.cod_filial_avaliado,',
'       c.cod_ccusto_avaliado,',
'       c.cod_cargo_avaliado,',
'       c.matricula_avaliado,',
'       c.cod_emp_avaliador||'' - ''||initcap(fnct_nome_empresa(c.cod_emp_avaliador)) empresa_aval, ',
'       c.cod_filial_avaliador||'' - ''||initcap(fnct_nome_filial(c.cod_emp_avaliador,c.cod_filial_avaliador)) filial_aval, ',
'       c.cod_ccusto_avaliador||'' - ''||initcap(fnct_nome_ccusto(c.cod_emp_avaliador,c.cod_ccusto_avaliador)) ccusto_aval, ',
'       c.matricula_avaliador||'' - ''||initcap(fnct_nome_func(c.cod_emp_avaliador,c.matricula_avaliador)) matricula_aval,',
'       c.cod_emp_avaliador,',
'       c.matricula_avaliador,',
'       c.cod_filial_avaliador,',
'       c.cod_ccusto_avaliador,',
'       c.cod_contrato, ',
'       c.cod_ciclo, ',
'       c.cod_ciclo||'' - ''||initcap(l.descr_ciclo) ciclo,',
'       c.cod_dimensao, ',
'       c.cod_dimensao||'' - ''||initcap(d.descr_dimensao) dimensao,',
'       c.status_contrato, ',
unistr('       decode(c.status_contrato,''A'',''Avalia\00E7\00E3o'',''E'',''Entre Per\00EDodos'',''F'',''Finalizado'',''I'',''Inser\00E7\00E3o de Metas'',''M'',''Monitora\00E7\00E3o'') desc_status_contrato, '),
'       c.resultado_final,',
'       c.cancelado,',
unistr('       decode(nvl(c.cancelado,''N''),''N'',''N\00E3o'',''S'',''Sim'') desc_cancelado,'),
'       c.id_copia',
'  from cg_contratos_avaliado c, cg_ciclos l, cg_dimensoes d',
' where c.cod_empresa = l.cod_empresa (+)',
'   and c.cod_ciclo = l.cod_ciclo (+)',
'   and c.cod_dimensao = d.cod_dimensao',
'   and c.cod_empresa = :p106_cod_empresa',
'   and c.cod_contrato = :p106_cod_contrato;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p106_emp_colab := v_c1.cod_empresa;',
':p106_mat_colab := v_c1.matricula_avaliado;',
':p106_fil_colab  := v_c1.cod_filial_avaliado;',
':p106_cc_colab  := v_c1.cod_ccusto_avaliado;',
':p106_cod_cargo_colab := v_c1.cod_cargo_avaliado;',
'',
':p106_emp_aval := v_c1.cod_emp_avaliador;',
':p106_mat_aval := v_c1.matricula_avaliador;',
':p106_cc_aval  := v_c1.cod_ccusto_avaliador;',
':p106_fil_aval  := v_c1.cod_filial_avaliador;',
'',
':p106_empresa_colab := v_c1.empresa_colab;',
':p106_matricula_colab := v_c1.matricula_colab;',
':p106_cod_filial_colab := v_c1.filial_colab;',
':p106_cod_ccusto_colab := v_c1.ccusto_colab;',
':p106_cargo_colab := v_c1.cargo_colab;',
'-------------------------------------------------',
':p106_empresa_aval := v_c1.empresa_aval;',
':p106_matricula_aval := v_c1.matricula_aval;',
':p106_cod_filial_aval := v_c1.filial_aval;',
':p106_cod_ccusto_aval := v_c1.ccusto_aval;',
'-------------------------------------------------',
'--:p106_cod_contrato := v_c1.cod_contrato;',
'--:p106_contrato := v_c1.cod_contrato;',
':p106_cod_ciclo := v_c1.cod_ciclo;',
':p106_ciclo := v_c1.ciclo;',
':p106_cod_dimensao := v_c1.cod_dimensao;',
':p106_dimensao := v_c1.dimensao;',
':p106_status_contrato := v_c1.status_contrato;',
':p106_desc_status_contrato := v_c1.desc_status_contrato;',
':p106_resultado_final := v_c1.resultado_final;',
':p106_cancelado := v_c1.cancelado;',
':p106_desc_cancelado := v_c1.desc_cancelado;',
':p106_id_copia := v_c1.id_copia;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405090681798601512)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Diretoria'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'	  --',
'	  SELECT AUX.COD||'' - ''||initcap(AUX.NOME) diretoria',
'	  INTO   :P106_DIRETORIA',
'	  FROM  (SELECT CC.COD, CC.NOME',
'					 FROM CENTRO_DE_CUSTO CC',
'		       WHERE CC.COD_EMPRESA = :P_EMPRESA_USER',
'		       AND CC.CD_NIVEL_SUPERIOR = 2',
'		       CONNECT BY PRIOR CC.COD_CCUSTO_SUPERIOR = CC.COD',
'		       START WITH CC.COD  = :P106_CC_COLAB',
'		       AND CC.COD_EMPRESA = :P106_EMP_COLAB',
'					 UNION',
'					 SELECT CC.COD, CC.NOME',
'					 FROM   CENTRO_DE_CUSTO CC',
'					 WHERE  CC.CD_NIVEL_SUPERIOR < 2',
'					 AND    CC.COD         = :P106_CC_COLAB',
'					 AND    CC.COD_EMPRESA = :P106_EMP_COLAB) AUX;',
'		--',
'EXCEPTION',
'	WHEN OTHERS THEN',
'	--  AVISO(''Erro ao buscar a diretoria. ''||sqlerrm);',
'	  :P106_DIRETORIA := NULL;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405504296584290141)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Hab/Desab Bot\00F5es')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_btn_save varchar2(1);',
'v_btn_delete varchar2(1);',
'v_btn_feedback varchar2(1);',
'',
'begin',
'',
'pkg_cg_contratos.hab_des_cg_cont_aval_colab(:p106_cod_empresa,',
'                                               :p106_cod_contrato,',
'                                               :p106_cancelado,',
'                                               :p106_status_contrato,',
'                                               :p106_mat_colab,',
'                                               :p106_cod_ciclo,',
'                                               :p_usuario,',
'                                               :p106_alterado,',
'                                               :p106_btn_concluir,',
'                                               :p106_btn_revisar);',
'',
'pkg_cg_contratos.hab_des_cg_contratos_colab (:p106_cod_empresa,',
'                                       :p106_cod_contrato,',
'                                       :p106_cancelado,',
'                                       :p106_status_contrato,',
'                                       :p106_cod_ciclo,',
'                                       :p106_mat_colab,',
'                                       :p_usuario,',
'                                       :p106_vld_valor_atingido,',
'                                       :p106_btn_adicionar_meta,',
'                                       v_btn_save,',
'                                       v_btn_delete,',
'                                       v_btn_feedback);',
'                                       ',
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
