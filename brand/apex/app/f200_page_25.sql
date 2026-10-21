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
,p_default_id_offset=>805756123742460090
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   21:22 Thursday October 8, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 25
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00025
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>25);
end;
/
prompt --application/pages/page_00025
begin
wwv_flow_api.create_page(
 p_id=>25
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>unistr('Controle de Funcion\00E1rios Afastados')
,p_step_title=>unistr('Controle de Funcion\00E1rios Afastados')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Afastamentos.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Afastamentos.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(283867002111251591073)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'AARAO.PRIMO'
,p_last_upd_yyyymmddhh24miss=>'20260324164856'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(275999567065926837070)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>5
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(271112851741372353539)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283826125206395937786)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(283780677543880158203)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(283867039513876591195)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283826191712090245013)
,p_plug_name=>unistr('Controle de Funcion\00E1rios Afastados')
,p_region_name=>'IR'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT i.cod_empresa COD_EMPRESA, ',
'       i.cod_empresa||'' - ''||Initcap(fnct_nome_empresa(i.cod_empresa,''S'')) NOME_EMPRESA, ',
'       i.FILIAL||'' - ''||Initcap(fnct_nome_filial(i.cod_empresa, i.filial,''S'')) NOME_FILIAL, ',
'       i.cod_ccusto||'' - ''||Initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) NOME_CCUSTO,',
'       i.unidade_adm||'' - ''||Initcap(fnct_nome_unidade_adm(i.cod_empresa, null, i.unidade_adm)) unidade_adm,',
'       i.cod_atividade||'' - ''||INITCAP(fnct_nome_atividade(i.cod_atividade)) Atividade,',
'       i.cargo||'' - ''||Initcap(fnct_nome_cargo(i.cargo)) CARGO, ',
'       I.MATRICULA||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador, ',
'      -- i.sindicato||'' - ''||i.nome_sindicato sindicato,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) SITUACAO_FUNC, ',
'       I.DT_SITUACAO, ',
'       I.DT_ADMISSAO, ',
'       Initcap(fnct_nome_vinculo(i.vinculo)) vinculo,',
'       Initcap(fnct_nome_motivo_alt (a.mot_alt)) motivo, ',
'       a.cod_valor_fato||'' - ''||Initcap(fnct_nome_situacao (a.cod_valor_fato)) situacao,',
'       a.dt_vigencia data_ini,',
'--       a.dt_vigencia_fim data_fim,',
'       nvl(a.dt_vigencia_fim,(SELECT AF.DT_TERMINO_AFASTAMENTO',
'        FROM   ATESTADO_FUNCIONARIO AF',
'        WHERE  ROWNUM = 1',
'        AND    I.DT_RETORNO_AFAST-1 = AF.DT_TERMINO_AFASTAMENTO',
'        AND    AF.DT_TERMINO_AFASTAMENTO IS NOT NULL',
'        AND    I.DT_RETORNO_AFAST IS NOT NULL',
'        AND    AF.DT_INICIO_AFASTAMENTO = A.DT_VIGENCIA',
'        AND    AF.MATRICULA = A.MATRICULA',
'        AND    AF.COD_EMPRESA = A.COD_EMPRESA)) data_fim,',
'       I.DT_RETORNO_AFAST DT_RET_PREV,',
'       I.MATRICULA',
'      -- ''f?p=&APP_ID.:13:''||:APP_SESSION||''::::P13_EMP,P13_MAT:''||I."COD_EMPRESA"||'',''||I."MATRICULA" LINK,',
'      -- ''Colaborador'' Tipo,',
'      -- i.cod_emp_gestor,',
'      -- i.mat_gestor,',
'      -- i.mat_gestor||'' - ''||i.nome_gestor gestor,',
'      -- i.cod_ccusto_superior||'' - ''||i.nome_ccusto_superior ccusto_superior,',
'      -- i.nome_de_guerra,',
'      -- i.nome_social,',
'      -- i.cpf,',
'      -- i.email_funcional',
'FROM HISTORICO_CADASTRAL a,',
'     informacoes_funcionais i',
'WHERE a.cod_empresa = i.cod_empresa',
'  and a.matricula = i.matricula',
' and a.cod_fato = 1',
' and a.cod_valor_fato <> ''01''',
' -- and i.situacao < ''90''',
'  --and i.dt_situacao = a.dt_vigencia',
'  --and i.situacao = a.cod_valor_fato',
'  and (:P25_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_EMPRESA, '','')) t))',
'  and (:P25_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_FILIAL, '','')) t))',
'  and (:P25_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_CCUSTO, '','')) t))',
'  and (:P25_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_UNIDADE_ADM, '','')) t))',
'  and (:P25_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_ATIVIDADE, '','')) t))',
'  and (:P25_CARGO       is null or i.cargo         in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_CARGO, '','')) t))',
'  and (:P25_MATRICULA   is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_MATRICULA, '','')) t))',
'       ',
'  /* and ((:P25_SITUACAO is null     and i.situacao <  ''90'' and a.cod_valor_fato < ''90'' and a.cod_valor_fato <> ''01'') or ',
'       (:P25_SITUACAO is not null and i.situacao >= ''90'' and a.cod_valor_fato in (select column_value from table(apex_string.split(:P25_SITUACAO, '','')) t)))*/',
'       ',
'       and ((:P25_SITUACAO is null     and a.cod_valor_fato <  ''90'' and a.cod_valor_fato <> ''01'') or ',
'     (:P25_SITUACAO is not null and i.situacao >= ''90'' and a.cod_valor_fato in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_SITUACAO, '','')) t)))',
'       ',
'  and ((:P25_DATA_INI is null) or ((a.dt_vigencia     between :P25_DATA_INI and :P25_DATA_FIM) or ',
'       (a.dt_vigencia_fim between :P25_DATA_INI and :P25_DATA_FIM)))'))
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
,p_plug_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  and ((:P25_SITUACAO is null     and a.cod_valor_fato < ''90'' and a.cod_valor_fato <> ''01'') or ',
'       (:P25_SITUACAO is not null and a.cod_valor_fato in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_SITUACAO, '','')) t)))'))
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(283826192158884245014)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>52710393323558664
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826192221165245014)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826193013774245015)
,p_db_column_name=>'MATRICULA'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826193820223245016)
,p_db_column_name=>'SITUACAO'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101581746393812405)
,p_db_column_name=>'NOME_EMPRESA'
,p_display_order=>70
,p_column_identifier=>'J'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101581917559812406)
,p_db_column_name=>'NOME_FILIAL'
,p_display_order=>80
,p_column_identifier=>'K'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101581941711812407)
,p_db_column_name=>'NOME_CCUSTO'
,p_display_order=>90
,p_column_identifier=>'L'
,p_column_label=>'C.Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582082803812408)
,p_db_column_name=>'UNIDADE_ADM'
,p_display_order=>100
,p_column_identifier=>'M'
,p_column_label=>'Unidade Adm.'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582205143812409)
,p_db_column_name=>'ATIVIDADE'
,p_display_order=>110
,p_column_identifier=>'N'
,p_column_label=>'Atividade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582232369812410)
,p_db_column_name=>'CARGO'
,p_display_order=>120
,p_column_identifier=>'O'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582403976812411)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>130
,p_column_identifier=>'P'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582446031812412)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>140
,p_column_identifier=>'Q'
,p_column_label=>unistr('Data de Admiss\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582564706812413)
,p_db_column_name=>'VINCULO'
,p_display_order=>150
,p_column_identifier=>'R'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582640972812414)
,p_db_column_name=>'MOTIVO'
,p_display_order=>160
,p_column_identifier=>'S'
,p_column_label=>'Motivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582774556812415)
,p_db_column_name=>'DATA_INI'
,p_display_order=>170
,p_column_identifier=>'T'
,p_column_label=>'Data Inicial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101582836396812416)
,p_db_column_name=>'DATA_FIM'
,p_display_order=>180
,p_column_identifier=>'U'
,p_column_label=>'Data Final'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101583016970812417)
,p_db_column_name=>'DT_RET_PREV'
,p_display_order=>190
,p_column_identifier=>'V'
,p_column_label=>'Data de Retorno Prevista'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101547942506623306)
,p_db_column_name=>'SITUACAO_FUNC'
,p_display_order=>200
,p_column_identifier=>'W'
,p_column_label=>unistr('Situa\00E7\00E3o Atual')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(271101548104795623307)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>210
,p_column_identifier=>'X'
,p_column_label=>unistr('Data de Situa\00E7\00E3o Atual')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283826195854100245021)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'527141'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_EMPRESA:NOME_FILIAL:NOME_CCUSTO:UNIDADE_ADM:ATIVIDADE:COLABORADOR:CARGO:SITUACAO:MOTIVO:DATA_INI:DATA_FIM:DT_RET_PREV:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113061126715618254)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113061395584619253)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-minus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271101566850622712722)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(60695007275494240847)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(283826191712090245013)
,p_button_name=>'IA'
,p_button_static_id=>'BTN_IA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'IA'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_base = ''NATCORP'' then',
' return true;',
'else',
' return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_button_css_classes=>'btnIA fab-ia-natcorp'
,p_button_cattributes=>'style="background-image: url(''#WORKSPACE_IMAGES#IA-NATCORP-LOGO (128X128).png''); background-size: cover; background-position: center;"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60695007604659240851)
,p_name=>'P25_STATIC_ID_IR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60695007733714240852)
,p_name=>'P25_FLG'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696539537379292703)
,p_name=>'P25_MSG'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696539599388292704)
,p_name=>'P25_SYS_PROMPT'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(60696539726463292705)
,p_name=>'P25_USER_PROMPT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101567673841712739)
,p_name=>'P25_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101568101361712742)
,p_name=>'P25_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101568511448712743)
,p_name=>'P25_FILIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p25_empresa||'','','',''||cod_empresa||'','') > 0) or (:p25_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P25_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101568916551712744)
,p_name=>'P25_CCUSTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p25_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p25_empresa, '','')) t))',
'and (:p25_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p25_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P25_EMPRESA,P25_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101569233255712746)
,p_name=>'P25_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p25_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p25_empresa is null))',
'       and ((instr('',''||:p25_filial||'','','',''||a.cod_filial||'','') > 0) or (:p25_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p25_ccusto',
'       and ((instr('',''||:p25_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p25_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p25_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p25_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p25_empresa is null))',
'       and ((instr('',''||:p25_filial||'','','',''||a.cod_filial||'','') > 0) or (:p25_filial is null))',
'       and :p25_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P25_EMPRESA,P25_FILIAL,P25_CCUSTO,P25_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101569699586712752)
,p_name=>'P25_ATIVIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p25_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p25_empresa is null))',
'   and ((instr('',''||:p25_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p25_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p25_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p25_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P25_CCUSTO,P25_UNIDADE_ADM,P25_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101570118133712754)
,p_name=>'P25_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101570459490712755)
,p_name=>'P25_MATRICULA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) d, i.matricula',
'  from informacoes_funcionais i',
' where (:P25_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_EMPRESA, '','')) t))',
'   and (:P25_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_FILIAL, '','')) t))',
'   and (:P25_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_CCUSTO, '','')) t))',
'   and (:P25_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_UNIDADE_ADM, '','')) t))',
'   and (:P25_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_ATIVIDADE, '','')) t))',
'  /* and ((:P25_SITUACAO is null     ) or --and i.situacao < ''90'' and i.situacao <> ''01''*',
'        (:P25_SITUACAO is not null and i.situacao in (select column_value from table(apex_string.split(:P25_SITUACAO, '','')) t)))*/',
'          and (:P25_SITUACAO is null or exists (',
'            select 1 ',
'              from historico_cadastral a',
'             where a.cod_empresa    = i.cod_empresa',
'               and a.matricula      = i.matricula',
'               and a.cod_fato       = 1',
'               and a.cod_valor_fato in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P25_SITUACAO, '','')) t)',
'        ))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P25_CCUSTO,P25_UNIDADE_ADM,P25_ATIVIDADE,P25_EMPRESA,P25_FILIAL,P25_CARGO,P25_SITUACAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101570902510712757)
,p_name=>'P25_PESQUISA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101581518992812402)
,p_name=>'P25_SITUACAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(271112851741372353539)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from sit_func',
' where cod <> ''01'' ',
'   --and cod < ''90''',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
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
 p_id=>wwv_flow_api.id(271101581571092812403)
