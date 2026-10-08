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
,p_default_id_offset=>789695335995812157
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2943 - Segurança do Trabalho - Controles
--
-- Application Export:
--   Application:     2943
--   Name:            Segurança do Trabalho - Controles
--   Date and Time:   17:11 Wednesday September 30, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 61
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00061
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>61);
end;
/
prompt --application/pages/page_00061
begin
wwv_flow_api.create_page(
 p_id=>61
,p_user_interface_id=>wwv_flow_api.id(137647235592464344980)
,p_name=>unistr('Criar/Editar: Requisi\00E7\00E3o de PPP / Laudo')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Criar/Editar: Requisi\00E7\00E3o de PPP / Laudo')
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20250729100802'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(72086954887986609181)
,p_name=>'Desdobramentos'
,p_template=>wwv_flow_api.id(137647209595626344886)
,p_display_sequence=>32
,p_include_in_reg_disp_sel_yn=>'Y'
,p_icon_css_classes=>'fa-users-chat'
,p_region_template_options=>'#DEFAULT#:t-Region--showIcon:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Comments--basic'
,p_display_point=>'BODY'
,p_item_display_point=>'BELOW'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ncd.num_desdobramento,',
'       '''' cod_area_remetente, ',
'       '''' cod_sub_area_remetente, ',
'       ncd.cod_empresa_remetente, ',
'       ncd.matricula_remetente,',
unistr('       case when 1=1 then ''<span> <aria-hidden="true" class="fa fa-user fa-2x"></span>'' /*apex_string.get_initials(p.nome)*/ else ''<span> <aria-hidden="true" class="fa fa-user-headset fa-2x"></span>'' end user_icon, -- \00EDcone do coment\00E1rio'),
unistr('case when 1=2 then ''backgroundColorBlue colorPink'' else ''backgroundColorPink colorBlue'' end icon_modifier, -- cor do coment\00E1rio'),
unistr('--''u-color-''||ora_hash(p.nome,45) icon_modifier, -- cor do coment\00E1rio'),
unistr('       initcap(p.nome) user_name, --nome do usu\00E1rio'),
unistr('--*       case when 1=1 then initcap(p.nome) else ''ATENDENTE - ''||initcap(p.nome) end user_name, --nome do usu\00E1rio'),
unistr('       ncd.comentario comment_text, -- /*replace(ncd.comentario ,chr(10),''<br>'')*/ comment_text, -- texto do coment\00E1rio'),
unistr('       to_char(ncd.dt_atualizacao,''dd/mm/rrrr hh24:mi:ss'') COMMENT_DATE, -- data do coment\00E1rio'),
'       null ATTRIBUTE_1,',
'       null ATTRIBUTE_2,',
'       null ATTRIBUTE_3,',
'       null ATTRIBUTE_4,',
'--''Delete'' actions,',
'       null ACTIONS',
'from DESDOBRAMENTOS_SOLIC_PPP NCD,',
'     inf_pessoais_cad p',
'where p.cod_empresa         = ncd.COD_EMPRESA_REMETENTE(+)',
'and   p.matricula           = ncd.MATRICULA_REMETENTE(+)',
'and   COD_REQ               = :P61_COD_REQ',
'order by ncd.NUM_DESDOBRAMENTO'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P61_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(137647217874825344901)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72086955027282609183)
,p_query_column_id=>1
,p_column_alias=>'NUM_DESDOBRAMENTO'
,p_column_display_sequence=>1
,p_column_heading=>'Num Desdobramento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72086955148809609184)
,p_query_column_id=>2
,p_column_alias=>'COD_AREA_REMETENTE'
,p_column_display_sequence=>2
,p_column_heading=>'Cod Area Remetente'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72086955234647609185)
,p_query_column_id=>3
,p_column_alias=>'COD_SUB_AREA_REMETENTE'
,p_column_display_sequence=>3
,p_column_heading=>'Cod Sub Area Remetente'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204693695112666336)
,p_query_column_id=>4
,p_column_alias=>'COD_EMPRESA_REMETENTE'
,p_column_display_sequence=>4
,p_column_heading=>'Cod Empresa Remetente'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204693801562666337)
,p_query_column_id=>5
,p_column_alias=>'MATRICULA_REMETENTE'
,p_column_display_sequence=>5
,p_column_heading=>'Matricula Remetente'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204693878466666338)
,p_query_column_id=>6
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>6
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204693924500666339)
,p_query_column_id=>7
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>7
,p_column_heading=>'Icon Modifier'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694014721666340)
,p_query_column_id=>8
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>8
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694181797666341)
,p_query_column_id=>9
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>9
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694253327666342)
,p_query_column_id=>10
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>10
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694362972666343)
,p_query_column_id=>11
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>11
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694475226666344)
,p_query_column_id=>12
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>12
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694522946666345)
,p_query_column_id=>13
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>13
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694658791666346)
,p_query_column_id=>14
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>14
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(72204694750955666347)
,p_query_column_id=>15
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>15
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(122393573600097451979)
,p_plug_name=>unistr('Criar/Editar: Requisi\00E7\00E3o de PPP / Laudo')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647201518132344872)
,p_plug_display_sequence=>22
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'SOLICITACAO_PPP'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(122393560616266254482)
,p_plug_name=>'Menu'
,p_parent_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(122393560654800254483)
,p_plug_name=>'Detalhes'
,p_parent_plug_id=>wwv_flow_api.id(122393560616266254482)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(137647209595626344886)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(122393560816184254484)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(122393560616266254482)
,p_template=>wwv_flow_api.id(137647209595626344886)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_SOLICITACAO_PPP a, usuario_oracle u',
' where a.cod_req = :P61_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
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
'  from APROVA_SOLICITACAO_PPP a, usuario_oracle u',
' where a.cod_req = :p61_cod_req ',
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
'  from APROVA_SOLICITACAO_PPP',
' where cod_req = :p61_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P61_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(137647218407180344902)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283211835768229893)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283212246322229893)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283212700144229893)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283213103059229894)
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
 p_id=>wwv_flow_api.id(121283213531876229894)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283213896298229895)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283214310244229895)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(121283214726850229895)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(122393583009085451999)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(137647201601304344873)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(72086954749258609180)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(72086954887986609181)
