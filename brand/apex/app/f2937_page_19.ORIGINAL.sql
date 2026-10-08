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
--   Date and Time:   01:36 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 19
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00019
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>19);
end;
/
prompt --application/pages/page_00019
begin
wwv_flow_api.create_page(
 p_id=>19
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Exame M\00E9dico Ocupacional')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Exame M\00E9dico Ocupacional')
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*#c-oculos .t-Region-headerItems--title, #s-oculos .t-Region-headerItems--title {*/',
'#wecker .t-Region-headerItems--title, #adicionais .t-Region-headerItems--title, #complementares .t-Region-headerItems--title {',
'    text-align: center;',
'}'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260901165830'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166667547911409288341)
,p_plug_name=>'Container'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(177921844724398886873)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166667546944704288331)
,p_plug_name=>'Dados Adicionais'
,p_region_name=>'adicionais'
,p_parent_plug_id=>wwv_flow_api.id(166667547911409288341)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166667547816205288340)
,p_plug_name=>'Tabela de Wecker'
,p_region_name=>'wecker'
,p_parent_plug_id=>wwv_flow_api.id(166667547911409288341)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166667548001404288342)
,p_plug_name=>unistr('Vis\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(166667547816205288340)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672788494744154323)
,p_plug_name=>'S/OCULOS'
,p_region_name=>'s-oculos'
,p_parent_plug_id=>wwv_flow_api.id(166667548001404288342)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672788626492154324)
,p_plug_name=>'C/OCULOS'
,p_region_name=>'c-oculos'
,p_parent_plug_id=>wwv_flow_api.id(166667548001404288342)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166671295429700347422)
,p_plug_name=>'Dinamometria'
,p_parent_plug_id=>wwv_flow_api.id(166667547816205288340)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672788783502154326)
,p_plug_name=>'Dinamometria'
,p_parent_plug_id=>wwv_flow_api.id(166671295429700347422)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166671295896999347427)
,p_plug_name=>'Outros'
,p_parent_plug_id=>wwv_flow_api.id(166667547816205288340)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672788923326154327)
,p_plug_name=>'Espirometria'
,p_parent_plug_id=>wwv_flow_api.id(166671295896999347427)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672789135178154329)
,p_plug_name=>'Outros Exames'
,p_parent_plug_id=>wwv_flow_api.id(166671295896999347427)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166672788692536154325)
,p_plug_name=>'Audiometria'
,p_parent_plug_id=>wwv_flow_api.id(166667547816205288340)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166667550604948288368)
,p_plug_name=>'Audiometria'
,p_parent_plug_id=>wwv_flow_api.id(166672788692536154325)
,p_region_template_options=>'#DEFAULT#:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166671296499323347433)
,p_plug_name=>unistr('Informa\00E7\00F5es Complementares')
,p_region_name=>'complementares'
,p_parent_plug_id=>wwv_flow_api.id(166667547911409288341)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167309177391571510752)
,p_plug_name=>unistr('Informa\00E7\00F5es Cadastrais')
,p_region_name=>'informacoes'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166671299114697347459)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:RP,18::'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166672788241252154320)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-trash-o'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166671298901125347457)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'SAVE'
,p_button_static_id=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P19_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-save-as'
,p_security_scheme=>wwv_flow_api.id(161347559704688747727)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166671299372052347462)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'INSERT'
,p_button_static_id=>'INSERT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P19_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus-square-o'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(87716555987008570567)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'BT_INICIO_ATEND'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Iniciar Atendimento'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P19_PRE_ATEND'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166678209984276051545)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'ASO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Relat\00F3rio ASO')
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166671300060607347469)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_button_name=>'EXAMES'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Exames'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP,19,11:P11_COD_EMPRESA,P11_MATRICULA,P11_PAGE_REQUEST:&P19_EMPRESA.,&P19_MATRICULA.,19'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21595652948624774717)
,p_name=>'P19_FUNCAO_PROPOSTA'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.funcao_proposta',
'  from solicitacao_exames a',
' where cod_req = :P19_COD_REQ',
'   and :P19_ROWID IS NULL',
'   and :P19_TIPO_EXAME = ''M'''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('Fun\00E7\00E3o Proposta')
,p_source=>'FUNCAO_PROPOSTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD||''-''||NOME DSCFUNCAO, COD',
'  FROM FUNCAO',
' WHERE /*COD_CARGO = :P19_CARGO_PROPOSTO',
'   AND */TRUNC(SYSDATE) BETWEEN DT_INIC_VIG_FUNCAO AND DT_TERM_VIG_FUNCAO',
' ORDER BY 2',
''))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET_FILTER'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73054379309312033892)
,p_name=>'P19_COD_CARGO_EPOCA'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO_EPOCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73054379368368033893)
,p_name=>'P19_COD_FUNCAO_EPOCA'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FUNCAO_EPOCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73054379496654033894)
,p_name=>'P19_COD_LOCAL_EPOCA'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_LOCAL_EPOCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(73054379521415033895)
,p_name=>'P19_COD_FILIAL_EPOCA'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FILIAL_EPOCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(87707812329659144183)
,p_name=>'P19_PRE_ATEND'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(102965017045714584381)
,p_name=>'P19_COD_REQ'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126327074866535818217)
,p_name=>'P19_USUARIO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126327074918551818218)
,p_name=>'P19_MEDICO_COORDENADOR'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(126327075036561818219)
,p_name=>'P19_UF_DOCUMENTO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'UF_DOCUMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130465423279866049232)
,p_name=>'P19_ORIGEM_MED'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'ORIGEM_MED'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130465424314644049242)
,p_name=>'P19_MEDICO_AUX'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT V.ORIGEM||V.COD R',
'  FROM PREST_SERV_ENTIDADE E,',
'       VW_MEDICOS V',
' WHERE E.COD_PREST_SERV (+) = V.COD',
'   AND V.COD = :P19_MEDICO'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('M\00E9dico do Trabalho')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT V.COD || '' - '' || V.NOME ',
'      ,V.ORIGEM||V.COD R',
'  FROM PREST_SERV_ENTIDADE E,',
'       VW_MEDICOS V',
' WHERE E.COD_PREST_SERV (+) = V.COD',
' GROUP BY V.ORIGEM,V.COD, V.NOME',
' ORDER BY V.COD;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-Selecione-'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667515357196152344)
,p_name=>'P19_DATA_ATUAL'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Exame'
,p_source=>'DATA_ATUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P19_DATA_ATUAL'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667515742092152344)
,p_name=>'P19_MATRICULA'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Funcion\00E1rio')
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula || '' - '' || p.nome as d,',
'       p.matricula as r',
'  from inf_pessoais p,',
'       informacoes_funcionais f',
' where p.cod_empresa = :P19_EMPRESA',
'   and p.cod_empresa = f.cod_empresa',
'   and p.matricula   = f.matricula',
' --  and (:P19_MATRICULA is not null or f.situacao < ''90'')',
' and f.situacao < ''90'' ',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P19_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P19_MATRICULA'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667516112469152344)
,p_name=>'P19_TIPO_EXAME'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo exame'
,p_source=>'TIPO_EXAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_EXAME_OCUPACIONAL'
,p_lov=>'.'||wwv_flow_api.id(166667492716614988373)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P19_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667516481411152345)
,p_name=>'P19_DEPTO_LOJA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'Depto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667517695772152348)
,p_name=>'P19_DATA_NASC'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'Data Nasc'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667518079366152348)
,p_name=>'P19_RG'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'RG'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667518470702152348)
,p_name=>'P19_UF_RG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'UF/RG'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667518945714152349)
,p_name=>'P19_CART_PROFISSIONAL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'CTPS'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667519289717152349)
,p_name=>'P19_SERIE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>unistr('S\00E9rie')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667519744313152349)
,p_name=>'P19_DATA_ADM'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>unistr('Data Admiss\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667520130180152349)
,p_name=>'P19_FUNCAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>unistr('Fun\00E7ao')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667520484195152350)
,p_name=>'P19_SETOR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>'Setor'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667520918944152350)
,p_name=>'P19_TEMPO_NA_FUNCAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_prompt=>unistr('Tempo na Fun\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667546089663288323)
,p_name=>'P19_EMPRESA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P19_EMPRESA'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667546334612288325)
,p_name=>'P19_CARGO_PROPOSTO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cargo_proposto',
'  from solicitacao_exames a',
' where cod_req = :P19_COD_REQ',
'   and :P19_ROWID IS NULL',
'   and :P19_TIPO_EXAME = ''M'''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Cargo Proposto'
,p_source=>'CARGO_PROPOSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod || '' - '' || nome as d',
'      ,cod',
'  from cargos',
' where dt_term_vig_cargo > sysdate',
' order by cod'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_cMaxlength=>7
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667546391001288326)
,p_name=>'P19_FILIAL_PROPOSTA'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial Proposta'
,p_source=>'FILIAL_PROPOSTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial || '' - '' || nome_filial nome_filial,',
'       cod_filial ',
'  from filiais',
' where cod_empresa = :P19_EMPRESA',
' order by cod_filial'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667546461561288327)
,p_name=>'P19_LOCAL_PRETENDIDO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.local_pretendido',
'  from solicitacao_exames a',
' where cod_req = :P19_COD_REQ',
'   and :P19_ROWID IS NULL',
'   and :P19_TIPO_EXAME = ''M'''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Local Pretendido'
,p_source=>'LOCAL_PRETENDIDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select l.cod_local_trab||'' - ''||initcap(l.descricao)||'' - Pr\00E9dio: ''||l.predio||'' - Bloco: ''||l.bloco||'' - Andar: ''||l.andar||'' - Sala: ''||l.sala descricao, l.cod_local_trab cod'),
'  from cargos_local_trab cl,',
'       local_trab l',
' where cl.cod_local_trab = l.cod_local_trab',
'   and cl.cod_cargo = :P19_CARGO_PROPOSTO',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P19_CARGO_PROPOSTO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667546980531288332)
,p_name=>'P19_PESO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_prompt=>'Peso'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667547068729288333)
,p_name=>'P19_ALTURA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_prompt=>'Altura'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667547251443288334)
,p_name=>'P19_MASSA_CORPOREA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_prompt=>'IMC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667547469084288337)
,p_name=>'P19_PRESSAO_ARTERIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Press\00E3o Arterial')
,p_source=>'PRESSAO_ARTERIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>7
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667547599634288338)
,p_name=>'P19_TEMPERATURA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Temperatura'
,p_source=>'TEMPERATURA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667547745252288339)
,p_name=>'P19_PULSO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166667546944704288331)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Pulso'
,p_source=>'PULSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667548747564288349)
,p_name=>'P19_OD_SO_PERTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_prompt=>'OD'
,p_source=>'OD_SO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667548790263288350)
,p_name=>'P19_OD_SO_LONGE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_source=>'OD_SO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667548941928288351)
,p_name=>'P19_OD_CO_PERTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'OD_CO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_column=>2
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667548991770288352)
,p_name=>'P19_OD_CO_LONGE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'OD_CO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549450885288356)
,p_name=>'P19_OE_SO_PERTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_prompt=>'OE'
,p_source=>'OE_SO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549493173288357)
,p_name=>'P19_OE_SO_LONGE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_source=>'OE_SO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549615187288358)
,p_name=>'P19_OE_CO_PERTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'OE_CO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>5
,p_grid_column=>2
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549718795288359)
,p_name=>'P19_OE_CO_LONGE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'OE_CO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549781872288360)
,p_name=>'P19_AO_OD_SO_PERTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_prompt=>'AO'
,p_source=>'AO_OD_SO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>7
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549861654288361)
,p_name=>'P19_AO_OD_SO_LONGE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166672788494744154323)
,p_use_cache_before_default=>'NO'
,p_source=>'AO_OD_SO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667549999150288362)
,p_name=>'P19_AO_OD_CO_PERTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'AO_OD_CO_PERTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>5
,p_grid_column=>2
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667550139282288363)
,p_name=>'P19_AO_OD_CO_LONGE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166672788626492154324)
,p_use_cache_before_default=>'NO'
,p_source=>'AO_OD_CO_LONGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671295252128347420)
,p_name=>'P19_OUV_DIR_DB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166667550604948288368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'OD'
,p_source=>'OUV_DIR_DB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671295267323347421)
,p_name=>'P19_OUV_ESQ_DB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166667550604948288368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'OE'
,p_source=>'OUV_ESQ_DB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671295600071347424)
,p_name=>'P19_MAO_DIREITA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166672788783502154326)
,p_use_cache_before_default=>'NO'
,p_prompt=>'MD'
,p_source=>'MAO_DIREITA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671295732657347425)
,p_name=>'P19_MAO_ESQUERDA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166672788783502154326)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ME'
,p_source=>'MAO_ESQUERDA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671295801888347426)
,p_name=>'P19_COLUNA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166672788783502154326)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Coluna'
,p_source=>'COLUNA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296111131347429)
,p_name=>'P19_ESPIROMETRIA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166672788923326154327)
,p_use_cache_before_default=>'NO'
,p_source=>'ESPIROMETRIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296165245347430)
,p_name=>'P19_EXAMES_COMPL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166672789135178154329)
,p_use_cache_before_default=>'NO'
,p_source=>'EXAMES_COMPL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>3
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296619249347434)
,p_name=>'P19_RESULT_EXAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Resultado ASO'
,p_source=>'RESULT_EXAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_RESULTADOS_ASO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_resultado || '' - '' || descricao',
'      ,cod_resultado',
'  from resultado',
' where tipo_resultado = ''A''',
' order by cod_resultado'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296720950347435)
,p_name=>'P19_DT_RESULTADO_ASO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dt. Resultado ASO'
,p_source=>'DT_RESULTADO_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296791260347436)
,p_name=>'P19_FEITO_LOJA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Exame Realizado na Empresa'
,p_source=>'FEITO_LOJA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(166663252488110389885)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671296906862347437)
,p_name=>'P19_NUM_ATESTADO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'ASO'
,p_source=>'NUM_ATESTADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>7
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297050550347438)
,p_name=>'P19_COD_PROCEDIMENTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cod Procedimento'
,p_source=>'COD_PROCEDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_PROCEDIMENTO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select lpad(codigo,4,0)||'' - ''||descricao d',
'      ,codigo r',
' from procedimentos_diagnosticos_es',
'order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297110424347439)
,p_name=>'P19_OBS_PROCEDIMENTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Obs. Procedimento'
,p_source=>'OBS_PROCEDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>800
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297217770347440)
,p_name=>'P19_CONDUTA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Conduta'
,p_source=>'CONDUTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>50
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297317455347441)
,p_name=>'P19_VAL_ASO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Validade do ASO'
,p_source=>'VAL_ASO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:6 Meses;1,1 Ano;2,2 anos;3'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297513980347443)
,p_name=>'P19_MEDICO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_source=>'MEDICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297562791347444)
,p_name=>'P19_COD_MEDICO_COORDENADOR'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('M\00E9dico Coordenador')
,p_source=>'COD_MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_prest_serv || '' - '' || a.nome,',
'       a.cod_prest_serv',
'  from prestador_servico a',
' where a.dt_vigencia_fin >= sysdate',
'   and a.tipo_prest_serv = ''1''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>8
,p_grid_column=>1
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297691635347445)
,p_name=>'P19_CRM_MEDICO_COORDENADOR'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CRM Coordenador'
,p_source=>'CRM_MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'readonly'
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>9
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297775538347446)
,p_name=>'P19_END_MEDICO_COORDENADOR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'End. Coordenador'
,p_source=>'END_MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'readonly'
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671297951547347447)
,p_name=>'P19_BAIRRO_MEDICO_COORDENADOR'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bairro Cidade'
,p_source=>'BAIRRO_MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'readonly'
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671298042614347448)
,p_name=>'P19_CEP_MEDICO_COORDENADOR'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(166671296499323347433)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CEP'
,p_source=>'CEP_MEDICO_COORDENADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'readonly'
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166671298501688347453)
,p_name=>'P19_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167309177391571510752)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166672788267709154321)
,p_validation_name=>'Valida P19_RESULT_EXAMES'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P19_COD_PROCEDIMENTO is not null and :P19_RESULT_EXAME is null then ',
'  return false;',
'elsif :P19_COD_PROCEDIMENTO is not null and :P19_RESULT_EXAME is not null then ',
'  return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Favor Preencher o c\00F3digo do Resultado!')
,p_validation_condition=>'SAVE,INSERT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(166671296619249347434)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(166672788377590154322)
,p_validation_name=>'Valida P19_COD_PROCEDIMENTO'
,p_validation_sequence=>20
,p_validation=>'P19_COD_PROCEDIMENTO'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('\00C9 obrigat\00F3rio informar o c\00F3digo do procedimento!')
,p_validation_condition=>'SAVE,INSERT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(166671297050550347438)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667546646292288328)
,p_name=>'AD_PROPOSTOS'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_TIPO_EXAME'
,p_condition_element=>'P19_TIPO_EXAME'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'M'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667546731455288329)
,p_event_id=>wwv_flow_api.id(166667546646292288328)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P19_CARGO_PROPOSTO,P19_FILIAL_PROPOSTA,P19_LOCAL_PRETENDIDO,P19_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667546837617288330)
,p_event_id=>wwv_flow_api.id(166667546646292288328)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P19_CARGO_PROPOSTO,P19_FILIAL_PROPOSTA,P19_LOCAL_PRETENDIDO,P19_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667547302851288335)
,p_name=>'AD_IMC'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_ALTURA,P19_PESO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667547366461288336)
,p_event_id=>wwv_flow_api.id(166667547302851288335)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P19_MASSA_CORPOREA := trunc(:P19_PESO/(:P19_ALTURA*:P19_ALTURA),2);'
,p_attribute_02=>'P19_PESO,P19_ALTURA'
,p_attribute_03=>'P19_MASSA_CORPOREA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166671298138512347449)
,p_name=>'AD_COORDENADOR'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_COD_MEDICO_COORDENADOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166671298230343347450)
,p_event_id=>wwv_flow_api.id(166671298138512347449)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--if :P19_ROWID IS NOT NULL THEN',
'begin',
' ',
'  select a.nr_documento',
'    into :P19_CRM_MEDICO_COORDENADOR',
'    from prestador_servico a,',
'         prestador_responsavel b',
'   where b.cod_empresa    = :P19_EMPRESA',
'     and a.cod_prest_serv = b.cod_prest_serv',
'     and a.cod_prest_serv = :P19_COD_MEDICO_COORDENADOR',
'     and b.cod_filial     = (select filial',
'                               from informacoes_funcionais a',
'                              where a.cod_empresa = b.cod_empresa ',
'                                and a.matricula = :P19_MATRICULA)',
'     and  :P19_DATA_ATUAL between b.dt_inic_vigencia and b.dt_fim_vigencia',
'     and a.tipo_prest_serv = ''1'';',
'',
'    exception',
'      when no_data_found then',
'         null;',
'        --:P19_CRM_MEDICO_COORDENADOR := null;',
'',
'end;',
'',
'--end if;'))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA,P19_COD_MEDICO_COORDENADOR'
,p_attribute_03=>'P19_CRM_MEDICO_COORDENADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166671298301214347451)
,p_event_id=>wwv_flow_api.id(166671298138512347449)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--if :P19_ROWID IS NOT NULL THEN',
'begin',
'',
unistr('  select fil.endereco || '', N\00BA '' || fil.numero,'),
'         fil.bairro || '' - '' || fil.cidade || ''/'' || fil.uf,',
'         lpad(fil.cep,5,''0'') || ''-'' || lpad(fil.complemento_cep,3,''0''),',
'         p.nome,',
'         r.uf_doc_resp',
'    into :P19_END_MEDICO_COORDENADOR,',
'         :P19_BAIRRO_MEDICO_COORDENADOR,',
'         :P19_CEP_MEDICO_COORDENADOR,',
'         :P19_MEDICO_COORDENADOR,',
'         :P19_UF_DOCUMENTO',
'    from prestador_responsavel r,',
'         prestador_servico     p,',
'         filiais_cad           fil,',
'         informacoes_funcionais_cad func',
'   where /*p.cod_empresa_endereco = :P19_EMPRESA',
'     and*/ r.cod_empresa          = :P19_EMPRESA',
'     and r.cod_empresa          = fil.cod_empresa',
'     and r.cod_empresa          = func.cod_empresa',
'     and r.cod_filial           = func.filial',
'     and p.cod_filial_endereco  = fil.cod_filial',
'     and r.coordenador          = ''S''',
'     and p.cod_prest_serv       = r.cod_prest_serv',
'     and p.tipo_prest_serv      = r.tipo_prest_serv',
'     and p.tipo_prest_serv      = ''1''',
'     and func.matricula         = :P19_MATRICULA',
'     and :P19_DATA_ATUAL between r.dt_inic_vigencia',
'                             and r.dt_fim_vigencia; 		',
'                             ',
'     ',
'',
'  exception',
'    when no_data_found then',
'      NULL;',
'   ',
'    --  :P19_END_MEDICO_COORDENADOR    := null;',
'    --  :P19_BAIRRO_MEDICO_COORDENADOR := null;',
'    --  :P19_CEP_MEDICO_COORDENADOR    := null; ',
'',
'end;',
'--end if; ',
'',
'     ',
'    ',
'        '))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA,P19_DATA_ATUAL'
,p_attribute_03=>'P19_END_MEDICO_COORDENADOR,P19_BAIRRO_MEDICO_COORDENADOR,P19_CEP_MEDICO_COORDENADOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166671299749628347465)
,p_name=>'AD_DADOS'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166671299847237347466)
,p_event_id=>wwv_flow_api.id(166671299749628347465)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  select trunc(months_between(sysdate, func.dt_funcao) / 12) || '' anos '' || ',
unistr('         trunc(mod(months_between(sysdate, func.dt_funcao), 12)) || '' m\00EAs(es)''  tempo_na_funcao,'),
'         ccusto.nome setor, ',
'         unid_adm.descricao unid_adm,',
'         pess.num_identidade, ',
'         pess.est_emis_ident,',
'         pess.peso,',
'         pess.altura,',
'         trunc(pess.peso/(pess.altura*pess.altura),2),',
'         pess.num_cart_prof, ',
'         pess.ser_cart_prof || '' - '' || pess.est_emis_prof, ',
'         pess.dt_nasc,',
'         func.dt_admissao, ',
'         funcao.nome funcao_pretendida',
'   into :P19_TEMPO_NA_FUNCAO,',
'        :P19_SETOR,',
'        :P19_DEPTO_LOJA,',
'        :P19_RG, ',
'        :P19_UF_RG,',
'        :P19_PESO,',
'        :P19_ALTURA,',
'        :P19_MASSA_CORPOREA,',
'        :P19_CART_PROFISSIONAL, ',
'        :P19_SERIE,',
'        :P19_DATA_NASC,',
'        :P19_DATA_ADM,',
'        :P19_FUNCAO',
'   from funcao,',
'        centro_de_custo ccusto, ',
'        unidade_administrativa unid_adm,',
'        filiais,',
'        inf_pessoais pess,',
'        informacoes_funcionais func',
'  where func.cod_empresa = pess.cod_empresa',
'    and func.matricula   = pess.matricula',
'    and func.cod_empresa = filiais.cod_empresa',
'    and func.filial      = filiais.cod_filial',
'    and func.cod_empresa = ccusto.cod_empresa',
'    and func.cod_ccusto  = ccusto.cod',
'    and func.cod_empresa = unid_adm.cod_empresa(+)',
'    and func.unidade_adm = unid_adm.cod_unidade_adm(+)',
'    and func.funcao      = funcao.cod',
'    and func.cod_empresa = :P19_EMPRESA',
'    and func.matricula   = :P19_MATRICULA',
'    FETCH FIRST 1 ROWS ONLY;',
'',
'  exception',
'    when no_data_found then',
'   ',
'      null;',
'      ',
'   ',
'   ',
'',
'end;'))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA'
,p_attribute_03=>'P19_TEMPO_NA_FUNCAO,P19_SETOR,P19_DEPTO_LOJA,P19_RG,P19_UF_RG,P19_PESO,P19_ALTURA,P19_MASSA_CORPOREA,P19_CART_PROFISSIONAL,P19_SERIE,P19_DATA_NASC,P19_DATA_ADM,P19_FUNCAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(128561598038816065043)
,p_event_id=>wwv_flow_api.id(166671299749628347465)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   v_cod_empresa_endereco  number;',
'begin',
'if :P19_ROWID IS NULL THEN    ',
'  ',
'      begin      ',
'         select a.cod_prest_serv',
'         into :P19_COD_MEDICO_COORDENADOR',
'         from prestador_servico a, prestador_responsavel b',
'         where b.cod_empresa    = :P19_EMPRESA',
'               and a.cod_prest_serv = b.cod_prest_serv',
'               and b.cod_filial     = (select filial',
'                                       from informacoes_funcionais a',
'                                       where a.cod_empresa = b.cod_empresa ',
'                                       and a.matricula =  :P19_MATRICULA)',
'               and a.tipo_prest_serv = ''1''',
'               and  :P19_DATA_ATUAL between b.dt_inic_vigencia and b.dt_fim_vigencia; ',
'         ',
'      exception',
'      when no_data_found then    ',
'        null;',
'        --:P19_COD_MEDICO_COORDENADOR := null;',
'      end;',
'     ',
'      begin',
'         select a.nr_documento, a.cod_empresa_endereco',
'         into :P19_CRM_MEDICO_COORDENADOR, v_cod_empresa_endereco',
'         from prestador_servico a, prestador_responsavel b',
'         where b.cod_empresa    = :P19_EMPRESA',
'            and a.cod_prest_serv = b.cod_prest_serv',
'            and a.cod_prest_serv = :P19_COD_MEDICO_COORDENADOR',
'            and b.cod_filial     = (select filial',
'                               from informacoes_funcionais a',
'                              where a.cod_empresa = b.cod_empresa ',
'                                and a.matricula = :P19_MATRICULA)',
'            and  :P19_DATA_ATUAL between b.dt_inic_vigencia and b.dt_fim_vigencia',
'            and a.tipo_prest_serv = ''1'';',
'   ',
'      ',
'      exception',
'         when no_data_found then  ',
'            null;',
'        --:P19_CRM_MEDICO_COORDENADOR := null;',
'      end;',
'  ',
'      begin',
'',
unistr('          select fil.endereco || '', N\00BA '' || fil.numero, fil.bairro || '' - '' || fil.cidade || ''/'' || fil.uf, lpad(fil.cep,5,''0'') || ''-'' || lpad(fil.complemento_cep,3,''0''),  p.nome,r.uf_doc_resp'),
'            into :P19_END_MEDICO_COORDENADOR,:P19_BAIRRO_MEDICO_COORDENADOR,:P19_CEP_MEDICO_COORDENADOR, :P19_MEDICO_COORDENADOR, :P19_UF_DOCUMENTO',
'          from prestador_responsavel r,prestador_servico     p, filiais_cad           fil,informacoes_funcionais_cad func',
'         where /*p.cod_empresa_endereco = v_cod_empresa_endereco--:P19_EMPRESA',
'           and */ r.cod_empresa          = :P19_EMPRESA',
'           and r.cod_empresa          = fil.cod_empresa',
'           and r.cod_empresa          = func.cod_empresa',
'           and r.cod_filial           = func.filial',
'           and p.cod_filial_endereco  = fil.cod_filial',
'           and r.coordenador          = ''S''',
'           and p.cod_prest_serv       = r.cod_prest_serv',
'           and p.tipo_prest_serv      = r.tipo_prest_serv',
'           and p.tipo_prest_serv      = ''1''',
'           and func.matricula         = :P19_MATRICULA',
'           and :P19_DATA_ATUAL between r.dt_inic_vigencia and r.dt_fim_vigencia; 			',
'',
'        exception',
'          when no_data_found then',
'            null;',
'            --:P19_END_MEDICO_COORDENADOR    := null;',
'            --:P19_BAIRRO_MEDICO_COORDENADOR := null;',
'            --:P19_CEP_MEDICO_COORDENADOR    := null;',
'',
'        end; ',
'  ',
'  ',
'   end if;',
'end;',
'',
' '))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA,P19_DATA_ATUAL'
,p_attribute_03=>'P19_COD_MEDICO_COORDENADOR,P19_CRM_MEDICO_COORDENADOR,P19_END_MEDICO_COORDENADOR,P19_BAIRRO_MEDICO_COORDENADOR,P19_CEP_MEDICO_COORDENADOR, P19_MEDICO_COORDENADOR, P19_UF_DOCUMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166678210121413051546)
,p_name=>unistr('Relat\00F3rio ASO')
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166678209984276051545)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166678210192107051547)
,p_event_id=>wwv_flow_api.id(166678210121413051546)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166678209984276051545)
,p_attribute_01=>'RP10394'
,p_attribute_02=>'ASO.PDF'
,p_attribute_03=>'inline'
,p_attribute_05=>'P19_EMPRESA,P19_MATRICULA,P19_DT_RESULTADO_ASO,P_USUARIO,P19_TIPO_EXAME'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return ''P_Data_Fim=''    ||to_char(to_date(:P19_DT_RESULTADO_ASO,''DD/MM/RRRR''),''DD/MM/RRRR'')||',
'       ''&P_Data_Ini=''   ||to_char(to_date(:P19_DT_RESULTADO_ASO,''DD/MM/RRRR''),''DD/MM/RRRR'')||',
'       ''&P_Empresa=''    ||to_char(:P19_EMPRESA)||',
'       ''&P_Filial_Fim='' ||to_char(''9999'')||',
'       ''&P_Filial_Ini='' ||to_char(''1'')||',
'       ''&P_Mat_Fim=''    ||to_char(:P19_MATRICULA)||',
'       ''&P_Mat_Ini=''    ||to_char(:P19_MATRICULA)||',
'       ''&P_Tipo_Exame='' ||to_char(:P19_TIPO_EXAME)||',
'       ''&P_Usuario=''    ||to_char(:P_USUARIO);',
'',
''))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(130465423372568049233)
,p_name=>'Popula P19_ORIGEM'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_MEDICO_AUX'
,p_condition_element=>'P19_MEDICO_AUX'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130465423522432049234)
,p_event_id=>wwv_flow_api.id(130465423372568049233)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P19_ORIGEM_MED := SUBSTR(:P19_MEDICO_AUX,1,2);',
'END;'))
,p_attribute_02=>'P19_MEDICO_AUX'
,p_attribute_03=>'P19_ORIGEM_MED'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130465423611561049235)
,p_event_id=>wwv_flow_api.id(130465423372568049233)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P19_ORIGEM_MED := NULL;',
'END;'))
,p_attribute_03=>'P19_ORIGEM_MED'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130465424112466049240)
,p_event_id=>wwv_flow_api.id(130465423372568049233)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P19_ORIGEM_MED := SUBSTR(:P19_MEDICO_AUX,1,2);',
'  :P19_MEDICO := SUBSTR(:P19_MEDICO_AUX,3);',
'END;'))
,p_attribute_02=>'P19_MEDICO_AUX'
,p_attribute_03=>'P19_ORIGEM_MED,P19_MEDICO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130465424177944049241)
,p_event_id=>wwv_flow_api.id(130465423372568049233)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P19_ORIGEM_MED := NULL;',
'END;'))
,p_attribute_03=>'P19_ORIGEM_MED'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(130465424424370049243)
,p_name=>'Popula P19_MEDICO_AUX'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P19_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130465424478675049244)
,p_event_id=>wwv_flow_api.id(130465424424370049243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VORIGEM VARCHAR2(2);',
'BEGIN',
'  BEGIN',
'    SELECT ORIGEM||COD',
'    INTO   :P19_MEDICO_AUX',
'    FROM   VW_MEDICOS',
'    WHERE  ROWNUM = 1',
'    AND COD = :P19_MEDICO;',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      :P19_MEDICO_AUX := NULL;',
'  END;',
'END;'))
,p_attribute_02=>'P19_MEDICO'
,p_attribute_03=>'P19_MEDICO_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126327074646455818215)
,p_name=>'Carrega dados medico'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126327074768235818216)
,p_event_id=>wwv_flow_api.id(126327074646455818215)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    ',
'  :P19_USUARIO := :P_USUARIO;  ',
'    ',
unistr('  select p.cod_prest_serv,p.nr_documento,fil.endereco || '', N\00BA '' || fil.numero,'),
'         fil.bairro || '' - '' || fil.cidade || ''/'' || fil.uf,',
'         lpad(fil.cep,5,''0'') || ''-'' || lpad(fil.complemento_cep,3,''0''),',
'         p.nome,',
'         r.uf_doc_resp',
'    into :P19_COD_MEDICO_COORDENADOR,',
'         :P19_CRM_MEDICO_COORDENADOR,',
'         :P19_END_MEDICO_COORDENADOR,',
'         :P19_BAIRRO_MEDICO_COORDENADOR,',
'         :P19_CEP_MEDICO_COORDENADOR,',
'         :P19_MEDICO_COORDENADOR,',
'         :P19_UF_DOCUMENTO',
'    from prestador_responsavel r,',
'         prestador_servico     p,',
'         filiais_cad           fil,',
'         informacoes_funcionais_cad func',
'   where r.cod_empresa          = :P19_EMPRESA',
'     and r.cod_empresa          = fil.cod_empresa',
'     and r.cod_empresa          = func.cod_empresa',
'     and r.cod_filial           = func.filial',
'     and p.cod_filial_endereco  = fil.cod_filial',
'     and r.coordenador          = ''S''',
'     and p.cod_prest_serv       = r.cod_prest_serv',
'     and p.tipo_prest_serv      = r.tipo_prest_serv',
'     and p.tipo_prest_serv      = ''1''',
'     and func.matricula         = :P19_MATRICULA',
'     and :P19_DATA_ATUAL between r.dt_inic_vigencia',
'                             and r.dt_fim_vigencia; 		',
'                             ',
'',
'  exception',
'    when no_data_found then',
'      NULL;',
'   ',
'    --  :P19_END_MEDICO_COORDENADOR    := null;',
'    --  :P19_BAIRRO_MEDICO_COORDENADOR := null;',
'    --  :P19_CEP_MEDICO_COORDENADOR    := null; ',
'',
'end;'))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA,P19_DATA_ATUAL,P_USUARIO'
,p_attribute_03=>'P19_CRM_MEDICO_COORDENADOR,,P19_END_MEDICO_COORDENADOR,P19_BAIRRO_MEDICO_COORDENADOR,P19_CEP_MEDICO_COORDENADOR,P19_COD_MEDICO_COORDENADOR,P19_USUARIO,P19_MEDICO_COORDENADOR,P19_UF_DOCUMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(87716556246261572049)
,p_name=>'Insere MT_CHAMADA_PACIENTE_STATUS'
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(87716555987008570567)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716556549002572051)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    INSERT INTO MT_CHAMADA_PACIENTE_STATUS ',
'    (SELECT COD_EMPRESA, MATRICULA, COD_CANDIDATO, DATA, SEQ, SENHA, ''I'', NULL, SYSDATE, OBSERVACAO, :P_USUARIO, SYSDATE, FLAG',
'      FROM MT_CHAMADA_PACIENTE_STATUS S',
'     WHERE S.STATUS = ''P''',
'       AND S.DATA_STATUS = (SELECT MAX(X.DATA_STATUS)',
'                              FROM MT_CHAMADA_PACIENTE_STATUS X',
'                             WHERE X.COD_EMPRESA = :P19_EMPRESA',
'                               AND (X.MATRICULA = :P19_MATRICULA',
'                                OR X.COD_CANDIDATO = :P19_MATRICULA)',
'                               AND DATA = TO_DATE(:P19_DATA_ATUAL,''DD/MM/RRRR'')));',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    NULL;',
'END;    '))
,p_attribute_02=>'P19_EMPRESA,P19_MATRICULA,P19_DATA_ATUAL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716557070822572052)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(87716555987008570567)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812900150144189)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P19_TIPO_EXAME'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716557612280572052)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#complementares'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716558138792572052)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#adicionais'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716558554104572052)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#wecker'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812962422144190)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166678209984276051545)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707813098465144191)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671300060607347469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707813222660144192)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671299372052347462)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707813405780144194)
,p_event_id=>wwv_flow_api.id(87716556246261572049)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671298901125347457)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(87716568681500600196)
,p_name=>'Disable Tabs'
,p_event_sequence=>120
,p_condition_element=>'P19_PRE_ATEND'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812846643144188)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P19_TIPO_EXAME'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716569084627600196)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#complementares'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716569615864600197)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#adicionais'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87716570105190600197)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#wecker'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812430528144184)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166678209984276051545)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812485724144185)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671300060607347469)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707812644453144186)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671299372052347462)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87707813311031144193)
,p_event_id=>wwv_flow_api.id(87716568681500600196)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166671298901125347457)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166671298694004347455)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Row Fetch MT_EXAME_PERIODICO'
,p_attribute_02=>'MT_EXAME_PERIODICO'
,p_attribute_03=>'P19_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166667545989100288322)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'AD_DADOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  begin',
'',
'      select trunc(months_between(sysdate, func.dt_funcao) / 12) || '' anos '' || ',
unistr('             trunc(mod(months_between(sysdate, func.dt_funcao), 12)) || '' m\00EAs(es)''  tempo_na_funcao,'),
'             ccusto.nome setor, ',
'             unid_adm.descricao unid_adm,',
'             pess.num_identidade, ',
'             pess.est_emis_ident,',
'             pess.peso,',
'             pess.altura,',
'             trunc(pess.peso/(pess.altura*pess.altura),2),',
'             pess.num_cart_prof, ',
'             pess.ser_cart_prof || '' - '' || pess.est_emis_prof, ',
'             pess.dt_nasc,',
'             func.dt_admissao, ',
'             funcao.nome funcao_pretendida',
'       into :P19_TEMPO_NA_FUNCAO,',
'            :P19_SETOR,',
'            :P19_DEPTO_LOJA,',
'            :P19_RG, ',
'            :P19_UF_RG,',
'            :P19_PESO,',
'            :P19_ALTURA,',
'            :P19_MASSA_CORPOREA,',
'            :P19_CART_PROFISSIONAL, ',
'            :P19_SERIE,',
'            :P19_DATA_NASC,',
'            :P19_DATA_ADM,',
'            :P19_FUNCAO',
'       from funcao,',
'            centro_de_custo ccusto, ',
'            unidade_administrativa unid_adm,',
'            filiais,',
'            inf_pessoais pess,',
'            informacoes_funcionais func',
'      where func.cod_empresa = pess.cod_empresa',
'        and func.matricula   = pess.matricula',
'        and func.cod_empresa = filiais.cod_empresa',
'        and func.filial      = filiais.cod_filial',
'        and func.cod_empresa = ccusto.cod_empresa',
'        and func.cod_ccusto  = ccusto.cod',
'        and func.cod_empresa = unid_adm.cod_empresa',
'        and func.unidade_adm = unid_adm.cod_unidade_adm',
'        and func.funcao      = funcao.cod',
'        and func.cod_empresa = :P19_EMPRESA',
'        and func.matricula   = :P19_MATRICULA',
'        FETCH FIRST 1 ROWS ONLY;',
'',
'      exception',
'        when no_data_found then',
'          null;',
'        when others then',
'          raise_application_error(-20001,''Erro ao encontrar dados: '' || SQLERRM);',
'',
'  end;',
'',
'  begin',
'',
'    select peso',
'          ,altura',
'      into :P19_PESO',
'          ,:P19_ALTURA',
'      from inf_pessoais',
'	   where cod_empresa = :P19_EMPRESA',
'	     and matricula   = :P19_MATRICULA;',
'',
'    exception',
'      when no_data_found then',
'        null;',
'      when others then',
'          raise_application_error(-20002,''Erro ao encontrar dados: '' || SQLERRM);',
'',
'  end;',
'',
'  DECLARE',
'    VORIGEM VARCHAR2(2);',
'  BEGIN',
'    BEGIN',
'      SELECT ORIGEM||COD',
'        INTO :P19_MEDICO_AUX',
'        FROM VW_CONSULTA_MEDICOS',
'       WHERE COD = :P19_MEDICO',
'         AND ORIGEM = :P19_ORIGEM_MED;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        :P19_MEDICO_AUX := NULL;',
'    END;',
'  END;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(87707813454816144195)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Atendimento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT ''S''',
'  INTO :P19_PRE_ATEND',
'  FROM PRE_ATENDIMENTO W,',
'       MT_CHAMADA_PACIENTE C,',
'       MT_CHAMADA_PACIENTE_STATUS S',
' WHERE C.COD_EMPRESA = W.COD_EMPRESA',
'   AND (C.MATRICULA = W.COD_PACIENTE',
'    OR C.COD_CANDIDATO = W.COD_PACIENTE)',
'   AND C.DATA = W.DATA_AGENDA',
'   AND C.COD_EMPRESA = S.COD_EMPRESA',
'   AND (C.MATRICULA = S.MATRICULA',
'    OR C.COD_CANDIDATO = S.COD_CANDIDATO)',
'   AND C.SENHA = S.SENHA',
'   AND C.SEQ = S.SEQ',
'   AND C.DATA = S.DATA',
'   AND S.STATUS in (''P'')',
'   AND S.DATA_STATUS = (SELECT MAX(X.DATA_STATUS)',
'                          FROM MT_CHAMADA_PACIENTE_STATUS X',
'                         WHERE X.COD_EMPRESA = C.COD_EMPRESA',
'                           AND (X.MATRICULA = C.MATRICULA',
'                            OR X.COD_CANDIDATO = C.COD_CANDIDATO)',
'                           AND X.SENHA = C.SENHA',
'                           AND X.SEQ = C.SEQ',
'                           AND X.DATA = C.DATA)',
'   AND W.COD_EMPRESA = :P19_EMPRESA',
'   AND W.DATA_AGENDA = TO_DATE(:P19_DATA_ATUAL,''DD/MM/RRRR'')',
'   AND W.COD_PACIENTE = :P19_MATRICULA;',
'EXCEPTION WHEN OTHERS THEN',
'  NULL;',
'END;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166671299920260347467)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPDATE INF_PESSOAIS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :P19_PESO is not null then',
'',
'    begin',
'        update inf_pessoais',
'           set peso = :P19_PESO',
'         where cod_empresa = :P19_EMPRESA',
'           and matricula   = :P19_MATRICULA;',
'',
'    exception',
'      when others then',
'        raise_application_error(-20001,''Erro ao atualizar peso: '' || SQLERRM);',
'',
'    end;',
'',
'  end if;',
'',
'  if :P19_ALTURA is not null then',
'',
'    begin',
'        update inf_pessoais',
'           set altura = :P19_ALTURA',
'         where cod_empresa = :P19_EMPRESA',
'           and matricula   = :P19_MATRICULA;',
'',
'    exception',
'      when others then',
'        raise_application_error(-20001,''Erro ao atualizar altura: '' || SQLERRM);',
'',
'    end;',
'',
'  end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166671298901125347457)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166671298971032347458)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Row Process MT_EXAME_PERIODICO'
,p_attribute_02=>'MT_EXAME_PERIODICO'
,p_attribute_03=>'P19_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(92959053112098988661)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Realizou Consulta'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update AGENDAS_MEDICOS_HORARIOS',
'   set realizou = ''S'',',
'       compareceu = ''S''',
' where cod_paciente = :P19_MATRICULA',
'   and data_agenda = TO_DATE(:P19_DATA_ATUAL,''DD/MM/RRRR'')',
'   and cod_empresa = :P19_EMPRESA;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'INSERT,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166691430053624452120)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_cod_prest_serv_coord prestador_responsavel.cod_prest_serv%type;',
'  l_num_atestado         mt_exame_periodico.num_atestado%type;',
'  l_mt_exame_periodico   mt_exame_periodico%rowtype;',
'begin',
'--raise_application_error(-20001, ''a'' || :P19_TIPO_EXAME || ''b'');',
'  select rowid',
'    into :P19_ROWID',
'    from mt_exame_periodico',
'   where empresa    = :P19_EMPRESA',
'     and matricula  = :P19_MATRICULA',
'     and tipo_exame = nvl(:P19_TIPO_EXAME,''P'')',
'     and data_atual = to_date(:P19_DATA_ATUAL, ''dd/mm/yyyy'');',
'exception when no_data_found then -- Tenta carregar ultimo ainda nao finalizado',
'  begin',
'    select rowid',
'      into :P19_ROWID',
'      from mt_exame_periodico a',
'     where a.empresa    = :P19_EMPRESA',
'       and a.matricula  = :P19_MATRICULA',
'       and a.tipo_exame = NVL(:P19_TIPO_EXAME,''P'')',
'       and a.data_atual = (',
'         select max(data_atual)',
'             from mt_exame_periodico b',
'          where b.empresa    = :P19_EMPRESA',
'            and b.matricula  = :P19_MATRICULA',
'            and b.tipo_exame = NVL(:P19_TIPO_EXAME,''P'')',
'       )',
'       and a.result_exame is null;',
'  exception when no_data_found then -- Cria novo exame',
'    l_mt_exame_periodico.num_atestado := seq_mt_exm_per_num_atestado.nextval;',
'    l_mt_exame_periodico.usuario      := :P_USUARIO;',
'    l_mt_exame_periodico.data_atual   := to_date(:P19_DATA_ATUAL, ''dd/mm/yyyy'');',
'    l_mt_exame_periodico.medico       := NVL(SUBSTR(:P19_MEDICO_AUX,3),:P19_MEDICO);',
'    l_mt_exame_periodico.origem_med   := :P19_ORIGEM;',
'    l_mt_exame_periodico.tipo_exame   := NVL(:P19_TIPO_EXAME,''P'');',
'    l_mt_exame_periodico.feito_loja   := ''S'';',
'    l_mt_exame_periodico.matricula    := :P19_MATRICULA;',
'    l_mt_exame_periodico.empresa      := :P19_EMPRESA;',
'',
unistr('    -- Carrega m\00E9dico coordenador'),
'    begin',
'      Select R.Cod_Prest_Serv,',
'             p.nome,',
'             p.nr_documento,',
unistr('             f.ENDERECO||'', N\00BA ''||f.NUMERO as endereco,'),
'             f.BAIRRO||'' - ''||f.Cidade||''/''||f.UF as bairro,',
'             LPAD(f.CEP,5,''0'')||''-''||LPAD(f.COMPLEMENTO_CEP,3,''0'') cep,',
'             (SELECT ORIGEM',
'              FROM   VW_MEDICOS',
'              WHERE  ROWNUM = 1',
'              AND    COD = :P19_MEDICO) origem',
'        Into l_mt_exame_periodico.cod_medico_coordenador,',
'             l_mt_exame_periodico.medico_coordenador,',
'             l_mt_exame_periodico.crm_medico_coordenador,',
'             l_mt_exame_periodico.end_medico_coordenador,',
'             l_mt_exame_periodico.bairro_medico_coordenador,',
'             l_mt_exame_periodico.cep_medico_coordenador,',
'             l_mt_exame_periodico.origem_med',
'        From Informacoes_funcionais I,',
'             Prestador_responsavel  R,',
'             Prestador_Servico      P,',
'             Filiais_cad            f',
'       Where I.Cod_Empresa     = :P19_EMPRESA',
'         And I.Matricula       = :P19_MATRICULA',
'         And R.Cod_Empresa     = I.Cod_Empresa',
'         And R.Cod_Filial      = I.Filial',
'         And P.Cod_Prest_Serv  = R.Cod_Prest_Serv',
'         AND R.Cod_Empresa         = f.Cod_Empresa',
'         AND P.Cod_Filial_Endereco = f.Cod_Filial',
'         And P.Tipo_Prest_Serv = ''1''',
'         And R.Coordenador     = ''S''',
'         And P.Dt_Vigencia_Fin > Sysdate;',
'    exception when others then null;',
'    end;',
' ',
'  end;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P19_MATRICULA'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_comment=>unistr('Substitu\00EDdo :P19_TIPO_EXAME por NVL(:P19_TIPO_EXAME,''P'')')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(87707813615758144196)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Atendimento_'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT ''S''',
'  INTO :P19_PRE_ATEND',
'  FROM PRE_ATENDIMENTO W,',
'       MT_CHAMADA_PACIENTE C,',
'       MT_CHAMADA_PACIENTE_STATUS S',
' WHERE C.COD_EMPRESA = W.COD_EMPRESA',
'   AND (C.MATRICULA = W.COD_PACIENTE',
'    OR C.COD_CANDIDATO = W.COD_PACIENTE)',
'   AND C.DATA = W.DATA_AGENDA',
'   AND C.COD_EMPRESA = S.COD_EMPRESA',
'   AND (C.MATRICULA = S.MATRICULA',
'    OR C.COD_CANDIDATO = S.COD_CANDIDATO)',
'   AND C.SENHA = S.SENHA',
'   AND C.SEQ = S.SEQ',
'   AND C.DATA = S.DATA',
'   AND S.STATUS in (''P'')',
'   AND S.DATA_STATUS = (SELECT MAX(X.DATA_STATUS)',
'                          FROM MT_CHAMADA_PACIENTE_STATUS X',
'                         WHERE X.COD_EMPRESA = C.COD_EMPRESA',
'                           AND (X.MATRICULA = C.MATRICULA',
'                            OR X.COD_CANDIDATO = C.COD_CANDIDATO)',
'                           AND X.SENHA = C.SENHA',
'                           AND X.SEQ = C.SEQ',
'                           AND X.DATA = C.DATA)',
'   AND W.COD_EMPRESA = :P19_EMPRESA',
'   AND W.DATA_AGENDA = TO_DATE(:P19_DATA_ATUAL,''DD/MM/RRRR'')',
'   AND W.COD_PACIENTE = :P19_MATRICULA;',
'EXCEPTION WHEN NO_DATA_FOUND THEN',
'  :P19_PRE_ATEND := NULL;',
'END;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'INSERT,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(73054379708319033896)
,p_process_sequence=>20
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Informa\00E7\00F5es Funcionais')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT CARGO, FUNCAO, COD_LOCALIZACAO, FILIAL',
'  INTO :P19_COD_CARGO_EPOCA, :P19_COD_FUNCAO_EPOCA, :P19_COD_LOCAL_EPOCA, :P19_COD_FILIAL_EPOCA',
'  FROM INFORMACOES_FUNCIONAIS',
' WHERE COD_EMPRESA = :P19_EMPRESA',
'   AND MATRICULA = :P19_MATRICULA;',
'EXCEPTION WHEN NO_DATA_FOUND THEN',
'  NULL;',
'END;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'INSERT'
,p_process_when_type=>'REQUEST_IN_CONDITION'
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
