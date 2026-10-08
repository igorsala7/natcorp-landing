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
--   Date and Time:   15:37 Wednesday September 30, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 134
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00134
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>134);
end;
/
prompt --application/pages/page_00134
begin
wwv_flow_api.create_page(
 p_id=>134
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Altera\00E7\00E3o de Endere\00E7o')
,p_step_title=>unistr('Editar: Altera\00E7\00E3o de Endere\00E7o')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cadastro.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Cadastro.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('DESENHO DA TELA (Natcorp_Cadastro.css / Natcorp_Cadastro.js, em Arquivos desta p\00E1gina)'),
'',
unistr('O MESMO desenho da Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral (p\00E1gina 136), s\00F3 com estes assuntos:'),
unistr('"O que voc\00EA quer atualizar?", "antes: \2026" no que mudou, o comprovante que falta e "Enviar pedido".'),
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-cad-colaborador  Colaborador: de quem s\00E3o os dados.'),
unistr('  nc-cad-solicitacao  &P134_TITULO.: n\00BA, data e solicitante, no alto.'),
unistr('  nc-cad-tema-XXX     cada bloco de dados, com o seu assunto: aqui endereco (Endere\00E7o), contato'),
unistr('                      (Contato), pessoais (Dados Pessoais) e estudo (Forma\00E7\00E3o / Escolaridade).'),
'  nc-cad-anexos       Documentos: a lista dos comprovantes pedidos pelo que mudou.',
unistr('  nc-cad-acoes        Bot\00F5es: barra fixa no rodap\00E9, com o que falta.'),
'',
unistr('Os campos s\00E3o os do APEX, com as mesmas a\00E7\00F5es din\00E2micas. Bloco sem nc-cad-tema-* continua'),
unistr('onde estava. Bloco novo: d\00EA a ele uma classe nc-cad-tema-XXX existente (ou pe\00E7a um tema novo).'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/CADASTRO-MANUTENCAO.md.'))
,p_last_upd_yyyymmddhh24miss=>'20240624131252'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(276067817800666770919)
,p_name=>'Documentos'
,p_region_css_classes=>'nc-cad-anexos'
,p_region_name=>'UPLOAD_DOCS'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>40
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
'            p_request     => 134,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_SUB_ITEM,P864_TIPO_ARQUIVO,P864_TIPO_COD_ITEM,P864_SEQ_ITEM,P864_COD_SUB_ITEM,P864_SEQ,P864_COD_REQ,P864_REQUEST'',',
'            p_values      => u.COD_EMPRESA||'',''||u.cod_item||'',''||u.tipo_sub_item||'',''||U.TIPO_ARQUIVO||'',''||''COLABORADOR''||'',''||U.SEQ_ITEM||'',''||U.COD_SUB_ITEM||'',''||U.SEQ||'',''||U.COD_REQ||'',''||134,',
'            p_clear_cache => 864) editar',
'  FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
' WHERE u.tipo_arquivo = t.cod',
'   AND u.tipo_sub_item = s.cod',
'   AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'   and u.tipo_sub_item = 0',
'   AND u.cod_empresa   = :p134_cod_empresa',
'   AND u.cod_item      = :p134_matricula',
'   AND u.tipo_cod_item = ''COLABORADOR''',
'   AND ((u.seq = :p134_seq and :p134_cod_req is null) or (u.cod_req = :p134_cod_req))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P134_COD_REQ,P134_SEQ,P134_COD_EMPRESA,P134_MATRICULA'
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
 p_id=>wwv_flow_api.id(269883975898462143745)
,p_query_column_id=>1
,p_column_alias=>'DESC_TIPO_SUB_ITEM'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883976310447143745)
,p_query_column_id=>2
,p_column_alias=>'COD_SUB_ITEM'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883976677534143745)
,p_query_column_id=>3
,p_column_alias=>'SEQ_ITEM'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883977045879143745)
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
 p_id=>wwv_flow_api.id(269883977499210143746)
,p_query_column_id=>5
,p_column_alias=>'DT_ATUALIZACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883977857213143746)
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
 p_id=>wwv_flow_api.id(269883978333561143746)
,p_query_column_id=>7
,p_column_alias=>'OBRIG_CANDIDATO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883978731685143747)
,p_query_column_id=>8
,p_column_alias=>'TIPO_ARQUIVO'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883979075240143747)
,p_query_column_id=>9
,p_column_alias=>'TIPO_SUB_ITEM'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883974658819143740)
,p_query_column_id=>10
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883975036157143744)
,p_query_column_id=>11
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>12
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269883975499953143744)
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
 p_id=>wwv_flow_api.id(281375223490804022358)
,p_plug_name=>'&P134_TITULO.'
,p_region_css_classes=>'nc-cad-solicitacao'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375227009891022363)
,p_plug_name=>'Colaborador'
,p_region_css_classes=>'nc-cad-colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375229432519022365)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P134_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375230257163022366)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P134_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375232302689022367)
,p_plug_name=>'Dados Pessoais'
,p_region_css_classes=>'nc-cad-tema-pessoais'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375233417155022368)
,p_plug_name=>'Contato'
,p_region_css_classes=>'nc-cad-tema-contato'
,p_parent_plug_id=>wwv_flow_api.id(281375232302689022367)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375236258643022371)
,p_plug_name=>unistr('Forma\00E7\00E3o / Escolaridade')
,p_region_css_classes=>'nc-cad-tema-estudo'
,p_parent_plug_id=>wwv_flow_api.id(281375232302689022367)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375237866255022372)
,p_plug_name=>unistr('Endere\00E7o')
,p_region_css_classes=>'nc-cad-tema-endereco'
,p_parent_plug_id=>wwv_flow_api.id(281375232302689022367)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375247026747022381)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_css_classes=>'nc-cad-acoes'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281375966576195181617)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281404529436169682497)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375247872390022381)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Deletar'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_button_condition=>'P134_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375248257152022382)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375248648474022382)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P134_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375223816988022358)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_button_name=>'p134_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P134 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P_EMPRESA_USER.,&P_MATRICULA_USER.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269883979486132143747)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(276067817800666770919)
,p_button_name=>'ANEXO'
,p_button_static_id=>'BTN_ANEXO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Anexar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paperclip'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375227461317022363)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_button_name=>'p134_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P134_COD_EMPRESA.,&P134_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281375247453794022381)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:133:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281375267461681022402)
,p_branch_name=>'Go To Page 133'
,p_branch_action=>'f?p=&APP_ID.:133:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269883933608085400656)
,p_name=>'P134_SEQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(276067817800666770919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269883979840769143751)
,p_name=>'P134_URL_DOCS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(276067817800666770919)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375224292932022359)
,p_name=>'P134_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375224676559022361)
,p_name=>'P134_TITULO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375225101639022361)
,p_name=>'P134_COD_PROPOSTA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375225421377022362)
,p_name=>'P134_FLAG_KNEXTITEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375225904724022362)
,p_name=>'P134_MENSAGEM_KNEXTITEM'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375226251530022362)
,p_name=>'P134_DATA_SOLICITACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Solicita\00E7\00E3o')
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_SOLICITACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375226646849022362)
,p_name=>'P134_SOLICITANTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281375223490804022358)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375227870919022363)
,p_name=>'P134_FILIAL_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375228290801022364)
,p_name=>'P134_IND_DUPLO_VINCULO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375228676306022364)
,p_name=>'P134_DATA_REF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375229104484022364)
,p_name=>'P134_SALDO_FER_MIN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375229837497022365)
,p_name=>'P134_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281375229432519022365)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P134_COD_EMPRESA',
'   and matricula = :P134_MATRICULA;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375230657441022366)
,p_name=>'P134_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281375230257163022366)
,p_prompt=>'Empresa'
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
 p_id=>wwv_flow_api.id(281375231092218022366)
