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
,p_default_application_id=>2943
,p_default_id_offset=>752138242173481645
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2943 - Segurança do Trabalho - Controles
--
-- Application Export:
--   Application:     2943
--   Name:            Segurança do Trabalho - Controles
--   Date and Time:   23:09 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 91
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00091
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>91);
end;
/
prompt --application/pages/page_00091
begin
wwv_flow_api.create_page(
 p_id=>91
,p_user_interface_id=>wwv_flow_api.id(136094936036627083393)
,p_name=>unistr('Criar/Editar: Comunica\00E7\00E3o de Acidente/Incidente')
,p_step_title=>unistr('Criar/Editar: Comunica\00E7\00E3o de Acidente/Incidente')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#APP_IMAGES#jquery.maskedinput.min.js',
'#APP_IMAGES#forms-functions.js',
'#APP_IMAGES#cards.js'))
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(function() {',
'        $.mask.definitions[''~''] = "[+-]";                       ',
'',
'        $("#P91_CEP_DSP").attr("type", "tel");',
'  ',
'        $("#P91_TELEFONE_FUNC_1_DSP").attr("type", "tel");',
'  ',
'        $("#P91_CEP_DSP").mask(''99999-999'', {reverse: true});',
'  ',
'        $("#P91_TELEFONE_FUNC_1_DSP").mask("(99) 99999-999?9");  ',
'    ',
'  });',
'',
'document.querySelectorAll(''.no-space'').forEach(function(el) {',
unistr('  // Bloqueia letras e espa\00E7os ao digitar'),
'  el.addEventListener(''keydown'', function(e) {',
'    const allowedKeys = [',
'      ''Backspace'', ''Delete'', ''ArrowLeft'', ''ArrowRight'', ''Tab'',',
'      ''Home'', ''End'', ''Enter''',
'    ];',
'',
'    // Permitir teclas de controle',
'    if (allowedKeys.includes(e.key)) return;',
'',
unistr('    // Permitir apenas n\00FAmeros (e ponto ou v\00EDrgula, se quiser)'),
'    if (!e.key.match(/[0-9:]/)) {',
'      e.preventDefault();',
'    }',
'',
unistr('    // Bloqueia espa\00E7o especificamente'),
'    if (e.key === '' '' || e.code === ''Space'') {',
'      e.preventDefault();',
'    }',
'  });',
'',
unistr('  // Tamb\00E9m remove caracteres inv\00E1lidos se forem colados (ex: Ctrl+V)'),
'  el.addEventListener(''input'', function(e) {',
unistr('    // Permite apenas d\00EDgitos, ponto e v\00EDrgula'),
'    el.value = el.value.replace(/[^0-9:]/g, '''');',
'  });',
'});'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260819145242'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96715730349964422036)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>10
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(96733066119433389826)
,p_name=>'Aprovadores'
,p_region_name=>'STATIC_APROV'
,p_template=>wwv_flow_api.id(136094910039789083299)
,p_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--hideNoPagination'
,p_grid_column_span=>8
,p_display_column=>3
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', ',
'       a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, ',
'       a.dt_aprov Data, ',
'       decode(a.STATUS_APROV,''P'',''Pendente'',''A'',''Aprovado'',''R'',''Reprovado'') Status, ',
'       a.cod_emp_aprov, ',
'       a.mat_aprov, ',
'       A.SEQ_APROV, ',
'       a.justificativa,',
'       substr(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov),0,2) user_avatar,',
'       u.nm_usuario_oracle event_date,',
'       fnct_nome_func(a.cod_emp_aprov,a.mat_aprov) user_name,',
'       case when a.status_aprov = ''P'' then null ',
'            when  :P_PAINEL = ''PC'' then null',
'            else a.justificativa',
'       end event_title,',
'       a.dt_aprov event_desc,',
'       fnct_nome_func(a.cod_emp_aprov,a.mat_aprov) owner,',
'       case when a.status_aprov = ''P'' then ''fa fa-clock-o''',
'            when a.status_aprov = ''A'' then ''fa fa-check-circle-o'' ',
'            when a.status_aprov = ''R'' then ''fa fa-times-o'' ',
'       end event_icon,',
'       case when a.status_aprov = ''P'' then ''is-updated''',
'            when a.status_aprov = ''A'' then ''is-new'' ',
'            when a.status_aprov = ''R'' then ''is-removed'' ',
'       end event_status,',
'       case when a.status_aprov = ''P'' then ''Pendente'' ',
'            when a.status_aprov = ''A'' then ''Aprovado'' ',
'            when a.status_aprov = ''R'' then ''Reprovado'' ',
'       end event_type,',
'       ''u-color-''||(ora_hash(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov),44)+1) user_color',
'  from aprova_cat a, usuario_oracle u',
' where a.cod_req = :p91_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil)',
'union',
'select DISTINCT ''ROWID'', ',
'       U.CD_PERFIL aprovador, ',
'       a.dt_aprov Data, ',
'       decode(a.STATUS_APROV,''P'',''Pendente'',''A'',''Aprovado'',''R'',''Reprovado'') Status,',
'       NULL cod_emp_aprov, ',
'       NULL mat_aprov, ',
'       MIN(A.SEQ_APROV) SEQ_APROV, ',
'       a.justificativa,',
'       substr(U.CD_PERFIL,0,2) user_avatar,',
'       null event_date,',
'       U.CD_PERFIL user_name,',
'       case when a.status_aprov = ''P'' then null ',
'            when :P_PAINEL = ''PC'' then null',
'            else a.justificativa',
'       end event_title,',
'       a.dt_aprov event_desc,',
'       U.CD_PERFIL owner,',
'       case when a.status_aprov = ''P'' then ''fa fa-clock-o''',
'            when a.status_aprov = ''A'' then ''fa fa-check-circle-o''',
'            when a.status_aprov = ''R'' then ''fa fa-times-o'' ',
'       end event_icon,',
'       case when a.status_aprov = ''P'' then ''is-updated''',
'            when a.status_aprov = ''A'' then ''is-new'' ',
'            when a.status_aprov = ''R'' then ''is-removed'' ',
'       end event_status,',
'       case when a.status_aprov = ''P'' then ''Pendente'' ',
'            when a.status_aprov = ''A'' then ''Aprovado'' ',
'            when a.status_aprov = ''R'' then ''Reprovado'' ',
'       end event_type,',
'       ''u-color-''||(ora_hash(U.CD_PERFIL,44)+1) user_color',
'  from aprova_cat a, usuario_oracle u',
' where a.cod_req = :p91_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1  ',
'  from aprova_cat a',
' where a.cod_req = :p91_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_items_to_submit=>'P91_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(130899080862108024014)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066246569389827)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_column_heading=>'&#x27;rowid&#x27;'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066385419389828)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066416676389829)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066492784389830)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066613897389831)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_column_heading=>'Cod Emp Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066715441389832)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_column_heading=>'Mat Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733066810668389833)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96188628455693008672)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>18
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067019776389835)
,p_query_column_id=>9
,p_column_alias=>'USER_AVATAR'
,p_column_display_sequence=>8
,p_column_heading=>'User Avatar'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067161629389836)
,p_query_column_id=>10
,p_column_alias=>'EVENT_DATE'
,p_column_display_sequence=>9
,p_column_heading=>'Event Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067212128389837)
,p_query_column_id=>11
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>10
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067298560389838)
,p_query_column_id=>12
,p_column_alias=>'EVENT_TITLE'
,p_column_display_sequence=>11
,p_column_heading=>'Event Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067469625389839)
,p_query_column_id=>13
,p_column_alias=>'EVENT_DESC'
,p_column_display_sequence=>12
,p_column_heading=>'Event Desc'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067571959389840)
,p_query_column_id=>14
,p_column_alias=>'OWNER'
,p_column_display_sequence=>13
,p_column_heading=>'Owner'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067628433389841)
,p_query_column_id=>15
,p_column_alias=>'EVENT_ICON'
,p_column_display_sequence=>14
,p_column_heading=>'Event Icon'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067746627389842)
,p_query_column_id=>16
,p_column_alias=>'EVENT_STATUS'
,p_column_display_sequence=>15
,p_column_heading=>'Event Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067876676389843)
,p_query_column_id=>17
,p_column_alias=>'EVENT_TYPE'
,p_column_display_sequence=>16
,p_column_heading=>'Event Type'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733067948090389844)
,p_query_column_id=>18
,p_column_alias=>'USER_COLOR'
,p_column_display_sequence=>17
,p_column_heading=>'User Color'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96851703152176910523)
,p_plug_name=>unistr('Comunica\00E7\00E3o de Acidente/Incidente')
,p_icon_css_classes=>'fa-ambulance'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(136094908464701083296)
,p_plug_display_sequence=>170
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(125887933428467092398)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(136094931327384083344)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134007532764736)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>170
,p_plug_grid_column_span=>4
,p_plug_display_column=>5
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p91_cod_sit_req in (1,6) or :p91_rowid is null then',
'return true;',
'else',
'return false;',
'end if;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134126005764737)
,p_plug_name=>'Colaborador'
,p_region_name=>'COLABORADOR'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134319532764739)
,p_plug_name=>unistr('Servi\00E7o / Provid\00EAncia')
,p_region_name=>'SERVICO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134431989764740)
,p_plug_name=>unistr('Descri\00E7\00E3o do Acidente')
,p_region_name=>'ACIDENTE'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134533306764741)
,p_plug_name=>unistr('Consequ\00EAncia')
,p_region_name=>'CONSEQUENCIA'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134539525764742)
,p_plug_name=>'Testemunha'
,p_region_name=>'TESTEMUNHA'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123711271288016225533)
,p_plug_name=>'IR - Testemunha'
,p_parent_plug_id=>wwv_flow_api.id(123709134539525764742)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(136094909519748083297)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a."ROWID",',
'       a.num_analise_acidente_testemun,',
'       a.cod_empresa||'' - ''||initcap(fnct_nome_empresa(a.cod_empresa, ''S'')) cod_empresa,',
'       case when a.matricula is not null then a.matricula||'' - ''||initcap(fnct_nome_func(a.cod_empresa, a.matricula)) ',
'            when a.matricula is null then a.nome end testemunha,',
'       a.endereco,',
'       a.numero,',
'       a.complem,',
'       a.bairro,',
'       lpad(a.cep,5,0)||''-''||lpad(a.complemento_cep,3,0) cep,',
'       a.cidade,',
'       a.uf,',
'       ''(''||a.ddd||'') ''||a.telefone telefone,',
'       a.depoimento_testemunha',
'  from ANALISE_ACIDENTE_TESTEMUNHA a',
' where a.cod_empresa = :p91_cod_empresa',
'   and a.cod_analise_acidente = :p91_cod_analise_acidente',
' order by a.num_analise_acidente_testemun'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P91_COD_EMPRESA,P91_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(123711271382172225534)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_ROWID:#ROWID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>27113989695649411040
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732658707966973063)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732659161929973065)
,p_db_column_name=>'NUM_ANALISE_ACIDENTE_TESTEMUN'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Ordem'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732663093304973069)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>30
,p_column_identifier=>'L'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732663498038973069)
,p_db_column_name=>'TESTEMUNHA'
,p_display_order=>40
,p_column_identifier=>'M'
,p_column_label=>'Testemunha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732659531278973066)
,p_db_column_name=>'ENDERECO'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732659901697973067)
,p_db_column_name=>'NUMERO'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>unistr('N\00BA')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732660375937973068)
,p_db_column_name=>'COMPLEM'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732660756054973068)
,p_db_column_name=>'BAIRRO'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732661103948973068)
,p_db_column_name=>'CEP'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'CEP'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732661578102973068)
,p_db_column_name=>'CIDADE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732661971260973069)
,p_db_column_name=>'UF'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732662321082973069)
,p_db_column_name=>'TELEFONE'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Telefone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732662717993973069)
,p_db_column_name=>'DEPOIMENTO_TESTEMUNHA'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Depoimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(123711417178821776125)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1353822'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TESTEMUNHA:CEP:ENDERECO:NUMERO:COMPLEM:BAIRRO:CIDADE:UF:TELEFONE:DEPOIMENTO_TESTEMUNHA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123709134720607764743)
,p_plug_name=>'Terceiros'
,p_region_name=>'TERCEIROS'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123711385257200743522)
,p_plug_name=>'IR - Terceiros'
,p_parent_plug_id=>wwv_flow_api.id(123709134720607764743)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(136094909519748083297)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a."ROWID",',
'       a.cod_empresa||'' - ''||initcap(fnct_nome_empresa(a.cod_empresa, ''S'')) cod_empresa,',
'       a.nome testemunha,',
'       a.endereco,',
'       a.numero,',
'       a.complemento,',
'       a.bairro,',
'       lpad(a.cep,5,0)||''-''||lpad(a.complemento_cep,3,0) cep,',
'       a.cidade,',
'       a.uf,',
'       ''(''||a.ddd||'') ''||a.telefone telefone,',
'       a.depoimento_testemunha',
'  from ACID_TESTEMUNHA_EXTERNA a',
' where a.cod_empresa = :p91_cod_empresa',
'   and a.cod_analise_acidente = :p91_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P91_COD_EMPRESA,P91_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(123711385494045743524)
,p_max_row_count=>'1000000'
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:RP,34:P34_ROWID:#ROWID#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_owner=>'IGOR'
,p_internal_uid=>27114103807522929030
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732665330483973071)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732665723757973072)
,p_db_column_name=>'ENDERECO'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>unistr('Endere\00E7o')
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732666129073973074)
,p_db_column_name=>'NUMERO'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>unistr('N\00BA')
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732666578125973074)
,p_db_column_name=>'BAIRRO'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Bairro'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732666930367973075)
,p_db_column_name=>'CEP'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>'CEP'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732667314927973075)
,p_db_column_name=>'CIDADE'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>'Cidade'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732667689823973075)
,p_db_column_name=>'UF'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'UF'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732668156764973076)
,p_db_column_name=>'TELEFONE'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>'Telefone'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732668491362973076)
,p_db_column_name=>'DEPOIMENTO_TESTEMUNHA'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Depoimento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732668927387973077)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>'Empresa'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732669297345973077)
,p_db_column_name=>'TESTEMUNHA'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>'Testemunha'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(96732669721998973077)
,p_db_column_name=>'COMPLEMENTO'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Complemento'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(123711538887324186240)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'1353884'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'TESTEMUNHA:CEP:ENDERECO:NUMERO:COMPLEMENTO:BAIRRO:CIDADE:UF:TELEFONE:DEPOIMENTO_TESTEMUNHA:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710022693326737793)
,p_plug_name=>unistr('Comunica\00E7\00E3o de Acidente')
,p_region_name=>'ANALISE'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099641952773199)
,p_plug_name=>'Dados do Acidente'
,p_parent_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96732823060224233813)
,p_plug_name=>unistr('Dados de Frequ\00EAncia')
,p_region_name=>'FREQUENCIA'
,p_parent_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(96732823133604233814)
,p_plug_name=>unistr('Marca\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(96732823060224233813)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099797918773200)
,p_plug_name=>'Local do Acidente'
,p_region_name=>'LOCAL'
,p_parent_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099849964773201)
,p_plug_name=>unistr('Atendimento M\00E9dico')
,p_region_name=>'ATENDIMENTO'
,p_parent_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710100008968773202)
,p_plug_name=>'Avaliador'
,p_region_name=>'AVALIADOR'
,p_parent_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710100222412773204)
,p_plug_name=>unistr('T\00E9cnico')
,p_parent_plug_id=>wwv_flow_api.id(123710100008968773202)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710100249061773205)
,p_plug_name=>'Engenheiro'
,p_parent_plug_id=>wwv_flow_api.id(123710100008968773202)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099177553773194)
,p_plug_name=>'EPIs'
,p_region_name=>'EPI'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123711268816870225508)
,p_plug_name=>'IG - EPIs'
,p_parent_plug_id=>wwv_flow_api.id(123710099177553773194)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(136094909519748083297)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa,',
'       cod_analise_acidente,',
'       cod_equip,',
'       usuario,',
'       dt_atualizacao',
'  from ANALISE_ACID_EQUIP_PROT_INDIV',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P91_COD_EMPRESA,P91_COD_ANALISE_ACIDENTE'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269029404225510)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P91_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269060607225511)
,p_name=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ANALISE_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P91_COD_ANALISE_ACIDENTE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269175054225512)
,p_name=>'COD_EQUIP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EQUIP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'EPI'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_equip||'' - ''||descricao d, cod_equip',
'  from equip_prot_indiv',
' order by descricao'))
,p_lov_display_extra=>false
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269250746225513)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':p_usuario'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269343220225514)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>80
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269497609225515)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269623272225516)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711269701139225517)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(123711268853728225509)
,p_internal_uid=>27113987167205411015
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(119440187796868249581)
,p_update_authorization_scheme=>wwv_flow_api.id(119440188303325249581)
,p_delete_authorization_scheme=>wwv_flow_api.id(119440188070973249581)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_no_data_found_message=>'Nenhum Registro Encontrado'
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(123711333142867467353)
,p_interactive_grid_id=>wwv_flow_api.id(123711268853728225509)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(123711333332928467356)
,p_report_id=>wwv_flow_api.id(123711333142867467353)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711333948680467370)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(123711269029404225510)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711334501680467379)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(123711269060607225511)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711334997259467382)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(123711269175054225512)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>1149
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711335440561467385)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(123711269250746225513)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711336023650467387)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(123711269343220225514)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711342780737496635)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(123711269497609225515)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711343264976496638)
,p_view_id=>wwv_flow_api.id(123711333332928467356)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(123711269623272225516)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099293478773195)
,p_plug_name=>'Custo'
,p_region_name=>'CUSTO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123711269946882225520)
,p_plug_name=>'IG - Custo'
,p_parent_plug_id=>wwv_flow_api.id(123710099293478773195)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(136094909519748083297)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_empresa, ',
'       cod_analise_acidente,',
'       cod_custo_acidente,',
'       descricao_custo,',
'       valor_custo_acidente,',
'       usuario,',
'       dt_atualizacao',
'  from CUSTO_ACIDENTE',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente'))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270223712225522)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P91_COD_EMPRESA'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270334187225523)
,p_name=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_ANALISE_ACIDENTE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P91_COD_ANALISE_ACIDENTE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270353026225524)
,p_name=>'COD_CUSTO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_CUSTO_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P91_NUM_ANAL'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270477613225525)
,p_name=>'DESCRICAO_CUSTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DESCRICAO_CUSTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Descri\00E7\00E3o')
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_item_width=>40
,p_is_required=>true
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270597710225526)
,p_name=>'VALOR_CUSTO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VALOR_CUSTO_ACIDENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Valor'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270692783225527)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>90
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>':p_usuario'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270811636225528)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'PLSQL_EXPRESSION'
,p_default_expression=>'sysdate'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711270906597225529)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711271009253225530)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(123711271082086225531)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(123711270071945225521)
,p_internal_uid=>27113988385422411027
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_api.id(119440187796868249581)
,p_update_authorization_scheme=>wwv_flow_api.id(119440188303325249581)
,p_delete_authorization_scheme=>wwv_flow_api.id(119440188070973249581)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(123711354120217553458)
,p_interactive_grid_id=>wwv_flow_api.id(123711270071945225521)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(123711354169460553458)
,p_report_id=>wwv_flow_api.id(123711354120217553458)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711354733069553460)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(123711270223712225522)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711355169789553463)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(123711270334187225523)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711355700189553465)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(123711270353026225524)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711356166668553467)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(123711270477613225525)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>637
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711356721326553469)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(123711270597710225526)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>222
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711357158931553471)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(123711270692783225527)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711357724965553473)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(123711270811636225528)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711358146033553475)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(123711270906597225529)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(123711358655861553477)
,p_view_id=>wwv_flow_api.id(123711354169460553458)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(123711271009253225530)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099429815773196)
,p_plug_name=>unistr('Plano e A\00E7\00E3o')
,p_region_name=>'PLANO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099467452773197)
,p_plug_name=>'Diagrama de Causa/Efeito (6Ms)'
,p_region_name=>'DIAGRAMA'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710099593595773198)
,p_plug_name=>unistr('Conclus\00E3o')
,p_region_name=>'CONCLUSAO'
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(123710100108734773203)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--stacked:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(136094910039789083299)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_display_column=>2
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(123710103958910773242)
,p_name=>'Parte do Corpo Atingida <span style="color:red;">*</span>'
,p_region_name=>'PARTE_CORPO'
,p_template=>wwv_flow_api.id(136094910039789083299)
,p_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_grid_column_span=>10
,p_display_column=>2
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p."ROWID",',
'       --l.ds_parte_lesada||'' (''||p.cod_parte_lesada||'')'' parte_lesada,',
'       (select l.ds_parte_lesada||'' (''||p.cod_parte_lesada||'')'' from parte_lesada l where p.cod_parte_lesada = l.cod_parte_lesada) parte_lesada,',
'       p.descricao_parte_lesada,',
unistr('       decode(nvl(p.lateralidade,0),0,''N\00E3o Aplic\00E1vel'',1,''Esquerda'',2,''Direita'',3,''Ambas'') lateralidade,'),
'       P.COD_REQ',
'  from req_analise_func_parte_lesada p',
' where p.cod_req = :p91_cod_req',
' order by 2'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P91_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(136094918851343083315)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em Adicionar para informar a parte do corpo atingida.'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96732725178462973146)
,p_query_column_id=>1
,p_column_alias=>'ROWID'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:32:&SESSION.::&DEBUG.:RP,32:P32_ROWID:#ROWID#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P91_ROWID'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96732725545054973149)
,p_query_column_id=>2
,p_column_alias=>'PARTE_LESADA'
,p_column_display_sequence=>2
,p_column_heading=>'Parte Atingida'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96732725969311973149)
,p_query_column_id=>3
,p_column_alias=>'DESCRICAO_PARTE_LESADA'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Descri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96732726307036973149)
,p_query_column_id=>4
,p_column_alias=>'LATERALIDADE'
,p_column_display_sequence=>3
,p_column_heading=>'Lateralidade'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(96733293267790523199)
,p_query_column_id=>5
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96188628042594008667)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(96733066119433389826)
,p_button_name=>'CAT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Caracteriza\00E7\00E3o CAT')
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:31:&SESSION.::&DEBUG.:31:P31_COD_EMPRESA,P31_MATRICULA,P31_COD_ANALISE_ACIDENTE:&P91_COD_EMPRESA.,&P91_MATRICULA.,&P91_COD_ANALISE_ACIDEN.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT 1',
'FROM   DUAL',
'WHERE  :P91_COD_SIT_REQ = 2',
'AND    :P91_COD_ANALISE_ACIDEN IS NOT NULL',
'AND    :P_PAINEL <> ''PC'''))
,p_button_condition_type=>'EXISTS'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96733293390589523201)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'Aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--iconLeft:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'BODY'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P91_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'if :p91_cod_sit_req = 1 then',
'',
'pkg_req_analise_acidente.Valida_Sequencia(pcod_empresa => :p91_cod_empresa',
'                            ,psolicitacao => :p91_cod_req',
'                            ,pemp_aprov   => :p_empresa_user',
'                            ,pmat_aprov   => :p_matricula_user',
'                            ,pflg_retorno => v_flag',
'                            ,pmsg_retorno => v_mensagem);',
'',
'if v_flag = ''N'' then',
'return false;',
'elsif v_flag = ''S'' then',
'return true;',
'else ',
'return false;',
'end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96733293525003523202)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'Reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'BODY'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P91_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'if :p91_cod_sit_req = 1 then',
'',
'pkg_req_atestado.Valida_Sequencia(pcod_empresa => :p91_cod_empresa',
'                            ,psolicitacao => :p91_cod_req',
'                            ,pemp_aprov   => :p_empresa_user',
'                            ,pmat_aprov   => :p_matricula_user',
'                            ,pflg_retorno => v_flag',
'                            ,pmsg_retorno => v_mensagem);',
'',
'if v_flag = ''N'' then',
'return false;',
'elsif v_flag = ''S'' then',
'return true;',
'else ',
'return false;',
'end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;*/',
'',
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'if :p91_cod_sit_req = 1 then',
'',
'pkg_req_analise_acidente.Valida_Sequencia(pcod_empresa => :p91_cod_empresa',
'                            ,psolicitacao => :p91_cod_req',
'                            ,pemp_aprov   => :p_empresa_user',
'                            ,pmat_aprov   => :p_matricula_user',
'                            ,pflg_retorno => v_flag',
'                            ,pmsg_retorno => v_mensagem);',
'',
'if v_flag = ''N'' then',
'return false;',
'elsif v_flag = ''S'' then',
'return true;',
'else ',
'return false;',
'end if;',
'',
'else',
'',
'return false;',
'',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732646131310973046)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--iconLeft:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P91_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_api.id(119440187796868249581)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732695774018973097)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_button_name=>'btn_add_medico'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cadastro de M\00E9dico')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:39:&SESSION.::&DEBUG.:RP,39::'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_security_scheme=>wwv_flow_api.id(119440188303325249581)
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732645716202973045)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BODY'
,p_button_condition_type=>'NEVER'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_api.id(119440188303325249581)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96733065944100389824)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'V_VALIDA_USUARIO NUMBER := 0;',
'',
'BEGIN',
'',
' SELECT COUNT(1)',
'   INTO V_VALIDA_USUARIO',
'   FROM APROVA_CAT APCA',
'      , USUARIO_ORACLE USOR',
'  WHERE APCA.COD_REQ = :P91_COD_REQ',
'    AND APCA.MAT_APROV = :P_MATRICULA_USER',
'    AND APCA.COD_EMP_APROV = USOR.CD_EMPRESA',
'    AND APCA.MAT_APROV = USOR.CD_MATRICULA;',
'',
'pkg_req_analise_acidente.Valida_Sit_Req(pcod_empresa => :p91_cod_empresa,',
'                          psolicitacao => :p91_cod_req,',
'                          pmatricula => :p91_matricula,',
'                          psit_req => 3,',
'                          pusuario => :p_usuario,',
'                          pflg_retorno => v_flg,',
'                          pmsg_retorno => v_msg);',
'',
'  IF V_FLG = ''N'' OR :P91_ROWID IS NULL THEN',
'   RETURN FALSE;',
'  ELSIF V_VALIDA_USUARIO = 0 THEN ',
'   RETURN FALSE;',
'  ELSE',
'   RETURN TRUE;',
'  END IF;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_api.id(119440188303325249581)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732646546754973046)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(123709134007532764736)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_security_scheme=>wwv_flow_api.id(119440188070973249581)
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732647204665973054)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_button_name=>'RELATORIO_CAT'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Relat\00F3rio CAT')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732671222989973078)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_button_name=>'REL_INVESTIGACAO_ACIDENTE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Investiga\00E7\00E3o de Acidente')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732726728991973149)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123710103958910773242)
,p_button_name=>'ADD_PARTE_CORPO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P91_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732645358270973044)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(96851703152176910523)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--simple:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(136094931005107083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:90:&SESSION.::&DEBUG.:::'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732664382053973071)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123711271288016225533)
,p_button_name=>'ADD_TESTEMUNHA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:RP,33:P33_COD_EMPRESA,P33_COD_ANALISE_ACIDENTE,P33_NUM_ANALISE_ACIDENTE_TESTE:&P91_COD_EMPRESA.,&P91_COD_ANALISE_ACIDENTE.,&P91_NUM_ANAL.'
,p_security_scheme=>wwv_flow_api.id(119440188303325249581)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(96732670536795973077)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(123711385257200743522)
,p_button_name=>'ADD_TERCEIRO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(136094930831387083343)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:RP,34:P34_COD_EMPRESA,P34_COD_ANALISE_ACIDENTE:&P91_COD_EMPRESA.,&P91_COD_ANALISE_ACIDENTE.'
,p_security_scheme=>wwv_flow_api.id(119440188303325249581)
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(94505735106519386281)
,p_branch_name=>'REFRESH'
,p_branch_action=>'f?p=&APP_ID.:91:&SESSION.::&DEBUG.:RP,91:P91_COD_REQ:&P91_COD_REQ.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'REQUEST_IN_CONDITION'
,p_branch_condition=>'REDIRECIONAMENTO'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(96732759605186973169)
,p_branch_name=>'Go To Page 90'
,p_branch_action=>'f?p=&APP_ID.:90:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(94505735222744386282)
,p_name=>'P91_NUM_LOCAL_ACIDENTE_AUX'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_item_default=>'P91_NUM_LOCAL_ACIDENTE'
,p_item_default_type=>'ITEM'
,p_prompt=>unistr('N\00FAmero')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96188628199376008669)
,p_name=>'P91_COD_ANALISE_ACIDEN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(96733066119433389826)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96433002248287894622)
,p_name=>'P91_ARQ_BO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Documento B.O.'
,p_source=>'ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'MIMETYPE_ARQ_BO'
,p_attribute_03=>'NOME_ARQ_BO'
,p_attribute_04=>'CHARSET_ARQ_BO'
,p_attribute_06=>'Y'
,p_attribute_07=>'Fazer Download'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96433002401767894623)
,p_name=>'P91_NOME_ARQ_BO'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96433002509409894624)
,p_name=>'P91_MIMETYPE_ARQ_BO'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'MIMETYPE_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96433002570390894625)
,p_name=>'P91_CHARSET_ARQ_BO'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'UTF-8'
,p_source=>'CHARSET_ARQ_BO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96715730200187422035)
,p_name=>'P91_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96715730464043422037)
,p_name=>'P91_COD_SIT_REQ'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Em Andamento;1,Concluida;2,Cancelada;3,Reprovada;4,Aprovada;5,Suspensa;6'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_protection_level=>'S'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96715730574030422038)
,p_name=>'P91_DT_REQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Requisi\00E7\00E3o')
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96715730598771422039)
,p_name=>'P91_DT_SIT_REQ'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Situa\00E7\00E3o')
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732647667572973054)
,p_name=>'P91_COD_ANALISE_ACIDENTE_DSP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>unistr('C\00F3digo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732648081455973055)
,p_name=>'P91_IND_ACIDENTE_ANTERIOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_item_default=>'N'
,p_prompt=>'Acidente Anterior'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(124799344530343009070)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732648392408973056)
,p_name=>'P91_COD_EMPRESA_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732648826738973056)
,p_name=>'P91_MATRICULA_DSP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732649244103973056)
,p_name=>'P91_COD_CCUSTO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732649629930973056)
,p_name=>'P91_VA_COD_DC'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732650076915973056)
,p_name=>'P91_COD_FATOR_PESSOAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>'Fator Pessoal'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_fator_pessoal||'' - ''||descricao d, cod_fator_pessoal',
'  from fator_pessoal',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732650472817973057)
,p_name=>'P91_COD_ATO_INSEGURO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>'Ato Inseguro'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_ato_inseguro||'' - ''||initcap(descricao) d, cod_ato_inseguro',
'  from ato_inseguro',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732650828039973057)
,p_name=>'P91_COD_CONDICAO_INSEGURA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_prompt=>unistr('Condi\00E7\00E3o Insegura')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_condicao_insegura||'' - ''||initcap(descricao) d,cod_condicao_insegura c',
'  from condicao_insegura',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732651195915973058)
,p_name=>'P91_COD_EMPRESA_SUP_IMEDIATO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732651594842973058)
,p_name=>'P91_MATRICULA_SUP_IMEDIATO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732652058167973058)
,p_name=>'P91_DC_MATRICULA_SUP_IMEDIATO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732652486162973058)
,p_name=>'P91_DT_EMISSAO_CAT'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Registro Prev.'
,p_source=>'DT_EMISSAO_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732652794210973058)
,p_name=>'P91_NUM_PROTOCOLO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(123709134126005764737)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero da CAT')
,p_source=>'NUM_PROTOCOLO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732653573476973059)
,p_name=>'P91_NUM_ANALISE_ACIDENTE_SERVICO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123709134319532764739)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732653952378973059)
,p_name=>'P91_SERVICO_TEXTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123709134319532764739)
,p_prompt=>'Tarefa Executada'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732654291495973059)
,p_name=>'P91_TEXTO_PROV_MEDIATAS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123709134319532764739)
,p_prompt=>'Mediatas'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732654777447973059)
,p_name=>'P91_TEXTO_PROV_IMEDIATAS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123709134319532764739)
,p_prompt=>'Imediatas'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732655464568973060)
,p_name=>'P91_NUM_ANALISE_ACIDENTE_DESCRICAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732655886277973061)
,p_name=>'P91_DESCRICAO_TEXTO'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732656278279973061)
,p_name=>'P91_DESCRICAO_OBSERVACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_prompt=>unistr('Outras Informa\00E7\00F5es')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732656889854973061)
,p_name=>'P91_TEXTO_DADOS_PESSOAIS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123709134533306764741)
,p_prompt=>'Texto: Dados Pessoais'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732657318556973061)
,p_name=>'P91_TEXTO_DADOS_PRODUCAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123709134533306764741)
,p_prompt=>unistr('Texto: Dados Produ\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732657783696973061)
,p_name=>'P91_TEXTO_DADOS_MATERIAIS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123709134533306764741)
,p_prompt=>'Texto: Dados Materiais'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732671668228973078)
,p_name=>'P91_AREA_SEGURANCA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732672085752973078)
,p_name=>'P91_AREA_MEDICA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732672435139973078)
,p_name=>'P91_ROWID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732672874089973079)
,p_name=>'P91_COD_ANALISE_2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ANALISE_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732673218859973079)
,p_name=>'P91_MATRICULA_ANALIZADOR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_use_cache_before_default=>'NO'
,p_source=>'MATRICULA_ANALIZADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732673658361973079)
,p_name=>'P91_NUM_ANAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732674049248973079)
,p_name=>'P91_USUARIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732674459042973079)
,p_name=>'P91_DT_ATUALIZACAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(123710022693326737793)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732675119811973080)
,p_name=>'P91_COD_ANALISE_ACIDENTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo')
,p_source=>'COD_ANALISE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732675545695973080)
,p_name=>'P91_STATUS_CAT'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'P'
,p_prompt=>'Status'
,p_source=>'STATUS_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Pendente;P,Conclu\00EDdo;C,Cancelado;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732675976935973080)
,p_name=>'P91_COD_EMPRESA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas_cad ',
' WHERE ((F_Acesso_Emp_PG_APEX(cod, :P_USUARIO) = ''S'' and :p91_rowid is null) or ',
'         (:p91_rowid is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID'
,p_ajax_items_to_submit=>'P91_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732676372737973080)
,p_name=>'P91_MATRICULA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, p.matricula',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p91_cod_empresa',
'  and ((:p91_rowid is not null ) or (:p91_rowid is null and f.situacao < ''90''))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID,P91_COD_EMPRESA'
,p_ajax_items_to_submit=>'P91_ROWID,P91_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732676726704973080)
,p_name=>'P91_DT_ACIDENTE'
,p_is_required=>true
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data do Acidente'
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DT_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732677180591973081)
,p_name=>'P91_HOR_ACIDENTE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora do Acidente'
,p_format_mask=>'hh24:mi'
,p_source=>'HOR_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732677527719973081)
,p_name=>'P91_DT_ANALISE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da An\00E1lise')
,p_source=>'DT_ANALISE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732677924887973081)
,p_name=>'P91_COD_ACIDENTE_TIPO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'4'
,p_prompt=>'Tipo Acidente'
,p_source=>'COD_ACIDENTE_TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_acidente_tipo ||'' - ''||initcap(descricao) d, cod_acidente_tipo',
'  from acidente_tipo',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732678324576973081)
,p_name=>'P91_TIPO_ANALISE'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_item_default=>'1'
,p_prompt=>'Tipo CAT'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:',
'Inicial;1,',
'Reabertura;2,',
unistr('Com \00D3bito;3')))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732678704437973081)
,p_name=>'P91_COD_ACIDENTE_TIPO_ES'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ACIDENTE_TIPO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732679171734973081)
,p_name=>'P91_AFASTAMENTO_IMEDIATO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Afastamento Imediato'
,p_source=>'AFASTAMENTO_IMEDIATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_null_value=>'N'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732679585169973081)
,p_name=>'P91_DT_ULT_DIA_TRAB'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('\00DAltimo Dia Trabalhado')
,p_source=>'DT_ULT_DIA_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732679938330973082)
,p_name=>'P91_HORAS_TRAB'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Horas Trabalhada'
,p_placeholder=>'Ex.: 06:30'
,p_source=>'HORAS_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>5
,p_cMaxlength=>5
,p_tag_css_classes=>'no-space'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732680365786973082)
,p_name=>'P91_IND_OBITO'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_item_default=>'N'
,p_prompt=>unistr('Indicativo de \00D3bito')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(124799344530343009070)||'.'
,p_colspan=>4
,p_display_when=>'P_PAINEL'
,p_display_when2=>'PC'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732680751899973083)
,p_name=>'P91_DT_OBITO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>unistr('Data de \00D3bito')
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_display_when=>'P_PAINEL'
,p_display_when2=>'PC'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732681175194973083)
,p_name=>'P91_IND_EXPERIENCIA_OPERACAO'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_item_default=>'N'
,p_prompt=>'Houve Registro Policial?'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(124799344530343009070)||'.'
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732681568203973083)
,p_name=>'P91_IND_DEPTO_POLICIAL'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Departamento Policial'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732681955208973083)
,p_name=>'P91_NUM_BOLETIM_OCORR'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'B.O.'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732682317905973083)
,p_name=>'P91_DATA_BOLETIM_OCORR'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Data B.O.'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732682783779973083)
,p_name=>'P91_ARQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Documento do Atendimento M\00E9dico')
,p_source=>'ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_colspan=>6
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'MIMETYPE_ARQ'
,p_attribute_03=>'NOME_ARQ'
,p_attribute_04=>'CHARSET_ARQ'
,p_attribute_06=>'Y'
,p_attribute_07=>'Fazer Download'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732683142387973084)
,p_name=>'P91_NOME_ARQ'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_use_cache_before_default=>'NO'
,p_source=>'NOME_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732683520316973084)
,p_name=>'P91_MIMETYPE_ARQ'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_use_cache_before_default=>'NO'
,p_source=>'MIMETYPE_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732683941746973084)
,p_name=>'P91_CHARSET_ARQ'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_use_cache_before_default=>'NO'
,p_item_default=>'UTF-8'
,p_source=>'CHARSET_ARQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732684383422973084)
,p_name=>'P91_CLASS_ACIDENTE'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Classifica\00E7\00E3o Acidente')
,p_source=>'CLASS_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao||'' (''||codigo||'') '' d, codigo c',
'  from classificacao_acidente',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_cMaxlength=>5
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732684757969973084)
,p_name=>'P91_TP_REGISTRO_CAT'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'Iniciativa'
,p_source=>'TP_REGISTRO_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:1 - Iniciativa do Empregador;1,2 - Ordem Judicial;2,3 - Determina\00E7\00E3o de \00D3rg\00E3o Fiscalizador;3')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732685117044973084)
,p_name=>'P91_COD_EMP_SOLICITANTE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Solicitante'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nvl(sigla, nome) descricao, cod',
'  from empresas_cad'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732685531366973085)
,p_name=>'P91_MAT_SOLICITANTE'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(96715730349964422036)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula Solicitante')
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||nome descricao, matricula cod',
'  from inf_pessoais_cad',
' where cod_empresa = :p91_cod_emp_solicitante'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P91_COD_EMP_SOLICITANTE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732685920176973086)
,p_name=>'P91_DC_MATRICULA'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732686598687973088)
,p_name=>'P91_TIPO_LOCAL_ACIDENTE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Local'
,p_source=>'TIPO_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:',
'1 - Estabelecimento do empregador no Brasil;1,',
'2 - Estabelecimento do empregador no exterior;2,',
unistr('3 - Estabelecimento de terceiros onde o empregador presta servi\00E7os;3,'),
unistr('4 - Via P\00FAblica;4,'),
unistr('5 - \00C1rea Rural;5,'),
unistr('6 - Embarca\00E7\00E3o;6,'),
'9 - Outros;9'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione'
,p_cHeight=>1
,p_colspan=>7
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732687059775973088)
,p_name=>'P91_IND_TRAJETO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VIND_TRAJETO ANALISE_ACIDENTE.IND_TRAJETO%TYPE;',
'BEGIN',
'  SELECT IND_TRAJETO INTO VIND_TRAJETO FROM ANALISE_ACIDENTE WHERE COD_ANALISE_ACIDENTE = :P91_COD_ANALISE_ACIDENTE;',
'  RETURN(VIND_TRAJETO);',
'EXCEPTION',
'  WHEN NO_DATA_FOUND THEN',
'   IF :P91_ROWID IS NULL THEN',
'   RETURN ''N'';',
'   END IF;',
'  WHEN OTHERS THEN',
'    RETURN(NULL);',
'END;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>unistr('A ocorr\00EAncia aconteceu no percurso de ida ou volta do trabalho?')
,p_source=>'IND_TRAJETO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'STATIC:Sim;S,',
unistr('N\00E3o;N')))
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732687482412973089)
,p_name=>'P91_COD_EMP_ACIDENTE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa (Local)'
,p_source=>'COD_EMP_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732687845064973090)
,p_name=>'P91_COD_FIL_ACIDENTE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial (Local)'
,p_source=>'COD_FIL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(sigla) descricao, cod_filial',
'  from filiais ',
'where cod_empresa = :p91_cod_emp_acidente',
'AND (((encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')) AND :p91_rowid IS NULL) or (:p91_rowid IS not NULL))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID,P91_COD_EMP_ACIDENTE'
,p_ajax_items_to_submit=>'P91_ROWID,P91_COD_EMP_ACIDENTE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732688277423973091)
,p_name=>'P91_COD_LOCAL_TRAB'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local Acidente'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('SELECT l.cod_local_trab||'' - ''||initcap(l.descricao)||'' - Pr\00E9dio: ''||l.predio||'' - Bloco: ''||l.bloco||'' - Andar: ''||l.andar||'' - Sala: ''||l.sala descricao, l.cod_local_trab'),
'FROM LOCAL_TRAB L, ',
'     FILIAL_LOCAL F',
'WHERE L.COD_LOCAL_TRAB = F.COD_LOCAL_FILIAL',
' AND F.COD_EMPRESA    = :p91_COD_EMP_ACIDENTE',
' AND F.COD_FILIAL     = :p91_cod_FIL_ACIDENTE',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_COD_EMP_ACIDENTE,P91_COD_FIL_ACIDENTE'
,p_ajax_items_to_submit=>'P91_COD_EMP_ACIDENTE,P91_COD_FIL_ACIDENTE'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732688630924973091)
,p_name=>'P91_DS_LOCAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'DS_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732689052284973092)
,p_name=>'P91_CNPJ_LOCAL_ACIDENTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CNPJ'
,p_placeholder=>unistr('CNPJ Apenas num\00E9ricos')
,p_source=>'CNPJ_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732689423740973092)
,p_name=>'P91_CEP_LOCAL'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'CEP_LOCAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732689830752973092)
,p_name=>'P91_COMPLEMENTO_CEP_LOC'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'COMPLEMENTO_CEP_LOC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732690227589973092)
,p_name=>'P91_COD_TP_LOGR'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Logradouro'
,p_source=>'COD_TP_LOGR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(a.nome_logr) d, a.cod_tp_logr',
'  from tipo_logradouro a',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732690599922973092)
,p_name=>'P91_TP_LOGR_CODIGO_ES'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'TP_LOGR_CODIGO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732691062357973092)
,p_name=>'P91_ENDERECO_ACIDENTE'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Endere\00E7o')
,p_source=>'ENDERECO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732691391569973093)
,p_name=>'P91_NUM_LOCAL_ACIDENTE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'NUM_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732691881373973093)
,p_name=>'P91_COMPLEMENTO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Complemento'
,p_source=>'COMPLEMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732692249731973093)
,p_name=>'P91_BAIRRO_ACIDENTE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Bairro'
,p_source=>'BAIRRO_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732692669148973093)
,p_name=>'P91_LOCAL_ACIDENTE'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Munic\00EDpio')
,p_source=>'LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>80
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732692991361973093)
,p_name=>'P91_CIDADE_ACIDENTE'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'CIDADE_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732693440204973093)
,p_name=>'P91_UF_LOCAL_ACIDENTE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'UF'
,p_source=>'UF_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT SIGLA d, sigla c FROM UF ORDER BY NOME'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732693797505973093)
,p_name=>'P91_COD_MUN_IBGE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MUN_IBGE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732694254737973094)
,p_name=>'P91_PAIS_ACIDENTE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pa\00EDs')
,p_source=>'PAIS_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.descricao, e.codigo ',
'  from paises_es e ',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732694617360973096)
,p_name=>'P91_CX_POSTAL'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Caixa Postal'
,p_source=>'CX_POSTAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>12
,p_colspan=>4
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732695019382973096)
,p_name=>'P91_ESPEC_LOCAL_ACIDENTE'
,p_is_required=>true
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Especifica\00E7\00E3o do Local do Acidente')
,p_source=>'ESPEC_LOCAL_ACIDENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>200
,p_cHeight=>4
,p_colspan=>12
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930650219083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732696086810973097)
,p_name=>'P91_SERV_MED_ATEND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123709134431989764740)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Recebeu atendimento m\00E9dico em servi\00E7o de sa\00FAde devido a ocorr\00EAncia?')
,p_source=>'SERV_MED_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;Sim,N\00E3o;N\00E3o')
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732696516251973097)
,p_name=>'P91_COD_MED_EMIT_CAT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('M\00E9dico')
,p_source=>'COD_MED_EMIT_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NOME||'' - ''||SIGLA||'' ''||NR_DOCUMENTO D, COD C',
'FROM   VW_MEDICOS',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732696927258973097)
,p_name=>'P91_DT_ATEND'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Atendimento'
,p_source=>'DT_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732697351862973098)
,p_name=>'P91_HORA_ATEND'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora de Atendimento'
,p_source=>'HORA_ATEND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>32
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732697774641973098)
,p_name=>'P91_QTDE_DIAS_TRATAMENTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Dura\00E7\00E3o Prov\00E1vel de Tratamento (Dias)')
,p_source=>'QTDE_DIAS_TRATAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732698147042973098)
,p_name=>'P91_COD_AGENTE_LESAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>unistr('Agente Les\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select a.cod_agente_lesao||'' - ''||initcap(a.descricao) d, a.cod_agente_lesao',
'  from agente_lesao a',
' where ((:p91_rowid is null and a.ativo = ''S'') or ',
'        (:p91_rowid is not null))',
' order by a.descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID'
,p_ajax_items_to_submit=>'P91_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732698501373973099)
,p_name=>'P91_COD_FATOR_TRABALHO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>unistr('Situa\00E7\00E3o Geradora')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select f.cod_FATOR_TRABALHO||'' - ''||initcap(f.descricao) d, f.cod_FATOR_TRABALHO',
'  from FATOR_TRABALHO f',
'  where ((:p91_rowid is null and f.ativo = ''S'') or ',
'         (:p91_rowid is not null))',
' order by f.descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID'
,p_ajax_items_to_submit=>'P91_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
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
 p_id=>wwv_flow_api.id(96732698919999973099)
