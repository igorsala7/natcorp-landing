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
,p_default_application_id=>9506
,p_default_id_offset=>697304003230140772
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9506 - Frequência - Relatórios
--
-- Application Export:
--   Application:     9506
--   Name:            Frequência - Relatórios
--   Date and Time:   21:27 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 45
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00045
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>45);
end;
/
prompt --application/pages/page_00045
begin
wwv_flow_api.create_page(
 p_id=>45
,p_user_interface_id=>wwv_flow_api.id(64098418965502502724)
,p_name=>unistr('Relat\00F3rio de Espelho de Ponto')
,p_step_title=>unistr('Relat\00F3rio de Espelho de Ponto')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var lSpinner$;'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'SUPORTE_NATCORP'
,p_last_upd_yyyymmddhh24miss=>'20260819170744'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9221917627128015076)
,p_plug_name=>'Assinatura'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9221917801566015078)
,p_plug_name=>'Assinatura'
,p_region_name=>'regiaoassinatura'
,p_parent_plug_id=>wwv_flow_api.id(9221917627128015076)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64098392448623502628)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa,',
'       matricula,',
'       nvl(nome_social,nome) nome,',
'       cpf,',
'       to_char(dt_assinatura,''dd/mm/rrrr hh24:mi:ss'') dt_assinatura,',
'       origem_assinatura',
'  from pe_espelho_ponto_assinado',
'where cod_empresa =   :p45_cod_empresa',
'AND MATRICULA =  :p45_matricula_ini',
'and DATA_INI_REF_PONTO >= :p45_data_ini',
'and DATA_FIM_REF_PONTO <= :p45_data_fim',
'AND :P45_EXIBE = ''S''',
'and :P45_MATRICULA_INI = :P45_MATRICULA_FIM',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA,P45_MATRICULA_INI,P45_MATRICULA_FIM,P45_EXIBE,P45_DATA_INI,P45_DATA_FIM'
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
 p_id=>wwv_flow_api.id(9221918062788015080)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'BRUNO.SOUSA'
,p_internal_uid=>1397578171257380033
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918159020015081)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918194620015082)
,p_db_column_name=>'MATRICULA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918632322015086)
,p_db_column_name=>'NOME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918732746015087)
,p_db_column_name=>'CPF'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Cpf'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918862636015088)
,p_db_column_name=>'DT_ASSINATURA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Dt Assinatura'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9221918980937015089)
,p_db_column_name=>'ORIGEM_ASSINATURA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Origem Assinatura'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(9236080303878987587)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'14117405'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:MATRICULA:NOME:CPF:DT_ASSINATURA:ORIGEM_ASSINATURA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9234019851695716572)
,p_plug_name=>'Espelho de Ponto'
,p_region_name=>'ESPELHOPONTO'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9233979587395313948)
,p_plug_name=>'Espelho de Ponto'
,p_region_name=>'regiaolist'
,p_parent_plug_id=>wwv_flow_api.id(9234019851695716572)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64098392448623502628)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DATA_PONTO, DIA_SEMANA, COD_JORNADA, CF_BATIDAS, ',
'       CF_COL01, CF_COL02, CF_COL03, CF_COL04, CF_COL05, ',
'       CF_COL06, CF_COL07, CF_COL08, CF_COL09, CF_COL10, ',
'       CF_COL11, CF_COL12, CF_COL13, CF_COL14, CF_COL15,',
'       CF_JUST',
'from pkg_espelho_ponto.Gera(p_imp => :p45_seq,',
'                                   p_emp => :P45_cod_empresa,',
'                                   p_mat_ini => :P45_MATRICULA_INI,',
'                                   p_mat_fin => :P45_MATRICULA_FIM,',
'                                   p_filial_ini => null,',
'                                   p_filial_fim => null,',
'                                   p_ccusto_ini => null,',
'                                   p_ccusto_fim => null,',
'                                   p_cod_un_negocio_ini => null,',
'                                   p_cod_un_negocio_fim => null,',
'                                   p_grupo_trab_ini => null,',
'                                   p_grupo_trab_fim => null,',
'                                   p_localizacao_ini => null,',
'                                   p_localizacao_fim => null,',
'                                   p_tipo => ''N'',',
'                                   p_data_ini => :P45_data_ini,',
'                                   p_data_fim => :P45_data_fim,',
'                                   p_situacao => nvl(:p45_situacao,''T''),',
'                                   p_usuario => :P_USUARIO,',
'                                   p_painel => :P_PAINEL,',
'                                   p_marca_ponto => :P45_MARCA_PONTO,',
'                                   p_saldo_bh => :P45_SALDO_BH)',
'where :P45_EXIBE = ''S''',
'and :P45_MATRICULA_INI = :P45_MATRICULA_FIM',
'and :P45_MATRICULA_INI is not null',
'and :P45_MATRICULA_FIM is not null',
'order by to_date(data_ponto,''dd/mm/rrrr''), hora_batida_1',
'                                   '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P45_DATA_INI,P45_DATA_FIM,P45_COD_EMPRESA,P45_MATRICULA_INI,P45_MATRICULA_FIM'
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
 p_id=>wwv_flow_api.id(9233979752048313950)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'BRUNO.SOUSA'
,p_internal_uid=>1409639860517678903
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233981158316313964)
,p_db_column_name=>'DATA_PONTO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Data Ponto'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233981216626313965)
,p_db_column_name=>'DIA_SEMANA'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Dia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233983359495313986)
,p_db_column_name=>'COD_JORNADA'
,p_display_order=>360
,p_column_identifier=>'AJ'
,p_column_label=>'Jornada'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233987815759324581)
,p_db_column_name=>'CF_BATIDAS'
,p_display_order=>810
,p_column_identifier=>'CC'
,p_column_label=>'Jornada Realizada'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233988590883324588)
,p_db_column_name=>'CF_COL01'
,p_display_order=>820
,p_column_identifier=>'CJ'
,p_column_label=>'H Prev'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233988650348324589)
,p_db_column_name=>'CF_COL02'
,p_display_order=>830
,p_column_identifier=>'CK'
,p_column_label=>'H Trab'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233988735653324590)
,p_db_column_name=>'CF_COL03'
,p_display_order=>840
,p_column_identifier=>'CL'
,p_column_label=>'Atr Comp'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233988832503324591)
,p_db_column_name=>'CF_COL04'
,p_display_order=>850
,p_column_identifier=>'CM'
,p_column_label=>'Atr / S antec'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233988915574324592)
,p_db_column_name=>'CF_COL05'
,p_display_order=>860
,p_column_identifier=>'CN'
,p_column_label=>'BH +'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233989061921324593)
,p_db_column_name=>'CF_COL06'
,p_display_order=>870
,p_column_identifier=>'CO'
,p_column_label=>'BH -'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233989095593324594)
,p_db_column_name=>'CF_COL07'
,p_display_order=>880
,p_column_identifier=>'CP'
,p_column_label=>'Falta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233989260087324595)
,p_db_column_name=>'CF_COL08'
,p_display_order=>890
,p_column_identifier=>'CQ'
,p_column_label=>'DSR'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233989356347324596)
,p_db_column_name=>'CF_COL09'
,p_display_order=>900
,p_column_identifier=>'CR'
,p_column_label=>'DSR Fer'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9233989402045324597)
,p_db_column_name=>'CF_COL10'
,p_display_order=>910
,p_column_identifier=>'CS'
,p_column_label=>'Dif Pos'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234017426497716548)
,p_db_column_name=>'CF_COL11'
,p_display_order=>920
,p_column_identifier=>'CT'
,p_column_label=>'Dif Neg'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234017495396716549)
,p_db_column_name=>'CF_COL12'
,p_display_order=>930
,p_column_identifier=>'CU'
,p_column_label=>'???'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234017608276716550)
,p_db_column_name=>'CF_COL13'
,p_display_order=>940
,p_column_identifier=>'CV'
,p_column_label=>'De/S >1h'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234017732117716551)
,p_db_column_name=>'CF_COL14'
,p_display_order=>950
,p_column_identifier=>'CW'
,p_column_label=>'BH R(+)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234017914955716553)
,p_db_column_name=>'CF_COL15'
,p_display_order=>960
,p_column_identifier=>'CX'
,p_column_label=>'BH R(-)'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2122187576991098607)
,p_db_column_name=>'CF_JUST'
,p_display_order=>970
,p_column_identifier=>'CY'
,p_column_label=>'Justificativa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(2170445973679434137)
,p_application_user=>'APXWS_ALTERNATIVE'
,p_name=>unistr('Confer\00EAncia do Espelho de Ponto')
,p_report_seq=>10
,p_report_alias=>'14731420'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_PONTO:DIA_SEMANA:COD_JORNADA:CF_BATIDAS:CF_COL01:CF_COL02:CF_COL03:CF_COL04:CF_COL05:CF_COL06:CF_COL07:CF_COL08:CF_COL09:CF_COL10:CF_COL11:CF_COL12:CF_COL13:CF_COL14:CF_COL15:CF_JUST'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(2170449127233457287)
,p_report_id=>wwv_flow_api.id(2170445973679434137)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'CF_BATIDAS'
,p_operator=>'contains'
,p_expr=>'FOLGA'
,p_condition_sql=>' (case when (upper("CF_BATIDAS") like ''%''||upper(#APXWS_EXPR#)||''%'') then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME# ''FOLGA''  '
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_font_color=>'#3BAA2C'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(2170449553383457287)
,p_report_id=>wwv_flow_api.id(2170445973679434137)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'CF_COL10'
,p_operator=>'is not null'
,p_condition_sql=>' (case when ("CF_COL10" is not null) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME#'
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_font_color=>'#0076DF'
);
wwv_flow_api.create_worksheet_condition(
 p_id=>wwv_flow_api.id(2170449935098457287)
,p_report_id=>wwv_flow_api.id(2170445973679434137)
,p_condition_type=>'HIGHLIGHT'
,p_allow_delete=>'Y'
,p_column_name=>'CF_COL11'
,p_operator=>'is not null'
,p_condition_sql=>' (case when ("CF_COL11" is not null) then #APXWS_HL_ID# end) '
,p_condition_display=>'#APXWS_COL_NAME# #APXWS_OP_NAME#'
,p_enabled=>'Y'
,p_highlight_sequence=>10
,p_row_font_color=>'#F44336'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(9234016039720327649)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'14096762'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_PONTO:DIA_SEMANA:COD_JORNADA:CF_BATIDAS:CF_COL01:CF_COL02:CF_COL03:CF_COL04:CF_COL05:CF_COL06:CF_COL07:CF_COL08:CF_COL09:CF_COL10:CF_COL11:CF_COL12:CF_COL13:CF_COL14:CF_COL15:CF_JUST'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9234020393812716578)
,p_plug_name=>'Totais'
,p_parent_plug_id=>wwv_flow_api.id(9234019851695716572)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9234020708743716581)
,p_plug_name=>'Horas Previstas'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9234021227454716586)
,p_plug_name=>'Eventos'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9234021321255716587)
,p_plug_name=>'Evento'
,p_region_name=>'regiaoevento'
,p_parent_plug_id=>wwv_flow_api.id(9234021227454716586)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64098392448623502628)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa, matricula, cod_evento, descricao, soma',
'from pkg_espelho_ponto.fnc_eventos(p_imp => :p45_seq,',
'                                   p_emp => :P45_cod_empresa,',
'                                   p_mat_ini => :P45_MATRICULA_INI,',
'                                   p_mat_fin => :P45_MATRICULA_FIM,',
'                                   p_filial_ini => null,',
'                                   p_filial_fim => null,',
'                                   p_ccusto_ini => null,',
'                                   p_ccusto_fim => null,',
'                                   p_cod_un_negocio_ini => null,',
'                                   p_cod_un_negocio_fim => null,',
'                                   p_grupo_trab_ini => null,',
'                                   p_grupo_trab_fim => null,',
'                                   p_localizacao_ini => null,',
'                                   p_localizacao_fim => null,',
'                                   p_tipo => ''N'',',
'                                   p_data_ini => :P45_data_ini,',
'                                   p_data_fim => :P45_data_fim,',
'                                   p_situacao => nvl(:p45_situacao,''T''),',
'                                   p_usuario => :P_USUARIO,',
'                                   p_painel => :P_PAINEL,',
'                                   p_marca_ponto => :P45_MARCA_PONTO)',
'where :P45_EXIBE = ''S''',
'and :P45_MATRICULA_INI = :P45_MATRICULA_FIM',
'and :P45_MATRICULA_INI is not null',
'and :P45_MATRICULA_FIM is not null',
'order by 3, 4;'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA,P45_MATRICULA_INI,P45_MATRICULA_FIM,P45_EXIBE,P45_DT_EVENTO_INI,P45_DT_EVENTO_FIM'
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
 p_id=>wwv_flow_api.id(9234021409197716588)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'BRUNO.SOUSA'
