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
,p_default_application_id=>2280
,p_default_id_offset=>785162071094797180
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2280 - Requisição de Indicação de Movimentação - Natcorp
--
-- Application Export:
--   Application:     2280
--   Name:            Requisição de Indicação de Movimentação - Natcorp
--   Date and Time:   19:00 Wednesday September 30, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 184
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00184
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>184);
end;
/
prompt --application/pages/page_00184
begin
wwv_flow_api.create_page(
 p_id=>184
,p_user_interface_id=>wwv_flow_api.id(28784976571400259323)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Indica\00E7\00E3o de Movimenta\00E7\00E3o')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Indica\00E7\00E3o de Movimenta\00E7\00E3o')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_IndMovimentacao.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.setThemeHooks({',
'    beforeShow: function( pMsgType, pElement$ ){',
'        if ( pMsgType === apex.message.TYPE.ERROR ) {',
'          ',
'            if (apex.item( "P184_COD_SIT_REQ" ).getValue() == ''2'' || ',
'                apex.item( "P184_COD_SIT_REQ" ).getValue() == ''3'' || ',
'                apex.item( "P184_COD_SIT_REQ" ).getValue() == ''4'')',
'            {',
'',
'            apex.item( "P184_COD_SIT_REQ" ).disable() ;',
'            apex.item( "P184_COD_EMP_SOLICITADO" ).disable() ;',
'            apex.item( "P184_COD_MAT_SOLICITADO" ).disable() ;',
'            apex.item( "P184_COD_FILIAL_ATUAL" ).disable() ;',
'//            apex.item( "P184_COD_CCUSTO" ).disable() ;',
'//            apex.item( "P184_SIT_DESLIG" ).disable() ;',
'            $(''#P184_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'//            apex.item( "P184_COD_MOT_DESLIG" ).disable() ;',
'//            $(''#P184_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'//            apex.item( "P184_AVISO_PREVIO" ).disable() ;',
'//            apex.item( "P184_HAVERA_REP" ).disable() ;',
'//            apex.item( "P184_IND_REALOCACAO" ).disable() ;',
'//            apex.item( "P184_RESTRICAO_REALOCACAO" ).disable() ;',
'//            apex.item( "P184_JUSTIFICATIVA" ).disable() ;',
'//            apex.item( "P184_DT_COMUNICACAO" ).disable() ;',
'//            apex.item( "P184_DT_SIT_DESLIGAMENTO" ).disable() ;',
'//            apex.item( "P184_TP_AV_PREVIO" ).disable() ;',
'//            apex.item( "P184_INDCUMPRPARC" ).disable() ;',
'            apex.item( "P184_OBSERVACAO" ).disable() ;',
'            }',
'',
'',
'',
'        }',
'    }',
'});'))
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_IndMovimentacao.css / Natcorp_IndMovimentacao.js)',
'',
unistr('A estrutura \00E9 toda do APEX; o .js s\00F3 reorganiza a leitura (sem classe no APEX). O stepper'),
unistr('"P\00E1gina \00FAnica / Etapas" \00E9 do time (Natcorp_Allow_Unload_Iframes.js, classe nc-stepper-host) e'),
unistr('n\00E3o \00E9 tocado.'),
unistr('  Pedido novo: passos 1 Quem vai mudar? \00B7 2 O que muda? \00B7 3 Por que mudar?; o quadro'),
unistr('  "Hoje \2192 Vai para" (Filial, Cargo, Fun\00E7\00E3o, Local de trabalho) com o selo Muda / Continua igual /'),
unistr('  Falta escolher; "Continua igual" copia o c\00F3digo de hoje (itens P184_COD_*_ATUAL) respeitando'),
unistr('  as listas em cascata (Cargo antes da Fun\00E7\00E3o, Filial antes do Local); barra no p\00E9 com o que falta'),
'  e "Criar" = "Enviar pedido".',
unistr('  Pedido gravado: cabe\00E7alho com c\00F3digo - descri\00E7\00E3o de cada mudan\00E7a (de \2192 para), empresa, motivo'),
unistr('  e quem pediu; a regi\00E3o Aprovadores vem logo abaixo, na largura toda, como o caminho das outras'),
unistr('  requisi\00E7\00F5es.'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/INDMOVIMENTACAO-MANUTENCAO.md.'))
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260909232456'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2293494568619613522)
,p_plug_name=>'Steppers'
,p_region_css_classes=>'nc-stepper-host'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2293494620792613523)
,p_plug_name=>unistr('Identifica\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(2293494568619613522)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650886691555846063)
,p_plug_name=>'&P184_TITULO.'
,p_parent_plug_id=>wwv_flow_api.id(2293494620792613523)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(3507854267645708606)
,p_plug_name=>'Colaborador'
,p_parent_plug_id=>wwv_flow_api.id(2293494568619613522)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2293494799380613525)
,p_plug_name=>'Colaborador'
,p_parent_plug_id=>wwv_flow_api.id(3507854267645708606)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650896256643846073)
,p_plug_name=>unistr('Informa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(2293494568619613522)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2293494970822613526)
,p_plug_name=>unistr('Informa\00E7\00F5es para Indica\00E7\00E3o de Movimenta\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(193650896256643846073)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650881046451846056)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(18577973963240268328)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(28784971862157259274)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(193650881489562846058)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(28784950574562259229)
,p_display_sequence=>70
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from aprova_indicacao_movimentacao a, usuario_oracle u',
' where a.cod_requisicao = :p184_cod_requisicao ',
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
'  from aprova_indicacao_movimentacao a, usuario_oracle u',
' where a.cod_requisicao = :p184_cod_requisicao ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'      and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_indicacao_movimentacao',
' where cod_requisicao = :p184_cod_requisicao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P184_COD_REQUISICAO'
,p_query_row_template=>wwv_flow_api.id(28784959386116259245)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507165613097782323)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507162751481782322)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507163124511782322)
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
 p_id=>wwv_flow_api.id(3507163618225782322)
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
 p_id=>wwv_flow_api.id(3507163970718782322)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507164337568782323)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507164753895782323)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3507165174726782323)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650885062815846062)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noPadding:t-ButtonRegion--noUI:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(28784942580240259216)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650892658983846067)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>60
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--* ',
'server-side condition',
'plsql function body',
'IF :P184_ROWID IS NOT NULL AND :P184_COD_MAT_SOLICITADO IS NOT NULL THEN',
'return true;',
'ELSE',
'return false;',
'END IF;'))
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650893432876846070)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(193650892658983846067)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(193650894291209846071)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(193650892658983846067)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(28784950574562259229)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507168936094782324)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_button_name=>'p184_btn_solicitante'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(28784971250089259270)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P184 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P184_COD_EMP_SOLICITANTE.,&P184_COD_MAT_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507165926427782323)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(193650881489562846058)
,p_button_name=>'p184_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(28784971539880259273)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P184_COD_REQUISICAO.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_indicacao_movimentacao',
' where cod_requisicao = :p184_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
' ',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'pkg_req_indicacao_movto.Valida_Sequencia(:p184_cod_emp_solicitado, :p184_cod_requisicao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
'END IF; ',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507167121081782323)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(193650885062815846062)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(28784971366160259273)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:183:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507167463968782323)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(193650885062815846062)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(28784971366160259273)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507167903475782324)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(193650885062815846062)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(28784971366160259273)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p184_rowid is not null then',
'',
'    if :p184_cod_sit_req in (1,5,6) then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507168279792782324)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(193650885062815846062)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(28784971366160259273)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P184_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507166327318782323)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(193650881489562846058)
,p_button_name=>'p184_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(28784971539880259273)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P184_COD_REQUISICAO.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_indicacao_movimentacao',
' where cod_requisicao = :p184_cod_requisicao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'  pkg_req_indicacao_movto.Valida_Sequencia(:p184_cod_emp_solicitado, :p184_cod_requisicao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'      IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'          RETURN TRUE;',
'      ELSE',
'          RETURN FALSE;',
'      END IF;',
'',
'  ELSE',
'',
'  RETURN FALSE;',
'',
'  END IF;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507857145323708635)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(3507854267645708606)
,p_button_name=>'p184_btn_solicitado'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(28784971250089259270)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P184 btn solicitado'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P184_COD_EMP_SOLICITADO.,&P184_COD_MAT_SOLICITADO.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(3507175696828782326)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(193650892658983846067)
,p_button_name=>'p184_btn_colab'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(28784971250089259270)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3507272173442782354)
,p_branch_name=>'Create: Go To Page 183'
,p_branch_action=>'f?p=&APP_ID.:183:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(3507168279792782324)
,p_branch_sequence=>1
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3507271325759782354)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3507272590704782354)
,p_branch_name=>'Save: Go To Page 183'
,p_branch_action=>'f?p=&APP_ID.:183:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(3507167903475782324)
,p_branch_sequence=>41
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(3507271002735782353)
,p_branch_name=>'Go To Page Page Branch'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>31
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'APROVAR,REPROVAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507169366155782324)
,p_name=>'P184_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507169800414782324)
,p_name=>'P184_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507170201448782324)
,p_name=>'P184_FLAG'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507170568795782324)
,p_name=>'P184_MENSAGEM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507170996649782325)
,p_name=>'P184_OK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507171332114782325)
,p_name=>'P184_COD_REQUISICAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507171770606782325)
,p_name=>'P184_COD_SIT_REQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
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
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507172148710782325)
,p_name=>'P184_DT_REQUISICAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_item_default=>'04/04/2025'
,p_prompt=>'Data de Abertura'
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DT_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507172553667782325)
,p_name=>'P184_SOLICITANTE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507173011014782326)
,p_name=>'P184_ITEM_VALIDACAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507173344242782326)
,p_name=>'P184_USUARIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507173784014782326)
,p_name=>'P184_DT_ATUALIZACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507174169833782326)
,p_name=>'P184_COD_EMP_SOLICITANTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507174621046782326)
,p_name=>'P184_COD_MAT_SOLICITANTE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507174991294782326)
,p_name=>'P184_PERFIL_USUARIO_LOGADO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(193650886691555846063)
,p_source=>'P_PERFIL'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507176358190782327)
,p_name=>'P184_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(193650893432876846070)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P184_COD_EMP_SOLICITADO',
'   and matricula = :P184_COD_MAT_SOLICITADO'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507177105233782327)
,p_name=>'P184_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507177507079782327)
,p_name=>'P184_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507177908056782327)
,p_name=>'P184_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507178224484782327)
,p_name=>'P184_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507178713583782327)
,p_name=>'P184_IND_CONTRATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>'Tipo de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(28784971023284259266)
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
 p_id=>wwv_flow_api.id(3507179110186782327)
