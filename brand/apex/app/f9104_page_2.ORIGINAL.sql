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
,p_default_application_id=>9104
,p_default_id_offset=>17701478678126781
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9104 - Treinamento - Processos
--
-- Application Export:
--   Application:     9104
--   Name:            Treinamento - Processos
--   Date and Time:   01:26 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00002
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(24253223456140525237)
,p_name=>unistr('Repostas de Question\00E1rio')
,p_step_title=>unistr('Repostas de Question\00E1rio')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'Y'
,p_last_upd_yyyymmddhh24miss=>'20241105164117'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(5894467873768882416)
,p_plug_name=>unistr('PERGUNTAS DO QUESTION\00C1RIO')
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--accent13:t-Region--stacked:t-Region--scrollBody:t-Form--noPadding:margin-top-sm:margin-bottom-none'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(24253197459302525143)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT qp.cod_questionario',
'      ,qp.cod_pergunta',
'      ,qp.peso',
'      ,LPAD(qp.cod_pergunta,6,0)||'' - ''||(SELECT INITCAP(x.descricao) FROM tr_perguntas x WHERE x.cod_pergunta = qp.cod_pergunta) PERGUNTA',
'      ,(SELECT x.tipo_pergunta FROM tr_perguntas x WHERE x.cod_pergunta = qp.cod_pergunta) tipo_pergunta',
unistr('      ,(SELECT DECODE(x.tipo_pergunta, ''M'',''M\00FAltipla Escolha'',''D'',''Dissertativa'') FROM tr_perguntas x WHERE x.cod_pergunta = qp.cod_pergunta)||'' | Peso: ''||NVL(TO_CHAR(qp.peso),''-'') TIPOPERG'),
'      ,(SELECT ''Resposta: ''||DECODE((SELECT x.tipo_pergunta FROM tr_perguntas x WHERE x.cod_pergunta = qp.cod_pergunta)',
'                                    ,''M'',(SELECT UPPER(x1.descricao) FROM tr_respostas x1 WHERE x1.cod_resposta = qpp.resposta_alt)',
'                                    ,''D'',(SUBSTR(qpp.resposta_dis,1,50)||''...'' )) resposta',
'          FROM tr_questionario_participante qpp   ',
'         WHERE qpp.cod_empresa      = :P2_EMPRESA',
'           AND qpp.matricula        = :P2_MATRICULA',
'           AND qpp.cod_turma        = :P2_TURMA',
'           AND qpp.cod_questionario = qp.cod_questionario',
'           AND qpp.cod_pergunta     = qp.cod_pergunta',
'           AND qpp.cod_curso        = :P2_CURSO',
'       ) RESPPERGMAT',
'      ,(SELECT qpp.ROWID',
'          FROM tr_questionario_participante qpp',
'         WHERE qpp.cod_empresa      = :P2_EMPRESA',
'           AND qpp.matricula        = :P2_MATRICULA',
'           AND qpp.cod_turma        = :P2_TURMA',
'           AND qpp.cod_questionario = qp.cod_questionario',
'           AND qpp.cod_pergunta     = qp.cod_pergunta',
'           AND qpp.cod_curso        = :P2_CURSO',
'       ) idROW3       ',
'  FROM tr_questionario_perguntas qp',
' WHERE qp.cod_questionario = :P2_QUESTIONARIO',
'   AND :P2_MATRICULA IS NOT NULL',
'ORDER BY 2'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_ajax_items_to_submit=>'P2_EMPRESA,P2_CURSO,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO,P2_CODQUEST'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_no_data_found=>'Nenhum Registro Encontrado!'
,p_attribute_02=>'PERGUNTA'
,p_attribute_06=>'RESPPERGMAT'
,p_attribute_08=>'TIPOPERG'
,p_attribute_16=>'f?p=&APP_ID.:3:&SESSION.::&DEBUG.:RP,3:P3_ROWID,P3_COD_QUESTIONARIO,P3_COD_PERGUNTA,P3_CODEMPRESA,P3_CODCURSO,P3_CODTURMA,P3_CODMATRICULA:&IDROW3.,&COD_QUESTIONARIO.,&COD_PERGUNTA.,&P2_EMPRESA.,&P2_CURSO.,&P2_TURMA.,&P2_MATRICULA.'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6368740647325808657)
,p_plug_name=>unistr('Repostas de Question\00E1rio')
,p_icon_css_classes=>'fa-table-check'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(24253195884214525140)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6368740739373808658)
,p_plug_name=>'Pesquisa'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(24253189381808525129)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6368741289306808664)
,p_plug_name=>unistr('PAR\00C2METROS')
,p_parent_plug_id=>wwv_flow_api.id(6368740739373808658)
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(24253189381808525129)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6536237344753001344)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(5894467873768882416)
,p_button_name=>'BT_PESQUISA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218134829525184)
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(5924980036784569387)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(5894467873768882416)
,p_button_name=>'BT_FILTRAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218134829525184)
,p_button_image_alt=>'Filtrar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-filter'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6536238791387001359)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(6368740647325808657)
,p_button_name=>'BT_RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218134829525184)
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP,2::'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3755963429718621265)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(6368740647325808657)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(24253218250900525187)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=TR_MENU_&P_BASE.:2:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5873396630897702810)
,p_name=>'P2_QUESTIONARIO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_item_default=>'NULL'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>unistr('QUESTION\00C1RIO')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT LPAD(q.cod_questionario,4,0)||'' - ''||INITCAP(q.descricao) dsc',
'      ,q.cod_questionario                                                 ret',
'  FROM tr_questionarios       q',
'      ,tr_turma_questionarios tq',
' WHERE tq.cod_questionario = q.cod_questionario',
'   AND tq.cod_turma = :P2_TURMA',
'   AND tq.cod_curso = :P2_CURSO',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P2_CURSO,P2_TURMA'
,p_ajax_items_to_submit=>'P2_CURSO,P2_TURMA'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5873396637563702811)
,p_name=>'P2_CURSOX'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6368740739373808658)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5873396800907702812)
,p_name=>'P2_TURMAX'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6368740739373808658)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(5924979212219569378)
,p_name=>'P2_CODQUEST'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6368740739373808658)
,p_use_cache_before_default=>'NO'
,p_source=>'P2_QUESTIONARIO'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6368740786958808659)
,p_name=>'P2_ERR_MSG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6368740739373808658)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6368741410328808665)
,p_name=>'P2_EMPRESA'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_item_default=>'select null from dual'
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'EMPRESA'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_EMPRESA_APEXUSER'
,p_lov=>'SELECT emp.cod||'' - ''||INITCAP(emp.nome_abrev) Dsp, emp.cod Ret FROM empresas emp WHERE F_Acesso_Emp_PG_APEX(cod, :P_USUARIO, :P_PAINEL) = ''S'' ORDER BY 1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6536234736377001318)
,p_name=>'P2_CURSO'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_item_default=>'NULL'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'CURSO'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(c.cod_curso,5,0)||'' - ''||INITCAP(c.nome_curso) dsc',
'      ,c.cod_curso                                         ret',
'  FROM tr_cursos c',
' WHERE (c.cod_curso = :P2_CURSOX OR :P2_CURSOX IS NULL)',
'   AND EXISTS(SELECT 1 ',
'                FROM tr_turma_participantes x ',
'               WHERE x.cod_empresa = :P2_EMPRESA',
'                 AND (x.cod_turma  = :P2_TURMAX OR :P2_TURMAX IS NULL) ',
'                 AND x.cod_curso   = c.cod_curso)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P2_EMPRESA'
,p_ajax_items_to_submit=>'P2_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Cursos'
,p_attribute_08=>'400'
,p_attribute_09=>'420'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6536234902280001320)
,p_name=>'P2_TURMA'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_item_default=>'NULL'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'TURMA'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (''TURMA ''||LPAD(t.cod_turma,6,0)||'' ''||TO_CHAR(t.data_inicio, ''DD/MM/RRRR'')||'' - ''||TO_CHAR(t.Data_Fim, ''DD/MM/RRRR'')||'' | ''||',
'       DECODE(T.STATUS, 1,''Prevista'', 2,''Confirmada'', 3,''Em Andamento'', 4,''Realizada'')) dsc',
'      ,t.cod_turma                                                                      ret                                   ',
'  FROM tr_turmas t',
' WHERE (t.cod_turma = :P2_TURMAX OR :P2_TURMAX IS NULL)',
'   AND t.cod_curso  = :P2_CURSO',
'   AND EXISTS(SELECT 1 ',
'                FROM tr_turma_participantes x ',
'               WHERE x.cod_empresa = :P2_EMPRESA ',
'                 AND x.cod_turma   = t.cod_turma ',
'                 AND x.cod_curso   = t.cod_curso) ',
'ORDER BY 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P2_EMPRESA,P2_CURSO'
,p_ajax_items_to_submit=>'P2_EMPRESA,P2_CURSO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6536234984207001321)
,p_name=>'P2_MATRICULA'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_item_default=>'NULL'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>unistr('MATR\00CDCULA')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(tq.matricula,6,0)||'' - ''||INITCAP(p.nome) dsc',
'      ,tq.matricula                                   ret',
'  FROM tr_turma_participantes tq   ',
'      ,inf_pessoais           p    ',
'      ,informacoes_funcionais f',
' WHERE p.cod_empresa = tq.cod_empresa',
'   and p.cod_empresa = f.cod_empresa',
'   AND p.matricula   = tq.matricula',
'   and p.matricula = f.matricula',
'   AND tq.cod_empresa = :P2_EMPRESA',
'   AND tq.cod_turma   = :P2_TURMA',
'   AND tq.cod_curso   = :P2_CURSO',
'   AND tq.tipo_participante = ''F'' ',
'   and f_acesso_pg_apex(f.cod_empresa, f.matricula, f.filial, f.cd_nivel, :P_USUARIO, :P_PAINEL) = ''S''',
'UNION',
'SELECT LPAD(tq.matricula,6,0)||'' - ''||INITCAP(pc.nome) dsc',
'      ,tq.matricula                                   ret',
'  FROM tr_turma_participantes tq   ',
'      ,inf_pessoais_candidato pc   ',
' WHERE pc.empresa       = tq.cod_empresa',
'   AND pc.cod_candidato = tq.matricula',
'   AND tq.cod_empresa   = :P2_EMPRESA',
'   AND tq.cod_turma     = :P2_TURMA',
'   AND tq.cod_curso     = :P2_CURSO',
'   AND tq.tipo_participante = ''C''   ',
'ORDER BY 2',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P2_EMPRESA,P2_CURSO,P2_TURMA'
,p_ajax_items_to_submit=>'P2_EMPRESA,P2_CURSO,P2_TURMA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>6
,p_field_template=>wwv_flow_api.id(7105155148032642160)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Turma'
,p_attribute_08=>'380'
,p_attribute_09=>'400'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6536235858575001329)
,p_name=>'P2_DT_RESPOSTA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(6368741289306808664)
,p_prompt=>'DATA RESPOSTA'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(7105154798914642160)
,p_item_icon_css_classes=>'fa-lg fa-calendar'
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6368740882762808660)
,p_name=>'DisparaAlerta'
,p_event_sequence=>1010
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_ERR_MSG'
,p_condition_element=>'P2_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6368740979870808661)
,p_event_id=>wwv_flow_api.id(6368740882762808660)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P2_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P2_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6546880402177094432)
,p_event_id=>wwv_flow_api.id(6368740882762808660)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_EMPRESA,P2_CURSO,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6536238236215001353)
,p_event_id=>wwv_flow_api.id(6368740882762808660)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(6536237344753001344)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924981289784569399)
,p_event_id=>wwv_flow_api.id(6368740882762808660)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(5924980036784569387)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6368741103663808662)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1020
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6368741274138808663)
,p_event_id=>wwv_flow_api.id(6368741103663808662)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5873396892664702813)
,p_name=>'SetDataResp'
,p_event_sequence=>1040
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P2_QUESTIONARIO,P2_MATRICULA'
,p_condition_element=>'P2_QUESTIONARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5873397012742702814)
,p_event_id=>wwv_flow_api.id(5873396892664702813)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_DT_RESPOSTA'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MAX(tq.data_resposta)',
'  FROM tr_questionario_participante tq',
' WHERE tq.cod_empresa      = :P2_EMPRESA',
'   AND tq.matricula        = :P2_MATRICULA',
'   AND tq.cod_turma        = :P2_TURMA',
'   AND tq.cod_questionario = :P2_QUESTIONARIO',
'   AND tq.cod_curso        = :P2_CURSO'))
,p_attribute_07=>'P2_EMPRESA,P2_CURSO,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5873397244158702817)
,p_event_id=>wwv_flow_api.id(5873396892664702813)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_DT_RESPOSTA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924979926442569385)
,p_name=>'VerifParametros'
,p_event_sequence=>1045
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(6536237344753001344)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924979987330569386)
,p_event_id=>wwv_flow_api.id(5924979926442569385)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P2_EMPRESA IS NULL THEN',
'    vMsg := ''EMPRESA deve ser informada!'';',
'  END IF;',
'  --',
'  IF vMsg IS NULL THEN',
'    IF :P2_CURSO IS NULL THEN',
'      vMsg := ''CURSO deve ser informado!'';',
'    END IF;  ',
'  END IF;',
'  --',
'  IF vMsg IS NULL THEN',
'    IF :P2_TURMA IS NULL THEN',
'      vMsg := ''TURMA deve ser informada!'';',
'    END IF;  ',
'  END IF;  ',
'  --',
'  IF vMsg IS NULL THEN',
'    IF :P2_MATRICULA IS NULL THEN',
unistr('      vMsg := ''MATR\00CDCULA deve ser informada!'';'),
'    END IF;  ',
'  END IF;   ',
'  --',
'  IF vMsg IS NULL THEN',
'    IF :P2_QUESTIONARIO IS NULL THEN',
unistr('      vMsg := ''QUESTION\00C1RIO deve ser informado!'';'),
'    END IF;  ',
'  END IF;   ',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P2_ERR_MSG := vMsg;',
'  ELSE',
'    :P2_ERR_MSG := NULL;',
'  END IF;',
'END;'))
,p_attribute_02=>'P2_EMPRESA,P2_CURSO,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO,P2_ERR_MSG'
,p_attribute_03=>'P2_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5894468277764882420)
,p_name=>'RefreshPerguntas'
,p_event_sequence=>1050
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(6536237344753001344)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5894468357610882421)
,p_event_id=>wwv_flow_api.id(5894468277764882420)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(5894467873768882416)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924980564047569392)
,p_name=>'HabilitaParametros'
,p_event_sequence=>1060
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(5924980036784569387)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924981562720569402)
,p_event_id=>wwv_flow_api.id(5924980564047569392)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_CODQUEST,P2_QUESTIONARIO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924981730528569403)
,p_event_id=>wwv_flow_api.id(5924980564047569392)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(5894467873768882416)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924980691047569393)
,p_event_id=>wwv_flow_api.id(5924980564047569392)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_EMPRESA,P2_CURSO,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924981431579569400)
,p_event_id=>wwv_flow_api.id(5924980564047569392)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(6536237344753001344)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924981495725569401)
,p_event_id=>wwv_flow_api.id(5924980564047569392)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(5924980036784569387)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924980907051569395)
,p_name=>'HideBT_FILTRAR'
,p_event_sequence=>1070
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924980996075569396)
,p_event_id=>wwv_flow_api.id(5924980907051569395)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(5924980036784569387)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(5924983452479569421)
,p_name=>'Resposta - Dialog Close'
,p_event_sequence=>1080
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(5894467873768882416)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5924983615465569422)
,p_event_id=>wwv_flow_api.id(5924983452479569421)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(5894467873768882416)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(5935781259587302880)
,p_event_id=>wwv_flow_api.id(5924983452479569421)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P2_DT_RESPOSTA'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT MAX(tq.data_resposta)',
'  FROM tr_questionario_participante tq',
' WHERE tq.cod_empresa      = :P2_EMPRESA',
'   AND tq.matricula        = :P2_MATRICULA',
'   AND tq.cod_turma        = :P2_TURMA',
'   AND tq.cod_questionario = :P2_QUESTIONARIO',
'   AND tq.cod_curso        = :P2_CURSO'))
,p_attribute_07=>'P2_EMPRESA,P2_TURMA,P2_MATRICULA,P2_QUESTIONARIO,P2_CURSO'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6536238703365001358)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ClearValores'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P2_EMPRESA      := NULL;',
'  :P2_CURSO        := NULL;',
'  :P2_TURMA        := NULL;',
'  :P2_MATRICULA    := NULL;',
'  :P2_QUESTIONARIO := NULL;  ',
'  :P2_DT_RESPOSTA  := NULL;',
'END;'))
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
