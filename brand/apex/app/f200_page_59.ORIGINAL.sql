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
--   Date and Time:   22:33 Monday September 28, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 59
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00059
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>59);
end;
/
prompt --application/pages/page_00059
begin
wwv_flow_api.create_page(
 p_id=>59
,p_user_interface_id=>wwv_flow_api.id(281503518922148346736)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Desligamento')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Desligamento')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.setThemeHooks({',
'    beforeShow: function( pMsgType, pElement$ ){',
'        if ( pMsgType === apex.message.TYPE.ERROR ) {',
'          ',
'            if (apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''2'' || ',
'                apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''3'' || ',
'                apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''4'')',
'            {',
'',
'            apex.item( "P59_COD_SIT_DESLIGAMENTO" ).disable() ;',
'            apex.item( "P59_COD_EMPRESA" ).disable() ;',
'            apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'            apex.item( "P59_COD_FILIAL" ).disable() ;',
'            apex.item( "P59_COD_CCUSTO" ).disable() ;',
'            apex.item( "P59_SIT_DESLIG" ).disable() ;',
'            $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'            $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'            apex.item( "P59_HAVERA_REP" ).disable() ;',
'            apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'            apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'            apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'            apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'            apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'            apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'            apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'            apex.item( "P59_OBS" ).disable() ;',
'            }',
'            ',
'',
'',
'            if (apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''5'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''FOLHA TOPAZ'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''RESCISAO'' && apex.item("P59_PERFIL_USUARIO_LO'
||'GADO").getValue() !== ''MASTER'')',
'            {',
'',
'            apex.item( "P59_COD_EMPRESA" ).disable() ;',
'            apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'            apex.item( "P59_COD_FILIAL" ).disable() ;',
'            apex.item( "P59_COD_CCUSTO" ).disable() ;',
'            apex.item( "P59_SIT_DESLIG" ).disable() ;',
'            $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'            $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'            apex.item( "P59_HAVERA_REP" ).disable() ;',
'            apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'            apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'            apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'            apex.item( "P59_DT_COMUNICACAO" ).disable();  ',
'',
'                if (apex.item( "P59_SIT_DESLIG" ).getValue() == ''93'' && ',
'                    apex.item( "P59_COD_EMPRESA_SOLICITANTE" ).getValue() == apex.item( "P_EMPRESA_USUARIO" ).getValue() &&',
'                    apex.item( "P59_COD_MAT_SOLICITANTE" ).getValue() == apex.item( "P_MATRICULA_USUARIO" ).getValue()){',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).enable() ;',
'                }else{',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ; ',
'                }',
'',
'            apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'            apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'            apex.item( "P59_OBS" ).disable() ;',
'            }',
'',
'            if  ((apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''1'' || apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''5'')',
'                 && ',
'                 (apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''FOLHA TOPAZ'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''RESCISAO'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''MASTER''))',
'            {',
'',
'            apex.item( "P59_COD_EMPRESA" ).disable() ;',
'            apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'            apex.item( "P59_COD_FILIAL" ).disable() ;',
'            apex.item( "P59_COD_CCUSTO" ).disable() ;',
'            apex.item( "P59_SIT_DESLIG" ).disable() ;',
'            $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'            $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'            apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'            apex.item( "P59_HAVERA_REP" ).disable() ;',
'            apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'            apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'            apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'            apex.item( "P59_DT_COMUNICACAO" ).enable() ;',
'            apex.item( "P59_DT_SIT_DESLIGAMENTO" ).enable() ;',
'            apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'            apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'            apex.item( "P59_OBS" ).enable() ;',
'            }',
'            ',
' ',
'             if ((apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''FOLHA TOPAZ'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''RESCISAO'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''MASTER'') && ',
'                 apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() != ''5'' && ',
'                 apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() != ''1'' && ',
'                 apex.item( "P59_ROWID" ).getValue().length > 0){',
'                 ',
'                    apex.item( "P59_COD_EMPRESA" ).disable() ;',
'                    apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'                    apex.item( "P59_COD_FILIAL" ).disable() ;',
'                    apex.item( "P59_COD_CCUSTO" ).disable() ;',
'                    apex.item( "P59_SIT_DESLIG" ).disable() ;',
'                    $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'                    $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'                    apex.item( "P59_HAVERA_REP" ).disable() ;',
'                    apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'                    apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'                    apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'                    apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'                    apex.item( "P59_OBS" ).enable() ;',
'                 ',
'             }else if(apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''FOLHA TOPAZ'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''RESCISAO'' && apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() !== ''MASTER'' && ',
'                 apex.item( "P59_ROWID" ).getValue().length > 0){',
'                 ',
'                    apex.item( "P59_COD_EMPRESA" ).disable() ;',
'                    apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'                    apex.item( "P59_COD_FILIAL" ).disable() ;',
'                    apex.item( "P59_COD_CCUSTO" ).disable() ;',
'                    apex.item( "P59_SIT_DESLIG" ).disable() ;',
'                    $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'                    $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'                    apex.item( "P59_HAVERA_REP" ).disable() ;',
'                    apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'                    apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'                    apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'                    apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'                    apex.item( "P59_OBS" ).disable() ;',
'                 ',
'             }',
'',
'        }',
'    }',
'});'))
,p_inline_css=>'img { height: 100px }'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'BRUNO.SOUSA'
,p_last_upd_yyyymmddhh24miss=>'20260916125451'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(258625272315063152834)
,p_plug_name=>'Alerta Anexo de Carta'
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--danger:t-Alert--removeHeading'
,p_plug_template=>wwv_flow_api.id(281503483357399346604)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_source=>unistr('<p><b>Na carta anexada</b>, dever\00E1 ter sido <b>redigida de pr\00F3prio punho</b>  e devidamente identificada com: <b>Nome Completo, Documento de Identifica\00E7\00E3o (CPF, N\00B0 RG, etc.), Data e Assinatura</b>.</p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281158388290890057288)
,p_plug_name=>unistr('Relat\00F3rios')
,p_region_name=>'RELATORIOS'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503491494631346639)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281226171138486371758)
,p_plug_name=>unistr('Carta de Demiss\00E3o')
,p_region_name=>'CARTA_DEMISSAO'
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503491494631346639)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(270295225063331866185)
,p_plug_name=>'Carta Anexada'
,p_parent_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--success'
,p_plug_template=>wwv_flow_api.id(281503483357399346604)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(270295225183315866186)
,p_plug_name=>'Anexe a Carta'
,p_parent_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_region_template_options=>'#DEFAULT#:t-Alert--colorBG:t-Alert--horizontal:t-Alert--defaultIcons:t-Alert--warning'
,p_plug_template=>wwv_flow_api.id(281503483357399346604)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362948615476680802)
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
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281362949058587680804)
,p_name=>'Aprovadores'
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
'  from aprova_desligamento a, usuario_oracle u',
' where a.cod_desligamento = :p59_cod_desligamento ',
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
'  from aprova_desligamento a, usuario_oracle u',
' where a.cod_desligamento = :p59_cod_desligamento ',
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
'ORDER BY 7 nulls first'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_desligamento',
' where cod_desligamento = :p59_cod_desligamento'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P59_COD_DESLIGAMENTO'
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
 p_id=>wwv_flow_api.id(281362949422229680804)
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
 p_id=>wwv_flow_api.id(281362949869362680805)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281362950255590680805)
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
 p_id=>wwv_flow_api.id(281362950610607680806)
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
 p_id=>wwv_flow_api.id(281362951016897680806)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(281362951482218680806)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(278901604693551941486)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269940533584631165743)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362952631840680808)
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
 p_id=>wwv_flow_api.id(281362954260580680809)
,p_plug_name=>'&P59_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362960228008680813)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P59_ROWID IS NOT NULL AND :P59_MAT_SOLICITADO IS NOT NULL THEN',
'return true;',
'ELSE',
'return false;',
'END IF;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362961001901680816)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(281362960228008680813)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362961860234680817)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(281362960228008680813)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281362963825668680819)
,p_plug_name=>unistr('Informa\00E7\00F5es para Desligamento')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503492925310346642)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281362954673134680810)
,p_button_sequence=>130
,p_button_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_button_name=>'p59_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P59 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P59_COD_EMPRESA_SOLICITANTE.,&P59_MAT_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940533632747165744)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281362949058587680804)
,p_button_name=>'p59_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P59_COD_DESLIGAMENTO.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_desligamento',
' where cod_desligamento = :p59_cod_desligamento',
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
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'pkg_deslig.Valida_Sequencia(:p59_cod_empresa, :p59_cod_desligamento, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281226171363394371760)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_button_name=>'FECHAR_CARTA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281362953012221680808)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(281362952631840680808)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:58:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(280612096641297543107)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(281362952631840680808)
,p_button_name=>'CANCEL_1'
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
 p_id=>wwv_flow_api.id(281362953483545680809)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281362952631840680808)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p59_rowid is not null then',
'',
'    if :p59_cod_sit_desligamento in (1,5,6) then',
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
 p_id=>wwv_flow_api.id(269940533793952165745)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281362949058587680804)
,p_button_name=>'p59_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P59_COD_DESLIGAMENTO.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_desligamento',
' where cod_desligamento = :p59_cod_desligamento',
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
'  pkg_deslig.Valida_Sequencia(:p59_cod_empresa, :p59_cod_desligamento, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
 p_id=>wwv_flow_api.id(281362953841738680809)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281362952631840680808)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513716908346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P59_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281158389451397057300)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_button_name=>'RELATORIOS_OLD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Imprima a Carta'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'',
'-- Bruno Sousa 05-06-2025 ',
unistr('-- Novo bot\00E3o de impress\00E3o criado'),
unistr('-- Ou esse fica exibido ou o novo de acordo com a condi\00E7\00E3o abaixo'),
'and NOT (:p59_sit_deslig = ''9A'' AND :p59_AVISO_PREVIO IN (''I'', ''T''))'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-print'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(86123361751513448236)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_button_name=>'RELATORIOS_NEW'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Imprima a Carta'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'-- Bruno Sousa 05-06-2025 ',
unistr('-- Novo bot\00E3o de impress\00E3o criado'),
unistr('-- Ou esse fica exibido ou o old de acordo com a condi\00E7\00E3o abaixo'),
'and (:p59_sit_deslig = ''9A'' AND :p59_AVISO_PREVIO IN (''I'', ''T''))'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-print'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281362960605175680815)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281362960228008680813)
,p_button_name=>'p59_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503513600837346683)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP:P13_EMP,P13_MAT:&P59_COD_EMPRESA.,&P59_MAT_SOLICITADO.'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281226171035471371757)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_button_name=>'CARTA_DEMISSAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Anexe a Carta Assinada'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P59_UPLOAD_CARTA_DESLIG = ''S'' then',
'--    if (:p59_sit_deslig = ''91'' or :p59_sit_deslig is null) then',
'    return true;',
'/*    elsif (:p59_sit_deslig <> ''91'' and ',
'         :p59_rowid is not null and',
'         :P59_COD_SIT_DESLIGAMENTO in (2,5)) then',
'    return true;',
'    else',
'    return false;',
'    end if;*/',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-paperclip'
,p_button_comment=>'ch42358'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281362964240596680819)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_button_name=>'p59_btn_req_pessoal'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o de Pessoal')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.:REQ_DESLIGAMENTO:&DEBUG.:RP,52:P52_COD_EMPRESA,P52_MAT_SUBS,P52_COD_MOT_REQ,P52_COD_VAGA,P52_COD_FILIAL,P52_MOT_SUBS,P52_VAGA_DISP_POR_REQ_DESLIG,P52_MAT_SUBS_DESLIG,P52_TIPO_SALARIO,P52_SALARIO:&P59_COD_EMPRESA.,&P59_MAT_SOLICITADO.,1,&P59_VAGA.,&P59_COD_FILIAL.,&P59_COD_MOT_DESLIG.,S,&P59_MAT_SOLICITADO.,M,8468.58'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select botoes_req_pessoal',
'  from configuracoes;',
'  ',
'v_c1 c1%rowtype;',
'',
'',
'cursor c2 is',
'  SELECT MAX(R.COD_REQ) COD_REQ',
'  FROM   REQUISICAO R, INFORMACOES_FUNCIONAIS_CAD IFF, DESLIGAMENTO D',
'  WHERE  R.COD_SIT_REQ                    NOT IN (3,4)',
'  AND    R.MAT_SUBS                       = D.MAT_SOLICITADO',
'  AND    R.COD_VAGA                       = IFF.CAD_VAGA',
'  AND    R.COD_FILIAL                     = IFF.FILIAL',
'  AND    R.COD_EMPRESA                    = IFF.COD_EMPRESA',
'  AND    IFF.MATRICULA                    = D.MAT_SOLICITADO',
'  AND    IFF.COD_EMPRESA                  = D.COD_EMPRESA',
'  AND    D.COD_DESLIGAMENTO               = :P59_COD_DESLIGAMENTO;',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.botoes_req_pessoal = ''S'' and :p59_rowid is not null and :P59_COD_SIT_DESLIGAMENTO in (1,2,5) then',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'  if v_c2.cod_req is not null then',
'    return false;',
'  else',
'    return true;',
'  end if;',
'else',
'return false;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-male'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(97820064808837380682)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_button_name=>'p59_btn_req_pessoal_consulta'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Visualizar Requisi\00E7\00E3o de Pessoal')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.:REQ_DESLIGAMENTO:&DEBUG.:RP,52:P52_COD_EMPRESA,P52_COD_REQ:&P59_COD_EMPRESA.,&P59_COD_RP.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-male'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(67667261098604718137)
,p_button_sequence=>5
,p_button_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_button_name=>'GERAR_REL_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Gerar Relat\00F3rio Caterpillar')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'   and realocacao = ''N''',
'union',
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and (:p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)))) or (mot_esocial1 is null))',
'   and realocacao = ''S'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-file-pdf-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(281158386853481057274)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_button_name=>'GERAR_REL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503513890628346686)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Gerar Relat\00F3rio')
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'   and realocacao = ''N''',
'union',
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and (:p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)))) or (mot_esocial1 is null))',
'   and realocacao = ''S'''))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-file-pdf-o'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281362991214626680844)
,p_branch_name=>'Create: Go To Page 58'
,p_branch_action=>'f?p=&APP_ID.:58:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(281362953841738680809)
,p_branch_sequence=>1
,p_branch_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_branch_condition=>'P59_HAVERA_REP'
,p_branch_condition_text=>'N'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281227300124316129618)
,p_branch_name=>'Create: Go To Page 52'
,p_branch_action=>'f?p=&APP_ID.:52:&SESSION.:REQ_DESLIG:&DEBUG.:59:P52_COD_EMPRESA,P52_MAT_SUBS,P52_COD_MOT_REQ,P52_COD_VAGA,P52_COD_FILIAL,P52_MOT_SUBS:&P59_COD_EMPRESA.,&P59_MAT_SOLICITADO.,1,&P59_VAGA.,&P59_COD_FILIAL.,&P59_COD_MOT_DESLIG.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(281362953841738680809)
,p_branch_sequence=>11
,p_branch_condition_type=>'FUNCTION_BODY'
,p_branch_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select botoes_req_pessoal',
'  from configuracoes;',
'  ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.botoes_req_pessoal = ''S'' and :p59_rowid is not null and :P59_COD_SIT_DESLIGAMENTO in (1,2,5) and :P59_HAVERA_REP = ''S'' then',
'return true;',
'else',
'return false;',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(280868940412228441055)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(281362991690505680844)
,p_branch_name=>'Save: Go To Page 58'
,p_branch_action=>'f?p=&APP_ID.:58:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(281362953483545680809)
,p_branch_sequence=>41
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(149864136147940850249)
,p_branch_name=>'Go To Page Page Branch'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>31
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'APROVAR,REPROVAR'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(29835249053911873607)
,p_name=>'P59_EXISTE_ANEXO_CONCLUIDO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31150131107077517351)
,p_name=>'P59_EXISTE_ANEXO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33815060348660803894)
,p_name=>'P59_MSG_CARTA_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_source=>'Para visualizar o arquivo, clique em Fazer Download.'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when=>'P59_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33815060451172803895)
,p_name=>'P59_DESC_SITUACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select Initcap(desc_sit_REQ) descricao',
'   from SIT_REQ',
'   where COD_SIT_REQ = :P59_COD_SIT_DESLIGAMENTO;'))
,p_item_default_type=>'SQL_QUERY_COLON'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(48047444224304622303)
,p_name=>'P59_IND_DEF_FIS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
,p_prompt=>'PCD'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  X.PCD',
'FROM   (SELECT NVL(PCD,''N'') PCD',
'        FROM   PERMISSAO_PERFIL_PESS',
'        WHERE  ID_PERFIL = :P_PERFIL',
'        UNION',
'        SELECT NVL(PCD,''N'') PCD',
'        FROM   PERMISSAO_PERFIL_GESTOR_PESS',
'        WHERE  ID_PERFIL = :P_PERFIL',
'        UNION',
'        SELECT NVL(PCD,''N'') PCD',
'        FROM   permissao_pess',
'        WHERE  ID_USUARIO =:P_USUARIO)X',
'WHERE   ROWNUM = 1',
'AND     X.PCD = ''S'''))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(68722417572117744633)
,p_name=>'P59_REPORT_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>unistr('Relat\00F3rio Caterpillar')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'   and realocacao = ''N''',
'   and cod IN (''RP21589'',''RP21587'',''RP21588'')',
'union',
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and (:p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)))) or (mot_esocial1 is null))',
'   and realocacao = ''S''',
'   and cod IN (''RP21589'',''RP21587'',''RP21588'')',
'order by 2'))
,p_lov_cascade_parent_items=>'P59_SIT_DESLIG,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_IND_REALOCACAO'
,p_ajax_optimize_refresh=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P59_UPLOAD_CARTA_DESLIG = ''S'' then',
'    if (:p59_sit_deslig = ''91'' or :p59_sit_deslig is null) then',
'    return true;',
'    elsif (:p59_sit_deslig <> ''91'' and ',
'         :p59_rowid is not null and',
'         --:P59_COD_SIT_DESLIGAMENTO ',
'         :P59_COD_SIT_AUX   ',
'           in (2,5)) then',
'    return true;',
'    else',
'    return false;',
'    end if;',
'else',
'return false;',
'end if;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(68722417662581744634)
,p_name=>'P59_TEXTO_CARTA_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Obs.: '
,p_source=>unistr('Esses relat\00F3rios s\00F3 ser\00E3o gerados para colaboradores da Unidade Caterpillar')
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(85263024143927947224)
,p_name=>'P59_COD_SIT_AUX'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97820065543765380689)
,p_name=>'P59_TIPO_SALARIO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97820065608006380690)
,p_name=>'P59_VALOR_VERBA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107396372065239991612)
,p_name=>'P59_MAT_SOLICITANTE_AUX'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107396372210100991613)
,p_name=>'P59_COD_EMPRESA_SOLICITANTE_AUX'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(108275417146217333696)
,p_name=>'P59_INDPDV'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>'PDV?'
,p_source=>'INDPDV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
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
 p_id=>wwv_flow_api.id(108275417204964333697)
