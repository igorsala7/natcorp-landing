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
--   Date and Time:   17:45 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 30
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00030
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>30);
end;
/
prompt --application/pages/page_00030
begin
wwv_flow_api.create_page(
 p_id=>30
,p_user_interface_id=>wwv_flow_api.id(283867044223119591244)
,p_name=>'Headcount'
,p_step_title=>'Headcount'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Posicoes.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Posicoes.css'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'SUPORTE_NATCORP'
,p_last_upd_yyyymmddhh24miss=>'20260414101206'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283779612424309784295)
,p_plug_name=>'Centro de Custo'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P30_CCUSTO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283826124770714937782)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(283867018226281591150)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(283780679271457190922)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(283867039513876591195)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(283826376865859361524)
,p_plug_name=>'Headcount'
,p_region_name=>'IR'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(283867017706240591148)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.rowid,',
'       c.cod_empresa, ',
'       c.cod_filial, ',
'       c.data_inicio, ',
'       c.data_fim,',
'       c.cod_vaga, ',
'       c.cod_ccusto, ',
'       c.cod_ccusto_contab, ',
'       c.cod_cargo, ',
'       c.cod_funcao, ',
'       Initcap(v.nome) vinculo, ',
'       decode(c.sit_vaga,''A'',''Ativa'',''S'',''Suspensa'',''E'',''Extinta'') sit_vaga, ',
unistr('       decode(c.ind_vaga_compartilhada,''S'',''Sim'',''N'',''N\00E3o'') ind_vaga_compartilhada, '),
'       c.vaga_compartilhada, ',
unistr('       decode(c.disponivel,''S'',''Sim'',''N'',''N\00E3o'') disponivel,'),
'       c.cod_requisicao',
'      ,c.cod_empresa||'' - ''||InitCap(fnct_nome_empresa(c.cod_empresa)) empresa_desc',
'      ,c.cod_filial||'' - ''||InitCap(fnct_nome_filial(c.cod_empresa,c.cod_filial)) filial_desc',
'      ,c.cod_ccusto||'' - ''||InitCap(fnct_nome_ccusto(c.cod_empresa, c.cod_ccusto)) ccusto_desc',
'      ,c.cod_ccusto_contab||'' - ''||InitCap(fnct_nome_ccusto_contab(c.cod_empresa,c.cod_ccusto_contab)) ccusto_contab_desc',
'      ,c.cod_cargo||'' - ''||InitCap(fnct_nome_cargo(c.cod_cargo)) cargo_desc',
'      ,c.cod_funcao||'' - ''||InitCap(fnct_nome_funcao(c.cod_cargo,c.cod_funcao)) funcao_desc',
unistr('      ,decode(c.POSICAO_IND_GESTOR,''S'',''Sim'',''N\00E3o'') POSICAO_IND_GESTOR'),
unistr('      ,decode(c.POSICAO_IND_WORKFLOW,''S'',''Sim'',''N\00E3o'') POSICAO_IND_WORKFLOW'),
'  from cl_vaga c, ',
'       vinculo_empreg v',
' where c.vinculo = v.cod ',
' and c.cod_empresa = nvl(:p30_emp, c.cod_empresa)',
' and c.cod_filial = nvl(:p30_filial, c.cod_filial)',
' and c.cod_ccusto = nvl(:p30_ccusto, c.cod_ccusto)',
' and f_acesso_fil(c.cod_empresa, c.cod_filial) = ''S''',
' and F_Acesso_CC(c.cod_empresa, c.cod_ccusto) = ''S''',
' and ((:p_painel = ''PO'') or (not exists (select 1 ',
'                                           from informacoes_funcionais i ',
'                                          where i.cod_empresa = c.cod_empresa',
'                                            and i.filial = c.cod_filial',
'                                            and i.cad_vaga = c.cod_vaga',
'                                            and i.cod_empresa = :p_empresa_user',
'                                            and i.matricula = :p_matricula_user)))',
' order by c.cod_empresa, c.cod_filial, c.cod_ccusto, to_number(c.cod_vaga)'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
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
 p_id=>wwv_flow_api.id(283826377272963361525)
