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
--   Date and Time:   23:19 Tuesday October 13, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 39
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00039
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>39);
end;
/
prompt --application/pages/page_00039
begin
wwv_flow_api.create_page(
 p_id=>39
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Pesquisa Consulta M\00E9dica')
,p_step_title=>unistr('Pesquisa Consulta M\00E9dica')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'365785'
,p_last_upd_yyyymmddhh24miss=>'20261013231943'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166675612840447889058)
,p_plug_name=>unistr('Dados Consulta M\00E9dica')
,p_icon_css_classes=>'fa-plus-square-o'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921841000262886869)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>unistr('<p>Cadastro Consulta M\00E9dica</p>')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166677334993202238958)
,p_plug_name=>unistr('Consulta M\00E9dica')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842055309886870)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cm.rowid,',
'       cm.cod_empresa cod_empresa,    ',
'	   --f.matricula || ''-'' ||f.dc_matricula matricula,',
'	   f.matricula matricula,       ',
'	   ip.nome,		',
'       trunc(months_between(sysdate, ip.dt_nasc) / 12) idade,',
'	   cm.dt_consulta dt_consulta,',
'       cm.cod_tipo_consulta tipo_consulta,',
'       t.descricao descricao_consulta,',
'	   cm.dt_consulta_hh ,',
'	   cm.dt_consulta_mm dt_consulta_mm,',
'	   cm.cod_entidade cod_entidade,',
'	   cm.cod_especialidade cod_especialidade,',
'	   cm.dt_consulta_hh_fim dt_consulta_hh_fim,',
'	   cm.dt_consulta_mm_fim dt_consulta_mm_fim,',
'     ps.cod_prest_serv||'' - ''||initcap(ps.nome) atendente',
'  from consulta_medica cm,',
'	   inf_pessoais_cad ip,',
'       informacoes_funcionais_cad f,',
'       prestador_servico ps,',
'       tipo_consulta t',
' where ip.cod_empresa = cm.cod_empresa',
'   and ip.cod_empresa = f.cod_empresa',
'   and ip.matricula = cm.matricula',
'   and ip.matricula = f.matricula  ',
'   and cm.cod_prest_serv = ps.cod_prest_serv',
'   and cm.tipo_prest_serv = ''1'' ',
'   and cm.tipo_entidade = ''1'' ',
'   and ps.tipo_prest_serv = ''1''',
'   and cm.cod_tipo_consulta = t.cod_tipo_consulta',
'   and f_acesso(f.cod_empresa, f.matricula, f.filial, f.cd_nivel) = ''S''',
'order by cod_cons_rel_paciente desc, cm.dt_consulta desc, cm.cod_empresa, cm.matricula'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(166677335436195238959)
,p_name=>'Report 1'
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:40:P40_ROWID:#ROWID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="Edit">'
,p_owner=>'LUIZ_OLIVEIRA'
,p_internal_uid=>656484276566984140
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166675609986030889030)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'M'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677335891072238960)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166659783712256520523)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166678118037748665050)
,p_db_column_name=>'NOME'
,p_display_order=>40
,p_column_identifier=>'O'
,p_column_label=>'Nome'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166678118077367665051)
,p_db_column_name=>'IDADE'
,p_display_order=>50
,p_column_identifier=>'P'
,p_column_label=>'Idade'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677337074539238961)
,p_db_column_name=>'DT_CONSULTA'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Data da Consulta'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166678118169369665052)
,p_db_column_name=>'TIPO_CONSULTA'
,p_display_order=>70
,p_column_identifier=>'Q'
,p_column_label=>'Tipo Consulta'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_rpt_named_lov=>wwv_flow_api.id(166664142566967702592)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677338265109238962)
,p_db_column_name=>'COD_ENTIDADE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Entidade'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(166677349902878301371)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677338716824238963)
,p_db_column_name=>'COD_ESPECIALIDADE'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Especialidade'
,p_column_type=>'STRING'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(166677381386316412619)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677337470709238962)
,p_db_column_name=>'DT_CONSULTA_HH'
,p_display_order=>100
,p_column_identifier=>'F'
,p_column_label=>'Dt Consulta Hh'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677337876543238962)
,p_db_column_name=>'DT_CONSULTA_MM'
,p_display_order=>110
,p_column_identifier=>'G'
,p_column_label=>'Dt Consulta Mm'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677339111200238963)
,p_db_column_name=>'DT_CONSULTA_HH_FIM'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Dt Consulta Hh Fim'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166677339479662238963)
,p_db_column_name=>'DT_CONSULTA_MM_FIM'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Dt Consulta Mm Fim'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(166678119433558665064)
,p_db_column_name=>'MATRICULA'
,p_display_order=>140
,p_column_identifier=>'R'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(798585556408873005)
,p_db_column_name=>'ATENDENTE'
,p_display_order=>150
,p_column_identifier=>'S'
,p_column_label=>'Atendente'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(798585682982873006)
,p_db_column_name=>'DESCRICAO_CONSULTA'
,p_display_order=>160
,p_column_identifier=>'T'
,p_column_label=>'Descricao Consulta'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(166677343280292241211)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'6564922'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:MATRICULA:NOME:IDADE:DT_CONSULTA:TIPO_CONSULTA:ATENDENTE:'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166677340819023238964)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(166677334993202238958)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:40:&SESSION.::&DEBUG.:40'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166677339928459238964)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(166677334993202238958)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166677340408213238964)
,p_event_id=>wwv_flow_api.id(166677339928459238964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166677334993202238958)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166677341218435238965)
,p_name=>'Create Button - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166677340819023238964)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166677341692745238965)
,p_event_id=>wwv_flow_api.id(166677341218435238965)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166677334993202238958)
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
