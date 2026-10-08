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
--   Date and Time:   01:29 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 118
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00118
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>118);
end;
/
prompt --application/pages/page_00118
begin
wwv_flow_api.create_page(
 p_id=>118
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Treinamento')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Treinamento')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20210719200110'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363606207654767007)
,p_plug_name=>'Turma'
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
 p_id=>wwv_flow_api.id(281363610638634767010)
,p_plug_name=>'&P118_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363615468795767014)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281363619074999767016)
,p_name=>'Aprovadores'
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
'  from TR_APROVA_REQUISICAO a, usuario_oracle u',
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
'  from TR_APROVA_REQUISICAO a, usuario_oracle u',
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
'  from TR_APROVA_REQUISICAO',
' where cod_requisicao = :p118_cod_requisicao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363619403257767016)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#EMPRESA_APROV#,#MATRICULA_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363619835546767016)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363620210613767017)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363620642855767017)
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
 p_id=>wwv_flow_api.id(281363621085445767017)
,p_query_column_id=>5
,p_column_alias=>'EMPRESA_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281363621418702767018)
,p_query_column_id=>6
,p_column_alias=>'MATRICULA_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068417190229879)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068438200229880)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363622669153767018)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363624644645767020)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P118_MAT_SOLICITADO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363626639605767022)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P118_MAT_SOLICITADO'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281363627484794767023)
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
 p_id=>wwv_flow_api.id(281363617090639767015)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P118_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363615873693767014)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P118_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363611019215767011)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_button_name=>'p118_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P118 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P118_EMP_SOLICITANTE.,&P118_MAT_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363616264060767014)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:117:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363621798146767018)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363619074999767016)
,p_button_name=>'p118_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P118_COD_REQUISICAO.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula_aprov',
'  from TR_APROVA_REQUISICAO',
' where cod_requisicao = :p118_cod_requisicao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363622262073767018)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281363619074999767016)
,p_button_name=>'p118_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P118_COD_REQUISICAO.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula_aprov',
'  from TR_APROVA_REQUISICAO',
' where cod_requisicao = :p118_cod_requisicao',
'   and empresa_aprov = :P_EMPRESA_USER',
'   and matricula_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281363616595459767014)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281363615468795767014)
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
 p_id=>wwv_flow_api.id(281363623004788767019)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_button_name=>'p118_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P118_EMP_SOLICITADO.,&P118_MAT_SOLICITADO.'
,p_button_condition=>'P118_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281363650879659767037)
,p_branch_action=>'f?p=&APP_ID.:117:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363606625762767007)
,p_name=>'P118_COD_CURSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Curso'
,p_source=>'COD_CURSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.cod_curso||'' - ''||initcap(c.nome_curso) descricao, c.cod_curso',
'  from tr_cursos c',
' where ((c.cod_curso in (SELECT distinct t.cod_curso',
'                         FROM TR_TURMAS T, TR_ENTIDADES E',
'                        WHERE COD_CURSO = c.COD_CURSO',
'                          AND T.COD_ENTIDADE = E.COD_ENTIDADE (+)',
'                          AND data_fim >= TRUNC(SYSDATE)',
'                          AND T.STATUS IN (1,3))',
'        and :p118_cod_requisicao is null) OR (:p118_cod_requisicao is not null))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P118_COD_REQUISICAO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363607088555767008)
,p_name=>'P118_COD_TURMA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Turma'
,p_source=>'COD_TURMA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.COD_TURMA||'', ''||T.COD_ENTIDADE||'' - ''||INITCAP(E.NOME_ENTIDADE) descricao,',
'       T.COD_TURMA ret',
'  FROM TR_TURMAS T, TR_ENTIDADES E',
'  WHERE t.COD_CURSO = :P118_COD_CURSO',
'   AND T.COD_ENTIDADE = NVL(E.COD_ENTIDADE,T.COD_ENTIDADE)',
'   AND t.data_fim >= TRUNC(SYSDATE)',
'   AND T.STATUS IN (1,3)',
'   AND (select  count(DISTINCT COD_TURMA) QTDE_PART from tr_turma_participantes  ',
'    where cod_curso = :P118_COD_CURSO) < T.MAXIMO_VAGAS',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P118_COD_CURSO,P118_EMP_SOLICITADO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363607491835767008)
,p_name=>'P118_COD_TIPO'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>'Tipo'
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
 p_id=>wwv_flow_api.id(281363607802956767008)