,p_internal_uid=>1409681517667081541
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234021515443716589)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234021665842716590)
,p_db_column_name=>'MATRICULA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234021711955716591)
,p_db_column_name=>'COD_EVENTO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Evento'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234021884461716592)
,p_db_column_name=>'DESCRICAO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>unistr('Descri\00E7\00E3o Evento')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(9234021962448716593)
,p_db_column_name=>'SOMA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Total'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(9234518677024437799)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'14101788'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:MATRICULA:COD_EVENTO:DESCRICAO:SOMA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26135233018765995970)
,p_plug_name=>'Assinatura'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(57454318400993449741)
,p_plug_name=>unistr('Relat\00F3rio de Espelho de Ponto')
,p_icon_css_classes=>'fa-file-search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64098391393576502627)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(72453755394712741610)
,p_plug_name=>unistr('Par\00E2metros')
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(64098392968664502630)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(72455203515655172614)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(64098389255374502625)
,p_plug_display_sequence=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P45_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(26155046118772875823)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_button_name=>'ASSINAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'t-Button--large:t-Button--success:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(64098413760262502674)
,p_button_image_alt=>'Assinar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(25479554893255881809)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_button_name=>'P45_PREVIEW'
,p_button_static_id=>'P45_PREVIEW'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(64098413933982502674)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Pr\00E9via do Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_retorno      varchar2(1) := ''N'';',
'begin',
'    if :P_PAINEL = ''PO'' then',
'        return false;',
'    elsif :P_PAINEL = ''PC'' then',
'        v_retorno := PKG_TERMOS.fnct_botao_preview (p_cod_empresa => :P45_EMP',
'                                                   ,p_matricula   => :P45_MAT',
'                                                   ,p_data_ini    => :P45_DATA_INI',
'                                                   ,p_data_fim    => :P45_DATA_fim);',
'    end if;',
'    --',
'    if v_retorno = ''S'' then',
'        return true;',
'    else',
'        return false;',
'    end if;    ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-clipboard-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(9234018099843716555)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_button_name=>'P45_LIST_ESPELHO'
,p_button_static_id=>'P45_LIST_ESPELHO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(64098413933982502674)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Listar Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-list-ul'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(48784388210673040469)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_button_name=>'P45_REL_ESPELHO'
,p_button_static_id=>'P45_REL_ESPELHO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(64098413933982502674)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Gerar Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-pdf-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(26155046335015875826)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_button_name=>'P45_REL_ESPELHO_ASSINATURA'
,p_button_static_id=>'P45_REL_ESPELHO_V2'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(64098413933982502674)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Gerar Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-file-pdf-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(9221917927380015079)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(9221917627128015076)
,p_button_name=>'ATUALIZA_ASSINATURA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(64098413644191502671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Assinatura'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(9234019903060716573)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(9234019851695716572)
,p_button_name=>'ATUALIZA_ESPELHO_PONTO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(64098413644191502671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Espelho Ponto'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(9234022201629716596)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(9234021227454716586)
,p_button_name=>'ATUALIZA_EVENTO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(64098413644191502671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Evento'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(48784398894160040481)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_button_name=>'p45_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(64098413644191502671)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P45_EMP.,&P45_MAT.,&P45_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(48784411542637040498)
,p_branch_name=>'Chama Report'
,p_branch_action=>'f?p=&APP_ID.:897:&SESSION.::&DEBUG.:RP,45:P897_PARAMETROS,P897_REPORT:&P45_PARAMETROS.,&P45_REPORT.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(48784388210673040469)
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'P45_REL_ESPELHO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9221917419950015074)
,p_name=>'P45_DT_EVENTO_INI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(9234021227454716586)
,p_prompt=>'Data Inicial'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	SELECT DATA_FIM_REF_PONTO',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel = ''PO''',
'	union',
'	SELECT nvl(dt_fim_ponto_gestor, DATA_FIM_REF_PONTO)',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel <> ''PO'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9221917532015015075)
,p_name=>'P45_DT_EVENTO_FIM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(9234021227454716586)
,p_prompt=>'Data Final'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	SELECT DATA_FIM_REF_PONTO',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel = ''PO''',
'	union',
'	SELECT nvl(dt_fim_ponto_gestor, DATA_FIM_REF_PONTO)',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel <> ''PO'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234018038617716554)
,p_name=>'P45_EXIBE'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234018509660716559)
,p_name=>'P45_MENSAGEM2'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234020280383716576)
,p_name=>'P45_SALDO_BH_REMANESCENTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(9234020393812716578)
,p_prompt=>'Saldo BH Remanescente'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234020823940716582)
,p_name=>'P45_HORAS_PREVISTAS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(9234020708743716581)
,p_prompt=>'Horas Previstas'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234020902684716583)
,p_name=>'P45_SALDO_BH_ANTERIOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(9234020393812716578)
,p_prompt=>'Saldo BH Anterior:'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234021080203716584)
,p_name=>'P45_SALDO_BH_PERIODO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(9234020393812716578)
,p_prompt=>unistr('Saldo BH do Per\00EDodo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9234021163973716585)
,p_name=>'P45_SALDO_ATUAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(9234020393812716578)
,p_prompt=>'Saldo Atual'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155048820144875850)
,p_name=>'P45_TITULO_TERMO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155048975383875852)
,p_name=>'P45_NOME_TERMO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155049125312875853)
,p_name=>'P45_TEXTO_TERMO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155049203120875854)
,p_name=>'P45_TEXTO_ACEITE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155049317813875855)
,p_name=>'P45_PROSSEGUIR_SEM_ACEITE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155049377062875856)
,p_name=>'P45_OPCAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(26135233018765995970)
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:&P45_TEXTO_ACEITE.;S'
,p_display_when=>'P45_PROSSEGUIR_SEM_ACEITE'
,p_display_when2=>'S'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155193828513189950)
,p_name=>'P45_CONTROLE_ASSINATURA'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155194738148189960)
,p_name=>'P45_MOSTRA_REGIAO'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26155195667284189969)
,p_name=>'P45_MOSTRA_NAO_ASSINADO'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28624568164418641479)
,p_name=>'P45_MARCA_PONTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_item_default=>'S'
,p_prompt=>'Marca Ponto'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N,Todos;T')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28641738615469879656)
,p_name=>'P45_COD_UN_NEGOCIO_INI'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Un. Neg\00F3cio Inicial')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod_un_negocio||'' - ''||initcap(nome_un_negocio) un_negocio, cod_un_negocio ',
'  from unidade_de_negocio',
' where cod_empresa = :p45_cod_empresa',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28641738742571879657)
,p_name=>'P45_COD_UN_NEGOCIO_FIM'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Un. Neg\00F3cio Final')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod_un_negocio||'' - ''||initcap(nome_un_negocio) un_negocio, cod_un_negocio ',
'  from unidade_de_negocio',
' where cod_empresa = :p45_cod_empresa',
' order by 2 DESC'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29743705824435893580)
,p_name=>'P45_ONCLICK'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30712248065847004492)
,p_name=>'P45_TIPO_RELATORIO'
,p_is_required=>true
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Tipo Relat\00F3rio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_tipo_relatorio  PE_TIPO_ESPELHO_PERFIL.CD_TIPO_ESPELHO%TYPE;',
'  v_desc            PE_TIPO_ESPELHO_PONTO.DESCRICAO%TYPE;',
'  v_retorno         varchar2(4000);',
'  vc_arr2           APEX_APPLICATION_GLOBAL.vc_arr2;',
'  v_conta           number := 0; ',
'  v_contador        number := 0; ',
'  v_valida          number := 0; ',
'',
'  v_erro         varchar2(4000);',
'',
'begin',
'  v_retorno := ''SELECT ''''ERRO'''', -1 from dual'';',
'  begin',
'      select CD_TIPO_ESPELHO into v_tipo_relatorio from PE_TIPO_ESPELHO_PERFIL where CD_perfiL = :P_PERFIL;',
'  exception',
'       when others then',
'           v_valida := 1;',
'  end;',
'',
'  if v_valida = 1 then',
'  ',
'           FOR C IN (SELECT COD, DESCRICAO FROM PE_TIPO_ESPELHO_PONTO)',
'              LOOP',
'              v_contador := v_contador + 1;',
'              if v_contador = 1 then',
'                v_retorno := ''SELECT ''''''|| C.COD ||'' - '' || C.DESCRICAO || '''''' d, ''''''||C.COD|| '''''' c FROM DUAL'';              ',
'              else  ',
'                    v_retorno := v_retorno || '' UNION SELECT ''''''|| C.COD ||'' - '' || C.DESCRICAO || '''''' d, ''''''||C.COD|| '''''' c FROM DUAL'';              ',
'              end if;',
'          END LOOP;',
'  else',
'        v_contador := 0; ',
'        vc_arr2 := APEX_UTIL.STRING_TO_TABLE(v_tipo_relatorio, '':'');',
'        FOR I IN 1..vc_arr2.COUNT',
'        LOOP',
'            v_contador := v_contador + 1;',
'            begin',
'                select DESCRICAO into v_desc from PE_TIPO_ESPELHO_PONTO where cod = vc_arr2(I);',
'            exception',
'                when others then',
'                    v_desc := null;',
'            end;',
'            if v_contador = 1 then   ',
'                v_retorno := ''SELECT ''''''|| vc_arr2(I) ||'' - '' || v_desc || '''''' d, ''''''||vc_arr2(I)|| '''''' c FROM DUAL'';',
'            else',
'                v_retorno := v_retorno || '' UNION SELECT ''''''|| vc_arr2(I) ||'' - '' || v_desc || '''''' d, ''''''||vc_arr2(I)|| '''''' c FROM DUAL '';',
'            end if;',
'        END LOOP;',
'  end if;',
'  commit;',
'  v_retorno := v_retorno || '' ORDER BY 2'';',
'',
'  RETURN v_retorno;',
'end;',
''))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784388605993040470)
,p_name=>'P45_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) empresa, cod',
'  from empresas',
' where ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784389000008040470)
,p_name=>'P45_FILIAL_INI'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'Filial Inicial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||nome_filial filial, cod_filial',
'  from filiais',
' where ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'   and cod_empresa  = :P45_cod_empresa',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784389373400040470)
,p_name=>'P45_FILIAL_FIM'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'Filial Final'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||nome_filial filial, cod_filial',
'  from filiais',
' where ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'   and cod_empresa  = :P45_cod_empresa',
' order by 2 desc'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784389768325040471)
,p_name=>'P45_COD_CCUSTO_INI'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'C.Custo Inicial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) ccusto, cod cod_ccusto',
'  from centro_de_custo c, filial_ccusto f',
' where c.cod_empresa = f.cod_empresa',
'    and c.cod = f.cod_ccusto',
'   -- and ((:P_PAINEL = ''PO'') or (sysdate between c.dt_inic_vige and nvl(c.dt_fim_vige, sysdate)))',
'    and F_Acesso_cc(c.cod_empresa, c.cod) = ''S''',
'    and f.cod_empresa = :p45_cod_empresa',
'    and (:p45_filial_ini is null or f.cod_filial between :p45_filial_ini and :p45_filial_fim)',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784390234735040471)
,p_name=>'P45_COD_CCUSTO_FIM'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'C.Custo Final'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) ccusto, cod cod_ccusto',
'  from centro_de_custo c, filial_ccusto f',
' where c.cod_empresa = f.cod_empresa',
'    and c.cod = f.cod_ccusto',
'   -- and ((:P_PAINEL = ''PO'') or (sysdate between c.dt_inic_vige and nvl(c.dt_fim_vige, sysdate)))',
'    and F_Acesso_cc(c.cod_empresa, c.cod) = ''S''',
'    and f.cod_empresa = :p45_cod_empresa',
'    and (:p45_filial_ini is null or f.cod_filial between :p45_filial_ini and :p45_filial_fim)',
' order by 2 desc'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784390567354040471)
,p_name=>'P45_COD_LOCALIZACAO_INI'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('C\00F3d. Localiza\00E7\00E3o Inicial')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_local_trab||'' - ''||initcap(descricao) descricao, cod_local_trab',
'  from local_trab l',
' where exists (select 1 ',
'                 from filial_local f',
'                where f.cod_empresa = :p45_cod_empresa',
'                  and f.cod_local_filial = l.cod_local_trab',
'                  and (:p45_filial_fim is null or f.cod_filial between :p45_filial_ini and :p45_filial_fim)',
'                  and F_Acesso_Fil(f.cod_empresa, f.cod_filial) = ''S'') ',
' order by to_number(REPLACE(cod_local_trab,''X'',9000))',
' '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784391037666040472)
,p_name=>'P45_COD_LOCALIZACAO_FIM'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('C\00F3d. Localiza\00E7\00E3o Final')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_local_trab||'' - ''||initcap(descricao) descricao, cod_local_trab',
'  from local_trab l',
' where exists (select 1 ',
'                 from filial_local f',
'                where f.cod_empresa = :p45_cod_empresa',
'                  and f.cod_local_filial = l.cod_local_trab',
'                  and (:p45_filial_fim is null or f.cod_filial between :p45_filial_ini and :p45_filial_fim)',
'                  and F_Acesso_Fil(f.cod_empresa, f.cod_filial) = ''S'') ',
'    order by to_number(REPLACE(cod_local_trab,''X'',9000)) desc'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784391365715040472)
,p_name=>'P45_COD_GRUPO_TRABALHO_INI'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('C\00F3d. Grupo Trabalho Inicial')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT cod_grupo||'' - ''||Initcap(DESCRICAO) as d, COD_GRUPO as r',
'FROM PE_GRUPOS',
'WHERE PE_GRUPOS.COD_EMPRESA =  nvl(:p45_cod_empresa,cod_empresa)',
'order by cod_grupo asc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784391842412040472)
,p_name=>'P45_COD_GRUPO_TRABALHO_FIM'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('C\00F3d. Grupo Trabalho Final')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT cod_grupo||'' - ''||Initcap(DESCRICAO) as d, COD_GRUPO as r',
'FROM PE_GRUPOS',
'WHERE PE_GRUPOS.COD_EMPRESA =  nvl(:p45_cod_empresa,cod_empresa)',
'order by cod_grupo desc'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784392149006040473)
,p_name=>'P45_MATRICULA_INI'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Matr\00EDcula Inicial')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  SELECT distinct ',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) NOME, ',
'       I.MATRICULA',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       PE_ESCALAS_EXCECOES E',
' WHERE i.cod_empresa = e.cod_empresa',
'   and i.matricula = e.matricula',
'  -- and e.cod_escala = Fnct_Pe_Retorna_Escala(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr'') )',
'  -- and e.cod_jornada = Fnct_Pe_Retorna_Jornada(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr''))',
'   and i.marca_Ponto = ''S''',
'   AND f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :P_PAINEL, ''PONTO'') = ''S''',
'   and i.cod_empresa = :p45_cod_empresa',
'   and ((i.filial between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'   and ((i.cod_ccusto between :p45_cod_ccusto_ini and :p45_cod_ccusto_fim) or (:p45_cod_ccusto_ini is null))',
'   and (replace(i.cod_localizacao,''X'',9000) BETWEEN replace(:p45_cod_localizacao_ini,''X'',9000)  and replace(:p45_cod_localizacao_fim,''X'',9000)  or (:p45_cod_localizacao_ini is null))',
'    ',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'',
'',
'  order by i.matricula'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_CCUSTO_INI.P45_CCUSTO_FIM,P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_CCUSTO_INI.P45_CCUSTO_FIM,P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>6
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784392581457040473)
,p_name=>'P45_MATRICULA_FIM'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Matr\00EDcula Final')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) NOME, ',
'       I.MATRICULA',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       PE_ESCALAS_EXCECOES E',
' WHERE i.cod_empresa = e.cod_empresa',
'   and i.matricula = e.matricula',
'  -- and e.cod_escala = Fnct_Pe_Retorna_Escala(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr'') )',
'  -- and e.cod_jornada = Fnct_Pe_Retorna_Jornada(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr''))',
'   and i.marca_Ponto = ''S''',
'   AND f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :P_PAINEL, ''PONTO'') = ''S''',
'   and i.cod_empresa = :p45_cod_empresa',
'   and ((i.filial between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'   and ((i.cod_ccusto between :p45_cod_ccusto_ini and :p45_cod_ccusto_fim) or (:p45_cod_ccusto_ini is null))',
'   and (replace(i.cod_localizacao,''X'',9000) BETWEEN replace(:p45_cod_localizacao_ini,''X'',9000)  and replace(:p45_cod_localizacao_fim,''X'',9000)  or (:p45_cod_localizacao_ini is null))',
'   ',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'',
'',
'  order by i.matricula desc'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_CCUSTO_INI.P45_CCUSTO_FIM,P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM'
,p_ajax_items_to_submit=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_CCUSTO_INI.P45_CCUSTO_FIM,P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>6
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784392976035040474)
,p_name=>'P45_BANCO_HORAS'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Op\00E7\00E3o')
,p_source=>'S'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Exibir Banco de Horas;S'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784393443400040474)
,p_name=>'P45_DATA_INI'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'Data Inicial'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	SELECT DATA_INI_REF_PONTO',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel = ''PO''',
'	union',
'	SELECT nvl(dt_ini_ponto_gestor, DATA_INI_REF_PONTO)',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel <> ''PO'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784393833449040475)
,p_name=>'P45_MAO_OBRA'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('M\00E3o de Obra')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Direto;D,Indireto;I,Todos;T'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784394551778040476)
,p_name=>'P45_SALDO_BH'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>unistr('Op\00E7\00E3o')
,p_source=>'S'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Exibir Saldo de Banco de Horas;S'
,p_colspan=>3
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784395000158040477)
,p_name=>'P45_DATA_FIM'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_prompt=>'Data Final'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	SELECT DATA_FIM_REF_PONTO',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel = ''PO''',
'	union',
'	SELECT nvl(dt_fim_ponto_gestor, DATA_FIM_REF_PONTO)',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = nvl(:P45_EMPRESAS,cod_empresa)',
'	   AND :p_Painel <> ''PO'''))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413501923502668)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784395370985040477)
,p_name=>'P45_SITUACAO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_item_default=>'A'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Todos;T,Ativos;A,Demitidos;D'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P45_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784395799198040478)
,p_name=>'P45_MENSAGEM'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784396150171040478)
,p_name=>'P45_OK'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784396634871040478)
,p_name=>'P45_PARAMETROS'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784396994437040479)
,p_name=>'P45_REPORT'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784397368093040479)
,p_name=>'P45_SEQ'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784397814059040480)
,p_name=>'P45_ENDERECO_REL'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784398221246040480)
,p_name=>'P45_ORDENACAO'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(72453755394712741610)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784399307292040482)
,p_name=>'P45_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'height="100" width="80"'
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>'select foto from fotos where cod_empresa = :p45_emp and matricula = :p45_mat'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784399658905040482)
,p_name=>'P45_COD_EMPRESA_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_column=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784400067797040483)
,p_name=>'P45_MATRICULA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_column=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784400529241040483)
,p_name=>'P45_SITUACAO_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_column=>8
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784400862757040484)
,p_name=>'P45_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_column=>11
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(64098413319658502667)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784401249368040484)
,p_name=>'P45_EMP'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48784401648600040485)
,p_name=>'P45_MAT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(72455203515655172614)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48784403895923040488)
,p_name=>'Popular Campos'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_COD_EMPRESA'
,p_condition_element=>'P45_COD_EMPRESA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P45_MAT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784404389461040489)
,p_event_id=>wwv_flow_api.id(48784403895923040488)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    begin',
'',
'    select min(cod_filial)',
'      into :p45_filial_ini',
'  from filiais',
' where (cod_empresa, cod_filial) in ( select distinct x.cd_empresa, x.cd_filial ',
'                                       from usuario_oracle_filiais x, ',
'                                            filial_ccusto z, ',
'                                            centro_de_custo g',
'                                      where x.cd_empresa = z.cod_empresa',
'                                        and x.cd_empresa = g.cod_empresa',
'                                        and x.cd_filial  = z.cod_filial',
'                                        and z.cod_ccusto = g.cod',
'                                        and ((z.cod_empresa  in (:p45_cod_empresa)) or (:p45_cod_empresa is null))',
'                                        and g.matricula_gestor = :P_MATRICULA_USER',
'                                        and (x.cd_empresa, x.cd_filial) in (select i.cod_empresa, i.filial from informacoes_funcionais i));',
'',
'    exception',
'    when no_Data_found then',
'    null;',
'    ',
'    end;',
'    begin',
'    select max(cod_filial)',
'      into :p45_filial_fim',
'  from filiais',
' where (cod_empresa, cod_filial) in ( select distinct x.cd_empresa, x.cd_filial ',
'                                       from usuario_oracle_filiais x, ',
'                                            filial_ccusto z, ',
'                                            centro_de_custo g',
'                                      where x.cd_empresa = z.cod_empresa',
'                                        and x.cd_empresa = g.cod_empresa',
'                                        and x.cd_filial  = z.cod_filial',
'                                        and z.cod_ccusto = g.cod',
'                                        and ((z.cod_empresa  in (:p45_cod_empresa)) or (:p45_cod_empresa is null))',
'                                        and g.matricula_gestor = :P_MATRICULA_USER',
'                                        and (x.cd_empresa, x.cd_filial) in (select i.cod_empresa, i.filial from informacoes_funcionais i));',
'',
'    exception',
'    when no_Data_found then',
'    null;',
'    ',
'    end;',
'end;'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P_USUARIO'
,p_attribute_03=>'P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM,P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM,P45_COD_GRUPO_TRABALHO_INI,P45_COD_GRUPO_TRABALHO_FIM,P45_MATRICULA_INI,P45_MATRICULA_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784404846459040491)
,p_event_id=>wwv_flow_api.id(48784403895923040488)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'     select min(cod)',
'      into :p45_cod_ccusto_ini',
'  from centro_de_custo',
' where (cod_empresa, cod) in ( select distinct g.cod_empresa, g.cod ',
'                                 from centro_de_custo g, filial_ccusto f',
'                                where g.cod_empresa = f.cod_empresa',
'                                  and g.cod = F.COD_CCUSTO',
'                                  and ((f.cod_empresa  in (:p45_cod_empresa))  or (:p45_cod_empresa is null))',
'                                  and ((f.cod_filial   between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'                                  and g.matricula_gestor = :P_MATRICULA_USER',
'                                  and (g.cod_empresa, g.cod) in (select i.cod_empresa, i.cod_ccusto from informacoes_funcionais i)',
'                             );',
' ',
' ',
'     select max(cod)',
'      into :p45_cod_ccusto_fim',
'  from centro_de_custo',
' where (cod_empresa, cod) in ( select distinct g.cod_empresa, g.cod ',
'                                 from centro_de_custo g, filial_ccusto f',
'                                where g.cod_empresa = f.cod_empresa',
'                                  and g.cod = F.COD_CCUSTO',
'                                  and ((f.cod_empresa  in (:p45_cod_empresa))  or (:p45_cod_empresa is null))',
'                                  and ((f.cod_filial   between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'                                  and g.matricula_gestor = :P_MATRICULA_USER',
'                                  and (g.cod_empresa, g.cod) in (select i.cod_empresa, i.cod_ccusto from informacoes_funcionais i)',
'                             );'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P_USUARIO'
,p_attribute_03=>'P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784405348040040491)
,p_event_id=>wwv_flow_api.id(48784403895923040488)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select min(cod_local_trab)',
'      into :p45_cod_localizacao_ini',
'  from local_trab ',
' where cod_Local_trab in (select distinct g.cod_localizacao ',
'                                 from centro_de_custo g, filial_ccusto f',
'                                where g.cod_empresa = f.cod_empresa',
'                                  and g.cod = F.COD_CCUSTO',
'                                  and ((f.cod_empresa  in (:p45_cod_empresa))  or (:p45_cod_empresa is null))',
'                                  and ((f.cod_filial   between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'                                  and ((f.cod_filial   between :p45_ccusto_ini and :p45_ccusto_fim) or (:p45_ccusto_ini is null))',
'                                  and g.matricula_gestor = :P_MATRICULA_USER',
'                                  and (g.cod_empresa, g.cod) in (select i.cod_empresa, i.cod_ccusto from informacoes_funcionais i));',
'                                  ',
'select max(cod_local_trab)',
'      into :p45_cod_localizacao_fim',
'  from local_trab ',
' where cod_Local_trab in (select distinct g.cod_localizacao ',
'                                 from centro_de_custo g, filial_ccusto f',
'                                where g.cod_empresa = f.cod_empresa',
'                                  and g.cod = F.COD_CCUSTO',
'                                  and ((f.cod_empresa  in (:p45_cod_empresa))  or (:p45_cod_empresa is null))',
'                                  and ((f.cod_filial   between :p45_filial_ini and :p45_filial_fim) or (:p45_filial_ini is null))',
'                                  and ((f.cod_filial   between :p45_ccusto_ini and :p45_ccusto_fim) or (:p45_ccusto_ini is null))',
'                                  and g.matricula_gestor = :P_MATRICULA_USER',
'                                  and (g.cod_empresa, g.cod) in (select i.cod_empresa, i.cod_ccusto from informacoes_funcionais i));',
'',
''))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM'
,p_attribute_03=>'P45_COD_LOCALIZACAO_INI,P45_COD_LOCALIZACAO_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784406417597040493)
,p_event_id=>wwv_flow_api.id(48784403895923040488)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select min(cod_grupo)',
'      into :p45_cod_grupo_trabalho_ini',
'FROM PE_GRUPOS',
'WHERE PE_GRUPOS.COD_EMPRESA =  nvl(:p45_cod_empresa,cod_empresa);',
'',
'select max(cod_grupo)',
'      into :p45_cod_grupo_trabalho_fim',
'FROM PE_GRUPOS',
'WHERE PE_GRUPOS.COD_EMPRESA =  nvl(:p45_cod_empresa,cod_empresa);'))
,p_attribute_02=>'P45_COD_EMPRESA'
,p_attribute_03=>'P45_COD_GRUPO_TRABALHO_INI,P45_COD_GRUPO_TRABALHO_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784405854510040492)
,p_event_id=>wwv_flow_api.id(48784403895923040488)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select min(i.matricula)',
'      into :p45_matricula_ini',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       CENTRO_DE_CUSTO C,',
'       PE_ESCALAS_EXCECOES E,',
'       pe_escalas s,',
'       pe_jornadas j',
' WHERE i.cod_empresa = c.cod_empresa',
'   and i.cod_empresa = e.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = e.matricula',
'   and e.cod_jornada = j.cod_jornada',
'   and e.cod_escala  = s.cod_escala',
'   and e.cod_escala = Fnct_Pe_Retorna_Escala(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr'') )',
'   and e.cod_jornada = Fnct_Pe_Retorna_Jornada(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr''))',
'   AND (I.COD_CCUSTO IN (SELECT X.COD',
'                           FROM CENTRO_DE_CUSTO X',
'                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                         FROM USUARIO_ORACLE U  ',
'                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO)));',
'                                                        ',
'select max(i.matricula)',
'      into :p45_matricula_fim',
'  FROM INFORMACOES_FUNCIONAIS_CAD I,',
'       CENTRO_DE_CUSTO C,',
'       PE_ESCALAS_EXCECOES E,',
'       pe_escalas s,',
'       pe_jornadas j',
' WHERE i.cod_empresa = c.cod_empresa',
'   and i.cod_empresa = e.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = e.matricula',
'   and e.cod_jornada = j.cod_jornada',
'   and e.cod_escala  = s.cod_escala',
'   and e.cod_escala = Fnct_Pe_Retorna_Escala(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr'') )',
'   and e.cod_jornada = Fnct_Pe_Retorna_Jornada(i.cod_empresa, i.matricula, to_date(sysdate,''dd/mm/rrrr''))',
'   AND (I.COD_CCUSTO IN (SELECT X.COD',
'                           FROM CENTRO_DE_CUSTO X',
'                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                         FROM USUARIO_ORACLE U  ',
'                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO)));'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_MATRICULA_INI,P45_MATRICULA_FIM,P_USUARIO'
,p_attribute_03=>'P45_MATRICULA_INI,P45_MATRICULA_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48784408691760040496)
,p_name=>'Dispara Alerta'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234018846945716562)
,p_event_id=>wwv_flow_api.id(48784408691760040496)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P45_MENSAGEM" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P45_MENSAGEM" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9234018604824716560)
,p_name=>'Dispara Alerta 2'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MENSAGEM2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234018739160716561)
,p_event_id=>wwv_flow_api.id(9234018604824716560)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'lSpinner$.remove();',
'if (apex.item( "P45_MENSAGEM2" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P45_MENSAGEM2" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29743705619119893577)
,p_name=>unistr('Valida\00E7\00E3o')
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(48784388210673040469)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29743705713789893578)
,p_event_id=>wwv_flow_api.id(29743705619119893577)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_mensagem varchar2(4000);',
'begin',
'    v_mensagem := null;',
'    if :P45_COD_EMPRESA is null then',
'        v_mensagem := v_mensagem||''Informe a empresa<br />'';',
'    end if;',
'    --',
'    if :P45_FILIAL_INI is null or :P45_FILIAL_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a filial inicial e filial final<br />'';  ',
'    end if;',
'    --',
'    if :P45_COD_CCUSTO_INI is null or :P45_COD_CCUSTO_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a centro de custo inicial e centro de custo final<br />'';  ',
'    end if;',
'    --',
'    if :P45_MATRICULA_INI is null or :P45_MATRICULA_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a matricula inicial e matricula final<br />'';  ',
'    end if;',
'    ',
'    if v_mensagem is not null then',
'        :P45_MENSAGEM := v_mensagem;',
'    else',
'        :P45_MENSAGEM := null;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM,P45_MATRICULA_INI,P45_MATRICULA_FIM,P45_COD_UN_NEGOCIO_INI,P45_COD_UN_NEGOCIO_FIM'
,p_attribute_03=>'P45_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48784406841471040493)
,p_name=>'Chama Report'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MENSAGEM'
,p_condition_element=>'P45_MENSAGEM'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784407341757040494)
,p_event_id=>wwv_flow_api.id(48784406841471040493)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784407818781040495)
,p_event_id=>wwv_flow_api.id(48784406841471040493)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_session_id number; ',
'  V_REPORT VARCHAR2(30);',
'  v_parametros varchar2(4000);',
'  V_BASE VARCHAR2(100);',
'  v_ip varchar2(200);  ',
'begin',
'begin',
'select APEX_CAMINHO_REPORT into v_ip from configuracoes;',
'exception when others then',
'v_ip := null;',
'end;',
'V_BASE := :P_BASE;',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;  ',
'  IF :P45_TIPO_RELATORIO in (''O'', ''A'') THEN',
'		V_REPORT := ''ESPELHO_PONTO'';',
'  ELSIF :P45_TIPO_RELATORIO = ''N'' THEN',
'		V_REPORT := ''ESPELHO_PONTO_N'';',
'  ELSIF :P45_TIPO_RELATORIO = ''2'' THEN',
'		V_REPORT := ''ESPELHO_PONTO_N2'';',
'  ELSIF :P45_TIPO_RELATORIO = ''3'' THEN',
'		V_REPORT := ''ESPELHO_PONTO_P'';',
'  ELSIF :P45_TIPO_RELATORIO = ''S'' THEN',
'		V_REPORT := ''ESPELHO_PONTO_A'';',
'  ELSIF :P45_TIPO_RELATORIO = ''P'' THEN',
'  	V_REPORT := ''RP20913'';',
'  ELSIF :P45_TIPO_RELATORIO = ''F'' THEN',
'    V_REPORT := ''RP20297'';',
'  ELSIF :P45_TIPO_RELATORIO = ''H'' THEN',
'    V_REPORT := ''RP20297_A'';',
'  END IF;',
'  v_session_id := TO_NUMBER(to_char(sysdate, ''RRRRMMDDHH24MISS''));',
'  if :P45_tipo_relatorio not in (''P'',''F'',''H'',''N'',''2'') then   ',
'    gera(v_session_id, :P45_COD_EMPRESA, nvl(:P45_MATRICULA_INI,1), nvl(:P45_MATRICULA_FIM,999999), ',
'	     nvl(:P45_FILIAL_INI,1), nvl(:P45_FILIAL_FIM,9999), nvl(:P45_COD_CCUSTO_INI,1), nvl(:P45_COD_CCUSTO_FIM,9999999999), nvl(:P45_COD_UN_NEGOCIO_INI,1), nvl(:P45_COD_UN_NEGOCIO_FIM,9999999999),',
'         null, null, :P45_COD_LOCALIZACAO_INI, :P45_COD_LOCALIZACAO_FIM, :P45_TIPO_RELATORIO, :P45_DATA_INI, :P45_DATA_FIM, nvl(:p45_situacao,''T''), :P_USUARIO, :P_PAINEL,:P45_MARCA_PONTO);',
'  end if;',
'  if v_report in (''ESPELHO_PONTO'',''ESPELHO_PONTO_A'', ''ESPELHO_PONTO_N'', ''ESPELHO_PONTO_N2'', ''ESPELHO_PONTO_P'') THEN',
'    V_PARAMETROS := ''p_empresa=''||:P45_cod_empresa||''&p_session_id=''||v_session_id||',
'          ''&p_banco=''||nvl(:P45_BANCO_HORAS,''N'')|| ''&p_saldo_bh=''||nvl(:P45_SALDO_BH,''N'')|| ',
'          ''&p_filial_ini=''||nvl(:P45_FILIAL_INI,1)||''&p_filial_fim=''||nvl(:P45_FILIAL_FIM,9999)||    ',
'          ''&p_ccusto_ini=''||nvl(:P45_COD_CCUSTO_INI,1)||  ''&p_ccusto_fim=''||nvl(:P45_COD_CCUSTO_FIM,9999999999)||',
'          ''&p_cod_un_negocio_ini=''||nvl(:P45_COD_UN_NEGOCIO_INI,1)|| ''&p_cod_un_negocio_fim=''||nvl(:P45_COD_UN_NEGOCIO_FIM,9999999999)||',
'          ''&p_mat_ini=''||nvl(:P45_MATRICULA_INI,1)||''&p_mat_fin=''||nvl(:P45_MATRICULA_FIM,999999)|| ',
'          ''&p_dt_ini=''||:P45_data_ini||''&p_dt_fim=''||:P45_data_fim||''&P_USUARIO=''||:P_USUARIO||''&P_MARCA_PONTO=''||:P45_MARCA_PONTO;',
'if v_report in (''ESPELHO_PONTO_N'', ''ESPELHO_PONTO_N2'') THEN',
'V_PARAMETROS := V_PARAMETROS ||''&p_tipo=N''|| ''&p_situacao=''||nvl(:p45_situacao,''T'')||''&P_PAINEL=''||:P_PAINEL;',
'end if;',
'ELSE',
'    V_PARAMETROS := ''p_empresa=''||:p45_COD_EMPRESA||  ''&p_session_id=''||v_session_id||',
'      ''&p_banco=''||nvl(:P45_BANCO_HORAS,''N'')||  ''&P_SALDO_BH=''||nvl(:P45_SALDO_BH,''N'')|| ',
'      ''&p_filial_ini=''||nvl(:P45_FILIAL_INI,1)|| ''&p_filial_fim=''||nvl(:P45_FILIAL_FIM,9999)||   ',
'      ''&p_ccust_ini=''||nvl(:P45_COD_CCUSTO_INI,1)|| ''&p_ccust_fim=''||nvl(:P45_COD_CCUSTO_FIM,9999999999)||  ',
'      ''&p_cod_un_negocio_ini=''||nvl(:P45_COD_UN_NEGOCIO_INI,1)|| ''&p_cod_un_negocio_fim=''||nvl(:P45_COD_UN_NEGOCIO_FIM,9999999999)||',
'      ''&p_ccusto_ini=''||nvl(:P45_COD_CCUSTO_INI,1)||''&p_ccusto_fim=''||nvl(:P45_COD_CCUSTO_FIM,9999999999)||',
'      ''&p_mat_ini=''||nvl(:P45_matricula_ini,1)|| ''&p_mat_fin=''||nvl(:P45_matricula_fim,999999)||',
'      ''&p_matricula_ini=''||nvl(:P45_matricula_ini,1)||''&p_matricula_fim=''||nvl(:P45_matricula_fim,999999)||  ',
'      ''&p_dt_ini=''||:P45_data_ini|| ''&p_dt_fim=''||:P45_data_fim||',
'      ''&p_dt_admissao_ini=''||:P45_data_ini|| ''&p_dt_admissao_fim=''||:P45_data_fim||',
'      ''&p_situacao=''||:p45_situacao||''&P_USUARIO=''||:P_USUARIO||''&P_MARCA_PONTO=''||:P45_MARCA_PONTO;',
'',
'END IF;',
'if NVL(:p45_OK,''S'') <> ''N'' THEN',
'  :P45_PARAMETROS := V_PARAMETROS;',
'  :P45_REPORT := v_report;',
'END IF; ',
':P45_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'end;'))
,p_attribute_02=>'P45_BANCO_HORAS,P45_DATA_INI,P45_DATA_FIM,P45_MAO_OBRA,P45_SITUACAO,P45_TIPO_RELATORIO,P45_COD_EMPRESA,P45_SALDO_BH,P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM,P45_MATRICULA_INI,P45_MATRICULA_FIM,P_USUARIO,P45_COD_LOCALIZACAO_'
||'INI,P45_COD_LOCALIZACAO_FIM,P45_COD_GRUPO_TRABALHO_INI,P45_COD_GRUPO_TRABALHO_FIM,P45_OK,P_PAINEL,P45_COD_UN_NEGOCIO_INI,P45_COD_UN_NEGOCIO_FIM,P45_MARCA_PONTO'
,p_attribute_03=>'P45_PARAMETROS,P45_REPORT,P45_ENDERECO_REL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784408289643040495)
,p_event_id=>wwv_flow_api.id(48784406841471040493)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P45_OK" ).getValue() == ''N''){',
' alert( apex.item( "P45_MENSAGEM" ).getValue());',
'}',
'lSpinner$.remove(); '))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48784409544089040497)
,p_name=>'Valida Datas'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_DATA_INI,P45_DATA_FIM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784410134980040497)
,p_event_id=>wwv_flow_api.id(48784409544089040497)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'	SELECT dt_ini_ponto_gestor data_ini, ',
'         dt_fim_ponto_gestor data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P45_COD_EMPRESA;',
'',
'v_c1 c1%rowtype;',
'',
'v_msg varchar2(4000);',
'',
'begin',
'NULL;',
'/*',
'  if :p_painel <> ''PO'' then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.data_ini is not null then',
'',
'        if :p45_data_ini is not null and',
'           :p45_data_ini not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'           goto valida;',
'        end if;',
'',
'    end if;',
'',
'    if v_c1.data_fim is not null then',
'',
'        if :p45_data_fim is not null and',
'           :p45_data_fim not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'',
'        end if;',
'',
'    end if;',
'',
'  end if;',
'  ',
'    <<valida>>',
'    ',
'    if v_msg is not null then',
'    :p45_mensagem := v_msg;',
'    :p45_ok := ''N'';',
'    else',
'    :p45_mensagem := null;',
'    :p45_ok := ''S'';',
'    end if;',
'*/',
'end;'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_DATA_INI,P45_DATA_FIM,P_PAINEL'
,p_attribute_03=>'P45_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(48784410494432040498)
,p_name=>'Chama Report 1'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_REPORT'
,p_condition_element=>'P45_REPORT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(48784411017259040498)
,p_event_id=>wwv_flow_api.id(48784410494432040498)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'&P45_REPORT.'
,p_attribute_02=>'relatorio'
,p_attribute_03=>'inline'
,p_attribute_05=>'P45_PARAMETROS'
,p_attribute_06=>'Y'
,p_attribute_07=>'return :p45_parametros;'
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29743705267839893574)
,p_name=>'Inicia Alertify'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_ONCLICK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29743705343038893575)
,p_event_id=>wwv_flow_api.id(29743705267839893574)
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
 p_id=>wwv_flow_api.id(28624568247242641480)
