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
,p_default_id_offset=>790116784104559759
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   20:48 Wednesday September 30, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 75
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00075
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>75);
end;
/
prompt --application/pages/page_00075
begin
wwv_flow_api.create_page(
 p_id=>75
,p_user_interface_id=>wwv_flow_api.id(176378098008189704537)
,p_name=>unistr('Pesquisar Hor\00E1rio para Encaminhamento')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Pesquisar Hor\00E1rio para Encaminhamento')
,p_autocomplete_on_off=>'OFF'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Agenda.css / Natcorp_Agenda.js)',
'',
unistr('A estrutura \00E9 toda do APEX; o .js s\00F3 reorganiza a leitura (sem classe no APEX).'),
unistr('  Campos com o nome em cima: M\00E9dico; Dia (atalhos Hoje / Amanh\00E3 / pr\00F3ximos dias \00FAteis); A partir de'),
unistr('  / At\00E9 com o seletor de hora do aparelho (type=time, hh:mm) no lugar do rel\00F3gio do plugin, e os'),
unistr('  atalhos Manh\00E3 / Tarde / Qualquer hora. "Pesquisar" = "Ver hor\00E1rios livres".'),
unistr('  O relat\00F3rio vira a lista de hor\00E1rios livres agrupada por dia; cada hor\00E1rio \00E9 um bot\00E3o que clica o'),
unistr('  link "Selecionar" da linha (o fechar devolvendo continua o da p\00E1gina).'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/AGENDA-MANUTENCAO.md.'))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Agenda.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Agenda.js'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260923105000'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(149282902863937736939)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(176378075303014704445)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(166171095400029713542)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(176378093298946704488)
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(149282903408600736943)
,p_plug_name=>unistr('Pesquisar Hor\00E1rio para Encaminhamento')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(176378071491310704441)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select   H.Cod_Empresa,',
'                    H.Cod_Prestr_Serv||'' - ''||INITCAP(P.Nome) COD_PREST_SERV,',
'                    H.Data_Agenda,',
'--                    H.Tipo_Prest_Serv,',
'                    H.Hora_Inic_Previsto,',
'                    H.COD_EMPRESA||'' - ''||INITCAP(E.NOME) EMPRESA_DSP,',
'                    H.RowId,',
'                    H.RowId link_selecionar,',
'					''<a href="javascript:apex.submit({request:''''FECHAR_DIALOG'''',''||',
'						''set:{''''P75_P_ROWID'''':''''''||H.ROWID||'''''',''''P75_P_DATA_AGENDA_DSP'''':''''''||H.Data_Agenda||',
'						'''''',''''P75_P_HORA_INI'''':''''''||to_char(H.Hora_Inic_Previsto,''HH24:MI'')||',
'						'''''',''''P75_P_HORA_TER'''':''''''||to_char(H.Hora_Fim_Previsto,''HH24:MI'')||''''''}, showWait:false});">''||',
'						''<span title="Selecionar" aria-hidden="true" class="fa fa-calendar-wrench"></span></a>'' LINKS',
'               From Agendas_Medicos_Horarios H,',
'                    Agendas_Medicos          A,',
'                    Prestador_Servico        P,',
'                    EMPRESAS_CAD E',
'              Where E.COD = H.COD_EMPRESA ',
'                AND DATA_AGENDA_ENC_MED IS NULL',
'                And A.Cod_Empresa         = H.Cod_Empresa',
'                And A.Cod_Prestr_Serv     = H.Cod_Prestr_Serv',
'                And A.Tipo_Prest_Serv     = H.Tipo_Prest_Serv',
'                And Trunc(H.Data_Agenda)  >= TRUNC(SYSDATE)',
'                And A.Data_Agenda         = H.Data_Agenda',
'                And A.Cod_Prestr_Serv     = Nvl(:P75_PRESTADOR_MEDICINA, A.Cod_Prestr_Serv)',
'                And Trunc(H.Data_Agenda)  = NVL(:P75_DATA,Trunc(H.Data_Agenda))',
'--                And To_Char(H.Hora_Inic_Previsto, ''HH24:MI'') Between  TO_DATE(REPLACE(TO_CHAR(SYSDATE-1,''DDMMRRRR'')||''00:00'','' '',''''),''DDMMRRRRHH24:MI'') -- To_Char(:P75_HORA_INICIO, ''HH24:MI'')',
'--                                                                 And To_Char(:P75_HORA_FIM, ''HH24:MI'')',
'--                And TO_DATE(REPLACE(TO_CHAR(H.Data_Agenda,''DDMMRRRR'')||To_Char(H.Hora_Inic_Previsto, ''HH24:MI''),'' '',''''),''DDMMRRRRHH24:MI'') ',
'----                And TO_DATE(REPLACE(TO_CHAR(H.Data_Agenda,''DDMMRRRR'')||NVL(:P75_HORA_INICIO,''00:00''),'' '',''''),''DDMMRRRRHH24:MI'') ',
'                  and h.hora_inic_previsto   Between  TO_DATE(REPLACE(TO_CHAR(H.Data_Agenda,''DDMMRRRR'')||NVL(:P75_HORA_INICIO,''00:00''),'' '',''''),''DDMMRRRRHH24:MI'')',
'                     And TO_DATE(REPLACE(TO_CHAR(H.Data_Agenda,''DDMMRRRR'')||NVL(:P75_HORA_FIM,''23:59''),'' '',''''),''DDMMRRRRHH24:MI'')',
'                     AND H.HORA_INIC_PREVISTO > SYSDATE ',
'                And H.Cod_Paciente       Is Null',
'                And H.Bloqueado           = ''N''',
'                And H.Atende_Area_Selecao = ''S''',
'                And H.cod_empresa         = :P75_COD_EMPRESA_AUX',
'                And P.Cod_Prest_Serv      = H.Cod_Prestr_Serv',
'                And P.Tipo_Prest_Serv     = ''1''',
'                And EXISTS (',
'                          SELECT 1 ',
'                          FROM PREST_SERV_ENTIDADE PE',
'                          WHERE PE.COD_PREST_SERV = H.Cod_Prestr_Serv',
'                            AND PE.COD_DIA_SEM = TO_CHAR(H.Data_Agenda, ''D'') -- Verifica o dia da semana',
unistr('                            AND TO_CHAR(H.Hora_Inic_Previsto, ''HH24MI'') >= PE.HOR_ENTRADA -- Verifica se a hora inicial \00E9 maior ou igual \00E0 permitida'),
unistr('                            AND TO_CHAR(H.Hora_Fim_Previsto, ''HH24MI'') <= PE.HOR_SAIDA -- Verifica se a hora final \00E9 menor ou igual \00E0 permitida'),
'                            )',
'',
'  /* AND EXISTS (',
'      SELECT 1 ',
'      FROM PREST_SERV_ENTIDADE PE',
'      WHERE PE.COD_PREST_SERV = H.Cod_Prestr_Serv',
'        AND PE.COD_DIA_SEM = TO_CHAR(H.Data_Agenda, ''D'') -- Verifica o dia da semana',
'        AND TO_CHAR(H.Hora_Inic_Previsto, ''HH24MI'') BETWEEN PE.HOR_ENTRADA AND PE.HOR_SAIDA',
'  )*/',
'              Order By H.Data_Agenda, H.Hora_Inic_Previsto, A.Cod_Prestr_Serv'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P75_COD_EMPRESA_AUX,P75_HORA_INICIO,P75_HORA_FIM,P75_DATA,P75_PRESTADOR_MEDICINA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(149282903512803736943)
,p_name=>unistr('Pesquisar Hor\00E1rio para Encaminhamento')
,p_max_row_count_message=>unistr('A contagem m\00E1xima de linhas deste relat\00F3rio \00E9 #MAX_ROW_COUNT# linhas. Aplique um filtro para reduzir o n\00FAmero de registros em sua consulta.')
,p_no_data_found_message=>unistr('Dados n\00E3o encontrados.')
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_actions_menu=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'CIBELE.CRISTINA'
,p_internal_uid=>1846590507113651766
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149282903981268736947)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149281261995358406727)
,p_db_column_name=>'EMPRESA_DSP'
,p_display_order=>11
,p_column_identifier=>'H'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149282904764808736949)
,p_db_column_name=>'DATA_AGENDA'
,p_display_order=>21
,p_column_identifier=>'C'
,p_column_label=>'Data Agenda'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149282905164512736949)
,p_db_column_name=>'HORA_INIC_PREVISTO'
,p_display_order=>31
,p_column_identifier=>'D'
,p_column_label=>unistr('Hor\00E1rio')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'HH24:MI'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149282904322750736949)
,p_db_column_name=>'COD_PREST_SERV'
,p_display_order=>41
,p_column_identifier=>'B'
,p_column_label=>unistr('M\00E9dico')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149283109023595525882)
,p_db_column_name=>'LINKS'
,p_display_order=>51
,p_column_identifier=>'G'
,p_column_label=>'Selecionar'
,p_column_type=>'STRING'
,p_display_text_as=>'WITHOUT_MODIFICATION'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149282905521155736949)
,p_db_column_name=>'ROWID'
,p_display_order=>61
,p_column_identifier=>'E'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(149281259913620406707)
,p_db_column_name=>'LINK_SELECIONAR'
,p_display_order=>71
,p_column_identifier=>'F'
,p_column_label=>'Link Selecionar'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(149282906901130780805)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'18465939'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_EMPRESA:COD_PREST_SERV:DATA_AGENDA:HORA_INIC_PREVISTO:ROWID:LINK_SELECIONAR:LINKS:EMPRESA_DSP'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(149281261631874406724)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(149282903408600736943)
,p_button_name=>'BT_PESQUISAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
,p_grid_column=>6
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(18601933827382844291)
,p_name=>'P75_PRESTADOR_MEDICINA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_prompt=>unistr('M\00E9dico')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    PS.Cod_Prest_Serv || '' - '' || INITCAP(PS.Nome) AS D, ',
'    PS.Cod_Prest_Serv AS C',
'FROM Prestador_Servico PS',
'WHERE PS.Tipo_Prest_Serv = ''1''',
'  AND PS.Dt_Vigencia_Fin > SYSDATE',
'  AND EXISTS (',
'      SELECT 1 ',
'      FROM Prest_Serv_Entidade E',
'      WHERE E.Cod_Prest_Serv = PS.Cod_Prest_Serv',
'        AND E.Atende_Area_Selecao = ''S''',
'  )',
'  AND EXISTS (',
'      SELECT 1',
'      FROM Agendas_Medicos_Horarios H',
'      JOIN Agendas_Medicos A ',
'        ON A.Cod_Empresa       = H.Cod_Empresa',
'       AND A.Cod_Prestr_Serv   = H.Cod_Prestr_Serv',
'       AND A.Tipo_Prest_Serv   = H.Tipo_Prest_Serv',
'       AND A.Data_Agenda       = H.Data_Agenda',
'      WHERE H.Cod_Prestr_Serv       = PS.Cod_Prest_Serv',
'        AND H.Tipo_Prest_Serv       = ''1''',
'        AND H.DATA_AGENDA_ENC_MED   IS NULL',
'        AND H.Data_Agenda          >= TRUNC(SYSDATE)',
'        AND H.Cod_Paciente         IS NULL',
'        AND H.Bloqueado             = ''N''',
'        AND H.Atende_Area_Selecao   = ''S''',
'  )',
'ORDER BY ',
'    PS.Nome;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141868510169967943140)
,p_name=>'P75_COD_EMPRESA_AUX'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281259676293406704)
,p_name=>'P75_REQ_EXAME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281260259305406710)
,p_name=>'P75_DATA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_prompt=>'Data'
,p_display_as=>'PLUGIN_COM.PLANETAPEX.DYNAMICDATETIMEPICKER'
,p_cSize=>30
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'1'
,p_attribute_03=>'0'
,p_attribute_04=>'6:0'
,p_attribute_08=>'clickicon'
,p_attribute_11=>'N'
,p_attribute_12=>'Bottom Left'
,p_attribute_14=>'3:4:5:6:7:8:9:10:11'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281260399540406711)
,p_name=>'P75_HORA_INICIO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_prompt=>'Hora Inicial'
,p_format_mask=>'HH24:MI'
,p_display_as=>'PLUGIN_COM.PLANETAPEX.DYNAMICDATETIMEPICKER'
,p_cSize=>5
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'10'
,p_attribute_03=>'0'
,p_attribute_04=>'6:0'
,p_attribute_07=>'00:00,23:59'
,p_attribute_08=>'clickicon'
,p_attribute_10=>':'
,p_attribute_11=>'Y'
,p_attribute_12=>'Bottom Left'
,p_attribute_14=>'3:4:5:6:7:8:9:10:11'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281261456823406722)
,p_name=>'P75_HORA_FIM'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(160031990433293395231)
,p_prompt=>'Hora Final'
,p_format_mask=>'HH24:MI'
,p_display_as=>'PLUGIN_COM.PLANETAPEX.DYNAMICDATETIMEPICKER'
,p_cSize=>5
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'10'
,p_attribute_03=>'0'
,p_attribute_04=>'6:0'
,p_attribute_07=>'00:00,23:59'
,p_attribute_08=>'clickicon'
,p_attribute_10=>':'
,p_attribute_11=>'Y'
,p_attribute_12=>'Bottom Left'
,p_attribute_14=>'3:4:5:6:7:8:9:10:11'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149283109120861525883)
,p_name=>'P75_P_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(149282903408600736943)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149283109260188525884)
,p_name=>'P75_P_DATA_AGENDA_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(149282903408600736943)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149283109752228525889)
,p_name=>'P75_P_HORA_INI'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(149282903408600736943)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149283109845113525890)
,p_name=>'P75_P_HORA_TER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(149282903408600736943)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(149284607179400831307)
,p_validation_name=>'Valida Data'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P75_DATA < TRUNC(SYSDATE) THEN',
unistr('  RETURN(''A data n\00E3o pode ser menor que a data atual.'');'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(149281260259305406710)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149281261738364406725)
,p_name=>'Dispara consulta'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(149281261631874406724)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149281261813396406726)
,p_event_id=>wwv_flow_api.id(149281261738364406725)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(149283109351522525885)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Novo'
,p_attribute_01=>'P75_P_DATA_AGENDA_DSP,P75_P_ROWID,P75_P_HORA_INI,P75_P_HORA_TER'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'FECHAR_DIALOG'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
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
