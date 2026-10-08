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
--   Date and Time:   01:41 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 120
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00120
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>120);
end;
/
prompt --application/pages/page_00120
begin
wwv_flow_api.create_page(
 p_id=>120
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Curso')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Curso')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Treinamento.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Treinamento.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('DESENHO DA TELA (Natcorp_Treinamento.css / Natcorp_Treinamento.js, os mesmos da p\00E1gina 118)'),
'',
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-tre-solicitacao  &P120_TITULO.: n\00BA e data no alto; a Situa\00E7\00E3o vai para o canto.'),
unistr('  nc-tre-aprovadores  Aprovadores: faixa horizontal do caminho da aprova\00E7\00E3o.'),
unistr('  nc-tre-curso        Curso: "Qual curso voc\00EA precisa?" (nome + o tipo em bot\00F5es grandes; a lista'),
unistr('                      P120_COD_TIPO continua l\00E1, fora da vista) e "Conte mais" (Observa\00E7\00E3o).'),
unistr('                      Pedido gravado (tudo travado): o cart\00E3o do curso.'),
unistr('  nc-tre-colaborador  Solicitante: "Quem est\00E1 pedindo" (o pr\00F3prio gestor), depois do curso.'),
unistr('  nc-tre-acoes        Bot\00F5es: barra fixa no rodap\00E9, com o que falta preencher.'),
'',
unistr('Os itens s\00E3o os do APEX, com as mesmas a\00E7\00F5es din\00E2micas. Para desligar tudo: tire as duas URLs'),
'de arquivo. Guia: brand/apex/app/TREINAMENTO-MANUTENCAO.md.'))
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20210502141741'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363667187238816692)
,p_plug_name=>'Curso'
,p_region_css_classes=>'nc-tre-curso'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363669094514816695)
,p_plug_name=>'&P120_TITULO.'
,p_region_css_classes=>'nc-tre-solicitacao'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363672298878816698)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_css_classes=>'nc-tre-acoes'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281363675959975816701)
,p_name=>'Aprovadores'
,p_region_css_classes=>'nc-tre-aprovadores'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.empresa_aprov||'' - ''||a.matricula_aprov||'' - ''||initcap(fnct_nome_func(a.empresa_aprov,a.matricula_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.empresa_aprov, a.matricula_aprov, A.SEQ_APROV, a.justificativa',
'  from TR_APROVA_REQUISICAO_CURSO a, usuario_oracle u',
' where a.cod_requisicao = :p118_cod_requisicao',
'   and a.empresa_aprov = u.cd_empresa',
'   and a.matricula_aprov = u.cd_matricula',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.empresa_aprov',
'                  and s.matricula_supl = a.matricula_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL empresa_aprov, NULL matricula_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from TR_APROVA_REQUISICAO_CURSO a, usuario_oracle u',
' where a.cod_requisicao = :p118_cod_requisicao',
'   and a.empresa_aprov = u.cd_empresa',
'   and a.matricula_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.empresa_aprov',
'                  and s.matricula_supl = a.matricula_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula_aprov',
'  from TR_APROVA_REQUISICAO_CURSO',
' where cod_requisicao = :p120_cod_requisicao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P120_COD_REQUISICAO'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_break_cols=>'0'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'TOP_RIGHT'
,p_break_type_flag=>'DEFAULT_BREAK_FORMATTING'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363676366267816702)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#EMPRESA_APROV#,#MATRICULA_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363676742028816702)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363677120052816702)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363677546586816703)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV_ESC'
,p_inline_lov=>'STATIC:Pendente;P,Aprovado;A,Reprovado;R'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363677930429816703)
,p_query_column_id=>5
,p_column_alias=>'EMPRESA_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363678344766816703)
,p_query_column_id=>6
,p_column_alias=>'MATRICULA_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068578375229881)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068704728229882)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363679494886816704)
,p_plug_name=>'Solicitante'
,p_region_css_classes=>'nc-tre-colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363681175891816705)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281363679494886816704)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P120_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363681906359816705)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281363679494886816704)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P120_MATRICULA'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363683971024816707)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281404529436169682497)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503514212905346687)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363672760328816698)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P120_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363673148280816700)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P120_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363673571805816700)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:119:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363678775998816703)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363675959975816701)
,p_button_name=>'p120_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P120_COD_REQUISICAO.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula_aprov',
'  from TR_APROVA_REQUISICAO_CURSO',
' where cod_requisicao = :p120_cod_requisicao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363679142909816703)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281363675959975816701)
,p_button_name=>'p120_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P120_COD_REQUISICAO.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula_aprov',
'  from TR_APROVA_REQUISICAO_CURSO',
' where cod_requisicao = :p120_cod_requisicao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363673985007816700)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363679960397816704)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363679494886816704)
,p_button_name=>'p120_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P120_COD_EMPRESA.,&P120_MATRICULA.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281363697847419816714)
,p_branch_action=>'f?p=&APP_ID.:119:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363667508726816694)
,p_name=>'P120_COD_CURSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281363667187238816692)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363667959232816694)
,p_name=>'P120_NOME_CURSO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363667187238816692)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nome do Curso'
,p_placeholder=>'Informe o nome do curso a ser criado'
,p_source=>'NOME_CURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363668311601816695)
,p_name=>'P120_COD_TIPO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363667187238816692)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo'
,p_source=>'COD_TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select to_char(cod_tipo)||'' - ''||Initcap(nome_tipo) descricao, to_char(cod_tipo) codigo from tr_tipo_curso order by cod_tipo'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363668738282816695)
,p_name=>'P120_OBSERVACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363667187238816692)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_placeholder=>'Descreva o curso a ser criado.'
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363669509023816696)
,p_name=>'P120_COD_REQUISICAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363669982149816696)
,p_name=>'P120_DATA_REQUISICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_source=>'DATA_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363670298452816697)
,p_name=>'P120_TITULO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363670732522816697)
,p_name=>'P120_ROWID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363671168801816697)
,p_name=>'P120_SITUACAO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'SITUACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Aberta;1,Conclu\00EDda;2,Cancelada;3,Reprovada;4,Aprovada;5')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363671586679816697)
,p_name=>'P120_USUARIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363671978400816698)
,p_name=>'P120_DT_ATUALIZACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281363669094514816695)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363674352244816701)
,p_name=>'P120_FLAG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363674765460816701)
,p_name=>'P120_MENSAGEM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363675100704816701)
,p_name=>'P120_ITEM_VALIDACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363675526688816701)
,p_name=>'P120_OK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363672298878816698)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363680340287816704)
,p_name=>'P120_COD_EMPRESA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281363679494886816704)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363680720271816704)
,p_name=>'P120_MATRICULA'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281363679494886816704)
,p_use_cache_before_default=>'NO'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363681529383816705)
,p_name=>'P120_FOTO_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363681175891816705)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P120_COD_EMPRESA',
'   and matricula = :P120_MATRICULA;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363682391135816706)
,p_name=>'P120_COD_EMPRESA_DISPLAY'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281363681906359816705)
,p_prompt=>'Empresa'
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
 p_id=>wwv_flow_api.id(281363682750493816706)
