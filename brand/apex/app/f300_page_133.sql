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
--   Date and Time:   17:37 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 133
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00133
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>133);
end;
/
prompt --application/pages/page_00133
begin
wwv_flow_api.create_page(
 p_id=>133
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>unistr('Altera\00E7\00E3o de Endere\00E7o')
,p_step_title=>unistr('Altera\00E7\00E3o de Endere\00E7o')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Consulta.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Consulta.css'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Consulta.css / Natcorp_Consulta.js) - o motor das consultas do Portal',
'',
'Os pedidos em cartoes, para o colaborador no celular: cartao curto do colaborador, o botao de criar (o original,',
'com as acoes dele) em destaque, cada linha do relatorio como um cartao (Pedido N, a situacao com a cor do sistema,',
'feito em, quem pediu, os outros dados com o titulo da coluna, Ver pedido). Com coluna de situacao: botoes por',
'situacao e cancelados/reprovados guardados. "Ver como tabela" mostra o relatorio original com as ferramentas.',
'Os dados sao lidos do relatorio pelo titulo das colunas; textos da pagina na RECEITA do Natcorp_Consulta.src.js.',
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/CONSULTA-MANUTENCAO.md.'))
,p_last_upd_yyyymmddhh24miss=>'20241105164117'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156091309638706726229)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P133_MAT'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156091313692152726234)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Altera\00E7\00E3o de Endere\00E7o')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492016720374058578)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  SELECT cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa)) Empresa_Colaborador, matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) colaborador, cod_req, data_solicitacao, COD_EMP_SOLICITANTE||'' - ''||initcap(fnct_nome_empresa('
||'COD_EMP_SOLICITANTE)) Empresa_Solicitante, mat_solicitante||'' - ''||initcap(fnct_nome_func(COD_EMP_SOLICITANTE, mat_solicitante)) Solicitante, cod_empresa, matricula',
'  FROM INF_PESSOAIS_PORTAL A',
'  WHERE A.COD_EMPRESA = nvl(:p133_emp,a.cod_empresa)',
'  AND   A.MATRICULA   = nvl(:P133_mat, a.matricula)',
'  and (a.cod_empresa, a.matricula) in (select x.cod_empresa, x.matricula from informacoes_funcionais_cad x where x.cod_empresa = a.cod_empresa and x.matricula = a.matricula and F_Acesso_PG_Apex(x.cod_empresa, x.matricula, x.filial, x.cd_nivel, :p_usu'
||'ario, :p_painel) = ''S'')',
'  ORDER BY a.cod_req desc'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(156091314086050726235)
,p_name=>unistr('Requisi\00E7\00E3o de Pessoal')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_allow_report_categories=>'N'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_calendar=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:134:&SESSION.::&DEBUG.:134:P134_COD_EMPRESA,P134_MATRICULA:#COD_EMPRESA#,#MATRICULA#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#e2.gif"  border="0">'
,p_owner=>'IGOR'
,p_internal_uid=>13750894440982323133
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475462014521899816)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>90
,p_column_identifier=>'CD'
,p_column_label=>'Cod empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475462367372899817)
,p_db_column_name=>'MATRICULA'
,p_display_order=>100
,p_column_identifier=>'CE'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475462769040899817)
,p_db_column_name=>'EMPRESA_COLABORADOR'
,p_display_order=>110
,p_column_identifier=>'CF'
,p_column_label=>'Empresa Colaborador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475463223929899818)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>120
,p_column_identifier=>'CG'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475461329262899815)
,p_db_column_name=>'COD_REQ'
,p_display_order=>130
,p_column_identifier=>'CH'
,p_column_label=>unistr('Requisi\00E7\00E3o')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475461589931899816)
,p_db_column_name=>'DATA_SOLICITACAO'
,p_display_order=>140
,p_column_identifier=>'CI'
,p_column_label=>unistr('Data de Solicita\00E7\00E3o')
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475463606855899818)
,p_db_column_name=>'EMPRESA_SOLICITANTE'
,p_display_order=>150
,p_column_identifier=>'CJ'
,p_column_label=>'Empresa Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(143475463970249899818)
,p_db_column_name=>'SOLICITANTE'
,p_display_order=>160
,p_column_identifier=>'CK'
,p_column_label=>'Solicitante'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(156091318916717726243)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'11350447'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'COD_REQ:DATA_SOLICITACAO:EMPRESA_COLABORADOR:COLABORADOR:EMPRESA_SOLICITANTE:SOLICITANTE:'
,p_sort_column_1=>'COD_REQ'
,p_sort_direction_1=>'DESC'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(156091993062990823557)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(145393053751274394435)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(145492038528010058625)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475466952521899826)
,p_button_sequence=>540
,p_button_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_button_name=>'p133_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P133_EMP.,&P133_MAT.,&P133_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(143475464808199899820)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(156091313692152726234)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:134:&SESSION.::&DEBUG.:RP,134:P134_COD_EMPRESA,P134_MATRICULA,P134_COD_EMP_SOLICITANTE,P134_MAT_SOLICITANTE:&P133_EMP.,&P133_MAT.,&P_EMPRESA_USER.,&P_MATRICULA_USER.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475465211079899822)
,p_name=>'P133_FLAG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(156091313692152726234)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475465578826899824)
,p_name=>'P133_MENSAGEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(156091313692152726234)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475466007752899825)
,p_name=>'P133_OK'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(156091313692152726234)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475467316770899827)
,p_name=>'P133_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(foto)',
'                              from fotos',
'                             where cod_empresa = :p133_emp',
'                               and matricula   = :p133_mat), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P133_EMP || ''|'' || :P133_MAT',
'               --apex_util.prepare_url(''f?p=&APP_ID.:9999:&APP_SESSION.:APPLICATION_PROCESS=GET_IMG_FUNC:&DEBUG.&x01='' || :p13_emp || ''&x02='' || :p13_mat)',
'             else',
'               ''#WORKSPACE_IMAGES#PROFILE.jpg''',
'             end foto',
'from dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_colspan=>2
,p_grid_column=>1
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475467705034899827)
,p_name=>'P133_COD_EMPRESA1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
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
 p_id=>wwv_flow_api.id(143475468056205899827)
