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
,p_default_id_offset=>760785258018494993
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   10:15 Wednesday September 30, 2026
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
,p_user_interface_id=>wwv_flow_api.id(173299740219489526297)
,p_name=>unistr('Criar/Editar: Requisi\00E7\00E3o de Atestados e Afastamentos')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Criar/Editar: Requisi\00E7\00E3o de Atestados e Afastamentos')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#jquery.maskedinput.min.js',
'#WORKSPACE_IMAGES#forms-functions.js',
'#WORKSPACE_IMAGES#jquery.maskMoney.min.js'))
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(function() {',
'  ',
'    if (apex.item("P91_ROWID").getValue().length == 0){',
'        $.mask.definitions[''~''] = "[+-]";          ',
'        /*',
'        $("#P91_DT_VACINA").mask(''99/99/9999'');',
'',
'  ',
'        $("#P91_DT_PROX_DOSE").mask(''99/99/9999'');',
'',
'  ',
'        $("#P91_VALIDADE").mask(''99/99/9999'');',
'    ',
'      ',
'        $("#P91_DT_VACINA").blur();',
'',
'        $("#P91_CUSTO_VACINA").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'        */',
'    }',
'  });',
' ',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P91_ARQ_IMG{',
'    max-width: 100%;',
'}',
'',
'#REVISAR{',
'color: #383838 !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_last_updated_by=>'ANDRE.BONI'
,p_last_upd_yyyymmddhh24miss=>'20260724153950'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157145317023521765932)
,p_plug_name=>'Cadastro de Atestado / Afastamento'
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(173299706145157526189)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(138682836495102239213)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(157145317023521765932)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(138682836542470239214)
,p_plug_name=>'Dados do Atestado'
,p_parent_plug_id=>wwv_flow_api.id(157145317023521765932)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'FUNCTION_BODY'
,p_plug_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from aprova_atestado',
' where cod_solicitacao = :p91_cod_req',
'   and status_aprov = ''A''',
'   and mat_aprov <> :p91_mat_solicitante;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    if :p91_rowid is not null',
'    and :p_empresa_user = :p91_cod_empresa ',
'    and :p_matricula_user = :p91_matricula ',
'    and :p91_cod_sit_req = 1 ',
'    and nvl(v_c1.existe,''N'') = ''N''',
'    then',
'        return false;',
'    elsif :p91_rowid is null then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(138682837153135239220)
,p_plug_name=>'Log'
,p_parent_plug_id=>wwv_flow_api.id(157145317023521765932)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157145010593775580169)
,p_plug_name=>'Documento'
,p_parent_plug_id=>wwv_flow_api.id(157145317023521765932)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_URL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select 1',
'    from req_atestado_funcionario',
'   where rowid = :P91_ROWID',
'     and dbms_lob.getlength(arq_1_anexo) > 0',
'     and instr(arq_1_mimetype,''pdf'') > 0'))
,p_attribute_01=>'&P91_URL_PDF.'
,p_attribute_02=>'IFRAME'
,p_attribute_03=>'type="application/pdf" style="width: 100%; height: 517px; border: 0px"'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157145330648931765948)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(173299706228329526190)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(157167826185221014600)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>6
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P91_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(158361392216793450174)
,p_name=>unistr('Hist\00F3rico')
,p_template=>wwv_flow_api.id(173299714222651526203)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select',
'  rl.cod_req id,',
'  apex_string.get_initials(rl.remetente) user_icon,',
'  to_char(rl.dt_log,''dd/mm/rrrr hh24:mi'') comment_date,',
'  initcap(rl.remetente) user_name,',
'  rl.mensagem_txt comment_text,',
'  '' '' actions,',
'  '' '' attribute_1,',
'  '' '' attribute_2,',
'  '' '' attribute_3,',
'  '' '' attribute_4,',
'  rl.dt_log task_created,',
'  rl.remetente task_owner,',
unistr('  ''Retorno da An\00E1lise'' task_name,'),
'  --''u-color-''||ora_hash(rl.dt_log,45) icon_modifier',
'  ''u-color-1'' icon_modifier',
'from',
'  REQ_ATESTADO_FUNCIONARIO_LOG rl,',
'  REQ_ATESTADO_FUNCIONARIO r',
'where',
'  rl.cod_req = r.cod_req',
'  and rl.cod_req = :p91_cod_req',
'  --and r.cod_sit_req <> 1',
'order by rl.dt_log desc'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from',
'  req_atestado_funcionario_log rl,',
'  req_atestado_funcionario r',
'where',
'  rl.cod_req = r.cod_req',
'  and r.cod_req = :p91_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(173299722501850526218)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682751340367165572)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682751759787165577)
,p_query_column_id=>2
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>2
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682752158761165577)
,p_query_column_id=>3
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>3
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682752534841165578)
,p_query_column_id=>4
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>4
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682753000576165578)
,p_query_column_id=>5
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>5
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682753342071165578)
,p_query_column_id=>6
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>6
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682753815056165578)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>7
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682754148552165579)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>8
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682754560473165579)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>9
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682754985117165579)
,p_query_column_id=>10
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>10
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682755364975165579)
,p_query_column_id=>11
,p_column_alias=>'TASK_CREATED'
,p_column_display_sequence=>11
,p_column_heading=>'Task Created'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682755766479165579)
,p_query_column_id=>12
,p_column_alias=>'TASK_OWNER'
,p_column_display_sequence=>12
,p_column_heading=>'Task Owner'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682756128421165580)
,p_query_column_id=>13
,p_column_alias=>'TASK_NAME'
,p_column_display_sequence=>13
,p_column_heading=>'Task Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682756595375165580)
,p_query_column_id=>14
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>14
,p_column_heading=>'Icon Modifier'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(162291895619387095739)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(173299714222651526203)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--hideNoPagination'
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
'       /*u.nm_usuario_oracle*/null event_date,',
'       fnct_nome_func(a.cod_emp_aprov,a.mat_aprov) user_name,',
'       case when a.status_aprov = ''P'' then null ',
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
'  from aprova_atestado a, usuario_oracle u',
' where a.cod_solicitacao = :p91_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil',
'                  AND ATIVO = ''S'')',
'                         --and u.cd_perfil in ''MASTER''                ',
'             and u.rowid = (select min(u2.rowid)',
'                 from usuario_oracle u2',
'                where (u2.cd_empresa = a.cod_empresa or u2.cd_empresa = a.cod_emp_aprov) --where u2.cd_empresa = a.cod_empresa',
'                  and u2.cd_matricula = a.mat_aprov',
'                           and u2.id_bloqueio = ''N'' )  ',
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
'  from aprova_atestado a, usuario_oracle u',
' where a.cod_solicitacao = :p91_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from aprova_atestado a',
' where a.cod_solicitacao = :p91_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P91_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(168103885044970466918)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683711133650657236)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683711557811657243)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683711954341657244)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683712376614657244)
,p_query_column_id=>4
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683712790823657245)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683713198812657245)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683713593689657245)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138683713944920657245)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_report_column_width=>200
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645341606689804)
,p_query_column_id=>9
,p_column_alias=>'USER_AVATAR'
,p_column_display_sequence=>9
,p_column_heading=>'User Avatar'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645422642689805)
,p_query_column_id=>10
,p_column_alias=>'EVENT_DATE'
,p_column_display_sequence=>10
,p_column_heading=>'Event Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645529881689806)
,p_query_column_id=>11
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>11
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645628391689807)
,p_query_column_id=>12
,p_column_alias=>'EVENT_TITLE'
,p_column_display_sequence=>12
,p_column_heading=>'Event Title'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682646870217689819)
,p_query_column_id=>13
,p_column_alias=>'EVENT_DESC'
,p_column_display_sequence=>18
,p_column_heading=>'Event Desc'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645784309689808)
,p_query_column_id=>14
,p_column_alias=>'OWNER'
,p_column_display_sequence=>13
,p_column_heading=>'Owner'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645894840689809)
,p_query_column_id=>15
,p_column_alias=>'EVENT_ICON'
,p_column_display_sequence=>14
,p_column_heading=>'Event Icon'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682645934919689810)
,p_query_column_id=>16
,p_column_alias=>'EVENT_STATUS'
,p_column_display_sequence=>15
,p_column_heading=>'Event Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682646102907689811)
,p_query_column_id=>17
,p_column_alias=>'EVENT_TYPE'
,p_column_display_sequence=>16
,p_column_heading=>'Event Type'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(138682646143342689812)
,p_query_column_id=>18
,p_column_alias=>'USER_COLOR'
,p_column_display_sequence=>17
,p_column_heading=>'User Color'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(72480285325462556559)
,p_plug_name=>'Justificativa'
,p_parent_plug_id=>wwv_flow_api.id(162291895619387095739)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(173299714222651526203)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct justificativa ',
'from aprova_atestado ',
'where cod_solicitacao = :P91_COD_REQ',
'and justificativa is not null'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_query_no_data_found=>'--'
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from aprova_atestado ',
'where cod_solicitacao = :P91_COD_REQ',
'and justificativa is not null'))
,p_attribute_02=>'JUSTIFICATIVA'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138683715022762657250)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(157167826185221014600)
,p_button_name=>'APROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(173299735187969526247)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'BODY'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P91_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_flag        VARCHAR2(1);',
'    v_mensagem    VARCHAR2(4000);',
'    v_matricula   NUMBER;',
'    v_ccusto      NUMBER;',
'    v_filial      NUMBER;',
'    v_conta       NUMBER := 0;',
'    v_per         VARCHAR2(1);',
'BEGIN',
'    IF :P_PAINEL = ''PC'' THEN    ',
'        RETURN FALSE;',
'    END IF;',
'    IF :P_PAINEL = ''PO'' THEN    ',
'        begin',
'',
'            select count(*)',
'                into v_conta',
'            from req_atestado_funcionario r,',
'                informacoes_funcionais i,',
'                aprovacao_ccusto a',
'            where i.cod_empresa = r.cod_empresa',
'            and i.matricula = r.matricula',
'            and i.cod_empresa = a.cod_empresa',
'            and a.cod_filial = i.filial',
'            and a.cod_ccusto = i.cod_ccusto',
'            and a.matricula = :P_MATRICULA_USER',
'            and r.cod_req = :P91_COD_REQ',
'            and r.cod_sit_req not in (2,3,4,5)',
'            and i.situacao < ''90''',
'            and a.per_atestado = ''S''',
'            and a.condicao_atestado != 99',
'            -----------and a.cod_emp_aprov = r.cod_empresa',
'            --and (a.matricula = :P_MATRICULA_USER',
'            --             or :P_USUARIO = ''SUPORTE_NATCORP'')',
'                         ;',
'',
'        end;',
'        if v_conta > 0 then',
'            return true;',
'        end if;',
'    END IF;',
unistr('    -- 1 Primeira verifica\00E7\00E3o: regra do painel PG'),
'    IF :P_PAINEL = ''PG'' THEN',
'        BEGIN',
'            SELECT i.matricula, i.cod_ccusto, i.filial',
'              INTO v_matricula, v_ccusto, v_filial',
'              FROM req_atestado_funcionario r,',
'                   informacoes_funcionais_cad i',
'             WHERE r.cod_empresa = i.cod_empresa',
'               AND r.matricula   = i.matricula',
'               AND r.cod_req     = :P91_COD_REQ;',
'',
'            SELECT MAX(per_atestado)',
'              INTO v_per',
'              FROM aprovacao_ccusto',
'             WHERE per_atestado = ''S''',
'               AND matricula    = v_matricula',
'               AND cod_ccusto   = v_ccusto',
'               AND cod_filial   = v_filial;',
'        EXCEPTION',
'            WHEN NO_DATA_FOUND THEN',
'                v_per := ''N'';',
'        END;',
'',
unistr('        -- Se tiver per_atestado = ''S'', o bot\00E3o N\00C3O deve aparecer'),
'        IF v_per = ''S'' THEN',
'            RETURN FALSE;',
'        END IF;',
'    END IF;',
'',
unistr('    -- 2 Segunda verifica\00E7\00E3o: situa\00E7\00E3o da requisi\00E7\00E3o'),
'    IF :P91_COD_SIT_REQ = 1 THEN',
'        pkg_req_atestado.Valida_Sequencia(',
'             pcod_empresa => :P91_COD_EMPRESA,',
'             psolicitacao => :P91_COD_REQ,',
'             pemp_aprov   => :P_EMPRESA_USER,',
'             pmat_aprov   => :P_MATRICULA_USER,',
'             pflg_retorno => v_flag,',
'             pmsg_retorno => v_mensagem',
'        );',
'',
'        IF v_flag = ''S'' THEN',
'            RETURN TRUE;',
'        ELSE',
'            RETURN FALSE;',
'        END IF;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
,p_button_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
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
'end;'))
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138683714689202657247)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(157167826185221014600)
,p_button_name=>'REPROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(173299735187969526247)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'BODY'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P91_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'    v_matricula   NUMBER;',
'    v_ccusto      NUMBER;',
'    v_filial      NUMBER;',
'    v_conta       NUMBER := 0; ',
'    v_per         VARCHAR2(1);',
'',
'begin ',
'    IF :P_PAINEL = ''PC'' THEN    ',
'        RETURN FALSE;',
'    END IF;',
'    IF :P_PAINEL = ''PO'' THEN    ',
'        begin',
'',
'            select count(*)',
'                into v_conta',
'            from req_atestado_funcionario r,',
'                informacoes_funcionais i,',
'                aprovacao_ccusto a',
'            where i.cod_empresa = r.cod_empresa',
'            and i.matricula = r.matricula',
'            and i.cod_empresa = a.cod_empresa',
'            and a.cod_filial = i.filial',
'            and a.cod_ccusto = i.cod_ccusto',
'            and a.matricula = :P_MATRICULA_USER',
'            and r.cod_req = :P91_COD_REQ',
'            and r.cod_sit_req not in (2,3,4,5)',
'            and i.situacao < ''90''',
'            and a.per_atestado = ''S''',
'            and a.condicao_atestado != 99',
'            --------and a.cod_emp_aprov = r.cod_empresa',
'            --and (a.matricula = :P_MATRICULA_USER',
'            --             or :P_USUARIO = ''SUPORTE_NATCORP'')',
'                         ;',
'        end;',
'        if v_conta > 0 then',
'            return true;',
'        end if;',
'    END IF;',
unistr('  -- 1 Primeira verifica\00E7\00E3o: regra do painel PG'),
'    IF :P_PAINEL = ''PG'' THEN',
'        BEGIN',
'            SELECT i.matricula, i.cod_ccusto, i.filial',
'              INTO v_matricula, v_ccusto, v_filial',
'              FROM req_atestado_funcionario r,',
'                   informacoes_funcionais_cad i',
'             WHERE r.cod_empresa = i.cod_empresa',
'               AND r.matricula   = i.matricula',
'               AND r.cod_req     = :P91_COD_REQ;',
'',
'            SELECT MAX(per_atestado)',
'              INTO v_per',
'              FROM aprovacao_ccusto',
'             WHERE per_atestado = ''S''',
'               AND matricula    = v_matricula',
'               AND cod_ccusto   = v_ccusto',
'               AND cod_filial   = v_filial;',
'        EXCEPTION',
'            WHEN NO_DATA_FOUND THEN',
'                v_per := ''N'';',
'        END;',
'',
unistr('        -- Se tiver per_atestado = ''S'', o bot\00E3o N\00C3O deve aparecer'),
'        IF v_per = ''S'' THEN',
'            RETURN FALSE;',
'        END IF;',
'    END IF;',
'    ',
unistr('    -- 2 Segunda verifica\00E7\00E3o: situa\00E7\00E3o da requisi\00E7\00E3o'),
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
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138683619162488681499)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(157167826185221014600)
,p_button_name=>'REVISAR'
,p_button_static_id=>'REVISAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--simple:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(173299735187969526247)
,p_button_image_alt=>unistr('Solicitar Revis\00E3o')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_button_css_classes=>' '
,p_icon_css_classes=>'fa-exclamation-triangle-o'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682643251154689783)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(157167826185221014600)
,p_button_name=>'CANCELAR_REQ'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(173299735187969526247)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_param is',
'    select operador_cancela_concluida, operador_cancela_requisicoes',
'        from parametros_recursos_humanos t',
'            where cod_empresa = :P91_COD_EMPRESA;',
'    r_param    c_param%rowtype;',
'    ',
'    v_aprovado number;',
'begin',
'',
unistr('   --Verifica se existe aprova\00E7\00E3o'),
'   /* SELECT COUNT(1)',
'      INTO v_aprovado',
'      FROM aprova_atestado a',
'     WHERE a.cod_solicitacao = :P91_COD_REQ',
'       AND a.status_aprov = ''A'';',
'',
'    IF v_aprovado > 0 THEN',
'        RETURN FALSE;',
'    END IF;   */',
'    ',
unistr('    -- Se tiver com o status da requisi\00E7\00E3o como conclu\00EDda n\00E3o pode cancelar'),
'    IF :P91_COD_SIT_REQ = 2 AND :P_PAINEL != ''PO'' THEN',
'        RETURN FALSE;',
'    END IF; ',
'',
'    if :P91_COD_SIT_REQ = 3 then',
'        return false;',
'    end if;',
'    open c_param;',
'    fetch c_param into r_param;',
'    close c_param;',
'    if r_param.operador_cancela_concluida = ''N'' and :P91_COD_SIT_REQ = 2 then',
'       return false;         ',
'    else',
'      if r_param.operador_cancela_requisicoes = ''S'' then ',
'         return true; --dbms_output.put_line(''1-pode cancelar qualquer'');      ',
'      else',
'         return false;     --dbms_output.put_line(''4-nao pode cancelar qualquer'');',
'      end if;',
'    end if;     ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-trash'
,p_grid_new_row=>'Y'
,p_security_scheme=>wwv_flow_api.id(156725431121944387057)
,p_database_action=>'UPDATE'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138683939109319163573)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_button_name=>'CADASTRAR_ENTIDADE'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_image_alt=>'+ Cadastrar Entidade'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:3:&SESSION.::&DEBUG.:RP,3::'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from dual',
'where :P_PAINEL not in (''PG'', ''PC'')'))
,p_button_condition_type=>'EXISTS'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682646923088689820)
,p_button_sequence=>210
,p_button_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_button_name=>'CADASTRAR_MEDICO'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--link'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_image_alt=>unistr('+ Cadastrar M\00E9dico')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=MT_CAD_&P_BASE.:39:&SESSION.::&DEBUG.:RP,39::'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682767695935165867)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(157145330648931765948)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682768077889165872)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(157145330648931765948)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682768442649165872)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(157145330648931765948)
,p_button_name=>'SAVE'
,p_button_static_id=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from aprova_atestado',
' where cod_solicitacao = :p91_cod_req',
'   and status_aprov = ''A''',
'   and mat_aprov <> :p91_mat_solicitante;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    if :p91_rowid is not null',
'    and :p_empresa_user = :p91_cod_empresa ',
'    and :p_matricula_user = :p91_matricula ',
'    and :p91_cod_sit_req = 1 ',
'    and nvl(v_c1.existe,''N'') = ''N''',
'    then',
'        return true;',
'    elsif :p91_rowid is null then',
'        return false;',
'    else',
'        return false;',
'    end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_security_scheme=>wwv_flow_api.id(156725431351989387058)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(138682768884877165873)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(157145330648931765948)
,p_button_name=>'CREATE'
,p_button_static_id=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(173299735014249526247)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P91_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(54754728894601551326)
,p_name=>'P91_TIPO_ATESTADO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Tipo Atestado'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56128747945896568793)
,p_name=>'P91_HORA_TERMINO_AFASTAMENTO_DSP'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Hora Termino Afastamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56129800064595782944)
,p_name=>'P91_HORA_INICIO_AFASTAMENTO_DSP'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Hora Inicio Afastamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56129800110636782945)
,p_name=>'P91_DT_INICIO_AFASTAMENTO_DSP'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Dt Inicio Afastamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56129800279602782946)
,p_name=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Dt Termino Afastamento Dsp'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56129800558873782949)
,p_name=>'P91_CONSULTA'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(56129800953789782953)
,p_name=>'P91_QTDE_DIAS_AFASTAMENTO_DSP'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Qtde Dias Afastamento Dsp'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(124998900264300880755)
,p_name=>'P91_OPERADOR_DELETA'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(124998900434426880756)
,p_name=>'P91_OPERADOR_DELETA_DEMAIS'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137418779375787332612)
,p_name=>'P91_COD_SIT_FUNC'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137589787754352623180)
,p_name=>'P91_COD_ENTIDADE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682643174198689782)
,p_name=>'P91_MENSAGEM_TXT'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682757288052165599)
,p_name=>'P91_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682757543075165822)
,p_name=>'P91_COD_EMPRESA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(cod||'' - ''||nvl(nome_abrev,nome)) descricao, cod',
'  from empresas',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682757823817165824)
,p_name=>'P91_MATRICULA'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct  colaborador, MATRICULA',
'FROM (',
'SELECT ',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador, ',
'       I.MATRICULA  ',
' FROM INFORMACOES_FUNCIONAIS I,',
'       CENTRO_DE_CUSTO C,',
'       sub_ccusto sc',
' WHERE i.cod_empresa = c.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   ',
'   AND  i.cod_empresa = SC.cod_empresa(+)',
'   and i.COD_SUB_CCUSTO = SC.COD_SUB_CCUSTO(+)',
'   and c.cod = SC.COD_CCUSTO(+) ',
'  ',
'    AND CASE WHEN :P_PAINEL = ''PG'' AND I.MATRICULA = :P_MATRICULA_USER THEN',
'        1',
'    ELSE',
'        2',
'    END = 2 ',
'',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL) = ''S''',
'',
' and ((sc.mat_gestor = :P_MATRICULA_USER or sc.mat_subs = :P_MATRICULA_USER)   ',
'   OR (C.MATRICULA_GESTOR = :P_MATRICULA_USER or C.MATRICULA_SUPLENTE = :P_MATRICULA_USER))',
'   AND (NVL(:P204_chk_colaboradores_diretos, ''S'') = ''S'' )',
'    AND I.COD_EMPRESA = :P91_COD_EMPRESA',
'UNION',
'',
'SELECT ',
'       I.MATRICULA||'' - ''||Initcap(fnct_nome_func(i.cod_empresa, i.matricula)) colaborador, ',
'       I.MATRICULA  ',
'FROM INFORMACOES_FUNCIONAIS I,',
'  CENTRO_DE_CUSTO C',
' WHERE i.cod_empresa = c.cod_empresa --(+)',
'   and i.cod_ccusto = c.cod --(+)',
'    ',
'    AND CASE WHEN :P_PAINEL = ''PG'' AND I.MATRICULA = :P_MATRICULA_USER THEN',
'        1',
'    ELSE',
'        2',
'    END = 2',
'    ',
'    AND PKG_MATRICULA_LISTAGEM.RETORNA_MOSTRA(P_COD_EMPRESA  => :P_EMPRESA_USER',
'                                ,P_MATRICULA   => :P_MATRICULA_USER',
'                                ,P_USUARIO     => :P_USUARIO',
'                                ,P_LOGADO      => I.MATRICULA',
'                                ,P_PAINEL      => :P_PAINEL',
'                                ,P_VER_PONTO   => ''N'') = ''S''',
'      ',
'   AND (NVL(:P204_chk_colaboradores_diretos,''N'') = ''N'' )    ',
'    AND I.COD_EMPRESA = :P91_COD_EMPRESA',
') ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_COD_EMPRESA,P91_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682758299409165826)
,p_name=>'P91_DC_MATRICULA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682762660466165837)
,p_name=>'P91_ENTIDADE_LOV'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Entidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select e.nome_entidade||'' [C\00F3digo ''||e.cod_entidade||'']'' d'),
'      ,e.rowid r',
'  from entidade e',
' where e.tipo_entidade in (1,7)',
' order by e.nome_entidade'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>5
,p_display_when_type=>'NEVER'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682763084263165837)
,p_name=>'P91_COD_ENTIDADE_DSP'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_prompt=>'Entidade'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select e.nome_entidade||'' [C\00F3digo ''||e.cod_entidade||'']'' descricao'),
'      ,e.cod_entidade||'':''||e.tipo_entidade codigo',
'  from entidade e',
' where e.tipo_entidade in (1,7)',
' order by e.nome_entidade'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682763503854165837)
,p_name=>'P91_TIPO_ENTIDADE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_ENTIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682765023790165858)
,p_name=>'P91_DT_ATUALIZACAO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(138682837153135239220)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Atualiza\00E7\00E3o')
,p_format_mask=>'dd/mm/rrrr hh24:mi'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_grid_label_column_span=>3
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682765500776165859)
,p_name=>'P91_USUARIO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(138682837153135239220)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Usu\00E1rio')
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682765849043165859)
,p_name=>'P91_URL_PDF'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682832550527239174)
,p_name=>'P91_COD_REQ'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682832653154239175)
,p_name=>'P91_DT_REQ'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Requisi\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682832739465239176)
,p_name=>'P91_COD_SIT_REQ'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Em Aberto;1,Concluida;2,Cancelada;3,Reprovada;4,Aprovada;5,Suspensa;6'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682832905318239177)
,p_name=>'P91_DT_SIT_REQ'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Situa\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682832971018239178)
,p_name=>'P91_COD_EMP_SOLICITANTE'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
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
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833089184239179)
,p_name=>'P91_MAT_SOLICITANTE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Matricula Solicitante'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||nome descricao, matricula cod',
'  from inf_pessoais_cad',
' where cod_empresa = :p91_cod_emp_solicitante'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P91_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833135820239180)
,p_name=>'P91_COD_ATESTADO_MEDICO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('C\00F3digo Atestado')
,p_source=>'COD_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select a.descricao||'' [C\00F3digo ''||a.cod_atestado_medico||'']'' descr_atest, a.cod_atestado_medico '),
'from Atestado_Medico A,',
' Motivo_Alteracoes M',
'where   M.COD = A.COD_MOT_ATESTADO',
'and not  exists (select 1 from pe_atestado_perfil where cd_perfil = :P_PERFIL )',
'union ',
unistr(' Select a.descricao||'' [C\00F3digo ''||a.cod_atestado_medico||'']'' descr_atest,'),
' a.cod_atestado_medico',
' From Atestado_Medico A,',
'               PE_ATESTADO_PERFIL p',
'where p.cod_atestado_medico = a.cod_atestado_medico',
'and cd_perfil = :P_PERFIL',
'and p.cod_empresa = :P91_COD_EMPRESA',
'order by 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833242597239181)
,p_name=>'P91_DT_ATESTADO_MEDICO'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data do Atestado'
,p_source=>'DT_ATESTADO_MEDICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833353855239182)
,p_name=>'P91_COD_PREST_SERV'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('M\00E9dico')
,p_source=>'COD_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select nome||'' ''||sigla||'' ''||nr_documento||''-''||uf_documento||'' [C\00F3digo ''||COD||'']'' d'),
'       ,cod r',
'  from vw_medicos',
'  WHERE origem = nvl(:P91_ORIGEM_MED,origem)',
' order by NOME'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_ORIGEM_MED'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833424069239183)
,p_name=>'P91_TIPO_PREST_SERV'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_source=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833613971239184)
,p_name=>'P91_DT_INICIO_AFASTAMENTO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data In\00EDcio Afastamento')
,p_source=>'DT_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953605071781879989)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833631190239185)
,p_name=>'P91_HORA_INICIO_AFASTAMENTO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Hora In\00EDcio Afastamento')
,p_placeholder=>'00:00'
,p_source=>'HORA_INICIO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833780686239186)
,p_name=>'P91_HORA_TERMINO_AFASTAMENTO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Hora T\00E9rmino Afastamento')
,p_placeholder=>'00:00'
,p_source=>'HORA_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833862271239187)
,p_name=>'P91_QTDE_HORAS_ABONADAS'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'QTDE_HORAS_ABONADAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682833973624239188)
,p_name=>'P91_COD_MOTIVO'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo'
,p_source=>'COD_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' Select M.Descricao||'' [C\00F3digo ''||m.cod||'']'' descr_mot, M.Cod '),
' From Atestado_Medico A,',
'      Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'and A.cod_atestado_medico = :P91_COD_ATESTADO_MEDICO',
'order by a.cod_atestado_medico'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P91_COD_ATESTADO_MEDICO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_cMaxlength=>3
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834048140239189)
,p_name=>'P91_DESC_MOTIVO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'DESC_MOTIVO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834162613239190)
,p_name=>'P91_COD_DOENCA'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'C.I.D.'
,p_source=>'COD_DOENCA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_DOENCA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select substr(cod_doenca,1,5)||'' - ''||descricao d',
'       ,cod_doenca r',
'from doenca ',
'order by cod_doenca'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834305055239191)
,p_name=>'P91_OCUPACIONAL'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>'Ocupacional'
,p_source=>'OCUPACIONAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC2:Sim;S,N\00E3o;N')
,p_colspan=>4
,p_display_when=>'select 1 from dual where 1=2'
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834323334239192)
,p_name=>'P91_OBSERVACAO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834514394239193)
,p_name=>'P91_CID_FAMILIA'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'CID_FAMILIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834565342239194)
,p_name=>'P91_DT_ALT_PROG'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Alta Programada'
,p_source=>'DT_ALT_PROG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834704009239195)
,p_name=>'P91_DT_PERICIA'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Per\00EDcia')
,p_source=>'DT_PERICIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834715706239196)
,p_name=>'P91_ORIGEM_MED'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'ORIGEM_MED'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834868214239197)
,p_name=>'P91_QTDE_DIAS_AFASTAMENTO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Qtde. Dias Afastamento'
,p_source=>'QTDE_DIAS_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682834998334239198)
,p_name=>'P91_COD_MOTIVO_ES'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MOTIVO_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835105654239199)
,p_name=>'P91_TIPO_ACIDENTE_ES'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo Acidente'
,p_source=>'TIPO_ACIDENTE_ES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_TIPO_ACIDENTE'
,p_lov=>'.'||wwv_flow_api.id(162045274977943101781)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835215308239200)
,p_name=>'P91_CRM_PREST_SERV_RESP'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'CRM_PREST_SERV_RESP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835233103239201)
,p_name=>'P91_UF_CRM_PREST_RESP'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'UF_CRM_PREST_RESP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835339877239202)
,p_name=>'P91_INFOMESMOMTV'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'INFOMESMOMTV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835464724239203)
,p_name=>'P91_COD_JUSTIFICATIVA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Justificativa'
,p_source=>'COD_JUSTIFICATIVA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr(' select J.descricao||'' [C\00F3digo ''||J.COD_JUSTIFICATIVA||'']'' d'),
'       ,J.cod_justificativa r',
'  from pe_tipo_justificativa J, ATESTADO_MEDICO_PD_JUS A',
' where j.cod_empresa = a.cod_empresa',
'   and j.cod_justificativa = a.cod_justificativa',
'   and J.cod_empresa = :P91_COD_EMPRESA ',
'   and a.cod_atestado_medico = :p91_cod_atestado_medico',
' order by DESCRICAO'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P91_COD_EMPRESA,P91_COD_ATESTADO_MEDICO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835542171239204)
,p_name=>'P91_DT_TERMINO_AFASTAMENTO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data T\00E9rmino Afastamento')
,p_source=>'DT_TERMINO_AFASTAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(156953605071781879989)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835641889239205)
,p_name=>'P91_ARQ_1_ANEXO'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Documento Comprobat\00F3rio')
,p_source=>'ARQ_1_ANEXO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(156953604754823879988)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ARQ_1_MIMETYPE'
,p_attribute_03=>'ARQ_1_NOME'
,p_attribute_04=>'ARQ_1_CHARSET'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835811117239206)
,p_name=>'P91_ARQ_1_NOME'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_1_NOME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835863955239207)
,p_name=>'P91_ARQ_1_MIMETYPE'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_1_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682835956485239208)
,p_name=>'P91_ARQ_1_CHARSET'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_1_CHARSET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682836056092239209)
,p_name=>'P91_ARQ_2_ANEXO'
,p_item_sequence=>580
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_2_ANEXO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682836166230239210)
,p_name=>'P91_ARQ_2_NOME'
,p_item_sequence=>590
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_2_NOME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682836306128239211)
,p_name=>'P91_ARQ_2_MIMETYPE'
,p_item_sequence=>600
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_2_MIMETYPE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682836389136239212)
,p_name=>'P91_ARQ_2_CHARSET'
,p_item_sequence=>610
,p_item_plug_id=>wwv_flow_api.id(157145010593775580169)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_2_CHARSET'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682837288778239221)
,p_name=>'P91_OK'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682837396748239222)
,p_name=>'P91_FLAG'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138682929793117814473)
,p_name=>'P91_MENSAGEM'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(138682836495102239213)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138683699602283483266)
,p_name=>'P91_ARQ_IMG'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(138682836542470239214)
,p_use_cache_before_default=>'NO'
,p_source=>'ARQ_1_ANEXO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_grid_label_column_span=>0
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select 1',
'    from REQ_ATESTADO_FUNCIONARIO',
'   where rowid = :P91_ROWID',
'     and dbms_lob.getlength(arq_1_ANEXO) > 0',
'     and instr(ARQ_1_mimetype,''image'') > 0'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(173299734573645526240)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_04=>'ARQ_1_NOME'
,p_attribute_07=>'ARQ_1_MIMETYPE'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(138682775703322165937)
,p_computation_sequence=>10
,p_computation_item=>'P91_URL_PDF'
,p_computation_point=>'AFTER_HEADER'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return ''f?p='' || :APP_ID || '':'' ',
'              || :APP_PAGE_ID || '':'' ',
'              || :APP_SESSION || '':''',
'              || ''APPLICATION_PROCESS=RENDER'' || '':''',
'              || :DEBUG ||',
'               ''&x01='' || :P91_ROWID;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(138682775991653165938)
,p_computation_sequence=>10
,p_computation_item=>'P91_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'to_char(sysdate,''dd/mm/rrrr hh24:mi'')'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(138682776331544165938)
,p_computation_sequence=>10
,p_computation_item=>'P91_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':p_usuario'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(138683939947922163582)
,p_validation_name=>'validar_dt'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(1000);',
'',
'begin',
'',
'  pkg_mt_cad_atest_medico.prc_validar_dt_inicio(:p91_cod_empresa, :p91_matricula, :P91_dt_inicio_afastamento, v_flg, v_msg);',
'',
'if v_flg = ''N'' and v_msg is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682833613971239184)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(138683940529905163588)
,p_validation_name=>'Validar_Data'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(1000);',
'',
'begin',
'    pkg_req_atestado.Valida_Data(pcod_empresa => :p91_cod_empresa,',
'                                  pmatricula => :p91_matricula,',
'                                  pdata => :p91_dt_inicio_afastamento,',
'                                  pcod_atestado => :p91_cod_atestado_medico,',
'                                  pflg_retorno => v_flg,',
'                                  pmsg_retorno => v_msg);',
'',
'    if v_flg = ''N'' and v_msg is not null then',
'        return v_msg;',
'    end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(138682833613971239184)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(137917141144758761158)
,p_validation_name=>'Obriga Anexo'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'SELECT OBRIGA_COMPROVANTE',
'  FROM pe_tipo_justificativa ',
' where cod_empresa = :p91_cod_empresa',
'   and cod_justificativa = :p91_cod_justificativa;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p91_arq_1_anexo is null and nvl(v_c1.obriga_comprovante,''N'') = ''S'' then',
'return ''Anexe o documento comprobatorio!'';',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(138682768884877165873)
,p_associated_item=>wwv_flow_api.id(138682835641889239205)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(138683940111153163583)
,p_validation_name=>'prc_valida_ferias_DTI'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(1000);',
'',
'begin',
'',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, v_flg, v_msg, :P91_dt_inicio_afastamento, :P91_DT_TERMINO_AFASTAMENTO);',
'  ',
'if v_flg = ''N'' and v_msg is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682833613971239184)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(138683940169843163584)
,p_validation_name=>'prc_valida_qtd'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(1000);',
'',
'begin',
'',
'  pkg_mt_cad_atest_medico.prc_valida_qtd(:p91_cod_empresa, :p91_matricula, :P91_cod_doenca, v_flg, v_msg, :P91_qtde_dias_afastamento);',
'if v_flg = ''N'' and v_msg is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682834868214239197)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(138683940304755163585)
,p_validation_name=>'prc_valida_ferias_DTF'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(1000);',
'',
'begin',
'',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, v_flg, v_msg, :P91_dt_inicio_afastamento, :P91_DT_TERMINO_AFASTAMENTO);',
'if v_flg = ''N'' and v_msg is not null then',
'return v_msg;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682835542171239204)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(118299172523254476688)
,p_validation_name=>'Valida se tem atestado funcionario'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'/*    CURSOR C1 IS ',
'    SELECT COUNT(*) AS TOTAL ,  DT_INICIO_AFASTAMENTO, DT_TERMINO_AFASTAMENTO',
'    FROM ATESTADO_FUNCIONARIO A',
'    WHERE COD_EMPRESA = :P91_COD_EMPRESA',
'    AND MATRICULA = :P91_MATRICULA',
'     AND ((:P91_DT_INICIO_AFASTAMENTO between A.DT_INICIO_AFASTAMENTO and A.DT_TERMINO_AFASTAMENTO)',
'     OR (:P91_DT_TERMINO_AFASTAMENTO between A.DT_INICIO_AFASTAMENTO and A.DT_TERMINO_AFASTAMENTO))',
'       GROUP BY  DT_INICIO_AFASTAMENTO, DT_TERMINO_AFASTAMENTO;',
'*/',
'    --    ',
'    CURSOR C2 IS',
'    select COUNT(*) REQ',
'    from REQ_ATESTADO_FUNCIONARIO t',
'    where cod_empresa = :P91_COD_EMPRESA ',
'    and matricula = :P91_MATRICULA ',
'     AND ((:P91_DT_INICIO_AFASTAMENTO between DT_INICIO_AFASTAMENTO and DT_TERMINO_AFASTAMENTO)',
'     OR (:P91_DT_TERMINO_AFASTAMENTO between DT_INICIO_AFASTAMENTO and DT_TERMINO_AFASTAMENTO))',
'    and t.cod_sit_req in (1,2,5);',
'',
'    --1    C1%ROWTYPE;',
'    R2    C2%ROWTYPE;',
'    v_mensagem VARCHAR2(4000);',
'BEGIN',
'    v_mensagem := NULL;',
'',
'    OPEN C2;',
'    FETCH C2 INTO R2;',
'    CLOSE C2;',
'    ',
'    if R2.REQ > 0 THEN ',
'        /*',
'        OPEN C1;',
'        FETCH C1 INTO R1;',
'        CLOSE C1;',
'        IF R1.TOTAL != 0 THEN*/',
unistr('            v_mensagem := ''J\00E1 existe um atestado funcion\00E1rio para esta ''||'''),
'                                Empresa = <bold>''||:P91_COD_EMPRESA||''</bold>, ''||',
'                                ''Matricula = <bold>''||:P91_MATRICULA||''</bold>, <br />''||',
'                                ''Data Inicial = <bold>''||:P91_DT_INICIO_AFASTAMENTO||''</bold> e ''||',
'                                ''Data Final = <bold>''||:P91_DT_TERMINO_AFASTAMENTO||''</bold>'';',
'        --END IF;',
'        RETURN v_mensagem;',
'    END IF;',
'    RETURN NULL;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(138682768884877165873)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(115684988190477708044)
,p_validation_name=>'Data inicio nula'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_mat is',
'    select dt_admissao',
'    from informacoes_funcionais_cad',
'    where cod_empresa = :P91_COD_EMPRESA',
'    and matricula = :P91_MATRICULA;',
'',
'    r    c_mat%rowtype;',
'begin',
'    if :P91_DT_INICIO_AFASTAMENTO is null then',
'        return ''Informe a data de inicio do afastamento'';',
'    else',
'',
'        open c_mat;',
'        fetch c_mat into r;',
'        close c_mat;',
'',
'        if r.dt_admissao > :P91_DT_INICIO_AFASTAMENTO then',
unistr('            return ''Data Inicial ''||:P91_DT_INICIO_AFASTAMENTO||'' n\00E3o pode ser menor que data de admiss\00E3o ''||r.dt_admissao ;'),
'        end if;',
'    end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(138682833613971239184)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(115684988308783708045)
,p_validation_name=>'Data final nula'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P91_DT_TERMINO_AFASTAMENTO is null then',
'    return ''Informe a data de termino do afastamento'';',
'else',
'    if TO_DATE( :P91_DT_TERMINO_AFASTAMENTO, ''DD/MM/YYYY'')  < TO_DATE( :P91_DT_INICIO_AFASTAMENTO, ''DD/MM/YYYY'') then   ',
unistr('        return ''Data Termino Afastamento ''||:P91_DT_TERMINO_AFASTAMENTO||'' n\00E3o pode ser menor que a Data Inicio Afastamento ''||:P91_DT_INICIO_AFASTAMENTO;'),
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(138682835542171239204)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(114847117773777431204)
,p_validation_name=>unistr('Verifica se tem requisi\00E7\00E3o para mesma emp., mat e data')
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_contador number;',
'begin',
'    select count(*)',
'    into v_contador',
'     from req_atestado_funcionario',
'    where cod_empresa = :P91_COD_EMPRESA',
'    and matricula = :P91_MATRICULA',
'    and ((DT_INICIO_AFASTAMENTO between :P91_DT_INICIO_AFASTAMENTO and :P91_DT_TERMINO_AFASTAMENTO)',
'             or (DT_TERMINO_AFASTAMENTO between :P91_DT_INICIO_AFASTAMENTO and :P91_DT_TERMINO_AFASTAMENTO))',
'    and cod_sit_req != (select cod_sit_req ',
'                            from sit_req ',
'                        where upper(DESC_SIT_REQ) = ''CANCELADA'');',
'    if v_contador != 0 then',
unistr('        return ''Para esta empresa, matricula e datas existem requisi\00E7\00F5es n\00E3o canceladas. Verifique.'';'),
'    end if;                    ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682833613971239184)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(71133193466540916950)
,p_validation_name=>'Valida se obrigatorio'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_param is',
'    select ind_medico_obrigatorio',
'    from parametros_recursos_humanos',
'    where cod_empresa = :P91_COD_EMPRESA;',
'    ',
'    r_p c_param%rowtype;',
'',
'begin',
'',
'    OPEN c_param;',
'    FETCH c_param INTO r_p;',
'    CLOSE c_param;',
'    --',
'    ',
'    if r_p.ind_medico_obrigatorio = ''S'' and :P91_COD_PREST_SERV is null then',
unistr('        return ''M\00E9dico \00E9 obrigat\00F3rio'';'),
'    end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(138682833353855239182)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(54754728546620551323)
,p_validation_name=>unistr('HORA ou DIA Valida\00E7\00E3o')
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if :P91_TIPO_ATESTADO = ''DIAS'' then',
'    if :P91_HORA_INICIO_AFASTAMENTO is not null or :P91_HORA_TERMINO_AFASTAMENTO is not null then',
'      :P91_HORA_INICIO_AFASTAMENTO := null;',
'      :P91_HORA_TERMINO_AFASTAMENTO := null;',
unistr('      return ''Ao selecionar o tipo do atestado m\00E9dico controlado por DIAS, n\00E3o deve informar as horas'';'),
'    end if;',
'',
'  elsif :P91_TIPO_ATESTADO = ''HORAS'' then',
'    if nvl(:P91_HORA_INICIO_AFASTAMENTO, ''00:00'') = ''00:00'' or nvl(:P91_HORA_TERMINO_AFASTAMENTO, ''00:00'') = ''00:00'' then',
unistr('      return ''Ao selecionar o tipo do atestado m\00E9dico controlado por HORAS, deve informar a hora de in\00EDcio e t\00E9rmino do afastamento'';'),
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682781072081165948)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138682767695935165867)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682781529959165949)
,p_event_id=>wwv_flow_api.id(138682781072081165948)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682787967173165958)
,p_name=>'Set Entidade'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_ENTIDADE_LOV'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682788494937165959)
,p_event_id=>wwv_flow_api.id(138682787967173165958)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P91_ENTIDADE_LOV IS NOT NULL THEN',
'select to_char(e.cod_entidade)',
'      ,to_char(e.tipo_entidade)',
'  into :P91_COD_ENTIDADE',
'      ,:P91_TIPO_ENTIDADE',
'  from entidade e',
' where rowidtochar(e.rowid) = :P91_ENTIDADE_LOV;',
'ELSE',
'  :P91_COD_ENTIDADE  := NULL;',
'  :P91_TIPO_ENTIDADE := NULL;',
'END IF;'))
,p_attribute_02=>'P91_ENTIDADE_LOV'
,p_attribute_03=>'P91_COD_ENTIDADE_DSP,P91_TIPO_ENTIDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682645001511689800)
,p_name=>'Set Tipo_Entidade'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_ENTIDADE_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682645055125689801)
,p_event_id=>wwv_flow_api.id(138682645001511689800)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_tipo        number;   ',
'    l_entidade    number;',
'begin',
'    IF :P91_COD_ENTIDADE_DSP IS NOT NULL THEN ',
'        l_tipo := substr(:P91_COD_ENTIDADE_DSP, instr(:P91_COD_ENTIDADE_DSP, '':'')+1);',
'        l_entidade := substr(:P91_COD_ENTIDADE_DSP, 1, instr(:P91_COD_ENTIDADE_DSP, '':'')-1);',
'        --',
'        :P91_TIPO_ENTIDADE := l_tipo;',
'        :P91_COD_ENTIDADE  := l_entidade;',
'    ELSE',
'      :P91_TIPO_ENTIDADE := NULL;',
'    END IF;',
'end;'))
,p_attribute_02=>'P91_COD_ENTIDADE_DSP'
,p_attribute_03=>'P91_COD_ENTIDADE,P91_TIPO_ENTIDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682788903937165960)
,p_name=>'Create'
,p_event_sequence=>90
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682789384172165960)
,p_event_id=>wwv_flow_api.id(138682788903937165960)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_USUARIO,P91_DT_ATUALIZACAO,P91_DT_ATESTADO_MEDICO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682837086045239219)
,p_event_id=>wwv_flow_api.id(138682788903937165960)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(138682836495102239213)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682930263886814478)
,p_event_id=>wwv_flow_api.id(138682788903937165960)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(138682837153135239220)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682836917574239218)
,p_event_id=>wwv_flow_api.id(138682788903937165960)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p91_cod_emp_solicitante := :p_empresa_user;',
':p91_mat_solicitante := :p_matricula_user;',
':p91_DT_ATESTADO_MEDICO := sysdate;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P91_MAT_SOLICITANTE,P91_COD_EMP_SOLICITANTE,P91_DT_ATESTADO_MEDICO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682789736045165960)
,p_name=>'FileSize'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_ARQ,P91_ARQ_1_ANEXO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682790255406165960)
,p_event_id=>wwv_flow_api.id(138682789736045165960)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var fileSize = $x(''P91_ARQ_1_ANEXO'').files[0].size;',
'',
'console.log(fileSize);',
'',
'if (fileSize > 10000000){',
'$(''#CREATE'').hide();',
'$(''#SAVE'').hide();',
unistr('alert(''O Tamanho do Arquivo est\00E1 excedendo o lim\00EDte de 10Mb! Redimensione ou diminua a qualidade do arquivo para que possa continuar!'');'),
'} else {',
'$(''#CREATE'').show();',
'$(''#SAVE'').show();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682836679265239215)
,p_name=>'(Create) Painel do Colaborador'
,p_event_sequence=>110
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
 p_id=>wwv_flow_api.id(138682836775392239216)
