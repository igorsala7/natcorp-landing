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