,p_name=>'P134_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281375230257163022366)
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
 p_id=>wwv_flow_api.id(281375231451203022367)
,p_name=>'P134_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281375230257163022366)
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
 p_id=>wwv_flow_api.id(281375231861612022367)
,p_name=>'P134_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281375230257163022366)
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
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375232700996022368)
,p_name=>'P134_ESTADO_CIVIL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281375232302689022367)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Estado Civil'
,p_source=>'ESTADO_CIVIL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(NOME) nome, cod',
'  FROM   ESTADO_CIVIL',
'order by 1'))
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
 p_id=>wwv_flow_api.id(281375233085216022368)
,p_name=>'P134_NOME_SUPERIOR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281375232302689022367)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_SUPERIOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375233872969022369)
,p_name=>'P134_DDD'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'DDD'
,p_source=>'DDD'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20
,p_cMaxlength=>20
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375234220640022369)
,p_name=>'P134_TELEFONE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Telefone'
,p_source=>'TELEFONE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>20
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375234697784022369)
,p_name=>'P134_DDD_CEL'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'DDD'
,p_source=>'DDD_CEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375235065917022370)
,p_name=>'P134_TELEFONE_CELULAR'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Celular'
,p_source=>'TELEFONE_CELULAR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>20
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375235503478022370)
,p_name=>'P134_E_MAIL_FUNCIONAL'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-Mail Funcional'
,p_source=>'E_MAIL_FUNCIONAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375235818179022371)
,p_name=>'P134_E_MAIL'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(281375233417155022368)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-Mail Pessoal'
,p_source=>'E_MAIL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375236649599022371)
,p_name=>'P134_INSTRUCAO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281375236258643022371)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Instru\00E7\00E3o')
,p_source=>'INSTRUCAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT initcap(NOME) nome, cod',
'	  FROM   INSTRUCAO',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375237092820022372)
,p_name=>'P134_COD_FORMACAO_ESCOLAR'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281375236258643022371)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Forma\00E7\00E3o Escolar')
,p_source=>'COD_FORMACAO_ESCOLAR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select initcap(descricao) nome, cod_formacao_escolar',
'    from formacao_escolar',
'   order by cod_formacao_escolar '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375237480980022372)
,p_name=>'P134_TITULACAO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281375236258643022371)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Titula\00E7\00E3o')
,p_source=>'TITULACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	select initcap(descricao_titulacao) nome, cod_titulacao',
'	  from titulacao',
'	 order by cod_titulacao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375238295255022373)
,p_name=>'P134_UTILIZA_TAB_CEP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375238702855022373)
,p_name=>'P134_CEP'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CEP'
,p_source=>'CEP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>5
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375239010592022373)
,p_name=>'P134_COMPLEMENTO_CEP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('D\00EDgito')
,p_source=>'COMPLEMENTO_CEP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>3
,p_cMaxlength=>3
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375239438298022375)
,p_name=>'P134_ENDERECO'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Endere\00E7o')
,p_source=>'ENDERECO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375239844365022375)
,p_name=>'P134_NUMERO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero')
,p_source=>'NUMERO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375240241602022375)
,p_name=>'P134_COMPLEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Complemento'
,p_source=>'COMPLEM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375240612585022376)
,p_name=>'P134_BAIRRO'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bairro'
,p_source=>'BAIRRO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375241035685022376)
,p_name=>'P134_CIDADE'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cidade'
,p_source=>'CIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375241429339022376)
,p_name=>'P134_UF'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_prompt=>'UF'
,p_source=>'UF'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
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
 p_id=>wwv_flow_api.id(281375241834986022376)