,p_name=>'Popula situacao_marca_ponto'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28624568363160641481)
,p_event_id=>wwv_flow_api.id(28624568247242641480)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P45_SITUACAO := ''T'';',
':P45_MARCA_PONTO := ''S'';'))
,p_attribute_03=>'P45_SITUACAO,P45_MARCA_PONTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26135232747412995968)
,p_name=>'Mostra Assinatura'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_CONTROLE_ASSINATURA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155048905215875851)
,p_event_id=>wwv_flow_api.id(26135232747412995968)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor C1 is   ',
'    select t.*, t.rowid from termos t',
'    where espelho_ponto_flag = ''S''',
'    and ativo = ''S'';',
'',
'    v_c1    c1%rowtype;',
'begin',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  PKG_TERMOS.prc_retorna_termo_espelho(p_cod_empresa             => :P_EMPRESA_USER,',
'                                       p_matricula               => :P_MATRICULA_USER,',
'                                       p_cod_candidato           => null,',
'                                       p_cod_termo               => v_c1.cod_termo,',
'                                       p_versao                  => v_c1.versao,',
'                                       p_nome_termo              => :P45_NOME_TERMO,',
'                                       p_titulo_termo            => :P45_TITULO_TERMO,',
'                                       p_texto_termo             => :P45_TEXTO_TERMO,',
'                                       p_texto_aceite            => :P45_TEXTO_ACEITE,',
'                                       p_prosseguir_sem_aceite   => :P45_PROSSEGUIR_SEM_ACEITE,',
'                                       p_opcao                   => :P45_OPCAO);',
'',
'end;'))
,p_attribute_03=>'P45_NOME_TERMO,P45_TITULO_TERMO,P45_TEXTO_TERMO,P45_TEXTO_ACEITE,P45_PROSSEGUIR_SEM_ACEITE,P45_OPCAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26135232835971995969)
,p_event_id=>wwv_flow_api.id(26135232747412995968)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155046216180875824)
,p_name=>'Assinar'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(26155046118772875823)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155046246455875825)
,p_event_id=>wwv_flow_api.id(26155046216180875824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR C_TERMO IS',
'  select t.*, t.rowid from termos t',
'    where espelho_ponto_flag = ''S''',
'    and ativo = ''S'';',
'',
'  CURSOR C_COLAB IS',
'  select i.cod_empresa, i.matricula, i.nome, i.nome_social,substr(lpad(i.num_cpf,9,0),0,3)||''.''||substr(lpad(i.num_cpf,9,0),4,3)||''.''||substr(lpad(i.num_cpf,9,0),7,3) ||''-''||lpad(i.dc_cpf,2,0) cpf,',
'         :P45_DATA_FIM data_ref_ponto,  :P45_DATA_INI data_ini_ref_ponto, :P45_DATA_FIM data_fim_ref_ponto ',
'    from inf_pessoais i, parametros_recursos_humanos p where i.cod_empresa = p.cod_empresa and i.cod_empresa = :P45_EMP and i.matricula = :P45_MAT;',
'',
'  V_C1 C_COLAB%ROWTYPE;',
'  V_C0 C_TERMO%ROWTYPE; ',
'  v_contador number := 0;',
'begin',
'    open C_TERMO;',
'    fetch C_TERMO into V_C0;',
'    close C_TERMO;',
'',
'    open C_COLAB;',
'    fetch C_COLAB into V_C1;',
'    close C_COLAB;',
'  begin',
'  ',
'  insert into pe_espelho_ponto_assinado (cod_empresa,',
'                                         matricula,',
'                                         nome,',
'                                         nome_social,',
'                                         cpf,',
'                                         data_ref_ponto,',
'                                         data_ini_ref_ponto,',
'                                         data_fim_ref_ponto,',
'                                         dt_assinatura,',
'                                         origem_assinatura,',
'                                         ip_assinatura,',
'                                         usuario,',
'                                         dt_atualizacao)',
'                                        values ',
'                                        (v_c1.cod_empresa,',
'                                         v_c1.matricula,',
'                                         v_c1.nome,',
'                                         v_c1.nome_social,',
'                                         v_c1.cpf,',
'                                         v_c1.data_ref_ponto,',
'                                         v_c1.data_ini_ref_ponto,',
'                                         v_c1.data_fim_ref_ponto,',
'                                         sysdate,',
'                                         ''PAINEL DO COLABORADOR'',',
'                                         NULL,',
'                                         :P_USUARIO,',
'                                         sysdate);',
'',
'  commit;',
'  ',
'  exception',
'  when dup_val_on_index then',
'    null;  ',
'  end;',
'    begin',
'        select count(*) into v_contador from termos_usuarios tu',
'        where cod_termo = V_C0.COD_TERMO and versao = (select max(versao) from termos where cod_termo = tu.cod_termo and espelho_ponto_flag = ''S'' and ativo = ''S'')',
'        and cod_empresa = :P45_EMP and matricula = :P45_MAT;',
'    exception',
'        when others then',
'           v_contador := 0;',
'    end;',
'    if v_contador = 0 then',
'        pkg_termos.prc_salvar_opcao(p_app => 9506,',
'                                    p_page => 45,',
'                                    p_publico => ''F'',',
'                                    p_cod_empresa => :P45_EMP,',
'                                    p_matricula => :P45_MAT,',
'                                    p_cod_candidato => NULL,',
'                                    p_tipo_documento => NULL,',
'                                    p_documento => NULL,',
'                                    p_cod_req => NULL,',
'                                    p_cod_termo => V_C0.COD_TERMO,',
'                                    p_versao => V_C0.VERSAO,',
'                                    p_aceite => ''S'',',
'                                    p_usuario => :P_USUARIO,',
'                                    p_dt_ini_per_espelho => :P45_DATA_INI,',
'                                    p_dt_fim_per_espelho => :P45_DATA_FIM,',
'                                    p_numero_parcela => NULL',
'                                    );    ',
'    end if;',
'end;'))
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155195199375189964)
,p_event_id=>wwv_flow_api.id(26155046216180875824)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155195279561189965)
,p_event_id=>wwv_flow_api.id(26155046216180875824)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155195426615189966)
,p_event_id=>wwv_flow_api.id(26155046216180875824)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(25479555165713881812)
,p_event_id=>wwv_flow_api.id(26155046216180875824)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(25479554893255881809)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155046528649875827)
,p_name=>'Assinatura'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(26155046335015875826)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26135232610297995966)
,p_event_id=>wwv_flow_api.id(26155046528649875827)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_controle      varchar2(1);',
'    v_cod_termo     termos_usuarios.cod_termo%type;',
'begin',
'    begin',
'        select cod_termo',
'         into v_cod_termo',
'        from termos t',
'            where espelho_ponto_flag = ''S''',
'            and ativo = ''S'';',
'    exception ',
'        when others then',
'            v_cod_termo := null;',
'    end;    ',
'    if v_cod_termo is not null then',
'        v_controle := ''N'';',
'    else   ',
'        begin',
'            select ''S'' controle',
'                 into v_controle',
'            from termos_usuarios tu',
'            where cod_termo = v_cod_termo',
'            and versao = (select max(versao) ',
'                              from termos ',
'                              where cod_termo = tu.cod_termo ',
'                              and espelho_ponto_flag = ''S'' ',
'                          and ativo = ''S'')',
'            and cod_empresa = :P45_EMP',
'            and matricula = :P45_MAT;',
'        exception ',
'            when others then',
'                v_controle := ''N'';',
'        end;    ',
'    end if;',
'',
'    if nvl(v_controle , ''N'') = ''N'' then',
'       :P45_MOSTRA_REGIAO := ''S''; ',
'    else',
'       :P45_MOSTRA_REGIAO := ''N'';     ',
'    end if;',
'end;'))
,p_attribute_02=>'P45_EMP,P45_MAT'
,p_attribute_03=>'P45_MOSTRA_REGIAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155048475124875847)
,p_name=>'Verifica se assina pelas datas'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_DATA_FIM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155195575325189968)
,p_event_id=>wwv_flow_api.id(26155048475124875847)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    vexiste_termo varchar2(1);',
'    vexiste_assina number;',
'begin',
'    if :P_PAINEL = ''PC'' then    ',
'        begin',
'            select ''S''',
'            into vexiste_termo',
'            from termos t',
'            where espelho_ponto_flag = ''S''',
'            and ativo = ''S'';',
'        exception',
'            when others then',
'                vexiste_termo := ''N'';',
'        end;',
'        --',
'        begin',
'            select count(*) into vexiste_assina',
'                from termos_usuarios tu, termos t, pe_espelho_ponto_assinado a',
'                where tu.cod_termo = t.cod_termo',
'                and a.cod_empresa = tu.cod_empresa',
'                and a.matricula = tu.matricula',
'                and espelho_ponto_flag = ''S''',
'                 and ativo = ''S''',
'                and t.versao = (select max(versao) ',
'                                  from termos ',
'                                  where cod_termo = tu.cod_termo ',
'                                  and espelho_ponto_flag = ''S'' ',
'                              and ativo = ''S'')',
'                and tu.cod_empresa = :P45_EMP',
'                and tu.matricula = :P45_MAT',
'                and a.data_ini_ref_ponto = :P45_DATA_INI and a.data_fim_ref_ponto = :P45_DATA_FIM;',
'        exception',
'            when others then',
'                vexiste_assina := 0;',
'        end;',
'    --',
'        if vexiste_termo = ''S'' and vexiste_assina = 0 then',
'            :P45_MOSTRA_NAO_ASSINADO := ''S'';',
'        else',
'            :P45_MOSTRA_NAO_ASSINADO := ''N'';',
'        end if;',
'        -- ',
'    end if;',
'end;'))
,p_attribute_02=>'P45_EMP,P45_MAT,P45_DATA_INI,P45_DATA_FIM'
,p_attribute_03=>'P45_MOSTRA_NAO_ASSINADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155050116894875863)
,p_name=>unistr('Mostra bot\00E3o assinatura pelo termo')
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MOSTRA_BOTAO_TEM_TERMO'
,p_condition_element=>'P45_MOSTRA_BOTAO_TEM_TERMO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155050148025875864)
,p_event_id=>wwv_flow_api.id(26155050116894875863)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155050262786875865)
,p_event_id=>wwv_flow_api.id(26155050116894875863)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155191393362189926)
,p_name=>unistr('Mostra bot\00E3o assinatura')
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_CONTROLE_ASSINATURA_VALIDA'
,p_condition_element=>'P45_CONTROLE_ASSINATURA_VALIDA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155191527801189927)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155192095147189933)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155191627495189928)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155191776745189930)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155191677812189929)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155191945200189932)
,p_event_id=>wwv_flow_api.id(26155191393362189926)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155192989990189942)
,p_name=>'Mostra se tem que assinar'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_CONTROLE_ASSINATURA'
,p_condition_element=>'P45_CONTROLE_ASSINATURA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193105206189943)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193605546189948)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193196222189944)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193517541189947)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193251917189945)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193420886189946)
,p_event_id=>wwv_flow_api.id(26155192989990189942)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155193847788189951)
,p_name=>unistr('Mostra bot\00E3o assinatura')
,p_event_sequence=>170
,p_condition_element=>'P45_CONTROLE_ASSINATURA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155193942160189952)
,p_event_id=>wwv_flow_api.id(26155193847788189951)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155194273350189955)
,p_event_id=>wwv_flow_api.id(26155193847788189951)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155194039800189953)
,p_event_id=>wwv_flow_api.id(26155193847788189951)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155194223478189954)
,p_event_id=>wwv_flow_api.id(26155193847788189951)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155194470819189957)
,p_name=>'Mostra / oculta assinatura'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_CONTROLE_ASSINATURA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155194557124189958)
,p_event_id=>wwv_flow_api.id(26155194470819189957)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155194885212189961)
,p_name=>'Mostra assinatura'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MOSTRA_REGIAO'
,p_condition_element=>'P45_MOSTRA_REGIAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155194971724189962)
,p_event_id=>wwv_flow_api.id(26155194885212189961)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(26135233018765995970)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155195045496189963)
,p_event_id=>wwv_flow_api.id(26155194885212189961)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor C1 is   ',
'    select t.*, t.rowid from termos t',
'    where espelho_ponto_flag = ''S''',
'    and ativo = ''S'';',
'',
'    v_c1    c1%rowtype;',
'begin',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  PKG_TERMOS.prc_retorna_termo_espelho(p_cod_empresa             => :P45_EMP,',
'                                       p_matricula               => :P45_MAT,',
'                                       p_cod_candidato           => null,',
'                                       p_cod_termo               => v_c1.cod_termo,',
'                                       p_versao                  => v_c1.versao,',
'                                       p_nome_termo              => :P45_NOME_TERMO,',
'                                       p_titulo_termo            => :P45_TITULO_TERMO,',
'                                       p_texto_termo             => :P45_TEXTO_TERMO,',
'                                       p_texto_aceite            => :P45_TEXTO_ACEITE,',
'                                       p_prosseguir_sem_aceite   => :P45_PROSSEGUIR_SEM_ACEITE,',
'                                       p_opcao                   => :P45_OPCAO);',
'',
'end;'))
,p_attribute_02=>'P45_EMP,P45_MAT'
,p_attribute_03=>'P45_NOME_TERMO,P45_TITULO_TERMO,P45_TEXTO_TERMO,P45_TEXTO_ACEITE,P45_PROSSEGUIR_SEM_ACEITE,P45_OPCAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26155195778317189970)
,p_name=>'Mostra / Oculta Assinatura Datas'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MOSTRA_NAO_ASSINADO'
,p_condition_element=>'P45_MOSTRA_NAO_ASSINADO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155239423391781221)
,p_event_id=>wwv_flow_api.id(26155195778317189970)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155239666029781224)
,p_event_id=>wwv_flow_api.id(26155195778317189970)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155239509372781222)
,p_event_id=>wwv_flow_api.id(26155195778317189970)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26155239622652781223)
,p_event_id=>wwv_flow_api.id(26155195778317189970)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(25479554995224881810)
,p_name=>'Imprime Preview'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(25479554893255881809)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(25479555058941881811)
,p_event_id=>wwv_flow_api.id(25479554995224881810)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_mensagem varchar2(4000);',
'begin',
'    v_mensagem := null;',
'    if :P45_COD_EMPRESA is null then',
'        v_mensagem := v_mensagem||''Informe a empresa<br />'';',
'    end if;',
'    --',
'    if :P45_FILIAL_INI is null or :P45_FILIAL_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a filial inicial e filial final<br />'';  ',
'    end if;',
'    --',
'    if :P45_COD_CCUSTO_INI is null or :P45_COD_CCUSTO_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a centro de custo inicial e centro de custo final<br />'';  ',
'    end if;',
'    --',
'    if :P45_MATRICULA_INI is null or :P45_MATRICULA_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a matricula inicial e matricula final<br />'';  ',
'    end if;',
'    ',
'    if v_mensagem is not null then',
'        :P45_MENSAGEM := v_mensagem;',
'    else',
'        :P45_MENSAGEM := null;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM,P45_MATRICULA_INI,P45_MATRICULA_FIM,P45_COD_UN_NEGOCIO_INI,P45_COD_UN_NEGOCIO_FIM'
,p_attribute_03=>'P45_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9234018247613716556)
,p_name=>'Listar'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(9234018099843716555)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234022099504716595)
,p_event_id=>wwv_flow_api.id(9234018247613716556)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234018297885716557)
,p_event_id=>wwv_flow_api.id(9234018247613716556)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_mensagem varchar2(4000);',
'begin',
'    v_mensagem := null;',
'    if :P45_COD_EMPRESA is null then',
'        v_mensagem := v_mensagem||''Informe a empresa<br />'';',
'    end if;',
'    --',
'    if :P45_FILIAL_INI is null or :P45_FILIAL_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a filial inicial e filial final<br />'';  ',
'    end if;',
'    --',
'    if :P45_COD_CCUSTO_INI is null or :P45_COD_CCUSTO_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a centro de custo inicial e centro de custo final<br />'';  ',
'    end if;',
'    --',
'    if :P45_MATRICULA_INI is null or :P45_MATRICULA_FIM is null then',
'        v_mensagem := v_mensagem||''Informe a matricula inicial e matricula final<br />'';',
'    elsif :P45_MATRICULA_INI <> :P45_MATRICULA_FIM then',
unistr('        v_mensagem := v_mensagem||''Op\00E7\00E3o para consulta individual. Informe a mesma matricula inicial e final<br />'';'),
'    end if;',
'    ',
'    if v_mensagem is not null then',
'        :P45_MENSAGEM2 := v_mensagem;',
'    else',
'        :P45_EXIBE := ''S'';',
'        :P45_MENSAGEM2 := null;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_FILIAL_INI,P45_FILIAL_FIM,P45_COD_CCUSTO_INI,P45_COD_CCUSTO_FIM,P45_MATRICULA_INI,P45_MATRICULA_FIM,P45_COD_UN_NEGOCIO_INI,P45_COD_UN_NEGOCIO_FIM'
,p_attribute_03=>'P45_EXIBE,P45_MENSAGEM2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9234019000333716564)
,p_name=>'Refresh'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_MENSAGEM2'
,p_condition_element=>'P45_MENSAGEM2'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234019224732716566)
,p_event_id=>wwv_flow_api.id(9234019000333716564)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'lSpinner$ = apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234019475133716568)
,p_event_id=>wwv_flow_api.id(9234019000333716564)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.region("regiaolist").refresh();',
'apex.region("regiaoevento").refresh();',
'apex.region("regiaoassinatura").refresh();',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234022016783716594)
,p_event_id=>wwv_flow_api.id(9234019000333716564)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P45_HORAS_PREVISTAS := pkg_espelho_ponto.CF_TOTAL_HORAS_PREVISTAS(:p45_cod_empresa, :p45_matricula_ini, :p45_data_ini, :p45_data_fim);',
'',
':p45_SALDO_BH_REMANESCENTE := pkg_espelho_ponto.CF_SALDO_REMANESCENTE(p_cod_empresa => :p45_cod_empresa,',
'                                                     p_matricula => :p45_matricula_ini,',
'                                                     p_data_ini => :p45_data_ini,',
'                                                     p_data_fim => :p45_data_fim,',
'                                                     P_SALDO_BH => :P45_SALDO_BH);',
'',
':P45_SALDO_BH_ANTERIOR := pkg_espelho_ponto.CF_SALDO_ANTERIOR(p_cod_empresa => :p45_cod_empresa,',
'                                                 p_matricula => :p45_matricula_ini,',
'                                                 p_data_ini => :p45_data_ini,',
'                                                 P_SALDO_BH => :P45_SALDO_BH);',
'',
':P45_SALDO_BH_PERIODO := pkg_espelho_ponto.CF_SALDO(p_cod_empresa => :p45_cod_empresa,',
'                                        p_matricula => :p45_matricula_ini,',
'                                        p_data_ini => :p45_data_ini,',
'                                        p_data_fim => :p45_data_fim);',
'                                        ',
':P45_SALDO_ATUAL := pkg_espelho_ponto.CF_SALDO_TOTAL(p_cod_empresa => :p45_cod_empresa,',
'                                              p_matricula => :p45_matricula_ini,',
'                                              p_data_ini => :p45_data_ini,',
'                                              p_data_fim => :p45_data_fim,',
'                                              P_SALDO_BH => :P45_SALDO_BH);'))
,p_attribute_02=>'P45_COD_EMPRESA,P45_MATRICULA_INI,P45_DATA_INI,P45_DATA_FIM'
,p_attribute_03=>'P45_HORAS_PREVISTAS,P45_SALDO_ATUAL,P45_SALDO_BH_PERIODO,P45_SALDO_BH_ANTERIOR,P45_SALDO_BH_REMANESCENTE'
,p_attribute_04=>'N'
,p_stop_execution_on_error=>'N'
,p_wait_for_result=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234019509895716569)
,p_event_id=>wwv_flow_api.id(9234019000333716564)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'lSpinner$.remove(); ',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221916648790015066)
,p_event_id=>wwv_flow_api.id(9234019000333716564)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9234020075121716574)
,p_name=>'Atualiza Espelho Ponto'
,p_event_sequence=>240
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(9234019903060716573)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9234020111061716575)
,p_event_id=>wwv_flow_api.id(9234020075121716574)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(9233979587395313948)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9221916417157015064)
,p_name=>'Atualiza Evento'
,p_event_sequence=>250
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(9234022201629716596)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221916578228015065)
,p_event_id=>wwv_flow_api.id(9221916417157015064)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(9234021321255716587)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9221916741304015067)
,p_name=>'Habilita / Desabilita botoes'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_EXIBE'
,p_condition_element=>'P45_EXIBE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221916873880015068)
,p_event_id=>wwv_flow_api.id(9221916741304015067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221917030417015070)
,p_event_id=>wwv_flow_api.id(9221916741304015067)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(48784388210673040469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221916936167015069)
,p_event_id=>wwv_flow_api.id(9221916741304015067)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221917108231015071)
,p_event_id=>wwv_flow_api.id(9221916741304015067)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(26155046335015875826)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9221919257527015092)
,p_name=>'Atualiza Data Evento'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_DATA_FIM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221919382039015093)
,p_event_id=>wwv_flow_api.id(9221919257527015092)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P45_DT_EVENTO_FIM := :P45_DATA_FIM;'
,p_attribute_02=>'P45_DATA_FIM'
,p_attribute_03=>'P45_DT_EVENTO_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9221919457411015094)
,p_name=>'Atualiza data Evento Ini'
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P45_DATA_INI'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9221919619713015096)
,p_event_id=>wwv_flow_api.id(9221919457411015094)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P45_DT_EVENTO_INI := :P45_DATA_INI;'
,p_attribute_02=>'P45_DATA_INI'
,p_attribute_03=>'P45_DT_EVENTO_INI'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(48784403084164040487)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
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
 p_id=>wwv_flow_api.id(48784403493906040488)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_data_ini_ref_ponto    PARAMETROS_RECURSOS_HUMANOS.DATA_INI_REF_PONTO%TYPE;',