,p_name=>'P25_DATA_INI'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_prompt=>'Data Inicial'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271101581645488812404)
,p_name=>'P25_DATA_FIM'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(275999567065926837070)
,p_prompt=>'Data Final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271101440675193651948)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P25_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271101581199191812399)
,p_event_id=>wwv_flow_api.id(271101440675193651948)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p25_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p25_empresa||'','','',''||cod_empresa||'','') > 0) or (:p25_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P25_EMPRESA'
,p_attribute_03=>'P25_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271101581325114812400)
,p_name=>'Pesquisa'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271101566850622712722)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271101581387905812401)
,p_event_id=>wwv_flow_api.id(271101581325114812400)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271101661486482746768)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P25_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271101661910745746774)
,p_event_id=>wwv_flow_api.id(271101661486482746768)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p16_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p16_empresa||'','','',''||cod_empresa||'','') > 0) or (:p16_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P16_EMPRESA'
,p_attribute_03=>'P16_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113061559042620544)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113061126715618254)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113061991126620546)
,p_event_id=>wwv_flow_api.id(271113061559042620544)
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
 p_id=>wwv_flow_api.id(271113062353705621730)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113061395584619253)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113062771268621732)
,p_event_id=>wwv_flow_api.id(271113062353705621730)
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
 p_id=>wwv_flow_api.id(60695007365433240848)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>60
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60695007417832240849)
,p_event_id=>wwv_flow_api.id(60695007365433240848)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(function() {',
unistr('  // Captura o bot\00E3o clicado'),
'  var button = event.target.closest("button");',
'',
'  if (!button) {',
unistr('    console.log("Bot\00E3o n\00E3o identificado.");'),
'    return;',
'  }',
'',
unistr('  // Sobe at\00E9 encontrar a regi\00E3o do IR'),
'  var regionDiv = button.closest(".t-IRR-region");',
'',
'  if (!regionDiv) {',
unistr('    console.log("Regi\00E3o com classe ''t-IRR-region'' n\00E3o encontrada.");'),
'    return;',
'  }',
'',
'  var staticId = regionDiv.id;',
'',
unistr('  // Atualiza os itens da p\00E1gina'),
'  apex.item("P25_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P25_SYS_PROMPT").setValue("Voc\00EA \00E9 um especialista em RH e Departamento Pessoal.");'),
'  apex.item("P25_USER_PROMPT").setValue("Analise os dados de afastamentos a seguir.");',
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(60695007540563240850)
,p_event_id=>wwv_flow_api.id(60695007365433240848)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    DECLARE',
'',
'      V_RESP    CLOB;',
'      V_FILES   VARCHAR2(4000);',
'',
'      V_SYSTEM_PROMPT CLOB;',
'      V_USER_PROMPT CLOB;',
'      ',
'      v_id_system_prompt NUMBER;',
'      v_servico varchar2(100) := ''N8N'';',
'      v_llm varchar2(100) := ''GEMINI'';',
'      v_region_static_id varchar2(100) := :P25_STATIC_ID_IR; --''IR_REGION'';',
'      v_region_name varchar2(100);',
'      v_opcao_arq_prompt varchar2(100) := ''CSV'';',
'      ',
'      v_ir_report_log_id number;',
'      v_chart_log_id number;',
'      ',
'      v_status varchar2(10);',
'      v_mensagem varchar2(4000);',
'      ',
'    BEGIN',
'',
'      v_system_prompt := :P25_SYS_PROMPT;',
'      v_user_prompt := :P25_USER_PROMPT;  --''Analise os dados a seguir.'';',
'',
'      v_ir_report_log_id := ',
'      pkg_ai.fnct_gerar_csv_ir(',
'      p_app_id => :app_id,',
'      p_page_id => :app_page_id,',
'      p_region_static_id => v_region_static_id,',
'      p_region_name => v_region_name,',
'      p_servico => v_servico,',
'      p_user_prompt => v_user_prompt,',
'      p_user_prompt_aux => null,',
'      p_sys_prompt => v_system_prompt,',
'      p_status => v_status,',
'      p_mensagem => v_mensagem',
'      );',
'',
'      pkg_chatbot.prc_chat(',
'      p_servico => v_servico,',
'      p_client_id => :p_base,',
'      p_user_id => :p_usuario,',
'      p_cod_empresa => :p_empresa_user,',
'      p_matricula => :p_matricula_user,',
'      p_id_system_prompt => v_id_system_prompt,',
'      p_app_id => :app_id,',
'      p_page_id => :app_page_id,',
'      p_region_static_id => v_region_static_id,',
'      p_region_name => v_region_name,',
'      p_system_prompt => v_system_prompt,',
'      p_simples => ''S'',',
'      p_llm => v_llm,',
'      p_role => ''user'',',
'      p_user_prompt => v_user_prompt,',
'      p_user_prompt_adicional => null,',
'      p_ia => ''S'',',
'      p_mostrar => ''S'',',
'      p_temperature => null,',
'      p_ir_report_log_id => v_ir_report_log_id,',
'      p_opcao_arq_prompt => v_opcao_arq_prompt,',
'      p_response => V_RESP,',
'      p_output_files => V_FILES,',
'      p_status => v_status,',
'      p_mensagem => v_mensagem',
'      );',
'',
'      :P25_flg := v_status;',
'      :P25_msg := v_mensagem;',
'',
'    END;'))
,p_attribute_02=>'P25_USER_PROMPT,P25_SYS_PROMPT,P25_STATIC_ID_IR'
,p_attribute_03=>'P25_FLG,P25_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283826122885293937763)
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
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990025000000000002)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_AFAST_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - painel de afastamentos (Natcorp_Afastamentos.js). FONTE: brand/apex/app/NC_AFAST_INDICADORES.plsql.sql',
'   (guia AFASTAMENTOS-MANUTENCAO.md). Mude la e aplique de novo com aplicar-afastamentos-pagina25.py. */',
'declare',
'  l_hoje   date := trunc(sysdate);',
'  l_ini    date;',
'  l_fim    date;',
'  l_padrao boolean := :P25_DATA_INI is null;',
'  l_quadro number := 0;',
'  l_tot    number := 0; l_v7 number := 0; l_sem number := 0; l_atr number := 0; l_m15 number := 0;',
'  l_saida  clob;',
'  l_cru    clob;                                             /* "quadroG" e "ev", escritos à mão */',
'  l_buf    varchar2(32767);',
'  /* os filtros de escolha múltipla chegam como "700,91". Viram ",700,91," e a linha entra quando',
'     ",<código>," está dentro (instr) - o mesmo jeito das listas de valores desta página.',
'     NÃO filtrar com TABLE() de apex_string.split nem de uma coleção aqui: nesta base, dentro do',
'     PL/SQL, os dois dão ORA-22905 (08/10). f_x = 1 quando o filtro foi preenchido. */',
'  l_emp varchar2(32767) := '','' || :P25_EMPRESA || '','';     f_emp number := case when :P25_EMPRESA is null then 0 else 1 end;',
'  l_fil varchar2(32767) := '','' || :P25_FILIAL || '','';      f_fil number := case when :P25_FILIAL is null then 0 else 1 end;',
'  l_cc  varchar2(32767) := '','' || :P25_CCUSTO || '','';      f_cc  number := case when :P25_CCUSTO is null then 0 else 1 end;',
'  l_un  varchar2(32767) := '','' || :P25_UNIDADE_ADM || '',''; f_un  number := case when :P25_UNIDADE_ADM is null then 0 else 1 end;',
'  l_at  varchar2(32767) := '','' || :P25_ATIVIDADE || '','';   f_at  number := case when :P25_ATIVIDADE is null then 0 else 1 end;',
'  l_car varchar2(32767) := '','' || :P25_CARGO || '','';       f_car number := case when :P25_CARGO is null then 0 else 1 end;',
'  l_mat varchar2(32767) := '','' || :P25_MATRICULA || '','';   f_mat number := case when :P25_MATRICULA is null then 0 else 1 end;',
'  l_sit varchar2(32767) := '','' || :P25_SITUACAO || '','';    f_sit number := case when :P25_SITUACAO is null then 0 else 1 end;',
'  l_passo  varchar2(30) := ''inicio'';                         /* onde estava, se der erro */',
'  l_t0     number := dbms_utility.get_time;                  /* tempos de cada parte, em centésimos */',
'  l_t1     number; l_t2 number;',
'  l_dims   sys.odcivarchar2list := sys.odcivarchar2list(''tipo'', ''emp'', ''fil'', ''cc'', ''un'', ''at'', ''car'', ''vin'');',
'  l_corte  pls_integer;',
'  l_n      pls_integer := 0;',
'  l_pi     pls_integer;',
'',
'  /* os nomes de cada coluna: cada nome ganha um número (a posição dele em "dims") */',
'  type t_num is table of number index by varchar2(400);',
'  type t_txt is table of varchar2(400) index by varchar2(400);',
'  cache   t_num;      /* "dim|empresa|código" -> número (o fnct_nome_* roda uma vez por código) */',
'  por_rot t_num;      /* "dim|nome" -> número (dois códigos com o MESMO nome viram um só, como na tabela) */',
'  qtd     t_num;      /* dim -> quantos nomes */',
'  rot     t_txt;      /* "dim#número" -> nome */',
'  pes     t_num;      /* "empresa|matrícula" -> número da pessoa */',
'  pes_ch  t_txt;      /* número da pessoa -> "empresa|matrícula" */',
'  pes_q   t_num;      /* número da pessoa -> vezes no período */',
'  l_npes  pls_integer := 0;',
'  l_vezes number := 0; l_dias number := 0;',
'',
'  /* (no PL/SQL as variáveis e os tipos vêm ANTES das funções: daqui para baixo só funções) */',
'  function data_de(p varchar2) return date is',
'  begin',
'    if p is null then return null; end if;',
'    begin return to_date(p, ''DD/MM/YYYY''); exception when others then return to_date(p); end;',
'  end;',
'',
'  /* escreve no CLOB à parte, de 32 mil em 32 mil caracteres */',
'  procedure descarrega is',
'  begin',
'    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;',
'  end;',
'  procedure cru(p varchar2) is',
'  begin',
'    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;',
'    l_buf := l_buf || p;',
'  end;',
'',
'  /* o nome de um código, IGUAL ao da coluna do relatório */',
'  function nome_dim(p_dim varchar2, p_emp varchar2, p_cod varchar2) return varchar2 is',
'    r varchar2(4000);',
'  begin',
'    if p_cod is null then return ''Não informado''; end if;',
'    begin',
'      r := case p_dim',
'             when ''tipo'' then p_cod || '' - '' || initcap(fnct_nome_situacao(p_cod))',
'             when ''emp''  then p_cod || '' - '' || initcap(fnct_nome_empresa(p_cod, ''S''))',
'             when ''fil''  then p_cod || '' - '' || initcap(fnct_nome_filial(p_emp, p_cod, ''S''))',
'             when ''cc''   then p_cod || '' - '' || initcap(fnct_nome_ccusto(p_emp, p_cod))',
'             when ''un''   then p_cod || '' - '' || initcap(fnct_nome_unidade_adm(p_emp, null, p_cod))',
'             when ''at''   then p_cod || '' - '' || initcap(fnct_nome_atividade(p_cod))',
'             when ''car''  then p_cod || '' - '' || initcap(fnct_nome_cargo(p_cod))',
'             when ''vin''  then initcap(fnct_nome_vinculo(p_cod))',
'           end;',
'    exception when others then r := p_cod;',
'    end;',
'    return substr(nvl(r, p_cod), 1, 380);',
'  end;',
'  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2) return pls_integer is',
'    k varchar2(400) := p_dim || ''|'' || p_emp || ''|'' || substr(p_cod, 1, 300);',
'    r varchar2(400); n pls_integer;',
'  begin',
'    if cache.exists(k) then return cache(k); end if;',
'    r := nome_dim(p_dim, p_emp, p_cod);',
'    if not por_rot.exists(p_dim || ''|'' || r) then',
'      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;',
'      por_rot(p_dim || ''|'' || r) := n;',
'      rot(p_dim || ''#'' || n) := r;',
'      qtd(p_dim) := n + 1;',
'    end if;',
'    cache(k) := por_rot(p_dim || ''|'' || r);',
'    return cache(k);',
'  end;',
'  /* "empresa,filial,ccusto,unidade,atividade,cargo,vínculo" em números (filial, ccusto e unidade',
'     dependem da empresa, os outros não) */',
'  function org(p_emp varchar2, p_fil varchar2, p_cc varchar2, p_un varchar2, p_at varchar2, p_car varchar2, p_vin varchar2) return varchar2 is',
'  begin',
'    return ix(''emp'', null, p_emp) || '','' || ix(''fil'', p_emp, p_fil) || '','' || ix(''cc'', p_emp, p_cc) || '','' ||',
'           ix(''un'', p_emp, p_un) || '','' || ix(''at'', null, p_at) || '','' || ix(''car'', null, p_car) || '','' || ix(''vin'', null, p_vin);',
'  end;',
'  procedure soma(a in out nocopy t_num, k varchar2, v number) is',
'  begin',
'    if a.exists(k) then a(k) := a(k) + v; else a(k) := v; end if;',
'  end;',
'  /* manda um CLOB para a resposta, até a posição p_ate */',
'  procedure manda(c clob, p_ate pls_integer) is',
'    p pls_integer := 1;',
'  begin',
'    while p <= p_ate loop',
'      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));',
'      p := p + 8000;',
'    end loop;',
'  end;',
'begin',
'  l_ini := data_de(:P25_DATA_INI);',
'  l_fim := nvl(data_de(:P25_DATA_FIM), l_hoje);',
'  if l_ini is null then l_ini := add_months(l_hoje, -12) + 1; l_fim := l_hoje; end if;',
'  dbms_lob.createtemporary(l_cru, true);',
'',
'  /* monta tudo na memória e só envia no fim: um erro no meio não manda meio JSON */',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''v'', 2);',
'  apex_json.write(''hoje'', to_char(l_hoje, ''DD/MM/YYYY''));',
'  apex_json.write(''ini'', to_char(l_ini, ''DD/MM/YYYY''));',
'  apex_json.write(''fim'', to_char(l_fim, ''DD/MM/YYYY''));',
'  apex_json.write(''padrao'', l_padrao);',
'',
'  /* -- o quadro (quem não está desligado), dividido pelas colunas -- */',
'  l_passo := ''quadro'';',
'  cru(''"quadroG":['');',
'  for r in (',
'    select i.cod_empresa emp, i.filial fil, i.cod_ccusto cc, i.unidade_adm un, i.cod_atividade ativ,',
'           i.cargo car, i.vinculo vin, count(*) n',
'      from informacoes_funcionais i',
'     where i.situacao < ''90''',
'       and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'       and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'       and (f_cc = 0 or instr(l_cc, '','' || i.cod_ccusto || '','') > 0)',
'       and (f_un = 0 or instr(l_un, '','' || i.unidade_adm || '','') > 0)',
'       and (f_at = 0 or instr(l_at, '','' || i.cod_atividade || '','') > 0)',
'       and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'       and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'     group by i.cod_empresa, i.filial, i.cod_ccusto, i.unidade_adm, i.cod_atividade, i.cargo, i.vinculo',
'  ) loop',
'    l_quadro := l_quadro + r.n;',
'    cru(case when l_n > 0 then '','' end || ''['' || org(r.emp, r.fil, r.cc, r.un, r.ativ, r.car, r.vin) || '','' || to_char(r.n) || '']'');',
'    l_n := l_n + 1;',
'  end loop;',
'  cru('']'');',
'  apex_json.write(''quadro'', l_quadro);',
'  l_t1 := dbms_utility.get_time;',
'',
'  /* -- HOJE: quem está afastado agora (a situação atual do cadastro) -- */',
'  l_passo := ''hoje'';',
'  apex_json.open_array(''pessoas'');',
'  for r in (',
'    select i.cod_empresa, i.matricula, i.cargo, i.cod_ccusto, i.situacao, i.dt_situacao, i.dt_retorno_afast,',
'           i.filial, i.unidade_adm, i.cod_atividade, i.vinculo',
'      from informacoes_funcionais i',
'     where i.situacao <> ''01'' and i.situacao < ''90''',
'       and (f_sit = 0 or instr(l_sit, '','' || i.situacao || '','') > 0)',
'       and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'       and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'       and (f_cc = 0 or instr(l_cc, '','' || i.cod_ccusto || '','') > 0)',
'       and (f_un = 0 or instr(l_un, '','' || i.unidade_adm || '','') > 0)',
'       and (f_at = 0 or instr(l_at, '','' || i.cod_atividade || '','') > 0)',
'       and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'       and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'     order by i.dt_retorno_afast nulls first, i.dt_situacao',
'  ) loop',
'    l_tot := l_tot + 1;',
'    if r.dt_retorno_afast is null then l_sem := l_sem + 1;',
'    elsif r.dt_retorno_afast < l_hoje then l_atr := l_atr + 1;',
'    elsif r.dt_retorno_afast <= l_hoje + 7 then l_v7 := l_v7 + 1;',
'    end if;',
'    if r.dt_situacao is not null and l_hoje - r.dt_situacao + 1 > 15 then l_m15 := l_m15 + 1; end if;',
'    if l_tot <= 3000 then                                  /* a lista para "quem são" (e para o filtro do painel) */',
'      apex_json.open_object;',
'      apex_json.write(''n'', r.matricula || '' - '' || initcap(fnct_nome_func(r.cod_empresa, r.matricula)));',
'      apex_json.write(''c'', r.cargo || '' - '' || initcap(fnct_nome_cargo(r.cargo)));',
'      apex_json.write(''s'', r.cod_ccusto || '' - '' || initcap(fnct_nome_ccusto(r.cod_empresa, r.cod_ccusto)));',
'      apex_json.write(''t'', r.situacao || '' - '' || initcap(fnct_nome_situacao(r.situacao)));',
'      apex_json.write(''d'', to_char(r.dt_situacao, ''DD/MM/YYYY''));',
'      apex_json.write(''r'', to_char(r.dt_retorno_afast, ''DD/MM/YYYY''));',
'      apex_json.write(''k'', ix(''tipo'', null, r.situacao) || '','' ||',
'                           org(r.cod_empresa, r.filial, r.cod_ccusto, r.unidade_adm, r.cod_atividade, r.cargo, r.vinculo));',
'      apex_json.close_object;',
'    end if;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.open_object(''agora'');',
'  apex_json.write(''total'', l_tot);',
'  apex_json.write(''voltam7'', l_v7);',
'  apex_json.write(''atrasados'', l_atr);',
'  apex_json.write(''semData'', l_sem);',
'  apex_json.write(''mais15'', l_m15);',
'  apex_json.write(''cortou'', l_tot > 3000);',
'  apex_json.close_object;',
'  l_t2 := dbms_utility.get_time;',
'',
'  /* -- NO PERÍODO: os afastamentos que tocam o período, lidos UMA vez; cada um vai para "ev" com as',
'       colunas em números. As contas (motivos, onde, mês a mês, pessoas) são feitas NA TELA, que assim',
'       filtra e troca o cruzamento na hora. -- */',
'  l_passo := ''periodo'';',
'  cru('',"ev":['');',
'  l_n := 0;',
'  for r in (',
'    /* a MESMA junção do relatório (historico_cadastral x informacoes_funcionais, os mesmos filtros), sem',
'       janela sobre o histórico e sem subconsulta no histórico por linha. Histórico de desempenho, 08/10:',
'       LEAD sobre o histórico inteiro = 82 s; "próxima situação" por subconsulta = mais de 260 s.',
'       O FIM de cada afastamento é o da coluna "Data Final" do relatório:',
'         1. a data de fim do histórico;  2. senão, a do atestado (a mesma subconsulta do relatório);',
'         3. senão, se é a situação ATUAL da pessoa, está em andamento: conta até hoje;',
'         4. senão (afastamento antigo sem fim registrado), conta só o dia de início. */',
'    with x as (',
'      select a.cod_valor_fato cod, i.cod_empresa emp, i.matricula mat, i.cod_ccusto ccusto, a.dt_vigencia ini,',
'             i.filial fil, i.unidade_adm un, i.cod_atividade ativ, i.cargo car, i.vinculo vin,',
'             coalesce(a.dt_vigencia_fim,',
'                      (select af.dt_termino_afastamento',
'                         from atestado_funcionario af',
'                        where rownum = 1',
'                          and i.dt_retorno_afast - 1 = af.dt_termino_afastamento',
'                          and af.dt_termino_afastamento is not null',
'                          and i.dt_retorno_afast is not null',
'                          and af.dt_inicio_afastamento = a.dt_vigencia',
'                          and af.matricula = a.matricula',
'                          and af.cod_empresa = a.cod_empresa),',
'                      case when i.situacao = a.cod_valor_fato and i.dt_situacao = a.dt_vigencia then l_hoje end,',
'                      a.dt_vigencia) fim',
'        from historico_cadastral a, informacoes_funcionais i',
'       where a.cod_empresa = i.cod_empresa',
'         and a.matricula = i.matricula',
'         and a.cod_fato = 1',
'         and a.cod_valor_fato <> ''01''',
'         and ((f_sit = 0 and a.cod_valor_fato < ''90'')',
'           or (f_sit = 1 and i.situacao >= ''90'' and instr(l_sit, '','' || a.cod_valor_fato || '','') > 0))',
'         and a.dt_vigencia <= l_fim',
'         and (f_emp = 0 or instr(l_emp, '','' || i.cod_empresa || '','') > 0)',
'         and (f_fil = 0 or instr(l_fil, '','' || i.filial || '','') > 0)',
'         and (f_cc = 0 or instr(l_cc, '','' || i.cod_ccusto || '','') > 0)',
'         and (f_un = 0 or instr(l_un, '','' || i.unidade_adm || '','') > 0)',
'         and (f_at = 0 or instr(l_at, '','' || i.cod_atividade || '','') > 0)',
'         and (f_car = 0 or instr(l_car, '','' || i.cargo || '','') > 0)',
'         and (f_mat = 0 or instr(l_mat, '','' || i.matricula || '','') > 0)',
'    )',
'    /* SEM GROUPING SETS: com a subconsulta do atestado dentro, o Oracle dá ORA-00904',
'       "SYS_TBL_$2$"."$vm_col_11" (a tabela temporária que ele cria para os grouping sets). */',
'    select cod, emp, mat, ccusto, fil, un, ativ, car, vin, to_char(ini, ''YYYYMM'') mes,',
'           round(greatest(0, least(fim, l_fim) - greatest(ini, l_ini) + 1)) dias',
'      from x',
'     where fim >= l_ini',
'  ) loop',
'    if not pes.exists(r.emp || ''|'' || r.mat) then',
'      pes(r.emp || ''|'' || r.mat) := l_npes; pes_ch(to_char(l_npes)) := r.emp || ''|'' || r.mat; l_npes := l_npes + 1;',
'    end if;',
'    l_pi := pes(r.emp || ''|'' || r.mat);',
'    soma(pes_q, to_char(l_pi), 1);',
'    l_vezes := l_vezes + 1; l_dias := l_dias + r.dias;',
'    cru(case when l_n > 0 then '','' end || ''['' || ix(''tipo'', null, r.cod) || '','' ||',
'        org(r.emp, r.fil, r.ccusto, r.un, r.ativ, r.car, r.vin) || '','' || l_pi || '','' || r.mes || '','' || to_char(r.dias) || '']'');',
'    l_n := l_n + 1;',
'  end loop;',
'  cru('']'');',
'  descarrega;',
'',
'  apex_json.open_object(''periodo'');',
'  apex_json.write(''vezes'', l_vezes);',
'  apex_json.write(''pessoas'', l_npes);',
'  apex_json.write(''dias'', l_dias);',
'  apex_json.close_object;',
'',
'  /* os nomes de cada coluna, na ordem dos números */',
'  l_passo := ''nomes'';',
'  apex_json.open_object(''dims'');',
'  for j in 1 .. l_dims.count loop                    /* laço na coleção (TABLE() aqui dá ORA-22905, 08/10) */',
'    apex_json.open_array(l_dims(j));',
'    if qtd.exists(l_dims(j)) then',
'      for n in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || ''#'' || n)); end loop;',
'    end if;',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_object;',
'  /* os nomes de quem se afastou 2 vezes ou mais (os únicos que o quadro "Mais de uma vez" mostra) */',
'  apex_json.open_object(''nomes'');',
'  declare k varchar2(400) := pes_q.first; e varchar2(400); m varchar2(400); begin',
'    while k is not null loop',
'      if pes_q(k) >= 2 then',
'        e := substr(pes_ch(k), 1, instr(pes_ch(k), ''|'') - 1);',
'        m := substr(pes_ch(k), instr(pes_ch(k), ''|'') + 1);',
'        apex_json.write(k, m || '' - '' || initcap(fnct_nome_func(e, m)));',
'      end if;',
'      k := pes_q.next(k);',
'    end loop;',
'  end;',
'  apex_json.close_object;',
'',
'  apex_json.open_object(''tempos'');',
'  apex_json.write(''quadro'', l_t1 - l_t0);',
'  apex_json.write(''hoje'', l_t2 - l_t1);',
'  apex_json.write(''periodo'', dbms_utility.get_time - l_t2);',
'  apex_json.close_object;',
'  apex_json.close_object;',
'  l_saida := apex_json.get_clob_output;',
'  apex_json.free_output;',
'',
'  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + quadroG/ev + "}" */',
'  l_corte := dbms_lob.getlength(l_saida);',
'  while l_corte > 0 and dbms_lob.substr(l_saida, 1, l_corte) <> ''}'' loop l_corte := l_corte - 1; end loop;',
'  manda(l_saida, l_corte - 1);',
'  htp.prn('','');',
'  manda(l_cru, dbms_lob.getlength(l_cru));',
'  htp.prn(''}'');',
'  dbms_lob.freetemporary(l_cru);',
'exception',
'  when others then',
'    apex_json.free_output;',
'    if l_cru is not null and dbms_lob.istemporary(l_cru) = 1 then dbms_lob.freetemporary(l_cru); end if;',
'    htp.prn(''{"erro":"'' || apex_escape.json(sqlerrm || '' [passo: '' || l_passo || '']'') || ''"}'');',
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