,p_name=>'P59_CONSIDERA_PDV'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269515782188022884980)
,p_name=>'P59_PARAMETROS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269950572692682704240)
,p_name=>'P59_PERFIL_USUARIO_LOGADO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_source=>'P_PERFIL'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270295225477443866189)
,p_name=>'P59_CARTA_ANEXADA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270523734191739013175)
,p_name=>'P59_IND_CONTR_PRZ_DETERM'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_CONTRATO_PRZ_DETERMINADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270523734318407013176)
,p_name=>'P59_DATA_CONTR_PRZ_DETERM'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'DATA_CONTRATO_PRZ_DETERMINADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270523734398419013177)
,p_name=>'P59_PRORROG_CONTR_PRZ_DETERM'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'PRORROG_CONTRATO_PRZ_DETERM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271254822556375072016)
,p_name=>'P59_VALIDA_PONTO'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(272404428254101419239)
,p_name=>'P59_DT_CONTRATO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
,p_prompt=>'Data de Contrato'
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
 p_id=>wwv_flow_api.id(272404428280656419240)
,p_name=>'P59_DT_PRORROG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
,p_prompt=>unistr('Data de Prorroga\00E7\00E3o')
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
 p_id=>wwv_flow_api.id(272416310390460393391)
,p_name=>'P59_IND_CONTRATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
,p_prompt=>'Tipo de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
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
 p_id=>wwv_flow_api.id(272416310464907393392)
,p_name=>'P59_IND_CONTRATO_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_prompt=>'Tipo de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
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
 p_id=>wwv_flow_api.id(272416310580850393393)
,p_name=>'P59_DT_CONTRATO_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_prompt=>'Data de Contrato'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
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
 p_id=>wwv_flow_api.id(272416310748150393394)
,p_name=>'P59_DT_PRORROG_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_prompt=>unistr('Data de Prorroga\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
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
 p_id=>wwv_flow_api.id(273425655273294702640)
,p_name=>'P59_TIPO_CONTRATO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(273434343353286200427)
,p_name=>'P59_CHECK_DOCUMENTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Documenta\00E7\00E3o Correta?')
,p_source=>'CHECK_DOCUMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N,Aguardando Verifica\00E7\00E3o;A')
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p59_cod_sit_desligamento in (2,3,5) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_read_only_when=>'P_PERFIL'
,p_read_only_when2=>'FOLHA'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(273434343744067200431)
,p_name=>'P59_VINCULO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(276581011885953680162)
,p_name=>'P59_TEXTO_CARTA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Obs.: '
,p_source=>unistr('Para poder imprimir a carta de desligamento, esta requisi\00E7\00E3o deve estar completamente Aprovada.')
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(280612096172718543102)
,p_name=>'P59_DT_ARQUIVO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ARQUIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158386731281057273)
,p_name=>'P59_REPORT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>unistr('Relat\00F3rio')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and :p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)) or (mot_esocial1 is null)))',
'   and realocacao = ''N''',
'   and cod NOT IN (''RP21589'',''RP21587'',''RP21588'')',
'union',
'select descricao, cod',
'  from reports_desligamento',
' where ((:p59_AVISO_PREVIO in (aviso_previo1,aviso_previo2,aviso_previo3)) or (aviso_previo1 is null))',
'   and ((:p59_sit_deslig   in (sit_deslig1,sit_deslig2,sit_deslig3)) or (sit_deslig1 is null))',
'   and (:p59_COD_MOT_DESLIG in (select cod',
'                                 from motivo_alteracoes',
'                                where class_motivo = ''2''',
'                                  and ((cod_motivo_esocial in (mot_esocial1, mot_esocial2, mot_esocial3)))) or (mot_esocial1 is null))',
'   and realocacao = ''S''',
'   and cod NOT IN (''RP21589'',''RP21587'',''RP21588'')',
'order by 2'))
,p_lov_cascade_parent_items=>'P59_SIT_DESLIG,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_IND_REALOCACAO'
,p_ajax_optimize_refresh=>'N'
,p_grid_label_column_span=>2
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P59_UPLOAD_CARTA_DESLIG = ''S'' then',
'    if (:p59_sit_deslig = ''91'' or :p59_sit_deslig is null) then',
'    return true;',
'    elsif (:p59_sit_deslig <> ''91'' and ',
'         :p59_rowid is not null and',
'         --:P59_COD_SIT_DESLIGAMENTO ',
'         :P59_COD_SIT_AUX   ',
'           in (2,5)) then',
'    return true;',
'    else',
'    return false;',
'    end if;',
'else',
'return false;',
'end if;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387204068057277)
,p_name=>'P59_ENDERECO_REL'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387432520057280)
,p_name=>'P59_DT_EXAME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>'Data Exame'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_grid_label_column_span=>1
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387596857057281)
,p_name=>'P59_DT_RH'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>'Data RH'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387629420057282)
,p_name=>'P59_HORARIO_EXAME'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>unistr('Hor\00E1rio Exame')
,p_placeholder=>'Exemplo: 09:00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>5
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387762874057283)
,p_name=>'P59_HORARIO_RH'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>unistr('Hor\00E1rio RH')
,p_placeholder=>'Exemplo: 09:00'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>5
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158387906747057284)
,p_name=>'P59_DT_PAGAMENTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>'Data de Pagamento'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158511827981820180)
,p_name=>'P59_LOCAL_EXAME'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>'Local Exame'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NM_lOCAL||'': ''||END_LOCAL||'', ''||BAIRRO||'', ''||CIDADE||''/''||UF||'', Cep: ''||lpad(CEP_PREFIXO,5,0)||''-''||lpad(CEP_SUFIXO,3,0) ENDERECO, COD_LOCAL',
'FROM ENDERECO',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158511917487820181)
,p_name=>'P59_LOCAL_RH'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281158388290890057288)
,p_prompt=>'Local RH'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NM_lOCAL||'': ''||END_LOCAL||'', ''||BAIRRO||'', ''||CIDADE||''/''||UF||'', Cep: ''||lpad(CEP_PREFIXO,5,0)||''-''||lpad(CEP_SUFIXO,3,0) ENDERECO, COD_LOCAL',
'FROM ENDERECO',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281158515691022820218)
,p_name=>'P59_TIPO_CARTEIRA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281212494044969140784)
,p_name=>'P59_UPLOAD_CARTA_DESLIG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281226170212427371748)
,p_name=>'P59_RECOMENDA_REALOCACAO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'RECOMENDA_REALOCACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281226170501001371751)
,p_name=>'P59_RESTRICAO_REALOCACAO'
,p_is_required=>true
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('H\00E1 algo que desabone para futuras oportunidades na empresa?')
,p_source=>'RESTRICAO_REALOCACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281226171313558371759)
,p_name=>'P59_ARQUIVO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Upload de Arquivo'
,p_source=>'ARQUIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>'** Para visualizar o arquivo, clique em Fazer Download.'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TIPO'
,p_attribute_03=>'NOME_ARQUIVO'
,p_attribute_04=>'CHARSET'
,p_attribute_05=>'DT_ARQUIVO'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281226171927088371765)
,p_name=>'P59_MSG_ANEXO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281226171138486371758)
,p_prompt=>'&nbsp'
,p_source=>unistr('Para anexar um documento \00E9 necess\00E1rio a Requisi\00E7\00E3o estar com situa\00E7\00E3o APROVADA. Favor verificar.')
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281227300137438129619)
,p_name=>'P59_TP_AV_PREVIO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de Aviso Pr\00E9vio')
,p_source=>'TP_AV_PREVIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select ''1 - Aviso pr\00E9vio trabalhado dado pelo empregador ao empregado, que optou pela redu\00E7\00E3o de duas horas di\00E1rias [caput do art. 488 da CLT]'' descricao,1 cod from dual where :P59_SIT_DESLIG = ''93'' AND :P59_AVISO_PREVIO = ''T'' union'),
unistr('select ''2 - Aviso pr\00E9vio trabalhado dado pelo empregador ao empregado, que optou pela redu\00E7\00E3o de dias corridos [par\00E1grafo \00FAnico do art. 488 da CLT]'' descricao,2 cod from dual where :P59_SIT_DESLIG = ''93'' AND :P59_AVISO_PREVIO = ''T'' union'),
unistr('select ''4 - Aviso pr\00E9vio dado pelo empregado (pedido de demiss\00E3o), n\00E3o dispensado de  seu  cumprimento,  sob  pena  de  desconto,  pelo  empregador,  dos  sal\00E1rios correspondentes ao prazo respectivo (\00A72\00BA do art. 487 da CLT)'' descricao,4 cod from dua')
||'l where :P59_SIT_DESLIG in (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''T'' union',
unistr('select ''5 - Aviso pr\00E9vio trabalhado dado pelo empregador rural ao empregado, com redu\00E7\00E3o de um dia por semana (art. 15 da Lei n\00BA 5889/73)'' descricao, 5 cod from dual where not((:P59_SIT_DESLIG = ''93'' AND :P59_AVISO_PREVIO = ''T'') or (:P59_SIT_DESLIG i')
||'n (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''T'')) and :p59_tipo_carteira = ''R''',
'order by 2'))
,p_lov_cascade_parent_items=>'P59_SIT_DESLIG,P59_AVISO_PREVIO,P59_TIPO_CARTEIRA'
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
 p_id=>wwv_flow_api.id(281227300256031129620)
,p_name=>'P59_INDCUMPRPARC'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_item_default=>'0'
,p_prompt=>'Indic. Cumprimento'
,p_source=>'INDCUMPRPARC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''0 - Cumprimento total'' descricao, 0 cod from dual where :P59_AVISO_PREVIO <> ''I'' union',
unistr('select ''1 - Cumprimento parcial em raz\00E3o de obten\00E7\00E3o de novo emprego pelo empregado'' descricao, 1 cod from dual where :P59_AVISO_PREVIO <> ''I'' union'),
'select ''2 - Cumprimento parcial por iniciativa do empregador'' descricao, 2 cod from dual where :P59_AVISO_PREVIO <> ''I'' union',
unistr('select ''3 - Outras hip\00F3teses de cumprimento parcial do aviso pr\00E9vio'' descricao, 3 cod from dual where :P59_AVISO_PREVIO <> ''I'' union'),
unistr('select ''4 - Aviso pr\00E9vio indenizado ou n\00E3o exig\00EDvel'' descricao, 4 cod from dual where :P59_AVISO_PREVIO = ''I'''),
'order by 2'))
,p_lov_cascade_parent_items=>'P59_AVISO_PREVIO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281227301516916129632)
,p_name=>'P59_DES_DT_SIT_DESLIG'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281256062412665137268)
,p_name=>'P59_IND_REALOCACAO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Indicar para Realoca\00E7\00E3o?')
,p_source=>'IND_REALOCACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362954996901680810)
,p_name=>'P59_TITULO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362955481491680810)
,p_name=>'P59_ROWID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362955800730680811)
,p_name=>'P59_FLAG'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362956194096680811)
,p_name=>'P59_MENSAGEM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362956649320680811)
,p_name=>'P59_OK'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362957053168680811)
,p_name=>'P59_COD_DESLIGAMENTO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_DESLIGAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P59_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362957461759680812)
,p_name=>'P59_COD_SIT_DESLIGAMENTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_DESLIGAMENTO'
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
 p_id=>wwv_flow_api.id(281362957849513680812)
,p_name=>'P59_DT_DESLIGAMENTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Abertura'
,p_source=>'DT_DESLIGAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_read_only_when=>'P59_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362958249643680812)
,p_name=>'P59_SOLICITANTE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
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
 p_id=>wwv_flow_api.id(281362958639472680812)
,p_name=>'P59_USUARIO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362959062889680813)
,p_name=>'P59_DT_ATUALIZACAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362959453793680813)
,p_name=>'P59_COD_EMPRESA_SOLICITANTE'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362959889500680813)
,p_name=>'P59_MAT_SOLICITANTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362961479951680816)
,p_name=>'P59_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281362961001901680816)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :P59_COD_EMPRESA',
'   and matricula = :P59_MAT_SOLICITADO'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362962281308680817)
,p_name=>'P59_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
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
 p_id=>wwv_flow_api.id(281362962648172680818)
,p_name=>'P59_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
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
 p_id=>wwv_flow_api.id(281362963059518680818)
,p_name=>'P59_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
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
 p_id=>wwv_flow_api.id(281362963424147680818)
,p_name=>'P59_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281362961860234680817)
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
 p_id=>wwv_flow_api.id(281362964656715680820)
,p_name=>'P59_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod',
'  from empresas',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :p59_cod_desligamento is null) or ',
'        (:p59_cod_desligamento is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_COD_DESLIGAMENTO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362965086072680821)
,p_name=>'P59_COD_FILIAL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||initcap(fnct_nome_filial(cod_empresa, cod_filial, ''S'')) descricao, cod_filial',
'  from filiais',
' where cod_empresa = :p59_cod_empresa',
'   AND encer_ativ = ''N'' ',
'   AND SIT NOT IN (''E'',''I'')',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362965474368680822)
,p_name=>'P59_COD_CCUSTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_source=>'COD_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'   from centro_de_custo c, filial_ccusto f',
'  where c.cod_empresa = f.cod_empresa',
'    and c.cod = f.cod_ccusto',
'    and f.cod_empresa = :p59_cod_empresa ',
'    and f.cod_filial = nvl(:p59_cod_filial,f.cod_filial)',
'    and trunc(sysdate) between c.dt_inic_vige and nvl(c.dt_fim_vige,sysdate)',
'    and F_ACESSO_CC(C.COD_EMPRESA, C.COD) = ''S''',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_COD_EMPRESA,P59_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_api.id(281362965850675680822)
,p_name=>'P59_MAT_SOLICITADO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_SOLICITADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, p.matricula',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p59_cod_empresa',
'  and f.filial = nvl(:p59_cod_filial,f.filial)',
'  and f.cod_ccusto = nvl(:p59_cod_ccusto,f.cod_ccusto)',
'  and f.situacao < ''90''',
'  --and f.situacao <> ''09''',
'  and not exists (',
'      select des.cod_desligamento requisicao',
'        from desligamento des',
'       where des.mat_solicitado = f.matricula',
'         and des.cod_empresa    = f.cod_empresa',
'         and des.cod_sit_desligamento in (1, 5, 6)',
'                    )',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_COD_EMPRESA,P59_COD_FILIAL,P59_COD_CCUSTO'
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
 p_id=>wwv_flow_api.id(281362966212162680823)
,p_name=>'P59_VAGA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362966631389680823)
,p_name=>'P59_COD_CARGO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362967051691680824)
,p_name=>'P59_SIT_DESLIG'
,p_is_required=>true
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_DESLIG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from sit_func',
'where requisicao_desligamento = ''S'' and',
'      nvl(:p59_vinculo,''C'') != ''E'' ',
'union',
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from sit_func',
'where requisicao_desligamento = ''S'' and',
'      nvl(:p59_vinculo,''C'') = ''E'' and',
'      cod = ''99''',
'/*',
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from sit_func',
' where cod > ''90'' ',
'   AND nvl(:p59_vinculo,''C'') <> ''E''',
'   and cod not in (''98'',''9A'',''EE'',''9B'')',
'union',
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from sit_func',
' where nvl(:p59_vinculo,''C'') = ''E'' ',
'   and cod = ''99''',
'   and cod not in (''98'',''9A'',''EE'',''9B'')*/',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_VINCULO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
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
 p_id=>wwv_flow_api.id(281362967464796680824)
