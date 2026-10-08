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
--   Date and Time:   02:42 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 40
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00040
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>40);
end;
/
prompt --application/pages/page_00040
begin
wwv_flow_api.create_page(
 p_id=>40
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Consulta M\00E9dica')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Consulta M\00E9dica')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'',
'function apex_disable(obj) {',
'  function focus_handler(evt) {',
'    return false;',
'  }',
'',
'  $(obj).each(function(){',
'    let $obj = $(this);',
'',
'    if ($obj.hasClass(''apex-item-popup-lov''))',
'      $obj = $obj.closest(''fieldset'');',
'',
'    $obj.addClass(''apex_disabled'')',
'        .attr(''tabindex'', ''-1'')',
'        .css(''pointer-events'', ''none'')',
'        .attr(''autocomplete'', ''off'')',
'        .css(''opacity'', ''.7'')',
'        .on(''keydown'', focus_handler)',
'        .find(''.a-Button--popupLOV,.a-Button--calendar'').hide()',
'    ;',
'',
'    // Remove date picker',
'    $obj.parent().find(''.a-Button--calendar'').hide()',
'  });',
'}'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'setTimeout(function() {',
'  $(''#receituario button[data-action="save"]'').parent().hide()',
'}, 500);'))
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_width=>'80%'
,p_protection_level=>'C'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260831095040'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166677314070816238935)
,p_plug_name=>'Form on CONSULTA_MEDICA'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834497856886858)
,p_plug_display_sequence=>12
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166677314808716238937)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834581028886859)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118466231665055)
,p_plug_name=>'Tabs Container'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(177921844724398886873)
,p_plug_display_sequence=>22
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(46935045405321026700)
,p_plug_name=>unistr('Recomenda\00E7\00E3o de Trabalho Compat\00EDvel ')
,p_region_name=>'TAB10'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>150
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(132868580041941049750)
,p_plug_name=>unistr('Descri\00E7\00E3o de Atividades')
,p_region_name=>'TAB9'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>140
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(132868579006422049740)
,p_plug_name=>unistr('Descri\00E7\00E3o de Atividades')
,p_parent_plug_id=>wwv_flow_api.id(132868580041941049750)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.descr_func ',
'  from PERFIL_PROFISIOGRAFICO a,',
'       informacoes_funcionais b',
' where b.cod_empresa = a.cod_empresa',
'   and b.filial = a.cod_filial',
'   and b.cargo = a.cod_cargo',
'   and b.cod_localizacao = a.cod_local_trab',
'   and b.funcao = a.cod_funcao',
'   and b.cod_empresa = :P40_COD_EMPRESA',
'   and b.matricula = :P40_MATRICULA;',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P40_COD_EMPRESA,P40_MATRICULA'
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
 p_id=>wwv_flow_api.id(132868578868229049739)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>65269242765292958162
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(68966109738682714214)
,p_db_column_name=>'DESCR_FUNC'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>unistr('Descri\00E7\00E3o de Atividades')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(132846607575574956254)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'13667740'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DESCR_FUNC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166290093786906420211)
,p_plug_name=>'Gestante'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:i-h240:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--stretchInputs:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'(NVL(pkg_mt_adt_CMO.fnc_VerifGeneroFunc(pEmp => to_number(:P40_COD_EMPRESA),  pMat => TO_NUMBER(:P40_MATRICULA),  pSexo => ''F''), 0) = 1)'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166675610486750889035)
,p_plug_name=>'Dados da Consulta'
,p_region_name=>'TAB1'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118581102665056)
,p_plug_name=>'Relato do Paciente'
,p_region_name=>'TAB2'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118710707665057)
,p_plug_name=>unistr('Exame F\00EDsico')
,p_region_name=>'TAB3'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118792221665058)
,p_plug_name=>unistr('Receitu\00E1rio M\00E9dico')
,p_region_name=>'TAB4'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select r.rowid',
'       ,r.cod_rec_medto',
'       ,r.cod_medto',
'       ,r.texto',
'       ,r.usuario',
'       ,r.dt_atualizacao',
'       ,(select m.via_administ from medicamento m where m.cod_medto = r.cod_medto) via_administ',
'       ,(select m.dosagem from medicamento m where m.cod_medto = r.cod_medto) dosagem',
'       ,(select m.forma from medicamento m where m.cod_medto = r.cod_medto) forma',
'   from rec_medto r',
'  where r.cod_rec_medto = nvl(:P40_COD_CONS_REL_PACIENTE,:P40_COD_REC_MEDTO)'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P40_COD_REC_MEDTO,P40_COD_CONS_REL_PACIENTE'
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
 p_id=>wwv_flow_api.id(165255385732959903824)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:RP,42:P42_ROWID,P42_COD_REC_MEDTO:#ROWID#,#COD_REC_MEDTO#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'CIBELE.CRISTINA'
