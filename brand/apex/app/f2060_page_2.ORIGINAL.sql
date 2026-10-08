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
--   Date and Time:   22:37 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00002
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(19041533386153604874)
,p_name=>unistr('Requisi\00E7\00E3o de Lan\00E7amentos Diversos')
,p_step_title=>unistr('Requisi\00E7\00E3o de Lan\00E7amentos Diversos')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var appItemPainelVal = ''&P_PAINEL.'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (appItemPainelVal == ''PC''){',
'    $(''#t_Header'').addClass(''hide'');',
'}',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.hide {',
'    display: none !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(19041491274285604703)
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'ANDRE.BONI'
,p_last_upd_yyyymmddhh24miss=>'20250821201251'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(46213689260575130511)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Lan\00E7amentos Diversos')
,p_icon_css_classes=>'fa-money'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(19041505814227604777)
,p_plug_display_sequence=>60
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>'<p></p>'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(63349560445845010750)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>50
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(58058145560961137751)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(19041507389315604780)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(69132570433944353978)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:is-expanded:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(19041503676025604775)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P2_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(69132574432280353984)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Reembolso Diversos')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(19041506869274604778)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       CASE WHEN :P_PAINEL = ''PC'' THEN             ',
'          APEX_UTIL.PREPARE_URL(p_url => ''f?p=&APP_ID.:11:&APP_SESSION.::NO::P11_COD_REQ,P11_EMP:''||c.solicitacao||'',''||r.cod_empresa) ',
'       ELSE  ',
'          APEX_UTIL.PREPARE_URL(p_url => ''f?p=&APP_ID.:7:&APP_SESSION.::NO::P7_COD_REQ,P7_EMP:''||c.solicitacao||'',''||r.cod_empresa) ',
'       END LINK,',
'       c.solicitacao REQUISICAO,',
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
'       r.cod_empresa COD_EMPRESA,',
'       r.cod_req cod_solicitacao,',
'       c.cod_empresa_solicitante,',
'       c.mat_solicitante,',
'       r.matricula,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) Filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) centro_de_custo,',
'       i.unidade_adm||'' - ''||initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||initcap(fnct_nome_atividade(i.cod_atividade)) atividade,',
'       i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo,',
'       r.cod_processo',
'  from consulta_requisicoes c,',
'       REQ_REEMBOLSO r,',
'       informacoes_funcionais_cad i',
' where upper(c.tipo_req) = ''REQ_REEMBOLSO''',
'   and c.cod_empresa     = r.cod_empresa',
'   and c.solicitacao     = r.cod_req',
'   and r.cod_empresa = i.cod_empresa',
'   and r.matricula = i.matricula',
'   and (((c.cod_empresa_solicitante = :P_EMPRESA_USER',
'   and           c.mat_solicitante = :P_MATRICULA_USER) or ',
'        (c.cod_emp_aprov = :P_EMPRESA_USER',
'   and       c.mat_aprov = :P_MATRICULA_USER) and :p_painel = ''PG'') or',
'        ((((f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel) = ''S'') or (COD_EMP_APROV = :P_EMPRESA_USER AND MAT_APROV = :P_MATRICULA_USER)))',
'         and :p_painel = ''PO'') or',
'        (i.cod_empresa = :P_EMPRESA_USER and i.matricula = :P_MATRICULA_USER and :p_painel = ''PC'') or',
'        (r.cod_empresa = :p2_emp and r.matricula = :p2_mat and :p2_mat is not null))',
'   and ((r.cod_sit_req = :p2_sit_req) or (:p2_sit_req is null))',
'   and (((trunc(sysdate) - trunc(r.dt_req)) <= :p2_periodo) or (:p2_periodo = 0))',
'   and (:p2_REQUISICAO  is null or c.solicitacao        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(REPLACE(TRIM(:p2_REQUISICAO),'' ''), '','')) t))',
'   and (:p2_empresa     is null or i.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_EMPRESA, '','')) t))',
'   and (:p2_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_FILIAL, '','')) t))',
'   and (:p2_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_CCUSTO, '','')) t))',
'   and (:p2_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_UNIDADE_ADM, '','')) t))',
'   and (:p2_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_ATIVIDADE, '','')) t))',
'   and (:p2_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_CARGO, '','')) t))',
'   and (:p2_MATRICULA_1   is null or i.matricula    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_MATRICULA_1, '','')) t))   ',
' order by solicitacao desc'))
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
 p_id=>wwv_flow_api.id(2127300702588579222)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'ANDRE.BONI'
