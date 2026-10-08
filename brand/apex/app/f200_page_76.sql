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
--   Date and Time:   23:00 Monday September 28, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 76
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00076
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>76);
end;
/
prompt --application/pages/page_00076
begin
wwv_flow_api.create_page(
 p_id=>76
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Posi\00E7\00E3o')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Posi\00E7\00E3o')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P76_VALOR").disable();',
'',
'$(''#BTN_LOCAL'').appendTo($(''#P76_COD_LOCAL_TRAB_CONTAINER .t-Form-itemWrapper''));'))
,p_inline_css=>'#P76_COD_LOCAL_TRAB_CONTAINER .t-Form-itemWrapper{    display: block !important}#BTN_LOCAL{ line-height: 3rem;}'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('DESENHO DA TELA (Natcorp_Requisicao.css / Natcorp_Requisicao.js, os mesmos da Requisi\00E7\00E3o de Pessoal)'),
'',
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-req-etapas       Informa\00E7\00F5es de Vaga: o resumo da vaga no alto, a faixa da aprova\00E7\00E3o e o menu das etapas.'),
unistr('  nc-req-etapa        cada etapa (Identifica\00E7\00E3o, Cargo, Remunera\00E7\00E3o, Perfil, Detalhamento, Pr\00E9via do an\00FAncio):'),
unistr('                      uma por vez; o nome no menu \00E9 o t\00EDtulo da regi\00E3o. Se\00E7\00E3o nova: ponha dentro de uma etapa.'),
unistr('  nc-req-ficha        se\00E7\00E3o que se l\00EA como documento; "Editar" abre o formul\00E1rio (que continua na p\00E1gina).'),
unistr('  nc-req-solicitacao  Solicita\00E7\00E3o (&P76_TITULO.): n\00FAmero, situa\00E7\00E3o, data e solicitante.'),
unistr('  nc-req-aprovadores  Aprovadores: faixa horizontal abaixo do resumo; Aprovar/Reprovar v\00E3o para ela.'),
'  nc-req-lista        Ferramentas de Apoio / Equipamentos: as linhas viram etiquetas.',
unistr('  nc-req-escrita / nc-req-textos   a descri\00E7\00E3o (com contador) e as observa\00E7\00F5es.'),
unistr('  nc-req-previa       o an\00FAncio (vazia no APEX; o JS desenha).'),
'',
unistr('Os bot\00F5es e links s\00E3o os do APEX (s\00F3 mudam de lugar na tela). Para desligar tudo: tire as duas'),
unistr('URLs de arquivo. Guia: brand/apex/app/REQUISICAO-MANUTENCAO.md (se\00E7\00E3o Requisi\00E7\00E3o de Posi\00E7\00E3o).')))
,p_last_updated_by=>'DANIEL.TASSO'
,p_last_upd_yyyymmddhh24miss=>'20260424170753'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281826669128151846119)
,p_plug_name=>'Escolha: Ferramentas de Apoio / Equipamentos'
,p_region_template_options=>'#DEFAULT#:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503491494631346639)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281956106811145282642)
,p_name=>'Aprovadores'
,p_region_css_classes=>'nc-req-aprovadores'
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_REQUISICAO_VAGA a, usuario_oracle u',
' where a.cod_requisicao = :p76_cod_requisicao',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   --and u.cd_perfil NOT IN (''BUSINESS PARTNER'',''REMUNERACAO'',''CONT DE NEGOCIOS'')',
'   and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_REQUISICAO_VAGA a, usuario_oracle u',
' where a.cod_requisicao = :p76_cod_requisicao',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from APROVA_REQUISICAO_VAGA',
' where cod_requisicao = :p76_cod_requisicao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P76_COD_REQUISICAO'
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
 p_id=>wwv_flow_api.id(271841160414404165892)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_lov_show_nulls=>'YES'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841160757658165893)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841161152221165894)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841161549063165895)
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
 p_id=>wwv_flow_api.id(271841162013313165896)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841162365282165897)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270734068043557229876)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269940535564024165763)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>7
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281956110385414282647)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(281503484930988346629)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281956112029115282649)
,p_plug_name=>unistr('Solicita\00E7\00E3o')
,p_region_css_classes=>'nc-req-ficha nc-req-solicitacao'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000001)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281956119091269282656)
,p_plug_name=>unistr('Informa\00E7\00F5es de Vaga')
,p_region_css_classes=>'nc-req-etapas'
,p_region_name=>'INF_VAGA'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000001)
,p_plug_name=>unistr('Identifica\00E7\00E3o')
,p_region_name=>'IDENTIFICACAO'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra Informa\00E7\00F5es da Vaga. O nome no menu das etapas \00E9 o t\00EDtulo desta regi\00E3o.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000002)
,p_plug_name=>'Cargo'
,p_region_name=>'CARGO_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra Cargo, Frequ\00EAncia. O nome no menu das etapas \00E9 o t\00EDtulo desta regi\00E3o.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000003)
,p_plug_name=>unistr('Remunera\00E7\00E3o')
,p_region_name=>'REMUNERACAO_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra Remunera\00E7\00E3o, Insalubridade / Periculosidade, Projeto, Contrato, Vaga Fatur\00E1vel. O nome no menu das etapas \00E9 o t\00EDtulo desta regi\00E3o.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000004)
,p_plug_name=>'Perfil'
,p_region_name=>'PERFIL_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra PCD, Ferramentas de Apoio / Equipamentos. O nome no menu das etapas \00E9 o t\00EDtulo desta regi\00E3o.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000005)
,p_plug_name=>'Detalhamento'
,p_region_name=>'DETALHAMENTO_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa do desenho da ficha da vaga (Natcorp_Requisicao.js): mostra Descri\00E7\00E3o de Atividades, Observa\00E7\00F5es / Pol\00EDticas / Detalhes da Vaga. O nome no menu das etapas \00E9 o t\00EDtulo desta regi\00E3o.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000006)
,p_plug_name=>unistr('Pr\00E9via do an\00FAncio')
,p_region_name=>'PREVIA_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_region_css_classes=>'nc-req-etapa nc-req-etapa-previa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('\00DAltima etapa: como a vaga aparece para o candidato. Vazia de prop\00F3sito: o Natcorp_Requisicao.js desenha o an\00FAncio e a confer\00EAncia "Antes de publicar". Se o JS n\00E3o carregar, o CSS a esconde.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999076000000000007)
,p_plug_name=>'Como o candidato vai ver'
,p_region_name=>'PREVIA_ANUNCIO'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000006)
,p_region_css_classes=>'nc-req-previa'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('O an\00FAncio desenhado pelo Natcorp_Requisicao.js (cargo, empresa, descri\00E7\00E3o e requisitos).')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834031619752608829)
,p_plug_name=>unistr('Informa\00E7\00F5es da Vaga')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000001)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834031734325608830)
,p_plug_name=>'Cargo'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000002)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834031894738608831)
,p_plug_name=>unistr('Frequ\00EAncia')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000002)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834031911414608832)
,p_plug_name=>unistr('Remunera\00E7\00E3o')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000003)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032064632608833)
,p_plug_name=>'Insalubridade / Periculosidade'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000003)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032097593608834)
,p_plug_name=>'Projeto'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000003)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032229488608835)
,p_plug_name=>'Contrato'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000003)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032377127608836)
,p_plug_name=>unistr('Vaga Fatur\00E1vel')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000003)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032461658608837)
,p_plug_name=>'PCD'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000004)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032503838608838)
,p_plug_name=>unistr('Descri\00E7\00E3o de Atividades')
,p_region_css_classes=>'nc-req-escrita'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000005)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(268834032604826608839)
,p_plug_name=>unistr('Observa\00E7\00F5es / Pol\00EDticas / Detalhes da Vaga')
,p_region_css_classes=>'nc-req-textos'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000005)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281943547685159807706)
,p_name=>'Ferramentas de Apoio / Equipamentos'
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(282999076000000000004)
,p_template=>wwv_flow_api.id(281503492925310346642)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select B.cod_beneficio codigo, initcap(B.descr_beneficio) descricao, B.valor_padrao valor, :P76_SEQ SEQ',
'from   beneficios B, beneficios_vaga_temp t',
'where b.cod_beneficio = t.cod_beneficio',
'  and nvl(t.cod_requisicao,0) = nvl(:p76_cod_requisicao,0)',
'  and t.seq = nvl(:p76_seq,t.seq)',
'order by 2'))
,p_display_when_condition=>'P76_COD_REQ'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P76_SEQ'
,p_query_row_template=>wwv_flow_api.id(281503501736864346658)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841157666978165887)
,p_query_column_id=>1
,p_column_alias=>'CODIGO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841158091305165888)
,p_query_column_id=>2
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Descri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841158530899165889)
,p_query_column_id=>3
,p_column_alias=>'VALOR'
,p_column_display_sequence=>4
,p_column_heading=>'Valor'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841158868673165890)
,p_query_column_id=>4
,p_column_alias=>'SEQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271841159254017165891)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from beneficios_vaga_temp where seq = #SEQ# and cod_beneficio = #CODIGO#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CODIGO#" class="apagarBeneficio t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P76_COD_REQUISICAO'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281956129880412282664)
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
 p_id=>wwv_flow_api.id(271841165837211165900)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_button_name=>'p76_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P76 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P76_COD_EMPRESA_SOLICITANTE.,&P76_MAT_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(150022873185159217050)
,p_button_sequence=>160
,p_button_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_button_name=>'ADD_LOCAL'
,p_button_static_id=>'BTN_LOCALX'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Local'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select utiliza_secao',
'  from parametros_recursos_humanos ',
' where utiliza_secao = ''S''',
'    and :p76_rowid is null',
'    and 1 = 2'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-plus'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841162823456165897)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281956106811145282642)
,p_button_name=>'p76_btn_reprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_existe_aprov_pendente varchar2(1) := ''N'';',
'v_saida_erro exception;',
'      ',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'cursor c0 is',
'select mat_aprov',
'  from APROVA_REQUISICAO_VAGA',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'  select seq_aprov',
'  from APROVA_REQUISICAO_VAGA aav',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if 1 = 2 then',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'IF V_C0.MAT_APROV IS NOT NULL THEN',
'',
'  begin',
'        --',
'    select distinct ''S''',
'      into v_existe_aprov_pendente',
'      from APROVA_REQUISICAO_VAGA aav',
'     where aav.status_aprov = ''P''',
'       and aav.seq_aprov < v_c1.seq_aprov',
'       and aav.cod_requisicao = :p76_cod_requisicao;',
'        --',
'  exception',
'  when no_data_found then',
'    v_existe_aprov_pendente := ''N'';',
'  when others then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Erro ao validar a sequ\00EAncia de aprova\00E7\00F5es: ''||sqlerrm;'),
'    raise v_saida_erro;',
'  end;',
'  -- ',
'  if v_existe_aprov_pendente = ''S'' then',
'      --',
'      v_flg_retorno := ''N'';',
unistr('      v_msg_retorno := ''\00C9 necess\00E1rio a aprova\00E7\00E3o de uma sequ\00EAncia anterior para qualquer altera\00E7\00E3o!'';'),
'      raise v_saida_erro;',
'      --',
'  end if;',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'end if;',
'  --',
'end if;',
'',
'return false;',
'  ',
'exception',
'  when others then',
'return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940535690614165764)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281956106811145282642)
,p_button_name=>'p76_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P76_COD_REQUISICAO.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_existe_aprov_pendente varchar2(1) := ''N'';',
'v_saida_erro exception;',
'      ',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'cursor c0 is',
'select mat_aprov',
'  from APROVA_REQUISICAO_VAGA',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'  select seq_aprov',
'  from APROVA_REQUISICAO_VAGA aav',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'IF V_C0.MAT_APROV IS NOT NULL THEN',
'',
'  begin',
'        --',
'    select distinct ''S''',
'      into v_existe_aprov_pendente',
'      from APROVA_REQUISICAO_VAGA aav',
'     where aav.status_aprov = ''P''',
'       and aav.seq_aprov < v_c1.seq_aprov',
'       and aav.cod_requisicao = :p76_cod_requisicao;',
'        --',
'  exception',
'  when no_data_found then',
'    v_existe_aprov_pendente := ''N'';',
'  when others then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Erro ao validar a sequ\00EAncia de aprova\00E7\00F5es: ''||sqlerrm;'),
'    raise v_saida_erro;',
'  end;',
'  -- ',
'  if v_existe_aprov_pendente = ''S'' then',
'      --',
'      v_flg_retorno := ''N'';',
unistr('      v_msg_retorno := ''\00C9 necess\00E1rio a aprova\00E7\00E3o de uma sequ\00EAncia anterior para qualquer altera\00E7\00E3o!'';'),
'      raise v_saida_erro;',
'      --',
'  end if;',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'end if;',
'  --',
'exception',
'  when others then',
'return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841163938143165898)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281956110385414282647)
,p_button_name=>'CANCEL'
,p_button_static_id=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841164337339165899)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281956110385414282647)
,p_button_name=>'CANCEL_1'
,p_button_static_id=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841164737498165899)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281956110385414282647)
,p_button_name=>'SAVE'
,p_button_static_id=>'#P76_SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p76_cod_sit_requisicao not in (2,3,4) and :p76_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841165110802165899)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281956110385414282647)
,p_button_name=>'CREATE'
,p_button_static_id=>'P76_CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P76_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841163193700165898)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281956106811145282642)
,p_button_name=>'p76_btn_aprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_existe_aprov_pendente varchar2(1) := ''N'';',
'v_saida_erro exception;',
'      ',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'cursor c0 is',
'select mat_aprov',
'  from APROVA_REQUISICAO_VAGA',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'  select seq_aprov',
'  from APROVA_REQUISICAO_VAGA aav',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if 1 = 2 then',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'IF V_C0.MAT_APROV IS NOT NULL THEN',
'',
'  begin',
'        --',
'    select distinct ''S''',
'      into v_existe_aprov_pendente',
'      from APROVA_REQUISICAO_VAGA aav',
'     where aav.status_aprov = ''P''',
'       and aav.seq_aprov < v_c1.seq_aprov',
'       and aav.cod_requisicao = :p76_cod_requisicao;',
'        --',
'  exception',
'  when no_data_found then',
'    v_existe_aprov_pendente := ''N'';',
'  when others then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Erro ao validar a sequ\00EAncia de aprova\00E7\00F5es: ''||sqlerrm;'),
'    raise v_saida_erro;',
'  end;',
'  -- ',
'  if v_existe_aprov_pendente = ''S'' then',
'      --',
'      v_flg_retorno := ''N'';',
unistr('      v_msg_retorno := ''\00C9 necess\00E1rio a aprova\00E7\00E3o de uma sequ\00EAncia anterior para qualquer altera\00E7\00E3o!'';'),
'      raise v_saida_erro;',
'      --',
'  end if;',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'end if;',
'  --',
'end if;',
'',
'return false;',
'  ',
'exception',
'  when others then',
'return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940535768525165765)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281956106811145282642)
,p_button_name=>'p76_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P76_COD_REQUISICAO.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_existe_aprov_pendente varchar2(1) := ''N'';',
'v_saida_erro exception;',
'      ',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'cursor c0 is',
'select mat_aprov',
'  from APROVA_REQUISICAO_VAGA',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'  select seq_aprov',
'  from APROVA_REQUISICAO_VAGA aav',
' where cod_requisicao = :p76_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'  open c0;',
'  fetch c0 into v_c0;',
'  close c0;',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'IF V_C0.MAT_APROV IS NOT NULL THEN',
'',
'  begin',
'        --',
'    select distinct ''S''',
'      into v_existe_aprov_pendente',
'      from APROVA_REQUISICAO_VAGA aav',
'     where aav.status_aprov = ''P''',
'       and aav.seq_aprov < v_c1.seq_aprov',
'       and aav.cod_requisicao = :p76_cod_requisicao;',
'        --',
'  exception',
'  when no_data_found then',
'    v_existe_aprov_pendente := ''N'';',
'  when others then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Erro ao validar a sequ\00EAncia de aprova\00E7\00F5es: ''||sqlerrm;'),
'    raise v_saida_erro;',
'  end;',
'  -- ',
'  if v_existe_aprov_pendente = ''S'' then',
'      --',
'      v_flg_retorno := ''N'';',
unistr('      v_msg_retorno := ''\00C9 necess\00E1rio a aprova\00E7\00E3o de uma sequ\00EAncia anterior para qualquer altera\00E7\00E3o!'';'),
'      raise v_saida_erro;',
'      --',
'  end if;',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'end if;',
'  --',
'exception',
'  when others then',
'return false;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841159697291165892)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281943547685159807706)
,p_button_name=>'chama_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P76_COD_REQUISICAO'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271841156245473165886)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281826669128151846119)
,p_button_name=>'Add_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(271841270517931165969)
,p_branch_name=>'Go To Page 75'
,p_branch_action=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(271841270084952165968)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(148136052757285371901)
,p_name=>'P76_URL_LOCAL_FULL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268802706676786074001)
,p_name=>'P76_TRAB_INTERMITENTE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>'Trabalho Intermitente'
,p_source=>'TRAB_INTERMITENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268834031582198608828)
,p_name=>'P76_TIPO_MODALIDADE'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(268834031894738608831)
,p_use_cache_before_default=>'NO'
,p_item_default=>'P'
,p_prompt=>'Tipo de Modalidade'
,p_source=>'TIPO_MODALIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(DESCRICAO) DESCRICAO, TIPO_MODALIDADE',
'  FROM TIPO_MODALIDADE_TRAB',
' WHERE COD_EMPRESA = :P76_COD_EMPRESA',
'  -- AND ((:p76_cod_sit_requisicao in (2,3,4,5)) or (ATIVO = ''S''))',
'  AND ATIVO = ''S''',
' ORDER BY CASE WHEN TIPO_MODALIDADE = ''P'' THEN ''A'' WHEN TIPO_MODALIDADE = ''S'' THEN ''B'' ELSE TIPO_MODALIDADE END'))
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_COD_SIT_REQUISICAO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268834032782846608840)
,p_name=>'P76_VLR_AUX_TIPO_MODALIDADE'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Valor de Aux\00EDlio<br><i><small>Tipo de Modalidade</small></i>')
,p_placeholder=>'Exemplo: 19999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'99999990D00'
,p_source=>'VLR_AUX_TIPO_MODALIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268834033907003608852)
,p_name=>'P76_PERC_BENEFICIO'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_source=>'PERC_BENEFICIO_VARIAVEL'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271331845270630489536)
,p_name=>'P76_ABRE_REQ_PESSOAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_source=>'ABRE_REQ_PESSOAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>unistr('STATIC:Abrir Requisi\00E7\00E3o de Pessoal;S')
,p_colspan=>3
,p_grid_label_column_span=>0
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--large'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841156571671165886)
,p_name=>'P76_BENEFICIO_VAGA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281826669128151846119)
,p_prompt=>unistr('Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descr_beneficio)||'' - Valor: ''||valor_padrao descricao, cod_beneficio codigo',
'from   beneficios',
'where cod_beneficio not in (select x.cod_beneficio from beneficios_vaga_temp x where x.seq = :p76_seq)',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841157001203165887)
,p_name=>'P76_VALOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281826669128151846119)
,p_prompt=>'Valor'
,p_format_mask=>'99999990D00'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841166151432165900)
,p_name=>'P76_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841166621984165900)
,p_name=>'P76_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841167001414165901)
,p_name=>'P76_ITEM_VALIDACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841167363782165901)
,p_name=>'P76_FLAG'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841167844117165901)
,p_name=>'P76_MENSAGEM'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841168175873165902)
,p_name=>'P76_MENSAGEM_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841168592601165902)
,p_name=>'P76_OK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841168985437165902)
,p_name=>'P76_COD_REQUISICAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P76_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841169375013165902)
,p_name=>'P76_COD_SIT_REQUISICAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select Initcap(desc_sit_REQ) descricao, cod_sit_req',
'   from SIT_REQ',
'   order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841169770932165903)
,p_name=>'P76_DATA_REQUISICAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Abertura'
,p_source=>'DATA_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_read_only_when=>'P76_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841170219738165903)
,p_name=>'P76_DISPLAY_VAGA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_prompt=>'Vaga'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('SELECT distinct NVL(V.COD_VAGA,''* Vaga ainda n\00E3o criada'') vaga'),
'  FROM REQUISICAO_VAGA R, CL_VAGA V',
' WHERE R.COD_EMPRESA = V.COD_EMPRESA (+)',
'   AND R.COD_REQUISICAO = V.COD_REQUISICAO (+)',
'   and R.COD_EMPRESA = :P76_COD_EMPRESA',
'   AND R.COD_REQUISICAO = :P76_COD_REQUISICAO',
'   order by 1'))
,p_source_type=>'QUERY_COLON'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841170564449165903)
,p_name=>'P76_SOLICITANTE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
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
 p_id=>wwv_flow_api.id(271841171010480165903)