,p_name=>'P118_COD_ENTIDADE'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>'Entidade'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT e.cod_entidade||'' - ''||initcap(e.nome_entidade) descricao , e.cod_entidade codigo',
'  FROM TR_ENTIDADES E',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P118_COD_CURSO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363608265899767008)
,p_name=>'P118_DATA_INICIO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>unistr('Data In\00EDcio')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363608689295767009)
,p_name=>'P118_DATA_FIM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>'Data Fim'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363609001765767009)
,p_name=>'P118_HORA_INICIO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>unistr('Hor\00E1rio In\00EDcio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363609417211767009)
,p_name=>'P118_HORA_FIM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>unistr('Hor\00E1rio Fim')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363609801270767010)
,p_name=>'P118_LOCAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_prompt=>'Local'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>8
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363610255832767010)
,p_name=>'P118_OBSERVACAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281363606207654767007)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
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
 p_id=>wwv_flow_api.id(281363611407093767011)
,p_name=>'P118_EMP_SOLICITANTE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_use_cache_before_default=>'NO'
,p_source=>'EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363611873844767011)
,p_name=>'P118_MAT_SOLICITANTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363612260311767011)
,p_name=>'P118_COD_REQUISICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
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
 p_id=>wwv_flow_api.id(281363612637690767012)
,p_name=>'P118_DATA_REQUISICAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
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
 p_id=>wwv_flow_api.id(281363613061783767012)
,p_name=>'P118_TITULO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363613462620767012)
,p_name=>'P118_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363613798395767012)
,p_name=>'P118_SITUACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
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
 p_id=>wwv_flow_api.id(281363614221931767013)
,p_name=>'P118_SOLICITANTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363614678139767013)
,p_name=>'P118_USUARIO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363615083750767013)
,p_name=>'P118_DT_ATUALIZACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281363610638634767010)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363617478333767015)
,p_name=>'P118_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363617832963767015)
,p_name=>'P118_MENSAGEM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363618228841767015)
,p_name=>'P118_ITEM_VALIDACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363618631450767016)
,p_name=>'P118_OK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281363615468795767014)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363623437672767019)
,p_name=>'P118_EMP_SOLICITADO'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'EMP_SOLICITADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod ret',
'from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P118_COD_REQUISICAO is null) or ',
'        (:P118_COD_REQUISICAO is not null)) ',
'  and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and cod = :p_empresa_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P118_COD_REQUISICAO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363623865627767019)
,p_name=>'P118_MAT_SOLICITADO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_SOLICITADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) descricao, i.matricula',
' from informacoes_funcionais i',
'where i.situacao < ''90''',
'  AND I.COD_EMPRESA = :P118_EMP_SOLICITADO',
'  and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and i.cod_empresa = :p_empresa_user and i.matricula = :p_matricula_user))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P_USUARIO,P118_EMP_SOLICITADO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363624261620767019)
,p_name=>'P118_TIPO_ORIGEM'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(281363622669153767018)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Origem'
,p_source=>'TIPO_ORIGEM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_ORIGEM||'' - ''||INITCAP(NOME_ORIGEM) DESCRICAO, COD_ORIGEM',
'  FROM TR_ORIGENS',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
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
 p_id=>wwv_flow_api.id(281363625007647767020)
,p_name=>'P118_COD_EMPRESA_DISPLAY'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281363624644645767020)
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
 p_id=>wwv_flow_api.id(281363625418816767021)