,p_max_row_count=>'1000000'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:31:P31_COD_EMPRESA,P31_COD_VAGA,P31_COD_FILIAL:#COD_EMPRESA#,#COD_VAGA#,#COD_FILIAL#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>52895507402675175
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826377457842361525)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('C\00F3d. Empresa')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826377817110361525)
,p_db_column_name=>'COD_FILIAL'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>unistr('C\00F3d. Filial')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826378237452361526)
,p_db_column_name=>'DATA_INICIO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>unistr('Data In\00EDcio')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826378607381361526)
,p_db_column_name=>'DATA_FIM'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Data Fim'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826378972225361527)
,p_db_column_name=>'COD_VAGA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Vaga'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826379441454361528)
,p_db_column_name=>'COD_CCUSTO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('C\00F3d. Hierarquia')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826379859504361528)
,p_db_column_name=>'COD_CCUSTO_CONTAB'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('C\00F3d. C.Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826380197866361528)
,p_db_column_name=>'COD_CARGO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('C\00F3d. Cargo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826380595627361528)
,p_db_column_name=>'COD_FUNCAO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>unistr('C\00F3d. Fun\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826381050625361530)
,p_db_column_name=>'VINCULO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826381457903361530)
,p_db_column_name=>'SIT_VAGA'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>unistr('Situa\00E7\00E3o da Vaga')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826381851921361530)
,p_db_column_name=>'IND_VAGA_COMPARTILHADA'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>'Vaga Compartilhada'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826382250793361531)
,p_db_column_name=>'VAGA_COMPARTILHADA'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>'Vaga Compartilhada'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826382604328361531)
,p_db_column_name=>'DISPONIVEL'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>unistr('Dispon\00EDvel')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283619287662963919924)
,p_db_column_name=>'COD_REQUISICAO'
,p_display_order=>150
,p_column_identifier=>'P'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(283826382972437361531)
,p_db_column_name=>'ROWID'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180011932693807997)
,p_db_column_name=>'EMPRESA_DESC'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180011974770807998)
,p_db_column_name=>'FILIAL_DESC'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180012154739807999)
,p_db_column_name=>'CCUSTO_DESC'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Hierarquia'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180012205479808000)
,p_db_column_name=>'CCUSTO_CONTAB_DESC'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>unistr('C.Custo Cont\00E1bil')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180012290753808001)
,p_db_column_name=>'CARGO_DESC'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Cargo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(36180012360229808002)
,p_db_column_name=>'FUNCAO_DESC'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>unistr('Fun\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28170329133168927763)
,p_db_column_name=>'POSICAO_IND_GESTOR'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>unistr('Posi\00E7\00E3o Ind. Gestor')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(28170329282876927764)
,p_db_column_name=>'POSICAO_IND_WORKFLOW'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>unistr('Posi\00E7\00E3o Ind. Workflow')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(283826383402559361532)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'529017'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_view_mode=>'REPORT'
,p_report_columns=>'EMPRESA_DESC:FILIAL_DESC:DATA_INICIO:DATA_FIM:COD_VAGA:COD_REQUISICAO:CCUSTO_DESC:CCUSTO_CONTAB_DESC:CARGO_DESC:FUNCAO_DESC:VINCULO:SIT_VAGA:IND_VAGA_COMPARTILHADA:VAGA_COMPARTILHADA:DISPONIVEL:POSICAO_IND_GESTOR:POSICAO_IND_WORKFLOW:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(283826844358465008699)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(283826376865859361524)
,p_button_name=>'p30_btn_pesquisar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(283867039191599591194)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612030937784291)
,p_name=>'P30_EMP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(283826376865859361524)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612089637784292)
,p_name=>'P30_FILIAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283826376865859361524)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612179135784293)
,p_name=>'P30_CCUSTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(283826376865859361524)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612542748784296)
,p_name=>'P30_EMPRESA_DISPLAY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(283779612424309784295)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612641060784297)
,p_name=>'P30_FILIAL_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(283779612424309784295)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(283779612709180784298)
,p_name=>'P30_CCUSTO_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(283779612424309784295)
,p_prompt=>'Centro de Custo'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(283867038577275591187)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283826124557222937779)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(283779612821685784299)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_CCusto'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select c.cod_empresa||'' - ''||initcap(fnct_nome_empresa(c.cod_empresa)) empresa, ',
'       f.cod_filial||'' - ''||initcap(fnct_nome_filial(c.cod_empresa, f.cod_filial)) filial, ',
'       c.cod||'' - ''||initcap(fnct_nome_ccusto(c.cod_empresa, c.cod)) ccusto, ',
'       c.cod_empresa, ',
'       f.cod_filial, ',
'       c.cod, ',
'       c.nome',
'  from centro_de_custo c, filial_ccusto f',
' where c.cod_empresa = f.cod_empresa',
'   and c.cod = f.cod_ccusto',
'   and c.cod_empresa = nvl(:p30_emp,c.cod_empresa)',
'   and f.cod_filial = nvl(:p30_filial,f.cod_filial)',
'   and c.cod = nvl(:p30_ccusto, c.cod);',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p30_empresa_display := v_c1.empresa;',
'    :p30_filial_display  := v_c1.filial;',
'    :p30_ccusto_display  := v_c1.ccusto;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(990030000000000002)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_POSICOES_INDICADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* NATCORP - painel de posicoes (Natcorp_Posicoes.js). FONTE: brand/apex/app/NC_POSICOES_INDICADORES.plsql.sql',
'   (guia POSICOES-MANUTENCAO.md). Mude la e aplique de novo com aplicar-posicoes-pagina30.py. SO LE: nao grava nada. */',
'declare',
'  l_hoje   date := trunc(sysdate);',
'  l_cru    clob;',
'  l_saida  clob;',
'  l_buf    varchar2(32767);',
'  l_corte  pls_integer;',
'  l_passo  varchar2(30) := ''inicio'';',
'  l_n      pls_integer := 0;',
'  l_nurl   pls_integer := 0;',
'  l_url    varchar2(4000);',
'  l_sem    pls_integer := 0;',
'  l_k      varchar2(400);',
'  l_ocup   number;',
'  l_saiu   varchar2(8);',
'  l_disp   number;',
'  l_prob   boolean;',
'  l_emp    varchar2(100) := :P30_EMP;',
'  l_fil    varchar2(100) := :P30_FILIAL;',
'  l_cc     varchar2(100) := :P30_CCUSTO;',
'',
'  l_dims sys.odcivarchar2list := sys.odcivarchar2list(''emp'', ''fil'', ''cc'', ''cct'', ''car'', ''fun'', ''vin'', ''sit'');',
'',
'  type t_num is table of number index by varchar2(400);',
'  type t_txt is table of varchar2(400) index by varchar2(400);',
unistr('  cache   t_num;      /* "dim|chave" -> n\00FAmero */'),
unistr('  por_rot t_num;      /* "dim|nome" -> n\00FAmero */'),
'  qtd     t_num;      /* dim -> quantos nomes */',
unistr('  rot     t_txt;      /* "dim#n\00FAmero" -> nome */'),
'  ocup    t_num;      /* "emp|filial|vaga" -> quem ocupa hoje */',
unistr('  saiu    t_txt;      /* "emp|filial|vaga" -> AAAAMMDD da \00FAltima sa\00EDda */'),
unistr('  pos_ix  t_num;      /* "emp|filial|vaga" -> posi\00E7\00E3o no "pos" (s\00F3 as de 2+ pessoas) */'),
unistr('  vinn    t_txt;      /* v\00EDnculo -> nome */'),
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
'  function q(p varchar2) return varchar2 is      /* texto JSON entre aspas */',
'  begin',
'    return ''"'' || apex_escape.json(p) || ''"'';',
'  end;',
'  function ix_rot(p_dim varchar2, p_rot varchar2) return pls_integer is',
unistr('    r varchar2(400) := substr(nvl(p_rot, ''N\00E3o informado''), 1, 380);'),
'    n pls_integer;',
'  begin',
'    if not por_rot.exists(p_dim || ''|'' || r) then',
'      n := case when qtd.exists(p_dim) then qtd(p_dim) else 0 end;',
'      por_rot(p_dim || ''|'' || r) := n;',
'      rot(p_dim || ''#'' || n) := r;',
'      qtd(p_dim) := n + 1;',
'    end if;',
'    return por_rot(p_dim || ''|'' || r);',
'  end;',
unistr('  /* o nome de um c\00F3digo, IGUAL ao da coluna do relat\00F3rio */'),
'  function ix(p_dim varchar2, p_emp varchar2, p_cod varchar2, p_cod2 varchar2 default null) return pls_integer is',
'    k varchar2(400) := p_dim || ''|'' || p_emp || ''|'' || substr(p_cod, 1, 150) || ''|'' || substr(p_cod2, 1, 150);',
'    r varchar2(4000);',
'  begin',
'    if cache.exists(k) then return cache(k); end if;',
unistr('    if p_cod is null then r := ''N\00E3o informado'';'),
'    else',
'      begin',
'        r := case p_dim',
'               when ''emp'' then p_cod || '' - '' || initcap(fnct_nome_empresa(p_cod))',
'               when ''fil'' then p_cod || '' - '' || initcap(fnct_nome_filial(p_emp, p_cod))',
'               when ''cc''  then p_cod || '' - '' || initcap(fnct_nome_ccusto(p_emp, p_cod))',
'               when ''cct'' then p_cod || '' - '' || initcap(fnct_nome_ccusto_contab(p_emp, p_cod))',
'               when ''car'' then p_cod || '' - '' || initcap(fnct_nome_cargo(p_cod))',
'               when ''fun'' then p_cod || '' - '' || initcap(fnct_nome_funcao(p_cod2, p_cod))',
'             end;',
'      exception when others then r := p_cod;',
'      end;',
'    end if;',
'    cache(k) := ix_rot(p_dim, r);',
'    return cache(k);',
'  end;',
'  function nome_vinculo(p_cod varchar2) return varchar2 is',
'  begin',
'    if p_cod is null then return null; end if;',
'    if not vinn.exists(p_cod) then',
'      begin',
'        select substr(initcap(nome), 1, 380) into vinn(p_cod) from vinculo_empreg where cod = p_cod;',
'      exception when others then vinn(p_cod) := p_cod;',
'      end;',
'    end if;',
'    return vinn(p_cod);',
'  end;',
'  function nome_func(p_emp varchar2, p_mat varchar2) return varchar2 is',
'    r varchar2(400);',
'  begin',
'    begin r := p_mat || '' - '' || initcap(fnct_nome_func(p_emp, p_mat)); exception when others then r := p_mat; end;',
'    return substr(r, 1, 380);',
'  end;',
'  procedure manda(c clob, p_ate pls_integer) is',
'    p pls_integer := 1;',
'  begin',
'    while p <= p_ate loop',
'      htp.prn(dbms_lob.substr(c, least(8000, p_ate - p + 1), p));',
'      p := p + 8000;',
'    end loop;',
'  end;',
'begin',
'  dbms_lob.createtemporary(l_cru, true);',
'  apex_json.initialize_clob_output;',
'  apex_json.open_object;',
'  apex_json.write(''v'', 1);',
'  apex_json.write(''hoje'', to_char(l_hoje, ''DD/MM/YYYY''));',
'',
unistr('  /* -- quem ocupa cada posi\00E7\00E3o hoje, e a \00FAltima sa\00EDda -- */'),
'  l_passo := ''ocupacao'';',
'  for r in (select cod_empresa emp, filial fil, to_char(cad_vaga) vaga, count(*) n',
'              from informacoes_funcionais',
'             where situacao < ''90'' and cad_vaga is not null',
'             group by cod_empresa, filial, cad_vaga) loop',
'    ocup(r.emp || ''|'' || r.fil || ''|'' || r.vaga) := r.n;',
'  end loop;',
'  for r in (select cod_empresa emp, filial fil, to_char(cad_vaga) vaga, to_char(max(dt_situacao), ''YYYYMMDD'') d',
'              from informacoes_funcionais',
'             where situacao >= ''90'' and cad_vaga is not null',
'             group by cod_empresa, filial, cad_vaga) loop',
'    saiu(r.emp || ''|'' || r.fil || ''|'' || r.vaga) := r.d;',
'  end loop;',
'',
unistr('  /* -- as posi\00E7\00F5es: a MESMA consulta do relat\00F3rio -- */'),
'  l_passo := ''posicoes'';',
'  apex_json.open_object(''urls'');',
'  cru(''"pos":['');',
'  for r in (',
'    select c.cod_empresa, c.cod_filial, c.data_inicio, c.data_fim, to_char(c.cod_vaga) cod_vaga,',
'           c.cod_ccusto, c.cod_ccusto_contab, c.cod_cargo, c.cod_funcao, initcap(v.nome) vinculo,',
'           decode(c.sit_vaga, ''A'', ''Ativa'', ''S'', ''Suspensa'', ''E'', ''Extinta'') sit_vaga,',
'           c.ind_vaga_compartilhada, c.disponivel, c.cod_requisicao, c.posicao_ind_gestor',
'      from cl_vaga c, vinculo_empreg v',
'     where c.vinculo = v.cod',
'       and c.cod_empresa = nvl(l_emp, c.cod_empresa)',
'       and c.cod_filial = nvl(l_fil, c.cod_filial)',
'       and c.cod_ccusto = nvl(l_cc, c.cod_ccusto)',
'       and f_acesso_fil(c.cod_empresa, c.cod_filial) = ''S''',
'       and F_Acesso_CC(c.cod_empresa, c.cod_ccusto) = ''S''',
'       and ((:P_PAINEL = ''PO'') or (not exists (select 1',
'                                                  from informacoes_funcionais i',
'                                                 where i.cod_empresa = c.cod_empresa',
'                                                   and i.filial = c.cod_filial',
'                                                   and i.cad_vaga = c.cod_vaga',
'                                                   and i.cod_empresa = :P_EMPRESA_USER',
'                                                   and i.matricula = :P_MATRICULA_USER)))',
'     order by c.cod_empresa, c.cod_filial, c.cod_ccusto, to_number(c.cod_vaga)',
'  ) loop',
'    l_k := r.cod_empresa || ''|'' || r.cod_filial || ''|'' || r.cod_vaga;',
'    l_ocup := case when ocup.exists(l_k) then ocup(l_k) else 0 end;',
'    l_saiu := case when saiu.exists(l_k) then saiu(l_k) end;',
'    l_disp := case r.disponivel when ''S'' then 1 when ''N'' then 0 else -1 end;',
'    cru(case when l_n > 0 then '','' end || ''['' ||',
'        ix(''emp'', null, r.cod_empresa) || '','' || ix(''fil'', r.cod_empresa, r.cod_filial) || '','' ||',
'        ix(''cc'', r.cod_empresa, r.cod_ccusto) || '','' || ix(''cct'', r.cod_empresa, r.cod_ccusto_contab) || '','' ||',
'        ix(''car'', null, r.cod_cargo) || '','' || ix(''fun'', null, r.cod_funcao, r.cod_cargo) || '','' ||',
unistr('        ix_rot(''vin'', r.vinculo) || '','' || ix_rot(''sit'', nvl(r.sit_vaga, ''Sem situa\00E7\00E3o'')) || '','' ||'),
'        q(r.cod_vaga) || '','' || l_disp || '','' ||',
'        case when r.ind_vaga_compartilhada = ''S'' then 1 else 0 end || '','' ||',
'        case when r.posicao_ind_gestor = ''S'' then 1 else 0 end || '','' ||',
'        q(to_char(r.cod_requisicao)) || '','' || q(to_char(r.data_inicio, ''YYYYMMDD'')) || '','' ||',
'        q(to_char(r.data_fim, ''YYYYMMDD'')) || '','' || l_ocup || '','' || q(l_saiu) || '']'');',
'    if l_ocup >= 2 then pos_ix(l_k) := l_n; end if;',
unistr('    /* o detalhe s\00F3 das posi\00E7\00F5es que as listas mostram */'),
'    l_prob := (r.sit_vaga = ''Ativa'' and (l_ocup = 0',
'                                         or (l_ocup >= 2 and nvl(r.ind_vaga_compartilhada, ''N'') <> ''S'')',
'                                         or (l_disp = 1 and l_ocup > 0) or (l_disp = 0 and l_ocup = 0)',
'                                         or r.data_fim < l_hoje))',
'              or (nvl(r.sit_vaga, ''X'') <> ''Ativa'' and l_ocup > 0);',
'    if l_prob and l_nurl < 6000 then',
'      begin',
'        l_url := apex_page.get_url(p_page => 31, p_clear_cache => ''31'',',
'                                   p_items => ''P31_COD_EMPRESA,P31_COD_VAGA,P31_COD_FILIAL'',',
'                                   p_values => r.cod_empresa || '','' || r.cod_vaga || '','' || r.cod_filial);',
'        apex_json.write(to_char(l_n), l_url);',
'        l_nurl := l_nurl + 1;',
'      exception when others then null;',
'      end;',
'    end if;',
'    l_n := l_n + 1;',
'  end loop;',
'  cru('']'');',
'  descarrega;',
'  apex_json.close_object;',
'',
unistr('  /* -- quem ocupa as posi\00E7\00F5es com 2 pessoas ou mais -- */'),
'  l_passo := ''ocupantes'';',
'  apex_json.open_object(''oc'');',
'  declare',
'    l_ult varchar2(400);',
'  begin',
'    for r in (select i.cod_empresa emp, i.filial fil, to_char(i.cad_vaga) vaga, i.matricula mat',
'                from informacoes_funcionais i',
'               where i.situacao < ''90'' and i.cad_vaga is not null',
'                 and (i.cod_empresa, i.filial, i.cad_vaga) in (select cod_empresa, filial, cad_vaga',
'                                                                 from informacoes_funcionais',
'                                                                where situacao < ''90'' and cad_vaga is not null',
'                                                                group by cod_empresa, filial, cad_vaga',
'                                                               having count(*) > 1)',
'               order by i.cod_empresa, i.filial, i.cad_vaga, i.matricula) loop',
'      l_k := r.emp || ''|'' || r.fil || ''|'' || r.vaga;',
'      if pos_ix.exists(l_k) then',
'        if l_ult is null or l_ult <> l_k then',
'          if l_ult is not null then apex_json.close_array; end if;',
'          apex_json.open_array(to_char(pos_ix(l_k)));',
'          l_ult := l_k;',
'        end if;',
'        apex_json.write(nome_func(r.emp, r.mat));',
'      end if;',
'    end loop;',
'    if l_ult is not null then apex_json.close_array; end if;',
'  end;',
'  apex_json.close_object;',
'',
unistr('  /* -- quem trabalha SEM posi\00E7\00E3o v\00E1lida, no mesmo alcance -- */'),
'  l_passo := ''sem posicao'';',
'  apex_json.open_object(''sem'');',
'  apex_json.open_array(''lista'');',
'  for r in (',
'    select i.cod_empresa emp, i.matricula mat, i.filial fil, i.cod_ccusto cc, i.cargo car, i.vinculo vin',
'      from informacoes_funcionais i',
'     where i.situacao < ''90''',
'       and i.cod_empresa = nvl(l_emp, i.cod_empresa)',
'       and i.filial = nvl(l_fil, i.filial)',
'       and i.cod_ccusto = nvl(l_cc, i.cod_ccusto)',
'       and (i.cad_vaga is null',
'            or not exists (select 1 from cl_vaga c',
'                            where c.cod_empresa = i.cod_empresa and c.cod_filial = i.filial',
'                              and c.cod_vaga = i.cad_vaga))',
'       and f_acesso_fil(i.cod_empresa, i.filial) = ''S''',
'       and F_Acesso_CC(i.cod_empresa, i.cod_ccusto) = ''S''',
'     order by i.cod_empresa, i.filial, i.matricula',
'  ) loop',
'    l_sem := l_sem + 1;',
'    if l_sem <= 2000 then',
'      apex_json.open_object;',
'      apex_json.write(''n'', nome_func(r.emp, r.mat));',
'      apex_json.write(''c'', rot(''car#'' || ix(''car'', null, r.car)));',
'      apex_json.write(''s'', rot(''cc#'' || ix(''cc'', r.emp, r.cc)));',
'      apex_json.write(''f'', rot(''fil#'' || ix(''fil'', r.emp, r.fil)));',
'      apex_json.write(''k'', ix(''emp'', null, r.emp) || '','' || ix(''fil'', r.emp, r.fil) || '','' || ix(''cc'', r.emp, r.cc) || '','' ||',
'                           ix(''car'', null, r.car) || '','' || ix_rot(''vin'', nome_vinculo(r.vin)));',
'      apex_json.close_object;',
'    end if;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.write(''total'', l_sem);',
'  apex_json.close_object;',
'  apex_json.write(''cortou'', l_sem > 2000);',
'',
'  /* -- os nomes -- */',
'  l_passo := ''nomes'';',
'  apex_json.open_object(''dims'');',
'  for j in 1 .. l_dims.count loop',
'    apex_json.open_array(l_dims(j));',
'    if qtd.exists(l_dims(j)) then',
'      for n in 0 .. qtd(l_dims(j)) - 1 loop apex_json.write(rot(l_dims(j) || ''#'' || n)); end loop;',
'    end if;',
'    apex_json.close_array;',
'  end loop;',
'  apex_json.close_object;',
'  apex_json.close_object;',
'  l_saida := apex_json.get_clob_output;',
'  apex_json.free_output;',
'',
'  /* emenda: o JSON do apex_json SEM o "}" do fim + "," + pos + "}" */',
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