,p_name=>'P184_DT_CONTRATO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>'Data de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507179438357782328)
,p_name=>'P184_DT_PRORROG'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(193650894291209846071)
,p_prompt=>unistr('Data de Prorroga\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507182173453782328)
,p_name=>'P184_COD_EMP_SOLICITADO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2293494799380613525)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMP_SOLICITADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod',
'  from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :p184_cod_requisicao is null) or ',
'        (:p184_cod_requisicao is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_REQUISICAO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507182562455782329)
,p_name=>'P184_COD_FILIAL_ATUAL'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FILIAL_ATUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507183337125782329)
,p_name=>'P184_COD_MAT_SOLICITADO'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2293494799380613525)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_placeholder=>'- Selecione -'
,p_source=>'COD_MAT_SOLICITADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, p.matricula',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p184_cod_emp_solicitado',
'  and f.filial = nvl(:p184_cod_filial_atual,f.filial)',
'  and f.situacao   < ''90''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_EMP_SOLICITADO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507193010134782331)
,p_name=>'P184_OBSERVACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507853241757708596)
,p_name=>'P184_COD_FILIAL_PROP'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial Proposta'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_FILIAL_PROP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(fnct_nome_filial(cod_empresa, cod_filial, ''S'')) descricao, cod_filial',
'  from filiais',
' where cod_empresa = :p184_cod_emp_solicitado',
'   AND encer_ativ = ''N'' ',
'   AND SIT NOT IN (''E'',''I'')',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_EMP_SOLICITADO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507853359219708597)
,p_name=>'P184_COD_CARGO_ATUAL'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO_ATUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507853423249708598)
,p_name=>'P184_COD_CARGO_PROP'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cargo Proposto'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_CARGO_PROP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.descricao d, x.cod c',
'  from (',
'select SUBSTR(c.cod,1,7)||'' - ''||initcap(c.nome) descricao , cod',
'  from cargos_empresas e, cargos c, parametros_recursos_humanos p',
' where e.cod_empresa = p.cod_empresa',
'   and e.cod_cargo = c.cod',
'   and c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and e.cod_empresa = :p184_cod_emp_solicitado',
'   and p.ind_empresa_cargo = ''S''',
'union ',
'SELECT SUBSTR(c.cod,1,7)||'' - ''||initcap(nome) descricao , cod',
'  from cargos c',
' where c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and exists (select 1',
'                 from parametros_recursos_humanos p',
'                where p.cod_empresa = :p184_cod_emp_solicitado',
'                  and p.ind_empresa_cargo = ''N'')',
') x',
' where exists (select 1',
'                     from cargos_local_trab c ',
'                    where c.cod_cargo = x.cod',
'                  )',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_EMP_SOLICITADO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>6
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507853560630708599)
,p_name=>'P184_COD_FUNCAO_ATUAL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FUNCAO_ATUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507853652636708600)
,p_name=>'P184_COD_FUNCAO_PROP'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fun\00E7\00E3o Proposta')
,p_placeholder=>'- Selecione -'
,p_source=>'COD_FUNCAO_PROP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' d, cod c',
'  from funcao',
' where sysdate between nvl(dt_inic_vig_funcao,sysdate) and nvl(dt_term_vig_funcao,sysdate)',
'   and cod_cargo = :p184_cod_cargo_prop',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_EMP_SOLICITADO,P184_COD_CARGO_PROP'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>6
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507854086720708604)
,p_name=>'P184_COD_LOCAL_TRAB_ATUAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_LOCAL_TRAB_ATUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507854154519708605)
,p_name=>'P184_COD_LOCAL_TRAB_PROP'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local de Trabalho Proposto'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_LOCAL_TRAB_PROP'
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
'      FROM local_trab l, filial_local f, cargos_local_trab clt',
'     WHERE trunc(sysdate) between clt.dt_validade_inicial and clt.dt_validade_final',
'       and clt.cod_cargo = :p184_cod_cargo_prop',
'       and nvl(L.ATIVO,''S'') = ''S''',
'       AND l.cod_local_trab = f.cod_local_filial',
'       AND F.COD_EMPRESA = :p184_cod_emp_solicitado',
'       AND F.COD_FILIAL = :p184_cod_filial_prop',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P184_COD_EMP_SOLICITADO,P184_COD_FILIAL_PROP'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>10
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P184_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(28784971184992259267)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507855626173708620)
,p_name=>'P184_CARGO_ATUAL_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_prompt=>'Cargo Atual'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507855770864708621)
,p_name=>'P184_FUNCAO_ATUAL_DSP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_prompt=>unistr('Fun\00E7\00E3o Atual')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3507855849484708622)
,p_name=>'P184_LOCAL_TRAB_ATUAL_DSP'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_prompt=>'Local de Trabalho Atual'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3509288376161131391)
,p_name=>'P184_FILIAL_ATUAL_DSP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(2293494970822613526)
,p_prompt=>'Filial Atual'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(28784971023284259266)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3507198071255782333)
,p_validation_name=>unistr('Valida Sit Requisi\00E7\00E3o')
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' Pkg_Req_indicacao_Movto.valida_sit_requisicao(:p184_cod_requisicao, :p184_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then --* retirar o 1 = 2',
'   return v_msg_retorno;',
' end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(3507171770606782325)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3507199660737782334)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :p184_cod_sit_req = 2 THEN --* retirar o 1 = 2',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(192375026317068860778)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3507857075607708634)
,p_validation_name=>'Valida Req Existente'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  for x in (select r.cod_requisicao',
unistr('            ,''Opera\00E7\00E3o n\00E3o permitida. Colaborador j\00E1 possui a Requisi\00E7\00E3o de Indica\00E7\00E3o de Movimenta\00E7\00E3o nr\00B0 ''||r.cod_requisicao||'),
'              decode(r.cod_sit_req,1,'' em aberto.'',6,'' suspensa.'')||'' Favor verificar.'' mensagem_erro',
'            from   req_indicacao_movimentacao r',
'            where  r.cod_mat_solicitado = :p184_cod_mat_solicitado',
'            and    r.cod_emp_solicitado = :p184_cod_emp_solicitado',
'            and    r.cod_sit_req in (1, 5, 6)',
'            order  by 1 desc) loop',
'    if x.cod_requisicao is not null then',
'      return x.mensagem_erro;',
'    end if;',
'    exit;',
'  end loop;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'P184_ROWID'
,p_validation_condition_type=>'ITEM_IS_NULL'
,p_associated_item=>wwv_flow_api.id(3507183337125782329)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507254910534782349)
,p_name=>'Hide Region'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P184_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507255362915782349)
,p_event_id=>wwv_flow_api.id(3507254910534782349)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(193650886691555846063)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507259573468782350)
,p_name=>unistr('Valida Sit Requisi\00E7\00E3o')
,p_event_sequence=>1081
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507260034773782350)
,p_event_id=>wwv_flow_api.id(3507259573468782350)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_flg_retorno varchar2(3);',
'  v_msg_retorno varchar2(4000);',
'',
'  v_item_validacao varchar2(100) := :P184_ITEM_VALIDACAO;',
'',
'begin',
'',
'  v_item_validacao     := null;',
'  :P184_ITEM_VALIDACAO := null;',
'',
'  Pkg_Req_indicacao_Movto.valida_sit_requisicao(:p184_cod_requisicao,',
'                                   :p184_cod_sit_req,',
'                                   :p_usuario,',
'                                   v_flg_retorno,',
'                                   v_msg_retorno);',
'',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P184_ITEM_VALIDACAO := TRIM(UPPER(''P184_COD_SIT_REQ'')); --* :P184_ITEM_VALIDACAO := TRIM(UPPER(''P184_SIT_DESLIGAMENTO''));',
'    :P184_ok             := ''N'';',
'    :P184_flag           := v_flg_retorno;',
'    :P184_mensagem       := v_msg_retorno;',
'  elsif nvl(v_flg_retorno, ''S'') = ''S'' then',
'    :P184_flag     := v_flg_retorno;',
'    :P184_mensagem := trim(v_msg_retorno);',
'    if v_item_validacao = TRIM(UPPER(''P184_COD_SIT_REQ'')) OR',
'       v_item_validacao IS NULL then',
'      :P184_OK             := ''S'';',
'      :P184_ITEM_VALIDACAO := null;',
'    else',
'      :P184_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P184_ITEM_VALIDACAO,P184_COD_REQUISICAO,P184_COD_SIT_REQ'
,p_attribute_03=>'P184_FLAG,P184_MENSAGEM,P184_OK,P184_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507260427424782350)
,p_name=>'Dispara Alerta'
,p_event_sequence=>1091
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507260932644782350)
,p_event_id=>wwv_flow_api.id(3507260427424782350)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P184_FLAG'').value == "Q") {',
'alertify.confirm($v(''P184_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P184_FLAG'').value = ''S'';',
'        $x(''P184_MENSAGEM'').value = '''';',
'        $x(''P184_OK'').value = ''S'';',
'       // $(''#P184_CREATE'').show();',
'    } else {',
'        $x(''P184_OK'').value = ''N'';',
'      //  $(''#P184_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P184_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P184_FLAG'').value == "N") {',
'           // $(''#P184_CREATE'').hide();',
'        } else {',
'          //  $(''#P184_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P184_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507261392213782350)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1101
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507261915361782351)
,p_event_id=>wwv_flow_api.id(3507261392213782350)
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
 p_id=>wwv_flow_api.id(3507265957231782352)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>1141
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P184_COD_SIT_REQ'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507207967018782337)
,p_name=>unistr('Desabilita Campos (Em Aprova\00E7\00E3o)')
,p_event_sequence=>1201
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'server-side condition',
'function return',
'IF 1 = 2 THEN',
'if :P184_COD_SIT_REQ not in (1) then',
'  return true;',
'  else',
'  return false;',
'  end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507208423234782337)
,p_event_id=>wwv_flow_api.id(3507207967018782337)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P184_COD_EMP_SOLICITADO,P184_COD_MAT_SOLICITADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507210230411782338)
,p_name=>'Desabilita Campos (Aprovado)'
,p_event_sequence=>1221
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'server-side condition',
'function return boolean',
'IF 1 = 2 THEN',
'if :P184_COD_SIT_REQ in (3,4,6) then',
'  return true;',
'else',
'  return false;',
'end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507210790568782338)
,p_event_id=>wwv_flow_api.id(3507210230411782338)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P184_COD_EMP_SOLICITADO,P184_COD_MAT_SOLICITADO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507213864733782339)
,p_name=>'Desabilita Dt_Sit_Deslig'
,p_event_sequence=>1261
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_DES_DT_SIT_DESLIG'
,p_condition_element=>'P184_DES_DT_SIT_DESLIG'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507214355547782339)
,p_event_id=>wwv_flow_api.id(3507213864733782339)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P184_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507214910496782339)
,p_event_id=>wwv_flow_api.id(3507213864733782339)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P184_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507219522302782340)
,p_name=>'Popula Dados Colab'
,p_event_sequence=>1301
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_MAT_SOLICITADO'
,p_condition_element=>'P184_COD_MAT_SOLICITADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P184_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507219975965782340)
,p_event_id=>wwv_flow_api.id(3507219522302782340)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.filial,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial)) filial_atual_dsp,',
'       i.cargo,',
'       i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo_atual_dsp,',
'       i.funcao,',
'       i.funcao||'' - ''||initcap(fnct_nome_funcao(i.cargo,i.funcao)) funcao_atual_dsp,',
'       i.cod_localizacao,',
'       i.cod_localizacao||'' - ''||initcap(fnct_nome_local_trab(i.cod_localizacao)) local_trab_atual_dsp',
'  from informacoes_funcionais_cad i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula   = p.matricula',
'   and i.cod_empresa = :p184_cod_emp_solicitado',
'   and i.matricula   = :p184_cod_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'/*',
'if :p184_cod_filial is null then',
':p184_cod_filial := v_c1.filial;',
'end if;',
'',
'if :p184_cod_ccusto is null then',
':p184_cod_ccusto := v_c1.cod_ccusto;',
'end if;',
'*/',
'if :p184_filial_atual_dsp is null then',
':p184_filial_atual_dsp := v_c1.filial_atual_dsp;',
'end if;',
'',
'if :p184_cod_filial_atual is null then',
':p184_cod_filial_atual := v_c1.filial;',
'end if;',
'',
'if :p184_cargo_atual_dsp is null then',
':p184_cargo_atual_dsp := v_c1.cargo_atual_dsp;',
'end if;',
'',
'if :p184_cod_cargo_atual is null then',
'  :p184_cod_cargo_atual  := v_c1.cargo;',
'end if;',
'',
'if :p184_funcao_atual_dsp is null then',
':p184_funcao_atual_dsp := v_c1.funcao_atual_dsp;',
'end if;',
'',
'if :p184_cod_funcao_atual is null then',
'  :p184_cod_funcao_atual  := v_c1.funcao;',
'end if;',
'',
'if :p184_local_trab_atual_dsp is null then',
':p184_local_trab_atual_dsp := v_c1.local_trab_atual_dsp;',
'end if;',
'',
'if :p184_cod_local_trab_atual is null then',
'  :p184_cod_local_trab_atual  := v_c1.cod_localizacao;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P184_COD_EMP_SOLICITADO,P184_COD_MAT_SOLICITADO'
,p_attribute_03=>'P184_COD_FILIAL_ATUAL,P184_COD_CARGO_ATUAL,P184_COD_FUNCAO_ATUAL,P184_COD_LOCAL_TRAB_ATUAL,P184_FILIAL_ATUAL_DSP,P184_CARGO_ATUAL_DSP,P184_FUNCAO_ATUAL_DSP,P184_LOCAL_TRAB_ATUAL_DSP,P184_OBSERVACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507856398369708627)
,p_event_id=>wwv_flow_api.id(3507219522302782340)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :p184_cod_filial_atual     := null;',
'  :p184_cod_cargo_atual      := null;',
'  :p184_cod_funcao_atual     := null;',
'  :p184_cod_local_trab_atual := null;',
'  :p184_cod_filial_prop      := null;',
'  :p184_cod_cargo_prop       := null;',
'  :p184_cod_funcao_prop      := null;',
'  :p184_cod_local_trab_prop  := null;',
'  :p184_observacao           := null;',
'  :p184_filial_atual_dsp     := null;',
'  :p184_cargo_atual_dsp      := null;',
'  :p184_funcao_atual_dsp     := null;',
'  :p184_local_trab_atual_dsp := null;',
'end;'))
,p_attribute_03=>'P184_COD_FILIAL_ATUAL,P184_COD_CARGO_ATUAL,P184_COD_FUNCAO_ATUAL,P184_COD_LOCAL_TRAB_ATUAL,P184_FILIAL_ATUAL_DSP,P184_CARGO_ATUAL_DSP,P184_FUNCAO_ATUAL_DSP,P184_LOCAL_TRAB_ATUAL_DSP,P184_OBSERVACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507224707543782341)
,p_name=>'(Save) Habilitar Campos'
,p_event_sequence=>1331
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(3507167903475782324)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509288606456131393)
,p_event_id=>wwv_flow_api.id(3507224707543782341)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507239305023782345)
,p_name=>unistr('Show/Hide Aprova\00E7\00F5es')
,p_event_sequence=>1471
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_SIT_REQ'
,p_condition_element=>'P184_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'server-side condition',
'item is not null rowid'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507242863343782345)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1511
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(3507165926427782323)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509288177388131389)
,p_event_id=>wwv_flow_api.id(3507242863343782345)
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
'begin',
'',
'PKG_REQ_INDICACAO_MOVTO.Post_Update(:P184_cod_requisicao,',
'                                    :app_user,',
'                                    v_flg_retorno,',
'                                    v_msg_retorno);',
'',
'commit;',
'',
' if v_msg_retorno is not null then',
'    :p184_ok       := ''N'';',
'    :p184_flag     := v_flg_retorno;',
'    :p184_mensagem := v_msg_retorno;',
' else',
'    :p184_flag     := null;',
'    :p184_mensagem := null;',
'    :p184_ok       := ''S'';',
' end if;',
'',
'end;'))
,p_attribute_02=>'P184_COD_REQUISICAO'
,p_attribute_03=>'P184_FLAG,P184_MENSAGEM,P184_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507243356742782346)
,p_event_id=>wwv_flow_api.id(3507242863343782345)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REPROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507243792643782346)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1521
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(3507166327318782323)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509288291997131390)
,p_event_id=>wwv_flow_api.id(3507243792643782346)
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
'begin',
'',
'PKG_REQ_INDICACAO_MOVTO.Post_Update(:P184_cod_requisicao,',
'                                    :app_user,',
'                                    v_flg_retorno,',
'                                    v_msg_retorno);',
'',
'commit;',
'',
' if v_msg_retorno is not null then',
'    :p184_ok       := ''N'';',
'    :p184_flag     := v_flg_retorno;',
'    :p184_mensagem := v_msg_retorno;',
' else',
'    :p184_flag     := null;',
'    :p184_mensagem := null;',
'    :p184_ok       := ''S'';',
' end if;',
'',
'end;'))
,p_attribute_02=>'P184_COD_REQUISICAO'
,p_attribute_03=>'P184_FLAG,P184_MENSAGEM,P184_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507244255819782346)
,p_event_id=>wwv_flow_api.id(3507243792643782346)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507244636956782346)
,p_name=>'Habilita/Desabilita Campos'
,p_event_sequence=>1531
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>unistr('--* desabilitei pra ver o erro da grava\00E7\00E3o do cancelamento')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507245193929782346)
,p_event_id=>wwv_flow_api.id(3507244636956782346)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P184_COD_SIT_REQ" ).getValue() == ''2'' || ',
'    apex.item( "P184_COD_SIT_REQ" ).getValue() == ''3'' || ',
'    apex.item( "P184_COD_SIT_REQ" ).getValue() == ''4'')',
'{',
'  ',
'apex.item( "P184_COD_SIT_REQ" ).disable() ;',
'apex.item( "P184_COD_EMP_SOLICITADO" ).disable() ;',
'apex.item( "P184_COD_MAT_SOLICITADO" ).disable() ;',
'    ',
'apex.item( "P184_COD_FILIAL_PROP" ).disable() ;',
'apex.item( "P184_COD_CARGO_PROP" ).disable() ;',
'apex.item( "P184_COD_FUNCAO_PROP" ).disable() ;',
'apex.item( "P184_COD_LOCAL_TRAB_PROP" ).disable() ;',
'   ',
'$(''#P184_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'$(''#P184_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P184_OBSERVACAO" ).disable() ;',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507245666925782346)
,p_event_id=>wwv_flow_api.id(3507244636956782346)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P184_COD_SIT_REQ" ).getValue() == ''6'')',
'{',
'apex.item( "P184_COD_SIT_REQ" ).enable() ;',
'apex.item( "P184_COD_EMP_SOLICITADO" ).disable() ;',
'apex.item( "P184_COD_MAT_SOLICITADO" ).disable() ;',
'apex.item( "P184_COD_FILIAL_PROP" ).disable() ;',
'apex.item( "P184_COD_CARGO_PROP" ).disable() ;',
'apex.item( "P184_COD_FUNCAO_PROP" ).disable() ;',
'apex.item( "P184_COD_LOCAL_TRAB_PROP" ).disable() ;',
'    ',
'$(''#P184_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'$(''#P184_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P184_OBSERVACAO" ).disable() ;',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507246187329782346)
,p_event_id=>wwv_flow_api.id(3507244636956782346)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if(apex.item( "P184_ROWID" ).getValue().length > 0){',
'                 ',
'                    apex.item( "P184_COD_EMP_SOLICITADO" ).disable() ;',
'                    apex.item( "P184_COD_MAT_SOLICITADO" ).disable() ;',
'                    apex.item( "P184_COD_FILIAL_PROP" ).disable() ;',
'                    apex.item( "P184_COD_CARGO_PROP" ).disable() ;',
'                    apex.item( "P184_COD_FUNCAO_PROP" ).disable() ;',
'                    apex.item( "P184_COD_LOCAL_TRAB_PROP" ).disable() ;',
'//*                    apex.item( "P184_COD_SIT_REQ" ).disable() ;',
'                    $(''#P184_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    $(''#P184_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P184_OBSERVACAO" ).disable() ;',
'                 ',
'             }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3507856442597708628)
,p_name=>'Limpa campos'
,p_event_sequence=>1541
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_EMP_SOLICITADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P184_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3507856593235708629)
,p_event_id=>wwv_flow_api.id(3507856442597708628)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  :p184_cod_filial_atual     := null;',
'  :p184_cod_cargo_atual      := null;',
'  :p184_cod_funcao_atual     := null;',
'  :p184_cod_local_trab_atual := null;',
'  :p184_cod_filial_prop      := null;',
'  :p184_cod_cargo_prop       := null;',
'  :p184_cod_funcao_prop      := null;',
'  :p184_cod_local_trab_prop  := null;',
'  :p184_observacao           := null;',
'  :p184_filial_atual_dsp     := null;',
'  :p184_cargo_atual_dsp      := null;',
'  :p184_funcao_atual_dsp     := null;',
'  :p184_local_trab_atual_dsp := null;',
'end;'))
,p_attribute_03=>'P184_COD_FILIAL_ATUAL,P184_COD_CARGO_ATUAL,P184_COD_FUNCAO_ATUAL,P184_COD_LOCAL_TRAB_ATUAL,P184_FILIAL_ATUAL_DSP,P184_CARGO_ATUAL_DSP,P184_FUNCAO_ATUAL_DSP,P184_LOCAL_TRAB_ATUAL_DSP,P184_OBSERVACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3509288685264131394)
,p_name=>unistr('Oculta bot\00E3o SAVE')
,p_event_sequence=>1551
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509288815737131395)
,p_event_id=>wwv_flow_api.id(3509288685264131394)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(3507167903475782324)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(3509288836715131396)
,p_name=>unistr('Exibe bot\00E3o SAVE')
,p_event_sequence=>1561
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P184_COD_SIT_REQ'
,p_condition_element=>'P184_COD_SIT_REQ'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'3'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509288990041131397)
,p_event_id=>wwv_flow_api.id(3509288836715131396)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(3507167903475782324)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(3509289074441131398)
,p_event_id=>wwv_flow_api.id(3509288836715131396)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(3507167903475782324)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507204378333782336)
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
'  where cod_empresa = :p184_COD_EMP_SOLICITANTE',
'    and matricula   = :p184_COD_MAT_SOLICITANTE;',
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
'    :p184_solicitante := v_c1.colaborador;',
' end if;',
'',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507204823133782336)
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
'  where cod_sit_req = :p184_cod_sit_req;',
'  ',
'  v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p184_rowid is not null then',
unistr('   :p184_titulo := ''Requisi\00E7\00E3o de Indica\00E7\00E3o de Movimenta\00E7\00E3o: N\00BA ''||:p184_cod_requisicao||'' - ''||:p184_dt_requisicao||'' (''||v_c1.sit||'')'';'),
'else',
unistr('   :p184_titulo := ''Requisi\00E7\00E3o de Indica\00E7\00E3o de Movimenta\00E7\00E3o'';'),
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507205982746782336)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'/*',
'cursor c1 is',
'select i.filial,',
'       i.cod_ccusto,',
'       i.cargo',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p184_cod_emp_solicitado',
'   and i.matricula = :p184_cod_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'*/',
'begin',
'',
'/*',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p184_cod_filial is null or :p184_cod_ccusto is null then',
':p184_cod_filial := v_c1.filial;',
':p184_cod_ccusto := v_c1.cod_ccusto;',
':p184_cod_cargo  := v_c1.cargo;',
'end if;',
'*/',
'    BEGIN',
'  	SELECT seq_requisicao.NEXTVAL INTO v_seq FROM dual;',
'    END;',
'        ',
'    :p184_cod_requisicao := v_seq;',
'',
'    :p184_cod_sit_req := 1;',
'',
'  :p184_usuario         := :p_usuario;',
'  :p184_dt_atualizacao  := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  :p184_dt_requisicao   := SYSDATE; -- TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS''); -- SYSDATE;',
'',
'  :p184_cod_emp_solicitante := NVL(:P_EMPRESA_USER,:P184_COD_EMPRESA_SOLICITANTE_AUX);',
'  :p184_cod_mat_solicitante := NVL(:P_MATRICULA_USER,:P184_MAT_SOLICITANTE_AUX);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3507168279792782324)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507206383255782336)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  :p184_usuario := :p_usuario;',
'  :p184_dt_atualizacao := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3507167903475782324)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507203955312782336)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQ_INDICACAO_MOVIMENTACAO'
,p_attribute_02=>'REQ_INDICACAO_MOVIMENTACAO'
,p_attribute_03=>'P184_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507205609150782336)
,p_process_sequence=>70
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
' :p184_mensagem := null;',
'',
' Pkg_Req_indicacao_Movto.post_insert(:p184_cod_emp_solicitado, :p184_cod_requisicao, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p184_ok       := ''N'';',
'    :p184_flag     := v_flg_retorno;',
'    :p184_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    :p184_flag     := null;',
'    :p184_mensagem := null;',
'    :p184_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3507168279792782324)
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507857236807708636)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_teste number := 0;',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_INDICACAO_MOVTO.Post_Update(:P184_cod_requisicao,',
'                              :app_user,',
'                              v_flg_retorno,',
'                              v_msg_retorno);',
'',
'commit;',
'',
' if v_msg_retorno is not null then',
'    :p184_ok       := ''N'';',
'    :p184_flag     := v_flg_retorno;',
'    :p184_mensagem := v_msg_retorno;',
' else',
'    :p184_flag     := null;',
'    :p184_mensagem := null;',
'    :p184_ok       := ''S'';',
' end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(3507167903475782324)
,p_process_success_message=>unistr('Requisi\00E7\00E3o alterada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507203203853782336)
,p_process_sequence=>20
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
'',
'if :p184_OK is null then',
':p184_OK := ''S'';',
':p184_mensagem := null;',
':p184_flag := null;',
'end if;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507203575970782336)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'REQ_INDICACAO_MOVIMENTACAO'
,p_attribute_03=>'P184_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P184_COD_REQUISICAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(3507207138039782337)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.filial,',
'       i.cargo,',
'       i.funcao,',
'       i.cod_localizacao',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p184_cod_emp_solicitado',
'   and i.matricula = :p184_cod_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'/*',
'if :p184_cod_requisicao is null then',
':p184_cod_filial_atual := v_c1.filial;',
':p184_cod_cargo_atual  := v_c1.cargo;',
'end if;',
'*/',
':p184_filial_atual_dsp := :p184_cod_filial_atual||'' - ''||initcap(fnct_nome_filial(:p184_cod_emp_solicitado,:p184_cod_filial_atual));',
':p184_cargo_atual_dsp  := :p184_cod_cargo_atual||'' - ''||initcap(fnct_nome_cargo(:p184_cod_cargo_atual));',
':p184_funcao_atual_dsp := :p184_cod_funcao_atual||'' - ''||initcap(fnct_nome_funcao(:p184_cod_cargo_atual,:p184_cod_funcao_atual));',
':p184_local_trab_atual_dsp := :p184_cod_local_trab_atual||'' - ''||initcap(fnct_nome_local_trab(:p184_cod_local_trab_atual));',
':p184_cod_empresa_DISPLAY := v_c1.empresa;',
':p184_matricula_DISPLAY := v_c1.matricula;',
':P184_MENSAGEM := '' '';',
'',
'exception',
'when others then',
':p184_cod_empresa_DISPLAY := :p184_cod_emp_solicitado;',
':p184_matricula_DISPLAY := :p184_cod_mat_solicitado;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P184_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
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