,p_name=>'P59_COD_MOT_DESLIG'
,p_is_required=>true
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo'
,p_source=>'COD_MOT_DESLIG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descricao)||'' - (''||cod||'')'' descricao, cod',
'  from motivo_alteracoes',
' where class_motivo = ''2''',
'   and ((cod_motivo_esocial = 1 and :p59_sit_deslig = ''92'') or',
'        (cod_motivo_esocial = 2 and :p59_sit_deslig = ''93'' and :p59_tipo_contrato = ''I'') or',
'        (cod_motivo_esocial = 3 and :p59_sit_deslig = ''93'' and :p59_tipo_contrato = ''D'') or',
'        (cod_motivo_esocial = 4 and :p59_sit_deslig = ''91'' and :p59_tipo_contrato = ''D'') or',
'        (cod_motivo_esocial = 33 and :p59_sit_deslig = ''9A'' and :p59_tipo_contrato = ''I'') or',
'        (cod_motivo_esocial = 6 and :p59_sit_deslig in (''96'',''99'')) or',
'        (cod_motivo_esocial = 7 and :p59_sit_deslig = ''91'' and :p59_tipo_contrato = ''I'') or',
'        (cod_motivo_esocial = 10 and :p59_sit_deslig = ''95'') or',
'        (cod_motivo_esocial = 18 and :p59_sit_deslig = ''97'') or',
'        (cod_motivo_esocial = 20 and :p59_sit_deslig = ''94''))',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P59_SIT_DESLIG,P59_TIPO_CONTRATO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
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
 p_id=>wwv_flow_api.id(281362967836119680824)
,p_name=>'P59_DT_SIT_DESLIGAMENTO'
,p_is_required=>true
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Demiss\00E3o (\00DAltimo dia Trabalhado)')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_SIT_DESLIGAMENTO'
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
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362968277835680825)
,p_name=>'P59_DT_COMUNICACAO'
,p_is_required=>true
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Comunica\00E7\00E3o (Aviso)')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_COMUNICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362968680896680825)
,p_name=>'P59_AVISO_PREVIO'
,p_is_required=>true
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Aviso Pr\00E9vio')
,p_source=>'AVISO_PREVIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''Isento'' descricao, ''N'' codigo  ',
'  FROM dual',
' WHERE (',
'         -- 91 e contrato D, com isencao S/N',
'         (:P59_SIT_DESLIG = ''91''',
'          AND :P59_TIPO_CONTRATO = ''D''',
'          AND EXISTS (',
'                 SELECT 1',
'                   FROM sit_func s',
'                  WHERE s.cod = :P59_SIT_DESLIG',
'                    AND s.ind_isencao_pedido IN (''S'',''N'')',
'          )',
'         )',
'',
unistr('         -- 91 e contrato I, com isencao S -> tamb\00E9m mostra Isento'),
'         OR (:P59_SIT_DESLIG = ''91''',
'             AND :P59_TIPO_CONTRATO = ''I''',
'             AND EXISTS (',
'                    SELECT 1',
'                      FROM sit_func s',
'                     WHERE s.cod = :P59_SIT_DESLIG',
'                       AND s.ind_isencao_pedido = ''S''',
'             )',
'         )',
'',
'         -- 93 e contrato D',
'         OR (:P59_SIT_DESLIG = ''93'' AND :P59_TIPO_CONTRATO = ''D'')',
'',
unistr('         -- demais situa\00E7\00F5es'),
'         OR (:P59_SIT_DESLIG IN (''92'',''95'',''96'',''97'',''99''))',
'       )',
'',
'',
'UNION',
'',
'',
'SELECT ''Indenizado'' descricao, ''I'' codigo',
'  FROM dual',
' WHERE ((:P59_SIT_DESLIG IN (''9A'',''94''))',
'        OR (:P59_SIT_DESLIG = ''93'' AND :P59_TIPO_CONTRATO = ''I''))',
'',
'',
'UNION',
'',
'',
'SELECT ''Trabalhado'' descricao, ''T'' codigo',
'  FROM dual',
' WHERE (',
'        (:P59_SIT_DESLIG = ''94'')',
'        OR (:P59_SIT_DESLIG = ''93'' AND :P59_TIPO_CONTRATO = ''I'')',
'        ',
unistr('        -- 91 e contrato I e isencao S -> inclui tamb\00E9m "Trabalhado"'),
'        OR (:P59_SIT_DESLIG = ''91''',
'            AND :P59_TIPO_CONTRATO = ''I''',
'            AND EXISTS (',
'                   SELECT 1',
'                     FROM sit_func s',
'                    WHERE s.cod = :P59_SIT_DESLIG',
'                      AND s.ind_isencao_pedido = ''S''',
'            )',
'        )',
'',
unistr('        -- cobre tamb\00E9m caso 91 e contrato I e isencao N'),
'        OR (:P59_SIT_DESLIG = ''91''',
'            AND :P59_TIPO_CONTRATO = ''I''',
'            AND EXISTS (',
'                   SELECT 1',
'                     FROM sit_func s',
'                    WHERE s.cod = :P59_SIT_DESLIG',
'                      AND s.ind_isencao_pedido = ''N''',
'            )',
'        )',
'',
'        OR (:P59_SIT_DESLIG = ''9A'' AND :P59_TIPO_CONTRATO = ''I'')',
' )',
'',
'',
'UNION',
'',
'',
'SELECT ''Descontado'' descricao, ''D'' codigo',
'  FROM dual',
' WHERE (',
'        (:P59_SIT_DESLIG = ''94'')',
'        OR (:P59_SIT_DESLIG = ''9A'' AND :P59_TIPO_CONTRATO = ''I'')',
'        ',
unistr('        -- 91 e contrato I e isencao S -> tamb\00E9m mostra Descontado'),
'        OR (:P59_SIT_DESLIG = ''91''',
'            AND :P59_TIPO_CONTRATO = ''I''',
'            AND EXISTS (',
'                   SELECT 1',
'                     FROM sit_func s',
'                    WHERE s.cod = :P59_SIT_DESLIG',
'                      AND s.ind_isencao_pedido = ''S''',
'            )',
'        )',
'',
unistr('        -- cobre tamb\00E9m caso 91 e contrato I e isencao N'),
'        OR (:P59_SIT_DESLIG = ''91''',
'            AND :P59_TIPO_CONTRATO = ''I''',
'            AND EXISTS (',
'                   SELECT 1',
'                     FROM sit_func s',
'                    WHERE s.cod = :P59_SIT_DESLIG',
'                      AND s.ind_isencao_pedido = ''N''',
'            )',
'        )',
' );',
''))
,p_lov_cascade_parent_items=>'P59_SIT_DESLIG,P59_TIPO_CONTRATO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513458569346680)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Isento'' descricao, ''N'' codigo ',
'  from dual',
' where (',
'         -- 91 e contrato D, com isencao S/N',
'         (:P59_SIT_DESLIG = ''91''',
'          and :P59_TIPO_CONTRATO = ''D''',
'          and exists (',
'                 select 1',
'                   from sit_func s',
'                  where s.cod = :P59_SIT_DESLIG',
'                    and s.ind_isencao_pedido in (''S'',''N'')',
'          )',
'         )',
'',
unistr('         -- 91 e contrato I, com isencao S  \00BF tamb\00E9m deve mostrar \00BFIsento\00BF'),
'         or (:P59_SIT_DESLIG = ''91''',
'             and :P59_TIPO_CONTRATO = ''I''',
'             and exists (',
'                    select 1',
'                      from sit_func s',
'                     where s.cod = :P59_SIT_DESLIG',
'                       and s.ind_isencao_pedido = ''S''',
'             )',
'         )',
'',
'         -- 93 e contrato D',
'         or (:P59_SIT_DESLIG = ''93'' and :P59_TIPO_CONTRATO = ''D'')',
'',
unistr('         -- demais situa\00E7\00F5es sempre mostram'),
'         or (:P59_SIT_DESLIG in (''9A'',''92'',''95'',''96'',''97'',''99''))',
'       )',
'',
'union',
'',
'select ''Indenizado'' descricao, ''I'' codigo',
'  from dual',
' where ((:P59_SIT_DESLIG in (''9A'',''94''))',
'        or (:P59_SIT_DESLIG = ''93'' and :P59_TIPO_CONTRATO = ''I''))',
'',
'union',
'',
'select ''Trabalhado'' descricao, ''T'' codigo',
'  from dual',
' where ((:P59_SIT_DESLIG = ''94'')',
'        or (:P59_SIT_DESLIG = ''93'' and :P59_TIPO_CONTRATO = ''I'')',
'        or (:P59_SIT_DESLIG = ''91'' and :P59_TIPO_CONTRATO = ''I''',
'            and exists (',
'                   select 1',
'                     from sit_func s',
'                    where s.cod = :P59_SIT_DESLIG',
'                      and s.ind_isencao_pedido in (''N'',''S'')  -- <== agora cobre N e S',
'            ))',
'        or (:P59_SIT_DESLIG = ''9A'' and :P59_TIPO_CONTRATO = ''I''))',
'',
'union',
'',
'',
'select ''Descontado'' descricao, ''D'' codigo',
'  from dual',
' where ((:P59_SIT_DESLIG = ''94'')',
'        or (:P59_SIT_DESLIG = ''9A'' and :P59_TIPO_CONTRATO = ''I'')',
'        or (:P59_SIT_DESLIG = ''91'' and :P59_TIPO_CONTRATO = ''I''',
'            and exists (',
'                   select 1',
'                     from sit_func s',
'                    where s.cod = :P59_SIT_DESLIG',
'                      and s.ind_isencao_pedido in (''N'',''S'')  -- <== agora cobre N e S',
'            )))',
''))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362969090616680825)
,p_name=>'P59_HAVERA_REP'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Haver\00E1 Reposi\00E7\00E3o?')
,p_source=>'HAVERA_REP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362969457179680826)
,p_name=>'P59_JUSTIFICATIVA'
,p_is_required=>true
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Justificativa'
,p_source=>'JUSTIFICATIVA'
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
 p_id=>wwv_flow_api.id(281362969862180680826)
