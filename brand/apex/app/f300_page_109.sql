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
,p_default_application_id=>300
,p_default_id_offset=>785128738853783604
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 300 - Painel do Colaborador - Natcorp
--
-- Application Export:
--   Application:     300
--   Name:            Painel do Colaborador - Natcorp
--   Date and Time:   23:13 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 109
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00109
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>109);
end;
/
prompt --application/pages/page_00109
begin
wwv_flow_api.create_page(
 p_id=>109
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>'Editar: Metas'
,p_page_mode=>'MODAL'
,p_step_title=>'Editar: Metas'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'var htmldb_ch_message=''"OK_TO_GET_NEXT_PREV_PK_VALUE"'';'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20210503020658'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(145405201147374843862)
,p_plug_name=>'Edit CG_CONTRATOS'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405201676257843862)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>'P109_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405223844116843926)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'GET_NEXT_ROWID'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'javascript:htmldb_goSubmit(''GET_NEXT_ROWID'')'
,p_button_condition=>'P109_ROWID_NEXT'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-right'
,p_button_comment=>'This button is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405223916280843926)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'GET_PREVIOUS_ROWID'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Previous'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'javascript:htmldb_goSubmit(''GET_PREVIOUS_ROWID'')'
,p_button_condition=>'P109_ROWID_PREV'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-chevron-left'
,p_button_comment=>'This button is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405201825400843862)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:106:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405201492943843862)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P109_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405201762493843862)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition=>'P109_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145405335538417280549)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_button_name=>'FEEDBACK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Feedback'
,p_button_position=>'REGION_TEMPLATE_HELP'
,p_button_redirect_url=>'f?p=&APP_ID.:110:&SESSION.::&DEBUG.:RP,110:P110_COD_EMPRESA,P110_COD_CONTRATO,P110_COD_CICLO,P110_SEQUENCIA,P110_EMP_AVAL,P110_MAT_AVAL,P110_STATUS_CONTRATO,P110_HABILITA_CREATE:&P109_COD_EMPRESA.,&P109_COD_CONTRATO.,&P109_COD_CICLO.,&P109_SEQUENCIA.,&P109_EMP_AVAL.,&P109_MAT_AVAL.,&P109_STATUS_CONTRATO.,&P109_BTN_FEEDBACK.'
,p_icon_css_classes=>'fa-comments'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(145405203410833843866)
,p_branch_name=>'Go To Page 106'
,p_branch_action=>'f?p=&APP_ID.:106:&SESSION.::&DEBUG.::P106_ALTERADO:&P109_ALTERADO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>30
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(145405234674480843944)
,p_branch_action=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.::P109_ROWID:&P109_ROWID_NEXT.'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(145405223844116843926)
,p_branch_sequence=>10
,p_branch_comment=>'This button is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(145405235073205843944)
,p_branch_action=>'f?p=&APP_ID.:109:&SESSION.::&DEBUG.::P109_ROWID:&P109_ROWID_PREV.'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(145405223916280843926)
,p_branch_sequence=>20
,p_branch_comment=>'This button is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405203800788843880)
,p_name=>'P109_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405204214834843896)
,p_name=>'P109_COD_CONTRATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405204547232843899)
,p_name=>'P109_COD_EMPRESA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405204979310843900)
,p_name=>'P109_MATRICULA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405205356386843900)
,p_name=>'P109_FILIAL_MAT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'FILIAL_MAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405205745410843900)
,p_name=>'P109_CCUSTO_MAT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'CCUSTO_MAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405206151072843901)
,p_name=>'P109_CARGO_MAT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'CARGO_MAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405206509257843901)
,p_name=>'P109_COD_CICLO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CICLO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405206889834843901)
,p_name=>'P109_COD_DIMENSAO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_DIMENSAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405207370367843902)
,p_name=>'P109_COD_CATEGORIA'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Categoria'
,p_source=>'COD_CATEGORIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'   select cc.cod_categoria||'' - ''||Initcap(cc.descr_categoria) descr_categoria, cc.cod_categoria',
'     from cg_categorias cc',
'     where cc.ind_ativo = ''S''',
'   union',
'   select cc.cod_categoria||'' - ''||Initcap(cc.descr_categoria) descr_categoria, cc.cod_categoria',
'     from  cg_contratos cco',
'          ,cg_categorias cc',
'     where cc.cod_categoria = cco.cod_categoria',
'     and cco.cod_contrato = :p109_cod_contrato',
'     and cco.cod_empresa  = :p109_cod_empresa',
'     order by 1, 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405207774281843902)
,p_name=>'P109_COD_OBJETIVO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Objetivo'
,p_source=>'COD_OBJETIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'       select cod_objetivo||'' - ''||initcap(descr_objetivo) descr_objetivo, cod_objetivo',
'       from cg_objetivos where ind_ativo = ''S''',
'		   union',
'		   select  co.cod_objetivo||'' - ''||initcap(co.descr_objetivo) descr_objetivo, co.cod_objetivo',
'		   from   cg_contratos cco',
'		         ,cg_objetivos co',
'		   where  co.cod_objetivo  = cco.cod_objetivo',
'		   and    cco.cod_contrato = :p109_cod_contrato',
'		   and    cco.cod_empresa  = :p109_cod_empresa',
'		   order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405208164100843902)
,p_name=>'P109_PERC_PESO'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Peso'
,p_source=>'PERC_PESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405208558429843903)
,p_name=>'P109_ACAO'
,p_is_required=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('A\00E7\00E3o')
,p_source=>'ACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>1000
,p_cHeight=>4
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405208968364843904)
,p_name=>'P109_TIPO_META'
,p_is_required=>true
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Meta'
,p_source=>'TIPO_META'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Valor;V,Percentual;P'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405209373981843904)
,p_name=>'P109_META'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Meta'
,p_source=>'META'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405209760953843905)
,p_name=>'P109_DT_ATUALIZACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405210102050843906)
,p_name=>'P109_USUARIO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405210512594843907)
,p_name=>'P109_META_DATA'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'META_DATA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405210907032843909)
,p_name=>'P109_CLASSIF_META'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'CLASSIF_META'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405211307864843909)
,p_name=>'P109_META_EMPRESA'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'META_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405211735357843909)
,p_name=>'P109_STATUS'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405212084488843910)
,p_name=>'P109_TIPO_STATUS'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_STATUS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405212545834843910)
,p_name=>'P109_VALOR_ATINGIDO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor Atingido'
,p_source=>'VALOR_ATINGIDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_column=>7
,p_grid_label_column_span=>2
,p_display_when=>'P109_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405212891880843910)
,p_name=>'P109_PERC_ATINGIDO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'% Atingido'
,p_source=>'PERC_ATINGIDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_column=>7
,p_grid_label_column_span=>2
,p_display_when=>'P109_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405213360846843911)
,p_name=>'P109_DESEMP_ATINGIDO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Desempenho Atingido'
,p_source=>'DESEMP_ATINGIDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_grid_column=>6
,p_grid_label_column_span=>3
,p_display_when=>'P109_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405213758646843911)
,p_name=>'P109_IND_ACEITE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_ACEITE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405214155968843911)
,p_name=>'P109_SEQUENCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00BA')
,p_source=>'SEQUENCIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'onchange="htmldb_item_change(this)"'
,p_colspan=>6
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405232390388843934)
,p_name=>'P109_ROWID_NEXT'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>'This item is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405232840293843934)
,p_name=>'P109_ROWID_PREV'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>'This item is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405233227315843935)
,p_name=>'P109_ROWID_COUNT'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_tag_attributes=>'class="fielddata"'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'N'
,p_item_comment=>'This item is needed for Get Next or Previous Primary Key Value process.'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405331993033280514)
,p_name=>'P109_OK'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_source=>'S'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405332163662280515)
,p_name=>'P109_FLAG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405332281405280516)
,p_name=>'P109_MENSAGEM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405332547033280519)
,p_name=>'P109_VL_META_BKP'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405501587993290114)
,p_name=>'P109_EMP_AVAL'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405501736083290115)
,p_name=>'P109_MAT_AVAL'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405502367054290121)
,p_name=>'P109_STATUS_CONTRATO'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405504608914290144)
,p_name=>'P109_VLD_VALOR_ATINGIDO'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405504744571290145)
,p_name=>'P109_BTN_CREATE'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405504831183290146)
,p_name=>'P109_BTN_SAVE'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405504960764290147)
,p_name=>'P109_BTN_DELETE'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405505074594290148)
,p_name=>'P109_BTN_FEEDBACK'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145405587255175174312)
,p_name=>'P109_ALTERADO'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(145405201147374843862)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405351313176636201)
,p_name=>'Dispara Alerta'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_MENSAGEM'
,p_condition_element=>'P109_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405351705157636204)
,p_event_id=>wwv_flow_api.id(145405351313176636201)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P109_FLAG'').value == "Q") {',
'alertify.confirm($v(''P109_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P109_FLAG'').value = ''S'';',
'        $x(''P109_MENSAGEM'').value = '''';',
'        $x(''P109_OK'').value = ''S'';',
'       // $(''#P109_CREATE'').show();',
'    } else {',
'        $x(''P109_OK'').value = ''N'';',
'       // $(''#P109_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P109_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P109_FLAG'').value == "N") {',
'            $x(''P109_OK'').value = ''N'';',
'           // $(''#P109_CREATE'').hide();',
'        } else {',
'            $x(''P109_OK'').value = ''S'';',
'           // $(''#P109_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P109_MENSAGEM''));',
'    }else{',
'            $x(''P109_OK'').value = ''S'';',
'           // $(''#P109_CREATE'').show();',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405352126652637948)
,p_name=>'Inicia Alertify'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405352503945637948)
,p_event_id=>wwv_flow_api.id(145405352126652637948)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Iniciando Alertify'
,p_attribute_07=>'Ok'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405332320076280517)
,p_name=>'when-validate-item'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_TIPO_META'
,p_condition_element=>'P109_TIPO_META'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405332478870280518)
,p_event_id=>wwv_flow_api.id(145405332320076280517)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P109_IND_ACEITE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'R'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405332908102280523)
,p_name=>'prc_perc_atingido'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_VALOR_ATINGIDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405332990813280524)
,p_event_id=>wwv_flow_api.id(145405332908102280523)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p109_mensagem := null;',
' :p109_ok       := ''S'';',
'',
'pkg_cg_contratos.Prc_Perc_Atingido (:p109_Cod_empresa,',
'                             :p109_Cod_ciclo,',
'                             :p109_Meta,',
'                             :p109_Cod_objetivo,',
'                             :p109_Valor_atingido,',
'                             :p109_Perc_atingido,',
'                             v_Flg_retorno,',
'                             v_Msg_retorno',
'                            );',
' ',
' if trim(v_msg_retorno) is not null then',
'    :p109_ok       := ''N'';',
'    :p109_flag     := v_flg_retorno;',
'    :p109_mensagem := v_msg_retorno;',
' else',
'    :p109_flag     := null;',
'    :p109_mensagem := null;',
'    :p109_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P109_COD_EMPRESA,P109_COD_CICLO,P109_META,P109_COD_OBJETIVO,P109_VALOR_ATINGIDO'
,p_attribute_03=>'P109_PERC_ATINGIDO,P109_FLAG,P109_MENSAGEM,P109_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405333180605280525)
,p_name=>'prc_desemp_atingido'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_VALOR_ATINGIDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405333194864280526)
,p_event_id=>wwv_flow_api.id(145405333180605280525)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p109_mensagem := null;',
' :p109_ok       := ''S'';',
'',
'pkg_cg_contratos.Prc_Desemp_Atingido (:p109_Cod_empresa,',
'                             :p109_Cod_ciclo,',
'                             :p109_Perc_peso,',
'                             :p109_Perc_atingido,',
'                             :p109_Desemp_atingido,',
'                             v_Flg_retorno,',
'                             v_Msg_retorno',
'                            );',
' ',
' if trim(v_msg_retorno) is not null then',
'    :p109_ok       := ''N'';',
'    :p109_flag     := v_flg_retorno;',
'    :p109_mensagem := v_msg_retorno;',
' else',
'    :p109_flag     := null;',
'    :p109_mensagem := null;',
'    :p109_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P109_COD_EMPRESA,P109_COD_CICLO,P109_PERC_PESO,P109_PERC_ATINGIDO'
,p_attribute_03=>'P109_DESEMP_ATINGIDO,P109_FLAG,P109_MENSAGEM,P109_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145369651663545881788)
,p_name=>unistr('Hab/ Desab Bot\00F5es')
,p_event_sequence=>58
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145369651799299881789)
,p_event_id=>wwv_flow_api.id(145369651663545881788)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_cg_contratos.hab_des_cg_contratos_colab (:p109_cod_empresa,',
'                                       :p109_cod_contrato,',
'                                       :p109_cancelado,',
'                                       :p109_status_contrato,',
'                                       :p109_cod_ciclo,',
'                                       :p109_matricula,',
'                                       :p_usuario,',
'                                       :p109_vld_valor_atingido,',
'                                       :p109_btn_create,',
'                                       :p109_btn_save,',
'                                       :p109_btn_delete,',
'                                       :p109_btn_feedback);',
'end;',
''))
,p_attribute_02=>'P109_COD_EMPRESA,P109_COD_CONTRATO,P109_CANCELADO,P109_STATUS_CONTRATO,P109_COD_CICLO,P109_MATRICULA,P_USUARIO'
,p_attribute_03=>'P109_VLD_VALOR_ATINGIDO,P109_BTN_CREATE,P109_BTN_SAVE,P109_BTN_DELETE,P109_BTN_FEEDBACK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405333806911280532)
,p_name=>'Esconder Campos'
,p_event_sequence=>60
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P109_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405333935367280533)
,p_event_id=>wwv_flow_api.id(145405333806911280532)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P109_SEQUENCIA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405505274673290150)
,p_name=>'Hab / Desab Valor Atingido'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_VLD_VALOR_ATINGIDO'
,p_condition_element=>'P109_VLD_VALOR_ATINGIDO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405505349007290151)
,p_event_id=>wwv_flow_api.id(145405505274673290150)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P109_VALOR_ATINGIDO,P109_PERC_ATINGIDO,P109_DESEMP_ATINGIDO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405587815698174318)
,p_event_id=>wwv_flow_api.id(145405505274673290150)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P109_VALOR_ATINGIDO,P109_PERC_ATINGIDO,P109_DESEMP_ATINGIDO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405586294931174303)
,p_name=>'Hab / Desab Create'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_BTN_CREATE'
,p_condition_element=>'P109_BTN_CREATE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405586386762174304)
,p_event_id=>wwv_flow_api.id(145405586294931174303)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201492943843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405586551560174305)
,p_event_id=>wwv_flow_api.id(145405586294931174303)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201492943843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405586620019174306)
,p_name=>'Hab / Desab Save'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_BTN_SAVE'
,p_condition_element=>'P109_BTN_SAVE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405586759570174307)
,p_event_id=>wwv_flow_api.id(145405586620019174306)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201676257843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405586821099174308)
,p_event_id=>wwv_flow_api.id(145405586620019174306)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201676257843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145405586914294174309)
,p_name=>'Hab / Desab Delete'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_BTN_DELETE'
,p_condition_element=>'P109_BTN_DELETE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405587014143174310)
,p_event_id=>wwv_flow_api.id(145405586914294174309)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201762493843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145405587175218174311)
,p_event_id=>wwv_flow_api.id(145405586914294174309)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201762493843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145335399569869194671)
,p_name=>'Valida Peso'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_PERC_PESO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145335399697448194672)
,p_event_id=>wwv_flow_api.id(145335399569869194671)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sum_perc_peso number;',
'',
'v_perc_peso number := :p109_perc_peso;',
'',
'begin',
'',
'    begin',
'    select sum(c.perc_peso) peso',
'      into v_sum_perc_peso',
'      from cg_contratos c, cg_objetivos co, cg_categorias cc',
'     where c.cod_objetivo = co.cod_objetivo (+)',
'       and c.cod_categoria = cc.cod_categoria (+)',
'       and c.cod_empresa = :p109_cod_empresa',
'       and c.cod_contrato = :p109_cod_contrato',
'       and c.sequencia <> :p109_sequencia;',
'',
'    exception',
'    when no_data_found then',
'    null;',
'    end;',
'',
'    ',
'   if (nvl(v_sum_perc_peso,0) + nvl(v_perc_peso,0)) > 100 then',
'   ',
'       :p109_flag := ''N'';',
'       :p109_ok := ''N'';',
unistr('       :p109_mensagem := ''A somat\00F3ria de todos os pesos dos itens est\00E1 retornando mais de 100%. Total: ''||(nvl(v_sum_perc_peso,0) + nvl(v_perc_peso,0))||''%.'';'),
'   ',
'   else',
'   ',
'     :p109_flag := null;',
'     :p109_mensagem := null;',
'     :p109_ok       := ''S'';',
'',
'   end if;',
' ',
'end;'))
,p_attribute_02=>'P109_COD_EMPRESA,P109_COD_CONTRATO,P109_PERC_PESO,P109_SEQUENCIA'
,p_attribute_03=>'P109_FLAG,P109_OK,P109_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145335399755454194673)
,p_name=>'Hide Save/Create'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P109_OK'
,p_condition_element=>'P109_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145335399926779194674)
,p_event_id=>wwv_flow_api.id(145335399755454194673)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201492943843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145335400188937194677)
,p_event_id=>wwv_flow_api.id(145335399755454194673)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201676257843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145335400035409194675)
,p_event_id=>wwv_flow_api.id(145335399755454194673)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201676257843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145335400127185194676)
,p_event_id=>wwv_flow_api.id(145335399755454194673)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145405201492943843862)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405222754471843922)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from CG_CONTRATOS'
,p_attribute_02=>'CG_CONTRATOS'
,p_attribute_03=>'P109_ROWID'
,p_attribute_04=>'ROWID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405234210639843943)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_PAGINATION'
,p_process_name=>'Get Next or Previous Primary Key Value'
,p_attribute_02=>'CG_CONTRATOS'
,p_attribute_03=>'P109_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_07=>'COD_EMPRESA'
,p_attribute_08=>'COD_CONTRATO'
,p_attribute_09=>'P109_ROWID_NEXT'
,p_attribute_10=>'P109_ROWID_PREV'
,p_attribute_13=>'P109_ROWID_COUNT'
,p_attribute_14=>wwv_flow_string.join(wwv_flow_t_varchar2(
'cod_empresa = :p109_cod_empresa',
'and cod_contrato = :p109_cod_contrato'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405093700050601543)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'	--',
'	CURSOR c_mat_login IS',
'	  SELECT cd_matricula',
'	    FROM usuario_oracle',
'	   WHERE nm_usuario_oracle = :p_usuario;',
'  --',
'  r_matricula informacoes_funcionais.matricula%TYPE;',
'--',
'BEGIN',
'',
'if :p109_rowid is null then',
'	 --',
'   declare',
'      found  number(1);',
'   begin',
'      select 1',
'        into found',
'        from cg_contratos',
'       where cod_empresa  = :P109_cod_empresa',
'         and cod_contrato = :P109_cod_contrato',
'         and sequencia    = :P109_sequencia;',
'      ---',
'		begin',
'		   select nvl( max(sequencia), 0) + 1',
'		     into :P109_sequencia',
'		     from cg_contratos',
'		    where cod_empresa  = :P109_cod_empresa',
'		      and cod_contrato = :P109_cod_contrato;',
'		exception',
'		when no_data_found then',
'		   :P109_sequencia := 1;',
'		end;',
'      ---',
'   exception',
'   when no_data_found then',
'   ',
'		begin',
'		   select nvl( max(sequencia), 0) + 1',
'		     into :P109_sequencia',
'		     from cg_contratos',
'		    where cod_empresa  = :P109_cod_empresa',
'		      and cod_contrato = :P109_cod_contrato;',
'		exception',
'		when no_data_found then',
'		   :P109_sequencia := 1;',
'		end;',
'   end;',
'   ---',
'   OPEN c_mat_login;',
'   FETCH c_mat_login INTO r_matricula;',
'   CLOSE c_mat_login;',
'   --',
'/*   IF r_matricula <> :P109_matricula THEN',
'      :P109_ind_aceite := ''G'';',
'   ELSE',
'      :P109_ind_aceite := ''C'';',
'   END IF;*/ -- Comentado por Cibele REVISAO JUL/2015',
'   --',
'   /*',
'   :P109_matricula    := :cg_contratos_avaliado.matricula_avaliado;',
'   :P109_cod_dimensao := :cg_contratos_avaliado.cod_dimensao;',
'   :P109_cod_ciclo    := :cg_contratos_avaliado.cod_ciclo;',
'   :P109_cargo_mat    := :cg_contratos_avaliado.cod_cargo_avaliado;',
'   :P109_ccusto_mat   := :cg_contratos_avaliado.cod_ccusto_avaliado;',
'   :P109_filial_mat   := :cg_contratos_avaliado.cod_filial_avaliado;',
'   */',
'   --',
'   :P109_dt_atualizacao := SYSDATE;',
'   :P109_usuario        := r_matricula;',
'   --',
'end if;   ',
'   ',
'END;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P109_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405094265220601548)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'   --',
'   :P109_ALTERADO := ''S'';',
'',
'   :P109_dt_atualizacao := SYSDATE;',
'   :P109_usuario        := NVL(:P_USUARIO,NVL(TO_CHAR(COLABORADOR.BUSCA_MATRICULA),:P_USUARIO));',
'   --',
'END;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(145405201676257843862)
,p_process_when=>'P109_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405223126841843925)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of CG_CONTRATOS'
,p_attribute_02=>'CG_CONTRATOS'
,p_attribute_03=>'P109_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P109_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
,p_process_success_message=>unistr('Grava\00E7\00E3o Efetuada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405331959716280513)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza_Status_Metas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_Flg_retorno varchar2(1);',
'v_Msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p109_mensagem := null;',
' :p109_ok       := ''S'';',
'',
'Pkg_Cg_Contratos.ATUALIZA_STATUS_METAS (:p109_Cod_empresa,',
'                                         :p109_Cod_Contrato, -- cg_contratos.cod_contrato%type,',
'                                         :p106_Status, -- cg_contratos.status%type,',
'                                         :p109_Status_Contrato, -- cg_contratos_avaliado.status_contrato%type,',
'                                         v_Flg_retorno,',
'                                         v_Msg_retorno',
'                                        );',
'                                        ',
' if trim(v_msg_retorno) is not null then',
'    :p109_ok       := ''N'';',
'    :p109_flag     := v_flg_retorno;',
'    :p109_mensagem := v_msg_retorno;',
' else',
'    :p109_flag     := null;',
'    :p109_mensagem := null;',
'    :p109_ok       := ''S'';',
' end if;',
'                                ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P109_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145369651861092881790)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Key-Commit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_contrato_concluido varchar2(1);',
'',
'v_saida_erro exception;',
'',
'v_msg varchar2(4000);',
'',
'begin',
'',
'begin',
'			select distinct ''S''',
'			into   v_contrato_concluido',
'			from   cg_contratos',
'			where  ((:p109_status_contrato = ''I'' and status = ''A'' and tipo_status = ''G'' and ind_aceite = ''G'')',
'			     or (:p109_status_contrato = ''M'' and status = ''A'' and tipo_status = ''G'' and ind_aceite = ''C''))',
'			and    cod_ciclo    = :p109_cod_ciclo',
'			and    sequencia    > 0',
'			and    cod_contrato = :p109_cod_contrato',
'			and    cod_empresa  = :p109_cod_empresa;',
'		exception',
'			when no_data_found then',
'			  v_contrato_concluido := ''N'';',
'			when others then',
'			  v_msg := ''Erro ao verificar status do contrato: ''||sqlerrm;',
'			  raise v_saida_erro;',
'		end;',
'			',
'		if nvl(v_contrato_concluido,''N'') = ''S'' then',
unistr('			v_msg := ''O contrato j\00E1 foi conclu\00EDdo ou finalizado. N\00E3o \00E9 poss\00EDvel salvar.'';'),
'			raise v_saida_erro;',
'		end if;',
'',
'',
'begin',
'      update cg_contratos',
'	  set    status = ''A''',
'	        ,tipo_status = ''A''',
'	        ,ind_aceite = ''C''',
'	  where  cod_ciclo    = :p109_cod_ciclo',
'	  and    sequencia    > 0',
'	  and    cod_contrato = :p109_cod_contrato',
'	  and    cod_empresa  = :p109_cod_empresa;',
'	  --',
'	  update cg_contratos_avaliado',
'	  set   resultado_final = nvl(pkg_cg_contratos.f_calcula_resultado(:p109_cod_empresa,:p109_cod_contrato),0)',
'	  where cod_empresa     = :p109_cod_empresa',
'	  and 	cod_contrato    = :p109_cod_contrato;',
'	  --',
'	  commit;',
'      ',
'end;',
'',
':p109_flag := null;',
':p109_OK := ''S'';',
':p109_mensagem := null;',
'',
'exception',
'when v_saida_erro then',
':p109_flag := ''N'';',
':p109_OK := ''N'';',
':p109_mensagem := v_msg;',
'when others then',
':p109_flag := ''N'';',
':p109_OK := ''N'';',
':p109_mensagem := ''Erro ao salvar: ''||sqlerrm;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P109_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405223548802843926)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(145405201762493843862)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405332815695280522)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_vl_meta_bkp'
,p_process_sql_clob=>':p109_vl_meta_bkp := :p109_meta;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405333559206280529)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicia OK'
,p_process_sql_clob=>':p109_ok := ''S'';'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145405505147345290149)
,p_process_sequence=>30
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Hab/ Desab Bot\00F5es')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_cg_contratos.hab_des_cg_contratos_colab (:p109_cod_empresa,',
'                                       :p109_cod_contrato,',
'                                       :p109_cancelado,',
'                                       :p109_status_contrato,',
'                                       :p109_cod_ciclo,',
'                                       :p109_matricula,',
'                                       :p_usuario,',
'                                       :p109_vld_valor_atingido,',
'                                       :p109_btn_create,',
'                                       :p109_btn_save,',
'                                       :p109_btn_delete,',
'                                       :p109_btn_feedback);',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
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
