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
--   Date and Time:   15:59 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 29
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00029
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>29);
end;
/
prompt --application/pages/page_00029
begin
wwv_flow_api.create_page(
 p_id=>29
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>'Dados Candidatos Reduzido '
,p_page_mode=>'MODAL'
,p_step_title=>'Dados do candidato'
,p_autocomplete_on_off=>'OFF'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_DadosCandidato.css / Natcorp_DadosCandidato.js)',
'',
unistr('A FICHA do candidato para o m\00E9dico: c\00F3digo - nome, idade, sexo, situa\00E7\00E3o e o cargo pretendido no alto;'),
unistr('o que pede aten\00E7\00E3o (PCD, restri\00E7\00E3o para admiss\00E3o) ou a confirma\00E7\00E3o de que n\00E3o h\00E1; e as se\00E7\00F5es Vaga'),
unistr('pretendida, Contato (telefones que ligam no celular), Identifica\00E7\00E3o, Documentos (CPF, PIS, CTPS'),
unistr('formatados), Indica\00E7\00E3o e v\00EDnculos e Uniforme. S\00F3 aparece o que est\00E1 preenchido ("Sem informa\00E7\00E3o: ...").'),
unistr('S\00F3 L\00CA os itens que o CARREGA_DADOS preenche; o formul\00E1rio original fica na p\00E1gina, fora da vista.'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/DADOS-CANDIDATO-MANUTENCAO.md.'))
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_DadosCandidato.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_DadosCandidato.css'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_last_upd_yyyymmddhh24miss=>'20241105164118'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166675613505957889065)
,p_plug_name=>'Dados Candidatos Reduzido'
,p_icon_css_classes=>'fa-address-book-o'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921841000262886869)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>'<p>Candidatos (Reduzido) </p>'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166697673675511055702)
,p_plug_name=>'Dados Candidatos Reduzido'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834497856886858)
,p_plug_display_sequence=>10
,p_plug_grid_column_css_classes=>'fa-address-book-o'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166698429476266559920)
,p_plug_name=>'Manequim'
,p_parent_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166698430222320559927)
,p_plug_name=>'Documentos'
,p_parent_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166698430607816559931)
,p_plug_name=>unistr('Pretens\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166698431025452559935)
,p_plug_name=>unistr('Refer\00EAncias')
,p_parent_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166697674549485055703)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834581028886859)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166697674262269055703)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166697674549485055703)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'#PLEASE_CHANGE#'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166697674060580055703)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166697674549485055703)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'#PLEASE_CHANGE#'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166697674176716055703)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166697674549485055703)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'#PLEASE_CHANGE#'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition_type=>'NEVER'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166697674409549055703)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166697674549485055703)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'#PLEASE_CHANGE#'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675613170414889062)
,p_name=>'P29_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P29_NUM_CALCA'
,p_ajax_items_to_submit=>'P29_NUM_CALCA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>50
,p_colspan=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675613329248889063)
,p_name=>'P29_COD_FILIAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>50
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675613591777889066)
,p_name=>'P29_NUM_CAMISA'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(166698429476266559920)
,p_prompt=>unistr('N\00FAmero Camisa')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675613749389889067)
,p_name=>'P29_NUM_CALCA'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(166698429476266559920)
,p_prompt=>unistr('N\00FAmero Cal\00E7a')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675613818367889068)
,p_name=>'P29_NUM_CALCADO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(166698429476266559920)
,p_prompt=>unistr('N\00FAmero Cal\00E7ado')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697677135483055738)
,p_name=>'P29_COD_CANDIDATO'
,p_item_sequence=>1
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697677467139055755)
,p_name=>'P29_NOME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Nome'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697677913105055755)
,p_name=>'P29_SEXO'
,p_item_sequence=>124
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Sexo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_SEXO'
,p_lov=>'.'||wwv_flow_api.id(166668299555649870032)||'.'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P29_NUM_CALCA'
,p_ajax_items_to_submit=>'P29_NUM_CALCA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697678333117055756)
,p_name=>'P29_STATUS_CANDIDATO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Status Candidato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>15
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697678680475055756)
,p_name=>'P29_DATA_CADASTRO'
,p_item_sequence=>123
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Data Cadastro'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697679149550055756)
,p_name=>'P29_NOME_MAE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>unistr('Nome da M\00E3e')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>50
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697679484929055757)
,p_name=>'P29_DT_NAC'
,p_item_sequence=>121
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Data de Nascimento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697679920746055757)
,p_name=>'P29_TELEFONE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Telefone Residencial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697680314046055757)
,p_name=>'P29_UF_NACTO'
,p_item_sequence=>122
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'UF de Nascimento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697680676594055758)
,p_name=>'P29_TELEFONE_RECADOS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Telefone Recados'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697681090028055758)
,p_name=>'P29_NOME_CONTATO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Contato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>15
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697681511287055759)
,p_name=>'P29_RESTRICAO_ADMISSAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>unistr('Restri\00E7\00E3o')
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(166663252488110389885)||'.'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P29_NUM_CALCA'
,p_ajax_items_to_submit=>'P29_NUM_CALCA'
,p_ajax_optimize_refresh=>'Y'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697681954991055759)
,p_name=>'P29_IND_DEF_FIS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'PCD'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(166663252488110389885)||'.'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P29_NUM_CALCA'
,p_ajax_items_to_submit=>'P29_NUM_CALCA'
,p_ajax_optimize_refresh=>'Y'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697682352625055759)
,p_name=>'P29_IND_EXIMIDO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Eximido'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(166663252488110389885)||'.'
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P29_NUM_CALCA'
,p_ajax_items_to_submit=>'P29_NUM_CALCA'
,p_ajax_optimize_refresh=>'Y'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166697682747560055760)
,p_name=>'P29_PS'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(166697673675511055702)
,p_prompt=>'Processo Seletivo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698429647055559921)
,p_name=>'P29_NUM_IDENTIDADE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>'Num. Indentidade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698429742068559922)
,p_name=>'P29_NUM_CPF'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698429761542559923)
,p_name=>'P29_NUM_PIS_PASEP'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>'PIS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698429947728559924)
,p_name=>'P29_NUM_CART_PROF'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>'CTPS'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430045129559925)
,p_name=>'P29_DT_EMIS_CART'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>unistr('Data de Emiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430132508559926)
,p_name=>'P29_EST_EMIS_PROF'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(166698430222320559927)
,p_prompt=>unistr('UF Emiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430359535559928)
,p_name=>'P29_CARGO_PRETENDIDO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(166698430607816559931)
,p_prompt=>'Cargo Pretendido'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430451581559929)
,p_name=>'P29_LOCAL_PRETENDIDO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(166698430607816559931)
,p_prompt=>'Local Pretendido'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430537917559930)
,p_name=>'P29_FUNCAO_PRETENDIDA'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(166698430607816559931)
,p_prompt=>unistr('Fun\00E7\00E3o Pretendida')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430672394559932)
,p_name=>'P29_IND_POR'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(166698431025452559935)
,p_prompt=>'Indicado Por'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430765434559933)
,p_name=>'P29_PARENTE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(166698431025452559935)
,p_prompt=>'Parente'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166698430859795559934)
,p_name=>'P29_EX_FUNCIONARIO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(166698431025452559935)
,p_prompt=>unistr('Ex. Funcion\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166697675253297055712)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166697674060580055703)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166697675622674055715)
,p_event_id=>wwv_flow_api.id(166697675253297055712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166697683164312055760)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_attribute_01=>'P29_COD_FILIAL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166675613099091889061)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CARREGA_DADOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
' Begin',
'	select IPC.EMPRESA,',
'				( Select F.Cod_Filial || '' - ''|| F.Nome_Filial',
'					  From Filiais F',
'				   Where F.Cod_Empresa = IPC.Empresa',
'					   and F.COD_FILIAL = IPC.COD_FILIAL and rownum = 1',
'					 ) COD_FILIAL,',
'	       IPC.COD_CANDIDATO ||'' - ''|| IPC.NOME,',
'				 IPC.SEXO,',
'				 decode(IPC.STATUS_CANDIDATO,''A'',''Ativo'',',
'				                             ''P'',''Pendente'',',
'																		 ''R'',''Reprovado''',
'							),',
'				 IPC.DATA_CADASTRO,',
'				 IPC.NOME_MAE,',
'				 IPC.DDD||'' - ''||IPC.TELEFONE,',
'				 IPC.DDD_CELULAR||'' - ''||IPC.TELEFONE_RECADOS,',
'				 IPC.NOME_CONTATO,',
'				 IPC.RESTRICAO_ADMISSAO,',
'				 IPC.IND_DEF_FIS,',
'				 IPC.IND_EXIMIDO,',
'				 IPC.PS,',
'				 IPC.DT_NAC,',
'         IPC.UF_NACTO,',
'				 IPC.NUM_CAMISA,',
'         IPC.NUM_CALCA,',
'         IPC.NUM_CALCADO,',
'				 IPC.NUM_IDENTIDADE,',
'				 IPC.NUM_CPF||'' - ''||IPC.DC_CPF,',
'				 IPC.NUM_PIS_PASEP,',
'				 IPC.NUM_CART_PROF||'' - ''||IPC.SER_CART_PROF,',
'				 IPC.DT_EMIS_CART,',
'				 IPC.EST_EMIS_PROF,',
'				(',
'				Select Cod||'' - ''||Nome',
'					From Cargos ',
'				 Where cod = IFC.cargo_pretendido and rownum = 1',
'				 )',
'				,',
'				(',
'				Select loc.cod_Local_Trab||'' - ''|| loc.Descricao',
'					From Local_Trab loc     ',
'					where loc.cod_Local_Trab = IFC.cargo_pretendido and rownum = 1',
'				)',
'				,',
'				(',
'				SELECT f.cod ||'' - ''||f.nome',
'					FROM funcao f',
'				 WHERE f.cod_cargo = IFC.cargo_pretendido and rownum = 1',
'				),',
'        IFC.REFERENCIA_EMP||'' - ''||IFC.REFERENCIA_MATR||'' - ''||IFC.REFERENCIA_DC||'' - ''||',
'				(',
'						select a.dc_matricula||'' - ''||a.nome    ',
'							from inf_pessoais a, ',
'									 informacoes_funcionais b ',
'						 where b.cod_empresa = a.cod_empresa',
'							 and b.matricula   = a.matricula',
'							 and b.matricula   = IFC.referencia_matr',
'							 and b.cod_empresa = IFC.referencia_emp and rownum = 1',
'				 ),',
'				IFC.PARENTE_EMP||'' - ''||IFC.PARENTE_MATR||'' - ''||IFC.PARENTE_DC||'' - ''||',
'				(',
'						select a.dc_matricula||'' - ''||a.nome',
'							from inf_pessoais a, ',
'							     informacoes_funcionais b ',
'						 where b.cod_empresa = a.cod_empresa',
'							 and b.matricula   = a.matricula',
'							 and b.matricula   = IFC.parente_matr',
'							 and b.cod_empresa = IFC.parente_emp and rownum = 1',
'				),							',
'				IFC.EX_FUNC_EMP||'' - ''||IFC.EX_FUNC_MATR||'' - ''||IFC.EX_FUNC_DC||'' - ''||',
'			(select a.dc_matricula ||'' - ''||a.nome',
'				from inf_pessoais a, ',
'						 informacoes_funcionais b ',
'			 where b.cod_empresa = a.cod_empresa',
'				 and b.matricula   = a.matricula',
'				 and b.matricula   = IFC.ex_func_matr',
'				 and b.cod_empresa = IFC.ex_func_emp and rownum = 1',
'       )			',
'  into 	:P29_EMPRESA,',
'				:P29_COD_FILIAL,',
'				:P29_NOME,',
'				:P29_SEXO,',
'				:P29_STATUS_CANDIDATO,',
'				:P29_DATA_CADASTRO,',
'				:P29_NOME_MAE,',
'				:P29_TELEFONE,',
'				:P29_TELEFONE_RECADOS,',
'				:P29_NOME_CONTATO,',
'				:P29_RESTRICAO_ADMISSAO,',
'				:P29_IND_DEF_FIS,',
'				:P29_IND_EXIMIDO,',
'				:P29_PS,',
'				:P29_DT_NAC,',
'        :P29_UF_NACTO,',
'				:P29_NUM_CAMISA,',
'        :P29_NUM_CALCA,',
'        :P29_NUM_CALCADO,',
'				:P29_NUM_IDENTIDADE,',
'				:P29_NUM_CPF,',
'				:P29_NUM_PIS_PASEP,',
'				:P29_NUM_CART_PROF,',
'				:P29_DT_EMIS_CART,',
'				:P29_EST_EMIS_PROF,',
'				:P29_CARGO_PRETENDIDO,',
'        :P29_LOCAL_PRETENDIDO,',
'				:P29_FUNCAO_PRETENDIDA,',
'				:P29_IND_POR,',
'				:P29_PARENTE,',
'				:P29_EX_FUNCIONARIO',
'		from INF_PESSOAIS_CANDIDATO IPC,',
'		     INF_FUNC_CANDIDATO IFC',
'	 where IPC.COD_CANDIDATO = :P29_COD_CANDIDATO',
'	   and IFC.COD_EMPRESA (+) = IPC.EMPRESA',
'     and IFC.COD_CANDIDATO (+) = IPC.COD_CANDIDATO;',
'exception ',
'   when no_data_found then null;  -- candidato sem cadastro: a ficha avisa (Natcorp_DadosCandidato.js)',
'   when others then',
'     raise_application_error(-20001, SQLERRM);',
'end; '))
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