,p_name=>'P134_ROWID'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375242246050022377)
,p_name=>'P134_COD_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod',
'from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P134_ROWID is null) or ',
'        (:P134_ROWID is not null)) ',
'  and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and cod = :p_empresa_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P134_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375242636862022377)
,p_name=>'P134_MATRICULA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281375227009891022363)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
' from informacoes_funcionais i, centro_de_custo c',
'where i.cod_empresa = c.cod_empresa',
'  and i.cod_ccusto = c.cod',
'  and i.situacao < ''90''',
'  AND I.COD_EMPRESA = :P134_COD_EMPRESA',
'  and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and i.cod_empresa = :p_empresa_user and i.matricula = :p_matricula_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P_USUARIO,P134_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375243087143022377)
,p_name=>'P134_DC_MATRICULA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375243499511022378)
,p_name=>'P134_NOME'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375243807096022378)
,p_name=>'P134_FILIAL'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375244231598022378)
,p_name=>'P134_DT_ATUALIZACAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375244617268022379)
,p_name=>'P134_COD_CUSTO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375245097002022379)
,p_name=>'P134_NOME_CCUSTO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375245440080022380)
,p_name=>'P134_COD_EMP_SOLICITANTE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375245849853022380)
,p_name=>'P134_MAT_SOLICITANTE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375246250962022380)
,p_name=>'P134_CD_NIVEL'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'CD_NIVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375246641441022380)
,p_name=>'P134_MOTIVO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281375237866255022372)
,p_use_cache_before_default=>'NO'
,p_source=>'MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375249029999022382)
,p_name=>'P134_OK'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375249479638022383)
,p_name=>'P134_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281375249895810022384)
,p_name=>'P134_MENSAGEM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281375247026747022381)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269738190773515422255)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c0 is',
'select matricula, cod_req',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  if :p134_cod_empresa is null then ',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''O Campo Empresa \00E9 Obrigat\00F3rio!'';'),
'  end if;',
'  ',
'  if :p134_matricula is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''O Campo Matr\00EDcula \00E9 Obrigat\00F3rio!'';'),
'  end if;',
'',
'  if v_c0.matricula is not null and :p134_rowid is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''J\00E1 existe a requisi\00E7\00E3o ''||v_c0.cod_req||'' em andamento!'';'),
'  end if;',
'',
'  if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'      return v_msg_retorno;',
'  else ',
'    if :p_painel = ''PC'' and :p134_matricula <> :p_matricula_user then',
unistr('      return ''Matr\00EDcula Inv\00E1lida!'';'),
'    else',
'      return null;',
'    end if;',
'  end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281375248648474022382)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375252629335022392)
,p_name=>'Popula Campos (S/ Portal)'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NOT_EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375253178410022393)
,p_event_id=>wwv_flow_api.id(281375252629335022392)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'                               ',
'cursor c1 is',
'select ip.matricula,',
'iFU.dc_matricula,',
'ip.sexo,',
'ip.nome ,',
'ip.endereco,',
'ip.bairro ,',
'ip.cidade,',
'ip.uf,',
'ip.cep,',
'ip.ddd,',
'ip.telefone,',
'ip.numero,',
'ip.complem,',
'ip.filial,',
'fl.nome_filial,',
'ip.e_mail,',
'ip.complemento_cep,',
'ip.telefone_celular,',
'ip.estado_civil,',
'ec.nome nome_estado_civil,',
'ip.instrucao,',
'i.nome nome_instrucao,',
'ip.cod_formacao_escolar,',
'decode(ip.cod_formacao_escolar, null, null, fe.descricao) desc_formacao_escolar,',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.ddd_cell,',
'ip.num_identidade,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'ip.titulacao,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_registro,',
'ip.sigla_cons_reg,',
'ip.regiao,',
'ip.nome_funcao_reg,',
'ip.valid_ident_est,',
'ip.tipo_visto,',
'ifu.e_mail email_funcional,',
'ifu.cod_tipo_mao_obra tipo_mao_obra,',
'ifu.banco,',
'ifu.agencia,',
'ifu.num_conta conta,',
'ifu.dc_conta,',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto',
'from inf_pessoais ip,',
'informacoes_funcionais ifu,',
'filiais fl, ',
'estado_civil ec,',
'instrucao i,',
'formacao_escolar fe,',
'raca_cor rc,',
'titulacao t,',
'nacionalidade n,',
'tipo_transacao_bancaria ttb,',
'campo_de_cadastro cc,',
'motivo_alteracoes ma ',
'where ip.cod_empresa = :p134_cod_empresa',
'and ip.matricula = :p134_matricula',
'and ifu.cod_empresa = ip.cod_empresa',
'and ifu.situacao < ''90''',
'and ifu.matricula = ip.matricula',
'and fl.cod_empresa = ip.cod_empresa',
'and fl.cod_filial = ip.filial',
'and ec.cod = ip.estado_civil',
'and i.cod = ip.instrucao',
'and fe.cod_formacao_escolar(+) = ip.cod_formacao_escolar',
'and rc.cod(+) = ip.cod_raca_cor',
'and t.cod_titulacao(+) = ip.titulacao',
'and n.cod(+) = ip.nacionalidade',
'and ttb.cod(+) = ifu.cod_tp_trans_bca',
'and cc.empresa(+) = ip.cod_empresa',
'and cc.chave_de_tabela(+) = ip.matricula',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'    open c0;',
'    fetch c0 into v_c0;',
'    close c0;',
'',
'    if v_c0.matricula is null then',
'',
'        open c1;',
'        fetch c1 into r1;',
'        close c1;',
'',
'        :p134_cod_emp_solicitante := :P_EMPRESA_USER;',
'        :p134_mat_solicitante := :P_MATRICULA_USER;',
'        ',
'        :p134_solicitante := :P_EMPRESA_USER||'' / ''||:P_MATRICULA_USER||'' - ''||iNITCAP(fnct_nome_func(:P_EMPRESA_USER, :P_MATRICULA_USER));',
'',
'        :p134_dc_matricula := r1.dc_matricula;',
'',
'        :p134_cod_custo := r1.cod_ccusto;',
'        :p134_nome_ccusto := r1.nome_ccusto;',
'',
'        :p134_nome := r1.nome;',
'        :p134_endereco := r1.endereco;',
'        :p134_bairro := r1.bairro;',
'        :p134_cidade := r1.cidade;',
'        :p134_uf := r1.uf;',
'        :p134_cep := r1.cep;',
'        :p134_ddd := r1.ddd;',
'        :p134_telefone := r1.telefone;',
'        :p134_numero := r1.numero;',
'        :p134_complem := r1.complem;',
'        :p134_filial := r1.filial;',
'        :p134_e_mail := r1.e_mail;',
'        :P134_E_MAIL_FUNCIONAL := r1.email_funcional;',
'        :p134_complemento_cep := r1.complemento_cep;',
'        :p134_ddd_cel := r1.ddd_cell;',
'        :p134_TELEFONE_celular := r1.telefone_celular;',
'        :p134_estado_civil := r1.estado_civil;',
'        :p134_instrucao := r1.instrucao;',
'        :p134_cod_formacao_escolar := r1.cod_formacao_escolar;',
'        :p134_titulacao := r1.titulacao;',
'',
'    end if;',
'',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA,P134_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P134_COD_EMP_SOLICITANTE,P134_MAT_SOLICITANTE,P134_NOME,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_CEP,P134_DDD,P134_TELEFONE,P134_NUMERO,P134_COMPLEM,P134_FILIAL,P134_E_MAIL,P134_COMPLEMENTO_CEP,P134_TELEFONE_CELULAR,P134_ESTADO_CIVIL,P134_I'
||'NSTRUCAO,P134_COD_FORMACAO_ESCOLAR,P134_COD_CUSTO,P134_NOME_CCUSTO,P134_DC_MATRICULA,P134_TITULACAO,P134_DDD_CEL,P134_SOLICITANTE,P134_E_MAIL_FUNCIONAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(272375984629503588310)
,p_name=>'Popula Campos (C/ Portal)'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula',
'and 1 = 2'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272375984813668588312)
,p_event_id=>wwv_flow_api.id(272375984629503588310)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'                               ',
'cursor c1 is',
'select ip.matricula,',
'iFU.dc_matricula,',
'ip.sexo,',
'ip.nome ,',
'ip.endereco,',
'ip.bairro ,',
'ip.cidade,',
'ip.uf,',
'ip.cep,',
'ip.ddd,',
'ip.telefone,',
'ip.numero,',
'ip.complem,',
'ip.filial,',
'fl.nome_filial,',
'ip.e_mail,',
'ip.complemento_cep,',
'ip.telefone_celular,',
'ip.estado_civil,',
'ec.nome nome_estado_civil,',
'ip.instrucao,',
'i.nome nome_instrucao,',
'ip.cod_formacao_escolar,',
'decode(ip.cod_formacao_escolar, null, null, fe.descricao) desc_formacao_escolar,',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.ddd_cel ddd_cell,',
'ip.num_identidade,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'ip.titulacao,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_registro,',
'ip.sigla_cons_reg,',
'ip.regiao,',
'ip.nome_funcao_reg,',
'ip.valid_ident_est,',
'ip.tipo_visto,',
'ip.e_mail email_funcional,',
'ifu.cod_tipo_mao_obra tipo_mao_obra,',
'ifu.banco,',
'ifu.agencia,',
'ifu.num_conta conta,',
'ifu.dc_conta,',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'COD_EMP_SOLICITANTE,',
'MAT_SOLICITANTE',
'from inf_pessoais_portal ip,',
'informacoes_funcionais ifu,',
'filiais fl, ',
'estado_civil ec,',
'instrucao i,',
'formacao_escolar fe,',
'raca_cor rc,',
'titulacao t,',
'nacionalidade n,',
'tipo_transacao_bancaria ttb,',
'campo_de_cadastro cc,',
'motivo_alteracoes ma ',
'where ip.cod_empresa = :p134_cod_empresa',
'and ip.matricula = :p134_matricula',
'and ifu.cod_empresa = ip.cod_empresa',
'and ifu.situacao < ''90''',
'and ifu.matricula = ip.matricula',
'and fl.cod_empresa = ip.cod_empresa',
'and fl.cod_filial = ip.filial',
'and ec.cod = ip.estado_civil',
'and i.cod = ip.instrucao',
'and fe.cod_formacao_escolar(+) = ip.cod_formacao_escolar',
'and rc.cod(+) = ip.cod_raca_cor',
'and t.cod_titulacao(+) = ip.titulacao',
'and n.cod(+) = ip.nacionalidade',
'and ttb.cod(+) = ifu.cod_tp_trans_bca',
'and cc.empresa(+) = ip.cod_empresa',
'and cc.chave_de_tabela(+) = ip.matricula',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
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
':p134_cod_emp_solicitante := R1.COD_EMP_SOLICITANTE;',
':p134_mat_solicitante := R1.MAT_SOLICITANTE;',
'',
':p134_solicitante := R1.COD_EMP_SOLICITANTE||'' / ''||R1.MAT_SOLICITANTE||'' - ''||iNITCAP(fnct_nome_func(R1.COD_EMP_SOLICITANTE, R1.MAT_SOLICITANTE));',
'',
':p134_dc_matricula := r1.dc_matricula;',
'',
':p134_cod_custo := r1.cod_ccusto;',
':p134_nome_ccusto := r1.nome_ccusto;',
'',
':p134_nome := r1.nome;',
':p134_endereco := r1.endereco;',
':p134_bairro := r1.bairro;',
':p134_cidade := r1.cidade;',
':p134_uf := r1.uf;',
':p134_cep := r1.cep;',
'',
':p134_numero := r1.numero;',
':p134_complem := r1.complem;',
':p134_filial := r1.filial;',
':p134_e_mail := r1.e_mail;',
':P134_E_MAIL_FUNCIONAL := r1.email_funcional;',
':p134_complemento_cep := r1.complemento_cep;',
'',
':p134_estado_civil := r1.estado_civil;',
':p134_instrucao := r1.instrucao;',
':p134_cod_formacao_escolar := r1.cod_formacao_escolar;',
':p134_titulacao := r1.titulacao;',
'--:p134_desc_titulacao := r1.descricao_titulacao;',
'',
'end if;',
'',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_03=>'P134_COD_EMP_SOLICITANTE,P134_MAT_SOLICITANTE,P134_NOME,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_CEP,P134_NUMERO,P134_COMPLEM,P134_FILIAL,P134_E_MAIL,P134_COMPLEMENTO_CEP,P134_ESTADO_CIVIL,P134_INSTRUCAO,P134_COD_FORMACAO_ESCOLAR,P134_COD_C'
||'USTO,P134_NOME_CCUSTO,P134_DC_MATRICULA,P134_TITULACAO,P134_SOLICITANTE,P134_E_MAIL_FUNCIONAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272375984926919588313)
,p_event_id=>wwv_flow_api.id(272375984629503588310)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'                               ',
'cursor c1 is',
'select ',
'ip.ddd,',
'ip.telefone,',
'ip.telefone_celular,',
'ip.ddd_cel ddd_cell',
'from inf_pessoais_portal ip,',
'informacoes_funcionais ifu',
'where ip.cod_empresa = :p134_cod_empresa',
'and ip.matricula = :p134_matricula',
'and ifu.cod_empresa = ip.cod_empresa',
'and ifu.situacao < ''90''',
'and ifu.matricula = ip.matricula;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
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
':p134_ddd := r1.ddd;',
':p134_telefone := r1.telefone;',
'',
':p134_ddd_cel := r1.ddd_cell;',
':p134_TELEFONE_celular := r1.telefone_celular;',
'',
'end if;',
'',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA,P134_COD_REQ'
,p_attribute_03=>'P134_DDD,P134_TELEFONE,P134_DDD_CEL,P134_TELEFONE_CELULAR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281374393495969192824)
,p_name=>'Popula Campos 1_2_1'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P134_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883934886573400669)
,p_event_id=>wwv_flow_api.id(281374393495969192824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_NOME,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_CEP,P134_DDD,P134_TELEFONE,P134_NUMERO,P134_COMPLEM,P134_FILIAL,P134_E_MAIL,P134_COMPLEMENTO_CEP,P134_TELEFONE_CELULAR,P134_ESTADO_CIVIL,P134_INSTRUCAO,P134_COD_FORMACAO_ESCOLAR,P134_COD_CU'
||'STO,P134_NOME_CCUSTO,P134_DC_MATRICULA,P134_TITULACAO,P134_UTILIZA_TAB_CEP,P134_E_MAIL_FUNCIONAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281374393582633192825)
,p_event_id=>wwv_flow_api.id(281374393495969192824)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'                               ',
'cursor c1 is',
'select ip.matricula,',
'iFU.dc_matricula,',
'ip.sexo,',
'ip.nome ,',
'ip.endereco,',
'ip.bairro ,',
'ip.cidade,',
'ip.uf,',
'ip.cep,',
'ip.ddd,',
'ip.telefone,',
'ip.numero,',
'ip.complem,',
'ip.filial,',
'fl.nome_filial,',
'ip.e_mail,',
'ip.complemento_cep,',
'ip.telefone_celular,',
'ip.estado_civil,',
'ec.nome nome_estado_civil,',
'ip.instrucao,',
'i.nome nome_instrucao,',
'ip.cod_formacao_escolar,',
'decode(ip.cod_formacao_escolar, null, null, fe.descricao) desc_formacao_escolar,',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.ddd_cel ddd_cell,',
'ip.num_identidade,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'ip.titulacao,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_registro,',
'ip.sigla_cons_reg,',
'ip.regiao,',
'ip.nome_funcao_reg,',
'ip.valid_ident_est,',
'ip.tipo_visto,',
'ifu.e_mail email_funcional,',
'ifu.cod_tipo_mao_obra tipo_mao_obra,',
'ifu.banco,',
'ifu.agencia,',
'ifu.num_conta conta,',
'ifu.dc_conta,',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'COD_EMP_SOLICITANTE,',
'MAT_SOLICITANTE,',
'ip.cod_req',
'from inf_pessoais_portal ip,',
'informacoes_funcionais ifu,',
'filiais fl, ',
'estado_civil ec,',
'instrucao i,',
'formacao_escolar fe,',
'raca_cor rc,',
'titulacao t,',
'nacionalidade n,',
'tipo_transacao_bancaria ttb,',
'campo_de_cadastro cc,',
'motivo_alteracoes ma ',
'where ip.cod_empresa = :p134_cod_empresa',
'and ip.matricula = :p134_matricula',
'and ifu.cod_empresa = ip.cod_empresa',
'and ifu.situacao < ''90''',
'and ifu.matricula = ip.matricula',
'and fl.cod_empresa = ip.cod_empresa',
'and fl.cod_filial = ip.filial',
'and ec.cod = ip.estado_civil',
'and i.cod = ip.instrucao',
'and fe.cod_formacao_escolar(+) = ip.cod_formacao_escolar',
'and rc.cod(+) = ip.cod_raca_cor',
'and t.cod_titulacao(+) = ip.titulacao',
'and n.cod(+) = ip.nacionalidade',
'and ttb.cod(+) = ifu.cod_tp_trans_bca',
'and cc.empresa(+) = ip.cod_empresa',
'and cc.chave_de_tabela(+) = ip.matricula',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
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
':p134_cod_emp_solicitante := R1.COD_EMP_SOLICITANTE;',
':p134_mat_solicitante := R1.MAT_SOLICITANTE;',
'',
':p134_solicitante := R1.COD_EMP_SOLICITANTE||'' / ''||R1.MAT_SOLICITANTE||'' - ''||iNITCAP(fnct_nome_func(R1.COD_EMP_SOLICITANTE, R1.MAT_SOLICITANTE));',
'',
':p134_dc_matricula := r1.dc_matricula;',
'',
':p134_cod_custo := r1.cod_ccusto;',
':p134_nome_ccusto := r1.nome_ccusto;',
'',
':p134_nome := r1.nome;',
':p134_endereco := r1.endereco;',
':p134_bairro := r1.bairro;',
':p134_cidade := r1.cidade;',
':p134_uf := r1.uf;',
':p134_cep := r1.cep;',
':p134_ddd := r1.ddd;',
':p134_telefone := r1.telefone;',
':p134_numero := r1.numero;',
':p134_complem := r1.complem;',
':p134_filial := r1.filial;',
':p134_e_mail := r1.e_mail;',
':p134_complemento_cep := r1.complemento_cep;',
':p134_TELEFONE_celular := r1.telefone_celular;',
':p134_estado_civil := r1.estado_civil;',
':p134_instrucao := r1.instrucao;',
':p134_cod_formacao_escolar := r1.cod_formacao_escolar;',
':p134_titulacao := r1.titulacao;',
'--:p134_desc_titulacao := r1.descricao_titulacao;',
':p134_cod_req := r1.cod_req;',
'end if;',
'',
'if v_c0.matricula is null then',
':p134_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'else',
':p134_seq := null;',
'end if;',
'',
'',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_03=>'P134_COD_EMP_SOLICITANTE,P134_MAT_SOLICITANTE,P134_NOME,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_CEP,P134_DDD,P134_TELEFONE,P134_NUMERO,P134_COMPLEM,P134_FILIAL,P134_E_MAIL,P134_COMPLEMENTO_CEP,P134_TELEFONE_CELULAR,P134_ESTADO_CIVIL,P134_I'
||'NSTRUCAO,P134_COD_FORMACAO_ESCOLAR,P134_COD_CUSTO,P134_NOME_CCUSTO,P134_DC_MATRICULA,P134_TITULACAO,P134_SOLICITANTE,P134_E_MAIL_FUNCIONAL,P134_COD_REQ,P134_SEQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281374392579886192815)
,p_event_id=>wwv_flow_api.id(281374393495969192824)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'                               ',
'cursor c1 is',
'select ip.matricula,',
'iFU.dc_matricula,',
'ip.sexo,',
'ip.nome ,',
'ip.endereco,',
'ip.bairro ,',
'ip.cidade,',
'ip.uf,',
'ip.cep,',
'ip.ddd,',
'ip.telefone,',
'ip.numero,',
'ip.complem,',
'ip.filial,',
'fl.nome_filial,',
'ip.e_mail,',
'ip.complemento_cep,',
'ip.telefone_celular,',
'ip.estado_civil,',
'ec.nome nome_estado_civil,',
'ip.instrucao,',
'i.nome nome_instrucao,',
'ip.cod_formacao_escolar,',
'decode(ip.cod_formacao_escolar, null, null, fe.descricao) desc_formacao_escolar,',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.ddd_cell,',
'ip.num_identidade,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'ip.titulacao,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_registro,',
'ip.sigla_cons_reg,',
'ip.regiao,',
'ip.nome_funcao_reg,',
'ip.valid_ident_est,',
'ip.tipo_visto,',
'ifu.e_mail email_funcional,',
'ifu.cod_tipo_mao_obra tipo_mao_obra,',
'ifu.banco,',
'ifu.agencia,',
'ifu.num_conta conta,',
'ifu.dc_conta,',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto',
'from inf_pessoais ip,',
'informacoes_funcionais ifu,',
'filiais fl, ',
'estado_civil ec,',
'instrucao i,',
'formacao_escolar fe,',
'raca_cor rc,',
'titulacao t,',
'nacionalidade n,',
'tipo_transacao_bancaria ttb,',
'campo_de_cadastro cc,',
'motivo_alteracoes ma ',
'where ip.cod_empresa = :p134_cod_empresa',
'and ip.matricula = :p134_matricula',
'and ifu.cod_empresa = ip.cod_empresa',
'and ifu.situacao < ''90''',
'and ifu.matricula = ip.matricula',
'and fl.cod_empresa = ip.cod_empresa',
'and fl.cod_filial = ip.filial',
'and ec.cod = ip.estado_civil',
'and i.cod = ip.instrucao',
'and fe.cod_formacao_escolar(+) = ip.cod_formacao_escolar',
'and rc.cod(+) = ip.cod_raca_cor',
'and t.cod_titulacao(+) = ip.titulacao',
'and n.cod(+) = ip.nacionalidade',
'and ttb.cod(+) = ifu.cod_tp_trans_bca',
'and cc.empresa(+) = ip.cod_empresa',
'and cc.chave_de_tabela(+) = ip.matricula',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'Begin',
'',
'open c1;',
'fetch c1 into r1;',
'close c1;',
'',
':p134_dc_matricula := r1.dc_matricula;',
'',
':p134_cod_custo := r1.cod_ccusto;',
':p134_nome_ccusto := r1.nome_ccusto;',
'',
':p134_nome := r1.nome;',
':p134_endereco := r1.endereco;',
':p134_bairro := r1.bairro;',
':p134_cidade := r1.cidade;',
':p134_uf := r1.uf;',
':p134_cep := r1.cep;',
':p134_ddd := r1.ddd;',
':p134_telefone := r1.telefone;',
':p134_numero := r1.numero;',
':p134_complem := r1.complem;',
':p134_filial := r1.filial;',
':p134_e_mail := r1.e_mail;',
':p134_e_mail_funcional := r1.email_funcional;',
':p134_complemento_cep := r1.complemento_cep;',
':p134_TELEFONE_celular := r1.telefone_celular;',
':p134_estado_civil := r1.estado_civil;',
':p134_instrucao := r1.instrucao;',
':p134_cod_formacao_escolar := r1.cod_formacao_escolar;',
':p134_titulacao := r1.titulacao;',
'--:p134_desc_titulacao := r1.descricao_titulacao;',
'',
'',
'  begin',
'  select tabela_cep',
'    into :p134_utiliza_tab_cep',
'    from empresas',
'   where cod = :p134_COD_EMPRESA;',
'  ',
'  exception',
'  when others then',
'  null;',
'  end;',
'',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_03=>'P134_NOME,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_CEP,P134_DDD,P134_TELEFONE,P134_NUMERO,P134_COMPLEM,P134_FILIAL,P134_E_MAIL,P134_COMPLEMENTO_CEP,P134_TELEFONE_CELULAR,P134_ESTADO_CIVIL,P134_INSTRUCAO,P134_COD_FORMACAO_ESCOLAR,P134_COD_CU'
||'STO,P134_NOME_CCUSTO,P134_DC_MATRICULA,P134_TITULACAO,P134_UTILIZA_TAB_CEP,P134_E_MAIL_FUNCIONAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883933791439400658)
,p_event_id=>wwv_flow_api.id(281374393495969192824)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
'select matricula, cod_req',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'if v_c0.matricula is not null and :p134_rowid is null then',
'  :p134_flag := ''N'';',
unistr('  :p134_mensagem := ''J\00E1 existe a requisi\00E7\00E3o ''||v_c0.cod_req||'' em andamento!'';'),
'end if;',
'',
'end;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA,P134_ROWID'
,p_attribute_03=>'P134_FLAG,P134_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375253572446022393)
,p_name=>'Popula Nome_Superior'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_MATRICULA_SUPERIOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375254045387022393)
,p_event_id=>wwv_flow_api.id(281375253572446022393)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'SELECT B.NOME',
'  FROM INFORMACOES_FUNCIONAIS_CAD A, INF_PESSOAIS_CAD B, CARGOS C',
' WHERE B.COD_EMPRESA = A.COD_EMPRESA',
'   AND B.MATRICULA   = A.MATRICULA',
'   AND C.COD         = A.CARGO',
'   AND C.CLASS_CARGO NOT IN(''PE'', ''AT'')',
'   AND A.SITUACAO    < ''90'' ',
'   AND A.COD_EMPRESA = :p134_cod_empresa',
'   and a.matricula = :p134_matricula_superior;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p134_nome_superior := v_c1.nome;',
'',
'end;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA_SUPERIOR'
,p_attribute_03=>'P134_NOME_SUPERIOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375260942245022398)
,p_name=>'Esconde Campos Def.'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_IND_DEF_FIS'
,p_condition_element=>'P134_IND_DEF_FIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375261495852022398)
,p_event_id=>wwv_flow_api.id(281375260942245022398)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_IND_DEF_FIS_BR,P134_RAIS_IND_DEF_FISICO,P134_RAIS_IND_DEF_AUDITIVA,P134_RAIS_IND_DEF_VISUAL,P134_RAIS_IND_DEF_MENTAL,P134_RAIS_IND_DEF_MULTIPLA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375262000483022398)
,p_event_id=>wwv_flow_api.id(281375260942245022398)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_IND_DEF_FIS_BR,P134_RAIS_IND_DEF_FISICO,P134_RAIS_IND_DEF_AUDITIVA,P134_RAIS_IND_DEF_VISUAL,P134_RAIS_IND_DEF_MENTAL,P134_RAIS_IND_DEF_MULTIPLA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375260077261022397)
,p_name=>'Dispara Alerta'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_MENSAGEM'
,p_condition_element=>'P134_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375260575063022397)
,p_event_id=>wwv_flow_api.id(281375260077261022397)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P134_FLAG'').value == "Q") {',
'alertify.confirm($v(''P134_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P134_FLAG'').value = ''S'';',
'        $x(''P134_MENSAGEM'').value = '''';',
'        $x(''P134_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P134_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P134_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P134_FLAG'').value == "N") {',
'            $x(''P134_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P134_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P134_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P134_MENSAGEM''));',
'    }else{',
'            if ($x(''P134_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P134_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375257284962022395)
,p_name=>'Salvar (CREATE)'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281375248648474022382)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281374393203481192821)
,p_event_id=>wwv_flow_api.id(281375257284962022395)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_EMPRESA,P134_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375257737430022396)
,p_event_id=>wwv_flow_api.id(281375257284962022395)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_REQ,P134_DATA_SOLICITACAO,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_COD_EMPRESA,P134_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375258288130022396)
,p_event_id=>wwv_flow_api.id(281375257284962022395)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P134_COD_REQ'').disabled = false;',
'$x(''P134_DATA_SOLICITACAO'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269800820070675646658)
,p_event_id=>wwv_flow_api.id(281375257284962022395)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375255390467022394)
,p_name=>'Salvar (SAVE)'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281375248257152022382)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375255867731022394)
,p_event_id=>wwv_flow_api.id(281375255390467022394)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_REQ,P134_DATA_SOLICITACAO,P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF,P134_COD_EMPRESA,P134_MATRICULA,P134_DATA_REF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375256364959022395)
,p_event_id=>wwv_flow_api.id(281375255390467022394)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P134_COD_REQ'').disabled = false;',
'$x(''P134_DATA_SOLICITACAO'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375256888139022395)
,p_event_id=>wwv_flow_api.id(281375255390467022394)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'v_cod_req_out number;',
'',
'begin',
'',
':p134_rowid := null;',
'',
'',
':p134_data_solicitacao := sysdate;',
':p134_dt_atualizacao := sysdate;',
'',
'pkg_alter_cadastral.salvar(:p134_cod_empresa, ',
'                           :p134_matricula,',
'                           v_flag, ',
'                           v_mensagem);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''N'';',
'else',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''S''; ',
'end if;',
'',
'exception',
'when others then null;',
'',
'end;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_03=>'P134_DATA_SOLICITACAO,P134_DT_ATUALIZACAO,P134_FLAG,P134_MENSAGEM,P134_OK,P134_ROWID'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269800820395400646661)
,p_event_id=>wwv_flow_api.id(281375255390467022394)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375262318686022399)
,p_name=>'Desabilita Campos'
,p_event_sequence=>110
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375262883700022399)
,p_event_id=>wwv_flow_api.id(281375262318686022399)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_REQ,P134_DATA_SOLICITACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375263271878022399)
,p_name=>'Esconde campo'
,p_event_sequence=>120
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P134_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375263763988022399)
,p_event_id=>wwv_flow_api.id(281375263271878022399)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_REQ,P134_DATA_SOLICITACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375264145328022400)
,p_name=>'Valida Cep'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_COMPLEMENTO_CEP'
,p_condition_element=>'P134_COMPLEMENTO_CEP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375264652014022400)
,p_event_id=>wwv_flow_api.id(281375264145328022400)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    CURSOR C1 IS ',
'        SELECT ENDERECO',
'              ,BAIRRO',
'              ,CIDADE',
'              ,UF         ',
'              ,COD_TP_LOGR',
'         FROM TABELA_CEP ',
'         WHERE CEP              = :P134_CEP',
'           AND COMPLEMENTO_CEP  = :P134_COMPLEMENTO_CEP;',
'    V_C1 C1%ROWTYPE;       ',
'',
'  cursor c2 is',
'     select cep, complemento_cep',
'     from inf_pessoais',
'     where cod_empresa = :P134_cod_empresa',
'     and   matricula   = :P134_matricula;',
'     ',
' v_flag varchar2(1);',
' v_mensagem varchar2(4000);',
' ',
' saida exception;',
' ',
'BEGIN',
'    IF  :P134_UTILIZA_TAB_CEP = ''S''  AND :P134_CEP IS NOT NULL ',
'  AND :P134_COMPLEMENTO_CEP IS NOT NULL THEN ',
'        BEGIN',
'      OPEN  C1;',
'      FETCH C1 INTO V_C1;   ',
'      close c1;',
'          IF v_c1.endereco is null THEN ',
'                 :p134_flag := ''N'';',
unistr('                 :p134_mensagem := ''CEP n\00E3o cadastrado. Dirija-se ao Recursos Humanos!'';'),
'                 ',
'                 ',
'                 /*',
'             open  c2;',
'              fetch c2 into :P134_CEP,:P134_COMPLEMENTO_CEP;        ',
'             close c2;                 ',
'*/',
'',
'',
'               raise saida;',
'          ELSE         ',
'                 IF :P134_CIDADE = ''SEM INFORMACAO''    THEN                     ',
'                 :p134_flag := ''N'';',
unistr('                 :p134_mensagem := ''O campo "Cidade" est\00E1 sem informa\00E7\00E3o. Cadastre-o e tente novamente!'';'),
'                 ',
'                         /*',
'                     open  c2;',
'                      fetch c2 into :P134_CEP,:P134_COMPLEMENTO_CEP;        ',
'                     close c2;',
'                     */',
'                   ',
'                   raise saida;',
'                 END IF;    ',
'            END IF;             ',
' ',
'        END;',
'    end if;    ',
'    ',
'    :p134_flag := ''S'';',
'    :p134_mensagem := null;',
'    ',
'exception',
'when saida then',
'null;',
'    ',
'END;'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA,P134_CEP,P134_COMPLEMENTO_CEP,P134_UTILIZA_TAB_CEP'
,p_attribute_03=>'P134_FLAG,P134_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375265098296022400)
,p_name=>unistr('Popula Endere\00E7o')
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_COMPLEMENTO_CEP'
,p_condition_element=>'P134_COMPLEMENTO_CEP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375265554649022401)
,p_event_id=>wwv_flow_api.id(281375265098296022400)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
' V_COD_TP_LOGR TIPO_LOGRADOURO.COD_TP_LOGR%TYPE;',
' ',
' CURSOR C1(p_cod number) IS',
'       SELECT '' ''||NOME_LOGR',
'       FROM   TIPO_LOGRADOURO',
'       WHERE  COD_TP_LOGR = p_cod;',
'',
'CURSOR C2 IS       ',
'SELECT TABELA_CEP ',
'  FROM EMPRESAS',
' WHERE COD = :p134_cod_empresa;      ',
'  V_C2 C2%ROWTYPE;',
'       ',
'BEGIN',
'    ',
'OPEN C2;',
'FETCH C2 INTO V_C2.TABELA_CEP;',
'CLOSE C2;',
'',
'    IF :p134_UTILIZA_TAB_CEP = ''S'' OR V_C2.TABELA_CEP = ''S'' THEN ',
'',
'        BEGIN',
'            SELECT ENDERECO',
'                  ,BAIRRO',
'                  ,CIDADE',
'                  ,UF',
'             INTO :p134_endereco',
'                 ,:p134_bairro',
'                 ,:p134_cidade',
'                 ,:p134_uf',
'             FROM TABELA_CEP ',
'             WHERE CEP             = :p134_CEP',
'               AND COMPLEMENTO_CEP = :p134_COMPLEMENTO_CEP;',
'',
'    ',
'        EXCEPTION WHEN OTHERS THEN',
'            null;',
'        END;',
'end if;    ',
'',
'END;',
''))
,p_attribute_02=>'P134_COD_EMPRESA,P134_CEP,P134_COMPLEMENTO_CEP,P134_UTILIZA_TAB_CEP'
,p_attribute_03=>'P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375265961165022401)
,p_name=>'Utiliza Tabela Cep'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_UTILIZA_TAB_CEP'
,p_condition_element=>'P134_UTILIZA_TAB_CEP'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>unistr('REDEFLEX pediu para permitir altera\00E7\00E3o (Never)')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375266417535022401)
,p_event_id=>wwv_flow_api.id(281375265961165022401)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375266916800022401)
,p_event_id=>wwv_flow_api.id(281375265961165022401)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_ENDERECO,P134_BAIRRO,P134_CIDADE,P134_UF'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281374392685563192816)
,p_name=>'Esconde Emp. Mat.'
,p_event_sequence=>160
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P134_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281374392758791192817)
,p_event_id=>wwv_flow_api.id(281374392685563192816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281374392873736192818)
,p_event_id=>wwv_flow_api.id(281374392685563192816)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_COD_EMPRESA,P134_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883980324591172972)
,p_name=>'Refresh Documentos'
,p_event_sequence=>170
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269883979486132143747)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883980698629172973)
,p_event_id=>wwv_flow_api.id(269883980324591172972)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276067817800666770919)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883981132222175264)
,p_name=>'OPEN URL_DOCS'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269883979486132143747)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883981471415175265)
,p_event_id=>wwv_flow_api.id(269883981132222175264)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item( "P134_URL_DOCS" ).getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883981902014178993)
,p_name=>'Report - Dialog Closed'
,p_event_sequence=>190
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(276067817800666770919)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883982283385178999)
,p_event_id=>wwv_flow_api.id(269883981902014178993)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(276067817800666770919)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883982677486182792)
,p_name=>'Popula URL_DOCS'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_MATRICULA'
,p_condition_element=>'P134_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883983129359182793)
,p_event_id=>wwv_flow_api.id(269883982677486182792)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P134_URL_DOCS := replace(apex_page.get_url (',
'            p_application => :APP_ID,',
'            p_page        => 864,',
'            p_request     => 134,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM,P864_DESCRICAO,P864_SEQ,P864_COD_SUB_ITEM,P864_COD_REQ'',',
'            p_values      => :P134_COD_EMPRESA||'',''||:P134_MATRICULA||'',''||NULL||'',''||0||'',''||134||'',''||''COLABORADOR''||'',''||null||'',''||:P134_SEQ||'',''||null||'',''||:P134_COD_REQ,',
'            p_clear_cache => 864,',
'            p_session     => :APP_SESSION),''this'',''apex.jQuery(''''#BTN_ANEXO'''')'');'))
,p_attribute_02=>'P134_COD_EMPRESA,P134_MATRICULA,P134_COD_REQ,P134_SEQ'
,p_attribute_03=>'P134_URL_DOCS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883984627856182795)
,p_event_id=>wwv_flow_api.id(269883982677486182792)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P134_URL_DOCS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883933909835400659)
,p_name=>'Inicia Alertify'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P134_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883934009116400660)
,p_event_id=>wwv_flow_api.id(269883933909835400659)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281375250208834022384)
,p_process_sequence=>90
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
'if :p134_rowid is not null then',
unistr('   :p134_titulo := ''Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral: N\00BA ''||:p134_cod_req||'' - ''||:P134_DATA_SOLICITACAO;'),
'else',
unistr('   :p134_titulo := ''Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral'';'),
'end if;',
'',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269800819864163646656)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CREATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'v_cod_req_out number;',
'',
'begin',
'',
':p134_COD_EMP_SOLICITANTE := :P_EMPRESA_USER;',
':p134_MAT_SOLICITANTE := :P_MATRICULA_USER;',
'',
':p134_data_solicitacao := sysdate;',
':p134_dt_atualizacao := sysdate;',
'',
'pkg_alter_cadastral.salvar(:p134_cod_empresa, ',
'                           :p134_matricula,',
'                           v_flag, ',
'                           v_mensagem);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''N'';',
'else',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''S''; ',
'end if;',
'',
'exception',
'when others then null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375248648474022382)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269800819940692646657)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PROCESSA CREATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'v_cod_req_out number;',
'',
'begin',
'',
'pkg_alter_cadastral.processa_cadastro (:p134_cod_empresa,',
'                             :p134_filial,',
'                             :p134_cod_ccusto,',
'                             :p134_matricula,',
'                             :p134_nome,',
'                             :p_usuario,',
'                             :p134_cod_req,',
'                             v_cod_req_out,',
'                             :p134_data_solicitacao,',
'                             v_flag,',
'                             v_mensagem);',
'',
':p134_cod_req := nvl(:p134_cod_req,v_cod_req_out);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''N'';',
'else',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''S''; ',
'end if;',
'                             ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375248648474022382)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269800820211373646659)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SAVE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'v_cod_req_out number;',
'',
'begin',
'',
':p134_rowid := null;',
'',
'',
':p134_data_solicitacao := sysdate;',
':p134_dt_atualizacao := sysdate;',
'',
'pkg_alter_cadastral.salvar(:p134_cod_empresa, ',
'                           :p134_matricula,',
'                           v_flag, ',
'                           v_mensagem);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''N'';',
'else',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''S''; ',
'end if;',
'',
'exception',
'when others then null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375248257152022382)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269800820295508646660)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PROCESSA SAVE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'v_cod_req_out number;',
'',
'begin',
'',
':p134_cod_req := NULL;',
'',
'pkg_alter_cadastral.processa_cadastro (:p134_cod_empresa,',
'                             :p134_filial,',
'                             :p134_cod_ccusto,',
'                             :p134_matricula,',
'                             :p134_nome,',
'                             :p_usuario,',
'                             :p134_cod_req,',
'                             v_cod_req_out,',
'                             :p134_data_solicitacao,',
'                             v_flag,',
'                             v_mensagem);',
'',
':p134_cod_req := nvl(:p134_cod_req,v_cod_req_out);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''N'';',
'else',
'   :p134_flag := v_flag;',
'   :p134_mensagem := v_mensagem;',
'   :p134_ok := ''S''; ',
'end if;',
'                             ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375248257152022382)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281375251461849022385)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of INF_PESSOAIS_PORTAL'
,p_attribute_02=>'INF_PESSOAIS_PORTAL'
,p_attribute_03=>'P134_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Processada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281375251899451022386)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375247872390022381)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883988093115229529)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Create)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update upload_files',
'   set cod_req = :p134_cod_req',
' where cod_empresa = :p134_cod_empresa',
'   and cod_item = :p134_matricula',
'   and tipo_sub_item = 0',
'   and tipo_cod_item = ''COLABORADOR'' ',
'   and seq = :p134_seq;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375248648474022382)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883988783373233362)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Delete)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from upload_files',
'  where cod_empresa = :p134_cod_empresa',
'    and cod_item = :p134_matricula',
'    and tipo_sub_item = 0',
'    and tipo_cod_item = ''COLABORADOR''',
'    and cod_req = :p134_cod_req;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281375247872390022381)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(272375985201135588316)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'INF_PESSOAIS_PORTAL'
,p_attribute_03=>'P134_COD_EMPRESA'
,p_attribute_04=>'COD_EMPRESA'
,p_attribute_05=>'P134_MATRICULA'
,p_attribute_06=>'MATRICULA'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p134_cod_empresa',
'and matricula   = :p134_matricula'))
,p_process_when_type=>'EXISTS'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281375250620217022385)
,p_process_sequence=>20
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
' where i.cod_empresa = :p134_cod_empresa',
'   and i.matricula = :p134_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'',
'begin',
'',
'  begin',
'  select tabela_cep',
'    into :p134_utiliza_tab_cep',
'    from empresas',
'   where cod = :p134_COD_EMPRESA;',
'  ',
'  exception',
'  when others then',
'  null;',
'  end;',
'',
'',
'',
':p134_solicitante := :p134_COD_EMP_SOLICITANTE||'' / ''||:p134_MAT_SOLICITANTE||'' - ''||iNITCAP(fnct_nome_func(:p134_COD_EMP_SOLICITANTE, :p134_MAT_SOLICITANTE));',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p134_cod_empresa_display := v_c1.empresa;',
':p134_matricula_display := v_c1.matricula;',
':p134_situacao_colab := v_c1.situacao;',
':p134_dt_admissao := v_c1.dt_admissao;',
'',
'',
'if :p134_seq is null and :p134_cod_req is null then',
':p134_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'else',
':p134_seq := null;',
'end if;',
'',
'exception',
'when others then',
':p134_cod_empresa_display := :p134_empresa;',
':p134_matricula_display := :p134_matricula;',
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