,p_internal_uid=>987869880175640117
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127303017506579245)
,p_db_column_name=>'LINK'
,p_display_order=>10
,p_column_identifier=>'W'
,p_column_label=>'Detalhes'
,p_column_link=>'#LINK#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301003595579225)
,p_db_column_name=>'REQUISICAO'
,p_display_order=>20
,p_column_identifier=>'C'
,p_column_label=>'Requisicao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301065938579226)
,p_db_column_name=>'DATA_ABERTURA'
,p_display_order=>30
,p_column_identifier=>'D'
,p_column_label=>'Data Abertura'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301126788579227)
,p_db_column_name=>'EMPRESA'
,p_display_order=>40
,p_column_identifier=>'E'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301233110579228)
,p_db_column_name=>'MATRICULA_SOLICITADA'
,p_display_order=>50
,p_column_identifier=>'F'
,p_column_label=>'Matricula Solicitada'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301342631579229)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>60
,p_column_identifier=>'G'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301498033579230)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>70
,p_column_identifier=>'H'
,p_column_label=>'Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301567144579231)
,p_db_column_name=>'SITUACAO'
,p_display_order=>80
,p_column_identifier=>'I'
,p_column_label=>'Situacao'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301642106579232)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>90
,p_column_identifier=>'J'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301758085579233)
,p_db_column_name=>'COD_SOLICITACAO'
,p_display_order=>100
,p_column_identifier=>'K'
,p_column_label=>'Cod Solicitacao'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301838910579234)
,p_db_column_name=>'COD_EMPRESA_SOLICITANTE'
,p_display_order=>110
,p_column_identifier=>'L'
,p_column_label=>'Cod Empresa Solicitante'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127301931518579235)
,p_db_column_name=>'MAT_SOLICITANTE'
,p_display_order=>120
,p_column_identifier=>'M'
,p_column_label=>'Mat Solicitante'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302090294579236)
,p_db_column_name=>'MATRICULA'
,p_display_order=>130
,p_column_identifier=>'N'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302206572579237)
,p_db_column_name=>'FILIAL'
,p_display_order=>140
,p_column_identifier=>'O'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302235075579238)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>'Centro De Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302412892579239)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Unidade Adm'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302508086579240)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Atividade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302547022579241)
,p_db_column_name=>'CARGO'
,p_display_order=>180
,p_column_identifier=>'S'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(2127302700735579242)
,p_db_column_name=>'COD_PROCESSO'
,p_display_order=>190
,p_column_identifier=>'T'
,p_column_label=>'Cod Processo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(2146703093943157780)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'10072723'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'LINK:REQUISICAO:DATA_ABERTURA:EMPRESA:MATRICULA_SOLICITADA:EMPRESA_SOLICITANTE:SOLICITANTE:SITUACAO:COD_EMPRESA:COD_SOLICITACAO:COD_EMPRESA_SOLICITANTE:MAT_SOLICITANTE:MATRICULA:FILIAL:CENTRO_DE_CUSTO:UNIDADE_ADM:ATIVIDADE:CARGO:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1440691861614397062)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1440692259340397064)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-minus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1440692682277397065)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1440698525104397083)
,p_button_sequence=>540
,p_button_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_button_name=>'p2_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(19041528064842604821)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P2_EMP.,&P2_MAT.,&P2_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(2052228304818041246)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(69132574432280353984)
,p_button_name=>'CRIAR_REQUISICAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar Requisicao'
,p_button_position=>'TOP'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP,11:P11_EMP,P11_MAT:&P2_EMP.,&P2_MAT.'
,p_button_condition=>'select 1 from dual where :P_PAINEL = ''PC'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1440711586796397107)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(69132574432280353984)
,p_button_name=>'LANCAMENTOS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Lan\00E7amentos Diversos em Lote')
,p_button_position=>'TOP'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RP,7:P7_EMP,P7_MAT,P7_PAINEL:&P2_EMPRESA.,&P2_MATRICULA.,&P_PAINEL.'
,p_button_condition=>'select 1 from dual where :P_PAINEL in (''PO'', ''PG'')'
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(1400007333069657444)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(69132574432280353984)
,p_button_name=>'PARAMETRIZACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(19041528354633604824)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Parametriza\00E7\00E3o')
,p_button_position=>'TOP'
,p_button_redirect_url=>'f?p=&APP_ID.:4:&SESSION.::&DEBUG.:RP,4::'
,p_button_condition=>'select 1 from dual where :P_PAINEL = ''PO'''
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-power-off'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440693063878397065)
,p_name=>'P2_SIT_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_prompt=>unistr('Situa\00E7\00E3o da Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>unistr('STATIC:Aberta;1,Conclu\00EDda;2,Cancelada;3,Reprovada;4,Aprovada;5,Suspens\00E3o;6')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todas'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440693553561397066)
,p_name=>'P2_PERIODO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_prompt=>unistr('Requisi\00E7\00F5es Criadas')
,p_source=>'15'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:\00DAltimos 15 Dias;15,\00DAltimos 30 Dias;30,\00DAltimos 60 dias;60,\00DAltimos 90 Dias;90,Todo o Per\00EDodo;0')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440693878503397067)
,p_name=>'P2_REQUISICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(63349560445845010750)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_placeholder=>'Ex.: 400,401,402'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440694628481397070)
,p_name=>'P2_EMPRESA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(nvl(e.nome_abrev,e.nome)) descricao, e.cod codigo ',
'  from empresas_cad e',
' WHERE F_Acesso_Emp_PG_APEX(e.cod, :P_USUARIO, ''PO'') = ''S'' ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440694962086397076)
,p_name=>'P2_UTILIZA_SECAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440695426023397077)
,p_name=>'P2_FILIAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_filial||'' - ''||Initcap(nvl(f.sigla,f.nome_filial)) descricao, f.cod_filial',
'  from filiais_cad f',
'where ((instr('',''||:p2_empresa||'','','',''||f.cod_empresa||'','') > 0) or (:p2_empresa is null))',
'AND F_Acesso_Fil_PG_APEX(f.cod_empresa, f.cod_filial, :P_USUARIO, ''PO'') = ''S''',
'and f.encer_ativ = ''N''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P2_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440695835107397078)
,p_name=>'P2_CCUSTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p2_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_empresa, '','')) t))',
'and (:p2_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p2_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, ''PO'') = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P2_EMPRESA,P2_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440696200005397078)
,p_name=>'P2_UNIDADE_ADM'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p2_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p2_empresa is null))',
'       and ((instr('',''||:p2_filial||'','','',''||a.cod_filial||'','') > 0) or (:p2_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p2_ccusto',
'       and ((instr('',''||:p2_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p2_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p2_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p2_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p2_empresa is null))',
'       and ((instr('',''||:p2_filial||'','','',''||a.cod_filial||'','') > 0) or (:p2_filial is null))',
'       and :p2_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P2_EMPRESA,P2_FILIAL,P2_CCUSTO,P2_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440696600270397079)
,p_name=>'P2_ATIVIDADE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p2_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p2_empresa is null))',
'   and ((instr('',''||:p2_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p2_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p2_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p2_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P2_CCUSTO,P2_UNIDADE_ADM,P2_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440696993492397079)
,p_name=>'P2_CARGO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440697380695397079)
,p_name=>'P2_MATRICULA_1'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(p.nome) d, i.matricula',
'  from informacoes_funcionais i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.situacao < ''90''',
'  -- and ((i.situacao < ''90'' and :p2_situacao = ''A'') or (i.situacao >= ''90'' and :p2_situacao = ''D'') or (:p2_situacao = ''T''))',
'   and (:P2_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P2_EMPRESA, '','')) t))',
'   and (:P2_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P2_FILIAL, '','')) t))',
'   and (:P2_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P2_CCUSTO, '','')) t))',
'   and (:P2_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P2_UNIDADE_ADM, '','')) t))',
'   and (:P2_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P2_ATIVIDADE, '','')) t))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P2_CCUSTO,P2_UNIDADE_ADM,P2_UTILIZA_SECAO,P2_ATIVIDADE,P2_EMPRESA,P2_FILIAL,P2_CARGO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P2_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440697844353397080)
,p_name=>'P2_PESQUISA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(58058145560961137751)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440698885828397084)
,p_name=>'P2_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>'select foto from fotos where cod_empresa = :p2_emp and matricula = :p2_mat'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440699291908397084)
,p_name=>'P2_COD_EMPRESA1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440699753608397085)
,p_name=>'P2_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440700148220397085)
,p_name=>'P2_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440700550244397085)
,p_name=>'P2_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(19041527740309604817)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440700941681397086)
,p_name=>'P2_EMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440701270613397086)
,p_name=>'P2_MAT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(1440701751884397086)
,p_name=>'P2_CHAMADOR'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(69132570433944353978)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440712370794397110)
,p_name=>'Dispara Alerta'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_MENSAGEM'
,p_condition_element=>'P2_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440712890678397111)
,p_event_id=>wwv_flow_api.id(1440712370794397110)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P2_FLAG'').value == "Q") {',
'alertify.confirm($v(''P2_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P2_FLAG'').value = ''S'';',
'        $x(''P2_MENSAGEM'').value = '''';',
'        $x(''P2_OK'').value = ''S'';',
'        $(''#P2_CREATE'').show();',
'    } else {',
'        $x(''P2_OK'').value = ''N'';',
'        $(''#P2_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P2_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P2_FLAG'').value == "N") {',
'            $(''#P2_CREATE'').hide();',
'        } else {',
'            $(''#P2_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P2_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440713275524397112)
,p_name=>'Carrega Plugin'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440713760552397112)
,p_event_id=>wwv_flow_api.id(1440713275524397112)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440715604911397114)
,p_name=>'Dialog Closed'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(69132574432280353984)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440716145362397115)
,p_event_id=>wwv_flow_api.id(1440715604911397114)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(69132574432280353984)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440716461368397115)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(1440691861614397062)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440717001198397116)
,p_event_id=>wwv_flow_api.id(1440716461368397115)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var element = document.getElementById(''PARAMETROS_ITENS'');',
'',
'element.classList.add("expandRegion");',
'element.classList.remove("collapseRegion");',
'',
'apex.item("OPEN_PARAMETROS").hide();',
'apex.item("CLOSE_PARAMETROS").show();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440717373714397116)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>140
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(1440692259340397064)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440717934166397116)
,p_event_id=>wwv_flow_api.id(1440717373714397116)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var element = document.getElementById(''PARAMETROS_ITENS'');',
'',
'element.classList.remove("expandRegion");',
'element.classList.add("collapseRegion");',
'',
'apex.item("CLOSE_PARAMETROS").hide();',
'apex.item("OPEN_PARAMETROS").show();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440718294017397116)
,p_name=>'Pesquisa'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(1440692682277397065)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440718781740397117)
,p_event_id=>wwv_flow_api.id(1440718294017397116)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p2_pesquisa := ''S'';'
,p_attribute_03=>'P2_PESQUISA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440719332250397117)
,p_event_id=>wwv_flow_api.id(1440718294017397116)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(1440719699660397117)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(1440720246055397118)
,p_event_id=>wwv_flow_api.id(1440719699660397117)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p2_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p2_empresa||'','','',''||cod_empresa||'','') > 0) or (:p2_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P2_EMPRESA'
,p_attribute_03=>'P2_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(1440712009981397109)
,p_process_sequence=>10
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
'       i.dt_admissao',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p2_emp',
'   and i.matricula = :p2_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p2_cod_empresa1 := v_c1.empresa;',
':p2_matricula := v_c1.matricula;',
':p2_situacao := v_c1.situacao;',
':p2_dt_admissao := v_c1.dt_admissao;',
'',
'--:p2_OK := ''S'';',
'',
'exception',
'when others then',
':p2_cod_empresa := :p2_emp;',
':p2_matricula := :p2_mat;',
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