,p_name=>'P76_UTILIZA_SECAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841171378501165904)
,p_name=>'P76_SEQ'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841171827659165904)
,p_name=>'P76_USUARIO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841172212732165904)
,p_name=>'P76_DT_ATUALIZACAO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841172606379165904)
,p_name=>'P76_COD_EMPRESA_SOLICITANTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841173035153165905)
,p_name=>'P76_MAT_SOLICITANTE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841173415116165905)
,p_name=>'P76_COD_FILIAL_SOLICITANTE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FILIAL_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841173809949165905)
,p_name=>'P76_COD_CCUSTO_SOLICITANTE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CCUSTO_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841174210124165906)
,p_name=>'P76_COD_CARGO_SOLICITANTE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281956112029115282649)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841174906089165906)
,p_name=>'P76_COD_TIPO_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_TIPO_PROCESSO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841175310905165907)
,p_name=>'P76_COD_METRICA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_METRICA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841175657710165907)
,p_name=>'P76_DATA_INICIO'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de In\00EDcio')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DATA_INICIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>unistr('ch39846 - tornar label e campo obrigat\00F3rios conforme est\00E1 na estrutura da tabela')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841176088599165907)
,p_name=>'P76_DATA_FIM'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Encerramento'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DATA_FIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_item_comment=>unistr('ch39846 - tornar label e campo obrigat\00F3rios conforme est\00E1 na estrutura da tabela')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841176462758165907)
,p_name=>'P76_VAGA_CONFIDENCIAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Vaga Confidencial'
,p_source=>'VAGA_CONFIDENCIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841176890626165908)
,p_name=>'P76_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod',
'  from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P76_COD_REQUISICAO is null) or ',
'        (:P76_COD_REQUISICAO is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_REQUISICAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841177341578165908)
,p_name=>'P76_IND_SERV_ALOCA_COLAB'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841177739906165908)
,p_name=>'P76_COD_FILIAL'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(SIGLA) descricao, cod_filial',
'  from filiais',
' where cod_empresa = :p76_cod_empresa',
'and ((nvl(encer_ativ,''N'') = ''N'' AND SIT NOT IN (''E'',''I'')) AND :P116_ROWID IS NULL)',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841178078352165908)
,p_name=>'P76_COD_CCUSTO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_source=>'COD_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_ccusto||'' - ''||initcap(c.nome) descricao, f.cod_ccusto',
'  from filial_ccusto f, centro_de_custo c',
' where f.cod_empresa = c.cod_empresa',
'   and f.cod_ccusto  = c.cod',
'   and f.cod_empresa = :p76_cod_empresa',
'   and f.cod_filial  = :p76_cod_filial',
'   and sysdate between c.dt_inic_vige and c.dt_fim_vige  ',
'   and F_ACESSO_CC(C.COD_EMPRESA, C.COD) = ''S''',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_COD_FILIAL,P_USUARIO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841178545836165909)
,p_name=>'P76_COD_UNIDADE_ADM'
,p_is_required=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Unidade Administrativa (Cliente)'
,p_source=>'COD_UNIDADE_ADM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
', a.cod_unidade_adm cod',
'  from unidade_administrativa a, SECAO S',
' where a.cod_empresa = :p76_cod_empresa',
'   and a.cod_filial = :p76_cod_filial',
'  -- and a.cod_empresa = s.cod_emp_unid_adm',
'   and a.cod_unidade_adm = s.cod_unid_adm',
' --  and s.cod_emp_ccusto = :p76_cod_empresa',
'   and s.cod_ccusto = :p76_cod_ccusto',
'   and s.ativo = ''S''',
'   and :p76_utiliza_secao = ''S''',
'union',
'select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
', a.cod_unidade_adm cod',
'  from unidade_administrativa a',
' where a.cod_empresa = :p76_cod_empresa',
'   and a.cod_filial = :p76_cod_filial',
'   and :p76_utiliza_secao = ''N''',
'order by 1',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_CCUSTO,P76_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841178903579165910)
,p_name=>'P76_ATIVIDADE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_source=>'COD_ATIVIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'  from atividade t, secao s',
' where t.cod = s.cod_atividade',
'   -- and s.cod_emp_ccusto = :p76_cod_empresa',
'   and s.cod_ccusto = :p76_cod_ccusto',
'   and s.cod_unid_adm = :p76_cod_unidade_adm',
'   and s.ativo = ''S''',
'   and :p76_utiliza_secao = ''S''',
'union',
'  select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     and :p76_utiliza_secao = ''N''',
'   order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_CCUSTO,P76_COD_UNIDADE_ADM,P76_UTILIZA_SECAO'
,p_ajax_items_to_submit=>'P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
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
 p_id=>wwv_flow_api.id(271841179302967165910)