,p_name=>'P59_OBS'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>3000
,p_cHeight=>5
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503513276304346679)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281362970208807680826)
,p_name=>'P59_RESCISAO_COMPLEMENTAR'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(281362963825668680819)
,p_use_cache_before_default=>'NO'
,p_source=>'RESCISAO_COMPLEMENTAR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(281373262838365818367)
,p_name=>'P59_ITEM_VALIDACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281362954260580680809)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281212493860894140783)
,p_validation_name=>'(CREATE) Valida Upload de Carta'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P59_SIT_DESLIG = ''91'' and :P59_UPLOAD_CARTA_DESLIG = ''S'' AND :P59_ARQUIVO IS NULL then',
unistr('  return ''ANEXE o aviso assinado pelo empregado para finalizar a requisi\00E7\00E3o, sob pena de MULTA prevista no art. 477 da CLT, revertida ao empregado'';'),
'end if;',
'  ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(277209984330953891486)
,p_validation_name=>'(SAVE) Valida Upload de Carta'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nome_arquivo, dbms_lob.getlength(arquivo) filesize',
'  from desligamento',
' where cod_desligamento = :p59_cod_desligamento;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :P59_SIT_DESLIG = ''91'' and :P59_UPLOAD_CARTA_DESLIG = ''S'' AND (nvl(v_c1.filesize,0) = 0 and :P59_ARQUIVO is null) then',
unistr('  return ''ANEXE o aviso assinado pelo empregado para finalizar a requisi\00E7\00E3o, sob pena de MULTA prevista no art. 477 da CLT, revertida ao empregado'';'),
'end if;',
'  ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'P59_COD_SIT_DESLIGAMENTO'
,p_validation_condition2=>'3'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_api.id(281362953483545680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281158515310508820214)
,p_validation_name=>unistr('Valida Requisi\00E7\00E3o Parte 1')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_data date := :p59_dt_comunicacao;',
'',
'  CURSOR C1 IS',
'  SELECT DISTINCT I.COD_EMPRESA, I.FILIAL, I.COD_CCUSTO, I.MATRICULA, i.data_contrato_prz_determinado data_contrato, i.prorrog_contrato_prz_determ data_prorrogacao',
'    FROM INFORMACOES_FUNCIONAIS I',
'   WHERE I.COD_EMPRESA = :P59_COD_EMPRESA',
'     AND I.MATRICULA = :P59_MAT_SOLICITADO;',
'     ',
'  V_C1 C1%ROWTYPE;',
'',
'cursor c2 is ',
'select initcap(descricao)||'' - (''||cod||'')'' descricao, cod, cod_motivo_esocial',
'  from motivo_alteracoes',
' where class_motivo = ''2''',
' and cod = NVL(:p59_cod_mot_deslig,COD)',
'   and ((cod_motivo_esocial = 3 and :p59_sit_deslig = ''93'')',
'   or (cod_motivo_esocial = 6 and :p59_sit_deslig = ''96'')',
'   or (cod_motivo_esocial = 6 and :p59_sit_deslig = ''99''))',
'order by 3,2;',
'',
'  V_C2 C2%ROWTYPE;',
'  ',
'begin',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'OPEN C2;',
'FETCH C2 INTO V_C2;',
'CLOSE C2;',
'',
'if :p59_mat_solicitado is not null and :P59_SIT_DESLIG is not null then ',
'',
'if :p59_rowid is null then',
'',
' pkg_deslig.Valida_Sit_Deslig(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.PRE_INSERT(:p59_cod_empresa, :p59_mat_solicitado, v_data, :P59_SIT_DESLIG, :P59_AVISO_PREVIO, v_flg_retorno, v_msg_retorno);',
'           ',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.valida_afastamento(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.valida_cipa(:p59_cod_empresa, :p59_mat_solicitado, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Per_Ferias(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Matricula(:p59_cod_empresa, :p59_mat_solicitado, :p_empresa_user, :p_matricula_user, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Req(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
'  ',
'pkg_deslig.Valida_Dt_Comunicacao(:P59_COD_EMPRESA, :P59_MAT_SOLICITADO, v_data, :p59_sit_deslig, :p59_cod_mot_deslig, :P59_AVISO_PREVIO, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno not in (''Q'',''S'') then goto valida; end if;',
' ',
'pkg_deslig.Valida_Mot_Deslig(:P59_COD_EMPRESA, :P59_MAT_SOLICITADO, v_data, :p59_sit_deslig, :p59_cod_mot_deslig, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno not in (''Q'',''S'') then goto valida; end if;',
' ',
' end if;',
'',
' <<valida>>',
'',
' if v_msg_retorno is not null and v_flg_retorno <> ''Q'' then',
'    return v_msg_retorno;',
' end if; ',
'',
'end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271266834771817057813)
,p_validation_name=>unistr('Valida Requisi\00E7\00E3o Parte 2')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_data date := :p59_dt_comunicacao;',
'',
'  CURSOR C1 IS',
'  SELECT DISTINCT I.COD_EMPRESA, I.FILIAL, I.COD_CCUSTO, I.MATRICULA, i.data_contrato_prz_determinado data_contrato, i.prorrog_contrato_prz_determ data_prorrogacao',
'    FROM INFORMACOES_FUNCIONAIS I',
'   WHERE I.COD_EMPRESA = :P59_COD_EMPRESA',
'     AND I.MATRICULA = :P59_MAT_SOLICITADO;',
'     ',
'  V_C1 C1%ROWTYPE;',
'',
'cursor c2 is ',
'select initcap(descricao)||'' - (''||cod||'')'' descricao, cod, cod_motivo_esocial',
'  from motivo_alteracoes',
' where class_motivo = ''2''',
' and cod = NVL(:p59_cod_mot_deslig,COD)',
'   and ((cod_motivo_esocial = 3 and :p59_sit_deslig = ''93'')',
'   or (cod_motivo_esocial = 6 and :p59_sit_deslig = ''96'')',
'   or (cod_motivo_esocial = 6 and :p59_sit_deslig = ''99''))',
'order by 3,2;',
'',
'  V_C2 C2%ROWTYPE;',
'',
'cursor c3 is',
'select dt_comunicacao, dt_sit_desligamento',
'  from desligamento',
' where cod_desligamento = :p59_cod_desligamento;',
' ',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'OPEN C2;',
'FETCH C2 INTO V_C2;',
'CLOSE C2;',
'',
'OPEN C3;',
'FETCH C3 INTO V_C3;',
'CLOSE C3;',
'',
'if (:p59_rowid is null     and :p59_mat_solicitado is not null and :P59_SIT_DESLIG is not null) or ',
'   (:p59_rowid is not null and :p59_dt_comunicacao <> v_c3.dt_comunicacao) or ',
'   (:p59_rowid is not null and :p59_dt_sit_desligamento <> v_c3.dt_sit_desligamento) then ',
' ',
' pkg_deslig.Valida_Dt_Deslig_0(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_DT_COMUNICACAO, :p59_sit_deslig, :P59_AVISO_PREVIO);',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_01(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_02(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_03(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_1(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_2(:p59_cod_empresa, :p59_mat_solicitado, :P59_DT_SIT_DESLIGAMENTO, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno,nvl(to_date(:P59_DT_DESLIGAMENTO,''DD/MM/YYYY''),TRUNC(SYSDATE)));',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_3(:p59_cod_empresa, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, :p59_aviso_previo,:p59_dt_comunicacao, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_4(:p59_cod_empresa, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_5(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, :P59_AVISO_PREVIO, :p59_dt_comunicacao, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then goto valida; end if;',
'',
' <<valida>>',
'',
' if v_msg_retorno is not null and v_flg_retorno <> ''Q'' then',
'    return v_msg_retorno;',
' end if; ',
'',
'end if;',
'',
'exception',
'  when others then',
'    if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'      return(v_msg_retorno);',
'    else',
unistr('      return(''Erro ao validar requisi\00E7\00E3o: ''||sqlerrm);'),
'    end if; ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(280915454056568284176)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cargo',
'  from informacoes_funcionais_cad',
' where cod_empresa = :p59_cod_empresa',
'   and matricula = :p59_mat_solicitado;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF :p59_cod_empresa IS NOT NULL AND :p59_mat_solicitado IS NOT NULL THEN',
'',
'pkg_deslig.valida_afastamento(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.valida_cipa(:p59_cod_empresa, :p59_mat_solicitado, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Per_Ferias(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Matricula(:p59_cod_empresa, :p59_mat_solicitado, :p_empresa_user, :p_matricula_user, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Req(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' <<valida>>',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
' return v_msg_retorno;',
' end if;',
' ',
'END IF;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271254822493482072015)
,p_validation_name=>'Valida Ponto'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
' if :P59_VALIDA_PONTO = ''N'' then',
unistr(' return ''Para este colaborador, o ponto n\00E3o foi fechado.'';'),
' end if;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P_BASE = ''STEFANINI'' AND :P59_ROWID IS NULL then',
'return true;',
'else',
'return false;',
'end if;'))
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281362971388973680828)
,p_validation_name=>unistr('Valida Situa\00E7\00E3o')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p59_mat_solicitado is not null and :P59_SIT_DESLIG is not null and :p59_rowid is null then',
'',
' :p59_mensagem := null;',
'',
' pkg_deslig.Valida_Sit_Deslig(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is null then goto valida; end if;',
' ',
' <<valida>>',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' elsif v_msg_retorno is not null and v_flg_retorno = ''Q'' then',
'    :p59_flag := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
'    :p59_ok := ''N'';',
' end if; ',
' ',
'end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_associated_item=>wwv_flow_api.id(281362967051691680824)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281362971779422680828)
,p_validation_name=>'Valida Cod Sit Deslig'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p59_mat_solicitado is not null and :P59_SIT_DESLIG is not null and :p59_rowid is not null then',
'',
'-- pkg_deslig.Valida_Alt_Sit_Deslig(:p59_cod_empresa, :p59_cod_desligamento, :P59_COD_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is null then goto valida; end if;',
' ',
' <<valida>>',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' elsif v_msg_retorno is not null and v_flg_retorno = ''Q'' then',
'    :p59_flag := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
'    :p59_ok := ''N'';',
' end if; ',
' ',
'end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_associated_item=>wwv_flow_api.id(281362957461759680812)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269984114024816437468)
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
' pkg_deslig.valida_sit_requisicao(:p59_cod_desligamento, :p59_cod_sit_desligamento, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'   return v_msg_retorno;',
' end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(281362957461759680812)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(281227300584803129623)
,p_validation_name=>'Valida Tp_Av_Previo'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'/*',
'IF :P59_SIT_DESLIG = ''91'' AND :P59_AVISO_PREVIO = ''N'' AND :P59_TP_AV_PREVIO <> 3 THEN',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "3"!'';'),
'ELS*/IF :P59_SIT_DESLIG in (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''T'' AND :P59_TP_AV_PREVIO <> 4 THEN',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "4"!'';	 '),
'ELSIF :P59_SIT_DESLIG = ''93'' AND :P59_AVISO_PREVIO = ''T'' AND :P59_TP_AV_PREVIO NOT IN(1,2) THEN',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "1" ou "2"!'';'),
'END IF;',
'',
'return v_msg_retorno;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(281362953841738680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(278901603445334941474)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P59_COD_SIT_DESLIGAMENTO = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(281362953483545680809)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269943974181040622052)
,p_validation_name=>unistr('(Observa\00E7\00E3o) Perfil Rescis\00E3o')
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select dt_comunicacao',
'  from desligamento',
' where cod_desligamento = :p59_cod_desligamento;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :P_PERFIL in (''MASTER'',''RESCISAO'',''FOLHA TOPAZ'') and :p59_dt_comunicacao <> v_c1.dt_comunicacao and :p59_obs is null then',
unistr('return ''Para esta altera\00E7\00E3o, \00E9 necess\00E1rio preencher o campo Observa\00E7\00E3o.'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(281362969862180680826)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362988875045680842)
,p_name=>'Hide Region'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P59_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362989380068680843)
,p_event_id=>wwv_flow_api.id(281362988875045680842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281362954260580680809)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362989834558680843)
,p_event_id=>wwv_flow_api.id(281362988875045680842)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p59_havera_rep := ''S'';'
,p_attribute_03=>'P59_HAVERA_REP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362980097094680834)
,p_name=>unistr('Valida Matr\00EDcula')
,p_event_sequence=>1061
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MAT_SOLICITADO'
,p_condition_element=>'P59_MAT_SOLICITADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P59_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212494673088140791)
,p_event_id=>wwv_flow_api.id(281362980097094680834)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_OK'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362980677113680835)
,p_event_id=>wwv_flow_api.id(281362980097094680834)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cargo, IND_CONTRATO_PRZ_DETERMINADO',
'  from informacoes_funcionais_cad',
' where cod_empresa = :p59_cod_empresa',
'   and matricula = :p59_mat_solicitado;',
'   ',
'v_c1 c1%rowtype;',
'',
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P59_ITEM_VALIDACAO := null;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p59_cod_cargo := v_c1.cargo;',
':p59_tipo_contrato := v_c1.IND_CONTRATO_PRZ_DETERMINADO;',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
'',
'IF :p59_cod_empresa IS NOT NULL AND :p59_mat_solicitado IS NOT NULL THEN',
'',
'pkg_deslig.valida_afastamento(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.valida_cipa(:p59_cod_empresa, :p59_mat_solicitado, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Per_Ferias(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Matricula(:p59_cod_empresa, :p59_mat_solicitado, :p_empresa_user, :p_matricula_user, :P59_DT_SIT_DESLIGAMENTO, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Req(:p59_cod_empresa, :p59_mat_solicitado, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' <<valida>>',
'/*',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p59_flag := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
'    :p59_ok := ''N'';',
'    ',
' else ',
'    :p59_ok := ''S'';',
' end if; ',
'*/',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_MAT_SOLICITADO''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' elsif nvl(v_flg_retorno,''S'') = ''S'' then',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := trim(v_msg_retorno);',
'    if v_item_validacao = TRIM(UPPER(''P59_MAT_SOLICITADO'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
'',
'',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_ITEM_VALIDACAO,P59_DT_SIT_DESLIGAMENTO,P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_OK,P59_COD_CARGO,P59_ITEM_VALIDACAO,P59_TIPO_CONTRATO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(272416310853835393395)
,p_event_id=>wwv_flow_api.id(281362980097094680834)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select decode(i.IND_CONTRATO_PRZ_DETERMINADO,''D'',''Determinado'',''I'',''Indeterminado'') ind_contrato,',
'       i.data_contrato_prz_determinado dt_contrato,',
'       i.prorrog_contrato_prz_determ dt_prorrog,',
'       i.IND_CONTRATO_PRZ_DETERMINADO',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p59_ind_contrato_1  := v_c1.IND_CONTRATO;',
':p59_dt_contrato_1  := v_c1.dt_contrato;',
':p59_dt_prorrog_1  := v_c1.dt_prorrog;',
'',
':P59_IND_CONTR_PRZ_DETERM := v_c1.IND_CONTRATO_PRZ_DETERMINADO;',
':P59_DATA_CONTR_PRZ_DETERM := v_c1.dt_contrato;',
':P59_PRORROG_CONTR_PRZ_DETERM := v_c1.dt_prorrog;',
'',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO'
,p_attribute_03=>'P59_IND_CONTRATO_1,P59_DT_CONTRATO_1,P59_DT_PRORROG_1,P59_IND_CONTR_PRZ_DETERM,P59_DATA_CONTR_PRZ_DETERM,P59_PRORROG_CONTR_PRZ_DETERM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271251882516865705934)
,p_event_id=>wwv_flow_api.id(281362980097094680834)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from informacoes_funcionais_cad i, pe_escalas_excecoes p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and trunc(sysdate) between p.inicio and p.fim',
'   and p.excecao = ''N''',
'   and i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'/*',
'if v_c1.existe = ''S'' then',
':p59_valida_ponto := ''N'';',
'else',
':p59_valida_ponto := ''S'';',
'end if;',
'*/',
':p59_valida_ponto := ''N'';',
'',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO'
,p_attribute_03=>'P59_VALIDA_PONTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362987968690680842)
,p_name=>'Popula Vaga'
,p_event_sequence=>1071
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MAT_SOLICITADO'
,p_condition_element=>'P59_MAT_SOLICITADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362988429114680842)
,p_event_id=>wwv_flow_api.id(281362987968690680842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cad_vaga, filial, cod_empresa',
'  from informacoes_funcionais',
' where cod_empresa = :p59_cod_empresa',
'   and matricula = :p59_mat_solicitado;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'  select tipo_salario, valor_verba',
'  into   :p59_tipo_salario, :p59_valor_verba',
'  from   cl_vaga',
'  where  cod_vaga = v_c1.cad_vaga',
'  and    cod_filial = v_c1.filial',
'  and    cod_empresa = v_c1.cod_empresa;',
'  ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p59_vaga := v_c1.cad_vaga;',
'',
'if v_c1.cad_vaga is not null then',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'  ',
'  :p59_tipo_salario := v_c2.tipo_salario;',
'  :p59_valor_verba := v_c2.valor_verba;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO'
,p_attribute_03=>'P59_VAGA,P59_TIPO_SALARIO,P59_VALOR_VERBA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269984113548101437463)
,p_name=>unistr('Valida Sit Requisi\00E7\00E3o')
,p_event_sequence=>1081
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269984113797635437465)
,p_event_id=>wwv_flow_api.id(269984113548101437463)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P59_ITEM_VALIDACAO := null;',
'',
'pkg_deslig.valida_sit_requisicao(:p59_cod_desligamento, :p59_cod_sit_desligamento, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_SIT_DESLIGAMENTO''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' elsif nvl(v_flg_retorno,''S'') = ''S'' then',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := trim(v_msg_retorno);',
'    if v_item_validacao = TRIM(UPPER(''P59_SIT_DESLIGAMENTO'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P59_ITEM_VALIDACAO,P59_COD_DESLIGAMENTO,P59_COD_SIT_DESLIGAMENTO'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_OK,P59_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362983459156680838)
,p_name=>'Dispara Alerta'
,p_event_sequence=>1091
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362983950168680839)
,p_event_id=>wwv_flow_api.id(281362983459156680838)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P59_FLAG'').value == "Q") {',
'alertify.confirm($v(''P59_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P59_FLAG'').value = ''S'';',
'        $x(''P59_MENSAGEM'').value = '''';',
'        $x(''P59_OK'').value = ''S'';',
'       // $(''#P59_CREATE'').show();',
'    } else {',
'        $x(''P59_OK'').value = ''N'';',
'      //  $(''#P59_CREATE'').hide();',
'    }',
'});',
'} else {',
'',
'    if ($x(''P59_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P59_FLAG'').value == "N") {',
'           // $(''#P59_CREATE'').hide();',
'        } else {',
'          //  $(''#P59_CREATE'').show();',
'        }',
'            ',
'        alertify.alert($v(''P59_MENSAGEM''));',
'    }',
'',
'                 ',
'}',
''))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362984352517680839)
,p_name=>'Inicia Alertify'
,p_event_sequence=>1101
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362984836738680839)
,p_event_id=>wwv_flow_api.id(281362984352517680839)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362985270784680840)
,p_name=>'Valida Dt Sit Deslig'
,p_event_sequence=>1111
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362985775053680840)
,p_event_id=>wwv_flow_api.id(281362985270784680840)
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
'v_qtd_dife number;',
'V_flag_aviso varchar2(2);',
'',
'',
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
' ',
' --',
' v_qtd_dife :=TO_NUMBER ( TO_DATE(:P59_DT_SIT_DESLIGAMENTO,''DD/MM/YYYY'') - TO_DATE(:P59_DT_COMUNICACAO,''DD/MM/YYYY'') );',
' ',
' IF NVL(v_qtd_dife,0) >= 30 THEN ',
'   V_flag_aviso := ''Z'' ;',
' ELSE',
'   V_flag_aviso := :P59_AVISO_PREVIO ;',
' END IF;',
' ',
' --',
'IF :p59_cod_empresa IS NOT NULL AND :p59_mat_solicitado IS NOT NULL /*and :p59_rowid is null */THEN',
'',
' pkg_deslig.Valida_Dt_Deslig_0(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_DT_COMUNICACAO, :P59_SIT_DESLIG, V_flag_aviso);',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' if :p59_aviso_previo = ''T'' then',
'   pkg_deslig.Valida_Dt_Deslig_04(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG, V_flag_aviso );',
' else',
'   pkg_deslig.Valida_Dt_Deslig_01(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG, V_flag_aviso );',
' end if;',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
'-- pkg_deslig.Valida_Dt_Deslig_02(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
'-- pkg_deslig.Valida_Dt_Deslig_03(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_1(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
'-- pkg_deslig.Valida_Dt_Deslig_2(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno,nvl(to_date(:P59_DT_DESLIGAMENTO,''DD/MM/YYYY''),trunc(sysdate)));',
'',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
'-- pkg_deslig.Valida_Dt_Deslig_3(:p59_cod_empresa, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, :p59_aviso_previo, :p59_dt_comunicacao, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_4(:p59_cod_empresa, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
'',
'-- pkg_deslig.Valida_Dt_Deslig_5(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, :P59_AVISO_PREVIO, :p59_dt_comunicacao, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
' <<valida>>',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_DT_SIT_DESLIGAMENTO''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P59_DT_SIT_DESLIGAMENTO'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'END IF;',
'',
'end;'))
,p_attribute_02=>'P59_COD_DESLIGAMENTO,P59_COD_EMPRESA,P59_COD_EMPRESA_SOLICITANTE,P59_MAT_SOLICITADO,P59_MAT_SOLICITANTE,P59_DT_SIT_DESLIGAMENTO,P59_SIT_DESLIG,P59_COD_SIT_DESLIGAMENTO,P59_ITEM_VALIDACAO,P59_AVISO_PREVIO,P59_DT_COMUNICACAO,P59_DT_DESLIGAMENTO'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_OK,P59_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(201973231919729047494)
,p_event_id=>wwv_flow_api.id(281362985270784680840)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
'',
'IF :p59_cod_empresa IS NOT NULL AND :p59_mat_solicitado IS NOT NULL /*and :p59_rowid is null */THEN',
'',
'-- pkg_deslig.Valida_Dt_Deslig_0(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
'-- pkg_deslig.Valida_Dt_Deslig_01(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG, :P59_AVISO_PREVIO);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_02(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_03(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno, :P59_SIT_DESLIG);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
'',
'-- pkg_deslig.Valida_Dt_Deslig_1(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_2(:p59_cod_empresa, :p59_mat_solicitado, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno,nvl(to_date(:P59_DT_DESLIGAMENTO,''DD/MM/YYYY''),trunc(sysdate)));',
'',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
' pkg_deslig.Valida_Dt_Deslig_3(:p59_cod_empresa, :p59_dt_sit_desligamento, :P59_SIT_DESLIG, :p59_aviso_previo, :p59_dt_comunicacao, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
' ',
'-- pkg_deslig.Valida_Dt_Deslig_4(:p59_cod_empresa, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
'-- if v_msg_retorno is not null then goto valida; end if;',
'',
' pkg_deslig.Valida_Dt_Deslig_5(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, :P59_AVISO_PREVIO, :p59_dt_comunicacao, :p59_dt_sit_desligamento, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then goto valida; end if;',
'',
' <<valida>>',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_DT_SIT_DESLIGAMENTO''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P59_DT_SIT_DESLIGAMENTO'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'END IF;',
'',
'end;'))
,p_attribute_02=>'P59_COD_DESLIGAMENTO,P59_COD_EMPRESA,P59_COD_EMPRESA_SOLICITANTE,P59_MAT_SOLICITADO,P59_MAT_SOLICITANTE,P59_DT_SIT_DESLIGAMENTO,P59_SIT_DESLIG,P59_COD_SIT_DESLIGAMENTO,P59_ITEM_VALIDACAO,P59_AVISO_PREVIO,P59_DT_COMUNICACAO,P59_DT_DESLIGAMENTO'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_OK,P59_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362986111791680841)
,p_name=>unistr('Valida Situa\00E7\00E3o')
,p_event_sequence=>1121
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_SIT_DESLIG'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362986684727680841)
,p_event_id=>wwv_flow_api.id(281362986111791680841)
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
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p59_mat_solicitado is not null and :P59_SIT_DESLIG is not null and :p59_rowid is null then',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
'',
' pkg_deslig.Valida_Sit_Deslig(:p59_cod_empresa, :p59_mat_solicitado, :P59_SIT_DESLIG, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_SIT_DESLIG''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P59_SIT_DESLIG'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_SIT_DESLIG,P59_ITEM_VALIDACAO'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_OK,P59_AVISO_PREVIO,P59_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212492287348140767)
,p_event_id=>wwv_flow_api.id(281362986111791680841)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_DT_COMUNICACAO,P59_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281362987026114680841)
,p_name=>'Hide Fields'
,p_event_sequence=>1131
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p59_cod_empresa is not null and :p59_mat_solicitado is not null and :p59_cod_sit_desligamento is null and :p59_dt_desligamento is null and :p59_rowid is null then',
'return true;',
'elsif :p59_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281362987503340680842)
,p_event_id=>wwv_flow_api.id(281362987026114680841)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_COD_FILIAL,P59_COD_CCUSTO,P59_IND_CONTRATO_1,P59_DT_CONTRATO_1,P59_DT_PRORROG_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281375679789366620724)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>1141
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P59_COD_SIT_DESLIGAMENTO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281226170313285371749)
,p_name=>'Popula Recomenda_Realocacao'
,p_event_sequence=>1151
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_IND_REALOCACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281226170406119371750)
,p_event_id=>wwv_flow_api.id(281226170313285371749)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p59_recomenda_realocacao := :p59_ind_realocacao;'
,p_attribute_02=>'P59_IND_REALOCACAO'
,p_attribute_03=>'P59_RECOMENDA_REALOCACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281226170886954371755)
,p_name=>'Valida Dt_Comunicacao'
,p_event_sequence=>1161
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_COMUNICACAO'
,p_condition_element=>'P59_DT_COMUNICACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281226171012448371756)
,p_event_id=>wwv_flow_api.id(281226170886954371755)
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
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'v_data date := :p59_dt_comunicacao;',
'',
'begin',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
' ',
'--Bruno 06/01/2025',
'pkg_deslig.Valida_Dt_Comunicacao(:P59_COD_EMPRESA,',
'                             :P59_MAT_SOLICITADO,',
'                             v_data,',
'                             :p59_sit_deslig,',
'                             :p59_cod_mot_deslig,',
'                             :P59_AVISO_PREVIO,',
'                              v_flg_retorno,',
'                              v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''p59_dt_comunicacao''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    ',
'    if v_msg_retorno is null then',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    else',
'    :P59_ok       := ''S'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
'    end if;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''p59_dt_comunicacao'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P59_ITEM_VALIDACAO,P59_DT_COMUNICACAO,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO'
,p_attribute_03=>'P59_FLAG,P59_MENSAGEM,P59_ITEM_VALIDACAO,P59_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281226171515571371761)
,p_name=>'Close Carta'
,p_event_sequence=>1171
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281226171363394371760)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281226171633010371762)
,p_event_id=>wwv_flow_api.id(281226171515571371761)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281226171138486371758)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281226171640871371763)
,p_name=>'Open Carta'
,p_event_sequence=>1191
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281226171035471371757)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31150131135037517352)
,p_event_id=>wwv_flow_api.id(281226171640871371763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_existe_anexo1 number := 0;',
'v_existe_anexo2 number := 0;',
'',
'begin',
'',
'',
'SELECT count(1)',
'into v_existe_anexo1',
'  FROM DESLIGAMENTO D',
' WHERE D.COD_DESLIGAMENTO = :P59_COD_DESLIGAMENTO',
'   AND D.ARQUIVO IS NOT NULL',
'   and D.COD_SIT_DESLIG In (''9A'',''92'',''93'',''96'',''99'');',
'   ',
'SELECT count(1)',
'into v_existe_anexo2',
'  FROM DESLIGAMENTO D',
' WHERE D.COD_DESLIGAMENTO = :P59_COD_DESLIGAMENTO',
'   AND D.ARQUIVO IS NOT NULL',
'   AND D.COD_SIT_DESLIGAMENTO in (2,3);   ',
'',
'if v_existe_anexo1 > 0 then',
':P59_EXISTE_ANEXO := ''S'';',
'ELSE ',
':P59_EXISTE_ANEXO := ''N'';',
'END IF;',
'   ',
'if v_existe_anexo2 > 0 then',
':P59_EXISTE_ANEXO_CONCLUIDO :=  ''S'';',
'ELSE ',
':P59_EXISTE_ANEXO_CONCLUIDO :=   ''N'';',
'END IF;',
'END;'))
,p_attribute_02=>'P59_COD_DESLIGAMENTO'
,p_attribute_03=>'P59_EXISTE_ANEXO,P59_EXISTE_ANEXO_CONCLUIDO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281226171798748371764)
,p_event_id=>wwv_flow_api.id(281226171640871371763)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281226171138486371758)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(32483226073227188657)
,p_event_id=>wwv_flow_api.id(281226171640871371763)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Captura os valores dos itens',
'var sitDeslig = apex.item("P59_SIT_DESLIG").getValue();',
'var codSitDeslig = apex.item("P59_COD_SIT_DESLIGAMENTO").getValue();',
'var existeAnexo = apex.item("P59_EXISTE_ANEXO").getValue();',
'',
unistr('// Lista de situa\00E7\00F5es que disparam a regra'),
'var listaSit = ["9A","92", "93", "96", "99"];',
'',
'if (listaSit.includes(sitDeslig) && codSitDeslig != "5" && existeAnexo !== "S") {',
'    apex.item("P59_ARQUIVO").hide();    ',
'    apex.item("P59_MSG_ANEXO").show();',
'} else {',
'    apex.item("P59_ARQUIVO").show();',
'    apex.item("P59_MSG_ANEXO").hide();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(31150131259530517353)
,p_event_id=>wwv_flow_api.id(281226171640871371763)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var existeAnexo = apex.item("P59_EXISTE_ANEXO_CONCLUIDO").getValue();',
'',
'if (existeAnexo == "S") {',
'    apex.item("P59_ARQUIVO").disable();    ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158389545505057301)
,p_name=>unistr('Open Relat\00F3rios')
,p_event_sequence=>1201
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281158389451397057300)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158389705280057302)
,p_event_id=>wwv_flow_api.id(281158389545505057301)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281158388290890057288)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281226172018703371766)
,p_name=>unistr('Desabilita Campos (Em Aprova\00E7\00E3o)')
,p_event_sequence=>1211
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF 1 = 2 THEN',
'if :P59_COD_SIT_DESLIGAMENTO not in (1) then',
'  return true;',
'  else',
'  return false;',
'  end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281226172099614371767)
,p_event_id=>wwv_flow_api.id(281226172018703371766)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_COD_FILIAL,P59_COD_CCUSTO,P59_SIT_DESLIG,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_HAVERA_REP,P59_IND_REALOCACAO,P59_RESTRICAO_REALOCACAO,P59_JUSTIFICATIVA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281212493199508140776)
,p_name=>'Alerta Anexo de Carta'
,p_event_sequence=>1221
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nome_arquivo',
'  from desligamento',
' where cod_desligamento = :P59_COD_DESLIGAMENTO;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c_rel is',
'select descricao, cod',
'  from reports_desligamento;',
'  ',
'v_rel c_rel%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
' open c_rel;',
'fetch c_rel into v_rel;',
'close c_rel;',
'',
'if (:P59_COD_SIT_DESLIGAMENTO in (5) and trim(v_c1.nome_arquivo) is null) and v_rel.cod is not null then',
'  return true;',
'else',
'  return false;',
'end if;',
'  ',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212493642279140780)
,p_event_id=>wwv_flow_api.id(281212493199508140776)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'error'
,p_attribute_02=>unistr('ANEXE o aviso assinado pelo empregado para finalizar a requisi\00E7\00E3o, sob pena de MULTA prevista no art. 477 da CLT, revertida ao empregado')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'false'
,p_attribute_05=>'true'
,p_attribute_06=>'false'
,p_attribute_07=>'true'
,p_attribute_08=>'30000000000'
,p_attribute_09=>'1000'
,p_attribute_10=>'500000'
,p_attribute_11=>'100000000'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258625272673096152837)
,p_event_id=>wwv_flow_api.id(281212493199508140776)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(258625272315063152834)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281212492873618140773)
,p_name=>'Desabilita Campos (Aprovado)'
,p_event_sequence=>1231
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF 1 = 2 THEN',
'if :P59_COD_SIT_DESLIGAMENTO in (3,4,6) then',
'  return true;',
'else',
'  return false;',
'end if;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212493015560140774)
,p_event_id=>wwv_flow_api.id(281212492873618140773)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_COD_FILIAL,P59_COD_CCUSTO,P59_SIT_DESLIG,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_HAVERA_REP,P59_IND_REALOCACAO,P59_RESTRICAO_REALOCACAO,P59_JUSTIFICATIVA,P59_DT_COMUNICACAO,P59_DT_SIT_DESLIGAMENTO,P59_TP_AV_PREV'
||'IO,P59_INDCUMPRPARC,P59_OBS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227300417628129621)
,p_name=>'Valida Tp_Av_Previo'
,p_event_sequence=>1241
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_TP_AV_PREVIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227300510248129622)
,p_event_id=>wwv_flow_api.id(281227300417628129621)
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
'v_item_validacao varchar2(100) := :P59_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p59_flag     := null;',
' :p59_mensagem := null;',
'/*',
'IF :P59_SIT_DESLIG = ''91'' AND :P59_AVISO_PREVIO = ''N'' AND :P59_TP_AV_PREVIO <> 3 THEN',
'    v_flg_retorno := ''N'';',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "3"!'';'),
'ELS*/',
'IF :P59_SIT_DESLIG in (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''T'' AND :P59_TP_AV_PREVIO <> 4 THEN',
'    v_flg_retorno := ''N'';',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "4"!'';	 '),
'ELSIF :P59_SIT_DESLIG = ''93'' AND :P59_AVISO_PREVIO = ''T'' AND :P59_TP_AV_PREVIO NOT IN(1,2) THEN',
'    v_flg_retorno := ''N'';',
unistr('	v_msg_retorno := ''S\00F3 \00E9 permitido informar a op\00E7\00E3o "1" ou "2"!'';'),
'END IF;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''P59_TP_AV_PREVIO''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P59_TP_AV_PREVIO'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P59_ITEM_VALIDACAO,P59_SIT_DESLIG,P59_AVISO_PREVIO,P59_TP_AV_PREVIO'
,p_attribute_03=>'P59_ITEM_VALIDACAO,P59_OK,P59_FLAG,P59_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227300704446129624)
,p_name=>'Seta Tp_Av_Previo'
,p_event_sequence=>1251
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_AVISO_PREVIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227300789471129625)
,p_event_id=>wwv_flow_api.id(281227300704446129624)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dt_comunicacao date := :P59_DT_COMUNICACAO;',
'v_dt_sit_desligamento date := :P59_DT_SIT_DESLIGAMENTO;',
'',
'begin',
'',
'IF :P59_SIT_DESLIG in (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''N'' THEN',
'	 :P59_TP_AV_PREVIO := 4;',
'ELSIF :P59_SIT_DESLIG in (''91'', ''9A'') AND :P59_AVISO_PREVIO = ''T'' THEN',
'	 :P59_TP_AV_PREVIO := 4;',
'END IF;',
'',
'if :P59_aviso_previo = ''T'' then',
'/*',
' if v_dt_comunicacao is not null then',
'',
'     if v_dt_comunicacao <> v_dt_sit_desligamento then',
'     :P59_DT_SIT_DESLIGAMENTO := (v_dt_comunicacao + 30) -1;',
'	 --:P59_DT_COMUNICACAO := (v_dt_sit_desligamento - 30) +1;',
'     else',
'     :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao;',
'     --:P59_DT_COMUNICACAO := v_dt_sit_desligamento;',
'     end if;',
'',
' end if;',
' */',
'	 if :P59_SIT_DESLIG = ''93'' and (NVL(:P59_tp_av_previo,0) not in(1,2)) then',
'	    :P59_TP_AV_PREVIO := 1;',
'	 end if;   ',
'	 ',
'else',
'    -- :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao;',
'	 :P59_TP_AV_PREVIO := null;',
'end if;  ',
'',
'if :P59_SIT_DESLIG in (''91'', ''9A'') And :P59_aviso_previo = ''N'' then',
'   :P59_tp_av_previo := 4;',
'elsif :P59_SIT_DESLIG in (''91'', ''9A'') and :P59_aviso_previo = ''T'' then',
'   :P59_tp_av_previo := 4;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P59_SIT_DESLIG,P59_AVISO_PREVIO,P59_DT_COMUNICACAO,P59_DT_SIT_DESLIGAMENTO'
,p_attribute_03=>'P59_TP_AV_PREVIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227300865824129626)
,p_name=>'Popula Dt_Sit_Deslig'
,p_event_sequence=>1261
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_COMUNICACAO,P59_AVISO_PREVIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227300936617129627)
,p_event_id=>wwv_flow_api.id(281227300865824129626)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dt_comunicacao date := :P59_DT_COMUNICACAO;',
'',
'cursor c0 is',
unistr('/*Bruno Sousa/Rosi 20/01/2025 - Data da comuni\00E7\00E3o menos data admiss\00E3o limitada a vinte anos.*/'),
'select case when floor((trunc(v_dt_comunicacao)-trunc(iff.dt_admissao))/365) > 20 then',
'60',
'else',
'floor((trunc(v_dt_comunicacao)-trunc(iff.dt_admissao))/365) * 3',
'end qtd_dias, ',
'nvl(iff.prorrog_contrato_prz_determ,iff.data_contrato_prz_determinado) dt_contrato,',
'iff.data_contrato_prz_determinado dt_prazo, ',
'iff.prorrog_contrato_prz_determ   dt_prorrog_prazo,',
'nvl(s.qtd_dias_aviso, 0) qtd_dias_aviso',
'from informacoes_funcionais iff, sindicatos s',
'where s.cod = iff.num_sind_diss',
'and s.cod_empresa = iff.cod_empresa',
'and iff.cod_empresa = :p59_cod_empresa',
'and iff.matricula = :p59_mat_solicitado;',
'   ',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'select acrescenta_dias_aviso',
'  from parametros_recursos_humanos',
' where cod_empresa = :p59_cod_empresa;',
'v_c1 c1%rowtype;',
'',
'v_estabilidade varchar2(1) := ''N'';',
'begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  if :P59_SIT_DESLIG = ''93'' and :P59_AVISO_PREVIO = ''I'' then',
'    ',
'    --v_estabilidade := pkg_deslig.fnc_estabilidade(:p59_cod_empresa,:p59_mat_solicitado, v_dt_comunicacao);',
'    :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao;',
'    ',
'  elsif :P59_SIT_DESLIG in (''91'',''93'') and :P59_AVISO_PREVIO = ''T'' then',
unistr('    /*Bruno Sousa 12/12/2024 - Nova regra definida pela Rosi - S\00F3 para trabalhado (T)'),
unistr('    ''N''\00E3o - N\00E3o d\00E1 mensagem e n\00E3o acrescenta os dias de proje\00E7\00E3o na data de demiss\00E3o'),
unistr('    ''S''im - D\00E1 a mensagem e n\00E3o acrescenta os dias de proje\00E7\00E3o na data de demiss\00E3o'),
unistr('    ''P''roje\00E7\00E3o - D\00E1 a mensagem e acrescenta os dias de proje\00E7\00E3o na data de demiss\00E3o'),
'    if nvl(v_c1.acrescenta_dias_aviso,''N'') = ''N'' then',
'      :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao + + v_c0.qtd_dias_aviso;',
'    else',
'      :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao + + v_c0.qtd_dias_aviso + v_c0.qtd_dias;',
'    end if;',
'    */',
'    if nvl(v_c1.acrescenta_dias_aviso,''N'') = ''P'' then',
'      :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao + v_c0.qtd_dias_aviso + v_c0.qtd_dias;',
'    else -- S ou N',
'      :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao + v_c0.qtd_dias_aviso;',
'    end if;',
'  elsif :P59_SIT_DESLIG in (''96'',''99'') then',
'    if v_dt_comunicacao <= nvl(v_c0.dt_prazo,v_dt_comunicacao) then',
'      :P59_DT_SIT_DESLIGAMENTO := nvl(v_c0.dt_prazo,v_dt_comunicacao);',
'    elsif v_dt_comunicacao > v_c0.dt_prazo and v_dt_comunicacao <= nvl(v_c0.dt_prorrog_prazo,v_dt_comunicacao) then',
'      :P59_DT_SIT_DESLIGAMENTO := nvl(v_c0.dt_prorrog_prazo,v_dt_comunicacao);',
'    else ',
'      :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao;',
'    end if;',
'  else',
'    :P59_DT_SIT_DESLIGAMENTO := v_dt_comunicacao;',
'  end if;',
'end;'))
,p_attribute_02=>'P59_DT_COMUNICACAO,P59_SIT_DESLIG,P59_AVISO_PREVIO'
,p_attribute_03=>'P59_DT_SIT_DESLIGAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227301079230129628)
,p_name=>'Desabilita Dt_Sit_Deslig'
,p_event_sequence=>1271
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DES_DT_SIT_DESLIG'
,p_condition_element=>'P59_DES_DT_SIT_DESLIG'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227301207038129629)
,p_event_id=>wwv_flow_api.id(281227301079230129628)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227301571097129633)
,p_event_id=>wwv_flow_api.id(281227301079230129628)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227301253562129630)
,p_name=>'Habilita Campos'
,p_event_sequence=>1281
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281362953841738680809)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227301419006129631)
,p_event_id=>wwv_flow_api.id(281227301253562129630)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280869016224885738604)
,p_event_id=>wwv_flow_api.id(281227301253562129630)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$x(''P59_DT_SIT_DESLIGAMENTO'').disabled = false;'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281227301711644129634)
,p_name=>'Des. Dt Sit_deslig'
,p_event_sequence=>1291
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_AVISO_PREVIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281227301754881129635)
,p_event_id=>wwv_flow_api.id(281227301711644129634)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :P59_SIT_DESLIG = ''93'' and :P59_AVISO_PREVIO = ''I'' then',
'    :P59_DES_DT_SIT_DESLIG := ''S'';',
'    elsif :P59_SIT_DESLIG in /*(''91'',''93'')*/ (''93'') and :P59_AVISO_PREVIO = ''T'' then',
'     :P59_DES_DT_SIT_DESLIG := ''S''; -- :P59_DES_DT_SIT_DESLIG := ''N''; -- :P59_DES_DT_SIT_DESLIG := ''S'';',
'    elsif :P59_SIT_DESLIG in (''96'',''99'') then',
'    :P59_DES_DT_SIT_DESLIG := ''S'';',
'    elsif :P59_AVISO_PREVIO = ''N'' then',
'    :P59_DES_DT_SIT_DESLIG := ''S'';',
'    else',
'    :P59_DES_DT_SIT_DESLIG := ''N'';',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P59_SIT_DESLIG,P59_AVISO_PREVIO'
,p_attribute_03=>'P59_DES_DT_SIT_DESLIG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281235600393959975657)
,p_name=>'Show / Hide RESTRICAO_REALOCACAO'
,p_event_sequence=>1301
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_IND_REALOCACAO'
,p_condition_element=>'P59_IND_REALOCACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281235600550620975659)
,p_event_id=>wwv_flow_api.id(281235600393959975657)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_RESTRICAO_REALOCACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281235600637948975660)
,p_event_id=>wwv_flow_api.id(281235600393959975657)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p59_restricao_realocacao := ''N'';'
,p_attribute_03=>'P59_RESTRICAO_REALOCACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281235600441266975658)
,p_event_id=>wwv_flow_api.id(281235600393959975657)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_RESTRICAO_REALOCACAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281212492069923140765)
,p_name=>'Popula Filial /CCusto'
,p_event_sequence=>1311
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MAT_SOLICITADO'
,p_condition_element=>'P59_MAT_SOLICITADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212492224760140766)
,p_event_id=>wwv_flow_api.id(281212492069923140765)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.filial,',
'       i.cod_ccusto,',
'       i.cargo,',
'       p.mod_cart_prof,',
'       i.vinculo',
'  from informacoes_funcionais_cad i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'/*',
'if :p59_cod_filial is null then',
':p59_cod_filial := v_c1.filial;',
'end if;',
'',
'if :p59_cod_ccusto is null then',
':p59_cod_ccusto := v_c1.cod_ccusto;',
'end if;',
'*/',
'if :p59_cod_cargo is null then',
':p59_cod_cargo  := v_c1.cargo;',
'end if;',
'',
':p59_tipo_carteira := v_c1.mod_cart_prof;',
':p59_vinculo := v_c1.vinculo;',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_COD_FILIAL,P59_COD_CCUSTO,P59_COD_CARGO'
,p_attribute_03=>'P59_COD_CARGO,P59_TIPO_CARTEIRA,P59_VINCULO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281212493717751140781)
,p_name=>unistr('(Cria\00E7\00E3o) Habilita Carta')
,p_event_sequence=>1321
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_SIT_DESLIG'
,p_condition_element=>'P59_SIT_DESLIG'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'91'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P59_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212493799857140782)
,p_event_id=>wwv_flow_api.id(281212493717751140781)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281226171035471371757)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258625272886102152839)
,p_event_id=>wwv_flow_api.id(281212493717751140781)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(258625272315063152834)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258625272983727152840)
,p_event_id=>wwv_flow_api.id(281212493717751140781)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(258625272315063152834)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280858533862942394083)
,p_event_id=>wwv_flow_api.id(281212493717751140781)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'error'
,p_attribute_02=>unistr('ANEXE o aviso assinado pelo empregado para finalizar a requisi\00E7\00E3o, sob pena de MULTA prevista no art. 477 da CLT, revertida ao empregado')
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'false'
,p_attribute_05=>'true'
,p_attribute_06=>'false'
,p_attribute_07=>'true'
,p_attribute_08=>'30000000000'
,p_attribute_09=>'1000'
,p_attribute_10=>'500000'
,p_attribute_11=>'100000000'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280660644872083510510)
,p_name=>'(Pesquisa) Habilita Carta'
,p_event_sequence=>1331
,p_condition_element=>'P59_UPLOAD_CARTA_DESLIG'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p59_sit_deslig = ''91'' then',
'    return true;',
'elsif :P59_COD_SIT_DESLIGAMENTO = 5 then',
'    return true;',
'else ',
'    return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280660644953542510511)
,p_event_id=>wwv_flow_api.id(280660644872083510510)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281226171035471371757)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280660645303193510514)
,p_event_id=>wwv_flow_api.id(280660644872083510510)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281226171035471371757)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281212494923184140793)
,p_name=>'(Save) Habilitar Campos'
,p_event_sequence=>1341
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281362953483545680809)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281212495042810140794)
,p_event_id=>wwv_flow_api.id(281212494923184140793)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_COD_FILIAL,P59_COD_CCUSTO,P59_SIT_DESLIG,P59_COD_MOT_DESLIG,P59_AVISO_PREVIO,P59_HAVERA_REP,P59_IND_REALOCACAO,P59_RESTRICAO_REALOCACAO,P59_JUSTIFICATIVA,P59_DT_COMUNICACAO,P59_DT_SIT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158386915904057275)
,p_name=>'Gerar Rel'
,p_event_sequence=>1351
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281158386853481057274)
,p_condition_element=>'P59_REPORT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158387071206057276)
,p_event_id=>wwv_flow_api.id(281158386915904057275)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30) := :p59_report;',
'  v_parametros varchar2(4000);',
'  V_OPCAO NUMBER;',
'  V_BASE VARCHAR2(100);',
'  v_ip varchar2(200);',
'  ',
'  cursor c1 is',
'  select i.cod_empresa, i.filial, i.cod_ccusto, p.dt_ref_folha',
'    from informacoes_funcionais i, parametros_recursos_humanos p',
'   where i.cod_empresa = p.cod_empresa',
'     and i.cod_empresa = :p59_cod_empresa',
'     and i.matricula = :p59_mat_solicitado;',
'     ',
'  v_c1 c1%rowtype;',
'  ',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'    ',
'V_BASE := :P_BASE;',
'',
'IF :P_BASE = ''LEADEC'' AND  V_REPORT NOT IN (''RP21589'',''RP21587'',''RP21588'') THEN ',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DATA_REF=''||V_C1.DT_REF_FOLHA||',
'''&P_DT_DEMISSAO_INI=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_DEMISSAO_FIM=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_DT_SIT_DESLIGAMENTO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_RETENCAO_INI=''||NULL||',
'''&P_DT_RETENCAO_FIM=''||NULL||',
'''&P_DT_PAGAMENTO=''||:P59_DT_PAGAMENTO||',
'''&P_HORARIO_EXAME=''||:P59_HORARIO_EXAME||',
'''&P_DT_DATA_EXAME=''||:P59_DT_EXAME||',
'''&P_HORARIO_RH=''||:P59_HORARIO_RH||',
'''&P_DT_DATA_RH=''||:P59_DT_RH||',
'''&P_LOCAL_EXAME=''||:P59_LOCAL_EXAME||',
'''&P_LOCAL_RH=''||:P59_LOCAL_RH||',
unistr('''&P_TIPO=''||''DEMISS\00C3O''||'),
'''&P_COD_MOT_DESLIG=''||:P59_COD_MOT_DESLIG||',
'''&P_COD_DESLIGAMENTO=''||:P59_COD_DESLIGAMENTO||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'ELSIF :P_BASE = ''LEADEC'' AND V_REPORT IN(''RP21589'',''RP21587'',''RP21588'') THEN ',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_MATRICULA=''||:P59_MAT_SOLICITADO||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'ELSIF :P_BASE = ''REDEFLEX'' AND V_REPORT IN(''RP21221_RD'',''RP21218_RD'',''RP21222_RD'',''RP21227_RD'') THEN ',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DT_EMISSAO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_LOCAL=''||NULL||',
'''&P_UF=''||NULL||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'ELSE',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DATA_REF=''||V_C1.DT_REF_FOLHA||',
'''&P_DT_DEMISSAO_INI=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_DEMISSAO_FIM=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_DT_SIT_DESLIGAMENTO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_RETENCAO_INI=''||NULL||',
'''&P_DT_RETENCAO_FIM=''||NULL||',
'''&P_DT_PAGAMENTO=''||:P59_DT_PAGAMENTO||',
'''&P_HORARIO_EXAME=''||:P59_HORARIO_EXAME||',
'''&P_DT_DATA_EXAME=''||:P59_DT_EXAME||',
'''&P_HORARIO_RH=''||:P59_HORARIO_RH||',
'''&P_DT_DATA_RH=''||:P59_DT_RH||',
'''&P_LOCAL_EXAME=''||:P59_LOCAL_EXAME||',
'''&P_LOCAL_RH=''||:P59_LOCAL_RH||',
unistr('''&P_TIPO=''||''DEMISS\00C3O''||'),
'''&P_COD_MOT_DESLIG=''||:P59_COD_MOT_DESLIG||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'END IF;',
'',
':P59_PARAMETROS := V_PARAMETROS;',
'',
':P59_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_DT_SIT_DESLIGAMENTO,P59_DT_COMUNICACAO,P_USUARIO,P59_DT_PAGAMENTO,P59_HORARIO_EXAME,P59_DT_EXAME,P59_HORARIO_RH,P59_DT_RH,P59_LOCAL_EXAME,P59_LOCAL_RH,P59_COD_MOT_DESLIG,P59_REPORT'
,p_attribute_03=>'P59_ENDERECO_REL,P59_PARAMETROS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269515782359952884982)
,p_event_id=>wwv_flow_api.id(281158386915904057275)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'&P59_REPORT.'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P59_PARAMETROS'
,p_attribute_06=>'Y'
,p_attribute_07=>'RETURN :P59_PARAMETROS;'
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158387411183057279)
,p_event_id=>wwv_flow_api.id(281158386915904057275)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P59_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(67667261303598718139)
,p_name=>'Gerar Rel Caterpillar'
,p_event_sequence=>1361
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(67667261098604718137)
,p_condition_element=>'P59_REPORT_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67667261357814718140)
,p_event_id=>wwv_flow_api.id(67667261303598718139)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30) := :p59_report_1;',
'  v_parametros varchar2(4000);',
'  V_OPCAO NUMBER;',
'  V_BASE VARCHAR2(100);',
'  v_ip varchar2(200);',
'  ',
'  cursor c1 is',
'  select i.cod_empresa, i.filial, i.cod_ccusto, p.dt_ref_folha',
'    from informacoes_funcionais i, parametros_recursos_humanos p',
'   where i.cod_empresa = p.cod_empresa',
'     and i.cod_empresa = :p59_cod_empresa',
'     and i.matricula = :p59_mat_solicitado;',
'     ',
'  v_c1 c1%rowtype;',
'  ',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'    ',
'V_BASE := :P_BASE;',
'',
'IF :P_BASE = ''LEADEC'' AND  V_REPORT NOT IN (''RP21589'',''RP21587'',''RP21588'') THEN ',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DATA_REF=''||V_C1.DT_REF_FOLHA||',
'''&P_DT_DEMISSAO_INI=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_DEMISSAO_FIM=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_DT_SIT_DESLIGAMENTO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_RETENCAO_INI=''||NULL||',
'''&P_DT_RETENCAO_FIM=''||NULL||',
'''&P_DT_PAGAMENTO=''||:P59_DT_PAGAMENTO||',
'''&P_HORARIO_EXAME=''||:P59_HORARIO_EXAME||',
'''&P_DT_DATA_EXAME=''||:P59_DT_EXAME||',
'''&P_HORARIO_RH=''||:P59_HORARIO_RH||',
'''&P_DT_DATA_RH=''||:P59_DT_RH||',
'''&P_LOCAL_EXAME=''||:P59_LOCAL_EXAME||',
'''&P_LOCAL_RH=''||:P59_LOCAL_RH||',
unistr('''&P_TIPO=''||''DEMISS\00C3O''||'),
'''&P_COD_MOT_DESLIG=''||:P59_COD_MOT_DESLIG||',
'''&P_COD_DESLIGAMENTO=''||:P59_COD_DESLIGAMENTO||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'ELSIF :P_BASE = ''LEADEC'' AND V_REPORT IN(''RP21589'',''RP21587'',''RP21588'') THEN ',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_MATRICULA=''||:P59_MAT_SOLICITADO||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'ELSE',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DATA_REF=''||V_C1.DT_REF_FOLHA||',
'''&P_DT_DEMISSAO_INI=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_DEMISSAO_FIM=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_DT_SIT_DESLIGAMENTO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_RETENCAO_INI=''||NULL||',
'''&P_DT_RETENCAO_FIM=''||NULL||',
'''&P_DT_PAGAMENTO=''||:P59_DT_PAGAMENTO||',
'''&P_HORARIO_EXAME=''||:P59_HORARIO_EXAME||',
'''&P_DT_DATA_EXAME=''||:P59_DT_EXAME||',
'''&P_HORARIO_RH=''||:P59_HORARIO_RH||',
'''&P_DT_DATA_RH=''||:P59_DT_RH||',
'''&P_LOCAL_EXAME=''||:P59_LOCAL_EXAME||',
'''&P_LOCAL_RH=''||:P59_LOCAL_RH||',
unistr('''&P_TIPO=''||''DEMISS\00C3O''||'),
'''&P_COD_MOT_DESLIG=''||:P59_COD_MOT_DESLIG||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
'END IF;',
'',
':P59_PARAMETROS := V_PARAMETROS;',
'',
':P59_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_DT_SIT_DESLIGAMENTO,P59_DT_COMUNICACAO,P_USUARIO,P59_DT_PAGAMENTO,P59_HORARIO_EXAME,P59_DT_EXAME,P59_HORARIO_RH,P59_DT_RH,P59_LOCAL_EXAME,P59_LOCAL_RH,P59_COD_MOT_DESLIG,P59_REPORT_1'
,p_attribute_03=>'P59_ENDERECO_REL,P59_PARAMETROS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67667261428610718141)
,p_event_id=>wwv_flow_api.id(67667261303598718139)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'&P59_REPORT_1.'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P59_PARAMETROS'
,p_attribute_06=>'Y'
,p_attribute_07=>'RETURN :P59_PARAMETROS;'
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67667261564793718142)
,p_event_id=>wwv_flow_api.id(67667261303598718139)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P59_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(86123361770146448237)
,p_name=>'Gerar Rel_1'
,p_event_sequence=>1371
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(86123361751513448236)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86123361862035448238)
,p_event_id=>wwv_flow_api.id(86123361770146448237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  V_REPORT VARCHAR2(30) := :p59_report;',
'  v_parametros varchar2(4000);',
'  V_OPCAO NUMBER;',
'  V_BASE VARCHAR2(100);',
'  v_ip varchar2(200);',
'  ',
'  cursor c1 is',
'  select i.cod_empresa, i.filial, i.cod_ccusto, p.dt_ref_folha',
'    from informacoes_funcionais i, parametros_recursos_humanos p',
'   where i.cod_empresa = p.cod_empresa',
'     and i.cod_empresa = :p59_cod_empresa',
'     and i.matricula = :p59_mat_solicitado;',
'     ',
'  v_c1 c1%rowtype;',
'  ',
'begin',
'IF :p59_sit_deslig = ''9A'' AND :p59_AVISO_PREVIO = ''I'' then',
':p59_report := ''RP21306_LD'';',
'V_REPORT := ''RP21306_LD'';',
'ELSIF :p59_sit_deslig = ''9A'' AND :p59_AVISO_PREVIO = ''T'' then',
':p59_report := ''RP21307_LD'';',
'V_REPORT := ''RP21307_LD'';',
'ELSE',
'RETURN;',
'END IF;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    begin',
'    select APEX_CAMINHO_REPORT',
'      into v_ip',
'      from configuracoes;',
'    exception',
'    when others then',
'    v_ip := null;',
'    end;',
'    ',
'V_BASE := :P_BASE;',
'',
'V_PARAMETROS := ''P_EMPRESA=''||:P59_COD_EMPRESA||',
'''&P_FILIAL_INI=''||V_C1.FILIAL||',
'''&P_FILIAL_FIM=''||V_C1.FILIAL||',
'''&P_CCUSTO_INI=''||V_C1.COD_CCUSTO||',
'''&P_CCUSTO_FIM=''||V_C1.COD_CCUSTO||',
'''&P_MATRICULA_INI=''||:P59_MAT_SOLICITADO||',
'''&P_MATRICULA_FIM=''||:P59_MAT_SOLICITADO||',
'''&P_DATA_REF=''||V_C1.DT_REF_FOLHA||',
'''&P_DT_DEMISSAO_INI=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_DEMISSAO_FIM=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_COMUNICACAO=''||:P59_DT_COMUNICACAO||',
'''&P_DT_SIT_DESLIGAMENTO=''||:P59_DT_SIT_DESLIGAMENTO||',
'''&P_DT_RETENCAO_INI=''||NULL||',
'''&P_DT_RETENCAO_FIM=''||NULL||',
'''&P_DT_PAGAMENTO=''||:P59_DT_PAGAMENTO||',
'''&P_HORARIO_EXAME=''||:P59_HORARIO_EXAME||',
'''&P_DT_DATA_EXAME=''||:P59_DT_EXAME||',
'''&P_HORARIO_RH=''||:P59_HORARIO_RH||',
'''&P_DT_DATA_RH=''||:P59_DT_RH||',
'''&P_LOCAL_EXAME=''||:P59_LOCAL_EXAME||',
'''&P_LOCAL_RH=''||:P59_LOCAL_RH||',
unistr('''&P_TIPO=''||''DEMISS\00C3O''||'),
'''&P_COD_MOT_DESLIG=''||:P59_COD_MOT_DESLIG||',
'''&P_USUARIO=''||:P_USUARIO;',
'',
':P59_PARAMETROS := V_PARAMETROS;',
'',
':P59_ENDERECO_REL :=  v_ip||''reports/rwservlet?''||v_report||''_''||''RH''||V_BASE||V_PARAMETROS;',
'',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_DT_SIT_DESLIGAMENTO,P59_DT_COMUNICACAO,P_USUARIO,P59_DT_PAGAMENTO,P59_HORARIO_EXAME,P59_DT_EXAME,P59_HORARIO_RH,P59_DT_RH,P59_LOCAL_EXAME,P59_LOCAL_RH,P59_COD_MOT_DESLIG,P59_REPORT,P59_SIT_DESLIG,P59_AVISO_PREVI'
||'O'
,p_attribute_03=>'P59_ENDERECO_REL,P59_PARAMETROS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86123361973827448239)
,p_event_id=>wwv_flow_api.id(86123361770146448237)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'&P59_REPORT.'
,p_attribute_02=>'RELATORIO'
,p_attribute_03=>'inline'
,p_attribute_05=>'P59_PARAMETROS'
,p_attribute_06=>'Y'
,p_attribute_07=>'RETURN :P59_PARAMETROS;'
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_attribute_10=>'cache'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(86123362149863448240)
,p_event_id=>wwv_flow_api.id(86123361770146448237)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'//javascript:void(window.open($v(''P59_ENDERECO_REL'')))'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158387970442057285)
,p_name=>'Hide / Show Parametros RP21221,RP21222,RP21226'
,p_event_sequence=>1381
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_REPORT'
,p_condition_element=>'P59_REPORT'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'RP21221,RP21222,RP21226'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158388046332057286)
,p_event_id=>wwv_flow_api.id(281158387970442057285)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_RH,P59_HORARIO_RH,P59_DT_EXAME,P59_HORARIO_EXAME,P59_LOCAL_EXAME,P59_LOCAL_RH'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158512247771820184)
,p_event_id=>wwv_flow_api.id(281158387970442057285)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_RH,P59_HORARIO_RH,P59_DT_EXAME,P59_HORARIO_EXAME,P59_LOCAL_EXAME,P59_LOCAL_RH'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158512930397820191)
,p_name=>'Hide / Show Parametros RP21217'
,p_event_sequence=>1391
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_REPORT'
,p_condition_element=>'P59_REPORT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'RP21217'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158513094645820192)
,p_event_id=>wwv_flow_api.id(281158512930397820191)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_RH,P59_HORARIO_RH,P59_DT_PAGAMENTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158513280391820194)
,p_event_id=>wwv_flow_api.id(281158512930397820191)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_RH,P59_HORARIO_RH,P59_DT_PAGAMENTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(276310910172465207997)
,p_name=>'Hide / Show Parametros'
,p_event_sequence=>1401
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281158389451397057300)
,p_condition_element=>'P59_REPORT'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'RP21217'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(276310910338061207999)
,p_event_id=>wwv_flow_api.id(276310910172465207997)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_DT_RH,P59_HORARIO_RH,P59_DT_PAGAMENTO,P59_DT_EXAME,P59_LOCAL_EXAME,P59_LOCAL_RH'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158390688092057312)
,p_name=>'Mascara DT_SIT_DESLIGAMENTO'
,p_event_sequence=>1411
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_SIT_DESLIGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158390757069057313)
,p_event_id=>wwv_flow_api.id(281158390688092057312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P59_DT_SIT_DESLIGAMENTO,''/'');',
'',
'begin',
'',
':P59_DT_SIT_DESLIGAMENTO := v_dt;',
'',
'exception',
'when others then',
':P59_DT_SIT_DESLIGAMENTO := null;',
'',
'end;'))
,p_attribute_02=>'P59_DT_SIT_DESLIGAMENTO'
,p_attribute_03=>'P59_DT_SIT_DESLIGAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158391106676057316)
,p_name=>'Mascara DT_PAGAMENTO'
,p_event_sequence=>1421
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_PAGAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158391185381057317)
,p_event_id=>wwv_flow_api.id(281158391106676057316)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P59_DT_PAGAMENTO,''/'');',
'',
'begin',
'',
':P59_DT_PAGAMENTO := v_dt;',
'',
'exception',
'when others then',
':P59_DT_PAGAMENTO := null;',
'',
'end;'))
,p_attribute_02=>'P59_DT_PAGAMENTO'
,p_attribute_03=>'P59_DT_PAGAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158391263730057318)
,p_name=>'Mascara DT_EXAME'
,p_event_sequence=>1431
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_EXAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158391384692057319)
,p_event_id=>wwv_flow_api.id(281158391263730057318)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P59_DT_EXAME,''/'');',
'',
'begin',
'',
':P59_DT_EXAME := v_dt;',
'',
'exception',
'when others then',
':P59_DT_EXAME := null;',
'',
'end;'))
,p_attribute_02=>'P59_DT_EXAME'
,p_attribute_03=>'P59_DT_EXAME'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158510895867820170)
,p_name=>'Mascara DT_RH'
,p_event_sequence=>1441
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_RH'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158510983881820171)
,p_event_id=>wwv_flow_api.id(281158510895867820170)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P59_DT_RH,''/'');',
'',
'begin',
'',
':P59_DT_RH := v_dt;',
'',
'exception',
'when others then',
':P59_DT_RH := null;',
'',
'end;'))
,p_attribute_02=>'P59_DT_RH'
,p_attribute_03=>'P59_DT_RH'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158511085634820172)
,p_name=>'Mascara HORARIO_EXAME'
,p_event_sequence=>1451
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_HORARIO_EXAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158511150298820173)
,p_event_id=>wwv_flow_api.id(281158511085634820172)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_hora varchar2(5) := replace(:P59_HORARIO_EXAME,'':'');',
'',
'begin',
'',
'v_hora := substr(v_hora,1,2)||'':''||substr(v_hora,3,2);',
'',
':P59_HORARIO_EXAME := v_hora;',
'',
'end;'))
,p_attribute_02=>'P59_HORARIO_EXAME'
,p_attribute_03=>'P59_HORARIO_EXAME'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158511265122820174)
,p_name=>'Mascara HORARIO_RH'
,p_event_sequence=>1461
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_HORARIO_RH'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158511369303820175)
,p_event_id=>wwv_flow_api.id(281158511265122820174)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_hora varchar2(5) := replace(:P59_HORARIO_RH,'':'');',
'',
'begin',
'',
'v_hora := substr(v_hora,1,2)||'':''||substr(v_hora,3,2);',
'',
':P59_HORARIO_RH := v_hora;',
'',
'end;'))
,p_attribute_02=>'P59_HORARIO_RH'
,p_attribute_03=>'P59_HORARIO_RH'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158390833926057314)
,p_name=>'Mascara DT_COMUNICACAO'
,p_event_sequence=>1471
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DT_COMUNICACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158390985984057315)
,p_event_id=>wwv_flow_api.id(281158390833926057314)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_dt date := replace(:P59_DT_COMUNICACAO,''/'');',
'',
'begin',
'',
':P59_DT_COMUNICACAO := v_dt;',
'',
'exception',
'when others then',
':P59_DT_COMUNICACAO := null;',
'',
'end;'))
,p_attribute_02=>'P59_DT_COMUNICACAO'
,p_attribute_03=>'P59_DT_COMUNICACAO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158515762321820219)
,p_name=>'Show TP_AV_PREVIO'
,p_event_sequence=>1481
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_SIT_DESLIG,P59_AVISO_PREVIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P59_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158792776972706770)
,p_event_id=>wwv_flow_api.id(281158515762321820219)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P59_SIT_DESLIG'').value == "91" && $x(''P59_AVISO_PREVIO'').value == "T") {',
'    $(''#P59_TP_AV_PREVIO'').show();',
'    $(''#P59_TP_AV_PREVIO_LABEL'').show();',
'    $(''#P59_INDCUMPRPARC'').show();',
'    $(''#P59_INDCUMPRPARC_LABEL'').show();',
'} else {',
'    $(''#P59_TP_AV_PREVIO'').hide();',
'    $(''#P59_TP_AV_PREVIO_LABEL'').hide();',
'    $(''#P59_INDCUMPRPARC'').hide();',
'    $(''#P59_INDCUMPRPARC_LABEL'').hide();',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281158793236742706775)
,p_name=>'Valida cod_mot_deslig'
,p_event_sequence=>1491
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_MOT_DESLIG'
,p_condition_element=>'P59_COD_MOT_DESLIG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(281158793376104706776)
,p_event_id=>wwv_flow_api.id(281158793236742706775)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_item_validacao varchar2(400) := :P59_ITEM_VALIDACAO;',
'',
'v_data date := :p59_dt_comunicacao;',
'',
'v_flg_retorno varchar2(1);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_deslig.Valida_Mot_Deslig(:P59_COD_EMPRESA,',
'                             :P59_MAT_SOLICITADO,',
'                             v_data,',
'                             :p59_sit_deslig,',
'                             :p59_cod_mot_deslig,',
'                              v_flg_retorno,',
'                              v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :P59_ITEM_VALIDACAO := TRIM(UPPER(''p59_cod_mot_deslig''));',
'    :P59_ok       := ''N'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
' else',
'    ',
'    if v_msg_retorno is null then',
'    :P59_flag     := null;',
'    :P59_mensagem := null;',
'    else',
'    :P59_ok       := ''S'';',
'    :P59_flag     := v_flg_retorno;',
'    :P59_mensagem := v_msg_retorno;',
'    end if;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''p59_cod_mot_deslig'')) OR v_item_validacao IS NULL then',
'       :P59_OK := ''S'';',
'       :P59_ITEM_VALIDACAO := null;',
'    else',
'       :P59_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P59_ITEM_VALIDACAO,P59_DT_COMUNICACAO,P59_COD_EMPRESA,P59_MAT_SOLICITADO,P59_SIT_DESLIG,P59_COD_MOT_DESLIG'
,p_attribute_03=>'P59_ITEM_VALIDACAO,P59_OK,P59_FLAG,P59_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(281066032517804683343)
,p_name=>unistr('Show/Hide Aprova\00E7\00F5es')
,p_event_sequence=>1501
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_condition_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P59_ROWID'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280869016036229738602)
,p_name=>'Desabilita Dt_Sit_Deslig JS'
,p_event_sequence=>1511
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_DES_DT_SIT_DESLIG'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280869016124417738603)
,p_event_id=>wwv_flow_api.id(280869016036229738602)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P59_DES_DT_SIT_DESLIG'').value == ''S'') {',
'//$x(''P59_DT_SIT_DESLIGAMENTO'').disabled = true;',
'  apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable();',
'}else{',
'//$x(''P59_DT_SIT_DESLIGAMENTO'').disabled = false;',
'  apex.item( "P59_DT_SIT_DESLIGAMENTO" ).enable();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(280612096258921543103)
,p_name=>'altera dt_arquivo'
,p_event_sequence=>1521
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_ARQUIVO'
,p_condition_element=>'P59_ARQUIVO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295226200960866196)
,p_event_id=>wwv_flow_api.id(280612096258921543103)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P59_CARTA_ANEXADA := ''N'';'
,p_attribute_03=>'P59_CARTA_ANEXADA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(280612096371693543104)
,p_event_id=>wwv_flow_api.id(280612096258921543103)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p59_dt_arquivo := sysdate;',
':P59_CARTA_ANEXADA := ''S'';'))
,p_attribute_03=>'P59_DT_ARQUIVO,P59_CARTA_ANEXADA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271251882257822705931)
,p_name=>'Valida Ponto'
,p_event_sequence=>1531
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MAT_SOLICITADO'
,p_condition_element=>'P59_MAT_SOLICITADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P_BASE = ''STEFANINI'' and :P59_ROWID IS NULL then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269966174492121037635)
,p_event_id=>wwv_flow_api.id(271251882257822705931)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P59_MAT_SOLICITADO" ).getValue().length >= 1 && apex.item( "P59_SIT_DESLIG" ).getValue().length == 0){',
unistr('    alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('    alertify.confirm(''\00C9 necess\00E1rio realizar o fechamento do ponto para o cadastro desta requisi\00E7\00E3o. Foi realizado o fechamento do ponto?'', function (e) {'),
'        if (e) {',
'            apex.item( "P59_VALIDA_PONTO" ).setValue( "S" );',
'        } else {',
'            apex.item( "P59_VALIDA_PONTO" ).setValue( "N" );',
'        }',
'    });',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940533883820165746)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1541
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940533632747165744)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940533993698165747)
,p_event_id=>wwv_flow_api.id(269940533883820165746)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REPROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940534086431165748)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1551
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940533793952165745)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940534149449165749)
,p_event_id=>wwv_flow_api.id(269940534086431165748)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269943974226572622053)
,p_name=>'Habilita/Desabilita Campos'
,p_event_sequence=>1561
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269943974399971622054)
,p_event_id=>wwv_flow_api.id(269943974226572622053)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''2'' || ',
'    apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''3'' || ',
'    apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''4'')',
'{',
'  ',
'apex.item( "P59_COD_SIT_DESLIGAMENTO" ).disable() ;',
'apex.item( "P59_COD_EMPRESA" ).disable() ;',
'apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'apex.item( "P59_COD_FILIAL" ).disable() ;',
'apex.item( "P59_COD_CCUSTO" ).disable() ;',
'apex.item( "P59_SIT_DESLIG" ).disable() ;',
'$(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'$(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'apex.item( "P59_HAVERA_REP" ).disable() ;',
'apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'apex.item( "P59_OBS" ).disable() ;',
'}',
'',
'if (apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''5'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''FOLHA TOPAZ'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''RESCISAO'' && apex.item("P59_PERFIL_USUARIO_LOGADO").getVa'
||'lue() !== ''MASTER'')',
'{',
'  ',
'apex.item( "P59_COD_EMPRESA" ).disable() ;',
'apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'apex.item( "P59_COD_FILIAL" ).disable() ;',
'apex.item( "P59_COD_CCUSTO" ).disable() ;',
'apex.item( "P59_SIT_DESLIG" ).disable() ;',
'$(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'$(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'apex.item( "P59_HAVERA_REP" ).disable() ;',
'apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'apex.item( "P59_DT_COMUNICACAO" ).disable();  ',
'',
'    if (apex.item( "P59_SIT_DESLIG" ).getValue() == ''93'' && ',
'        apex.item( "P59_COD_EMPRESA_SOLICITANTE" ).getValue() == apex.item( "P_EMPRESA_USUARIO" ).getValue() &&',
'        apex.item( "P59_COD_MAT_SOLICITANTE" ).getValue() == apex.item( "P_MATRICULA_USUARIO" ).getValue()){',
'        apex.item( "P59_DT_SIT_DESLIGAMENTO" ).enable() ;',
'    }else{',
'        apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ; ',
'    }',
'',
'apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'apex.item( "P59_OBS" ).disable() ;',
'}',
'',
'',
'',
'if  ((apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''1'' || apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''5'')',
'      && ',
'      (apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''FOLHA TOPAZ'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''RESCISAO'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''MASTER''))',
'{',
'apex.item( "P59_COD_EMPRESA" ).disable() ;',
'apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'apex.item( "P59_COD_FILIAL" ).disable() ;',
'apex.item( "P59_COD_CCUSTO" ).disable() ;',
'apex.item( "P59_SIT_DESLIG" ).disable() ;',
'$(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'$(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'apex.item( "P59_HAVERA_REP" ).disable() ;',
'apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'apex.item( "P59_DT_COMUNICACAO" ).enable() ;',
'apex.item( "P59_DT_SIT_DESLIGAMENTO" ).enable() ;',
'apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'apex.item( "P59_OBS" ).enable() ;',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269953991048986647169)
,p_event_id=>wwv_flow_api.id(269943974226572622053)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() == ''6'')',
'{',
'apex.item( "P59_COD_SIT_DESLIGAMENTO" ).enable() ;',
'apex.item( "P59_COD_EMPRESA" ).disable() ;',
'apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'apex.item( "P59_COD_FILIAL" ).disable() ;',
'apex.item( "P59_COD_CCUSTO" ).disable() ;',
'apex.item( "P59_SIT_DESLIG" ).disable() ;',
'$(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'$(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'apex.item( "P59_HAVERA_REP" ).disable() ;',
'apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'apex.item( "P59_OBS" ).disable() ;',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148144534645753162014)
,p_event_id=>wwv_flow_api.id(269943974226572622053)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'             if ((apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''FOLHA TOPAZ'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''RESCISAO'' || apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() == ''MASTER'') && ',
'                 apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() != ''5'' && ',
'                 apex.item( "P59_COD_SIT_DESLIGAMENTO" ).getValue() != ''1'' && ',
'                 apex.item( "P59_ROWID" ).getValue().length > 0){',
'                 ',
'                    apex.item( "P59_COD_EMPRESA" ).disable() ;',
'                    apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'                    apex.item( "P59_COD_FILIAL" ).disable() ;',
'                    apex.item( "P59_COD_CCUSTO" ).disable() ;',
'                    apex.item( "P59_SIT_DESLIG" ).disable() ;',
'                    $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'                    $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'                    apex.item( "P59_HAVERA_REP" ).disable() ;',
'                    apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'                    apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'                    apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'                    apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'                    apex.item( "P59_OBS" ).enable() ;',
'                 ',
'             }else if(apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''FOLHA TOPAZ'' && apex.item( "P59_PERFIL_USUARIO_LOGADO" ).getValue() != ''RESCISAO'' && apex.item("P59_PERFIL_USUARIO_LOGADO").getValue() !== ''MASTER'' && ',
'                 apex.item( "P59_ROWID" ).getValue().length > 0){',
'                 ',
'                    apex.item( "P59_COD_EMPRESA" ).disable() ;',
'                    apex.item( "P59_MAT_SOLICITADO" ).disable() ;',
'                    apex.item( "P59_COD_FILIAL" ).disable() ;',
'                    apex.item( "P59_COD_CCUSTO" ).disable() ;',
'                    apex.item( "P59_SIT_DESLIG" ).disable() ;',
'                    $(''#P59_SIT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_COD_MOT_DESLIG" ).disable() ;',
'                    $(''#P59_COD_MOT_DESLIG_holder'').addClass(''apex_disabled'').attr(''tabindex'',''-1'') ;',
'                    apex.item( "P59_AVISO_PREVIO" ).disable() ;',
'                    apex.item( "P59_HAVERA_REP" ).disable() ;',
'                    apex.item( "P59_IND_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_RESTRICAO_REALOCACAO" ).disable() ;',
'                    apex.item( "P59_JUSTIFICATIVA" ).disable() ;',
'                    apex.item( "P59_DT_COMUNICACAO" ).disable() ;',
'                    apex.item( "P59_DT_SIT_DESLIGAMENTO" ).disable() ;',
'                    apex.item( "P59_TP_AV_PREVIO" ).disable() ;',
'                    apex.item( "P59_INDCUMPRPARC" ).disable() ;',
'                    apex.item( "P59_OBS" ).disable() ;',
'                 ',
'             }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270295225648175866191)
,p_name=>'(Show/Hide) Carta Anexada'
,p_event_sequence=>1571
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_CARTA_ANEXADA'
,p_condition_element=>'P59_CARTA_ANEXADA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295225833877866192)
,p_event_id=>wwv_flow_api.id(270295225648175866191)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270295225063331866185)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295226035890866195)
,p_event_id=>wwv_flow_api.id(270295225648175866191)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270295225183315866186)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295225914940866193)
,p_event_id=>wwv_flow_api.id(270295225648175866191)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270295225063331866185)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270295225960746866194)
,p_event_id=>wwv_flow_api.id(270295225648175866191)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270295225183315866186)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(258660215874572155403)
,p_name=>'Inicia Alerta Anexo de Carta ocultada '
,p_event_sequence=>1581
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_ROWID'
,p_condition_element=>'P59_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258660215925728155404)
,p_event_id=>wwv_flow_api.id(258660215874572155403)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(258625272315063152834)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108275417318735333698)
,p_name=>'Seta CONSIDERA_PDV'
,p_event_sequence=>1591
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_COD_FILIAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108275417403403333699)
,p_event_id=>wwv_flow_api.id(108275417318735333698)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_considera_pdv varchar2(1) := ''N'';',
'begin',
'IF :P59_COD_EMPRESA IS NOT NULL AND :P59_COD_FILIAL IS NOT NULL THEN',
'select considera_pdv',
'into v_considera_pdv',
'from sindicatos s, filiais f',
'where f.cod_empresa = :p59_cod_empresa',
'and f.cod_filial = :p59_cod_filial',
'and s.cod_empresa = f.cod_empresa',
'and s.cod = f.cod_sindicato;',
'END IF;',
':P59_CONSIDERA_PDV := v_considera_pdv;',
'exception',
'when others then',
':P59_CONSIDERA_PDV := ''N'';',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_COD_FILIAL'
,p_attribute_03=>'P59_CONSIDERA_PDV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108275417955422333704)
,p_name=>'Seta CONSIDERA_PDV2'
,p_event_sequence=>1601
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_MAT_SOLICITADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108275418005697333705)
,p_event_id=>wwv_flow_api.id(108275417955422333704)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_considera_pdv varchar2(1) := ''N'';',
'begin',
'IF :P59_COD_EMPRESA IS NOT NULL AND :P59_MAT_SOLICITADO IS NOT NULL THEN',
'select considera_pdv',
'into v_considera_pdv',
'from sindicatos s, informacoes_funcionais i',
'where i.cod_empresa = :p59_cod_empresa',
'and i.matricula = :p59_mat_solicitado',
'and s.cod_empresa = i.cod_empresa',
'and s.cod = nvl(i.num_sind_cat, i.num_sind_diss);',
'END IF;',
':P59_CONSIDERA_PDV := v_considera_pdv;',
'exception',
'when others then',
':P59_CONSIDERA_PDV := ''N'';',
'end;'))
,p_attribute_02=>'P59_COD_EMPRESA,P59_MAT_SOLICITADO'
,p_attribute_03=>'P59_CONSIDERA_PDV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108275417605702333701)
,p_name=>'Show/Hide INDPDV'
,p_event_sequence=>1611
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P59_CONSIDERA_PDV'
,p_condition_element=>'P59_CONSIDERA_PDV'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108275417761468333702)
,p_event_id=>wwv_flow_api.id(108275417605702333701)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_INDPDV'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108275417820813333703)
,p_event_id=>wwv_flow_api.id(108275417605702333701)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_INDPDV'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(107396372348854991614)
,p_name=>'SET SOLICITANTE AUX'
,p_event_sequence=>1621
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(107396372447541991615)
,p_event_id=>wwv_flow_api.id(107396372348854991614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P59_MAT_SOLICITANTE_AUX := :P_MATRICULA_USER;'
,p_attribute_02=>'P_MATRICULA_USER'
,p_attribute_03=>'P59_MAT_SOLICITANTE_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(107396372456751991616)
,p_name=>'SET EMPRESA SOLICITANTE AUX_1'
,p_event_sequence=>1631
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(107396372585478991617)
,p_event_id=>wwv_flow_api.id(107396372456751991616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P59_COD_EMPRESA_SOLICITANTE_AUX := :P_EMPRESA_USER;'
,p_attribute_02=>'P_EMPRESA_USER'
,p_attribute_03=>'P59_COD_EMPRESA_SOLICITANTE_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68722417817426744635)
,p_name=>'Esconde Caterpillar'
,p_event_sequence=>1641
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P_BASE'
,p_display_when_cond2=>'LEADEC'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68722417921942744636)
,p_event_id=>wwv_flow_api.id(68722417817426744635)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P59_REPORT_1,P59_TEXTO_CARTA_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67667261161073718138)
,p_event_id=>wwv_flow_api.id(68722417817426744635)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(67667261098604718137)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13462450473527365066)
,p_name=>'valida situacao'
,p_event_sequence=>1651
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(281226171035471371757)
,p_condition_element=>'P59_COD_SIT_DESLIGAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13462450492623365067)
,p_event_id=>wwv_flow_api.id(13462450473527365066)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281226171035471371757)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13462450672439365068)
,p_event_id=>wwv_flow_api.id(13462450473527365066)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(281226171035471371757)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362973283195680829)
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
'  where cod_empresa = :p59_COD_EMPRESA_SOLICITANTE',
'    and matricula   = :p59_MAT_SOLICITANTE;',
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
'    :p59_solicitante := v_c1.colaborador;',
' end if;',
' ',
'if :p59_rowid is null and :p59_havera_rep is null then',
':p59_havera_rep := ''S'';  ',
'end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362973616564680829)
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
'  where cod_sit_req = :p59_cod_sit_Desligamento;',
'  ',
'  v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p59_rowid is not null then',
unistr('   :p59_titulo := ''Requisi\00E7\00E3o de Desligamento: N\00BA ''||:p59_cod_desligamento||'' - ''||:p59_dt_desligamento||'' (''||v_c1.sit||'')'';'),
'else',
unistr('   :p59_titulo := ''Requisi\00E7\00E3o de Desligamento'';'),
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362974867266680830)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'',
'cursor c1 is',
'select i.filial,',
'       i.cod_ccusto,',
'       i.cargo',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p59_cod_filial is null or :p59_cod_ccusto is null then',
':p59_cod_filial := v_c1.filial;',
':p59_cod_ccusto := v_c1.cod_ccusto;',
':p59_cod_cargo  := v_c1.cargo;',
'end if;',
'',
'    BEGIN',
'  	SELECT seq_requisicao.NEXTVAL INTO v_seq FROM dual;',
'    END;',
'        ',
'    :p59_cod_DESLIGAMENTO := v_seq;',
'',
'    :p59_cod_SIT_DESLIGAMENTO := 1;',
'',
'  :p59_usuario         := :p_usuario;',
'  :p59_dt_atualizacao  := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');',
'  ',
'  :p59_RESCISAO_COMPLEMENTAR      := nvl(:p59_RESCISAO_COMPLEMENTAR, ''N'');',
'  ',
' ',
'    :p59_DT_DESLIGAMENTO  := SYSDATE;',
'',
'    :p59_cod_empRESA_SOLICITANTE := NVL(:P_EMPRESA_USER,:P59_COD_EMPRESA_SOLICITANTE_AUX);',
'    :p59_mat_SOLICITANTE     := NVL(:P_MATRICULA_USER,:P59_MAT_SOLICITANTE_AUX);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281362953841738680809)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362975207382680830)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  :p59_usuario := :p_usuario;',
'  :p59_dt_atualizacao := TO_CHAR(sysdate,''DD/MM/RRRR HH24:MI:SS'');'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281362953483545680809)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362972846031680829)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of DESLIGAMENTO'
,p_attribute_02=>'DESLIGAMENTO'
,p_attribute_03=>'P59_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Efetuada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362974058438680829)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cancela_Req'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_msg_retorno varchar2(4000);',
'v_flg_retorno varchar2(1);',
'',
'begin',
'',
' pkg_deslig.cancela_req(:p59_cod_empresa, :p59_mat_solicitado, :p59_cod_desligamento, :p59_dt_desligamento, :p59_cod_sit_desligamento, :p_usuario,v_flg_retorno,v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p59_flag := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
'    :p59_ok := ''N'';',
'    ',
' else ',
'    :p59_ok := ''S'';',
' end if; ',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281362953483545680809)
,p_process_when=>'P59_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362975612658680830)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Altera_Sit_Deslig'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' :p59_mensagem := null;',
'',
' pkg_deslig.Altera_Sit_Deslig(:p59_cod_empresa, :p59_cod_desligamento, :P59_COD_SIT_DESLIGAMENTO, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p59_ok       := ''N'';',
'    :p59_flag     := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
' else',
'    :p59_flag     := null;',
'    :p59_mensagem := null;',
'    :p59_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281362953483545680809)
,p_process_when=>'P59_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362974456391680830)
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
' :p59_mensagem := null;',
'',
' pkg_deslig.post_insert(:p59_cod_empresa, :p59_cod_desligamento, :p_usuario, v_flg_retorno, v_msg_retorno, :p59_mat_solicitado, :p59_dt_sit_desligamento, :p59_sit_deslig);',
' ',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'    :p59_ok       := ''N'';',
'    :p59_flag     := v_flg_retorno;',
'    :p59_mensagem := v_msg_retorno;',
'    raise_application_error(-20001,v_msg_retorno);',
' else',
'    :p59_flag     := null;',
'    :p59_mensagem := null;',
'    :p59_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(281362953841738680809)
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281212494133255140785)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'upload_carta_deslig'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select upload_carta_deslig',
'  from configuracoes;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':P59_upload_carta_deslig := V_C1.upload_carta_deslig;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362972075249680828)
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
'if :p59_OK is null then',
':p59_OK := ''S'';',
':p59_mensagem := null;',
':p59_flag := null;',
'end if;',
'',
'if :p59_rowid is null and :p59_havera_rep is null then',
':p59_havera_rep := ''S'';  ',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362972412882680828)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'DESLIGAMENTO'
,p_attribute_03=>'P59_COD_EMPRESA'
,p_attribute_04=>'COD_EMPRESA'
,p_attribute_05=>'P59_COD_DESLIGAMENTO'
,p_attribute_06=>'COD_DESLIGAMENTO'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P59_COD_DESLIGAMENTO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362976078816680831)
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
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       i.filial,',
'       i.cod_ccusto,',
'       i.cargo,',
'       i.IND_CONTRATO_PRZ_DETERMINADO,',
'       i.vinculo,',
'       decode(:P59_IND_CONTR_PRZ_DETERM/*i.IND_CONTRATO_PRZ_DETERMINADO*/,''D'',''Determinado'',''I'',''Indeterminado'') ind_contrato,',
'       i.data_contrato_prz_determinado dt_contrato,',
'       i.prorrog_contrato_prz_determ dt_prorrog',
'       ',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'                   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
unistr('select decode(i.ind_def_fis,''S'',''Sim'',''N\00E3o'') IND_DEF_FIS'),
'from   inf_pessoais_cad i',
'where  i.cod_empresa = :p59_cod_empresa',
'   and i.matricula = :p59_mat_solicitado;',
'   ',
'v_c2 c2%rowtype;',
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
'if :p59_cod_desligamento is null then',
':p59_cod_filial := v_c1.filial;',
':p59_cod_ccusto := v_c1.cod_ccusto;',
':p59_cod_cargo  := v_c1.cargo;',
'end if;',
'',
'if :p59_rowid is null and :p59_havera_rep is null then',
':p59_havera_rep := ''S'';  ',
'end if;',
'',
':p59_cod_empresa_DISPLAY := v_c1.empresa;',
':p59_matricula_DISPLAY := v_c1.matricula;',
':p59_situacao_colab := v_c1.situacao;',
':p59_dt_admissao := v_c1.dt_admissao;',
':p59_tipo_contrato := :P59_IND_CONTR_PRZ_DETERM;--v_c1.IND_CONTRATO_PRZ_DETERMINADO;',
':p59_ind_contrato  := v_c1.IND_CONTRATO;',
':p59_vinculo := v_c1.vinculo;',
':p59_dt_contrato  := :P59_DATA_CONTR_PRZ_DETERM;--v_c1.dt_contrato;',
':p59_dt_prorrog  := :P59_PRORROG_CONTR_PRZ_DETERM;--v_c1.dt_prorrog;',
'',
':P59_IND_CONTR_PRZ_DETERM := v_c1.IND_CONTRATO_PRZ_DETERMINADO;',
':P59_IND_DEF_FIS := V_C2.IND_DEF_FIS;',
':P59_DATA_CONTR_PRZ_DETERM := v_c1.dt_contrato;',
':P59_PRORROG_CONTR_PRZ_DETERM := v_c1.dt_prorrog;',
'',
':P59_MENSAGEM := '' '';',
'',
'exception',
'when others then',
':p59_cod_empresa_DISPLAY := :p59_cod_empresa;',
':p59_matricula_DISPLAY := :p59_mat_solicitado;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(281362976427138680831)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Vaga'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cad_vaga, filial, cod_empresa',
'  from informacoes_funcionais',
' where cod_empresa = :p59_cod_empresa',
'   and matricula = :p59_mat_solicitado;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'  select tipo_salario, valor_verba',
'  into   :p59_tipo_salario, :p59_valor_verba',
'  from   cl_vaga',
'  where  cod_vaga = v_c1.cad_vaga',
'  and    cod_filial = v_c1.filial',
'  and    cod_empresa = v_c1.cod_empresa;',
'  ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p59_vaga := v_c1.cad_vaga;',
'',
'if v_c1.cad_vaga is not null then',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'  ',
'  :p59_tipo_salario := v_c2.tipo_salario;',
'  :p59_valor_verba := v_c2.valor_verba;',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(270295225594749866190)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida Carta Anexa'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select nome_arquivo, dbms_lob.getlength(arquivo) filesize',
'  from desligamento',
' where cod_desligamento = :p59_cod_desligamento;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :P59_UPLOAD_CARTA_DESLIG = ''S'' AND nvl(v_c1.filesize,0) = 0 then',
'   :P59_CARTA_ANEXADA := ''N'';',
'elsif :P59_UPLOAD_CARTA_DESLIG = ''S'' AND nvl(v_c1.filesize,0) > 0 then',
'   :P59_CARTA_ANEXADA := ''S'';',
'end if;',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(85263024234570947225)
,p_process_sequence=>70
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula COD_SIT_AUX'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'SELECT COD_SIT_DESLIGAMENTO',
'INTO :P59_COD_SIT_AUX',
'FROM DESLIGAMENTO ',
'WHERE COD_DESLIGAMENTO = :P59_COD_DESLIGAMENTO;',
'EXCEPTION ',
'WHEN NO_DATA_FOUND THEN NULL;',
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