,p_name=>'P133_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
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
 p_id=>wwv_flow_api.id(143475468482898899828)
,p_name=>'P133_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475468884444899828)
,p_name=>'P133_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475469255869899829)
,p_name=>'P133_EMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475469650896899829)
,p_name=>'P133_MAT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475470123768899829)
,p_name=>'P133_CHAMADOR'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(156091309638706726229)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143475471097492899832)
,p_name=>'P133_ITEM_VALIDACAO_1'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475471880819899833)
,p_name=>'Dispara Alerta'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P133_MENSAGEM'
,p_condition_element=>'P133_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475472421269899835)
,p_event_id=>wwv_flow_api.id(143475471880819899833)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P133_FLAG'').value == "Q") {',
'alertify.confirm($v(''P133_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P133_FLAG'').value = ''S'';',
'        $x(''P133_MENSAGEM'').value = '''';',
'        $x(''P133_OK'').value = ''S'';',
'        $(''#P133_CREATE'').show();',
'    } else {',
'        $x(''P133_OK'').value = ''N'';',
'        $(''#P133_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P133_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P133_FLAG'').value == "N") {',
'            $(''#P133_CREATE'').hide();',
'        } else {',
'            $(''#P133_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P133_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143475472837475899836)
,p_name=>'Carrega Plugin'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143475473313177899836)
,p_event_id=>wwv_flow_api.id(143475472837475899836)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143475471499036899832)
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
'       i.dt_admissao',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p133_emp',
'   and i.matricula = :p133_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p133_cod_empresa1 := v_c1.empresa;',
':p133_matricula := v_c1.matricula;',
':p133_situacao := v_c1.situacao;',
':p133_dt_admissao := v_c1.dt_admissao;',
'',
':p133_OK := ''S'';',
'',
'exception',
'when others then',
':p133_cod_empresa := :P_EMPRESA_USER;',
':p133_matricula := :P_MATRICULA_USER;',
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