,p_internal_uid=>524306970901864119
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255385831279903825)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255385884672903826)
,p_db_column_name=>'COD_REC_MEDTO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cod Rec Medto'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255385970969903827)
,p_db_column_name=>'COD_MEDTO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Medicamento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386112011903828)
,p_db_column_name=>'TEXTO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Texto'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386173701903829)
,p_db_column_name=>'USUARIO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386354719903830)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386406060903831)
,p_db_column_name=>'VIA_ADMINIST'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Via Administrativa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386521646903832)
,p_db_column_name=>'DOSAGEM'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Dosagem'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165255386581209903833)
,p_db_column_name=>'FORMA'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Forma'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(165257727746324326324)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'5266490'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ROWID:COD_REC_MEDTO:COD_MEDTO:TEXTO:USUARIO:DT_ATUALIZACAO:VIA_ADMINIST:DOSAGEM:FORMA'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118946069665059)
,p_plug_name=>unistr('Diagn\00F3stico')
,p_region_name=>'TAB6'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165239787328500942844)
,p_plug_name=>unistr('Doen\00E7as')
,p_parent_plug_id=>wwv_flow_api.id(166678118946069665059)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select rowid',
'      ,cod_func_doenca',
'      ,cod_empresa',
'      ,matricula',
'      ,dc_matricula',
'      ,cod_doenca',
'      ,dt_inicio',
'      ,dt_termino',
'      ,usuario',
'      ,dt_atualizacao',
'      ,COD_CONS_DIAGNO',
'  from func_doenca    ',
' where cod_cons_diagno = :P40_COD_CONS_REL_PACIENTE',
'and cod_empresa = :P40_COD_EMPRESA',
'and matricula = :P40_MATRICULA'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P40_COD_CONS_REL_PACIENTE,P40_COD_EMPRESA,P40_MATRICULA'
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
 p_id=>wwv_flow_api.id(165239787460620942845)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>508708698562903140
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787529426942846)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787582858942847)
,p_db_column_name=>'COD_FUNC_DOENCA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Cod Func Doenca'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787707841942848)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787766143942849)
,p_db_column_name=>'MATRICULA'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787887916942850)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239787985718942851)
,p_db_column_name=>'COD_DOENCA'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>unistr('Doen\00E7a')
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166662468646390256708)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239788065410942852)
,p_db_column_name=>'DT_INICIO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Data In\00EDcio')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239788180677942853)
,p_db_column_name=>'DT_TERMINO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('Data T\00E9rmino')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_format_mask=>'dd/mm/rrrr'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239788282329942854)
,p_db_column_name=>'USUARIO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Usuario'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165239788447508942855)
,p_db_column_name=>'DT_ATUALIZACAO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>'Dt Atualizacao'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(165241980911781493006)
,p_db_column_name=>'COD_CONS_DIAGNO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Cod Cons Diagno'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(165241993214504534946)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'5109145'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ROWID:COD_FUNC_DOENCA:COD_EMPRESA:MATRICULA:DC_MATRICULA:COD_DOENCA:DT_INICIO:DT_TERMINO:USUARIO:DT_ATUALIZACAO:COD_CONS_DIAGNO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678118995566665060)
,p_plug_name=>'Posologia'
,p_region_name=>'TAB5'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678119146118665061)
,p_plug_name=>'Encaminhamento'
,p_region_name=>'TAB7'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>120
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166678119169543665062)
,p_plug_name=>'Conduta'
,p_region_name=>'TAB8'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>130
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168153434374263693757)
,p_plug_name=>'Anamnese'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157500821370729117)
,p_plug_name=>'Anamnese'
,p_parent_plug_id=>wwv_flow_api.id(168153434374263693757)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157502085891730556)
,p_plug_name=>'Antecedentes / Vida Pregressa'
,p_parent_plug_id=>wwv_flow_api.id(166678118466231665055)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14344471177577698148)
,p_plug_name=>unistr('Outras Doen\00E7as')
,p_region_name=>'RG_DOENCAS'
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14344471683582698153)
,p_plug_name=>'Uso Medicamentos'
,p_region_name=>'RG_USO_MED'
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157502199710730557)
,p_plug_name=>unistr('Question\00E1rio')
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157504338677730578)
,p_plug_name=>'Pessoais'
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157504351127730579)
,p_plug_name=>unistr('Observa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157504442797730580)
,p_plug_name=>'Familiares'
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168157504628984730581)
,p_plug_name=>'Ocupacionais'
,p_parent_plug_id=>wwv_flow_api.id(168157502085891730556)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165255384196580903809)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166678118792221665058)
,p_button_name=>'ADD_RECEITUARIO'
,p_button_static_id=>'ADD_RECEITUARIO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P40_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(92954124176244616167)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_button_name=>'BT_INICIO_ATEND'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Iniciar Atendimento'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P40_PRE_ATEND'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_grid_new_row=>'N'
,p_grid_column_span=>2
,p_grid_column=>11
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(33009886705875600825)
,p_button_sequence=>140
,p_button_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_button_name=>'BT_SALVAR_DESCR'
,p_button_static_id=>'BT_SALVAR_DESCR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BODY'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from RESTRICAO_ATIVIDADES',
' where cod_restr_atividade = :P40_COD_CONS_REL_PACIENTE',
'   and usuario = :P_USUARIO',
'   and trunc(sysdate) between dt_inicio and dt_termino'))
,p_button_condition_type=>'EXISTS'
,p_grid_new_row=>'Y'
,p_grid_column_span=>1
,p_grid_column=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166677315187008238937)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166677314808716238937)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166677314677751238937)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166677314808716238937)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166680716800684798435)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_button_name=>'DADOS_FUNC'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Dados do Funcion\00E1rio')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_COD_EMPRESA,P6_MATRICULA:&P40_COD_EMPRESA.,&P40_MATRICULA.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166680716869449798436)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_button_name=>'ATES_SAUD_OCUP'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Atestado de Sa\00FAde Ocupacional')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:RP:P19_EMPRESA,P19_MATRICULA,P19_TIPO_EXAME,P19_DATA_ATUAL:&P40_COD_EMPRESA.,&P40_MATRICULA.,&P40_TIPO_EXAME.,&P40_DT_CONSULTA.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166680717053787798437)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_button_name=>'IMPR_CONS_REAL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Imprimir Consulta Realizada'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P40_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(41395617661832485626)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_button_name=>'IMPR_REC'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Imprimir Recomenda\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P40_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166677314616055238937)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(166677314808716238937)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166677314483240238937)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(166677314808716238937)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Finalizar Consulta'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P40_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165241980969791493007)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165239787328500942844)
,p_button_name=>'ADD_DOENCA'
,p_button_static_id=>'ADD_DOENCA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(166691432560949452146)
,p_branch_name=>'Go To Page &APP_PAGE_ID.'
,p_branch_action=>'f?p=&APP_ID.:&APP_PAGE_ID.:&SESSION.::&DEBUG.:RP,40:P40_ROWID:&P40_ROWID.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(166677314483240238937)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12860891982245130065)
,p_name=>'P40_COD_REQ'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14318837121739493094)
,p_name=>'P40_OBSERVACOES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157504351127730579)
,p_use_cache_before_default=>'NO'
,p_source=>'OBSERVACOES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>2000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14318837336480493096)
,p_name=>'P40_IND_OUTRAS_DOENCAS'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_OUTRAS_DOENCAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Outras Doen\00E7as;S')
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344132018254138147)
,p_name=>'P40_TEXTO_ANAMNESE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157500821370729117)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Registro da Entrevista'
,p_source=>'TEXTO_ANAMNESE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344132996084139580)
,p_name=>'P40_APARELHO_CIRCULATORIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'APARELHO_CIRCULATORIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Aparelho Circulat\00F3rio;S')
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344133360197139581)
,p_name=>'P40_SANGUE_HEMATOPOIESE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'SANGUE_HEMATOPOIESE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Sangue / Hematopoiese?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344133806742139581)
,p_name=>'P40_TRANSTORNOS_MENTAIS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'TRANSTORNOS_MENTAIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Transtornos Mentais?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344134209338139581)
,p_name=>'P40_ENDOCRINOLOGIA_NUTRICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'ENDOCRINOLOGIA_NUTRICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Endocrinologia / Nutri\00E7\00E3o?;S')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344134642139139581)
,p_name=>'P40_APARELHO_RESPIRATORIO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'APARELHO_RESPIRATORIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Aparelho Respirat\00F3rio?;S')
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344135023088139581)
,p_name=>'P40_SISTEMA_OSTEOMUSCULAR'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'SISTEMA_OSTEOMUSCULAR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Sistema Osteomuscular?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344135369185139581)
,p_name=>'P40_DOENCAS_INFECTO_CONTAGIOSAS'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'DOENCAS_INFECTO_CONTAGIOSAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Doen\00E7as infecto-contagiosas?;S')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344135779617139582)
,p_name=>'P40_MEDICAMENTOS_DIETAS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'MEDICAMENTOS_DIETAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Medicamentos / Dietas?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344136160722139582)
,p_name=>'P40_APARELHO_DIGESTIVO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'APARELHO_DIGESTIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Aparelho Digestivo?;S'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344136627877139582)
,p_name=>'P40_SISTEMA_NERVOSO_SENTIDOS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'SISTEMA_NERVOSO_SENTIDOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Sistema Nervoso / \00D3rg\00E3o dos Sentidos?;S')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344137009593139582)
,p_name=>'P40_TUMORES'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'TUMORES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Tumores?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344137357864139582)
,p_name=>'P40_PELE_SUBCUTANEO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'PELE_SUBCUTANEO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Pele / Subcut\00E2neo?;S')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344137807058139582)
,p_name=>'P40_APARELHO_GENITOURINARIO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'APARELHO_GENITOURINARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Aparelho Geniturin\00E1rio?;S')
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344138189064139582)
,p_name=>'P40_HOSPITALIZACAO_CIRURGIA'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'HOSPITALIZACAO_CIRURGIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Hospitaliza\00E7\00E3o / Cirurgia?;S')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344138562073139582)
,p_name=>'P40_ANGIOLOGIA'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'ANGIOLOGIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Angiologia?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344138954284139582)
,p_name=>'P40_ALERGIA'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'ALERGIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Alergia?;S'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344139451735139583)
,p_name=>'P40_ANOMALIAS_CONGENITAS'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'ANOMALIAS_CONGENITAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Anomalias Cong\00EAnitas?;S')
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344140150892139583)
,p_name=>'P40_ANTEC_PESSOAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157504338677730578)
,p_use_cache_before_default=>'NO'
,p_source=>'ANTEC_PESSOAIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344141066659139583)
,p_name=>'P40_ANTEC_FAMILIARES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157504442797730580)
,p_use_cache_before_default=>'NO'
,p_source=>'ANTEC_FAMILIARES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344141767045139583)
,p_name=>'P40_ANTEC_OCUPACIONAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168157504628984730581)
,p_use_cache_before_default=>'NO'
,p_source=>'ANTEC_OCUPACIONAIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344471296168698149)
,p_name=>'P40_DESC_OUTRAS_DOENCAS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14344471177577698148)
,p_use_cache_before_default=>'NO'
,p_source=>'DESC_OUTRAS_DOENCAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344471807245698154)
,p_name=>'P40_DESC_USO_MEDICAMENTOS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14344471683582698153)
,p_use_cache_before_default=>'NO'
,p_source=>'DESC_USO_MEDICAMENTOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>500
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14344471897135698155)
,p_name=>'P40_IND_USO_MEDICAMENTOS'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(168157502199710730557)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_USO_MEDICAMENTOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Uso Medicamentos;S'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14345601921300803408)
,p_name=>'P40_IND_GESTANTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166290093786906420211)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Est\00E1 Gestante?')
,p_source=>'IND_GESTANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14345602347929803410)
,p_name=>'P40_NUM_SEMANA_GESTACAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(166290093786906420211)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Quantas Semanas?'
,p_source=>'NUM_SEMANA_GESTACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_column=>7
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'40'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14345602671047803410)
,p_name=>'P40_IND_PRE_NATAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(166290093786906420211)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Faz Pr\00E9-Natal?')
,p_source=>'IND_PRE_NATAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14345603087169803410)
,p_name=>'P40_IND_LOCAL_PRE_NATAL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(166290093786906420211)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Local do Pr\00E9-Natal:')
,p_source=>'IND_LOCAL_PRE_NATAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:I - Interno;I,E - Externo;E'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14345603543337803411)
,p_name=>'P40_IND_AMAMENTANDO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(166290093786906420211)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Est\00E1 Amamentando?')
,p_source=>'IND_AMAMENTANDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46935045755289026704)
,p_name=>'P40_DSP_CARGO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46935046027835026706)
,p_name=>'P40_DSP_FUNCAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46935046160338026708)
,p_name=>'P40_DSP_LOCAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>'Local de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46935046378241026710)
,p_name=>'P40_DT_INICIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>unistr('Data In\00EDcio')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951475109027677761)
,p_name=>'P40_DT_TERMINO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>unistr('Data T\00E9rmino')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_cMaxlength=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951475154487677762)
,p_name=>'P40_QTDE_DIAS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>'Qtde Dias'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951476186288677772)
,p_name=>'P40_DESCRICAO_RESTRICAO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>unistr('N\00E3o dever\00E1 realizar as atividades abaixo')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>999
,p_cHeight=>8
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951476551047677776)
,p_name=>'P40_DESCRICAO_ATUAL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>unistr('Descri\00E7\00E3o Atual')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951476876415677779)
,p_name=>'P40_COD_FUNCAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951476968850677780)
,p_name=>'P40_COD_CARGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951477073969677781)
,p_name=>'P40_COD_LOCAL_TRAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951477881578677789)
,p_name=>'P40_COD_RESTR_ATIVIDADE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_RESTR_ATIVIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(46951478308989677793)
,p_name=>'P40_ORIGEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(46935045405321026700)
,p_prompt=>'Origem'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:\00D3steo;1,Mental ;2,Gestante;3,Outros;4,Fibromialgia;5,Lactante;6')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(92954124828171616173)
,p_name=>'P40_PRE_ATEND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(114649532144326907328)
,p_name=>'P40_ROWID_AGD'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165241981492046493012)
,p_name=>'P40_COD_EMPRESA_AUX'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165241981636826493013)
,p_name=>'P40_MATRICULA_AUX'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165241981764571493015)
,p_name=>'P40_URL_CAD_DOENCA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165255384890033903816)
,p_name=>'P40_URL_CAD_RECEITUARIO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166675610258260889032)
,p_name=>'P40_DSP_IDADE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_prompt=>'Idade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_column=>7
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677317620282238942)
,p_name=>'P40_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677318024694238944)
,p_name=>'P40_COD_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cSize=>40
,p_read_only_when=>'P40_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677318442247238945)
,p_name=>'P40_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||p.nome d',
'      ,p.matricula r',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and ((:P40_ROWID is null and f.situacao < ''90'') or (:P40_ROWID is not null))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P40_ROWID,P40_COD_EMPRESA'
,p_ajax_items_to_submit=>'P40_ROWID,P40_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>45
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_read_only_when=>'P40_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677318858805238945)
,p_name=>'P40_DC_MATRICULA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677319161198238945)
,p_name=>'P40_DT_CONSULTA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>'trunc(sysdate)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Data'
,p_source=>'DT_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>15
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677319598456238946)
,p_name=>'P40_DT_CONSULTA_HH'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>'to_char(sysdate, ''hh24'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Entrada'
,p_post_element_text=>'&nbsp(hora)'
,p_source=>'DT_CONSULTA_HH'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677319960269238946)
,p_name=>'P40_DT_CONSULTA_MM'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>'to_char(sysdate,''mi'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'&nbsp'
,p_post_element_text=>'&nbsp(minuto)'
,p_source=>'DT_CONSULTA_MM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677320392743238947)
,p_name=>'P40_COD_CONS_REL_PACIENTE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CONS_REL_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677320779731238947)
,p_name=>'P40_COD_REC_MEDTO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_REC_MEDTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677321206044238947)
,p_name=>'P40_COD_CONS_DIAGNO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CONS_DIAGNO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677321566608238948)
,p_name=>'P40_COD_TIPO_CONSULTA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Consulta'
,p_source=>'COD_TIPO_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_TIPO_CONSULTA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select substr(cod_tipo_consulta,1,5)||'' - ''||descricao d ',
'      ,cod_tipo_consulta r',
'from tipo_consulta ',
'order by cod_tipo_consulta   '))
,p_lov_display_null=>'YES'
,p_cSize=>40
,p_begin_on_new_line=>'N'
,p_grid_column=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677322015701238949)
,p_name=>'P40_COD_ENTIDADE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Entidade'
,p_source=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_ENTIDADE_TP_1'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select substr(entidade.cod_entidade,1,5)||'' - ''|| entidade.nome_entidade d,',
'       cod_entidade r',
'  from entidade ',
' where tipo_entidade = ''1''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>50
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677322398201238949)
,p_name=>'P40_COD_PREST_SERV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('M\00E9dico')
,p_source=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_prest_serv||'' - ''||a.nome d',
'      ,a.cod_prest_serv r',
'  from prestador_servico a',
' where a.dt_vigencia_fin >= sysdate',
'   and a.tipo_prest_serv = ''1''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>50
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677322839481238949)
,p_name=>'P40_COD_ESPECIALIDADE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Especialidade'
,p_source=>'COD_ESPECIALIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(substr(a.cod_especialidade,1,5))||'' - ''||b.descricao d',
'      ,a.cod_especialidade r',
'from prest_serv_especialidade a',
'    ,especialidade b ',
'where a.cod_prest_serv = :P40_COD_PREST_SERV',
'  and a.tipo_prest_serv = ''1'' ',
'  and a.cod_especialidade = b.cod_especialidade ',
'order by substr(a.cod_especialidade,1,5) '))
,p_lov_cascade_parent_items=>'P40_COD_PREST_SERV'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>40
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677323254366238949)
,p_name=>'P40_USUARIO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>':APP_USER'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677323605754238950)
,p_name=>'P40_DT_ATUALIZACAO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>'sysdate'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677324053637238950)
,p_name=>'P40_TIPO_ENTIDADE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677324371837238950)
,p_name=>'P40_TIPO_PREST_SERV'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677324832102238951)
,p_name=>'P40_DT_CONSULTA_HH_FIM'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Sa\00EDda')
,p_post_element_text=>'&nbsp(hora)'
,p_source=>'DT_CONSULTA_HH_FIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_grid_column=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677325243007238951)
,p_name=>'P40_DT_CONSULTA_MM_FIM'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'&nbsp'
,p_post_element_text=>'&nbsp(minuto)'
,p_source=>'DT_CONSULTA_MM_FIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>2
,p_cMaxlength=>2
,p_begin_on_new_line=>'N'
,p_grid_column=>7
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677325643277238951)
,p_name=>'P40_COD_POSOLOGIA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_POSOLOGIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166677325963397238952)
,p_name=>'P40_ORIGEM_MED'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_item_default=>'MI'
,p_source=>'ORIGEM_MED'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166678119267509665063)
,p_name=>'P40_DSP_RELATO_PACIENTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678118581102665056)
,p_prompt=>unistr('Relato do Paci\00EAnte')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166678119578135665066)
,p_name=>'P40_DSP_EXAME_FISICO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678118710707665057)
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>2000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680717118049798438)
,p_name=>'P40_DSP_DIAGNOSTICO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678118946069665059)
,p_prompt=>unistr('Diagn\00F3stico')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680717267947798440)
,p_name=>'P40_HIGIDO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166678118946069665059)
,p_prompt=>unistr('H\00EDgido')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(166663252488110389885)||'.'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680719023543798457)
,p_name=>'P40_DSP_POSOLOGIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678118995566665060)
,p_prompt=>'Posologia'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680719218727798459)
,p_name=>'P40_DSP_ENCAMINHAMENTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678119146118665061)
,p_prompt=>'Encaminhamento'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680719364129798461)
,p_name=>'P40_DSP_CONDUTA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166678119169543665062)
,p_prompt=>'Conduta'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>80
,p_cMaxlength=>4000
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166691430144534452121)
,p_name=>'P40_CHAMADA_AGENDA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166677314070816238935)
,p_use_cache_before_default=>'NO'
,p_source=>'N'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166691433185764452152)
,p_name=>'P40_TIPO_EXAME'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(166675610486750889035)
,p_use_cache_before_default=>'NO'
,p_prompt=>'TIPO EXAME'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select Classificacao_Aso',
'  From Tipo_Consulta',
' Where Cod_Tipo_Consulta = :P40_COD_TIPO_CONSULTA',
'   and rownum = 1'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680719620654798463)
,p_computation_sequence=>80
,p_computation_item=>'P40_TIPO_ENTIDADE'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tipo_entidade ',
'  from entidade ',
' where tipo_entidade = ''1'' ',
'   and cod_entidade = :P40_COD_ENTIDADE;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680719714464798464)
,p_computation_sequence=>90
,p_computation_item=>'P40_TIPO_PREST_SERV'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.tipo_prest_serv',
'  from prestador_servico a',
' where a.dt_vigencia_fin >= sysdate',
'   and a.tipo_prest_serv = ''1''',
'   and a.cod_prest_serv = :P40_COD_PREST_SERV;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680720059527798467)
,p_computation_sequence=>110
,p_computation_item=>'P40_COD_REC_MEDTO'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P40_COD_CONS_REL_PACIENTE'
,p_compute_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
':REQUEST = ''CREATE'' AND',
':P40_COD_REC_MEDTO is null'))
,p_compute_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680720096424798468)
,p_computation_sequence=>120
,p_computation_item=>'P40_COD_CONS_DIAGNO'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P40_COD_CONS_REL_PACIENTE'
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680720244082798469)
,p_computation_sequence=>130
,p_computation_item=>'P40_COD_POSOLOGIA'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select seq_cons_rel_posologia.nextval',
'  from sys.dual;'))
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(46951478017165677790)
,p_computation_sequence=>140
,p_computation_item=>'P40_COD_RESTR_ATIVIDADE'
,p_computation_type=>'ITEM_VALUE'
,p_computation=>'P40_COD_CONS_REL_PACIENTE'
,p_compute_when=>'CREATE'
,p_compute_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166681527957793015221)
,p_computation_sequence=>150
,p_computation_item=>'P40_DC_MATRICULA'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.dc_matricula',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and p.matricula   = :P40_MATRICULA'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(46951477167445677782)
,p_computation_sequence=>160
,p_computation_item=>'P40_COD_CARGO'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cargo',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and p.matricula   = :P40_MATRICULA'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(46951477319265677783)
,p_computation_sequence=>170
,p_computation_item=>'P40_COD_FUNCAO'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.funcao',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and p.matricula   = :P40_MATRICULA'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344153976507151684)
,p_computation_sequence=>180
,p_computation_item=>'P40_APARELHO_CIRCULATORIO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_APARELHO_CIRCULATORIO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344154396485153253)
,p_computation_sequence=>180
,p_computation_item=>'P40_SANGUE_HEMATOPOIESE'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_SANGUE_HEMATOPOIESE'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344154669166154071)
,p_computation_sequence=>180
,p_computation_item=>'P40_TRANSTORNOS_MENTAIS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_TRANSTORNOS_MENTAIS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344155043122154852)
,p_computation_sequence=>180
,p_computation_item=>'P40_ENDOCRINOLOGIA_NUTRICAO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_ENDOCRINOLOGIA_NUTRICAO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344155262879155833)
,p_computation_sequence=>180
,p_computation_item=>'P40_APARELHO_RESPIRATORIO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_APARELHO_RESPIRATORIO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344155567123156634)
,p_computation_sequence=>180
,p_computation_item=>'P40_SISTEMA_OSTEOMUSCULAR'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_SISTEMA_OSTEOMUSCULAR'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344155858631157545)
,p_computation_sequence=>180
,p_computation_item=>'P40_DOENCAS_INFECTO_CONTAGIOSAS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_DOENCAS_INFECTO_CONTAGIOSAS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344156245029158513)
,p_computation_sequence=>180
,p_computation_item=>'P40_MEDICAMENTOS_DIETAS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_MEDICAMENTOS_DIETAS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344156467442159691)
,p_computation_sequence=>180
,p_computation_item=>'P40_APARELHO_DIGESTIVO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_APARELHO_DIGESTIVO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344156838114160736)
,p_computation_sequence=>180
,p_computation_item=>'P40_SISTEMA_NERVOSO_SENTIDOS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_SISTEMA_NERVOSO_SENTIDOS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344157095399162021)
,p_computation_sequence=>180
,p_computation_item=>'P40_TUMORES'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_TUMORES'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344157397696163324)
,p_computation_sequence=>180
,p_computation_item=>'P40_PELE_SUBCUTANEO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_PELE_SUBCUTANEO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344157901968164984)
,p_computation_sequence=>180
,p_computation_item=>'P40_APARELHO_GENITOURINARIO'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_APARELHO_GENITOURINARIO'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344158373414166101)
,p_computation_sequence=>180
,p_computation_item=>'P40_HOSPITALIZACAO_CIRURGIA'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_HOSPITALIZACAO_CIRURGIA'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344158673862167241)
,p_computation_sequence=>180
,p_computation_item=>'P40_ANGIOLOGIA'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_ANGIOLOGIA'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344159116491168298)
,p_computation_sequence=>180
,p_computation_item=>'P40_ALERGIA'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_ALERGIA'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14344159503488169303)
,p_computation_sequence=>180
,p_computation_item=>'P40_ANOMALIAS_CONGENITAS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_ANOMALIAS_CONGENITAS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(14318837365221493097)
,p_computation_sequence=>190
,p_computation_item=>'P40_IND_OUTRAS_DOENCAS'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'N'
,p_compute_when=>'P40_IND_OUTRAS_DOENCAS'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(46951477353920677784)
,p_computation_sequence=>200
,p_computation_item=>'P40_COD_LOCAL_TRAB'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_localizacao',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and p.matricula   = :P40_MATRICULA'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166678119462513665065)
,p_computation_sequence=>10
,p_computation_item=>'P40_DSP_RELATO_PACIENTE'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select texto',
'  from cons_rel_paciente ',
' where cod_cons_rel_paciente = :P40_COD_CONS_REL_PACIENTE;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166678119693702665067)
,p_computation_sequence=>20
,p_computation_item=>'P40_DSP_EXAME_FISICO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select exame_fisico',
'  from cons_rel_paciente ',
' where cod_cons_rel_paciente = :P40_COD_CONS_REL_PACIENTE;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680717176901798439)
,p_computation_sequence=>30
,p_computation_item=>'P40_DSP_DIAGNOSTICO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select texto',
'  from cons_diagno   ',
' where cod_cons_diagno = :P40_COD_CONS_DIAGNO'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680717423762798441)
,p_computation_sequence=>40
,p_computation_item=>'P40_HIGIDO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select higido',
'  from cons_diagno   ',
' where cod_cons_diagno = :P40_COD_CONS_DIAGNO'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680719068880798458)
,p_computation_sequence=>50
,p_computation_item=>'P40_DSP_POSOLOGIA'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select texto',
'  from posologia  ',
' where cod_cons_rel_posologia = :P40_COD_POSOLOGIA;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680719342279798460)
,p_computation_sequence=>60
,p_computation_item=>'P40_DSP_ENCAMINHAMENTO'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select conduta',
'  from posologia  ',
' where cod_cons_rel_posologia = :P40_COD_POSOLOGIA;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(166680719519362798462)
,p_computation_sequence=>70
,p_computation_item=>'P40_DSP_CONDUTA'
,p_computation_point=>'BEFORE_BOX_BODY'
,p_computation_type=>'QUERY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select texto ',
'  from cons_conduta ',
' where cod_cons_conduta = :P40_COD_CONS_DIAGNO;'))
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(46951477587465677786)
,p_validation_name=>unistr('Data Inicio Restri\00E7\00E3o')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if to_date(:p40_dt_inicio,''dd/mm/rrrr'') < trunc(sysdate) and :P40_COD_CONS_REL_PACIENTE is null then',
unistr('   return(''A Data In\00EDcio da recomenda\00E7\00E3o n\00E3o deve ser menor que a Data Atual.'');'),
'end if;',
'',
'if to_date(:p40_dt_inicio,''dd/mm/rrrr'') > to_date(:p40_dt_termino,''dd/mm/rrrr'') then',
unistr('   return(''A Data In\00EDcio da recomenda\00E7\00E3o n\00E3o deve ser maior que a Data T\00E9rmino.'');'),
'end if;',
'',
'if to_date(:p40_dt_inicio,''dd/mm/rrrr'') < to_date(:p40_dt_consulta,''dd/mm/rrrr'') then',
unistr('   return(''A Data In\00EDcio da recomenda\00E7\00E3o n\00E3o deve ser menor que a Data Consulta.'');'),
'end if;',
'',
'if :p40_dt_inicio is null and :p40_dt_termino is not null then',
unistr('   return(''A Data In\00EDcio da recomenda\00E7\00E3o deve ser preenchida.'');'),
'end if;',
'',
'if :P40_DESCRICAO_RESTRICAO is not null and to_date(:p40_dt_inicio,''dd/mm/rrrr'') is null then',
unistr('   return(''A Data In\00EDcio da recomenda\00E7\00E3o deve ser preenchida.'');'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(46935046378241026710)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(46951477728433677787)
,p_validation_name=>unistr('Data Termino Restri\00E7\00E3o')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if to_date(:p40_dt_inicio,''dd/mm/rrrr'') > to_date(:p40_dt_termino,''dd/mm/rrrr'') then',
unistr('   return(''A Data T\00E9rmino da recomenda\00E7\00E3o n\00E3o deve ser menor que a Data In\00EDcio.'');'),
'end if;',
'',
'if :p40_dt_termino is null then',
unistr('   return(''A Data T\00E9rmino da recomenda\00E7\00E3o deve ser preenchida.'');'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P40_DT_INICIO'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_api.id(46951475109027677761)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(46951477785956677788)
,p_validation_name=>unistr('Descri\00E7\00E3o Restri\00E7\00E3o')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P40_DESCRICAO_RESTRICAO is null then',
unistr('   return(''A Descri\00E7\00E3o da recomenda\00E7\00E3o deve ser preenchida.'');'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'P40_DT_INICIO'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_api.id(46951476186288677772)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(35816023227417443677)
,p_validation_name=>'Valida P40_QTDE_DIAS'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P40_QTDE_DIAS > 90 then',
unistr('   return(''A Qtde. de Dias n\00E3o deve ser maior que 90 dias.'');'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(46951475154487677762)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166677315326174238937)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166677315187008238937)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165199437798213961748)
,p_event_id=>wwv_flow_api.id(166677315326174238937)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :p40_rowid is null then',
'    delete',
'    from func_doenca    ',
'     where cod_cons_diagno = :P40_COD_CONS_REL_PACIENTE',
'    and cod_empresa = :P40_COD_EMPRESA',
'    and matricula = :P40_MATRICULA;',
'',
'    commit;',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P40_ROWID,P40_COD_CONS_REL_PACIENTE,P40_COD_EMPRESA,P40_MATRICULA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166677316090370238939)
,p_event_id=>wwv_flow_api.id(166677315326174238937)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166675610272144889033)
,p_name=>'Carrega Idade'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166678118312875665053)
,p_event_id=>wwv_flow_api.id(166675610272144889033)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_DSP_IDADE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select trunc(months_between(sysdate, p.dt_nasc) / 12) idade',
'from inf_pessoais p',
'    ,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P40_COD_EMPRESA',
'  and p.matricula = :P40_MATRICULA'))
,p_attribute_07=>'P40_MATRICULA,P40_COD_EMPRESA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46935045934560026705)
,p_event_id=>wwv_flow_api.id(166675610272144889033)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_DSP_CARGO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.cod||''-''||c.nome cargo',
'  from inf_pessoais p',
'      ,informacoes_funcionais f',
'      ,cargos c',
' where p.cod_empresa = f.cod_empresa',
'   and p.matricula   = f.matricula',
'   and p.cod_empresa = :P40_COD_EMPRESA',
'   and p.matricula = :P40_MATRICULA',
'   and c.cod = f.cargo'))
,p_attribute_07=>'P40_MATRICULA,P40_COD_EMPRESA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46935046105446026707)
,p_event_id=>wwv_flow_api.id(166675610272144889033)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_DSP_FUNCAO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select func.cod||''-''||func.nome funcao',
'  from inf_pessoais p',
'      ,informacoes_funcionais f',
'      ,funcao func',
' where p.cod_empresa = f.cod_empresa',
'   and p.matricula   = f.matricula',
'   and p.cod_empresa = :P40_COD_EMPRESA',
'   and p.matricula = :P40_MATRICULA',
'   and func.cod_cargo = f.cargo',
'   and func.cod = f.funcao'))
,p_attribute_07=>'P40_MATRICULA,P40_COD_EMPRESA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46935046270504026709)
,p_event_id=>wwv_flow_api.id(166675610272144889033)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_DSP_LOCAL'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select l.cod_local_trab||''-''||l.descricao local_trab',
'  from inf_pessoais p',
'      ,informacoes_funcionais f',
'      ,local_trab l',
' where p.cod_empresa = f.cod_empresa',
'   and p.matricula   = f.matricula',
'   and p.cod_empresa = :P40_COD_EMPRESA',
'   and p.matricula = :P40_MATRICULA',
'   and l.cod_local_trab = f.cod_localizacao'))
,p_attribute_07=>'P40_MATRICULA,P40_COD_EMPRESA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165241981691540493014)
,p_event_id=>wwv_flow_api.id(166675610272144889033)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P40_COD_EMPRESA_AUX").setValue(apex.item("P40_COD_EMPRESA").getValue());',
'apex.item("P40_MATRICULA_AUX").setValue(apex.item("P40_MATRICULA").getValue());'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166691431373907452134)
,p_name=>'CREATE'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166677314483240238937)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691432558173452145)
,p_event_id=>wwv_flow_api.id(166691431373907452134)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>unistr('Deseja finalizar a consulta? N\00E3o ser\00E1 poss\00EDvel alterar ap\00F3s esta a\00E7\00E3o.')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691431713894452137)
,p_event_id=>wwv_flow_api.id(166691431373907452134)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P40_COD_CONS_REL_PACIENTE is null then',
'  :P40_COD_CONS_REL_PACIENTE := seq_cod_cons_rel_paciente.nextval;',
'end if;'))
,p_attribute_02=>'P40_COD_CONS_REL_PACIENTE'
,p_attribute_03=>'P40_COD_CONS_REL_PACIENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691431465379452135)
,p_event_id=>wwv_flow_api.id(166691431373907452134)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//apex.region("receituario").widget().interactiveGrid("getActions").invoke("save");',
'//apex.region("doencas").widget().interactiveGrid("getActions").invoke("save");'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967268347371810246)
,p_event_id=>wwv_flow_api.id(166691431373907452134)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    INSERT INTO MT_CHAMADA_PACIENTE_STATUS ',
'    (SELECT COD_EMPRESA, MATRICULA, COD_CANDIDATO, DATA, SEQ, SENHA, ''F'', NULL, SYSDATE, OBSERVACAO, :P_USUARIO, SYSDATE, FLAG',
'      FROM MT_CHAMADA_PACIENTE_STATUS S',
'     WHERE S.STATUS = ''I''',
'       AND S.DATA_STATUS = (SELECT MAX(X.DATA_STATUS)',
'                              FROM MT_CHAMADA_PACIENTE_STATUS X',
'                             WHERE X.COD_EMPRESA = :P40_COD_EMPRESA',
'                               AND (X.MATRICULA = :P40_MATRICULA',
'                                OR X.COD_CANDIDATO = :P40_MATRICULA)',
'                               AND DATA = TO_DATE(:P40_DT_CONSULTA,''DD/MM/RRRR'')));',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    NULL;',
'END;    '))
,p_attribute_02=>'P40_COD_EMPRESA,P40_MATRICULA,P40_DT_CONSULTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691431605837452136)
,p_event_id=>wwv_flow_api.id(166691431373907452134)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166691431781157452138)
,p_name=>'Disable Horarios'
,p_event_sequence=>50
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691431913923452139)
,p_event_id=>wwv_flow_api.id(166691431781157452138)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_DT_CONSULTA_HH,P40_DT_CONSULTA_MM,P40_DT_CONSULTA_HH_FIM,P40_DT_CONSULTA_MM_FIM'
,p_attribute_01=>'apex_disable(this.affectedElements)'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166691432707653452147)
,p_name=>unistr('Chama Relat\00F3rio')
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166680717053787798437)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691432843860452148)
,p_event_id=>wwv_flow_api.id(166691432707653452147)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RH1101'
,p_attribute_02=>'Consulta_Medica.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P40_COD_EMPRESA,P40_MATRICULA,P40_DT_CONSULTA,P40_USUARIO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return apex_string.format (',
'         ''COD_EMPRESA=%s&Data1=%s&Data2=%s&DT_CONSULTA=%s&Funcionario1=%s&Funcionario2=%s&P_Usuario=%s'',',
'         :P40_COD_EMPRESA,',
'         :P40_DT_CONSULTA, -- LTRIM(TO_CHAR(:P40_DT_CONSULTA,''DD/MM/YYYY'')),',
'         :P40_DT_CONSULTA, -- LTRIM(TO_CHAR(:P40_DT_CONSULTA,''DD/MM/YYYY'')),',
'         :P40_DT_CONSULTA, -- LTRIM(TO_CHAR(:P40_DT_CONSULTA,''DD/MM/YYYY'')),',
'         :P40_MATRICULA,',
'         :P40_MATRICULA,',
'         :P40_USUARIO',
'       );'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(41395617842878485627)
,p_name=>unistr('Chama Relat\00F3rio_Rec')
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(41395617661832485626)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(41395617927622485628)
,p_event_id=>wwv_flow_api.id(41395617842878485627)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP21594'
,p_attribute_02=>'Recomendacao.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P40_COD_EMPRESA,P40_MATRICULA,P40_DT_INICIO,P40_USUARIO,P40_COD_REC_MEDTO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return ''P_EMPRESA=''          || :P40_COD_EMPRESA',
'    || ''&P_DATA_INI=''        || :P40_DT_INICIO',
'    || ''&P_MATRICULA=''       || :P40_MATRICULA',
'    || ''&P_RESTR_ATIVIDADE='' || :P40_COD_REC_MEDTO',
'    || ''&P_USUARIO=''         || :P40_USUARIO;',
'      '))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165237406389228731340)
,p_name=>'Popula COD_CONS_REL_PACIENTE'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_COD_PREST_SERV'
,p_condition_element=>'P40_COD_PREST_SERV'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165237406497419731341)
,p_event_id=>wwv_flow_api.id(165237406389228731340)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_COD_CONS_REL_PACIENTE'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>'seq_cod_cons_rel_paciente.nextval;'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165241981075017493008)
,p_name=>unistr('Refresh Doen\00E7as')
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165241980969791493007)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165241981241330493009)
,p_event_id=>wwv_flow_api.id(165241981075017493008)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165239787328500942844)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165241981353343493010)
,p_name=>unistr('IR - Doen\00E7as - Dialog Close')
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(165239787328500942844)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165241981403631493011)
,p_event_id=>wwv_flow_api.id(165241981353343493010)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165239787328500942844)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165241982259706493019)
,p_name=>unistr('Button Action - Doen\00E7as')
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165241980969791493007)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165241981897521493016)
,p_event_id=>wwv_flow_api.id(165241982259706493019)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_URL_CAD_DOENCA'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url               varchar2(2000);',
'begin',
'',
'      l_url := apex_string.format (',
'                 ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'                 :APP_ID,',
'                 ''41'',',
'                 :SESSION,',
'                 null,',
'                 :DEBUG,',
'                 ''41'',',
'                 ''P41_COD_EMPRESA,P41_MATRICULA,P41_COD_CONS_DIAGNO'',',
'                 apex_string.format(''%s,%s,%s,%s,%s,%s,%s,%s'', :P40_COD_EMPRESA, :P40_MATRICULA, :P40_COD_CONS_REL_PACIENTE)',
'               );',
'',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#ADD_DOENCA")'');',
'end;'))
,p_attribute_07=>'P40_COD_EMPRESA,P40_MATRICULA,P40_COD_CONS_REL_PACIENTE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165241982450808493021)
,p_event_id=>wwv_flow_api.id(165241982259706493019)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*buttonAction = function() {',
'  window.location = apex.item(''P40_URL_CAD_DOENCA'').getValue()',
'}',
'buttonActionClick()',
'*/',
'eval(apex.item( "P40_URL_CAD_DOENCA" ).getValue());'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165255386719119903834)
,p_name=>'Refresh Receituario'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165255384196580903809)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165255386784165903835)
,p_event_id=>wwv_flow_api.id(165255386719119903834)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166678118792221665058)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165255384737003903814)
,p_name=>'Button Action - Receituario'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165255384196580903809)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165255385132245903818)
,p_event_id=>wwv_flow_api.id(165255384737003903814)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_URL_CAD_RECEITUARIO'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url               varchar2(2000);',
'begin',
'',
'      l_url := apex_string.format (',
'                 ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'                 :APP_ID,',
'                 ''42'',',
'                 :SESSION,',
'                 null,',
'                 :DEBUG,',
'                 ''42'',',
'                 ''P42_COD_REC_MEDTO'',',
'                 apex_string.format(''%s,%s,%s,%s,%s,%s,%s,%s'', :P40_COD_CONS_REL_PACIENTE)',
'               );',
'',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#ADD_RECEITUARIO")'');',
'end;'))
,p_attribute_07=>'P40_COD_CONS_REL_PACIENTE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165255384816379903815)
,p_event_id=>wwv_flow_api.id(165255384737003903814)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*buttonAction = function() {',
'  window.location = apex.item(''P40_URL_CAD_RECEITUARIO'').getValue()',
'}',
'buttonActionClick()',
'*/',
'eval(apex.item( "P40_URL_CAD_RECEITUARIO" ).getValue());'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165255388237059903849)
,p_name=>'IR - Receituario - Dialog Close'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(166678118792221665058)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165255388279297903850)
,p_event_id=>wwv_flow_api.id(165255388237059903849)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166678118792221665058)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165260870089975698338)
,p_name=>'Exibe/Oculta ATES_SAUD_OCUP'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_TIPO_EXAME'
,p_condition_element=>'P40_TIPO_EXAME'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165260870200116698339)
,p_event_id=>wwv_flow_api.id(165260870089975698338)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166680716869449798436)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165260870360966698340)
,p_event_id=>wwv_flow_api.id(165260870089975698338)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166680716869449798436)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165260871306955698350)
,p_name=>'Create: ATES_SAUD_OCUP'
,p_event_sequence=>160
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P40_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165260871376126698351)
,p_event_id=>wwv_flow_api.id(165260871306955698350)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166680716869449798436)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165272514145524990008)
,p_name=>'Popula P40_TIPO_EXAME'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_COD_TIPO_CONSULTA'
,p_condition_element=>'P40_COD_TIPO_CONSULTA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165272514223580990009)
,p_event_id=>wwv_flow_api.id(165272514145524990008)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_TIPO_EXAME'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select Classificacao_Aso',
'  From Tipo_Consulta',
' Where Cod_Tipo_Consulta = :P40_COD_TIPO_CONSULTA',
'   and rownum = 1'))
,p_attribute_07=>'P40_COD_TIPO_CONSULTA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165272514281003990010)
,p_event_id=>wwv_flow_api.id(165272514145524990008)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_TIPO_EXAME'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'NULL'
,p_attribute_09=>'N'
,p_wait_for_result=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92954124512243616170)
,p_name=>'Insere MT_CHAMADA_PACIENTE_STATUS'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(92954124176244616167)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954124618011616171)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
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
'                             WHERE X.COD_EMPRESA = :P40_COD_EMPRESA',
'                               AND (X.MATRICULA = :P40_MATRICULA',
'                                OR X.COD_CANDIDATO = :P40_MATRICULA)',
'                               AND DATA = TO_DATE(:P40_DT_CONSULTA,''DD/MM/RRRR'')));',
'EXCEPTION',
'  WHEN OTHERS THEN',
'    NULL;',
'END;    '))
,p_attribute_02=>'P40_COD_EMPRESA,P40_MATRICULA,P40_DT_CONSULTA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954124706415616172)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(92954124176244616167)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46935045570485026702)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB10'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68960445215395634512)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB9'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267817044810241)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB8'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267706767810240)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB7'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267637905810239)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB6'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267512436810238)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB5'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267419681810237)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB4'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267340481810236)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB3'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267171682810235)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB2'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267125269810234)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967268008286810243)
,p_event_id=>wwv_flow_api.id(92954124512243616170)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166677314483240238937)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(92954124989490616175)
,p_name=>'Disable Tabs'
,p_event_sequence=>190
,p_condition_element=>'P40_PRE_ATEND'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125101582616176)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125220124616177)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB2'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125328801616178)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB3'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125411972616179)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB4'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125482646616180)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB5'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125614163616181)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB6'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125747249616182)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB7'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92954125850148616183)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB8'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68960445152976634511)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB9'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46935045514731026701)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#TAB10'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(92967267916240810242)
,p_event_id=>wwv_flow_api.id(92954124989490616175)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166677314483240238937)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(46951475337885677763)
,p_name=>'Calcula Qtde Dias'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_DT_INICIO,P40_DT_TERMINO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(46951475426889677764)
,p_event_id=>wwv_flow_api.id(46951475337885677763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let dtInicioStr = $v(''P40_DT_INICIO'');',
'let dtTerminoStr = $v(''P40_DT_TERMINO'');',
'',
'if (dtInicioStr !== '''' && dtTerminoStr !== '''') {',
'    let pInicio = dtInicioStr.split(''/'');',
'    let pTermino = dtTerminoStr.split(''/'');',
'    ',
unistr('    // Cria as datas ignorando fuso hor\00E1rio'),
'    let dateInicio = new Date(pInicio[2], pInicio[1] - 1, pInicio[0]);',
'    let dateTermino = new Date(pTermino[2], pTermino[1] - 1, pTermino[0]);',
'    ',
unistr('    // Calcula a diferen\00E7a bruta em dias'),
'    let diferencaTempo = dateTermino.getTime() - dateInicio.getTime();',
'    let diferencaDias = Math.ceil(diferencaTempo / (1000 * 60 * 60 * 24));',
'    ',
unistr('    // Aplica a regra: diferen\00E7a + 1 dia inclusivo'),
'    let resultadoFinal = diferencaDias + 1;',
'    ',
unistr('    // Valida se o t\00E9rmino n\00E3o \00E9 menor que o in\00EDcio'),
'    if (!isNaN(diferencaDias) && diferencaDias >= 0) {',
'        apex.item(''P40_QTDE_DIAS'').setValue(resultadoFinal, null, true);',
'    } else {',
unistr('        // Se a data de t\00E9rmino for retroativa (menor que in\00EDcio), limpa o campo'),
'        apex.item(''P40_QTDE_DIAS'').setValue('''', null, true);',
'    }',
'} else {',
'    apex.item(''P40_QTDE_DIAS'').setValue('''', null, true);',
'}',
''))
,p_da_action_comment=>':P40_QTDE_DIAS := TO_DATE(:P40_DT_TERMINO,''DD/MM/RRRR'') - TO_DATE(:P40_DT_INICIO,''DD/MM/RRRR'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(35816023060378443675)
,p_name=>'Calcula Dt_Termino'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_QTDE_DIAS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35816023110719443676)
,p_event_id=>wwv_flow_api.id(35816023060378443675)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let dtInicioStr = $v(''P40_DT_INICIO'');',
'let diasStr = $v(''P40_QTDE_DIAS'');',
'let dias = parseInt(diasStr, 10);',
'',
unistr('// Garante que a quantidade de dias seja pelo menos 1 para fazer o c\00E1lculo'),
'if (dtInicioStr !== '''' && diasStr !== '''' && !isNaN(dias) && dias >= 1) {',
'    let partes = dtInicioStr.split(''/'');',
'    let data = new Date(partes[2], partes[1] - 1, partes[0]);',
'    ',
'    // Soma os dias e subtrai 1 para bater com a regra inclusiva',
'    data.setDate(data.getDate() + dias - 1);',
'    ',
'    let diaF = String(data.getDate()).padStart(2, ''0'');',
'    let mesF = String(data.getMonth() + 1).padStart(2, ''0'');',
'    let anoF = data.getFullYear();',
'    let dtTerminoStr = `${diaF}/${mesF}/${anoF}`;',
'    ',
'    apex.item(''P40_DT_TERMINO'').setValue(dtTerminoStr, null, true);',
'} else {',
'    apex.item(''P40_DT_TERMINO'').setValue('''', null, true);',
'}',
''))
,p_da_action_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P40_QTDE_DIAS = 0 THEN',
'    :P40_DT_TERMINO := :P40_DT_INICIO;',
'  ELSE',
'    :P40_DT_TERMINO := TO_DATE(:P40_DT_INICIO,''DD/MM/RRRR'') + (:P40_QTDE_DIAS-1);',
'  END IF;',
'END;',
'--TO_DATE(:P40_DT_TERMINO,''DD/MM/RRRR'') - TO_DATE(:P40_DT_INICIO,''DD/MM/RRRR'')'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14344471356162698150)
,p_name=>'Check Outras Doencas'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_IND_OUTRAS_DOENCAS'
,p_condition_element=>'P40_IND_OUTRAS_DOENCAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14344471475072698151)
,p_event_id=>wwv_flow_api.id(14344471356162698150)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#RG_DOENCAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14344471578161698152)
,p_event_id=>wwv_flow_api.id(14344471356162698150)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#RG_DOENCAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14344472019393698156)
,p_name=>'Check Uso Medicamentos'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_IND_USO_MEDICAMENTOS'
,p_condition_element=>'P40_IND_USO_MEDICAMENTOS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14344472143735698157)
,p_event_id=>wwv_flow_api.id(14344472019393698156)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#RG_USO_MED'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14344472210506698158)
,p_event_id=>wwv_flow_api.id(14344472019393698156)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#RG_USO_MED'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14345603876593806492)
,p_name=>'Habilita Desabilita Itens Gestante'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_IND_GESTANTE'
,p_condition_element=>'P40_IND_GESTANTE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345604296083806493)
,p_event_id=>wwv_flow_api.id(14345603876593806492)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_NUM_SEMANA_GESTACAO,P40_IND_TRAB_COMP_GESTLAC_OBSASO,P40_IND_PRE_NATAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345604768149806494)
,p_event_id=>wwv_flow_api.id(14345603876593806492)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_NUM_SEMANA_GESTACAO,P40_IND_TRAB_COMP_GESTLAC_OBSASO,P40_IND_PRE_NATAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345605307243806494)
,p_event_id=>wwv_flow_api.id(14345603876593806492)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_NUM_SEMANA_GESTACAO,P40_IND_TRAB_COMP_GESTLAC_OBSASO,P40_IND_PRE_NATAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14345605688991812578)
,p_name=>'Habilita Desabilita Local Pre Natal'
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_IND_PRE_NATAL'
,p_condition_element=>'P40_IND_PRE_NATAL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345606145130812578)
,p_event_id=>wwv_flow_api.id(14345605688991812578)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_IND_LOCAL_PRE_NATAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345606553429812578)
,p_event_id=>wwv_flow_api.id(14345605688991812578)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_IND_LOCAL_PRE_NATAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14345607122244812578)
,p_event_id=>wwv_flow_api.id(14345605688991812578)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P40_IND_LOCAL_PRE_NATAL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166691430715102452127)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_dt_consulta_hh consulta_medica.dt_consulta_hh%type;',
'  l_sysdate        date := sysdate;',
'',
'begin',
'  select rowid, dt_consulta_hh',
'    into :P40_ROWID, l_dt_consulta_hh',
'    from consulta_medica',
'   where cod_empresa       = :P40_COD_EMPRESA',
'     and matricula         = :P40_MATRICULA',
'     and dt_consulta       = to_date(:P40_DT_CONSULTA, ''dd/mm/yyyy'')',
'     and cod_tipo_consulta = :P40_COD_TIPO_CONSULTA;',
'exception',
'  when no_data_found then',
'    /*insert into consulta_medica (',
'      cod_empresa,',
'      matricula,',
'      dt_consulta,',
'      cod_tipo_consulta',
'    ) values (',
'      :P40_COD_EMPRESA,',
'      :P40_MATRICULA,',
'      to_date(:P40_DT_CONSULTA, ''dd/mm/yyyy''),',
'      :P40_COD_TIPO_CONSULTA',
'    ) returning rowid into :P40_ROWID;*/',
'    null;',
'  when others then',
'    null;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166677333081665238956)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from CONSULTA_MEDICA'
,p_attribute_02=>'CONSULTA_MEDICA'
,p_attribute_03=>'P40_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(92954124888589616174)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Atendimento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT ''S''',
'  INTO :P40_PRE_ATEND',
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
'   AND W.COD_EMPRESA = :P40_COD_EMPRESA',
'   AND W.DATA_AGENDA = TO_DATE(:P40_DT_CONSULTA,''DD/MM/RRRR'')',
'   AND W.COD_PACIENTE = :P40_MATRICULA;',
'EXCEPTION WHEN OTHERS THEN',
'  NULL;',
'END;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(46951478185762677792)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'RESTRICAO_ATIVIDADES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select dt_inicio, dt_termino, qtde_dias, descricao_atual, descricao_restricao',
'  into :p40_dt_inicio, :p40_dt_termino, :p40_qtde_dias, :p40_descricao_atual, :p40_descricao_restricao',
'  from RESTRICAO_ATIVIDADES ',
' where cod_restr_atividade = :P40_COD_CONS_REL_PACIENTE;',
'exception',
'  when no_data_found then',
'   null;',
'end; ',
'',
'begin',
'select a.descr_func',
'  into :P40_DESCRICAO_ATUAL',
'  from PERFIL_PROFISIOGRAFICO a,',
'       informacoes_funcionais b',
' where b.cod_empresa = a.cod_empresa',
'   and b.filial = a.cod_filial',
'   and b.cargo = a.cod_cargo',
'   and b.cod_localizacao = a.cod_local_trab',
'   and b.funcao = a.cod_funcao',
'   and b.cod_empresa = :P40_COD_EMPRESA',
'   and b.matricula = :P40_MATRICULA;',
'exception',
'  when no_data_found then',
'   null;',
'end; ',
'   '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166681527800828015220)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process CONS_REL_PACIENTE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :REQUEST = ''CREATE'' then',
'',
'        insert into cons_rel_paciente (cod_cons_rel_paciente',
'                                      ,seq_cons_rel_paciente',
'                                      ,texto',
'                                      ,usuario',
'                                      ,dt_atualizacao',
'                                      ,exame_fisico)',
'        values (:P40_COD_CONS_REL_PACIENTE',
'               ,1',
'               ,:P40_DSP_RELATO_PACIENTE',
'               ,:P40_USUARIO',
'               ,:P40_DT_ATUALIZACAO',
'               ,:P40_DSP_EXAME_FISICO);',
'',
'    elsif :REQUEST = ''SAVE'' then',
'',
'        update cons_rel_paciente',
'           set texto = :P40_DSP_RELATO_PACIENTE',
'              ,usuario = :P40_USUARIO',
'              ,dt_atualizacao = :P40_DT_ATUALIZACAO',
'              ,exame_fisico = :P40_DSP_EXAME_FISICO',
'         where cod_cons_rel_paciente = :P40_COD_CONS_REL_PACIENTE;',
'    ',
'    elsif :REQUEST = ''DELETE'' then',
'        ',
'        delete from cons_rel_paciente',
'         where cod_cons_rel_paciente = :P40_COD_CONS_REL_PACIENTE;',
'         ',
'    else',
'        null;',
'    end if;',
'    ',
'exception',
' when others then',
'  raise_application_error(-20001, SQLERRM);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166681528030834015222)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process CONS_DIAGNO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :REQUEST = ''CREATE'' then',
'',
'        insert into cons_diagno (cod_cons_diagno',
'                                ,seq_cons_diagno	',
'                                ,texto',
'                                ,usuario',
'                                ,dt_atualizacao',
'                                ,higido)',
'        values (:P40_COD_CONS_DIAGNO',
'               ,1',
'               ,:P40_DSP_DIAGNOSTICO',
'               ,:P40_USUARIO',
'               ,:P40_DT_ATUALIZACAO',
'               ,:P40_HIGIDO);',
'',
'    elsif :REQUEST = ''SAVE'' then',
'',
'        update cons_diagno',
'           set texto = :P40_DSP_DIAGNOSTICO',
'              ,usuario = :P40_USUARIO',
'              ,dt_atualizacao = :P40_DT_ATUALIZACAO',
'              ,higido = :P40_HIGIDO',
'         where cod_cons_diagno = :P40_COD_CONS_DIAGNO;',
'    ',
'    elsif :REQUEST = ''DELETE'' then',
'        ',
'        delete from cons_diagno',
'         where cod_cons_diagno = :P40_COD_CONS_DIAGNO;',
'         ',
'    else',
'        null;',
'    end if;',
'    ',
'exception',
' when others then',
'  raise_application_error(-20001, SQLERRM);',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166681528076417015223)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process POSOLOGIA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :REQUEST = ''CREATE'' then',
'',
'        insert into posologia (cod_cons_rel_posologia	',
'                              ,seq_cons_rel_posologia	',
'                              ,texto	',
'                              ,usuario	',
'                              ,dt_atualizacao	',
'                              ,conduta)',
'        values (:P40_COD_POSOLOGIA',
'               ,1',
'               ,:P40_DSP_POSOLOGIA',
'               ,:P40_USUARIO',
'               ,:P40_DT_ATUALIZACAO',
'               ,:P40_DSP_ENCAMINHAMENTO);',
'',
'    elsif :REQUEST = ''SAVE'' then',
'',
'        update posologia',
'           set texto = :P40_DSP_POSOLOGIA',
'              ,usuario = :P40_USUARIO',
'              ,dt_atualizacao = :P40_DT_ATUALIZACAO',
'              ,conduta = :P40_DSP_ENCAMINHAMENTO',
'         where cod_cons_rel_posologia = :P40_COD_POSOLOGIA;',
'    ',
'    elsif :REQUEST = ''DELETE'' then',
'        ',
'        delete from posologia',
'         where cod_cons_rel_posologia = :P40_COD_POSOLOGIA;',
'         ',
'    else',
'        null;',
'    end if;',
'    ',
'exception',
' when others then',
'  raise_application_error(-20001, SQLERRM);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166681528196143015224)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process CONS_CONDUTA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :REQUEST = ''CREATE'' then',
'',
'        insert into cons_conduta (cod_cons_conduta	',
'                                 ,seq_cons_conduta	',
'                                 ,texto	',
'                                 ,usuario	',
'                                 ,dt_atualizacao)',
'        values (:P40_COD_CONS_DIAGNO',
'               ,1',
'               ,:P40_DSP_CONDUTA',
'               ,:P40_USUARIO',
'               ,:P40_DT_ATUALIZACAO);',
'',
'    elsif :REQUEST = ''SAVE'' then',
'',
'        update cons_conduta',
'           set texto = :P40_DSP_CONDUTA',
'              ,usuario = :P40_USUARIO',
'              ,dt_atualizacao = :P40_DT_ATUALIZACAO',
'         where cod_cons_conduta = :P40_COD_CONS_DIAGNO;',
'    ',
'    elsif :REQUEST = ''DELETE'' then',
'        ',
'        delete from cons_conduta',
'         where cod_cons_conduta = :P40_COD_CONS_DIAGNO;',
'         ',
'    else',
'        null;',
'    end if;',
'    ',
'exception',
' when others then',
'  raise_application_error(-20001, SQLERRM);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(46951477540076677785)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Process RESTRICAO_ATIVIDADES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :REQUEST = ''CREATE'' then',
'',
'        insert into RESTRICAO_ATIVIDADES (cod_restr_atividade, ',
'                                         cod_empresa, ',
'                                         matricula, ',
'                                         dc_matricula, ',
'                                         cod_cargo, ',
'                                         cod_funcao, ',
'                                         cod_local_trab, ',
'                                         descricao_atual, ',
'                                         descricao_restricao, ',
'                                         qtde_dias, ',
'                                         dt_inicio, ',
'                                         dt_termino, ',
'                                         usuario, ',
'                                         dt_atualizacao,',
'                                         origem)',
'        values (:P40_COD_CONS_REL_PACIENTE, ',
'               :P40_cod_empresa, ',
'               :P40_matricula, ',
'               :P40_dc_matricula, ',
'               :P40_cod_cargo, ',
'               :P40_cod_funcao, ',
'               :P40_cod_local_trab, ',
'               :P40_descricao_atual, ',
'               :P40_descricao_restricao, ',
'               :P40_qtde_dias, ',
'               :P40_dt_inicio, ',
'               :P40_dt_termino, ',
'               :P40_USUARIO,',
'               :P40_DT_ATUALIZACAO,',
'               :p40_origem);',
'',
'    elsif :REQUEST = ''SAVE'' then',
'',
'        update RESTRICAO_ATIVIDADES',
'           set descricao_restricao = :P40_descricao_restricao',
'               ,qtde_dias = :P40_qtde_dias',
'               ,dt_inicio = :P40_dt_inicio',
'               ,dt_termino = :P40_dt_termino',
'               ,usuario = :P40_USUARIO',
'               ,dt_atualizacao = :P40_DT_ATUALIZACAO',
'               ,origem = :p40_origem',
'         where cod_restr_atividade = :P40_COD_RESTR_ATIVIDADE;',
'    ',
'    elsif :REQUEST = ''DELETE'' then',
'        ',
'        delete from RESTRICAO_ATIVIDADES',
'         where cod_restr_atividade = :P40_COD_RESTR_ATIVIDADE;',
'         ',
'         ',
'    else',
'        null;',
'    end if;',
'    ',
'exception',
' when others then',
'  raise_application_error(-20001, SQLERRM);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P40_DT_INICIO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(33009886851260600826)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Process Update Descri\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update RESTRICAO_ATIVIDADES',
'   set descricao_restricao = :P40_DESCRICAO_RESTRICAO',
'       ,usuario = :P40_USUARIO',
'       ,dt_atualizacao = :P40_DT_ATUALIZACAO',
' where cod_restr_atividade = :P40_COD_RESTR_ATIVIDADE;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(33009886705875600825)
,p_process_when=>'P40_DT_INICIO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>unistr('Altera\00E7\00F5es Salvas')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166677333481609238957)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of CONSULTA_MEDICA'
,p_attribute_02=>'CONSULTA_MEDICA'
,p_attribute_03=>'P40_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_09=>'P40_ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('A\00E7\00E3o realizada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165241982603574493023)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete func_doenca  '
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete',
'from func_doenca    ',
' where cod_cons_diagno = :P40_COD_CONS_REL_PACIENTE',
'and cod_empresa = :P40_COD_EMPRESA',
'and matricula = :P40_MATRICULA;',
'',
'commit;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166677314677751238937)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166677333896243238957)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166677314677751238937)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(114687001260066137500)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Realizou Consulta'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'update AGENDAS_MEDICOS_HORARIOS',
'   set realizou = ''S'',',
'       compareceu = ''S''',
' where rowid = :P40_ROWID_AGD;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166677314483240238937)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166677334354817238957)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(166677314483240238937)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166691431988758452140)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Values'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_sysdate date := sysdate;',
'begin',
'  :P40_DT_CONSULTA_HH_FIM := to_char(l_sysdate, ''hh24'');',
'  :P40_DT_CONSULTA_MM_FIM := to_char(l_sysdate, ''mi'');',
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
