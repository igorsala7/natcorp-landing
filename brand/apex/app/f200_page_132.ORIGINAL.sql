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
,p_default_id_offset=>784797347607055121
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 200 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     200
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   01:01 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 132
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00132
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>132);
end;
/
prompt --application/pages/page_00132
begin
wwv_flow_api.create_page(
 p_id=>132
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Dependentes')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Dependentes')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#jquery.maskedinput.min.js',
'#WORKSPACE_IMAGES#forms-functions.js',
'#WORKSPACE_IMAGES#jquery.maskMoney.min.js'))
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(function() {',
'  ',
'        $.mask.definitions[''~''] = "[+-]";                       ',
'       // $("#P34_DT_VACINA").mask(''99/99/9999'');',
'       // $("#P34_DT_VACINA").attr("type", "tel");',
'  ',
'       $("#P132_NUM_CPF_CONJUGE_DISPLAY").attr("type", "tel");',
'       $("#P132_NUM_CPF_CONJUGE_DISPLAY").mask(''999.999.999-99'', {reverse: true});',
'    ',
'       $("#P132_CPF_MAE_DEPEND_DISPLAY").attr("type", "tel");',
'       $("#P132_CPF_MAE_DEPEND_DISPLAY").mask(''999.999.999-99'', {reverse: true});',
'    ',
'       $("#P132_DECL_NASC_VIVOS_DISPLAY").mask(''99-99999999-9'', {reverse: true});',
'',
'   //  $("#P34_CUSTO_VACINA").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'    /*$("#VALOR_BENEFICIO").maskMoney({showSymbol:true, symbol:"R$", allowNegative: true, thousands:''.'', decimal:'','', affixesStay: false});*/',
'  //  }',
'  });'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'YLEM.ARNALDO'
,p_last_upd_yyyymmddhh24miss=>'20250717171458'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(267432760700166930776)
,p_name=>'Documentos'
,p_region_name=>'UPLOAD_DOCS'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>3
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(s.descricao) Desc_Tipo_Sub_Item,',
'       NVL(u.cod_sub_item,0) cod_sub_item,',
'       u.seq_item,',
'       INITCAP(t.descricao)||'' ''||U.DESCRICAO||'' ''||U.DATA_ARQUIVO documento,',
'       u.dt_atualizacao,',
'       '' - '' VISUALIZAR,',
'       NULL obrig_candidato,',
'       U.TIPO_ARQUIVO,',
'       u.tipo_sub_item,',
'       U.COD_EMPRESA,',
'       U.COD_ITEM MATRICULA,',
'       apex_page.get_url (',
'            p_application => :APP_ID,',
'            p_page        => 864,',
'            p_request     => 132,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_SUB_ITEM,P864_TIPO_ARQUIVO,P864_TIPO_COD_ITEM,P864_SEQ_ITEM,P864_COD_SUB_ITEM,P864_SEQ,P864_COD_REQ,P864_REQUEST'',',
'            p_values      => u.COD_EMPRESA||'',''||u.cod_item||'',''||u.tipo_sub_item||'',''||U.TIPO_ARQUIVO||'',''||''COLABORADOR''||'',''||U.SEQ_ITEM||'',''||U.COD_SUB_ITEM||'',''||U.SEQ||'',''||U.COD_REQ||'',''||132,',
'            p_clear_cache => 864) editar',
'  FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
' WHERE u.tipo_arquivo = t.cod',
'   AND u.tipo_sub_item = s.cod',
'   AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'   and u.tipo_sub_item = 1',
'   AND u.cod_empresa   = :p132_cod_empresa',
'   AND u.cod_item      = :p132_matricula',
'   AND u.tipo_cod_item = ''COLABORADOR''',
'   /*',
'   AND ((u.seq = :p132_seq                and not exists (select 1 from dependentes_temp where cod_requisicao = :p132_cod_requisicao)) or ',
'        (u.cod_req = :p132_cod_requisicao and     exists (select 1 from dependentes_temp where cod_requisicao = :p132_cod_requisicao)))',
'   */',
'   AND ((:p132_seq is not null and u.seq = :p132_seq) or (:p132_seq is null and u.cod_req = :p132_cod_requisicao))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P132_COD_REQUISICAO,P132_SEQ,P132_COD_EMPRESA,P132_MATRICULA'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Documento Anexado'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175283945110836757)
,p_query_column_id=>1
,p_column_alias=>'DESC_TIPO_SUB_ITEM'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175284336343836758)
,p_query_column_id=>2
,p_column_alias=>'COD_SUB_ITEM'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175284786365836758)
,p_query_column_id=>3
,p_column_alias=>'SEQ_ITEM'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175285205025836759)
,p_query_column_id=>4
,p_column_alias=>'DOCUMENTO'
,p_column_display_sequence=>3
,p_column_heading=>'Documento'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175285519769836759)
,p_query_column_id=>5
,p_column_alias=>'DT_ATUALIZACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175285957573836759)
,p_query_column_id=>6
,p_column_alias=>'VISUALIZAR'
,p_column_display_sequence=>1
,p_column_heading=>'Visualizar'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:862:&SESSION.::&DEBUG.:RP,862:P862_COD_EMPRESA,P862_COD_ITEM,P862_SEQ_ITEM,P862_TIPO_ARQUIVO,P862_TIPO_SUB_ITEM,P862_TIPO_COD_ITEM:#COD_EMPRESA#,#MATRICULA#,#SEQ_ITEM#,#TIPO_ARQUIVO#,#TIPO_SUB_ITEM#,COLABORADOR'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_display_when_cond_type=>'NEVER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175286330429836760)
,p_query_column_id=>7
,p_column_alias=>'OBRIG_CANDIDATO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175286805309836760)
,p_query_column_id=>8
,p_column_alias=>'TIPO_ARQUIVO'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175287198958836760)
,p_query_column_id=>9
,p_column_alias=>'TIPO_SUB_ITEM'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175287566534836761)
,p_query_column_id=>10
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175287935986836761)
,p_query_column_id=>11
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>12
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(254175288388230836761)
,p_query_column_id=>12
,p_column_alias=>'EDITAR'
,p_column_display_sequence=>2
,p_column_heading=>'Editar'
,p_use_as_row_header=>'N'
,p_column_link=>'#EDITAR#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil-alt.png" class="apex-edit-pencil-alt" alt="">'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960259492047549082)
,p_plug_name=>'&P132_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960265110174549087)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960269029894549090)
,p_plug_name=>'Dados do Dependente'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960287914510549103)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960289504261549106)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(276960287914510549103)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P132_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(276960290226901549107)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(276960287914510549103)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P132_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175289915149836770)
,p_button_sequence=>190
,p_button_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_button_name=>'p132_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P76 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P_EMPRESA_USER.,&P_MATRICULA_USER.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175295766168836776)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:131:&SESSION.::&DEBUG.:::'
,p_button_condition=>'DEPENDENTE'
,p_button_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175296163334836777)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:22:&SESSION.::&DEBUG.:::'
,p_button_condition=>'DEPENDENTE'
,p_button_condition_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175296593788836777)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P132_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175296999545836777)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P132_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175297379165836778)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>unistr('javascript:apex.confirm(''Deseja apagar esta requisi\00E7\00E3o?'',''DELETE'');')
,p_button_execute_validations=>'N'
,p_button_condition=>'P132_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175288759203836763)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(267432760700166930776)
,p_button_name=>'ANEXO'
,p_button_static_id=>'BTN_ANEXO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anexar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paperclip'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254175320725873836801)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(276960287914510549103)
,p_button_name=>'p132_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P132_COD_EMPRESA.,&P132_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(254175375907509836854)
,p_branch_name=>'Go To Page 131'
,p_branch_action=>'f?p=&APP_ID.:131:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(79821413749850685013)
,p_name=>'P132_CLASS_TRAB_ESTRANG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Classif. Estrangeiro'
,p_source=>'CLASS_TRAB_ESTRANG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC(,):Refugiado1Solicitante de ref\00FAgio2Perman\00EAncia no Brasil em raz\00E3o de reuni\00E3o familiar3Beneficiado pelo acordo entre pa\00EDses do Mercosul4Dependente de agente diplom\00E1tico e/ou consular de5Beneficiado pelo Tratado de Amizade, Coopera\00E7')
||unistr('\00E3o e6Outra condi\00E7\00E3o7')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(106922456418853800539)
,p_name=>'P132_DESC_VL_PL_MEDICO'
,p_is_required=>true
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Desconta Plano M\00E9dico')
,p_source=>'DESC_VL_PL_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(106922456565932800540)
,p_name=>'P132_DESC_VL_PL_ODONTO'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Desconta Plano Odontol\00F3gico')
,p_source=>'DESC_VL_PL_ODONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(108275418090354333706)
,p_name=>'P132_DTLAUDO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Laudo'
,p_source=>'DTLAUDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(245778375520897581394)
,p_name=>'P132_IDADE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175289131121836766)
,p_name=>'P132_URL_DOCS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(267432760700166930776)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175290273916836771)
,p_name=>'P132_TITULO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175290651207836771)
,p_name=>'P132_COD_PROPOSTA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175291019064836772)
,p_name=>'P132_DC_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dc Matricula'
,p_source=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175291503251836772)
,p_name=>'P132_FLAG_KNEXTITEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175291861586836772)
,p_name=>'P132_MENSAGEM_KNEXTITEM'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175292255221836773)
,p_name=>'P132_USUARIO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Usuario'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175292699057836773)
,p_name=>'P132_COD_REQUISICAO'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175293078896836773)
,p_name=>'P132_DATA_REQUISICAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Requisi\00E7\00E3o')
,p_source=>'DATA_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175293419554836774)
,p_name=>'P132_SOLICITANTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175293822514836774)
,p_name=>'P132_DT_ATUALIZACAO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dt Atualizacao'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175294292988836774)
,p_name=>'P132_COD_EMP_SOLICITANTE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175294617289836775)
,p_name=>'P132_MAT_SOLICITANTE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175295056614836775)
,p_name=>'P132_COD_REQ_ANT'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(276960259492047549082)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175297764350836778)
,p_name=>'P132_SEQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175298147063836779)
,p_name=>'P132_ITEM_VALIDACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175298564599836779)
,p_name=>'P132_OK'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175298967024836779)
,p_name=>'P132_FLAG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175299369896836779)
,p_name=>'P132_MENSAGEM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(276960265110174549087)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175300098306836780)
,p_name=>'P132_DES_INCID_IR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175300487279836781)
,p_name=>'P132_DES_INCID_SF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175300846596836781)
,p_name=>'P132_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175301279448836781)
,p_name=>'P132_NUM_DEPEND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dependente'
,p_source=>'NUM_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(Nome_Depend) nome, num_depend',
'  from dependentes',
' where cod_empresa = :p132_cod_empresa',
'   and matricula = :p132_matricula',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Novo Dependente -'
,p_lov_cascade_parent_items=>'P132_COD_EMPRESA,P132_MATRICULA'
,p_ajax_items_to_submit=>'P132_COD_EMPRESA,P132_MATRICULA'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175301627886836783)
,p_name=>'P132_EXCLUIR_DEPENDENTE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>'Excluir dependente'
,p_source=>'EXCLUIR_DEPENDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175302115173836783)
,p_name=>'P132_NOME_DEPEND'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nome'
,p_source=>'NOME_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175302419528836784)
,p_name=>'P132_CONDICAO_DEPEND'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Condi\00E7\00E3o')
,p_source=>'CONDICAO_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Normal;N,Inv\00E1lido;I,Universit\00E1rio;U')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175302897102836784)
,p_name=>'P132_SEXO_DEPEND'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Sexo'
,p_source=>'SEXO_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Feminino;F,Masculino;M'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175303273725836784)
,p_name=>'P132_GRAU_PARENTESCO'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Grau de Parentesco'
,p_source=>'GRAU_PARENTESCO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRICAO, COD',
'  FROM GRAU_PARENTESCO',
' WHERE ((:P132_SEXO_DEPEND IS NULL)',
'     OR (:P132_SEXO_DEPEND = ''M'' AND SUBSTR(COD,2,1) IN (''I'',''O'',''T'',''U''))',
'     OR (:P132_SEXO_DEPEND = ''F'' AND SUBSTR(COD,2,1) IN (''A'',''T'',''U'')))',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P132_SEXO_DEPEND'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175303629265836785)
,p_name=>'P132_DT_DEPENDENTE'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Inclus\00E3o Folha')
,p_source=>'DT_DEPENDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175304072697836785)
,p_name=>'P132_DT_NASC'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Nascimento'
,p_source=>'DT_NASC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175304465009836785)
,p_name=>'P132_CIDADE_NASC'
,p_is_required=>true
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cidade de Nascimento'
,p_source=>'CIDADE_NASC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175304875411836786)
,p_name=>'P132_EST_NASC'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'UF'
,p_source=>'EST_NASC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT SIGLA cod, SIGLA nome FROM UF ORDER BY 1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175305240975836786)
,p_name=>'P132_PAIS_NASCIMENTO'
,p_is_required=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pa\00EDs')
,p_source=>'PAIS_NASCIMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(DESCRICAO) descricao, to_char(CODIGO) codigo FROM PAISES_ES ORDER BY 1'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175305708409836787)
,p_name=>'P132_PAIS_NACIONALIDADE'
,p_is_required=>true
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nacionalidade'
,p_source=>'PAIS_NACIONALIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(DESCRICAO) descricao, to_char(CODIGO) codigo FROM PAISES_ES ORDER BY 1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175306077633836787)
,p_name=>'P132_NUM_CPF_CONJUGE_DISPLAY'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_prompt=>'CPF'
,p_source=>'regexp_replace(LPAD(lpad(:p132_num_cpf_conjuge,9,0)||lpad(:p132_dc_cpf_conjuge,2,0), 11),''([0-9]{3})([0-9]{3})([0-9]{3})'',''\1.\2.\3-'')'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175306501240836788)
,p_name=>'P132_NUM_CPF_CONJUGE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'NUM_CPF_CONJUGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175306907911836788)
,p_name=>'P132_DC_CPF_CONJUGE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_CPF_CONJUGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175307239600836788)
,p_name=>'P132_IND_AGREGADO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Agregado'
,p_source=>'IND_AGREGADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175307707714836789)
,p_name=>'P132_CARTORIO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Cart\00F3rio')
,p_source=>'CARTORIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>5
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175308116493836789)
,p_name=>'P132_NUM_REGISTRO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Registro'
,p_source=>'NUM_REGISTRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>7
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175308505029836789)
,p_name=>'P132_NUM_LIVRO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Livro'
,p_source=>'NUM_LIVRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>4
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175308858940836790)
,p_name=>'P132_NUM_FOLHA'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Folha'
,p_source=>'NUM_FOLHA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>4
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175309282459836790)
,p_name=>'P132_DATA_CERTIDAO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Certid\00E3o')
,p_source=>'DATA_CERTIDAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175309623119836790)
,p_name=>'P132_TIPO_CERTIDAO'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de Certid\00E3o')
,p_source=>'TIPO_CERTIDAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(a.descricao) descricao, a.cod_tipo_documento',
'  FROM tipo_documento a',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>10
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175310071968836791)
,p_name=>'P132_DECL_NASC_VIVOS_DISPLAY'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_prompt=>'Decl. Nasc. Vivos'
,p_source=>'substr(lpad(:P132_DECL_NASC_VIVOS,11,0),1,2)||''-''||substr(lpad(:P132_DECL_NASC_VIVOS,11,0),3,8)||''-''||substr(lpad(:P132_DECL_NASC_VIVOS,11,0),11,1)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>15
,p_cMaxlength=>15
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175310492262836791)
,p_name=>'P132_DECL_NASC_VIVOS'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'DECL_NASC_VIVOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175310900961836792)
,p_name=>'P132_MAE_DEPEND'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Nome da M\00E3e')
,p_source=>'MAE_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_tag_attributes=>'style="text-transform:uppercase"'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175311290622836792)
,p_name=>'P132_CPF_MAE_DEPEND_DISPLAY'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_prompt=>unistr('CPF da M\00E3e')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175311693328836792)
,p_name=>'P132_CPF_MAE_DEPEND'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'CPF_MAE_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175312054844836793)
,p_name=>'P132_DC_CPF_MAE_DEPEND'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_CPF_MAE_DEPEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175312450313836793)
,p_name=>'P132_INCID_IR'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'I.R.'
,p_source=>'INCID_IR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175312883497836793)
,p_name=>'P132_INCID_SF'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Sal\00E1rio Fam\00EDlia')
,p_source=>'INCID_SF'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175313222564836793)
,p_name=>'P132_CART_VACIN'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Cart. de Vacina\00E7\00E3o')
,p_source=>'CART_VACIN'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175313689326836794)
,p_name=>'P132_FREQ_ESCOLAR'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Frequ\00EAncia Escolar')
,p_source=>'FREQ_ESCOLAR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175314086723836794)
,p_name=>'P132_INCID_PLANO_MED'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'INCID_PLANO_MED'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175314444384836795)
,p_name=>'P132_CODIGO_PLANO'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'CODIGO_PLANO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175314817851836795)
,p_name=>'P132_CODIGO_TIPO'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'CODIGO_TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175315229680836796)
,p_name=>'P132_DATA_BAIXA'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'DATA_BAIXA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175315707579836796)
,p_name=>'P132_CD_NIVEL'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'CD_NIVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175316103352836797)
,p_name=>'P132_EMP_USUARIO_CONEXAO'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'EMP_USUARIO_CONEXAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175316478239836797)
,p_name=>'P132_MATR_USUARIO_CONEXAO'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'MATR_USUARIO_CONEXAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175316875466836797)
,p_name=>'P132_MANEQUIM'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Manequim'
,p_source=>'MANEQUIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175317240625836798)
,p_name=>'P132_CALCADO'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Cal\00E7ado')
,p_source=>'CALCADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175317691919836798)
,p_name=>'P132_COD_TIPO_ES'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_TIPO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175318108177836799)
,p_name=>'P132_INCID_AUX_CRECHE'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'INCID_AUX_CRECHE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175318490766836799)
,p_name=>'P132_AUX_EXCEPCIONAL'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_use_cache_before_default=>'NO'
,p_source=>'AUX_EXCEPCIONAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175318819910836799)
,p_name=>'P132_INCID_PLANO_MED_ANT'
,p_item_sequence=>540
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175319231741836800)
,p_name=>'P132_CODIGO_PLANO_ANT'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175319714729836800)
,p_name=>'P132_CODIGO_TIPO_ANT'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175320071039836800)
,p_name=>'P132_DT_ADESAO_ANT'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(276960269029894549090)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175321138811836801)
,p_name=>'P132_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276960287914510549103)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(fnct_nome_empresa(cod)) descricao, cod',
'from empresas_cad',
'where ((f_acesso_emp_pg_apex(cod, :p_usuario, :p_painel) = ''S'' and :p_painel in (''PG'',''PO''))',
'  or (:p_painel = ''PC'' and cod = :p_empresa_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175321572214836802)
,p_name=>'P132_MATRICULA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276960287914510549103)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
' from informacoes_funcionais i',
'where i.situacao < ''90''',
'  and i.cod_empresa = :p132_cod_empresa',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P132_COD_EMPRESA,P_EMPRESA_USER,P_MATRICULA_USER,P_PORTAL'
,p_ajax_items_to_submit=>'P132_COD_EMPRESA,P_EMPRESA_USER,P_MATRICULA_USER,P_PORTAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175322224034836803)
,p_name=>'P132_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276960289504261549106)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p132_cod_empresa',
'                               and matricula   = :p132_matricula), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P132_COD_EMPRESA || ''|'' || :P132_MATRICULA',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175322940628836804)
,p_name=>'P132_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276960290226901549107)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175323416535836804)
,p_name=>'P132_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(276960290226901549107)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175323796956836805)
,p_name=>'P132_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(276960290226901549107)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254175324175384836805)
,p_name=>'P132_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(276960290226901549107)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(254175326087764836810)
,p_validation_name=>'Valida CPF 1'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P132_ITEM_VALIDACAO;',
'',
'BEGIN',
'',
'if :P132_NUM_CPF_CONJUGE is not null then ',
'',
'          declare',
'          tamanho        number(1) := length(to_char(:P132_NUM_CPF_CONJUGE));',
'          tot1           number(4) := 0;',
'          tot2           number(4) := 0;',
'          multiplicador  number(2) := 9;',
'          digito         number(1) := 0;',
'          resto1         number(2) := 0;',
'          resto2         number(2) := 0;',
'          dc1_cpf        number(1) := 0;',
'          dc2_cpf        number(1) := 0;',
'          dc_cpf         number(2) := 0;',
'          dc_cpf_final   number(2) := 0;',
'',
'        begin',
'           for i in reverse 1..tamanho loop',
'             tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P132_NUM_CPF_CONJUGE),i,1)));',
'             multiplicador := multiplicador - 1;',
'           end loop;',
'           resto1 := mod(tot1,11);',
'           if resto1 = 10 then',
'              dc1_cpf := 0;',
'           else',
'              dc1_cpf := resto1;',
'           end if;',
'           digito := dc1_cpf;',
'           tot2 := tot2 + 9*digito;',
'           multiplicador := 8;',
'           for i in reverse 1..tamanho loop',
'             tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P132_NUM_CPF_CONJUGE),i,1)));',
'             multiplicador := multiplicador - 1;',
'           end loop;',
'           resto2 := mod(tot2,11);',
'           if resto2 = 10 then',
'              dc2_cpf := 0;',
'           else',
'              dc2_cpf := resto2;',
'           end if;',
'           dc_cpf := to_number(to_char(dc1_cpf)||(to_char(dc2_cpf)));',
'           dc_cpf_final := dc_cpf;',
'',
'           if dc_cpf_final <> :P132_DC_CPF_CONJUGE then',
'             v_flg_retorno := ''N'';',
unistr('             v_msg_retorno := ''CPF INV\00C1LIDO!'';'),
'',
'              raise SAIDA;',
'           end if;',
'        --   next_item;',
'        end;',
'',
'        if v_msg_retorno is not null then',
'        return v_msg_retorno;',
'        end if;',
'        ',
'end if;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'',
'if v_msg_retorno is not null then',
'return v_msg_retorno;',
'end if;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(254175306501240836788)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(254175325630445836810)
,p_validation_name=>'Valida CPF 2'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select x.existe from(',
'SELECT ''S'' existe',
'FROM DEPENDENTES ',
'WHERE COD_EMPRESA = :p132_cod_empresa ',
'AND MATRICULA   = :p132_matricula',
'and num_cpf_conjuge = :p132_num_cpf_conjuge',
'and dc_cpf_conjuge = :p132_dc_cpf_conjuge',
'union',
'select ''S'' existe 		   ',
'from dependentes_TEMP',
'where cod_empresa = :p132_cod_empresa ',
'and matricula   = :p132_matricula',
'and num_cpf_conjuge = :p132_num_cpf_conjuge',
'and dc_cpf_conjuge = :p132_dc_cpf_conjuge) x',
'where x.existe = ''S'';',
'',
'v_c1 c1%rowtype;',
'',
'BEGIN',
'',
'if :p132_num_cpf_conjuge is not null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.existe = ''S'' then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''N\00FAmero de CPF j\00E1 cadastrado para outro dependente.'';'),
'    end if;',
'',
'    if v_msg_retorno IS NOT NULL then',
'    return v_msg_retorno;',
'    end if;',
'',
'end if;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P132_NUM_DEPEND'
,p_validation_condition_type=>'ITEM_IS_NULL'
,p_associated_item=>wwv_flow_api.id(254175306501240836788)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(254175325298663836809)
,p_validation_name=>unistr('CPF - Obrigat\00F3rio')
,p_validation_sequence=>30
,p_validation=>'P132_NUM_CPF_CONJUGE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Informe o CPF!'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(254175306077633836787)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(254175326498158836811)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        return v_msg_retorno;',
'    else ',
'      if :p_painel = ''PC'' and :p132_matricula <> :p_matricula_user then',
unistr('        return ''Matr\00EDcula Inv\00E1lida!'';'),
'      else',
'        return null;',
'      end if;',
'    end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(254175296593788836777)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(254175326835512836811)
,p_validation_name=>'Valida comprovantes'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'p dependentes_temp%rowtype;',
'',
'begin',
'',
'  if nvl(:P132_EXCLUIR_DEPENDENTE,''N'') = ''N'' then',
'',
'    p.NUM_DEPEND := :P132_NUM_DEPEND;',
'    p.NOME_DEPEND := :P132_NOME_DEPEND;',
'    p.CONDICAO_DEPEND := :P132_CONDICAO_DEPEND;',
'    p.SEXO_DEPEND := :P132_SEXO_DEPEND;',
'    p.GRAU_PARENTESCO := :P132_GRAU_PARENTESCO;',
'    p.DT_NASC := :P132_DT_NASC;',
'    p.CIDADE_NASC := :P132_CIDADE_NASC;',
'    p.EST_NASC := :P132_EST_NASC;',
'    p.PAIS_NASCIMENTO := :P132_PAIS_NASCIMENTO;',
'    p.PAIS_NACIONALIDADE := :P132_PAIS_NACIONALIDADE;',
'    p.NUM_CPF_CONJUGE := :P132_NUM_CPF_CONJUGE;',
'    p.DC_CPF_CONJUGE := :P132_DC_CPF_CONJUGE;',
'    p.IND_AGREGADO := :P132_IND_AGREGADO;',
'    p.CARTORIO := :P132_CARTORIO;',
'    p.NUM_REGISTRO := :P132_NUM_REGISTRO;',
'    p.NUM_LIVRO := :P132_NUM_LIVRO;',
'    p.NUM_FOLHA := :P132_NUM_FOLHA;',
'    p.DATA_CERTIDAO := :P132_DATA_CERTIDAO;',
'    p.TIPO_CERTIDAO := :P132_TIPO_CERTIDAO;',
'    p.DECL_NASC_VIVOS := :P132_DECL_NASC_VIVOS;',
'    p.MAE_DEPEND := :P132_MAE_DEPEND;',
'    p.CPF_MAE_DEPEND := :P132_CPF_MAE_DEPEND;',
'    p.DC_CPF_MAE_DEPEND := :P132_DC_CPF_MAE_DEPEND;',
'    p.INCID_IR := :P132_INCID_IR;',
'    p.INCID_SF := :P132_INCID_SF;',
'    p.CART_VACIN := :P132_CART_VACIN;',
'    p.FREQ_ESCOLAR := :P132_FREQ_ESCOLAR;',
'    p.INCID_PLANO_MED := :P132_INCID_PLANO_MED;',
'    p.CODIGO_PLANO := :P132_CODIGO_PLANO;',
'    p.CODIGO_TIPO := :P132_CODIGO_TIPO;',
'    p.DATA_BAIXA := :P132_DATA_BAIXA;',
'    p.MANEQUIM := :P132_MANEQUIM;',
'    p.CALCADO := :P132_CALCADO;',
'    p.COD_TIPO_ES := :P132_COD_TIPO_ES;',
'    p.INCID_AUX_CRECHE := :P132_INCID_AUX_CRECHE;',
'    p.AUX_EXCEPCIONAL := :P132_AUX_EXCEPCIONAL;',
'',
'    prc_valida_req_dep_docs (p_emp => :p132_cod_empresa,',
'                             p_mat => :p132_matricula,',
'                             p_num_depend => :p132_num_depend,',
'                             p_cod_req => :p132_cod_requisicao,',
'                             p_seq => :p132_seq,',
'                             p_campos => p,',
'                             p_flg_retorno => v_flg,',
'                             p_msg_retorno => v_msg);',
'',
'    if v_flg = ''N'' and trim(v_msg) is not null then',
'    return replace(v_msg,chr(10),''<br>'');',
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(247013429624257909525)
,p_validation_name=>'Valida Dt. Dependente'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'	wl_data date;',
'	v_periodo_1 date;',
'	v_periodo_2 date;',
'    ',
'    vl_dt_referencia date;',
'    ',
'    saida exception;',
'    erro varchar2(4000);',
'    ',
'cursor c1 is',
'SELECT num_depend, DT_DEPENDENTE',
'  FROM DEPENDENTES A',
' WHERE A.COD_EMPRESA = :p132_cod_empresa',
'   AND A.MATRICULA   = :p132_matricula',
'   AND A.NUM_DEPEND  = :P132_NUM_DEPEND;',
'  ',
'v_c1 c1%rowtype;',
' ',
'begin',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if (nvl(v_c1.dt_dependente,sysdate) <> nvl(:p132_dt_dependente,sysdate)) or (v_c1.num_depend is null) then',
'',
'		 begin',
'			select dt_ref_folha',
'			into   wl_data',
'		  from parametros_recursos_humanos',
'		  where cod_empresa = :p132_cod_empresa;',
'		exception',
'			when others then',
'			    wl_data := NULL;',
'		end;',
'',
'        vl_dt_referencia := wl_data;',
'',
'        Select P.DT_REF_FOLHA,',
'            lpad(Nvl(Dia_Limite_lancto,To_Char(Last_Day(P.DT_REF_FOLHA),''DD'')),2,0)||To_Char(P.DT_REF_FOLHA,''MMYYYY'') ',
'	         --To_Date(lpad(Nvl(Dia_Limite_lancto,To_Char(Last_Day(P.DT_REF_FOLHA),''DD'')),2,0) || ',
'	         --        To_Char(P.DT_REF_FOLHA,''MMYYYY''),''DDMMYYYY'')',
'	    Into v_periodo_1,',
'	         v_periodo_2',
'	    From Parametros_Recursos_Humanos P',
'	   Where P.Cod_Empresa = :p132_Cod_Empresa;',
'	   IF (trunc(sysdate) > v_periodo_2) and (:p132_dt_dependente < add_months(v_periodo_1,1)) then	   		',
'',
unistr('	   	return ''A data de inclus\00E3o folha deve ser maior ou igual a ''||to_char(add_months(v_periodo_1,1),''dd/mm/yyyy'');'),
'',
'	   END IF; 	',
'',
'end if;',
'exception',
'    when others then',
'       erro := SQLERRM;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(254175303629265836785)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(108275418540846333710)
,p_validation_name=>'Valida DTLAUDO'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P132_CONDICAO_DEPEND = ''I'' AND :P132_DTLAUDO IS NULL THEN',
unistr('  RETURN ''Para condi\00E7\00E3o do dependente igual a "Inv\00E1lido" a informa\00E7\00E3o ref. data do laudo deve ser informada!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(108275418090354333706)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(79821413792538685014)
,p_validation_name=>'Valida_UF'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P132_PAIS_NASCIMENTO = 105 AND :P132_EST_NASC IS NULL THEN',
'   RETURN(''A UF deve ser informada.'');',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(254175304875411836786)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(79821413889032685015)
,p_validation_name=>'Valida_classif_estrangeiro'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P132_PAIS_NASCIMENTO != 105 AND :P132_CLASS_TRAB_ESTRANG IS NULL THEN',
unistr('   RETURN(''A classifica\00E7\00E3o do estrangeiro deve ser informada.'');'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(79821413749850685013)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175354793208836837)
,p_name=>'Dispara Alerta'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_MENSAGEM'
,p_condition_element=>'P132_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175355263650836838)
,p_event_id=>wwv_flow_api.id(254175354793208836837)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P132_FLAG'').value == "Q") {',
'alertify.confirm($v(''P132_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P132_FLAG'').value = ''S'';',
'        $x(''P132_MENSAGEM'').value = '''';',
'        $x(''P132_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P132_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P132_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P132_FLAG'').value == "N") {',
'            $x(''P132_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P132_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P132_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P132_MENSAGEM''));',
'    }else{',
'            if ($x(''P132_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P132_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175355684931836838)
,p_name=>'Habilita Campos (Create)'
,p_event_sequence=>29
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296593788836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175356215469836839)
,p_event_id=>wwv_flow_api.id(254175355684931836838)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276960259492047549082)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175356624049836839)
,p_event_id=>wwv_flow_api.id(254175355684931836838)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_EMPRESA,P132_MATRICULA,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_COD_REQUISICAO,P132_DATA_REQUISICAO,P132_INCID_IR,P132_INCID_SF,P132_INCID_PLANO_MED,P132_INCID_AUX_CRECHE,P132_FREQ_ESCOLAR,P132_CART_VACIN,P132_DT_DEPENDENTE,P1'
||'32_SOLICITANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175357106426836840)
,p_name=>'Inicia Alertify'
,p_event_sequence=>29
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175357572467836840)
,p_event_id=>wwv_flow_api.id(254175357106426836840)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175357959697836840)
,p_name=>'PRE-INSERT'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296593788836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175358483020836841)
,p_event_id=>wwv_flow_api.id(254175357959697836840)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR C1 IS',
'  SELECT SEQ_ALTERACAO_CADASTRAL.NEXTVAL',
'  FROM DUAL;	',
'  ',
'  cursor c2 is',
'  select dc_matricula',
'    from informacoes_funcionais',
'   where cod_empresa = :p132_cod_empresa',
'     and matricula = :p132_matricula;',
'     ',
'  v_c2 c2%rowtype;',
'     ',
'  ',
'BEGIN',
'	--',
'	:p132_dt_atualizacao := Sysdate;                                  ',
'	:p132_usuario        := :P_USUARIO;      ',
'',
'       :P132_AUX_EXCEPCIONAL := ''N'';',
'       ',
'       :P132_INCID_AUX_CRECHE := ''N'';',
'',
'		 OPEN C1;',
'		 FETCH C1 INTO :p132_COD_REQUISICAO;',
'		 CLOSE C1;',
'         ',
'         open c2;',
'         fetch c2 into v_c2;',
'         close c2;',
'         ',
'         :p132_dc_matricula := v_c2.dc_matricula;',
'',
'	   :p132_DATA_REQUISICAO      := sysdate;',
'',
'END;',
'',
''))
,p_attribute_02=>'P_USUARIO,P132_COD_EMPRESA,P132_MATRICULA'
,p_attribute_03=>'P132_DT_ATUALIZACAO,P132_USUARIO,P132_COD_REQUISICAO,P132_DATA_REQUISICAO,P132_AUX_EXCEPCIONAL,P132_DC_MATRICULA,P132_INCID_AUX_CRECHE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175358950750836841)
,p_event_id=>wwv_flow_api.id(254175357959697836840)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175359364609836841)
,p_name=>'Habilita Campos (Save) Enable'
,p_event_sequence=>38
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296999545836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175359906828836842)
,p_event_id=>wwv_flow_api.id(254175359364609836841)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_EMPRESA,P132_MATRICULA,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_COD_REQUISICAO,P132_DATA_REQUISICAO,P132_INCID_IR,P132_INCID_SF,P132_INCID_PLANO_MED,P132_INCID_AUX_CRECHE,P132_FREQ_ESCOLAR,P132_CART_VACIN'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175360336714836842)
,p_event_id=>wwv_flow_api.id(254175359364609836841)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175360744681836842)
,p_name=>'Habilita Campos (Save) Show'
,p_event_sequence=>39
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296999545836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175361231241836842)
,p_event_id=>wwv_flow_api.id(254175360744681836842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_EMPRESA,P132_MATRICULA,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_COD_REQUISICAO,P132_COD_EMP_SOLICITANTE,P132_MAT_SOLICITANTE,P132_DATA_REQUISICAO,P132_INCID_IR,P132_INCID_SF,P132_INCID_PLANO_MED,P132_INCID_AUX_CRECHE,P132_FREQ'
||'_ESCOLAR,P132_CART_VACIN'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175361625830836843)
,p_name=>'PRE-UPDATE'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296999545836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175362204534836843)
,p_event_id=>wwv_flow_api.id(254175361625830836843)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR C1 IS',
'  SELECT SEQ_ALTERACAO_CADASTRAL.NEXTVAL',
'  FROM DUAL;	',
'BEGIN',
'	--',
'	:p132_dt_atualizacao := Sysdate;                                  ',
'	:p132_usuario        := :P_USUARIO;                                ',
'',
'       :P132_AUX_EXCEPCIONAL := ''N'';',
'',
'		 OPEN C1;',
'		 FETCH C1 INTO :p132_COD_REQUISICAO;',
'		 CLOSE C1;',
'',
'	   :p132_DATA_REQUISICAO      := sysdate;',
'',
'END;',
'',
''))
,p_attribute_02=>'P_USUARIO'
,p_attribute_03=>'P132_DT_ATUALIZACAO,P132_USUARIO,P132_COD_REQUISICAO,P132_DATA_REQUISICAO,P132_AUX_EXCEPCIONAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175362579086836843)
,p_name=>'Incluir Dependente'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296593788836777)
,p_condition_element=>'P132_NUM_DEPEND'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175363067551836844)
,p_event_id=>wwv_flow_api.id(254175362579086836843)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select nvl(max(num_depend),0)+1 num_depend',
'		into :p132_num_depend',
'	  from (SELECT NUM_DEPEND',
'					  FROM DEPENDENTES ',
'					 WHERE COD_EMPRESA = :p132_cod_empresa ',
'					   AND MATRICULA   = :p132_matricula',
'					union',
'					select num_depend	 					   ',
'						from dependentes_TEMP',
'					 where cod_empresa = :p132_cod_empresa ',
'					   and matricula   = :p132_matricula);',
'',
'exception',
'when no_data_found then',
':p132_num_depend := 1;',
'when others then',
':p132_ok := ''N'';',
':p132_flag := ''N'';',
unistr(':p132_mensagem := ''Erro ao calcular n\00FAmero de dependente.'';'),
'',
'',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA'
,p_attribute_03=>'P132_NUM_DEPEND,P132_FLAG,P132_MENSAGEM,P132_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175363508428836844)
,p_name=>'Processa_Cadastro'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296593788836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175364008809836844)
,p_event_id=>wwv_flow_api.id(254175363508428836844)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_seq      number;',
'  v_processo number(38);',
'  v_ret     varchar2(2000);',
'  V_MSG     VARCHAR2(4000);',
'  ',
'  CURSOR C1 IS ',
'  SELECT PROCESSO',
'  FROM APLICACOES',
'  WHERE APLICACAO = ''FP15018'';',
'',
'  V_C1 C1%ROWTYPE;',
'  ',
'  cursor c2 is',
'  select cod_empresa, matricula, filial, cod_ccusto',
'    from informacoes_funcionais',
'   where cod_empresa = :p132_cod_empresa',
'     and matricula = :p132_matricula;',
'     ',
'  v_c2 c2%rowtype;',
'  ',
'  v_Dependentes varchar2(4000);',
'  ',
'  SAIDA EXCEPTION;',
'  ',
'BEGIN',
'	--',
'    v_dependentes := :p132_nome_depend||'', '';',
unistr('	v_dependentes := ''Requisi\00E7\00E3o de Inclus\00E3o e Altera\00E7\00E3o de Dependentes. ''||''Matr\00EDcula: ''||:p132_Matricula||'' - ''||initcap(fnct_nome_func(:p132_Cod_Empresa,:p132_Matricula))||'' - Nomes dos Dependentes: ''||v_dependentes;'),
'  ',
'  OPEN  C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;  ',
'  ',
'  OPEN  C2;',
'  FETCH C2 INTO V_C2;',
'  CLOSE C2;  ',
'  ',
'  Obtem_Processo(V_C1.PROCESSO,',
'	               :p132_Cod_Empresa,',
'	               v_c2.filial,',
'	  	           :p_usuario,',
'	  	           substr(v_dependentes,1,length(v_dependentes)-1),',
'                 v_seq,',
'                 v_processo,',
'	  	           v_ret, ',
'	  	           V_MSG);',
'',
'  IF nvl(v_ret,''S'') = ''S'' THEN	 ',
'    Proc_Insere_Payroll(:p132_Cod_Empresa,',
'                        v_c2.Filial,',
'                        :p132_Matricula,',
'                        :p132_DATA_SOLICITACAO,',
'                        v_c2.COD_CCUSTO,',
'                        v_processo,',
'     	                  V_C1.PROCESSO,',
'                        :p132_COD_REQUISICAO,',
'                        v_seq,',
'                        v_ret);',
'    V_processo := v_processo; ',
'  else ',
'  :P132_MENSAGEM := V_MSG;',
' 	  raise SAIDA;',
'  end if;  ',
'',
'  IF V_RET = ''S'' THEN',
'   	  COMMIT;',
'      :P132_FLAG := ''S'';',
'      :P132_OK := ''S'';',
' 	  :P132_MENSAGEM := null;',
'  ELSE',
'   ROLLBACK;',
'      :P132_FLAG := ''N'';',
'      :P132_OK := ''N'';',
' 	  :P132_MENSAGEM := V_RET;',
'  END IF;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'  ',
'END;'))
,p_attribute_02=>'P132_NOME_DEPEND,P132_MATRICULA,P132_COD_EMPRESA,P_USUARIO,P132_DATA_SOLICITACAO,P132_COD_REQUISICAO'
,p_attribute_03=>'P132_MENSAGEM,P132_FLAG,P132_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175364376309836845)
,p_name=>'Grava_Historico_Ass_Med1'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296999545836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P132_INCID_PLANO_MED_ANT'
,p_display_when_cond2=>'NX'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175364914394836845)
,p_event_id=>wwv_flow_api.id(254175364376309836845)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dummy number;',
'',
'saida exception;',
'',
'begin',
'begin',
'   select 0 into v_dummy',
'   from   historico_ass_med',
'   where  cod_empresa  = :p132_cod_empresa',
'   and    matricula    = :p132_matricula',
'   and    num_depend   = :p132_num_depend;',
'exception',
'   when no_data_found then',
'      begin',
'         insert into historico_ass_med ( COD_EMPRESA    ,',
'                                         MATRICULA      ,',
'                                         NUM_DEPEND     ,',
'                                         USUARIO        ,',
'                                         DT_ATUALIZACAO )',
'                                values ( :p132_cod_empresa  ,',
'                                         :p132_matricula    ,',
'                                         :p132_num_depend   ,',
'                                         user                      ,',
'                                         sysdate                   );',
'                                         ',
'                                         ',
'      exception',
'         when others then',
'            :p132_flag := ''N'';',
'            :p132_ok := ''N'';',
'            :p132_mensagem := ''Erro na insercao da procedure grava_historico_ass_med'';',
'            raise saida;',
'      end;',
'   when others then',
'            :p132_flag := ''N'';',
'            :p132_ok := ''N'';',
'         :p132_mensagem := ''Erro na procedure grava_historico_ass_med'';',
'         raise saida;',
'end;',
'commit;',
'exception',
'when saida then',
'rollback;',
'null;',
'END;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_NUM_DEPEND'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175365241713836845)
,p_name=>'Grava_Historico_Ass_Med2'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175296999545836777)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P132_INCID_PLANO_MED_ANT'
,p_display_when_cond2=>'SX'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175365765566836846)
,p_event_id=>wwv_flow_api.id(254175365241713836845)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dummy number;',
'',
'saida exception;',
'',
'v_dt_adesao_ant date := :p132_dt_adesao_ant;',
'',
'begin',
'begin',
'   select 0 into v_dummy',
'   from   historico_ass_med',
'   where  cod_empresa   = :p132_cod_empresa ',
'   and    matricula     = :p132_matricula',
'   and    num_depend    = :p132_num_depend',
'   and    codigo_plano  = :p132_codigo_plano_ant',
'   and    codigo_tipo   = :p132_codigo_tipo_ant',
'   and    data_exclusao is null',
'   group  by cod_empresa, matricula, num_depend, codigo_plano, codigo_tipo;               ',
'   begin',
'      update historico_ass_med',
'      set data_exclusao        = sysdate - 1,',
'          usuario              = user,',
'          dt_atualizacao       = sysdate',
'      where cod_empresa        = :p132_cod_empresa',
'      and   matricula          = :p132_matricula',
'      and   num_depend         = :p132_num_depend',
'      and   codigo_plano       = :p132_codigo_plano_ant',
'      and   codigo_tipo        = :p132_codigo_tipo_ant',
'      and   trunc(data_adesao) = trunc(v_dt_adesao_ant)',
'      and   data_exclusao      is null;',
'   exception',
'      when others then null;',
'   end;',
'exception',
'   when others then null;',
'end;',
'commit;',
'exception',
'when saida then',
'rollback;',
'null;',
'END;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_NUM_DEPEND,P132_CODIGO_PLANO_ANT,P132_CODIGO_TIPO_ANT,P132_DT_ADESAO_ANT'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175366159795836846)
,p_name=>'Popula_Campos'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P132_COD_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175366699391836847)
,p_event_id=>wwv_flow_api.id(254175366159795836846)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p132_cod_requisicao is null and :P132_NUM_DEPEND is not null then',
'',
'  SELECT NUM_CPF_CONJUGE          , DC_CPF_CONJUGE                  , GRAU_PARENTESCO              , ',
'  NUM_DEPEND                      , NOME_DEPEND                     , SEXO_DEPEND                  ,',
'  IND_AGREGADO                    , CONDICAO_DEPEND                 , DT_DEPENDENTE                , ',
'  DT_NASC                         , EST_NASC                        , CIDADE_NASC                  , ',
'  CARTORIO                        , NUM_REGISTRO                    , NUM_LIVRO                    , ',
'  NUM_FOLHA                       , DATA_CERTIDAO                   , TIPO_CERTIDAO                , ',
'  DATA_BAIXA                      , MANEQUIM                        , INCID_IR                     , ',
'  INCID_SF                        , CART_VACIN                      , CALCADO                      , ',
'  DECL_NASC_VIVOS                 , INCID_AUX_CRECHE                , FREQ_ESCOLAR                 ,',
'  MAE_DEPEND                      , CPF_MAE_DEPEND                  , DC_CPF_MAE_DEPEND            ,',
'  AUX_EXCEPCIONAL                 , ',
'  DC_MATRICULA                    , USUARIO                      , ',
'  DT_ATUALIZACAO                  , PAIS_NASCIMENTO                 , PAIS_NACIONALIDADE, CLASS_TRAB_ESTRANG',
'  INTO',
'  :P132_NUM_CPF_CONJUGE          , :P132_DC_CPF_CONJUGE                  , :P132_GRAU_PARENTESCO              , ',
'  :P132_NUM_DEPEND                      , :P132_NOME_DEPEND                     , :P132_SEXO_DEPEND                  ,',
'  :P132_IND_AGREGADO                    , :P132_CONDICAO_DEPEND                 , :P132_DT_DEPENDENTE                , ',
'  :P132_DT_NASC                         , :P132_EST_NASC                        , :P132_CIDADE_NASC                  , ',
'  :P132_CARTORIO                        , :P132_NUM_REGISTRO                    , :P132_NUM_LIVRO                    , ',
'  :P132_NUM_FOLHA                       , :P132_DATA_CERTIDAO                   , :P132_TIPO_CERTIDAO                , ',
'  :P132_DATA_BAIXA                      , :P132_MANEQUIM                        , :P132_INCID_IR                     , ',
'  :P132_INCID_SF                        , :P132_CART_VACIN                      , :P132_CALCADO                      , ',
'  :P132_DECL_NASC_VIVOS                 , :P132_INCID_AUX_CRECHE                , :P132_FREQ_ESCOLAR                 ,',
'  :P132_MAE_DEPEND                      , :P132_CPF_MAE_DEPEND                  , :P132_DC_CPF_MAE_DEPEND            ,',
'  :P132_AUX_EXCEPCIONAL                 , ',
'  :P132_DC_MATRICULA                    , :P132_USUARIO                      , ',
'  :P132_DT_ATUALIZACAO                  , :P132_PAIS_NASCIMENTO                 , :P132_PAIS_NACIONALIDADE,  :P132_CLASS_TRAB_ESTRANG',
'  FROM DEPENDENTES A',
'  WHERE A.COD_EMPRESA = :p132_cod_empresa',
'  AND   A.MATRICULA   = :p132_matricula',
'  AND   A.NUM_DEPEND  = :P132_NUM_DEPEND;',
'',
'elsif :p132_cod_requisicao is null and :P132_NUM_DEPEND is null then',
'',
':P132_INCID_IR := ''N'';',
':P132_INCID_SF := ''N'';',
':P132_FREQ_ESCOLAR := ''N'';',
':P132_CART_VACIN := ''N'';',
'',
'end if;',
'',
'if :p132_cod_requisicao is null and :p132_seq is null then',
':p132_seq := :p132_matricula||to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'end if;',
'',
'EXCEPTION',
'WHEN OTHERS THEN',
'NULL;',
'',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_NUM_DEPEND,P132_COD_REQUISICAO,P132_SEQ'
,p_attribute_03=>'P132_NUM_CPF_CONJUGE,P132_DC_CPF_CONJUGE,P132_GRAU_PARENTESCO,P132_NUM_DEPEND,P132_NOME_DEPEND,P132_SEXO_DEPEND,P132_IND_AGREGADO,P132_CONDICAO_DEPEND,P132_DT_DEPENDENTE,P132_DT_NASC,P132_EST_NASC,P132_CIDADE_NASC,P132_CARTORIO,P132_NUM_REGISTRO,P132'
||'_NUM_LIVRO,P132_NUM_FOLHA,P132_DATA_CERTIDAO,P132_TIPO_CERTIDAO,P132_DATA_BAIXA,P132_MANEQUIM,P132_INCID_IR,P132_INCID_SF,P132_CART_VACIN,P132_CALCADO,P132_DECL_NASC_VIVOS,P132_INCID_AUX_CRECHE,P132_FREQ_ESCOLAR,P132_MAE_DEPEND,P132_CPF_MAE_DEPEND,P1'
||'32_DC_CPF_MAE_DEPEND,P132_AUX_EXCEPCIONAL,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_PAIS_NASCIMENTO,P132_PAIS_NACIONALIDADE,P132_FREQ_ESCOLAR,P132_SEQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175367033087836847)
,p_name=>'Valida_Cpf'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DC_CPF_CONJUGE'
,p_condition_element=>'P132_DC_CPF_CONJUGE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175367553552836848)
,p_event_id=>wwv_flow_api.id(254175367033087836847)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P132_ITEM_VALIDACAO;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P132_NUM_CPF_CONJUGE));',
'  tot1           number(4) := 0;',
'  tot2           number(4) := 0;',
'  multiplicador  number(2) := 9;',
'  digito         number(1) := 0;',
'  resto1         number(2) := 0;',
'  resto2         number(2) := 0;',
'  dc1_cpf        number(1) := 0;',
'  dc2_cpf        number(1) := 0;',
'  dc_cpf         number(2) := 0;',
'  dc_cpf_final   number(2) := 0;',
'',
'begin',
'   for i in reverse 1..tamanho loop',
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P132_NUM_CPF_CONJUGE),i,1)));',
'     multiplicador := multiplicador - 1;',
'   end loop;',
'   resto1 := mod(tot1,11);',
'   if resto1 = 10 then',
'      dc1_cpf := 0;',
'   else',
'      dc1_cpf := resto1;',
'   end if;',
'   digito := dc1_cpf;',
'   tot2 := tot2 + 9*digito;',
'   multiplicador := 8;',
'   for i in reverse 1..tamanho loop',
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P132_NUM_CPF_CONJUGE),i,1)));',
'     multiplicador := multiplicador - 1;',
'   end loop;',
'   resto2 := mod(tot2,11);',
'   if resto2 = 10 then',
'      dc2_cpf := 0;',
'   else',
'      dc2_cpf := resto2;',
'   end if;',
'   dc_cpf := to_number(to_char(dc1_cpf)||(to_char(dc2_cpf)));',
'   dc_cpf_final := dc_cpf;',
'   ',
'   if dc_cpf_final <> :P132_DC_CPF_CONJUGE then',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''CPF INV\00C1LIDO!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'EXCEPTION',
'WHEN OTHERS THEN NULL;',
'end;',
'',
'if v_item_validacao = TRIM(UPPER(''P132_NUM_CPF_CONJUGE'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'',
'EXCEPTION',
'',
'WHEN SAIDA THEN',
'',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P132_ok       := ''N'';',
'    :P132_ITEM_VALIDACAO := TRIM(UPPER(''P132_NUM_CPF_CONJUGE''));',
'else',
'    :P132_ok       := ''S'';',
'end if;',
'',
':P132_flag     := v_flg_retorno;',
':P132_mensagem := v_msg_retorno;',
' else',
':P132_flag     := null;',
':P132_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''P132_NUM_CPF_CONJUGE'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
' end if;',
'',
'',
'WHEN OTHERS THEN NULL;',
'',
'END;'))
,p_attribute_02=>'P132_NUM_CPF_CONJUGE,P132_DC_CPF_CONJUGE,P132_ITEM_VALIDACAO'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM,P132_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175368079810836848)
,p_event_id=>wwv_flow_api.id(254175367033087836847)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P132_ITEM_VALIDACAO;',
'',
'cursor c1 is',
'select x.existe from(',
'SELECT ''S'' existe',
'FROM DEPENDENTES ',
'WHERE COD_EMPRESA = :p132_cod_empresa ',
'AND MATRICULA   = :p132_matricula',
'and num_cpf_conjuge = :p132_num_cpf_conjuge',
'and dc_cpf_conjuge = :p132_dc_cpf_conjuge',
'union',
'select ''S'' existe 		   ',
'from dependentes_TEMP',
'where cod_empresa = :p132_cod_empresa ',
'and matricula   = :p132_matricula',
'and num_cpf_conjuge = :p132_num_cpf_conjuge',
'and dc_cpf_conjuge = :p132_dc_cpf_conjuge) x',
'where x.existe = ''S'';',
'',
'v_c1 c1%rowtype;',
'',
'BEGIN',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.existe = ''S'' then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''N\00FAmero de CPF j\00E1 cadastrado para outro dependente.'';'),
'end if;',
'',
'if v_item_validacao = TRIM(UPPER(''P132_NUM_CPF_CONJUGE'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P132_ok       := ''N'';',
'    :P132_ITEM_VALIDACAO := TRIM(UPPER(''P132_NUM_CPF_CONJUGE''));',
'else',
'    :P132_ok       := ''S'';',
'end if;',
'',
':P132_flag     := v_flg_retorno;',
':P132_mensagem := v_msg_retorno;',
' else',
':P132_flag     := null;',
':P132_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''P132_NUM_CPF_CONJUGE'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
' end if;',
'',
'',
'END;'))
,p_attribute_02=>'P132_NUM_CPF_CONJUGE,P132_DC_CPF_CONJUGE,P132_ITEM_VALIDACAO'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM,P132_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175368435564836848)
,p_name=>unistr('Valida_Cpf M\00E3e')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DC_CPF_MAE_DEPEND'
,p_condition_element=>'P132_DC_CPF_MAE_DEPEND'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175368933715836849)
,p_event_id=>wwv_flow_api.id(254175368435564836848)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P132_ITEM_VALIDACAO;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P132_CPF_MAE_DEPEND));',
'  tot1           number(4) := 0;',
'  tot2           number(4) := 0;',
'  multiplicador  number(2) := 9;',
'  digito         number(1) := 0;',
'  resto1         number(2) := 0;',
'  resto2         number(2) := 0;',
'  dc1_cpf        number(1) := 0;',
'  dc2_cpf        number(1) := 0;',
'  dc_cpf         number(2) := 0;',
'  dc_cpf_final   number(2) := 0;',
'',
'begin',
'   for i in reverse 1..tamanho loop',
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P132_CPF_MAE_DEPEND),i,1)));',
'     multiplicador := multiplicador - 1;',
'   end loop;',
'   resto1 := mod(tot1,11);',
'   if resto1 = 10 then',
'      dc1_cpf := 0;',
'   else',
'      dc1_cpf := resto1;',
'   end if;',
'   digito := dc1_cpf;',
'   tot2 := tot2 + 9*digito;',
'   multiplicador := 8;',
'   for i in reverse 1..tamanho loop',
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P132_CPF_MAE_DEPEND),i,1)));',
'     multiplicador := multiplicador - 1;',
'   end loop;',
'   resto2 := mod(tot2,11);',
'   if resto2 = 10 then',
'      dc2_cpf := 0;',
'   else',
'      dc2_cpf := resto2;',
'   end if;',
'   dc_cpf := to_number(to_char(dc1_cpf)||(to_char(dc2_cpf)));',
'   dc_cpf_final := dc_cpf;',
'   ',
'   if dc_cpf_final <> :P132_DC_CPF_MAE_DEPEND then',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''CPF INV\00C1LIDO!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'',
'EXCEPTION',
'WHEN OTHERS THEN NULL;',
'',
'end;',
'',
'if v_item_validacao = TRIM(UPPER(''P132_CPF_MAE_DEPEND'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_OK := ''S'';',
'   :P132_MENSAGEM := NULL;',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P132_ok       := ''N'';',
'    :P132_ITEM_VALIDACAO := TRIM(UPPER(''P132_CPF_MAE_DEPEND''));',
'else',
'    :P132_ok       := ''S'';',
'end if;',
'',
':P132_flag     := v_flg_retorno;',
':P132_mensagem := v_msg_retorno;',
' else',
':P132_flag     := null;',
':P132_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''P132_CPF_MAE_DEPEND'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'WHEN OTHERS THEN NULL;',
'END;'))
,p_attribute_02=>'P132_CPF_MAE_DEPEND,P132_DC_CPF_MAE_DEPEND,P132_ITEM_VALIDACAO'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM,P132_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175369377481836849)
,p_name=>'PRC_VALIDAR_SF_IR'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DT_NASC,P132_GRAU_PARENTESCO,P132_CART_VACIN,P132_FREQ_ESCOLAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175369883389836850)
,p_event_id=>wwv_flow_api.id(254175369377481836849)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'vl_dt_ref_folha parametros_recursos_humanos.dt_ref_folha%TYPE;',
'V_DT_NASC DATE := :P132_dt_nasc;',
'BEGIN',
'BEGIN ',
'select dt_ref_folha',
'into vl_dt_ref_folha',
'from parametros_recursos_humanos',
'where cod_empresa = :P132_cod_empresa;',
'exception when others then',
'null;',
'end;',
'',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''N''; ',
'',
'IF :P132_DATA_BAIXA IS NOT NULL THEN',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir := ''N'';',
'END IF;',
'',
'IF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'') AND ',
'to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) > 14 THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''N'';',
'end if;',
'IF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'')',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) between 7 and 14',
'AND :P132_freq_escolar = ''S'' THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''S''; ',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'',''I'')',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) < 7',
'AND :P132_cart_vacin = ''S'' THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''S'';  ',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'',''I'')',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) < 7',
'AND :P132_cart_vacin = ''N'' THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''N'';',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'')',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) between 7 and 14',
'AND :P132_freq_escolar = ''N'' THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''N''; ',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend = ''I'' THEN',
':P132_DES_INCID_SF := ''S'';',
':P132_incid_sf := ''S'';',
'ELSE',
':P132_incid_sf := ''N'';',
':P132_DES_INCID_SF := ''S'';',
'END IF;',
'',
'IF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend = ''N''',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) >= 21',
'AND TO_NUMBER(TO_CHAR(vl_dt_ref_folha,''YYYYMM'')) <',
'( TO_NUMBER(to_char(V_DT_NASC,''YYYY'')) + 21)||LPAD(TO_NUMBER(to_char(V_DT_NASC,''MM'')),2,0)',
'THEN',
'IF :P132_DATA_BAIXA IS NULL THEN',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir := ''N'';',
'END IF;',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend IN (''N'',''U'')',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) <= 21',
'AND TO_NUMBER(TO_CHAR(vl_dt_ref_folha,''YYYYMM'')) <=',
'(TO_NUMBER(to_char(V_DT_NASC,''YYYY'')) + 21)||LPAD(TO_NUMBER(to_char(V_DT_NASC,''MM'')),2,0)',
'THEN',
'IF :P132_DATA_BAIXA IS NULL THEN',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir := ''S'';',
'END IF;',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend = ''U''',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) >= 24',
'AND TO_NUMBER(TO_CHAR(vl_dt_ref_folha,''YYYYMM'')) <',
'( TO_NUMBER(to_char(V_DT_NASC,''YYYY'')) + 24)||LPAD(TO_NUMBER(to_char(V_DT_NASC,''MM'')),2,0)',
'THEN',
'IF :P132_DATA_BAIXA IS NULL THEN',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir := ''N'';',
'END IF;',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend = ''U'' ',
'AND to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) <= 24 ',
'AND TO_NUMBER(TO_CHAR(vl_dt_ref_folha,''YYYYMM'')) <= ( TO_NUMBER(to_char(V_DT_NASC,''YYYY'')) + 24)||LPAD(TO_NUMBER(to_char(V_DT_NASC,''MM'')),2,0)',
'THEN ',
'IF :P132_DATA_BAIXA IS NULL THEN ',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir  := ''S'';',
'END IF; ',
'ELSIF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') AND :P132_condicao_depend = ''I'' THEN',
'IF :P132_DATA_BAIXA IS NULL THEN ',
':P132_DES_INCID_IR := ''S'';',
':P132_incid_ir  := ''S'';',
'END IF; ',
'ELSE',
'IF :P132_grau_parentesco NOT IN (''FO'',''FA'',''DO'',''DA'') AND :P132_DATA_BAIXA IS NOT NULL THEN ',
':P132_DES_INCID_IR := ''N'';',
'END IF;',
'END IF;',
'',
'END;'))
,p_attribute_02=>'P132_DT_NASC,P132_COD_EMPRESA,P132_DATA_BAIXA,P132_GRAU_PARENTESCO,P132_CONDICAO_DEPEND,P132_FREQ_ESCOLAR,P132_CART_VACIN'
,p_attribute_03=>'P132_DES_INCID_SF,P132_INCID_SF,P132_DES_INCID_IR,P132_INCID_IR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(247013429748413909526)
,p_event_id=>wwv_flow_api.id(254175369377481836849)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'vl_dt_ref_folha parametros_recursos_humanos.dt_ref_folha%TYPE;',
'V_DT_NASC DATE := :P132_dt_nasc;',
'',
'BEGIN',
'',
'  BEGIN ',
'    select dt_ref_folha',
'      into vl_dt_ref_folha',
'      from parametros_recursos_humanos',
'     where cod_empresa = :P132_cod_empresa;',
'  exception ',
'  when others then',
'  null;',
'  end;',
'',
'  IF :P132_grau_parentesco IN (''FO'',''FA'',''DO'',''DA'') then',
'  ',
'    if ((to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) between 0 and 21 and :P132_condicao_depend = ''N'') or',
'        (to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365))) between 21 and 24 and :P132_condicao_depend = ''U'') or',
'        (:P132_condicao_depend = ''I'')) ',
'    then',
'      :P132_DES_INCID_IR := ''N'';',
'    else ',
'      :P132_DES_INCID_IR := ''S'';',
'    end if;',
'    ',
'  else ',
'  ',
'    :P132_DES_INCID_IR := ''S'';',
'    ',
'  end if;',
'  ',
'END;'))
,p_attribute_02=>'P132_DT_NASC,P132_COD_EMPRESA,P132_DATA_BAIXA,P132_GRAU_PARENTESCO,P132_CONDICAO_DEPEND,P132_FREQ_ESCOLAR,P132_CART_VACIN'
,p_attribute_03=>'P132_DES_INCID_SF,P132_INCID_SF,P132_DES_INCID_IR,P132_INCID_IR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175370298918836850)
,p_name=>'Valida_dt_nascimento'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DT_NASC'
,p_condition_element=>'P132_DT_NASC'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P132_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175370738736836850)
,p_event_id=>wwv_flow_api.id(254175370298918836850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_data date;',
'',
'v_flg_retorno varchar2(1);',
'v_ok varchar2(1);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P132_ITEM_VALIDACAO;',
'',
'saida exception;',
'',
'begin ',
'',
'        if :p132_dt_nasc > sysdate then',
'           v_flg_retorno := ''N'';',
'           v_ok := ''N'';',
unistr('           v_msg_retorno := ''Data N\00E3o Deve Ser Maior Que A Data Do Sistema'';'),
'           raise saida;',
'        end if;',
'',
'    select dt_nasc',
'    into   v_data',
'    from   inf_pessoais',
'    where  cod_empresa = :p132_cod_empresa',
'      and  matricula   = :p132_matricula;',
'',
'        if v_data >= :p132_dt_nasc and',
'           ((:p132_grau_parentesco = ''FO'' )   or',
'            (:p132_grau_parentesco = ''FA'' )) then',
'           v_flg_retorno := ''N'';',
'           v_ok := ''N'';',
unistr('           v_msg_retorno := ''Data De Nascimento Do Dependente N\00E3o Pode Ser Menor Ou Igual \00C0 ''||to_char(v_data,''dd/mm/yyyy'');'),
'           raise saida;',
'        end if;',
'',
'if v_item_validacao = TRIM(UPPER(''p132_dt_nasc'')) OR v_item_validacao IS NULL then',
'    :p132_ok := ''S'';',
'    :p132_flag := null;',
'    :p132_mensagem := null;',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'    :p132_ok := ''S'';',
'    :p132_flag := null;',
'    :p132_mensagem := null;',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'',
'exception',
'      when no_data_found then ',
'      null;',
'when saida then',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P132_ok       := ''N'';',
'    :P132_ITEM_VALIDACAO := TRIM(UPPER(''p132_dt_nasc''));',
'else',
'    :P132_ok       := ''S'';',
'end if;',
'',
':P132_flag     := v_flg_retorno;',
':P132_mensagem := v_msg_retorno;',
' else',
':P132_flag     := null;',
':P132_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p132_dt_nasc'')) OR v_item_validacao IS NULL then',
'   :P132_OK := ''S'';',
'   :P132_ITEM_VALIDACAO := null;',
'else',
'   :P132_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P132_DT_NASC,P132_COD_EMPRESA,P132_MATRICULA,P132_GRAU_PARENTESCO,P132_ITEM_VALIDACAO'
,p_attribute_03=>'P132_OK,P132_FLAG,P132_MENSAGEM,P132_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175371157021836850)
,p_name=>'Desabilita Incid IR'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DES_INCID_IR'
,p_condition_element=>'P132_DES_INCID_IR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175371644708836851)
,p_event_id=>wwv_flow_api.id(254175371157021836850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_INCID_IR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175372123552836851)
,p_event_id=>wwv_flow_api.id(254175371157021836850)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_INCID_IR'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175372609629836851)
,p_name=>'Desabilita Incid SF'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DES_INCID_SF'
,p_condition_element=>'P132_DES_INCID_SF'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175373029275836852)
,p_event_id=>wwv_flow_api.id(254175372609629836851)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_INCID_SF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175373549360836852)
,p_event_id=>wwv_flow_api.id(254175372609629836851)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_INCID_SF'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175373969734836852)
,p_name=>'Valida Dt_Dependente'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DT_DEPENDENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175374483051836853)
,p_event_id=>wwv_flow_api.id(254175373969734836852)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'	--wl_data date;',
'	v_periodo_1 date;',
'	v_periodo_2 date;',
'  ',
'  --vl_dt_referencia date;',
'  saida exception;',
'  ',
'cursor c1 is',
'SELECT num_depend, DT_DEPENDENTE',
'  FROM DEPENDENTES A',
' WHERE A.COD_EMPRESA = :p132_cod_empresa',
'   AND A.MATRICULA   = :p132_matricula',
'   AND A.NUM_DEPEND  = :P132_NUM_DEPEND;',
'  ',
'v_c1 c1%rowtype;',
' ',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if (nvl(v_c1.dt_dependente,sysdate) <> nvl(:p132_dt_dependente,sysdate)) or (v_c1.num_depend is null) then',
'  /*',
'  begin',
'    select dt_ref_folha',
'    into   wl_data',
'    from parametros_recursos_humanos',
'   where cod_empresa = :p132_cod_empresa;',
'  exception',
'    when others then',
'      wl_data := NULL;',
'  end;',
'',
'  vl_dt_referencia := wl_data;',
'  */',
'		Select P.DT_REF_FOLHA,',
'               /* To_Date(LPAD(NVL(P.DIA_LIMITE_LANCTO, TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD'')), 2, ''0'') ||''/''||',
'       TO_CHAR(P.DT_REF_FOLHA, ''MM/YYYY''),''DD/MM/YYYY'' ) */',
'       ',
'        CASE ',
'           WHEN NVL(P.Dia_Limite_Lancto, 31) > TO_NUMBER(TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD'')) THEN ',
unistr('               TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD/MM/YYYY'')  -- Ajusta para o \00FAltimo dia do m\00EAs'),
'           ELSE',
unistr('               -- Se Dia_Limite_Lancto for v\00E1lido e menor ou igual ao \00FAltimo dia do m\00EAs'),
'               LPAD(NVL(P.Dia_Limite_Lancto, TO_NUMBER(TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD''))), 2, ''0'') || ''/'' ||',
'               TO_CHAR(P.DT_REF_FOLHA, ''MM/YYYY'')  ',
'       END',
'	    Into v_periodo_1,',
'	         v_periodo_2',
'	    From Parametros_Recursos_Humanos P',
'	   Where P.Cod_Empresa = :p132_Cod_Empresa;',
'       ',
'	   IF (trunc(sysdate) > v_periodo_2) and (:p132_dt_dependente < add_months(v_periodo_1,1)) then	   		',
'	   	',
'        :p132_flag := ''N'';',
'        :p132_ok := ''N'';',
unistr('	   	:p132_mensagem := ''A data de inclus\00E3o folha deve ser maior ou igual a ''||to_char(add_months(v_periodo_1,1),''dd/mm/yyyy'');'),
'	       RAISE saida;',
'',
'	   END IF; 	',
'',
'end if;',
'',
'exception',
'when saida then',
'null;',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_DT_DEPENDENTE,P132_MATRICULA,P132_NUM_DEPEND'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175334371776836820)
,p_name=>'Post-Change Grau Parent'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_GRAU_PARENTESCO,P132_DT_NASC'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175334872789836821)
,p_event_id=>wwv_flow_api.id(254175334371776836820)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'	vl_dt_ref_folha date;',
'    ',
'   v_dt_nasc date :=  :p132_dt_nasc;',
'BEGIN',
'	',
'	',
'	begin',
'    select dt_ref_folha',
'      into vl_dt_ref_folha',
'      from parametros_recursos_humanos',
'     where cod_empresa = :p132_cod_empresa;  ',
'   exception when others then',
'	   null;',
'   end;',
'	',
'	',
'	IF :p132_grau_parentesco IN (''FO'',''FA'') AND :p132_condicao_depend IN (''N'',''U'', ''I'') ',
'		 AND to_number(to_char(trunc( ( vl_dt_ref_folha - v_dt_nasc ) / 365 ))) < 7  	THEN		 ',
'		 :p132_freq_escolar := ''N'';',
'		 :p132_cart_vacin   := ''S'';',
'	ELSIF to_number(to_char(trunc( ( vl_dt_ref_folha - v_dt_nasc ) / 365 ))) >= 7 ',
'		 AND to_number(to_char(trunc( ( vl_dt_ref_folha - v_dt_nasc ) / 365 ))) <= 14 THEN',
'		 :p132_freq_escolar := ''S'';',
'		 :p132_cart_vacin   := ''N'';',
'	END IF;',
'',
'END;',
''))
,p_attribute_02=>'P132_DT_NASC,P132_COD_EMPRESA,P132_GRAU_PARENTESCO,P132_CONDICAO_DEPEND'
,p_attribute_03=>'P132_FREQ_ESCOLAR,P132_CART_VACIN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175335275981836821)
,p_name=>'Valida Data Certidao'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DATA_CERTIDAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175335813433836822)
,p_event_id=>wwv_flow_api.id(254175335275981836821)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_data_certidao date := :p132_data_certidao;',
'v_dt_nasc date := :p132_dt_nasc;',
'',
'begin',
'',
'  if v_dt_nasc is not null and v_data_certidao is not null then',
'    if trunc(v_data_certidao) < trunc(v_dt_nasc) then',
'       :p132_flag := ''N'';',
'       :p132_ok := ''N'';',
unistr('       :p132_mensagem := ''DATA DA CERTID\00C3O N\00C3O PODE SER MENOR QUE A DATA DE NASCIMENTO'';'),
'    else',
'       :p132_flag := ''S'';',
'       :p132_ok := ''S'';',
'       :p132_mensagem := null;',
'    end if;',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P132_DATA_CERTIDAO,P132_DT_NASC'
,p_attribute_03=>'P132_FLAG,P132_OK,P132_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175336162474836822)
,p_name=>'Esconde Campos (Create)'
,p_event_sequence=>200
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P132_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175336716072836823)
,p_event_id=>wwv_flow_api.id(254175336162474836822)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_COD_REQUISICAO,P132_DATA_REQUISICAO,P132_SOLICITANTE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175337137505836823)
,p_event_id=>wwv_flow_api.id(254175336162474836822)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175337663639836823)
,p_event_id=>wwv_flow_api.id(254175336162474836822)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276960259492047549082)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175338138205836824)
,p_event_id=>wwv_flow_api.id(254175336162474836822)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_DT_DEPENDENTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175338567971836824)
,p_name=>'Esconde Campos (Save)'
,p_event_sequence=>210
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P132_COD_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175339018117836825)
,p_event_id=>wwv_flow_api.id(254175338567971836824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_EMPRESA,P132_MATRICULA,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175339520168836825)
,p_event_id=>wwv_flow_api.id(254175338567971836824)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_REQUISICAO,P132_DATA_REQUISICAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175339990566836825)
,p_name=>'Popula_Colab'
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_MATRICULA'
,p_condition_element=>'P132_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175340421150836825)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276960269029894549090)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175340971565836826)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       I.FILIAL',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p132_cod_empresa',
'   and i.matricula = :p132_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'',
'begin',
'',
':p132_solicitante := NVL(:p132_COD_EMP_SOLICITANTE,:P_EMPRESA_USER)||'' / ''||NVL(:p132_MAT_SOLICITANTE,:P_MATRICULA_USER)||'' - ''||iNITCAP(fnct_nome_func(:p132_COD_EMP_SOLICITANTE, :p132_MAT_SOLICITANTE));',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p132_cod_empresa_display := v_c1.empresa;',
':p132_matricula_display := v_c1.matricula;',
':p132_situacao_colab := v_c1.situacao;',
':p132_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p132_cod_empresa_display := :p132_cod_empresa;',
':p132_matricula_display := :p132_matricula;',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_COD_EMP_SOLICITANTE,P132_MAT_SOLICITANTE,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P132_SOLICITANTE,P132_COD_EMPRESA_DISPLAY,P132_MATRICULA_DISPLAY,P132_SITUACAO_COLAB,P132_DT_ADMISSAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175341456257836826)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175341991800836827)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p132_cod_requisicao is null and :P132_NUM_DEPEND is null then',
'',
':P132_INCID_IR := ''N'';',
':P132_INCID_SF := ''N'';',
':P132_FREQ_ESCOLAR := ''N'';',
':P132_CART_VACIN := ''N'';',
'DECLARE',
'  v_periodo_1 DATE;',
'  v_periodo_2 DATE;',
'BEGIN',
'Select P.DT_REF_FOLHA,',
'       CASE ',
'         WHEN NVL(P.Dia_Limite_Lancto, 31) > TO_NUMBER(TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD'')) THEN ',
unistr('           TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD/MM/YYYY'')  -- Ajusta para o \00FAltimo dia do m\00EAs'),
'         ELSE',
unistr('           -- Se Dia_Limite_Lancto for v\00E1lido e menor ou igual ao \00FAltimo dia do m\00EAs'),
'           LPAD(NVL(P.Dia_Limite_Lancto, TO_NUMBER(TO_CHAR(LAST_DAY(P.DT_REF_FOLHA), ''DD''))), 2, ''0'') || ''/'' ||',
'           TO_CHAR(P.DT_REF_FOLHA, ''MM/YYYY'')  ',
'       END',
'	Into v_periodo_1,',
'	     v_periodo_2',
'	From Parametros_Recursos_Humanos P',
' Where P.Cod_Empresa = :p132_Cod_Empresa;',
'',
'IF (trunc(sysdate) > v_periodo_2) and (:p132_dt_dependente < add_months(v_periodo_1,1)) then	   		',
'	:p132_dt_dependente := add_months(v_periodo_1,1);',
'ELSE',
'  :P132_DT_DEPENDENTE := sysdate;',
'END IF;',
'END;',
':P132_IND_AGREGADO := ''N'';',
':P132_CONDICAO_DEPEND := ''N'';',
'end if;'))
,p_attribute_02=>'P132_COD_REQUISICAO,P132_NUM_DEPEND'
,p_attribute_03=>'P132_FREQ_ESCOLAR,P132_CART_VACIN,P132_IND_AGREGADO,P132_DT_DEPENDENTE,P132_CONDICAO_DEPEND,P132_INCID_IR,P132_INCID_SF'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175342442688836827)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276960269029894549090)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175343009639836827)
,p_event_id=>wwv_flow_api.id(254175339990566836825)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175343374340836828)
,p_name=>'Popula Dados Dependente'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_NUM_DEPEND'
,p_condition_element=>'P132_NUM_DEPEND'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175343859514836828)
,p_event_id=>wwv_flow_api.id(254175343374340836828)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_EXCLUIR_DEPENDENTE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175344400748836829)
,p_event_id=>wwv_flow_api.id(254175343374340836828)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nome_depend,',
'       condicao_depend,',
'       sexo_depend,',
'       grau_parentesco,',
'       dt_dependente,',
'       dt_nasc,',
'       cidade_nasc, ',
'       est_nasc,',
'       pais_nascimento,',
'       pais_nacionalidade,',
'       num_cpf_conjuge,',
'       dc_cpf_conjuge,',
'       regexp_replace(LPAD(lpad(num_cpf_conjuge,9,0)||lpad(dc_cpf_conjuge,2,0), 11),''([0-9]{3})([0-9]{3})([0-9]{3})'',''\1.\2.\3-'') CPF_CONJUGE_DISPLAY,',
'       ind_agregado,',
'       cartorio,',
'       num_registro,',
'       num_livro,',
'       num_folha,',
'       data_certidao,',
'       tipo_certidao,',
'       decl_nasc_vivos,',
'       substr(lpad(DECL_NASC_VIVOS,11,0),1,2)||''-''||substr(lpad(DECL_NASC_VIVOS,11,0),3,8)||''-''||substr(lpad(DECL_NASC_VIVOS,11,0),11,1) decl_nasc_vivos_display,',
'       mae_depend,',
'       cpf_mae_depend,',
'       dc_cpf_mae_depend,',
'       regexp_replace(LPAD(lpad(cpf_mae_depend,9,0)||lpad(dc_cpf_mae_depend,2,0), 11),''([0-9]{3})([0-9]{3})([0-9]{3})'',''\1.\2.\3-'') CPF_MAE_DEPEND_DISPLAY,',
'       incid_ir,',
'       incid_sf,',
'       cart_vacin,',
'       freq_escolar,',
'       manequim,',
'       calcado,',
'       class_trab_estrang',
'  from dependentes',
' where cod_empresa = :p132_cod_empresa',
'   and matricula = :p132_matricula',
'   and num_depend = :p132_num_depend;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p132_nome_depend := v_c1.nome_depend;',
':p132_condicao_depend := v_c1.condicao_depend;',
':p132_sexo_depend := v_c1.sexo_depend;',
':p132_grau_parentesco := v_c1.grau_parentesco;',
':p132_dt_dependente := v_c1.dt_dependente;',
':p132_dt_nasc := v_c1.dt_nasc;',
':p132_cidade_nasc := v_c1.cidade_nasc;',
':p132_est_nasc := v_c1.est_nasc;',
':p132_pais_nascimento := v_c1.pais_nascimento;',
':p132_pais_nacionalidade := v_c1.pais_nacionalidade; ',
':p132_num_cpf_conjuge := v_c1.num_cpf_conjuge; ',
':p132_dc_cpf_conjuge := v_c1.dc_cpf_conjuge; ',
':p132_num_cpf_conjuge_display := v_c1.cpf_conjuge_display; ',
':p132_ind_agregado := v_c1.ind_agregado; ',
':p132_cartorio := v_c1.cartorio; ',
':p132_num_registro := v_c1.num_registro; ',
':p132_num_livro := v_c1.num_livro; ',
':p132_num_folha := v_c1.num_folha; ',
':p132_data_certidao := v_c1.data_certidao; ',
':p132_tipo_certidao := v_c1.tipo_certidao; ',
':p132_decl_nasc_vivos := v_c1.decl_nasc_vivos; ',
':p132_decl_nasc_vivos_display := v_c1.decl_nasc_vivos_display; ',
':p132_mae_depend := v_c1.mae_depend; ',
':p132_cpf_mae_depend := v_c1.cpf_mae_depend; ',
':p132_dc_cpf_mae_depend := v_c1.dc_cpf_mae_depend; ',
':p132_cpf_mae_depend_display := v_c1.cpf_mae_depend_display; ',
':p132_incid_ir := v_c1.incid_ir; ',
':p132_incid_sf := v_c1.incid_sf;',
':p132_cart_vacin := v_c1.cart_vacin; ',
':p132_freq_escolar := v_c1.freq_escolar; ',
':p132_manequim := v_c1.manequim; ',
':p132_calcado := v_c1.calcado; ',
':p132_class_trab_estrang := v_c1.class_trab_estrang;',
'',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_NUM_DEPEND'
,p_attribute_03=>'P132_NOME_DEPEND,P132_CONDICAO_DEPEND,P132_SEXO_DEPEND,P132_GRAU_PARENTESCO,P132_DT_DEPENDENTE,P132_DT_NASC,P132_CIDADE_NASC,P132_EST_NASC,P132_PAIS_NASCIMENTO,P132_PAIS_NACIONALIDADE,P132_NUM_CPF_CONJUGE,P132_DC_CPF_CONJUGE,P132_IND_AGREGADO,P132_CA'
||'RTORIO,P132_NUM_REGISTRO,P132_NUM_LIVRO,P132_NUM_FOLHA,P132_DATA_CERTIDAO,P132_TIPO_CERTIDAO,P132_DECL_NASC_VIVOS,P132_DECL_NASC_VIVOS_DISPLAY,P132_MAE_DEPEND,P132_CPF_MAE_DEPEND,P132_DC_CPF_MAE_DEPEND,P132_INCID_IR,P132_INCID_SF,P132_CART_VACIN,P132'
||'_FREQ_ESCOLAR,P132_MANEQUIM,P132_CALCADO,P132_NUM_CPF_CONJUGE_DISPLAY,P132_CPF_MAE_DEPEND_DISPLAY'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175344857544836829)
,p_event_id=>wwv_flow_api.id(254175343374340836828)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_EXCLUIR_DEPENDENTE'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175345145863836830)
,p_name=>'Habilita Campos'
,p_event_sequence=>270
,p_bind_type=>'bind'
,p_bind_event_type=>'apexbeforepagesubmit'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175345658333836830)
,p_event_id=>wwv_flow_api.id(254175345145863836830)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_COD_EMPRESA,P132_MATRICULA,P132_DC_MATRICULA,P132_USUARIO,P132_DT_ATUALIZACAO,P132_COD_REQUISICAO,P132_COD_EMP_SOLICITANTE,P132_MAT_SOLICITANTE,P132_DATA_REQUISICAO,P132_INCID_IR,P132_INCID_SF,P132_INCID_PLANO_MED,P132_INCID_AUX_CRECHE,P132_FREQ'
||'_ESCOLAR,P132_CART_VACIN,P132_DT_DEPENDENTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175346103364836831)
,p_name=>'Refresh Documentos'
,p_event_sequence=>280
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175288759203836763)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175346558560836831)
,p_event_id=>wwv_flow_api.id(254175346103364836831)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175346952022836831)
,p_name=>'Report - Dialog Closed'
,p_event_sequence=>290
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(267432760700166930776)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175347512350836832)
,p_event_id=>wwv_flow_api.id(254175346952022836831)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175347859979836832)
,p_name=>'Popula URL_DOCS'
,p_event_sequence=>310
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_NOME_DEPEND'
,p_condition_element=>'P132_NOME_DEPEND'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175348399650836832)
,p_event_id=>wwv_flow_api.id(254175347859979836832)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_requisicao',
'  from dependentes_temp',
' where cod_requisicao = :p132_cod_requisicao;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':P132_URL_DOCS := replace(apex_page.get_url (',
'            p_application => :APP_ID,',
'            p_page        => 864,',
'            p_request     => 132,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM,P864_DESCRICAO,P864_SEQ,P864_COD_SUB_ITEM,P864_COD_REQ'',',
'            p_values      => :P132_COD_EMPRESA||'',''||:P132_MATRICULA||'',''||NULL||'',''||1||'',''||132||'',''||''COLABORADOR''||'',''||:P132_NOME_DEPEND||'',''||:P132_SEQ||'',''||:P132_NUM_DEPEND||'',''||V_C1.COD_REQUISICAO,',
'            p_clear_cache => 864,',
'            p_session     => :APP_SESSION),''this'',''apex.jQuery(''''#BTN_ANEXO'''')'');',
'',
'end;'))
,p_attribute_02=>'P132_COD_EMPRESA,P132_MATRICULA,P132_NOME_DEPEND,P132_SEQ,P132_NUM_DEPEND,P132_COD_REQUISICAO'
,p_attribute_03=>'P132_URL_DOCS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175348884450836833)
,p_event_id=>wwv_flow_api.id(254175347859979836832)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175349409807836833)
,p_event_id=>wwv_flow_api.id(254175347859979836832)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175349820765836833)
,p_event_id=>wwv_flow_api.id(254175347859979836832)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_URL_DOCS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175350303836836834)
,p_name=>'Refresh Docs'
,p_event_sequence=>340
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_REFRESH_DOCS'
,p_condition_element=>'P132_REFRESH_DOCS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175350765291836834)
,p_event_id=>wwv_flow_api.id(254175350303836836834)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(267432760700166930776)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175351119247836834)
,p_name=>'OPEN URL_DOCS'
,p_event_sequence=>350
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254175288759203836763)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175351651199836835)
,p_event_id=>wwv_flow_api.id(254175351119247836834)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item( "P132_URL_DOCS" ).getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175374873468836853)
,p_name=>'Popula Campos Mask'
,p_event_sequence=>360
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175375333129836853)
,p_event_id=>wwv_flow_api.id(254175374873468836853)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P132_DECL_NASC_VIVOS is not null then',
':P132_DECL_NASC_VIVOS_DISPLAY := substr(lpad(:P132_DECL_NASC_VIVOS,11,0),1,2)||''-''||substr(lpad(:P132_DECL_NASC_VIVOS,11,0),3,8)||''-''||substr(lpad(:P132_DECL_NASC_VIVOS,11,0),11,1);',
'end if;',
'',
'if :P132_NUM_CPF_CONJUGE is not null then',
':P132_NUM_CPF_CONJUGE_DISPLAY := regexp_replace(LPAD(lpad(:P132_NUM_CPF_CONJUGE,9,0)||lpad(:P132_DC_CPF_CONJUGE,2,0), 11),''([0-9]{3})([0-9]{3})([0-9]{3})'',''\1.\2.\3-'');',
'end if;',
'',
'if :P132_CPF_MAE_DEPEND is not null then',
':P132_CPF_MAE_DEPEND_DISPLAY := regexp_replace(LPAD(lpad(:P132_CPF_MAE_DEPEND,9,0)||lpad(:P132_DC_CPF_MAE_DEPEND,2,0), 11),''([0-9]{3})([0-9]{3})([0-9]{3})'',''\1.\2.\3-'');',
'end if;'))
,p_attribute_02=>'P132_DECL_NASC_VIVOS,P132_NUM_CPF_CONJUGE,P132_CPF_MAE_DEPEND,P132_DC_CPF_CONJUGE,P132_DC_CPF_MAE_DEPEND'
,p_attribute_03=>'P132_DECL_NASC_VIVOS_DISPLAY,P132_NUM_CPF_CONJUGE_DISPLAY,P132_CPF_MAE_DEPEND_DISPLAY'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175352926580836836)
,p_name=>'Popula Num Cpf Conjuge'
,p_event_sequence=>370
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_NUM_CPF_CONJUGE_DISPLAY'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175353447773836836)
,p_event_id=>wwv_flow_api.id(254175352926580836836)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P132_NUM_CPF_CONJUGE_DISPLAY IS NOT NULL THEN',
':P132_NUM_CPF_CONJUGE := substr(trim(replace(translate(:P132_NUM_CPF_CONJUGE_DISPLAY,''.-'','' ''),'' '','''')),1,9);',
':P132_DC_CPF_CONJUGE := substr(trim(replace(translate(:P132_NUM_CPF_CONJUGE_DISPLAY,''.-'','' ''),'' '','''')),10,2);',
'ELSE',
':P132_NUM_CPF_CONJUGE := NULL;',
':P132_DC_CPF_CONJUGE := NULL;',
'END IF;'))
,p_attribute_02=>'P132_NUM_CPF_CONJUGE_DISPLAY'
,p_attribute_03=>'P132_NUM_CPF_CONJUGE,P132_DC_CPF_CONJUGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175352096836836835)
,p_name=>unistr('Popula Num CPF M\00E3e')
,p_event_sequence=>380
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_CPF_MAE_DEPEND_DISPLAY'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175352522689836836)
,p_event_id=>wwv_flow_api.id(254175352096836836835)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P132_CPF_MAE_DEPEND_DISPLAY IS NOT NULL THEN',
':P132_CPF_MAE_DEPEND := substr(trim(replace(translate(:P132_CPF_MAE_DEPEND_DISPLAY,''.-'','' ''),'' '','''')),1,9);',
':P132_DC_CPF_MAE_DEPEND := substr(trim(replace(translate(:P132_CPF_MAE_DEPEND_DISPLAY,''.-'','' ''),'' '','''')),10,2);',
'ELSE',
':P132_CPF_MAE_DEPEND := NULL;',
':P132_DC_CPF_MAE_DEPEND := NULL;',
'END IF;'))
,p_attribute_02=>'P132_CPF_MAE_DEPEND_DISPLAY'
,p_attribute_03=>'P132_CPF_MAE_DEPEND,P132_DC_CPF_MAE_DEPEND'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254175353883201836837)
,p_name=>'Popula Decl Nasc Vivos'
,p_event_sequence=>390
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DECL_NASC_VIVOS_DISPLAY'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254175354317880836837)
,p_event_id=>wwv_flow_api.id(254175353883201836837)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P132_DECL_NASC_VIVOS_DISPLAY is not null then',
':P132_DECL_NASC_VIVOS := TO_NUMBER(trim(replace(translate(:P132_DECL_NASC_VIVOS_DISPLAY,''-'','' ''),'' '','''')));',
'end if;'))
,p_attribute_02=>'P132_DECL_NASC_VIVOS_DISPLAY'
,p_attribute_03=>'P132_DECL_NASC_VIVOS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(245778375819816581397)
,p_name=>'(Enable/Disable) IR/SF/Vac./Freq.'
,p_event_sequence=>400
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_IDADE,P132_CONDICAO_DEPEND,P132_GRAU_PARENTESCO,P132_FREQ_ESCOLAR,P132_CART_VACIN'
,p_condition_element=>'P132_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(245778375793984581396)
,p_event_id=>wwv_flow_api.id(245778375819816581397)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P132_INCID_IR'').enable();',
'if (apex.item(''P132_DATA_BAIXA'').getValue().length == 0){',
'    //apex.item(''P132_INCID_IR'').disable();',
'    apex.item(''P132_INCID_IR'').setValue(''N'');',
'   ',
'}',
'',
'if (',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''FO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''FA'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''DO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''DA'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''NO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''NA'' ',
'   ){',
'		',
'		   if (',
'		   	   Number(apex.item(''P132_IDADE'').getValue()) > 24 && ',
'			     apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N''',
'		   	  )',
'		   {',
'           ',
'            apex.item(''P132_INCID_IR'').setValue(''N'');',
'		   	apex.item(''P132_INCID_IR'').disable();',
'		   	',
'		   }else{',
'            apex.item(''P132_INCID_IR'').enable(); ',
'            apex.item(''P132_INCID_IR'').setValue(''S'');   ',
'		    ',
'		    ',
'		   }',
'',
'	if (Number(apex.item(''P132_IDADE'').getValue()) <= 14) {',
'     ',
'		apex.item(''P132_CART_VACIN'').enable();',
'		apex.item(''P132_FREQ_ESCOLAR'').enable();',
'	}else{',
'       ',
'      //  apex.item(''P132_CART_VACIN'').setValue(''N'');',
'		apex.item(''P132_CART_VACIN'').disable();',
'        ',
'       ',
'	//	apex.item(''P132_FREQ_ESCOLAR'').setValue(''N'');',
'		apex.item(''P132_FREQ_ESCOLAR'').disable();',
'		',
'	}',
'',
'} else{',
'       ',
'      //  apex.item(''P132_CART_VACIN'').setValue(''N'');',
'		apex.item(''P132_CART_VACIN'').disable();',
'        ',
'       ',
'	//	apex.item(''P132_FREQ_ESCOLAR'').setValue(''N'');',
'		apex.item(''P132_FREQ_ESCOLAR'').disable();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(245817489855373247249)
,p_event_id=>wwv_flow_api.id(245778375819816581397)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P132_INCID_SF'').disable();',
'',
'//apex.item(''P132_INCID_SF'').setValue(''N'');',
'',
'',
'if (',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''FO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''FA'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''DO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''DA'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''NO'' ||',
'    apex.item(''P132_GRAU_PARENTESCO'').getValue() == ''NA'' ',
'   ) {',
'		',
'     if (',
'         Number(apex.item(''P132_IDADE'').getValue()) > 14 && ',
'         (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''U'')',
'        )',
'		    {',
'               ',
'                apex.item(''P132_INCID_SF'').setValue(''N'');',
'		    	apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
'  ',
'     if (',
'         (Number(apex.item(''P132_IDADE'').getValue()) >= 7 && ',
'          Number(apex.item(''P132_IDADE'').getValue()) <= 14) && ',
'         (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''U'') &&',
'         (apex.item(''P132_FREQ_ESCOLAR'').getValue() == ''S'')',
'        )',
'		    {',
'                ',
'		    	apex.item(''P132_INCID_SF'').setValue(''S'');',
'                apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
'    ',
'     if (',
'         (Number(apex.item(''P132_IDADE'').getValue()) >= 7 && ',
'          Number(apex.item(''P132_IDADE'').getValue()) <= 14) && ',
'         (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''U'') &&',
'         (apex.item(''P132_FREQ_ESCOLAR'').getValue() == ''N'')',
'        )',
'		    {',
'		    	',
'                apex.item(''P132_INCID_SF'').setValue(''N'');',
'                apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
' ',
'     if (',
'         (Number(apex.item(''P132_IDADE'').getValue()) < 7) && ',
'         (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''I'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''U'') &&',
'         (apex.item(''P132_CART_VACIN'').getValue() == ''S'')',
'        )',
'		    {',
'                apex.item(''P132_INCID_SF'').enable();',
'		    	apex.item(''P132_INCID_SF'').setValue(''S'');',
'                apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
'',
'     if (',
'         (Number(apex.item(''P132_IDADE'').getValue()) < 7) && ',
'         (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''N'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''I'' ||',
'          apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''U'') &&',
'         (apex.item(''P132_CART_VACIN'').getValue() == ''N'')',
'        )',
'		    {',
'                ',
'                apex.item(''P132_INCID_SF'').setValue(''N'');',
'		    	apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
'   ',
'     if (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''I'')',
'		    {',
'               ',
'		    	apex.item(''P132_INCID_SF'').setValue(''S'');',
'                apex.item(''P132_INCID_SF'').disable();',
'		    	',
'		    }',
'  ',
'  ',
'	if (Number(apex.item(''P132_IDADE'').getValue()) <= 14) {',
'		apex.item(''P132_CART_VACIN'').enable();',
'		apex.item(''P132_FREQ_ESCOLAR'').enable();',
'	}',
'    else{',
'       ',
'      //  apex.item(''P132_CART_VACIN'').setValue(''N'');',
'		apex.item(''P132_CART_VACIN'').disable();',
'        	',
'    //    apex.item(''P132_FREQ_ESCOLAR'').setValue(''N'');',
'		apex.item(''P132_FREQ_ESCOLAR'').disable();',
'		',
'	 }  ',
'',
'} else{',
'       ',
'      //  apex.item(''P132_CART_VACIN'').setValue(''N'');',
'		apex.item(''P132_CART_VACIN'').disable();',
'        	',
'    //    apex.item(''P132_FREQ_ESCOLAR'').setValue(''N'');',
'		apex.item(''P132_FREQ_ESCOLAR'').disable();',
'		',
'	 }  ',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(245817229924691690349)
,p_name=>'Seta Idade'
,p_event_sequence=>410
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_DT_NASC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(245778375690652581395)
,p_event_id=>wwv_flow_api.id(245817229924691690349)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'vl_dt_ref_folha date;',
'V_DT_NASC DATE := :P132_dt_nasc;',
'',
'BEGIN',
'',
'  IF :P132_ROWID IS NULL THEN',
'  ',
'  vl_dt_ref_folha := trunc(sysdate);',
'    /*',
'    BEGIN ',
'      select dt_ref_folha',
'        into vl_dt_ref_folha',
'        from parametros_recursos_humanos',
'       where cod_empresa = :P132_cod_empresa;',
'    exception ',
'    when others then',
'    null;',
'    end;',
'    */',
'  ',
'  ELSE',
' ',
'    vl_dt_ref_folha := :P132_DT_DEPENDENTE;',
' ',
'  END IF;',
'  ',
'  -- :P132_IDADE := to_number(to_char(trunc((vl_dt_ref_folha - V_DT_NASC)/365)));',
'  :P132_IDADE := floor(MONTHS_BETWEEN(vl_dt_ref_folha, V_DT_NASC) / 12);',
'  ',
'END;'))
,p_attribute_02=>'P132_DT_NASC,P132_ROWID,P132_COD_EMPRESA,P132_DT_DEPENDENTE'
,p_attribute_03=>'P132_IDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(245833694704514645049)
,p_name=>'Modulo - Folha'
,p_event_sequence=>420
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NOT_EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from modulos_sistema',
' where modulo = ''FOLHA''',
'   and ativo = ''S'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(245833694789402645050)
,p_event_id=>wwv_flow_api.id(245833694704514645049)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P132_INCID_SF'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108275418331392333708)
,p_name=>'(Enable/Disable) DTLAUDO'
,p_event_sequence=>430
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P132_CONDICAO_DEPEND'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108275418405847333709)
,p_event_id=>wwv_flow_api.id(108275418331392333708)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item(''P132_CONDICAO_DEPEND'').getValue() == ''I''){',
'  apex.item(''P132_DTLAUDO'').enable();',
'}else {',
'  apex.item(''P132_DTLAUDO'').disable();',
'  apex.item(''P132_DTLAUDO'').setValue('''');',
'}'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175327211534836811)
,p_process_sequence=>160
,p_process_point=>'AFTER_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pintar Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.*',
'from dependentes_temp ip',
'where ip.cod_empresa = :P132_COD_EMPRESA',
'and ip.matricula = :P132_MATRICULA',
'and ip.num_depend = :P132_num_depend;',
'',
'r1 c1%rowtype;',
'',
'cursor c2 is',
'select IP.*',
'from dependentes ip',
'where ip.cod_empresa = :P132_COD_EMPRESA',
'and ip.matricula = :P132_MATRICULA',
'and ip.num_depend = :P132_num_depend;',
'',
'r2 c2%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from dependentes_temp',
'where cod_empresa = :P132_COD_EMPRESA',
'and matricula   = :P132_MATRICULA',
'and num_depend = :P132_num_depend;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'if v_c0.matricula is not null then',
'',
'open c1;',
'fetch c1 into r1;',
'close c1;',
'',
'open c2;',
'fetch c2 into r2;',
'close c2;',
'',
' if nvl(r1.NOME_DEPEND,''Z'') <> nvl(r2.NOME_DEPEND,''Z'')    then',
'     begin htp.script(''P132_NOME_DEPEND.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
' if nvl(r1.CONDICAO_DEPEND,''Z'') <> nvl(r2.CONDICAO_DEPEND,''Z'')    then',
'     begin htp.script(''P132_CONDICAO_DEPEND.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
' if nvl(r1.SEXO_DEPEND,''Z'') <> nvl(r2.SEXO_DEPEND,''Z'')    then',
'     begin htp.script(''P132_SEXO_DEPEND.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.GRAU_PARENTESCO,''Z'') <> nvl(r2.GRAU_PARENTESCO,''Z'')    then',
'     begin htp.script(''P132_GRAU_PARENTESCO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
' if nvl(r1.DT_DEPENDENTE,sysdate) <> nvl(r2.DT_DEPENDENTE,sysdate)    then',
'     begin htp.script(''P132_DT_DEPENDENTE.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
' if nvl(r1.DT_NASC,sysdate) <> nvl(r2.DT_NASC,sysdate)    then',
'     begin htp.script(''P132_DT_NASC.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
'   if nvl(r1.CIDADE_NASC,''Z'') <> nvl(r2.CIDADE_NASC,''Z'')    then',
'     begin htp.script(''P132_CIDADE_NASC.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.EST_NASC,''Z'') <> nvl(r2.EST_NASC,''Z'')     then',
'     begin htp.script(''P132_EST_NASC.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.PAIS_NASCIMENTO,0) <> nvl(r2.PAIS_NASCIMENTO,0)     then',
'     begin htp.script(''P132_PAIS_NASCIMENTO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.PAIS_NACIONALIDADE,0) <> nvl(r2.PAIS_NACIONALIDADE,0)     then',
'     begin htp.script(''P132_PAIS_NACIONALIDADE.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_CPF_CONJUGE,0) <> nvl(r2.NUM_CPF_CONJUGE,0)    then',
'     begin htp.script(''P132_NUM_CPF_CONJUGE_DISPLAY.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.DC_CPF_CONJUGE,0) <> nvl(r2.DC_CPF_CONJUGE,0)    then',
'     begin htp.script(''P132_NUM_CPF_CONJUGE_DISPLAY.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if; ',
'',
'  if nvl(r1.IND_AGREGADO,0) <> nvl(r2.IND_AGREGADO,0)    then',
'     begin htp.script(''P132_IND_AGREGADO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if; ',
' ',
'  if nvl(r1.CARTORIO,''Z'') <> nvl(r2.CARTORIO,''Z'')     then',
'     begin htp.script(''P132_CARTORIO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_REGISTRO,''Z'') <> nvl(r2.NUM_REGISTRO,''Z'')     then',
'     begin htp.script(''P132_NUM_REGISTRO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
'  if nvl(r1.NUM_LIVRO,''Z'') <> nvl(r2.NUM_LIVRO,''Z'')     then',
'     begin htp.script(''P132_NUM_LIVRO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_FOLHA,''Z'') <> nvl(r2.NUM_FOLHA,''Z'')     then',
'     begin htp.script(''P132_NUM_FOLHA.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.DATA_CERTIDAO,sysdate) <> nvl(r2.DATA_CERTIDAO,sysdate)    then',
'     begin htp.script(''P132_DATA_CERTIDAO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.TIPO_CERTIDAO,''Z'') <> nvl(r2.TIPO_CERTIDAO,''Z'')     then',
'     begin htp.script(''P132_TIPO_CERTIDAO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.DECL_NASC_VIVOS,0) <> nvl(r2.DECL_NASC_VIVOS,0)    then',
'     begin htp.script(''P132_DECL_NASC_VIVOS_DISPLAY.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.MAE_DEPEND,''Z'') <> nvl(r2.MAE_DEPEND,''Z'')    then',
'     begin htp.script(''P132_MAE_DEPEND.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.CPF_MAE_DEPEND,0) <> nvl(r2.CPF_MAE_DEPEND,0)    then',
'     begin htp.script(''P132_CPF_MAE_DEPEND_DISPLAY.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.DC_CPF_MAE_DEPEND,0) <> nvl(r2.DC_CPF_MAE_DEPEND,0)    then',
'     begin htp.script(''P132_CPF_MAE_DEPEND_DISPLAY.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if; ',
' ',
'  if nvl(r1.INCID_IR,''Z'') <> nvl(r2.INCID_IR,''Z'')    then',
'     begin htp.script(''P132_INCID_IR.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.INCID_SF,''Z'') <> nvl(r2.INCID_SF,''Z'')    then',
'     begin htp.script(''P132_INCID_SF.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.CART_VACIN,''Z'') <> nvl(r2.CART_VACIN,''Z'')    then',
'     begin htp.script(''P132_CART_VACIN.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
'  if nvl(r1.FREQ_ESCOLAR,''Z'') <> nvl(r2.FREQ_ESCOLAR,''Z'')    then',
'     begin htp.script(''P132_FREQ_ESCOLAR.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if; ',
'',
'  if nvl(r1.MANEQUIM,''Z'') <> nvl(r2.MANEQUIM,''Z'')    then',
'     begin htp.script(''P132_MANEQUIM.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
'',
'  if nvl(r1.CALCADO,''Z'') <> nvl(r2.CALCADO,''Z'')    then',
'     begin htp.script(''P132_CALCADO.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.EXCLUIR_DEPENDENTE,''Z'') = ''S'' then',
'     begin htp.script(''P132_EXCLUIR_DEPENDENTE.style.backgroundColor = "yellow"'',''Javascript''); end;',
' end if;',
' ',
' end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175331154921836816)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from DEPENDENTES_TEMP'
,p_attribute_02=>'DEPENDENTES_TEMP'
,p_attribute_03=>'P132_COD_REQUISICAO'
,p_attribute_04=>'COD_REQUISICAO'
,p_process_when=>'P132_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175332387261836817)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'begin',
'',
'if :p132_rowid is not null then',
unistr('   :p132_titulo := ''Requisi\00E7\00E3o de Dependentes: N\00BA ''||:P132_COD_REQUISICAO||'' - ''||:P132_DATA_REQUISICAO;'),
'else',
unistr('   :p132_titulo := ''Requisi\00E7\00E3o de Dependentes'';'),
'end if;',
'',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175332720427836818)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
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
' where i.cod_empresa = :p132_cod_empresa',
'   and i.matricula = :p132_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'',
'begin',
'',
'if :p132_cod_requisicao is null and :p132_seq is null then',
':p132_seq := :p_candidato||to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'end if;',
'',
'if :p132_cod_requisicao is not null then',
'  :P132_COD_REQ_ANT := :p132_COD_REQUISICAO;',
'end if;',
'',
'IF :p132_MAT_SOLICITANTE IS NULL THEN',
':p132_COD_EMP_SOLICITANTE := NVL(:P_EMPRESA_USER,:P_EMP);',
':p132_MAT_SOLICITANTE := NVL(:P_MATRICULA_USER,:P_MAT);',
'END IF;',
'',
':p132_solicitante := :p132_COD_EMP_SOLICITANTE||'' / ''||:p132_MAT_SOLICITANTE||'' - ''||iNITCAP(fnct_nome_func(:p132_COD_EMP_SOLICITANTE, :p132_MAT_SOLICITANTE));',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p132_cod_empresa_display := v_c1.empresa;',
':p132_matricula_display := v_c1.matricula;',
':p132_situacao_colab := v_c1.situacao;',
':p132_dt_admissao := v_c1.dt_admissao;',
'',
':P132_DESC_VL_PL_MEDICO := ''S'';',
':P132_DESC_VL_PL_ODONTO := ''S'';',
'',
'exception',
'when others then',
':p132_cod_empresa_display := :p132_cod_empresa;',
':p132_matricula_display := :p132_matricula;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175330761434836815)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Popula campos padr\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p132_cod_requisicao is null and :P132_NUM_DEPEND is null then',
'',
':P132_INCID_IR := ''N'';',
':P132_INCID_SF := ''N'';',
':P132_FREQ_ESCOLAR := ''N'';',
':P132_CART_VACIN := ''N'';',
':P132_DT_DEPENDENTE := sysdate;',
':P132_IND_AGREGADO := ''N'';',
':P132_CONDICAO_DEPEND := ''N'';',
'',
'',
':P132_DESC_VL_PL_MEDICO := ''S'';',
':P132_DESC_VL_PL_ODONTO := ''S'';',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175330324126836815)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SE NULO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C_TIPO_ES(V_GRAU VARCHAR2, V_CONDICAO VARCHAR2) IS',
' select cod',
'   from tipo_dependente_es',
'  where grau_parentesco = V_GRAU ',
'    and condicao = v_condicao;',
'',
'v_tipo_es c_tipo_es%rowtype;',
'',
'BEGIN',
'',
'IF :P132_INCID_PLANO_MED IS NULL THEN',
':P132_INCID_PLANO_MED := ''N'';',
'END IF;',
'',
'IF :P132_INCID_IR IS NULL THEN',
':P132_INCID_IR := ''N'';',
'END IF;',
'',
'IF :P132_INCID_SF IS NULL THEN',
':P132_INCID_SF := ''N'';',
'END IF;',
'',
'IF :p132_MAT_SOLICITANTE IS NULL THEN',
':p132_COD_EMP_SOLICITANTE := NVL(:P_EMPRESA_USER,:P_EMP);',
':p132_MAT_SOLICITANTE := NVL(:P_MATRICULA_USER,:P_MAT);',
'END IF;',
'',
'IF :P132_DECL_NASC_VIVOS_DISPLAY IS NOT NULL THEN',
':P132_DECL_NASC_VIVOS := TO_NUMBER(trim(replace(translate(:P132_DECL_NASC_VIVOS_DISPLAY,''-'','' ''),'' '','''')));',
'END IF;',
'',
'',
'if :P132_NUM_CPF_CONJUGE_DISPLAY is not null then',
':P132_NUM_CPF_CONJUGE := substr(trim(replace(translate(:P132_NUM_CPF_CONJUGE_DISPLAY,''.-'','' ''),'' '','''')),1,9);',
':P132_DC_CPF_CONJUGE := substr(trim(replace(translate(:P132_NUM_CPF_CONJUGE_DISPLAY,''.-'','' ''),'' '','''')),10,2);',
'end if;',
'',
'if :P132_CPF_MAE_DEPEND_DISPLAY is not null then',
':P132_CPF_MAE_DEPEND := substr(trim(replace(translate(:P132_CPF_MAE_DEPEND_DISPLAY,''.-'','' ''),'' '','''')),1,9);',
':P132_DC_CPF_MAE_DEPEND := substr(trim(replace(translate(:P132_CPF_MAE_DEPEND_DISPLAY,''.-'','' ''),'' '','''')),10,2);',
'end if;',
'',
'',
'   open c_tipo_es(:P132_grau_parentesco, :P132_CONDICAO_DEPEND);',
'   fetch c_tipo_es into v_tipo_es;',
'   close c_tipo_es;',
'',
'   :P132_COD_TIPO_ES := V_TIPO_ES.COD;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175327581730836812)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(CREATE) PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'/*',
'  CURSOR C1 IS',
'  SELECT SEQ_ALTERACAO_CADASTRAL.NEXTVAL cod_req',
'  FROM DUAL;	',
'  */',
'  cursor c2 is',
'  select dc_matricula',
'    from informacoes_funcionais',
'   where cod_empresa = :p132_cod_empresa',
'     and matricula = :p132_matricula;',
'     ',
'  v_c2 c2%rowtype;',
'     ',
'  ',
'BEGIN',
'	--',
'	:p132_dt_atualizacao := Sysdate;                                  ',
'	:p132_usuario        := :P_USUARIO;      ',
'',
'       :P132_AUX_EXCEPCIONAL := ''N'';',
'       ',
'       :P132_INCID_AUX_CRECHE := ''N'';',
'/*',
'		 OPEN C1;',
'		 FETCH C1 INTO :p132_COD_REQUISICAO;',
'		 CLOSE C1;',
'         */',
'         open c2;',
'         fetch c2 into v_c2;',
'         close c2;',
'         ',
'         :p132_dc_matricula := v_c2.dc_matricula;',
'',
'	   :p132_DATA_REQUISICAO      := sysdate;',
'',
'END;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296593788836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175327999946836813)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(CREATE) Novo Dependente'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select nvl(max(num_depend),0)+1 num_depend',
'		into :p132_num_depend',
'	  from (SELECT NUM_DEPEND',
'					  FROM DEPENDENTES ',
'					 WHERE COD_EMPRESA = :p132_cod_empresa ',
'					   AND MATRICULA   = :p132_matricula',
'					union',
'					select num_depend	 					   ',
'						from dependentes_TEMP',
'					 where cod_empresa = :p132_cod_empresa ',
'					   and matricula   = :p132_matricula);',
'',
'exception',
'when no_data_found then',
':p132_num_depend := 1;',
'when others then',
':p132_ok := ''N'';',
':p132_flag := ''N'';',
unistr(':p132_mensagem := ''Erro ao calcular n\00FAmero de dependente.'';'),
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296593788836777)
,p_process_when=>'P132_NUM_DEPEND'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175328377212836813)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(CREATE) PROCESSA CADASTRO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_seq      number;',
'  v_processo number(38);',
'  v_ret     varchar2(2000);',
'  V_MSG     VARCHAR2(4000);',
'  ',
'  CURSOR C1 IS ',
'  SELECT PROCESSO',
'  FROM APLICACOES',
'  WHERE APLICACAO = ''FP15018'';',
'',
'  V_C1 C1%ROWTYPE;',
'  ',
'  cursor c2 is',
'  select cod_empresa, matricula, filial, cod_ccusto',
'    from informacoes_funcionais',
'   where cod_empresa = :p132_cod_empresa',
'     and matricula = :p132_matricula;',
'     ',
'  v_c2 c2%rowtype;',
'  ',
'  v_Dependentes varchar2(4000);',
'  ',
'  SAIDA EXCEPTION;',
'  ',
'BEGIN',
'	--',
'    v_dependentes := :p132_nome_depend||'', '';',
unistr('	v_dependentes := ''Requisi\00E7\00E3o de Inclus\00E3o e Altera\00E7\00E3o de Dependentes. ''||''Matr\00EDcula: ''||:p132_Matricula||'' - ''||initcap(fnct_nome_func(:p132_Cod_Empresa,:p132_Matricula))||'' - Nomes dos Dependentes: ''||v_dependentes;'),
'  ',
'  OPEN  C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;  ',
'  ',
'  OPEN  C2;',
'  FETCH C2 INTO V_C2;',
'  CLOSE C2;  ',
'  ',
'  Obtem_Processo(V_C1.PROCESSO,',
'	               :p132_Cod_Empresa,',
'	               v_c2.filial,',
'	  	           :p_usuario,',
'	  	           substr(v_dependentes,1,length(v_dependentes)-1),',
'                 v_seq,',
'                 v_processo,',
'	  	           v_ret, ',
'	  	           V_MSG);',
'',
'  IF nvl(v_ret,''S'') = ''S'' THEN	 ',
'    Proc_Insere_Payroll(:p132_Cod_Empresa,',
'                        v_c2.Filial,',
'                        :p132_Matricula,',
'                        :p132_DATA_SOLICITACAO,',
'                        v_c2.COD_CCUSTO,',
'                        v_processo,',
'     	                  V_C1.PROCESSO,',
'                        :p132_COD_REQUISICAO,',
'                        v_seq,',
'                        v_ret);',
'    V_processo := v_processo; ',
'  else ',
'  :P132_MENSAGEM := V_MSG;',
' 	  raise SAIDA;',
'  end if;  ',
'',
'  IF V_RET = ''S'' THEN',
'   	  COMMIT;',
'      :P132_FLAG := ''S'';',
'      :P132_OK := ''S'';',
' 	  :P132_MENSAGEM := null;',
'  ELSE',
'   ROLLBACK;',
'      :P132_FLAG := ''N'';',
'      :P132_OK := ''N'';',
' 	  :P132_MENSAGEM := V_RET;',
'  END IF;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'  ',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296593788836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175328770790836813)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(SAVE) PRE-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR C1 IS',
'  SELECT SEQ_ALTERACAO_CADASTRAL.NEXTVAL',
'  FROM DUAL;	',
'BEGIN',
'	--',
'	:p132_dt_atualizacao := Sysdate;                                  ',
'	:p132_usuario        := :P_USUARIO;                                ',
'',
'       :P132_AUX_EXCEPCIONAL := ''N'';',
'',
'		 OPEN C1;',
'		 FETCH C1 INTO :p132_COD_REQUISICAO;',
'		 CLOSE C1;',
'',
'	   :p132_DATA_REQUISICAO      := sysdate;',
'',
'END;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296999545836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175329538810836814)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(SAVE) Grava_Historico_Ass_Med1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dummy number;',
'',
'saida exception;',
'',
'begin',
'begin',
'   select 0 into v_dummy',
'   from   historico_ass_med',
'   where  cod_empresa  = :p132_cod_empresa',
'   and    matricula    = :p132_matricula',
'   and    num_depend   = :p132_num_depend;',
'exception',
'   when no_data_found then',
'      begin',
'         insert into historico_ass_med ( COD_EMPRESA    ,',
'                                         MATRICULA      ,',
'                                         NUM_DEPEND     ,',
'                                         USUARIO        ,',
'                                         DT_ATUALIZACAO )',
'                                values ( :p132_cod_empresa  ,',
'                                         :p132_matricula    ,',
'                                         :p132_num_depend   ,',
'                                         user                      ,',
'                                         sysdate                   );',
'                                         ',
'                                         ',
'      exception',
'         when others then',
'            :p132_flag := ''N'';',
'            :p132_ok := ''N'';',
'            :p132_mensagem := ''Erro na insercao da procedure grava_historico_ass_med'';',
'            raise saida;',
'      end;',
'   when others then',
'            :p132_flag := ''N'';',
'            :p132_ok := ''N'';',
'         :p132_mensagem := ''Erro na procedure grava_historico_ass_med'';',
'         raise saida;',
'end;',
'commit;',
'exception',
'when saida then',
'rollback;',
'null;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296999545836777)
,p_process_when=>'P132_INCID_PLANO_MED_ANT'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175329956626836814)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(SAVE) Grava_Historico_Ass_Med2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dummy number;',
'',
'saida exception;',
'',
'v_dt_adesao_ant date := :p132_dt_adesao_ant;',
'',
'begin',
'begin',
'   select 0 into v_dummy',
'   from   historico_ass_med',
'   where  cod_empresa   = :p132_cod_empresa ',
'   and    matricula     = :p132_matricula',
'   and    num_depend    = :p132_num_depend',
'   and    codigo_plano  = :p132_codigo_plano_ant',
'   and    codigo_tipo   = :p132_codigo_tipo_ant',
'   and    data_exclusao is null',
'   group  by cod_empresa, matricula, num_depend, codigo_plano, codigo_tipo;               ',
'   begin',
'      update historico_ass_med',
'      set data_exclusao        = sysdate - 1,',
'          usuario              = user,',
'          dt_atualizacao       = sysdate',
'      where cod_empresa        = :p132_cod_empresa',
'      and   matricula          = :p132_matricula',
'      and   num_depend         = :p132_num_depend',
'      and   codigo_plano       = :p132_codigo_plano_ant',
'      and   codigo_tipo        = :p132_codigo_tipo_ant',
'      and   trunc(data_adesao) = trunc(v_dt_adesao_ant)',
'      and   data_exclusao      is null;',
'   exception',
'      when others then null;',
'   end;',
'exception',
'   when others then null;',
'end;',
'commit;',
'exception',
'when saida then',
'rollback;',
'null;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296999545836777)
,p_process_when=>'P132_INCID_PLANO_MED_ANT'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175331580161836816)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of DEPENDENTES_TEMP'
,p_attribute_02=>'DEPENDENTES_TEMP'
,p_attribute_03=>'P132_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Registro Processado!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175329185857836814)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(SAVE) ON-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select matricula',
'  from dependentes',
' where cod_empresa = :p132_cod_empresa',
'   and matricula = :p132_matricula',
'   and num_depend = :p132_num_depend;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.matricula is not null then',
'',
'DELETE DEPENDENTES_TEMP',
'WHERE  cod_empresa    = :p132_COD_EMPRESA',
'AND    matricula      = :p132_matricula',
'AND    COD_REQUISICAO < :p132_COD_REQUISICAO',
'AND    NUM_DEPEND     = :p132_NUM_DEPEND;',
'',
'commit;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296999545836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175333159980836819)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Create)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update upload_files',
'   set cod_req = :p132_cod_requisicao, cod_sub_item = :p132_num_depend',
'  where cod_empresa = :p132_cod_empresa',
'    and cod_item = :p132_matricula',
'    and tipo_sub_item = 1',
'    and tipo_cod_item = ''COLABORADOR''',
'    and seq = :p132_seq;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296593788836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175333536485836819)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Save)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update upload_files',
'   set cod_req = :p132_cod_requisicao, cod_sub_item = :p132_num_depend',
'  where cod_empresa = nvl(:p_cod_emp_up,:p132_cod_empresa)',
'    and cod_item = nvl(:p_cod_item_up,:p132_matricula)',
'   -- and tipo_cod_item = :p_tipo_cod_item_up',
'    and tipo_sub_item = 1',
'    and tipo_cod_item = ''COLABORADOR''',
'    and cod_req = :P132_COD_REQ_ANT;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175296999545836777)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175334007090836819)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Delete)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from upload_files',
'  where cod_empresa = :p132_cod_empresa',
'    and cod_item = :p132_matricula',
'    and tipo_sub_item = 1',
'    and tipo_cod_item = ''COLABORADOR''',
'    and cod_req = :p132_cod_requisicao;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175297379165836778)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(254175331957820836817)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(254175297379165836778)
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
