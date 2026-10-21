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
