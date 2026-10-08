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
--   Date and Time:   18:35 Friday October 2, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 108
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00108
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>108);
end;
/
prompt --application/pages/page_00108
begin
wwv_flow_api.create_page(
 p_id=>108
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>'Linha do Tempo'
,p_step_title=>'Linha do Tempo'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LinhaTempo.css'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_LinhaTempo.css / Natcorp_LinhaTempo.js)',
'',
unistr('No alto do relat\00F3rio, um seletor com tr\00EAs jeitos de ver os mesmos fatos:'),
'  Tabela      o Interactive Report de sempre;',
unistr('  Trajet\00F3ria  um Gantt: uma faixa por assunto (contrato e lota\00E7\00E3o, remunera\00E7\00E3o, f\00E9rias e'),
unistr('              sa\00FAde, desenvolvimento, ponto), cada fato uma barra do come\00E7o ao fim, a r\00E9gua'),
'              dos anos, o "hoje" e o zoom; tocar numa barra mostra os detalhes;',
unistr('  Cronologia  os fatos por ano, com filtros por assunto; o ponto resumido por m\00EAs.'),
unistr('Os dados v\00EAm do processo Ajax Callback NC_LINHA_TEMPO_DADOS desta p\00E1gina: a mesma consulta do'),
unistr('relat\00F3rio (vw_linha_do_tempo), o filtro Fato, a checagem f_acesso_pg_apex e o sal\00E1rio s\00F3 para quem'),
unistr('pode ver (FNCT_TRATA_VERIF_SAL_NIVEL, no servidor). O plugin Linha do Tempo n\00E3o \00E9 mais necess\00E1rio.'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/LINHATEMPO-MANUTENCAO.md.'))
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261002183439'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378732727873829615)
,p_plug_name=>'Colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378735571854829619)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281417152242908913695)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378735951684829620)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'Y'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281378738314631829623)
,p_plug_name=>unistr('Relat\00F3rio')
,p_parent_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492405269346640)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa||'' - ''||initcap(nome_empresa) Empresa,',
'       filial||'' - ''||initcap(nome_filial) Filial,',
'       cod_ccusto||'' - ''||initcap(nome_ccusto) CCusto,',
'       matricula||'' - ''||initcap(nome) Colaborador,',
unistr('       situacao||'' - ''||initcap(nome_situacao) Situa\00E7\00E3o,'),
unistr('       vinculo||'' - ''||initcap(nome_vinculo) V\00EDnculo,'),
'       fato Fato,',
unistr('       case when upper(Fato) NOT IN (''SAL\00C1RIO'',''SALARIO'') then '),
'                 case when cod_valor_fato is not null then decode(cod_valor_fato,''0'','' '',cod_valor_fato||'' - '')||valor_fato else valor_fato end',
unistr('            when upper(Fato) IN (''SAL\00C1RIO'',''SALARIO'') and NVL(:P108_VISUALIZA_SAL,''N'') = ''S'' then'),
'                 valor_fato',
unistr('       end Descri\00E7\00E3o,'),
'       data_ini Data_Inicial,',
'       data_fim Data_Final,',
'       initcap(motivo_movto) Motivo       ',
'  from vw_linha_do_tempo',
' where cod_empresa = :p108_emp',
'   and matricula = :p108_mat',
'   and ((instr('':''||:p108_fato||'':'','':''||fato||'':'') > 0) or (:p108_fato is null))',
'   and f_acesso_pg_apex(cod_empresa, matricula, filial, cd_nivel, :p_usuario) = ''S''',
' order by cod_empresa, matricula, data_ini, fato'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P108_VISUALIZA_SAL,P108_FATO,P108_EMP,P108_MAT'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(281378738773088829623)
,p_name=>unistr('Hist\00F3rico Cadastral')
,p_max_row_count=>'1000000'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'IGOR'
,p_internal_uid=>46084581014384101
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378738812732829623)
,p_db_column_name=>'EMPRESA'
,p_display_order=>10
,p_column_identifier=>'K'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378739209130829625)
,p_db_column_name=>'FILIAL'
,p_display_order=>20
,p_column_identifier=>'L'
,p_column_label=>'Filial'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378739602730829625)
,p_db_column_name=>'CCUSTO'
,p_display_order=>30
,p_column_identifier=>'M'
,p_column_label=>'Ccusto'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378740032689829626)
,p_db_column_name=>'COLABORADOR'
,p_display_order=>40
,p_column_identifier=>'N'
,p_column_label=>'Colaborador'
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378740392249829626)
,p_db_column_name=>unistr('SITUA\00C7\00C3O')
,p_display_order=>50
,p_column_identifier=>'O'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378740877899829627)
,p_db_column_name=>unistr('V\00CDNCULO')
,p_display_order=>60
,p_column_identifier=>'P'
,p_column_label=>unistr('V\00EDnculo')
,p_column_type=>'STRING'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_display_condition=>'P108_MAT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378741242866829627)
,p_db_column_name=>'FATO'
,p_display_order=>70
,p_column_identifier=>'Q'
,p_column_label=>'Fato'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378741601341829627)
,p_db_column_name=>unistr('DESCRI\00C7\00C3O')
,p_display_order=>80
,p_column_identifier=>'R'
,p_column_label=>unistr('Descri\00E7\00E3o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378742026935829628)
,p_db_column_name=>'DATA_INICIAL'
,p_display_order=>90
,p_column_identifier=>'S'
,p_column_label=>'Data inicial'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378742448672829628)
,p_db_column_name=>'DATA_FINAL'
,p_display_order=>100
,p_column_identifier=>'T'
,p_column_label=>'Data final'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(281378742841125829629)
,p_db_column_name=>'MOTIVO'
,p_display_order=>110
,p_column_identifier=>'U'
,p_column_label=>'Motivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(281378743221510829629)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'460891'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>unistr('COD_MATRICULA:COD_DESC_COD_VALOR_VALOR_MOT_ALT:EMPRESA:FILIAL:CCUSTO:COLABORADOR:SITUA\00C7\00C3O:V\00CDNCULO:FATO:DESCRI\00C7\00C3O:DATA_INICIAL:DATA_FINAL:MOTIVO')
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281378736369401829620)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_button_name=>'p108_filtrar'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--padLeft'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Filtrar'
,p_button_position=>'BODY'
,p_icon_css_classes=>'fa-filter'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281378733170261829615)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281378732727873829615)
,p_button_name=>'p108_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT,P13_CHAMADOR:&P108_EMP.,&P108_MAT.,&P108_CHAMADOR.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(278901603872414941478)
,p_name=>'P108_VISUALIZA_SAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378733587445829616)
,p_name=>'P108_FOTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281378732727873829615)
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'case when nvl((select dbms_lob.getlength(f.foto)',
'                 from fotos f',
'                where cod_empresa = :P108_EMP',
'                  and matricula   = :P108_MAT',
'                  ), 0) > 0 then',
'             ''f?p='' || :APP_ID || '':'' || 1 || '':'' || :APP_SESSION ||',
'               '':APPLICATION_PROCESS=GET_IMG_FUNC:'' || :DEBUG ||',
'               ''&x01='' || :P108_EMP || ''|'' || :P108_MAT',
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
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'URL'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378733901381829617)
,p_name=>'P108_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281378732727873829615)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column=>3
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
 p_id=>wwv_flow_api.id(281378734327497829617)