,p_button_name=>'Desdobramento'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(137647230560944344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar Desdobramento'
,p_button_position=>'BELOW_BOX'
,p_button_redirect_url=>'f?p=&APP_ID.:65:&SESSION.::&DEBUG.:RP,65:P65_COD_REQ:&P61_COD_REQ.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283217427414229899)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p61_COD_REQ is not null and :p61_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;',
'return true;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283215107337229896)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(122393560816184254484)
,p_button_name=>'p61_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(137647230560944344930)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P61_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_PPP.Valida_Sequencia(:p61_cod_emp_solicitado, :p61_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
' ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283216606944229898)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283215529745229896)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(122393560816184254484)
,p_button_name=>'p61_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(137647230560944344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P61_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'  PKG_REQ_PPP.Valida_Sequencia(:p61_cod_emp_solicitado, :p61_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
' ',
' if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'  return false;',
' else',
'  return true;',
' end if;',
' ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283217788876229899)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_button_condition=>'P61_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121283216984517229898)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(122393583009085451999)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(137647230387224344930)
,p_button_image_alt=>'Delete'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283201760863229881)
,p_name=>'P61_COD_REQ'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>2
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283202196646229881)
,p_name=>'P61_DT_REQ'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_format_mask=>'dd/mm/yyyy'
,p_source=>'DT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283202559048229881)
,p_name=>'P61_COD_SIT_REQ'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283202988810229882)
,p_name=>'P61_DT_SIT_REQ'
,p_source_data_type=>'DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_format_mask=>'dd/mm/yyyy'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283203424883229882)
,p_name=>'P61_COD_EMP_SOLICITANTE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283203737771229882)
,p_name=>'P61_MAT_SOLICITANTE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283204209571229883)
,p_name=>'P61_SOLICITANTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>'Solicitante'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cargo ',
'  from informacoes_funcionais',
' where cod_empresa = :p61_cod_emp_solicitante',
'   and matricula = :p61_mat_solicitante;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'return :p61_cod_emp_solicitante||'' - ''||initcap(fnct_nome_empresa(:p61_cod_emp_solicitante))||'' / ''||:p61_mat_solicitante||'' - ''||initcap(fnct_nome_func(:p61_cod_emp_solicitante,:p61_mat_solicitante));',
'',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283204623040229883)
,p_name=>'P61_COD_EMP_SOLICITADO'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>'Empresa'
,p_source=>'COD_EMP_SOLICITADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>'SELECT emp.cod||'' - ''||emp.nome Dsp, emp.cod Ret FROM empresas emp ORDER BY emp.cod'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>2
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283204943839229883)
,p_name=>'P61_MATRICULA_SOLICITADO'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA_SOLICITADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) descricao, matricula cod',
'  from informacoes_funcionais_cad i',
' where cod_empresa = :p61_COD_EMP_SOLICITADO',
' --  and ((:p61_COD_REQ is null and ((i.situacao < ''90'') or (i.situacao > ''89'' and i.dt_admissao >= trunc(sysdate)-30)))',
'   --or (:p61_COD_REQ is not null))',
'    AND ((:p_painel <> ''PC'') or ',
'         (i.cod_empresa = :P_EMPRESA_USER',
'         and i.matricula = :P_MATRICULA_USER',
'         and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_COD_EMP_SOLICITADO,P61_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>2
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647230128885344924)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283205342185229883)
,p_name=>'P61_ITEM_VALIDACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283205749145229884)
,p_name=>'P61_OK'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283206190000229884)
,p_name=>'P61_FLAG'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283206587314229884)
,p_name=>'P61_MENSAGEM'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283208362126229887)
,p_name=>'P61_TIPO_SOLICITACAO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_item_default=>'PPP'
,p_prompt=>unistr('Objeto da Solicita\00E7\00E3o')
,p_source=>'TIPO_SOLICITACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:PPP;PPP,LTCAT;LTCAT,LI;LI,Per\00EDcia;PRCA')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_read_only_when=>'P61_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(137647230206056344924)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283208806866229887)
,p_name=>'P61_OBSERVACAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(137647230044348344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283209177854229887)
,p_name=>'P61_ARQUIVO'
,p_source_data_type=>'BLOB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_prompt=>'Documento'
,p_source=>'ARQUIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(137647230044348344923)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TIPO_ARQUIVO'
,p_attribute_03=>'NOME_ARQUIVO'
,p_attribute_04=>'CHARSET_ARQUIVO'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283209574379229888)
,p_name=>'P61_NOME_ARQUIVO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'NOME_ARQUIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283209979854229888)
,p_name=>'P61_TIPO_ARQUIVO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'TIPO_ARQUIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283210398201229888)
,p_name=>'P61_CHARSET_ARQUIVO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'CHARSET_ARQUIVO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283210742135229889)
,p_name=>'P61_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_format_mask=>'dd/mm/yyyy hh24:mi:ss'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283211155366229889)
,p_name=>'P61_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(122393560654800254483)
,p_item_source_plug_id=>wwv_flow_api.id(122393573600097451979)
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(121283215839660229897)
,p_name=>'P61_OBS_APROVADOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(122393560816184254484)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o do Aprovador')
,p_placeholder=>unistr('Informe alguma observa\00E7\00E3o.')
,p_source=>'OBS_APROVADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from APROVA_ABONO',
' where cod_solicitacao = :p61_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_read_only_when_type=>'NOT_EXISTS'
,p_field_template=>wwv_flow_api.id(137647229946620344923)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(121281086343835874224)
,p_computation_sequence=>10
,p_computation_item=>'P61_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':p_usuario'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(121281086454426874225)
,p_computation_sequence=>10
,p_computation_item=>'P61_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'to_char(sysdate,''dd/mm/yyyy hh24:mi:ss'')'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283234182257229912)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(121283216606944229898)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283234717477229912)
,p_event_id=>wwv_flow_api.id(121283234182257229912)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283225050209229906)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(121283215107337229896)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283225623019229906)
,p_event_id=>wwv_flow_api.id(121283225050209229906)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283226021898229906)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(121283215529745229896)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283226438312229906)
,p_event_id=>wwv_flow_api.id(121283226021898229906)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283226908766229907)
,p_name=>'Ativa Alertify'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283227393765229907)
,p_event_id=>wwv_flow_api.id(121283226908766229907)
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
 p_id=>wwv_flow_api.id(121283227783750229907)