,p_name=>'P118_MATRICULA_DISPLAY'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281363624644645767020)
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
 p_id=>wwv_flow_api.id(281363625875690767021)
,p_name=>'P118_SITUACAO_COLAB'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281363624644645767020)
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
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363626236521767022)
,p_name=>'P118_DT_ADMISSAO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281363624644645767020)
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
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281363627017577767022)
,p_name=>'P118_FOTO_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281363626639605767022)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P118_EMP_SOLICITADO',
'   and matricula = :P118_MAT_SOLICITADO;'))
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269894817506930506261)
,p_validation_name=>unistr('Valida_Situa\00E7\00E3o')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000); ',
'',
'cursor c1 is',
'select TRIM(TO_CHAR(situacao)) cod_sit_solicitacao',
'  from TR_REQUISICOES',
' where cod_requisicao = :P118_cod_requisicao;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF v_c1.cod_sit_solicitacao IS NOT NULL and :P118_situacao is not null and :P118_situacao <> v_c1.cod_sit_solicitacao THEN',
'',
'    if :P118_situacao = v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (1,5) and :P118_situacao in (3,6) then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao = 6 and :P118_situacao = 1 then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (2,3,4) and :P118_situacao <> v_c1.cod_sit_solicitacao then',
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
,p_when_button_pressed=>wwv_flow_api.id(281363617090639767015)
,p_associated_item=>wwv_flow_api.id(281363613798395767012)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269883936231301400682)
,p_validation_name=>'Valida Turma'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from tr_turma_participantes',
' where cod_empresa = :p118_emp_solicitado',
'   and cod_turma = :p118_cod_turma',
'   and cod_curso = :p118_cod_curso',
'   and matricula = :p118_mat_solicitado;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if nvl(v_c1.existe,''N'') = ''S'' then',
unistr('return ''Colaborador j\00E1 inscrito para este curso e turma!'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281363615873693767014)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363631226572767026)
,p_name=>'Inicia Alertify'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363631729891767027)
,p_event_id=>wwv_flow_api.id(281363631226572767026)
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
 p_id=>wwv_flow_api.id(281363632159120767027)