,p_name=>'P76_COD_LOCAL_TRAB'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local de Trabalho'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, filial_local f',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       AND l.cod_local_trab = f.cod_local_filial',
'       and not exists (select 1 from unid_adm_secao_local u where u.cod_local_trab = l.cod_local_trab)',
'       AND F.COD_EMPRESA = :p76_COD_EMPRESA',
'       AND F.COD_FILIAL = :P76_COD_FILIAL',
'UNION',
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, unid_adm_secao_local u',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       and l.cod_local_trab = u.cod_local_trab',
'       AND U.COD_EMPRESA = :p76_COD_EMPRESA',
'       AND U.COD_UNIDADE_ADM = :P76_COD_UNIDADE_ADM',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_UNIDADE_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841179692891165911)
,p_name=>'P76_COD_CCUSTO_CONTAB'
,p_is_required=>true
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C.Custo Cont\00E1bil')
,p_source=>'COD_CCUSTO_CONTAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct b.cod||'' - ''||initcap(b.nome) nome, b.cod codigo',
'  from ccusto_contab b, secao s',
' where b.cod_empresa = :p76_cod_empresa',
'   and b.cod = s.cod_ccusto_contab',
'  -- and s.cod_emp_ccusto = :p76_cod_empresa',
'   and s.cod_ccusto = :p76_cod_ccusto',
'   and s.cod_unid_adm = :p76_cod_unidade_adm',
'   and s.cod_atividade = :p76_atividade',
'   and s.ativo = ''S''',
'   and :p76_utiliza_secao = ''S''',
'union',
'select distinct b.cod||'' - ''||initcap(b.nome) nome, b.cod codigo',
'  from ccusto_contab b',
' where b.cod_empresa = :p76_cod_empresa',
'   and :p76_utiliza_secao = ''N''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_CCUSTO,P76_COD_UNIDADE_ADM,P76_ATIVIDADE,P76_UTILIZA_SECAO,P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841180126808165911)
,p_name=>'P76_COD_UN_NEGOCIO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Unidade de Neg\00F3cio')
,p_source=>'COD_UN_NEGOCIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod_un_negocio||'' - ''||initcap(a.nome_un_negocio) descricao, a.cod_un_negocio codigo',
'  from unidade_de_negocio a',
' where a.cod_empresa = :p76_cod_empresa',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA'
,p_ajax_items_to_submit=>'P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841180450236165911)
,p_name=>'P76_VINCULO'
,p_is_required=>true
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('V\00EDnculo')
,p_source=>'VINCULO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||Initcap(a.nome) descricao, a.cod codigo',
'      from vinculo_empreg a',
'      where ((:p76_rowid is null and a.cod <> ''V'') or ',
'             (:p76_rowid is not null))',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841180915218165912)
,p_name=>'P76_COD_CARGO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cargo'
,p_source=>'COD_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.descricao, x.cod',
'  from (',
'select SUBSTR(c.cod,1,7)||'' - ''||initcap(c.nome) descricao , cod',
'  from cargos_empresas e, cargos c, parametros_recursos_humanos p',
' where e.cod_empresa = p.cod_empresa',
'   and e.cod_cargo = c.cod',
'   and c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and e.cod_empresa = :p76_cod_empresa',
'   and p.ind_empresa_cargo = ''S''',
'   /*',
'   and not exists (select 1 ',
'                    from cargos_ccusto cc ',
'                   where cc.cod_empresa = e.cod_empresa',
'                     and cc.cod_ccusto = :p76_cod_ccusto)',
'   */',
' union ',
'SELECT SUBSTR(c.cod,1,7)||'' - ''||initcap(nome) descricao , cod',
'  from cargos c',
' where c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and exists (select 1',
'                 from parametros_recursos_humanos p',
'                where p.cod_empresa = :p76_cod_empresa',
'                  and p.ind_empresa_cargo = ''N'')',
') x',
' where not exists (select 1',
'                     from cargos_ccusto c ',
'                    where c.cod_empresa = :p76_cod_empresa',
'                     and c.cod_cargo = x.cod',
'                  )',
' and exists (select 1',
'                     from cargos_empresas c ',
'                    where c.COD_EMPRESA = :p76_cod_empresa',
'                     and c.COD_CARGO = x.cod',
'                  )                  ',
'union',
'select SUBSTR(r.cod,1,7)||'' - ''||initcap(r.nome) descricao , cod',
'  from cargos r, cargos_ccusto c',
' where r.cod = c.cod_cargo',
'   and c.cod_empresa = :p76_cod_empresa',
'   and c.cod_ccusto = :p76_cod_ccusto',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_CCUSTO,P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841181301367165912)
,p_name=>'P76_COD_FUNCAO'
,p_is_required=>true
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_source=>'COD_FUNCAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' descricao, cod codigo',
'  from funcao',
' where sysdate between nvl(dt_inic_vig_funcao,sysdate) and nvl(dt_term_vig_funcao,sysdate)',
'   and cod_cargo = :p76_cod_cargo',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_CARGO'
,p_ajax_items_to_submit=>'P76_COD_CARGO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841181672473165912)
,p_name=>'P76_COD_CATEGORIA'
,p_is_required=>true
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Categoria'
,p_source=>'COD_CATEGORIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(C.NOME)||'' (''||a.cod_categoria||'')'' d, A.COD_CATEGORIA c',
'  FROM CATEGORIA_CARGO_REL A , CATEGORIA_GRUPOS_SALARIAIS B, CATEGORIA_CARGO C',
' WHERE A.COD_CAT_GRUPOS_SALARIAIS  = B.COD_CAT_GRUPOS_SALARIAIS ',
'   AND A.COD_CATEGORIA = C.COD',
'   AND A.COD_CARGO = :p76_cod_cargo',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_CARGO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841182071140165913)
,p_name=>'P76_COD_SINDICATO'
,p_is_required=>true
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(268834031734325608830)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Sindicato'
,p_source=>'COD_SINDICATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT S.COD||'' - ''||Initcap(S.sigla)||'' - ''||initcap(s.nome) descricao, S.COD codigo',
'FROM SINDICATOS S',
'WHERE S.COD_EMPRESA = :P76_COD_EMPRESA',
'and ((trunc(sysdate) >= nvl(s.dt_vigencia_inicial,trunc(sysdate)) and :P76_cod_requisicao is null) or (:P76_cod_requisicao is not null))',
'and nvl(s.sit,''A'') not in (''E'',''I'')',
'and s.cod <> 999',
'and not exists ',
'(',
'SELECT 1',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P76_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P76_cod_requisicao is null) or (:P76_cod_requisicao is not null))',
'   and (sx.filial = :P76_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = :P76_COD_CCUSTO or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = :P76_COD_UNIDADE_ADM or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = :P76_ATIVIDADE or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = :P76_COD_LOCAL_TRAB or sx.cod_local_trab is null)',
'   and exists (',
'            select 1 from SINDICATO_FILIAIS sfy where sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P76_COD_FILIAL UNION',
'            select 1 from SINDICATO_CCUSTO scy where scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = :P76_COD_CCUSTO UNION',
'            select 1 from SINDICATO_UNID_ADM suy where suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = :P76_COD_UNIDADE_ADM UNION',
'            select 1 from SINDICATO_ATIVIDADE say where say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = :P76_ATIVIDADE UNION',
'            select 1 from SINDICATO_LOCAL_TRAB sly where sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = :P76_COD_LOCAL_TRAB',
'           )',
')',
'union',
'SELECT Sx.COD_sindicato||'' - ''||Initcap(Sx.sigla)||'' - ''||initcap(sx.nome_sindicato) descricao, sx.cod_sindicato codigo',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P76_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P76_cod_requisicao is null) or (:P76_cod_requisicao is not null))',
'   and (sx.filial = :P76_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = :P76_COD_CCUSTO or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = :P76_COD_UNIDADE_ADM or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = :P76_ATIVIDADE or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = :P76_COD_LOCAL_TRAB or sx.cod_local_trab is null)',
'   and exists (',
'            select 1 from SINDICATO_FILIAIS sfy where sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P76_COD_FILIAL UNION',
'            select 1 from SINDICATO_CCUSTO scy where scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = :P76_COD_CCUSTO UNION',
'            select 1 from SINDICATO_UNID_ADM suy where suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = :P76_COD_UNIDADE_ADM UNION',
'            select 1 from SINDICATO_ATIVIDADE say where say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = :P76_ATIVIDADE UNION',
'            select 1 from SINDICATO_LOCAL_TRAB sly where sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = :P76_COD_LOCAL_TRAB',
'           )',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_COD_REQUISICAO,P76_COD_FILIAL,P76_COD_CCUSTO,P76_COD_UNIDADE_ADM,P76_ATIVIDADE,P76_COD_LOCAL_TRAB'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841182517540165913)
,p_name=>'P76_RT_JORNADA_MENSAL'
,p_is_required=>true
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(268834031894738608831)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Carga Hor\00E1ria')
,p_source=>'RT_JORNADA_MENSAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Select ''C\00F3digo: ''||R.cod||'' - ''||r.desc_regime descricao_regime, '),
'       R.cod codigo_regime',
'from REG_TRABALHO R',
'WHERE R.COD <> ''NUL''',
' AND R.COD_EMPRESA = :p76_cod_empresa',
' and not exists (select 1 ',
'                   from sind_reg_trabalho x ',
'                  where x.cod_empresa = r.cod_empresa ',
'                    and x.cod_sindicato = :p76_cod_sindicato',
'                   -- and x.cod_reg_trab = r.cod',
'                )',
' union',
unistr(' Select ''C\00F3digo: ''||R.cod||'' - ''||r.desc_regime descricao_regime, '),
'       R.cod codigo_regime',
'from REG_TRABALHO R, SIND_REG_TRABALHO S',
'WHERE R.COD <> ''NUL''',
' AND R.COD = S.COD_REG_TRAB',
' AND R.COD_EMPRESA = S.COD_EMPRESA',
' AND R.COD_EMPRESA = :p76_cod_empresa',
' AND S.COD_SINDICATO = :P76_COD_SINDICATO',
' order by 1--R.JORNADA_DIARIA_H, R.JORNADA_SEMANAL_H'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841182944988165914)
,p_name=>'P76_COD_HORARIO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(268834031894738608831)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Hor\00E1rio Contratual')
,p_source=>'COD_HORARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_horario||'' - ''||desc_horario descricao, cod_horario',
'  from cad_horario_trabalho ',
'where cod_empresa = :p76_cod_empresa ',
'  and COD_REG_TRAB = nvl(:p76_RT_JORNADA_MENSAL, cod_reg_trab)',
'order by desc_horario'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_COD_EMPRESA,P76_RT_JORNADA_MENSAL'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>4
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841183345216165914)
,p_name=>'P76_COD_HORARIO_JORNADA'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_HORARIO_JORNADA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT A.COD_JORNADA||'' - ''||A.NOME_JORNADA||'' - Total de Horas Mensais: ''||SUBSTR(A.TOTAL_HORAS_MENSAIS,1,INSTR(A.TOTAL_HORAS_MENSAIS,'':'')-1) DESCRICAO, A.COD_JORNADA COD',
'FROM PE_JORNADAS A , REG_TRABALHO B, PE_JORNADAS_LOCAL C',
'WHERE A.COD_EMPRESA = B.COD_EMPRESA',
'AND A.COD_EMPRESA = C.COD_EMPRESA (+)',
'AND A.COD_JORNADA = C.COD_JORNADA (+)',
'AND B.COD <> ''NUL''',
'and b.cod = nvl(:P76_RT_JORNADA_MENSAL,b.cod)',
'AND SUBSTR(A.TOTAL_HORAS_MENSAIS,1,INSTR(A.TOTAL_HORAS_MENSAIS,'':'')-1) = B.JORNADA_MENSAL_H',
'AND A.COD_EMPRESA = :P76_COD_EMPRESA',
'AND NVL(C.COD_LOCAL_TRAB,0) = NVL(NVL(:P76_COD_LOCAL_TRAB,C.COD_LOCAL_TRAB),0)',
'ORDER BY 1'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841183720013165914)
,p_name=>'P76_REFEITORIO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Possui Refeit\00F3rio?')
,p_source=>'REFEITORIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841184077059165914)
,p_name=>'P76_IND_INSALUB'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(268834032064632608833)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Insalubridade'
,p_source=>'IND_INSALUB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841184535389165915)
,p_name=>'P76_IND_PERIC'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(268834032064632608833)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Periculosidade'
,p_source=>'IND_PERIC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841184855289165915)
,p_name=>'P76_MARCA_PONTO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(268834031894738608831)
,p_use_cache_before_default=>'NO'
,p_item_default=>'S'
,p_prompt=>'Marca Ponto?'
,p_source=>'MARCA_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841185296647165915)
,p_name=>'P76_TP_REGISTRO_PONTO'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(268834031894738608831)
,p_use_cache_before_default=>'NO'
,p_item_default=>'F'
,p_prompt=>unistr('Tipo de Marca\00E7\00E3o')
,p_source=>'TP_REGISTRO_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Ambos;A,Fixo;F,M\00F3vel;M')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841185695190165915)
,p_name=>'P76_IND_DEF_FIS'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>'PCD'
,p_source=>'IND_DEF_FIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841186057304165916)
,p_name=>'P76_RAIS_IND_DEF_AUDITIVA'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Auditiva'
,p_source=>'RAIS_IND_DEF_AUDITIVA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841186516351165916)
,p_name=>'P76_RAIS_IND_DEF_FISICO'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('F\00EDsica')
,p_source=>'RAIS_IND_DEF_FISICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841186895376165916)
,p_name=>'P76_RAIS_IND_DEF_MENTAL'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Mental'
,p_source=>'RAIS_IND_DEF_MENTAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841187297333165916)
,p_name=>'P76_RAIS_IND_DEF_MULTIPLA'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Multipla'
,p_source=>'RAIS_IND_DEF_MULTIPLA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841187690610165917)
,p_name=>'P76_RAIS_IND_DEF_VISUAL'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(268834032461658608837)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Visual'
,p_source=>'RAIS_IND_DEF_VISUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841188059209165917)
,p_name=>'P76_TIPO_SALARIO'
,p_is_required=>true
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de Sal\00E1rio')
,p_source=>'TIPO_SALARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select INITCAP(descricao)||'' (''||cod||'')'' DESCRICAO,',
'       COD',
'  from tipo_salario',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841188466493165917)
,p_name=>'P76_TOTAL_SALARIO'
,p_is_required=>true
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Total Remunera\00E7\00E3o')
,p_placeholder=>'Exemplo: 1999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_TOTAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'',
'if :p76_rowid is not null then',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL);',
'return v_return;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841188918210165917)
,p_name=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_prompt=>unistr('% Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:20%;20,30%;30,Exce\00E7\00E3o;0')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'FULL CLT'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841189319471165918)
,p_name=>'P76_PERC_BENEF_EXCECAO'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_prompt=>unistr('% Benef. Exce\00E7\00E3o')
,p_format_mask=>'990D00'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_icon_css_classes=>'fa-percent'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841189708375165918)
,p_name=>'P76_REMUNERACAO_VARIAVEL'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Valor do Benef\00EDcio')
,p_placeholder=>'Exemplo: 19999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'99999990D00'
,p_source=>'REMUNERACAO_VARIAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841190145464165918)
,p_name=>'P76_VALOR_VERBA'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Sal\00E1rio')
,p_placeholder=>'Exemplo: 19999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_VERBA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'',
'if :p76_rowid is not null then',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL);',
'return v_return;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841190503809165919)
,p_name=>'P76_MOTIVO_EXCECAO'
,p_item_sequence=>540
,p_item_plug_id=>wwv_flow_api.id(268834031911414608832)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Motivo de Exce\00E7\00E3o')
,p_source=>'MOTIVO_EXCECAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841190945422165919)
,p_name=>'P76_TIPO_CONTRATO'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(268834032229488608835)
,p_use_cache_before_default=>'NO'
,p_item_default=>'I'
,p_prompt=>'Tipo de Contrato'
,p_source=>'TIPO_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Determinado;D,Indeterminado;I'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841191272435165919)
,p_name=>'P76_DT_PREVISAO_ADMISSAO'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(268834032229488608835)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Previs\00E3o de Admiss\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_PREVISAO_ADMISSAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841191652516165919)
,p_name=>'P76_DT_PREV_FIM_CONTRATO'
,p_item_sequence=>540
,p_item_plug_id=>wwv_flow_api.id(268834032229488608835)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Previs\00E3o de Fim de Contrato')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_PREV_FIM_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841192080343165920)
,p_name=>'P76_VAGA_FATURAVEL'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(268834032377127608836)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Vaga Fatur\00E1vel')
,p_source=>'VAGA_FATURAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841192473015165920)
,p_name=>'P76_VALOR_FATURAVEL'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(268834032377127608836)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Valor Fatur\00E1vel')
,p_placeholder=>'Exemplo: 19999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'999999990D00'
,p_source=>'VALOR_FATURAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841192894527165920)
,p_name=>'P76_NOVO_CONTRATO'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(268834032097593608834)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Novo Contrato / Cliente'
,p_source=>'NOVO_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841193249165165920)
,p_name=>'P76_ORGAO_PUBLICO'
,p_item_sequence=>580
,p_item_plug_id=>wwv_flow_api.id(268834032097593608834)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('\00D3rg\00E3o P\00FAblico')
,p_source=>'ORGAO_PUBLICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841193655874165921)
,p_name=>'P76_VALOR_VENDA'
,p_item_sequence=>590
,p_item_plug_id=>wwv_flow_api.id(268834032097593608834)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor de Venda'
,p_placeholder=>'Exemplo: 19999,99'
,p_pre_element_text=>'R$'
,p_format_mask=>'999999990D00'
,p_source=>'VALOR_VENDA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841194134168165921)
,p_name=>'P76_QTDE_VAGAS'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Quantidade de Vagas'
,p_source=>'QTDE_VAGAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'1'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841194462148165921)
,p_name=>'P76_MOT_ABERT_VAGA'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo de Abertura'
,p_source=>'MOT_ABERT_VAGA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(desc_mot_abert_vaga) name, cod_mot_abert_vaga id',
'from   cl_mot_abertura_vaga',
'WHERE  ((:P76_ROWID IS NULL AND ATIVO = ''S'') or (:P76_ROWID IS NOT NULL)) -- CH42711 ',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P76_ROWID'
,p_ajax_optimize_refresh=>'Y'
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
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841194897384165921)
,p_name=>'P76_DT_ABERT_VAGA'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(268834031619752608829)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Abertura de Vaga'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_ABERT_VAGA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841195247739165922)
,p_name=>'P76_DESC_ATIVIDADES'
,p_item_sequence=>640
,p_item_plug_id=>wwv_flow_api.id(268834032503838608838)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descri\00E7\00E3o de Atividades')
,p_source=>'DESC_ATIVIDADES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841195729851165922)
,p_name=>'P76_TEXTO'
,p_is_required=>true
,p_item_sequence=>650
,p_item_plug_id=>wwv_flow_api.id(268834032604826608839)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00F5es / Pol\00EDticas / Detalhes da Vaga')
,p_source=>'TEXTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>3000
,p_cHeight=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841196102952165922)
,p_name=>'P76_COD_PONTO_FAIXA'
,p_item_sequence=>660
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_PONTO_FAIXA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841196534495165923)
,p_name=>'P76_COEFICIENTE_FTE'
,p_item_sequence=>670
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COEFICIENTE_FTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841196927543165923)
,p_name=>'P76_COD_CARGO_REFERENCIA'
,p_item_sequence=>680
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO_REFERENCIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841197259029165923)
,p_name=>'P76_COD_CAT_GRUPOS_SALARIAIS'
,p_item_sequence=>690
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CAT_GRUPOS_SALARIAIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841197702314165923)
,p_name=>'P76_COD_GRUPOS_SALARIAIS'
,p_item_sequence=>700
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_GRUPOS_SALARIAIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271841198106960165924)
,p_name=>'P76_COD_SINDICATO_PF'
,p_item_sequence=>710
,p_item_plug_id=>wwv_flow_api.id(281956119091269282656)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_SINDICATO_PF'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841200742783165927)
,p_validation_name=>unistr('Valor Fatur\00E1vel')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'begin',
'',
'  if :p76_VAGA_FATURAVEL = ''S'' and :p76_valor_Faturavel is null then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Informe um valor fatur\00E1vel!'';'),
'  elsif :p76_VAGA_FATURAVEL = ''S'' and :p76_valor_Faturavel = 0 then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Valor fatur\00E1vel n\00E3o pode ser 0!'';'),
'  end if;',
'  ',
'  if trim(v_msg_retorno) is not null then',
'     return v_msg_retorno;',
'  end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841201911767165928)
,p_validation_name=>'Requerido'
,p_validation_sequence=>20
,p_validation=>'P76_VALOR_VERBA'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('Campo Sal\00E1rio dever\00E1 ter algum valor.')
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_param varchar2(1) := ''N''; ',
'',
'begin',
'',
'    if :p76_rowid is null then',
'',
'      select ind_estr_cargo_sal',
'        into v_param',
'        from configuracoes;',
'',
'      if nvl(:p_perfil,''X'') NOT IN (''REMUNERACAO'',''MASTER'') then',
'',
'        if v_param = ''N'' then ',
unistr('        return false; -- N\00E3o Ter\00E1 que informar o Sal\00E1rio'),
'        else',
unistr('        return true; -- Ter\00E1 que informar o Sal\00E1rio'),
'        end if;',
'',
'      end if;',
'',
'    end if;',
'',
'exception',
'when others then',
'return false;',
'        ',
'end;'))
,p_validation_condition_type=>'FUNCTION_BODY'
,p_associated_item=>wwv_flow_api.id(271841190145464165918)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841202268162165928)
,p_validation_name=>'Requerido 1'
,p_validation_sequence=>30
,p_validation=>'P76_TOTAL_SALARIO'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('Campo Total Sal\00E1rio dever\00E1 ter algum valor.')
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_param varchar2(1) := ''N''; ',
'',
'begin',
'',
'    if :p76_rowid is null then',
'',
'      select ind_estr_cargo_sal',
'        into v_param',
'        from configuracoes;',
'',
'      if nvl(:p_perfil,''X'') NOT IN (''REMUNERACAO'',''MASTER'') then',
'',
'        if v_param = ''N'' then ',
unistr('        return false; -- N\00E3o Ter\00E1 que informar o Sal\00E1rio'),
'        else',
unistr('        return true; -- Ter\00E1 que informar o Sal\00E1rio'),
'        end if;',
'',
'      end if;',
'',
'    end if;',
'',
'exception',
'when others then',
'return false;',
'        ',
'end;'))
,p_validation_condition_type=>'FUNCTION_BODY'
,p_associated_item=>wwv_flow_api.id(271841188466493165917)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841201500319165927)
,p_validation_name=>'Requerido Sindicato'
,p_validation_sequence=>40
,p_validation=>'P76_COD_SINDICATO'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>unistr('Campo Sindicato dever\00E1 ter algum valor.')
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_associated_item=>wwv_flow_api.id(271841182071140165913)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841201134290165927)
,p_validation_name=>'Valida Benef Obrig'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number := replace(replace(:p76_remuneracao_variavel,''R$''),''.'');',
'',
'v_perc_ben_var number;',
'',
'begin',
'',
'if :P76_PERC_BENEFICIO_VARIAVEL = 0 then',
'   v_perc_ben_var := :P76_PERC_BENEF_EXCECAO;',
'else',
'   v_perc_ben_var := :P76_PERC_BENEFICIO_VARIAVEL;',
'end if;',
'',
'pkg_vagas.retorna_benef_sindicato (:p76_cod_empresa,',
'                                   :p76_cod_filial,',
'                                   :p76_cod_ccusto,',
'                                   :p76_cod_cargo,',
'                                   :p76_cod_sindicato,',
'                                   :p76_cod_unidade_adm,',
'                                   :p76_cod_un_negocio,',
'                                   :p76_atividade,',
'                                   NULL,',
'                                   :p76_refeitorio,',
'                                   null,',
'                                   v_perc_ben_var,',
'                                   :p76_cod_cargo,',
'                                   :p76_rt_jornada_mensal,',
'                                    v_valor_beneficio,',
'                                    :p76_vinculo,',
'                                    :p76_cod_horario);',
'',
'if v_remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Valor de benef\00EDcio n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de ''||v_valor_beneficio;'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and replace(replace(nvl(v_remuneracao_variavel,0),''.''),'','') <> replace(replace(nvl(v_valor_beneficio,0),''.''),'','') and :p76_perc_beneficio_variavel is null and :P76_PERC_BENEF_EXCECAO is null then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de ''||v_valor_beneficio;'),
'end if;',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841200252877165927)
,p_validation_name=>'Valida Benef/Equip'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select *',
'  from beneficios_vaga_temp',
' where seq = :p76_seq;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select utiliza_benef_vaga valida',
'  from parametros_recursos_humanos',
' where cod_empresa = :p76_cod_empresa;',
' ',
'v_c2 c2%rowtype;',
' ',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'',
'  if nvl(v_c2.valida,''N'') = ''S'' then',
'',
'    if v_c1.cod_beneficio is null then',
unistr('    return ''\00C9 necess\00E1rio informar ao menos um benef\00EDcio/equipamento!'';'),
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841199878633165927)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P76_COD_SIT_REQUISICAO = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(271841164737498165899)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271841199544704165926)
,p_validation_name=>unistr('Valida Motivo Exce\00E7\00E3o')
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P76_PERC_BENEFICIO_VARIAVEL = 0 and :p76_motivo_excecao is null then',
unistr('return ''Informe o motivo da exce\00E7\00E3o do percentual de benef\00EDcio.'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_associated_item=>wwv_flow_api.id(271841190503809165919)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269588269480139532660)
,p_validation_name=>'COD_HORARIO'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select utiliza_horario_vaga valida',
'  from parametros_recursos_humanos',
' where cod_empresa = :p76_cod_empresa;',
' ',
'v_c1 c1%rowtype;',
' ',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  if nvl(v_c1.valida,''N'') = ''S'' then',
'',
'    if :p76_cod_horario is null then',
unistr('    return ''\00C9 necess\00E1rio informar o Hor\00E1rio Contratual!'';'),
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271841165110802165899)
,p_associated_item=>wwv_flow_api.id(271841182944988165914)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269588272395951532689)
,p_validation_name=>unistr('Valida Situa\00E7\00E3o')
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_vagas.Valida_Sit_Requisicao(:p76_cod_empresa, :p76_cod_filial, :p76_cod_requisicao, :p76_cod_sit_requisicao, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'   return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'P76_ROWID'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_api.id(271841169375013165902)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(263631882749760512396)
,p_validation_name=>'Valida Perc Benef Excecao'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_PERC NUMBER;',
'',
'BEGIN',
'',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'V_PERC := :P76_PERC_BENEF_EXCECAO;',
'',
'if nvl(V_PERC,0) < 0 or nvl(V_PERC,0) > 100 then',
unistr('return ''Percentual de Remunera\00E7\00E3o Var\00EDavel Inv\00E1lido!'';'),
'end if;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(271841189319471165918)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(258596242852672545145)
,p_validation_name=>'VALIDA_PISO_SALARIO'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'',
'V_DT DATE;',
'',
'begin',
'',
'IF :P76_ROWID IS NULL THEN',
'V_DT := SYSDATE;',
'ELSE',
'V_DT := :P76_DT_REQ;',
'END IF;',
'',
'pkg_vagas.Valida_Piso_Salario (:P76_VALOR_VERBA',
'                               ,:p76_cod_empresa',
'                           ,:P76_COD_CARGO',
'                           ,:P76_COD_SINDICATO',
'                           ,:P76_RT_JORNADA_MENSAL',
'                           ,:P76_TIPO_SALARIO',
'                           ,V_DT',
'                           ,V_FLG',
'                           ,V_MSG);',
'',
' if trim(v_msg) is not null then',
'    IF V_FLG = ''N'' THEN',
'    RETURN V_MSG;',
'    END IF;',
' end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(271841190145464165918)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(74937784952618077454)
,p_validation_name=>'Valida Data Fim'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p76_data_fim is not null and :p76_data_inicio is not null and to_date(:p76_data_fim,''dd/mm/yyyy'') < to_date(:p76_data_inicio,''dd/mm/yyyy'') then',
unistr('  return ''A Data de Encerramento n\00E3o pode ser menor que a Data de In\00EDcio'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(271841176088599165907)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>'ch39846'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(74937785096764077455)
,p_validation_name=>'Valida Data Inicio'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p76_data_inicio is not null then',
'  if to_date(:p76_data_inicio,''dd/mm/yyyy'') < trunc(sysdate,''mm'') then',
unistr('    return ''A Data de In\00EDcio n\00E3o pode ser inferior ao m\00EAs atual'';'),
'  elsif :p76_data_fim is not null and to_date(:p76_data_fim,''dd/mm/yyyy'') < to_date(:p76_data_inicio,''dd/mm/yyyy'') then',
unistr('    return ''A Data de In\00EDcio n\00E3o pode ser maior que a Data de Encerramento'';'),
'  end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(271841175657710165907)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>'ch39846'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841208028867165933)
,p_name=>'Hide Region'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841208483208165933)
,p_event_id=>wwv_flow_api.id(271841208028867165933)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281956112029115282649)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841208850295165934)
,p_name=>unistr('Confirma Aprova\00E7\00E3o')
,p_event_sequence=>1041
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841163193700165898)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_MENSAGEM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841209377438165934)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja Continuar com a Aprova\00E7\00E3o?')
,p_attribute_07=>'Aprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841209871656165934)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' update APROVA_REQUISICAO_VAGA',
'    set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'  where cod_requisicao = :p76_cod_requisicao',
'    and cod_emp_aprov = :P_EMPRESA_USER',
'    and mat_aprov = :P_MATRICULA_USER;',
'',
'commit;',
'end;',
'',
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'-- :p76_mensagem := null;',
'',
'pkg_vagas.Post_Update(:p76_cod_empresa, :p76_cod_requisicao, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    :p76_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P_USUARIO,P76_COD_REQUISICAO,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P76_MENSAGEM,P76_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841210354076165935)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'success'
,p_attribute_02=>unistr('Requisi\00E7\00E3o Aprovada com Sucesso!')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'true'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'10000'
,p_attribute_11=>'2000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841210912412165935)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281956106811145282642)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841211417638165935)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281956112029115282649)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841211940591165935)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841212361235165936)
,p_event_id=>wwv_flow_api.id(271841208850295165934)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841212760798165936)
,p_name=>unistr('Confirma Reprova\00E7\00E3o')
,p_event_sequence=>1061
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841162823456165897)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_MENSAGEM'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841213280918165936)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja Continuar com a Reprova\00E7\00E3o?')
,p_attribute_07=>'Reprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841213835604165936)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' update APROVA_REQUISICAO_VAGA',
'    set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'  where cod_requisicao = :p76_cod_requisicao',
'    and cod_emp_aprov = :P_EMPRESA_USER',
'    and mat_aprov = :P_MATRICULA_USER;',
'',
'commit;',
'end;',
'',
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'-- :p76_mensagem := null;',
'',
'pkg_vagas.Post_Update(:p76_cod_empresa, :p76_cod_requisicao, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    :p76_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P_USUARIO,P76_COD_REQUISICAO,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P76_MENSAGEM,P76_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841214328337165937)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'error'
,p_attribute_02=>unistr('Requisi\00E7\00E3o Reprovada com Sucesso!')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'true'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'10000'
,p_attribute_11=>'2000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841214759512165937)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281956106811145282642)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841215344704165937)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281956112029115282649)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841215784430165937)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841216281343165938)
,p_event_id=>wwv_flow_api.id(271841212760798165936)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841216723797165938)
,p_name=>'Dispara Alerta'
,p_event_sequence=>1071
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841217205989165938)
,p_event_id=>wwv_flow_api.id(271841216723797165938)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P76_FLAG'').value == "Q") {',
'alertify.confirm($v(''P76_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P76_FLAG'').value = ''S'';',
'        $x(''P76_MENSAGEM'').value = '''';',
'        $x(''P76_OK'').value = ''S'';',
'        $(''#P76_CREATE'').show();',
'    } else {',
'        $x(''P76_OK'').value = ''N'';',
'        $(''#P76_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P76_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        alertify.alert($v(''P76_MENSAGEM''));',
'        ',
'        if ($x(''P76_FLAG'').value == "N") {',
'            $(''#P76_CREATE'').hide();',
'        } else {',
'            $(''#P76_CREATE'').show();',
'        }',
'',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841217588385165938)
,p_name=>'Dispara Alerta_1'
,p_event_sequence=>1081
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_MENSAGEM_1'
,p_condition_element=>'P76_MENSAGEM_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841218069850165939)
,p_event_id=>wwv_flow_api.id(271841217588385165938)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P76_MENSAGEM_1'').value.length  > 0 ) {',
'',
'    alert($v(''P76_MENSAGEM_1''));',
'',
'        if ($x(''P76_FLAG'').value == "N") {',
'            $(''#P76_CREATE'').hide();',
'        } else {',
'            $(''#P76_CREATE'').show();',
'        }',
'    ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841218545324165939)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1091
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841218998557165939)
,p_event_id=>wwv_flow_api.id(271841218545324165939)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Teste'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841219442284165939)
,p_name=>'Valida Estrutura Salarial'
,p_event_sequence=>1101
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_CARGO'
,p_condition_element=>'P76_COD_CARGO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_param varchar2(1) := ''N''; ',
'',
'begin',
'',
'  if 1 = 2 then',
'',
'    select ind_estr_cargo_sal',
'            into v_param',
'            from configuracoes;',
'',
'    if :p76_rowid is null then',
'    if v_param = ''S'' then',
'    return true;',
'    else',
'    return false;',
'    end if;',
'    else',
'    return false;',
'    end if;',
'',
'  else',
'',
'    return false;',
'',
'  end if;',
'',
'exception',
'when others then',
'return false;',
'        ',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841219879408165940)
,p_event_id=>wwv_flow_api.id(271841219442284165939)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja utilizar estrutura salarial? Caso n\00E3o utilize, o sal\00E1rio dever\00E1 ser informado.')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841220371745165940)
,p_event_id=>wwv_flow_api.id(271841219442284165939)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'    SELECT CCR.COD_CAT_GRUPO_SAL        GRUPO_SALARIAL',
'          ,CCR.COD_CAT_GRUPOS_SALARIAIS CATEGORIA_GRUPO_SALARIAL',
'    FROM   CATEGORIA_CARGO_REL CCR',
'          ,CATEGORIA_CARGO     CC',
'    WHERE  CC.COD                   = CCR.COD_CATEGORIA',
'    AND    CCR.COD_CARGO            = :P76_COD_CARGO',
'    AND    NVL(CCR.COD_EMPRESA_SINDJORN,:P76_COD_EMPRESA) = :P76_COD_EMPRESA;',
'    ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  if v_c1.grupo_salarial is not null then',
'  ',
'     :P76_COD_GRUPOS_SALARIAIS     := V_C1.GRUPO_SALARIAL;',
'     :P76_COD_CAT_GRUPOS_SALARIAIS := V_C1.CATEGORIA_GRUPO_SALARIAL;',
'  ',
'  ELSE ',
'',
'     :P76_COD_GRUPOS_SALARIAIS     := null;',
'     :P76_COD_CAT_GRUPOS_SALARIAIS := null;',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P76_COD_EMPRESA,P76_COD_CARGO'
,p_attribute_03=>'P76_COD_GRUPOS_SALARIAIS,P76_COD_CAT_GRUPOS_SALARIAIS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270228087922521909302)
,p_name=>'Valida Estrutura Salarial (2)'
,p_event_sequence=>1111
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_CATEGORIA'
,p_condition_element=>'P76_COD_CATEGORIA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_param varchar2(1) := ''N''; ',
'',
'begin',
'',
'select ind_estr_cargo_sal',
'        into v_param',
'        from configuracoes;',
'        ',
'if :p76_rowid is null then',
'if v_param = ''S'' then',
'return true;',
'else',
'return false;',
'end if;',
'else',
'return false;',
'end if;',
'',
'exception',
'when others then',
'return false;',
'        ',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270228087982200909303)
,p_event_id=>wwv_flow_api.id(270228087922521909302)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja utilizar estrutura salarial? Caso n\00E3o utilize, o sal\00E1rio dever\00E1 ser informado.')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295221957843866154)
,p_event_id=>wwv_flow_api.id(270228087922521909302)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'    SELECT CCR.COD_CAT_GRUPO_SAL        GRUPO_SALARIAL',
'          ,CCR.COD_CAT_GRUPOS_SALARIAIS CATEGORIA_GRUPO_SALARIAL',
'    FROM   CATEGORIA_CARGO_REL CCR',
'          ,CATEGORIA_CARGO     CC',
'    WHERE  CC.COD                   = CCR.COD_CATEGORIA',
'    AND    CCR.COD_CARGO            = :P76_COD_CARGO',
'    AND    CCR.COD_CATEGORIA        = :P76_COD_CATEGORIA',
'    AND    NVL(CCR.COD_EMPRESA_SINDJORN,:P76_COD_EMPRESA) = :P76_COD_EMPRESA;',
'    ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  if v_c1.grupo_salarial is not null then',
'  ',
'     :P76_COD_GRUPOS_SALARIAIS     := V_C1.GRUPO_SALARIAL;',
'     :P76_COD_CAT_GRUPOS_SALARIAIS := V_C1.CATEGORIA_GRUPO_SALARIAL;',
'  ',
'  ELSE ',
'',
'     :P76_COD_GRUPOS_SALARIAIS     := null;',
'     :P76_COD_CAT_GRUPOS_SALARIAIS := null;',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P76_COD_EMPRESA,P76_COD_CARGO,P76_COD_CATEGORIA'
,p_attribute_03=>'P76_COD_GRUPOS_SALARIAIS,P76_COD_CAT_GRUPOS_SALARIAIS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841220825171165940)
,p_name=>'Se Nulo Valor Verba 0'
,p_event_sequence=>1121
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_GRUPOS_SALARIAIS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841221336929165940)
,p_event_id=>wwv_flow_api.id(271841220825171165940)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p76_cod_grupos_salariais is null then',
'   :p76_valor_verba := 0;',
'end if;'))
,p_attribute_02=>'P76_COD_GRUPOS_SALARIAIS'
,p_attribute_03=>'P76_VALOR_VERBA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841221714805165941)
,p_name=>unistr('Esconde Itens (Cria\00E7\00E3o)')
,p_event_sequence=>1131
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_param varchar2(1) := ''N''; ',
'',
'begin',
'',
'    if :p76_rowid is null then',
'',
'      select ind_estr_cargo_sal',
'        into v_param',
'        from configuracoes;',
'',
'      if nvl(:p_perfil,''X'') IN (''REMUNERACAO'',''MASTER'') then',
'',
'        return false;',
'',
'      else',
'',
'        if v_param = ''N'' then ',
unistr('        return true; -- N\00E3o Ter\00E1 que informar o Sal\00E1rio'),
'        else',
unistr('        return false; -- Ter\00E1 que informar o Sal\00E1rio'),
'        end if;',
'',
'      end if;',
'',
'    end if;',
'',
'exception',
'when others then',
'return false;',
'        ',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841222181675165941)
,p_event_id=>wwv_flow_api.id(271841221714805165941)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_VERBA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841222551184165941)
,p_name=>'Valida_dt_abert_vaga'
,p_event_sequence=>1141
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_DT_ABERT_VAGA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841223111677165941)
,p_event_id=>wwv_flow_api.id(271841222551184165941)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P76_ITEM_VALIDACAO := null;',
'',
' :p76_mensagem := null;',
' :p76_ok       := ''S'';',
'',
'pkg_vagas.Valida_Dt_Abert_Vaga(:p76_dt_abert_vaga, :p76_data_inicio, :p76_data_fim, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''P76_DT_ABERT_VAGA''));',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P76_DT_ABERT_VAGA'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P76_DT_ABERT_VAGA,P76_DATA_FIM,P76_ITEM_VALIDACAO'
,p_attribute_03=>'P76_OK,P76_FLAG,P76_MENSAGEM,P76_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841223520317165942)
,p_name=>'Seta Data Inical / Final'
,p_event_sequence=>1151
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_FILIAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>'ch39846 - solicitado comentar essa tratativa - Adriana (antes, o server condition era item is null - rowid)'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841223947154165942)
,p_event_id=>wwv_flow_api.id(271841223520317165942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P76_COD_EMPRESA IS NOT NULL AND :P76_COD_FILIAL IS NOT NULL THEN',
'	--',
'  BEGIN',
'	  --',
'	  SELECT HP.DATA_INICIO',
'		      ,HP.DATA_FIM',
'		INTO   :P76_DATA_INICIO',
'		      ,:P76_DATA_FIM',
'		FROM   HEADCOUNT_PERIODOS HP',
'		WHERE  HP.DATA_INICIO = (SELECT MAX(HP2.DATA_INICIO)',
'		                         FROM   HEADCOUNT_PERIODOS HP2',
'		                         WHERE  HP2.DATA_FIM    > TRUNC(SYSDATE)',
'		                         AND    HP2.COD_FILIAL  = HP.COD_FILIAL',
'		                         AND    HP2.COD_EMPRESA = HP.COD_EMPRESA)',
'		AND    HP.COD_FILIAL  = NVL(:P76_COD_FILIAL,  HP.COD_FILIAL)',
'		AND    HP.COD_EMPRESA = NVL(:P76_COD_EMPRESA, HP.COD_EMPRESA);',
'	  --',
'  EXCEPTION',
'  	WHEN NO_DATA_FOUND THEN',
'  	  :P76_DATA_INICIO := NULL;',
'  	  :P76_DATA_FIM    := NULL;',
'  END;',
'  ',
'     if :P76_DT_ABERT_VAGA is null then',
'       :P76_DT_ABERT_VAGA := sysdate;',
'   end if;',
'	--',
'END IF;'))
,p_attribute_02=>'P76_COD_EMPRESA,P76_COD_FILIAL,P76_DT_ABERT_VAGA,P76_DATA_INICIO,P76_DATA_FIM'
,p_attribute_03=>'P76_DATA_INICIO,P76_DATA_FIM,P76_DT_ABERT_VAGA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841224375369165942)
,p_name=>'CREATE: Esconde se N'
,p_event_sequence=>1161
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_OK'
,p_condition_element=>'P76_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841224936737165943)
,p_event_id=>wwv_flow_api.id(271841224375369165942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(271841165110802165899)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841225324619165944)
,p_name=>'CREATE: Mostra se S'
,p_event_sequence=>1171
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_OK'
,p_condition_element=>'P76_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841225821411165944)
,p_event_id=>wwv_flow_api.id(271841225324619165944)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(271841165110802165899)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841226238714165944)
,p_name=>'Valida_Sit_Requisicao'
,p_event_sequence=>1181
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_SIT_REQUISICAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841226662336165945)
,p_event_id=>wwv_flow_api.id(271841226238714165944)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P76_ITEM_VALIDACAO := null;',
'',
' :p76_mensagem := null;',
' :p76_ok       := ''S'';',
'',
'pkg_vagas.Valida_Sit_Requisicao(:p76_cod_empresa, :p76_cod_filial, :p76_cod_requisicao, :p76_cod_sit_requisicao, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''p76_cod_sit_requisicao''));',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p76_cod_sit_requisicao'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_REQUISICAO,P76_COD_SIT_REQUISICAO,P_USUARIO,P76_ITEM_VALIDACAO'
,p_attribute_03=>'P76_FLAG,P76_OK,P76_MENSAGEM,P76_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841227084713165945)
,p_name=>'Limpa campos valores'
,p_event_sequence=>1191
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_REFEITORIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841227566244165945)
,p_event_id=>wwv_flow_api.id(271841227084713165945)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TOTAL_SALARIO,P76_PERC_BENEFICIO_VARIAVEL,P76_PERC_BENEF_EXCECAO,P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841228025060165945)
,p_name=>unistr('Confirma Cargo Refer\00EAncia')
,p_event_sequence=>1201
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_CARGO'
,p_condition_element=>'P76_COD_CARGO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841228513075165945)
,p_event_id=>wwv_flow_api.id(271841228025060165945)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('O Cargo escolhido ser\00E1 apenas uma refer\00EAncia?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'CANCEL'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841228955755165946)
,p_event_id=>wwv_flow_api.id(271841228025060165945)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p76_cod_cargo_referencia := :p76_cod_cargo;'
,p_attribute_02=>'P76_COD_CARGO,P76_COD_CARGO_REFERENCIA'
,p_attribute_03=>'P76_COD_CARGO_REFERENCIA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841229398038165946)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>1211
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P76_COD_SIT_REQUISICAO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841229879382165946)
,p_event_id=>wwv_flow_api.id(271841229398038165946)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841230416904165946)
,p_event_id=>wwv_flow_api.id(271841229398038165946)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841230751221165947)
,p_name=>'Mostra campos DEF'
,p_event_sequence=>1221
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_IND_DEF_FIS'
,p_condition_element=>'P76_IND_DEF_FIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841231341679165947)
,p_event_id=>wwv_flow_api.id(271841230751221165947)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_RAIS_IND_DEF_AUDITIVA,P76_RAIS_IND_DEF_FISICO,P76_RAIS_IND_DEF_MENTAL,P76_RAIS_IND_DEF_MULTIPLA,P76_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841231826019165947)
,p_event_id=>wwv_flow_api.id(271841230751221165947)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_RAIS_IND_DEF_AUDITIVA,P76_RAIS_IND_DEF_FISICO,P76_RAIS_IND_DEF_MENTAL,P76_RAIS_IND_DEF_MULTIPLA,P76_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841232205874165947)
,p_name=>'Mostra Campo Valor Faturavel'
,p_event_sequence=>1231
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VAGA_FATURAVEL'
,p_condition_element=>'P76_VAGA_FATURAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841232707501165948)
,p_event_id=>wwv_flow_api.id(271841232205874165947)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841233215912165948)
,p_event_id=>wwv_flow_api.id(271841232205874165947)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_FATURAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841233694656165948)
,p_event_id=>wwv_flow_api.id(271841232205874165947)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841234079792165948)
,p_name=>'(CREATE) Valida Valor Faturavel'
,p_event_sequence=>1241
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841165110802165899)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841234554849165949)
,p_event_id=>wwv_flow_api.id(271841234079792165948)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P76_ITEM_VALIDACAO := null;',
'',
' :p76_mensagem := null;',
' :p76_ok       := ''S'';',
'',
'  if :p76_VAGA_FATURAVEL = ''S'' and :p76_valor_Faturavel is null then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Informe um valor fatur\00E1vel!'';'),
'  elsif :p76_VAGA_FATURAVEL = ''S'' and :p76_valor_Faturavel = 0 then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Valor fatur\00E1vel n\00E3o pode ser 0!'';'),
'  end if;',
'  ',
' if trim(v_msg_retorno) is not null then',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''p76_valor_Faturavel''));',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p76_valor_Faturavel'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P76_VAGA_FATURAVEL,P76_VALOR_FATURAVEL,P76_ITEM_VALIDACAO'
,p_attribute_03=>'P76_FLAG,P76_MENSAGEM,P76_OK,P76_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841234968844165949)
,p_name=>'(CREATE) Habilita Campos'
,p_event_sequence=>1251
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841165110802165899)
,p_condition_element=>'P76_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841235477795165949)
,p_event_id=>wwv_flow_api.id(271841234968844165949)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_FATURAVEL,P76_VALOR_VERBA,P76_TOTAL_SALARIO,P76_REMUNERACAO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841235953314165949)
,p_event_id=>wwv_flow_api.id(271841234968844165949)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VALOR_FATURAVEL,P76_VALOR_VERBA,P76_TOTAL_SALARIO,P76_REMUNERACAO_VARIAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841236462722165950)
,p_event_id=>wwv_flow_api.id(271841234968844165949)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    $x(''P76_REMUNERACAO_VARIAVEL'').disabled = false;',
'    $x(''P76_VALOR_VERBA'').disabled = false;',
'    $x(''P76_VALOR_FATURAVEL'').disabled = false;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841236913420165950)
,p_name=>'Valida Valor Faturavel'
,p_event_sequence=>1261
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841237364609165950)
,p_event_id=>wwv_flow_api.id(271841236913420165950)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P76_ITEM_VALIDACAO := null;',
'',
' :p76_mensagem := null;',
' :p76_ok       := ''S'';',
'',
'  if :p76_VAGA_FATURAVEL = ''S'' and :p76_valor_Faturavel is null then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Informe um valor fatur\00E1vel!'';'),
'  elsif :p76_VAGA_FATURAVEL = ''S'' and NVL(:p76_valor_Faturavel,''0'') = ''0'' then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Valor fatur\00E1vel n\00E3o pode ser 0!'';'),
'  end if;',
'  ',
' if trim(v_msg_retorno) is not null then',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''p76_valor_Faturavel''));',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p76_valor_Faturavel'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P76_VAGA_FATURAVEL,P76_VALOR_FATURAVEL,P76_ITEM_VALIDACAO'
,p_attribute_03=>'P76_FLAG,P76_MENSAGEM,P76_OK,P76_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841237770493165950)
,p_name=>'Mostra Valores'
,p_event_sequence=>1271
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841238303952165951)
,p_event_id=>wwv_flow_api.id(271841237770493165950)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841238835666165951)
,p_event_id=>wwv_flow_api.id(271841237770493165950)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841239344307165951)
,p_event_id=>wwv_flow_api.id(271841237770493165950)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841239833298165951)
,p_event_id=>wwv_flow_api.id(271841237770493165950)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P76_REMUNERACAO_VARIAVEL'').disabled = true;',
'$x(''P76_VALOR_VERBA'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841240204275165952)
,p_name=>'Mostra Valores Excecao'
,p_event_sequence=>1281
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841241186328165952)
,p_event_id=>wwv_flow_api.id(271841240204275165952)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841241703952165952)
,p_event_id=>wwv_flow_api.id(271841240204275165952)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA,P76_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841240684366165952)
,p_event_id=>wwv_flow_api.id(271841240204275165952)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841242233206165953)
,p_event_id=>wwv_flow_api.id(271841240204275165952)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841242740359165953)
,p_event_id=>wwv_flow_api.id(271841240204275165952)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    $x(''P76_REMUNERACAO_VARIAVEL'').disabled = false;',
'    $x(''P76_VALOR_VERBA'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841243085945165954)
,p_name=>'Esconde Valores'
,p_event_sequence=>1291
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841243626159165955)
,p_event_id=>wwv_flow_api.id(271841243085945165954)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA,P76_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841243988109165955)
,p_name=>'Popula Remuneracao Variavel'
,p_event_sequence=>1301
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841244498612165955)
,p_event_id=>wwv_flow_api.id(271841243988109165955)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_total_salario number := replace(replace(:P76_TOTAL_SALARIO,''R$''),''.'');',
'begin',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'if :p76_perc_beneficio_variavel > 0 then',
':p76_remuneracao_variavel := round((v_TOTAL_SALARIO * (:p76_perc_beneficio_variavel/100)),2);',
':p76_valor_verba := round((v_TOTAL_SALARIO * ((100-:p76_perc_beneficio_variavel)/100)),2);',
'elsif :p76_perc_beneficio_variavel is null then',
':p76_remuneracao_variavel := null;',
':p76_valor_verba := nvl(v_TOTAL_SALARIO,0);',
'elsif :p76_perc_beneficio_variavel = 0 then',
':p76_remuneracao_variavel := 0;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P76_TOTAL_SALARIO,P76_PERC_BENEFICIO_VARIAVEL,P76_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841244920176165955)
,p_name=>'Mask Total Salario'
,p_event_sequence=>1311
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_TOTAL_SALARIO'
,p_condition_element=>'P76_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841245496703165956)
,p_event_id=>wwv_flow_api.id(271841244920176165955)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(replace(:p76_total_salario,''.''),''R$'');',
'',
'begin',
'',
':p76_total_salario := trim(to_char(v_sal,''999999990D90''));',
'',
'end;'))
,p_attribute_02=>'P76_TOTAL_SALARIO'
,p_attribute_03=>'P76_TOTAL_SALARIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841245848745165956)
,p_name=>'Popula Remuneracao Excecao'
,p_event_sequence=>1321
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEF_EXCECAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841246382687165956)
,p_event_id=>wwv_flow_api.id(271841245848745165956)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_total_salario number := replace(replace(:P76_TOTAL_SALARIO,''R$''),''.'');',
'',
'begin',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'if :p76_rowid is null then',
'    if :p76_perc_benef_excecao > 0 then',
'    :p76_remuneracao_variavel := round((v_total_salario * (:p76_perc_benef_excecao/100)),2) - nvl(:P76_VLR_AUX_TIPO_MODALIDADE,0);',
'    :p76_valor_verba := round((v_total_salario * ((100-:p76_perc_benef_excecao)/100)),2);',
'    else',
'    :p76_remuneracao_variavel := null;',
'    :p76_valor_verba := v_total_salario - :p76_remuneracao_variavel;',
'    end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P76_TOTAL_SALARIO,P76_PERC_BENEF_EXCECAO,P76_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P76_REMUNERACAO_VARIAVEL,P76_VALOR_VERBA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841246981118165956)
,p_name=>'Popula Valor_Verba'
,p_event_sequence=>1331
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_TOTAL_SALARIO,P76_PERC_BENEFICIO_VARIAVEL,P76_VLR_AUX_TIPO_MODALIDADE,P76_PERC_BENEF_EXCECAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841247453985165957)
,p_event_id=>wwv_flow_api.id(271841246981118165956)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_total_salario number := replace(replace(:P76_TOTAL_SALARIO,''R$''),''.'');',
'v_remuneracao_variavel number := replace(replace(:p76_remuneracao_variavel,''R$''),''.'');',
'',
'v_perc_ben_var number;',
'',
'begin',
'',
'if :P76_PERC_BENEFICIO_VARIAVEL = 0 then',
'   v_perc_ben_var := :P76_PERC_BENEF_EXCECAO;',
'else',
'   v_perc_ben_var := :P76_PERC_BENEFICIO_VARIAVEL;',
'end if;',
'',
'--:p76_valor_verba := v_total_salario;',
'',
'pkg_vagas.retorna_benef_sindicato (:p76_cod_empresa,',
'                                   :p76_cod_filial,',
'                                   :p76_cod_ccusto,',
'                                   :p76_cod_cargo,',
'                                   :p76_cod_sindicato,',
'                                   :p76_cod_unidade_adm,',
'                                   :p76_cod_un_negocio,',
'                                   :p76_atividade,',
'                                   null,--:p76_cod_vaga,',
'                                   :p76_refeitorio,',
'                                   null,',
'                                   v_perc_ben_var,',
'                                   :p76_cod_cargo,',
'                                   :p76_rt_jornada_mensal,',
'                                    v_valor_beneficio,',
'                                    :p76_vinculo,',
'                                    :p76_cod_horario);',
'',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'  if :p76_perc_beneficio_variavel is null then -- Full-CLT',
'',
'    :p76_valor_verba := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0) /*- NVL(:p76_vlr_aux_tipo_modalidade,0)*/;',
'    :p76_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'  ',
'  elsif :p76_perc_beneficio_variavel > 0 then -- Flex (20% ou 30%)',
'  ',
'    :p76_valor_verba := round((v_total_salario * ((100-:p76_perc_beneficio_variavel)/100)),2);',
'    :p76_remuneracao_variavel := round((v_total_salario * (:p76_perc_beneficio_variavel/100)),2) /*- NVL(:p76_vlr_aux_tipo_modalidade,0)*/;',
'  ',
unistr('  elsif :p76_perc_beneficio_variavel = 0 then -- Flex (Exce\00E7\00E3o)'),
'  ',
'    if nvl(:p76_perc_benef_excecao,0) > 0 then',
'       :p76_remuneracao_variavel := round((v_total_salario * (:p76_perc_benef_excecao/100)),2) /*- nvl(:P76_VLR_AUX_TIPO_MODALIDADE,0)*/;',
'       :p76_valor_verba := v_total_salario - (nvl(:p76_remuneracao_variavel,0) /*+ nvl(:P76_VLR_AUX_TIPO_MODALIDADE,0)*/);--round((v_total_salario * ((100-:p76_perc_benef_excecao)/100)),2);',
'    else',
'       :p76_remuneracao_variavel := null;',
'       :p76_valor_verba := v_total_salario - :p76_remuneracao_variavel;',
'    end if;',
'  ',
'  end if;',
'',
'  IF :P76_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(:P76_PERC_BENEF_EXCECAO,0) > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEF_EXCECAO;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(:P76_PERC_BENEF_EXCECAO,0) = 0 THEN',
'     :P76_PERC_BENEFICIO := NULL;',
'  END IF;',
'',
'end;'))
,p_attribute_02=>'P76_TOTAL_SALARIO,P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_CCUSTO,P76_COD_CARGO,P76_COD_SINDICATO,P76_COD_UNIDADE_ADM,P76_COD_UN_NEGOCIO,P76_ATIVIDADE,P76_PERC_BENEFICIO_VARIAVEL,P76_REFEITORIO,P76_PERC_BENEF_EXCECAO,P76_RT_JORNADA_MENSAL,P76_VLR_AUX_T'
||'IPO_MODALIDADE,P76_VINCULO,P76_COD_HORARIO'
,p_attribute_03=>'P76_VALOR_VERBA,P76_REMUNERACAO_VARIAVEL,P76_PERC_BENEFICIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841247860864165957)
,p_name=>'Valida Benf. Sindicato'
,p_event_sequence=>1341
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_REMUNERACAO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841248492047165957)
,p_event_id=>wwv_flow_api.id(271841247860864165957)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P76_ITEM_VALIDACAO;',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number := replace(replace(:p76_remuneracao_variavel,''R$''),''.'');',
'',
'v_perc_ben_var number;',
'',
'begin',
'',
'if :P76_PERC_BENEFICIO_VARIAVEL = 0 then',
'   v_perc_ben_var := :P76_PERC_BENEF_EXCECAO;',
'else',
'   v_perc_ben_var := :P76_PERC_BENEFICIO_VARIAVEL;',
'end if;',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'v_item_validacao := NULL;',
':P76_ITEM_VALIDACAO := null;',
'',
' :p76_mensagem_1 := null;',
' :p76_ok       := ''S'';',
'',
'pkg_vagas.retorna_benef_sindicato (:p76_cod_empresa,',
'                                   :p76_cod_filial,',
'                                   :p76_cod_ccusto,',
'                                   :p76_cod_cargo,',
'                                   :p76_cod_sindicato,',
'                                   :p76_cod_unidade_adm,',
'                                   :p76_cod_un_negocio,',
'                                   :p76_atividade,',
'                                   NULL,',
'                                   :p76_refeitorio,',
'                                   null,',
'                                   v_perc_ben_var,',
'                                   :p76_cod_cargo,',
'                                   :p76_rt_jornada_mensal,',
'                                    v_valor_beneficio,',
'                                    :p76_vinculo,',
'                                    :p76_cod_horario);',
'',
'if v_remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Valor de benef\00EDcio n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de ''||v_valor_beneficio;'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and replace(replace(nvl(v_remuneracao_variavel,0),''.''),'','') <> replace(replace(nvl(v_valor_beneficio,0),''.''),'','') and :p76_perc_beneficio_variavel is null and :P76_PERC_BENEF_EXCECAO is null then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de ''||v_valor_beneficio;'),
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''P76_REMUNERACAO_VARIAVEL''));',
'    :p76_ok       := ''N'';',
'    :p76_flag     := ''N'';',
'    :p76_mensagem_1 := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem_1 := null;',
'    if v_item_validacao = TRIM(UPPER(''P76_REMUNERACAO_VARIAVEL'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P76_ITEM_VALIDACAO,P76_REMUNERACAO_VARIAVEL,P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_CCUSTO,P76_COD_CARGO,P76_COD_SINDICATO,P76_COD_UNIDADE_ADM,P76_COD_UN_NEGOCIO,P76_ATIVIDADE,P76_REFEITORIO,P76_PERC_BENEFICIO_VARIAVEL,P76_PERC_BENEF_EXCECAO,P76_RT_JO'
||'RNADA_MENSAL,P76_VINCULO,P76_COD_HORARIO'
,p_attribute_03=>'P76_ITEM_VALIDACAO,P76_OK,P76_FLAG,P76_MENSAGEM_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841248955800165958)
,p_event_id=>wwv_flow_api.id(271841247860864165957)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P76_MENSAGEM_1'').value.length  > 0 ) {',
'',
'    alert($v(''P76_MENSAGEM_1''));',
'',
'        if ($x(''P76_FLAG'').value == "N") {',
'            $(''#P76_CREATE'').hide();',
'        } else {',
'            $(''#P76_CREATE'').show();',
'        }',
'    ',
'}else{',
'   $(''#P76_CREATE'').show();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841249353965165958)
,p_name=>'Add_Beneficio'
,p_event_sequence=>1351
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841156245473165886)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841249942631165958)
,p_event_id=>wwv_flow_api.id(271841249353965165958)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into beneficios_vaga_temp (seq, cod_requisicao, cod_empresa, cod_filial, cod_beneficio, valor)',
'values',
'(:p76_seq, null, :p76_cod_empresa, :p76_cod_filial, :p76_beneficio_vaga, :p76_valor);',
'',
'commit;'))
,p_attribute_02=>'P76_SEQ,P76_COD_EMPRESA,P76_COD_FILIAL,P76_BENEFICIO_VAGA,P76_VALOR'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841250415254165958)
,p_event_id=>wwv_flow_api.id(271841249353965165958)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281826669128151846119)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841250907109165959)
,p_event_id=>wwv_flow_api.id(271841249353965165958)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281943547685159807706)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841251296988165959)
,p_name=>'Altera Valor_Verba e %'
,p_event_sequence=>1361
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_REMUNERACAO_VARIAVEL'
,p_condition_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841251814040165959)
,p_event_id=>wwv_flow_api.id(271841251296988165959)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_total_salario number := replace(replace(:P76_TOTAL_SALARIO,''R$''),''.'');',
'v_remuneracao_variavel number := replace(replace(:p76_remuneracao_variavel,''R$''),''.'');',
'',
'begin',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
unistr('if :P76_PERC_BENEFICIO_VARIAVEL = 0 then -- Flex - Exce\00E7\00E3o'),
':p76_perc_benef_excecao := ROUND(((nvl(v_remuneracao_variavel,0) /*+ nvl(:p76_vlr_aux_tipo_modalidade,0)*/) / v_total_salario),4) * 100;',
'                         --round(((nvl(v_remuneracao_variavel,0) - nvl(:p76_vlr_aux_tipo_modalidade,0)) / v_total_salario) * 100,3);',
':p76_valor_verba := v_total_salario - nvl(v_remuneracao_variavel,0) /*- nvl(:p76_vlr_aux_tipo_modalidade,0)*/;                           ',
'end if;',
'',
'',
'end;'))
,p_attribute_02=>'P76_TOTAL_SALARIO,P76_REMUNERACAO_VARIAVEL,P76_PERC_BENEFICIO_VARIAVEL,P76_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P76_VALOR_VERBA,P76_PERC_BENEF_EXCECAO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841252220326165959)
,p_name=>'open_beneficios'
,p_event_sequence=>1371
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271841159697291165892)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841252657819165959)
,p_event_id=>wwv_flow_api.id(271841252220326165959)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_BENEFICIO_VAGA,P76_VALOR'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841253216301165960)
,p_event_id=>wwv_flow_api.id(271841252220326165959)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281826669128151846119)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841253585522165960)
,p_name=>'Refresh Region'
,p_event_sequence=>1381
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281943547685159807706)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841254081173165960)
,p_event_id=>wwv_flow_api.id(271841253585522165960)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281943547685159807706)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841254538814165960)
,p_name=>'Popula Valor'
,p_event_sequence=>1391
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_BENEFICIO_VAGA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841254984858165961)
,p_event_id=>wwv_flow_api.id(271841254538814165960)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select valor_padrao valor',
'  into :p76_valor',
'from   beneficios',
'where cod_beneficio = :p76_beneficio_vaga;',
'exception',
'when others then',
' :p76_valor := null;',
'end;'))
,p_attribute_02=>'P76_BENEFICIO_VAGA'
,p_attribute_03=>'P76_VALOR'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841255408888165961)
,p_name=>'Mask Rem Var'
,p_event_sequence=>1401
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_REMUNERACAO_VARIAVEL'
,p_condition_element=>'P76_REMUNERACAO_VARIAVEL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841255849893165961)
,p_event_id=>wwv_flow_api.id(271841255408888165961)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_rem number;',
'v_rem_mask varchar2(200);',
'',
'begin',
'',
'    v_rem := replace(replace(:P76_REMUNERACAO_VARIAVEL,''R$''),''.'','','');',
'',
'    v_rem_mask :=  trim(to_char(v_rem,''99999990D00''));',
'',
'  :P76_REMUNERACAO_VARIAVEL := v_rem_mask;',
'',
'end;'))
,p_attribute_02=>'P76_REMUNERACAO_VARIAVEL'
,p_attribute_03=>'P76_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841256306732165961)
,p_name=>'Mask Valor Verba'
,p_event_sequence=>1411
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VALOR_VERBA'
,p_condition_element=>'P76_VALOR_VERBA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841256769495165962)
,p_event_id=>wwv_flow_api.id(271841256306732165961)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(:p76_valor_verba,''.'','','');',
'',
'begin',
'',
':p76_valor_verba := trim(to_char(v_sal,''999999990D00''));',
'',
'end;'))
,p_attribute_02=>'P76_VALOR_VERBA'
,p_attribute_03=>'P76_VALOR_VERBA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841257215175165962)
,p_name=>'Mask Dt_Abert_Vaga'
,p_event_sequence=>1421
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_DT_ABERT_VAGA'
,p_condition_element=>'P76_DT_ABERT_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841257717748165962)
,p_event_id=>wwv_flow_api.id(271841257215175165962)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:p76_dt_abert_vaga,''/'');',
'',
'begin',
'',
':p76_dt_abert_vaga := v_dt;',
'',
'exception',
'when others then',
':p76_dt_abert_vaga := v_dt;',
'',
'end;'))
,p_attribute_02=>'P76_DT_ABERT_VAGA'
,p_attribute_03=>'P76_DT_ABERT_VAGA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841259758134165963)
,p_name=>'Mask Data_Previsao'
,p_event_sequence=>1431
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_DT_PREVISAO_ADMISSAO'
,p_condition_element=>'P76_DT_PREVISAO_ADMISSAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841260329216165963)
,p_event_id=>wwv_flow_api.id(271841259758134165963)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P76_DT_PREVISAO_ADMISSAO,''/'');',
'',
'begin',
'',
':P76_DT_PREVISAO_ADMISSAO := v_dt;',
'',
'exception',
'when others then',
':P76_DT_PREVISAO_ADMISSAO := v_dt;',
'',
'end;'))
,p_attribute_02=>'P76_DT_PREVISAO_ADMISSAO'
,p_attribute_03=>'P76_DT_PREVISAO_ADMISSAO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841260665713165964)
,p_name=>'Mask Data_Previsao_Fim'
,p_event_sequence=>1441
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_DT_PREV_FIM_CONTRATO'
,p_condition_element=>'P76_DT_PREV_FIM_CONTRATO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841261161199165964)
,p_event_id=>wwv_flow_api.id(271841260665713165964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P76_DT_PREV_FIM_CONTRATO,''/'');',
'',
'begin',
'',
':P76_DT_PREV_FIM_CONTRATO := v_dt;',
'',
'exception',
'when others then',
':P76_DT_PREV_FIM_CONTRATO := v_dt;',
'',
'end;'))
,p_attribute_02=>'P76_DT_PREV_FIM_CONTRATO'
,p_attribute_03=>'P76_DT_PREV_FIM_CONTRATO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841261621532165964)
,p_name=>'Mask Vlr Fat.'
,p_event_sequence=>1451
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841262099037165964)
,p_event_id=>wwv_flow_api.id(271841261621532165964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(replace(:p76_valor_faturavel,''.''),''R$'');',
'',
'begin',
'',
':p76_valor_faturavel := trim(to_char(v_sal,''999999990D00''));',
'',
'end;'))
,p_attribute_02=>'P76_VALOR_FATURAVEL'
,p_attribute_03=>'P76_VALOR_FATURAVEL'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841262522676165964)
,p_name=>'Retorna Insalub / Pericul'
,p_event_sequence=>1461
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_LOCAL_TRAB'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841263044695165965)
,p_event_id=>wwv_flow_api.id(271841262522676165964)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select l.ind_pericul, l.ind_insalub',
'  from local_trab l, filial_local f',
' where f.cod_empresa = :p76_cod_empresa',
'   and f.cod_filial = :p76_cod_filial',
'   and l.cod_local_trab = f.cod_local_filial',
'   and l.cod_local_trab = :p76_cod_local_trab;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p76_ind_insalub := v_c1.ind_insalub;',
':p76_ind_peric := v_c1.ind_pericul;',
'',
'end;'))
,p_attribute_02=>'P76_COD_EMPRESA,P76_COD_FILIAL,P76_COD_LOCAL_TRAB'
,p_attribute_03=>'P76_IND_INSALUB,P76_IND_PERIC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841263384213165965)
,p_name=>'Show Tipo_Registro'
,p_event_sequence=>1471
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_MARCA_PONTO'
,p_condition_element=>'P76_MARCA_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841263871347165965)
,p_event_id=>wwv_flow_api.id(271841263384213165965)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TP_REGISTRO_PONTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841264406175165965)
,p_event_id=>wwv_flow_api.id(271841263384213165965)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TP_REGISTRO_PONTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841264936633165966)
,p_event_id=>wwv_flow_api.id(271841263384213165965)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TP_REGISTRO_PONTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841265291378165966)
,p_name=>'Popula Utiliza_Secao'
,p_event_sequence=>1481
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_EMPRESA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841265782833165966)
,p_event_id=>wwv_flow_api.id(271841265291378165966)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao, IND_SERV_ALOCA_COLAB',
'  into :p76_utiliza_secao, :p76_IND_SERV_ALOCA_COLAB',
'  from parametros_recursos_humanos ',
' where cod_empresa = :p76_cod_empresa;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P76_COD_EMPRESA'
,p_attribute_03=>'P76_UTILIZA_SECAO,P76_IND_SERV_ALOCA_COLAB'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841266242685165966)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>1491
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_SIT_REQUISICAO'
,p_condition_element=>'P76_COD_SIT_REQUISICAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P76_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841267705761165967)
,p_event_id=>wwv_flow_api.id(271841266242685165966)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841268243303165967)
,p_event_id=>wwv_flow_api.id(271841266242685165966)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841266675356165967)
,p_event_id=>wwv_flow_api.id(271841266242685165966)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841267237247165967)
,p_event_id=>wwv_flow_api.id(271841266242685165966)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841268609683165968)
,p_name=>'(Hide/Show) DT_PREV_FIM_CONTRATO'
,p_event_sequence=>1501
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_TIPO_CONTRATO'
,p_condition_element=>'P76_TIPO_CONTRATO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841269052539165968)
,p_event_id=>wwv_flow_api.id(271841268609683165968)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841269594776165968)
,p_event_id=>wwv_flow_api.id(271841268609683165968)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841206563379165931)
,p_name=>'Empresa Aloca Colab?'
,p_event_sequence=>1511
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_IND_SERV_ALOCA_COLAB'
,p_condition_element=>'P76_IND_SERV_ALOCA_COLAB'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033238111608845)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(268834032377127608836)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841207119347165932)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_NOVO_CONTRATO,P76_ORGAO_PUBLICO,P76_VALOR_VENDA,P76_VAGA_FATURAVEL,P76_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033154953608844)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(268834032097593608834)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834032983062608842)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(268834032097593608834)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841207554497165932)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_NOVO_CONTRATO,P76_ORGAO_PUBLICO,P76_VALOR_VENDA,P76_VAGA_FATURAVEL,P76_VALOR_FATURAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033087356608843)
,p_event_id=>wwv_flow_api.id(271841206563379165931)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(268834032377127608836)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940535904360165766)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1521
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940535690614165764)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883937764057400698)
,p_event_id=>wwv_flow_api.id(269940535904360165766)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//lSpinner$ = apex.util.showSpinner();',
'',
'if (document.getElementById("CANCEL")) {',
'  document.getElementById("CANCEL").click();',
'}else{',
'  document.getElementById("CANCEL_1").click(); ',
'}',
'',
unistr('toastr.success("Reprova\00E7\00E3o Realizada com Sucesso!");'),
'',
'$(''#CREATE'').hide();',
'$(''#SAVE'').hide();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940536053793165768)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1531
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940535768525165765)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269883937850656400699)
,p_event_id=>wwv_flow_api.id(269940536053793165768)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//lSpinner$ = apex.util.showSpinner();',
'',
'if (document.getElementById("CANCEL")) {',
'  document.getElementById("CANCEL").click();',
'}else{',
'  document.getElementById("CANCEL_1").click(); ',
'}',
'',
unistr('toastr.success("Aprova\00E7\00E3o Realizada com Sucesso!");'),
'',
'$(''#CREATE'').hide();',
'$(''#SAVE'').hide();'))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269588271961332532685)
,p_name=>'Enable/Disable'
,p_event_sequence=>1541
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269588271472747532680)
,p_event_id=>wwv_flow_api.id(269588271961332532685)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P76_COD_SIT_REQUISICAO" ).getValue().length == 0 ||',
'    apex.item( "P76_ROWID" ).getValue().length == 0){',
'console.log(''Nova requisicao'');',
'}else{',
'  $("#INF_VAGA *").attr("disabled", "disabled").off(''click'');',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268834033330288608846)
,p_name=>unistr('Habilita/Desabilita Valor Aux\00EDlio')
,p_event_sequence=>1551
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_TIPO_MODALIDADE'
,p_condition_element=>'P76_TIPO_MODALIDADE'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'S,H'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033462015608847)
,p_event_id=>wwv_flow_api.id(268834033330288608846)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033509806608848)
,p_event_id=>wwv_flow_api.id(268834033330288608846)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033683438608849)
,p_event_id=>wwv_flow_api.id(268834033330288608846)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868551782470611656)
,p_event_id=>wwv_flow_api.id(268834033330288608846)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P76_TIPO_MODALIDADE").getValue() == ''H'') {',
unistr('     $("label[for=P76_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Home-Office)'')'),
'} else if (apex.item("P76_TIPO_MODALIDADE").getValue() == ''S'') {',
unistr('     $("label[for=P76_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Semi-Presencial)'')'),
'} else if (apex.item("P76_TIPO_MODALIDADE").getValue() == ''T'') {',
unistr('     $("label[for=P76_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Teletrabalho)'')'),
'} else if (apex.item("P76_TIPO_MODALIDADE").getValue() == ''E'') {',
unistr('     $("label[for=P76_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Everywhere)'')'),
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268834033706548608850)
,p_name=>'Valida Vlr Aux Tipo Modalidade'
,p_event_sequence=>1561
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VLR_AUX_TIPO_MODALIDADE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834033897045608851)
,p_event_id=>wwv_flow_api.id(268834033706548608850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :P76_PERC_BENEFICIO_VARIAVEL IS NULL then -- Full CLT',
'    if nvl(:p76_vlr_aux_tipo_modalidade,0) > 0 then',
'      :p76_total_salario := nvl(:p76_valor_verba,0) + nvl(:p76_remuneracao_variavel,0) /*+ nvl(:p76_vlr_aux_tipo_modalidade,0)*/;',
'    else',
'      :p76_total_salario := nvl(:p76_valor_verba,0) + nvl(:p76_remuneracao_variavel,0);',
'    end if;',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P76_PERC_BENEFICIO_VARIAVEL,P76_VALOR_VERBA,P76_REMUNERACAO_VARIAVEL,P76_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P76_TOTAL_SALARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268834034384196608856)
,p_name=>'(Pesquisa) Popula % Beneficio'
,p_event_sequence=>1571
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834034477281608857)
,p_event_id=>wwv_flow_api.id(268834034384196608856)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select PERC_BENEFICIO_VARIAVEL ',
'  from requisicao_vaga',
' where cod_requisicao = :p76_cod_requisicao;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  if v_c1.perc_beneficio_variavel is not null and :p76_perc_beneficio is null then',
'    :p76_perc_beneficio := v_c1.perc_beneficio_variavel;',
'  end if;',
'',
'  IF v_c1.perc_beneficio_variavel IN (20,30) THEN',
'    :P76_PERC_BENEFICIO_VARIAVEL := v_c1.perc_beneficio_variavel;',
'  ELSIF NVL(v_c1.perc_beneficio_variavel ,0) = 0 THEN',
'    :P76_PERC_BENEFICIO_VARIAVEL := NULL;',
'  ELSE',
'    :P76_PERC_BENEFICIO_VARIAVEL := 0;',
'    :P76_PERC_BENEF_EXCECAO := v_c1.perc_beneficio_variavel;',
'  END IF;',
'',
'end;'))
,p_attribute_02=>'P76_PERC_BENEFICIO,P76_COD_REQUISICAO'
,p_attribute_03=>'P76_PERC_BENEFICIO_VARIAVEL,P76_PERC_BENEF_EXCECAO,P76_PERC_BENEFICIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868550380058611642)
,p_event_id=>wwv_flow_api.id(268834034384196608856)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P76_PERC_BENEFICIO").getValue().trim().length > 0 ){',
'		',
'  //alert("PAGE LOAD #01");',
'  ',
'	  apex.item("P76_REMUNERACAO_VARIAVEL").show();',
'',
'	  if ( apex.item("P76_PERC_BENEFICIO").getValue().trim() > 0 && ',
'         apex.item("P76_PERC_BENEFICIO").getValue().trim() != 20 && ',
'         apex.item("P76_PERC_BENEFICIO").getValue().trim() != 30 &&',
'         apex.item("P76_PERC_BENEFICIO").getValue().trim() != "0,00" && ',
'         apex.item("P76_PERC_BENEFICIO").getValue().trim() != "20,00" && ',
'         apex.item("P76_PERC_BENEFICIO").getValue().trim() != "30,00" ){',
'      ',
'      //alert("PAGE LOAD #02");',
'      ',
'      if (apex.item("P76_COD_SIT_REQUISICAO").getValue() == 1) {',
'        //alert("PAGE LOAD #03");',
'    	  $x(''P76_REMUNERACAO_VARIAVEL'').disabled = false;',
'    	  apex.item("P76_REMUNERACAO_VARIAVEL").enable();',
'      }else{',
'        //alert("PAGE LOAD #04");',
'    	  $x(''P76_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	  apex.item("P76_REMUNERACAO_VARIAVEL").disable();',
'      }',
'      ',
'    	$x(''P76_VALOR_VERBA'').disabled = true;',
'    	apex.item("P76_VALOR_VERBA").disable();',
'      ',
'      apex.item("P76_PERC_BENEF_EXCECAO").show();',
'      apex.item("P76_PERC_BENEF_EXCECAO").setValue(apex.item("P76_PERC_BENEFICIO").getValue());',
'      apex.item("P76_MOTIVO_EXCECAO").show();',
'',
'	  } else {',
'      ',
'      //alert("PAGE LOAD #05");',
'      ',
'	  	apex.item("P76_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P76_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P76_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P76_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P76_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P76_VALOR_VERBA'').disabled = true;',
'    	apex.item("P76_VALOR_VERBA").disable();',
'	  }',
'',
'	} else {',
'		',
'    //alert("PAGE LOAD #06");',
'    ',
'		apex.item("P76_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P76_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P76_MOTIVO_EXCECAO").hide();',
'',
'	}',
'',
'//alert("PAGE LOAD #07");',
'',
'	if (apex.item("P76_TIPO_MODALIDADE").getValue() != ''P''){',
'    ',
'    //alert("PAGE LOAD #08");',
'		apex.item("P76_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'    ',
'    //alert("PAGE LOAD #09");',
'		apex.item("P76_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P76_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268834034562419608858)
,p_name=>unistr('(Pesquisa) Mostra % Exce\00E7\00E3o e Vlr Remunera\00E7\00E3o')
,p_event_sequence=>1581
,p_condition_element=>'P76_PERC_BENEFICIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834034766567608860)
,p_event_id=>wwv_flow_api.id(268834034562419608858)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO,P76_REMUNERACAO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834034859231608861)
,p_event_id=>wwv_flow_api.id(268834034562419608858)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO,P76_REMUNERACAO_VARIAVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268834034956444608862)
,p_name=>unistr('(Pesquisa) Mostra % (20,30) e Vlr Remunera\00E7\00E3o_1')
,p_event_sequence=>1591
,p_condition_element=>'P76_PERC_BENEFICIO'
,p_triggering_condition_type=>'GREATER_THAN'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834035005418608863)
,p_event_id=>wwv_flow_api.id(268834034956444608862)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_REMUNERACAO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834035145786608864)
,p_event_id=>wwv_flow_api.id(268834034956444608862)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_REMUNERACAO_VARIAVEL,P76_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268834035200106608865)
,p_event_id=>wwv_flow_api.id(268834034956444608862)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268868549936810611638)
,p_name=>'Mostra Valores (New)'
,p_event_sequence=>1601
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868550006545611639)
,p_event_id=>wwv_flow_api.id(268868549936810611638)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//alert("item #01");',
'',
'if (apex.item("P52_ROWID").getValue().length == 0 ){',
'  ',
'  //alert("item #02");',
'  ',
'	if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().length > 0 ){',
'		',
'    //alert("item #03");',
'    ',
'	  apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'	  if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue() == 0 ){',
'      ',
'      //alert("item #04");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").show();',
'	  	apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  } else {',
'      ',
'      //alert("item #05");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  }',
'',
'	} else {',
'    ',
'    //alert("item #06");',
'		',
'		apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'	}',
'',
'',
'}else{',
'',
'  //alert("item #07");',
'  ',
'  if (apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 ){',
'',
'    //alert("item #08");',
'    ',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'    if ( apex.item("P52_PERC_BENEFICIO").getValue().trim() > 0 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 20 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 30 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "0,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "20,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "30,00"){',
'',
'      //alert("item #09");',
'      ',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'      apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'      $x(''P52_SALARIO'').disabled = true;',
'      apex.item("P52_SALARIO").disable();',
'',
'      apex.item("P52_PERC_BENEF_EXCECAO").show();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue(apex.item("P52_PERC_BENEFICIO").getValue());',
'      apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    } else {',
'      ',
'      //alert("item #10");',
'      ',
'      apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'      apex.item("P52_MOTIVO_EXCECAO").hide();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'      apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'      $x(''P52_SALARIO'').disabled = true;',
'      apex.item("P52_SALARIO").disable();',
'        ',
'    }',
'',
'  } else {',
'    ',
'    //alert("item #11");',
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'      ',
'      if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue() == 0 ){',
'',
'          //alert("item #04");',
'',
'            apex.item("P52_PERC_BENEF_EXCECAO").show();',
'            apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'            $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'            apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'            $x(''P52_SALARIO'').disabled = true;',
'            apex.item("P52_SALARIO").disable();',
'',
'          } else {',
'',
'          //alert("item #05");',
'',
'            apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'            apex.item("P52_MOTIVO_EXCECAO").hide();',
'            apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'            $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'            apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'            $x(''P52_SALARIO'').disabled = true;',
'            apex.item("P52_SALARIO").disable();',
'',
'          }',
'',
'  }',
'',
'}',
'',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268959109447729328561)
,p_name=>unistr('Vinculo (E)stagi\00E1rio')
,p_event_sequence=>1611
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VINCULO'
,p_condition_element=>'P76_VINCULO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'E'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959109522930328562)
,p_event_id=>wwv_flow_api.id(268959109447729328561)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959109641807328563)
,p_event_id=>wwv_flow_api.id(268959109447729328561)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959109699928328564)
,p_event_id=>wwv_flow_api.id(268959109447729328561)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959109876031328565)
,p_event_id=>wwv_flow_api.id(268959109447729328561)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268802706771774074002)
,p_name=>'Vinculo (C)ontratado'
,p_event_sequence=>1621
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VINCULO'
,p_condition_element=>'P76_VINCULO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802707249330074007)
,p_event_id=>wwv_flow_api.id(268802706771774074002)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802707411809074008)
,p_event_id=>wwv_flow_api.id(268802706771774074002)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802707500130074009)
,p_event_id=>wwv_flow_api.id(268802706771774074002)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_TRAB_INTERMITENTE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(258596242630539545143)
,p_name=>'VALIDA_PISO_SALARIO'
,p_event_sequence=>1631
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_VALOR_VERBA'
,p_condition_element=>'P76_VALOR_VERBA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P76_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSIF :P76_ROWID IS NOT NULL AND :P76_COD_SIT_REQUISICAO IN (1,5) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258596242751569545144)
,p_event_id=>wwv_flow_api.id(258596242630539545143)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_ITEM_VALIDACAO VARCHAR2(100) := :P76_ITEM_VALIDACAO;',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'',
'V_DT DATE;',
'',
'begin',
'',
'IF :P76_ROWID IS NULL THEN',
'V_DT := SYSDATE;',
'ELSE',
unistr('V_DT := :P76_DT_ABERT_VAGA; -- :P76_DT_REQ; (n\00E3o existe esse campo na p\00E1gina)'),
'END IF;',
'',
'pkg_vagas.Valida_Piso_Salario (:P76_VALOR_VERBA',
'                           ,:P76_COD_EMPRESA',
'                           ,:P76_COD_CARGO',
'                           ,:P76_COD_SINDICATO',
'                           ,:P76_RT_JORNADA_MENSAL',
'                           ,:P76_TIPO_SALARIO',
'                           ,V_DT',
'                           ,V_FLG',
'                           ,V_MSG);',
'',
' if trim(v_msg) is not null then',
'    IF V_FLG = ''N'' THEN',
'    :P76_ITEM_VALIDACAO := TRIM(UPPER(''P76_VALOR_VERBA''));',
'    :p76_ok       := ''N'';',
'    ELSE',
'    :P76_ITEM_VALIDACAO := NULL;',
'    :p76_ok       := ''S'';',
'    END IF;',
'    :p76_flag     := v_flg;',
'    :p76_mensagem := v_msg;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P76_VALOR_VERBA'')) OR v_item_validacao IS NULL then',
'       :P76_OK := ''S'';',
'       :P76_ITEM_VALIDACAO := null;',
'    else',
'       :P76_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P76_ITEM_VALIDACAO,P76_ROWID,P76_DT_REQ,P76_VALOR_VERBA,P76_COD_CARGO,P76_COD_SINDICATO,P76_COD_EMPRESA,P76_RT_JORNADA_MENSAL,P76_TIPO_SALARIO,P76_DT_ABERT_VAGA'
,p_attribute_03=>'P76_ITEM_VALIDACAO,P76_OK,P76_FLAG,P76_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150022874069701217059)
,p_name=>'Open Create Local'
,p_event_sequence=>1641
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(150022873185159217050)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022874213885217060)
,p_event_id=>wwv_flow_api.id(150022874069701217059)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item("P76_URL_LOCAL_FULL").getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150022873330261217051)
,p_name=>'Dialog Closed (Local)'
,p_event_sequence=>1642
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(150022873185159217050)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022873403455217052)
,p_event_id=>wwv_flow_api.id(150022873330261217051)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_COD_LOCAL_TRAB'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148136052923045371903)
,p_event_id=>wwv_flow_api.id(150022873330261217051)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_COD_LOCAL_TRAB'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P76_COD_LOCAL_TRAB'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150022873506584217053)
,p_name=>'Dialog Closed (Local)_1'
,p_event_sequence=>1651
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_COD_LOCAL_TRAB'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022873627816217054)
,p_event_id=>wwv_flow_api.id(150022873506584217053)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_COD_LOCAL_TRAB'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148136053046820371904)
,p_event_id=>wwv_flow_api.id(150022873506584217053)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P76_COD_LOCAL_TRAB'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P76_COD_LOCAL_TRAB'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150022873725484217055)
,p_name=>'(Show/Hide) Btn Add Local'
,p_event_sequence=>1661
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_ATIVIDADE'
,p_condition_element=>'P76_ATIVIDADE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022873823171217056)
,p_event_id=>wwv_flow_api.id(150022873725484217055)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(150022873185159217050)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022873902856217057)
,p_event_id=>wwv_flow_api.id(150022873725484217055)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(150022873185159217050)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150022874277713217061)
,p_name=>'Popula URL_LOCAL'
,p_event_sequence=>1671
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P76_ATIVIDADE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150022874425791217062)
,p_event_id=>wwv_flow_api.id(150022874277713217061)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'V_URL VARCHAR2(500);',
'',
'begin',
'',
'V_URL := apex_page.get_url (',
'         p_application => ''MT_CAD_''||:P_BASE,',
'         p_page        => 40,',
'         p_items       => ''P_USUARIO,P_PAINEL,P40_COD_CCUSTO,P40_UNIDADE_ADM,P40_ATIVIDADE'',',
'         p_values      => :P_USUARIO||'',''||:P_PAINEL||'',''||:P76_COD_CCUSTO||'',''||:P76_COD_UNIDADE_ADM||'',''||:P76_ATIVIDADE,',
'         p_clear_cache => 40',
'       );',
'       ',
':P76_URL_LOCAL_FULL := V_URL;',
'   ',
'end;'))
,p_attribute_02=>'P76_COD_CCUSTO,P76_COD_UNIDADE_ADM,P76_ATIVIDADE'
,p_attribute_03=>'P76_URL_LOCAL_FULL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841204989899165930)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Solicitante'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa))||'' / ''||',
'        matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula))||'' / ''||',
'        cargo||'' - ''||initcap(fnct_nome_cargo(cargo)) colaborador',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p76_COD_EMPRESA_SOLICITANTE',
'    and matricula   = :p76_MAT_SOLICITANTE;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p76_solicitante := v_c1.colaborador;',
' end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841205418843165930)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'cursor c1 is',
' select Initcap(desc_sit_REQ) sit',
'   from SIT_REQ',
'  where cod_sit_req = :p76_cod_sit_requisicao;',
'  ',
'  v_c1 c1%rowtype;',
'',
'CURSOR C2 IS',
unistr('SELECT distinct NVL(V.COD_VAGA,''* Vaga ainda n\00E3o criada'') vaga'),
'  FROM REQUISICAO_VAGA R, CL_VAGA V',
' WHERE R.COD_EMPRESA = V.COD_EMPRESA (+)',
'   AND R.COD_REQUISICAO = V.COD_REQUISICAO (+)',
'   and R.COD_EMPRESA = :P76_COD_EMPRESA',
'   AND R.COD_REQUISICAO = :P76_COD_REQUISICAO',
'   ORDER BY 1;',
'   ',
'V_C2 C2%ROWTYPE;',
'',
'v_vagas varchar2(3000);',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'for l2 in c2',
'loop',
'    if v_vagas is null then',
'    v_vagas := l2.vaga; ',
'    else',
'    v_vagas := v_vagas||'', ''||l2.vaga;',
'    end if;',
'end loop;',
'',
'if :p76_rowid is not null then',
unistr('   :p76_titulo := ''Requisi\00E7\00E3o de Vaga: N\00BA ''||:p76_cod_requisicao||'' - ''||:p76_data_requisicao||'' (''||v_c1.sit||'') - Vaga: ''||v_vagas;'),
'   :p76_seq := null;',
'else',
unistr('   :p76_titulo := ''Requisi\00E7\00E3o de Vaga'';'),
'   :p76_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841205775971165930)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  cursor c1 is',
'  select cod_empresa, matricula, filial, cod_ccusto, cargo',
'    from informacoes_funcionais_cad',
'   where cod_empresa = :P_EMPRESA_USER',
'     and matricula   = :P_MATRICULA_USER;',
'     ',
'  v_c1 c1%rowtype;',
'/*',
'cursor c2 is',
'select distinct b.cod',
'  from filial_ccusto f, centro_de_custo c, ccusto_contab b',
' where f.cod_empresa = c.cod_empresa',
'   and f.cod_empresa = b.cod_empresa',
'   and f.cod_ccusto  = c.cod',
'   and c.cod_ccusto_cont = b.cod',
'   and f.cod_empresa = :p76_cod_empresa',
'   and f.cod_filial  = :p76_cod_filial',
'   and f.cod_ccusto  = :p76_cod_ccusto;',
'   ',
'v_c2 c2%rowtype;',
'*/',
'',
'cursor c3 is',
'select utiliza_estrutura_sal',
'  from parametros_recursos_humanos',
' where cod_empresa = :p76_cod_empresa;',
' ',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
'',
'--if :p76_ok = ''S'' then',
'',
':P76_valor_verba            := nvl(:p76_valor_verba,0);',
'',
'    IF :P76_COEFICIENTE_FTE IS NULL THEN',
'	    :P76_COEFICIENTE_FTE := 100;',
'	END IF;',
'  --',
'	SELECT seq_requisicao.NEXTVAL',
'	  INTO :P76_cod_requisicao',
'	  FROM DUAL;',
'	--',
'	:P76_cod_sit_requisicao := 1;',
'  :P76_usuario            := :p_usuario;',
'  :P76_data_requisicao    := sysdate;',
'  :P76_dt_atualizacao     := SYSDATE;',
'  ',
'  if v_c3.utiliza_estrutura_sal = ''S'' then',
'  :P76_cod_ponto_faixa := ''A'';',
'  else',
'  :P76_cod_ponto_faixa := ''Z'';',
'  end if;',
'  ',
'  :P76_cod_sindicato_pf    := 999;',
'',
'if :p76_data_inicio is null then',
':p76_data_inicio := :p76_dt_abert_vaga;',
'end if;',
'',
'if :p76_vaga_faturavel is null then',
':p76_vaga_faturavel := ''N'';',
'end if;',
'',
'if :p76_vaga_confidencial is null then',
':p76_vaga_confidencial := ''N'';',
'end if;',
'',
'if :p76_ind_def_fis is null then',
':p76_ind_def_fis := ''N'';',
'end if;',
'',
'if :p76_rais_ind_def_auditiva is null then',
':p76_rais_ind_def_auditiva := ''N'';',
'end if;',
'',
'if :p76_rais_ind_def_fisico is null then',
':p76_rais_ind_def_fisico := ''N'';',
'end if;',
'',
'if :p76_rais_ind_def_mental is null then',
':p76_rais_ind_def_mental := ''N'';',
'end if;',
'',
'if :p76_rais_ind_def_multipla is null then',
':p76_rais_ind_def_multipla := ''N'';',
'end if;',
'',
'if :p76_rais_ind_def_visual is null then',
':p76_rais_ind_def_visual := ''N'';',
'end if;',
'',
'if :P76_IND_INSALUB is null then',
':P76_IND_INSALUB := ''N'';',
'end if;',
'',
'if :P76_IND_PERIC is null then',
':P76_IND_PERIC := ''N'';',
'end if;',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  :p76_cod_empresa_solicitante := v_c1.cod_empresa;',
'  :p76_cod_filial_solicitante := v_c1.filial;',
'  :p76_cod_ccusto_solicitante := v_c1.cod_ccusto;',
'  :p76_cod_cargo_solicitante := v_c1.cargo;',
'  :p76_mat_solicitante := v_c1.matricula;',
'  ',
'  ',
'IF :P76_PERC_BENEFICIO IS NULL THEN',
'  IF :P76_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(:P76_PERC_BENEF_EXCECAO,0) > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEF_EXCECAO;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(:P76_PERC_BENEF_EXCECAO,0) = 0 THEN',
'     :P76_PERC_BENEFICIO := NULL;',
'  END IF;',
'END IF;',
'  ',
'/*',
'if :p76_cod_ccusto_contab is null then',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
':p76_cod_ccusto_contab := v_c2.cod;',
'',
'end if;',
'*/',
'',
'if :P76_TP_REGISTRO_PONTO is null then ',
' SELECT NVL(TIPO_REG_PONTO_PADRAO,''F'')',
'   INTO :P76_TP_REGISTRO_PONTO',
'   FROM PARAMETROS_RECURSOS_HUMANOS',
'  WHERE COD_EMPRESA = :P76_COD_EMPRESA;',
'END IF;',
'',
'',
'',
'    begin',
'        update beneficios_vaga_temp',
'           set cod_requisicao = :p76_cod_requisicao',
'         where seq = :p76_seq;',
'         ',
'    commit;',
'    end;',
'',
'--end if;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841165110802165899)
,p_process_when=>'P76_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_process_when2=>'N'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841206182211165931)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P76_PERC_BENEFICIO IS NULL THEN',
'  IF :P76_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(:P76_PERC_BENEF_EXCECAO,0) > 0 THEN',
'     :P76_PERC_BENEFICIO := :P76_PERC_BENEF_EXCECAO;',
'  ELSIF :P76_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(:P76_PERC_BENEF_EXCECAO,0) = 0 THEN',
'     :P76_PERC_BENEFICIO := NULL;',
'  END IF;',
'END IF;',
'  ',
':p76_usuario := :p_usuario;',
'  :p76_dt_atualizacao := sysdate;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841164737498165899)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841204581520165929)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQUISICAO_VAGA'
,p_attribute_02=>'REQUISICAO_VAGA'
,p_attribute_03=>'P76_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841165110802165899)
,p_process_when=>'P76_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_process_when2=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269588272445224532690)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Altera Situa\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'UPDATE REQUISICAO_VAGA',
'   SET COD_SIT_REQUISICAO = :P76_COD_SIT_REQUISICAO,',
'       USUARIO = :P_USUARIO,',
'       DT_ATUALIZACAO = SYSDATE',
' WHERE COD_REQUISICAO = :P76_COD_REQUISICAO;',
' ',
'COMMIT;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841164737498165899)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841202625250165928)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
'    update requisicao_vaga',
'       set remuneracao_variavel = :P76_REMUNERACAO_VARIAVEL,',
'           valor_verba = :p76_valor_verba,',
'           valor_total = :P76_TOTAL_SALARIO,',
'           vlr_aux_tipo_modalidade = :p76_vlr_aux_tipo_modalidade,',
'           PERC_BENEFICIO_VARIAVEL = :P76_PERC_BENEFICIO',
'     where cod_requisicao = :p76_cod_requisicao;',
'     ',
'     commit;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'     ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841165110802165899)
,p_process_when=>'P76_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_process_when2=>'N'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841202950645165928)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'-- :p76_mensagem := null;',
'',
'insert into testex values (111,''APEX Req_Vaga #01''); commit;',
'',
'pkg_vagas.Post_Insert(:p76_cod_requisicao, v_flg_retorno, v_msg_retorno);',
'',
'insert into testex values (111,''APEX Req_Vaga #02''); commit;',
'',
' if v_msg_retorno is not null then',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    :p76_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841165110802165899)
,p_process_when=>'P76_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_process_when2=>'N'
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841203401021165929)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'-- :p76_mensagem := null;',
'',
'pkg_vagas.Post_Update(:p76_cod_empresa, :p76_cod_requisicao, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p76_ok       := ''N'';',
'    :p76_flag     := v_flg_retorno;',
'    :p76_mensagem := v_msg_retorno;',
' else',
'    :p76_flag     := null;',
'    :p76_mensagem := null;',
'    :p76_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271841164737498165899)
,p_process_when=>'P76_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_process_when2=>'N'
,p_process_success_message=>unistr('Requisi\00E7\00E3o alterada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841203775711165929)
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
'end;',
':p76_OK := ''S'';',
'if :p76_OK is null then',
':p76_OK := ''S'';',
':p76_mensagem := null;',
':p76_flag := null;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271841204210651165929)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'REQUISICAO_VAGA'
,p_attribute_03=>'P76_COD_EMPRESA'
,p_attribute_04=>'COD_EMPRESA'
,p_attribute_05=>'P76_COD_REQUISICAO'
,p_attribute_06=>'COD_REQUISICAO'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P76_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271326679024664124255)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Utiliza Se\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao, IND_SERV_ALOCA_COLAB',
'  into :p76_utiliza_secao, :p76_IND_SERV_ALOCA_COLAB',
'  from parametros_recursos_humanos ',
' where cod_empresa = :p76_cod_empresa;',
' ',
'exception',
'when others then',
'null;',
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