,p_name=>'P108_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281378732727873829615)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378734755329829618)
,p_name=>'P108_MATRICULA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281378732727873829615)
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
 p_id=>wwv_flow_api.id(281378735139764829618)
,p_name=>'P108_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281378732727873829615)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378736724590829620)
,p_name=>'P108_FATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_prompt=>'Fato'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(fato) descricao, fato cod  ',
'  from vw_linha_do_tempo',
' where cod_empresa = :p108_emp',
'   and matricula = :p108_mat',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'MULTI'
,p_attribute_08=>'CIC'
,p_attribute_10=>'250'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378737169509829622)
,p_name=>'P108_CHAMADOR'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378737501709829622)
,p_name=>'P108_EMP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281378737955391829622)
,p_name=>'P108_MAT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281378735951684829620)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281378749490922829639)
,p_name=>'Refresh Linha do Tempo'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P108_FATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281378748558690829637)
,p_name=>'Submit Page Linha do Tempo'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P108_FATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281378749065953829638)
,p_event_id=>wwv_flow_api.id(281378748558690829637)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281378748183438829637)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'',
'v_acesso boolean;',
'begin',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'',
'v_acesso := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, :P108_EMP, :P108_MAT);',
'',
'IF V_ACESSO THEN',
':P108_VISUALIZA_SAL := ''S'';',
'else',
':P108_VISUALIZA_SAL := ''N'';',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281378747748721829636)
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
'       i.dt_admissao',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p108_emp',
'   and i.matricula = :p108_mat;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p108_cod_empresa := v_c1.empresa;',
':p108_matricula := v_c1.matricula;',
':p108_situacao := v_c1.situacao;',
':p108_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p108_cod_empresa := :p108_emp;',
':p108_matricula := :p108_mat;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(28299020001080000001)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'NC_LINHA_TEMPO_DADOS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Entrega os fatos da Linha do Tempo ao Natcorp_LinhaTempo.js (Trajet\00F3ria e Cronologia), em JSON.'),
unistr('-- A mesma consulta do relat\00F3rio; o sal\00E1rio s\00F3 para quem pode ver, calculado AQUI (n\00E3o confia no navegador).'),
'declare',
'  v_sal boolean := nvl(fnct_trata_verif_sal_nivel(:p_usuario, :p108_emp, :p108_mat), false);',
'  procedure data_json(p_nome varchar2, p_data date) is',
'  begin',
'    apex_json.open_object(p_nome);',
'    if p_data is not null then',
'      apex_json.write(''year'', to_number(to_char(p_data, ''yyyy'')));',
'      apex_json.write(''month'', to_number(to_char(p_data, ''mm'')));',
'      apex_json.write(''day'', to_number(to_char(p_data, ''dd'')));',
'    end if;',
'    apex_json.close_object;',
'  end;',
'begin',
'  apex_json.open_object;',
'  apex_json.open_array(''events'');',
'  for r in (select fato, data_ini, data_fim, titulo, descricao',
'              from vw_linha_do_tempo',
'             where cod_empresa = :p108_emp',
'               and matricula = :p108_mat',
'               and ((instr('':''||:p108_fato||'':'', '':''||fato||'':'') > 0) or (:p108_fato is null))',
'               and f_acesso_pg_apex(cod_empresa, matricula, filial, cd_nivel, :p_usuario) = ''S''',
'             order by data_ini, fato) loop',
unistr('    if upper(r.fato) in (''SAL\00C1RIO'', ''SALARIO'') and not v_sal then'),
unistr('      continue;   -- quem n\00E3o pode ver sal\00E1rio n\00E3o recebe nenhuma linha de sal\00E1rio'),
'    end if;',
'    apex_json.open_object;',
'    apex_json.write(''group'', r.fato);',
'    data_json(''start_date'', r.data_ini);',
'    data_json(''end_date'', r.data_fim);',
'    apex_json.open_object(''text'');',
'    apex_json.write(''headline'', r.descricao);',
'    apex_json.write(''text'', r.titulo);',
'    apex_json.close_object;',
'    apex_json.close_object;',
'  end loop;',
'  apex_json.close_array;',
'  apex_json.close_object;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_comment=>unistr('Natcorp_LinhaTempo.js: a Trajet\00F3ria e a Cronologia pedem os fatos aqui (apex.server.process). Guia: LINHATEMPO-MANUTENCAO.md.')
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
