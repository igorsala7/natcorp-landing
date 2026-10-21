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
--   Date and Time:   18:01 Monday October 19, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 5
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00005
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Dados de Funcion\00E1rio')
,p_step_title=>unistr('Dados de Funcion\00E1rio')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_SaudePainel.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_SaudePainel.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_step_template=>wwv_flow_api.id(177921826460320886795)
,p_page_template_options=>'#DEFAULT#'
,p_last_upd_yyyymmddhh24miss=>'20241105164118'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166660200724208394533)
,p_plug_name=>unistr('Ficha Cl\00EDnica - Medicina do Trabalho')
,p_icon_css_classes=>'fa-address-book-o'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921841000262886869)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>unistr('<p>Dados de Funcion\00E1rios</p>')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166660323437772908334)
,p_plug_name=>unistr('Dados de Funcion\00E1rio')
,p_region_name=>'COLABORADORES'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select infu.cod_empresa cod_empresa_dsp',
'      ,infu.cod_empresa cod_empresa',
'      ,(select distinct fi.cod_filial||'' - ''||fi.nome_filial',
'        from filiais fi',
'        where fi.cod_empresa = infu.cod_empresa',
'          and fi.cod_filial = infu.filial) filial',
'      ,infu.dc_filial',
'      ,infu.matricula||'' - ''||infu.dc_matricula matricula_dsp',
'      ,infu.matricula matricula',
'      ,fnct_nome_func(infu.cod_empresa, infu.matricula) nome',
'      ,infu.cargo',
'      ,infu.cod_ccusto||'' - ''||fnct_nome_ccusto(infu.cod_empresa, infu.cod_ccusto) setor',
'      ,cod_local_trab||'' - ''|| descricao local',
'      ,inpe.tipo_sanguineo',
'      ,inpe.fator_rh',
'      ,trunc(trunc(sysdate - inpe.dt_nasc)/360) idade',
'      ,lotr.predio',
'      ,lotr.andar',
'      ,lotr.sala      ',
'  from informacoes_funcionais infu',
'      ,inf_pessoais_cad inpe',
'      ,local_trab lotr',
' where infu.cod_empresa = inpe.cod_empresa',
'   and infu.matricula = inpe.matricula',
'   and lotr.cod_local_trab = infu.cod_localizacao',
'  and ((infu.situacao < ''90'' and :p5_situacao = ''A'') or (infu.situacao >= ''90'' and :p5_situacao = ''D'') or (:p5_situacao = ''T''))',
'   and (:P5_EMPRESA     is null or infu.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_EMPRESA, '','')) t))',
'   and (:P5_FILIAL      is null or infu.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_FILIAL, '','')) t))',
'   and (:P5_CCUSTO      is null or infu.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_CCUSTO, '','')) t))',
'   and (:P5_UNIDADE_ADM is null or infu.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_UNIDADE_ADM, '','')) t))',
'   and (:P5_ATIVIDADE   is null or infu.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_ATIVIDADE, '','')) t))',
'   and (:P5_CARGO       is null or infu.cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_CARGO, '','')) t))',
'   and (:P5_MATRICULA   is null or infu.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_MATRICULA, '','')) t))',
' order by infu.cod_empresa, infu.filial, infu.cod_ccusto, infu.matricula;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(166660323486439908334)
,p_name=>unistr('Dados de Funcion\00E1rio')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_COD_EMPRESA,P6_MATRICULA:#COD_EMPRESA#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'ERICO_DANTAS'
,p_internal_uid=>639472326811653515
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660340606152908362)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>43
,p_column_identifier=>'AQ'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660203525032394561)
,p_db_column_name=>'MATRICULA'
,p_display_order=>53
,p_column_identifier=>'BY'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660203311593394559)
,p_db_column_name=>'COD_EMPRESA_DSP'
,p_display_order=>63
,p_column_identifier=>'BW'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'RIGHT'
,p_rpt_named_lov=>wwv_flow_api.id(166659783712256520523)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202298018394549)
,p_db_column_name=>'FILIAL'
,p_display_order=>73
,p_column_identifier=>'BR'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660341455339908363)
,p_db_column_name=>'DC_FILIAL'
,p_display_order=>83
,p_column_identifier=>'AS'
,p_column_label=>'Dc Filial'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660203446905394560)
,p_db_column_name=>'MATRICULA_DSP'
,p_display_order=>93
,p_column_identifier=>'BX'
,p_column_label=>unistr('Matr\00EDcula')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202453980394550)
,p_db_column_name=>'NOME'
,p_display_order=>103
,p_column_identifier=>'BS'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660348624000908376)
,p_db_column_name=>'CARGO'
,p_display_order=>113
,p_column_identifier=>'BK'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166662274719576398729)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202624337394552)
,p_db_column_name=>'SETOR'
,p_display_order=>123
,p_column_identifier=>'BU'
,p_column_label=>'Setor Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202689293394553)
,p_db_column_name=>'LOCAL'
,p_display_order=>133
,p_column_identifier=>'BV'
,p_column_label=>'Local Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660201989785394546)
,p_db_column_name=>'PREDIO'
,p_display_order=>143
,p_column_identifier=>'BO'
,p_column_label=>unistr('Pr\00E9dio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202148018394547)
,p_db_column_name=>'ANDAR'
,p_display_order=>153
,p_column_identifier=>'BP'
,p_column_label=>'Andar'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660202218028394548)
,p_db_column_name=>'SALA'
,p_display_order=>163
,p_column_identifier=>'BQ'
,p_column_label=>'Sala'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660201699557394543)
,p_db_column_name=>'TIPO_SANGUINEO'
,p_display_order=>173
,p_column_identifier=>'BL'
,p_column_label=>unistr('Tipo Sangu\00EDneo')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166662302930648483563)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660201790211394544)
,p_db_column_name=>'FATOR_RH'
,p_display_order=>183
,p_column_identifier=>'BM'
,p_column_label=>'Fator RH'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166662305668566490472)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166660201905716394545)
,p_db_column_name=>'IDADE'
,p_display_order=>193
,p_column_identifier=>'BN'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(166660408220016913284)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6395571'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA_DSP:FILIAL:MATRICULA_DSP:NOME:CARGO:SETOR:LOCAL:PREDIO:ANDAR:SALA:TIPO_SANGUINEO:FATOR_RH:IDADE:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(177600691624041866693)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(173222666693072186572)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(161360659803398055070)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(161360660226285055071)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-minus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(161360660678872055071)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161360661040914055071)
,p_name=>'P5_SITUACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_item_default=>'A'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Ativos;A,Demitidos;D,Todos;T'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161360661431457055072)
,p_name=>'P5_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360661876732055072)
,p_name=>'P5_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(177600691624041866693)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161360662559346055073)
,p_name=>'P5_FILIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p5_empresa||'','','',''||cod_empresa||'','') > 0) or (:p5_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P5_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360662933720055074)
,p_name=>'P5_CCUSTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p5_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p5_empresa, '','')) t))',
'and (:p5_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p5_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P5_EMPRESA,P5_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360663391549055074)
,p_name=>'P5_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p5_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p5_empresa is null))',
'       and ((instr('',''||:p5_filial||'','','',''||a.cod_filial||'','') > 0) or (:p5_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p5_ccusto',
'       and ((instr('',''||:p5_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p5_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p5_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p5_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p5_empresa is null))',
'       and ((instr('',''||:p5_filial||'','','',''||a.cod_filial||'','') > 0) or (:p5_filial is null))',
'       and :p5_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P5_EMPRESA,P5_FILIAL,P5_CCUSTO,P5_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360663698295055074)
,p_name=>'P5_ATIVIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p5_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p5_empresa is null))',
'   and ((instr('',''||:p5_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p5_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p5_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p5_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P5_CCUSTO,P5_UNIDADE_ADM,P5_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360664187092055075)
,p_name=>'P5_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360664569879055075)
,p_name=>'P5_MATRICULA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) d, i.matricula',
'  from informacoes_funcionais i',
' where ((i.situacao < ''90'' and :p5_situacao = ''A'') or (i.situacao >= ''90'' and :p5_situacao = ''D'') or (:p5_situacao = ''T''))',
'   and (:P5_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_EMPRESA, '','')) t))',
'   and (:P5_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_FILIAL, '','')) t))',
'   and (:P5_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_CCUSTO, '','')) t))',
'   and (:P5_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_UNIDADE_ADM, '','')) t))',
'   and (:P5_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P5_ATIVIDADE, '','')) t))',
'   AND ((:P_PAINEL = ''PO'') or (',
'           EXISTS (SELECT 1',
'                     FROM centro_de_custo cx',
'                    WHERE cx.cod_empresa = i.cod_empresa',
'                      AND cx.cod = i.cod_ccusto',
'                      AND cx.cod_emp_gestor = :P_EMPRESA_USER',
'                      AND cx.matricula_gestor = :P_MATRICULA_USER',
'                   UNION',
'                   SELECT 1',
'                     FROM centro_de_custo cy',
'                    WHERE cy.cod_emp_gestor = i.cod_empresa ',
'                      AND cy.matricula_gestor = i.matricula',
'                      AND cy.cod_ccusto_superior = :P_CCUSTO_USER',
'                   )))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P5_CCUSTO,P5_UNIDADE_ADM,P5_UTILIZA_SECAO,P5_ATIVIDADE,P5_SITUACAO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
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
 p_id=>wwv_flow_api.id(161360664967354055076)
