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
--   Date and Time:   16:18 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 150
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00150
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>150);
end;
/
prompt --application/pages/page_00150
begin
wwv_flow_api.create_page(
 p_id=>150
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>'Acidente de Trabalho'
,p_step_title=>'Acidente de Trabalho'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
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
,p_last_upd_yyyymmddhh24miss=>'20240621162228'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276011111853476019523)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>30
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(271633086922506339402)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(276011111853476019523)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283725458974017996838)
,p_plug_name=>'Acidente de Trabalho'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>12
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.COD_EMPRESA||'' - ''||initcap(fnct_nome_empresa(a.cod_empresa)) empresa,',
'i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) filial,',
'i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) centro_de_custo,',
'a.MATRICULA||'' - ''||initcap(fnct_nome_func(a.cod_empresa, a.matricula)) colaborador,',
'i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo,',
'i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) situacao,',
'a.COD_ANALISE_ACIDENTE,',
'a.DT_ANALISE Data_da_Analise,',
'a.COD_ACIDENTE_TIPO||'' - ''||Initcap(t.descricao) Tipo,',
'a.DT_ACIDENTE Data_do_Acidente,',
'to_char(a.HOR_ACIDENTE,''hh24:mi'') Hora_do_Acidente,',
'a.COD_LOCAL_TRAB||'' - ''||initcap(a.DS_LOCAL) Local_de_Trabalho,',
unistr('a.MATRICULA_TEC_SEGURANCA||'' - ''||initcap(p1.nome) Matr\00EDcula_T\00E9c_Seguran\00E7a,'),
unistr('a.MATRICULA_ENG_SEGURANCA||'' - ''||initcap(p2.nome) Matr\00EDcula_Eng_Seguran\00E7a,'),
'a.OBSERVACAO,',
'i.cod_empresa,',
'i.matricula',
'from ANALISE_ACIDENTE a, informacoes_funcionais i, prestador_servico p1, prestador_servico p2, acidente_tipo t',
'where a.cod_empresa = i.cod_empresa',
'  and a.matricula = i.matricula',
'  and a.cod_acidente_tipo = t.cod_acidente_tipo (+)',
'  and a.matricula_tec_seguranca = p1.cod_prest_serv (+)',
'  and a.matricula_eng_seguranca = p2.cod_prest_serv (+)',
'  and a.cod_empresa = nvl(:p150_emp,a.cod_empresa)',
'  and a.matricula = nvl(:p150_mat,a.matricula)',
'  and ((i.situacao < ''90'' and :P150_situacao = ''A'') or (i.situacao >= ''90'' and :P150_situacao = ''D'') or (:P150_situacao = ''T''))',
'   and (:P150_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_EMPRESA, '','')) t))',
'   and (:P150_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_FILIAL, '','')) t))',
'   and (:P150_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_CCUSTO, '','')) t))',
'   and (:P150_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_UNIDADE_ADM, '','')) t))',
'   and (:P150_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_ATIVIDADE, '','')) t))',
'   and (:P150_CARGO       is null or i.cargo     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_CARGO, '','')) t))',
'   and (:P150_MATRICULA   is null or i.matricula     in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_MATRICULA, '','')) t))',
'order by data_do_acidente desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(283725459386899996838)
,p_name=>'Acidente de Trabalho'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Acidente de Trabalho Cadastrado.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:151:&SESSION.::&DEBUG.:151:P151_COD_EMPRESA,P151_COD_ANALISE_ACIDENTE,P151_MATRICULA:#COD_EMPRESA#,#COD_ANALISE_ACIDENTE#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>6388280976970929
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725695737967442340)
,p_db_column_name=>'EMPRESA'
,p_display_order=>47
,p_column_identifier=>'AR'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725695825714442341)
,p_db_column_name=>'FILIAL'
,p_display_order=>57
,p_column_identifier=>'AS'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725695996352442342)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>67
,p_column_identifier=>'AT'
,p_column_label=>'Centro de Custo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696070214442343)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>77
,p_column_identifier=>'AU'
,p_column_label=>'Colaborador'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#COLABORADOR#'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696114855442344)
,p_db_column_name=>'CARGO'
,p_display_order=>87
,p_column_identifier=>'AV'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696240156442345)
,p_db_column_name=>'SITUACAO'
,p_display_order=>97
,p_column_identifier=>'AW'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725460224474996844)
,p_db_column_name=>'COD_ANALISE_ACIDENTE'
,p_display_order=>107
,p_column_identifier=>'C'
,p_column_label=>unistr('C\00F3d. Analise Acidente')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696360952442346)
,p_db_column_name=>'DATA_DA_ANALISE'
,p_display_order=>117
,p_column_identifier=>'AX'
,p_column_label=>'Data da Analise'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696485347442347)
,p_db_column_name=>'TIPO'
,p_display_order=>127
,p_column_identifier=>'AY'
,p_column_label=>'Tipo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696519841442348)
,p_db_column_name=>'DATA_DO_ACIDENTE'
,p_display_order=>137
,p_column_identifier=>'AZ'
,p_column_label=>'Data do Acidente'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696662231442349)
,p_db_column_name=>'HORA_DO_ACIDENTE'
,p_display_order=>147
,p_column_identifier=>'BA'
,p_column_label=>'Hora do Acidente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696777224442350)
,p_db_column_name=>'LOCAL_DE_TRABALHO'
,p_display_order=>157
,p_column_identifier=>'BB'
,p_column_label=>'Local de Trabalho'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696821949442351)
,p_db_column_name=>unistr('MATR\00CDCULA_T\00C9C_SEGURAN\00C7A')
,p_display_order=>167
,p_column_identifier=>'BC'
,p_column_label=>unistr('Matr\00EDcula T\00E9c. Seguran\00E7a')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725696959844442352)
,p_db_column_name=>unistr('MATR\00CDCULA_ENG_SEGURAN\00C7A')
,p_display_order=>177
,p_column_identifier=>'BD'
,p_column_label=>unistr('Matr\00EDcula Eng. Seguran\00E7a')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725470930959996854)
,p_db_column_name=>'OBSERVACAO'
,p_display_order=>187
,p_column_identifier=>'AD'
,p_column_label=>unistr('Observa\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725459841578996843)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>197
,p_column_identifier=>'B'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283725473727363996857)
,p_db_column_name=>'MATRICULA'
,p_display_order=>207
,p_column_identifier=>'AK'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283725477070616997643)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'64060'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('EMPRESA:FILIAL:CENTRO_DE_CUSTO:COLABORADOR:CARGO:SITUACAO:COD_ANALISE_ACIDENTE:DATA_DA_ANALISE:TIPO:DATA_DO_ACIDENTE:HORA_DO_ACIDENTE:LOCAL_DE_TRABALHO:MATR\00CDCULA_T\00C9C_SEGURAN\00C7A:MATR\00CDCULA_ENG_SEGURAN\00C7A:OBSERVACAO:')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283725697025146442353)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(283780677543880158203)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(283867039513876591195)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P150_MAT'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283725745077662851505)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P150_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283725747354305851513)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(283725745077662851505)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P150_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283725748140994851514)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(283725745077662851505)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P150_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271113111715115895161)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(276011111853476019523)
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
 p_id=>wwv_flow_api.id(271113112082289895161)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(276011111853476019523)
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
 p_id=>wwv_flow_api.id(271113112437441895162)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(276011111853476019523)
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
 p_id=>wwv_flow_api.id(283725745334443851509)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(283725745077662851505)