,p_name=>'P91_IND_PROT_TIPO_ACIDENTE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_item_default=>'N'
,p_prompt=>unistr('Interna\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(124799344530343009070)||'.'
,p_cHeight=>1
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732699307693973099)
,p_name=>'P91_IND_AFASTAMENTO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_item_default=>'N'
,p_prompt=>'Afastamento'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_SIM_NAO'
,p_lov=>'.'||wwv_flow_api.id(124799344530343009070)||'.'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732699742123973099)
,p_name=>'P91_QTD_DIAS_AFASTAMENTO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>'Qtde. Dias'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_cMaxlength=>70
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732700114957973099)
,p_name=>'P91_DT_RETORNO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>'Data de Alta'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732700531212973099)
,p_name=>'P91_CID'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>'CID'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_DOENCA||'' - ''||UPPER(DESCRICAO) DESCRICAO, COD_DOENCA',
'  FROM DOENCA',
'ORDER BY descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732700956289973100)
,p_name=>'P91_CODIGO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>unistr('Descri\00E7\00E3o da Les\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select codigo||'' - ''||descricao d, codigo',
'  from descricao_nat_lesao_es',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732701337083973100)
,p_name=>'P91_DIAGNO_PROVAVEL'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>unistr('Diagn\00F3stico Prov\00E1vel')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732701730029973102)
,p_name=>'P91_OBSERVACAO_CAT'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_prompt=>unistr('Observa\00E7\00E3o CAT')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732702175642973102)
,p_name=>'P91_COD_CNES'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CNES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732702571885973102)
,p_name=>'P91_OBSERVACAO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o M\00E9dica')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(136094930573048083337)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732702907053973103)
,p_name=>'P91_ORIGEM_MED_CAT'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(123710099849964773201)
,p_use_cache_before_default=>'NO'
,p_source=>'ORIGEM_MED_CAT'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732703673403973103)
,p_name=>'P91_CIPEIRO_AREA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(123710100008968773202)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Cipeiro \00C1rea')
,p_source=>'CIPEIRO_AREA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732704386177973104)
,p_name=>'P91_COD_EMPRESA_TEC_SEGURANCA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(123710100222412773204)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732704785263973104)
,p_name=>'P91_MATRICULA_TEC_SEGURANCA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(123710100222412773204)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, to_char(p.matricula) codigo',
'from inf_pessoais p,informacoes_funcionais f, prestador_servico s',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.matricula   = s.cod_prest_serv',
'  and s.tipo_prest_serv = 3',
'  and p.cod_empresa = :P91_COD_EMPRESA_TEC_SEGURANCA',
'  and ((:p91_rowid is not null ) or (:p91_rowid is null and f.situacao < ''90''))',
'union',
'select s.cod_prest_serv||'' - ''||initcap(s.nome) descricao, s.cod_prest_serv codigo',
'  from prestador_servico s',
' where s.tipo_prest_serv = 3',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_COD_EMPRESA_TEC_SEGURANCA,P91_ROWID'
,p_ajax_items_to_submit=>'P91_COD_EMPRESA_TEC_SEGURANCA,P91_ROWID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>32
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732705108694973104)
,p_name=>'P91_DC_MATRICULA_TEC_SEGURANCA'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(123710100222412773204)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA_TEC_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732705818857973105)
,p_name=>'P91_COD_EMPRESA_ENG_SEGURANCA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(123710100249061773205)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732706196847973105)
,p_name=>'P91_MATRICULA_ENG_SEGURANCA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(123710100249061773205)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula||'' - ''||initcap(p.nome) descricao, to_char(p.matricula) codigo',
'from inf_pessoais p,informacoes_funcionais f, prestador_servico s',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.matricula   = s.cod_prest_serv',
'  and s.tipo_prest_serv = 3',
'  and p.cod_empresa = :P91_COD_EMPRESA_ENG_SEGURANCA',
'  and ((:p91_rowid is not null ) or (:p91_rowid is null and f.situacao < ''90''))',
'union',
'select s.cod_prest_serv||'' - ''||initcap(s.nome) descricao, s.cod_prest_serv codigo',
'  from prestador_servico s',
' where s.tipo_prest_serv = 3',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ROWID,P91_COD_EMPRESA_ENG_SEGURANCA'
,p_ajax_items_to_submit=>'P91_ROWID,P91_COD_EMPRESA_ENG_SEGURANCA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732706623547973105)
,p_name=>'P91_DC_MATRICULA_ENG_SEGURANCA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(123710100249061773205)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA_ENG_SEGURANCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732718304716973142)
,p_name=>'P91_NUM_ANALISE_ACIDENTE_PROVIDEN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710099429815773196)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732718711431973143)
,p_name=>'P91_PLANO_TEXTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123710099429815773196)
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732719173118973143)
,p_name=>'P91_PLANO_OQUE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710099429815773196)
,p_prompt=>unistr('O Qu\00EA')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732719564658973143)
,p_name=>'P91_PLANO_COMO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123710099429815773196)
,p_prompt=>'Como'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732719951412973143)
,p_name=>'P91_PLANO_QUANDO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123710099429815773196)
,p_prompt=>'Quando'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732720633576973143)
,p_name=>'P91_ITEM_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>'Meio-Ambiente'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732721051914973144)
,p_name=>'P91_ITEM_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>unistr('M\00E1quina')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732721410420973144)
,p_name=>'P91_ITEM_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>unistr('Mat\00E9ria Prima')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732721873211973144)
,p_name=>'P91_ITEM_4'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>unistr('M\00E3o de Obra')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732722246269973144)
,p_name=>'P91_ITEM_5'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>unistr('M\00E9todo')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732722663924973144)
,p_name=>'P91_ITEM_6'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>'Medida'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732723053254973144)
,p_name=>'P91_EFEITO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(123710099467452773197)
,p_prompt=>'Efeito'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732723754958973145)
,p_name=>'P91_NUM_ANALISE_ACIDENTE_CONCLUSAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710099593595773198)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732724088351973145)
,p_name=>'P91_CONCLUSAO_TEXTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(123710099593595773198)
,p_prompt=>'Acompanhamento'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732822593133233809)
,p_name=>'P91_COD_FILIAL'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732822729663233810)
,p_name=>'P91_COD_CARGO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823281316233815)
,p_name=>'P91_HORA_BATIDA_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 1'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823375601233816)
,p_name=>'P91_HORA_BATIDA_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 2'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823416522233817)
,p_name=>'P91_HORA_BATIDA_3'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 3'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823572828233818)
,p_name=>'P91_HORA_BATIDA_4'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 4'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823595279233819)
,p_name=>'P91_HORA_BATIDA_5'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 5'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823761645233820)
,p_name=>'P91_HORA_BATIDA_6'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 6'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823876090233821)
,p_name=>'P91_HORA_BATIDA_7'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 7'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823955021233822)
,p_name=>'P91_HORA_BATIDA_8'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 8'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732823998015233823)
,p_name=>'P91_COD_JORNADA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(96732823060224233813)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_JORNADA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824150095233824)
,p_name=>'P91_COD_ESCALA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(96732823060224233813)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ESCALA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824245761233825)
,p_name=>'P91_COD_JORNADA_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(96732823060224233813)
,p_prompt=>'Jornada'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824299089233826)
,p_name=>'P91_COD_ESCALA_DSP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(96732823060224233813)
,p_prompt=>'Escala'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824780097233830)
,p_name=>'P91_HORA_BATIDA_9'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 9'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824850689233831)
,p_name=>'P91_HORA_BATIDA_10'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(96732823133604233814)
,p_prompt=>'Batida 10'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732824923005233832)
,p_name=>'P91_CPF'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'CPF'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732825287819233836)
,p_name=>'P91_CARGO_DSP'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732825451046233837)
,p_name=>'P91_DESCRICAO_CARGO_DSP'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>unistr('Descri\00E7\00E3o do Cargo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732825580357233838)
,p_name=>'P91_DESCRICAO_CARGO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'DESCRICAO_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732825662940233839)
,p_name=>'P91_COD_FILIAL_DSP'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96732826147270233844)
,p_name=>'P91_COD_LOCAL_TRAB_FUNC'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_LOCAL_TRAB_FUNC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733063079386389795)
,p_name=>'P91_LOCAL_TRAB_FUNC_DSP'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Local de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733063350092389798)
,p_name=>'P91_NOME'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Nome'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733063752477389802)
,p_name=>'P91_CEP_DSP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(123710099797918773200)
,p_prompt=>'CEP'
,p_source=>'regexp_replace(LPAD(lpad(:P91_CEP_LOCAL,5,0)||lpad(:P91_COMPLEMENTO_CEP_LOC,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'')'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(136094930488511083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733064048511389805)
,p_name=>'P91_DDD_FUNC_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_source=>'DDD_FUNC_1'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733064139179389806)
,p_name=>'P91_TELEFONE_FUNC_1'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_use_cache_before_default=>'NO'
,p_source=>'TELEFONE_FUNC_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733064194448389807)
,p_name=>'P91_TELEFONE_FUNC_1_DSP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(123710099641952773199)
,p_prompt=>'Telefone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(136094930390783083336)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(96733064530812389810)
,p_name=>'P91_URL_PARTE_LESADA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(123710103958910773242)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(96733065216003389817)
,p_computation_sequence=>10
,p_computation_item=>'P91_DT_REQ'
,p_computation=>'SYSDATE'
,p_compute_when=>'P91_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(96733065329599389818)
,p_computation_sequence=>20
,p_computation_item=>'P91_DT_SIT_REQ'
,p_computation=>'SYSDATE'
,p_compute_when=>'P91_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(96733065454926389819)
,p_computation_sequence=>30
,p_computation_item=>'P91_COD_SIT_REQ'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'1'
,p_compute_when=>'P91_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(96733065543968389820)
,p_computation_sequence=>40
,p_computation_item=>'P91_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_USUARIO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(96733065597322389821)
,p_computation_sequence=>50
,p_computation_item=>'P91_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'SYSDATE'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(84941771412558117841)
,p_validation_name=>'Valida Duplicidade Req'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VREQ_EXISTENTE REQ_ANALISE_ACIDENTE.COD_REQ%TYPE;',
'  VMSG_ERRO      VARCHAR2(4000);',
'BEGIN',
'',
'  BEGIN',
'    SELECT COD_REQ',
'    INTO   VREQ_EXISTENTE',
'    FROM   REQ_ANALISE_ACIDENTE',
'    WHERE  ROWNUM      = 1',
'    AND    COD_SIT_REQ NOT IN (3,4)',
'    AND    TO_CHAR(DT_ACIDENTE,''DD/MM/YYYY'') = :P91_DT_ACIDENTE -- TO_DATE(:P91_DT_ACIDENTE,''DD/MM/YYYY'')',
'    AND    MATRICULA   = :P91_MATRICULA',
'    AND    COD_EMPRESA = :P91_COD_EMPRESA',
'    ORDER  BY COD_REQ DESC;',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      VMSG_ERRO := SQLERRM;',
'      VREQ_EXISTENTE := NULL;',
'  END;',
'--  RETURN(:P91_COD_EMPRESA||'',''||:P91_MATRICULA||'';''||:P91_DT_ACIDENTE||'';''||VREQ_EXISTENTE);',
'--  RETURN(:P91_COD_EMPRESA||'',''||:P91_MATRICULA||'';''||:P91_DT_ACIDENTE||'';''||VREQ_EXISTENTE||'';''||VMSG_ERRO);',
'  IF VREQ_EXISTENTE IS NOT NULL THEN',
unistr('    RETURN(''J\00E1 existe o Comunicado de Acidente/Incidente ''||VREQ_EXISTENTE||'' para este colaborador.'');'),
'  ELSE',
'    RETURN NULL;',
'  END IF;',
'  ',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(96732646131310973046)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732711828725973138)
,p_tabular_form_region_id=>wwv_flow_api.id(123711268816870225508)
,p_validation_name=>'Valida COD_EQUIP'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  v_existe varchar2(1);',
'',
'begin',
'',
'  if :rowid is null then',
'',
'    begin',
'',
'    select ''S'' into v_existe',
'    from analise_acid_equip_prot_indiv',
'    where cod_equip = :cod_equip',
'      and cod_analise_acidente = :cod_analise_acidente;',
'',
unistr('    return ''EPI j\00E1 cadastrado!'';'),
'',
'    exception',
'    when no_data_found then',
'    return null;',
'',
'    end;',
'',
'  else',
'  return null;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_column=>'COD_EQUIP'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732728713943973153)
,p_validation_name=>'Valida CEP_LOCAL'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P91_COD_ACIDENTE_TIPO in (1,2,3) then',
'',
'  IF :P91_TIPO_LOCAL_ACIDENTE  IS NULL OR ',
'  :P91_TIPO_LOCAL_ACIDENTE IN (1,3) THEN',
'',
'          if :p91_cep_local is null then',
unistr('          return ''Campo CEP \00E9 Obrigat\00F3rio!'';'),
'          else',
'          return null;',
'          end if;',
'',
'  ELSIF     :P91_TIPO_LOCAL_ACIDENTE = 2 THEN',
'    return null;',
'          /*',
'          if :p91_cx_postal is null then',
unistr('          return ''Caixa Postal \00E9 Obrigat\00F3rio!'';'),
'          else',
'          return null;',
'          end if;',
'          */',
'  ELSE',
'          return null;',
'  END IF;',
'',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(96732689423740973092)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732729185658973153)
,p_validation_name=>'Valida CX_POSTAL'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P91_TIPO_LOCAL_ACIDENTE  IS NULL OR ',
':P91_TIPO_LOCAL_ACIDENTE IN (1,3) THEN',
'/*',
'        if :p91_cep_local is null then',
unistr('        return ''Campo CEP \00E9 Obrigat\00F3rio!'';'),
'        else',
'        return null;',
'        end if;',
'*/',
'return null;',
'ELSIF     :P91_TIPO_LOCAL_ACIDENTE = 2 THEN',
'',
'        ',
'        if :p91_cx_postal is null then',
unistr('        return ''Caixa Postal \00E9 Obrigat\00F3rio!'';'),
'        else',
'        return null;',
'        end if;',
'        ',
'ELSE',
'        return null;',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(96732694617360973096)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732729569387973154)
,p_validation_name=>'Valida COD_ACIDENTE_TIPO_ES'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p91_cod_acidente_tipo = 1 and :p91_cod_acidente_tipo_es is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Preencha o campo C\00F3d. Acidente eSocial.')
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(96732678704437973081)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732727972163973153)
,p_validation_name=>'Valida_Dt_Obito'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF NVL(:P91_TIPO_ANALISE,1) = 3 AND :P91_DT_OBITO IS NULL THEN',
unistr('  RETURN(''Para \00F3bito, \00E9 necess\00E1rio informar a data.'');'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(96732680751899973083)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96732728367153973153)
,p_validation_name=>'IMPEDE CARACTERES ALPHA'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VTEXTO VARCHAR2(10) := :P91_QTDE_DIAS_TRATAMENTO;',
'BEGIN',
'  --',
'  IF VTEXTO IS NOT NULL THEN',
'  FOR X IN 1..LENGTH(VTEXTO) LOOP',
'    IF LTRIM(SUBSTR(VTEXTO,1,X)) IS NOT NULL AND LTRIM(SUBSTR(VTEXTO,1,X)) NOT IN (''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''0'') THEN',
unistr('      RETURN(''Este campo aceita somente caracteres num\00E9ricos!'');'),
'    END IF;',
'  END LOOP;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(96732697774641973098)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(96733293299624523200)
,p_validation_name=>'Obriga Arquivo B.O.'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(:p91_ind_depto_policial,''N'') = ''S'' and :p91_arq_bo is null then',
'return ''Anexe o arquivo do Boletim de Ocorrencia!'';',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(96732646131310973046)
,p_associated_item=>wwv_flow_api.id(96433002248287894622)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(84965991280127162912)
,p_validation_name=>'New'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P91_DT_ACIDENTE > TRUNC(SYSDATE) THEN',
unistr('  RETURN(''A data do acidente n\00E3o pode ser maior que a data atual.'');'),
'ELSE',
'  RETURN NULL;',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(96732646131310973046)
,p_associated_item=>wwv_flow_api.id(96732676726704973080)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(61364093046400043799)
,p_validation_name=>unistr('Valida \00DAltimo Dia Trabalhado')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P91_DT_ULT_DIA_TRAB > TRUNC(SYSDATE) THEN',
unistr('  RETURN(''\00DAltimo dia Trabalhada n\00E3o pode ser maior que a data atual.'');'),
'ELSIF :P91_DT_ULT_DIA_TRAB IS NULL THEN',
unistr('  RETURN(''\00DAltimo dia Trabalhada deve ter algum valor.'');'),
'ELSE',
'  RETURN NULL;',
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(96732646131310973046)
,p_associated_item=>wwv_flow_api.id(96732679585169973081)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(61364093133674043800)
,p_validation_name=>'Valida Horas Trabalhada'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  FUNCTION f_valida_hora(p_horas VARCHAR2) RETURN boolean IS',
'    v_horas NUMBER(5);',
'    v_minutos NUMBER(5);',
'    v_entrada varchar2(10);',
'    v_final varchar2(10);',
'  BEGIN',
'    v_horas := TO_NUMBER(SUBSTR(P_HORAS, 1,INSTR(P_horas, '':'')-1));',
'    v_minutos :=  TO_NUMBER(SUBSTR(P_horas, INSTR(P_horas, '':'')+1));',
'    v_entrada := to_char(v_horas, ''fm09'')||'':''||to_char(v_minutos, ''fm09'');',
'    if v_horas > 24 or v_horas < 0 then',
'      v_horas := 0;',
'    end if;',
'    if v_minutos > 59 or v_minutos < 0 then',
'      v_minutos := 0;',
'    end if;',
'    v_final := to_char(v_horas, ''fm09'')||'':''||to_char(v_minutos, ''fm09'');',
'    return v_final = v_entrada;',
'  END;',
'BEGIN',
'  IF :P91_HORAS_TRAB IS NULL THEN',
'    RETURN(''QTDE horas trabalhadas deve ter algum valor.'');',
'  ELSIF NOT f_valida_hora(:P91_HORAS_TRAB) THEN',
'    RETURN(''QTDE horas trabalhadas invalida.'');',
'  ELSE',
'    RETURN NULL;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(96732646131310973046)
,p_associated_item=>wwv_flow_api.id(96732679938330973082)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(61364093239993043801)
,p_validation_name=>'Valida Trajeto'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P91_IND_TRAJETO = ''S'' and :P91_CEP_DSP is null then',
unistr('  return ''Favor informar o CEP/Endere\00E7o da ocorr\00EAncia'';'),
'else',
'  return null;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(96732687059775973088)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(61364093330892043802)
,p_validation_name=>'Valida Hora do Acidente'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  FUNCTION f_valida_hora(p_horas VARCHAR2) RETURN boolean IS',
'    v_horas NUMBER(5);',
'    v_minutos NUMBER(5);',
'    v_entrada varchar2(10);',
'    v_final varchar2(10);',
'  BEGIN',
'    v_horas := TO_NUMBER(SUBSTR(P_HORAS, 1,INSTR(P_horas, '':'')-1));',
'    v_minutos :=  TO_NUMBER(SUBSTR(P_horas, INSTR(P_horas, '':'')+1));',
'    v_entrada := to_char(v_horas, ''fm09'')||'':''||to_char(v_minutos, ''fm09'');',
'    if v_horas > 24 or v_horas < 0 then',
'      v_horas := 0;',
'    end if;',
'    if v_minutos > 59 or v_minutos < 0 then',
'      v_minutos := 0;',
'    end if;',
'    v_final := to_char(v_horas, ''fm09'')||'':''||to_char(v_minutos, ''fm09'');',
'    return v_final = v_entrada;',
'  END;',
'BEGIN',
'  IF :P91_HOR_ACIDENTE IS NULL THEN',
'    RETURN(''Hora do acidente deve ter algum valor.'');',
'  ELSIF NOT f_valida_hora(:P91_HOR_ACIDENTE) THEN',
'    RETURN(''Hora do acidente invalida.'');',
'  ELSE',
'    RETURN NULL;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(96732677180591973081)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(16981486880413938294)
,p_validation_name=>'Valida Partes do corpo'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  V_EXISTE       NUMBER;',
'  VMSG_ERRO      VARCHAR2(4000);',
'BEGIN',
'',
'  BEGIN',
'      SELECT 1 ',
'        INTO V_EXISTE',
'        FROM REQ_ANALISE_FUNC_PARTE_LESADA R',
'       WHERE R.COD_REQ = :P91_COD_REQ',
'         AND ROWNUM = 1;',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      VMSG_ERRO := SQLERRM;',
'      V_EXISTE  := NULL;',
'  END;',
'  IF V_EXISTE IS NULL THEN',
unistr('    RETURN(''\00C9 Necessario informar Parte do Corpo Atingida para finalizar a cria\00E7\00E3o.'');'),
'  ELSE',
'    RETURN NULL;',
'  END IF;',
'  ',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732735461470973157)
,p_name=>'Popula TP_LOGR_CODIGO_ES'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_TP_LOGR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732735911363973158)
,p_event_id=>wwv_flow_api.id(96732735461470973157)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select a.codigo_es',
'  from tipo_logradouro a',
' where a.cod_tp_logr = :p91_cod_tp_logr;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p91_tp_logr_codigo_es := v_c1.codigo_es;',
'',
'end;'))
,p_attribute_02=>'P91_COD_TP_LOGR'
,p_attribute_03=>'P91_TP_LOGR_CODIGO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732736295079973158)
,p_name=>unistr('CEP: Popula Endere\00E7o')
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COMPLEMENTO_CEP_LOC,P91_CEP_LOCAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732736881111973159)
,p_event_id=>wwv_flow_api.id(96732736295079973158)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'	',
'	if :P91_complemento_cep_loc is not null and :P91_cep_local is not null then',
'				begin',
'				 select c.endereco,',
'		            c.bairro,',
'		            c.cidade,',
'		            c.cod_mun_ibge,',
'		            c.uf,',
'		            t.cod_tp_logr,',
'		            c.cidade,',
'                t.codigo_es',
'		       into :P91_endereco_acidente,',
'		            :P91_bairro_acidente,',
'		            :P91_cidade_acidente,',
'		            :P91_COD_MUN_IBGE,',
'		            :P91_UF_LOCAL_ACIDENTE,',
'		            :P91_cod_tp_logr,',
'		            :P91_local_acidente,',
'                :P91_tp_logr_codigo_es',
'		       from tabela_cep c, tipo_logradouro t',
'		      where c.cep = :P91_cep_local',
'		        and c.complemento_cep = :P91_complemento_cep_loc',
'		        and c.cod_tp_logr = t.cod_tp_logr;',
'',
'					exception',
'						 when no_data_found then',
'						    null;',
'					end;',
'  else',
'      :P91_endereco_acidente := null;',
'      :P91_bairro_acidente := null;',
'      :P91_cidade_acidente := null;',
'      :P91_COD_MUN_IBGE := null;',
'      :P91_UF_LOCAL_ACIDENTE := null;',
'      :P91_cod_tp_logr := null;',
'      :P91_local_acidente := null;',
'      :P91_tp_logr_codigo_es := null;',
'  end if;',
'',
'end;',
''))
,p_attribute_02=>'P91_CEP_LOCAL,P91_COMPLEMENTO_CEP_LOC'
,p_attribute_03=>'P91_ENDERECO_ACIDENTE,P91_BAIRRO_ACIDENTE,P91_CIDADE_ACIDENTE,P91_COD_MUN_IBGE,P91_UF_LOCAL_ACIDENTE,P91_COD_TP_LOGR,P91_LOCAL_ACIDENTE,P91_TP_LOGR_CODIGO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732737195700973159)
,p_name=>unistr('Popula Dados de Endere\00E7o (Local)')
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_LOCAL_TRAB'
,p_condition_element=>'P91_COD_LOCAL_TRAB'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732737733221973159)
,p_event_id=>wwv_flow_api.id(96732737195700973159)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  cursor c1 is',
'  select l.endereco,',
'         l.numero,',
'         l.complemento,',
'         l.bairro,',
'         l.cidade,',
'         l.uf,',
'         l.cep, ',
'         l.complemento_cep,',
'         c.cod_mun_ibge,',
'         t.cod_tp_logr,',
'         t.codigo_es',
'    from local_trab l, tabela_cep c, tipo_logradouro t',
'   where l.cod_local_trab = :p91_cod_local_trab',
'     and l.cep = c.cep',
'     and l.complemento_cep = c.complemento_cep',
'     and c.cod_tp_logr = t.cod_tp_logr;',
'',
'  v_c1 c1%rowtype;',
'',
'  cursor c2 is',
'  select cgc||dc_cgc cnpj',
'    from filiais',
'   where cod_empresa = :p91_cod_emp_acidente',
'     and cod_filial = :p91_cod_fil_acidente;',
'     ',
'  v_c2 c2%rowtype;',
'',
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
' -- if v_c1.endereco is not null then',
'',
'  :p91_cep_local := v_c1.cep;',
'  :p91_complemento_cep_loc := v_c1.complemento_cep;',
'  :P91_endereco_acidente := v_c1.endereco;',
'  :p91_num_local_acidente := v_c1.numero;',
'  :p91_complemento := v_c1.complemento;',
'  :P91_bairro_acidente := v_c1.bairro;',
'  :P91_cidade_acidente := v_c1.cidade;',
'  :P91_COD_MUN_IBGE := v_c1.cod_mun_ibge;',
'  :P91_UF_LOCAL_ACIDENTE := v_c1.uf;',
'  :P91_cod_tp_logr := v_c1.cod_tp_logr;',
'  :P91_local_acidente := v_c1.cidade;',
'  :P91_tp_logr_codigo_es := v_c1.codigo_es;',
'',
' -- end if;',
'  ',
'  :p91_cnpj_local_acidente := v_c2.cnpj;',
'',
'end;'))
,p_attribute_02=>'P91_COD_LOCAL_TRAB'
,p_attribute_03=>'P91_CEP_LOCAL,P91_COMPLEMENTO_CEP_LOC,P91_ENDERECO_ACIDENTE,P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO,P91_BAIRRO_ACIDENTE,P91_CIDADE_ACIDENTE,P91_COD_MUN_IBGE,P91_UF_LOCAL_ACIDENTE,P91_COD_TP_LOGR,P91_LOCAL_ACIDENTE,P91_TP_LOGR_CODIGO_ES,P91_CNPJ_LOCAL_'
||'ACIDENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732738099037973159)
,p_name=>'BTN - ADD_PARTE_CORPO'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(96732726728991973149)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732738591367973160)
,p_event_id=>wwv_flow_api.id(96732738099037973159)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123710103958910773242)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732739030612973160)
,p_name=>'IR - Parte - Dialog Closed'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(123710103958910773242)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732739546220973161)
,p_event_id=>wwv_flow_api.id(96732739030612973160)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123710103958910773242)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732739967872973161)
,p_name=>'Btn - Testemunha - Dialog Closed'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(123576020212372584957)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732740449961973161)
,p_event_id=>wwv_flow_api.id(96732739967872973161)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123711271288016225533)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732740792034973161)
,p_name=>'Btn - Terceiro - Dialog Closed'
,p_event_sequence=>70
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(123576022286773584978)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732741382402973162)
,p_event_id=>wwv_flow_api.id(96732740792034973161)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123711385257200743522)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732741696934973162)
,p_name=>'IR - Testemunha - Dialog Closed'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(123711271288016225533)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732742276302973162)
,p_event_id=>wwv_flow_api.id(96732741696934973162)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123711271288016225533)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732742599938973162)
,p_name=>'IR - Terceiros - Dialog Closed'
,p_event_sequence=>100
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(123711385257200743522)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732743087322973162)
,p_event_id=>wwv_flow_api.id(96732742599938973162)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123711385257200743522)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732743508791973162)
,p_name=>'Popula Colaborador (Create)'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_condition_element=>'P91_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_da_event_comment=>unistr('O ITEM \00C9 NULO ROWID')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732744079663973163)
,p_event_id=>wwv_flow_api.id(96732743508791973162)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select p.cod_empresa||'' - ''||INITCAP(nvl(e.nome_abrev,e.nome)),',
'       p.matricula||'' - ''||initcap(p.nome),',
'       :p91_cod_analise_acidente,',
'       i.cod_ccusto,',
'       c.cod_dc,',
'       i.dc_matricula,',
'       I.FILIAL,',
'       I.COD_LOCALIZACAO,',
'       I.CARGO,',
'       substr(lpad(p.num_cpf,9,''0''),0,3)||''.''||',
'       substr(lpad(p.num_cpf,9,''0''),4,3)||''.''||',
'       substr(lpad(p.num_cpf,9,''0''),7,3)',
'       ||''-''||lpad(p.dc_cpf,2,''0'') cpf,',
'       UPPER(p.nome) NOME,',
'       p.ddd_cell,',
'       p.telefone_celular,',
'      ''(''||P.DDD_CELL||'') ''||substr(p.telefone_celular,1,5)||''-''||substr(p.telefone_celular,6,5) TELEFONE_FUNC_1_DSP',
'  into :p91_cod_empresa_dsp,',
'       :p91_matricula_dsp,',
'       :p91_cod_analise_acidente_dsp,',
'       :p91_cod_ccusto,',
'       :p91_va_cod_dc,',
'       :p91_dc_matricula,',
'       :P91_COD_FILIAL,',
'       :P91_COD_LOCAL_TRAB_FUNC,',
'       :P91_COD_CARGO,',
'       :P91_CPF,',
'       :P91_NOME,',
'       :P91_DDD_FUNC_1,',
'       :P91_TELEFONE_FUNC_1,',
'       :P91_TELEFONE_FUNC_1_DSP',
'  from inf_pessoais p,',
'       informacoes_funcionais i,',
'       empresas e,',
'       centro_de_custo c',
' where p.cod_empresa = e.cod',
'   and p.cod_empresa = i.cod_empresa',
'   and p.cod_empresa = c.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and p.matricula = i.matricula',
'   and p.cod_empresa = :p91_cod_empresa',
'   and p.matricula = :p91_matricula;',
'',
'exception',
'when no_data_found then',
'null;',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_COD_ANALISE_ACIDENTE'
,p_attribute_03=>'P91_COD_EMPRESA_DSP,P91_MATRICULA_DSP,P91_COD_ANALISE_ACIDENTE_DSP,P91_COD_CCUSTO,P91_VA_COD_DC,P91_DC_MATRICULA,P91_COD_FILIAL,P91_COD_LOCAL_TRAB_FUNC,P91_COD_CARGO,P91_CPF,P91_NOME,P91_TELEFONE_FUNC_1,P91_DDD_FUNC_1,P91_TELEFONE_FUNC_1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733063668431389801)
,p_event_id=>wwv_flow_api.id(96732743508791973162)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_NOME,P91_CPF,P91_COD_FILIAL_DSP,P91_LOCAL_TRAB_FUNC_DSP,P91_CARGO_DSP,P91_DESCRICAO_CARGO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733063415775389799)
,p_event_id=>wwv_flow_api.id(96732743508791973162)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_NOME,P91_CPF,P91_COD_FILIAL_DSP,P91_LOCAL_TRAB_FUNC_DSP,P91_CARGO_DSP,P91_DESCRICAO_CARGO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732744557107973163)
,p_event_id=>wwv_flow_api.id(96732743508791973162)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_EMPRESA_DSP,P91_MATRICULA_DSP,P91_COD_ANALISE_ACIDENTE_DSP,P91_COD_CCUSTO,P91_VA_COD_DC,P91_COD_FILIAL,P91_COD_CARGO,P91_DESCRICAO_CARGO,P91_CPF,P91_COD_LOCAL_TRAB_FUNC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732744982686973163)
,p_name=>unistr('\00D3bito: DT_RETORNO e QTD_DIAS_AFAST')
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_IND_OBITO'
,p_condition_element=>'P91_IND_OBITO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732745480733973163)
,p_event_id=>wwv_flow_api.id(96732744982686973163)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_RETORNO,P91_QTD_DIAS_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732745983303973163)
,p_event_id=>wwv_flow_api.id(96732744982686973163)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_OBITO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732746452006973164)
,p_event_id=>wwv_flow_api.id(96732744982686973163)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_OBITO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732746818926973164)
,p_name=>'Ind_Afastamento: Seta qtd_dias_afast'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_IND_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732747344616973164)
,p_event_id=>wwv_flow_api.id(96732746818926973164)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p91_tipo_analise = 2 then',
'',
'  if :p91_ind_obito = ''S'' then',
'  ',
'    :p91_qtd_dias_afastamento := null;',
'    :p91_dt_retorno := null;',
'    ',
'  else',
'',
'    if :p91_ind_afastamento = ''N'' then',
'    :p91_qtd_dias_afastamento := 0;',
'    :p91_dt_retorno := null;',
'    else',
'    :p91_qtd_dias_afastamento := null;',
'    end if;',
'    ',
'  end if;',
'end if;'))
,p_attribute_02=>'P91_TIPO_ANALISE,P91_IND_OBITO,P91_IND_AFASTAMENTO'
,p_attribute_03=>'P91_QTD_DIAS_AFASTAMENTO,P91_DT_RETORNO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732747715032973164)
,p_name=>'Qtd. Dias. Afast.: Seta Dt_Retorno'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_QTD_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732748224797973164)
,p_event_id=>wwv_flow_api.id(96732747715032973164)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
' ',
'if :p91_ind_obito = ''S'' then',
'',
'   :p91_dt_retorno := null ;',
'',
'end if ;',
' ',
'if :p91_ind_obito = ''N'' and ',
'   :p91_ind_afastamento = ''S'' then',
'',
'      :p91_dt_retorno := TO_DATE(:p91_dt_acidente) + :P91_QTD_DIAS_AFASTAMENTO; ',
'       ',
'end if ;',
'END ;'))
,p_attribute_02=>'P91_IND_OBITO,P91_IND_AFASTAMENTO,P91_DT_ACIDENTE,P91_QTD_DIAS_AFASTAMENTO'
,p_attribute_03=>'P91_DT_RETORNO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732748587065973164)
,p_name=>'Popula dc_mat_sup_imediato'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA_SUP_IMEDIATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732749157720973165)
,p_event_id=>wwv_flow_api.id(96732748587065973164)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p91_dc_matricula_sup_imediato',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :p91_cod_empresa',
'  and p.matricula = :p91_matricula_sup_imediato;',
'  ',
'exception',
'when no_data_found then',
':p91_dc_matricula_sup_imediato := null;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA_SUP_IMEDIATO'
,p_attribute_03=>'P91_DC_MATRICULA_SUP_IMEDIATO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732749546903973165)
,p_name=>'Popula dc_mat_eng'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA_ENG_SEGURANCA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732750043084973165)
,p_event_id=>wwv_flow_api.id(96732749546903973165)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p91_dc_matricula_ENG_SEGURANCA',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P91_COD_EMPRESA_ENG_SEGURANCA',
'  and p.matricula = :p91_matricula_ENG_SEGURANCA;',
'  ',
'exception',
'when no_data_found then',
':p91_dc_matricula_ENG_SEGURANCA := null;',
'WHEN OTHERS THEN',
':p91_dc_matricula_ENG_SEGURANCA := null;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA_ENG_SEGURANCA,P91_MATRICULA_ENG_SEGURANCA'
,p_attribute_03=>'P91_DC_MATRICULA_ENG_SEGURANCA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732750476984973165)
,p_name=>'Popula dc_mat_tec'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA_TEC_SEGURANCA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732750927333973165)
,p_event_id=>wwv_flow_api.id(96732750476984973165)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select f.dc_matricula',
'  into :p91_dc_matricula_TEC_SEGURANCA',
'from inf_pessoais p,informacoes_funcionais f',
'where p.cod_empresa = f.cod_empresa',
'  and p.matricula   = f.matricula',
'  and p.cod_empresa = :P91_COD_EMPRESA_TEC_SEGURANCA',
'  and p.matricula = :p91_matricula_TEC_SEGURANCA;',
'  ',
'exception',
'when no_data_found then',
':p91_dc_matricula_TEC_SEGURANCA := null;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA_TEC_SEGURANCA,P91_MATRICULA_TEC_SEGURANCA'
,p_attribute_03=>'P91_DC_MATRICULA_TEC_SEGURANCA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732751374734973165)
,p_name=>'Chama Report RP20537'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(123576488128505196157)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732751864515973166)
,p_event_id=>wwv_flow_api.id(96732751374734973165)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP20537'
,p_attribute_02=>'INVESTIGACAO_ACIDENTE.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P91_COD_EMPRESA,P91_MATRICULA,P91_COD_ANALISE_ACIDENTE,P_USUARIO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return(',
'''&P_DATA_EMISSAO=''||To_Char(Sysdate,''DD/MM/RRRR'')||',
'''&P_EMPRESA=''||:P91_COD_EMPRESA||',
'''&P_MATRICULA=''||:P91_MATRICULA||',
'''&P_ANALISE_ACIDENTE=''||:P91_COD_ANALISE_ACIDENTE||',
'''&P_USUARIO=''     ||:P_USUARIO);'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732752214018973166)
,p_name=>'Chama Report RP10401'
,p_event_sequence=>200
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(123576487566031196152)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732752769196973166)
,p_event_id=>wwv_flow_api.id(96732752214018973166)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP10401'
,p_attribute_02=>'CAT.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P91_COD_EMPRESA,P91_MATRICULA,P91_COD_ANALISE_ACIDENTE,P_USUARIO,P91_DT_ACIDENTE,P91_OBSERVACAO'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return(',
'''&P_DATA_EMISSAO=''||To_Char(Sysdate,''DD/MM/RRRR'')||',
'''&P_COD_EMPRESA=''||:P91_COD_EMPRESA||',
'''&P_MATRICULA=''||:P91_MATRICULA||',
'''&P_DT_INICIO=''||:P91_DT_ACIDENTE||',
'''&P_DT_FIM=''||:P91_DT_ACIDENTE||',
'''&P_OBSERVACOES=''||:P91_OBSERVACAO||',
'''&P_CODIGO=''||:P91_COD_ANALISE_ACIDENTE||',
'''&P_USUARIO=''     ||:P_USUARIO);'))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732753087287973166)
,p_name=>'ADD_MEDICO DIALOG CLOSED'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(123577037510888227366)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732753678599973166)
,p_event_id=>wwv_flow_api.id(96732753087287973166)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_MED_EMIT_CAT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732754035521973166)
,p_name=>'SHOW/HIDE Campos'
,p_event_sequence=>220
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732754514040973167)
,p_event_id=>wwv_flow_api.id(96732754035521973166)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_ANALISE_ACIDENTE,P91_STATUS_CAT,P91_TIPO_LOCAL_ACIDENTE,P91_COD_EMP_ACIDENTE,P91_COD_FIL_ACIDENTE,P91_COD_LOCAL_TRAB,P91_CNPJ_LOCAL_ACIDENTE,P91_PAIS_ACIDENTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732755468306973167)
,p_name=>unistr('Area Seguran\00E7a / M\00E9dica')
,p_event_sequence=>230
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732755942945973167)
,p_event_id=>wwv_flow_api.id(96732755468306973167)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select area_medica, area_seguranca',
'  from analise_acidente_perfil',
' where ((CD_PERFIL IS NULL) OR (:P_PERFIL in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(CD_PERFIL, '':'')) t)));',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    :p91_area_seguranca := v_c1.area_seguranca;',
'    :p91_area_medica := v_c1.area_medica;',
'',
'end;'))
,p_attribute_02=>'P_PERFIL'
,p_attribute_03=>'P91_AREA_SEGURANCA,P91_AREA_MEDICA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732756393817973167)
,p_event_id=>wwv_flow_api.id(96732755468306973167)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//if (apex.item( "P91_ROWID" ).getValue().length == 0)',
'{',
'    $("#AVALIADOR").hide();',
'    $("#SERVICO_tab").hide();',
'    $("#CONSEQUENCIA_tab").hide();',
'    $("#TESTEMUNHA_tab").hide();',
'    $("#TERCEIROS_tab").hide();',
'    $("#EPI_tab").hide();',
'    $("#CUSTO_tab").hide();',
'    $("#PLANO_tab").hide();',
'    $("#DIAGRAMA_tab").hide();',
'    $("#CONCLUSAO_tab").hide();',
'    $("#COLABORADOR_tab").hide();',
'    $("#ACIDENTE_tab").hide();',
'    $("#PARTE_CORPO_tab").hide();',
'}',
'',
'if (apex.item( "P91_AREA_SEGURANCA" ).getValue() == ''S''){',
'  ',
'    $("#AVALIADOR").show();',
'    $("#SERVICO_tab").show();',
'    $("#CONSEQUENCIA_tab").show();',
'    $("#TESTEMUNHA_tab").show();',
'    $("#TERCEIROS_tab").show();',
'    $("#EPI_tab").show();',
'    $("#CUSTO_tab").show();',
'    $("#PLANO_tab").show();',
'    $("#DIAGRAMA_tab").show();',
'    $("#CONCLUSAO_tab").show();',
'    ',
'    if (apex.item( "P91_COD_ACIDENTE_TIPO" ).getValue() == ''2'') {',
'    apex.item( "P91_CID" ).hide();',
'    apex.item( "P91_CODIGO" ).hide();',
'    apex.item( "P91_DIAGNO_PROVAVEL" ).hide();',
'    }',
'  }',
'',
'if (apex.item( "P91_AREA_MEDICA" ).getValue() == ''S''){',
'    ',
'    apex.item( "P91_COD_FATOR_PESSOAL" ).hide();',
'    apex.item( "P91_COD_ATO_INSEGURO" ).hide();',
'    apex.item( "P91_COD_CONDICAO_INSEGURA" ).hide();',
'    ',
'    $("#ANALISE_tab").show();',
'    $("#ACIDENTE_tab").show();',
'    $("#COLABORADOR_tab").show();',
'    $("#PARTE_CORPO_tab").show();',
'  ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732756794191973167)
,p_name=>'Popula ORIGEM_MED_CAT'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_MED_EMIT_CAT'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732757374037973168)
,p_event_id=>wwv_flow_api.id(96732756794191973167)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_ORIGEM_MED_CAT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ORIGEM',
'FROM   VW_MEDICOS',
'WHERE  COD = :P91_COD_MED_EMIT_CAT'))
,p_attribute_07=>'P91_COD_MED_EMIT_CAT'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732758646763973168)
,p_name=>unistr('SET dura\00E7\00E3o provavel')
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_QTD_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732759171704973168)
,p_event_id=>wwv_flow_api.id(96732758646763973168)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P91_QTDE_DIAS_TRATAMENTO := TO_CHAR(:P91_QTD_DIAS_AFASTAMENTO);',
'END;'))
,p_attribute_02=>'P91_QTD_DIAS_AFASTAMENTO'
,p_attribute_03=>'P91_QTDE_DIAS_TRATAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732757695539973168)
,p_name=>unistr('SET dura\00E7\00E3o provavel_1')
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_QTDE_DIAS_TRATAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732758193943973168)
,p_event_id=>wwv_flow_api.id(96732757695539973168)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
':P91_QTD_DIAS_AFASTAMENTO := TO_NUMBER(:P91_QTDE_DIAS_TRATAMENTO);',
'END;'))
,p_attribute_02=>'P91_QTDE_DIAS_TRATAMENTO'
,p_attribute_03=>'P91_QTD_DIAS_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96715730832564422041)
,p_name=>'Create'
,p_event_sequence=>270
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96715730948601422042)
,p_event_id=>wwv_flow_api.id(96715730832564422041)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_USUARIO,P91_DT_ATUALIZACAO,P91_DT_ATUALIZACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96715731026517422043)
,p_event_id=>wwv_flow_api.id(96715730832564422041)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(96715730349964422036)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96715731102626422044)
,p_event_id=>wwv_flow_api.id(96715730832564422041)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p91_cod_emp_solicitante := :p_empresa_user;',
':p91_mat_solicitante := :p_matricula_user;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P91_COD_EMP_SOLICITANTE,P91_MAT_SOLICITANTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732821240996233795)
,p_name=>'(Create) Painel do Colaborador'
,p_event_sequence=>280
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_painel = ''PC'' and :p91_rowid is null then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732821316375233796)
,p_event_id=>wwv_flow_api.id(96732821240996233795)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_EMPRESA,P91_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732821457611233797)
,p_event_id=>wwv_flow_api.id(96732821240996233795)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p91_cod_empresa := :p_empresa_user;',
':p91_matricula := :p_matricula_user;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732821634450233799)
,p_name=>'(Create) Popula Req Temp'
,p_event_sequence=>290
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA'
,p_condition_element=>'P91_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732821785645233800)
,p_event_id=>wwv_flow_api.id(96732821634450233799)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p91_cod_req := :p91_matricula||to_char(sysdate,''hh24miss'');'
,p_attribute_02=>'P91_MATRICULA'
,p_attribute_03=>'P91_COD_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732821866137233801)
,p_name=>'Hide Regions / Items'
,p_event_sequence=>300
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732821939978233802)
,p_event_id=>wwv_flow_api.id(96732821866137233801)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123709134126005764737)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732822058353233803)
,p_event_id=>wwv_flow_api.id(96732821866137233801)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_ANALISE,P91_COD_ACIDENTE_TIPO,P91_TIPO_ANALISE,P91_AFASTAMENTO_IMEDIATO,P91_CLASS_ACIDENTE,P91_TP_REGISTRO_CAT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732822129391233804)
,p_name=>'Mask Hor Acidente'
,p_event_sequence=>310
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_HOR_ACIDENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732822251413233805)
,p_event_id=>wwv_flow_api.id(96732822129391233804)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P91_HOR_ACIDENTE");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29716945965820922247)
,p_name=>'Mask P91_HORAS_TRAB'
,p_event_sequence=>320
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_HORAS_TRAB'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29716946054168922248)
,p_event_id=>wwv_flow_api.id(29716945965820922247)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P91_HORAS_TRAB");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732822363354233806)
,p_name=>'Houve Registro Policial'
,p_event_sequence=>330
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_IND_EXPERIENCIA_OPERACAO'
,p_condition_element=>'P91_IND_EXPERIENCIA_OPERACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732822474140233807)
,p_event_id=>wwv_flow_api.id(96732822363354233806)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_IND_DEPTO_POLICIAL,P91_NUM_BOLETIM_OCORR,P91_DATA_BOLETIM_OCORR,P91_ARQ_BO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732822515281233808)
,p_event_id=>wwv_flow_api.id(96732822363354233806)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_IND_DEPTO_POLICIAL,P91_NUM_BOLETIM_OCORR,P91_DATA_BOLETIM_OCORR,P91_ARQ_BO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732822875932233811)
,p_name=>'Dados de Frequencia'
,p_event_sequence=>340
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_ACIDENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732822959375233812)
,p_event_id=>wwv_flow_api.id(96732822875932233811)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
'select p.cod_jornada, p.cod_escala, j.nome_jornada, e.descricao nome_escala',
'  from pe_escalas_excecoes p, pe_jornadas j, pe_escalas e, pe_escalas_jornadas ej',
' where p.cod_jornada = j.cod_jornada',
'   and p.cod_jornada = ej.cod_jornada',
'   and p.cod_escala = e.cod_escala',
'   and p.cod_escala = ej.cod_escala',
'   and p.cod_empresa = :p91_cod_empresa',
'   and p.matricula = :p91_matricula',
'   and :p91_Dt_Acidente between p.inicio and p.fim;',
'   ',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 1',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 2',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 3',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 4',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 5',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 6',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 7',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 8',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 9',
' union',
'select hora_batida, posicao',
'  from pe_historico_batimentos',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula',
'   and data_ponto = :p91_Dt_Acidente',
'   and posicao = 10;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
':p91_cod_jornada := v_c0.cod_jornada;',
':p91_cod_escala := v_c0.cod_escala;',
':p91_cod_jornada_dsp := v_c0.nome_jornada;',
':p91_cod_escala_dsp := v_c0.nome_escala;',
'',
'for l1 in c1',
'loop',
'  if l1.posicao = 1 then',
'     :p91_hora_batida_1 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 2 then',
'     :p91_hora_batida_2 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 3 then',
'     :p91_hora_batida_3 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 4 then',
'     :p91_hora_batida_4 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 5 then',
'     :p91_hora_batida_5 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 6 then',
'     :p91_hora_batida_6 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 7 then',
'     :p91_hora_batida_7 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 8 then',
'     :p91_hora_batida_8 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 9 then',
'     :p91_hora_batida_9 := to_char(l1.hora_batida,''hh24:mi'');',
'  elsif l1.posicao = 10 then',
'     :p91_hora_batida_10 := to_char(l1.hora_batida,''hh24:mi'');',
'  end if;',
'',
'end loop;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_DT_ACIDENTE'
,p_attribute_03=>'P91_HORA_BATIDA_1,P91_HORA_BATIDA_2,P91_HORA_BATIDA_3,P91_HORA_BATIDA_4,P91_HORA_BATIDA_5,P91_HORA_BATIDA_6,P91_HORA_BATIDA_7,P91_HORA_BATIDA_8,P91_HORA_BATIDA_9,P91_HORA_BATIDA_10,P91_COD_ESCALA,P91_COD_ESCALA_DSP,P91_COD_JORNADA,P91_COD_JORNADA_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732824681497233829)
,p_event_id=>wwv_flow_api.id(96732822875932233811)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P91_COD_JORNADA").getValue().length > 0 ){',
'        apex.item("FREQUENCIA").show();    ',
'    }else{',
'        apex.item("FREQUENCIA").hide();   ',
'    }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732825750636233840)
,p_name=>'Filial DSP'
,p_event_sequence=>350
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_FILIAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732825844909233841)
,p_event_id=>wwv_flow_api.id(96732825750636233840)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P91_COD_FILIAL_DSP := FNCT_NOME_FILIAL(:P91_COD_EMPRESA, :P91_COD_FILIAL,''S'');'
,p_attribute_02=>'P91_COD_EMPRESA,P91_COD_FILIAL'
,p_attribute_03=>'P91_COD_FILIAL_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96732825935024233842)
,p_name=>'Cargo DSP'
,p_event_sequence=>360
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_CARGO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96732826080927233843)
,p_event_id=>wwv_flow_api.id(96732825935024233842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select p.descr_func ',
'  from perfil_profisiografico p ',
' where p.cod_empresa = :p91_cod_empresa',
'   and p.cod_filial = :p91_cod_filial',
'   and p.cod_cargo = :p91_cod_cargo',
'   and p.cod_local_trab = :p91_cod_local_trab_func;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p91_cargo_dsp := :p91_cod_cargo||'' - ''||fnct_nome_Cargo(:p91_cod_cargo);',
'',
'if v_c1.descr_func is not null then',
'    if :p91_rowid is null then',
'        :p91_descricao_cargo := v_c1.descr_func;',
'        :p91_descricao_cargo_dsp := v_c1.descr_func;',
'    else',
'        :p91_descricao_cargo_dsp := :p91_descricao_cargo;',
'    end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P91_COD_CARGO,P91_DESCRICAO_CARGO,P91_COD_EMPRESA,P91_COD_LOCAL_TRAB_FUNC,P91_COD_FILIAL'
,p_attribute_03=>'P91_CARGO_DSP,P91_DESCRICAO_CARGO,P91_DESCRICAO_CARGO_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733063126033389796)
,p_name=>'Local Trab Func DSP'
,p_event_sequence=>370
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_LOCAL_TRAB_FUNC'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733063200280389797)
,p_event_id=>wwv_flow_api.id(96733063126033389796)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p91_local_trab_func_dsp := :p91_cod_local_trab_func||'' - ''||fnct_nome_local_trab(:p91_cod_local_trab_func);'
,p_attribute_02=>'P91_COD_LOCAL_TRAB_FUNC'
,p_attribute_03=>'P91_LOCAL_TRAB_FUNC_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733063886171389803)
,p_name=>'Popula Endereco'
,p_event_sequence=>380
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_CEP_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733063964595389804)
,p_event_id=>wwv_flow_api.id(96733063886171389803)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cep number(5);',
'v_dc_cep number(3);',
'',
'begin',
'',
'if :P91_CEP_DSP is not null then ',
' V_CEP := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' V_DC_CEP  := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'else',
' V_CEP := null;',
' V_DC_CEP := null;',
'end if;',
'',
' :P91_CEP_LOCAL := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' :P91_COMPLEMENTO_CEP_LOC  := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'',
'prc_api_busca_cep(p_cep => v_cep,',
'                  p_complem_cep => v_dc_cep, ',
'                  p_endereco => :p91_endereco_acidente, ',
'                  p_bairro => :p91_bairro_acidente, ',
'                  p_cidade => :p91_cidade_acidente, ',
'                  p_uf => :p91_uf_local_acidente,',
'                  p_cod_tipo_logradouro => :p91_cod_tp_logr,',
'                  p_cod_tipo_logradouro_es => :p91_tp_logr_codigo_es,',
'                  p_ibge => :p91_cod_mun_ibge);',
'',
':P91_LOCAL_ACIDENTE := :p91_cidade_acidente;',
'',
':p91_num_local_acidente := null;',
':p91_complemento := null;',
'',
'end;'))
,p_attribute_02=>'P91_CEP_DSP,P91_CIDADE_ACIDENTE'
,p_attribute_03=>'P91_CEP_LOCAL,P91_COMPLEMENTO_CEP_LOC,P91_ENDERECO_ACIDENTE,P91_BAIRRO_ACIDENTE,P91_CIDADE_ACIDENTE,P91_UF_LOCAL_ACIDENTE,P91_COD_TP_LOGR,P91_TP_LOGR_CODIGO_ES,P91_COD_MUN_IBGE,P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO,P91_LOCAL_ACIDENTE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96451226698758029237)
,p_event_id=>wwv_flow_api.id(96733063886171389803)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select f.cep, ',
'       f.complemento_cep, ',
'       f.endereco, ',
'       f.numero, ',
'       f.complem,',
'       f.bairro, ',
'       f.cidade, ',
'       f.uf',
'  from informacoes_funcionais i, ',
'       filiais f',
' where i.cod_empresa = f.cod_empresa',
'   and i.filial = f.cod_filial',
'   and i.cod_empresa = :p91_cod_empresa',
'   and i.matricula = :p91_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'     if :p91_ind_trajeto = ''N'' then',
'',
'         open c1;',
'         fetch c1 into v_c1;',
'         close c1;',
'',
'         if v_c1.endereco is not null then',
'           -- :p91_cep_dsp := regexp_replace(LPAD(lpad(v_c1.cep,5,0)||lpad(v_c1.COMPLEMENTO_CEP,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'');',
'           -- :p91_cep_local := v_c1.cep;',
'           -- :p91_complemento_cep_loc := v_c1.complemento_cep;',
'            :p91_endereco_acidente := v_c1.endereco;',
'            :p91_num_local_acidente := v_c1.numero;',
'            :p91_complemento := v_c1.complem;',
'            :p91_bairro_acidente := v_c1.bairro;',
'            :p91_cidade_acidente := v_c1.cidade;',
'            :p91_uf_local_acidente := v_c1.uf;',
'         else',
'            :p91_num_local_acidente := null;',
'            :p91_complemento := null;',
'         end if;',
'',
'     end if;',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_IND_TRAJETO'
,p_attribute_03=>'P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733064318647389808)
,p_name=>'Popula Telefone'
,p_event_sequence=>390
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_TELEFONE_FUNC_1_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733064463533389809)
,p_event_id=>wwv_flow_api.id(96733064318647389808)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P91_TELEFONE_FUNC_1_DSP IS NOT NULL THEN',
':P91_DDD_FUNC_1 :=  substr(trim(replace(translate(:P91_TELEFONE_FUNC_1_DSP,''()- '','' ''),'' '','''')),1,2);',
':P91_TELEFONE_FUNC_1 := to_number(substr(trim(replace(translate(:P91_TELEFONE_FUNC_1_DSP,''()- '','' ''),'' '','''')),3,9));',
'ELSE',
':P91_DDD_FUNC_1 := NULL;',
':P91_TELEFONE_FUNC_1 := NULL;',
'END IF;',
''))
,p_attribute_02=>'P91_TELEFONE_FUNC_1_DSP'
,p_attribute_03=>'P91_DDD_FUNC_1,P91_TELEFONE_FUNC_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733064710285389812)
,p_name=>'Add Parte Corpo'
,p_event_sequence=>400
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(96732726728991973149)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733064826204389813)
,p_event_id=>wwv_flow_api.id(96733064710285389812)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'eval(apex.item("P91_URL_PARTE_LESADA").getValue());'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96465219078808995612)
,p_event_id=>wwv_flow_api.id(96733064710285389812)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_COM.ORACLE.APEX.TIMER'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123710103958910773242)
,p_attribute_01=>'add'
,p_attribute_02=>'PARTE_ATINGIDA'
,p_attribute_04=>'2000'
,p_attribute_05=>'infinite'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733293874423523205)
,p_event_id=>wwv_flow_api.id(96733064710285389812)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123710103958910773242)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733065042719389815)
,p_name=>'Monta URL'
,p_event_sequence=>410
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_ACIDENTE'
,p_condition_element=>'P91_DT_ACIDENTE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733064595838389811)
,p_event_id=>wwv_flow_api.id(96733065042719389815)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'V_URL VARCHAR2(1000);',
'',
'begin',
'',
'V_URL := apex_page.get_url (',
'         p_application => ''SEG_CTRL_''||:P_BASE,',
'         p_page        => 92,',
'         p_items       => ''P_USUARIO,P_PAINEL,P92_COD_EMPRESA,P92_MATRICULA,P92_COD_REQ'',',
'         p_values      => :P_USUARIO||'',''||:P_PAINEL||'',''||:P91_COD_EMPRESA||'',''||:P91_MATRICULA||'',''||:P91_COD_REQ',
'       );',
'       ',
':P91_URL_PARTE_LESADA := V_URL;',
'   ',
'end;'))
,p_attribute_02=>'P_BASE,P_USUARIO,P_PAINEL,P91_COD_EMPRESA,P91_MATRICULA,P91_COD_REQ'
,p_attribute_03=>'P91_URL_PARTE_LESADA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733065727096389822)
,p_name=>'(Pesquisa) Show/Hide'
,p_event_sequence=>420
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733065832885389823)
,p_event_id=>wwv_flow_api.id(96733065727096389822)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_CEP_DSP,P91_TELEFONE_FUNC_1_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96733293004460523197)
,p_name=>'Cancelar Req'
,p_event_sequence=>430
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(96733065944100389824)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94505734474953386274)
,p_event_id=>wwv_flow_api.id(96733293004460523197)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>unistr('Deseja realmente Cancelar a Requisi\00E7\00E3o?')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96733293122132523198)
,p_event_id=>wwv_flow_api.id(96733293004460523197)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CANCELAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96465219198749995613)
,p_name=>'Timer Expired'
,p_event_sequence=>440
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(123710103958910773242)
,p_bind_type=>'bind'
,p_bind_event_type=>'PLUGIN_COM.ORACLE.APEX.TIMER|DYNAMIC ACTION|timer_expired'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96465219340312995614)
,p_event_id=>wwv_flow_api.id(96465219198749995613)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(123710103958910773242)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96451226101456029231)
,p_name=>'Popula Local de Trabalho (Colab)'
,p_event_sequence=>450
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA'
,p_condition_element=>'P91_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96433001661530894616)
,p_event_id=>wwv_flow_api.id(96451226101456029231)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    :p91_cep_dsp := NULL;',
'    :p91_num_local_acidente := NULL;',
'    :p91_complemento := NULL;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_03=>'P91_CEP_DSP,P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96451226202631029232)
,p_event_id=>wwv_flow_api.id(96451226101456029231)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select f.cep, ',
'       f.complemento_cep, ',
'       f.endereco, ',
'       f.numero,',
'       f.complem,',
'       f.bairro, ',
'       f.cidade, ',
'       f.uf',
'  from informacoes_funcionais i, ',
'       filiais f',
' where i.cod_empresa = f.cod_empresa',
'   and i.filial = f.cod_filial',
'   and i.cod_empresa = :p91_cod_empresa',
'   and i.matricula = :p91_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.endereco is not null then',
'    :p91_cep_dsp := regexp_replace(LPAD(lpad(v_c1.cep,5,0)||lpad(v_c1.COMPLEMENTO_CEP,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'');',
'    :p91_num_local_acidente := v_c1.numero;',
'    :p91_complemento := v_c1.complem;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_03=>'P91_CEP_DSP,P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96451226296581029233)
,p_name=>'Popula Local de Trabalho (Trajeto)'
,p_event_sequence=>460
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_IND_TRAJETO'
,p_condition_element=>'P91_IND_TRAJETO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96451226415317029234)
,p_event_id=>wwv_flow_api.id(96451226296581029233)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select f.cep, ',
'       f.complemento_cep, ',
'       f.endereco, ',
'       f.numero,',
'       f.complem,',
'       f.bairro, ',
'       f.cidade, ',
'       f.uf',
'  from informacoes_funcionais i, ',
'       filiais f',
' where i.cod_empresa = f.cod_empresa',
'   and i.filial = f.cod_filial',
'   and i.cod_empresa = :p91_cod_empresa',
'   and i.matricula = :p91_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.endereco is not null then',
'    :p91_cep_dsp := regexp_replace(LPAD(lpad(v_c1.cep,5,0)||lpad(v_c1.COMPLEMENTO_CEP,3,0), 8),''([0-9]{2})([0-9]{3})([0-9]{3})'',''\1.\2-\3'');',
'    :p91_num_local_acidente := v_c1.numero;',
'    :p91_complemento := v_c1.complem;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_03=>'P91_CEP_DSP,P91_NUM_LOCAL_ACIDENTE,P91_COMPLEMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96433001829404894617)
,p_event_id=>wwv_flow_api.id(96451226296581029233)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P91_IND_TRAJETO").getValue() == ''N''){',
'    apex.item("P91_CEP_DSP").disable();',
'    apex.item("P91_COD_TP_LOGR").disable();',
'    apex.item("P91_ENDERECO_ACIDENTE").disable();',
'    apex.item("P91_NUM_LOCAL_ACIDENTE").disable();',
'    apex.item("P91_COMPLEMENTO").disable();',
'    apex.item("P91_BAIRRO_ACIDENTE").disable();',
'    apex.item("P91_LOCAL_ACIDENTE").disable();',
'    apex.item("P91_CIDADE_ACIDENTE").disable();',
'    apex.item("P91_UF_LOCAL_ACIDENTE").disable();',
'}else{',
'    apex.item("P91_CEP_DSP").enable();',
'    apex.item("P91_COD_TP_LOGR").enable();',
'    apex.item("P91_ENDERECO_ACIDENTE").enable();',
'    apex.item("P91_NUM_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_COMPLEMENTO").enable();',
'    apex.item("P91_BAIRRO_ACIDENTE").enable();',
'    apex.item("P91_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_CIDADE_ACIDENTE").enable();',
'    apex.item("P91_UF_LOCAL_ACIDENTE").enable();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96451226554964029236)
,p_event_id=>wwv_flow_api.id(96451226296581029233)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_CEP_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96433001863832894618)
,p_event_id=>wwv_flow_api.id(96451226296581029233)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P91_IND_TRAJETO").getValue() == ''N''){',
'    apex.item("P91_CEP_DSP").disable();',
'    apex.item("P91_COD_TP_LOGR").disable();',
'    apex.item("P91_ENDERECO_ACIDENTE").disable();',
'    apex.item("P91_NUM_LOCAL_ACIDENTE").disable();',
'    apex.item("P91_COMPLEMENTO").disable();',
'    apex.item("P91_BAIRRO_ACIDENTE").disable();',
'    apex.item("P91_LOCAL_ACIDENTE").disable();',
'    apex.item("P91_CIDADE_ACIDENTE").disable();',
'    apex.item("P91_UF_LOCAL_ACIDENTE").disable();',
'}else{',
'    apex.item("P91_CEP_DSP").enable();',
'    apex.item("P91_COD_TP_LOGR").enable();',
'    apex.item("P91_ENDERECO_ACIDENTE").enable();',
'    apex.item("P91_NUM_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_COMPLEMENTO").enable();',
'    apex.item("P91_BAIRRO_ACIDENTE").enable();',
'    apex.item("P91_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_CIDADE_ACIDENTE").enable();',
'    apex.item("P91_UF_LOCAL_ACIDENTE").enable();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96433002020737894619)
,p_name=>'Habilitar Campos'
,p_event_sequence=>470
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(96732646131310973046)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96433002099465894620)
,p_event_id=>wwv_flow_api.id(96433002020737894619)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P91_SERV_MED_ATEND").getValue() == ''Sim'' && apex.item("P91_ARQ").getValue().length == 0){',
'    ',
unistr('    alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'    ',
unistr('    alertify.confirm("No dia da consulta ser\00E1 necess\00E1rio apresentar o comprovante de atendimento m\00E9dico. Deseja continuar sem anexar o comprovante?", function (e) {'),
'        if (e) {',
'',
'        apex.item("P91_CEP_DSP").enable();',
'        apex.item("P91_COD_TP_LOGR").enable();',
'        apex.item("P91_ENDERECO_ACIDENTE").enable();',
'        apex.item("P91_NUM_LOCAL_ACIDENTE").enable();',
'        apex.item("P91_COMPLEMENTO").enable();',
'        apex.item("P91_BAIRRO_ACIDENTE").enable();',
'        apex.item("P91_LOCAL_ACIDENTE").enable();',
'        apex.item("P91_CIDADE_ACIDENTE").enable();',
'        apex.item("P91_UF_LOCAL_ACIDENTE").enable();',
'',
'          apex.submit(''CREATE'');',
'        }',
'    });',
'    ',
'}else{',
'',
'    apex.item("P91_CEP_DSP").enable();',
'    apex.item("P91_COD_TP_LOGR").enable();',
'    apex.item("P91_ENDERECO_ACIDENTE").enable();',
'    apex.item("P91_NUM_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_COMPLEMENTO").enable();',
'    apex.item("P91_BAIRRO_ACIDENTE").enable();',
'    apex.item("P91_LOCAL_ACIDENTE").enable();',
'    apex.item("P91_CIDADE_ACIDENTE").enable();',
'    apex.item("P91_UF_LOCAL_ACIDENTE").enable();',
'    ',
'    apex.submit(''CREATE'');',
'}',
'',
'',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(96433002973731894629)
,p_name=>'Start Alertify'
,p_event_sequence=>480
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_ROWID'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96433003137026894630)
,p_event_id=>wwv_flow_api.id(96433002973731894629)
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
 p_id=>wwv_flow_api.id(96188628571439008673)
,p_name=>unistr('Hide Bot\00E3o Caracteriza\00E7\00E3o')
,p_event_sequence=>490
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P_PAINEL'
,p_display_when_cond2=>'PC'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(96188628673136008674)
,p_event_id=>wwv_flow_api.id(96188628571439008673)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(96188628042594008667)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(94505734874728386278)
,p_name=>'REFRESH'
,p_event_sequence=>500
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94505734954156386279)
,p_event_id=>wwv_flow_api.id(94505734874728386278)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REDIRECIONAMENTO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54291047009684870060)
,p_name=>'Popula P91_NUM_LOCAL_ACIDENTE'
,p_event_sequence=>510
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_NUM_LOCAL_ACIDENTE_AUX'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54291047127312870061)
,p_event_id=>wwv_flow_api.id(54291047009684870060)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_NUM_LOCAL_ACIDENTE'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>':P91_NUM_LOCAL_ACIDENTE_AUX'
,p_attribute_07=>'P91_NUM_LOCAL_ACIDENTE_AUX'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29716945813680922245)
,p_name=>'MASCARA_HORA_ATEND'
,p_event_sequence=>520
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_HORA_ATEND'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29716945873219922246)
,p_event_id=>wwv_flow_api.id(29716945813680922245)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'let item = apex.item("P91_HORA_ATEND");',
'let valor = item.getValue().trim();',
'',
'if (valor) {',
unistr('    // Se o usu\00E1rio digitou apenas n\00FAmeros (ex: "8", "9", "12")'),
'    if (/^\d+$/.test(valor)) {',
'        let horas = parseInt(valor, 10);',
'        if (horas >= 0 && horas <= 23) {',
unistr('            // Adiciona o zero \00E0 esquerda se necess\00E1rio e completa com :00'),
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':00'';',
'            item.setValue(horasFormatadas);',
'        }',
'    } ',
unistr('    // Se o usu\00E1rio digitou com dois pontos mas esqueceu o zero (ex: "8:30", "9:05")'),
'    else if (/^\d{1,2}:\d{2}$/.test(valor)) {',
'        let partes = valor.split('':'');',
'        let horas = parseInt(partes[0], 10);',
'        let minutos = partes[1];',
'        ',
'        if (horas >= 0 && horas <= 23 && parseInt(minutos, 10) <= 59) {',
'            let horasFormatadas = String(horas).padStart(2, ''0'') + '':'' + minutos;',
'            item.setValue(horasFormatadas);',
'        }',
'    }',
'}'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732729841018973155)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from REQ_ANALISE_ACIDENTE'
,p_attribute_02=>'REQ_ANALISE_ACIDENTE'
,p_attribute_03=>'P91_COD_REQ'
,p_attribute_04=>'COD_REQ'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732731047220973155)
,p_process_sequence=>20
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sequence'
,p_process_sql_clob=>'select sequencia_num_testemunha.nextval into :p91_num_anal from dual;'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P91_ROWID'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732734278616973157)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preenche Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'    begin',
'',
'    select p.cod_empresa||'' - ''||INITCAP(nvl(e.nome_abrev,e.nome)),',
'           p.matricula||'' - ''||initcap(p.nome),',
'           c.cod_dc,',
'           i.dc_matricula,',
'           substr(lpad(p.num_cpf,9,''0''),0,3)||''.''||',
'           substr(lpad(p.num_cpf,9,''0''),4,3)||''.''||',
'           substr(lpad(p.num_cpf,9,''0''),7,3)',
'           ||''-''||lpad(p.dc_cpf,2,''0'') cpf,',
'           UPPER(P.NOME) NOME,',
'           p.ddd_cell,',
'           p.telefone_celular,',
'          ''(''||P.DDD_CELL||'') ''||substr(p.telefone_celular,1,5)||''-''||substr(p.telefone_celular,6,5) TELEFONE_FUNC_1_DSP',
'      into :p91_cod_empresa_dsp,',
'           :p91_matricula_dsp,',
'           :p91_va_cod_dc,',
'           :p91_dc_matricula,',
'           :p91_cpf,',
'           :P91_NOME,',
'           :P91_DDD_FUNC_1,',
'           :P91_TELEFONE_FUNC_1,',
'           :P91_TELEFONE_FUNC_1_DSP',
'      from inf_pessoais p,',
'           informacoes_funcionais i,',
'           empresas e,',
'           centro_de_custo c',
'     where p.cod_empresa = e.cod',
'       and p.cod_empresa = i.cod_empresa',
'       and p.cod_empresa = c.cod_empresa',
'       and i.cod_ccusto = c.cod',
'       and p.matricula = i.matricula',
'       and p.cod_empresa = :p91_cod_empresa',
'       and p.matricula = :p91_matricula;',
'',
'    exception',
'    when no_data_found then',
'    null;',
'    end;',
'',
'   IF :P91_TELEFONE_FUNC_1 IS NOT NULL THEN',
'      :P91_TELEFONE_FUNC_1_DSP := ''(''||:P91_DDD_FUNC_1||'') ''||substr(:P91_TELEFONE_FUNC_1,1,5)||''-''||substr(:P91_TELEFONE_FUNC_1,6,5);',
'   END IF;',
'    ',
'   -- :p91_hor_acidente := to_char(:p91_hor_acidente,''hh24:mi'');',
'',
'    begin',
'',
'    select ',
'    TIPO_ANALISE,',
'    COD_CCUSTO,',
'    --VA_COD_DC,',
'    IND_OBITO,',
'    DT_OBITO,',
'    COD_FATOR_PESSOAL,',
'    IND_ACIDENTE_ANTERIOR,',
'    COD_ATO_INSEGURO,',
'    IND_EXPERIENCIA_OPERACAO,',
'    COD_CONDICAO_INSEGURA,',
'    COD_AGENTE_LESAO,',
'    COD_FATOR_TRABALHO,',
'    IND_PROT_TIPO_ACIDENTE,',
'    IND_AFASTAMENTO,',
'    QUANTIDADE_DIAS_AFASTAMENTO,',
'    DT_RETORNO,',
'    CID,',
'    CODIGO,',
'    COD_EMPRESA_SUP_IMEDIATO,',
'    MATRICULA_SUP_IMEDIATO,',
'    DC_MATRICULA_SUP_IMEDIATO,',
'    DIAGNO_PROVAVEL,',
'    OBSERVACAO_CAT',
'     into',
'    :P91_TIPO_ANALISE,',
'    :P91_COD_CCUSTO,',
'    --:P91_VA_COD_DC,',
'    :P91_IND_OBITO,',
'    :P91_DT_OBITO,',
'    :P91_COD_FATOR_PESSOAL,',
'    :P91_IND_ACIDENTE_ANTERIOR,',
'    :P91_COD_ATO_INSEGURO,',
'    :P91_IND_EXPERIENCIA_OPERACAO,',
'    :P91_COD_CONDICAO_INSEGURA,',
'    :P91_COD_AGENTE_LESAO,',
'    :P91_COD_FATOR_TRABALHO,',
'    :P91_IND_PROT_TIPO_ACIDENTE,',
'    :P91_IND_AFASTAMENTO,',
'    :P91_QTD_DIAS_AFASTAMENTO,',
'    :P91_DT_RETORNO,',
'    :P91_CID,',
'    :P91_CODIGO,',
'    :P91_COD_EMPRESA_SUP_IMEDIATO,',
'    :P91_MATRICULA_SUP_IMEDIATO,',
'    :P91_DC_MATRICULA_SUP_IMEDIATO,',
'    :P91_DIAGNO_PROVAVEL,',
'    :P91_OBSERVACAO_CAT',
'    from REQ_ANALISE_FUNC',
'     where cod_REQ = :P91_cod_REQ;',
'',
'    exception',
'    when no_data_found then',
'    null;',
'',
'    end;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P91_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732733816756973156)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Preenche Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select ',
' texto,',
' texto_prov_mediatas,',
' texto_prov_imediatas',
' into',
' :p91_servico_texto,',
' :p91_texto_prov_mediatas,',
' :p91_texto_prov_imediatas',
'from ANALISE_ACIDENTE_SERVICO',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select texto,',
' observacao ',
' into  :p91_descricao_texto,',
' :p91_descricao_observacao',
' from REQ_ANALISE_ACIDENTE_DESCRICAO',
' where cod_req = :p91_cod_req;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select  texto_dados_pessoais,',
' texto_dados_materiais,',
' texto_dados_producao',
' into  :p91_texto_dados_pessoais,',
' :p91_texto_dados_producao,',
' :p91_texto_dados_materiais',
'from ANALISE_ACIDENTE_CONSEQUENCIA',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'begin',
'',
'select texto,',
' plano_oque,',
' plano_como,',
' plano_quando',
' into ',
'  :p91_plano_texto,',
' :p91_plano_oque,',
' :p91_plano_como,',
' :p91_plano_quando',
'from ANALISE_ACIDENTE_PROVIDENCIA',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select item_1,',
'		item_2,',
'		item_3,',
'		item_4,',
'		item_5,',
'		item_6,',
'		efeito',
'  into  :p91_item_1,',
' :p91_item_2,',
' :p91_item_3,',
' :p91_item_4,',
' :p91_item_5,',
' :p91_item_6,',
' :p91_efeito',
'  from causa_efeito',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'   ',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
'',
'-------------------------------------------------',
'',
'begin',
'',
'select texto',
'  into :p91_conclusao_texto',
'  from analise_acidente_conclusao',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P91_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96087825357471564883)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Cod_Analise_Aciden'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    BEGIN',
'            SELECT COD_ANALISE_ACIDENTE',
'                INTO :P91_COD_ANALISE_ACIDEN',
'            FROM ANALISE_ACIDENTE',
'                WHERE COD_EMPRESA = :P91_COD_EMPRESA',
'                AND MATRICULA = :P91_MATRICULA',
'                AND TRUNC(DT_ACIDENTE) = TO_DATE(:P91_DT_ACIDENTE,''DD/MM/YYYY'');',
'                ',
'                ',
'         EXCEPTION ',
'         WHEN NO_DATA_FOUND ',
'         THEN NULL;  /*     ',
'    BEGIN',
'        IF V_COD IS NOT NULL THEN ',
'            :P91_COD_ANALISE_ACIDEN := V_COD;',
'    ELSE',
'            :P91_COD_ANALISE_ACIDEN := NULL;',
'        END IF;',
'    END;*/',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P91_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732735012721973157)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cod_req_temp number := :p91_cod_req;',
'v_cod_req number;           ',
'           ',
'begin',
'',
'  :p91_status_cat := ''P'';',
'  /*',
'  IF :P91_HOR_ACIDENTE IS NOT NULL THEN',
'  :P91_HOR_ACIDENTE := TO_DATE(:P91_DT_ACIDENTE||'' ''||:P91_HOR_ACIDENTE,''DD/MM/RRRR HH24:MI'');',
'  END IF;',
'  */',
'  ',
'  v_cod_req := seq_requisicao.NEXTVAL;',
'  ',
'  begin',
'  update REQ_ANALISE_FUNC_PARTE_LESADA',
'     set cod_req = v_cod_req',
'   where cod_req = v_cod_req_temp;',
'   ',
'  exception',
'  when others then',
'  null;',
'  end;',
'',
'   :p91_cod_req := v_cod_req;',
'  -- :P91_COD_SIT_REQ := 1;',
'   --:P91_DT_REQ := SYSDATE;',
'  -- :P91_DT_SIT_REQ := SYSDATE;',
'   ',
'',
'  :p91_cod_emp_solicitante := :p_empresa_user;',
'  :p91_mat_solicitante := :p_matricula_user;',
'  ',
'  :p91_usuario := :p_usuario;',
'  :p91_dt_atualizacao := sysdate;',
'  ',
'if :P91_CEP_DSP is not null then ',
' :P91_CEP_LOCAL := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),1,5);',
' :P91_COMPLEMENTO_CEP_LOC  := substr(trim(replace(translate(:P91_CEP_DSP,''.-'','' ''),'' '','''')),6,3);',
'else',
' :P91_CEP_LOCAL := null;',
' :P91_COMPLEMENTO_CEP_LOC := null;',
'end if;',
'',
'IF :P91_TELEFONE_FUNC_1_DSP IS NOT NULL THEN',
':P91_DDD_FUNC_1 :=  substr(trim(replace(translate(:P91_TELEFONE_FUNC_1_DSP,''()- '','' ''),'' '','''')),1,2);',
':P91_TELEFONE_FUNC_1 := to_number(substr(trim(replace(translate(:P91_TELEFONE_FUNC_1_DSP,''()- '','' ''),'' '','''')),3,9));',
'ELSE',
':P91_DDD_FUNC_1 := NULL;',
':P91_TELEFONE_FUNC_1 := NULL;',
'END IF;',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96732646131310973046)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732821549723233798)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' ',
'  :p91_usuario := :p_usuario;',
'  :p91_dt_atualizacao := sysdate;',
'  ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96732645716202973045)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732730241771973155)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of ANALISE_ACIDENTE'
,p_attribute_02=>'REQ_ANALISE_ACIDENTE'
,p_attribute_03=>'P91_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('A\00E7\00E3o realizada com sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732868894744114814)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Colaborador'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'/*',
'delete from ANALISE_FUNC',
' where cod_empresa = :P91_cod_empresa',
'   and cod_analise_acidente = :P91_cod_analise_acidente;',
'*/',
'insert into REQ_ANALISE_FUNC',
'(COD_REQ,',
' COD_EMPRESA,',
' COD_ANALISE_ACIDENTE,',
' MATRICULA,',
' DC_MATRICULA,',
'TIPO_ANALISE,',
'COD_CCUSTO,',
'IND_OBITO,',
'DT_OBITO,',
'COD_FATOR_PESSOAL,',
'IND_ACIDENTE_ANTERIOR,',
'COD_ATO_INSEGURO,',
'IND_EXPERIENCIA_OPERACAO,',
'COD_CONDICAO_INSEGURA,',
'COD_AGENTE_LESAO,',
'COD_FATOR_TRABALHO,',
'IND_PROT_TIPO_ACIDENTE,',
'IND_AFASTAMENTO,',
'QUANTIDADE_DIAS_AFASTAMENTO,',
'DT_RETORNO,',
'CID,',
'CODIGO,',
'COD_EMPRESA_SUP_IMEDIATO,',
'MATRICULA_SUP_IMEDIATO,',
'DC_MATRICULA_SUP_IMEDIATO,',
'DIAGNO_PROVAVEL,',
'OBSERVACAO_CAT,',
'IND_DEPTO_POLICIAL,                      ',
'NUM_BOLETIM_OCORR,                    ',
'DATA_BOLETIM_OCORR,',
'usuario,',
'dt_atualizacao)',
' values(',
' :P91_COD_REQ,',
':P91_COD_EMPRESA,',
':P91_COD_ANALISE_ACIDENTE,',
':P91_MATRICULA,',
':P91_DC_MATRICULA,',
':P91_TIPO_ANALISE,',
':P91_COD_CCUSTO,',
':P91_IND_OBITO,',
':P91_DT_OBITO,',
':P91_COD_FATOR_PESSOAL,',
':P91_IND_ACIDENTE_ANTERIOR,',
':P91_COD_ATO_INSEGURO,',
':P91_IND_EXPERIENCIA_OPERACAO,',
':P91_COD_CONDICAO_INSEGURA,',
':P91_COD_AGENTE_LESAO,',
':P91_COD_FATOR_TRABALHO,',
':P91_IND_PROT_TIPO_ACIDENTE,',
':P91_IND_AFASTAMENTO,',
':P91_QTD_DIAS_AFASTAMENTO,',
':P91_DT_RETORNO,',
':P91_CID,',
':P91_CODIGO,',
':P91_COD_EMPRESA_SUP_IMEDIATO,',
':P91_MATRICULA_SUP_IMEDIATO,',
':P91_DC_MATRICULA_SUP_IMEDIATO,',
':P91_DIAGNO_PROVAVEL,',
':P91_OBSERVACAO_CAT,',
':P91_IND_DEPTO_POLICIAL,                      ',
':P91_NUM_BOLETIM_OCORR,                    ',
':P91_DATA_BOLETIM_OCORR,',
' :p_usuario,',
' sysdate);',
'',
'commit;',
'',
'exception',
'when no_data_found then',
'null;',
'   ',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732731847653973156)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Descri\00E7\00E3o do Acidente')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'/*',
'delete from ANALISE_ACIDENTE_DESCRICAO',
' where cod_empresa = :p91_cod_empresa',
'   and cod_analise_acidente = :p91_cod_analise_acidente;',
'*/',
'insert into ',
'REQ_ANALISE_ACIDENTE_DESCRICAO',
'(cod_req,',
' cod_empresa,',
' cod_analise_acidente,',
' num_ANALISE_ACIDENTE_DESCRICAO,',
' texto,',
' observacao,',
' usuario,',
' dt_atualizacao)',
'values',
'(:p91_cod_req,',
' :p91_cod_empresa,',
' :p91_cod_analise_acidente,',
' :p91_num_anal,',
' :p91_descricao_texto,',
' :p91_descricao_observacao,',
' :p_usuario,',
' sysdate',
');',
'',
'commit;',
'',
'exception',
'when others then',
unistr('raise_application_error(20000,''Erro ao gravar Descri\00E7\00E3o do Acidente: ''||sqlerrm);'),
'rollback;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96733066060049389825)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cancelar Requisicao'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update req_analise_acidente',
'   set cod_sit_req = 3,',
'       dt_sit_req = sysdate,',
'       usuario = :p_usuario,',
'       dt_atualizacao = sysdate',
' where cod_req = :p91_cod_req;',
' ',
' DELETE REQ_ANALISE_FUNC',
' WHERE  COD_REQ = :p91_cod_req;',
'',
' DELETE REQ_ANALISE_ACIDENTE_DESCRICAO',
' WHERE  COD_REQ = :p91_cod_req;',
'',
' DELETE ANALISE_ACIDENTE',
' WHERE  TO_CHAR(DT_ACIDENTE,''DD/MM/YYYY'') = :p91_dt_acidente',
' AND    MATRICULA          = :p91_matricula',
' AND    COD_EMPRESA        = :p91_cod_empresa;',
'   ',
'commit;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96733065944100389824)
,p_process_success_message=>'Cancelado com Sucesso!'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96733292845387523195)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_ANALISE_ACIDENTE.Post_Insert(:P91_COD_EMPRESA,',
'                        :P91_COD_REQ,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96732646131310973046)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(16981486711584938293)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-INSERT_LIMPA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'DELETE FROM REQ_ANALISE_FUNC_PARTE_LESADA R',
' WHERE  NOT EXISTS ( SELECT 1 FROM REQ_ANALISE_ACIDENTE A ',
'                      WHERE A.COD_REQ = R.COD_REQ)',
' AND DT_ATUALIZACAO < SYSDATE - 2;',
' ',
' COMMIT;',
' ',
' EXCEPTION ',
'   WHEN OTHERS ',
'     THEN NULL;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96732646131310973046)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96733292887560523196)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_ANALISE_ACIDENTE.Post_Update(:P91_COD_EMPRESA,',
'                        :P91_COD_REQ,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,CANCELAR'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(90802391392911472521)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza_CAT_Reprovado'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  CURSOR C_DADOS IS',
'   SELECT RA.*',
'     FROM REQ_ANALISE_ACIDENTE RA',
'    WHERE RA.COD_REQ = :P91_COD_REQ',
'      AND NOT EXISTS (SELECT 1 FROM analise_acidente ANAC',
'                       WHERE ANAC.COD_EMPRESA = RA.COD_EMPRESA',
'                         AND ANAC.MATRICULA = RA.MATRICULA',
'                         AND ANAC.DT_ACIDENTE = RA.DT_ACIDENTE);',
'',
'V_REQ_CAT REQ_ANALISE_ACIDENTE%ROWTYPE;',
'V_COD_ANALISE_ACIDENTE NUMBER;',
'',
'BEGIN',
'',
'  OPEN C_DADOS;',
'   FETCH C_DADOS INTO v_req_cat;',
'  CLOSE C_DADOS;',
'',
'        BEGIN ',
'        SELECT TRIM(NVL(TO_CHAR(MAX(TO_NUMBER(COD_ANALISE_ACIDENTE))+1),1)) COD_ANALISE_ACIDENTE',
'        INTO V_COD_ANALISE_ACIDENTE',
'        FROM ANALISE_ACIDENTE',
'        WHERE COD_EMPRESA = V_REQ_CAT.COD_EMPRESA;',
'        ',
'        EXCEPTION WHEN NO_DATA_FOUND THEN',
'         NULL;',
'        END;',
'',
'        IF V_COD_ANALISE_ACIDENTE IS NULL THEN ',
'         V_COD_ANALISE_ACIDENTE := 1;',
'        END IF;',
'        ',
' IF v_req_cat.cod_empresa IS NOT NULL THEN ',
'',
' begin',
' ',
' insert into analise_acidente',
'    (  cod_empresa',
'    ,  cod_analise_acidente',
'    ,  dt_acidente',
'    ,  dt_analise',
'    ,  hor_acidente',
'    ,  cod_local_trab',
'    ,  ds_local',
'    ,  cod_empresa_tec_seguranca',
'    ,  matricula_tec_seguranca',
'    ,  dc_matricula_tec_seguranca',
'    ,  cod_empresa_eng_seguranca',
'    ,  matricula_eng_seguranca',
'    ,  dc_matricula_eng_seguranca',
'    ,  cod_acidente_tipo',
'    ,  usuario',
'    ,  dt_atualizacao',
'    ,  ind_trajeto',
'    ,  matricula_analizador',
'    ,  espec_local_acidente',
'    ,  local_acidente',
'    ,  uf_local_acidente',
'    ,  dt_emissao_cat',
'    ,  num_protocolo',
'    ,  cipeiro_area',
'    ,  status_cat',
'    ,  dt_ult_dia_trab',
'    ,  horas_trab',
'    ,  serv_med_atend',
'    ,  dt_atend',
'    ,  hora_atend',
'    ,  observacao',
'    ,  cnpj_local_acidente',
'    ,  qtde_dias_tratamento',
'    ,  afastamento_imediato',
'    ,  matricula',
'    ,  cod_analise_2',
'    ,  tipo_local_acidente',
'    ,  cod_acidente_tipo_es',
'    ,  num_local_acidente',
'    ,  cod_cnes',
'    ,  tp_registro_cat',
'    ,  cod_med_emit_cat',
'    ,  cep_local',
'    ,  complemento_cep_loc',
'    ,  bairro_acidente',
'    ,  cidade_acidente',
'    ,  endereco_acidente',
'    ,  cod_mun_ibge',
'    ,  pais_acidente',
'    ,  cod_tp_logr',
'    ,  complemento',
'    ,  cx_postal',
'    ,  tp_logr_codigo_es',
'    ,  cod_emp_acidente',
'    ,  cod_fil_acidente',
'    ,  class_acidente',
'    ,  cod_emp_solicitante',
'    ,  mat_solicitante',
'    ,  origem_med_cat',
'    ,  arq',
'    ,  nome_arq',
'    ,  mimetype_arq',
'    ,  charset_arq',
'    ,  arq_bo',
'    ,  nome_arq_bo',
'    ,  mimetype_arq_bo',
'    ,  charset_arq_bo',
'    , cod_req)',
'  values',
'    ( v_req_cat.cod_empresa,',
'      V_COD_ANALISE_ACIDENTE,--v_req_cat.cod_analise_acidente,',
'      v_req_cat.dt_acidente,',
'      null,-- v_req_cat.dt_analise,',
'      v_req_cat.hor_acidente,',
'      v_req_cat.cod_local_trab,',
'      v_req_cat.ds_local,',
'      NULL,-- v_req_cat.cod_empresa_tec_seguranca,',
'      null,-- v_req_cat.matricula_tec_seguranca,',
'      null,-- v_req_cat.dc_matricula_tec_seguranca,',
'      null,-- v_req_cat.cod_empresa_eng_seguranca,',
'      null,-- v_req_cat.matricula_eng_seguranca,',
'      null,-- v_req_cat.dc_matricula_eng_seguranca,',
'      v_req_cat.cod_acidente_tipo,',
'      usuario.busca_user, --AQ DANIEL',
'      sysdate,',
'      v_req_cat.ind_trajeto,',
'      null,-- v_req_cat.matricula_analizador,',
'      v_req_cat.espec_local_acidente,',
'      v_req_cat.local_acidente,',
'      v_req_cat.uf_local_acidente,',
'      null,-- v_req_cat.dt_emissao_cat,',
'      null,-- v_req_cat.num_protocolo,',
'      null,-- v_req_cat.cipeiro_area,',
'      v_req_cat.status_cat,',
'      v_req_cat.dt_ult_dia_trab,',
'      v_req_cat.horas_trab,',
'      v_req_cat.serv_med_atend,',
'      v_req_cat.dt_atend,',
'      v_req_cat.hora_atend,',
'      v_req_cat.observacao,',
'      null,-- v_req_cat.cnpj_local_acidente,',
'      v_req_cat.qtde_dias_tratamento,',
'      v_req_cat.afastamento_imediato,',
'      v_req_cat.matricula,',
'      null,-- v_req_cat.cod_analise_2,',
'      v_req_cat.tipo_local_acidente,',
'      null,-- v_req_cat.cod_acidente_tipo_es,',
'      v_req_cat.num_local_acidente,',
'      null,-- v_req_cat.cod_cnes,',
'      v_req_cat.tp_registro_cat,',
'      v_req_cat.cod_med_emit_cat,',
'      v_req_cat.cep_local,',
'      v_req_cat.complemento_cep_loc,',
'      v_req_cat.bairro_acidente,',
'      v_req_cat.cidade_acidente,',
'      v_req_cat.endereco_acidente,',
'      v_req_cat.cod_mun_ibge,',
'      null,-- v_req_cat.pais_acidente,',
'      v_req_cat.cod_tp_logr,',
'      v_req_cat.complemento,',
'      null,-- v_req_cat.cx_postal,',
'      null,-- v_req_cat.tp_logr_codigo_es,',
'      v_req_cat.cod_emp_acidente,',
'      v_req_cat.cod_fil_acidente,',
'      null,-- v_req_cat.class_acidente,',
'      v_req_cat.cod_emp_solicitante,',
'      v_req_cat.mat_solicitante,',
'      v_req_cat.origem_med_cat,',
'      v_req_cat.arq,',
'      v_req_cat.nome_arq,',
'      v_req_cat.mimetype_arq,',
'      v_req_cat.charset_arq,',
'      v_req_cat.arq_bo,',
'      v_req_cat.nome_arq_bo,',
'      v_req_cat.mimetype_arq_bo,',
'      v_req_cat.charset_arq_bo,',
'      v_req_cat.cod_req);',
'    --',
'    COMMIT;',
'   exception',
'     when dup_val_on_index then',
'       begin',
'          select cod_analise_acidente',
'          into   V_COD_ANALISE_ACIDENTE',
'          from   analise_acidente',
'          where  dt_acidente = v_req_cat.dt_acidente',
'          and    matricula   = v_req_cat.matricula',
'          and    cod_empresa = v_req_cat.cod_empresa;',
'        end;',
'   end;',
'   ',
' END IF;',
'END;',
''))
,p_process_error_message=>'Erro ao reportar ao CAT - #SQLERRM#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from REQ_ANALISE_ACIDENTE a',
'where a.cod_req = :p91_cod_req',
'and a.COD_EMPRESA = :P91_COD_EMPRESA',
'and a.COD_SIT_REQ = 4;',
''))
,p_process_when_type=>'EXISTS'
,p_process_success_message=>unistr('A\00E7\00E3o realizada com sucesso !')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(96732730681130973155)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(96732646546754973046)
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
