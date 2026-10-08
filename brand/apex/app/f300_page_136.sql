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
--   Date and Time:   17:13 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 136
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00136
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>136);
end;
/
prompt --application/pages/page_00136
begin
wwv_flow_api.create_page(
 p_id=>136
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral')
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
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-cad-colaborador  Colaborador: de quem s\00E3o os dados.'),
unistr('  nc-cad-solicitacao  &P136_TITULO.: n\00BA, data e solicitante, no alto.'),
unistr('  nc-cad-seletor      Seletor: sai da tela; os cart\00F5es "O que voc\00EA quer atualizar?" abrem os blocos.'),
'  nc-cad-tema-XXX     cada bloco de dados, com o seu assunto (endereco, contato, banco, pessoais,',
'                      familia, estudo, documentos, uniforme, deficiencia).',
'  nc-cad-anexos       Documentos (Upload): a lista dos comprovantes pedidos pelo que mudou.',
unistr('  nc-cad-acoes        Bot\00F5es: barra fixa no rodap\00E9, com o que falta.'),
'',
unistr('Os campos s\00E3o os do APEX, com as mesmas a\00E7\00F5es din\00E2micas. Bloco sem nc-cad-tema-* continua'),
unistr('onde estava. Bloco novo: d\00EA a ele uma classe nc-cad-tema-XXX existente (ou pe\00E7a um tema novo).'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/CADASTRO-MANUTENCAO.md.'))
,p_last_upd_yyyymmddhh24miss=>'20241105164117'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(151918702361905704763)
,p_name=>'Documentos (Upload)'
,p_region_css_classes=>'nc-cad-anexos'
,p_region_name=>'UPLOAD_DOCS'
,p_template=>wwv_flow_api.id(145492017240415058580)
,p_display_sequence=>25
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
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
'            p_request     => 136,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_TIPO_SUB_ITEM,P864_TIPO_ARQUIVO,P864_TIPO_COD_ITEM,P864_SEQ_ITEM,P864_COD_SUB_ITEM,P864_SEQ,P864_COD_REQ,P864_REQUEST'',',
'            p_values      => u.COD_EMPRESA||'',''||u.cod_item||'',''||u.tipo_sub_item||'',''||U.TIPO_ARQUIVO||'',''||''COLABORADOR''||'',''||U.SEQ_ITEM||'',''||U.COD_SUB_ITEM||'',''||U.SEQ||'',''||U.COD_REQ||'',''||136,',
'            p_clear_cache => 864) editar',
'  FROM upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s',
' WHERE u.tipo_arquivo = t.cod',
'   AND u.tipo_sub_item = s.cod',
'   AND u.tipo_sub_item = t.cod_tipo_sub_item (+)',
'   and u.tipo_sub_item = 0',
'   AND u.cod_empresa   = :p136_cod_empresa',
'   AND u.cod_item      = :p136_matricula',
'   AND u.tipo_cod_item = ''COLABORADOR''',
'   AND ((u.seq = :p136_seq and :p136_cod_req is null) or (u.cod_req = :p136_cod_req))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P136_COD_REQ,P136_SEQ,P136_COD_EMPRESA,P136_MATRICULA'
,p_query_row_template=>wwv_flow_api.id(145492026051969058596)
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
 p_id=>wwv_flow_api.id(143475643885959040044)
,p_query_column_id=>1
,p_column_alias=>'DESC_TIPO_SUB_ITEM'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475644268747040046)
,p_query_column_id=>2
,p_column_alias=>'COD_SUB_ITEM'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475644738500040046)
,p_query_column_id=>3
,p_column_alias=>'SEQ_ITEM'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475645121100040047)
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
 p_id=>wwv_flow_api.id(143475645490661040048)
,p_query_column_id=>5
,p_column_alias=>'DT_ATUALIZACAO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475645876372040049)
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
 p_id=>wwv_flow_api.id(143475646312923040049)
,p_query_column_id=>7
,p_column_alias=>'OBRIG_CANDIDATO'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475646651999040050)
,p_query_column_id=>8
,p_column_alias=>'TIPO_ARQUIVO'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475647133091040051)
,p_query_column_id=>9
,p_column_alias=>'TIPO_SUB_ITEM'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475642700752040043)
,p_query_column_id=>10
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475643142570040043)
,p_query_column_id=>11
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>12
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475643535401040044)
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
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(155874660038981602408)
,p_name=>'Documentos'
,p_template=>wwv_flow_api.id(145492015809736058577)
,p_display_sequence=>45
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.tipo_sub_item||'' - ''||initcap(s.descricao) Tipo_Sub_Item,',
'       case when to_char(nvl(u.cod_sub_item,0)) = 0 then',
'       to_char(u.cod_sub_item)',
'       end cod_sub_item,',
'       u.seq_item,',
'       initcap(t.descricao) documento,',
'       u.dt_atualizacao,',
'       '' - '' VISUALIZAR,',
'       null obrig_candidato,',
'       U.TIPO_ARQUIVO',
'  from UPLOAD_REQ_ALT_CAD u, tipo_arquivo_upload t, tipo_sub_item_upload s',
' where u.tipo_arquivo = t.cod (+)',
'   and u.tipo_sub_item = s.cod (+)',
'   AND u.cod_empresa = :p136_cod_empresa',
'   and u.matricula = :p136_matricula',
'   and nvl(u.cod_req,:p136_seq) = nvl(:p136_cod_req,:p136_seq)',
'   and nvl(u.seq,:p136_cod_req) = nvl(:p136_seq,:p136_cod_req)'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P136_COD_EMPRESA,P136_MATRICULA,P136_SEQ,P136_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(145492026051969058596)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475580737947039931)
,p_query_column_id=>1
,p_column_alias=>'TIPO_SUB_ITEM'
,p_column_display_sequence=>1
,p_column_heading=>'Tipo sub item'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475581100485039937)
,p_query_column_id=>2
,p_column_alias=>'COD_SUB_ITEM'
,p_column_display_sequence=>2
,p_column_heading=>'Cod sub item'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475581544078039937)
,p_query_column_id=>3
,p_column_alias=>'SEQ_ITEM'
,p_column_display_sequence=>3
,p_column_heading=>'Seq item'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475581944484039938)
,p_query_column_id=>4
,p_column_alias=>'DOCUMENTO'
,p_column_display_sequence=>4
,p_column_heading=>'Documento'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475582294006039938)
,p_query_column_id=>5
,p_column_alias=>'DT_ATUALIZACAO'
,p_column_display_sequence=>5
,p_column_heading=>'Dt atualizacao'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475582700722039938)
,p_query_column_id=>6
,p_column_alias=>'VISUALIZAR'
,p_column_display_sequence=>6
,p_column_heading=>'Visualizar'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475583135751039939)
,p_query_column_id=>7
,p_column_alias=>'OBRIG_CANDIDATO'
,p_column_display_sequence=>7
,p_column_heading=>'Obrig candidato'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(143475583451757039941)
,p_query_column_id=>8
,p_column_alias=>'TIPO_ARQUIVO'
,p_column_display_sequence=>8
,p_column_heading=>'Tipo arquivo'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079937212903613979)
,p_plug_name=>'Colaborador'
,p_region_css_classes=>'nc-cad-colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079940365031613982)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P136_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079941127914613983)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P136_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079943150026613984)
,p_plug_name=>'&P136_TITULO.'
,p_region_css_classes=>'nc-cad-solicitacao'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>15
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079946791857613988)
,p_plug_name=>'Seletor'
,p_region_css_classes=>'nc-cad-seletor'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--slimPadding:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>35
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079951584256613994)
,p_plug_name=>'Documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079951985396613995)
,p_plug_name=>'CPF'
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079953173592613996)
,p_plug_name=>'Carteira Profissional'
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079955543642613998)
,p_plug_name=>'PIS / PASEP'
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079956401786613999)
,p_plug_name=>unistr('Habilita\00E7\00E3o Profissional')
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079958389862614001)
,p_plug_name=>'Identidade'
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079961534073614004)
,p_plug_name=>unistr('T\00EDtulo de Eleitor')
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079963938500614007)
,p_plug_name=>'Reservista'
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079964720154614008)
,p_plug_name=>unistr('Carteira Nacional de Habilita\00E7\00E3o')
,p_region_css_classes=>'nc-cad-tema-documentos'
,p_parent_plug_id=>wwv_flow_api.id(156079951584256613994)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079965555192614009)
,p_plug_name=>'Dados Pessoais'
,p_region_css_classes=>'nc-cad-tema-pessoais'
,p_parent_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079971170600614015)
,p_plug_name=>unistr('Endere\00E7o')
,p_region_css_classes=>'nc-cad-tema-endereco'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079974791223614017)
,p_plug_name=>'Contato'
,p_region_css_classes=>'nc-cad-tema-contato'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079977565903614020)
,p_plug_name=>'Medidas'
,p_region_css_classes=>'nc-cad-tema-uniforme'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079979601344614021)
,p_plug_name=>unistr('Dados da M\00E3e')
,p_region_css_classes=>'nc-cad-tema-familia'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079981192920614022)
,p_plug_name=>'Dados do Pai'
,p_region_css_classes=>'nc-cad-tema-familia'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079982776979614023)
,p_plug_name=>'Dados do Conjuge'
,p_region_css_classes=>'nc-cad-tema-familia'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079984349528614024)
,p_plug_name=>unistr('Forma\00E7\00E3o / Escolaridade')
,p_region_css_classes=>'nc-cad-tema-estudo'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>60
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079985968643614025)
,p_plug_name=>unistr('Dados Banc\00E1rios')
,p_region_css_classes=>'nc-cad-tema-banco'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>90
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079988371760614026)
,p_plug_name=>'Portador de Necessidades'
,p_region_css_classes=>'nc-cad-tema-deficiencia'
,p_parent_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079991914951614030)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(145393053751274394435)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(145492038528010058625)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156079992348761614030)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_css_classes=>'nc-cad-acoes'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding'
,p_plug_template=>wwv_flow_api.id(145492009246093058567)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475639548121040039)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_button_name=>'DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Deletar'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_button_condition=>'P136_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475639980577040039)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475640424781040040)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P136_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475591122245039961)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_button_name=>'p136_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
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
 p_id=>wwv_flow_api.id(143475640746286040040)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:135:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475612398948039999)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_button_name=>'DOCUMENTOS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Documentos'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:864:&SESSION.::&DEBUG.:RP,864:P864_COD_EMPRESA,P864_MATRICULA,P864_SEQ,P864_COD_REQ:&P136_COD_EMPRESA.,&P136_MATRICULA.,&P136_SEQ.,&P136_COD_REQ.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-file-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475647463699040051)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(151918702361905704763)