,p_name=>'Aprovar'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363622262073767018)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883935916843400679)
,p_event_id=>wwv_flow_api.id(281363632159120767027)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363619074999767016)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883935608418400676)
,p_event_id=>wwv_flow_api.id(281363632159120767027)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE,P118_COD_CURSO,P118_COD_TURMA,P118_OBSERVACAO,P118_TIPO_ORIGEM,P118_COD_REQUISICAO,P118_DATA_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363633614370767028)
,p_event_id=>wwv_flow_api.id(281363632159120767027)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363634057587767028)
,p_name=>'Reprovar'
,p_event_sequence=>320
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363621798146767018)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883936016199400680)
,p_event_id=>wwv_flow_api.id(281363634057587767028)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363619074999767016)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883936051848400681)
,p_event_id=>wwv_flow_api.id(281363634057587767028)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE,P118_COD_CURSO,P118_COD_TURMA,P118_OBSERVACAO,P118_TIPO_ORIGEM,P118_COD_REQUISICAO,P118_DATA_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363635587282767029)
,p_event_id=>wwv_flow_api.id(281363634057587767028)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REPROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363635959645767029)
,p_name=>'OK: Show Create'
,p_event_sequence=>550
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_ITEM_VALIDACAO'
,p_condition_element=>'P118_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363636384244767029)
,p_name=>'Dispara Alerta'
,p_event_sequence=>590
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_MENSAGEM'
,p_condition_element=>'P118_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363636856853767029)
,p_event_id=>wwv_flow_api.id(281363636384244767029)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P118_FLAG'').value == "Q") {',
'alertify.confirm($v(''P118_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P118_FLAG'').value = ''S'';',
'        $x(''P118_MENSAGEM'').value = '''';',
'        $x(''P118_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P118_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P118_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P118_FLAG'').value == "N") {',
'            $x(''P118_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P118_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P118_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P118_MENSAGEM''));',
'    }else{',
'            if ($x(''P118_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P118_OK'').value = ''S'';',
'            }',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363638174355767030)
,p_name=>'seta_cod_tipo'
,p_event_sequence=>610
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_COD_CURSO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363638618336767030)
,p_event_id=>wwv_flow_api.id(281363638174355767030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_curso, nome_curso, cod_tipo',
'  from tr_cursos',
' where cod_curso = :p118_cod_curso;',
'  ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_curso is not null then',
'',
':p118_cod_tipo := v_c1.cod_tipo;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P118_COD_CURSO'
,p_attribute_03=>'P118_COD_TIPO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363639007979767030)
,p_name=>'seta_cod_entidade'
,p_event_sequence=>620
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_COD_TURMA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363639548650767031)
,p_event_id=>wwv_flow_api.id(281363639007979767030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'  SELECT te.cod_entidade',
'    FROM tr_entidades te, tr_turmas tt',
'   WHERE tt.cod_entidade = te.cod_entidade',
'     AND tt.cod_turma = :P118_cod_turma',
'     AND tt.cod_curso = :P118_cod_curso;',
'  ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_entidade is not null then',
'',
':p118_cod_entidade := v_c1.cod_entidade;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P118_COD_CURSO,P118_COD_TURMA'
,p_attribute_03=>'P118_COD_ENTIDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363639941607767031)
,p_name=>'Cod_Turma: when-validade-item'
,p_event_sequence=>630
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_COD_TURMA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363640450893767031)
,p_event_id=>wwv_flow_api.id(281363639941607767031)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'	--',
'  v_matriculados NUMBER := 0; ',
'  v_vagas        NUMBER := 0;',
'--',
'',
'saida exception;',
'',
'BEGIN',
'	--',
'	SELECT COUNT(tp.cod_turma), ',
'	       t.maximo_vagas',
'    INTO v_matriculados,',
'         v_vagas',
'    FROM tr_turma_participantes tp, tr_turmas t',
'   WHERE t.cod_turma  = tp.cod_turma',
'     AND t.cod_curso  = tp.cod_curso',
'     AND tp.cod_turma = :p118_cod_turma',
'     AND tp.cod_curso = :p118_cod_curso',
'     AND tp.situacao  <> 4',
'  GROUP BY tp.cod_turma, t.maximo_vagas;',
'  --',
'  IF v_matriculados = v_vagas THEN',
'  	--',
'    :p118_ok := ''N'';',
'    :p118_flag := ''N'';',
unistr('  	:p118_mensagem := ''Esta turma n\00E3o possui vagas em Aberto!'';'),
'  	RAISE saida;',
'  --',
'  END IF;',
'',
'EXCEPTION',
'when saida then',
'null;',
'  --',
'WHEN NO_DATA_FOUND THEN',
'    --',
'    NULL;',
'--',
'END;',
''))
,p_attribute_02=>'P118_COD_TURMA,P118_COD_CURSO'
,p_attribute_03=>'P118_OK,P118_FLAG,P118_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363640815057767031)
,p_name=>'Seta Hora / Data'
,p_event_sequence=>640
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_COD_TURMA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363641373804767032)
,p_event_id=>wwv_flow_api.id(281363640815057767031)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT T.DATA_INICIO,T.DATA_FIM,to_char(T.HORA_INICIO,''hh24:mi'') hora_inicio, to_char(T.HORA_FIM,''hh24:mi'') hora_fim',
'  FROM TR_TURMAS T, TR_ENTIDADES E',
' WHERE T.COD_CURSO = :p118_COD_CURSO',
'   and T.cod_turma = :P118_COD_TURMA',
'   AND T.COD_ENTIDADE = E.COD_ENTIDADE (+);',
'   ',
'V_C1 C1%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
':P118_DATA_INICIO := V_C1.DATA_INICIO;',
':P118_DATA_FIM := V_C1.DATA_FIM;',
':P118_HORA_INICIO := V_C1.HORA_INICIO;',
':P118_HORA_FIM := V_C1.HORA_FIM;',
'',
'END;'))
,p_attribute_02=>'P118_COD_CURSO,P118_COD_TURMA'
,p_attribute_03=>'P118_OK,P118_FLAG,P118_MENSAGEM,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363641730331767032)
,p_name=>'Seta Local'
,p_event_sequence=>650
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_COD_ENTIDADE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363642238148767032)
,p_event_id=>wwv_flow_api.id(281363641730331767032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select e.cod_entidade, ',
'       initcap(e.nome_entidade) nome_entidade, ',
'       Initcap(e.endereco)||'', ''||e.numero||'' - ''||initcap(e.complemento) endereco, ',
'       Initcap(e.bairro) Bairro, ',
'       Initcap(e.cidade)||''/''||e.uf cidade,',
'       ''(''||e.ddd_telefone||'') ''||e.telefone telefone,',
'       lower(site) site,',
'       lower(e_mail) e_mail',
'  from tr_entidades e',
' where cod_entidade = :p118_cod_entidade;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p118_local := ''Entidade: ''||v_c1.nome_entidade||chr(10)||',
unistr('               ''Endere\00E7o: ''||v_c1.endereco||chr(10)||'),
'               ''Bairro: ''||v_c1.bairro||chr(10)||',
'               ''Cidade: ''||v_c1.cidade||chr(10)||',
'               ''Telefone: ''||v_c1.telefone||chr(10)||',
'               ''Site: ''||v_c1.site||chr(10)||',
'               ''E-Mail: ''||v_c1.e_mail;',
'',
'end;'))
,p_attribute_02=>'P118_COD_ENTIDADE'
,p_attribute_03=>'P118_LOCAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363648983419767036)
,p_name=>'Hide Column (Create)'
,p_event_sequence=>660
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P118_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363649478574767036)
,p_event_id=>wwv_flow_api.id(281363648983419767036)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_REQUISICAO,P118_DATA_REQUISICAO,P118_SITUACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363649829017767036)
,p_name=>'Disable Column (Create)'
,p_event_sequence=>670
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363650389937767036)
,p_event_id=>wwv_flow_api.id(281363649829017767036)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363642650515767032)
,p_name=>'Disable Column (Save)'
,p_event_sequence=>680
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P118_COD_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363643096462767033)
,p_event_id=>wwv_flow_api.id(281363642650515767032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE,P118_COD_CURSO,P118_COD_TURMA,P118_OBSERVACAO,P118_TIPO_ORIGEM,P118_COD_REQUISICAO,P118_DATA_REQUISICAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363643560104767033)
,p_name=>'Enable Columns (CREATE)'
,p_event_sequence=>690
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363615873693767014)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363644020624767033)
,p_event_id=>wwv_flow_api.id(281363643560104767033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_REQUISICAO,P118_DATA_REQUISICAO,P118_SITUACAO,P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269894817256917506259)
,p_event_id=>wwv_flow_api.id(281363643560104767033)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363644395707767033)
,p_name=>'Enable Fields (Save)'
,p_event_sequence=>700
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281363617090639767015)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363644974786767034)
,p_event_id=>wwv_flow_api.id(281363644395707767033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_COD_TIPO,P118_DATA_INICIO,P118_DATA_FIM,P118_HORA_INICIO,P118_HORA_FIM,P118_LOCAL,P118_COD_ENTIDADE,P118_COD_CURSO,P118_COD_TURMA,P118_OBSERVACAO,P118_TIPO_ORIGEM,P118_COD_REQUISICAO,P118_DATA_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269894817432922506260)
,p_event_id=>wwv_flow_api.id(281363644395707767033)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281363648043975767035)
,p_name=>'Hide Matricula (Save) '
,p_event_sequence=>750
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P118_COD_REQUISICAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281363648552567767036)
,p_event_id=>wwv_flow_api.id(281363648043975767035)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P118_EMP_SOLICITADO,P118_MAT_SOLICITADO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375681258356620739)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>760
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P118_SITUACAO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375681325019620740)
,p_event_id=>wwv_flow_api.id(281375681258356620739)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363622262073767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281375681453365620741)
,p_event_id=>wwv_flow_api.id(281375681258356620739)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363621798146767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281066035585094683373)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>770
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P118_SITUACAO'
,p_condition_element=>'P118_SITUACAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P118_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128305524697824)
,p_event_id=>wwv_flow_api.id(281066035585094683373)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363622262073767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128676006697827)
,p_event_id=>wwv_flow_api.id(281066035585094683373)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363621798146767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128431654697825)
,p_event_id=>wwv_flow_api.id(281066035585094683373)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363621798146767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281068128528645697826)
,p_event_id=>wwv_flow_api.id(281066035585094683373)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281363622262073767018)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269883935668176400677)
,p_name=>'Aprovadores - Dialog Closed'
,p_event_sequence=>780
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281363619074999767016)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883935820678400678)
,p_event_id=>wwv_flow_api.id(269883935668176400677)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281363619074999767016)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269894816855697506255)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
':p118_emp_solicitante := :P_EMPRESA_USER;',
':p118_mat_solicitante := :P_MATRICULA_USER;',
'',
':p118_data_requisicao := sysdate;',
':p118_situacao				:= 1;',
'',
':P118_usuario := :P_USUARIO;',
':P118_dt_atualizacao := SYSDATE;',
'',
'  BEGIN',
'',
'    SELECT seq_requisicao.NEXTVAL',
'      INTO :P118_cod_requisicao',
'      FROM DUAL;',
'',
'  END;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363615873693767014)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269894817142924506258)
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
,p_process_when_button_id=>wwv_flow_api.id(281363617090639767015)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363628837293767024)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of TR_REQUISICOES'
,p_attribute_02=>'TR_REQUISICOES'
,p_attribute_03=>'P118_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada com Sucesso.')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269894817022948506256)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'insere_aprovadores'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  --',
'  CURSOR c_aprov IS',
'    SELECT a.cod_empresa, a.matricula, a.seq_aprov',
'      FROM aprovacao_ccusto a, INFORMACOES_FUNCIONAIS_CAD I',
'     WHERE a.cod_empresa = I.COD_EMPRESA',
'       AND a.cod_filial = I.FILIAL',
'       AND a.cod_ccusto = I.COD_CCUSTO',
'       AND i.cod_empresa = :p118_emp_solicitado',
'       AND i.matricula = :p118_mat_solicitado',
'       AND a.matricula <> :P118_mat_solicitante',
'       AND a.per_cursos = ''S'';',
'  --',
'  SAIDA EXCEPTION;',
'  ',
'BEGIN',
'  --',
'  BEGIN',
'    --',
'    INSERT INTO tr_aprova_requisicao',
'      (cod_requisicao, --1',
'       empresa_aprov, --2',
'       matricula_aprov, --3',
'       status_aprov, --4',
'       dt_aprov, --5',
'       seq_aprov, --6',
'       usuario, --7',
'       dt_atualizacao) --8',
'    VALUES',
'      (:P118_cod_requisicao, --1',
'       :P118_emp_solicitante, --2',
'       :P118_mat_solicitante, --3',
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
'      :P118_FLAG := ''N'';',
'      :P118_OK := ''N'';',
'      :P118_MENSAGEM := ''1 - Erro ao Inserir Dados na Tabela tr_aprova_requisicao: ''||sqlerrm;',
'      RAISE SAIDA;',
'      --',
'  END;',
'  --',
'  FOR r_aprov IN c_aprov LOOP',
'    --',
'    BEGIN',
'      --',
'      INSERT INTO tr_aprova_requisicao',
'        (cod_requisicao, --1',
'         empresa_aprov, --2',
'         matricula_aprov, --3',
'         status_aprov, --4',
'         dt_aprov, --5',
'         seq_aprov, --6',
'         usuario, --7',
'         dt_atualizacao) --8',
'      VALUES',
'        (:P118_cod_requisicao, --1',
'         r_aprov.cod_empresa, --2',
'         r_aprov.matricula, --3',
'         ''P'', --4',
'         NULL, --5',
'         r_aprov.seq_aprov, --6',
'         :P_USUARIO, --7',
'         SYSDATE); --8',
'      --',
'    EXCEPTION',
'      --',
'      WHEN OTHERS THEN',
'        --',
'      :P118_FLAG := ''N'';',
'      :P118_OK := ''N'';',
'      :P118_MENSAGEM := ''2 - Erro ao Inserir Dados na Tabela tr_aprova_requisicao: ''||sqlerrm;',
'        RAISE SAIDA;',
'        --',
'    END;',
'    --',
'  END LOOP;',
'  --',
'EXCEPTION',
'  --',
'  WHEN SAIDA THEN',
'    --',
'    NULL;',
'    --',
'  WHEN OTHERS THEN',
'    --',
'      :P118_FLAG := ''N'';',
'      :P118_OK := ''N'';',
'      :P118_MENSAGEM := ''3 - Erro ao Inserir Dados na Tabela tr_aprova_requisicao: ''||sqlerrm;',
'    --',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363615873693767014)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883935526109400675)
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
'pkg_aprovacao_coletiva.req_treinamento (:p118_cod_requisicao, ',
'                    :P118_EMP_SOLICITADO,',
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
,p_process_when_button_id=>wwv_flow_api.id(281363615873693767014)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363629243399767025)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281363616595459767014)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281363630034342767026)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from TR_REQUISICOES'
,p_attribute_02=>'TR_REQUISICOES'
,p_attribute_03=>'P118_COD_REQUISICAO'
,p_attribute_04=>'COD_REQUISICAO'
,p_process_when=>'P118_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883935184566400672)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colaborador Solicitado'
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
' where i.cod_empresa = :p118_emp_solicitado',
'   and i.matricula = :p118_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p118_cod_empresa_display := v_c1.empresa;',
':p118_matricula_display := v_c1.matricula;',
':p118_situacao_colab := v_c1.situacao;',
':p118_dt_admissao := v_c1.dt_admissao;',
'',
'exception',
'when others then',
':p118_cod_empresa_display := :p118_emp_solicitado;',
':p118_matricula_display := :p118_mat_solicitado;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883935334851400673)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Solicitante'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa))||'' / ''||',
'        matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula))||'' / ''||',
'        cargo||'' - ''||initcap(fnct_nome_cargo(cargo)) colaborador',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p118_emp_solicitante',
'    and matricula   = :p118_mat_solicitante;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
'IF :P118_COD_REQUISICAO IS NULL THEN',
':p118_emp_solicitante := :P_EMPRESA_USER;',
':p118_mat_solicitante := :P_MATRICULA_USER;',
'END IF;',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p118_solicitante := v_c1.colaborador;',
' end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269883935351554400674)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'begin',
'',
'   if :P118_SITUACAO = 1 then',
'      v_sit := ''Aberta'';',
'elsif :P118_SITUACAO = 2 then',
unistr('      v_sit := ''Conclu\00EDda'';'),
'elsif :P118_SITUACAO = 3 then',
'      v_sit := ''Cancelada'';',
'elsif :P118_SITUACAO = 4 then',
'      v_sit := ''Reprovada'';',
'elsif :P118_SITUACAO = 5 then',
'      v_sit := ''Aprovada'';',
'end if;',
'',
'',
'if :p118_rowid is not null then',
unistr('   :p118_titulo := ''Requisi\00E7\00E3o de Participante: N\00BA ''||:p118_cod_requisicao||'' - ''||:P118_DATA_REQUISICAO||'' (''||v_sit||'')'';'),
'else',
unistr('   :p118_titulo := ''Requisi\00E7\00E3o de Participante'';'),
'end if;',
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