,p_name=>'Hide Fields'
,p_event_sequence=>50
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P61_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283228259253229908)
,p_event_id=>wwv_flow_api.id(121283227783750229907)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_REQ,P61_DT_REQ,P61_COD_SIT_REQ,P61_DT_SIT_REQ,P61_COD_EMP_SOLICITANTE,P61_MAT_SOLICITANTE,P61_SOLICITANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283228708297229908)
,p_name=>'Hide Fields_1'
,p_event_sequence=>60
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P61_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283229139443229908)
,p_event_id=>wwv_flow_api.id(121283228708297229908)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EMP_SOLICITANTE,P61_MAT_SOLICITANTE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283230950369229909)
,p_name=>'Dispara Alerta'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_MENSAGEM'
,p_condition_element=>'P61_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283231442427229910)
,p_event_id=>wwv_flow_api.id(121283230950369229909)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P61_FLAG'').value == "Q") {',
'alertify.confirm($v(''P61_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P61_FLAG'').value = ''S'';',
'        $x(''P61_MENSAGEM'').value = '''';',
'        $x(''P61_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P61_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P61_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P61_FLAG'').value == "N") {',
'            $x(''P61_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P61_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P61_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P61_MENSAGEM''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P61_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P61_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P61_ITEM_VALIDACAO'').value == ''P61_CREATE''){',
'            $x(''P61_OK'').value = ''S'';',
'        $x(''P61_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283231861870229910)
,p_name=>'OK: Show Create'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_ITEM_VALIDACAO'
,p_condition_element=>'P61_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283232874492229911)
,p_event_id=>wwv_flow_api.id(121283231861870229910)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(121283217427414229899)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283232431484229910)
,p_event_id=>wwv_flow_api.id(121283231861870229910)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(121283217427414229899)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283233292847229911)
,p_name=>'Valida Sit Req'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283233781534229911)
,p_event_id=>wwv_flow_api.id(121283233292847229911)
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
'cursor c1 is',
'select cod_req',
'  from solicitacao_ppp',
' where cod_req = :p61_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_req is not null then',
'',
' pkg_req_ppp.Valida_Sit_Req(:p61_COD_EMP_SOLICITADO, :p61_cod_req, :p61_MATRICULA_SOLICITADO, :p61_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'NULL;',
'',
'end if;',
'',
' if v_msg_retorno is not null then',
'    :p61_ok       := ''N'';',
'    :p61_flag     := v_flg_retorno;',
'    :p61_mensagem := v_msg_retorno;',
' else',
'    :p61_flag     := null;',
'    :p61_mensagem := null;',
'    :p61_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P716_COD_EMP_SOLICITADO,P716_COD_REQ,P716_COD_SIT_REQ,P_USUARIO,P716_MATRICULA_SOLICITADO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM,P61_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(121283223664746229904)
,p_name=>'Sinaliza preenchimento'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_MATRICULA_SOLICITADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(121283224187195229905)
,p_event_id=>wwv_flow_api.id(121283223664746229904)
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
'v_item_validacao varchar2(100) := :P61_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p61_mensagem := null;',
' :p61_flag     := null;',
' :p61_mensagem := null;',
' :P61_OK := ''S'';',
' :P61_ITEM_VALIDACAO := null;',
' ',
'end;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(72204694924949666349)
,p_name=>'Refresh Desdobramentos'
,p_event_sequence=>120
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(72086954749258609180)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(72204695102564666350)
,p_event_id=>wwv_flow_api.id(72204694924949666349)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(72086954887986609181)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283222112011229903)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_seq number;',
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;   ',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  begin',
'  SELECT seq_requisicao.NEXTVAL',
'  INTO v_seq ',
'  FROM DUAL;',
'  end;',
'',
':p61_cod_req := v_seq;',
':p61_cod_sit_req := 1;',
':p61_dt_req := sysdate;',
':p61_dt_sit_req := sysdate;',
':p61_cod_emp_solicitante := :P_EMPRESA_USER;',
':p61_mat_solicitante := :P_MATRICULA_USER;',
'-- :p61_fil_req := v_c1.filial;',
':p61_usuario := :p_usuario;',
':p61_dt_atualizacao := to_char(sysdate,''dd/mm/rrrr hh24:mi:ss'');',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(121283217788876229899)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283207384229229885)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(122393573600097451979)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form Criar/Editar: Requisi\00E7\00E3o de PPP / Laudo')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Processo Realizado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283222460554229904)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'vexiste varchar2(1) := ''N'';',
'',
'begin',
'',
' begin',
'   select distinct ''S'' INTO vexiste from aprova_solicitacao_ppp where cod_req = :p61_cod_req;',
' exception',
'   when no_data_found then',
'     vexiste := ''N'';',
' end;',
'if nvl(vexiste,''N'') = ''N'' then',
'PKG_REQ_PPP.Post_Insert(:P61_cod_emp_solicitado          ,',
'                         :P61_cod_req      ,',
'                         V_flg_retorno             ,',
'                         V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    :p61_ok       := ''N'';',
'    :p61_flag     := v_flg_retorno;',
'    :p61_mensagem := v_msg_retorno;',
' else',
'    :p61_flag     := null;',
'    :p61_mensagem := null;',
'    :p61_ok       := ''S'';',
' end if;',
'end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(121283217788876229899)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283222866416229904)
,p_process_sequence=>60
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
'PKG_REQ_PPP.Post_Update(:P61_cod_emp_solicitado          ,',
'                       :P61_cod_req      ,',
'                      V_flg_retorno             ,',
'                      V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    :p61_ok       := ''N'';',
'    :p61_flag     := v_flg_retorno;',
'    :p61_mensagem := v_msg_retorno;',
' else',
'    :p61_flag     := null;',
'    :p61_mensagem := null;',
'    :p61_ok       := ''S'';',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(121283217427414229899)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283223297158229904)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Processo executado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(98666372168178734104)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicio'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_painel = ''PC'' then',
'    if :p61_COD_REQ is null then',
'        :P61_COD_EMP_SOLICITADO := :p_empresa_user;',
'        :P61_MATRICULA_SOLICITADO := :p_matricula_user;',
'    end if;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P_PAINEL'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'PC'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(121283206999277229885)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(122393573600097451979)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form Criar/Editar: Requisi\00E7\00E3o de PPP / Laudo')
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
