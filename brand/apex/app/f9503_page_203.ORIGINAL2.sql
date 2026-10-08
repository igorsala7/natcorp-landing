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
,p_default_application_id=>9503
,p_default_id_offset=>777366879312119448
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   10:23 Thursday October 1, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 203
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00203
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>203);
end;
/
prompt --application/pages/page_00203
begin
wwv_flow_api.create_page(
 p_id=>203
,p_user_interface_id=>wwv_flow_api.id(199995603908188555028)
,p_name=>'Abono - Colaborador'
,p_step_title=>'Abono - Colaborador'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Abono.js'
,p_javascript_code=>'var appItemPainelVal = ''&P_PAINEL.'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (appItemPainelVal == ''PC''){',
'    $(''#t_Header'').addClass(''hide'');',
'}',
'',
'document.getElementById("marcacao").setAttribute("style", "overflow:auto;height:650px");',
'',
''))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Abono.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'.hide {',
'    display: none !important;',
'}',
'',
'.t-Button--simple.t-Button--primary:not(.t-Button--hot), .t-Button--simple.t-Button--primary:not(.t-Button--hot) .t-Icon {',
'    color: initial;',
'}',
'/*',
'#a_Collapsible1_content',
'{',
'    padding-bottom: 2px;',
'    padding-top: 2px;',
'    padding-right: 0px;',
'    padding-left: 0px;',
'}',
'',
'.t-Region-headerItems .t-Region-headerItems--title',
'{',
'    padding-right: 8px;',
'    padding-left: 8px;',
'    padding-top: 12px;',
'    padding-bottom: 12px;',
'}',
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
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261001102245'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(127968663291943440270)
,p_plug_name=>'Consultas'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>22
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>'select 1 from dual where :P_PAINEL != ''PC'''
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167429712744768886388)
,p_plug_name=>unistr('Requisi\00E7\00F5es de Apura\00E7\00E3o')
,p_region_name=>'REQUISICAO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>92
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P203_USE_REQ'
,p_plug_display_when_cond2=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167429712966361886390)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Apura\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(167429712744768886388)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(199995577391309554932)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       c.solicitacao requisicao,',
'       c.dt_solicitacao data_abertura,',
'       c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) Empresa, ',
'       r.matricula||'' - ''||initcap(fnct_nome_func(r.cod_empresa, r.matricula)) Matricula_Solicitada,',
'       c.cod_empresa_solicitante||'' - ''||Initcap(fnct_nome_empresa(c.cod_empresa_solicitante)) Empresa_Solicitante,',
'       c.mat_solicitante||'' - ''||initcap(fnct_nome_func(c.cod_empresa_solicitante, c.mat_solicitante)) Solicitante,',
'       decode(cod_sit_req,1,''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Aberta'',',
unistr('                            2,''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Conclu\00EDda'','),
'                            3,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada'',',
'                            4,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada'',',
'                            5,''<span aria-hidden="true" class="fa fa-check-circle colorInfo"></span> ''||''Aprovada'',',
unistr('                            6,''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||''Suspens\00E3o'') Situacao,'),
'       r.cod_empresa,',
'       r.cod_req cod_solicitacao,',
'       c.cod_empresa_solicitante,',
'       c.mat_solicitante,',
'       r.matricula,',
'       r.data_ponto,',
'       r.cod_item,',
'       r.id_apuracao,',
'       r.cod_evento,',
'       r.cod_evento_atual||'' - ''||(select descricao from pe_eventos_folha  pef',
'                 where cod_empresa = r.cod_empresa',
'                 and r.tipo_evento_atual = ''PONTO''',
'                 and pef.cod_evento_folha = r.cod_evento_atual ',
'          union',
'           select descricao from pe_eventos_banco peb',
'                            where cod_empresa = r.cod_empresa',
'                 and r.tipo_evento_atual = ''BANCO''',
'                 and peb.cod_evento_banco = r.cod_evento_atual ',
'      ) EVENTO_ORIGINAL,   ',
'       r.tipo_evento_atual TIPO_EVENTO_ORIGINAL,',
'       r.qtd_horas_atual HORAS_ORIGINAIS,',
'',
'      r.cod_evento||'' - ''||(select descricao from pe_eventos_folha  pef',
'                 where cod_empresa = r.cod_empresa',
'                 and r.tipo_evento = ''PONTO''',
'                 and pef.cod_evento_folha = r.cod_evento ',
'          union',
'           select descricao from pe_eventos_banco peb',
'                            where cod_empresa = r.cod_empresa',
'                 and r.tipo_evento = ''BANCO''',
'                 and peb.cod_evento_banco = r.cod_evento ',
'      ) EVENTO_SOLICITADO,',
'    r.tipo_evento TIPO_EVENTO_SOLICITADO,',
'       r.qtd_horas HORAS_SOLICITADAS,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.usuario',
'        else',
'            null',
'        end usuario_cancelamento,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.dt_atualizacao',
'        else',
'            null',
'        end dt_cancelamento',
'',
'from consulta_requisicoes c,',
'       PE_REQ_APURACAO r,',
'       parametros_recursos_humanos h',
' where upper(c.tipo_req) = ''REQ_APURA''',
'   and c.cod_empresa     = r.cod_empresa',
'   and h.cod_empresa = c.cod_empresa ',
'   and c.solicitacao     = r.cod_req',
'   and r.cod_empresa = :p203_emp',
'   and r.matricula   = :p203_mat',
'   and r.data_ponto between to_date(:P203_dt_ini_ap, ''dd/mm/rrrr'') and to_date(:P203_dt_fim_ap, ''dd/mm/rrrr'')',
' order by solicitacao desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P203_DT_INI_AP,P203_DT_FIM_AP'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(167429713078468886391)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>unistr('Nenhuma Requisi\00E7\00E3o Cadastrada.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:181:&SESSION.::&DEBUG.:181:P181_COD_REQ,P181_NOVA_REQUISICAO,P181_ID_APURACAO,P181_EMP,P181_MAT,P181_DATA_PONTO,P181_COD_EVENTO,P181_CONSULTA:#COD_SOLICITACAO#,#COD_SOLICITACAO#,#ID_APURACAO#,&P203_EMP.,&P203_MAT.,#DATA_PONTO#,#COD_EVENT'
||'O#,C'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">'
,p_owner=>'ANDRE.BONI'
,p_internal_uid=>92804836038022005
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713212462886392)
,p_db_column_name=>'REQUISICAO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713315043886393)
,p_db_column_name=>'DATA_ABERTURA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Data de Abertura'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713376092886394)
,p_db_column_name=>'EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713454654886395)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713624384886396)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Solicitante'
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA_SOLICITANTE#,#MAT_SOLICITANTE#'
,p_column_linktext=>'#SOLICITANTE#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713660114886397)
,p_db_column_name=>'SITUACAO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<span style="white-space:nowrap;">#SITUACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713813657886398)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429713889445886399)
,p_db_column_name=>'COD_EMPRESA_SOLICITANTE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Cod empresa solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429714036071886400)
,p_db_column_name=>'MAT_SOLICITANTE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Mat solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429714076976886401)
,p_db_column_name=>'MATRICULA_SOLICITADA'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Matr\00EDcula Solicitada')
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#MATRICULA_SOLICITADA#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429714235797886402)
,p_db_column_name=>'COD_SOLICITACAO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Cod solicitacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429714270945886403)
,p_db_column_name=>'MATRICULA'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429714357677886404)
,p_db_column_name=>'DATA_PONTO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Data Ponto'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(167429715031131886410)
,p_db_column_name=>'ID_APURACAO'
,p_display_order=>160
,p_column_identifier=>'R'
,p_column_label=>'Id Apuracao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165224602703852835087)
,p_db_column_name=>'COD_ITEM'
,p_display_order=>170
,p_column_identifier=>'S'
,p_column_label=>'Cod Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100094965142615061314)
,p_db_column_name=>'TIPO_EVENTO_ORIGINAL'
,p_display_order=>180
,p_column_identifier=>'Z'
,p_column_label=>'Tipo Evento Original'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100099425397560869265)
,p_db_column_name=>'EVENTO_ORIGINAL'
,p_display_order=>190
,p_column_identifier=>'AA'
,p_column_label=>'Evento Original'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100099425655303869268)
,p_db_column_name=>'COD_EVENTO'
,p_display_order=>220
,p_column_identifier=>'AD'
,p_column_label=>'Cod Evento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(95848681662250234565)
,p_db_column_name=>'EVENTO_SOLICITADO'
,p_display_order=>260
,p_column_identifier=>'AH'
,p_column_label=>'Evento Solicitado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(95848681719213234566)
,p_db_column_name=>'TIPO_EVENTO_SOLICITADO'
,p_display_order=>270
,p_column_identifier=>'AI'
,p_column_label=>'Tipo Evento Solicitado'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(95848681791637234567)
,p_db_column_name=>'HORAS_SOLICITADAS'
,p_display_order=>280
,p_column_identifier=>'AJ'
,p_column_label=>'Horas Solicitadas'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(95848681884127234568)
,p_db_column_name=>'HORAS_ORIGINAIS'
,p_display_order=>290
,p_column_identifier=>'AK'
,p_column_label=>'Horas Originais'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(33570358977920695970)
,p_db_column_name=>'USUARIO_CANCELAMENTO'
,p_display_order=>300
,p_column_identifier=>'AL'
,p_column_label=>'Usuario Cancelamento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(30820948909840127246)
,p_db_column_name=>'DT_CANCELAMENTO'
,p_display_order=>310
,p_column_identifier=>'AN'
,p_column_label=>'Dt Cancelamento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(167429730187673249472)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'928220'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REQUISICAO:DATA_ABERTURA:SITUACAO:EMPRESA:MATRICULA_SOLICITADA:DATA_PONTO:EMPRESA_SOLICITANTE:SOLICITANTE:EVENTO_ORIGINAL:TIPO_EVENTO_ORIGINAL::EVENTO_SOLICITADO:TIPO_EVENTO_SOLICITADO:HORAS_SOLICITADAS:HORAS_ORIGINAIS:USUARIO_CANCELAMENTO:DT_CANCELA'
||'MENTO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(189070540730273729839)
,p_plug_name=>'Tratativa de Abono'
,p_icon_css_classes=>'fa-user'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(199995576336262554931)
,p_plug_display_sequence=>110
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'<p></p>'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199669327573211064236)
,p_plug_name=>unistr('Marca\00E7\00F5es')
,p_region_name=>'marcacao'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(199995577391309554932)
,p_plug_display_sequence=>52
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct x.cod_empresa, ',
'x.matricula,',
'x.ordem,',
'x.tipo,',
'x.data,',
'x.dia,',
'nvl(x.hora_batida_1,''+'') hora_batida_11,',
'x.cod_justificativa_1,',
'x.comentarios_1,',
'x.cod_req_1,',
'nvl(x.hora_batida_2,''+'') hora_batida_21,',
'x.cod_justificativa_2,',
'x.comentarios_2,',
'x.cod_req_2,',
'nvl(x.hora_batida_3,''+'') hora_batida_31,',
'x.cod_justificativa_3,',
'x.comentarios_3,',
'x.cod_req_3,',
'nvl(x.hora_batida_4,''+'') hora_batida_41,',
'x.cod_justificativa_4,',
'x.comentarios_4,',
'x.cod_req_4,',
'nvl(x.hora_batida_5,''+'') hora_batida_51,',
'x.cod_justificativa_5,',
'x.comentarios_5,',
'x.cod_req_5,',
'nvl(x.hora_batida_6,''+'') hora_batida_61,',
'x.cod_justificativa_6,',
'x.comentarios_6,',
'x.cod_req_6,',
'nvl(x.hora_batida_7,''+'') hora_batida_71,',
'x.cod_justificativa_7,',
'x.comentarios_7,',
'x.cod_req_7,',
'nvl(x.hora_batida_8,''+'') hora_batida_81,',
'x.cod_justificativa_8,',
'x.comentarios_8,',
'x.cod_req_8,',
'nvl(x.hora_batida_9,''+'') hora_batida_91,',
'x.cod_justificativa_9,',
'x.comentarios_9,',
'x.cod_req_9,',
'nvl(x.hora_batida_10,''+'') hora_batida_101,',
'x.cod_justificativa_10,',
'x.comentarios_10,',
'x.cod_req_10,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||1||'',''||X.COD_REQ_1||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_1,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||2||'',''||X.COD_REQ_2||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_2,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||3||'',''||X.COD_REQ_3||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_3,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||4||'',''||X.COD_REQ_4||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_4,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||5||'',''||X.COD_REQ_5||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_5,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||6||'',''||X.COD_REQ_6||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_6,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||7||'',''||X.COD_REQ_7||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_7,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||8||'',''||X.COD_REQ_8||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_8,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||9||'',''||X.COD_REQ_9||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT_F'
||'IM||'',''||:P203_OPCAO) url_9,',
'apex_page.get_url(p_application => ''FREQ_LANC''||''_''||:p_base, p_page => 714, p_clear_cache => 714, p_items => ''P_PAINEL,P_USUARIO,P_EMPRESA_USER,P_MATRICULA_USER,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_REQ,P714_SEQ,P714_DTINI_ABONO,P714_DTF'
||'IM_ABONO,P714_OPCAO_PLANTAO'', p_values => :P_PAINEL||'',''||:P_USUARIO||'',''||:P_EMPRESA_USER||'',''||:P_MATRICULA_USER||'',''||X.COD_EMPRESA||'',''||X.MATRICULA||'',''||trunc(X.DATA)||'',''||10||'',''||X.COD_REQ_10||'',''||:P203_SEQ||'',''||:P203_DT_INI||'',''||:P203_DT'
||'_FIM) url_10,',
'''class="t-Button t-Button--''||x.divergente_1||'' t-Button--simple t-Button--stretch"'' class_1,',
'''class="t-Button t-Button--''||x.divergente_2||'' t-Button--simple t-Button--stretch"'' class_2,',
'''class="t-Button t-Button--''||x.divergente_3||'' t-Button--simple t-Button--stretch"'' class_3,',
'''class="t-Button t-Button--''||x.divergente_4||'' t-Button--simple t-Button--stretch"'' class_4,',
'''class="t-Button t-Button--''||x.divergente_5||'' t-Button--simple t-Button--stretch"'' class_5,',
'''class="t-Button t-Button--''||x.divergente_6||'' t-Button--simple t-Button--stretch"'' class_6,',
'''class="t-Button t-Button--''||x.divergente_7||'' t-Button--simple t-Button--stretch"'' class_7,',
'''class="t-Button t-Button--''||x.divergente_8||'' t-Button--simple t-Button--stretch"'' class_8,',
'''class="t-Button t-Button--''||x.divergente_9||'' t-Button--simple t-Button--stretch"'' class_9,',
'''class="t-Button t-Button--''||x.divergente_10||'' t-Button--simple t-Button--stretch"'' class_10',
'from (',
'select distinct t.cod_empresa, ',
't.matricula, ',
't.ordem,',
'case t.tipo ',
'    when ''F'' then',
'    ''Final''',
'    when ''O'' then',
'    ''Original''',
'    when ''T'' then',
'    ''Todos''',
'    when ''R'' then',
unistr('    ''Requisi\00E7\00E3o'''),
'    when ''P'' then',
unistr('    ''Plant\00E3o Original'''),
'    when ''Q'' then',
unistr('    ''Plant\00E3o Abonado'''),
'    when ''Z'' then',
unistr('    ''Plant\00E3o Final'''),
'    else',
'    ''Todos''',
'    end  tipo, ',
't.data, ',
'decode(Fnct_Pe_Retorna_Situacao(t.cod_empresa, t.matricula, t.data),null,',
'       decode(nvl(pkg_pe_abono.RETORNA_FOLGA_FERIADO(t.cod_empresa, t.matricula, t.data),null),null,to_char(t.data,''dy''),to_char(t.data,''dy'')||'' - ''||',
'              pkg_pe_abono.RETORNA_FOLGA_FERIADO(cod_empresa, matricula, data)),substr(Fnct_Pe_Retorna_Situacao(t.cod_empresa, t.matricula, t.data), 1,20)) dia,',
'',
'nvl(to_char(nvl(t.hora_batida_abono_1,t.hora_batida_1),''hh24:mi'') , decode(t.cod_justificativa_1, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_1, t.cod_justificativa_1, t.comentarios_1,',
'nvl(to_char(nvl(t.hora_batida_abono_2,t.hora_batida_2),''hh24:mi'') , decode(t.cod_justificativa_2, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_2, t.cod_justificativa_2, t.comentarios_2,',
'nvl(to_char(nvl(t.hora_batida_abono_3,t.hora_batida_3),''hh24:mi'') , decode(t.cod_justificativa_3, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_3, t.cod_justificativa_3, t.comentarios_3,',
'nvl(to_char(nvl(t.hora_batida_abono_4,t.hora_batida_4),''hh24:mi'') , decode(t.cod_justificativa_4, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_4, t.cod_justificativa_4, t.comentarios_4,',
'nvl(to_char(nvl(t.hora_batida_abono_5,t.hora_batida_5),''hh24:mi'') , decode(t.cod_justificativa_5, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_5, t.cod_justificativa_5, t.comentarios_5,',
'nvl(to_char(nvl(t.hora_batida_abono_6,t.hora_batida_6),''hh24:mi'') , decode(t.cod_justificativa_6, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_6, t.cod_justificativa_6, t.comentarios_6,',
'nvl(to_char(nvl(t.hora_batida_abono_7,t.hora_batida_7),''hh24:mi'') , decode(t.cod_justificativa_7, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_7, t.cod_justificativa_7, t.comentarios_7,',
'nvl(to_char(nvl(t.hora_batida_abono_8,t.hora_batida_8),''hh24:mi'') , decode(t.cod_justificativa_8, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_8, t.cod_justificativa_8, t.comentarios_8,',
'nvl(to_char(nvl(t.hora_batida_abono_9,t.hora_batida_9),''hh24:mi'') , decode(t.cod_justificativa_9, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_9, t.cod_justificativa_9, t.comentarios_9,',
'nvl(to_char(nvl(t.hora_batida_abono_10,t.hora_batida_10),''hh24:mi'') , decode(t.cod_justificativa_10, null, null, pkg_espelho_ponto.CF_JUST(t.cod_empresa, t.matricula, t.data))) hora_batida_10, t.cod_justificativa_10, t.comentarios_10,',
'/*  Ajuste comentando estas colunas abaixo - Andre - 01-04-2024  ',
'to_char(t.hora_batida_1,''hh24:mi'') hora_batida_1, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_1) cod_justificativa_1, t.comentarios_1,',
'to_char(t.hora_batida_2,''hh24:mi'') hora_batida_2, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_2) cod_justificativa_2, t.comentarios_2,',
'to_char(t.hora_batida_3,''hh24:mi'') hora_batida_3, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_3) cod_justificativa_3, t.comentarios_3,',
'to_char(t.hora_batida_4,''hh24:mi'') hora_batida_4, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_4) cod_justificativa_4, t.comentarios_4,',
'to_char(t.hora_batida_5,''hh24:mi'') hora_batida_5, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_5) cod_justificativa_5, t.comentarios_5,',
'to_char(t.hora_batida_6,''hh24:mi'') hora_batida_6, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_6) cod_justificativa_6, t.comentarios_6,',
'to_char(t.hora_batida_7,''hh24:mi'') hora_batida_7, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_7) cod_justificativa_7, t.comentarios_7,',
'to_char(t.hora_batida_8,''hh24:mi'') hora_batida_8, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_8) cod_justificativa_8, t.comentarios_8,',
'to_char(t.hora_batida_9,''hh24:mi'') hora_batida_9, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_9) cod_justificativa_9, t.comentarios_9,',
'to_char(t.hora_batida_10,''hh24:mi'') hora_batida_10, fnct_nome_pe_justificativa(t.cod_empresa, t.cod_justificativa_10) cod_justificativa_10, t.comentarios_10,',
'*/',
't.cod_req_1,',
't.cod_req_2,',
't.cod_req_3,',
't.cod_req_4,',
't.cod_req_5,',
't.cod_req_6,',
't.cod_req_7,',
't.cod_req_8,',
't.cod_req_9,',
't.cod_req_10,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_1, 1, t.cod_jornada) divergente_1,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_2, 2, t.cod_jornada) divergente_2,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_3, 3, t.cod_jornada) divergente_3,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_4, 4, t.cod_jornada) divergente_4,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_5, 5, t.cod_jornada) divergente_5,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_6, 6, t.cod_jornada) divergente_6,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_7, 7, t.cod_jornada) divergente_7,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_8, 8, t.cod_jornada) divergente_8,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_9, 9, t.cod_jornada) divergente_9,',
'PKG_PE_ABONO.fnct_pe_retorna_div_class_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_10, 10, t.cod_jornada) divergente_10',
'from pe_abono_batidas_seq_aux t',
'where t.seq = :P203_SEQ',
'and  ((t.tipo = :P203_OPCAO and t.tipo != ''T'') or (:P203_OPCAO = ''T''))',
'and ((nvl(:p203_divergente,''N'') = ''S'' and ',
'((PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_1, 1, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_2, 2, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_3, 3, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_4, 4, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_5, 5, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_6, 6, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_7, 7, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_8, 8, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_9, 9, t.cod_jornada) = ''S'') or',
'(PKG_PE_ABONO.fnct_pe_retorna_divergente_plt (t.cod_empresa, t.matricula, t.data, t.hora_batida_10, 10, t.cod_jornada) = ''S''))) ',
'or (nvl(:p203_divergente,''N'') = ''N''))',
'',
' --and  t.cod_empresa = :P203_EMP',
' --and  t.matricula  = :P203_MAT',
') x,',
'parametros_recursos_humanos p',
'where x.cod_empresa = p.cod_empresa',
'and   x.tipo != ''Todos''',
'and ((:p_painel = ''PO'') or (x.data between nvl(p.dt_ini_ponto_gestor,x.data) and nvl(p.dt_fim_ponto_gestor,x.data))',
'    OR (:p_painel = ''PC'') or (x.data between nvl(p.dt_ini_ponto_colab,x.data) and nvl(p.dt_fim_ponto_colab,x.data))',
'    OR (:p_painel = ''PG'') or (x.data between nvl(p.dt_ini_ponto_gestor,x.data) and nvl(p.dt_fim_ponto_gestor,x.data))',
'    )',
'--and ((:p_painel = ''PO'') or (x.data >= nvl(p.dt_ini_ponto_gestor,x.data)))',
'order by 1,2,5,3',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_SEQ,P203_OPCAO,P203_DIVERGENTE'
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(199669757916937846139)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'+'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_search_textbox=>'N'
,p_show_actions_menu=>'N'
,p_report_list_mode=>'NONE'
,p_show_detail_link=>'N'
,p_owner=>'IGOR'
,p_internal_uid=>13136711007666484865
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435828978517409111)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435829397966409112)
,p_db_column_name=>'MATRICULA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435829748846409113)
,p_db_column_name=>'ORDEM'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Ordem'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435830191699409114)
,p_db_column_name=>'TIPO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435830535388409114)
,p_db_column_name=>'DATA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Data'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435830969319409115)
,p_db_column_name=>'DIA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Dia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435832169532409117)
,p_db_column_name=>'COMENTARIOS_1'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Comentarios 1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435833315246409118)
,p_db_column_name=>'COMENTARIOS_2'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Comentarios 2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435834595308409120)
,p_db_column_name=>'COMENTARIOS_3'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Comentarios 3'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435835766411409122)
,p_db_column_name=>'COMENTARIOS_4'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Comentarios 4'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435836933405409124)
,p_db_column_name=>'COMENTARIOS_5'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Comentarios 5'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435838136345409126)
,p_db_column_name=>'COMENTARIOS_6'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Comentarios 6'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435839354978409129)
,p_db_column_name=>'COMENTARIOS_7'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Comentarios 7'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435840563314409131)
,p_db_column_name=>'COMENTARIOS_8'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>'Comentarios 8'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435841801847409134)
,p_db_column_name=>'COMENTARIOS_9'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>'Comentarios 9'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435842998895409137)
,p_db_column_name=>'COMENTARIOS_10'
,p_display_order=>360
,p_column_identifier=>'AJ'
,p_column_label=>'Comentarios 10'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435843405822409137)
,p_db_column_name=>'COD_REQ_1'
,p_display_order=>370
,p_column_identifier=>'AK'
,p_column_label=>'Cod req 1'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435843736034409138)
,p_db_column_name=>'COD_REQ_2'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>'Cod req 2'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435844141364409139)
,p_db_column_name=>'COD_REQ_3'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Cod req 3'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435844527669409140)
,p_db_column_name=>'COD_REQ_4'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'Cod req 4'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435844907115409141)
,p_db_column_name=>'COD_REQ_5'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'Cod req 5'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435845280953409141)
,p_db_column_name=>'COD_REQ_6'
,p_display_order=>420
,p_column_identifier=>'AP'
,p_column_label=>'Cod req 6'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435845627132409142)
,p_db_column_name=>'COD_REQ_7'
,p_display_order=>430
,p_column_identifier=>'AQ'
,p_column_label=>'Cod req 7'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435846096004409142)
,p_db_column_name=>'COD_REQ_8'
,p_display_order=>440
,p_column_identifier=>'AR'
,p_column_label=>'Cod req 8'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435846476177409143)
,p_db_column_name=>'COD_REQ_9'
,p_display_order=>450
,p_column_identifier=>'AS'
,p_column_label=>'Cod req 9'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435846813946409144)
,p_db_column_name=>'COD_REQ_10'
,p_display_order=>460
,p_column_identifier=>'AT'
,p_column_label=>'Cod req 10'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435847258187409145)
,p_db_column_name=>'CLASS_1'
,p_display_order=>570
,p_column_identifier=>'BE'
,p_column_label=>'Class 1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435847645870409145)
,p_db_column_name=>'CLASS_2'
,p_display_order=>580
,p_column_identifier=>'BF'
,p_column_label=>'Class 2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435848025263409146)
,p_db_column_name=>'CLASS_3'
,p_display_order=>590
,p_column_identifier=>'BG'
,p_column_label=>'Class 3'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435848439247409147)
,p_db_column_name=>'CLASS_4'
,p_display_order=>600
,p_column_identifier=>'BH'
,p_column_label=>'Class 4'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435848834590409147)
,p_db_column_name=>'CLASS_5'
,p_display_order=>610
,p_column_identifier=>'BI'
,p_column_label=>'Class 5'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435849300724409148)
,p_db_column_name=>'CLASS_6'
,p_display_order=>620
,p_column_identifier=>'BJ'
,p_column_label=>'Class 6'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435849696183409149)
,p_db_column_name=>'CLASS_7'
,p_display_order=>630
,p_column_identifier=>'BK'
,p_column_label=>'Class 7'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435850020316409150)
,p_db_column_name=>'CLASS_8'
,p_display_order=>640
,p_column_identifier=>'BL'
,p_column_label=>'Class 8'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435850473937409150)
,p_db_column_name=>'CLASS_9'
,p_display_order=>650
,p_column_identifier=>'BM'
,p_column_label=>'Class 9'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435850826752409151)
,p_db_column_name=>'CLASS_10'
,p_display_order=>660
,p_column_identifier=>'BN'
,p_column_label=>'Class 10'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435851298364409151)
,p_db_column_name=>'URL_1'
,p_display_order=>670
,p_column_identifier=>'BO'
,p_column_label=>'Url 1'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435851648280409152)
,p_db_column_name=>'URL_2'
,p_display_order=>680
,p_column_identifier=>'BP'
,p_column_label=>'Url 2'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435852012514409152)
,p_db_column_name=>'URL_3'
,p_display_order=>690
,p_column_identifier=>'BQ'
,p_column_label=>'Url 3'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435852457499409153)
,p_db_column_name=>'URL_4'
,p_display_order=>700
,p_column_identifier=>'BR'
,p_column_label=>'Url 4'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435852867572409154)
,p_db_column_name=>'URL_5'
,p_display_order=>710
,p_column_identifier=>'BS'
,p_column_label=>'Url 5'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435853285843409154)
,p_db_column_name=>'URL_6'
,p_display_order=>720
,p_column_identifier=>'BT'
,p_column_label=>'Url 6'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435853700747409155)
,p_db_column_name=>'URL_7'
,p_display_order=>730
,p_column_identifier=>'BU'
,p_column_label=>'Url 7'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435854027763409156)
,p_db_column_name=>'URL_8'
,p_display_order=>740
,p_column_identifier=>'BV'
,p_column_label=>'Url 8'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435854428960409157)
,p_db_column_name=>'URL_9'
,p_display_order=>750
,p_column_identifier=>'BW'
,p_column_label=>'Url 9'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435854829846409157)
,p_db_column_name=>'URL_10'
,p_display_order=>760
,p_column_identifier=>'BX'
,p_column_label=>'Url 10'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170001676024446431)
,p_db_column_name=>'HORA_BATIDA_11'
,p_display_order=>870
,p_column_identifier=>'DC'
,p_column_label=>'1'
,p_column_link=>'#URL_1#'
,p_column_linktext=>'#HORA_BATIDA_11#'
,p_column_link_attr=>'#CLASS_1#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170001738575446432)
,p_db_column_name=>'HORA_BATIDA_21'
,p_display_order=>880
,p_column_identifier=>'DD'
,p_column_label=>'2'
,p_column_link=>'#URL_2#'
,p_column_linktext=>'#HORA_BATIDA_21#'
,p_column_link_attr=>'#CLASS_2#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170001889356446433)
,p_db_column_name=>'HORA_BATIDA_31'
,p_display_order=>890
,p_column_identifier=>'DE'
,p_column_label=>'3'
,p_column_link=>'#URL_3#'
,p_column_linktext=>'#HORA_BATIDA_31#'
,p_column_link_attr=>'#CLASS_3#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170001920031446434)
,p_db_column_name=>'HORA_BATIDA_41'
,p_display_order=>900
,p_column_identifier=>'DF'
,p_column_label=>'4'
,p_column_link=>'#URL_4#'
,p_column_linktext=>'#HORA_BATIDA_41#'
,p_column_link_attr=>'#CLASS_4#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002019122446435)
,p_db_column_name=>'HORA_BATIDA_51'
,p_display_order=>910
,p_column_identifier=>'DG'
,p_column_label=>'5'
,p_column_link=>'#URL_5#'
,p_column_linktext=>'#HORA_BATIDA_51#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002136923446436)
,p_db_column_name=>'HORA_BATIDA_61'
,p_display_order=>920
,p_column_identifier=>'DH'
,p_column_label=>'6'
,p_column_link=>'#URL_6#'
,p_column_linktext=>'#HORA_BATIDA_61#'
,p_column_link_attr=>'#COD_REQ_6#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002201953446437)
,p_db_column_name=>'HORA_BATIDA_71'
,p_display_order=>930
,p_column_identifier=>'DI'
,p_column_label=>'7'
,p_column_link=>'#URL_7#'
,p_column_linktext=>'#HORA_BATIDA_71#'
,p_column_link_attr=>'#CLASS_7#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002372294446438)
,p_db_column_name=>'HORA_BATIDA_81'
,p_display_order=>940
,p_column_identifier=>'DJ'
,p_column_label=>'8'
,p_column_link=>'#URL_8#'
,p_column_linktext=>'#HORA_BATIDA_81#'
,p_column_link_attr=>'#CLASS_8#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002458447446439)
,p_db_column_name=>'HORA_BATIDA_91'
,p_display_order=>950
,p_column_identifier=>'DK'
,p_column_label=>'9'
,p_column_link=>'#URL_9#'
,p_column_linktext=>'#HORA_BATIDA_91#'
,p_column_link_attr=>'#CLASS_9#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145170002539110446440)
,p_db_column_name=>'HORA_BATIDA_101'
,p_display_order=>960
,p_column_identifier=>'DL'
,p_column_label=>'10'
,p_column_link=>'#URL_10#'
,p_column_linktext=>'#HORA_BATIDA_101#'
,p_column_link_attr=>'#CLASS_10#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144563724163864230474)
,p_db_column_name=>'COD_JUSTIFICATIVA_1'
,p_display_order=>970
,p_column_identifier=>'EA'
,p_column_label=>'Cod Justificativa 1'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144563724257852230475)
,p_db_column_name=>'COD_JUSTIFICATIVA_2'
,p_display_order=>980
,p_column_identifier=>'EB'
,p_column_label=>'Cod Justificativa 2'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166051028178826)
,p_db_column_name=>'COD_JUSTIFICATIVA_3'
,p_display_order=>990
,p_column_identifier=>'EC'
,p_column_label=>'Cod Justificativa 3'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166121467178827)
,p_db_column_name=>'COD_JUSTIFICATIVA_4'
,p_display_order=>1000
,p_column_identifier=>'ED'
,p_column_label=>'Cod Justificativa 4'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166278174178828)
,p_db_column_name=>'COD_JUSTIFICATIVA_5'
,p_display_order=>1010
,p_column_identifier=>'EE'
,p_column_label=>'Cod Justificativa 5'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166375854178829)
,p_db_column_name=>'COD_JUSTIFICATIVA_6'
,p_display_order=>1020
,p_column_identifier=>'EF'
,p_column_label=>'Cod Justificativa 6'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166489671178830)
,p_db_column_name=>'COD_JUSTIFICATIVA_7'
,p_display_order=>1030
,p_column_identifier=>'EG'
,p_column_label=>'Cod Justificativa 7'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166582261178831)
,p_db_column_name=>'COD_JUSTIFICATIVA_8'
,p_display_order=>1040
,p_column_identifier=>'EH'
,p_column_label=>'Cod Justificativa 8'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166637219178832)
,p_db_column_name=>'COD_JUSTIFICATIVA_9'
,p_display_order=>1050
,p_column_identifier=>'EI'
,p_column_label=>'Cod Justificativa 9'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(144451166702034178833)
,p_db_column_name=>'COD_JUSTIFICATIVA_10'
,p_display_order=>1060
,p_column_identifier=>'EJ'
,p_column_label=>'Cod Justificativa 10'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(199669897584287064438)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9028083'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:MATRICULA:ORDEM:TIPO:DATA:DIA:COD_COMENTARIOS_1:COMENTARIOS_2:COMENTARIOS_3:COMENTARIOS_4:COMENTARIOS_5:COMENTARIOS_6:COMENTARIOS_7:COMENTARIOS_8:COMENTARIOS_900:COMENTARIOS_10:COD_REQ_1:COD_REQ_2:COD_REQ_3:COD_REQ_4:COD_REQ_5:COD_REQ_6:C'
||'OD_REQ_7:COD_REQ_8:COD_REQ_9:COD_REQ_10:CLASS_1:CLASS_2:CLASS_3:CLASS_4:CLASS_5:CLASS_6:CLASS_7:CLASS_8:CLASS_9:CLASS_10:URL_1:URL_2:URL_3:URL_4:URL_5:URL_6:URL_7:URL_8:URL_9:URL_10:HORA_BATIDA_11:HORA_BATIDA_21:HORA_BATIDA_31:HORA_BATIDA_41:HORA_BAT'
||'IDA_51:HORA_BATIDA_61:HORA_BATIDA_71:HORA_BATIDA_81:HORA_BATIDA_91:HORA_BATIDA_101'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(200969618168090049864)
,p_plug_name=>'Selecionar Colaborador'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(199995576480671554931)
,p_plug_display_sequence=>112
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202146973198159595208)
,p_plug_name=>unistr('Hist\00F3rico de Apura\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size720x480'
,p_plug_template=>wwv_flow_api.id(199995576480671554931)
,p_plug_display_sequence=>102
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(202146973363300595209)
,p_name=>unistr('Hist\00F3rico de Apura\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(202146973198159595208)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select h.data, ',
'       h.posicao, ',
'       (select b.cod_evento_banco||'' - ''||b.descricao',
'          from pe_eventos_banco b',
'         where b.cod_evento_banco = h.cod_evento_ant',
'           and b.cod_empresa = h.cod_empresa',
'           and h.tipo_evento_ant = ''BANCO''',
'         UNION',
'        select f.cod_evento_folha||'' - ''||f.descricao',
'          from pe_eventos_folha f',
'         where f.cod_evento_folha = h.cod_evento_ant',
'           and f.cod_empresa = h.cod_empresa',
'           and h.tipo_evento_ant = ''PONTO'') cod_evento_ant,',
'       h.tipo_evento_ant, ',
'       h.qtd_horas_ant, ',
'       (select b.cod_evento_banco||'' - ''||b.descricao',
'          from pe_eventos_banco b',
'         where B.cod_empresa = H.cod_empresa',
'           AND b.cod_evento_banco = h.cod_evento',
'           and h.tipo_evento = ''BANCO''',
'         UNION',
'        select f.cod_evento_folha||'' - ''||f.descricao',
'          from pe_eventos_folha f',
'         where F.cod_empresa = H.cod_empresa',
'           AND f.cod_evento_folha = h.cod_evento',
'           and h.tipo_evento = ''PONTO'') cod_evento,',
'       h.tipo_evento, ',
'       h.qtd_horas, ',
'       h.diferenca_qtd_horas, ',
'	   h.saldo_reman,',
'	   h.saldo_reman_ant,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.usuario',
'        else',
'            null',
'        end usuario_cancelamento,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.dt_atualizacao',
'        else',
'            null',
'        end dt_cancelamento',
'',
'  from pe_req_apuracao  r, PE_HIST_RESUL_APURACAO h',
' where h.cod_empresa = :p203_emp',
'   and h.matricula = :p203_mat',
'   and h.data between :p203_dt_ini and :p203_dt_fim',
'   and h.cod_empresa = r.cod_empresa (+)',
'   and h.cod_req = r.cod_req (+)',
'order by h.cod_empresa, h.matricula, h.data, h.posicao'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('Nenhum Dado Encontrado, Verifique o Per\00EDodo Selecionado.')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435862589724409174)
,p_query_column_id=>1
,p_column_alias=>'DATA'
,p_column_display_sequence=>1
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435862916969409175)
,p_query_column_id=>2
,p_column_alias=>'POSICAO'
,p_column_display_sequence=>2
,p_column_heading=>unistr('Posi\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435863373439409175)
,p_query_column_id=>3
,p_column_alias=>'COD_EVENTO_ANT'
,p_column_display_sequence=>3
,p_column_heading=>'Evento Anterior'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435863717300409176)
,p_query_column_id=>4
,p_column_alias=>'TIPO_EVENTO_ANT'
,p_column_display_sequence=>4
,p_column_heading=>'Tipo de Evento Anterior'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435864205063409176)
,p_query_column_id=>5
,p_column_alias=>'QTD_HORAS_ANT'
,p_column_display_sequence=>5
,p_column_heading=>'Qtd. Horas Anterior'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435864593529409177)
,p_query_column_id=>6
,p_column_alias=>'COD_EVENTO'
,p_column_display_sequence=>6
,p_column_heading=>'Evento Atual'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435864995963409177)
,p_query_column_id=>7
,p_column_alias=>'TIPO_EVENTO'
,p_column_display_sequence=>7
,p_column_heading=>'Tipo de Evento Atual'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435865389240409177)
,p_query_column_id=>8
,p_column_alias=>'QTD_HORAS'
,p_column_display_sequence=>8
,p_column_heading=>'Qtd. Horas Atual'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435865718510409178)
,p_query_column_id=>9
,p_column_alias=>'DIFERENCA_QTD_HORAS'
,p_column_display_sequence=>9
,p_column_heading=>unistr('Diferen\00E7a de Qtd. Horas')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(183447883923284975624)
,p_query_column_id=>10
,p_column_alias=>'SALDO_REMAN'
,p_column_display_sequence=>10
,p_column_heading=>'Saldo Remanescente'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(183447883967711975625)
,p_query_column_id=>11
,p_column_alias=>'SALDO_REMAN_ANT'
,p_column_display_sequence=>11
,p_column_heading=>'Saldo Reman. Anterior'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(32195229601235145148)
,p_query_column_id=>12
,p_column_alias=>'USUARIO_CANCELAMENTO'
,p_column_display_sequence=>12
,p_column_heading=>'Usuario Cancelamento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(32195229676497145149)
,p_query_column_id=>13
,p_column_alias=>'DT_CANCELAMENTO'
,p_column_display_sequence=>13
,p_column_heading=>'Dt Cancelamento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211073970831086503668)
,p_plug_name=>unistr('Requisi\00E7\00F5es de Hora Extra')
,p_region_name=>'REQUISICAO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>82
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'V_RESULTADO BOOLEAN;',
'',
'begin',
'',
unistr('v_resultado := pkg_acesso_po.fnct_botao(138, :P_USUARIO,NULL,''REQUISI\00C7\00D5ES'');'),
'',
'return v_resultado;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211073970950870503669)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Hora Extra')
,p_parent_plug_id=>wwv_flow_api.id(211073970831086503668)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(199995577391309554932)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       c.solicitacao requisicao,',
'       c.dt_solicitacao data_abertura,',
'       c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) Empresa, ',
'       r.matricula||'' - ''||initcap(fnct_nome_func(r.cod_empresa, r.matricula)) Matricula_Solicitada,',
'       c.cod_empresa_solicitante||'' - ''||Initcap(fnct_nome_empresa(c.cod_empresa_solicitante)) Empresa_Solicitante,',
'       c.mat_solicitante||'' - ''||initcap(fnct_nome_func(c.cod_empresa_solicitante, c.mat_solicitante)) Solicitante,',
'       decode(cod_sit_req,1,''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Aberta'',',
unistr('                            2,''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Conclu\00EDda'','),
'                            3,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada'',',
'                            4,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada'',',
'                            5,''<span aria-hidden="true" class="fa fa-check-circle colorInfo"></span> ''||''Aprovada'',',
unistr('                            6,''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||''Suspens\00E3o'') Situacao,'),
'       r.cod_empresa,',
'       r.cod_req cod_solicitacao,',
'       c.cod_empresa_solicitante,',
'       c.mat_solicitante,',
'       r.matricula,',
'       r.data_ponto,',
'       r.hora_inicial,',
'       r.hora_final',
'  from consulta_requisicoes c,',
'       PE_REQ_HORA_EXTRA r',
' where upper(c.tipo_req) = ''REQ_HE''',
'   and c.cod_empresa     = r.cod_empresa',
'   and c.solicitacao     = r.cod_req',
'   and r.cod_empresa = :p203_emp',
'   and r.matricula   = :p203_mat',
'   and r.data_ponto between to_date(:P203_dt_ini_he, ''dd/mm/rrrr'') and to_date(:P203_dt_fim_he, ''dd/mm/rrrr'')',
' order by solicitacao desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P203_DT_INI_HE,P203_DT_FIM_HE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(211073971088348503670)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>unistr('Nenhuma Requisi\00E7\00E3o Cadastrada.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:716:&SESSION.::&DEBUG.:716:P716_COD_REQ,P716_EMP,P716_MAT,P716_DATA_PONTO:#REQUISICAO#,#COD_EMPRESA#,#MATRICULA#,#DATA_PONTO#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">'
,p_owner=>'IGOR'
,p_internal_uid=>24540924179077142396
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435867520116409180)
,p_db_column_name=>'REQUISICAO'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435868005088409181)
,p_db_column_name=>'DATA_ABERTURA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Data de Abertura'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435868386260409181)
,p_db_column_name=>'EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435868719436409182)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435869178706409182)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Solicitante'
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA_SOLICITANTE#,#MAT_SOLICITANTE#'
,p_column_linktext=>'#SOLICITANTE#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435869604327409182)
,p_db_column_name=>'SITUACAO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<span style="white-space:nowrap;">#SITUACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435869974870409183)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435870408995409183)
,p_db_column_name=>'COD_EMPRESA_SOLICITANTE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Cod empresa solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435870777774409184)
,p_db_column_name=>'MAT_SOLICITANTE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Mat solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435871173374409184)
,p_db_column_name=>'MATRICULA_SOLICITADA'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Matr\00EDcula Solicitada')
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#MATRICULA_SOLICITADA#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435871550057409184)
,p_db_column_name=>'COD_SOLICITACAO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Cod solicitacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435871910964409185)
,p_db_column_name=>'MATRICULA'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435872379395409185)
,p_db_column_name=>'DATA_PONTO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Data Ponto'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435872754346409185)
,p_db_column_name=>'HORA_INICIAL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Hora inicial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435873137551409186)
,p_db_column_name=>'HORA_FINAL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Hora final'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(211086896253593420666)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9028266'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REQUISICAO:DATA_ABERTURA:SITUACAO:EMPRESA:MATRICULA_SOLICITADA:DATA_PONTO:HORA_INICIAL:HORA_FINAL:EMPRESA_SOLICITANTE:SOLICITANTE:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211084760904438861010)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>32
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211084764485776861017)
,p_plug_name=>unistr('Consolida\00E7\00E3o (Apura\00E7\00E3o)')
,p_region_name=>'rgnSticky'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>62
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(167417859387957134215)
,p_name=>unistr('Requisi\00E7\00F5es de Apura\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(211084764485776861017)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'    r.cod_evento||'' - ''||b.descricao descricao,',
unistr('    decode(b.tipo,''C'',''Cr\00E9dito'',''D'',''D\00E9bito'') tipo, '),
'    r.qtd_horas,',
'    Initcap(r.tipo_evento) tipo_evento, ',
'    decode(r.bh_apurado,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'',r.bh_apurado) bh_apurado_desc,',
'    r.cod_req',
'    /*                 ',
'       r.cod_evento, ',
'       c.solicitacao requisicao,',
'       c.dt_solicitacao data_abertura,',
'       c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) Empresa, ',
'       r.matricula||'' - ''||initcap(fnct_nome_func(r.cod_empresa, r.matricula)) Matricula_Solicitada,',
'       c.cod_empresa_solicitante||'' - ''||Initcap(fnct_nome_empresa(c.cod_empresa_solicitante)) Empresa_Solicitante,',
'       c.mat_solicitante||'' - ''||initcap(fnct_nome_func(c.cod_empresa_solicitante, c.mat_solicitante)) Solicitante,',
'       decode(cod_sit_req,1,''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Aberta'',',
unistr('                            2,''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Conclu\00EDda'','),
'                            3,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada'',',
'                            4,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada'',',
'                            5,''<span aria-hidden="true" class="fa fa-check-circle colorInfo"></span> ''||''Aprovada'',',
unistr('                            6,''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||''Suspens\00E3o'') Situacao,'),
'       r.cod_empresa,',
'       r.cod_req cod_solicitacao,',
'       c.cod_empresa_solicitante,',
'       c.mat_solicitante,',
'       r.matricula,',
'       r.data_ponto,',
'       r.hora_inicial,',
'       r.hora_final*/',
'  from consulta_requisicoes c,',
'       NATCORP.PE_REQ_APURACAO r,',
'       pe_eventos_banco b',
' where 1=1 ',
'  AND  r.cod_empresa = b.cod_empresa ',
'AND r.cod_evento = b.cod_evento_banco ',
' AND upper(c.tipo_req) = ''REQ_APURA''',
'   and c.cod_empresa     = r.cod_empresa',
'   and c.solicitacao     = r.cod_req',
'   and cod_sit_req       = 1',
'   and r.cod_empresa = :p203_emp',
'   and r.mat_req   = :p203_mat',
' order by cod_req desc',
' '))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DATA'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('Nenhuma Requisi\00E7\00E3o de Apura\00E7\00E3o Para Essa Data')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425962631900361000)
,p_query_column_id=>1
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>2
,p_column_heading=>'Descricao'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425962678887361001)
,p_query_column_id=>2
,p_column_alias=>'TIPO'
,p_column_display_sequence=>3
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425962749053361002)
,p_query_column_id=>3
,p_column_alias=>'QTD_HORAS'
,p_column_display_sequence=>4
,p_column_heading=>'Qtd Horas'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425962936529361003)
,p_query_column_id=>4
,p_column_alias=>'TIPO_EVENTO'
,p_column_display_sequence=>5
,p_column_heading=>'Tipo Evento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425962961582361004)
,p_query_column_id=>5
,p_column_alias=>'BH_APURADO_DESC'
,p_column_display_sequence=>6
,p_column_heading=>'Bh Apurado Desc'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425963068047361005)
,p_query_column_id=>6
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167417861112386134232)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:181:&SESSION.::&DEBUG.:RP,181:P181_EMP,P181_MAT,P181_COD_REQ:&P203_COD_EMPRESA.,&P203_MATRICULA.,#COD_REQ##COD_EMPRESA#,#MATRICULA##COD_ITEM#,#ID_APURACAO#,&P203_DATA.'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_condition=>'P_PAINEL'
,p_display_when_condition2=>'PC'
,p_report_column_width=>10
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(185052902906641277549)
,p_name=>unistr('Per\00EDodo')
,p_parent_plug_id=>wwv_flow_api.id(211084764485776861017)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with',
'    TP_C as (',
'        select  B.TIPO,',
'                A.COD_EVENTO,',
'                B.DESCRICAO,',
'                A.TIPO_EVENTO,',
'                A.BH_APURADO,',
'                A.PLANTAO,',
'                sum(substr(A.QTD_HORAS,1,instr(A.QTD_HORAS,'':'')-1)) HORAS,',
'                sum(substr(A.QTD_HORAS,instr(A.QTD_HORAS,'':'')+1) ) MINUTOS,',
'                X.ULTIMO_DIA',
'        from    PE_RESULTADO_APURACAO A,',
'                PE_EVENTOS_BANCO B,',
'                (SELECT MAX(NVL(VIRA_DIA,DATA_PONTO)) ULTIMO_DIA',
'                 FROM PE_TRATAMENTO_BATIMENTOS',
'                 WHERE COD_EMPRESA = :p203_emp',
'                  AND  MATRICULA = :p203_mat',
'                  AND  NVL(VIRA_DIA,DATA_PONTO) BETWEEN to_date(:P203_DT_INI,''DD/MM/YYYY'') and to_date(:P203_DT_FIM,''DD/MM/YYYY'')',
'                  ) X',
'        where   A.COD_EMPRESA = :P203_EMP',
'        and     A.MATRICULA = :P203_MAT',
'        AND     A.ID_APURACAO != 9020',
'       AND ((EXISTS (SELECT DISTINCT 1 ',
'                      FROM PE_JORNADAS ',
'                     WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, X.ULTIMO_DIA, ''S''), FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DT_FIM, ''N''))',
'                      AND (TIPO_JORNADA = 2 AND A.ID_APURACAO > 9000 ))',
'                      AND a.DATA = :P203_DT_FIM_PERIODO)',
'            OR (EXISTS(SELECT DISTINCT 1 ',
'                      FROM PE_JORNADAS ',
'                     WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DATA, ''N''))',
'                      AND (TIPO_JORNADA != 2 ))',
'                      AND A.DATA  between to_date(:P203_DT_INI_PERIODO,''DD/MM/YYYY'') and to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY''))',
'           )',
'        and     (A.TIPO_EVENTO = ''BANCO'')',
'        and     A.COD_EMPRESA = B.COD_EMPRESA',
'        and     A.COD_EVENTO = B.COD_EVENTO_BANCO',
'        --AND NVL(A.PLANTAO,''N'') =  DECODE(:P203_OPCAO'', ''P'', ''S'', ''Q'', ''S'', ''N'')',
'            AND (NVL(A.PLANTAO,''N'') = ''N'' AND :P203_OPCAO NOT IN (''P'', ''Q'')',
'                     OR A.PLANTAO = ''S'' AND :P203_OPCAO IN (''P'', ''Q''))',
'        group by ',
'                B.TIPO,',
'                A.COD_EVENTO,',
'                B.DESCRICAO,',
'                A.TIPO_EVENTO,',
'                A.BH_APURADO,',
'                A.PLANTAO,',
'                X.ULTIMO_DIA',
'       union',
'        select  ''H'' TIPO,',
'                A.COD_EVENTO,',
'                B.DESCRICAO,',
'                A.TIPO_EVENTO,',
'                A.BH_APURADO,',
'                A.PLANTAO,',
'                sum(substr(A.QTD_HORAS,1,instr(A.QTD_HORAS,'':'')-1)) HORAS,',
'                sum(substr(A.QTD_HORAS,instr(A.QTD_HORAS,'':'')+1) ) MINUTOS,',
'                X.ULTIMO_DIA',
'        from    PE_RESULTADO_APURACAO A,',
'                PE_EVENTOS_FOLHA B,',
'                (SELECT MAX(NVL(VIRA_DIA,DATA_PONTO)) ULTIMO_DIA',
'                 FROM PE_TRATAMENTO_BATIMENTOS',
'                 WHERE COD_EMPRESA = :p203_emp',
'                  AND  MATRICULA = :p203_mat',
'                  AND  NVL(VIRA_DIA,DATA_PONTO) BETWEEN to_date(:P203_DT_INI,''DD/MM/YYYY'') and to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY'')',
'                  ) X',
'        where   A.COD_EMPRESA = :P203_EMP',
'        and     A.MATRICULA = :P203_MAT',
'        and     (A.TIPO_EVENTO = ''PONTO'')',
'        AND     A.ID_APURACAO != 9020',
'        AND ((EXISTS (SELECT DISTINCT 1 ',
'                      FROM PE_JORNADAS ',
'                     WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DT_FIM, ''S''), FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DT_FIM, ''N''))',
'                      AND (TIPO_JORNADA = 2 AND A.ID_APURACAO > 9000 ))',
'                      AND a.DATA = to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY''))',
'            OR (EXISTS(SELECT DISTINCT 1 ',
'                      FROM PE_JORNADAS ',
'                     WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(A.COD_EMPRESA, A.MATRICULA, :P203_DATA, ''N''))',
'                      AND (TIPO_JORNADA != 2 ))',
'                      AND A.DATA  between to_date(:P203_DT_INI_PERIODO,''DD/MM/YYYY'') and to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY'')))',
'',
'        and     A.COD_EMPRESA = B.COD_EMPRESA',
'        and     A.COD_EVENTO = B.COD_EVENTO_FOLHA',
'--                AND NVL(A.PLANTAO,''N'') =  DECODE(:P203_OPCAO, ''P'', ''S'', ''Q'', ''S'', ''N'')',
'            --AND NVL(A.PLANTAO,''N'') =  DECODE(:P203_OPCAO, ''P'', ''S'', ''Q'', ''S'', ''N'')',
'            AND (NVL(A.PLANTAO,''N'') = ''N'' AND :P203_OPCAO NOT IN (''P'', ''Q'')',
'                     OR A.PLANTAO = ''S'' AND :P203_OPCAO IN (''P'', ''Q''))',
'        group by ',
'                A.COD_EVENTO,A.MATRICULA,',
'                B.DESCRICAO,',
'                A.TIPO_EVENTO,',
'                A.BH_APURADO,',
'                A.PLANTAO,',
'                X.ULTIMO_DIA),',
'    TP_A as (',
'        select C.COD_EVENTO,',
'               C.DESCRICAO,',
'               C.TIPO_EVENTO,',
'               C.PLANTAO,',
'               case when C.TIPO = ''C'' then nvl(fnct_tot_horas(nvl(sum(C.HORAS),0), nvl(sum(C.MINUTOS),0)),0) end CREDITO,',
'               case when C.TIPO = ''D'' then nvl(fnct_tot_horas(nvl(sum(C.HORAS),0), nvl(sum(C.MINUTOS),0)),0) end DEBITO,',
'               case when C.TIPO = ''H'' then nvl(fnct_tot_horas(nvl(sum(C.HORAS),0), nvl(sum(C.MINUTOS),0)),0) end HORA',
'        from   TP_C C',
'        group by ',
'               C.COD_EVENTO,',
'               C.DESCRICAO,',
'               C.TIPO_EVENTO,',
'               C.TIPO,',
'               C.PLANTAO    ',
'    ),',
'    TP_B as (',
'      select  D.COD_EVENTO,',
'                D.DESCRICAO,',
'                D.TIPO_EVENTO,',
'                D.PLANTAO,',
'                case',
'                    when D.TIPO_EVENTO = ''BANCO'' then',
'            case',
'              when nvl(max(D.CREDITO),0) >= nvl(max(D.DEBITO),0) then',
'                              ltrim(replace(to_char(FNCT_TOT_HORAS(',
'                                                           nvl(nvl(trim(replace(substr(to_char(max(D.CREDITO),''990D90''),1,instr(to_char(max(D.CREDITO),''990D90''),''.'')),''.'')),0) - nvl(trim(replace(substr(to_char(max(D.DEBITO),''990D90''),1,instr(to_char('
||'max(D.DEBITO),''990D90''),''.'')),''.'')),0),0), ',
'                                                           nvl(nvl(trim(replace(substr(to_char(max(D.CREDITO),''990D90''),instr(to_char(max(D.CREDITO),''990D90''),''.''), length(to_char(max(D.CREDITO),''990D90''))),''.'')),0) - nvl(trim(replace(substr(to_char('
||'max(D.DEBITO),''990D90''),instr(to_char(max(D.DEBITO),''990D90''),''.''), length(to_char(max(D.DEBITO),''990D90''))),''.'')),0),0)',
'                                                        ), ''99900.09''),''.'', '':''))',
'                            else',
'                                ''-''||replace(lpad(trim(to_char(fnct_calc_horas(nvl(trim(replace(trim(to_char(max(D.CREDITO),''990D90'')),''.'','':'')),''00:00''),nvl(trim(replace(trim(to_char(max(D.DEBITO),''990D90'')),''.'','':'')),''00:00'')),''990D90'')),5,0),''.'','''
||':'')',
'                        end',
'                    else',
'                      ltrim(replace(to_char(max(D.HORA), ''99900.09''),''.'', '':''))',
'                end  QTD_HORAS',
'        from    TP_A D',
'        group by',
'                D.COD_EVENTO,',
'                D.DESCRICAO,',
'                D.TIPO_EVENTO,',
'                D.PLANTAO    ',
'    )',
'select  E.COD_EVENTO||'' - ''||E.DESCRICAO DESCRICAO,',
'        E.QTD_HORAS,',
'        E.COD_EVENTO,',
'        E.TIPO_EVENTO,',
'        E.PLANTAO,',
'    replace(E.QTD_HORAS,'':'',''.'') QT_HC',
'from    TP_B E',
'where   E.QTD_HORAS != ''00:00''',
'order by 1',
''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DT_INI_PERIODO,P203_DT_FIM_PERIODO'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('Nenhum Evento Apurado Para Esse Per\00EDodo')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903496436277555)
,p_query_column_id=>1
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>4
,p_column_heading=>'Evento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903603403277556)
,p_query_column_id=>2
,p_column_alias=>'QTD_HORAS'
,p_column_display_sequence=>5
,p_column_heading=>'Horas'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903361040277554)
,p_query_column_id=>3
,p_column_alias=>'COD_EVENTO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903667327277557)
,p_query_column_id=>4
,p_column_alias=>'TIPO_EVENTO'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(116282533696709284435)
,p_query_column_id=>5
,p_column_alias=>'PLANTAO'
,p_column_display_sequence=>9
,p_column_heading=>'Plantao'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903737984277558)
,p_query_column_id=>6
,p_column_alias=>'QT_HC'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052903917212277559)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:215:&SESSION.::&DEBUG.:RP,215:P215_EMP,P215_MAT,P215_COD_EVENTO,P215_TIPO_EVENTO,P215_DT_INI,P215_DT_FIM,P215_HORAS:&P203_EMP.,&P203_MAT.,#COD_EVENTO#,#TIPO_EVENTO#,&P203_DT_INI.,&P203_DT_FIM.,#QT_HC#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P203_USE_REQ'
,p_display_when_condition2=>'N'
,p_report_column_width=>10
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(140750710235960233477)
,p_query_column_id=>8
,p_column_alias=>'DERIVED$02'
,p_column_display_sequence=>2
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:183:&SESSION.::&DEBUG.:RP,183:P183_EMP,P183_MAT,P183_OPCAO,P183_COD_EVENTO,P183_DT_INI,P183_DT_FIM,P183_SEQ:&P203_EMP.,&P203_MAT.,&P203_OPCAO.,#COD_EVENTO#,&P203_DT_INI_PERIODO.,&P203_DT_FIM_PERIODO.,&P203_SEQ.'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P203_USE_REQ_PERIODO'
,p_display_when_condition2=>'S'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(127963904357608534071)
,p_query_column_id=>9
,p_column_alias=>'DERIVED$03'
,p_column_display_sequence=>8
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP:P11_COD_EMPRESA,P11_MATRICULA,P11_EVENTO,P11_DT_INI,P11_DT_FIM,P11_TIPO_EVENTO,P11_DESC_EVENTO:&P203_EMP.,&P203_MAT.,#COD_EVENTO#,&P203_DT_INI.,&P203_DT_FIM.,#TIPO_EVENTO#,#DESCRICAO#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(211084765253157861019)
,p_name=>unistr('Di\00E1rio')
,p_parent_plug_id=>wwv_flow_api.id(211084764485776861017)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT -- r."ROWID",',
'       r.cod_empresa, ',
'	   r.matricula, ',
'	   r.DATA, ',
'	   r.cod_evento, ',
'	   r.cod_evento||'' - ''||b.descricao descricao,',
unistr('	   decode(b.tipo,''C'',''Cr\00E9dito'',''D'',''D\00E9bito'') tipo,  '),
'	   r.qtd_horas,',
'	   Initcap(r.tipo_evento) tipo_evento,',
'	   decode(r.bh_apurado,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'',r.bh_apurado) bh_apurado_desc,',
'       r.bh_apurado,',
'	   r.posicao,',
'       r.id_apuracao,',
'       r.cod_item',
'  FROM pe_resultado_apuracao r,',
'       pe_eventos_banco b,',
'       parametros_recursos_humanos h,',
'       PE_ABONO_BATIDAS_SEQ_AUX s,',
'       (SELECT MAX(NVL(VIRA_DIA,DATA_PONTO)) ULTIMO_DIA',
'         FROM PE_TRATAMENTO_BATIMENTOS',
'         WHERE COD_EMPRESA = :p203_emp',
'          AND  MATRICULA = :p203_mat',
'          AND  NVL(VIRA_DIA,DATA_PONTO) BETWEEN to_date(:P203_DT_INI_PERIODO,''DD/MM/YYYY'') and to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY'')',
'          ) X',
' WHERE r.cod_empresa = b.cod_empresa ',
'   AND r.cod_empresa = h.cod_empresa',
'   AND r.cod_evento = b.cod_evento_banco ',
'   AND r.cod_empresa = s.cod_empresa',
'   AND r.matricula = s.matricula',
'   AND s.seq = :P203_SEQ',
'   AND r.data = s.data',
'   AND r.plantao = s.plantao',
'   AND s.cod_escala = nvl(:P203_ESCALA,s.cod_escala)',
'   AND r.tipo_evento = ''BANCO''',
'   AND r.cod_empresa = :p203_emp',
'   AND r.matricula = :p203_mat',
'   AND ((EXISTS (SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''N''))',
'                  AND (TIPO_JORNADA = 2 ))',
'                  AND R.DATA = :P203_DATA)',
'        OR (EXISTS (SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DT_FIM, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DT_FIM, ''N''))',
'                  AND (TIPO_JORNADA = 2 AND R.ID_APURACAO > 9000 ))',
'                  AND R.DATA = X.ULTIMO_DIA ',
'              AND  :P203_DATA = :P203_DT_FIM_PERIODO)',
'        OR (EXISTS(SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''N''))',
'                  AND (TIPO_JORNADA != 2 ))',
'                  AND r.data = :p203_data))',
'   --AND (r.cod_empresa, r.matricula , r.data , r.plantao, :p203_escala) in (select cod_empresa, matricula, data, plantao, cod_escala from PE_ABONO_BATIDAS_SEQ_AUX where seq = :P203_SEQ)',
'   --AND ((:P203_OPCAO in (''F'',''A'',''O'',''R'')  and r.plantao = ''N'') or (:P203_OPCAO in (''P'',''Q'') and  r.plantao = ''S'') or (:P203_OPCAO = ''T''))',
'',
'   --and (((:p_painel = ''PO'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data)))',
'   and (((:p_painel = ''PO'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data)))',
'    OR ((:p_painel = ''PC'') or (r.data between nvl(h.dt_ini_ponto_colab,r.data) and nvl(h.dt_fim_ponto_colab,r.data)))',
'    OR ((:p_painel = ''PG'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data)))',
'    )',
' /*  and (h.exibe_apura_zeradas = ''S'' or (h.exibe_apura_zeradas = ''N'' and qtd_horas != ''00:00''))',
'   and FNCT_PE_EXIBE_EVENTO(p_cod_empresa => :p203_emp',
'                           ,p_matricula   => :p203_mat',
'                           ,p_cod_evento  => b.cod_evento_banco  --r.cod_evento',
'                           ,p_cod_jornada =>  NVL(:P203_JORNADA, :p203_escala)',
'                           ,p_data        => :p203_data) = ''S'' */',
'  union',
'  SELECT -- r."ROWID",',
'       r.cod_empresa, ',
'	   r.matricula, ',
'	   r.DATA, ',
'	   r.cod_evento, ',
'	   r.cod_evento||'' - ''||upper(p.descricao) descricao,',
unistr('       (select decode(tipo_rubrica, 1, ''Cr\00E9dito'', 2, ''D\00E9bito'', 3, ''Base'') from ocorr_pagto where cod = p.cod_ocorr and cod_empresa = h.cod_empresa) tipo,'),
'	   r.qtd_horas,',
'	   Initcap(r.tipo_evento) tipo_evento,',
'	   decode(r.bh_apurado,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'',r.bh_apurado) bh_apurado_desc,',
'       r.bh_apurado,',
'	   r.posicao,',
'       r.id_apuracao,',
'       r.cod_item',
'  FROM pe_resultado_apuracao r,',
'	   pe_eventos_folha p,',
'       parametros_recursos_humanos h,',
'       PE_ABONO_BATIDAS_SEQ_AUX s,',
'       (SELECT MAX(NVL(VIRA_DIA,DATA_PONTO)) ULTIMO_DIA',
'         FROM PE_TRATAMENTO_BATIMENTOS',
'         WHERE COD_EMPRESA = :p203_emp',
'          AND  MATRICULA = :p203_mat',
'          AND  NVL(VIRA_DIA,DATA_PONTO) BETWEEN to_date(:P203_DT_INI_PERIODO,''DD/MM/YYYY'') and to_date(:P203_DT_FIM_PERIODO,''DD/MM/YYYY'')',
'          ) X',
' WHERE r.cod_empresa = p.cod_empresa ',
'   AND r.cod_empresa = h.cod_empresa',
'   AND r.cod_evento = p.cod_evento_folha ',
'   AND r.cod_empresa = s.cod_empresa',
'   AND r.matricula = s.matricula',
'   AND r.data = s.data',
'   AND r.plantao = s.plantao',
'   --AND s.cod_escala = nvl(:P203_ESCALA,s.cod_escala)',
'   AND r.tipo_evento = ''PONTO''',
'   AND r.cod_empresa = :p203_emp',
'   AND r.matricula = :p203_mat',
'   AND s.seq = :P203_SEQ',
'   AND ((EXISTS (SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''N''))',
'                  AND (TIPO_JORNADA = 2 ))',
'                  AND R.DATA = :P203_DATA)',
'        OR (EXISTS (SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DT_FIM, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DT_FIM, ''N''))',
'                  AND (TIPO_JORNADA = 2 AND R.ID_APURACAO > 9000 ))',
'            AND R.DATA = X.ULTIMO_DIA ',
'            AND  :P203_DATA = :P203_DT_FIM_PERIODO)',
'        OR (EXISTS(SELECT DISTINCT 1 ',
'                  FROM PE_JORNADAS ',
'                 WHERE COD_JORNADA = nvl(FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''S''), FNCT_PE_RETORNA_JORNADA(R.COD_EMPRESA, R.MATRICULA, :P203_DATA, ''N''))',
'                  AND (TIPO_JORNADA != 2 ))',
'                  AND r.data = :p203_data))',
' /*  and FNCT_PE_EXIBE_EVENTO(p_cod_empresa => :p203_emp',
'                           ,p_matricula   => :p203_mat',
'                           ,p_cod_evento  => p.cod_evento_folha --r.cod_evento',
'                           ,p_cod_jornada => NVL(:P203_JORNADA, :p203_escala)',
'                           ,p_data        => :p203_data) = ''S'' */',
'',
'   --AND (r.cod_empresa, r.matricula , r.data , r.plantao, :p203_escala) in (select cod_empresa, matricula, data, plantao, cod_escala from PE_ABONO_BATIDAS_SEQ_AUX where seq = :P203_SEQ)',
'   --AND ((:P203_OPCAO in (''F'',''A'',''O'',''R'') and r.plantao = ''N'') or (:P203_OPCAO in (''P'',''Q'') and  r.plantao = ''S'') or (:P203_OPCAO = ''T''))',
'   --and ((:p_painel = ''PO'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data)))',
'   --and ((:p_painel = ''PO'') or (r.data >= nvl(h.dt_ini_ponto_gestor,r.data)))',
'  /* and ((:p_painel = ''PO'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data))',
'    OR (:p_painel = ''PC'') or (r.data between nvl(h.dt_ini_ponto_colab,r.data) and nvl(h.dt_fim_ponto_colab,r.data))',
'    OR (:p_painel = ''PG'') or (r.data between nvl(h.dt_ini_ponto_gestor,r.data) and nvl(h.dt_fim_ponto_gestor,r.data))',
'    )*/',
'--and (h.exibe_apura_zeradas = ''S'' or (h.exibe_apura_zeradas = ''N'' and qtd_horas != ''00:00''))',
''))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DATA,P203_OPCAO,P203_ESCALA'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Evento Apurado Para Essa Data'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435880705188409194)
,p_query_column_id=>1
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435881085204409195)
,p_query_column_id=>2
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435881449256409195)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435881826789409195)
,p_query_column_id=>4
,p_column_alias=>'COD_EVENTO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(24053312614886565533)
,p_query_column_id=>5
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>15
,p_column_heading=>'Descricao'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435882626124409196)
,p_query_column_id=>6
,p_column_alias=>'TIPO'
,p_column_display_sequence=>8
,p_column_heading=>'C / D'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435883076586409197)
,p_query_column_id=>7
,p_column_alias=>'QTD_HORAS'
,p_column_display_sequence=>9
,p_column_heading=>'Horas'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435883491355409197)
,p_query_column_id=>8
,p_column_alias=>'TIPO_EVENTO'
,p_column_display_sequence=>10
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435883835359409197)
,p_query_column_id=>9
,p_column_alias=>'BH_APURADO_DESC'
,p_column_display_sequence=>11
,p_column_heading=>unistr('Apura\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435884306676409198)
,p_query_column_id=>10
,p_column_alias=>'BH_APURADO'
,p_column_display_sequence=>12
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435884646764409198)
,p_query_column_id=>11
,p_column_alias=>'POSICAO'
,p_column_display_sequence=>13
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435885080452409199)
,p_query_column_id=>12
,p_column_alias=>'ID_APURACAO'
,p_column_display_sequence=>14
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435885437569409199)
,p_query_column_id=>13
,p_column_alias=>'COD_ITEM'
,p_column_display_sequence=>3
,p_column_heading=>'Cod Item'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_COD_ITEM,P10_ROWID,P10_EMP,P10_MAT,P10_COD_EVENTO,P10_BH_APURADO,P10_CALC_HORAS,P10_TIPO_EVENTO,P10_COD_EVENTO,P10_DATA,P10_QTD_HORAS:#COD_ITEM#,#COD_ITEM#,#COD_EMPRESA#,#MATRICULA#,#COD_EVENTO#,#BH_APURAD'
||'O#,#QTD_HORAS#,#TIPO_EVENTO#,#COD_EVENTO#,#DATA#,#QTD_HORAS#'
,p_column_linktext=>'<span class="fa fa-commenting-o" aria-hidden=true"></span>'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'EXISTS'
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 ',
'from parametros_recursos_humanos p',
'where p.cod_empresa = :P203_EMP',
'and p.permite_justificar = ''S'''))
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435885852276409200)
,p_query_column_id=>14
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:214:&SESSION.::&DEBUG.:RP,214:P214_EMP,P214_MAT,P214_COD_ITEM,P214_ID_APURACAO,P214_DTINI_MARCACAO,P214_COD_EVENTO:#COD_EMPRESA#,#MATRICULA#,#COD_ITEM#,#ID_APURACAO#,&P203_DATA.,#COD_EVENTO#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P203_USE_REQ'
,p_display_when_condition2=>'N'
,p_report_column_width=>10
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167425965779248361032)
,p_query_column_id=>15
,p_column_alias=>'DERIVED$02'
,p_column_display_sequence=>2
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:181:&SESSION.::&DEBUG.:RP,181:P181_EMP,P181_MAT,P181_COD_ITEM,P181_ID_APURACAO,P181_DTINI_MARCACAO,P181_DATA_PONTO,P181_COD_EVENTO,P181_QTD_HORAS_NOVO,P181_POSICAO,P181_COD_EVENTO_NOVO_DSP:&P203_EMP.,&P203_MAT.,#COD_ITEM#,#ID_APURACAO#,&'
||'P203_DATA.,#DATA#,#COD_EVENTO#,,#POSICAO#,#COD_EVENTO#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_display_when_cond_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_condition=>'P203_USE_REQ'
,p_display_when_condition2=>'S'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(211084772092330861030)
,p_name=>unistr('Per\00EDodo - x')
,p_parent_plug_id=>wwv_flow_api.id(211084764485776861017)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa, matricula, cod_evento, cod_evento||'' - ''||descricao descricao, qtd_horas, replace(qtd_horas,'':'',''.'') qt_hc',
'  from pe_abono_apuracao_periodo_seq',
' where cod_empresa = :p203_emp',
'   and matricula = :p203_mat',
'   and seq = :p203_seq',
'   and qtd_horas <> ''00:00''',
'   order by 1,2,3,4,5'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DATA,P203_SEQ'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>unistr('Nenhum Evento Apurado Para Esse Per\00EDodo')
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435887778358409203)
,p_query_column_id=>1
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435888116322409204)
,p_query_column_id=>2
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435888588305409204)
,p_query_column_id=>3
,p_column_alias=>'COD_EVENTO'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435888924009409205)
,p_query_column_id=>4
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>5
,p_column_heading=>'Evento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(187435889363219409205)
,p_query_column_id=>5
,p_column_alias=>'QTD_HORAS'
,p_column_display_sequence=>6
,p_column_heading=>'Horas'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(185052902307784277543)
,p_query_column_id=>6
,p_column_alias=>'QT_HC'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211084774459272861033)
,p_plug_name=>unistr('Relat\00F3rios')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>42
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211084798499720861064)
,p_plug_name=>unistr('Requisi\00E7\00F5es de Abono')
,p_region_name=>'REQUISICAO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>72
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211084798900202861065)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Abono')
,p_parent_plug_id=>wwv_flow_api.id(211084798499720861064)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(199995577391309554932)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       r.cod_req requisicao,',
'       r.dt_req data_abertura,',
'       r.cod_empresa||'' - ''||initcap(fnct_nome_empresa(r.cod_empresa,''S'')) Empresa, ',
'       r.matricula||'' - ''||initcap(fnct_nome_func(r.cod_empresa, r.matricula)) Matricula_Solicitada,',
'       r.cod_emp_req||'' - ''||Initcap(fnct_nome_empresa(r.cod_emp_req,''S'')) Empresa_Solicitante,',
'       r.mat_req||'' - ''||initcap(fnct_nome_func(r.cod_emp_req, r.mat_req)) Solicitante,',
'       decode(r.cod_sit_req,1,''<span class="fa fa-play-circle colorNone" aria-hidden="true"></span> ''||''Aberta'',',
unistr('                            2,''<span aria-hidden="true" class="fa fa-check-circle colorSuccess"></span> ''||''Conclu\00EDda'','),
'                            3,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Cancelada'',',
'                            4,''<span aria-hidden="true" class="fa fa-times-circle colorDanger"></span> ''||''Reprovada'',',
'                            5,''<span aria-hidden="true" class="fa fa-check-circle colorInfo"></span> ''||''Aprovada'',',
unistr('                            6,''<span aria-hidden="true" class="fa fa-pause-circle colorAlert"></span> ''||''Suspens\00E3o'') Situacao,'),
'       r.cod_empresa,',
'       r.cod_req cod_solicitacao,',
'       r.cod_emp_req cod_empresa_solicitante,',
'       r.mat_req mat_solicitante,',
'       r.matricula,',
'       r.data_ponto,',
'       r.vira_dia,',
'       to_char(r.hora_batida,''hh24:mi'') hora_original,',
'       to_char(r.hora_batida_abono,''hh24:mi'') hora_abono,',
'       r.posicao,',
'       r.posicao_envio,',
'       decode(r.apagar_marcacao, ''S'', ''Sim'', '''') apagar_marcacao, ',
unistr('       DECODE(PLANTAO, ''S'', ''Sim'', ''N'', ''N\00E3o'') plantao,'),
'       r.comentarios,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.usuario',
'        else',
'            null',
'        end usuario_cancelamento,',
'        case',
'            when r.cod_sit_req = 3 then',
'            r.dt_atualizacao',
'        else',
'            null',
'        end dt_cancelamento',
'       ',
'  from PE_REQ_TRATAMENTO_BATIMENTOS r',
' where r.cod_empresa = :p203_emp',
'   and r.matricula   = :p203_mat',
'   and r.data_ponto between to_date(:P203_dt_ini_a, ''dd/mm/rrrr'') and to_date(:P203_dt_fim_a, ''dd/mm/rrrr'')',
' order by r.cod_req desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P203_DT_INI_A,P203_DT_FIM_A,P203_EMP,P203_MAT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(211084799272728861065)
,p_name=>unistr('Requisi\00E7\00E3o de Pessoal')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>unistr('Nenhuma Requisi\00E7\00E3o Cadastrada.')
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:714:&SESSION.::&DEBUG.:714:P714_COD_REQ,P714_EMP,P714_MAT,P714_POSICAO,P714_DATA,P714_TEM_REQ,P714_CONSULTA:#REQUISICAO#,#COD_EMPRESA#,#MATRICULA#,#POSICAO#,#DATA_PONTO#,S,C'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">'
,p_owner=>'IGOR'
,p_internal_uid=>24551752363457499791
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435892698593409209)
,p_db_column_name=>'REQUISICAO'
,p_display_order=>20
,p_column_identifier=>'AX'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435893089587409210)
,p_db_column_name=>'DATA_ABERTURA'
,p_display_order=>30
,p_column_identifier=>'AY'
,p_column_label=>'Data de Abertura'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435893487612409210)
,p_db_column_name=>'EMPRESA'
,p_display_order=>50
,p_column_identifier=>'BA'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435893812000409211)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>110
,p_column_identifier=>'BF'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435894281094409211)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>120
,p_column_identifier=>'BG'
,p_column_label=>'Solicitante'
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA_SOLICITANTE#,#MAT_SOLICITANTE#'
,p_column_linktext=>'#SOLICITANTE#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435894681725409211)
,p_db_column_name=>'SITUACAO'
,p_display_order=>130
,p_column_identifier=>'BH'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<span style="white-space:nowrap;">#SITUACAO#</span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435895068400409212)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>140
,p_column_identifier=>'BI'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435895431914409212)
,p_db_column_name=>'COD_EMPRESA_SOLICITANTE'
,p_display_order=>160
,p_column_identifier=>'BK'
,p_column_label=>'Cod empresa solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435895814517409212)
,p_db_column_name=>'MAT_SOLICITANTE'
,p_display_order=>170
,p_column_identifier=>'BL'
,p_column_label=>'Mat solicitante'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435896283885409213)
,p_db_column_name=>'MATRICULA_SOLICITADA'
,p_display_order=>200
,p_column_identifier=>'BO'
,p_column_label=>unistr('Matr\00EDcula Solicitada')
,p_column_link=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#MATRICULA_SOLICITADA#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435896648726409213)
,p_db_column_name=>'COD_SOLICITACAO'
,p_display_order=>210
,p_column_identifier=>'BR'
,p_column_label=>'Cod solicitacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435897012311409213)
,p_db_column_name=>'MATRICULA'
,p_display_order=>220
,p_column_identifier=>'BS'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435897467530409214)
,p_db_column_name=>'DATA_PONTO'
,p_display_order=>230
,p_column_identifier=>'BT'
,p_column_label=>'Data Ponto'
,p_column_type=>'DATE'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435897846414409214)
,p_db_column_name=>'POSICAO'
,p_display_order=>240
,p_column_identifier=>'BU'
,p_column_label=>unistr('Posi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435898272652409214)
,p_db_column_name=>'HORA_ORIGINAL'
,p_display_order=>250
,p_column_identifier=>'BV'
,p_column_label=>'Hora Original'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(187435898696557409215)
,p_db_column_name=>'HORA_ABONO'
,p_display_order=>260
,p_column_identifier=>'BW'
,p_column_label=>'Hora Abono'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(161888964098736380525)
,p_db_column_name=>'APAGAR_MARCACAO'
,p_display_order=>270
,p_column_identifier=>'BX'
,p_column_label=>'Apagar Marcacao'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(145348512985117024510)
,p_db_column_name=>'POSICAO_ENVIO'
,p_display_order=>280
,p_column_identifier=>'BY'
,p_column_label=>'Posicao Envio'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(136705039382677479288)
,p_db_column_name=>'PLANTAO'
,p_display_order=>290
,p_column_identifier=>'BZ'
,p_column_label=>unistr('Plant\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100099425766656869269)
,p_db_column_name=>'VIRA_DIA'
,p_display_order=>300
,p_column_identifier=>'CA'
,p_column_label=>'Vira Dia'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(100099425940396869270)
,p_db_column_name=>'COMENTARIOS'
,p_display_order=>310
,p_column_identifier=>'CB'
,p_column_label=>'Comentarios'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(33570358734772695968)
,p_db_column_name=>'USUARIO_CANCELAMENTO'
,p_display_order=>320
,p_column_identifier=>'CD'
,p_column_label=>'Usuario Cancelamento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(32195229795774145150)
,p_db_column_name=>'DT_CANCELAMENTO'
,p_display_order=>330
,p_column_identifier=>'CF'
,p_column_label=>'Dt Cancelamento'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(211084805791995861075)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9028521'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REQUISICAO:DATA_ABERTURA:SITUACAO:EMPRESA:MATRICULA_SOLICITADA:DATA_PONTO:POSICAO:POSICAO_ENVIO:HORA_ORIGINAL:HORA_ABONO:EMPRESA_SOLICITANTE:SOLICITANTE:APAGAR_MARCACAO:PLANTAO:COMENTARIOS::USUARIO_CANCELAMENTO:DT_CANCELAMENTO'
,p_sort_column_1=>'COD_REQ'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167429712902424886389)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167429712744768886388)
,p_button_name=>'BTN_REQ_HE_2'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:716:&SESSION.::&DEBUG.:RP,716:P716_COD_EMPRESA,P716_MATRICULA,P716_EMP,P716_MAT:&P203_EMP.,&P203_MAT.,&P203_EMP.,&P203_MAT.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115496433091737169671)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_button_name=>'TRAVA_APURACAO_DIARIO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Trava Apuracao Diario'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP,12:P12_EMP,P12_MAT,P12_DATA_INI:&P203_EMP.,&P203_MAT.,&P203_DATA.'
,p_button_condition=>'select 1 from dual where :P_PAINEL = ''PO'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-stop-circle-o'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115496433587853169676)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(185052902906641277549)
,p_button_name=>'TRAVA_APURACAO_PERIODO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Trava Apuracao Periodo'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP,12:P12_EMP,P12_MAT,P12_DATA_INI,P12_DATA_FIM:&P203_EMP.,&P203_MAT.,&P203_DT_INI_PERIODO.,&P203_DT_FIM_PERIODO.'
,p_button_condition=>'select 1 from dual where :P_PAINEL = ''PO'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-stop-circle-o'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435890054178409206)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_btn_rel_divergencias'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Diverg\00EAncias')
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-exchange'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(127968663705445440274)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_button_name=>'p203_btn_Cons_eventos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Eventos Apurados'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-calculator'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435890468808409207)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_btn_rel_folgas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Escalas de Folgas'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-calendar'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(127968663763682440275)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_button_name=>'p203_btn_param_jornadas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Jornadas'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_acesso is ',
'    SELECT NVL(ACESSO, ''N'') acesso',
'       FROM APEX_PROGRAMAS_ACESSO_PERFIL',
unistr('    WHERE MODULO = ''FREQU\00CANCIA'''),
unistr('    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'    AND APP_PAGE_NAME = ''JORNADAS''',
'    AND APP_ID = (SELECT APP_ID FROM APEX_PROGRAMAS',
'                   WHERE APP_NAME = ''PAINEL DO GESTOR'' AND :P_PAINEL = ''PG''',
unistr('                   AND MODULO = ''FREQU\00CANCIA'''),
unistr('                    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'                    AND APP_PAGE_NAME = ''JORNADAS''',
'                   )',
'    AND ATIVO = ''S''',
'    and (perfil = :P_PERFIL or perfil = ''GESTOR'');',
'',
'    cursor c_acesso_operador is -- Consulta acesso por perfil  ',
'    SELECT NVL(ACESSO, ''N'') acesso',
'       FROM APEX_PROGRAMAS_ACESSO_PERFIL',
unistr('    WHERE MODULO = ''FREQU\00CANCIA'''),
unistr('    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'    AND APP_PAGE_NAME = ''JORNADAS''',
'    AND APP_ID = (SELECT APP_ID FROM APEX_PROGRAMAS',
'                   WHERE APP_NAME = ''PAINEL DO OPERADOR''',
unistr('                   AND MODULO = ''FREQU\00CANCIA'''),
unistr('                    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'                    AND APP_PAGE_NAME = ''JORNADAS''',
'                   )',
'    AND ATIVO = ''S''',
'    and (perfil = :P_PERFIL);',
'    ',
'    cursor c_acesso_operador_usuario is -- Consulta acesso por usuario',
'    SELECT NVL(ACESSO, ''N'') acesso',
'       FROM APEX_PROGRAMAS_ACESSO',
unistr('    WHERE MODULO = ''FREQU\00CANCIA'''),
unistr('    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'    AND APP_PAGE_NAME = ''JORNADAS''',
'    AND APP_ID = (SELECT APP_ID FROM APEX_PROGRAMAS',
'                   WHERE APP_NAME = ''PAINEL DO OPERADOR''',
unistr('                   AND MODULO = ''FREQU\00CANCIA'''),
unistr('                    AND SUB_MODULO = ''PARAMETRIZA\00C7\00D5ES'''),
'                    AND APP_PAGE_NAME = ''JORNADAS''',
'                   )',
'    AND ATIVO = ''S''',
'    and (USUARIO = :P_USUARIO);',
'    ',
'    r_acesso c_acesso%rowtype;',
'begin',
'',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    elsif :P_PAINEL = ''PG'' then',
'        open c_acesso;',
'        fetch c_acesso into r_acesso;',
'        close c_acesso;',
'',
'        if r_acesso.acesso = ''N'' then',
'            return false;',
'        end if;',
'    elsif :P_PAINEL = ''PO'' then',
'        open c_acesso_operador;',
'        fetch c_acesso_operador into r_acesso;',
'        close c_acesso_operador;',
'',
'        if r_acesso.acesso = ''N'' then',
'          open c_acesso_operador_usuario;',
'          fetch c_acesso_operador_usuario into r_acesso;',
'          close c_acesso_operador_usuario;',
'          if r_acesso.acesso = ''N'' then',
'            return false;',
'          end if;',
'        end if;',
'    end if;',
'    return true;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-table-clock'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435890827192409207)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_btn_rel_espelho'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Espelho de Ponto'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-clock-o'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(126114948044878036757)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_button_name=>'P203_BTN_TRABALHO_INDIVIDUAL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Escala de Trabalho'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-user-clock'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435891260515409207)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_btn_rel_eventos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Eventos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-calculator'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(127968663839465440276)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_button_name=>'p203_btn_escala_folga'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Escalas de Folga'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-layout-modal-rows'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435891625358409208)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_btn_hist_resul_apuracao'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Hist\00F3rico de Apura\00E7\00E3o')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P_PAINEL'
,p_button_condition2=>'PC'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-table-clock'
,p_grid_new_row=>'Y'
,p_grid_column_span=>6
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(133661614174009361950)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_button_name=>'p203_redirect'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Consultar Ciclo'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=FREQ_PARAM_&P_BASE.:23:&SESSION.::&DEBUG.:RP,23:P23_COD_EMPRESA,P23_MATRICULA,P23_DATA_INICIO,P23_DATA_FINAL,P23_CONSULTA,P23_ABONO:&P203_EMP.,&P203_MAT.,&P203_DT_INI.,&P203_DT_FIM.,C,S'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from dual'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-layout-modal-rows'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89274127466825946604)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_button_name=>'p203_btn_reprocessar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reprocessar'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'select 1 from dual where :P_PAINEL = ''PO'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-gears'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(140309783599234148097)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_button_name=>'REFRESH_DIARIO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Refresh Diario'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(140309783903397148100)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(185052902906641277549)
,p_button_name=>'REFRESH_PERIODOD'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Refresh Periodod'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435859538454409166)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_button_name=>'PARAM_PESQUISAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435866821271409179)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211073970831086503668)
,p_button_name=>'BTN_REQ_HE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:716:&SESSION.::&DEBUG.:RP,716:P716_COD_EMPRESA,P716_MATRICULA,P716_EMP,P716_MAT:&P203_EMP.,&P203_MAT.,&P203_EMP.,&P203_MAT.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    V_RESULTADO BOOLEAN;',
'begin',
'    /*',
unistr('    v_resultado := pkg_acesso_po.fnct_botao(138, :P_USUARIO,NULL,''REQUISI\00C7\00D5ES'');'),
'    return v_resultado;',
'    */',
'    return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435874842218409189)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_button_name=>'PESQUISAR_COLAB'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Selecionar Colaborador'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P_PAINEL'
,p_button_condition2=>'PC'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435879991157409193)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211084764485776861017)
,p_button_name=>'p203_btn_apurar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Realizar Apura\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=FREQ_PROC_&P_BASE.:47:&SESSION.::&DEBUG.:RP,47:P47_EMP,P47_MAT,P47_DATA_INI,P47_DATA_FIM,P_USUARIO,P_PAINEL:&P203_EMP.,&P203_MAT.,&P203_DT_INI.,&P203_DT_FIM.,&P_USUARIO.,&P_PAINEL.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_ret varchar2(1) := ''S'';',
'begin',
'    if :P_PAINEL = ''PG'' then',
'        begin',
'            select nvl(mostrar_botao_apuracao_gestor, ''N'')',
'            into v_ret ',
'                from parametros_recursos_humanos',
'                where cod_empresa = :P203_EMP;    ',
'        exception',
'            when others then',
'                v_ret := ''N'';',
'        end;',
'    elsif :P_PAINEL = ''PC'' then    ',
'        v_ret := ''N'';',
'    elsif :P_PAINEL = ''PO'' then    ',
'        v_ret := ''S'';',
'    end if;',
'    --',
'    if v_ret = ''S'' then',
'        return true;',
'    else',
'        return false;',
'    end if;    ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-clock-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(116957805358734092286)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_button_name=>'REGRAS_SINDICATO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Regras por Sindicato'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=FREQ_PARAM_&P_BASE.:28:&SESSION.::&DEBUG.:RP,28:P28_COD_EMPRESA,P28_MATRICULA:&P203_EMP.,&P203_MAT.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from dual'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435875287772409189)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_button_name=>'p203_btn_colab'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&P_PAINEL._&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P203_EMP.,&P203_MAT.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167425962246894360997)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167417859387957134215)
,p_button_name=>'BTN_REQ_APUR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:181:&SESSION.::&DEBUG.:RP,181:P181_EMP,P181_MAT,P181_COD_REQ,P181_COD_EMPRESA,P181_MATRICULA:&P203_COD_EMPRESA.,&P203_MATRICULA.,,&P203_EMP.,&P203_MAT.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(26690750391194765440)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'P203_BTN_INVERSAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Invers\00E3o')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:RP,19:P19_FILTRO_EMP,P19_FILTRO_MAT,P19_FILTRO_DT_INI,P19_FILTRO_DT_FIM,P19_COD_EMPRESA,P19_MATRICULA:&P203_COD_EMPRESA.,&P203_MATRICULA.,&P203_DT_INI_A.,&P203_DT_FIM_A.,&P203_EMP.,&P203_MAT.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_tem_perfil   number;',
'begin',
'',
'   select count(*)',
'   into v_tem_perfil',
'   from pe_perfil_inversao',
'   where cd_perfil    = :p_perfil and',
'         ind_inversao = ''S'';',
'         ',
'   if :P_PAINEL != ''PO'' then',
'      return(false);',
'   end if;',
'         ',
'   if nvl(v_tem_perfil,0) != 0 then',
'      return(true);',
'   else',
'      return(false);',
'   end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-calendar'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435855653726409160)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'P203_BTN_CALENDARIO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Calend\00E1rio')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:15:&SESSION.::&DEBUG.:RP,15:P15_EMP,P15_MAT,P15_DT_INI,P15_DT_FIM:&P203_EMP.,&P203_MAT.,&P203_DT_INI.,&P203_DT_FIM.'
,p_icon_css_classes=>'fa-calendar'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435856072371409161)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'p203_btn_add_data'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adic. Data'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:14:&SESSION.::&DEBUG.:RP,14:P14_EMP,P14_MAT,P14_DTINI_MARCACAO,P14_OPCAO_PLANTAO,P14_SEQ,P14_DATA_INI,P14_DATA_FIM:&P203_EMP.,&P203_MAT.,&P203_DT_INI.,&P203_OPCAO.,&P203_SEQ.,&P203_DT_INI.,&P203_DT_FIM.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435856496631409161)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'BTN_REQ_HE_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Req. HE'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:716:&SESSION.::&DEBUG.:RP,716:P716_COD_EMPRESA,P716_MATRICULA,P716_EMP,P716_MAT:&P203_EMP.,&P203_MAT.,&P203_EMP.,&P203_MAT.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'V_RESULTADO BOOLEAN;',
'',
'begin',
'',
unistr('v_resultado := pkg_ACESSO_PO.fnct_botao(138, :P_USUARIO,NULL,''REQUISI\00C7\00D5ES'');'),
'',
'return v_resultado;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(126114948379181036761)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'BTN_REQ_ATESTADO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--iconRight:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Req. Atestado'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(187435856812401409162)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_button_name=>'p203_btn_pesquisa'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--pillEnd:t-Button--padLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P3 btn pesquisa'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(140309784159557148103)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(211084798900202861065)
,p_button_name=>'ATUALIZA_REQUISICOES_ABONO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Requisicoes Abono'
,p_button_position=>'TEMPLATE_DEFAULT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(140309784508014148106)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(211073970950870503669)
,p_button_name=>'ATUALIZA_REQUISICOES_HE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Requisicoes He'
,p_button_position=>'TOP'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(140309784785884148109)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167429712966361886390)
,p_button_name=>'ATUALIZA_REQUISICAO_APURACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft:t-Button--gapRight:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(199995598586877554975)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualiza Requisicao Apuracao'
,p_button_position=>'TOP'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(23937657313860190391)
,p_name=>'P203_PARAM_MATRICULA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_prompt=>unistr('Matr\00EDcula')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT I.MATRICULA||'' - ''||INITCAP(FNCT_NOME_FUNC(I.COD_EMPRESA, I.MATRICULA)) D, I.MATRICULA C',
'  FROM INFORMACOES_FUNCIONAIS I, PE_ESCALAS_EXCECOES E',
' WHERE I.COD_EMPRESA = E.COD_EMPRESA',
'   AND I.MATRICULA = E.MATRICULA',
'   AND I.MARCA_PONTO = ''S''',
'   AND I.COD_EMPRESA = :P203_PARAM_EMPRESA',
'   AND (:P203_PARAM_FILIAL IS NULL OR I.FILIAL = :P203_PARAM_FILIAL)',
'   AND (:P203_PARAM_CCUSTO IS NULL OR I.COD_CCUSTO = :P203_PARAM_CCUSTO)',
'   AND ((:P203_PARAM_SITUACAO = ''T'') OR ',
'        (I.SITUACAO <  ''90'' AND :P203_PARAM_SITUACAO = ''A'') OR ',
'        (I.SITUACAO >= ''90'' AND :P203_PARAM_SITUACAO = ''I''))',
'   AND F_ACESSO_PG_APEX(I.COD_EMPRESA, I.MATRICULA, I.FILIAL, I.CD_NIVEL, :P_USUARIO, :P_PAINEL,''PONTO'') = ''S''',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P203_PARAM_EMPRESA,P203_PARAM_FILIAL,P203_PARAM_CCUSTO,P203_PARAM_SITUACAO'
,p_ajax_items_to_submit=>'P203_PARAM_EMPRESA,P203_PARAM_FILIAL,P203_PARAM_CCUSTO,P203_PARAM_SITUACAO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Matr\00EDculas')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56238161414721552892)
,p_name=>'P203_TRAVA_APURACAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89274125996825946589)
,p_name=>'P203_URL_REPROCESSA'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126114948102770036758)
,p_name=>'P203_URL_TRBALHO_INDIVIDUAL'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126114948551831036762)
,p_name=>'P203_URL_REQ_ATESTADO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783911103400110192)
,p_name=>'P203_URL_CONS_EVENTOS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783911475388110196)
,p_name=>'P203_URL_PARAM_JORNADAS'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783911670414110197)
,p_name=>'P203_URL_ESCALA_FOLGA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(127968663291943440270)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783912127467110202)
,p_name=>'P203_URL_REL_DIVERGENCIAS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783912225851110203)
,p_name=>'P203_URL_REL_FOLGAS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783912332902110204)
,p_name=>'P203_URL_REL_ESPELHO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126783912423645110205)
,p_name=>'P203_URL_REL_EVENTOS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(211084774459272861033)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963904714439534075)
,p_name=>'P203_DT_INI_A'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(211084798900202861065)
,p_item_default=>'P203_DT_INI'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Inicial'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963904842065534076)
,p_name=>'P203_DT_FIM_A'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(211084798900202861065)
,p_item_default=>'P203_DT_FIM'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Final'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963905936770534087)
,p_name=>'P203_DT_INI_AP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167429712966361886390)
,p_item_default=>'P203_DT_INI'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Inicial'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963906042285534088)
,p_name=>'P203_DT_FIM_AP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167429712966361886390)
,p_item_default=>'P203_DT_FIM'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Final'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963906593207534093)
,p_name=>'P203_DT_INI_HE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(211073970950870503669)
,p_item_default=>'P203_DT_INI'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Inicial'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127963906848635534096)
,p_name=>'P203_DT_FIM_HE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(211073970950870503669)
,p_item_default=>'P203_DT_FIM'
,p_item_default_type=>'ITEM'
,p_prompt=>'Data Final'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127968664953399440287)
,p_name=>'P203_TP_FOLGA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_item_default=>'2'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(139592939452031543978)
,p_name=>'P203_DT_INI_PERIODO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(185052902906641277549)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(139592939636290543979)
,p_name=>'P203_DT_FIM_PERIODO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(185052902906641277549)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140750710344202233478)
,p_name=>'P203_USE_REQ_PERIODO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141281466675063263797)
,p_name=>'P203_ESCALA_2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167417859504486134216)
,p_name=>'P203_DATA_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167417859387957134215)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167417859556514134217)
,p_name=>'P203_ESCALA_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167417859387957134215)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167417859702209134218)
,p_name=>'P203_JORNADA_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(167417859387957134215)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425965647518361031)
,p_name=>'P203_USE_REQ'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435857226433409162)
,p_name=>'P203_OPCAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_prompt=>unistr('Tipo de Marca\00E7\00F5es')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Final;F,Original;O,Abonado;A,Todos;T,Requisi\00E7\00E3o;R,Plant\00E3o Original;P,Plant\00E3o Abonado;Q,Plant\00E3o Final;Z')
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435857706201409163)
,p_name=>'P203_DIVERGENTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_prompt=>'Visualizar'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Todos;N,Apenas Divergentes;S'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435858060690409164)
,p_name=>'P203_DT_INI'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_prompt=>'Data Inicial'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435858421711409164)
,p_name=>'P203_DT_FIM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_prompt=>'Data Final'
,p_format_mask=>'dd/mm/yyyy'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435858889329409165)
,p_name=>'P203_APURAR_OK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(199669327573211064236)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435859935327409166)
,p_name=>'P203_PARAM_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_prompt=>'Empresa'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) d, cod',
'  from empresas',
' WHERE f_acesso_emp_pg_apex(cod, :P_USUARIO) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Empresas'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435860369082409167)
,p_name=>'P203_PARAM_FILIAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_prompt=>'Filial'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(nvl(sigla,nome_filial)) d, cod_filial',
'  from filiais',
'where cod_empresa = :p203_param_empresa',
'AND F_Acesso_fil_PG_Apex(cod_empresa, cod_filial, :p_usuario) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P203_PARAM_EMPRESA'
,p_ajax_items_to_submit=>'P203_PARAM_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Filiais'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435860805456409167)
,p_name=>'P203_PARAM_CCUSTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome), cod',
'  from centro_de_custo',
' where cod_empresa = :p203_param_empresa',
' AND f_acesso_cc_pg_apex (cod_empresa, cod, :p_usuario) = ''S''',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P203_PARAM_EMPRESA'
,p_ajax_items_to_submit=>'P203_PARAM_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Centros de Custo'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435861122830409167)
,p_name=>'P203_PARAM_SITUACAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(200969618168090049864)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Ativo;A,Inativo;I,Todos;T'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435875616811409189)
,p_name=>'P203_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p203_emp',
'                               and matricula   = :p203_mat), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P203_EMP || ''|'' || :P203_MAT',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_colspan=>3
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435876105211409190)
,p_name=>'P203_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435876486057409190)
,p_name=>'P203_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435876866881409190)
,p_name=>'P203_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435877268802409191)
,p_name=>'P203_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435877639732409191)
,p_name=>'P203_EMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435878051004409191)
,p_name=>'P203_MAT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435878416129409192)
,p_name=>'P203_SEQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435878838719409192)
,p_name=>'P203_OK'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435879273966409192)
,p_name=>'P203_MENSAGEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(211084760904438861010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435886277614409201)
,p_name=>'P203_DATA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_prompt=>'Data'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct nvl(t.vira_dia, t.data_ponto) data_desc, nvl(t.vira_dia, t.data_ponto) data',
'  from pe_tratamento_batimentos t,',
'       parametros_recursos_humanos p',
' where t.cod_empresa = p.cod_empresa',
'   and t.cod_empresa = :p203_emp',
'   and t.matricula = :p203_mat',
'   and nvl(t.vira_dia, t.data_ponto) between :p203_dt_ini and :p203_dt_fim',
'   --and ((:p_painel = ''PO'') or (nvl(t.vira_dia, t.data_ponto) between nvl(p.dt_ini_ponto_gestor,nvl(t.vira_dia, t.data_ponto)) and nvl(p.dt_fim_ponto_gestor,nvl(t.vira_dia, t.data_ponto))))',
'and ((:p_painel = ''PO'') or (nvl(t.vira_dia, t.data_ponto) between nvl(p.dt_ini_ponto_gestor,nvl(t.vira_dia, t.data_ponto)) and nvl(p.dt_fim_ponto_gestor,nvl(t.vira_dia, t.data_ponto)))',
'    OR (:p_painel = ''PC'') or (nvl(t.vira_dia, t.data_ponto) between nvl(p.dt_ini_ponto_colab,nvl(t.vira_dia, t.data_ponto)) and nvl(p.dt_fim_ponto_colab,nvl(t.vira_dia, t.data_ponto)))',
'    OR (:p_painel = ''PG'') or (nvl(t.vira_dia, t.data_ponto) between nvl(p.dt_ini_ponto_gestor,nvl(t.vira_dia, t.data_ponto)) and nvl(p.dt_fim_ponto_gestor,nvl(t.vira_dia, t.data_ponto)))',
'    )',
'order by 2'))
,p_lov_cascade_parent_items=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435886653527409201)
,p_name=>'P203_ESCALA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_prompt=>'Escala'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select cod_escala||'' - ''||initcap(descricao) descricao, cod_escala',
'  from pe_escalas e',
'  where  ((exists (select 1 ',
'            from PE_ABONO_BATIDAS_SEQ_AUX where cod_escala = e.cod_escala and cod_empresa = :p203_EMP',
'             and matricula = :P203_MAT and data = to_date(:P203_DATA,''dd/mm/rrrr'') and seq = :P203_SEQ',
'             and  cod_escala = nvl(Fnct_Pe_Retorna_Escala(:P203_EMP, :P203_MAT, to_date(:P203_DATA,''dd/mm/rrrr''),''S''),Fnct_Pe_Retorna_Escala(:P203_EMP, :P203_MAT, to_date(:P203_DATA,''dd/mm/rrrr''),''N'')))) ',
'          or (e.cod_escala =  nvl(Fnct_Pe_Retorna_Escala(:P203_EMP, :P203_MAT, to_date(:P203_DATA,''dd/mm/rrrr''),''S''),Fnct_Pe_Retorna_Escala(:P203_EMP, :P203_MAT, to_date(:P203_DATA,''dd/mm/rrrr''),''N''))))',
'  order by 2'))
,p_lov_cascade_parent_items=>'P203_OPCAO,P203_EMP,P203_MAT,P203_DATA,P203_SEQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(187435887087304409202)
,p_name=>'P203_JORNADA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(211084765253157861019)
,p_prompt=>'Jornada'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select j.cod_jornada||'' - ''||initcap(j.nome_jornada) descricao, j.cod_jornada',
'  from pe_jornadas j',
' where j.cod_empresa = :p203_emp',
'  and ((exists (select 1 ',
'            from PE_ABONO_BATIDAS_SEQ_AUX where cod_jornada = j.cod_jornada and cod_empresa = :p203_EMP',
'             and matricula = :P203_MAT and data = to_date(:P203_DATA,''dd/mm/rrrr'') and seq = :P203_SEQ',
'             and cod_jornada = nvl(Fnct_Pe_Retorna_Jornada( :p203_emp,:p203_mat, :P203_DATA, ''S''),Fnct_Pe_Retorna_Jornada( :p203_emp,:p203_mat, :P203_DATA, ''N'') ) ))',
'          or (cod_jornada =  nvl(Fnct_Pe_Retorna_Jornada( :p203_emp,:p203_mat, :P203_DATA, ''S''),Fnct_Pe_Retorna_Jornada( :p203_emp,:p203_mat, :P203_DATA, ''N'') ) ))',
'order by j.cod_jornada'))
,p_lov_cascade_parent_items=>'P203_EMP,P203_MAT,P203_DATA,P203_ESCALA,P203_ESCALA_2,P203_SEQ,P203_OPCAO'
,p_ajax_items_to_submit=>'P203_EMP,P203_MAT,P203_DATA,P203_ESCALA,P203_ESCALA_2'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435902461702409218)
,p_name=>unistr('Di\00E1rio: Dialog_Closed_Diario')
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(211084765253157861019)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435903449383409219)
,p_event_id=>wwv_flow_api.id(187435902461702409218)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(185052904834470277568)
,p_name=>unistr('Di\00E1rio: Dialog_Closed_Periodo')
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(185052902906641277549)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(185052905166431277572)
,p_event_id=>wwv_flow_api.id(185052904834470277568)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435904843326409220)
,p_name=>unistr('(Requisi\00E7\00E3o) Seta Divergente')
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_OPCAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435905383554409221)
,p_event_id=>wwv_flow_api.id(187435904843326409220)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_divergente varchar2(1) := :p203_divergente;',
'',
'begin',
'',
'if :p203_opcao = ''R'' then',
':p203_divergente := ''N'';',
'else',
':p203_divergente := v_divergente;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P203_DIVERGENTE,P203_OPCAO'
,p_attribute_03=>'P203_DIVERGENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167415438335043965036)
,p_event_id=>wwv_flow_api.id(187435904843326409220)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199669327573211064236)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435905713945409221)
,p_name=>unistr('Open Hist\00F3rico')
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435891625358409208)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435906273971409222)
,p_event_id=>wwv_flow_api.id(187435905713945409221)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202146973198159595208)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(120689796398985861929)
,p_name=>'PesqColab'
,p_event_sequence=>69
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435874842218409189)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(120689796496929861930)
,p_event_id=>wwv_flow_api.id(120689796398985861929)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
':p203_seq := :p_matricula_user||to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_param_empresa,:p203_param_matricula,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
'END;'))
,p_attribute_02=>'P203_PARAM_EMPRESA,P203_PARAM_MATRICULA,P203_DT_INI,P203_DT_FIM,P203_SEQ,P203_DIVERGENTE'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(69376825522654986368)
,p_name=>'PesqColab_teste'
,p_event_sequence=>79
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435859538454409166)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(69376825627975986369)
,p_event_id=>wwv_flow_api.id(69376825522654986368)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
':p203_seq := :p_matricula_user||to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_param_empresa,:p203_param_matricula,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
'END;'))
,p_attribute_02=>'P203_PARAM_EMPRESA,P203_PARAM_MATRICULA,P203_DT_INI,P203_DT_FIM,P203_SEQ,P203_DIVERGENTE'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435906618946409222)
,p_name=>'Open Dialog Colab'
,p_event_sequence=>89
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435874842218409189)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435907153027409223)
,p_event_id=>wwv_flow_api.id(187435906618946409222)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(200969618168090049864)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435907596004409223)
,p_name=>'BTN_REQ_HE: Dialog Closed'
,p_event_sequence=>99
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435866821271409179)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435908068378409224)
,p_event_id=>wwv_flow_api.id(187435907596004409223)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435908424598409224)
,p_name=>'Refresh Region'
,p_event_sequence=>109
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435856812401409162)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435908990051409225)
,p_event_id=>wwv_flow_api.id(187435908424598409224)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_trava varchar2(1);',
'begin',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
':P203_TRAVA_APURACAO := PKG_PE_ABONO.fnc_trava_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim);',
'end;'))
,p_attribute_02=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DIVERGENTE,P203_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435909422016409225)
,p_event_id=>wwv_flow_api.id(187435908424598409224)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199669327573211064236)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435910003349409226)
,p_event_id=>wwv_flow_api.id(187435908424598409224)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435910442350409226)
,p_event_id=>wwv_flow_api.id(187435908424598409224)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122426514296362779)
,p_event_id=>wwv_flow_api.id(187435908424598409224)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167417859387957134215)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145336234751304665939)
,p_name=>'IR - Dialog Closed Refresh Region_1'
,p_event_sequence=>119
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(199669327573211064236)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145336234913134665940)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'end;'))
,p_attribute_02=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DIVERGENTE,P203_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145336234943353665941)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199669327573211064236)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145336235092313665942)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145336235218482665943)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145356330087824021394)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167417859387957134215)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29421702272603285341)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084765253157861019)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145356330199131021395)
,p_event_id=>wwv_flow_api.id(145336234751304665939)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P203_OPCAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(82177615966580177970)
,p_name=>unistr('Dialog Closed Refresh Regi\00F5es')
,p_event_sequence=>129
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(211084798499720861064)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(82177616619579177977)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'end;'))
,p_attribute_02=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DIVERGENTE,P203_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(82177616177865177972)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(199669327573211064236)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(82177616241070177973)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(82177616352906177974)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(82177616502054177975)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167417859387957134215)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29421702934176285348)
,p_event_id=>wwv_flow_api.id(82177615966580177970)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084765253157861019)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435913243978409229)
,p_name=>'Dispara Alerta'
,p_event_sequence=>139
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435913785250409229)
,p_event_id=>wwv_flow_api.id(187435913243978409229)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P203_MENSAGEM" ).getValue().length > 0){',
'alert( apex.item( "P203_MENSAGEM" ).getValue());',
'  apex.item( "P203_OK" ).setValue("N");',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435914205360409230)
,p_name=>'Valida Datas'
,p_event_sequence=>149
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_INI'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435914699271409230)
,p_event_id=>wwv_flow_api.id(187435914205360409230)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'/*',
'cursor c1 is',
'	SELECT dt_ini_ponto_gestor data_ini, ',
'         dt_fim_ponto_gestor data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P203_EMP;',
'',
'v_c1 c1%rowtype;',
'',
'v_msg varchar2(4000);',
'*/',
'begin',
'    :P203_DT_INI_PERIODO := :P203_DT_INI;',
'    /*',
'  if :p_painel <> ''PO'' then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.data_ini is not null then',
'',
'        if :p203_dt_ini is not null and',
'           :p203_dt_ini not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'           goto valida;',
'        end if;',
'',
'    end if;',
'',
'    if v_c1.data_fim is not null then',
'',
'        if :p203_dt_fim is not null and',
'           :p203_dt_fim not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'',
'        end if;',
'',
'    end if;',
'',
'  end if;',
'    <<valida>>',
'    ',
'    if v_msg is not null then',
'    :p203_mensagem := v_msg;',
'    :p203_ok := ''N'';',
'    else',
'    :p203_mensagem := null;',
'    :p203_ok := ''S'';',
'    end if;',
'*/',
'end;'))
,p_attribute_02=>'P203_EMP,P203_DT_INI,P203_DT_FIM,P_PAINEL'
,p_attribute_03=>'P203_MENSAGEM,P203_OK,,P203_DT_INI_PERIODO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188043652057610785524)
,p_event_id=>wwv_flow_api.id(187435914205360409230)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(139181237620243755544)
,p_name=>'Valida Datas_Fim'
,p_event_sequence=>159
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_FIM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(139181237696615755545)
,p_event_id=>wwv_flow_api.id(139181237620243755544)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'/*',
'cursor c1 is',
'	SELECT dt_ini_ponto_gestor data_ini, ',
'         dt_fim_ponto_gestor data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P203_EMP;',
'',
'v_c1 c1%rowtype;',
'',
'v_msg varchar2(4000);',
'*/',
'begin',
'    :P203_DT_FIM_PERIODO := :P203_DT_FIM;',
'    /*',
'  if :p_painel <> ''PO'' then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.data_ini is not null then',
'',
'        if :p203_dt_ini is not null and',
'           :p203_dt_ini not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'           goto valida;',
'        end if;',
'',
'    end if;',
'',
'    if v_c1.data_fim is not null then',
'',
'        if :p203_dt_fim is not null and',
'           :p203_dt_fim not between v_c1.data_ini and v_c1.data_fim then',
'',
unistr('           v_msg := ''Essa data est\00E1 fora do per\00EDodo de consulta de ''||to_char(v_c1.data_ini,''dd/mm/rrrr'')||'' at\00E9 ''||to_char(v_c1.data_fim,''dd/mm/rrrr'');'),
'',
'        end if;',
'',
'    end if;',
'',
'  end if;',
'    <<valida>>',
'    ',
'    if v_msg is not null then',
'    :p203_mensagem := v_msg;',
'    :p203_ok := ''N'';',
'    else',
'    :p203_mensagem := null;',
'    :p203_ok := ''S'';',
'    end if;',
'*/',
'end;'))
,p_attribute_02=>'P203_EMP,P203_DT_INI,P203_DT_FIM,P_PAINEL'
,p_attribute_03=>'P203_MENSAGEM,P203_OK,,P203_DT_FIM_PERIODO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(139181237789383755546)
,p_event_id=>wwv_flow_api.id(139181237620243755544)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(187435915012281409230)
,p_name=>'Ao alterar data'
,p_event_sequence=>169
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_FIM'
,p_condition_element=>'P203_OK'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136966737147878546930)
,p_event_id=>wwv_flow_api.id(187435915012281409230)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
'END;'))
,p_attribute_02=>'P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DIVERGENTE,P203_SEQ'
,p_attribute_03=>'P203_ESCALA,P203_JORNADA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(187435915555808409231)
,p_event_id=>wwv_flow_api.id(187435915012281409230)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122426728994362782)
,p_name=>unistr('Apura\00E7\00E3o: Dialog_Closed_Apuracao')
,p_event_sequence=>179
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(167429712966361886390)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122426913880362783)
,p_event_id=>wwv_flow_api.id(156122426728994362782)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143519066621734892616)
,p_name=>'Apurar - Dialog Closed'
,p_event_sequence=>189
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435879991157409193)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143519066696950892617)
,p_event_id=>wwv_flow_api.id(143519066621734892616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084765253157861019)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143519066889484892619)
,p_event_id=>wwv_flow_api.id(143519066621734892616)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(185052902906641277549)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142892197760671965138)
,p_name=>unistr('Mostra / Oculta Bot\00E3o Apuracao')
,p_event_sequence=>199
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_MOSTRA_BOTAO_APURACAO'
,p_condition_element=>'P203_MOSTRA_BOTAO_APURACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142892197869647965139)
,p_event_id=>wwv_flow_api.id(142892197760671965138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(187435879991157409193)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142892197966230965140)
,p_event_id=>wwv_flow_api.id(142892197760671965138)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(187435879991157409193)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142183075168209725535)
,p_name=>unistr('Atualizar Regi\00E3o')
,p_event_sequence=>209
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(211084798900202861065)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142183075302249725536)
,p_event_id=>wwv_flow_api.id(142183075168209725535)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140309783742388148098)
,p_name=>'Refresh Diario'
,p_event_sequence=>219
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(140309783599234148097)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140309783779543148099)
,p_event_id=>wwv_flow_api.id(140309783742388148098)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084765253157861019)
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140309784278856148104)
,p_name=>'Atualiza Regiao Requisicoes Abono'
,p_event_sequence=>229
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(140309784159557148103)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140309784378104148105)
,p_event_id=>wwv_flow_api.id(140309784278856148104)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127963905365071534081)
,p_name=>'Atualiza Regiao Requisicoes Abono_1'
,p_event_sequence=>239
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_INI_A'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127963905463859534082)
,p_event_id=>wwv_flow_api.id(127963905365071534081)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211084798900202861065)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127963906666694534094)
,p_name=>'Atualiza Regiao Requisicoes HE1'
,p_event_sequence=>249
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_INI_HE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127963906748855534095)
,p_event_id=>wwv_flow_api.id(127963906666694534094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127963906199059534089)
,p_name=>'Atualiza Regiao Requisicoes Apuracao_1'
,p_event_sequence=>259
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_INI_AP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127963906292669534090)
,p_event_id=>wwv_flow_api.id(127963906199059534089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167429712966361886390)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127963906949442534097)
,p_name=>'Atualiza Regiao Requisicoes HE2'
,p_event_sequence=>269
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_FIM_HE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127963907058882534098)
,p_event_id=>wwv_flow_api.id(127963906949442534097)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127963906323698534091)
,p_name=>'Atualiza Regiao Requisicoes Apuracao2'
,p_event_sequence=>279
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_FIM_AP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127963906431898534092)
,p_event_id=>wwv_flow_api.id(127963906323698534091)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167429712966361886390)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140309784627346148107)
,p_name=>'Atualiza Regiao Requisicoes HE'
,p_event_sequence=>289
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(140309784508014148106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140309784675163148108)
,p_event_id=>wwv_flow_api.id(140309784627346148107)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(211073970950870503669)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140309784875487148110)
,p_name=>'Atualiza Regiao Requisicoes Apuracao'
,p_event_sequence=>299
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(140309784785884148109)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140309784960135148111)
,p_event_id=>wwv_flow_api.id(140309784875487148110)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167429712966361886390)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(135479987194255340119)
,p_name=>'Recarrega'
,p_event_sequence=>349
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435859538454409166)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697609549608139)
,p_event_id=>wwv_flow_api.id(135479987194255340119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(187435859538454409166)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697182006608135)
,p_event_id=>wwv_flow_api.id(135479987194255340119)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P203_EMP := :P203_PARAM_EMPRESA;',
':P203_MAT := :P203_PARAM_MATRICULA;'))
,p_attribute_02=>'P203_PARAM_MATRICULA,P203_PARAM_EMPRESA'
,p_attribute_03=>'P203_MAT,P203_EMP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68068696833131608131)
,p_name=>'Recarrega_apoio_teste'
,p_event_sequence=>359
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435859538454409166)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697744386608140)
,p_event_id=>wwv_flow_api.id(68068696833131608131)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'window.meuSpinner = apex.util.showSpinner();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697041209608133)
,p_event_id=>wwv_flow_api.id(68068696833131608131)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_param_empresa,:p203_param_matricula,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
'end;'))
,p_attribute_02=>'P203_PARAM_EMPRESA,P203_PARAM_MATRICULA,P203_EMP,P203_MAT,P203_DT_INI,P203_DT_FIM,P203_OPCAO,P203_DIVERGENTE,P203_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068696874326608132)
,p_event_id=>wwv_flow_api.id(68068696833131608131)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P203_EMP := :P203_PARAM_EMPRESA;'
,p_attribute_02=>'P203_PARAM_EMPRESA'
,p_attribute_03=>'P203_EMP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697379962608137)
,p_event_id=>wwv_flow_api.id(68068696833131608131)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P203_MAT := :P203_PARAM_MATRICULA;'
,p_attribute_02=>'P203_PARAM_MATRICULA'
,p_attribute_03=>'P203_MAT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68068697113764608134)
,p_event_id=>wwv_flow_api.id(68068696833131608131)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(132701811639926756874)
,p_name=>'Data - Refresh'
,p_event_sequence=>369
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(132701811699123756875)
,p_event_id=>wwv_flow_api.id(132701811639926756874)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783911330856110194)
,p_name=>'Open Cons Eventos'
,p_event_sequence=>379
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(127968663705445440274)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783911376882110195)
,p_event_id=>wwv_flow_api.id(126783911330856110194)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_CONS_EVENTOS").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783911711824110198)
,p_name=>'Open Param Jornadas'
,p_event_sequence=>389
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(127968663763682440275)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783911787935110199)
,p_event_id=>wwv_flow_api.id(126783911711824110198)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_PARAM_JORNADAS").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783911882064110200)
,p_name=>'Open Escala Folga'
,p_event_sequence=>399
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(127968663839465440276)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783912074557110201)
,p_event_id=>wwv_flow_api.id(126783911882064110200)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_ESCALA_FOLGA").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783912494857110206)
,p_name=>'Open Rel Divergencias'
,p_event_sequence=>409
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435890054178409206)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783912614692110207)
,p_event_id=>wwv_flow_api.id(126783912494857110206)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REL_DIVERGENCIAS").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783912760095110208)
,p_name=>'Open Rel Folgas'
,p_event_sequence=>419
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435890468808409207)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783912844327110209)
,p_event_id=>wwv_flow_api.id(126783912760095110208)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REL_FOLGAS").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783912937338110210)
,p_name=>'Open Rel Espelho'
,p_event_sequence=>429
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435890827192409207)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783913026365110211)
,p_event_id=>wwv_flow_api.id(126783912937338110210)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REL_ESPELHO").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126783913141707110212)
,p_name=>'Open Rel Eventos'
,p_event_sequence=>439
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(187435891260515409207)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126783913195521110213)
,p_event_id=>wwv_flow_api.id(126783913141707110212)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REL_EVENTOS").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126114948248830036759)
,p_name=>'Open Trabalho Individual'
,p_event_sequence=>449
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(126114948044878036757)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126114948338456036760)
,p_event_id=>wwv_flow_api.id(126114948248830036759)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_TRBALHO_INDIVIDUAL").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126114948585387036763)
,p_name=>'Open Req Atestado'
,p_event_sequence=>459
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(126114948379181036761)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126114948724113036764)
,p_event_id=>wwv_flow_api.id(126114948585387036763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REQ_ATESTADO").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115504088568666612654)
,p_name=>'Refresh para data fim'
,p_event_sequence=>469
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_FIM_PERIODO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115504088690012612655)
,p_event_id=>wwv_flow_api.id(115504088568666612654)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115504088799404612656)
,p_name=>'Refresh para data ini'
,p_event_sequence=>479
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_DT_INI_PERIODO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115504088848782612657)
,p_event_id=>wwv_flow_api.id(115504088799404612656)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89274127604912946605)
,p_name=>'Open reprocessar'
,p_event_sequence=>489
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89274127466825946604)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89274127732448946606)
,p_event_id=>wwv_flow_api.id(89274127604912946605)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'javascript:window.open(apex.item("P203_URL_REPROCESSA").getValue(),''_blank'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(56238161579037552893)
,p_name=>unistr('Trava Apura\00E7\00E3o')
,p_event_sequence=>499
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P203_TRAVA_APURACAO'
,p_condition_element=>'P203_TRAVA_APURACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238161645515552894)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(126114948044878036757)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238162111496552899)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89274127466825946604)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238161689370552895)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(127968663839465440276)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238161995637552898)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(127968663839465440276)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238161790980552896)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89274127466825946604)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56238161907321552897)
,p_event_id=>wwv_flow_api.id(56238161579037552893)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(126114948044878036757)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435902096044409218)
,p_process_sequence=>10
,p_process_point=>'AFTER_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'deleta_temp'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
'',
'delete from pe_abono_apuracao_periodo_seq where seq = :p203_seq; commit;',
'--delete from pe_abono_batidas_seq where seq = :p203_seq; commit;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435900054803409216)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Seleciona Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p203_emp := :p203_param_empresa;',
':p203_mat := :p203_param_matricula;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(187435859538454409166)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435901242817409217)
,p_process_sequence=>30
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Apuracao_Periodo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435900436399409217)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'',
'',
' :p203_seq := :p_matricula_user||to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435900902456409217)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
'SELECT DATA_INI_REF_PONTO DATA_INI, ',
'       DATA_FIM_REF_PONTO DATA_FIM,',
'       nvl(dt_ini_ponto_gestor,DATA_INI_REF_PONTO) DATA_INI_GESTOR, ',
'       nvl(dt_fim_ponto_gestor,DATA_FIM_REF_PONTO) DATA_FIM_GESTOR,',
'       dt_ini_ponto_colab,',
'       dt_fim_ponto_colab      ',
'  FROM PARAMETROS_RECURSOS_HUMANOS',
' WHERE COD_EMPRESA = :P203_EMP;',
' ',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p203_emp',
'   and i.matricula = :p203_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p203_apurar_ok := ''N'';',
'',
':p203_cod_empresa := v_c1.empresa;',
':p203_matricula := v_c1.matricula;',
':p203_situacao := v_c1.situacao;',
':p203_dt_admissao := v_c1.dt_admissao;',
'',
'    if :p203_opcao is null then',
'       :p203_opcao := ''F'';',
'    end if;',
'',
'    if :p203_divergente is null then',
'       :p203_divergente := ''N'';',
'    end if;',
'',
'    if :P203_DT_INI is null then ',
'    ',
'      open c0;',
'      fetch c0 into v_c0;',
'      close c0;',
'        if :p_Painel = ''PO'' then',
'        ',
'        :p203_dt_ini := v_c0.data_ini;',
'        :p203_dt_fim := v_c0.data_fim;',
'        :P203_DT_INI_PERIODO := v_c0.data_ini;',
'        :P203_DT_FIM_PERIODO := v_c0.data_fim;',
'        ',
'        elsif :p_Painel = ''PG'' then',
'        ',
'        :p203_dt_ini := v_c0.data_ini_gestor;',
'        :p203_dt_fim := v_c0.data_fim_gestor;',
'        :P203_DT_INI_PERIODO := v_c0.data_ini_gestor;',
'        :P203_DT_FIM_PERIODO := v_c0.data_fim_gestor;',
'        ',
'        else',
'        ',
'        :p203_dt_ini := v_c0.dt_ini_ponto_colab;',
'        :p203_dt_fim := v_c0.dt_fim_ponto_colab;',
'        :P203_DT_INI_PERIODO := v_c0.dt_ini_ponto_colab;',
'        :P203_DT_FIM_PERIODO := v_c0.dt_fim_ponto_colab;',
'        ',
'        end if;',
'',
'    end if;',
'',
'    if :p203_data is null then',
'        begin',
'            select distinct nvl(vira_dia, data_ponto) data_desc',
'               into :p203_data',
'              from pe_tratamento_batimentos',
'             where cod_empresa = :p203_emp',
'               and matricula = :p203_mat',
'               and nvl(vira_dia, data_ponto) between :p203_dt_ini and :p203_dt_fim',
'               and rownum = 1',
'             order by 1;',
'        exception',
'        when no_data_found then',
'            null;',
'        end; ',
'    end if;',
'    ',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'/*',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'*/',
'exception',
'when others then',
':p203_cod_empresa := :p203_emp;',
':p203_matricula := :p203_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P203_MAT'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(187435901680333409218)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'apuracao_periodo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;    ',
'',
'begin',
'PKG_PE_ABONO.prc_pe_abono_bat_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim,:p203_opcao, :p203_divergente, :p203_seq);',
'exception ',
'    when others then',
'        apex_error.add_error(p_message => sqlerrm, p_display_location => apex_error.c_inline_in_notification);',
'end;     ',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P203_MAT'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167425965576434361030)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Localiza Parametro'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select usa_req_apuracao, USA_REQ_PERIODO',
'        into :P203_USE_REQ, :P203_USE_REQ_PERIODO',
'    from parametros_recursos_humanos',
'    where cod_empresa = :P203_EMP;',
'',
'exception',
'    when others then',
'        :P203_USE_REQ := ''N'';',
'        :P203_USE_REQ_PERIODO := ''N'';',
'end;        ',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(126783911196603110193)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('URLs Bot\00F5es')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P203_URL_CONS_EVENTOS := apex_page.get_url (',
'p_application => ''FREQ_CONSULTAS_''||:P_BASE,',
'p_page        => 2,',
'p_items       => ''P2_COD_EMPRESA,P2_MATRICULA_INI,P2_MATRICULA_FIM,P2_DT_INI,P2_DT_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 2',
');',
'',
':P203_URL_PARAM_JORNADAS := apex_page.get_url (',
'p_application => ''FREQ_PARAM_''||:P_BASE,',
'p_page        => 8,',
'p_items       => ''P8_EMP,P8_MAT,P8_DT_INI,P8_DT_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 8',
');',
'',
':P203_URL_ESCALA_FOLGA := apex_page.get_url (',
'p_application => ''FREQ_CONSULTAS_''||:P_BASE,',
'p_page        => 35,',
'p_items       => ''P35_EMPRESAS_IND,P35_MATRICULAS_IND,P35_TIPO_FOLGA,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_TP_FOLGA||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 35',
');',
'',
':P203_URL_REL_DIVERGENCIAS := apex_page.get_url (',
'p_application => ''FREQ_REL_''||:P_BASE,',
'p_page        => 39,',
'p_items       => ''P39_EMP,P39_MAT,P39_DATA_INI,P39_DATA_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 39',
');',
'',
':P203_URL_REL_FOLGAS := apex_page.get_url (',
'p_application => ''FREQ_REL_''||:P_BASE,',
'p_page        => 44,',
'p_items       => ''P44_EMP,P44_MAT,P44_DATA_INI,P44_DATA_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 44',
');',
'',
':P203_URL_REL_ESPELHO := apex_page.get_url (',
'p_application => ''FREQ_REL_''||:P_BASE,',
'p_page        => 45,',
'p_items       => ''P45_EMP,P45_MAT,P45_DATA_INI,P45_DATA_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 45',
');',
'',
':P203_URL_REL_EVENTOS := apex_page.get_url (',
'p_application => ''FREQ_REL_''||:P_BASE,',
'p_page        => 46,',
'p_items       => ''P46_EMP,P46_MAT,P46_DATA_INI,P46_DATA_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 46',
');',
'',
'/*:P203_URL_TRBALHO_INDIVIDUAL := apex_page.get_url (',
'p_application => ''FREQ_CONSULTAS_''||:P_BASE,',
'p_page        => 99178,',
'p_items       => ''P99178_COD_EMP,P99178_MATRICULA,P99178_DATA_INI,P99178_DATA_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 99178',
');*/',
'',
':P203_URL_TRBALHO_INDIVIDUAL := apex_page.get_url (',
'p_application => ''FREQ_CONSULTAS_''||:P_BASE,',
'p_page        => 99178,',
'p_items       => ''P99178_COD_EMPRESA,P99178_MATRICULA,P99178_DT_INI,P99178_DT_FIM,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 99178',
');',
'',
':P203_URL_REQ_ATESTADO := apex_page.get_url (',
'p_application => ''MT_ATD_''||:P_BASE,',
'p_page        => 90,',
'p_items       => ''P90_EMPRESA,P90_MATRICULA,P90_PERIODO,P_PAINEL,P_USUARIO'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||7||'',''||:P_PAINEL||'',''||:P_USUARIO,',
'p_clear_cache => 90',
');',
'',
':P203_URL_REPROCESSA := apex_page.get_url (',
'p_application => ''IMP_PE_''||:P_BASE,',
'p_page        => 10,',
'p_items       => ''P10_FILTRO_EMP,P10_FILTRO_MAT,P10_FILTRO_DT_INI,P10_FILTRO_DT_FIM,P_PAINEL,P_USUARIO,P10_REPROCESSAR'',',
'p_values      => :P203_EMP||'',''||:P203_MAT||'',''||:P203_DT_INI||'',''||:P203_DT_FIM||'',''||:P_PAINEL||'',''||:P_USUARIO||'',S'',',
'p_clear_cache => 10',
');',
'',
':P203_TRAVA_APURACAO := PKG_PE_ABONO.fnc_trava_abono(:p203_emp,:p203_mat,:p203_dt_ini,:p203_dt_fim);'))
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