,p_button_name=>'ANEXO'
,p_button_static_id=>'BTN_ANEXO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Anexar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-paperclip'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475585429041039947)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_button_name=>'p136_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P136_COD_EMPRESA.,&P136_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(143475687608612040331)
,p_branch_name=>'Go To Page 135'
,p_branch_action=>'f?p=&APP_ID.:135:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>135
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475583899273039941)
,p_name=>'P136_TIPO_SUB_ITEM'
,p_item_sequence=>950
,p_item_plug_id=>wwv_flow_api.id(155874660038981602408)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Sub-Item'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select cod||'' - ''||initcap(descricao) descricao, cod from tipo_sub_item_upload where colaborador = ''S'' order by 2'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475584344949039944)
,p_name=>'P136_COD_SUB_ITEM'
,p_item_sequence=>960
,p_item_plug_id=>wwv_flow_api.id(155874660038981602408)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo Sub-Item')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NUM_DEPEND||'' - ''||INITCAP(NOME_DEPEND) DESCRICAO, NUM_DEPEND',
'  FROM DEPENDENTES',
' WHERE COD_EMPRESA = :P860_COD_EMPRESA',
'   AND MATRICULA = :P860_MATRICULA',
'   AND :P860_TIPO_SUB_ITEM = 1',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P860_COD_EMPRESA,P860_MATRICULA,P860_TIPO_SUB_ITEM'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475584645903039945)
,p_name=>'P136_SEQ_ITEM'
,p_item_sequence=>970
,p_item_plug_id=>wwv_flow_api.id(155874660038981602408)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475585813713039947)
,p_name=>'P136_COD_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod',
'from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P136_COD_REQ is null) or ',
'        (:P136_COD_REQ is not null)) ',
' and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and cod = :p_empresa_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P136_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475586235317039950)
,p_name=>'P136_MATRICULA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_prompt=>unistr('Matr\00EDcula')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
' from informacoes_funcionais i, centro_de_custo c',
'where i.cod_empresa = c.cod_empresa',
'  and i.cod_ccusto = c.cod',
'  and i.situacao < ''90''',
'  AND I.COD_EMPRESA = :P136_COD_EMPRESA',
'  and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and i.cod_empresa = :p_empresa_user and i.matricula = :p_matricula_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P136_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475586580604039951)
,p_name=>'P136_FILIAL_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475586964537039952)
,p_name=>'P136_IND_DUPLO_VINCULO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475587436674039953)
,p_name=>'P136_DATA_REF'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475587827220039954)
,p_name=>'P136_SALDO_FER_MIN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079937212903613979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475588454056039956)
,p_name=>'P136_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079940365031613982)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p136_cod_empresa',
'                               and matricula   = :p136_matricula), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P136_COD_EMPRESA || ''|'' || :P136_MATRICULA',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475589214323039958)
,p_name=>'P136_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079941127914613983)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475589556663039959)
,p_name=>'P136_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079941127914613983)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475589989257039959)
,p_name=>'P136_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079941127914613983)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475590365970039960)
,p_name=>'P136_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079941127914613983)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475591523763039961)
,p_name=>'P136_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475591903745039963)
,p_name=>'P136_TITULO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475592267701039963)
,p_name=>'P136_COD_PROPOSTA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475592676812039964)
,p_name=>'P136_FLAG_KNEXTITEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475593087503039965)
,p_name=>'P136_MENSAGEM_KNEXTITEM'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475593533727039966)
,p_name=>'P136_DATA_SOLICITACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_prompt=>unistr('Data de Solicita\00E7\00E3o')
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475593850010039966)
,p_name=>'P136_SOLICITANTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(156079943150026613984)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475594611238039968)
,p_name=>'P136_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475595026328039969)
,p_name=>'P136_DC_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475595363105039970)
,p_name=>'P136_NOME'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475595766310039970)
,p_name=>'P136_FILIAL'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475596215759039970)
,p_name=>'P136_DT_ATUALIZACAO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475596643103039971)
,p_name=>'P136_COD_CUSTO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475596967060039971)
,p_name=>'P136_NOME_CCUSTO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475597427489039971)
,p_name=>'P136_COD_EMP_SOLICITANTE'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475597811215039972)
,p_name=>'P136_MAT_SOLICITANTE'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475598202709039972)
,p_name=>'P136_CD_NIVEL'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475598612600039972)
,p_name=>'P136_MOTIVO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(156079946791857613988)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475599561058039974)
,p_name=>'P136_NUM_CPF'
,p_item_sequence=>690
,p_item_plug_id=>wwv_flow_api.id(156079951985396613995)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475599977249039974)
,p_name=>'P136_DC_CPF'
,p_item_sequence=>700
,p_item_plug_id=>wwv_flow_api.id(156079951985396613995)
,p_prompt=>unistr('D\00EDgito')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475600669006039975)
,p_name=>'P136_MOD_CART_PROF'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079953173592613996)
,p_prompt=>'Modelo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Rural;R,Urbano;U'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475601089424039975)
,p_name=>'P136_NUM_CART_PROF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079953173592613996)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475601544194039976)
,p_name=>'P136_SER_CART_PROF'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079953173592613996)
,p_prompt=>unistr('S\00E9rie')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475601893981039976)
,p_name=>'P136_EST_EMIS_PROF'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079953173592613996)
,p_prompt=>'UF'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475602324424039976)
,p_name=>'P136_DT_EMIS_CART'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079953173592613996)
,p_prompt=>unistr('Data de Emiss\00E3o')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475603039402039978)
,p_name=>'P136_NUM_PIS_PASEP'
,p_item_sequence=>770
,p_item_plug_id=>wwv_flow_api.id(156079955543642613998)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475603742761039979)
,p_name=>'P136_NUM_REGISTRO'
,p_item_sequence=>790
,p_item_plug_id=>wwv_flow_api.id(156079956401786613999)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>11
,p_cMaxlength=>11
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475604065816039979)
,p_name=>'P136_SIGLA_CONS_REG'
,p_item_sequence=>800
,p_item_plug_id=>wwv_flow_api.id(156079956401786613999)
,p_prompt=>'Conselho'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select sigla||'' - ''||nome descricao, num_ordem cod from conselho_regional order by 1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475604448631039980)
,p_name=>'P136_REGIAO'
,p_item_sequence=>810
,p_item_plug_id=>wwv_flow_api.id(156079956401786613999)
,p_prompt=>unistr('Regi\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT sigla descricao, sigla',
'  FROM UF',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475604860563039980)
,p_name=>'P136_NOME_FUNCAO_REG'
,p_item_sequence=>820
,p_item_plug_id=>wwv_flow_api.id(156079956401786613999)
,p_prompt=>unistr('Fun\00E7\00E3o do Registro')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>70
,p_cMaxlength=>70
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475605633344039982)
,p_name=>'P136_TIPO_IDENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>'Tipo de Identidade'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:RG;1,Modelo 19;2,Carteira de Estrangeiro;3'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475606007106039985)
,p_name=>'P136_NUM_IDENTIDADE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>12
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475606386457039986)
,p_name=>'P136_EMISSAO_IDENT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>unistr('Data de Emiss\00E3o')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475606829566039986)
,p_name=>'P136_EST_EMIS_IDENT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>unistr('Estado de Emiss\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475607204971039988)
,p_name=>'P136_ORG_EMIS_IDENT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>unistr('Org\00E3o Emissor')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475607610379039988)
,p_name=>'P136_VALID_IDENT_EST'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>'Validade'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475607994293039989)
,p_name=>'P136_TIPO_VISTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(156079958389862614001)
,p_prompt=>'Tipo de Visto'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Tempor\00E1rio / Provis\00F3rio;1,Permanente;2')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475608740415039991)
,p_name=>'P136_NUM_TIT_ELEITOR'
,p_item_sequence=>640
,p_item_plug_id=>wwv_flow_api.id(156079961534073614004)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475609058433039992)
,p_name=>'P136_ZON_TIT_ELEITOR'
,p_item_sequence=>650
,p_item_plug_id=>wwv_flow_api.id(156079961534073614004)
,p_prompt=>'Zona'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475609528671039992)
,p_name=>'P136_SEC_TIT_ELEITOR'
,p_item_sequence=>660
,p_item_plug_id=>wwv_flow_api.id(156079961534073614004)
,p_prompt=>unistr('Se\00E7\00E3o')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475609857485039993)
,p_name=>'P136_DT_EMIS_ELEITOR'
,p_item_sequence=>670
,p_item_plug_id=>wwv_flow_api.id(156079961534073614004)
,p_prompt=>unistr('Data de Emiss\00E3o')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475610293794039993)
,p_name=>'P136_EST_EMIS_TITULO'
,p_item_sequence=>680
,p_item_plug_id=>wwv_flow_api.id(156079961534073614004)
,p_prompt=>unistr('Estado de Emiss\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475611028029039994)
,p_name=>'P136_CERTIF_RESERV'
,p_item_sequence=>710
,p_item_plug_id=>wwv_flow_api.id(156079963938500614007)
,p_prompt=>'Certificado de Reservista'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475611712986039998)
,p_name=>'P136_CNH'
,p_item_sequence=>720
,p_item_plug_id=>wwv_flow_api.id(156079964720154614008)
,p_prompt=>'CNH'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475612765424039999)
,p_name=>'P136_SEQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475613171158040000)
,p_name=>'P136_NOME_DE_GUERRA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Apelido'
,p_placeholder=>'Informe como gostaria de ser chamado(a).'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475613546577040001)
,p_name=>'P136_SEXO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Sexo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Feminino;F,Masculino;M'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475614003020040002)
,p_name=>'P136_DT_NASC'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Data de Nascimento'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475614440397040003)
,p_name=>'P136_ESTADO_CIVIL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Estado Civil'
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
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475614807869040004)
,p_name=>'P136_NACIONALIDADE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Nacionalidade'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select initcap(nome) nome, cod',
'    from nacionalidade',
'   order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475615234696040005)
,p_name=>'P136_UF_NACTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Estado de Nascimento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475615602319040005)
,p_name=>'P136_NATURALIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Naturalidade'
,p_placeholder=>'Cidade de nascimento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475616010414040006)
,p_name=>'P136_NATURALIZACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>unistr('Naturaliza\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475616355759040006)
,p_name=>'P136_ANO_CHEGADA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>'Ano de Chegada'
,p_placeholder=>'Ano em que chegou no Brasil'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475616806206040006)
,p_name=>'P136_COD_RACA_COR'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>unistr('Ra\00E7a / Cor')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descricao) nome, cod',
'    from raca_cor',
'   order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475617205990040007)
,p_name=>'P136_COD_TIPO_MAO_OBRA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>unistr('Tipo de M\00E3o de Obra')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Direta;D,Indireta;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475617546735040007)
,p_name=>'P136_MATRICULA_SUPERIOR'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_prompt=>unistr('Matr\00EDcula do Superior')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT A.MATRICULA||'' - ''||initcap(B.NOME) descricao, a.matricula',
'  FROM INFORMACOES_FUNCIONAIS_CAD A, INF_PESSOAIS_CAD B, CARGOS C',
' WHERE B.COD_EMPRESA = A.COD_EMPRESA',
'   AND B.MATRICULA   = A.MATRICULA',
'   AND C.COD         = A.CARGO',
'   AND C.CLASS_CARGO NOT IN(''PE'', ''AT'')',
'   AND A.SITUACAO    < ''90'' ',
'   AND A.COD_EMPRESA = :P136_COD_EMPRESA',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P136_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475617949961040008)
,p_name=>'P136_NOME_SUPERIOR'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(156079965555192614009)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_SUPERIOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475618672135040009)
,p_name=>'P136_CEP'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'CEP'
,p_format_mask=>'00000'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475619070199040009)
,p_name=>'P136_COMPLEMENTO_CEP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>unistr('D\00EDgito')
,p_format_mask=>'000'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>3
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475619450261040009)
,p_name=>'P136_TIPO_LOGRADOURO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'Logradouro'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(nome_logr) descricao, cod_tp_logr',
'  from tipo_logradouro',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_value=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475619876797040010)
,p_name=>'P136_TIPO_LOGRADOURO_ES'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475620274634040010)
,p_name=>'P136_ENDERECO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>unistr('Endere\00E7o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475620662069040012)
,p_name=>'P136_NUMERO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475621067586040012)
,p_name=>'P136_COMPLEM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'Complemento'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475621477433040013)
,p_name=>'P136_BAIRRO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'Bairro'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>20
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475621873639040013)
,p_name=>'P136_CIDADE'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'Cidade'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475622251131040013)
,p_name=>'P136_UF'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(156079971170600614015)
,p_prompt=>'UF'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT Initcap(u.nome) nome, u.sigla FROM uf u order by u.nome'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037773674058618)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475622998029040014)
,p_name=>'P136_DDD'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'DDD'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>4
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475623373857040015)
,p_name=>'P136_TELEFONE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'Telefone'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475623797840040015)
,p_name=>'P136_DDD_CEL'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'DDD'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>4
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475624214780040016)
,p_name=>'P136_TELEFONE_CELULAR'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'Celular'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475624604265040016)
,p_name=>'P136_E_MAIL_FUNCIONAL'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'E-Mail Funcional'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475624986337040016)
,p_name=>'P136_E_MAIL'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(156079974791223614017)
,p_prompt=>'E-Mail Pessoal'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>50
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475625716048040017)
,p_name=>'P136_NUM_CALCA'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(156079977565903614020)
,p_prompt=>unistr('N\00BA da Cal\00E7a')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475626050111040018)
,p_name=>'P136_NUM_CAMISA'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(156079977565903614020)
,p_prompt=>unistr('N\00BA da Camisa')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475626453510040018)
,p_name=>'P136_NUM_CALCADO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(156079977565903614020)
,p_prompt=>unistr('N\00BA do Cal\00E7ado')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475626845582040018)
,p_name=>'P136_MANEQUIM'
,p_item_sequence=>940
,p_item_plug_id=>wwv_flow_api.id(156079977565903614020)
,p_prompt=>unistr('N\00BA do Manequim')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>15
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475627580171040020)
,p_name=>'P136_NOME_MAE'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(156079979601344614021)
,p_prompt=>unistr('Nome da M\00E3e')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475628017435040020)
,p_name=>'P136_NUM_CPF_MAE'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(156079979601344614021)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>9
,p_cMaxlength=>9
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475628374143040020)
,p_name=>'P136_DC_CPF_MAE'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(156079979601344614021)
,p_prompt=>unistr('D\00EDgito')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475629105308040021)
,p_name=>'P136_NOME_PAI'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(156079981192920614022)
,p_prompt=>'Nome do Pai'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475629500995040026)
,p_name=>'P136_NUM_CPF_PAI'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(156079981192920614022)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>9
,p_cMaxlength=>9
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475629891013040026)
,p_name=>'P136_DC_CPF_PAI'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(156079981192920614022)
,p_prompt=>unistr('D\00EDgito')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475630520205040027)
,p_name=>'P136_NOME_CONJUGE'
,p_item_sequence=>540
,p_item_plug_id=>wwv_flow_api.id(156079982776979614023)
,p_prompt=>'Nome do Conjuge'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475630908714040027)
,p_name=>'P136_NUM_CPF_CONJUGE'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(156079982776979614023)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>9
,p_cMaxlength=>9
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475631335126040028)
,p_name=>'P136_DC_CPF_CONJUGE'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(156079982776979614023)
,p_prompt=>unistr('D\00EDgito')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475631956232040029)
,p_name=>'P136_INSTRUCAO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(156079984349528614024)
,p_prompt=>unistr('Instru\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' SELECT initcap(NOME) nome, cod',
'	  FROM   INSTRUCAO',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475632350630040029)
,p_name=>'P136_COD_FORMACAO_ESCOLAR'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(156079984349528614024)
,p_prompt=>unistr('Forma\00E7\00E3o Escolar')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select initcap(descricao) nome, cod_formacao_escolar',
'    from formacao_escolar',
'   order by cod_formacao_escolar '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475632801175040030)
,p_name=>'P136_TITULACAO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(156079984349528614024)
,p_prompt=>unistr('Titula\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	select initcap(descricao_titulacao) nome, cod_titulacao',
'	  from titulacao',
'	 order by cod_titulacao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475633488689040032)
,p_name=>'P136_BANCO'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(156079985968643614025)
,p_prompt=>'Banco'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod_banco||'' - ''||Initcap(nome_banco) nome, cod_banco ',
'from bancos_agencias ',
'where cod_empresa = :P136_COD_EMPRESA',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P136_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475633935934040033)
,p_name=>'P136_AGENCIA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(156079985968643614025)
,p_prompt=>unistr('Ag\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct bco.cod_agencia||'' - ''||initcap(bco.nome_agencia) nome, cod_agencia',
'  from bancos_agencias BCO ',
' where bco.cod_empresa = :P136_COD_EMPRESA',
'   and bco.cod_banco   = :p136_banco',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P136_COD_EMPRESA,P136_BANCO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475634324297040033)
,p_name=>'P136_NUM_CONTA'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(156079985968643614025)
,p_prompt=>unistr('N\00BA da Conta')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475634739612040033)
,p_name=>'P136_DC_CONTA'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(156079985968643614025)
,p_prompt=>unistr('D\00EDgito')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475635081941040034)
,p_name=>'P136_COD_TP_TRANS_BCA'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(156079985968643614025)
,p_prompt=>unistr('Tipo de Transa\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'		select initcap(descricao) nome, cod',
'		  from tipo_transacao_bancaria',
'         order by cod'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475635771396040035)
,p_name=>'P136_IND_DEF_FIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>'Especial?'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475636188915040035)
,p_name=>'P136_IND_DEF_FIS_BR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>'Reabilitado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475636611380040035)
,p_name=>'P136_TIPO_DEFICIENCIA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_DEFICIENCIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475636964329040036)
,p_name=>'P136_RAIS_IND_DEF_FISICO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>unistr('F\00EDsica')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475637421504040036)
,p_name=>'P136_RAIS_IND_DEF_AUDITIVA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>'Auditiva'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475637752405040037)
,p_name=>'P136_RAIS_IND_DEF_VISUAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>'Visual'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475638228349040037)
,p_name=>'P136_RAIS_IND_DEF_MENTAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>'Mental'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475638551501040037)
,p_name=>'P136_RAIS_IND_DEF_MULTIPLA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(156079988371760614026)
,p_prompt=>unistr('M\00FAltipla')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475641145369040040)
,p_name=>'P136_OK'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475641563836040041)
,p_name=>'P136_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475641958620040041)
,p_name=>'P136_MENSAGEM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156079992348761614030)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475647891081040052)
,p_name=>'P136_URL_DOCS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(151918702361905704763)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(143475649025462040057)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'',
'cursor c0 is',
'select matricula, cod_req',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  if :p136_cod_empresa is null then ',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''O Campo Empresa \00E9 Obrigat\00F3rio!'';'),
'  end if;',
'  ',
'  if :p136_matricula is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''O Campo Matr\00EDcula \00E9 Obrigat\00F3rio!'';'),
'  end if;',
'',
'  if v_c0.matricula is not null and :p134_rowid is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''J\00E1 existe a requisi\00E7\00E3o ''||v_c0.cod_req||'' em andamento!'';'),
'  end if;',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        return v_msg_retorno;',
'    else ',
'      if :p_painel = ''PC'' and :p136_matricula <> :p_matricula_user then',
unistr('        return ''Matr\00EDcula Inv\00E1lida!'';'),
'      else',
'        return null;',
'      end if;',
'    end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(143475640424781040040)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(143876212657260011752)
,p_validation_name=>'Valida Documentos'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'p inf_pessoais_portal%rowtype;',
'',
'begin',
'',
'p.MOD_CART_PROF := :P136_MOD_CART_PROF;',
'p.TIPO_IDENT := :P136_TIPO_IDENT;',
'p.CEP := :P136_CEP;',
'p.IND_DEF_FIS := :P136_IND_DEF_FIS;',
'p.NUM_CART_PROF := :P136_NUM_CART_PROF;',
'p.NUM_IDENTIDADE := :P136_NUM_IDENTIDADE;',
'p.NOME_DE_GUERRA := :P136_NOME_DE_GUERRA;',
'p.COMPLEMENTO_CEP := :P136_COMPLEMENTO_CEP;',
'p.IND_DEF_FIS_BR := :P136_IND_DEF_FIS_BR;',
'p.TIPO_LOGRADOURO := :P136_TIPO_LOGRADOURO;',
'p.SER_CART_PROF := :P136_SER_CART_PROF;',
'p.EMISSAO_IDENT := :P136_EMISSAO_IDENT;',
'p.SEXO := :P136_SEXO;',
'p.TIPO_DEFICIENCIA := :P136_TIPO_DEFICIENCIA;',
'p.TIPO_LOGRADOURO_ES := :P136_TIPO_LOGRADOURO_ES;',
'p.EST_EMIS_PROF := :P136_EST_EMIS_PROF;',
'p.EST_EMIS_IDENT := :P136_EST_EMIS_IDENT;',
'p.DT_NASC := :P136_DT_NASC;',
'p.RAIS_IND_DEF_FISICO := :P136_RAIS_IND_DEF_FISICO;',
'p.NOME := :P136_NOME;',
'p.DT_EMIS_CART := :P136_DT_EMIS_CART;',
'p.ORG_EMIS_IDENT := :P136_ORG_EMIS_IDENT;',
'p.ESTADO_CIVIL := :P136_ESTADO_CIVIL;',
'p.ENDERECO := :P136_ENDERECO;',
'p.RAIS_IND_DEF_AUDITIVA := :P136_RAIS_IND_DEF_AUDITIVA;',
'p.VALID_IDENT_EST := :P136_VALID_IDENT_EST;',
'p.NACIONALIDADE := :P136_NACIONALIDADE;',
'p.NUMERO := :P136_NUMERO;',
'p.RAIS_IND_DEF_VISUAL := :P136_RAIS_IND_DEF_VISUAL;',
'p.TIPO_VISTO := :P136_TIPO_VISTO;',
'p.UF_NACTO := :P136_UF_NACTO;',
'p.COMPLEM := :P136_COMPLEM;',
'p.RAIS_IND_DEF_MENTAL := :P136_RAIS_IND_DEF_MENTAL;',
'p.NATURALIDADE := :P136_NATURALIDADE;',
'p.BAIRRO := :P136_BAIRRO;',
'p.RAIS_IND_DEF_MULTIPLA := :P136_RAIS_IND_DEF_MULTIPLA;',
'p.NATURALIZACAO := :P136_NATURALIZACAO;',
'p.CIDADE := :P136_CIDADE;',
'p.ANO_CHEGADA := :P136_ANO_CHEGADA;',
'p.UF := :P136_UF;',
'p.COD_RACA_COR := :P136_COD_RACA_COR;',
'p.DDD := :P136_DDD;',
'p.COD_TIPO_MAO_OBRA := :P136_COD_TIPO_MAO_OBRA;',
'p.TELEFONE := :P136_TELEFONE;',
'p.MATRICULA_SUPERIOR := :P136_MATRICULA_SUPERIOR;',
'p.NOME_SUPERIOR := :P136_NOME_SUPERIOR;',
'p.INSTRUCAO := :P136_INSTRUCAO;',
'p.COD_FORMACAO_ESCOLAR := :P136_COD_FORMACAO_ESCOLAR;',
'p.NUM_CALCA := :P136_NUM_CALCA;',
'p.TITULACAO := :P136_TITULACAO;',
'p.NUM_CAMISA := :P136_NUM_CAMISA;',
'p.NUM_CALCADO := :P136_NUM_CALCADO;',
'p.DDD_CEL := :P136_DDD_CEL;',
'p.TELEFONE_CELULAR := :P136_TELEFONE_CELULAR;',
'p.E_MAIL_FUNCIONAL := :P136_E_MAIL_FUNCIONAL;',
'p.E_MAIL := :P136_E_MAIL;',
'p.BANCO := :P136_BANCO;',
'p.AGENCIA := :P136_AGENCIA;',
'p.NUM_CONTA := :P136_NUM_CONTA;',
'p.DC_CONTA := :P136_DC_CONTA;',
'p.COD_TP_TRANS_BCA := :P136_COD_TP_TRANS_BCA;',
'p.NOME_MAE := :P136_NOME_MAE;',
'p.NUM_CPF_MAE := :P136_NUM_CPF_MAE;',
'p.DC_CPF_MAE := :P136_DC_CPF_MAE;',
'p.NOME_PAI := :P136_NOME_PAI;',
'p.NUM_CPF_PAI := :P136_NUM_CPF_PAI;',
'p.DC_CPF_PAI := :P136_DC_CPF_PAI;',
'p.NOME_CONJUGE := :P136_NOME_CONJUGE;',
'p.NUM_CPF_CONJUGE := :P136_NUM_CPF_CONJUGE;',
'p.DC_CPF_CONJUGE := :P136_DC_CPF_CONJUGE;',
'p.NUM_TIT_ELEITOR := :P136_NUM_TIT_ELEITOR;',
'p.ZON_TIT_ELEITOR := :P136_ZON_TIT_ELEITOR;',
'p.SEC_TIT_ELEITOR := :P136_SEC_TIT_ELEITOR;',
'p.DT_EMIS_ELEITOR := :P136_DT_EMIS_ELEITOR;',
'p.EST_EMIS_TITULO := :P136_EST_EMIS_TITULO;',
'p.NUM_CPF := :P136_NUM_CPF;',
'p.DC_CPF := :P136_DC_CPF;',
'p.CERTIF_RESERV := :P136_CERTIF_RESERV;',
'p.CNH := :P136_CNH;',
'p.NUM_PIS_PASEP := :P136_NUM_PIS_PASEP;',
'p.NUM_REGISTRO := :P136_NUM_REGISTRO;',
'p.SIGLA_CONS_REG := :P136_SIGLA_CONS_REG;',
'p.REGIAO := :P136_REGIAO;',
'p.NOME_FUNCAO_REG := :P136_NOME_FUNCAO_REG;',
'p.MANEQUIM := :P136_MANEQUIM;',
'',
'prc_valida_req_cad_docs (p_emp => :p136_cod_empresa,',
'           p_mat => :p136_matricula,',
'           p_cod_req => :p136_cod_req,',
'           p_seq => :p136_seq,',
'           p_campos  => p,',
'           p_flg_retorno => v_flg,',
'           p_msg_retorno  => v_msg);',
'',
'',
'if v_flg = ''N'' and trim(v_msg) is not null then',
'return replace(v_msg,chr(10),''<br>'');',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(143475640424781040040)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475653741149040068)
,p_name=>'Popula Campos 2_1'
,p_event_sequence=>18
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MATRICULA'
,p_condition_element=>'P136_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475655645272040072)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMP_SOLICITANTE,P136_MAT_SOLICITANTE,P136_SOLICITANTE,P136_COD_REQ,P136_DATA_SOLICITACAO,P136_COD_CUSTO,P136_NOME_CCUSTO,P136_SEXO,P136_NOME,P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_CEP,P136_DDD,P136_TELEFONE,P136_NUMERO,P136_COMPL'
||'EM,P136_FILIAL,P136_E_MAIL,P136_COMPLEMENTO_CEP,P136_TELEFONE_CELULAR,P136_ESTADO_CIVIL,P136_INSTRUCAO,P136_COD_FORMACAO_ESCOLAR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475656217177040073)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_NUM_CALCA,P136_NUM_CAMISA,P136_NUM_CALCADO,P136_MANEQUIM,P136_DDD_CEL,P136_NUM_IDENTIDADE,P136_DT_NASC,P136_COD_RACA_COR,P136_NACIONALIDADE,P136_UF_NACTO,P136_NATURALIDADE,P136_NATURALIZACAO,P136_ANO_CHEGADA,P136_NOME_MAE,P136_NUM_CPF_MAE,P136_D'
||'C_CPF_MAE,P136_NOME_PAI,P136_NUM_CPF_PAI,P136_DC_CPF_PAI,P136_NOME_CONJUGE,P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE,P136_TITULACAO,P136_DESC_TITULACAO,P136_IND_DEF_FIS,P136_IND_DEF_FIS_BR,P136_TIPO_DEFICIENCIA,P136_CD_NIVEL,P136_TIPO_IDENT,P136_EMISS'
||'AO_IDENT,P136_EST_EMIS_IDENT,P136_ORG_EMIS_IDENT,P136_NUM_TIT_ELEITOR,P136_ZON_TIT_ELEITOR,P136_SEC_TIT_ELEITOR,P136_DT_EMIS_ELEITOR,P136_EST_EMIS_TITULO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475656691792040073)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_NUM_CPF,P136_DC_CPF,P136_CERTIF_RESERV,P136_CNH,P136_NUM_CART_PROF,P136_MOD_CART_PROF,P136_SER_CART_PROF,P136_EST_EMIS_PROF,P136_NUM_PIS_PASEP,P136_DT_EMIS_CART,P136_NUM_REGISTRO,P136_SIGLA_CONS_REG,P136_REGIAO,P136_NOME_FUNCAO_REG,P136_VALID_ID'
||'ENT_EST,P136_TIPO_VISTO,P136_E_MAIL_FUNCIONAL,P136_COD_TIPO_MAO_OBRA,P136_BANCO,P136_AGENCIA,P136_NUM_CONTA,P136_DC_CONTA,P136_COD_TP_TRANS_BCA,P136_MATRICULA_SUPERIOR,P136_NOME_SUPERIOR,P136_MOTIVO,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA'
||',P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA,P136_MANEQUIM,P136_NOME_DE_GUERRA'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475654172891040069)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select iFU.dc_matricula,',
'ip.sexo,',
'ip.nome,',
'ip.endereco,',
'ip.bairro,',
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
'ip.ddd_cel ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'--',
'cod_emp_solicitante,',
'mat_solicitante,',
'cod_req,',
'data_solicitacao,',
'tipo_logradouro,',
'tipo_logradouro_es',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_cod_emp_solicitante := r1.cod_emp_solicitante;',
':p136_mat_solicitante := r1.mat_solicitante;',
':p136_solicitante := :p136_cod_emp_solicitante||'' / ''||:p136_mat_solicitante||'' - ''||iNITCAP(fnct_nome_func(:p136_cod_emp_solicitante, :p136_mat_solicitante));',
':p136_cod_req := r1.cod_req;',
':p136_data_solicitacao := r1.data_solicitacao;',
'',
':p136_cod_custo := r1.cod_ccusto;',
':p136_nome_ccusto := r1.nome_ccusto;',
'',
':p136_sexo := r1.sexo;',
':p136_nome := r1.nome;',
':p136_endereco := r1.endereco;',
':p136_bairro := r1.bairro;',
':p136_cidade := r1.cidade;',
':p136_uf := r1.uf;',
':p136_cep := r1.cep;',
':p136_ddd := r1.ddd;',
':p136_telefone := r1.telefone;',
':p136_numero := r1.numero;',
':p136_complem := r1.complem;',
':p136_filial := r1.filial;',
':p136_e_mail := r1.e_mail;',
':p136_complemento_cep := r1.complemento_cep;',
':p136_TELEFONE_celular := r1.telefone_celular;',
':p136_estado_civil := r1.estado_civil;',
':p136_instrucao := r1.instrucao;',
':p136_cod_formacao_escolar := r1.cod_formacao_escolar;',
':p136_tipo_logradouro := r1.tipo_logradouro;',
':p136_tipo_logradouro_es := r1.tipo_logradouro_es;',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_COD_EMP_SOLICITANTE,P136_MAT_SOLICITANTE,P136_SOLICITANTE,P136_COD_REQ,P136_DATA_SOLICITACAO,P136_COD_CUSTO,P136_NOME_CCUSTO,P136_SEXO,P136_NOME,P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_CEP,P136_DDD,P136_TELEFONE,P136_NUMERO,P136_COMPL'
||'EM,P136_FILIAL,P136_E_MAIL,P136_COMPLEMENTO_CEP,P136_TELEFONE_CELULAR,P136_ESTADO_CIVIL,P136_INSTRUCAO,P136_COD_FORMACAO_ESCOLAR,P136_TIPO_LOGRADOURO,P136_TIPO_LOGRADOURO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475654724912040071)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cel ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'ip.manequim',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_num_calca := r1.num_calca;',
':p136_num_camisa := r1.num_camisa;',
':p136_num_calcado := r1.num_calcado;',
':p136_manequim := r1.manequim;',
':p136_ddd_cel := r1.ddd_cell;',
':p136_num_identidade := r1.num_identidade;',
':p136_dt_nasc := r1.dt_nasc;',
':p136_cod_raca_cor := r1.cod_raca_cor;',
':p136_nacionalidade := r1.nacionalidade;',
':p136_uf_nacto := r1.uf_nacto;',
':p136_naturalidade := r1.naturalidade;',
':p136_naturalizacao := r1.naturalizacao;        ',
':p136_ano_chegada := r1.ano_chegada;',
':p136_nome_mae := r1.nome_mae;',
':p136_num_cpf_mae := r1.num_cpf_mae;',
':p136_dc_cpf_mae := r1.dc_cpf_mae;',
':p136_nome_pai := r1.nome_pai;',
':p136_num_cpf_pai := r1.num_cpf_pai;',
':p136_dc_cpf_pai := r1.dc_cpf_pai;',
':p136_nome_conjuge := r1.nome_conjuge;',
':p136_num_cpf_conjuge := r1.num_cpf_conjuge;',
':p136_dc_cpf_conjuge := r1.dc_cpf_conjuge;',
':p136_titulacao := r1.titulacao;',
'-- :p136_desc_titulacao := r1.descricao_titulacao;',
':p136_ind_def_fis := r1.ind_def_fis;',
':p136_ind_def_fis_br := r1.ind_def_fis_br;',
':p136_tipo_deficiencia := r1.tipo_deficiencia;',
':p136_cd_nivel := r1.cd_nivel;',
':p136_tipo_ident := r1.tipo_ident;',
':p136_emissao_ident := r1.emissao_ident;',
':p136_est_emis_ident := r1.est_emis_ident;',
':p136_org_emis_ident := r1.org_emis_ident;',
':p136_num_tit_eleitor := r1.num_tit_eleitor;',
':p136_zon_tit_eleitor := r1.zon_tit_eleitor;',
':p136_sec_tit_eleitor := r1.sec_tit_eleitor;',
':p136_dt_emis_eleitor := r1.dt_emis_eleitor;',
':p136_est_emis_titulo := r1.est_emis_titulo;',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_NUM_CALCA,P136_NUM_CAMISA,P136_NUM_CALCADO,P136_MANEQUIM,P136_DDD_CEL,P136_NUM_IDENTIDADE,P136_DT_NASC,P136_COD_RACA_COR,P136_NACIONALIDADE,P136_UF_NACTO,P136_NATURALIDADE,P136_NATURALIZACAO,P136_ANO_CHEGADA,P136_NOME_MAE,P136_NUM_CPF_MAE,P136_D'
||'C_CPF_MAE,P136_NOME_PAI,P136_NUM_CPF_PAI,P136_DC_CPF_PAI,P136_NOME_CONJUGE,P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE,P136_TITULACAO,P136_DESC_TITULACAO,P136_IND_DEF_FIS,P136_IND_DEF_FIS_BR,P136_TIPO_DEFICIENCIA,P136_CD_NIVEL,P136_TIPO_IDENT,P136_EMISS'
||'AO_IDENT,P136_EST_EMIS_IDENT,P136_ORG_EMIS_IDENT,P136_NUM_TIT_ELEITOR,P136_ZON_TIT_ELEITOR,P136_SEC_TIT_ELEITOR,P136_DT_EMIS_ELEITOR,P136_EST_EMIS_TITULO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475655209238040071)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cel ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'--',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'NVL(IP.NOME_DE_GUERRA,ifu.nome_de_guerra) NOME_DE_GUERRA,',
'ma.cod motivo,',
'--',
'cod_emp_solicitante,',
'mat_solicitante,',
'cod_req,',
'data_solicitacao,',
'ip.RAIS_IND_DEF_FISICO,',
'ip.RAIS_IND_DEF_AUDITIVA,',
'ip.RAIS_IND_DEF_VISUAL,',
'ip.RAIS_IND_DEF_MENTAL,',
'ip.RAIS_IND_DEF_MULTIPLA,',
'ip.MANEQUIM',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_num_cpf := r1.num_cpf;',
':p136_dc_cpf := r1.dc_cpf;',
':p136_certif_reserv := r1.certif_reserv;',
':p136_cnh := r1.cnh;',
':p136_num_cart_prof := r1.num_cart_prof;',
':p136_mod_cart_prof := r1.mod_cart_prof;',
':p136_ser_cart_prof := r1.ser_cart_prof;',
':p136_est_emis_prof := r1.est_emis_prof;',
':p136_num_pis_pasep := r1.num_pis_pasep;',
':p136_dt_emis_cart := r1.dt_emis_cart;',
':p136_num_registro := r1.num_registro;',
':p136_sigla_cons_reg := r1.sigla_cons_reg;',
':p136_regiao := r1.regiao;',
':p136_nome_funcao_reg := r1.nome_funcao_reg;',
':p136_valid_ident_est := r1.valid_ident_est;',
':p136_tipo_visto := r1.tipo_visto;',
':p136_e_mail_funcional := r1.email_funcional;',
':p136_cod_tipo_mao_obra := UPPER(r1.tipo_mao_obra);',
':p136_banco := r1.banco;',
':p136_agencia := r1.agencia;',
':p136_num_conta := r1.conta;',
':p136_dc_conta := r1.dc_conta;',
':p136_cod_tp_trans_bca := r1.cod_tp_trans_bca;',
':p136_nome_de_guerra := r1.nome_de_guerra;',
':p136_matricula_superior := r1.matricula_superior;',
':p136_nome_superior := r1.nome_superior;',
':p136_motivo := r1.motivo;',
'',
':p136_RAIS_IND_DEF_FISICO := r1.RAIS_IND_DEF_FISICO;',
':p136_RAIS_IND_DEF_AUDITIVA := r1.RAIS_IND_DEF_AUDITIVA;',
':p136_RAIS_IND_DEF_VISUAL := r1.RAIS_IND_DEF_VISUAL;',
':p136_RAIS_IND_DEF_MENTAL := r1.RAIS_IND_DEF_MENTAL;',
':p136_RAIS_IND_DEF_MULTIPLA := r1.RAIS_IND_DEF_MULTIPLA;',
':p136_MANEQUIM := r1.MANEQUIM;',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_NUM_CPF,P136_DC_CPF,P136_CERTIF_RESERV,P136_CNH,P136_NUM_CART_PROF,P136_MOD_CART_PROF,P136_SER_CART_PROF,P136_EST_EMIS_PROF,P136_NUM_PIS_PASEP,P136_DT_EMIS_CART,P136_NUM_REGISTRO,P136_SIGLA_CONS_REG,P136_REGIAO,P136_NOME_FUNCAO_REG,P136_VALID_ID'
||'ENT_EST,P136_TIPO_VISTO,P136_E_MAIL_FUNCIONAL,P136_COD_TIPO_MAO_OBRA,P136_BANCO,P136_AGENCIA,P136_NUM_CONTA,P136_DC_CONTA,P136_COD_TP_TRANS_BCA,P136_MATRICULA_SUPERIOR,P136_NOME_SUPERIOR,P136_MOTIVO,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA'
||',P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA,P136_MANEQUIM,P136_NOME_DE_GUERRA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475657217468040074)
,p_event_id=>wwv_flow_api.id(143475653741149040068)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
'select matricula, cod_req',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'if v_c0.matricula is not null and :p136_rowid is null then',
'  :p136_flag := ''N'';',
unistr('  :p136_mensagem := ''J\00E1 existe a requisi\00E7\00E3o ''||v_c0.cod_req||'' em andamento!'';'),
'end if;',
'',
'end;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_ROWID'
,p_attribute_03=>'P136_FLAG,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475657574318040074)
,p_name=>'Popula Campos 1_1'
,p_event_sequence=>28
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MATRICULA'
,p_condition_element=>'P136_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475660630973040080)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMP_SOLICITANTE,P136_MAT_SOLICITANTE,P136_SOLICITANTE,P136_COD_REQ,P136_DATA_SOLICITACAO,P136_COD_CUSTO,P136_NOME_CCUSTO,P136_SEXO,P136_NOME,P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_CEP,P136_DDD,P136_TELEFONE,P136_NUMERO,P136_COMPL'
||'EM,P136_FILIAL,P136_E_MAIL,P136_COMPLEMENTO_CEP,P136_TELEFONE_CELULAR,P136_ESTADO_CIVIL,P136_INSTRUCAO,P136_COD_FORMACAO_ESCOLAR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475661122509040082)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_NUM_CALCA,P136_NUM_CAMISA,P136_NUM_CALCADO,P136_MANEQUIM,P136_DDD_CEL,P136_NUM_IDENTIDADE,P136_DT_NASC,P136_COD_RACA_COR,P136_NACIONALIDADE,P136_UF_NACTO,P136_NATURALIDADE,P136_NATURALIZACAO,P136_ANO_CHEGADA,P136_NOME_MAE,P136_NUM_CPF_MAE,P136_D'
||'C_CPF_MAE,P136_NOME_PAI,P136_NUM_CPF_PAI,P136_DC_CPF_PAI,P136_NOME_CONJUGE,P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE,P136_TITULACAO,P136_DESC_TITULACAO,P136_IND_DEF_FIS,P136_IND_DEF_FIS_BR,P136_TIPO_DEFICIENCIA,P136_CD_NIVEL,P136_TIPO_IDENT,P136_EMISS'
||'AO_IDENT,P136_EST_EMIS_IDENT,P136_ORG_EMIS_IDENT,P136_NUM_TIT_ELEITOR,P136_ZON_TIT_ELEITOR,P136_SEC_TIT_ELEITOR,P136_DT_EMIS_ELEITOR,P136_EST_EMIS_TITULO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475661571725040082)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_NUM_CPF,P136_DC_CPF,P136_CERTIF_RESERV,P136_CNH,P136_NUM_CART_PROF,P136_MOD_CART_PROF,P136_SER_CART_PROF,P136_EST_EMIS_PROF,P136_NUM_PIS_PASEP,P136_DT_EMIS_CART,P136_NUM_REGISTRO,P136_SIGLA_CONS_REG,P136_REGIAO,P136_NOME_FUNCAO_REG,P136_VALID_ID'
||'ENT_EST,P136_TIPO_VISTO,P136_E_MAIL_FUNCIONAL,P136_COD_TIPO_MAO_OBRA,P136_BANCO,P136_AGENCIA,P136_NUM_CONTA,P136_DC_CONTA,P136_COD_TP_TRANS_BCA,P136_MATRICULA_SUPERIOR,P136_NOME_SUPERIOR,P136_MOTIVO,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA'
||',P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA,P136_MANEQUIM,P136_NOME_DE_GUERRA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475658104800040076)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select iFU.dc_matricula,',
'ip.sexo,',
'ip.nome,',
'ip.endereco,',
'ip.bairro,',
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
'ip.ddd_cell ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'tipo_logradouro,',
'tipo_logradouro_es',
'--',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_dc_matricula := r1.dc_matricula;',
'',
':p136_cod_custo := nvl(:p136_cod_custo ,r1.cod_ccusto);',
':p136_nome_ccusto := nvl(:p136_nome_ccusto ,r1.nome_ccusto);',
'',
':p136_sexo := nvl(:p136_sexo ,r1.sexo);',
':p136_nome := nvl(:p136_nome ,r1.nome);',
':p136_endereco := nvl(:p136_endereco ,r1.endereco);',
':p136_bairro := nvl(:p136_bairro ,r1.bairro);',
':p136_cidade := nvl(:p136_cidade ,r1.cidade);',
':p136_uf := nvl(:p136_uf ,r1.uf);',
':p136_cep := nvl(:p136_cep ,r1.cep);',
':p136_ddd := nvl(:p136_ddd ,r1.ddd);',
':p136_telefone := nvl(:p136_telefone ,r1.telefone);',
':p136_numero := nvl(:p136_numero ,r1.numero);',
':p136_complem := nvl(:p136_complem ,r1.complem);',
':p136_filial := nvl(:p136_filial ,r1.filial);',
':p136_e_mail := nvl(:p136_e_mail ,r1.e_mail);',
':p136_complemento_cep := nvl(:p136_complemento_cep ,r1.complemento_cep);',
':p136_TELEFONE_celular := nvl(:p136_TELEFONE_celular ,r1.telefone_celular);',
':p136_estado_civil := nvl(:p136_estado_civil ,r1.estado_civil);',
':p136_instrucao := nvl(:p136_instrucao ,r1.instrucao);',
':p136_cod_formacao_escolar := nvl(:p136_cod_formacao_escolar ,r1.cod_formacao_escolar);',
':p136_tipo_logradouro := nvl(:p136_tipo_logradouro,r1.tipo_logradouro);',
':p136_tipo_logradouro_es := nvl(:p136_tipo_logradouro_es,r1.tipo_logradouro_es);',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_COD_CUSTO,P136_NOME_CCUSTO,P136_SEXO,P136_NOME,P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_CEP,P136_DDD,P136_TELEFONE,P136_NUMERO,P136_COMPLEM,P136_FILIAL,P136_E_MAIL,P136_COMPLEMENTO_CEP,P136_TELEFONE_CELU'
||'LAR,P136_ESTADO_CIVIL,P136_INSTRUCAO,P136_COD_FORMACAO_ESCOLAR,P136_TIPO_LOGRADOURO,P136_TIPO_LOGRADOURO_ES'
,p_attribute_03=>'P136_DC_MATRICULA,P136_COD_CUSTO,P136_NOME_CCUSTO,P136_SEXO,P136_NOME,P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_CEP,P136_DDD,P136_TELEFONE,P136_NUMERO,P136_COMPLEM,P136_FILIAL,P136_E_MAIL,P136_COMPLEMENTO_CEP,P136_TELEFONE_CELULAR,P136_ESTAD'
||'O_CIVIL,P136_INSTRUCAO,P136_COD_FORMACAO_ESCOLAR,P136_TIPO_LOGRADOURO,P136_TIPO_LOGRADOURO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475658596127040077)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cell ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.manequim,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'ifu.dc_conta',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_num_calca := nvl(:p136_num_calca ,r1.num_calca);',
':p136_num_camisa := nvl(:p136_num_camisa ,r1.num_camisa);',
':p136_num_calcado := nvl(:p136_num_calcado ,r1.num_calcado);',
':p136_manequim := nvl(:p136_manequim, r1.manequim);',
':p136_ddd_cel := nvl(:p136_ddd_cel ,r1.ddd_cell);',
':p136_num_identidade := nvl(:p136_num_identidade ,r1.num_identidade);',
':p136_dt_nasc := nvl(:p136_dt_nasc ,r1.dt_nasc);',
':p136_cod_raca_cor := nvl(:p136_cod_raca_cor ,r1.cod_raca_cor);',
':p136_nacionalidade := nvl(:p136_nacionalidade ,r1.nacionalidade);',
':p136_uf_nacto := nvl(:p136_uf_nacto ,r1.uf_nacto);',
':p136_naturalidade := nvl(:p136_naturalidade ,r1.naturalidade);',
':p136_naturalizacao := nvl(:p136_naturalizacao ,r1.naturalizacao);        ',
':p136_ano_chegada := nvl(:p136_ano_chegada ,r1.ano_chegada);',
':p136_nome_mae := nvl(:p136_nome_mae ,r1.nome_mae);',
':p136_num_cpf_mae := nvl(:p136_num_cpf_mae ,r1.num_cpf_mae);',
':p136_dc_cpf_mae := nvl(:p136_dc_cpf_mae ,r1.dc_cpf_mae);',
':p136_nome_pai := nvl(:p136_nome_pai ,r1.nome_pai);',
':p136_num_cpf_pai := nvl(:p136_num_cpf_pai ,r1.num_cpf_pai);',
':p136_dc_cpf_pai := nvl(:p136_dc_cpf_pai ,r1.dc_cpf_pai);',
':p136_nome_conjuge := nvl(:p136_nome_conjuge ,r1.nome_conjuge);',
':p136_num_cpf_conjuge := nvl(:p136_num_cpf_conjuge ,r1.num_cpf_conjuge);',
':p136_dc_cpf_conjuge := nvl(:p136_dc_cpf_conjuge ,r1.dc_cpf_conjuge);',
'',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_NUM_CALCA,P136_NUM_CAMISA,P136_NUM_CALCADO,P136_NUM_MANEQUIM,P136_DDD_CEL,P136_NUM_IDENTIDADE,P136_DT_NASC,P136_COD_RACA_COR,P136_NACIONALIDADE,P136_UF_NACTO,P136_NATURALIDADE,P136_NATURALIZACAO,P136_ANO_CHEGADA,P'
||'136_NOME_MAE,P136_NUM_CPF_MAE,P136_DC_CPF_MAE,P136_NOME_PAI,P136_NUM_CPF_PAI,P136_DC_CPF_PAI,P136_NOME_CONJUGE,P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE'
,p_attribute_03=>'P136_NUM_CALCA,P136_NUM_CAMISA,P136_NUM_CALCADO,P136_MANEQUIM,P136_DDD_CEL,P136_NUM_IDENTIDADE,P136_DT_NASC,P136_COD_RACA_COR,P136_NACIONALIDADE,P136_UF_NACTO,P136_NATURALIDADE,P136_NATURALIZACAO,P136_ANO_CHEGADA,P136_NOME_MAE,P136_NUM_CPF_MAE,P136_D'
||'C_CPF_MAE,P136_NOME_PAI,P136_NUM_CPF_PAI,P136_DC_CPF_PAI,P136_NOME_CONJUGE,P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475659075320040078)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cell ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'ifu.dc_conta',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_titulacao := nvl(:p136_titulacao ,r1.titulacao);',
'--:p136_desc_titulacao := nvl(:p136_desc_titulacao ,r1.descricao_titulacao);',
':p136_ind_def_fis := nvl(:p136_ind_def_fis ,r1.ind_def_fis);',
':p136_ind_def_fis_br := nvl(:p136_ind_def_fis_br ,r1.ind_def_fis_br);',
':p136_tipo_deficiencia := nvl(:p136_tipo_deficiencia ,r1.tipo_deficiencia);',
':p136_cd_nivel := nvl(:p136_cd_nivel ,r1.cd_nivel);',
':p136_tipo_ident := nvl(:p136_tipo_ident ,r1.tipo_ident);',
':p136_emissao_ident := nvl(:p136_emissao_ident ,r1.emissao_ident);',
':p136_est_emis_ident := nvl(:p136_est_emis_ident ,r1.est_emis_ident);',
':p136_org_emis_ident := nvl(:p136_org_emis_ident ,r1.org_emis_ident);',
':p136_num_tit_eleitor := nvl(:p136_num_tit_eleitor ,r1.num_tit_eleitor);',
':p136_zon_tit_eleitor := nvl(:p136_zon_tit_eleitor ,r1.zon_tit_eleitor);',
':p136_sec_tit_eleitor := nvl(:p136_sec_tit_eleitor ,r1.sec_tit_eleitor);',
':p136_dt_emis_eleitor := nvl(:p136_dt_emis_eleitor ,r1.dt_emis_eleitor);',
':p136_est_emis_titulo := nvl(:p136_est_emis_titulo ,r1.est_emis_titulo);',
'',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_TITULACAO,P136_IND_DEF_FIS,P136_IND_DEF_FIS_BR,P136_TIPO_DEFICIENCIA,P136_CD_NIVEL,P136_TIPO_IDENT,P136_EMISSAO_IDENT,P136_EST_EMIS_IDENT,P136_ORG_EMIS_IDENT,P136_NUM_TIT_ELEITOR,P136_ZON_TIT_ELEITOR,P136_SEC_TIT_'
||'ELEITOR,P136_DT_EMIS_ELEITOR,P136_EST_EMIS_TITULO'
,p_attribute_03=>'P136_TITULACAO,P136_IND_DEF_FIS,P136_IND_DEF_FIS_BR,P136_TIPO_DEFICIENCIA,P136_CD_NIVEL,P136_TIPO_IDENT,P136_EMISSAO_IDENT,P136_EST_EMIS_IDENT,P136_ORG_EMIS_IDENT,P136_NUM_TIT_ELEITOR,P136_ZON_TIT_ELEITOR,P136_SEC_TIT_ELEITOR,P136_DT_EMIS_ELEITOR,P13'
||'6_EST_EMIS_TITULO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475659634092040079)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cell ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'--',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ip.RAIS_IND_DEF_FISICO,',
'ip.RAIS_IND_DEF_AUDITIVA,',
'ip.RAIS_IND_DEF_VISUAL,',
'ip.RAIS_IND_DEF_MENTAL,',
'ip.RAIS_IND_DEF_MULTIPLA,',
'ip.MANEQUIM',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_num_cpf := nvl(:p136_num_cpf ,r1.num_cpf);',
':p136_dc_cpf := nvl(:p136_dc_cpf ,r1.dc_cpf);',
':p136_certif_reserv := nvl(:p136_certif_reserv ,r1.certif_reserv);',
':p136_cnh := nvl(:p136_cnh ,r1.cnh);',
':p136_num_cart_prof := nvl(:p136_num_cart_prof ,r1.num_cart_prof);',
':p136_mod_cart_prof := nvl(:p136_mod_cart_prof ,r1.mod_cart_prof);',
':p136_ser_cart_prof := nvl(:p136_ser_cart_prof ,r1.ser_cart_prof);',
':p136_est_emis_prof := nvl(:p136_est_emis_prof ,r1.est_emis_prof);',
':p136_num_pis_pasep := nvl(:p136_num_pis_pasep ,r1.num_pis_pasep);',
':p136_dt_emis_cart := nvl(:p136_dt_emis_cart ,r1.dt_emis_cart);',
':p136_num_registro := nvl(:p136_num_registro ,r1.num_registro);',
':p136_sigla_cons_reg := nvl(:p136_sigla_cons_reg ,r1.sigla_cons_reg);',
':p136_regiao := nvl(:p136_regiao ,r1.regiao);',
':p136_nome_funcao_reg := nvl(:p136_nome_funcao_reg ,r1.nome_funcao_reg);',
':p136_valid_ident_est := nvl(:p136_valid_ident_est ,r1.valid_ident_est);',
':p136_tipo_visto := nvl(:p136_tipo_visto ,r1.tipo_visto);',
':p136_e_mail_funcional := nvl(:p136_e_mail_funcional ,r1.email_funcional);',
':p136_cod_tipo_mao_obra := UPPER(nvl(:p136_cod_tipo_mao_obra ,r1.tipo_mao_obra));',
'----------------------------',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_NUM_CPF,P136_DC_CPF,P136_CERTIF_RESERV,P136_CNH,P136_NUM_CART_PROF,P136_MOD_CART_PROF,P136_SER_CART_PROF,P136_EST_EMIS_PROF,P136_NUM_PIS_PASEP,P136_DT_EMIS_CART,P136_NUM_REGISTRO,P136_SIGLA_CONS_REG,P136_REGIAO,P1'
||'36_NOME_FUNCAO_REG,P136_VALID_IDENT_EST,P136_TIPO_VISTO,P136_E_MAIL_FUNCIONAL,P136_COD_TIPO_MAO_OBRA'
,p_attribute_03=>'P136_NUM_CPF,P136_DC_CPF,P136_CERTIF_RESERV,P136_CNH,P136_NUM_CART_PROF,P136_MOD_CART_PROF,P136_SER_CART_PROF,P136_EST_EMIS_PROF,P136_NUM_PIS_PASEP,P136_DT_EMIS_CART,P136_NUM_REGISTRO,P136_SIGLA_CONS_REG,P136_REGIAO,P136_NOME_FUNCAO_REG,P136_VALID_ID'
||'ENT_EST,P136_TIPO_VISTO,P136_E_MAIL_FUNCIONAL,P136_COD_TIPO_MAO_OBRA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475660102530040080)
,p_event_id=>wwv_flow_api.id(143475657574318040074)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ip.ddd_cell ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'--',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'--',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ip.RAIS_IND_DEF_FISICO,',
'ip.RAIS_IND_DEF_AUDITIVA,',
'ip.RAIS_IND_DEF_VISUAL,',
'ip.RAIS_IND_DEF_MENTAL,',
'ip.RAIS_IND_DEF_MULTIPLA,',
'ip.MANEQUIM',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
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
':p136_banco := nvl(:p136_banco ,r1.banco);',
':p136_agencia := nvl(:p136_agencia ,r1.agencia);',
':p136_num_conta := nvl(:p136_num_conta ,r1.conta);',
':p136_dc_conta := nvl(:p136_dc_conta ,r1.dc_conta);',
':p136_cod_tp_trans_bca := nvl(:p136_cod_tp_trans_bca ,r1.cod_tp_trans_bca);',
':p136_nome_de_guerra := nvl(:P136_nome_de_guerra ,r1.nome_de_guerra);',
':p136_matricula_superior := nvl(:p136_matricula_superior ,r1.matricula_superior);',
':p136_nome_superior := nvl(:p136_nome_superior ,r1.nome_superior);',
':p136_motivo := nvl(:p136_motivo ,r1.motivo);',
'--:p136_descricao_motivo := nvl(:p136_descricao_motivo ,r1.descricao_motivo);',
':p136_RAIS_IND_DEF_FISICO := nvl(:p136_RAIS_IND_DEF_FISICO ,r1.RAIS_IND_DEF_FISICO);',
':p136_RAIS_IND_DEF_AUDITIVA := nvl(:p136_RAIS_IND_DEF_AUDITIVA ,r1.RAIS_IND_DEF_AUDITIVA);',
':p136_RAIS_IND_DEF_VISUAL := nvl(:p136_RAIS_IND_DEF_VISUAL ,r1.RAIS_IND_DEF_VISUAL);',
':p136_RAIS_IND_DEF_MENTAL := nvl(:p136_RAIS_IND_DEF_MENTAL ,r1.RAIS_IND_DEF_MENTAL);',
':p136_RAIS_IND_DEF_MULTIPLA := nvl(:p136_RAIS_IND_DEF_MULTIPLA ,r1.RAIS_IND_DEF_MULTIPLA);',
':p136_MANEQUIM := nvl(:p136_MANEQUIM ,r1.MANEQUIM);',
'----------------------------',
'',
'END;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_BANCO,P136_AGENCIA,P136_NUM_CONTA,P136_DC_CONTA,P136_COD_TP_TRANS_BCA,P136_MATRICULA_SUPERIOR,P136_NOME_SUPERIOR,P136_MOTIVO,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA,P136_RAIS_IND_DEF_VISUAL,P136_RAIS_I'
||'ND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA,P136_MANEQUIM'
,p_attribute_03=>'P136_BANCO,P136_AGENCIA,P136_NUM_CONTA,P136_DC_CONTA,P136_COD_TP_TRANS_BCA,P136_MATRICULA_SUPERIOR,P136_NOME_SUPERIOR,P136_MOTIVO,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA,P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_'
||'MULTIPLA,P136_MANEQUIM,P136_NOME_DE_GUERRA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475662041079040082)
,p_name=>'Popula Nome_Superior'
,p_event_sequence=>58
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MATRICULA_SUPERIOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475662522425040083)
,p_event_id=>wwv_flow_api.id(143475662041079040082)
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
'   AND A.COD_EMPRESA = :p136_cod_empresa',
'   and a.matricula = :p136_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p136_nome_superior := v_c1.nome;',
'',
'end;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_NOME_SUPERIOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475662932801040083)
,p_name=>'Esconde Campos Def.'
,p_event_sequence=>68
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_IND_DEF_FIS'
,p_condition_element=>'P136_IND_DEF_FIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475663402380040084)
,p_event_id=>wwv_flow_api.id(143475662932801040083)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_IND_DEF_FIS_BR,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA,P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475663849292040084)
,p_event_id=>wwv_flow_api.id(143475662932801040083)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_IND_DEF_FIS_BR,P136_RAIS_IND_DEF_FISICO,P136_RAIS_IND_DEF_AUDITIVA,P136_RAIS_IND_DEF_VISUAL,P136_RAIS_IND_DEF_MENTAL,P136_RAIS_IND_DEF_MULTIPLA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475664328893040084)
,p_name=>'Dispara Alerta'
,p_event_sequence=>78
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MENSAGEM'
,p_condition_element=>'P136_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475664798699040085)
,p_event_id=>wwv_flow_api.id(143475664328893040084)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P136_FLAG'').value == "Q") {',
'alertify.confirm($v(''P136_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P136_FLAG'').value = ''S'';',
'        $x(''P136_MENSAGEM'').value = '''';',
'        $x(''P136_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P136_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P136_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P136_FLAG'').value == "N") {',
'            $x(''P136_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P136_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P136_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P136_MENSAGEM''));',
'    }else{',
'            if ($x(''P136_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P136_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475665191519040085)
,p_name=>'CREATE'
,p_event_sequence=>88
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(143475640424781040040)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475666178924040086)
,p_event_id=>wwv_flow_api.id(143475665191519040085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMPRESA,P136_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475666672015040086)
,p_event_id=>wwv_flow_api.id(143475665191519040085)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_REQ,P136_DATA_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475667174083040086)
,p_event_id=>wwv_flow_api.id(143475665191519040085)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P136_COD_REQ'').disabled = false;',
'$x(''P136_DATA_SOLICITACAO'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475665731610040085)
,p_event_id=>wwv_flow_api.id(143475665191519040085)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475667584213040087)
,p_name=>'Salvar (SAVE)'
,p_event_sequence=>98
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(143475639980577040039)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475668083885040087)
,p_event_id=>wwv_flow_api.id(143475667584213040087)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_REQ,P136_DATA_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475668588026040087)
,p_event_id=>wwv_flow_api.id(143475667584213040087)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P136_COD_REQ'').disabled = false;',
'$x(''P136_DATA_SOLICITACAO'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475669098949040088)
,p_event_id=>wwv_flow_api.id(143475667584213040087)
,p_event_result=>'TRUE'
,p_action_sequence=>30
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
'',
':p136_data_solicitacao := sysdate;',
':p136_dt_atualizacao := sysdate;',
'',
'pkg_alter_cadastral.salvar(:p136_cod_empresa, ',
'                           :p136_matricula,',
'                           v_flag, ',
'                           v_mensagem);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''N'';',
'else',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''S''; ',
'end if;',
'',
'exception',
'when others then null;',
'',
'end;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_DATA_SOLICITACAO,P136_DT_ATUALIZACAO,P136_FLAG,P136_MENSAGEM,P136_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475669379151040309)
,p_name=>'Processa Cadastro (SAVE)'
,p_event_sequence=>118
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(143475639980577040039)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475669848704040309)
,p_event_id=>wwv_flow_api.id(143475669379151040309)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
'pkg_alter_cadastral.processa_cadastro (:p136_cod_empresa,',
'                             :p136_filial,',
'                             :p136_cod_ccusto,',
'                             :p136_matricula,',
'                             :p136_nome,',
'                             :p_usuario,',
'                             :p136_cod_req,',
'                             v_cod_req_out,',
'                             :p136_data_solicitacao,',
'                             v_flag,',
'                             v_mensagem);',
'',
':p136_cod_req := nvl(:p136_cod_req,v_cod_req_out);',
'',
'if v_flag in (''N'',''Q'') then',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''N'';',
'else',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''S''; ',
'end if;',
'                             ',
'end;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_FILIAL,P136_COD_CCUSTO,P136_MATRICULA,P136_NOME,P_USUARIO,P136_COD_REQ,P136_DATA_SOLICITACAO'
,p_attribute_03=>'P136_COD_REQ,P136_FLAG,P136_MENSAGEM,P136_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475670337314040309)
,p_name=>'Desabilita Campos'
,p_event_sequence=>128
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475670773304040310)
,p_event_id=>wwv_flow_api.id(143475670337314040309)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_REQ,P136_DATA_SOLICITACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475671161207040310)
,p_name=>'Esconde campo'
,p_event_sequence=>138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_COD_REQ'
,p_condition_element=>'P136_COD_REQ'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475671744658040310)
,p_event_id=>wwv_flow_api.id(143475671161207040310)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_REQ,P136_DATA_SOLICITACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475672193288040311)
,p_event_id=>wwv_flow_api.id(143475671161207040310)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_REQ,P136_DATA_SOLICITACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475672641423040311)
,p_name=>'Esconde Mat'
,p_event_sequence=>148
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P136_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475673069513040311)
,p_event_id=>wwv_flow_api.id(143475672641423040311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475673597110040312)
,p_event_id=>wwv_flow_api.id(143475672641423040311)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475674124031040312)
,p_event_id=>wwv_flow_api.id(143475672641423040311)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
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
' where i.cod_empresa = :p136_cod_empresa',
'   and i.matricula = :p136_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p136_cod_empresa_display := v_c1.empresa;',
':p136_matricula_display := v_c1.matricula;',
':p136_situacao_colab := v_c1.situacao;',
':p136_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p136_cod_empresa_display := :p136_empresa;',
':p136_matricula_display := :p136_matricula;',
'end;'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_03=>'P136_COD_EMPRESA_DISPLAY,P136_MATRICULA_DISPLAY,P136_SITUACAO_COLAB,P136_DT_ADMISSAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475674542340040312)
,p_name=>'Mostra Mat'
,p_event_sequence=>158
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P136_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475675023276040313)
,p_event_id=>wwv_flow_api.id(143475674542340040312)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475675542766040313)
,p_event_id=>wwv_flow_api.id(143475674542340040312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_COD_EMPRESA,P136_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475675872451040313)
,p_name=>'Seta Solicitante'
,p_event_sequence=>168
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MAT_SOLICITANTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475676355384040314)
,p_event_id=>wwv_flow_api.id(143475675872451040313)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p136_solicitante := :p136_cod_emp_solicitante||'' / ''||:p136_mat_solicitante||'' - ''||iNITCAP(fnct_nome_func(:p136_cod_emp_solicitante, :p136_mat_solicitante));'
,p_attribute_02=>'P136_COD_EMP_SOLICITANTE,P136_MAT_SOLICITANTE'
,p_attribute_03=>'P136_SOLICITANTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475676799119040316)
,p_name=>'Valida_Cpf'
,p_event_sequence=>178
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_DC_CPF'
,p_condition_element=>'P136_DC_CPF'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475677338926040316)
,p_event_id=>wwv_flow_api.id(143475676799119040316)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P136_NUM_CPF));',
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
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF),i,1)));',
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
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF),i,1)));',
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
'   if dc_cpf_final <> :P136_DC_CPF then',
'     :P136_FLAG := ''N'';',
'     :P136_OK := ''N'';',
unistr('     :P136_MENSAGEM := ''CPF Inv\00E1lido!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'end;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'',
'END;'))
,p_attribute_02=>'P136_NUM_CPF,P136_DC_CPF'
,p_attribute_03=>'P136_FLAG,P136_OK,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475677724983040317)
,p_name=>'Valida_Cpf_1'
,p_event_sequence=>188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_DC_CPF_CONJUGE'
,p_condition_element=>'P136_DC_CPF_CONJUGE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475678171863040318)
,p_event_id=>wwv_flow_api.id(143475677724983040317)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P136_NUM_CPF_CONJUGE));',
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
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_CONJUGE),i,1)));',
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
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_CONJUGE),i,1)));',
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
'   if dc_cpf_final <> :P136_DC_CPF_CONJUGE then',
'     :P136_FLAG := ''N'';',
'     :P136_OK := ''N'';',
unistr('     :P136_MENSAGEM := ''CPF Inv\00E1lido!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'end;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'',
'END;'))
,p_attribute_02=>'P136_NUM_CPF_CONJUGE,P136_DC_CPF_CONJUGE'
,p_attribute_03=>'P136_FLAG,P136_OK,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475678598926040318)
,p_name=>'Valida_Cpf_2'
,p_event_sequence=>198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_DC_CPF_PAI'
,p_condition_element=>'P136_DC_CPF_PAI'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475679052400040318)
,p_event_id=>wwv_flow_api.id(143475678598926040318)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P136_NUM_CPF_PAI));',
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
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_PAI),i,1)));',
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
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_PAI),i,1)));',
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
'   if dc_cpf_final <> :P136_DC_CPF_PAI then',
'     :P136_FLAG := ''N'';',
'     :P136_OK := ''N'';',
unistr('     :P136_MENSAGEM := ''CPF Inv\00E1lido!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'end;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'',
'END;'))
,p_attribute_02=>'P136_NUM_CPF_PAI,P136_DC_CPF_PAI'
,p_attribute_03=>'P136_FLAG,P136_OK,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475679534792040318)
,p_name=>'Valida_Cpf_3'
,p_event_sequence=>208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_DC_CPF_MAE'
,p_condition_element=>'P136_DC_CPF_MAE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475679948832040319)
,p_event_id=>wwv_flow_api.id(143475679534792040318)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'SAIDA EXCEPTION;',
'',
'BEGIN',
'  declare',
'  tamanho        number(1) := length(to_char(:P136_NUM_CPF_MAE));',
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
'     tot1 := tot1 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_MAE),i,1)));',
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
'     tot2 := tot2 + multiplicador*(to_number(substr(to_char(:P136_NUM_CPF_MAE),i,1)));',
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
'   if dc_cpf_final <> :P136_DC_CPF_MAE then',
'     :P136_FLAG := ''N'';',
'     :P136_OK := ''N'';',
unistr('     :P136_MENSAGEM := ''CPF Inv\00E1lido!'';'),
'     ',
'      raise SAIDA;',
'   end if;',
'--   next_item;',
'end;',
'',
'EXCEPTION',
'WHEN SAIDA THEN',
'NULL;',
'',
'END;'))
,p_attribute_02=>'P136_NUM_CPF_MAE,P136_DC_CPF_MAE'
,p_attribute_03=>'P136_FLAG,P136_OK,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475680429947040319)
,p_name=>'Inicia Alertify'
,p_event_sequence=>218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475680889504040320)
,p_event_id=>wwv_flow_api.id(143475680429947040319)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
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
 p_id=>wwv_flow_api.id(143475681328158040320)
,p_name=>'Valida Num_Pis_Pasep'
,p_event_sequence=>228
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_NUM_PIS_PASEP'
,p_condition_element=>'P136_NUM_PIS_PASEP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475681781501040321)
,p_event_id=>wwv_flow_api.id(143475681328158040320)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' saida exception;',
'',
' v_digito1  number(1) := 0;',
' v_digito2  number(1) := 0;',
'  ',
' V_NUM_PIS_PASEP INF_PESSOAIS.NUM_PIS_PASEP%TYPE;',
' VL_SITUACAO INFORMACOES_FUNCIONAIS.SITUACAO%TYPE;',
' ',
' V_FLG_RETORNO VARCHAR2(1);',
' V_OK VARCHAR2(1);',
' V_MSG_RETORNO VARCHAR2(4000);',
' ',
'begin',
'',
'if :P136_COD_REQ is not null then',
'',
'  if :p136_num_pis_pasep is not null then',
'     v_digito1 := fnct_calc_pis(:p136_num_pis_pasep);',
'     v_digito2 := substr(lpad(to_char(:p136_num_pis_pasep),11,''0''),11,1);',
'     if v_digito1 <> v_digito2 then',
'         V_FLG_RETORNO := ''N'';',
'         V_OK := ''N'';',
unistr('         V_MSG_RETORNO := ''D\00EDgito controle do PIS/PASEP incorreto!!!'';'),
'        raise saida;',
'     end if;',
'  end if;',
'  ',
'  BEGIN',
'    SELECT DISTINCT P.NUM_PIS_PASEP, F.SITUACAO',
'      INTO V_NUM_PIS_PASEP, VL_SITUACAO          ',
'      FROM INF_PESSOAIS P,',
'           INFORMACOES_FUNCIONAIS F',
'     WHERE P.COD_EMPRESA = :p136_COD_EMPRESA',
'       AND P.NUM_PIS_PASEP = :p136_NUM_PIS_PASEP',
'       AND F.COD_EMPRESA = P.COD_EMPRESA',
'       AND F.MATRICULA = P.MATRICULA',
'       AND :p136_NUM_PIS_PASEP <> 0',
'       and F.SITUACAO < ''90'';',
'         ',
'         V_FLG_RETORNO := ''Q'';',
'         V_OK := ''N'';',
unistr('         V_MSG_RETORNO := ''PIS/PASEP j\00E1 cadastrado para o seguinte funcion\00E1rio ativo: ''||'),
'        fnct_pis(:p136_COD_EMPRESA,''A'',:p136_num_pis_pasep)||'', deseja continuar?'';',
'        raise saida;',
'         ',
'  EXCEPTION',
'    WHEN NO_DATA_FOUND THEN',
'        begin',
'            SELECT DISTINCT P.NUM_PIS_PASEP, F.SITUACAO',
'              INTO V_NUM_PIS_PASEP, VL_SITUACAO          ',
'              FROM INF_PESSOAIS P,',
'                    INFORMACOES_FUNCIONAIS F',
'                 WHERE P.COD_EMPRESA = :p136_COD_EMPRESA',
'               AND P.NUM_PIS_PASEP = :p136_NUM_PIS_PASEP',
'               AND F.COD_EMPRESA = P.COD_EMPRESA',
'               AND F.MATRICULA = P.MATRICULA',
'               AND :p136_NUM_PIS_PASEP <> 0',
'               and F.SITUACAO > ''90'';',
'',
'         V_FLG_RETORNO := ''Q'';',
'         V_OK := ''N'';',
unistr('         V_MSG_RETORNO := ''PIS/PASEP j\00E1 cadastrado para o seguinte ex-funcion\00E1rio: ''||'),
'                    fnct_pis(:p136_COD_EMPRESA,''D'',:p136_num_pis_pasep)||'', deseja continuar?'';',
'        raise saida;',
'                   ',
'                exception ',
'                    when no_data_found then',
'                        null;',
'                    when too_many_rows then',
'                        ',
'                     V_FLG_RETORNO := ''Q'';',
'                     V_OK := ''N'';',
unistr('                     V_MSG_RETORNO := ''PIS/PASEP j\00E1 cadastrado para os seguintes ex-funcion\00E1rios: ''||'),
'                            fnct_pis(:p136_COD_EMPRESA,''D'',:p136_num_pis_pasep)||'', deseja continuar?'';',
'                    raise saida;',
'                    ',
'      end;',
'    WHEN TOO_MANY_ROWS THEN',
'    ',
'        V_FLG_RETORNO := ''Q'';',
'        V_OK := ''N'';',
unistr('        V_MSG_RETORNO := ''PIS/PASEP j\00E1 cadastrado para os seguintes funcion\00E1rios ativos: ''||'),
'        fnct_pis(:p136_COD_EMPRESA,''A'',:p136_num_pis_pasep)||'', deseja continuar?'';',
'        raise saida;',
'                    ',
'  END;',
'  ',
'end if;  ',
'  ',
' :P136_FLAG := NULL;',
' :P136_OK := ''S'';',
' :P136_MENSAGEM := NULL;',
'  ',
'EXCEPTION',
'WHEN SAIDA THEN',
' :P136_FLAG := V_FLG_RETORNO;',
' :P136_OK := V_OK;',
' :P136_MENSAGEM := V_MSG_RETORNO;',
'',
'END;'))
,p_attribute_02=>'P136_NUM_PIS_PASEP,P136_COD_EMPRESA,P136_COD_REQ'
,p_attribute_03=>'P136_FLAG,P136_OK,P136_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475682207761040321)
,p_name=>unistr('Popula Endere\00E7o')
,p_event_sequence=>238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_CEP,P136_COMPLEMENTO_CEP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475682735170040321)
,p_event_id=>wwv_flow_api.id(143475682207761040321)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  cursor c1 is',
'  select trim(c.endereco) endereco, c.bairro, c.cidade, c.uf, c.cod_tp_logr, t.codigo_es',
'    from tabela_cep c, tipo_logradouro t',
'   where c.cod_tp_logr = t.cod_tp_logr (+)',
'     and c.cep = :p136_cep',
'     and c.complemento_cep = :p136_complemento_cep;',
'',
'  v_c1 c1%rowtype;',
'',
'  v_endereco varchar2(100);',
'  v_ibge number;',
'',
'begin',
'/*',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'*/',
'    prc_api_busca_cep(p_cep =>                    :p136_cep, ',
'                      p_complem_cep =>            :p136_complemento_cep, ',
'                      p_endereco =>               :p136_endereco, ',
'                      p_bairro =>                 :p136_bairro, ',
'                      p_cidade =>                 :p136_cidade, ',
'                      p_uf =>                     :p136_uf, ',
'                      p_cod_tipo_logradouro =>    :p136_tipo_logradouro, ',
'                      p_cod_tipo_logradouro_es => :p136_tipo_logradouro_es, ',
'                      p_ibge =>                   v_ibge); ',
'',
'/*',
'    :p136_endereco := v_c1.endereco;',
'    :p136_bairro := v_c1.bairro;',
'    :p136_cidade := v_c1.cidade;',
'    :p136_uf := v_c1.uf;',
'    :p136_tipo_logradouro := v_c1.cod_tp_logr;',
'    :p136_tipo_logradouro_es := v_c1.codigo_es;',
'*/',
'    :p136_numero := null;',
'    :p136_complem := null;',
'',
'end;'))
,p_attribute_02=>'P136_CEP,P136_COMPLEMENTO_CEP'
,p_attribute_03=>'P136_ENDERECO,P136_BAIRRO,P136_CIDADE,P136_UF,P136_NUMERO,P136_COMPLEM,P136_TIPO_LOGRADOURO,P136_TIPO_LOGRADOURO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475683978259040323)
,p_name=>'Refresh Documentos'
,p_event_sequence=>248
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(143475647463699040051)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475684491314040323)
,p_event_id=>wwv_flow_api.id(143475683978259040323)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(151918702361905704763)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475684845873040323)
,p_name=>'OPEN URL_DOCS'
,p_event_sequence=>258
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(143475647463699040051)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475685377695040324)
,p_event_id=>wwv_flow_api.id(143475684845873040323)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item( "P136_URL_DOCS" ).getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475683073081040321)
,p_name=>'Report - Dialog Closed'
,p_event_sequence=>268
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(151918702361905704763)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475683600157040322)
,p_event_id=>wwv_flow_api.id(143475683073081040321)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(151918702361905704763)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475685756231040324)
,p_name=>'Popula URL_DOCS'
,p_event_sequence=>278
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P136_MATRICULA'
,p_condition_element=>'P136_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475686184781040327)
,p_event_id=>wwv_flow_api.id(143475685756231040324)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P136_URL_DOCS := replace(apex_page.get_url (',
'            p_application => :APP_ID,',
'            p_page        => 864,',
'            p_request     => 136,',
'            p_items       => ''P864_COD_EMPRESA,P864_COD_ITEM,P864_SEQ_ITEM,P864_TIPO_SUB_ITEM,P864_REQUEST,P864_TIPO_COD_ITEM,P864_DESCRICAO,P864_SEQ,P864_COD_SUB_ITEM,P864_COD_REQ'',',
'            p_values      => :P136_COD_EMPRESA||'',''||:P136_MATRICULA||'',''||NULL||'',''||0||'',''||136||'',''||''COLABORADOR''||'',''||null||'',''||:P136_SEQ||'',''||null||'',''||:P136_COD_REQ,',
'            p_clear_cache => 864,',
'            p_session     => :APP_SESSION),''this'',''apex.jQuery(''''#BTN_ANEXO'''')'');'))
,p_attribute_02=>'P136_COD_EMPRESA,P136_MATRICULA,P136_COD_REQ,P136_SEQ'
,p_attribute_03=>'P136_URL_DOCS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475686731646040328)
,p_event_id=>wwv_flow_api.id(143475685756231040324)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P136_URL_DOCS'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475651684179040062)
,p_process_sequence=>10
,p_process_point=>'AFTER_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pintar Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
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
'ip.ddd_cel ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'-----------------------------------------------------------------',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'-----------------------------------------------------------------',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'nvl(ip.nome_de_guerra,ifu.nome_de_guerra) nome_de_guerra,',
'ma.cod motivo,',
'-----------------------------------------------------------------',
'cod_emp_solicitante,',
'mat_solicitante,',
'cod_req,',
'data_solicitacao,',
'ip.COD_TIPO_MAO_OBRA,',
'ip.E_MAIL_FUNCIONAL,',
'ip.RAIS_IND_DEF_FISICO,',
'ip.RAIS_IND_DEF_AUDITIVA,',
'ip.RAIS_IND_DEF_VISUAL,',
'ip.RAIS_IND_DEF_MENTAL,',
'ip.RAIS_IND_DEF_MULTIPLA,',
'ip.MANEQUIM,',
'ip.NUM_CONTA',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c2 is',
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
'ip.ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'-----------------------------------------------------------------',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'-----------------------------------------------------------------',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'ip.RAIS_IND_DEF_FISICO,',
'ip.RAIS_IND_DEF_AUDITIVA,',
'ip.RAIS_IND_DEF_VISUAL,',
'ip.RAIS_IND_DEF_MENTAL,',
'ip.RAIS_IND_DEF_MULTIPLA,',
'ip.MANEQUIM',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r2 c2%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula;',
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
' if nvl(r1.NOME_DE_GUERRA,''Z'') <> nvl(r2.NOME_DE_GUERRA,''Z'')    then',
'     begin htp.script(''P136_NOME_DE_GUERRA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.SEXO,''Z'') <> nvl(r2.SEXO,''Z'')    then',
'     begin htp.script(''P136_SEXO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if r1.DT_NASC <> r2.DT_NASC    then',
'     begin htp.script(''P136_DT_NASC.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.ESTADO_CIVIL,''Z'') <> nvl(r2.ESTADO_CIVIL,''Z'')    then',
'     begin htp.script(''P136_ESTADO_CIVIL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NACIONALIDADE,0) <> nvl(r2.NACIONALIDADE,0)    then',
'     begin htp.script(''P136_NACIONALIDADE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.UF_NACTO,''Z'') <> nvl(r2.UF_NACTO,''Z'')    then',
'     begin htp.script(''P136_UF_NACTO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NATURALIDADE,''Z'') <> nvl(r2.NATURALIDADE,''Z'')    then',
'     begin htp.script(''P136_NATURALIDADE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NATURALIZACAO,''Z'') <> nvl(r2.NATURALIZACAO,''Z'')    then',
'     begin htp.script(''P136_NATURALIZACAO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.ANO_CHEGADA,0) <> nvl(r2.ANO_CHEGADA,0)    then',
'     begin htp.script(''P136_ANO_CHEGADA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if r1.COD_RACA_COR <> r2.COD_RACA_COR    then',
'     begin htp.script(''P136_COD_RACA_COR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  /*if r1.COD_TIPO_MAO_OBRA <> r2.COD_TIPO_MAO_OBRA    then',
'     begin htp.script(''P136_COD_TIPO_MAO_OBRA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' */',
' ',
'  if nvl(r1.MATRICULA_SUPERIOR,0) <> nvl(r2.MATRICULA_SUPERIOR,0)     then',
'     begin htp.script(''P136_MATRICULA_SUPERIOR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.ENDERECO,''Z'') <> nvl(r2.ENDERECO,''Z'')    then',
'     begin htp.script(''P136_ENDERECO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.NUMERO,0) <> nvl(r2.NUMERO,0)    then',
'     begin htp.script(''P136_NUMERO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.COMPLEM,''Z'') <> nvl(r2.COMPLEM,''Z'')    then',
'     begin htp.script(''P136_COMPLEM.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.BAIRRO,''Z'') <> nvl(r2.BAIRRO,''Z'')    then',
'     begin htp.script(''P136_BAIRRO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.CIDADE,''Z'') <> nvl(r2.CIDADE,''Z'')    then',
'     begin htp.script(''P136_CIDADE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.UF,''Z'') <> nvl(r2.UF,''Z'') then',
'     begin htp.script(''P136_UF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.CEP,0) <> nvl(r2.CEP,0)    then',
'     begin htp.script(''P136_CEP.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.COMPLEMENTO_CEP,0) <> nvl(r2.COMPLEMENTO_CEP,0)    then',
'     begin htp.script(''P136_COMPLEMENTO_CEP.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.DDD,0) <> nvl(r2.DDD,0)    then',
'     begin htp.script(''P136_DDD.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.TELEFONE,0) <> nvl(r2.TELEFONE,0)     then',
'     begin htp.script(''P136_TELEFONE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.DDD_CELL,0) <> nvl(r2.DDD_CELL,0)    then',
'     begin htp.script(''P136_DDD_CEL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.TELEFONE_CELULAR,0) <> nvl(r2.TELEFONE_CELULAR,0)    then',
'     begin htp.script(''P136_TELEFONE_CELULAR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  /*if r1.E_MAIL_FUNCIONAL <> r2.E_MAIL_FUNCIONAL    then',
'     begin htp.script(''P136_E_MAIL_FUNCIONAL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' */',
'  if nvl(r1.E_MAIL,''Z'') <> nvl(r2.E_MAIL,''Z'')    then',
'     begin htp.script(''P136_E_MAIL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NOME_MAE,''Z'') <> nvl(r2.NOME_MAE,''Z'') then',
'     begin htp.script(''P136_NOME_MAE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.NUM_CPF_MAE,0) <> nvl(r2.NUM_CPF_MAE,0)    then',
'     begin htp.script(''P136_NUM_CPF_MAE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if r1.DC_CPF_MAE <> r2.DC_CPF_MAE    then',
'     begin htp.script(''P136_DC_CPF_MAE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.NOME_PAI,''Z'') <> nvl(r2.NOME_PAI,''Z'')    then',
'     begin htp.script(''P136_NOME_PAI.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.NUM_CPF_PAI,0) <> nvl(r2.NUM_CPF_PAI,0)    then',
'     begin htp.script(''P136_NUM_CPF_PAI.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if r1.DC_CPF_PAI <> r2.DC_CPF_PAI    then',
'     begin htp.script(''P136_DC_CPF_PAI.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.NOME_CONJUGE,''Z'') <> nvl(r2.NOME_CONJUGE,''Z'')    then',
'     begin htp.script(''P136_NOME_CONJUGE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.NUM_CPF_CONJUGE,0) <> nvl(r2.NUM_CPF_CONJUGE,0)    then',
'     begin htp.script(''P136_NUM_CPF_CONJUGE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if r1.DC_CPF_CONJUGE <> r2.DC_CPF_CONJUGE    then',
'     begin htp.script(''P136_DC_CPF_CONJUGE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   if nvl(r1.INSTRUCAO,''Z'') <> nvl(r2.INSTRUCAO,''Z'')    then',
'     begin htp.script(''P136_INSTRUCAO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.COD_FORMACAO_ESCOLAR,''Z'') <> nvl(r2.COD_FORMACAO_ESCOLAR,''Z'')    then',
'     begin htp.script(''P136_COD_FORMACAO_ESCOLAR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.TITULACAO,''Z'') <> nvl(r2.TITULACAO,''Z'')    then',
'     begin htp.script(''P136_TITULACAO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.IND_DEF_FIS,''Z'') <> nvl(r2.IND_DEF_FIS,''Z'')    then',
'     begin htp.script(''P136_IND_DEF_FIS.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.IND_DEF_FIS_BR,''Z'') <> nvl(r2.IND_DEF_FIS_BR,''Z'')    then',
'     begin htp.script(''P136_IND_DEF_FIS_BR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.RAIS_IND_DEF_FISICO,''Z'') <> nvl(r2.RAIS_IND_DEF_FISICO,''Z'')   then',
'     begin htp.script(''P136_RAIS_IND_DEF_FISICO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.RAIS_IND_DEF_AUDITIVA,''Z'') <> nvl(r2.RAIS_IND_DEF_AUDITIVA,''Z'')    then',
'     begin htp.script(''P136_RAIS_IND_DEF_AUDITIVA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.RAIS_IND_DEF_VISUAL,''Z'') <> nvl(r2.RAIS_IND_DEF_VISUAL,''Z'')    then',
'     begin htp.script(''P136_RAIS_IND_DEF_VISUAL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.RAIS_IND_DEF_MENTAL,''Z'') <> nvl(r2.RAIS_IND_DEF_MENTAL,''Z'')    then',
'     begin htp.script(''P136_RAIS_IND_DEF_MENTAL.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.RAIS_IND_DEF_MULTIPLA,''Z'') <> nvl(r2.RAIS_IND_DEF_MULTIPLA,''Z'')    then',
'     begin htp.script(''P136_RAIS_IND_DEF_MULTIPLA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.NUM_CALCA,''Z'') <> nvl(r2.NUM_CALCA,''Z'')    then',
'     begin htp.script(''P136_NUM_CALCA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.NUM_CAMISA,''Z'') <> nvl(r2.NUM_CAMISA,''Z'')    then',
'     begin htp.script(''P136_NUM_CAMISA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.NUM_CALCADO,''Z'') <> nvl(r2.NUM_CALCADO,''Z'')    then',
'     begin htp.script(''P136_NUM_CALCADO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.MANEQUIM,''Z'') <> nvl(r2.MANEQUIM,''Z'')    then',
'     begin htp.script(''P136_MANEQUIM.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.BANCO,0) <> nvl(r2.BANCO,0)    then',
'     begin htp.script(''P136_BANCO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.AGENCIA,0) <> nvl(r2.AGENCIA,0)    then',
'     begin htp.script(''P136_AGENCIA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'   /* if r1.NUM_CONTA <> r2.NUM_CONTA    then',
'     begin htp.script(''P136_NUM_CONTA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;*/',
' ',
'    if nvl(r1.DC_CONTA,''Z'') <> nvl(r2.DC_CONTA,''Z'')    then',
'     begin htp.script(''P136_DC_CONTA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.COD_TP_TRANS_BCA,0) <> nvl(r2.COD_TP_TRANS_BCA,0)    then',
'     begin htp.script(''P136_COD_TP_TRANS_BCA.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'if nvl(r1.TIPO_IDENT,''Z'') <> nvl(r2.TIPO_IDENT,''Z'')    then',
'     begin htp.script(''P136_TIPO_IDENT.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'    if nvl(r1.NUM_IDENTIDADE,''Z'') <> nvl(r2.NUM_IDENTIDADE,''Z'')    then',
'     begin htp.script(''P136_NUM_IDENTIDADE.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'if nvl(r1.EMISSAO_IDENT,sysdate) <> nvl(r2.EMISSAO_IDENT,sysdate)    then',
'     begin htp.script(''P136_EMISSAO_IDENT.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.EST_EMIS_IDENT,''Z'') <> nvl(r2.EST_EMIS_IDENT,''Z'')   then',
'     begin htp.script(''P136_EST_EMIS_IDENT.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.ORG_EMIS_IDENT,''Z'') <> nvl(r2.ORG_EMIS_IDENT,''Z'')    then',
'     begin htp.script(''P136_ORG_EMIS_IDENT.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.VALID_IDENT_EST,sysdate) <> nvl(r2.VALID_IDENT_EST,sysdate)    then',
'     begin htp.script(''P136_VALID_IDENT_EST.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.TIPO_VISTO,''Z'') <> nvl(r2.TIPO_VISTO,''Z'')   then',
'     begin htp.script(''P136_TIPO_VISTO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.NUM_CPF,0) <> nvl(r2.NUM_CPF,0)    then',
'     begin htp.script(''P136_NUM_CPF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.DC_CPF,0) <> nvl(r2.DC_CPF,0)    then',
'     begin htp.script(''P136_DC_CPF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.CERTIF_RESERV,''Z'') <> nvl(r2.CERTIF_RESERV,''Z'')    then',
'     begin htp.script(''P136_CERTIF_RESERV.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.NUM_TIT_ELEITOR,0) <> nvl(r2.NUM_TIT_ELEITOR,0)    then',
'     begin htp.script(''P136_NUM_TIT_ELEITOR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.ZON_TIT_ELEITOR,0) <> nvl(r2.ZON_TIT_ELEITOR,0)    then',
'     begin htp.script(''P136_ZON_TIT_ELEITOR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.SEC_TIT_ELEITOR,0) <> nvl(r2.SEC_TIT_ELEITOR,0)    then',
'     begin htp.script(''P136_SEC_TIT_ELEITOR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.DT_EMIS_ELEITOR,sysdate) <> nvl(r2.DT_EMIS_ELEITOR,sysdate)    then',
'     begin htp.script(''P136_DT_EMIS_ELEITOR.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.EST_EMIS_TITULO,''Z'') <> nvl(r2.EST_EMIS_TITULO,''Z'')    then',
'     begin htp.script(''P136_EST_EMIS_TITULO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' if nvl(r1.CNH,0) <> nvl(r2.CNH,0)    then',
'     begin htp.script(''P136_CNH.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.MOD_CART_PROF,''Z'') <> nvl(r2.MOD_CART_PROF,''Z'')    then',
'     begin htp.script(''P136_MOD_CART_PROF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_CART_PROF,0) <> nvl(r2.NUM_CART_PROF,0)    then',
'     begin htp.script(''P136_NUM_CART_PROF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.SER_CART_PROF,''Z'') <> nvl(r2.SER_CART_PROF,''Z'')    then',
'     begin htp.script(''P136_SER_CART_PROF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.EST_EMIS_PROF,''Z'') <> nvl(r2.EST_EMIS_PROF,''Z'')    then',
'     begin htp.script(''P136_EST_EMIS_PROF.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.DT_EMIS_CART,sysdate) <> nvl(r2.DT_EMIS_CART,sysdate)    then',
'     begin htp.script(''P136_DT_EMIS_CART.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_REGISTRO,''Z'') <> nvl(r2.NUM_REGISTRO,''Z'')    then',
'     begin htp.script(''P136_NUM_REGISTRO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.SIGLA_CONS_REG,0) <> nvl(r2.SIGLA_CONS_REG,0)    then',
'     begin htp.script(''P136_SIGLA_CONS_REG.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.REGIAO,''Z'') <> nvl(r2.REGIAO,''Z'')    then',
'     begin htp.script(''P136_REGIAO.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NOME_FUNCAO_REG,''Z'') <> nvl(r2.NOME_FUNCAO_REG,''Z'')    then',
'     begin htp.script(''P136_NOME_FUNCAO_REG.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
'  if nvl(r1.NUM_PIS_PASEP,0) <> nvl(r2.NUM_PIS_PASEP,0)    then',
'     begin htp.script(''P136_NUM_PIS_PASEP.style.backgroundColor = "#c9578875"'',''Javascript''); end;',
' end if;',
' ',
' end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475652511631040066)
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
'if :p136_rowid is not null then',
unistr('   :p136_titulo := ''Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral: N\00BA ''||:p136_cod_req||'' - ''||:P136_DATA_SOLICITACAO;'),
'else',
unistr('   :p136_titulo := ''Requisi\00E7\00E3o de Altera\00E7\00E3o Cadastral'';'),
'end if;',
'',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475650100929040059)
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
':p136_cod_req := null;',
'',
':p136_data_solicitacao := sysdate;',
':p136_dt_atualizacao := sysdate;',
'',
'pkg_alter_cadastral.salvar(:p136_cod_empresa, ',
'                           :p136_matricula,',
'                           v_flag, ',
'                           v_mensagem);',
'',
'pkg_alter_cadastral.processa_cadastro (:p136_cod_empresa,',
'                             :p136_filial,',
'                             :p136_cod_ccusto,',
'                             :p136_matricula,',
'                             :p136_nome,',
'                             :p_usuario,',
'                             :p136_cod_req,',
'                             v_cod_req_out,',
'                             :p136_data_solicitacao,',
'                             v_flag,',
'                             v_mensagem);',
'',
':p136_cod_req := nvl(:p136_cod_req,v_cod_req_out);',
'',
'',
'BEGIN',
'',
'insert into inf_pessoais_portal',
'(',
'COD_EMPRESA,',
'MATRICULA,',
'DC_MATRICULA,',
'NOME,',
'ENDERECO,',
'BAIRRO,',
'CIDADE,',
'UF,',
'CEP,',
'DDD,',
'TELEFONE,',
'NUMERO,',
'COMPLEM,',
'FILIAL,',
'E_MAIL,',
'COMPLEMENTO_CEP,',
'EMP_USUARIO_CONEXAO,',
'MATR_USUARIO_CONEXAO,',
'DT_ATUALIZACAO,',
'TELEFONE_CELULAR,',
'ESTADO_CIVIL,',
'INSTRUCAO,',
'COD_FORMACAO_ESCOLAR,',
'NUM_CALCA,',
'NUM_CAMISA,',
'NUM_CALCADO,',
'DATA_SOLICITACAO,',
'COD_CUSTO,',
'NOME_CCUSTO,',
'DDD_CEL,',
'COD_REQ,',
'COD_EMP_SOLICITANTE,',
'MAT_SOLICITANTE,',
'BANCO,',
'AGENCIA,',
'NUM_CONTA,',
'DC_CONTA,',
'COD_TP_TRANS_BCA,',
'NUM_IDENTIDADE,',
'DT_NASC,',
'COD_RACA_COR,',
'NACIONALIDADE,',
'UF_NACTO,',
'NATURALIDADE,',
'NATURALIZACAO,',
'ANO_CHEGADA,',
'NOME_MAE,',
'NUM_CPF_MAE,',
'DC_CPF_MAE,',
'NOME_PAI,',
'NUM_CPF_PAI,',
'DC_CPF_PAI,',
'NOME_CONJUGE,',
'NUM_CPF_CONJUGE,',
'DC_CPF_CONJUGE,',
'TITULACAO,',
'IND_DEF_FIS,',
'CD_NIVEL,',
'TIPO_IDENT,',
'EMISSAO_IDENT,',
'EST_EMIS_IDENT,',
'ORG_EMIS_IDENT,',
'NUM_TIT_ELEITOR,',
'ZON_TIT_ELEITOR,',
'SEC_TIT_ELEITOR,',
'DT_EMIS_ELEITOR,',
'EST_EMIS_TITULO,',
'NUM_CPF,',
'DC_CPF,',
'CERTIF_RESERV,',
'CNH,',
'NUM_CART_PROF,',
'MOD_CART_PROF,',
'SER_CART_PROF,',
'EST_EMIS_PROF,',
'NUM_PIS_PASEP,',
'DT_EMIS_CART,',
'NUM_REGISTRO,',
'SIGLA_CONS_REG,',
'REGIAO,',
'NOME_FUNCAO_REG,',
'VALID_IDENT_EST,',
'TIPO_VISTO,',
'SEXO,',
'NOME_DE_GUERRA,',
'E_MAIL_FUNCIONAL,',
'COD_TIPO_MAO_OBRA,',
'IND_DEF_FIS_BR,',
'TIPO_DEFICIENCIA,',
'MOTIVO,',
'NOME_SUPERIOR,',
'MATRICULA_SUPERIOR,',
'MANEQUIM,',
'RAIS_IND_DEF_FISICO,',
'RAIS_IND_DEF_AUDITIVA,',
'RAIS_IND_DEF_VISUAL,',
'RAIS_IND_DEF_MENTAL,',
'RAIS_IND_DEF_MULTIPLA,',
'TIPO_LOGRADOURO,',
'TIPO_LOGRADOURO_ES',
') values (',
':P136_COD_EMPRESA,',
':P136_MATRICULA,',
':P136_DC_MATRICULA,',
':P136_NOME,',
':P136_ENDERECO,',
':P136_BAIRRO,',
':P136_CIDADE,',
':P136_UF,',
':P136_CEP,',
':P136_DDD,',
':P136_TELEFONE,',
':P136_NUMERO,',
':P136_COMPLEM,',
':P136_FILIAL,',
':P136_E_MAIL,',
':P136_COMPLEMENTO_CEP,',
':P136_EMP_USUARIO_CONEXAO,',
':P136_MATR_USUARIO_CONEXAO,',
':P136_DT_ATUALIZACAO,',
':P136_TELEFONE_CELULAR,',
':P136_ESTADO_CIVIL,',
':P136_INSTRUCAO,',
':P136_COD_FORMACAO_ESCOLAR,',
':P136_NUM_CALCA,',
':P136_NUM_CAMISA,',
':P136_NUM_CALCADO,',
':P136_DATA_SOLICITACAO,',
':P136_COD_CUSTO,',
':P136_NOME_CCUSTO,',
':P136_DDD_CEL,',
':P136_COD_REQ,',
':P136_COD_EMP_SOLICITANTE,',
':P136_MAT_SOLICITANTE,',
':P136_BANCO,',
':P136_AGENCIA,',
':P136_NUM_CONTA,',
':P136_DC_CONTA,',
':P136_COD_TP_TRANS_BCA,',
':P136_NUM_IDENTIDADE,',
':P136_DT_NASC,',
':P136_COD_RACA_COR,',
':P136_NACIONALIDADE,',
':P136_UF_NACTO,',
':P136_NATURALIDADE,',
':P136_NATURALIZACAO,',
':P136_ANO_CHEGADA,',
':P136_NOME_MAE,',
':P136_NUM_CPF_MAE,',
':P136_DC_CPF_MAE,',
':P136_NOME_PAI,',
':P136_NUM_CPF_PAI,',
':P136_DC_CPF_PAI,',
':P136_NOME_CONJUGE,',
':P136_NUM_CPF_CONJUGE,',
':P136_DC_CPF_CONJUGE,',
':P136_TITULACAO,',
':P136_IND_DEF_FIS,',
':P136_CD_NIVEL,',
':P136_TIPO_IDENT,',
':P136_EMISSAO_IDENT,',
':P136_EST_EMIS_IDENT,',
':P136_ORG_EMIS_IDENT,',
':P136_NUM_TIT_ELEITOR,',
':P136_ZON_TIT_ELEITOR,',
':P136_SEC_TIT_ELEITOR,',
':P136_DT_EMIS_ELEITOR,',
':P136_EST_EMIS_TITULO,',
':P136_NUM_CPF,',
':P136_DC_CPF,',
':P136_CERTIF_RESERV,',
':P136_CNH,',
':P136_NUM_CART_PROF,',
':P136_MOD_CART_PROF,',
':P136_SER_CART_PROF,',
':P136_EST_EMIS_PROF,',
':P136_NUM_PIS_PASEP,',
':P136_DT_EMIS_CART,',
':P136_NUM_REGISTRO,',
':P136_SIGLA_CONS_REG,',
':P136_REGIAO,',
':P136_NOME_FUNCAO_REG,',
':P136_VALID_IDENT_EST,',
':P136_TIPO_VISTO,',
':P136_SEXO,',
':P136_NOME_DE_GUERRA,',
':P136_E_MAIL_FUNCIONAL,',
':P136_COD_TIPO_MAO_OBRA,',
':P136_IND_DEF_FIS_BR,',
':P136_TIPO_DEFICIENCIA,',
':P136_MOTIVO,',
':P136_NOME_SUPERIOR,',
':P136_MATRICULA_SUPERIOR,',
':P136_MANEQUIM,',
':P136_RAIS_IND_DEF_FISICO,',
':P136_RAIS_IND_DEF_AUDITIVA,',
':P136_RAIS_IND_DEF_VISUAL,',
':P136_RAIS_IND_DEF_MENTAL,',
':P136_RAIS_IND_DEF_MULTIPLA,',
':P136_TIPO_LOGRADOURO,',
':P136_TIPO_LOGRADOURO_ES',
');',
'',
'commit;',
'',
'END;',
'',
'',
'if v_flag in (''N'',''Q'') then',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''N'';',
'else',
'   :p136_flag := v_flag;',
'   :p136_mensagem := v_mensagem;',
'   :p136_ok := ''S''; ',
'end if;',
'',
'exception',
'when others then null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475649298423040058)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Req'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'delete from inf_pessoais_portal ipp',
'        where ipp.cod_empresa = :p136_cod_empresa',
'          and ipp.matricula   = :p136_matricula;',
'          ',
'commit;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(143475639548121040039)
,p_process_success_message=>unistr('Requisi\00E7\00E3o Deletada!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475650537181040061)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Create)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update upload_files',
'   set cod_req = :p136_cod_req',
' where cod_empresa = :p136_cod_empresa',
'   and cod_item = :p136_matricula',
'   and tipo_cod_item = ''COLABORADOR'' ',
'   and seq = :p136_seq;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475650882631040062)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload Files (Delete)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'delete from upload_files',
'  where cod_empresa = :p136_cod_empresa',
'    and cod_item = :p136_matricula',
'    and tipo_cod_item = ''COLABORADOR''',
'    and cod_req = :p136_cod_req;',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'DELETE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475649695624040058)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Alerta'
,p_process_sql_clob=>'null;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(143475640424781040040)
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475653335698040067)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Inf_Pessoais_Portal'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
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
'ip.ddd_cel ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'-----------------------------------------------------------------',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.manequim,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'-----------------------------------------------------------------',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'NVL(IP.NOME_DE_GUERRA,ifu.nome_de_guerra) NOME_DE_GUERRA,',
'ma.cod motivo,',
'-----------------------------------------------------------------',
'cod_emp_solicitante,',
'mat_solicitante,',
'cod_req,',
'data_solicitacao,',
'tipo_logradouro,',
'tipo_logradouro_es',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula;',
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
':p136_cod_emp_solicitante := r1.cod_emp_solicitante;',
':p136_mat_solicitante := r1.mat_solicitante;',
'',
':p136_solicitante := :p136_cod_emp_solicitante||'' / ''||:p136_mat_solicitante||'' - ''||iNITCAP(fnct_nome_func(:p136_cod_emp_solicitante, :p136_mat_solicitante));',
'',
':p136_cod_req := r1.cod_req;',
':p136_data_solicitacao := r1.data_solicitacao;',
'',
':p136_dc_matricula := r1.dc_matricula;',
'',
':p136_cod_custo := r1.cod_ccusto;',
':p136_nome_ccusto := r1.nome_ccusto;',
'',
':p136_sexo := r1.sexo;',
':p136_nome := r1.nome;',
':p136_endereco := r1.endereco;',
':p136_bairro := r1.bairro;',
':p136_cidade := r1.cidade;',
':p136_uf := r1.uf;',
':p136_cep := r1.cep;',
':p136_ddd := r1.ddd;',
':p136_telefone := r1.telefone;',
':p136_numero := r1.numero;',
':p136_complem := r1.complem;',
':p136_filial := r1.filial;',
':p136_e_mail := r1.e_mail;',
':p136_complemento_cep := r1.complemento_cep;',
':p136_TELEFONE_celular := r1.telefone_celular;',
':p136_estado_civil := r1.estado_civil;',
':p136_instrucao := r1.instrucao;',
':p136_cod_formacao_escolar := r1.cod_formacao_escolar;',
'---------------------------------------------------------',
'',
':p136_num_calca := r1.num_calca;',
':p136_num_camisa := r1.num_camisa;',
':p136_num_calcado := r1.num_calcado;',
':p136_manequim := r1.manequim;',
':p136_ddd_cel := r1.ddd_cell;',
':p136_num_identidade := r1.num_identidade;',
':p136_dt_nasc := r1.dt_nasc;',
':p136_cod_raca_cor := r1.cod_raca_cor;',
':p136_nacionalidade := r1.nacionalidade;',
':p136_uf_nacto := r1.uf_nacto;',
':p136_naturalidade := r1.naturalidade;',
':p136_naturalizacao := r1.naturalizacao;        ',
':p136_ano_chegada := r1.ano_chegada;',
':p136_nome_mae := r1.nome_mae;',
':p136_num_cpf_mae := r1.num_cpf_mae;',
':p136_dc_cpf_mae := r1.dc_cpf_mae;',
':p136_nome_pai := r1.nome_pai;',
':p136_num_cpf_pai := r1.num_cpf_pai;',
':p136_dc_cpf_pai := r1.dc_cpf_pai;',
':p136_nome_conjuge := r1.nome_conjuge;',
':p136_num_cpf_conjuge := r1.num_cpf_conjuge;',
':p136_dc_cpf_conjuge := r1.dc_cpf_conjuge;',
':p136_titulacao := r1.titulacao;',
'--:p136_desc_titulacao := r1.descricao_titulacao;',
':p136_ind_def_fis := r1.ind_def_fis;',
':p136_ind_def_fis_br := r1.ind_def_fis_br;',
':p136_tipo_deficiencia := r1.tipo_deficiencia;',
':p136_cd_nivel := r1.cd_nivel;',
':p136_tipo_ident := r1.tipo_ident;',
':p136_emissao_ident := r1.emissao_ident;',
':p136_est_emis_ident := r1.est_emis_ident;',
':p136_org_emis_ident := r1.org_emis_ident;',
':p136_num_tit_eleitor := r1.num_tit_eleitor;',
':p136_zon_tit_eleitor := r1.zon_tit_eleitor;',
':p136_sec_tit_eleitor := r1.sec_tit_eleitor;',
':p136_dt_emis_eleitor := r1.dt_emis_eleitor;',
':p136_est_emis_titulo := r1.est_emis_titulo;',
'',
'---------------------------------------------------------',
'',
':p136_num_cpf := r1.num_cpf;',
':p136_dc_cpf := r1.dc_cpf;',
':p136_certif_reserv := r1.certif_reserv;',
':p136_cnh := r1.cnh;',
':p136_num_cart_prof := r1.num_cart_prof;',
':p136_mod_cart_prof := r1.mod_cart_prof;',
':p136_ser_cart_prof := r1.ser_cart_prof;',
':p136_est_emis_prof := r1.est_emis_prof;',
':p136_num_pis_pasep := r1.num_pis_pasep;',
':p136_dt_emis_cart := r1.dt_emis_cart;',
':p136_num_registro := r1.num_registro;',
':p136_sigla_cons_reg := r1.sigla_cons_reg;',
':p136_regiao := r1.regiao;',
':p136_nome_funcao_reg := r1.nome_funcao_reg;',
':p136_valid_ident_est := r1.valid_ident_est;',
':p136_tipo_visto := r1.tipo_visto;',
':p136_e_mail_funcional := r1.email_funcional;',
':p136_cod_tipo_mao_obra := UPPER(r1.tipo_mao_obra);',
':p136_banco := r1.banco;',
':p136_agencia := r1.agencia;',
':p136_num_conta := r1.conta;',
':p136_dc_conta := r1.dc_conta;',
':p136_cod_tp_trans_bca := r1.cod_tp_trans_bca;',
':p136_nome_de_guerra := r1.nome_de_guerra;',
':p136_matricula_superior := r1.matricula_superior;',
':p136_nome_superior := r1.nome_superior;',
':p136_motivo := r1.motivo;',
'',
':p136_tipo_logradouro := r1.tipo_logradouro;',
':p136_tipo_logradouro_es := r1.tipo_logradouro_es;',
'--:p136_descricao_motivo := r1.descricao_motivo;',
'',
'end if;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475652053066040064)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Inf_Pessoais'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
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
'ip.ddd_cell,',
'ip.dt_nasc,',
'ip.cod_raca_cor,',
'decode(ip.cod_raca_cor, null, null, rc.descricao) desc_raca_cor,',
'ip.nacionalidade,',
'n.nome desc_nacionalidade,',
'ip.uf_nacto,',
'ip.naturalidade,',
'ip.naturalizacao,',
'ip.ano_chegada,',
'ip.titulacao,',
'ma.descricao descricao_motivo,',
'cc.numero matricula_superior,',
'cc.texto nome_superior,',
'ifu.cod_ccusto,',
'fnct_nome_ccusto(ifu.cod_empresa, ifu.cod_ccusto) nome_ccusto,',
'-----------------------------------------------------------------',
'ip.num_calca,',
'ip.num_camisa,',
'ip.num_calcado,',
'ip.manequim,',
'ip.nome_mae,',
'ip.num_cpf_mae,',
'ip.dc_cpf_mae,',
'ip.nome_pai,',
'ip.num_cpf_pai,',
'ip.dc_cpf_pai,',
'ip.nome_conjuge,',
'ip.num_cpf_conjuge,',
'ip.dc_cpf_conjuge,',
'decode(ip.titulacao, null, null, t.descricao_titulacao) descricao_titulacao,',
'ip.ind_def_fis,',
'ip.ind_def_fis_br,',
'ip.tipo_deficiencia,',
'ip.cd_nivel,',
'ip.num_identidade,',
'ip.tipo_ident,',
'ip.emissao_ident,',
'ip.est_emis_ident,',
'ip.org_emis_ident,',
'ip.num_tit_eleitor,',
'ip.zon_tit_eleitor,',
'ip.sec_tit_eleitor,',
'ip.dt_emis_eleitor,',
'ip.est_emis_titulo,',
'ip.num_cpf,',
'ip.dc_cpf,',
'ip.certif_reserv,',
'ip.cnh,',
'ip.num_cart_prof,',
'ip.mod_cart_prof,',
'ip.ser_cart_prof,',
'ip.est_emis_prof,',
'ip.num_pis_pasep,',
'ip.dt_emis_cart,',
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
'-----------------------------------------------------------------',
'ifu.cod_tp_trans_bca,',
'ttb.descricao desc_transacao_bancaria,',
'ifu.nome_de_guerra,',
'ma.cod motivo,',
'tipo_logradouro,',
'tipo_logradouro_es',
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
'where ip.cod_empresa = :p136_cod_empresa',
'and ip.matricula = :p136_matricula',
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
'and cc.chave_de_tabela(+) = to_char(ip.matricula)',
'and cc.campo(+) = ''SUP_IMEDIATO''',
'and cc.tabela(+) = ''INF-FUNCIONAIS''',
'and ma.cod(+) = cc.motivo;',
'',
'r1 c1%rowtype;',
'',
'cursor c0 is',
'select matricula',
'from inf_pessoais_portal',
'where cod_empresa = :p136_cod_empresa',
'and matricula   = :p136_matricula;',
'',
'v_c0 c0%rowtype;',
'',
'Begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'--if v_c0.matricula is null then',
'',
'open c1;',
'fetch c1 into r1;',
'close c1;',
'',
'',
'if v_c0.matricula is null then',
':p136_cod_emp_solicitante := :P_EMPRESA_USER;',
':p136_mat_solicitante := :P_MATRICULA_USER;',
'',
':p136_solicitante := :p136_cod_emp_solicitante||'' / ''||:p136_mat_solicitante||'' - ''||iNITCAP(fnct_nome_func(:p136_cod_emp_solicitante, :p136_mat_solicitante));',
'',
'end if;',
'',
':p136_dc_matricula := r1.dc_matricula;',
'',
':p136_cod_custo := r1.cod_ccusto;',
':p136_nome_ccusto := r1.nome_ccusto;',
'',
':p136_sexo := nvl(:p136_sexo,r1.sexo);',
':p136_nome := nvl(:p136_nome,r1.nome);',
':p136_endereco := nvl(:p136_endereco,r1.endereco);',
':p136_bairro := nvl(:p136_bairro,r1.bairro);',
':p136_cidade := nvl(:p136_cidade,r1.cidade);',
':p136_uf := nvl(:p136_uf,r1.uf);',
':p136_cep := nvl(:p136_cep,r1.cep);',
':p136_ddd := nvl(:p136_ddd,r1.ddd);',
':p136_telefone := nvl(:p136_telefone,r1.telefone);',
':p136_numero := nvl(:p136_numero,r1.numero);',
':p136_complem := nvl(:p136_complem,r1.complem);',
':p136_filial := nvl(:p136_filial,r1.filial);',
':p136_e_mail := nvl(:p136_e_mail,r1.e_mail);',
':p136_complemento_cep := nvl(:p136_complemento_cep,r1.complemento_cep);',
':p136_TELEFONE_celular := nvl(:p136_TELEFONE_celular,r1.telefone_celular);',
':p136_estado_civil := nvl(:p136_estado_civil,r1.estado_civil);',
':p136_instrucao := nvl(:p136_instrucao,r1.instrucao);',
':p136_cod_formacao_escolar := nvl(:p136_cod_formacao_escolar,r1.cod_formacao_escolar);',
'---------------------------------------------------------',
'',
':p136_num_calca := nvl(:p136_num_calca,r1.num_calca);',
':p136_num_camisa := nvl(:p136_num_camisa,r1.num_camisa);',
':p136_num_calcado := nvl(:p136_num_calcado,r1.num_calcado);',
':p136_manequim := nvl(:p136_manequim,r1.manequim);',
':p136_ddd_cel := nvl(:p136_ddd_cel,r1.ddd_cell);',
':p136_num_identidade := nvl(:p136_num_identidade,r1.num_identidade);',
':p136_dt_nasc := nvl(:p136_dt_nasc,r1.dt_nasc);',
':p136_cod_raca_cor := nvl(:p136_cod_raca_cor,r1.cod_raca_cor);',
':p136_nacionalidade := nvl(:p136_nacionalidade,r1.nacionalidade);',
':p136_uf_nacto := nvl(:p136_uf_nacto,r1.uf_nacto);',
':p136_naturalidade := nvl(:p136_naturalidade,r1.naturalidade);',
':p136_naturalizacao := nvl(:p136_naturalizacao,r1.naturalizacao);        ',
':p136_ano_chegada := nvl(:p136_ano_chegada,r1.ano_chegada);',
':p136_nome_mae := nvl(:p136_nome_mae,r1.nome_mae);',
':p136_num_cpf_mae := nvl(:p136_num_cpf_mae,r1.num_cpf_mae);',
':p136_dc_cpf_mae := nvl(:p136_dc_cpf_mae,r1.dc_cpf_mae);',
':p136_nome_pai := nvl(:p136_nome_pai,r1.nome_pai);',
':p136_num_cpf_pai := nvl(:p136_num_cpf_pai,r1.num_cpf_pai);',
':p136_dc_cpf_pai := nvl(:p136_dc_cpf_pai,r1.dc_cpf_pai);',
':p136_nome_conjuge := nvl(:p136_nome_conjuge,r1.nome_conjuge);',
':p136_num_cpf_conjuge := nvl(:p136_num_cpf_conjuge,r1.num_cpf_conjuge);',
':p136_dc_cpf_conjuge := nvl(:p136_dc_cpf_conjuge,r1.dc_cpf_conjuge);',
':p136_titulacao := nvl(:p136_titulacao,r1.titulacao);',
'-- :p136_desc_titulacao := nvl(:p136_desc_titulacao,r1.descricao_titulacao);',
':p136_ind_def_fis := nvl(:p136_ind_def_fis,r1.ind_def_fis);',
':p136_ind_def_fis_br := nvl(:p136_ind_def_fis_br,r1.ind_def_fis_br);',
':p136_tipo_deficiencia := nvl(:p136_tipo_deficiencia,r1.tipo_deficiencia);',
':p136_cd_nivel := nvl(:p136_cd_nivel,r1.cd_nivel);',
':p136_tipo_ident := nvl(:p136_tipo_ident,r1.tipo_ident);',
':p136_emissao_ident := nvl(:p136_emissao_ident,r1.emissao_ident);',
':p136_est_emis_ident := nvl(:p136_est_emis_ident,r1.est_emis_ident);',
':p136_org_emis_ident := nvl(:p136_org_emis_ident,r1.org_emis_ident);',
':p136_num_tit_eleitor := nvl(:p136_num_tit_eleitor,r1.num_tit_eleitor);',
':p136_zon_tit_eleitor := nvl(:p136_zon_tit_eleitor,r1.zon_tit_eleitor);',
':p136_sec_tit_eleitor := nvl(:p136_sec_tit_eleitor,r1.sec_tit_eleitor);',
':p136_dt_emis_eleitor := nvl(:p136_dt_emis_eleitor,r1.dt_emis_eleitor);',
':p136_est_emis_titulo := nvl(:p136_est_emis_titulo,r1.est_emis_titulo);',
'',
'---------------------------------------------------------',
'',
':p136_num_cpf := nvl(:p136_num_cpf,r1.num_cpf);',
':p136_dc_cpf := nvl(:p136_dc_cpf,r1.dc_cpf);',
':p136_certif_reserv := nvl(:p136_certif_reserv,r1.certif_reserv);',
':p136_cnh := nvl(:p136_cnh,r1.cnh);',
':p136_num_cart_prof := nvl(:p136_num_cart_prof,r1.num_cart_prof);',
':p136_mod_cart_prof := nvl(:p136_mod_cart_prof,r1.mod_cart_prof);',
':p136_ser_cart_prof := nvl(:p136_ser_cart_prof,r1.ser_cart_prof);',
':p136_est_emis_prof := nvl(:p136_est_emis_prof,r1.est_emis_prof);',
':p136_num_pis_pasep := nvl(:p136_num_pis_pasep,r1.num_pis_pasep);',
':p136_dt_emis_cart := nvl(:p136_dt_emis_cart,r1.dt_emis_cart);',
':p136_num_registro := nvl(:p136_num_registro,r1.num_registro);',
':p136_sigla_cons_reg := nvl(:p136_sigla_cons_reg,r1.sigla_cons_reg);',
':p136_regiao := nvl(:p136_regiao,r1.regiao);',
':p136_nome_funcao_reg := nvl(:p136_nome_funcao_reg,r1.nome_funcao_reg);',
':p136_valid_ident_est := nvl(:p136_valid_ident_est,r1.valid_ident_est);',
':p136_tipo_visto := nvl(:p136_tipo_visto,r1.tipo_visto);',
':p136_e_mail_funcional := nvl(:p136_e_mail_funcional,r1.email_funcional);',
':p136_cod_tipo_mao_obra := nvl(:p136_cod_tipo_mao_obra,UPPER(r1.tipo_mao_obra));',
':p136_banco := nvl(:p136_banco,r1.banco);',
':p136_agencia := nvl(:p136_agencia,r1.agencia);',
':p136_num_conta := nvl(:p136_num_conta,r1.conta);',
':p136_dc_conta := nvl(:p136_dc_conta,r1.dc_conta);',
':p136_cod_tp_trans_bca := nvl(:p136_cod_tp_trans_bca,r1.cod_tp_trans_bca);',
':p136_nome_de_guerra := nvl(:p136_nome_de_guerra,r1.nome_de_guerra);',
':p136_matricula_superior := nvl(:p136_matricula_superior,r1.matricula_superior);',
':p136_nome_superior := nvl(:p136_nome_superior,r1.nome_superior);',
':p136_motivo := nvl(:p136_motivo,r1.motivo);',
'--:p136_descricao_motivo := nvl(:p136_descricao_motivo,r1.descricao_motivo);',
':p136_tipo_logradouro := nvl(:p136_tipo_logradouro,r1.tipo_logradouro);',
':p136_tipo_logradouro_es := nvl(:p136_tipo_logradouro_es,r1.tipo_logradouro_es);',
'--end if;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475651252665040062)
,p_process_sequence=>30
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SEQ'
,p_process_sql_clob=>':p136_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P136_COD_REQ'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475652864998040066)
,p_process_sequence=>50
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
' where i.cod_empresa = :p136_cod_empresa',
'   and i.matricula = :p136_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p136_cod_empresa_display := v_c1.empresa;',
':p136_matricula_display := v_c1.matricula;',
':p136_situacao_colab := v_c1.situacao;',
':p136_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p136_cod_empresa_display := :p136_empresa;',
':p136_matricula_display := :p136_matricula;',
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
