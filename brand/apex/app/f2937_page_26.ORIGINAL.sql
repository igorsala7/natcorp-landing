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
--   Date and Time:   15:34 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 26
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00026
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>26);
end;
/
prompt --application/pages/page_00026
begin
wwv_flow_api.create_page(
 p_id=>26
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>'Consulta Matricula'
,p_page_mode=>'MODAL'
,p_step_title=>'Consulta Matricula'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_last_upd_yyyymmddhh24miss=>'20200909113732'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166680575581239215254)
,p_plug_name=>unistr('Par\00E2metros de Pesquisa')
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
 p_id=>wwv_flow_api.id(166680576241247215260)
,p_plug_name=>unistr('Hor\00E1rios')
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select data_agenda',
'      ,to_char(hora_inic_previsto,''hh24:mi'') hora_inic_previsto',
'      ,to_char(hora_fim_previsto,''hh24:mi'') hora_fim_previsto',
'      ,(select cod_prestr_serv || '' - '' || c.nome',
'          from prestador_servico c',
'         where c.cod_prest_serv = cod_prestr_serv',
'           and tipo_prest_serv = ''1'') cod_prestr_serv',
'      ,cod_tipo_consulta',
unistr('      ,decode(compareceu,''S'',''Sim'',''N'',''N\00E3o'') compareceu'),
unistr('      ,decode(realizou,''S'',''Sim'',''N'',''N\00E3o'') realizou'),
'      ,to_char(hora_inicio_consulta,''hh24:mi'') hora_inicio_consulta',
'      ,to_char(hora_fim_consulta,''hh24:mi'') hora_fim_consulta',
'      ,to_char(hora_chegada,''hh24:mi'') hora_chegada',
'  from agendas_medicos_horarios',
' where cod_empresa = :P26_COD_EMPRESA',
'   and tipo_paciente = :P26_TIPO_PACIENTE',
'   and cod_paciente = :P26_COD_PACIENTE',
' order by data_agenda desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P26_COD_EMPRESA,P26_TIPO_PACIENTE,P26_COD_PACIENTE'
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
 p_id=>wwv_flow_api.id(166680576362218215262)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'RAFAEL_GEBARA'
,p_internal_uid=>659725202589960443
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680576535252215263)
,p_db_column_name=>'DATA_AGENDA'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Data'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680576779053215266)
,p_db_column_name=>'COD_PRESTR_SERV'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Profissional'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680576885301215267)
,p_db_column_name=>'COD_TIPO_CONSULTA'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Tipo Consulta'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166664142566967702592)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680577009485215268)
,p_db_column_name=>'COMPARECEU'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Compareceu'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680577144564215269)
,p_db_column_name=>'REALIZOU'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Realizou'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680787309572024625)
,p_db_column_name=>'HORA_INIC_PREVISTO'
,p_display_order=>80
,p_column_identifier=>'K'
,p_column_label=>unistr('Hr. In\00EDcio Previsto')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680787416185024626)
,p_db_column_name=>'HORA_FIM_PREVISTO'
,p_display_order=>90
,p_column_identifier=>'L'
,p_column_label=>'Hr. Fim Previsto'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680787477374024627)
,p_db_column_name=>'HORA_INICIO_CONSULTA'
,p_display_order=>100
,p_column_identifier=>'M'
,p_column_label=>unistr('Hr. In\00EDcio Real')
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680787626699024628)
,p_db_column_name=>'HORA_FIM_CONSULTA'
,p_display_order=>110
,p_column_identifier=>'N'
,p_column_label=>'Hr. Fim Real'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166680787718952024629)
,p_db_column_name=>'HORA_CHEGADA'
,p_display_order=>120
,p_column_identifier=>'O'
,p_column_label=>'Hora Chegada'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(166680800271641048816)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6599492'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'DATA_AGENDA:HORA_INIC_PREVISTO:HORA_FIM_PREVISTO:COD_PRESTR_SERV:COD_TIPO_CONSULTA:COMPARECEU:REALIZOU:HORA_INICIO_CONSULTA:HORA_FIM_CONSULTA:HORA_CHEGADA:'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680575718413215255)
,p_name=>'P26_COD_EMPRESA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166680575581239215254)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680575822211215256)
,p_name=>'P26_TIPO_PACIENTE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166680575581239215254)
,p_prompt=>'Tipo Paciente'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Funcion\00E1rio;1,Candidato;2')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680575905810215257)
,p_name=>'P26_COD_PACIENTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166680575581239215254)
,p_prompt=>'Paciente'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula || '' - '' || p.nome d,',
'       p.matricula r',
'  from inf_pessoais p,',
'       informacoes_funcionais f',
' where f.cod_empresa = p.cod_empresa',
'   and f.matricula   = p.matricula',
'   and f.situacao    < ''90''',
'   and p.cod_empresa = :P26_COD_EMPRESA',
'   and :P26_TIPO_PACIENTE = 1',
' union all',
'select c.cod_candidato || '' - '' || c.nome d,',
'       c.cod_candidato r',
'  from inf_pessoais_candidato c',
' where c.empresa          = :P26_COD_EMPRESA',
'   and c.status_candidato = ''P''',
'   and :P26_TIPO_PACIENTE = 2',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P26_COD_EMPRESA,P26_TIPO_PACIENTE'
,p_ajax_items_to_submit=>'P26_COD_EMPRESA,P26_TIPO_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166680575976467215258)
,p_name=>'P26_DATA_INICIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166680575581239215254)
,p_prompt=>'Data Inicial'
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
 p_id=>wwv_flow_api.id(166680576079216215259)
,p_name=>'P26_DATA_FINAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166680575581239215254)
,p_prompt=>'Data final'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166680787115413024623)
,p_name=>unistr('Atualiza informa\00E7\00F5es')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P26_DATA_FINAL,P26_DATA_INICIAL,P26_COD_PACIENTE,P26_COD_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166680787175547024624)
,p_event_id=>wwv_flow_api.id(166680787115413024623)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166680576241247215260)
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