,p_name=>'P120_MATRICULA_DISPLAY'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281363681906359816705)
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
 p_id=>wwv_flow_api.id(281363683128065816706)
,p_name=>'P120_SITUACAO_COLAB'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281363681906359816705)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_api.id(281363683582926816706)
,p_name=>'P120_DT_ADMISSAO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281363681906359816705)
,p_prompt=>unistr('Data de Admiss\00E3o')
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
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269883936250029400683)
,p_validation_name=>unistr('Valida Situa\00E7\00E3o')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000); ',
'',
'cursor c1 is',
'select TRIM(TO_CHAR(situacao)) cod_sit_solicitacao',
'  from TR_REQUISICOES_CURSOS',
' where cod_requisicao = :P120_cod_requisicao;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF v_c1.cod_sit_solicitacao IS NOT NULL and :P120_situacao is not null and :P120_situacao <> v_c1.cod_sit_solicitacao THEN',
'',
'    if :P120_situacao = v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (1,5) and :P120_situacao in (3,6) then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao = 6 and :P120_situacao = 1 then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (2,3,4) and :P120_situacao <> v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar a situa\00E7\00E3o desta requisi\00E7\00E3o.'';'),
'    else',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar para a situa\00E7\00E3o escolhida.'';'),
'    end if;',
'',
'END IF;',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'  return v_msg_retorno;',
' end if; ',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281363672760328816698)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363687376193816709)
,p_name=>'Inicia Alertify'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P120_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363687798521816709)
,p_event_id=>wwv_flow_api.id(281363687376193816709)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363688246637816710)
,p_name=>'Aprovar'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363679142909816703)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883937689435400697)
,p_event_id=>wwv_flow_api.id(281363688246637816710)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363675959975816701)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363689234865816710)
,p_event_id=>wwv_flow_api.id(281363688246637816710)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363689678248816710)
,p_name=>'Reprovar'
,p_event_sequence=>320
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363678775998816703)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883937629069400696)
,p_event_id=>wwv_flow_api.id(281363689678248816710)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363675959975816701)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363690634980816711)
,p_event_id=>wwv_flow_api.id(281363689678248816710)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363691084867816711)
,p_name=>'OK: Show Create'
,p_event_sequence=>550
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P120_ITEM_VALIDACAO'
,p_condition_element=>'P120_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363691475335816711)
,p_name=>'Dispara Alerta'
,p_event_sequence=>590
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P120_MENSAGEM'
,p_condition_element=>'P120_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363691946124816711)
,p_event_id=>wwv_flow_api.id(281363691475335816711)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P120_FLAG'').value == "Q") {',
'alertify.confirm($v(''P120_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P120_FLAG'').value = ''S'';',
'        $x(''P120_MENSAGEM'').value = '''';',
'        $x(''P120_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P120_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P120_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P120_FLAG'').value == "N") {',
'            $x(''P120_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P120_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P120_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P120_MENSAGEM''));',
'    }else{',
'            if ($x(''P120_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P120_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363695021647816713)
,p_name=>'Hide Column (Create)'
,p_event_sequence=>620
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P120_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363695514614816713)
,p_event_id=>wwv_flow_api.id(281363695021647816713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P120_COD_REQUISICAO,P120_DATA_REQUISICAO,P120_SITUACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363695913824816713)
,p_name=>'Disable Fields (Save)'
,p_event_sequence=>630
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P120_COD_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363696423808816713)
,p_event_id=>wwv_flow_api.id(281363695913824816713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P120_COD_REQUISICAO,P120_DATA_REQUISICAO,P120_COD_CURSO,P120_COD_TIPO,P120_OBSERVACAO,P120_NOME_CURSO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363696819507816714)
,p_name=>'Enable Fields (Create)'
,p_event_sequence=>640
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363673148280816700)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363697368828816714)
,p_event_id=>wwv_flow_api.id(281363696819507816714)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P120_COD_REQUISICAO,P120_DATA_REQUISICAO,P120_SITUACAO,P120_COD_CURSO,P120_COD_TIPO,P120_OBSERVACAO,P120_COD_EMPRESA,P120_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883936737039400688)
,p_event_id=>wwv_flow_api.id(281363696819507816714)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883936605456400686)
,p_name=>'Enable Fields (Save)'
,p_event_sequence=>650
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363672760328816698)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883936679463400687)
,p_event_id=>wwv_flow_api.id(269883936605456400686)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P120_COD_REQUISICAO,P120_DATA_REQUISICAO,P120_SITUACAO,P120_COD_CURSO,P120_COD_TIPO,P120_OBSERVACAO,P120_COD_EMPRESA,P120_MATRICULA,P120_NOME_CURSO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883936921581400689)
,p_event_id=>wwv_flow_api.id(269883936605456400686)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375681554209620742)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>660
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P120_SITUACAO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375681616492620743)
,p_event_id=>wwv_flow_api.id(281375681554209620742)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363679142909816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375681769273620744)
,p_event_id=>wwv_flow_api.id(281375681554209620742)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363678775998816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281068128775665697828)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>670
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P120_SITUACAO'
,p_condition_element=>'P120_SITUACAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P120_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128810173697829)
,p_event_id=>wwv_flow_api.id(281068128775665697828)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363679142909816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129182402697832)
,p_event_id=>wwv_flow_api.id(281068128775665697828)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363678775998816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128927613697830)
,p_event_id=>wwv_flow_api.id(281068128775665697828)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363678775998816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068129019932697831)
,p_event_id=>wwv_flow_api.id(281068128775665697828)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363679142909816703)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883937375074400694)
,p_name=>'IR - Dialog Closed'
,p_event_sequence=>680
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281363675959975816701)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883937483645400695)
,p_event_id=>wwv_flow_api.id(269883937375074400694)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363675959975816701)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363685768989816708)
,p_process_sequence=>50
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
'   if :P120_SITUACAO = 1 then',
'      v_sit := ''Aberta'';',
'elsif :P120_SITUACAO = 2 then',
unistr('      v_sit := ''Conclu\00EDda'';'),
'elsif :P120_SITUACAO = 3 then',
'      v_sit := ''Cancelada'';',
'elsif :P120_SITUACAO = 4 then',
'      v_sit := ''Reprovada'';',
'elsif :P120_SITUACAO = 5 then',
'      v_sit := ''Aprovada'';',
'end if;',
'',
'',
'if :p120_rowid is not null then',
unistr('   :p120_titulo := ''Requisi\00E7\00E3o de Curso: N\00BA ''||:p120_cod_requisicao||'' - ''||:P120_DATA_REQUISICAO||'' (''||v_sit||'')'';'),
'else',
unistr('   :p120_titulo := ''Requisi\00E7\00E3o de Curso'';'),
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883936395838400684)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'SELECT seq_requisicao.NEXTVAL',
'	  INTO :P120_cod_requisicao',
'	  FROM DUAL;',
'    ',
'END;',
'',
':p120_data_requisicao := sysdate;',
':p120_situacao				:= 1;',
'',
':p120_dt_atualizacao  := SYSDATE;',
':p120_usuario		  := :p_usuario;',
'',
':p120_cod_empresa := :P_EMPRESA_USER;',
':p120_matricula := :P_MATRICULA_USER;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363673148280816700)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883937112116400691)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
':P118_usuario := :P_USUARIO;',
':P118_dt_atualizacao := SYSDATE;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363672760328816698)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363684950893816708)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of TR_REQUISICOES_CURSOS'
,p_attribute_02=>'TR_REQUISICOES_CURSOS'
,p_attribute_03=>'P120_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada com Sucesso.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883936453128400685)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'INSERE APROVADORES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  --',
'  CURSOR c_aprov IS',
'    SELECT a.cod_empresa, a.matricula, a.seq_aprov',
'      FROM aprovacao_ccusto a, informacoes_funcionais i',
'     WHERE a.cod_empresa = :p120_cod_empresa',
'       AND a.cod_filial = i.filial',
'       AND a.cod_ccusto = i.cod_ccusto',
'       AND a.matricula <> :p120_matricula',
'       and a.cod_empresa = i.cod_empresa',
'       and i.cod_empresa = :p120_cod_empresa',
'       and i.matricula = :p120_matricula',
'       AND a.per_treinamentos = ''S'';',
'  --',
'  saida exception;',
'  ',
'  V_MSG VARCHAR2(4000);',
'  ',
'BEGIN',
'  --',
'  BEGIN',
'    --',
'    INSERT INTO tr_aprova_requisicao_curso',
'      (cod_requisicao, --1',
'       empresa_aprov, --2',
'       matricula_aprov, --3',
'       status_aprov, --4',
'       dt_aprov, --5',
'       seq_aprov, --6',
'       usuario, --7',
'       dt_atualizacao) --8',
'    VALUES',
'      (:p120_cod_requisicao, --1',
'       :p120_cod_empresa, --2',
'       :p120_matricula, --3',
'       ''A'', --4',
'       SYSDATE, --5',
'       1, --6',
'       :p_usuario, --7',
'       SYSDATE); --8',
'    --',
'  EXCEPTION',
'    --',
'    WHEN OTHERS THEN',
'      --',
'      :p120_flag := ''N'';',
'      :p120_ok := ''N'';',
'      V_MSG := ''1 - Erro ao inserir dados na tr_aprova_requisicao_curso: '' ||SQLERRM;',
'      raise saida;',
'      --',
'  END;',
'  --',
'  FOR r_aprov in c_aprov LOOP',
'    --',
'    BEGIN',
'      --',
'      INSERT INTO tr_aprova_requisicao_curso',
'        (cod_requisicao, --1',
'         empresa_aprov, --2',
'         matricula_aprov, --3',
'         status_aprov, --4',
'         dt_aprov, --5',
'         seq_aprov, --6',
'         usuario, --7',
'         dt_atualizacao) --8',
'      VALUES',
'        (:p120_cod_requisicao, --1',
'         r_aprov.cod_empresa, --2',
'         r_aprov.matricula, --3',
'         ''P'', --4',
'         NULL, --5',
'         r_aprov.seq_aprov, --6',
'         :p_usuario, --7',
'         SYSDATE); --8',
'      --',
'    EXCEPTION',
'      --',
'      WHEN OTHERS THEN',
'',
'      :p120_flag := ''N'';',
'      :p120_ok := ''N'';',
'      V_MSG := ''2 - Erro ao inserir dados na tr_aprova_requisicao_curso: '' ||SQLERRM;',
'      raise saida;',
'    END;',
'    --',
'  END LOOP;',
'  --',
'exception',
'when saida then',
'RAISE_APPLICATION_ERROR(-20001,V_MSG);',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363673148280816700)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883937007145400690)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Efetiva Req.'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(1);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_aprovacao_coletiva.req_treinamento_cursos (:p120_cod_requisicao, ',
'                    :P120_EMP_SOLICITADO,',
'                    ''A'', ',
'                    :p_empresa_user, ',
'                    :p_matricula_user, ',
'                    :p_usuario,',
'                    :p_perfil,',
'                    null,',
'                    v_flg_retorno,',
'                    v_msg_retorno);',
'                    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363673148280816700)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363685388406816708)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363870383558795151)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363686948851816709)
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
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363686154723816709)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from TR_REQUISICOES_CURSOS'
,p_attribute_02=>'TR_REQUISICOES_CURSOS'
,p_attribute_03=>'P120_COD_REQUISICAO'
,p_attribute_04=>'COD_REQUISICAO'
,p_attribute_05=>'P120_COD_EMPRESA'
,p_attribute_06=>'COD_EMPRESA'
,p_attribute_08=>'MATRICULA = :P120_MATRICULA'
,p_process_when=>'P120_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363686506299816709)
,p_process_sequence=>30
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
' where i.cod_empresa = :p120_COD_EMPRESA',
'   and i.matricula = :p120_MATRICULA;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p120_cod_requisicao is null then',
' :p120_COD_EMPRESA := :P_EMPRESA_USER;',
' :p120_MATRICULA := :P_MATRICULA_USER;',
'end if;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p120_cod_empresa_display := v_c1.empresa;',
':p120_matricula_display := v_c1.matricula;',
':p120_situacao_colab := v_c1.situacao;',
':p120_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p120_cod_empresa_display := :p120_empresa;',
':p120_matricula_display := :p120_matricula;',
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