,p_button_name=>'p150_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(283867038901808591191)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P150_COD_EMPRESA.,&P150_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271113112914788895163)
,p_name=>'P150_SITUACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276011111853476019523)
,p_item_default=>'A'
,p_prompt=>unistr('Situa\00E7\00E3o Funcional')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Ativos;A,Demitidos;D,Todos;T'
,p_cHeight=>1
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271113113289854895164)
,p_name=>'P150_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(276011111853476019523)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' WHERE ((:p_painel = ''PO'') or (nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113113728145895165)
,p_name=>'P150_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(276011111853476019523)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271113114367251895167)
,p_name=>'P150_FILIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(nvl(sigla,nome_filial)) descricao, cod_filial',
'  from filiais ',
'where ((instr('',''||:p150_empresa||'','','',''||cod_empresa||'','') > 0) or (:p150_empresa is null))',
'and ((:P_PAINEL = ''PO'') or (encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P150_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113114759996895168)
,p_name=>'P150_CCUSTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and (:p150_empresa is null or c.cod_empresa in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p150_empresa, '','')) t))',
'and (:p150_filial is null or f.cod_filial in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:p150_filial, '','')) t))',
'and ((:P_PAINEL = ''PO'') or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                        and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and f_acesso_cc(c.cod_empresa, c.cod) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P150_EMPRESA,P150_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113115218623895169)
,p_name=>'P150_UNIDADE_ADM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>'Unidade Adm. (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where ((instr('',''||:p150_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p150_empresa is null))',
'       and ((instr('',''||:p150_filial||'','','',''||a.cod_filial||'','') > 0) or (:p150_filial is null))',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'       and s.cod_ccusto = :p150_ccusto',
'       and ((instr('',''||:p150_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p150_ccusto is null))',
'       and s.ativo = ''S''',
'       and :p150_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where ((instr('',''||:p150_empresa||'','','',''||a.cod_empresa||'','') > 0) or (:p150_empresa is null))',
'       and ((instr('',''||:p150_filial||'','','',''||a.cod_filial||'','') > 0) or (:p150_filial is null))',
'       and :p150_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P150_EMPRESA,P150_FILIAL,P150_CCUSTO,P150_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113115554136895170)
,p_name=>'P150_ATIVIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.ativo = ''S''',
'   and t.cod = s.cod_atividade',
'   and ((instr('',''||:p150_ccusto||'','','',''||s.cod_ccusto||'','') > 0) or (:p150_empresa is null))',
'   and ((instr('',''||:p150_unidade_adm||'','','',''||s.cod_unid_adm||'','') > 0) or (:p150_unidade_adm is null))',
'   and s.ativo = ''S''',
'   and :p150_utiliza_secao = ''S''',
'union',
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t',
' where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'   and t.ativo = ''S''',
'   and :p150_utiliza_secao = ''N''',
' order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P150_CCUSTO,P150_UNIDADE_ADM,P150_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113115965370895171)
,p_name=>'P150_CARGO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nome) descricao, cod',
'  from cargos',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113116360723895172)
,p_name=>'P150_MATRICULA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_prompt=>'Colaboradores'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(p.nome) d, i.matricula',
'  from informacoes_funcionais i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and ((i.situacao < ''90'' and :p150_situacao = ''A'') or (i.situacao >= ''90'' and :p150_situacao = ''D'') or (:p150_situacao = ''T''))',
'   and (:P150_EMPRESA     is null or i.cod_empresa   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_EMPRESA, '','')) t))',
'   and (:P150_FILIAL      is null or i.filial        in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_FILIAL, '','')) t))',
'   and (:P150_CCUSTO      is null or i.cod_ccusto    in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_CCUSTO, '','')) t))',
'   and (:P150_UNIDADE_ADM is null or i.unidade_adm   in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_UNIDADE_ADM, '','')) t))',
'   and (:P150_ATIVIDADE   is null or i.cod_atividade in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P150_ATIVIDADE, '','')) t))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P150_CCUSTO,P150_UNIDADE_ADM,P150_UTILIZA_SECAO,P150_ATIVIDADE,P150_SITUACAO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_display_when=>'P150_MAT'
,p_display_when_type=>'ITEM_IS_NULL'
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
 p_id=>wwv_flow_api.id(271113116761755895173)
,p_name=>'P150_PESQUISA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(271633086922506339402)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725697165784442354)
,p_name=>'P150_EMP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(283725745077662851505)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725697263603442355)
,p_name=>'P150_MAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283725745077662851505)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725747719319851514)
,p_name=>'P150_FOTO_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283725747354305851513)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_attributes=>'height="100" width="80"'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P150_EMP',
'   and matricula = :P150_MAT'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725748583744851515)
,p_name=>'P150_COD_EMPRESA_DISPLAY'
,p_item_sequence=>850
,p_item_plug_id=>wwv_flow_api.id(283725748140994851514)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725748991800851515)
,p_name=>'P150_MATRICULA_DISPLAY'
,p_item_sequence=>860
,p_item_plug_id=>wwv_flow_api.id(283725748140994851514)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725749366520851515)
,p_name=>'P150_SITUACAO_COLAB'
,p_item_sequence=>870
,p_item_plug_id=>wwv_flow_api.id(283725748140994851514)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283725749715869851515)
,p_name=>'P150_DT_ADMISSAO'
,p_item_sequence=>880
,p_item_plug_id=>wwv_flow_api.id(283725748140994851514)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271113117363615905884)
,p_name=>'Open Parametros_Itens'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113111715115895161)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113117738822905887)
,p_event_id=>wwv_flow_api.id(271113117363615905884)
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
 p_id=>wwv_flow_api.id(271113118223876907420)
,p_name=>'Close Parametros_Itens'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113112082289895161)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113118540237907422)
,p_event_id=>wwv_flow_api.id(271113118223876907420)
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
 p_id=>wwv_flow_api.id(271113118968906912227)
,p_name=>'Pesquisa'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271113112437441895162)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113119402894912228)
,p_event_id=>wwv_flow_api.id(271113118968906912227)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p150_pesquisa := ''S'';'
,p_attribute_03=>'P15-_PESQUISA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271113119861342912230)
,p_event_id=>wwv_flow_api.id(271113118968906912227)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283725752355706873322)
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
'       i.dt_admissao,',
'       I.FILIAL',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p150_emp',
'   and i.matricula = :p150_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p150_cod_empresa_display := v_c1.empresa;',
':p150_matricula_display := v_c1.matricula;',
':p150_situacao_colab := v_c1.situacao;',
':p150_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p150_cod_empresa_display := :p150_emp;',
':p150_matricula_display := :p150_mat;',
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