,p_event_id=>wwv_flow_api.id(138682836679265239215)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_EMPRESA,P91_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682836849204239217)
,p_event_id=>wwv_flow_api.id(138682836679265239215)
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
 p_id=>wwv_flow_api.id(138682910340759707243)
,p_name=>'alt_COD_ATESTADO_MEDICO'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_ATESTADO_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682910772433707244)
,p_event_id=>wwv_flow_api.id(138682910340759707243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
' Select count(1) total',
' From Atestado_Medico A,',
'      Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'and A.cod_atestado_medico = :P91_COD_ATESTADO_MEDICO;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
' Select M.Cod ',
' From Atestado_Medico A,',
'      Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'and A.cod_atestado_medico = :P91_COD_ATESTADO_MEDICO;',
'',
'v_c2 c2%rowtype;',
'',
'cursor c3 is',
' select J.cod_justificativa ',
'  from pe_tipo_justificativa J, ATESTADO_MEDICO_PD_JUS A',
' where j.cod_empresa = a.cod_empresa',
'   and j.cod_justificativa = a.cod_justificativa',
'   and J.cod_empresa = :P91_COD_EMPRESA ',
'   and a.cod_atestado_medico = :p91_cod_atestado_medico;',
'   ',
' v_c3 c3%rowtype;',
'',
'begin',
'',
'    begin',
'',
'        select	max(A.COD_JUSTIFICATIVA)',
'        into	:P91_COD_JUSTIFICATIVA',
'        from	ATESTADO_MEDICO_PD_JUS A',
'        where	A.COD_EMPRESA = :P91_COD_EMPRESA',
'        and		A.COD_ATESTADO_MEDICO = :P91_COD_ATESTADO_MEDICO;',
'',
'    exception',
'    when others then ',
'    null;',
'    end;',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if nvl(v_c1.total,0) = 1 then',
'    ',
'       open c2;',
'       fetch c2 into v_c2;',
'       close c2;',
'       ',
'       :P91_COD_MOTIVO := v_c2.cod;',
'       ',
'       open c3;',
'       fetch c3 into v_c3;',
'       close c3;',
'       ',
'       :P91_COD_JUSTIFICATIVA := v_c3.cod_justificativa;',
'       ',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_COD_ATESTADO_MEDICO'
,p_attribute_03=>'P91_COD_JUSTIFICATIVA,P91_COD_MOTIVO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137418779582983332615)
,p_event_id=>wwv_flow_api.id(138682910340759707243)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'Select cod_sit_func',
'into :p91_cod_sit_func',
' From Atestado_Medico ',
'where cod_atestado_medico = :P91_COD_ATESTADO_MEDICO; ',
'exception',
'when no_data_found then',
unistr('--raise_application_error (-20001,''Dados de atestado n\00E3o encontrados'');'),
'null;',
'when others then',
'--raise_application_error (-20002,''Erro ao buscar dados'');',
'null;',
'end;'))
,p_attribute_02=>'P91_COD_ATESTADO_MEDICO'
,p_attribute_03=>'P91_COD_SIT_FUNC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682911171848709994)
,p_name=>'Atribui CodMoitvoES'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_MOTIVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682911555133709994)
,p_event_id=>wwv_flow_api.id(138682911171848709994)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR c2 IS',
'    SELECT x2.cod_motivo_esocial',
'      FROM motivo_alteracoes x2',
'     WHERE x2.cod = :P91_COD_MOTIVO;',
'  --',
'  r2   c2%ROWTYPE;   ',
'BEGIN',
'  IF :P91_COD_MOTIVO IS NOT NULL THEN',
'    OPEN c2;',
'    FETCH c2 INTO r2;',
'    CLOSE c2; ',
'    --',
'    :P91_COD_MOTIVO_ES := r2.cod_motivo_esocial;  ',
'  ELSE',
'    :P91_COD_MOTIVO_ES := NULL;',
'  END IF;',
'END;'))
,p_attribute_02=>'P91_COD_MOTIVO,P91_COD_MOTIVO_ES'
,p_attribute_03=>'P91_COD_MOTIVO_ES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682912108227715929)
,p_name=>'validar_dt'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_INICIO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682912499675715929)
,p_event_id=>wwv_flow_api.id(138682912108227715929)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  pkg_mt_cad_atest_medico.prc_validar_dt_inicio(:p91_cod_empresa, :p91_matricula, :P91_dt_inicio_afastamento, :p91_flag, :p91_mensagem);',
'  ',
'  :P91_OBSERVACAO := :p91_mensagem;',
'  ',
' ',
'end;'))
,p_attribute_02=>'P91_DT_INICIO_AFASTAMENTO,P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_03=>'P91_OBSERVACAO,P91_FLAG,P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682912819984718171)
,p_name=>'prc_valida_ferias_DTI'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_INICIO_AFASTAMENTO'
,p_condition_element=>'P91_DT_INICIO_AFASTAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682913289699718171)
,p_event_id=>wwv_flow_api.id(138682912819984718171)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  --pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, :p91_flag, :p91_mensagem, :dt_inicio_afastamento); ',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, :p91_flag, :p91_mensagem, :P91_dt_inicio_afastamento, :P91_DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_DT_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_03=>'P91_FLAG,P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682913626754720849)
,p_name=>'Set DT_TERMINO_AGASTAMENTO'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_QTDE_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682914043962720849)
,p_event_id=>wwv_flow_api.id(138682913626754720849)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P91_DT_TERMINO_AFASTAMENTO := to_date(:P91_DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'') + :P91_QTDE_DIAS_AFASTAMENTO - 1;'
,p_attribute_02=>'P91_DT_INICIO_AFASTAMENTO,P91_QTDE_DIAS_AFASTAMENTO'
,p_attribute_03=>'P91_DT_TERMINO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682914429319722839)
,p_name=>'prc_valida_qtd'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_QTDE_DIAS_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682914822663722840)
,p_event_id=>wwv_flow_api.id(138682914429319722839)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  pkg_mt_cad_atest_medico.prc_valida_qtd(:p91_cod_empresa, :p91_matricula, :P91_cod_doenca, :p91_flag, :p91_mensagem,:P91_qtde_dias_afastamento);',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_COD_DOENCA,P91_QTDE_DIAS_AFASTAMENTO'
,p_attribute_03=>'P91_FLAG,P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(118299172291435476685)
,p_name=>'Valida se tem atestado funcionario'
,p_event_sequence=>175
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(118299172404299476686)
,p_event_id=>wwv_flow_api.id(118299172291435476685)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    CURSOR C1 IS ',
'    SELECT COUNT(*) AS TOTAL , DT_ATESTADO_MEDICO, DT_INICIO_AFASTAMENTO, DT_TERMINO_AFASTAMENTO',
'    FROM ATESTADO_FUNCIONARIO A',
'    WHERE COD_EMPRESA = :P91_COD_EMPRESA',
'    AND MATRICULA = :P91_MATRICULA',
'     AND ((:P91_DT_INICIO_AFASTAMENTO between A.DT_INICIO_AFASTAMENTO and A.DT_TERMINO_AFASTAMENTO)',
'     OR (:P91_DT_TERMINO_AFASTAMENTO between A.DT_INICIO_AFASTAMENTO and A.DT_TERMINO_AFASTAMENTO))',
'       GROUP BY DT_ATESTADO_MEDICO, DT_INICIO_AFASTAMENTO, DT_TERMINO_AFASTAMENTO;',
'    --',
'    R1    C1%ROWTYPE;',
'BEGIN',
'    :P91_MENSAGEM := NULL;',
'DELETE FROM TESTEX WHERE TEXTO LIKE ''ANDRE%'';',
'INSERT INTO TESTEX VALUES (-1, ''ANDRE P91_COD_EMPRESA = ''|| :P91_COD_EMPRESA);',
'INSERT INTO TESTEX VALUES (-2, ''ANDRE P91_MATRICULA = ''|| :P91_MATRICULA);',
'INSERT INTO TESTEX VALUES (-3, ''ANDRE P91_DT_INICIO_AFASTAMENTO = ''|| :P91_DT_INICIO_AFASTAMENTO);',
'INSERT INTO TESTEX VALUES (-4, ''ANDRE P91_DT_TERMINO_AFASTAMENTO = ''|| :P91_DT_TERMINO_AFASTAMENTO);',
'COMMIT;',
'',
'    OPEN C1;',
'    FETCH C1 INTO R1;',
'    CLOSE C1;',
'INSERT INTO TESTEX VALUES (-5, ''ANDRE R1.TOTAL = ''|| R1.TOTAL);',
'    ',
'    IF R1.TOTAL != 0 THEN',
unistr('        :P91_MENSAGEM := ''J\00E1 existe um atestado funcion\00E1rio para esta ''||'''),
'                            Empresa = <bold>''||:P91_COD_EMPRESA||''</bold>, ''||',
'                            ''Matricula = <bold>''||:P91_MATRICULA||''</bold>, <br />''||',
'                            ''Data Atestado = <bold>''||R1.DT_ATESTADO_MEDICO||''</bold>, <br />''||',
'                            ''Data Inicial = <bold>''||R1.DT_INICIO_AFASTAMENTO||''</bold> e ''||',
'                            ''Data Final = <bold>''||R1.DT_TERMINO_AFASTAMENTO||''</bold>'';',
'    END IF;',
'END;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_DT_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_03=>'P91_MENSAGEM,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682915235499725452)
,p_name=>'Set QTD DIAS AFASTAMENTO'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682915693971725453)
,p_event_id=>wwv_flow_api.id(138682915235499725452)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P91_QTDE_DIAS_AFASTAMENTO := to_number((to_date(:P91_DT_TERMINO_AFASTAMENTO,''dd/mm/yyyy'') - to_date(:P91_DT_INICIO_AFASTAMENTO,''dd/mm/yyyy'')))+1;',
'',
'',
''))
,p_attribute_02=>'P91_DT_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_03=>'P91_QTDE_DIAS_AFASTAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682916018979727668)
,p_name=>'prc_valida_ferias_DTF'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_condition_element=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682916511380727668)
,p_event_id=>wwv_flow_api.id(138682916018979727668)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  --pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, :p91_flag, :p91_mensagem, :dt_inicio_afastamento, :dt_termino_afastamento); ',
'  pkg_mt_cad_atest_medico.prc_valida_ferias(:p91_cod_empresa, :p91_matricula, :p91_flag, :p91_mensagem, :P91_dt_inicio_afastamento, :P91_DT_TERMINO_AFASTAMENTO);',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_DT_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_03=>'P91_FLAG,P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682916874161730416)
,p_name=>'Popula MENSAGEM'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_OBSERVACAO'
,p_condition_element=>'P91_OBSERVACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682917269961730416)
,p_event_id=>wwv_flow_api.id(138682916874161730416)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P91_MENSAGEM := :P91_observacao;'
,p_attribute_02=>'P91_OBSERVACAO'
,p_attribute_03=>'P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682935514126822029)
,p_name=>'Dispara Alerta'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MENSAGEM'
,p_condition_element=>'P91_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682935865523822029)
,p_event_id=>wwv_flow_api.id(138682935514126822029)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P91_MENSAGEM" ).getValue().length > 0){',
'',
'  if (apex.item( "P91_FLAG" ).getValue() == ''Q''){',
'',
unistr('      alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
'      alertify.confirm(apex.item( "P91_MENSAGEM" ).getValue(), function (e) {',
'          if (e) {',
'              apex.item( "P91_OK" ).setValue("S");',
'          } else {',
'              apex.item( "P91_OK" ).setValue("N");',
'          }',
'      });',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'',
'  }else{',
'',
'    if (apex.item( "P91_FLAG" ).getValue() == ''N'') {',
'      apex.item( "P91_OK" ).setValue("N");',
'    } else {',
'      apex.item( "P91_OK" ).setValue("S");',
'    }',
'',
'    alertify.alert(apex.item( "P91_MENSAGEM" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }',
'  ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682936239477824209)
,p_name=>'Inicia Alertify'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682936679075824209)
,p_event_id=>wwv_flow_api.id(138682936239477824209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Ok'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682642556654689776)
,p_name=>'Mask Hora Inicio Afastamento'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_HORA_INICIO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682642694767689777)
,p_event_id=>wwv_flow_api.id(138682642556654689776)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p91_hora_inicio_afastamento is not null then',
':p91_hora_inicio_afastamento := substr(replace(:p91_hora_inicio_afastamento,'':''),0,2)||'':''||substr(replace(:p91_hora_inicio_afastamento,'':''),3,2);',
'else ',
':p91_hora_inicio_afastamento := null;',
'end if;'))
,p_attribute_02=>'P91_HORA_INICIO_AFASTAMENTO'
,p_attribute_03=>'P91_HORA_INICIO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682642733686689778)
,p_name=>'Mask Hora Termino Afastamento'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_HORA_TERMINO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682642887803689779)
,p_event_id=>wwv_flow_api.id(138682642733686689778)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p91_hora_termino_afastamento is not null then',
':p91_hora_termino_afastamento := substr(replace(:p91_hora_termino_afastamento,'':''),0,2)||'':''||substr(replace(:p91_hora_termino_afastamento,'':''),3,2);',
'else ',
':p91_hora_termino_afastamento := null;',
'end if;'))
,p_attribute_02=>'P91_HORA_TERMINO_AFASTAMENTO'
,p_attribute_03=>'P91_HORA_TERMINO_AFASTAMENTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682642956105689780)
,p_name=>'Matricula popula digito'
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682643083285689781)
,p_event_id=>wwv_flow_api.id(138682642956105689780)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'select dc_matricula',
'  into :p91_dc_matricula',
'  from informacoes_funcionais_cad',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula;',
'   ',
'exception',
'when others then',
':p91_dc_matricula := null;',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA'
,p_attribute_03=>'P91_DC_MATRICULA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138683620888851686425)
,p_name=>'Revisar'
,p_event_sequence=>260
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138683619162488681499)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683621276130686425)
,p_event_id=>wwv_flow_api.id(138683620888851686425)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'PROMPT'
,p_attribute_04=>unistr('Deseja <strong>Solicitar Revis\00E3o</strong> dessa requisi\00E7\00E3o? Descreva o motivo.')
,p_attribute_06=>'P91_MENSAGEM_TXT'
,p_attribute_07=>'Continuar'
,p_attribute_08=>'Voltar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683621772153686427)
,p_event_id=>wwv_flow_api.id(138683620888851686425)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'REVISAR'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682643342375689784)
,p_name=>'Cancelar Req'
,p_event_sequence=>270
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138682643251154689783)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682643684291689787)
,p_event_id=>wwv_flow_api.id(138682643342375689784)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja <strong>cancelar</strong> essa requisi\00E7\00E3o?')
,p_attribute_07=>'Continuar'
,p_attribute_08=>'Voltar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682643478478689785)
,p_event_id=>wwv_flow_api.id(138682643342375689784)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_flag     VARCHAR2(1);',
'    v_mensagem VARCHAR2(4000);',
'BEGIN',
'    PKG_MT_CAD_ATEST_MEDICO.CANCELA_REQUISICAO(P_CODREQ => :P91_COD_REQ',
'                                        ,PFLG_RETORNO   => v_flag',
'                                        ,PMSG_RETORNO   => v_mensagem',
'                                        ,PUSUARIO       => :p_usuario);',
'    IF v_mensagem IS NOT NULL THEN',
'            APEX_ERROR.ADD_ERROR (',
'                            p_message          => v_mensagem,',
'                            p_display_location => apex_error.c_inline_in_notification );',
'    END IF;',
'END;'))
,p_attribute_02=>'P91_COD_REQ'
,p_attribute_03=>'P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(124998900579053880758)
,p_event_id=>wwv_flow_api.id(138682643342375689784)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682646240139689813)
,p_name=>'Aprovar Dialog Closed'
,p_event_sequence=>280
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138683715022762657250)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682646374100689814)
,p_event_id=>wwv_flow_api.id(138682646240139689813)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(162291895619387095739)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682646514732689815)
,p_event_id=>wwv_flow_api.id(138682646240139689813)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682646569343689816)
,p_name=>'Reprovar Dialog Closed'
,p_event_sequence=>290
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138683714689202657247)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682646617838689817)
,p_event_id=>wwv_flow_api.id(138682646569343689816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(162291895619387095739)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682646762054689818)
,p_event_id=>wwv_flow_api.id(138682646569343689816)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138682647088184689821)
,p_name=>'Refresh COD_PREST_SERV'
,p_event_sequence=>300
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138682646923088689820)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138682647209366689822)
,p_event_id=>wwv_flow_api.id(138682647088184689821)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_PREST_SERV'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138683939126167163574)
,p_name=>'Refresh COD_ENTIDADE'
,p_event_sequence=>310
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(138683939109319163573)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683939226373163575)
,p_event_id=>wwv_flow_api.id(138683939126167163574)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_COD_ENTIDADE_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138683939372823163576)
,p_name=>'Solicitante Nao Alterar'
,p_event_sequence=>320
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from aprova_atestado',
' where cod_solicitacao = :p91_cod_req',
'   and status_aprov = ''A''',
'   and mat_aprov <> :p91_mat_solicitante;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    if :p91_rowid is not null',
'    and :p_empresa_user = :p91_cod_empresa ',
'    and :p_matricula_user = :p91_matricula ',
'    and :p91_cod_sit_req = 1 ',
'    and nvl(v_c1.existe,''N'') = ''N''',
'    then',
'        return false;',
'    elsif :p91_rowid is null then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683939416029163577)
,p_event_id=>wwv_flow_api.id(138683939372823163576)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(138683939109319163573)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683939559808163578)
,p_event_id=>wwv_flow_api.id(138683939372823163576)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(138682646923088689820)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138683940356832163586)
,p_name=>'Valida Data'
,p_event_sequence=>330
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_ATESTADO_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P91_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683940493483163587)
,p_event_id=>wwv_flow_api.id(138683940356832163586)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_req_atestado.Valida_Data(pcod_empresa => :p91_cod_empresa,',
'                              pmatricula => :p91_matricula,',
'                              pdata => :p91_dt_inicio_afastamento,',
'                              pcod_atestado => :p91_cod_atestado_medico,',
'                              pflg_retorno => :p91_flag,',
'                              pmsg_retorno => :p91_mensagem);',
'end;'))
,p_attribute_02=>'P91_COD_EMPRESA,P91_MATRICULA,P91_DT_ATESTADO_MEDICO,P91_COD_ATESTADO_MEDICO,P91_DT_INICIO_AFASTAMENTO'
,p_attribute_03=>'P91_FLAG,P91_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138683940698610163589)
,p_name=>'Hide Campos'
,p_event_sequence=>340
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138683940733374163590)
,p_event_id=>wwv_flow_api.id(138683940698610163589)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_OCUPACIONAL,P91_TIPO_ACIDENTE_ES,P91_DT_ALT_PROG,P91_DT_PERICIA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(137418779706448332616)
,p_name=>'Configura Campos Situacao'
,p_event_sequence=>350
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_SIT_FUNC'
,p_condition_element=>'P91_COD_SIT_FUNC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'01'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137418779852210332617)
,p_event_id=>wwv_flow_api.id(137418779706448332616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137418780030341332619)
,p_event_id=>wwv_flow_api.id(137418779706448332616)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137418779908397332618)
,p_event_id=>wwv_flow_api.id(137418779706448332616)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137418780137511332620)
,p_event_id=>wwv_flow_api.id(137418779706448332616)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(81772774510711589232)
,p_name=>'Limpa campois'
,p_event_sequence=>360
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_INICIO_AFASTAMENTO'
,p_condition_element=>'P91_DT_INICIO_AFASTAMENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(81772774663186589233)
,p_event_id=>wwv_flow_api.id(81772774510711589232)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_QTDE_DIAS_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select null from dual'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(80451497554556840685)
,p_name=>'New'
,p_event_sequence=>370
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'justificativa'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(80451497710557840686)
,p_event_id=>wwv_flow_api.id(80451497554556840685)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'teste'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(79129703997178111699)
,p_name=>'Dispara Alerta Datas'
,p_event_sequence=>390
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MENSAGEM_DATA'
,p_condition_element=>'P91_MENSAGEM_DATA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(79129704065039111700)
,p_event_id=>wwv_flow_api.id(79129703997178111699)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Data Inicial n\00E3o pode ser menor que data de admiss\00E3o')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(79129704231315111701)
,p_event_id=>wwv_flow_api.id(79129703997178111699)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_INICIO_AFASTAMENTO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select null from dual'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(79137426962494386556)
,p_name=>'Valida data inicioe final'
,p_event_sequence=>410
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_MENSAGEM_DATA_FINAL'
,p_condition_element=>'P91_MENSAGEM_DATA_FINAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(79137427082711386557)
,p_event_id=>wwv_flow_api.id(79137426962494386556)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Data Final n\00E3o pode ser menor que Data Inicial')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(79137427198025386558)
,p_event_id=>wwv_flow_api.id(79137426962494386556)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select null from dual'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(65692976776195947176)
,p_name=>'Desabilita/Habilita'
,p_event_sequence=>430
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DIAS_HORAS_PONTO'
,p_condition_element=>'P91_DIAS_HORAS_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(65692976872093947177)
,p_event_id=>wwv_flow_api.id(65692976776195947176)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'OK'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(56128746799838568782)
,p_name=>'Seta Hora Inicio'
,p_event_sequence=>440
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128746980407568783)
,p_event_id=>wwv_flow_api.id(56128746799838568782)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128747060228568784)
,p_event_id=>wwv_flow_api.id(56128746799838568782)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P91_COD_REQ is not null then',
'    begin',
'    select hora_inicio_afastamento    --, hora_termino_afastamento',
'    into :P91_HORA_INICIO_AFASTAMENTO --, :P91_HORA_TERMINO_AFASTAMENTO',
'    from req_atestado_funcionario',
'    where cod_req = :P91_COD_REQ;',
'    exception',
'        when others then',
'            :P91_HORA_INICIO_AFASTAMENTO    := ''00:00'';',
'            --:P91_HORA_TERMINO_AFASTAMENTO := ''00:00'';',
'    end;',
'end if;'))
,p_attribute_02=>'P91_COD_REQ'
,p_attribute_03=>'P91_HORA_INICIO_AFASTAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128747163546568785)
,p_event_id=>wwv_flow_api.id(56128746799838568782)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(56128747282986568786)
,p_name=>'Seta Hora tERMINO'
,p_event_sequence=>450
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128747357256568787)
,p_event_id=>wwv_flow_api.id(56128747282986568786)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128747428107568788)
,p_event_id=>wwv_flow_api.id(56128747282986568786)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P91_COD_REQ is not null then',
'    begin',
'    select hora_termino_afastamento',
'    into  :P91_HORA_TERMINO_AFASTAMENTO',
'    from req_atestado_funcionario',
'    where cod_req = :P91_COD_REQ;',
'    exception',
'        when others then',
'            :P91_HORA_TERMINO_AFASTAMENTO := ''00:00'';',
'    end;',
'end if;'))
,p_attribute_02=>'P91_COD_REQ'
,p_attribute_03=>'P91_DT_TERMINO_AFASTAMENTO_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56128747493392568789)
,p_event_id=>wwv_flow_api.id(56128747282986568786)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(56129800345829782947)
,p_name=>'Valida se eh consulta'
,p_event_sequence=>460
,p_condition_element=>'P91_CONSULTA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56129800435607782948)
,p_event_id=>wwv_flow_api.id(56129800345829782947)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_INICIO_AFASTAMENTO_DSP,P91_DT_TERMINO_AFASTAMENTO_DSP,P91_HORA_INICIO_AFASTAMENTO_DSP,P91_HORA_TERMINO_AFASTAMENTO_DSP,P91_QTDE_DIAS_AFASTAMENTO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56129800880382782952)
,p_event_id=>wwv_flow_api.id(56129800345829782947)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_INICIO_AFASTAMENTO,P91_HORA_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO,P91_HORA_TERMINO_AFASTAMENTO,P91_QTDE_DIAS_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56129800617643782950)
,p_event_id=>wwv_flow_api.id(56129800345829782947)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_INICIO_AFASTAMENTO_DSP,P91_DT_TERMINO_AFASTAMENTO_DSP,P91_HORA_INICIO_AFASTAMENTO_DSP,P91_HORA_TERMINO_AFASTAMENTO_DSP,P91_QTDE_DIAS_AFASTAMENTO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56129800708243782951)
,p_event_id=>wwv_flow_api.id(56129800345829782947)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_DT_INICIO_AFASTAMENTO,P91_HORA_INICIO_AFASTAMENTO,P91_DT_TERMINO_AFASTAMENTO,P91_HORA_TERMINO_AFASTAMENTO,P91_QTDE_DIAS_AFASTAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54754728637897551324)
,p_name=>'Dia ou Hora'
,p_event_sequence=>470
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_COD_ATESTADO_MEDICO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754728736307551325)
,p_event_id=>wwv_flow_api.id(54754728637897551324)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct case when am.dias_horas_ponto = ''D'' then ''DIAS'' else ''HORAS'' end TIPO',
'into :P91_TIPO_ATESTADO',
'from atestado_medico am',
'where cod_atestado_medico = :P91_COD_ATESTADO_MEDICO;'))
,p_attribute_02=>'P91_COD_ATESTADO_MEDICO'
,p_attribute_03=>'P91_TIPO_ATESTADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54754729371252551331)
,p_name=>'New_1'
,p_event_sequence=>480
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_DT_TERMINO_AFASTAMENTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754729450679551332)
,p_event_id=>wwv_flow_api.id(54754729371252551331)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  i date := :P91_DT_INICIO_AFASTAMENTO;',
'  f date := :P91_DT_TERMINO_AFASTAMENTO;',
'  V number;',
'BEGIN ',
'  V := TO_number( f - i ) + 1;',
'  :P91_QTDE_DIAS_AFASTAMENTO := V;',
'',
'END;'))
,p_attribute_02=>'P91_DT_TERMINO_AFASTAMENTO,, P91_DT_INICIO_AFASTAMENTO'
,p_attribute_03=>'P91_QTDE_DIAS_AFASTAMENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(54754472787120551740)
,p_name=>'Seta parametro'
,p_event_sequence=>490
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P91_TIPO_ATESTADO'
,p_condition_element=>'P91_TIPO_ATESTADO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'HORAS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754472851290551741)
,p_event_id=>wwv_flow_api.id(54754472787120551740)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754473152287551744)
,p_event_id=>wwv_flow_api.id(54754472787120551740)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754473008858551742)
,p_event_id=>wwv_flow_api.id(54754472787120551740)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_TERMINO_AFASTAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(54754473053390551743)
,p_event_id=>wwv_flow_api.id(54754472787120551740)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P91_HORA_INICIO_AFASTAMENTO'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682929837404814474)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'begin',
'',
'select dc_matricula',
'  into :p91_dc_matricula',
'  from informacoes_funcionais_cad',
' where cod_empresa = :p91_cod_empresa',
'   and matricula = :p91_matricula;',
'   ',
'exception',
'when others then',
':p91_dc_matricula := null;',
'end;',
'',
':P91_cod_req := seq_requisicao.NEXTVAL;',
'    ',
':P91_dt_req    := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
':P91_cod_sit_req := 1;',
':P91_dt_sit_req    := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'    ',
':P91_usuario            := :p_usuario;',
':P91_dt_atualizacao     := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'',
'',
'',
'end;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(138682768884877165873)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682929962347814475)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
':P91_usuario            := :p_usuario;',
':P91_dt_atualizacao     := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'',
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(138682768442649165872)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682644257747689793)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set DESC_MOTIVO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select max(substr(mot.descricao, 1 , 30))',
'  into :P91_DESC_MOTIVO',
'  from motivo_alteracoes mot ',
' where mot.ind_situacao IN ( ''S'', ''O'' )',
'   and mot.cod = :P91_COD_MOTIVO;',
'   ',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(138682768884877165873)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682644498616689795)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Dados Complementares'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR c1 IS ',
'    SELECT max(x1.origem) origem, max(x1.nr_documento) nr_documento, max(x1.uf_documento) uf_documento',
'      FROM vw_medicos x1',
'     WHERE x1.cod = :P91_COD_PREST_SERV;',
'  --',
'  r1   c1%ROWTYPE;',
'  --',
'  CURSOR c2 IS',
'    SELECT max(x2.cod_motivo_esocial) cod_motivo_esocial',
'      FROM motivo_alteracoes x2',
'     WHERE x2.cod = :P91_COD_MOTIVO;',
'  --',
'  r2   c2%ROWTYPE;   ',
'BEGIN',
'  IF /*:P91_ORIGEM_MED IS NULL AND :P91_CRM_PREST_SERV_RESP IS NULL AND :P91_UF_CRM_PREST_RESP IS NULL AND*/ :P91_COD_PREST_SERV IS NOT NULL THEN',
'    OPEN c1;',
'    FETCH c1 INTO r1;',
'    CLOSE c1;',
'    --',
'    :P91_ORIGEM_MED          := r1.origem;',
'    :P91_CRM_PREST_SERV_RESP := r1.nr_documento;',
'    :P91_UF_CRM_PREST_RESP   := r1.uf_documento;',
'  END IF;',
'  --',
'  IF /*:P91_COD_MOTIVO_ES IS NULL AND*/ :P91_COD_MOTIVO IS NOT NULL THEN',
'    OPEN c2;',
'    FETCH c2 INTO r2;',
'    CLOSE c2; ',
'    --',
'    :P91_COD_MOTIVO_ES := r2.cod_motivo_esocial;  ',
'  END IF;',
'  ',
' ',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(138682768884877165873)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682643987336689790)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Processing'
,p_attribute_02=>'REQ_ATESTADO_FUNCIONARIO'
,p_attribute_03=>'P91_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682643571534689786)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cancelar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
':P91_usuario            := :p_usuario;',
':P91_dt_atualizacao     := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
':p91_cod_sit_req := 3;',
':p91_dt_sit_req := to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'',
'UPDATE REQ_ATESTADO_FUNCIONARIO',
'  SET USUARIO = :P_USUARIO,',
'      DT_ATUALIZACAO = SYSDATE,',
'      COD_SIT_REQ = 3,',
'      DT_SIT_REQ = SYSDATE',
' WHERE COD_REQ = :P91_COD_REQ;',
' ',
'  ',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682930049287814476)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'V_ARQ_1_NOME               VARCHAR2(200);',
'',
'begin',
'',
' PKG_REQ_ATESTADO.Post_Insert(:P91_COD_EMPRESA,',
'                        :P91_COD_REQ,',
'                       v_flg_retorno,',
'                       v_msg_retorno); ',
' if v_msg_retorno is not null then',
'    :p91_ok       := ''N'';',
'    :p91_flag     := v_flg_retorno;',
'    :p91_mensagem := v_msg_retorno;',
' else',
'    :p91_flag     := null;',
'    :p91_mensagem := null;',
'    :p91_ok       := ''S'';',
' end if;',
'',
'',
'',
'UPDATE req_atestado_funcionario SET ARQ_1_NOME =  replace(ARQ_1_NOME,'','','''')',
'WHERE COD_REQ  = :P91_COD_REQ;',
'',
'COMMIT;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(138682768884877165873)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682930149205814477)
,p_process_sequence=>110
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
'PKG_REQ_ATESTADO.Post_Update(:P91_COD_EMPRESA,',
'                        :P91_COD_REQ,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' if v_msg_retorno is not null then',
'    :p91_ok       := ''N'';',
'    :p91_flag     := v_flg_retorno;',
'    :p91_mensagem := v_msg_retorno;',
' else',
'    :p91_flag     := null;',
'    :p91_mensagem := null;',
'    :p91_ok       := ''S'';',
' end if;',
' ',
'UPDATE req_atestado_funcionario SET ARQ_1_NOME =  replace(ARQ_1_NOME,'','','''')',
'WHERE COD_REQ  = :P91_COD_REQ;',
'',
'COMMIT;',
'',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138683698556754476354)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'ENVIA E-MAIL'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(1);',
'v_msg varchar2(4000);',
'',
'cursor c1 is',
'select nvl(max(seq),0) seq',
'  from req_atestado_funcionario_log',
' where cod_req = :p91_cod_req;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select nvl(i.e_mail,p.e_mail) email',
'  from informacoes_funcionais_cad i,',
'       inf_pessoais_cad p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p91_cod_empresa',
'   and i.matricula = :p91_matricula;',
'   ',
'v_c2 c2%rowtype;',
'',
'',
'cursor c_req is',
'select ''<h3>''||( Select  a.descricao',
' From Atestado_Medico A,',
'               Motivo_Alteracoes M',
'where M.COD = A.COD_MOT_ATESTADO',
'  and a.cod_atestado_medico = vf.cod_atestado_medico)||''</h3><br>''',
'  || case when vf.dt_atestado_medico is not null then ''<b>Data de Lancamento ''||to_char(vf.dt_atestado_medico,''dd/mm/rrrr'')||''</b><br>'' end',
'       texto,',
'       vf.dt_req,',
'       vf.dt_sit_req,',
'       vf.cod_sit_req',
'  from req_atestado_funcionario vf',
' where vf.cod_req = :p91_cod_req;',
' ',
' v_req c_req%rowtype;',
'',
'v_subject varchar2(200);',
'v_texto varchar2(4000);',
'',
'v_mensagem varchar2(200);',
'',
'v_remetente varchar2(100);',
'',
'v_mensagem_txt varchar2(4000):= replace(trim(:p91_mensagem_txt),chr(10),''<br>'');',
'',
'begin',
'',
'    open c_req;',
'    fetch c_req into v_req;',
'    close c_req;',
'',
'     if :p91_cod_sit_req = 1 then ',
'        v_subject := ''(EM ANDAMENTO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';',
'        if v_req.dt_sit_req = v_req.dt_req then',
'        v_mensagem := ''Sua requisicao foi cadastrada e passara por uma analise.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Criada.'';'),
'        else',
'        v_mensagem := ''Sua requisicao foi ajustada e passara por uma analise.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Ajustada.'';'),
'        end if;',
'     elsif :p91_cod_sit_req = 2 then',
'        v_subject := ''(CONCLUIDO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';',
'        v_mensagem := ''Sua requisicao foi concluida com sucesso.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Conclu\00EDda.'';'),
'     elsif :p91_cod_sit_req = 3 then',
'        v_subject := ''(CANCELADO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';  ',
'        v_mensagem := ''Sua requisicao foi cancelada.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Cancelada.'';'),
'     elsif :p91_cod_sit_req = 4 then',
'        v_subject := ''(REPROVADO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';',
'        v_mensagem := ''Sua requisicao foi reprovava. Revise os dados cadastrados e apos os ajustes, salve novamente.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Reprovada <br><strong>''||v_mensagem_txt||''</strong>'';'),
'     elsif :p91_cod_sit_req = 5 then',
'        v_subject := ''(APROVADO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';   ',
'        v_mensagem := ''Sua requisicao foi aprovada.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Aprovada.'';'),
'     elsif :p91_cod_sit_req = 6 then',
'        v_subject := ''(SUSPENSO) Cadastro de Atestado [''||:P91_COD_REQ||'']'';',
'        v_mensagem := ''Sua requisicao foi suspensa.'';',
unistr('        v_mensagem_txt := ''Requisi\00E7\00E3o ''||:p91_cod_req||'' Suspensa.'';'),
'     end if;',
'     ',
'     v_remetente := upper(fnct_nome_func(:p_empresa_user,:p_matricula_user))||'' [''||case when :p_painel = ''PC'' then :p_matricula_user else :p_usuario end||'']'';',
'',
'    if v_Mensagem_txt is not null then',
'',
'      open c1;',
'      fetch c1 into v_c1;',
'      close c1;',
'',
'      insert into req_atestado_funcionario_log (cod_req, ',
'                                       seq,  ',
'                                       remetente,',
'                                       cod_empresa,',
'                                       matricula,',
'                                       usuario,',
'                                       mensagem_txt) ',
'      values ',
'      (:p91_cod_req,',
'       v_c1.seq+1,',
'       v_remetente,',
'       :p_empresa_user,',
'       :p_matricula_user,',
'       :p_usuario,',
'       v_mensagem_txt);',
'',
'      commit;',
'',
'    end if;',
'    ',
'    open c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'    ',
'    if v_c2.email is not null then',
'    ',
'      v_texto := ''<p><h2>Requisicao de Cadastro de Atestado</h2></p>''||',
'                 ''Requisicao: ''||:p91_cod_req||''<br>''||',
unistr('                 ''Data de Requisi\00E7\00E3o: ''||:p91_dt_req||''<br>''||'),
unistr('                 ''Situa\00E7\00E3o: ''||case when :p91_cod_sit_req = 1 then ''<b>EM ANDAMENTO</b>'' '),
unistr('                                    when :p91_cod_sit_req = 2 then ''<b><a style="color:blue;">CONCLU\00CDDO<a></b>'' '),
'                                    when :p91_cod_sit_req = 3 then ''<b><a style="color:red;">CANCELADO<a></b>'' ',
'                                    when :p91_cod_sit_req = 4 then ''<b><a style="color:red;">REPROVADO<a></b>'' ',
'                                    when :p91_cod_sit_req = 5 then ''<b><a style="color:green;">APROVADO<a></b>''',
'                                    when :p91_cod_sit_req = 6 then ''<b>SUSPENSO</b>''',
'                               end||''<br>''||',
unistr('                 ''Data de Situa\00E7\00E3o: ''||:p91_dt_sit_req||''<br>''||'),
'                 CASE WHEN v_mensagem IS NOT NULL THEN ''<br>''||v_mensagem||''<br>''||''<br>'' end ||',
unistr('                 CASE WHEN :P91_MENSAGEM_TXT IS NOT NULL THEN ''<strong>Retorno da An\00E1lise: </strong><br>''||:p91_mensagem_txt ||''<br>''||''<br>'' end ||'),
'                 v_req.texto;',
'          ',
'       PRC_ENVIA_EMAIL (v_c2.email, ',
'                        V_SUBJECT, ',
'                        v_texto,',
'                        v_flg, ',
'                        v_msg);',
'                     ',
'    end if;',
'   ',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682780696705165946)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE,APROVAR,REPROVAR'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682766290457165860)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(157145317023521765932)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form Cadastro de Vacina\00E7\00E3o')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682644046647689791)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'REQ_ATESTADO_FUNCIONARIO'
,p_attribute_03=>'P91_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(137589788119839623183)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carregar entidade com tipo no Popup LOV'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select e.cod_entidade||'':''||e.tipo_entidade codigo',
'        into :P91_COD_ENTIDADE_DSP',
'      from entidade e',
'     where e.tipo_entidade in (1,7)',
'     and cod_entidade = :P91_COD_ENTIDADE',
'     and tipo_entidade = :P91_TIPO_ENTIDADE;',
'exception',
'    when others then',
'        :P91_COD_ENTIDADE_DSP := null;',
'end;        '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(124998900496728880757)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Permite cancelar por painel'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'declare',
'    l_operador_cancela_concluida       parametros_recursos_humanos.operador_cancela_concluida%type;',
'    l_operador_cancela_requisicoes     parametros_recursos_humanos.operador_cancela_requisicoes%type;',
'begin',
'    :P91_OPERADOR_DELETA := ''N'';',
'    :P91_OPERADOR_DELETA_DEMAIS := ''N'';',
'    --',
'    if :P91_COD_SIT_REQ != 3 then    -- Nao cancelada',
'      if :P_EMPRESA_USER is null and :P_USUARIO	= ''SUPORTE_NATCORP'' and :P_PERFIL = ''MASTER'' then',
'        l_operador_cancela_concluida := ''S'';',
'        l_operador_cancela_requisicoes := ''S'';',
'      else',
'        begin',
'          select operador_cancela_concluida, operador_cancela_requisicoes',
'              into l_operador_cancela_concluida, l_operador_cancela_requisicoes',
'          from parametros_recursos_humanos',
'              where cod_empresa = :P_EMPRESA_USER;',
'        --',
'        exception',
'          when others then',
'            l_operador_cancela_concluida := ''N'';',
'            l_operador_cancela_requisicoes := ''N'';',
'        end;',
'      end if;',
'        if :P_PAINEL = ''PO'' then      -- Painel do Operador',
'            --',
'            if l_operador_cancela_concluida = ''S'' and :P91_COD_SIT_REQ = 2 then',
'                :P91_OPERADOR_DELETA := ''S'';',
'            end if;',
'            if l_operador_cancela_requisicoes = ''S'' --and :P181_COD_SIT_REQ = 2',
'            then',
'                :P91_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;',
'            ',
'        elsif :P_PAINEL = ''PG'' then     -- Painel do Gestor',
'        --sekect periodo gestor',
'            if (:P91_COD_SIT_REQ = 2 or :P91_COD_SIT_REQ = 1 )  then',
'                :P91_OPERADOR_DELETA := ''S'';',
'                :P91_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;',
'            ',
'        else    -- Painel do Colaborador',
'            --',
'            if :P91_COD_SIT_REQ = 1 then',
'                :P91_OPERADOR_DELETA := ''S'';',
'                :P91_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;        ',
'        end if;',
'   end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(56128747856148568792)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Recupera dados'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'    IF :p91_cod_req IS NOT NULL THEN',
'        select  ',
'                nvl(hora_inicio_afastamento, ''00:00''), ',
'                nvl(hora_termino_afastamento, ''00:00''), ',
'                dt_inicio_afastamento,',
'                dt_termino_afastamento, ',
'                qtde_dias_afastamento',
'            INTO :P91_HORA_INICIO_AFASTAMENTO_DSP,',
'                    :P91_HORA_TERMINO_AFASTAMENTO_DSP,',
'                    :P91_DT_INICIO_AFASTAMENTO_DSP,',
'                    :P91_DT_TERMINO_AFASTAMENTO_DSP,',
'                    :P91_QTDE_DIAS_AFASTAMENTO_DSP',
'        from req_atestado_funcionario R',
'        where cod_req = :p91_cod_req;',
'        ',
'        select distinct case when am.dias_horas_ponto = ''D'' then ''DIAS'' else ''HORAS'' end TIPO',
'        into :P91_TIPO_ATESTADO',
'        from atestado_medico am',
'        where cod_atestado_medico = :P91_COD_ATESTADO_MEDICO;',
'',
'    END IF;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(138682779463846165945)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'RENDER'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_blob blob;',
'  l_len  number;',
'  --',
'  l_mime varchar2(255);',
'  l_name varchar2(255);',
'  --',
' -- l_client_id  docs_document_codes.client_id%type;',
' -- l_doc_code   docs_document_codes.doc_code%type;',
' l_rowid varchar2(500);',
'begin',
'/*',
'  l_client_id := regexp_substr(apex_application.g_x01, ''[0-9]+'', 1, 1);',
'  l_doc_code  := regexp_substr(apex_application.g_x01, ''[0-9]+'', 1, 2);',
'',
'  select doc_file_orig, dbms_lob.getlength(doc_file_orig), doc_mimetype_orig, doc_filename_orig --|| ''.jpg''',
'    into l_blob, l_len, l_mime, l_name',
'    from docs_document_codes',
'   where client_id = l_client_id',
'     and doc_code  = l_doc_code;',
'*/',
'',
'l_rowid := apex_application.g_x01;--regexp_substr(apex_application.g_x01, ''[0-9]+'', 1, 1);',
'',
'  select ARQ_1_ANEXO, dbms_lob.getlength(ARQ_1_ANEXO), ARQ_1_MIMETYPE, ARQ_1_NOME --|| ''.jpg''',
'    into l_blob, l_len, l_mime, l_name',
'    from REQ_ATESTADO_FUNCIONARIO',
'   where rowid = l_rowid;',
'',
'  if l_len > 0 then',
unistr('    -- seta header de sess\00E3o'),
'    owa_util.mime_header(l_mime, false);',
'    htp.p(''Content-length: '' || l_len);',
'    --htp.p(''Content-Disposition: '' || ''attachment'' || ''; filename="'' || l_name || ''"'');',
'    htp.p(''Content-Disposition: inline; filename="'' || l_name || ''"'');',
'    owa_util.http_header_close;',
'',
'    -- faz download',
'    sys.wpg_docload.download_file(l_blob);',
'    apex_application.stop_apex_engine;',
'  end if;',
'exception when others then',
'  htp.p(''param:'' || apex_application.g_x01 || '' / erro:'' || sqlerrm);',
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