,p_name=>'P5_PESQUISA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(173222666693072186572)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(161360665556673064346)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161360665924252064347)
,p_event_id=>wwv_flow_api.id(161360665556673064346)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p99999_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p99999_empresa||'','','',''||cod_empresa||'','') > 0) or (:p99999_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P99999_EMPRESA'
,p_attribute_03=>'P99999_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(161360666378754065828)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(161360659803398055070)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161360666784528065828)
,p_event_id=>wwv_flow_api.id(161360666378754065828)
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
 p_id=>wwv_flow_api.id(161360667595588071706)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(161360660226285055071)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161360667992448071706)
,p_event_id=>wwv_flow_api.id(161360667595588071706)
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
 p_id=>wwv_flow_api.id(161360676504832118539)
,p_name=>'Pesquisa'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(161360660678872055071)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161360676969697118539)
,p_event_id=>wwv_flow_api.id(161360676504832118539)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p99999_pesquisa := ''S'';'
,p_attribute_03=>'P99999_PESQUISA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161360677450117118540)
,p_event_id=>wwv_flow_api.id(161360676504832118539)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990005000000000002)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_SAUDE_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - painel "Saude e seguranca do trabalho" (Natcorp_SaudePainel.js). FONTE: brand/apex/app/NC_SAUDE_INDICADORES.plsql.sql',
'   (guia SAUDEPAINEL-MANUTENCAO.md). Mude la e aplique de novo com aplicar-saudepainel-pagina5.py. */',
'declare',
'  MAX_PES   constant pls_integer := 10000;     /* acima disso o painel pede para filtrar */',
unistr('  MAX_DIAS  constant pls_integer := 731;       /* per\00EDodo maior que isso: corta (2 anos) */'),
'  INSS_DIAS constant pls_integer := 60;        /* janela da regra dos 15 dias (atestados) */',
'  l_hoje    date := trunc(sysdate);',
'  l_ini     date;',
'  l_fim     date;',
'  l_wini    date;',
'  l_wfim    date;',
'  l_cortouD boolean := false;',
'  l_saida   clob;',
'  l_cru     clob;',
'  l_buf     varchar2(32767);',
'  l_passo   varchar2(30) := ''inicio'';',
'  l_t0      number := dbms_utility.get_time;',
'  l_t1      number;',
'  l_t2      number;',
'  l_n       pls_integer;',
'  l_pi      pls_integer;',
'  l_total   pls_integer := 0;',
'  l_cortou  boolean := false;',
'  l_corte   pls_integer;',
'  l_ua      varchar2(20) := ''null'';',
'  l_ua2     varchar2(20) := ''null'';',
'  l_dims    sys.odcivarchar2list := sys.odcivarchar2list(''emp'', ''fil'', ''cc'', ''loc'', ''car'');',
'  l_cats    sys.odcivarchar2list := sys.odcivarchar2list(''ex'', ''cid'', ''tat'', ''vac'', ''res'', ''sit'');',
'',
unistr('  /* os filtros do relat\00F3rio: ",700,91," e a linha entra quando ",c\00F3digo," est\00E1 dentro */'),
'  l_emp varchar2(32767) := '','' || :P5_EMPRESA || '','';     f_emp number := case when :P5_EMPRESA is null then 0 else 1 end;',
'  l_fil varchar2(32767) := '','' || :P5_FILIAL || '','';      f_fil number := case when :P5_FILIAL is null then 0 else 1 end;',
'  l_cc  varchar2(32767) := '','' || :P5_CCUSTO || '','';      f_cc  number := case when :P5_CCUSTO is null then 0 else 1 end;',
'  l_un  varchar2(32767) := '','' || :P5_UNIDADE_ADM || '',''; f_un  number := case when :P5_UNIDADE_ADM is null then 0 else 1 end;',
'  l_at  varchar2(32767) := '','' || :P5_ATIVIDADE || '','';   f_at  number := case when :P5_ATIVIDADE is null then 0 else 1 end;',
'  l_car varchar2(32767) := '','' || :P5_CARGO || '','';       f_car number := case when :P5_CARGO is null then 0 else 1 end;',
'  l_mat varchar2(32767) := '','' || :P5_MATRICULA || '','';   f_mat number := case when :P5_MATRICULA is null then 0 else 1 end;',
'  l_sit varchar2(10)    := nvl(:P5_SITUACAO, ''A'');',
'',
'  type t_num is table of number index by varchar2(400);',
'  type t_txt is table of varchar2(4000) index by varchar2(400);',
'  type t_lin is table of varchar2(4000) index by pls_integer;',
unistr('  cache   t_num;      /* "dim|empresa|c\00F3digo|c\00F3digo2" -> n\00FAmero do nome */'),
unistr('  por_rot t_num;      /* "dim|nome" -> n\00FAmero (dois c\00F3digos com o MESMO nome viram um s\00F3, como na tabela) */'),
'  qtd     t_num;      /* dim -> quantos nomes */',
unistr('  rot     t_txt;      /* "dim#n\00FAmero" -> nome */'),
unistr('  pes     t_num;      /* "empresa|matr\00EDcula" -> n\00FAmero da pessoa */'),
unistr('  lin     t_lin;      /* n\00FAmero da pessoa -> a linha de "pes", pronta */'),
unistr('  nom     t_lin;      /* n\00FAmero da pessoa -> "mat - Nome" */'),
unistr('  ult     t_lin;      /* n\00FAmero da pessoa -> "\00FAltimo exame,quantos" */'),
unistr('  mes     t_num;      /* "yyyymm" -> n\00FAmero do m\00EAs */'),
'  l_npes  pls_integer := 0;',
'  l_nmes  pls_integer := 0;',
unistr('  /* as listas, escritas \00E0 m\00E3o (cada uma no seu CLOB) */'),
'  c_ex clob; c_xf clob; c_at clob; c_dz clob; c_vc clob; c_rs clob; c_ac clob; c_cs clob; c_es clob;',
'  n_es pls_integer := 0;',
unistr('  l_codacid varchar2(4000) := '','';              /* ",13,14," = situa\00E7\00F5es de afastamento por acidente */'),
'  type t_dt is table of date index by pls_integer;',
unistr('  es_ate t_dt;                                  /* n\00FAmero da pessoa -> fim da estabilidade mais longa */'),
'  es_lin t_lin;',
'  n_ex pls_integer := 0; n_xf pls_integer := 0; n_at pls_integer := 0; n_dz pls_integer := 0;',
'  n_vc pls_integer := 0; n_rs pls_integer := 0; n_ac pls_integer := 0; n_cs pls_integer := 0;',
'',
'  procedure descarrega is',
'  begin',
'    if l_buf is not null then dbms_lob.writeappend(l_cru, length(l_buf), l_buf); l_buf := null; end if;',
'  end;',
'  procedure cru(p varchar2) is',
'  begin',
'    if nvl(length(l_buf), 0) + nvl(length(p), 0) > 32000 then descarrega; end if;',
'    l_buf := l_buf || p;',
'  end;',
'  procedure poe(c in out nocopy clob, qt in out pls_integer, p varchar2) is',
'    t varchar2(4000) := case when qt > 0 then '','' end || p;',
'  begin',
'    if c is null then dbms_lob.createtemporary(c, true); end if;',
'    dbms_lob.writeappend(c, length(t), t);',
'    qt := qt + 1;',
'  end;',
'  procedure junta(nome varchar2, c in out nocopy clob) is',
'  begin',
'    descarrega;',
'    cru('',"'' || nome || ''":['');',
'    descarrega;',
'    if c is not null then dbms_lob.append(l_cru, c); dbms_lob.freetemporary(c); end if;',
'    cru('']'');',
'  end;',
'  procedure manda(c clob, p_ate number) is',
'    p number := 1;',
'  begin',
'    while p <= p_ate loop',
'      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));',
'      p := p + 8000;',
'    end loop;',
'  end;',
'  function js(p varchar2) return varchar2 is',
'  begin',
'    return ''"'' || apex_escape.json(p) || ''"'';',
'  end;',
'  function n(p number) return varchar2 is',
'  begin',
'    return to_char(round(nvl(p, 0)), ''FM99999999990'');',
'  end;',
'  /* data -> dias a partir de hoje (sem data: null) */',
'  function dd(p date) return varchar2 is',
'  begin',
'    if p is null then return ''null''; end if;',
'    return to_char(trunc(p) - l_hoje, ''FM99999999990'');',
'  end;',
'  function data_de(p varchar2) return date is',
'  begin',
'    if p is null then return null; end if;',
'    begin return to_date(p, ''DD/MM/YYYY''); exception when others then return null; end;',
'  end;',
'  /* "8", "08:00", "8,5" -> minutos */',
'  function minutos(p varchar2) return number is',
'    t varchar2(400) := trim(p);',
'  begin',
'    if t is null then return 0; end if;',
'    if instr(t, '':'') > 0 then',
'      return to_number(substr(t, 1, instr(t, '':'') - 1)) * 60 + to_number(substr(t, instr(t, '':'') + 1, 2));',
'    end if;',
'    return round(to_number(replace(t, '','', ''.''), ''99999999990D9999'', ''NLS_NUMERIC_CHARACTERS=''''.,'''''') * 60);',
'  exception when others then return 0;',
'  end;',
'',
unistr('  /* o nome de um c\00F3digo, IGUAL ao da coluna do relat\00F3rio (dims) ou da lista da p\00E1gina 6 (cat) */'),
'  function nome_de(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2) return varchar2 is',
'    r varchar2(4000);',
'  begin',
unistr('    if p_cod is null then return ''N\00E3o informado''; end if;'),
'    begin',
'      if p_dim = ''emp'' then',
'        select max(emp.cod || '' - '' || emp.nome) into r from empresas emp where emp.cod = p_cod;',
'      elsif p_dim = ''fil'' then',
'        select max(fi.cod_filial || '' - '' || fi.nome_filial) into r from filiais fi where fi.cod_empresa = p_emp and fi.cod_filial = p_cod;',
'      elsif p_dim = ''cc'' then',
'        r := p_cod || '' - '' || fnct_nome_ccusto(p_emp, p_cod);',
'      elsif p_dim = ''loc'' then',
'        r := p_cod || '' - '' || p_cod2;',
'      elsif p_dim = ''car'' then',
'        select max(cod || '' - '' || nome) into r from cargos where cod = p_cod;',
'      elsif p_dim = ''ex'' then',
'        select max(cod_exame || '' - '' || descricao) into r from exame where cod_exame = p_cod;',
'      elsif p_dim = ''cid'' then',
'        select max(substr(cod_doenca, 1, 5) || '' - '' || descricao) into r from doenca where cod_doenca = p_cod;',
'      elsif p_dim = ''tat'' then',
'        select max(substr(cod_atestado_medico, 1, 5) || '' - '' || descricao) into r from atestado_medico where cod_atestado_medico = p_cod;',
'      elsif p_dim = ''vac'' then',
'        select max(cod_vacina || '' - '' || descricao) into r from vacina where cod_vacina = p_cod;',
'      elsif p_dim = ''res'' then',
'        r := p_cod2;',
'      elsif p_dim = ''sit'' then',
'        r := p_cod || '' - '' || initcap(fnct_nome_situacao(p_cod));',
'      end if;',
'    exception when others then r := null;',
'    end;',
'    return substr(nvl(r, p_cod), 1, 380);',
'  end;',
'  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is',
'    k varchar2(400) := substr(p_dim || ''|'' || p_emp || ''|'' || p_cod || ''|'' || p_cod2, 1, 400);',
'    t varchar2(400);',
'    i pls_integer;',
'  begin',
'    if cache.exists(k) then return cache(k); end if;',
'    t := nome_de(p_dim, p_emp, p_cod, p_cod2);',
'    if por_rot.exists(p_dim || ''|'' || t) then',
'      i := por_rot(p_dim || ''|'' || t);',
'    else',
'      i := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;',
'      qtd(p_dim) := i + 1;',
'      rot(p_dim || ''#'' || i) := t;',
'      por_rot(p_dim || ''|'' || t) := i;',
'    end if;',
'    cache(k) := i;',
'    return i;',
'  end;',
unistr('  /* c\00F3digo opcional: sem c\00F3digo -> -1 */'),
'  function ixo(p_dim varchar2, p_cod varchar2) return varchar2 is',
'  begin',
'    if p_cod is null then return ''-1''; end if;',
'    return to_char(ix(p_dim, null, p_cod));',
'  end;',
'  function im(p varchar2) return pls_integer is',
'  begin',
'    if not mes.exists(p) then mes(p) := l_nmes; l_nmes := l_nmes + 1; end if;',
'    return mes(p);',
'  end;',
'begin',
unistr('  /* o LINK do Hist\00F3rico (p\00E1gina 6) de uma pessoa: o mesmo endere\00E7o do l\00E1pis da lista */'),
'  if apex_application.g_x01 = ''LINK'' then',
'    htp.prn(''{"url":'' || js(apex_page.get_url(p_page => 6, p_clear_cache => ''RP,6'',',
'                                              p_items => ''P6_COD_EMPRESA,P6_MATRICULA'',',
'                                              p_values => apex_application.g_x02 || '','' || apex_application.g_x03)) || ''}'');',
'    return;',
'  end if;',
'',
unistr('  /* o per\00EDodo: o que o painel mandou, ou os \00FAltimos 12 meses */'),
'  l_ini := data_de(apex_application.g_x01);',
'  l_fim := data_de(apex_application.g_x02);',
'  if l_ini is null then l_ini := add_months(trunc(l_hoje, ''MM''), -11); end if;',
'  if l_fim is null then l_fim := last_day(l_hoje); end if;',
'  if l_fim < l_ini then l_fim := l_ini; end if;',
'  if l_fim - l_ini + 1 > MAX_DIAS then l_fim := l_ini + MAX_DIAS - 1; l_cortouD := true; end if;',
unistr('  /* atestados: o per\00EDodo E os \00FAltimos 60 dias (regra do INSS) */'),
'  l_wini := least(l_ini, l_hoje - INSS_DIAS);',
'  l_wfim := greatest(l_fim, l_hoje);',
unistr('  /* os meses do per\00EDodo, em ordem */'),
'  declare d date := trunc(l_ini, ''MM''); x pls_integer; begin',
'    while d <= l_fim loop x := im(to_char(d, ''yyyymm'')); d := add_months(d, 1); end loop;',
'  end;',
'',
'  dbms_lob.createtemporary(l_cru, true);',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''v'', 1);',
'  apex_json.write(''hoje'', to_char(l_hoje, ''dd/mm/yyyy''));',
'  apex_json.write(''painel'', :P_PAINEL);',
'  apex_json.write(''ini'', to_char(l_ini, ''dd/mm/yyyy''));',
'  apex_json.write(''fim'', to_char(l_fim, ''dd/mm/yyyy''));',
'  apex_json.write(''dias'', l_fim - l_ini + 1);',
'  apex_json.write(''cortouDias'', l_cortouD);',
'',
'  l_passo := ''consulta'';',
'  l_t1 := dbms_utility.get_time;',
'  for r in (',
'    with pop as (',
unistr('      /* A CONSULTA DO RELAT\00D3RIO, s\00F3 com os c\00F3digos (o mesmo where) */'),
'      select /*+ materialize */',
'             infu.cod_empresa emp, infu.matricula mat, infu.filial fil, infu.cod_ccusto cc,',
'             infu.cod_localizacao loc, lotr.descricao locd, infu.cargo car,',
'             trunc(trunc(sysdate - inpe.dt_nasc) / 360) idade, infu.situacao sit',
'        from informacoes_funcionais infu',
'            ,inf_pessoais_cad inpe',
'            ,local_trab lotr',
'       where infu.cod_empresa = inpe.cod_empresa',
'         and infu.matricula = inpe.matricula',
'         and lotr.cod_local_trab = infu.cod_localizacao',
'         and ((infu.situacao < ''90'' and l_sit = ''A'') or (infu.situacao >= ''90'' and l_sit = ''D'') or (l_sit = ''T''))',
'         and (f_emp = 0 or instr(l_emp, '','' || infu.cod_empresa || '','') > 0)',
'         and (f_fil = 0 or instr(l_fil, '','' || infu.filial || '','') > 0)',
'         and (f_cc  = 0 or instr(l_cc,  '','' || infu.cod_ccusto || '','') > 0)',
'         and (f_un  = 0 or instr(l_un,  '','' || infu.unidade_adm || '','') > 0)',
'         and (f_at  = 0 or instr(l_at,  '','' || infu.cod_atividade || '','') > 0)',
'         and (f_car = 0 or instr(l_car, '','' || infu.cargo || '','') > 0)',
'         and (f_mat = 0 or instr(l_mat, '','' || infu.matricula || '','') > 0)',
'    )',
unistr('    /* P: as pessoas (v\00EAm primeiro) */'),
'    select 0 ord, ''P'' k, p.emp, p.mat, to_char(p.fil) c1, to_char(p.cc) c2, to_char(p.loc) c3, to_char(p.car) c4,',
'           cast(p.locd as varchar2(4000)) c5, cast(p.sit as varchar2(4000)) c6, cast(null as date) d1, cast(null as date) d2, cast(null as date) d3, p.idade n1',
'      from pop p',
'    union all',
unistr('    /* E: o \00FAltimo de cada exame, quando ele tem "pr\00F3ximo exame" */'),
'    select 1, ''E'', x.cod_empresa, x.matricula, to_char(x.cod_exame), null, null, null, null, null, x.dt_exame, x.dt_prox_exame_period, null, null',
'      from (select e.cod_empresa, e.matricula, e.cod_exame, e.dt_exame, e.dt_prox_exame_period,',
'                   row_number() over (partition by e.cod_empresa, e.matricula, e.cod_exame',
'                                      order by e.dt_exame desc, e.dt_prox_exame_period desc nulls last) rn',
'              from exame_func e, resultado rs, pop p',
'             where e.cod_resultado = rs.cod_resultado',
'               and e.tipo_entidade in (1, 7)',
'               and e.cod_empresa = p.emp',
'               and e.matricula = p.mat) x',
'     where x.rn = 1',
'       and x.dt_prox_exame_period is not null',
'    union all',
unistr('    /* U: o \00FAltimo exame (qualquer um) e quantos */'),
'    select 1, ''U'', e.cod_empresa, e.matricula, null, null, null, null, null, null, max(e.dt_exame), null, null, count(*)',
'      from exame_func e, resultado rs, pop p',
'     where e.cod_resultado = rs.cod_resultado',
'       and e.tipo_entidade in (1, 7)',
'       and e.cod_empresa = p.emp',
'       and e.matricula = p.mat',
'     group by e.cod_empresa, e.matricula',
'    union all',
unistr('    /* X: exames feitos no per\00EDodo, por m\00EAs, tipo e resultado */'),
'    select 1, ''X'', e.cod_empresa, e.matricula, to_char(e.dt_exame, ''yyyymm''), e.tipo_exame, to_char(rs.cod_resultado),',
'           to_char(rs.cod_resultado) || '' - '' || initcap(rs.descricao), null, null, null, null, null, count(*)',
'      from exame_func e, resultado rs, pop p',
'     where e.cod_resultado = rs.cod_resultado',
'       and e.tipo_entidade in (1, 7)',
'       and e.cod_empresa = p.emp',
'       and e.matricula = p.mat',
'       and e.dt_exame between l_ini and l_fim',
'     group by e.cod_empresa, e.matricula, to_char(e.dt_exame, ''yyyymm''), e.tipo_exame, rs.cod_resultado, rs.descricao',
'    union all',
unistr('    /* A: atestados que tocam o per\00EDodo ou os \00FAltimos 60 dias */'),
'    select 1, ''A'', a.cod_empresa, a.matricula, to_char(a.cod_doenca), to_char(a.cod_atestado_medico), to_char(a.ocupacional),',
'           to_char(a.qtde_horas_abonadas), null, null,',
'           nvl(a.dt_inicio_afastamento, a.dt_atestado_medico), a.dt_termino_afastamento, a.dt_atestado_medico, a.qtde_dias_afastamento',
'      from atestado_funcionario a, pop p',
'     where a.cod_empresa = p.emp',
'       and a.matricula = p.mat',
'       and nvl(a.dt_inicio_afastamento, a.dt_atestado_medico) <= l_wfim',
'       and nvl(a.dt_termino_afastamento, nvl(a.dt_inicio_afastamento, a.dt_atestado_medico) + greatest(nvl(a.qtde_dias_afastamento, 1), 1) - 1) >= l_wini',
'    union all',
unistr('    /* D: doen\00E7as sem t\00E9rmino */'),
'    select 1, ''D'', f.cod_empresa, f.matricula, to_char(f.cod_doenca), null, null, null, null, null, f.dt_inicio, null, null, null',
'      from func_doenca f, pop p',
'     where f.cod_empresa = p.emp',
'       and f.matricula = p.mat',
'       and f.dt_termino is null',
'    union all',
unistr('    /* V: a \00FAltima dose de cada vacina, quando a pr\00F3xima j\00E1 venceu ou vence em 30 dias */'),
'    select 1, ''V'', x.cod_empresa, x.matricula, to_char(x.cod_vacina), to_char(x.cod_dose), null, null, null, null, x.dt_vacina, x.dt_prox_dose, null, null',
'      from (select f.cod_empresa, f.matricula, f.cod_vacina, f.cod_dose, f.dt_vacina, f.dt_prox_dose,',
'                   row_number() over (partition by f.cod_empresa, f.matricula, f.cod_vacina order by f.dt_vacina desc) rn',
'              from vacina_func f, pop p',
'             where f.cod_empresa = p.emp',
'               and f.matricula = p.mat) x',
'     where x.rn = 1',
'       and x.dt_prox_dose is not null',
'       and x.dt_prox_dose <= l_hoje + 30',
'    union all',
unistr('    /* R: restri\00E7\00E3o m\00E9dica */'),
'    select 1, ''R'', m.cod_empresa, m.matricula, substr(m.restricao, 1, 240), null, null, null, null, null, null, null, null, null',
'      from restricao_medica m, pop p',
'     where m.cod_empresa = p.emp',
'       and m.matricula = p.mat',
'       and m.restricao is not null',
'    union all',
unistr('    /* C: acidentes no per\00EDodo */'),
'    select 1, ''C'', aa.cod_empresa, aa.matricula, to_char(aa.cod_acidente_tipo), to_char(aa.class_acidente), to_char(af.ind_afastamento),',
'           to_char(af.cid), null, null, aa.dt_acidente, null, null,',
unistr('           /* o tipo desta coluna n\00E3o est\00E1 na exporta\00E7\00E3o: lida como texto, s\00F3 n\00FAmero inteiro conta */'),
'           case when regexp_like(trim(to_char(af.quantidade_dias_afastamento)), ''^[0-9]{1,6}$'')',
'                then to_number(trim(to_char(af.quantidade_dias_afastamento))) end',
'      from analise_acidente aa, analise_func af, pop p',
'     where aa.cod_empresa = af.cod_empresa',
'       and aa.matricula = af.matricula',
'       and aa.cod_analise_acidente = af.cod_analise_acidente',
'       and aa.cod_empresa = p.emp',
'       and aa.matricula = p.mat',
'       and aa.dt_acidente between l_ini and l_fim',
'    union all',
unistr('    /* L: o acidente mais recente de toda a popula\00E7\00E3o (e o mais recente com afastamento) */'),
'    select 1, ''L'', null, null, null, null, null, null, null, null,',
'           max(aa.dt_acidente), max(case when af.ind_afastamento = ''S'' then aa.dt_acidente end), null, null',
'      from analise_acidente aa, analise_func af, pop p',
'     where aa.cod_empresa = af.cod_empresa',
'       and aa.matricula = af.matricula',
'       and aa.cod_analise_acidente = af.cod_analise_acidente',
'       and aa.cod_empresa = p.emp',
'       and aa.matricula = p.mat',
'       and aa.dt_acidente <= l_hoje',
'    union all',
unistr('    /* Q: consultas no per\00EDodo, por pessoa e m\00EAs */'),
'    select 1, ''Q'', cm.cod_empresa, cm.matricula, to_char(cm.dt_consulta, ''yyyymm''), null, null, null, null, null, null, null, null, count(*)',
'      from consulta_medica cm, pop p',
'     where cm.cod_empresa = p.emp',
'       and cm.matricula = p.mat',
'       and cm.dt_consulta between l_ini and l_fim',
'     group by cm.cod_empresa, cm.matricula, to_char(cm.dt_consulta, ''yyyymm'')',
'     order by 1',
'  ) loop',
'    if r.k = ''P'' then',
'      l_total := l_total + 1;',
'      if not pes.exists(r.emp || ''|'' || r.mat) then',
'        if l_npes >= MAX_PES then',
'          l_cortou := true;',
'        else',
'          pes(r.emp || ''|'' || r.mat) := l_npes;',
'          nom(l_npes) := r.mat || '' - '' || initcap(fnct_nome_func(r.emp, r.mat));',
'          lin(l_npes) := ix(''emp'', r.emp, r.emp) || '','' || ix(''fil'', r.emp, r.c1) || '','' || ix(''cc'', r.emp, r.c2) || '','' ||',
'                         ix(''loc'', null, r.c3, r.c5) || '','' || ix(''car'', null, r.c4) || '','' ||',
'                         case when r.n1 is null then ''null'' else n(r.n1) end || '','' || ixo(''sit'', r.c6);',
'          l_npes := l_npes + 1;',
'        end if;',
'      end if;',
'    elsif r.k = ''L'' then',
'      l_ua := dd(r.d1); l_ua2 := dd(r.d2);',
'    elsif pes.exists(r.emp || ''|'' || r.mat) then',
'      l_pi := pes(r.emp || ''|'' || r.mat);',
'      if r.k = ''E'' then',
'        poe(c_ex, n_ex, ''['' || l_pi || '','' || ix(''ex'', null, r.c1) || '','' || dd(r.d1) || '','' || dd(r.d2) || '']'');',
'      elsif r.k = ''U'' then',
'        ult(l_pi) := dd(r.d1) || '','' || n(r.n1);',
'      elsif r.k = ''X'' then',
'        poe(c_xf, n_xf, ''['' || l_pi || '','' || im(r.c1) || '','' || js(r.c2) || '','' || ix(''res'', null, r.c3, r.c4) || '','' || n(r.n1) || '']'');',
'      elsif r.k = ''A'' then',
'        poe(c_at, n_at, ''['' || l_pi || '','' || dd(r.d1) || '','' || dd(r.d2) || '','' || case when r.n1 is null then ''null'' else n(r.n1) end || '','' ||',
'                        n(minutos(r.c4)) || '','' || ixo(''cid'', r.c1) || '','' || ixo(''tat'', r.c2) || '','' || js(r.c3) || '','' || dd(r.d3) || '']'');',
'      elsif r.k = ''D'' then',
'        poe(c_dz, n_dz, ''['' || l_pi || '','' || ixo(''cid'', r.c1) || '','' || dd(r.d1) || '']'');',
'      elsif r.k = ''V'' then',
'        poe(c_vc, n_vc, ''['' || l_pi || '','' || ix(''vac'', null, r.c1) || '','' || dd(r.d1) || '','' || dd(r.d2) || '','' || js(r.c2) || '']'');',
'      elsif r.k = ''R'' then',
'        poe(c_rs, n_rs, ''['' || l_pi || '','' || js(r.c1) || '']'');',
'      elsif r.k = ''C'' then',
'        poe(c_ac, n_ac, ''['' || l_pi || '','' || dd(r.d1) || '','' || js(r.c1) || '','' || js(r.c2) || '','' || js(r.c3) || '','' ||',
'                        case when r.n1 is null then ''null'' else n(r.n1) end || '','' || js(r.c4) || '']'');',
'      elsif r.k = ''Q'' then',
'        poe(c_cs, n_cs, ''['' || l_pi || '','' || im(r.c1) || '','' || n(r.n1) || '']'');',
'      end if;',
'    end if;',
'  end loop;',
'  l_t2 := dbms_utility.get_time;',
'',
'  /* ESTABILIDADE (art. 118 da Lei 8.213 - a MESMA regra do painel de Acidentes, 200:150): voltou de',
unistr('     afastamento por acidente (situa\00E7\00E3o com ACID no nome) com mais de 15 dias e ainda est\00E1 nos 12 meses'),
unistr('     seguintes \00E0 volta. A volta \00E9 o fim do hist\00F3rico (+1) ou o in\00EDcio da situa\00E7\00E3o seguinte. */'),
'  l_passo := ''estabilidade'';',
'  for r in (select situacao cod from informacoes_funcionais where situacao <> ''01'' and situacao < ''90''',
'            union',
'            select cod_valor_fato from historico_cadastral',
'             where cod_fato = 1 and cod_valor_fato <> ''01'' and cod_valor_fato < ''90''',
'               and dt_vigencia >= add_months(l_hoje, -48)) loop',
'    begin',
'      if upper(fnct_nome_situacao(r.cod)) like ''%ACID%'' then l_codacid := l_codacid || r.cod || '',''; end if;',
'    exception when others then null;',
'    end;',
'  end loop;',
'  if l_codacid <> '','' then',
'    for r in (',
'      select x.*',
'        from (select h.cod_empresa emp, h.matricula mat, h.cod_valor_fato sit_h, h.dt_vigencia ini,',
'                     coalesce(h.dt_vigencia_fim + 1,',
'                              (select min(h2.dt_vigencia) from historico_cadastral h2',
'                                where h2.cod_empresa = h.cod_empresa and h2.matricula = h.matricula',
'                                  and h2.cod_fato = 1 and h2.dt_vigencia > h.dt_vigencia)) volta,',
'                     i.situacao',
'                from historico_cadastral h, informacoes_funcionais i',
'               where h.cod_empresa = i.cod_empresa',
'                 and h.matricula = i.matricula',
'                 and h.cod_fato = 1',
'                 and instr(l_codacid, '','' || h.cod_valor_fato || '','') > 0',
'                 and h.dt_vigencia >= add_months(l_hoje, -60)',
'                 and i.situacao < ''90'') x',
'       where x.volta is not null',
'         and x.volta <= l_hoje',
'         and x.volta - x.ini > 15',
'         and add_months(x.volta - 1, 12) >= l_hoje',
'    ) loop',
unistr('      /* s\00F3 quem est\00E1 na lista; quem est\00E1 afastado de novo por acidente aparece como afastado */'),
'      if pes.exists(r.emp || ''|'' || r.mat) and instr(l_codacid, '','' || r.situacao || '','') = 0 then',
'        l_pi := pes(r.emp || ''|'' || r.mat);',
'        if not es_ate.exists(l_pi) or es_ate(l_pi) < add_months(r.volta - 1, 12) then',
'          es_ate(l_pi) := add_months(r.volta - 1, 12);',
'          es_lin(l_pi) := ''['' || l_pi || '','' || dd(r.volta) || '','' || dd(add_months(r.volta - 1, 12)) || '','' || ixo(''sit'', r.sit_h) || '']'';',
'        end if;',
'      end if;',
'    end loop;',
'    declare i pls_integer := es_lin.first; begin',
'      while i is not null loop poe(c_es, n_es, es_lin(i)); i := es_lin.next(i); end loop;',
'    end;',
'  end if;',
'',
unistr('  /* as listas escritas \00E0 m\00E3o: pes (com o \00FAltimo exame), depois cada tabela */'),
'  l_passo := ''montar'';',
'  cru(''"pes":['');',
'  for i in 0 .. l_npes - 1 loop',
'    cru(case when i > 0 then '','' end || ''['' || lin(i) || '','' || case when ult.exists(i) then ult(i) else ''null,0'' end || '']'');',
'  end loop;',
'  cru('']'');',
'  junta(''ex'', c_ex); junta(''xf'', c_xf); junta(''at'', c_at); junta(''dz'', c_dz);',
'  junta(''vc'', c_vc); junta(''rs'', c_rs); junta(''ac'', c_ac); junta(''cs'', c_cs); junta(''es'', c_es);',
'  cru('',"acid":'' || js(l_codacid));',
'  cru('',"ua":['' || l_ua || '','' || l_ua2 || '']'');',
'  cru('',"meses":['');',
'  declare k varchar2(400) := mes.first; t t_lin; begin',
'    while k is not null loop t(mes(k)) := k; k := mes.next(k); end loop;',
'    for i in 0 .. l_nmes - 1 loop cru(case when i > 0 then '','' end || ''"'' || t(i) || ''"''); end loop;',
'  end;',
'  cru('']'');',
'  descarrega;',
'',
'  apex_json.write(''total'', l_total);',
'  apex_json.write(''cortou'', l_cortou);',
'  apex_json.open_object(''dims'');',
'  for j in 1 .. l_dims.count loop',
'    apex_json.open_array(l_dims(j));',
'    if qtd.exists(l_dims(j)) then',
'      for k in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || ''#'' || k)); end loop;',
'    end if;',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_object;',
'  apex_json.open_object(''cat'');',
'  for j in 1 .. l_cats.count loop',
'    apex_json.open_array(l_cats(j));',
'    if qtd.exists(l_cats(j)) then',
'      for k in 0 .. qtd(l_cats(j)) - 1 loop apex_json.write(rot(l_cats(j) || ''#'' || k)); end loop;',
'    end if;',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_object;',
'  apex_json.open_array(''nomes'');',
'  for i in 0 .. l_npes - 1 loop apex_json.write(nom(i)); end loop;',
'  apex_json.close_array;',
'  apex_json.open_object(''tempos'');',
'  apex_json.write(''consulta'', l_t2 - l_t1);',
'  apex_json.write(''total'', dbms_utility.get_time - l_t0);',
'  apex_json.close_object;',
'  apex_json.close_object;',
'  l_saida := apex_json.get_clob_output;',
'  apex_json.free_output;',
'',
unistr('  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + as listas escritas \00E0 m\00E3o + "}" */'),
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