'    v_data_fim_ref_ponto    PARAMETROS_RECURSOS_HUMANOS.DATA_INI_REF_PONTO%TYPE;',
'    v_dt_ini_ponto_colab    PARAMETROS_RECURSOS_HUMANOS.DATA_INI_REF_PONTO%TYPE;',
'    v_dt_fim_ponto_colab    PARAMETROS_RECURSOS_HUMANOS.DATA_INI_REF_PONTO%TYPE;',
'',
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'  PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'',
'       --if :p45_data_ini is null then',
'        BEGIN',
'		SELECT DATA_INI_REF_PONTO, DATA_FIM_REF_PONTO, dt_ini_ponto_colab, dt_fim_ponto_colab',
'		  INTO v_data_ini_ref_ponto, v_data_fim_ref_ponto, v_dt_ini_ponto_colab, v_dt_fim_ponto_colab',
'		  FROM PARAMETROS_RECURSOS_HUMANOS',
'		 WHERE COD_EMPRESA = nvl(:P45_EMP, :P_EMPRESA_USER) ;   -- nvl(:p45_emp,nvl(:P45_EMPRESAS,nvl(:P_EMPRESA_USER,cod_empresa)));',
'		 --WHERE COD_EMPRESA = nvl(:p45_emp,nvl(:P45_EMPRESAS,nvl(:P_EMPRESA_USER,cod_empresa)));',
'        end;',
'       --end if;',
'       ',
'       if :P_PAINEL = ''PC'' then',
'           :P45_DATA_INI := v_dt_ini_ponto_colab;',
'           :P45_DATA_FIM := v_dt_fim_ponto_colab;',
'           :P45_DT_EVENTO_INI := v_dt_ini_ponto_colab;',
'           :P45_DT_EVENTO_FIM := v_dt_fim_ponto_colab;',
'       else',
'           :P45_DATA_INI := v_data_ini_ref_ponto;',
'           :P45_DATA_FIM := v_data_fim_ref_ponto;',
'           :P45_DT_EVENTO_INI := v_data_ini_ref_ponto;',
'           :P45_DT_EVENTO_FIM := v_data_fim_ref_ponto;',
'       ',
'       ',
'       end if;',
'       ',
'       ',
'if :p45_mao_obra is null then',
':p45_mao_obra := ''T'';',
'end if;',
'if :p45_situacao is null then',
':p45_situacao := ''T'';',
'end if;',
'if :p45_ordenacao is null then',
':P45_ORDENACAO := ''FA'';',
'end if;',
'if :p45_seq is null then',
':p45_seq := to_char(sysdate,''yyyymmddhh24miss'');',
'end if;',
'end;',
'if :p45_exibe is null then',
'  :p45_exibe := ''N'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(48784402711544040486)
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
'       i.cod_empresa,',
'       i.filial,',
'       i.cod_ccusto,',
'       i.cod_localizacao,',
'       i.cod_grupo_trabalho,',
'       I.MATRICULA matricula_cod',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p45_emp',
'   and i.matricula = :p45_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p45_cod_empresa_1 := v_c1.empresa;',
':p45_matricula := v_c1.matricula;',
':p45_situacao_1 := v_c1.situacao;',
':p45_dt_admissao := v_c1.dt_admissao;',
'',
':p45_cod_empresa := v_c1.cod_empresa;',
':p45_filial_ini := v_c1.filial;',
':p45_filial_fim := v_c1.filial;',
':p45_cod_ccusto_ini := v_c1.cod_ccusto;',
':p45_cod_ccusto_fim := v_c1.cod_ccusto;',
':p45_cod_grupo_trabalho_ini := v_c1.cod_grupo_trabalho;',
':p45_cod_grupo_trabalho_fim := v_c1.cod_grupo_trabalho;',
':p45_cod_localizacao_ini := v_c1.cod_localizacao;',
':p45_cod_localizacao_fim := v_c1.cod_localizacao;',
':p45_matricula_ini := v_c1.matricula_cod;',
':p45_matricula_fim := v_c1.matricula_cod;',
'',
'IF v_c1.matricula_cod IS NULL THEN',
'  :p45_exibe := ''S'';',
'END IF;',
'exception',
'when others then',
':p45_cod_empresa := :p45_emp;',
':p45_matricula := :p45_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(26155194390253189956)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida termos e assinaturas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    vexiste_termo varchar2(1);',
'    vexiste_assina number;',
'begin',
'    if :P_PAINEL = ''PC'' then    ',
'        begin',
'            select ''S''',
'                into vexiste_termo',
'                from termos t',
'                where espelho_ponto_flag = ''S''',
'                and ativo = ''S'';',
'        exception',
'            when others then',
'                vexiste_termo := ''N'';',
'        end;',
'        --',
'        begin',
'            select count(*) into vexiste_assina',
'                from termos_usuarios tu, termos t, pe_espelho_ponto_assinado a',
'                where tu.cod_termo = t.cod_termo',
'                and a.cod_empresa = tu.cod_empresa',
'                and a.matricula = tu.matricula',
'                and espelho_ponto_flag = ''S''',
'                 and ativo = ''S''',
'                and t.versao = (select max(versao) ',
'                                  from termos ',
'                                  where cod_termo = tu.cod_termo ',
'                                  and espelho_ponto_flag = ''S'' ',
'                              and ativo = ''S'')',
'                and tu.cod_empresa = :P45_EMP',
'                and tu.matricula = :P45_MAT',
'                and a.data_ini_ref_ponto = :P45_DATA_INI and a.data_fim_ref_ponto = :P45_DATA_FIM;',
'        exception',
'            when others then',
'                vexiste_assina := 0;',
'        end;',
'    --',
'        if vexiste_termo = ''S'' and vexiste_assina = 0 then',
'            :P45_CONTROLE_ASSINATURA := ''S'';',
'        else',
'            :P45_CONTROLE_ASSINATURA := ''N'';',
'        end if;',
'    end if;',
'    --    ',
'end;',
''))
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
