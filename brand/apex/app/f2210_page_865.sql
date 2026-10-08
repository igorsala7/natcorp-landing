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
,p_default_application_id=>2210
,p_default_id_offset=>617349228366023513
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2210 - Gerenciamento Eletrônico de Documento (GED) - Natcorp
--
-- Application Export:
--   Application:     2210
--   Name:            Gerenciamento Eletrônico de Documento (GED) - Natcorp
--   Date and Time:   02:44 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 865
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00865
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>865);
end;
/
prompt --application/pages/page_00865
begin
wwv_flow_api.create_page(
 p_id=>865
,p_user_interface_id=>wwv_flow_api.id(20911188347277716657)
,p_name=>'Consulta de Documentos'
,p_page_mode=>'MODAL'
,p_step_title=>'Consulta de Documentos'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Documentos.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Documentos.js'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}',
'',
'#PARAMETROS .t-Region-buttons-right > * {',
'    width: 100% !important;',
'}'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_chained=>'N'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Documentos.css / Natcorp_Documentos.js)',
'',
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO das regi\00F5es com a classe'),
unistr('  nc-ged-docs  Documentos Colaborador / Candidato / Terceiro / Outros: a PASTA da pessoa \2014'),
'               abas por assunto (tirado do nome do documento e do tipo de sub-item), um',
unistr('               cart\00E3o por documento com as vers\00F5es (Sequ\00EAncia) dentro, dependentes por'),
unistr('               pessoa, "Mais recentes" por m\00EAs e a tabela original a um clique.'),
unistr('"Ver" e "Editar" clicam nos links originais da linha; "Adicionar" \00E9 o bot\00E3o do APEX.'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/DOCUMENTOS-MANUTENCAO.md.'))
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260710175835'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4090720396812552736)
,p_plug_name=>'Documentos Terceiro'
,p_region_css_classes=>'nc-ged-docs'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(20911161830398716561)
,p_plug_display_sequence=>59
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) Empresa,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) Filial,',
'       I.LOCAL_TRAB||'' - ''||FNCT_NOME_LOCAL_TRAB(I.LOCAL_TRAB) LOCAL_TRAB,',
'       i.cod_terceiro||'' - ''||initcap(nom_terceiro) Terceiro,',
'       u.tipo_sub_item||'' - ''||initcap(s.descricao) Tipo_Sub_Item,',
'       to_char(u.cod_sub_item) cod_sub_item,',
'       u.seq_item,',
'       initcap(t.descricao) || case when u.descricao is not null then '' - ''||u.descricao end || case when u.data_arquivo is not null then '' (''||to_char(u.data_arquivo,''DD/MM/RRRR'')||'')'' end documento,',
'       u.dt_atualizacao,',
'       u.usuario,',
'       i.cod_empresa,',
'       i.cod_terceiro,',
'       '' - '' VISUALIZAR,',
'       '' - '' VISUALIZAR2,',
'       u.tipo_sub_item TIPO_SUB_ITEMX,',
'       U.TIPO_ARQUIVO,',
'       ''TERCERIO'' TIPO_COD_ITEM, ',
'       u.rowid as "ROWID_U",',
'       pkg_blob_cloud.get_modal_url(''upload_files'', u.rowid, ''RENDER'') as modal_url,',
'       u.dt_criacao',
'  from upload_files u, tipo_arquivo_upload t, INFORMACOES_TERCEIROS I, tipo_sub_item_upload s',
' where u.tipo_arquivo = t.cod',
'   and u.tipo_sub_item = s.cod (+)',
'   and u.tipo_sub_item = t.cod_tipo_sub_item',
'   and u.cod_empresa = i.cod_empresa',
'   and u.cod_item = i.cod_terceiro',
'   and u.tipo_cod_item in (''TERCEIRO'')',
'   and i.COD_EMPRESA = :P865_EMP ',
'   and i.COD_TERCEIRO = :P865_TERCEIRO',
'   -- and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = ''S''',
'order by u.cod_empresa, i.cod_terceiro, u.cod_item, u.cod_sub_item, t.descricao, u.seq_item'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P865_TIPO'
,p_plug_display_when_cond2=>'TERCEIRO'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(4090720786123552739)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Filtre sua pesquisa para demonstrar os resultados.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:860:P860_ROWID:#ROWID_U#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>999158592025671807
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090720874850552740)
,p_db_column_name=>'TIPO_SUB_ITEM'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Tipo Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090720932484552741)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721112326552743)
,p_db_column_name=>'VISUALIZAR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Visualizar'
,p_column_link=>'f?p=&APP_ID.:862:&SESSION.::&DEBUG.:RP,862:P862_COD_EMPRESA,P862_COD_ITEM,P862_TIPO_ARQUIVO,P862_TIPO_SUB_ITEM,P862_SEQ_ITEM,P862_TIPO_COD_ITEM:#COD_EMPRESA#,#MATRICULA#,#TIPO_ARQUIVO#,#TIPO_SUB_ITEMX#,#SEQ_ITEM#,#TIPO_COD_ITEM#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721418631552746)
,p_db_column_name=>'TIPO_SUB_ITEMX'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Tipo sub itemx'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721536179552747)
,p_db_column_name=>'TIPO_ARQUIVO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Tipo arquivo'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721670731552748)
,p_db_column_name=>'ROWID_U'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Rowid u'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721750173552749)
,p_db_column_name=>'TIPO_COD_ITEM'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Tipo Cod Item'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721797496552750)
,p_db_column_name=>'MODAL_URL'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Modal Url'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721921000552751)
,p_db_column_name=>'VISUALIZAR2'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Visualizar'
,p_column_link=>'#MODAL_URL#'
,p_column_linktext=>'<span class="fa fa-search" aria-hidden="true"></span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090721995433552752)
,p_db_column_name=>'DT_CRIACAO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Data de Cria\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722191469552753)
,p_db_column_name=>'SEQ_ITEM'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Sequ\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722254770552754)
,p_db_column_name=>'DOCUMENTO'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722323823552755)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722438054552756)
,p_db_column_name=>'USUARIO'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722537749552757)
,p_db_column_name=>'FILIAL'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722838105552760)
,p_db_column_name=>'EMPRESA'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090722929525552761)
,p_db_column_name=>'COD_SUB_ITEM'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090723395401552766)
,p_db_column_name=>'LOCAL_TRAB'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Local Trab'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090723579231552767)
,p_db_column_name=>'TERCEIRO'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Terceiro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090723649099552768)
,p_db_column_name=>'COD_TERCEIRO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Cod Terceiro'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(4090803436211932308)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9992413'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'VISUALIZAR2:TIPO_SUB_ITEM:DOCUMENTO:DT_CRIACAO:SEQ_ITEM:DT_ATUALIZACAO:USUARIO:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(4090808741404079035)
,p_plug_name=>'Documentos Outros'
,p_region_css_classes=>'nc-ged-docs'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(20911161830398716561)
,p_plug_display_sequence=>69
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) Empresa,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) Filial,',
'       i.cod_terceiro||'' - ''||initcap(tx.nom_terceiro) Terceiro,',
'       i.matricula||'' - ''||initcap(i.nome) Profissional,',
'       u.tipo_sub_item||'' - ''||initcap(s.descricao) Tipo_Sub_Item,',
'       to_char(u.cod_sub_item) cod_sub_item,',
'       u.seq_item,',
'       initcap(t.descricao) || case when u.descricao is not null then '' - ''||u.descricao end || case when u.data_arquivo is not null then '' (''||to_char(u.data_arquivo,''DD/MM/RRRR'')||'')'' end documento,',
'       u.dt_atualizacao,',
'       u.usuario,',
'       i.cod_empresa,',
'       i.matricula,',
'       i.cod_terceiro,',
'       '' - '' VISUALIZAR,',
'       '' - '' VISUALIZAR2,',
'       u.tipo_sub_item TIPO_SUB_ITEMX,',
'       U.TIPO_ARQUIVO,',
'       ''OUTROS'' TIPO_COD_ITEM, ',
'       u.rowid as "ROWID_U",',
'       pkg_blob_cloud.get_modal_url(''upload_files'', u.rowid, ''RENDER'') as modal_url,',
'       u.dt_criacao',
'  from upload_files u, tipo_arquivo_upload t, INCOR_FUNC_HCSP_BENEFICIOS I, INFORMACOES_TERCEIROS tx, tipo_sub_item_upload s',
' where u.tipo_arquivo = t.cod',
'   and u.tipo_sub_item = s.cod (+)',
'   and u.tipo_sub_item = t.cod_tipo_sub_item',
'   and u.cod_empresa = i.cod_empresa',
'   and u.cod_item = i.MATRICULA',
'   and i.cod_terceiro = tx.cod_terceiro',
'   and u.tipo_cod_item in (''OUTROS'')',
'   and i.COD_EMPRESA = :P865_EMP ',
'   and i.MATRICULA = :P865_OUTROS',
'   -- and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = ''S''',
'order by u.cod_empresa, i.cod_terceiro, i.MATRICULA, u.cod_item, u.cod_sub_item, t.descricao, u.seq_item'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P865_TIPO'
,p_plug_display_when_cond2=>'OUTROS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(4090809014758079038)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Filtre sua pesquisa para demonstrar os resultados.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:860:P860_ROWID:#ROWID_U#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>999246820660198106
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809178185079039)
,p_db_column_name=>'TIPO_SUB_ITEM'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Tipo Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809228520079040)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809299798079041)
,p_db_column_name=>'VISUALIZAR'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Visualizar'
,p_column_link=>'f?p=&APP_ID.:862:&SESSION.::&DEBUG.:RP,862:P862_COD_EMPRESA,P862_COD_ITEM,P862_TIPO_ARQUIVO,P862_TIPO_SUB_ITEM,P862_SEQ_ITEM,P862_TIPO_COD_ITEM:#COD_EMPRESA#,#MATRICULA#,#TIPO_ARQUIVO#,#TIPO_SUB_ITEMX#,#SEQ_ITEM#,#TIPO_COD_ITEM#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809449593079042)
,p_db_column_name=>'TIPO_SUB_ITEMX'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Tipo sub itemx'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809591535079043)
,p_db_column_name=>'TIPO_ARQUIVO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Tipo arquivo'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809685058079044)
,p_db_column_name=>'ROWID_U'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Rowid u'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809694673079045)
,p_db_column_name=>'TIPO_COD_ITEM'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Tipo Cod Item'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809845718079046)
,p_db_column_name=>'MODAL_URL'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Modal Url'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090809932116079047)
,p_db_column_name=>'VISUALIZAR2'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Visualizar'
,p_column_link=>'#MODAL_URL#'
,p_column_linktext=>'<span class="fa fa-search" aria-hidden="true"></span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810055776079048)
,p_db_column_name=>'DT_CRIACAO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Data de Cria\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810159346079049)
,p_db_column_name=>'SEQ_ITEM'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('Sequ\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810210624079050)
,p_db_column_name=>'DOCUMENTO'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810374687079051)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810402320079052)
,p_db_column_name=>'USUARIO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810504749079053)
,p_db_column_name=>'FILIAL'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810624603079054)
,p_db_column_name=>'EMPRESA'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810728253079055)
,p_db_column_name=>'COD_SUB_ITEM'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090810926338079057)
,p_db_column_name=>'TERCEIRO'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Terceiro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090811054143079058)
,p_db_column_name=>'COD_TERCEIRO'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Cod Terceiro'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090812927718079077)
,p_db_column_name=>'PROFISSIONAL'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Profissional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4090813088505079078)
,p_db_column_name=>'MATRICULA'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(4090853243904258946)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9992911'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'VISUALIZAR2:TIPO_SUB_ITEM:DOCUMENTO:DT_CRIACAO:SEQ_ITEM:TERCEIRO:PROFISSIONAL:USUARIO:DT_ATUALIZACAO:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(132844388159014120993)
,p_plug_name=>'Documentos Candidato'
,p_region_css_classes=>'nc-ged-docs'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(20911161830398716561)
,p_plug_display_sequence=>49
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select u.cod_empresa||'' - ''||initcap(fnct_nome_empresa(u.cod_empresa)) Empresa,',
'       v.cod_filial||'' - ''||initcap(fnct_nome_filial(v.cod_empresa, v.cod_filial)) Filial,',
'       v.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(v.cod_empresa, v.cod_ccusto)) Centro_de_Custo,',
'       p.cod_candidato||'' - ''||initcap(p.nome) Candidato,',
'       u.tipo_sub_item||'' - ''||initcap(s.descricao) Tipo_Sub_Item,',
'       case when to_char(u.tipo_sub_item) = ''1'' then',
'       (select x.num_depend||'' - ''||initcap(x.nome_depend) dependente',
'         from DEPENDENTES_CAND x',
'        where x.cod_empresa = p.empresa',
'          and x.cod_candidato = p.cod_candidato',
'          and x.num_depend = u.cod_sub_item)',
'       when to_char(u.cod_sub_item) = 0 then',
'       to_char(u.cod_sub_item)',
'       end cod_sub_item,',
'       u.seq_item,',
'       initcap(t.descricao) || case when u.descricao is not null then '' - ''||u.descricao end || case when u.data_arquivo is not null then '' (''||to_char(u.data_arquivo,''DD/MM/RRRR'')||'')'' end documento,',
'       u.dt_atualizacao,',
'       u.usuario,',
'       p.empresa cod_empresa,',
'       p.cod_candidato,',
'       '' - '' VISUALIZAR,',
'       '' - '' VISUALIZAR2,',
'       v.vinculo||'' - ''||initcap(fnct_nome_vinculo(v.vinculo)) vinculo,',
'       u.tipo_sub_item TIPO_SUB_ITEMX,',
'       U.TIPO_ARQUIVO,',
'       CASE WHEN v.vinculo in (''C'',''E'',''S'',''D'',''V'') THEN ''CANDIDATO''',
'       ELSE ''CANDIDATO_PJ''',
'       END TIPO_COD_ITEM, ',
'       u.rowid as "ROWID_U",',
'       pkg_blob_cloud.get_modal_url(''upload_files'', u.rowid, ''RENDER'') as modal_url,',
'       u.dt_criacao',
'  from upload_files u, tipo_arquivo_upload t, tipo_sub_item_upload s,',
'  INF_PESSOAIS_CANDIDATO P, INF_FUNC_CANDIDATO F, CANDIDATO_APROVADO C, requisicao V',
' where P.COD_CANDIDATO = F.COD_CANDIDATO',
'   AND P.COD_CANDIDATO = C.COD_CANDIDATO (+)',
'   AND C.COD_SOLICITACAO = V.COD_REQ (+)',
'   AND P.PS IS NOT NULL',
'   AND u.tipo_arquivo = t.cod ',
'   and u.tipo_sub_item = s.cod (+)',
'   and u.tipo_sub_item = t.cod_tipo_sub_item',
'   and u.cod_empresa = p.empresa',
'   and u.cod_item = p.cod_candidato',
'   and u.tipo_cod_item in (''CANDIDATO'',''CANDIDATO_PJ'')',
'   and v.COD_EMPRESA = :P865_EMP ',
'   AND p.cod_candidato = :P865_COD_CANDIDATO',
'   and F_Acesso_cc(v.cod_empresa, v.cod_ccusto) = ''S''',
'    and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = ''S''',
' order by v.cod_empresa, p.cod_candidato, u.cod_item, u.cod_sub_item, t.descricao, u.seq_item'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P865_TIPO'
,p_plug_display_when_cond2=>'CANDIDATO'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(132844388471389120996)
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Filtre sua pesquisa para demonstrar os resultados.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:860:P860_ROWID:#ROWID_U#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>129589942281108516417
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345085949620697174)
,p_db_column_name=>'TIPO_SUB_ITEM'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Tipo Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345086324688697177)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345086750071697179)
,p_db_column_name=>'VISUALIZAR'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Visualizar'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345085148026697173)
,p_db_column_name=>'VISUALIZAR2'
,p_display_order=>50
,p_column_identifier=>'V'
,p_column_label=>'Visualizar'
,p_column_link=>'#MODAL_URL#'
,p_column_linktext=>'<span class="fa fa-search" aria-hidden="true"></span>'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345087188406697179)
,p_db_column_name=>'VINCULO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345087538615697180)
,p_db_column_name=>'TIPO_SUB_ITEMX'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Tipo sub itemx'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345087924210697180)
,p_db_column_name=>'TIPO_ARQUIVO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Tipo arquivo'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345088388829697182)
,p_db_column_name=>'ROWID_U'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Rowid u'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345088754278697182)
,p_db_column_name=>'SEQ_ITEM'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Sequ\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345089172584697182)
,p_db_column_name=>'DOCUMENTO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345089523254697183)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345089983330697183)
,p_db_column_name=>'USUARIO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345090384768697184)
,p_db_column_name=>'FILIAL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345090761664697184)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>'Centro de custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345091151811697184)
,p_db_column_name=>'EMPRESA'
,p_display_order=>160
,p_column_identifier=>'Q'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345091492881697185)
,p_db_column_name=>'COD_SUB_ITEM'
,p_display_order=>170
,p_column_identifier=>'R'
,p_column_label=>'Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345091902028697185)
,p_db_column_name=>'CANDIDATO'
,p_display_order=>180
,p_column_identifier=>'S'
,p_column_label=>'Candidato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345092373839697186)
,p_db_column_name=>'COD_CANDIDATO'
,p_display_order=>190
,p_column_identifier=>'T'
,p_column_label=>'Cod Candidato'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345092774806697187)
,p_db_column_name=>'TIPO_COD_ITEM'
,p_display_order=>200
,p_column_identifier=>'U'
,p_column_label=>'Tipo Cod Item'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345085559619697174)
,p_db_column_name=>'MODAL_URL'
,p_display_order=>210
,p_column_identifier=>'W'
,p_column_label=>'Modal Url'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345084826232697161)
,p_db_column_name=>'DT_CRIACAO'
,p_display_order=>220
,p_column_identifier=>'X'
,p_column_label=>unistr('Data de Cria\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(132882475936152756808)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'906469'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'VISUALIZAR2:EMPRESA:CANDIDATO:VINCULO:FILIAL:CENTRO_DE_CUSTO:TIPO_SUB_ITEM:COD_SUB_ITEM:SEQ_ITEM:DOCUMENTO:USUARIO:DT_ATUALIZACAO::DT_CRIACAO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(136807379183420922414)
,p_plug_name=>'Filtros'
,p_region_name=>'PARAMETROS'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(20911162350439716563)
,p_plug_display_sequence=>39
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(132372097566249742447)
,p_plug_name=>'PARAMETROS ITENS'
,p_region_name=>'PARAMETROS_ITENS'
,p_parent_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(20911162350439716563)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(147063993265242280607)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(20911162350439716563)
,p_plug_display_sequence=>9
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P865_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(147063994909196280612)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(147063993265242280607)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(20911162350439716563)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P865_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(147063995638754280615)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(147063993265242280607)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(20911162350439716563)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P865_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(147063997648254280617)
,p_plug_name=>'Documentos Colaborador'
,p_region_css_classes=>'nc-ged-docs'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton'
,p_plug_template=>wwv_flow_api.id(20911161830398716561)
,p_plug_display_sequence=>29
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) Empresa,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) Filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) Centro_de_Custo,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) Colaborador,',
'       u.tipo_sub_item||'' - ''||initcap(s.descricao) Tipo_Sub_Item,',
'       case when to_char(u.tipo_sub_item) = ''1'' then',
'       (select x.num_depend||'' - ''||initcap(x.nome_depend) dependente',
'         from dependentes x',
'        where x.cod_empresa = i.cod_empresa',
'          and x.matricula = i.matricula',
'          and x.num_depend = u.cod_sub_item)',
'       when to_char(u.cod_sub_item) = 0 then',
'       to_char(u.cod_sub_item)',
'       end cod_sub_item,',
'       u.seq_item,',
'       initcap(t.descricao) || case when u.descricao is not null then '' - ''||u.descricao end || case when u.data_arquivo is not null then '' (''||to_char(u.data_arquivo,''DD/MM/RRRR'')||'')'' end documento,',
'       u.dt_atualizacao,',
'       u.usuario,',
'       i.cod_empresa,',
'       i.matricula,',
'       '' - '' VISUALIZAR,',
'       '' - '' VISUALIZAR2,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao)) situacao,',
'       i.vinculo||'' - ''||initcap(fnct_nome_vinculo(i.vinculo)) vinculo,',
'       u.tipo_sub_item TIPO_SUB_ITEMX,',
'       U.TIPO_ARQUIVO,',
'       CASE WHEN i.vinculo in (''C'',''E'',''S'',''D'',''V'') THEN ''COLABORADOR''',
'       ELSE ''COLABORADOR_PJ''',
'       END TIPO_COD_ITEM, ',
'       u.rowid as "ROWID_U",',
'       pkg_blob_cloud.get_modal_url(''upload_files'', u.rowid, ''RENDER'') as modal_url,',
'       u.dt_criacao',
'  from upload_files u, tipo_arquivo_upload t, informacoes_funcionais_cad i, tipo_sub_item_upload s',
' where u.tipo_arquivo = t.cod',
'   and u.tipo_sub_item = s.cod (+)',
'   and u.tipo_sub_item = t.cod_tipo_sub_item',
'   and u.cod_empresa = i.cod_empresa',
'   and u.cod_item = i.matricula',
'   and u.tipo_cod_item in (''COLABORADOR'',''COLABORADOR_PJ'')',
'   and u.cod_req is null',
'   and u.seq is null',
'   and i.COD_EMPRESA = :P865_EMP ',
'   and i.MATRICULA = REGEXP_REPLACE(:P865_MAT, ''[^0-9]'', '''')',
'   AND EXISTS (select ''S'' RETORNO',
'                 from informacoes_funcionais_cad Z',
'                where Z.cod_empresa = I.cod_empresa',
'                  and Z.matricula = I.matricula',
'                  AND ((/*Z.COD_CCUSTO IN*/ EXISTS (SELECT 1 --X.COD',
'                                           FROM CENTRO_DE_CUSTO X',
'                                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                                         FROM USUARIO_ORACLE U  ',
'                                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO)) and (:p_painel = ''PG'')) or (:p_PAINEL = ''PO'' and F_Acesso_PG_Apex(z.cod_empresa, z.matricula, z.filial, z.cd_nivel, :p_usuario) = ''S'') or'
||' (:p_PAINEL = ''PC'' and z.cod_empresa = :P_EMPRESA_USER AND z.matricula = :P_MATRICULA_USER)))',
'    and f_permissao_docs (u.tipo_cod_item, u.tipo_sub_item, t.cod) = ''S''',
'order by u.cod_empresa, i.matricula, u.cod_item, u.cod_sub_item, t.descricao, u.seq_item'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P865_TIPO'
,p_plug_display_when_cond2=>'COLABORADOR'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(147063998084481280617)
,p_name=>'Fotos'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Filtre sua pesquisa para demonstrar os resultados.'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:860:P860_ROWID:#ROWID_U#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>143809551894200676038
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345109397793697772)
,p_db_column_name=>'VISUALIZAR'
,p_display_order=>30
,p_column_identifier=>'AD'
,p_column_label=>'Visualizar'
,p_column_link=>'f?p=&APP_ID.:862:&SESSION.::&DEBUG.:RP,862:P862_COD_EMPRESA,P862_COD_ITEM,P862_TIPO_ARQUIVO,P862_TIPO_SUB_ITEM,P862_SEQ_ITEM,P862_TIPO_COD_ITEM:#COD_EMPRESA#,#MATRICULA#,#TIPO_ARQUIVO#,#TIPO_SUB_ITEMX#,#SEQ_ITEM#,#TIPO_COD_ITEM#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345106281103697700)
,p_db_column_name=>'VISUALIZAR2'
,p_display_order=>40
,p_column_identifier=>'AN'
,p_column_label=>'Visualizar'
,p_column_link=>'#MODAL_URL#'
,p_column_linktext=>'<span class="fa fa-search" aria-hidden="true"></span>'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345110502906697776)
,p_db_column_name=>'SEQ_ITEM'
,p_display_order=>50
,p_column_identifier=>'Q'
,p_column_label=>unistr('Sequ\00EAncia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345110928526697777)
,p_db_column_name=>'DOCUMENTO'
,p_display_order=>60
,p_column_identifier=>'R'
,p_column_label=>'Documento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345111370855697777)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>70
,p_column_identifier=>'T'
,p_column_label=>unistr('Data de Atualiza\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345111789670697778)
,p_db_column_name=>'USUARIO'
,p_display_order=>80
,p_column_identifier=>'U'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345112150814697780)
,p_db_column_name=>'FILIAL'
,p_display_order=>90
,p_column_identifier=>'V'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345112558394697780)
,p_db_column_name=>'CENTRO_DE_CUSTO'
,p_display_order=>100
,p_column_identifier=>'W'
,p_column_label=>'Centro de custo'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345112923606697781)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>110
,p_column_identifier=>'X'
,p_column_label=>'Colaborador'
,p_column_link=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:#COD_EMPRESA#,#MATRICULA#'
,p_column_linktext=>'#COLABORADOR#'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345113316695697781)
,p_db_column_name=>'EMPRESA'
,p_display_order=>120
,p_column_identifier=>'Y'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345113745453697781)
,p_db_column_name=>'COD_SUB_ITEM'
,p_display_order=>130
,p_column_identifier=>'Z'
,p_column_label=>'Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345108249204697709)
,p_db_column_name=>'TIPO_SUB_ITEM'
,p_display_order=>140
,p_column_identifier=>'AA'
,p_column_label=>'Tipo Sub-Item'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345108641405697710)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>150
,p_column_identifier=>'AB'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345109080432697711)
,p_db_column_name=>'MATRICULA'
,p_display_order=>160
,p_column_identifier=>'AC'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345109745251697772)
,p_db_column_name=>'SITUACAO'
,p_display_order=>170
,p_column_identifier=>'AE'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345110168627697773)
,p_db_column_name=>'VINCULO'
,p_display_order=>180
,p_column_identifier=>'AF'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P865_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345107435226697706)
,p_db_column_name=>'TIPO_SUB_ITEMX'
,p_display_order=>190
,p_column_identifier=>'AG'
,p_column_label=>'Tipo sub itemx'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345107863983697707)
,p_db_column_name=>'TIPO_ARQUIVO'
,p_display_order=>200
,p_column_identifier=>'AH'
,p_column_label=>'Tipo arquivo'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345106990855697705)
,p_db_column_name=>'ROWID_U'
,p_display_order=>210
,p_column_identifier=>'AK'
,p_column_label=>'Rowid u'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345106636546697704)
,p_db_column_name=>'TIPO_COD_ITEM'
,p_display_order=>220
,p_column_identifier=>'AL'
,p_column_label=>'Tipo Cod Item'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345105792667697699)
,p_db_column_name=>'MODAL_URL'
,p_display_order=>230
,p_column_identifier=>'AM'
,p_column_label=>'Modal Url'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(3345105495531697695)
,p_db_column_name=>'DT_CRIACAO'
,p_display_order=>240
,p_column_identifier=>'AO'
,p_column_label=>unistr('Data de Cria\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(147064004600727280629)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'906679'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'VISUALIZAR:VISUALIZAR2:EMPRESA:FILIAL:CENTRO_DE_CUSTO:COLABORADOR:DOCUMENTO:TIPO_SUB_ITEM:COD_SUB_ITEM:SEQ_ITEM:SITUACAO:VINCULO:USUARIO:DT_ATUALIZACAO::DT_CRIACAO'
,p_sort_column_1=>'EMPRESA'
,p_sort_direction_1=>'ASC'
,p_sort_column_2=>'FILIAL'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'CENTRO_DE_CUSTO'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'COLABORADOR'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'DOCUMENTO'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'DT_ATUALIZACAO'
,p_sort_direction_6=>'DESC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4090720668711552738)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4090720396812552736)
,p_button_name=>'BACK_2'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(20911183142037716607)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP::'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4090808920418079037)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(4090808741404079035)
,p_button_name=>'BACK_3'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(20911183142037716607)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP::'
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345093558349697370)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(132844388159014120993)
,p_button_name=>'BACK_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(20911183142037716607)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP::'
,p_button_condition_type=>'NEVER'
,p_grid_new_row=>'Y'
,p_grid_column=>11
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345114580310697787)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(147063997648254280617)
,p_button_name=>'BACK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(20911183142037716607)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP::'
,p_button_condition_type=>'NEVER'
,p_grid_new_row=>'Y'
,p_grid_column=>11
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345094505292697386)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_button_name=>'OPEN_PARAMETROS'
,p_button_static_id=>'OPEN_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver mais'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345094934175697387)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_button_name=>'CLOSE_PARAMETROS'
,p_button_static_id=>'CLOSE_PARAMETROS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--noUI:t-Button--iconLeft:t-Button--stretch:t-Button--padTop:t-Button--padBottom'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ver menos'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-minus'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345095315977697387)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_button_name=>'Pesquisar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345102273974697520)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(147063993265242280607)
,p_button_name=>'p865_btn_colab'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(20911183025966716604)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P865_EMP.,&P865_MAT.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345093796161697373)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(132844388159014120993)
,p_button_name=>'adicionar_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:RP,860:P860_COD_EMPRESA,P860_COD_CANDIDATO,P860_TIPO_COD_ITEM:&P865_EMP.,&P865_CAND.,CANDIDATO'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3345114929402697787)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(147063997648254280617)
,p_button_name=>'adicionar'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:RP,860:P860_TIPO_COD_ITEM,P860_COD_EMPRESA,P860_COD_ITEM,P860_MATRICULA:COLABORADOR,&P865_EMP.,&P865_MAT.,&P865_MAT.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4090720582780552737)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4090720396812552736)
,p_button_name=>'adicionar_2'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:RP,860:P860_TIPO_COD_ITEM,P860_COD_EMPRESA,P860_COD_ITEM,P860_TERCEIRO:TERCEIRO,&P865_EMP.,&P865_TERCEIRO.,&P865_TERCEIRO.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4090808856276079036)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(4090808741404079035)
,p_button_name=>'adicionar_3'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(20911183315757716607)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:860:&SESSION.::&DEBUG.:RP,860:P860_TIPO_COD_ITEM,P860_COD_EMPRESA,P860_COD_ITEM,P860_TERCEIRO:OUTROS,&P865_EMP.,&P865_OUTROS.,&P865_OUTROS.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345095765695697388)
,p_name=>'P865_TIPO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345096106697697453)
,p_name=>'P865_SITUACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_item_default=>'A'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345096425418697454)
,p_name=>'P865_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345096807262697455)
,p_name=>'P865_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345097253450697466)
,p_name=>'P865_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345097611875697467)
,p_name=>'P865_UNIDADE_ADM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345098055703697475)
,p_name=>'P865_ATIVIDADE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345098470143697475)
,p_name=>'P865_CARGO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345098793205697476)
,p_name=>'P865_MATRICULA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345099238004697477)
,p_name=>'P865_COD_CANDIDATO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345099684039697477)
,p_name=>'P865_PESQUISA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345100083269697478)
,p_name=>'P865_EMP'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345100480388697478)
,p_name=>'P865_MAT'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345100829883697479)
,p_name=>'P865_CAND'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345101566560697481)
,p_name=>'P865_UTILIZA_SECAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(132372097566249742447)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345102956561697523)
,p_name=>'P865_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(147063994909196280612)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = :P865_EMP',
'                  and matricula   = REGEXP_REPLACE(:P865_MAT, ''[^0-9]'', '''')',
'',
'                  ), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P865_EMP || ''|'' || REGEXP_REPLACE(:P865_MAT, ''[^0-9]'', '''')',
'',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(20911182701433716600)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345103662534697533)
,p_name=>'P865_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(147063995638754280615)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(20911182701433716600)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345103991335697533)
,p_name=>'P865_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(147063995638754280615)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(20911182701433716600)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345104436125697533)
,p_name=>'P865_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(147063995638754280615)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(20911182701433716600)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3345104884093697533)
,p_name=>'P865_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(147063995638754280615)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(20911182701433716600)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4090723065257552762)
,p_name=>'P865_TERCEIRO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4090812881302079076)
,p_name=>'P865_OUTROS'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(136807379183420922414)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4090813179627079079)
,p_name=>'P865_TERCEIRO_DISPLAY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4090720396812552736)
,p_prompt=>'Terceiro'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(11596478195782695767)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4090813201628079080)
,p_name=>'P865_OUTROS_DISPLAY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(4090808741404079035)
,p_prompt=>unistr('Outros V\00EDnculos')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(11596478195782695767)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3345116608782697831)
,p_name=>'Pesquisar'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(3345095315977697387)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345117103979697833)
,p_event_id=>wwv_flow_api.id(3345116608782697831)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P865_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345117610107697833)
,p_event_id=>wwv_flow_api.id(3345116608782697831)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3345118070622697835)
,p_name=>unistr('Utiliza Se\00E7\00E3o')
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P865_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345118530357697835)
,p_event_id=>wwv_flow_api.id(3345118070622697835)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p865_utiliza_secao',
'  from parametros_recursos_humanos ',
' where ((instr('',''||:p865_empresa||'','','',''||cod_empresa||'','') > 0) or (:p865_empresa is null))',
'   and rownum = 1;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P865_EMPRESA'
,p_attribute_03=>'P865_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3345118938632697836)
,p_name=>'Tipo de Consulta'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P865_TIPO'
,p_condition_element=>'P865_TIPO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'COLABORADOR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345119407548697836)
,p_event_id=>wwv_flow_api.id(3345118938632697836)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P865_SITUACAO,P865_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345119974833697837)
,p_event_id=>wwv_flow_api.id(3345118938632697836)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P865_SITUACAO,P865_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345120432349697837)
,p_event_id=>wwv_flow_api.id(3345118938632697836)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P865_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3345120908983697838)
,p_event_id=>wwv_flow_api.id(3345118938632697836)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P865_COD_CANDIDATO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4091764912122532635)
,p_name=>'Adicionar_2 Dialog Closed'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(4090720582780552737)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4091765003661532636)
,p_event_id=>wwv_flow_api.id(4091764912122532635)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4090720396812552736)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4091765387270532639)
,p_name=>'Adicionar_3 Dialog Closed'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(4090808856276079036)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4091765402956532640)
,p_event_id=>wwv_flow_api.id(4091765387270532639)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4090808741404079035)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4091765122654532637)
,p_name=>'Terceiro Dialog Closed'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(4090720396812552736)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4091765278601532638)
,p_event_id=>wwv_flow_api.id(4091765122654532637)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4090720396812552736)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2012749512181926357)
,p_name=>'Candidato Dialog Closed'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(132844388159014120993)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2012749532322926358)
,p_event_id=>wwv_flow_api.id(2012749512181926357)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(132844388159014120993)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(2012749711430926359)
,p_name=>'Colaborador Dialog Closed'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(147063997648254280617)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2012749792569926360)
,p_event_id=>wwv_flow_api.id(2012749711430926359)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(147063997648254280617)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(4091765575158532641)
,p_name=>'Outros Dialog Closed'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(4090808741404079035)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(4091765639436532642)
,p_event_id=>wwv_flow_api.id(4091765575158532641)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(4090808741404079035)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3345115358884697811)
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
' where i.cod_empresa = :p865_emp',
'   and i.matricula = :p865_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p865_cod_empresa_display := v_c1.empresa;',
':p865_matricula_display := v_c1.matricula;',
':p865_situacao_colab := v_c1.situacao;',
':p865_dt_admissao := v_c1.dt_admissao;',
'',
'',
'IF :P865_PESQUISA IS NULL THEN',
'    IF :P865_MAT IS NOT NULL THEN ',
'        :P865_TIPO := ''COLABORADOR'';',
'        :P865_PESQUISA := ''S'';',
'    ELSIF :P865_CAND IS NOT NULL THEN',
'        :P865_TIPO := ''CANDIDATO'';',
'        :P865_PESQUISA := ''S'';',
'    ELSIF :P865_TERCEIRO IS NOT NULL THEN',
'        :P865_TIPO := ''TERCEIRO'';',
'        :P865_PESQUISA := ''S'';',
'    ELSIF :P865_OUTROS IS NOT NULL THEN',
'        :P865_TIPO := ''OUTROS'';',
'        :P865_PESQUISA := ''S'';',
'    ELSE',
'        :P865_PESQUISA := ''N'';',
'    END IF;',
'END IF;',
'',
'',
'',
'  begin',
'',
'  SELECT I.COD_TERCEIRO||'' - ''||I.NOM_TERCEIRO D',
'    INTO :P865_TERCEIRO_DISPLAY',
'    FROM INFORMACOES_TERCEIROS I',
'   where i.cod_empresa  = :P865_EMP',
'     and i.cod_terceiro = :P865_TERCEIRO',
'     and rownum = 1;',
'',
'  exception',
'  when others then',
'  null;',
'',
'  end;',
'',
'',
'  begin',
'',
'  SELECT I.MATRICULA||'' - ''||I.NOME D',
'    into :P865_OUTROS_DISPLAY',
'    FROM INCOR_FUNC_HCSP_BENEFICIOS I',
'   where i.cod_empresa   = :P865_EMP',
'     and i.matricula = :P865_OUTROS',
'     and rownum = 1;',
'',
'  exception',
'  when others then',
'  null;',
'',
'  end;',
'',
'exception',
'when others then',
':p865_cod_empresa_display := :p865_emp;',
':p865_matricula_display := :p865_mat;',
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
