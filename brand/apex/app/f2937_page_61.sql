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
,p_default_id_offset=>790116784104559759
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   20:47 Wednesday September 30, 2026
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
,p_user_interface_id=>wwv_flow_api.id(176378098008189704537)
,p_name=>unistr('Solicita\00E7\00E3o de Exames: Criar/Editar')
,p_step_title=>unistr('Solicita\00E7\00E3o de Exames: Criar/Editar')
,p_autocomplete_on_off=>'OFF'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Exames.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Exames.js'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.message.setThemeHooks({',
'    beforeShow: function( pMsgType, pElement$ ){',
'        if ( pMsgType === apex.message.TYPE.ERROR ) {',
'          ',
'            apex.item("P61_TIPO_PACIENTE").disable();',
'            apex.item("P61_COD_EMP_PACIENTE").disable();',
'            apex.item("P61_COD_PACIENTE").disable();',
'            apex.item("P61_FILIAL_AUX").disable();',
'',
'        }',
'    }',
'});'))
,p_step_template=>wwv_flow_api.id(176378055896321704366)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_Exames.css / Natcorp_Exames.js)',
'',
unistr('A estrutura \00E9 toda do APEX; o .js s\00F3 reorganiza a leitura (sem classe no APEX).'),
unistr('  Pedido novo: passos 1 Quem vai fazer o exame? \00B7 2 Que exame? \00B7 3 Quando? \00B7 4 Alguma observa\00E7\00E3o?;'),
unistr('  Candidato / Colaborador e os tipos de exame em cart\00F5es (setValue nos itens de verdade); o cart\00E3o'),
unistr('  da consulta com "Escolher dia e hor\00E1rio" (clica o bot\00E3o da agenda, que fica fora de vista); barra'),
unistr('  no p\00E9 com o que falta e "Criar" = "Enviar pedido".'),
unistr('  Pedido gravado: cabe\00E7alho claro com c\00F3digo - descri\00E7\00E3o; o registro da agenda (dia, hor\00E1rio,'),
unistr('  m\00E9dico) \00E9 o \00FAnico bloco em roxo; Situa\00E7\00E3o, Salvar, Cancelar e Voltar numa linha de a\00E7\00F5es; a'),
unistr('  aprova\00E7\00E3o logo abaixo, na largura toda.'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/EXAMES-MANUTENCAO.md.'))
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260730145010'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291955554491679720)
,p_plug_name=>unistr('Requisi\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_02'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165293745870725817710)
,p_plug_name=>'REQ_STATUS'
,p_parent_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--stretchInputs:margin-top-lg'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :p61_rowid is null then',
'    return false;',
'  else',
'',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291956341189679728)
,p_plug_name=>'Menu'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--large:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(165291956412074679729)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(165291956341189679728)
,p_template=>wwv_flow_api.id(176378072011351704443)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
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
'       a.justificativa',
'  from aprova_exames a, usuario_oracle u',
' where a.cod_req = :p61_cod_req ',
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
'       a.justificativa',
'  from aprova_exames a, usuario_oracle u',
' where a.cod_req = :p61_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from aprova_exames a',
' where a.cod_req = :p61_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P61_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(176378080822905704459)
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
 p_id=>wwv_flow_api.id(165291956510891679730)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(165291956641770679731)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(165291956755636679732)
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
 p_id=>wwv_flow_api.id(165291956869771679733)
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
 p_id=>wwv_flow_api.id(165291956924504679734)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(165291957062280679735)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(165291957157030679736)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(165291957244080679737)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165293376763895848198)
,p_plug_name=>'REGION_APROVACAO'
,p_parent_plug_id=>wwv_flow_api.id(165291956412074679729)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>6
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''APROVAR'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if v_flag = ''N'' then',
'return false;',
'elsif v_flag = ''S'' then',
'return true;',
'else ',
'return false;',
'end if;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165292539061320316032)
,p_plug_name=>unistr('Informa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(165291956341189679728)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291955954767679724)
,p_plug_name=>'Paciente'
,p_parent_plug_id=>wwv_flow_api.id(165292539061320316032)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291956042330679725)
,p_plug_name=>'Exame'
,p_parent_plug_id=>wwv_flow_api.id(165292539061320316032)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291956171129679726)
,p_plug_name=>'Agendamento'
,p_parent_plug_id=>wwv_flow_api.id(165292539061320316032)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(176378072011351704443)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'FUNCTION_BODY'
,p_plug_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :p61_rowid is null then',
'    return false;',
'  else',
'',
'--    if :p61_cod_sit_req in (2,3,4,5) then --voltar',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return true;',
'    else',
'      if :p61_data_agenda is null then',
'        return false;',
'      else',
'        return true;',
'      end if;',
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(165291956207785679727)
,p_plug_name=>unistr('Bot\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(165292539061320316032)
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--noUI'
,p_plug_template=>wwv_flow_api.id(176378064017029704430)
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>6
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166756973199276981827)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Exames')
,p_icon_css_classes=>'fa-bullhorn'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(176378070436263704440)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(166171095400029713542)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(176378093298946704488)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_plug_header=>'<p> </p>'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165293746047116817712)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165293745870725817710)
,p_button_name=>'EM_ANDAMENTO_REQ'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092976669704487)
,p_button_image_alt=>'Em Andamento'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_SIT_REQ'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  1,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if (v_flag = ''N'' and trim(v_mensagem) is not null) or :p61_cod_req is null or :p61_cod_sit_req = 1 then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-play'
,p_security_scheme=>wwv_flow_api.id(159803789140689565298)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165293745954949817711)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165293745870725817710)
,p_button_name=>'SUSPENDER_REQ'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092976669704487)
,p_button_image_alt=>'Suspender'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_SIT_REQ'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  6,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if (v_flag = ''N'' and trim(v_mensagem) is not null) or :p61_cod_req is null or :p61_cod_sit_req = 6 then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-pause'
,p_security_scheme=>wwv_flow_api.id(159803789140689565298)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165293745700287817709)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(165293745870725817710)
,p_button_name=>'CANCELAR_REQ'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092976669704487)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_SIT_REQ'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  3,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if (v_flag = ''N'' and trim(v_mensagem) is not null) or :p61_cod_req is null or :p61_cod_sit_req = 3 then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_security_scheme=>wwv_flow_api.id(159803789140689565298)
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(149284605672889831292)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_button_name=>'BT_GUIA_EXAMES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Guia de Exames'
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VHABILITA_BOTAO VARCHAR2(1) := ''N'';',
'BEGIN',
'  BEGIN',
'    SELECT DISTINCT ''S'' habilita_botao',
'    INTO   VHABILITA_BOTAO',
'    FROM   GRUPO_EXAME_CARGO G',
'          ,SOLICITACAO_EXAMES SE',
'          ,EXAME E',
'    WHERE  E.COMPLEMENTAR = ''S''',
'    AND    E.COD_EXAME = G.COD_EXAME',
'    AND    INSTR(SE.GRUPO_EXAME_CARGO,G.COD) > 0',
'    AND    SE.COD_REQ = :P61_COD_REQ;',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      VHABILITA_BOTAO := ''N'';',
'  END;',
'  ',
'  FOR X IN (SELECT COD_SIT_REQ, GRUPO_EXAME_CARGO FROM SOLICITACAO_EXAMES WHERE COD_REQ = :P61_COD_REQ) LOOP',
'    IF X.COD_SIT_REQ NOT IN (2,3,4,6)',
'       AND INSTR(X.GRUPO_EXAME_CARGO,''SRO'') = 0 AND NVL(VHABILITA_BOTAO,''N'') = ''S'' THEN',
'       RETURN(TRUE);',
'    ELSE',
'       RETURN(FALSE);',
'    END IF;',
'  END LOOP;',
'  RETURN(FALSE);',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(149281259269045406700)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_button_name=>'BT_AGENDA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Agenda - Datas e Hor\00E1rios')
,p_button_position=>'REGION_TEMPLATE_CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:75:&SESSION.::&DEBUG.:RP,75:P75_REQ_EXAME,P75_COD_EMPRESA_AUX:&P61_COD_REQ.,&P61_COD_EMP_PACIENTE.'
,p_button_condition=>'2,3,4,6'
,p_button_condition_type=>'REQUEST_NOT_IN_CONDITION'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165292539737848316037)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_button_name=>'BACK'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165293376694252848197)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165293376763895848198)
,p_button_name=>'REPROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--danger:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092976669704487)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P61_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''APROVAR'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if v_flag = ''N'' then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165294904884044361097)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(165291956207785679727)
,p_button_name=>'BACK_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:60:&SESSION.::&DEBUG.:::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165292539475213316036)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165291956207785679727)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P61_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_security_scheme=>wwv_flow_api.id(159803788651440565297)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165293376524710848196)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(165293376763895848198)
,p_button_name=>'APROVAR'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--success:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092976669704487)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P61_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''APROVAR'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if v_flag = ''N'' then',
'return false;',
'else',
'return true;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(165292539515290316036)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(165291956207785679727)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--large:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(176378092802949704487)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :p61_rowid is null then',
'    return false;',
'  else',
'',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_security_scheme=>wwv_flow_api.id(159803789140689565298)
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(165292541392199316043)
,p_branch_action=>'f?p=&APP_ID.:60:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21497297875661108353)
,p_name=>'P61_FUNCAO_PROPOSTA'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fun\00E7\00E3o Proposta')
,p_source=>'FUNCAO_PROPOSTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD||''-''||NOME DSCFUNCAO, COD',
'  FROM FUNCAO',
' WHERE COD_CARGO = :P61_CARGO_PROPOSTO',
'   AND TRUNC(SYSDATE) BETWEEN DT_INIC_VIG_FUNCAO AND DT_TERM_VIG_FUNCAO',
' ORDER BY 2',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_CARGO_PROPOSTO'
,p_ajax_items_to_submit=>'P61_CARGO_PROPOSTO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>7
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(41234870843993249608)
,p_name=>'P61_VERIF_ID_RISCO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(102646432325585652786)
,p_name=>'P61_MEDICO_DSP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(PS.COD_PREST_SERV||'' - ''||PS.NOME)',
'FROM   SOLICITACAO_EXAMES SE',
'      ,PRESTADOR_SERVICO PS',
'WHERE  PS.COD_PREST_SERV  = SE.COD_PREST_SERV',
'AND    PS.TIPO_PREST_SERV = SE.TIPO_PREST_SERV',
'AND    SE.COD_REQ = :P61_COD_REQ'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('M\00E9dico')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>4
,p_display_when=>'P61_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(129514910573559654455)
,p_name=>'P61_CARGO_ATUAL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(129514910655984654456)
,p_name=>'P61_FUNCAO_ATUAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(129514910796879654457)
,p_name=>'P61_LOCAL_TRAB_ATUAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141686238185936188140)
,p_name=>'P61_OPERACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147433870312843107580)
,p_name=>'P61_GRUPO_EXAME_CARGO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Grupo Exame'
,p_source=>'GRUPO_EXAME_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT G.COD /*||'' - ''||G.DESCRICAO D,*/, G.COD C',
'FROM(select b.cod COD_GRUPO_RISCO from GRUPO_EXAME_CARGO b where rownum <= 1  and   b.cod = ''SRO'' AND NOT EXISTS (select distinct a.cod_exame',
'from risco_funcao C, st_risco_exame A',
'where C.Cod_Result_Matriz > 6',
'AND TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO   = C.COD_RISCO',
'AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'union',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'where C.Cod_Result_Matriz > 6',
'AND TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO      = C.COD_RISCO',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA  AND c.cod_empresa    = :P61_COD_EMP_PACIENTE  and c.cod_local_trab = :P61_LOCAL_PRETENDIDO)',
'UNION',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_funcao C, st_risco_exame A',
'where C.Cod_Result_Matriz > 6',
'AND TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'union',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'where C.Cod_Result_Matriz > 6',
'AND TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA AND c.cod_empresa = :P61_COD_EMP_PACIENTE and c.cod_local_trab = :P61_LOCAL_PRETENDIDO) X',
',GRUPO_EXAME_CARGO G',
'WHERE X.COD_GRUPO_RISCO = G.COD',
'AND ((:P61_ROWID IS NOT NULL) OR (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'and (:P61_CARGO_PROPOSTO is not null or :P61_LOCAL_PRETENDIDO is not null)  AND :P61_COD_TIPO_CONSULTA IS NOT NULL AND :P61_TIPO_PACIENTE IN (1,2)',
'UNION',
'SELECT DISTINCT G.COD /*||'' - ''||G.DESCRICAO D,*/, G.COD C',
'FROM   (SELECT DISTINCT S.GRUPO_RISCO COD_GRUPO_RISCO',
'FROM   VW_RISCO_ELEG_COLABORADOR V ,ST_RISCO_EXAME S, MATRIZ_RESULTADO MR',
'WHERE  RISCO IS NOT NULL AND S.COD_RISCO = V.RISCO AND    S.COD_EMPRESA = V.COD_EMPRESA AND    V.MATRICULA   = :P61_COD_PACIENTE AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'AND    V.COD_RESULT_MATRIZ > 6 AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1)',
'UNION',
'SELECT ''SRO'' COD_GRUPO_RISCO FROM   DUAL',
'WHERE  NOT EXISTS (SELECT *',
'FROM   VW_RISCO_ELEG_COLABORADOR V, MATRIZ_RESULTADO MR WHERE  RISCO IS NOT NULL AND    V.MATRICULA   = :P61_COD_PACIENTE AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'AND    V.COD_RESULT_MATRIZ > 6 AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1))) X ,GRUPO_EXAME_CARGO G',
'WHERE  G.COD = X.COD_GRUPO_RISCO',
'AND    ((:P61_ROWID IS NOT NULL) OR',
'(TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND',
'NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'AND :P61_TIPO_PACIENTE = 1',
'and (:P61_CARGO_PROPOSTO is null and :P61_LOCAL_PRETENDIDO is null)',
'AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_TIPO_PACIENTE,P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_FILIAL_AUX'
,p_ajax_items_to_submit=>'P61_ROWID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_cMaxlength=>500
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
,p_attribute_11=>','
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147433870380233107581)
,p_name=>'P61_GRUPO_EXAME_CARGO_DSP'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_item_default=>'P61_GRUPO_EXAME_CARGO'
,p_item_default_type=>'ITEM'
,p_prompt=>'Grupo Exame'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT G.COD/*||'' - ''||G.DESCRICAO D*/, G.COD C',
'FROM(select b.cod COD_GRUPO_RISCO',
'       from GRUPO_EXAME_CARGO b',
'      where rownum <= 1',
'       and   b.cod = ''SRO''',
'       AND NOT EXISTS (select distinct a.cod_exame',
'        from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO   = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA',
'         and C.COD_CARGO   = :P61_CARGO_PROPOSTO',
'         AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO',
'        from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA    = C.COD_EMPRESA',
'         AND c.cod_empresa    = :P61_COD_EMP_PACIENTE',
'         and c.cod_local_trab = :P61_LOCAL_PRETENDIDO)',
'      UNION',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO',
'        from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA',
'         and C.COD_CARGO = :P61_CARGO_PROPOSTO',
'         AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO',
'        from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA',
'         AND c.cod_empresa = :P61_COD_EMP_PACIENTE',
'         and c.cod_local_trab = :P61_LOCAL_PRETENDIDO) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE X.COD_GRUPO_RISCO = G.COD',
'AND ((:P61_ROWID IS NOT NULL) OR',
'       (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND',
'       NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   and (:P61_CARGO_PROPOSTO is not null or',
'       :P61_LOCAL_PRETENDIDO is not null)',
'   AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'   AND :P61_TIPO_PACIENTE IN (1,2)',
'UNION',
'SELECT DISTINCT G.COD/*||''-''||G.DESCRICAO D*/, G.COD C',
'FROM   (SELECT DISTINCT S.GRUPO_RISCO COD_GRUPO_RISCO',
'        FROM   VW_RISCO_ELEG_COLABORADOR V',
'              ,ST_RISCO_EXAME S',
'        WHERE  RISCO IS NOT NULL',
'        AND    S.COD_RISCO = V.RISCO',
'        AND    S.COD_EMPRESA = V.COD_EMPRESA',
'        AND    V.MATRICULA   = :P61_COD_PACIENTE',
'        AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'        UNION',
'        SELECT ''SRO'' COD_GRUPO_RISCO',
'        FROM   DUAL',
'        WHERE  NOT EXISTS (SELECT *',
'                           FROM   VW_RISCO_ELEG_COLABORADOR V',
'                           WHERE  RISCO IS NOT NULL',
'                           AND    V.MATRICULA   = :P61_COD_PACIENTE',
'                           AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE)) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE  G.COD = X.COD_GRUPO_RISCO',
'AND    ((:P61_ROWID IS NOT NULL) OR',
'       (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND',
'       NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   AND :P61_TIPO_PACIENTE = 1',
'   and (:P61_CARGO_PROPOSTO is null and :P61_LOCAL_PRETENDIDO is null)',
'   AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'ORDER BY 2'))
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281259104421406698)
,p_name=>'P61_DATA_AGENDA_DSP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_prompt=>'Data'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- ready only',
'begin',
'',
'  if :p61_rowid is null then',
'    return false;',
'  else',
'',
'--    if :p61_cod_sit_req in (2,3,4,5) then --voltar',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return true;',
'    else',
'      if :p61_data_agenda is null then',
'        return false;',
'      else',
'        return true;',
'      end if;',
'    end if;',
'',
'  end if;',
'',
'end;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149281259497958406702)
,p_name=>'P61_AGENDA_ROWID'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(149284606633885831302)
,p_name=>'P61_APAGAR'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(152925520088205212761)
,p_name=>'P61_FILIAL_AUX'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VFILIAL FILIAIS.COD_FILIAL%TYPE;',
'BEGIN',
'  IF :P61_COD_REQ IS NOT NULL AND :P61_FILIAL_AUX IS NULL THEN',
'  IF :P61_TIPO_PACIENTE = 1 THEN',
'    BEGIN',
'      SELECT FILIAL',
'      INTO   VFILIAL',
'      FROM   INFORMACOES_FUNCIONAIS_CAD',
'      WHERE  MATRICULA = :P61_COD_PACIENTE',
'      AND    COD_EMPRESA = :P61_COD_EMP_PACIENTE;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VFILIAL := NULL;',
'    END;',
'  ELSIF :P61_TIPO_PACIENTE = 2 AND :P61_COD_EMP_PACIENTE IS NOT NULL AND :P61_COD_PACIENTE IS NOT NULL THEN',
'    BEGIN',
'      SELECT COD_FILIAL',
'      INTO   VFILIAL',
'      FROM   INF_FUNC_CANDIDATO',
'      WHERE  ROWNUM = 1',
'      AND    COD_CANDIDATO = :P61_COD_PACIENTE;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VFILIAL := NULL;',
'    END;',
'  ELSE',
'    VFILIAL := NULL;',
'  END IF;',
'    RETURN(VFILIAL);',
'  ELSE',
'    RETURN(:P61_FILIAL_AUX);',
'  END IF;',
'END;'))
,p_item_default_type=>'PLSQL_FUNCTION_BODY'
,p_prompt=>'Filial'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_FILIAL||'' - ''||INITCAP(NOME_FILIAL) D, COD_FILIAL C',
'FROM   FILIAIS_cad',
'WHERE  COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'-- Chamado 29002 -- Andre -- 16-04-2023 --',
'AND COD_FILIAL IN (select CD_FILIAL',
'                           from usuario_oracle_filiais',
'                           where nm_usuario_oracle = v(''P_USUARIO'')',
'                  and cd_empresa = :P61_COD_EMP_PACIENTE )',
'-- Chamado 29002 -- Andre -- 16-04-2023 --',
'ORDER  BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_COD_EMP_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(159994009737786048060)
,p_name=>'P61_CARGO_PROPOSTO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Cargo Proposto'
,p_source=>'CARGO_PROPOSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT C.COD||''-''||C.NOME||'', CBO: ''||C.COD_CBO||''-''||C.DC_CBO D, C.COD C',
'FROM   CARGOS_EMPRESAS CE',
'      ,CARGOS C',
'WHERE  TRUNC(SYSDATE) BETWEEN C.DT_INIC_VIG_CARGO AND C.DT_TERM_VIG_CARGO',
'AND    C.COD = CE.COD_CARGO',
'AND    CE.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'ORDER  BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_COD_EMP_PACIENTE'
,p_ajax_items_to_submit=>'P61_COD_EMP_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(159994009842418048061)
,p_name=>'P61_LOCAL_PRETENDIDO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Local Pretendido'
,p_source=>'LOCAL_PRETENDIDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('SELECT L.COD_LOCAL_TRAB||''-''||L.DESCRICAO||DECODE(L.PREDIO,NULL,NULL,'' - Pr\00E9dio ''||L.PREDIO)||DECODE(L.ANDAR,NULL,NULL,'' Andar ''||L.ANDAR)||DECODE(SALA,NULL,NULL,'' Sala ''||L.SALA) D, L.COD_LOCAL_TRAB'),
'FROM   FILIAL_LOCAL FL,  LOCAL_TRAB L',
'WHERE TRUNC(SYSDATE) BETWEEN L.DT_INICIO AND NVL(L.DT_FIM,TO_DATE(''31/12/2099'',''DD/MM/RRRR''))',
'AND   L.COD_LOCAL_TRAB = FL.COD_LOCAL_FILIAL',
'AND   FL.COD_FILIAL  = :P61_FILIAL_AUX',
'AND   FL.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_COD_EMP_PACIENTE'
,p_ajax_items_to_submit=>'P61_FILIAL_AUX,P61_COD_EMP_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(160100437147331656131)
,p_name=>'P61_GCOE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_source=>'GCOE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'  FROM GCOE',
' WHERE ((:P61_ROWID IS NOT NULL) OR ',
'        (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI,TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM,TRUNC(SYSDATE))))'))
,p_display_when_type=>'EXISTS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163773339261194664117)
,p_name=>'P61_DT_DESLIGAMENTO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dt. Desligamento'
,p_source=>'DT_DESLIGAMENTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>15
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163773339323078664118)
,p_name=>'P61_CLASS_ASO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292541697967316047)
,p_name=>'P61_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292542181729316060)
,p_name=>'P61_COD_REQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292542527417316061)
,p_name=>'P61_DT_REQ'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292542896069316062)
,p_name=>'P61_COD_SIT_REQ'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ',
' order by 2'))
,p_cHeight=>1
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'    ',
'end;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292543299376316062)
,p_name=>'P61_DT_SIT_REQ'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_format_mask=>'dd/mm/rrrr hh24:mi'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292543711701316065)
,p_name=>'P61_COD_EMP_SOLICITANTE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Solicitante'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev,nome)) d, cod c',
'  from empresas'))
,p_cSize=>100
,p_cMaxlength=>255
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292544103111316065)
,p_name=>'P61_MAT_SOLICITANTE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Solicitante'
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(nome) d, matricula c',
'  from inf_pessoais',
' where cod_empresa = :p61_cod_emp_solicitante'))
,p_lov_cascade_parent_items=>'P61_COD_EMP_SOLICITANTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>100
,p_cMaxlength=>255
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:margin-bottom-lg'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292544553536316066)
,p_name=>'P61_TIPO_PACIENTE'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_prompt=>'Tipo de Paciente'
,p_source=>'TIPO_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Colaborador;1,Candidato;2'
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292544935287316066)
,p_name=>'P61_COD_EMP_PACIENTE'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMP_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nvl(nome_abrev, nome)) d, cod c',
'  from empresas',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292545346494316066)
,p_name=>'P61_COD_PACIENTE'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Paciente'
,p_source=>'COD_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select upper(p.nome)||'' Matr\00EDcula: ''||p.matricula||'' CPF: ''||p.num_cpf||''-''||p.dc_cpf||'' RG: ''||p.num_identidade d, p.matricula'),
'from inf_pessoais_cad p, informacoes_funcionais_cad i, parametros_recursos_humanos param',
'where ((param.verif_id_risco = ''S'' and exists (select 1 from vw_risco_eleg_colaborador v where (v.id_risco is not null or v.risco is not null) and v.matricula = i.matricula',
'and v.cod_empresa = i.cod_empresa)) or (nvl(param.verif_id_risco,''N'') = ''N'')) and param.cod_empresa = i.cod_empresa and p.cod_empresa = i.cod_empresa and p.matricula = i.matricula',
'and (:p61_cod_emp_paciente is null or p.cod_empresa = :p61_cod_emp_paciente) and i.situacao < ''90'' and i.filial = NVL(:p61_filial_aux,I.FILIAL) and :p61_tipo_paciente = 1',
'and :p61_rowid is null',
'union',
'select p.matricula||'' - ''||upper(p.nome) d, p.matricula from inf_pessoais_cad p, informacoes_funcionais_cad i, parametros_recursos_humanos param',
'where ((param.verif_id_risco = ''S'' and exists (select 1 from vw_risco_eleg_colaborador v where (v.id_risco is not null or v.risco is not null) and v.matricula = i.matricula',
'and v.cod_empresa = i.cod_empresa)) or (nvl(param.verif_id_risco,''N'') = ''N'')) and param.cod_empresa = i.cod_empresa and p.cod_empresa = i.cod_empresa',
'and p.matricula = i.matricula and (:p61_cod_emp_paciente is null or p.cod_empresa = :p61_cod_emp_paciente) and i.filial = NVL(:p61_filial_aux,I.FILIAL) and :p61_tipo_paciente = 1 and :p61_rowid is not null',
'union',
'select upper(p.nome)||'' Candidato: ''||p.cod_candidato||'' CPF: ''||p.num_cpf||''-''||p.dc_cpf||'' RG: ''||p.num_identidade d, p.cod_candidato',
'from inf_pessoais_candidato p, inf_func_candidato i, parametros_recursos_humanos h',
'where p.empresa = i.cod_empresa and p.cod_candidato = i.cod_candidato and p.status_candidato = ''P'' and p.nome is not null and (:p61_cod_emp_paciente is null or p.empresa = i.cod_empresa)',
'and  ((h.verif_id_risco = ''S'' and ((exists (select 1 from risco_funcao f where trunc(sysdate) between nvl(f.dt_inicio, trunc(sysdate)) and nvl(f.dt_termino,to_date(''31/12/2099'',''dd/mm/rrrr''))',
'and f.cod_cargo = i.cargo_pretendido and f.cod_local_trab = i.local_pretendido and f.cod_filial = i.cod_filial and f.cod_empresa = i.cod_empresa))',
'or (exists (select 1 from risco_local_trab l where trunc(sysdate) between l.dt_ini_validade and l.dt_fim_validade and l.cod_local_trab = i.local_pretendido',
'and l.cod_filial = i.cod_filial and l.cod_empresa = i.cod_empresa)))) or (nvl(h.verif_id_risco,''N'') = ''N'')) and i.cod_empresa = h.cod_empresa and h.cod_empresa = :p61_cod_emp_paciente',
'and i.cod_filial = NVL(:p61_filial_aux,I.COD_FILIAL) and :p61_tipo_paciente = 2 and :p61_rowid is null',
'union',
'select p.cod_candidato||'' - ''||upper(p.nome) d, p.cod_candidato from inf_pessoais_candidato p, inf_func_candidato i, parametros_recursos_humanos h',
'where p.cod_candidato = i.cod_candidato and p.status_candidato = ''P'' and p.nome is not null and (:p61_cod_emp_paciente is null or p.empresa = h.cod_empresa)',
'and ((h.verif_id_risco = ''S'' and ((exists (select 1 from risco_funcao f where trunc(sysdate) between nvl(f.dt_inicio, trunc(sysdate)) and nvl(f.dt_termino,to_date(''31/12/2099'',''dd/mm/rrrr''))',
'and f.cod_cargo = i.cargo_pretendido and f.cod_local_trab = i.local_pretendido and f.cod_filial = i.cod_filial and f.cod_empresa = i.cod_empresa)) or (exists (select 1',
'from risco_local_trab l where trunc(sysdate) between l.dt_ini_validade and l.dt_fim_validade and l.cod_local_trab = i.local_pretendido and l.cod_filial = i.cod_filial and l.cod_empresa = i.cod_empresa))))',
'or (nvl(h.verif_id_risco,''N'') = ''N'')) and h.cod_empresa = :p61_cod_emp_paciente and i.cod_filial = NVL(:p61_filial_aux,I.COD_FILIAL) and :p61_tipo_paciente = 2 and :p61_rowid is not null order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_ROWID,P61_COD_EMP_PACIENTE,P61_TIPO_PACIENTE'
,p_ajax_items_to_submit=>'P61_FILIAL_AUX'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292545761063316066)
,p_name=>'P61_COD_TIPO_CONSULTA'
,p_is_required=>true
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Exame'
,p_source=>'COD_TIPO_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select upper(descricao) d, cod_tipo_consulta c',
' from tipo_consulta',
' where   ((classificacao_aso = ''A'' and :p61_tipo_paciente = 2) or',
'         (classificacao_aso <> ''A'' and :p61_tipo_paciente = 1))',
' and     classificacao_aso is not null',
' order by descricao'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_grid_label_column_span=>4
,p_read_only_when=>'P61_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(176378092544610704481)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292546158446316067)
,p_name=>'P61_COD_EXAME'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_item_default=>'ASO'
,p_prompt=>'Exame'
,p_source=>'COD_EXAME'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292546582688316067)
,p_name=>'P61_TIPO_PREST_SERV'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(165291956042330679725)
,p_use_cache_before_default=>'NO'
,p_item_default=>'1'
,p_source=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292546915741316069)
,p_name=>'P61_DATA_AGENDA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_use_cache_before_default=>'NO'
,p_item_default=>'P61_DATA_AGENDA_DSP'
,p_item_default_type=>'ITEM'
,p_source=>'DATA_AGENDA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292547359950316070)
,p_name=>'P61_HORA_INIC_PREVISTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'HORA_INIC_PREVISTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292547793045316070)
,p_name=>'P61_HORA_FIM_PREVISTO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'HORA_FIM_PREVISTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292548151183316071)
,p_name=>'P61_OBSERVACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>500
,p_cHeight=>4
,p_grid_label_column_span=>4
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :p61_rowid is null then',
'    return false;',
'  else',
'',
'--    if :p61_cod_sit_req in (2,3,4,5) then --voltar',
'    if :p61_cod_sit_req in (2,3,4) then',
'        return true;',
'    else',
'      if :p61_observacao is null then',
'        return false;',
'      else',
'        return true;',
'      end if;',
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292548590844316071)
,p_name=>'P61_DT_ATUALIZACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165292548985743316071)
,p_name=>'P61_USUARIO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(165291955954767679724)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165293376829723848199)
,p_name=>'P61_FLAG'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165293376982994848200)
,p_name=>'P61_MENSAGEM'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(165291955554491679720)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165293377081280848201)
,p_name=>'P61_HORA_INIC_PREVISTO_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_prompt=>unistr('Previs\00E3o de In\00EDcio (Hora)')
,p_format_mask=>'HH24:MI'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165293377179031848202)
,p_name=>'P61_HORA_FIM_PREVISTO_DSP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(165291956171129679726)
,p_prompt=>unistr('Previs\00E3o de T\00E9rmino (Hora)')
,p_format_mask=>'HH24:MI'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(176378092362345704480)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165291957354425679738)
,p_computation_sequence=>10
,p_computation_item=>'P61_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_USUARIO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165291957434842679739)
,p_computation_sequence=>10
,p_computation_item=>'P61_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'SYSDATE'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165291957540543679740)
,p_computation_sequence=>10
,p_computation_item=>'P61_COD_SIT_REQ'
,p_computation_type=>'STATIC_ASSIGNMENT'
,p_computation=>'1'
,p_compute_when=>'P61_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165293376010071848191)
,p_computation_sequence=>10
,p_computation_item=>'P61_DT_SIT_REQ'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT COD_SIT_REQ, DT_SIT_REQ',
'  FROM SOLICITACAO_EXAMES',
' WHERE COD_REQ = :P61_COD_REQ;',
' ',
'V_C1 C1%ROWTYPE;',
'',
'V_DATA DATE;',
'',
'BEGIN',
'',
'    IF :P61_ROWID IS NULL THEN',
'    ',
'      RETURN to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'    ',
'    ELSE',
'    ',
'      OPEN C1;',
'      FETCH C1 INTO V_C1;',
'      CLOSE C1;',
'      ',
'      if v_c1.cod_sit_req <> :p61_cod_sit_req then',
'        RETURN to_char(sysdate,''dd/mm/rrrr hh24:mi'');',
'      elsif v_c1.cod_sit_req = :p61_cod_sit_req then',
'        RETURN V_C1.DT_SIT_REQ;',
'      else',
'        return v_c1.dt_sit_req;',
'      end if;',
'      ',
'    END IF;',
'',
'END;'))
);
end;
/
begin
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165293376183084848192)
,p_computation_sequence=>10
,p_computation_item=>'P61_COD_EMP_SOLICITANTE'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':p_empresa_user'
,p_compute_when=>'P61_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165293376253246848193)
,p_computation_sequence=>10
,p_computation_item=>'P61_MAT_SOLICITANTE'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':p_matricula_user'
,p_compute_when=>'P61_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165293376308233848194)
,p_computation_sequence=>10
,p_computation_item=>'P61_DT_REQ'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'to_char(sysdate,''dd/mm/rrrr hh24:mi'')'
,p_compute_when=>'P61_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(165293376474493848195)
,p_computation_sequence=>10
,p_computation_item=>'P61_COD_REQ'
,p_computation_type=>'QUERY'
,p_computation=>'SELECT seq_requisicao.NEXTVAL FROM DUAL'
,p_compute_when=>'P61_ROWID'
,p_compute_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165293744888584817700)
,p_validation_name=>unistr('Valida\00E7\00E3o Geral')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => null,',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_cod_exame_cargo => :P61_GRUPO_EXAME_CARGO, ',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if :P61_COD_TIPO_CONSULTA = ''DEM'' and :P61_DT_DESLIGAMENTO is null then',
'   return(''Para Exames demissionais e necessario informar a data de desligamento.'');',
'   :P61_FLAG := ''N'';',
'end if;',
'',
'if v_flag = ''N'' and trim(v_mensagem) is not null then',
'  return v_mensagem;',
'end if;',
'',
'if nvl(:p61_class_aso,''X'') in (''A'',''M'') then',
'  if :p61_cargo_proposto is null then',
'    return(''O cargo proposto deve ser informado!'');',
'  elsif :p61_funcao_proposta is null then',
unistr('    return(''A fun\00E7\00E3o proposta deve ser informada!'');  '),
'  elsif :p61_local_pretendido is null then',
'    return(''O local pretendido deve ser informado!'');',
'  end if;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(165293746398170817716)
,p_validation_name=>unistr('Valida\00E7\00E3o COD_SIT_REQ')
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_SIT_REQ'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if v_flag = ''N'' and trim(v_mensagem) is not null then',
'  return v_mensagem;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'SAVE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(163820955777566873288)
,p_validation_name=>'Valida Exame'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flag varchar2(1);',
'v_mensagem varchar2(4000);',
'',
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_EXAME'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => v_flag, ',
'p_msg_retorno => v_mensagem',
');',
'',
'if v_flag = ''N'' and v_mensagem is not null then',
'return v_mensagem;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(165292539475213316036)
,p_associated_item=>wwv_flow_api.id(165292546158446316067)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(163820956189410873292)
,p_validation_name=>unistr('Valida Trabalho Compat\00EDvel')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vmsg_erro varchar2(4000);',
'begin',
unistr('  select distinct ''Funcion\00E1rio possui atestado v\00E1lido, n\00E3o \00E9 necess\00E1rio solicitar o exame.'' erro'),
'  into vmsg_erro',
'  from exame_func ex',
' where ((sysdate - dt_exame) < 90)',
'   and cod_exame = ''ASO''',
'   and tipo_exame = ''D''',
'   and cod_resultado  = 1  ',
'   and matricula = :P61_COD_PACIENTE',
'   and cod_empresa = :P61_COD_EMP_PACIENTE;',
'   ',
'   if vmsg_erro is not null then',
'     return(vmsg_erro);',
'   end if;',
'exception',
'  when no_data_found then',
'    null;',
'  when others then',
'    return(sqlerrm);',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(165292545346494316066)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(109815464108546846761)
,p_validation_name=>'Valida Tipo Consulta'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vflg_retorno varchar2(3) := ''S'';',
'  vmsg_retorno varchar2(4000);',
'begin',
'  if :p61_cod_tipo_consulta is not null then',
'    pkg_solicitacao_exames.validacao (p_campo => ''COD_TIPO_CONSULTA'',',
'                                      p_cod_req  =>  :p61_cod_req,',
'                                      p_sit_req  =>  :p61_cod_sit_req,',
'                                      p_tipo_paciente  =>  :p61_tipo_paciente,',
'                                      p_cod_emp  =>  :p61_cod_emp_paciente,',
'                                      p_paciente  =>  :p61_cod_paciente,',
'                                      p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'                                      p_cod_exame  =>  :p61_cod_exame,',
'                                      p_data_agenda  =>  :p61_data_agenda, ',
'                                      p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'                                      p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'                                      p_usuario  =>  :P_USUARIO,',
'                                      p_emp_user => :p_empresa_user,',
'                                      p_mat_user => :p_matricula_user,',
'                                      p_cod_exame_cargo => :P61_GRUPO_EXAME_CARGO,',
'                                      p_operacao => :P61_OPERACAO,    ',
'                                      p_flg_retorno => vflg_retorno, -- :p61_flag, ',
'                                      p_msg_retorno => vmsg_retorno); --:p61_mensagem',
'',
'/*  pkg_solicitacao_exames.valida_tipo_consulta (p_tipo_consulta => :p61_tipo_consulta,',
'                          p_tipo_paciente => :p61_tipo_paciente,',
'                          p_cod_emp => :p61_cod_emp_paciente,',
'                          p_paciente => :p61_cod_paciente,',
'                          p_flg_retorno => vflg_retorno,',
'                          p_msg_retorno => vmsg_retorno);*/',
'    if nvl(vflg_retorno,''S'') = ''N'' then',
'      return (vmsg_retorno);',
'    end if;',
'  end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(165292539475213316036)
,p_associated_item=>wwv_flow_api.id(165292545761063316066)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165291955603930679721)
,p_name=>unistr('(Show/Hide) Nova Requisi\00E7\00E3o')
,p_event_sequence=>10
,p_condition_element=>'P61_ROWID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P61_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165291955742313679722)
,p_event_id=>wwv_flow_api.id(165291955603930679721)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165291955554491679720)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165291955851172679723)
,p_event_id=>wwv_flow_api.id(165291955603930679721)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(165291955554491679720)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293377648352848207)
,p_name=>'valida_sit_req'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293377729568848208)
,p_event_id=>wwv_flow_api.id(165293377648352848207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_SIT_REQ'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293378095440848211)
,p_name=>'valida_paciente (1)'
,p_event_sequence=>25
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_TIPO_PACIENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293378150524848212)
,p_event_id=>wwv_flow_api.id(165293378095440848211)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''TIPO_PACIENTE'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293380105240848232)
,p_name=>'valida_paciente (2)'
,p_event_sequence=>35
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_PACIENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>'Never'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293380335416848234)
,p_event_id=>wwv_flow_api.id(165293380105240848232)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_PACIENTE'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401915814797795)
,p_event_id=>wwv_flow_api.id(165293380105240848232)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293377844492848209)
,p_name=>'valida_empresa'
,p_event_sequence=>45
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_EMP_PACIENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293377983684848210)
,p_event_id=>wwv_flow_api.id(165293377844492848209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'begin',
'  select nvl(verif_id_risco,''N'')',
'  into   :p61_verif_id_risco',
'  from   parametros_recursos_humanos',
'  where  cod_empresa = :p61_cod_emp_paciente;',
'exception',
'  when others then',
'    :p61_verif_id_risco := ''N'';',
'end;',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_EMP_PACIENTE'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM,P61_VERIF_ID_RISCO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143723382514798324668)
,p_name=>'Exibe, oculta cargo e local pret'
,p_event_sequence=>53
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CLASS_ASO'
,p_condition_element=>'P61_CLASS_ASO'
,p_triggering_condition_type=>'NOT_IN_LIST'
,p_triggering_expression=>'A,M'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143723382665045324669)
,p_event_id=>wwv_flow_api.id(143723382514798324668)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_LOCAL_PRETENDIDO,P61_CARGO_PROPOSTO,P61_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143723382801756324670)
,p_event_id=>wwv_flow_api.id(143723382514798324668)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_LOCAL_PRETENDIDO,P61_CARGO_PROPOSTO,P61_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163820955413774873285)
,p_name=>'Popula Cod_Exame_Aux'
,p_event_sequence=>54
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_TIPO_CONSULTA'
,p_condition_element=>'P61_COD_TIPO_CONSULTA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163820955579029873286)
,p_event_id=>wwv_flow_api.id(163820955413774873285)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME_AUX'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163820956560645873296)
,p_event_id=>wwv_flow_api.id(163820955413774873285)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163820956694748873297)
,p_event_id=>wwv_flow_api.id(163820955413774873285)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(158975401413002797789)
,p_name=>'Popula Cod_Exame_Aux_2'
,p_event_sequence=>64
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_LOCAL_PRETENDIDO'
,p_condition_element=>'P61_LOCAL_PRETENDIDO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401488995797790)
,p_event_id=>wwv_flow_api.id(158975401413002797789)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME_AUX'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401627867797792)
,p_event_id=>wwv_flow_api.id(158975401413002797789)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401580607797791)
,p_event_id=>wwv_flow_api.id(158975401413002797789)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(158975401000593797785)
,p_name=>'Popula Cod_Exame_Aux_1'
,p_event_sequence=>74
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CARGO_PROPOSTO'
,p_condition_element=>'P61_CARGO_PROPOSTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401109745797786)
,p_event_id=>wwv_flow_api.id(158975401000593797785)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME_AUX'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401234953797788)
,p_event_id=>wwv_flow_api.id(158975401000593797785)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975401209727797787)
,p_event_id=>wwv_flow_api.id(158975401000593797785)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_COD_EXAME'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'ASO'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293379323770848224)
,p_name=>'valida_tipo_consulta'
,p_event_sequence=>84
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_TIPO_CONSULTA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293379442170848225)
,p_event_id=>wwv_flow_api.id(165293379323770848224)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_TIPO_CONSULTA'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_cod_exame_cargo => :P61_GRUPO_EXAME_CARGO,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293379512089848226)
,p_name=>'valida_exame'
,p_event_sequence=>94
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_EXAME'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P61_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293379608513848227)
,p_event_id=>wwv_flow_api.id(165293379512089848226)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''COD_EXAME'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293379775260848228)
,p_name=>'valida_agenda (1)'
,p_event_sequence=>104
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_DATA_AGENDA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293379804804848229)
,p_event_id=>wwv_flow_api.id(165293379775260848228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''DATA_AGENDA'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293380446545848235)
,p_name=>'valida_agenda (2)'
,p_event_sequence=>114
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_HORA_INIC_PREVISTO_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293746914691817721)
,p_event_id=>wwv_flow_api.id(165293380446545848235)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_hora varchar2(5) := lpad(replace(:p61_hora_inic_previsto_dsp,'':''),4,''0'');',
'',
'begin',
'',
'  if :p61_hora_inic_previsto_dsp is not null then',
'',
'    :p61_hora_inic_previsto_dsp := substr(v_hora,1,2)||'':''||substr(v_hora,3,2);',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P61_HORA_INIC_PREVISTO_DSP'
,p_attribute_03=>'P61_HORA_INIC_PREVISTO_DSP'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293380536829848236)
,p_event_id=>wwv_flow_api.id(165293380446545848235)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''HORA_INIC_PREVISTO'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149284606799188831303)
,p_event_id=>wwv_flow_api.id(165293380446545848235)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_APAGAR'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'RETURN(REPLACE(TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')||:P61_HORA_INIC_PREVISTO_DSP,'' '',''''));',
'',
'-- RETURN(:P61_HORA_INIC_PREVISTO_DSP);',
'-- RETURN(REPLACE(TO_CHAR(:P61_DATA_AGENDA_DSP,''DD/MM/RRRR'')||:P61_HORA_INIC_PREVISTO_DSP,'' '',''''));',
'',
'-- TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')'))
,p_attribute_07=>'P61_HORA_INIC_PREVISTO_DSP,P61_DATA_AGENDA_DSP'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293380613219848237)
,p_name=>'valida_agenda (3)'
,p_event_sequence=>124
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_HORA_FIM_PREVISTO_DSP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293747016407817722)
,p_event_id=>wwv_flow_api.id(165293380613219848237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'',
'v_hora varchar2(5) := lpad(replace(:p61_hora_fim_previsto_dsp,'':''),4,''0'');',
'',
'begin',
'',
'  if :p61_hora_fim_previsto_dsp is not null then',
'',
'    :p61_hora_fim_previsto_dsp := substr(v_hora,1,2)||'':''||substr(v_hora,3,2);',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P61_HORA_FIM_PREVISTO_DSP'
,p_attribute_03=>'P61_HORA_FIM_PREVISTO_DSP'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293380792818848238)
,p_event_id=>wwv_flow_api.id(165293380613219848237)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin ',
'',
'pkg_solicitacao_exames.validacao(',
'p_campo => ''HORA_FIM_PREVISTO'',',
'p_cod_req  =>  :p61_cod_req,',
'p_sit_req  =>  :p61_cod_sit_req,',
'p_tipo_paciente  =>  :p61_tipo_paciente,',
'p_cod_emp  =>  :p61_cod_emp_paciente,',
'p_paciente  =>  :p61_cod_paciente,',
'p_tipo_consulta  =>  :p61_cod_tipo_consulta,',
'p_cod_exame  =>  :p61_cod_exame,',
'p_data_agenda  =>  :p61_data_agenda, ',
'p_hora_ini =>  :p61_hora_inic_previsto_dsp,',
'p_hora_fim  => :p61_hora_fim_previsto_dsp,',
'p_usuario  =>  :P_USUARIO,',
'p_emp_user => :p_empresa_user,',
'p_mat_user => :p_matricula_user,',
'p_operacao => :P61_OPERACAO,    ',
'p_flg_retorno => :p61_flag, ',
'p_msg_retorno => :p61_mensagem',
');',
'',
'end;'))
,p_attribute_02=>'P61_COD_REQ,P61_COD_SIT_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_COD_EXAME,P61_DATA_AGENDA,P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P61_FLAG,P61_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293744690005817698)
,p_name=>'Popula Campos'
,p_event_sequence=>134
,p_condition_element=>'P61_HORA_INIC_PREVISTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P61_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293744710001817699)
,p_event_id=>wwv_flow_api.id(165293744690005817698)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  --V_HORA_INI VARCHAR2(100) := :P61_HORA_INIC_PREVISTO; ',
'  --V_HORA_FIM VARCHAR2(100) := :P61_HORA_FIM_PREVISTO; ',
'',
'  V_HORA_INI DATE := TO_DATE(:P61_HORA_INIC_PREVISTO,''DD/MM/RRRR HH24:MI''); ',
'  V_HORA_FIM DATE := TO_DATE(:P61_HORA_FIM_PREVISTO,''DD/MM/RRRR HH24:MI''); ',
'',
'BEGIN',
'',
'  :p61_hora_inic_previsto_dsp := TO_CHAR(V_HORA_INI,''HH24:MI''); ',
'  :p61_hora_fim_previsto_dsp  := TO_CHAR(V_HORA_FIM,''HH24:MI''); ',
'',
'END;'))
,p_attribute_02=>'P61_HORA_INIC_PREVISTO,P61_HORA_FIM_PREVISTO'
,p_attribute_03=>'P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293746296299817715)
,p_event_id=>wwv_flow_api.id(165293744690005817698)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_HORA_INIC_PREVISTO_DSP,P61_HORA_FIM_PREVISTO_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293744924999817701)
,p_name=>'Dispara Alerta'
,p_event_sequence=>144
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293745039780817702)
,p_event_id=>wwv_flow_api.id(165293744924999817701)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P61_FLAG" ).getValue() == "Q") {',
'',
unistr('	alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
'	alertify.confirm(apex.item( "P61_MENSAGEM" ).getValue(), function (e) {',
'	    if (e) {',
'	        apex.item( "P61_FLAG" ).setValue("S");',
'	        apex.item( "P61_MENSAGEM" ).setValue("");',
'	    }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
'',
'} else {',
'',
'    if (apex.item( "P61_MENSAGEM" ).getValue().length  > 0 ) {',
'        alertify.alert(apex.item( "P61_MENSAGEM" ).getValue());',
'    }',
'',
'                 ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293745192433817703)
,p_name=>'Inicia Alertify'
,p_event_sequence=>154
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_FLAG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293745255499817704)
,p_event_id=>wwv_flow_api.id(165293745192433817703)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Inicia'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293746125173817713)
,p_name=>unistr('Cancela Requisi\00E7\00E3o')
,p_event_sequence=>164
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165293745700287817709)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293746274884817714)
,p_event_id=>wwv_flow_api.id(165293746125173817713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('	alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja realmente Cancelar esta requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'	        apex.item( "P61_FLAG" ).setValue("S");',
'	        apex.item( "P61_MENSAGEM" ).setValue("");',
'        //  apex.item( "P61_COD_SIT_REQ" ).setValue(3);',
'        ',
'        //apex.submit({  request:"SAVE",  showWait:true});',
'        apex.submit({  request:"SAVE",  set:{"P61_COD_SIT_REQ":3},  showWait:true});',
'        ',
'	    }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293748693851817738)
,p_name=>unistr('Suspender Requisi\00E7\00E3o')
,p_event_sequence=>174
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165293745954949817711)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165293748723440817739)
,p_event_id=>wwv_flow_api.id(165293748693851817738)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('	alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja realmente Suspender esta requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'	        apex.item( "P61_FLAG" ).setValue("S");',
'	        apex.item( "P61_MENSAGEM" ).setValue("");',
'        ',
'        //apex.submit({  request:"SAVE",  showWait:true});',
'        apex.submit({  request:"SAVE",  set:{"P61_COD_SIT_REQ":6},  showWait:true});',
'        ',
'	    }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(165293748891747817740)
,p_name=>unistr('Em Andamento Requisi\00E7\00E3o')
,p_event_sequence=>184
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165293746047116817712)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(165294904266721361091)
,p_event_id=>wwv_flow_api.id(165293748891747817740)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('	alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja realmente deixar Em Andamento esta requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'	        apex.item( "P61_FLAG" ).setValue("S");',
'	        apex.item( "P61_MENSAGEM" ).setValue("");',
'         // apex.item( "P61_COD_SIT_REQ" ).setValue(6);',
'        ',
'        //apex.submit({  request:"SAVE",  showWait:true});',
'        apex.submit({  request:"SAVE",  set:{"P61_COD_SIT_REQ":1},  showWait:true});',
'        ',
'	    }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163773339658911664121)
,p_name=>'carr_class_aso'
,p_event_sequence=>194
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_TIPO_CONSULTA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163773339744529664122)
,p_event_id=>wwv_flow_api.id(163773339658911664121)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_CLASS_ASO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select classificacao_aso from tipo_consulta where cod_tipo_consulta = :p61_cod_tipo_consulta'
,p_attribute_07=>'P61_COD_TIPO_CONSULTA'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163773339834058664123)
,p_name=>'show_dt_deslig'
,p_event_sequence=>204
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CLASS_ASO'
,p_condition_element=>'P61_CLASS_ASO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163773339940041664124)
,p_event_id=>wwv_flow_api.id(163773339834058664123)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_DT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163776785749821514177)
,p_event_id=>wwv_flow_api.id(163773339834058664123)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_DT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(159994009479780048057)
,p_name=>'show cargo e local'
,p_event_sequence=>214
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CLASS_ASO'
,p_condition_element=>'P61_CLASS_ASO'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'M,A'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>'Never'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(159994009553412048058)
,p_event_id=>wwv_flow_api.id(159994009479780048057)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(159994010007302048062)
,p_event_id=>wwv_flow_api.id(159994009479780048057)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_FUNCAO_PROPOSTA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975400741775797783)
,p_event_id=>wwv_flow_api.id(159994009479780048057)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975400898822797784)
,p_event_id=>wwv_flow_api.id(159994009479780048057)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163773340032180664125)
,p_name=>'hide_class_aso'
,p_event_sequence=>224
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163773340143538664126)
,p_event_id=>wwv_flow_api.id(163773340032180664125)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_DT_DESLIGAMENTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(158975400489178797780)
,p_name=>'Popula P61_GRUPO_EXAME_CARGO_CLASS'
,p_event_sequence=>234
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CLASS_ASO'
,p_condition_element=>'P61_CLASS_ASO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
,p_da_event_comment=>'Never'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975400583824797781)
,p_event_id=>wwv_flow_api.id(158975400489178797780)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VCODIGO VARCHAR2(500);',
'BEGIN',
'FOR C1 IN (SELECT DISTINCT G.COD',
'FROM(select b.cod COD_GRUPO_RISCO from GRUPO_EXAME_CARGO b where rownum <= 1 and b.cod = ''SRO'' AND NOT EXISTS (select distinct a.cod_exame from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA    = C.COD_EMPRESA  AND c.cod_empresa = :P61_COD_EMP_PACIENTE  and c.cod_local_trab = :P61_LOCAL_PRETENDIDO)',
'      UNION',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA AND c.cod_empresa = :P61_COD_EMP_PACIENTE and c.cod_local_trab = :P61_LOCAL_PRETENDIDO) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE X.COD_GRUPO_RISCO = G.COD',
'AND ((:P61_ROWID IS NOT NULL) OR (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   and (:P61_CARGO_PROPOSTO is not null or :P61_LOCAL_PRETENDIDO is not null)  AND :P61_COD_TIPO_CONSULTA IS NOT NULL AND :P61_TIPO_PACIENTE IN (1,2)',
'UNION',
'SELECT DISTINCT G.COD',
'FROM   (SELECT DISTINCT S.GRUPO_RISCO COD_GRUPO_RISCO',
'        FROM   VW_RISCO_ELEG_COLABORADOR V ,ST_RISCO_EXAME S, MATRIZ_RESULTADO MR',
'        WHERE  RISCO IS NOT NULL AND S.COD_RISCO = V.RISCO AND S.COD_EMPRESA = V.COD_EMPRESA AND V.MATRICULA = :P61_COD_PACIENTE AND V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'        AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1)',
'        UNION',
'        SELECT ''SRO'' COD_GRUPO_RISCO FROM   DUAL',
'        WHERE  NOT EXISTS (SELECT *',
'                           FROM   VW_RISCO_ELEG_COLABORADOR V, MATRIZ_RESULTADO MR WHERE  RISCO IS NOT NULL AND V.MATRICULA = :P61_COD_PACIENTE AND V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'                           AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1))) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE  G.COD = X.COD_GRUPO_RISCO',
'AND    ((:P61_ROWID IS NOT NULL) OR',
'       (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND',
'       NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   AND :P61_TIPO_PACIENTE = 1',
'   and (:P61_CARGO_PROPOSTO is null and :P61_LOCAL_PRETENDIDO is null)',
'   AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'ORDER BY 1) LOOP',
'IF VCODIGO IS NULL THEN',
'VCODIGO := C1.COD;',
'ELSE',
'VCODIGO := VCODIGO || '','' || C1.COD;',
'END IF;',
'END LOOP;',
':P61_GRUPO_EXAME_CARGO := VCODIGO;',
'END;'))
,p_attribute_02=>'P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_CLASS_ASO,P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_ROWID,P61_FILIAL_AUX'
,p_attribute_03=>'P61_GRUPO_EXAME_CARGO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975400647234797782)
,p_event_id=>wwv_flow_api.id(158975400489178797780)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(158975402191032797797)
,p_name=>'Popula P61_GRUPO_EXAME_CARGO_CARGO'
,p_event_sequence=>244
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_CARGO_PROPOSTO'
,p_condition_element=>'P61_CARGO_PROPOSTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
,p_da_event_comment=>'Never'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975402253650797798)
,p_event_id=>wwv_flow_api.id(158975402191032797797)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975402329354797799)
,p_event_id=>wwv_flow_api.id(158975402191032797797)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VCODIGO VARCHAR2(500);',
'BEGIN',
'FOR C1 IN (SELECT DISTINCT G.COD FROM(select b.cod COD_GRUPO_RISCO',
'       from GRUPO_EXAME_CARGO b where rownum <= 1 and   b.cod = ''SRO''  AND NOT EXISTS (select distinct a.cod_exame from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO   = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA  and C.COD_CARGO   = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL) AND A.COD_EMPRESA    = C.COD_EMPRESA',
'         AND c.cod_empresa    = :P61_COD_EMP_PACIENTE and c.cod_local_trab = :P61_LOCAL_PRETENDIDO)',
'      UNION',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO  from risco_funcao C, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)  AND A.COD_EMPRESA = C.COD_EMPRESA',
'         and C.COD_CARGO = :P61_CARGO_PROPOSTO  AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'      union',
'      select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'       where TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'         AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'         AND A.COD_EMPRESA = C.COD_EMPRESA AND c.cod_empresa = :P61_COD_EMP_PACIENTE and c.cod_local_trab = :P61_LOCAL_PRETENDIDO) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE X.COD_GRUPO_RISCO = G.COD',
'AND ((:P61_ROWID IS NOT NULL) OR (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   and (:P61_CARGO_PROPOSTO is not null or :P61_LOCAL_PRETENDIDO is not null)  AND :P61_COD_TIPO_CONSULTA IS NOT NULL AND :P61_TIPO_PACIENTE IN (1,2)',
'UNION',
'SELECT DISTINCT G.COD',
'FROM   (SELECT DISTINCT S.GRUPO_RISCO COD_GRUPO_RISCO FROM   VW_RISCO_ELEG_COLABORADOR V ,ST_RISCO_EXAME S, MATRIZ_RESULTADO MR',
'        WHERE  RISCO IS NOT NULL AND    S.COD_RISCO = V.RISCO AND S.COD_EMPRESA = V.COD_EMPRESA  AND    V.MATRICULA   = :P61_COD_PACIENTE',
'        AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1)',
'        UNION',
'        SELECT ''SRO'' COD_GRUPO_RISCO FROM   DUAL',
'        WHERE  NOT EXISTS (SELECT * FROM   VW_RISCO_ELEG_COLABORADOR V, MATRIZ_RESULTADO MR  WHERE  RISCO IS NOT NULL',
'                           AND    V.MATRICULA   = :P61_COD_PACIENTE  AND    V.COD_EMPRESA = :P61_COD_EMP_PACIENTE AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1))) X',
'      ,GRUPO_EXAME_CARGO G',
'WHERE  G.COD = X.COD_GRUPO_RISCO',
'AND    ((:P61_ROWID IS NOT NULL) OR (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'   AND :P61_TIPO_PACIENTE = 1 and (:P61_CARGO_PROPOSTO is null and :P61_LOCAL_PRETENDIDO is null) AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'ORDER BY 1) LOOP',
'IF VCODIGO IS NULL THEN',
'VCODIGO := C1.COD;',
'ELSE',
'VCODIGO := VCODIGO || '','' || C1.COD;',
'END IF;',
'END LOOP;',
':P61_GRUPO_EXAME_CARGO := VCODIGO;',
'END;'))
,p_attribute_02=>'P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_CLASS_ASO,P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_ROWID,P61_FILIAL_AUX'
,p_attribute_03=>'P61_GRUPO_EXAME_CARGO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(158975402486305797800)
,p_name=>'Popula P61_GRUPO_EXAME_CARGO_LOCAL'
,p_event_sequence=>254
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_LOCAL_PRETENDIDO'
,p_condition_element=>'P61_LOCAL_PRETENDIDO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
,p_da_event_comment=>'Never'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975402573910797801)
,p_event_id=>wwv_flow_api.id(158975402486305797800)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158975402620589797802)
,p_event_id=>wwv_flow_api.id(158975402486305797800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VCODIGO VARCHAR2(500);',
'BEGIN',
'FOR C1 IN (SELECT DISTINCT G.COD',
'FROM(select b.cod COD_GRUPO_RISCO from GRUPO_EXAME_CARGO b where rownum <= 1 and   b.cod = ''SRO''',
'AND NOT EXISTS (select distinct a.cod_exame from risco_funcao C, st_risco_exame A',
'where C.Cod_Result_Matriz > 6 AND TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO   = C.COD_RISCO',
'AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO   = :P61_CARGO_PROPOSTO  AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'union',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'where C.Cod_Result_Matriz > 6 AND TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO      = C.COD_RISCO',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA    = C.COD_EMPRESA AND c.cod_empresa    = :P61_COD_EMP_PACIENTE  and c.cod_local_trab = :P61_LOCAL_PRETENDIDO)',
'UNION',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_funcao C, st_risco_exame A',
'where C.Cod_Result_Matriz > 6 AND TRUNC(SYSDATE) BETWEEN NVL(C.DT_INICIO,TO_DATE(''01/01/1900'',''DD/MM/RRRR'')) AND NVL(C.DT_TERMINO,TO_DATE(''31/12/2099'',''DD/MM/RRRR'')) AND A.COD_RISCO = C.COD_RISCO',
'AND ((C.COD_LOCAL_TRAB IS NOT NULL AND C.COD_LOCAL_TRAB = :P61_LOCAL_PRETENDIDO) OR C.COD_LOCAL_TRAB IS NULL)',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA and C.COD_CARGO = :P61_CARGO_PROPOSTO AND C.cod_empresa = :P61_COD_EMP_PACIENTE',
'union',
'select distinct a.Grupo_Risco COD_GRUPO_RISCO from risco_local_trab c, st_risco_exame A',
'where C.Cod_Result_Matriz > 6 AND TRUNC(SYSDATE) BETWEEN C.DT_INI_VALIDADE AND C.DT_FIM_VALIDADE AND A.COD_RISCO = C.COD_RISCO AND A.COD_RISCO = C.COD_RISCO',
'AND ((C.COD_FILIAL IS NOT NULL AND C.COD_FILIAL = :P61_FILIAL_AUX) OR C.COD_FILIAL IS NULL)',
'AND A.COD_EMPRESA = C.COD_EMPRESA AND c.cod_empresa = :P61_COD_EMP_PACIENTE',
'and c.cod_local_trab = :P61_LOCAL_PRETENDIDO) X, GRUPO_EXAME_CARGO G WHERE X.COD_GRUPO_RISCO = G.COD',
'AND ((:P61_ROWID IS NOT NULL) OR (TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'and (:P61_CARGO_PROPOSTO is not null or :P61_LOCAL_PRETENDIDO is not null) AND :P61_COD_TIPO_CONSULTA IS NOT NULL AND :P61_TIPO_PACIENTE IN (1,2)',
'UNION',
'SELECT DISTINCT G.COD',
'FROM   (SELECT DISTINCT S.GRUPO_RISCO COD_GRUPO_RISCO FROM   VW_RISCO_ELEG_COLABORADOR V ,ST_RISCO_EXAME S, MATRIZ_RESULTADO MR',
'WHERE  V.COD_RESULT_MATRIZ > 6 AND RISCO IS NOT NULL AND S.COD_RISCO = V.RISCO AND    S.COD_EMPRESA = V.COD_EMPRESA AND V.MATRICULA = :P61_COD_PACIENTE AND V.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1)',
'UNION',
'SELECT ''SRO'' COD_GRUPO_RISCO FROM DUAL',
'WHERE  NOT EXISTS (SELECT * FROM VW_RISCO_ELEG_COLABORADOR V, MATRIZ_RESULTADO MR',
'WHERE V.COD_RESULT_MATRIZ > 6 AND RISCO IS NOT NULL AND V.MATRICULA = :P61_COD_PACIENTE',
'AND V.COD_EMPRESA = :P61_COD_EMP_PACIENTE AND MR.COD_RESULTADO = V.COD_RESULT_MATRIZ AND MR.PESO NOT IN (0,1))) X,GRUPO_EXAME_CARGO G',
'WHERE  G.COD = X.COD_GRUPO_RISCO AND ((:P61_ROWID IS NOT NULL) OR',
'(TRUNC(SYSDATE) BETWEEN NVL(DT_VALIDADE_INI, TRUNC(SYSDATE)) AND NVL(DT_VALIDADE_FIM, TRUNC(SYSDATE))))',
'AND :P61_TIPO_PACIENTE = 1 and (:P61_CARGO_PROPOSTO is null and :P61_LOCAL_PRETENDIDO is null) AND :P61_COD_TIPO_CONSULTA IS NOT NULL',
'ORDER BY 1) LOOP',
'IF VCODIGO IS NULL THEN',
'VCODIGO := C1.COD;',
'ELSE',
'VCODIGO := VCODIGO || '','' || C1.COD;',
'END IF;',
'END LOOP;',
':P61_GRUPO_EXAME_CARGO := VCODIGO;',
'END;'))
,p_attribute_02=>'P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE,P61_COD_TIPO_CONSULTA,P61_CLASS_ASO,P61_CARGO_PROPOSTO,P61_LOCAL_PRETENDIDO,P61_ROWID,P61_FILIAL_AUX'
,p_attribute_03=>'P61_GRUPO_EXAME_CARGO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149281259713876406705)
,p_name=>'Retorna filial do paciente'
,p_event_sequence=>264
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_REQ'
,p_condition_element=>'P61_COD_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149281259820230406706)
,p_event_id=>wwv_flow_api.id(149281259713876406705)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VFILIAL FILIAIS.COD_FILIAL%TYPE;',
'BEGIN',
'  IF :P61_TIPO_PACIENTE = 1 THEN',
'    BEGIN',
'      SELECT FILIAL',
'      INTO   VFILIAL',
'      FROM   INFORMACOES_FUNCIONAIS_CAD',
'      WHERE  MATRICULA = :P61_COD_PACIENTE',
'      AND    COD_EMPRESA = :P61_COD_EMP_PACIENTE;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VFILIAL := NULL;',
'    END;',
'  ELSIF :P61_TIPO_PACIENTE = 2 AND :P61_COD_EMP_PACIENTE IS NOT NULL AND :P61_COD_PACIENTE IS NOT NULL THEN',
'    BEGIN',
'      SELECT COD_FILIAL',
'      INTO   VFILIAL',
'      FROM   INF_FUNC_CANDIDATO',
'      WHERE  ROWNUM = 1',
'      AND    COD_CANDIDATO = :P61_COD_PACIENTE;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VFILIAL := NULL;',
'    END;',
'  ELSE',
'    VFILIAL := NULL;',
'  END IF;',
'  :P61_FILIAL_AUX := VFILIAL;',
'END;'))
,p_attribute_02=>'P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_COD_PACIENTE'
,p_attribute_03=>'P61_FILIAL_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149283109442536525886)
,p_name=>'Novo'
,p_event_sequence=>274
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(149281259269045406700)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149283109578961525887)
,p_event_id=>wwv_flow_api.id(149283109442536525886)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_AGENDA_ROWID'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P75_P_ROWID'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149283109635393525888)
,p_event_id=>wwv_flow_api.id(149283109442536525886)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_DATA_AGENDA_DSP'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P75_P_DATA_AGENDA_DSP'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149283109947147525891)
,p_event_id=>wwv_flow_api.id(149283109442536525886)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_HORA_INIC_PREVISTO_DSP'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P75_P_HORA_INI'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149283110099574525892)
,p_event_id=>wwv_flow_api.id(149283109442536525886)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_HORA_FIM_PREVISTO_DSP'
,p_attribute_01=>'DIALOG_RETURN_ITEM'
,p_attribute_09=>'N'
,p_attribute_10=>'P75_P_HORA_TER'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149284605401450831289)
,p_name=>'Exibe/Oculta P61_GRUPO_EXAME_CARGO'
,p_event_sequence=>284
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_ROWID'
,p_condition_element=>'P61_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149284605473167831290)
,p_event_id=>wwv_flow_api.id(149284605401450831289)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149284605524253831291)
,p_event_id=>wwv_flow_api.id(149284605401450831289)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149284605773872831293)
,p_name=>'Chama Report'
,p_event_sequence=>294
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(149284605672889831292)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149284605815991831294)
,p_event_id=>wwv_flow_api.id(149284605773872831293)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BR.COM.NATCORP.REPORTS'
,p_attribute_01=>'RP10302'
,p_attribute_02=>'RP10302.pdf'
,p_attribute_03=>'inline'
,p_attribute_05=>'P61_COD_REQ,P61_TIPO_PACIENTE,P61_COD_EMP_PACIENTE,P61_FILIAL_AUX,P61_COD_PACIENTE'
,p_attribute_06=>'Y'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return (''&PCOD_EMPRESA=''||:P61_COD_EMP_PACIENTE',
'||''&PMATRICULA_INI=''||:P61_COD_PACIENTE',
'||''&PMATRICULA_FIM=''||:P61_COD_PACIENTE',
'||''&PFILIAL_INI=''||:P61_FILIAL_AUX',
'||''&PFILIAL_FIM=''||:P61_FILIAL_AUX',
'||''&PCOD_REQ=''||:P61_COD_REQ',
'||''&PTIPO_PACIENTE=''||:P61_TIPO_PACIENTE',
'||''&P_USUARIO=''||:APP_USER); '))
,p_attribute_08=>'pdf'
,p_attribute_09=>'.rep'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(149284606245030831298)
,p_name=>'Popula_Agenda'
,p_event_sequence=>304
,p_condition_element=>'P61_DATA_AGENDA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P61_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(149284606311239831299)
,p_event_id=>wwv_flow_api.id(149284606245030831298)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_DATA_AGENDA_DSP'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P61_DATA_AGENDA); '
,p_attribute_07=>'P61_DATA_AGENDA'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147433871129789107588)
,p_name=>'Exibe/Oculta'
,p_event_sequence=>334
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_REQ'
,p_condition_element=>'P61_COD_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147433870819613107585)
,p_event_id=>wwv_flow_api.id(147433871129789107588)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO_DSP'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P61_GRUPO_EXAME_CARGO);'
,p_attribute_07=>'P61_GRUPO_EXAME_CARGO'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147439814272346769742)
,p_event_id=>wwv_flow_api.id(147433871129789107588)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147433871284423107590)
,p_event_id=>wwv_flow_api.id(147433871129789107588)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147439814150708769741)
,p_event_id=>wwv_flow_api.id(147433871129789107588)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147433871231035107589)
,p_event_id=>wwv_flow_api.id(147433871129789107588)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P61_GRUPO_EXAME_CARGO_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143736211256286765850)
,p_name=>'Painel do Colaborador'
,p_event_sequence=>344
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P_PAINEL'
,p_display_when_cond2=>'PC'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141879313950253798705)
,p_event_id=>wwv_flow_api.id(143736211256286765850)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P61_COD_REQ").getValue().length == 0){',
'apex.item("P61_TIPO_PACIENTE").disable();',
'apex.item("P61_COD_EMP_PACIENTE").disable();',
'apex.item("P61_COD_PACIENTE").disable();',
'apex.item("P61_FILIAL_AUX").disable();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(141879314030219798706)
,p_name=>'CREATE'
,p_event_sequence=>354
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(165292539475213316036)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141879314116294798707)
,p_event_id=>wwv_flow_api.id(141879314030219798706)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P61_TIPO_PACIENTE").enable();',
'apex.item("P61_COD_EMP_PACIENTE").enable();',
'apex.item("P61_COD_PACIENTE").enable();',
'apex.item("P61_FILIAL_AUX").enable();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141879314211296798708)
,p_event_id=>wwv_flow_api.id(141879314030219798706)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(129514911126555654460)
,p_name=>'Popula dados func atuais'
,p_event_sequence=>364
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_PACIENTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(129514911211132654461)
,p_event_id=>wwv_flow_api.id(129514911126555654460)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR C IS',
'    SELECT CARGO, FUNCAO, COD_LOCALIZACAO ',
'    FROM   INFORMACOES_FUNCIONAIS_CAD',
'    WHERE  MATRICULA = :P61_COD_PACIENTE AND COD_EMPRESA = :P61_COD_EMP_PACIENTE;',
'  V_C C%ROWTYPE;',
'BEGIN',
'  OPEN C;',
'  FETCH C INTO V_C;',
'  IF C%NOTFOUND THEN',
'    :P61_CARGO_ATUAL  := NULL;',
'    :P61_FUNCAO_ATUAL := NULL;',
'    :P61_LOCAL_TRAB_ATUAL := NULL;',
'  ELSE',
'    :P61_CARGO_ATUAL          := V_C.CARGO;',
'    :P61_FUNCAO_ATUAL         := V_C.FUNCAO;',
'    :P61_LOCAL_TRAB_ATUAL := V_C.COD_LOCALIZACAO;',
'  END IF;',
'  CLOSE C;',
'END;'))
,p_attribute_02=>'P61_COD_EMP_PACIENTE,P61_COD_PACIENTE'
,p_attribute_03=>'P61_CARGO_ATUAL,P61_FUNCAO_ATUAL,P61_LOCAL_TRAB_ATUAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(41234870701263249606)
,p_name=>'Alerta Lista de Valores Candidatos'
,p_event_sequence=>374
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P61_COD_EMP_PACIENTE,P61_VERIF_ID_RISCO'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v(''P61_VERIF_ID_RISCO'') === ''S'' && apex.item(''P61_ROWID'').isEmpty()'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P61_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(41234870774813249607)
,p_event_id=>wwv_flow_api.id(41234870701263249606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Somente ser\00E3o retornados colaboradores e candidatos com Aplica\00E7\00E3o de Risco.')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165292555150098316078)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from SOLICITACAO_EXAMES'
,p_attribute_02=>'SOLICITACAO_EXAMES'
,p_attribute_03=>'P61_COD_REQ'
,p_attribute_04=>'COD_REQ'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165293377511598848206)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Dados de Hor\00E1rios')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'  if :p61_Data_agenda is not null then',
'',
'    IF :P61_HORA_INIC_PREVISTO IS NULL AND :P61_HORA_INIC_PREVISTO_DSP IS NOT NULL THEN',
'       :P61_HORA_INIC_PREVISTO := :P61_DATA_AGENDA||'' ''||:P61_HORA_INIC_PREVISTO_DSP;',
'    END IF;',
'',
'    IF :P61_HORA_FIM_PREVISTO IS NULL AND :P61_HORA_FIM_PREVISTO_DSP IS NOT NULL THEN',
'       :P61_HORA_FIM_PREVISTO := :P61_DATA_AGENDA||'' ''||:P61_HORA_FIM_PREVISTO_DSP;',
'    END IF;',
'',
'  end if;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(143671566776077658952)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Limpa agenda'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  FOR X IN (SELECT * FROM SOLICITACAO_EXAMES WHERE COD_REQ = :P61_COD_REQ) LOOP',
'    UPDATE AGENDAS_MEDICOS_HORARIOS',
'    SET    COD_PACIENTE      = NULL',
'          ,TIPO_PACIENTE     = NULL',
'          ,COD_TIPO_CONSULTA = NULL',
'          ,USUARIO           = SUBSTR(:APP_USER||''ReqExame1'',1,30)',
'          ,DT_ATUALIZACAO = SYSDATE',
'          ,SENHA              = NULL -- alterado ch37215 Adriana',
'          ,COD_REQ            = NULL -- NVL(COD_REQ,:P61_COD_REQ) alterado ch37215 Adriana',
'    WHERE  COD_REQ            = NVL(COD_REQ,:P61_COD_REQ) -- incluso ch37215 Adriana',
'    AND    HORA_INIC_PREVISTO = X.HORA_INIC_PREVISTO',
'    AND    DATA_AGENDA        = X.DATA_AGENDA',
'    AND    COD_PACIENTE       = X.COD_PACIENTE',
'    AND    COD_EMPRESA        = X.COD_EMP_PACIENTE',
'    AND    TIPO_PACIENTE      in (1,2);',
'    --',
'    Update Agendas_Medicos_Horarios',
'    SET    BLOQUEADO = ''N''',
'          ,SENHA              = NULL -- alterado ch37215 Adriana',
'          ,COD_REQ            = NULL -- NVL(COD_REQ,:P61_COD_REQ) alterado ch37215 Adriana',
'          ,USUARIO            = SUBSTR(:APP_USER||''ReqExame2'',1,30)',
'          ,DT_ATUALIZACAO     = SYSDATE',
'          ,TIPO_PACIENTE      = NULL',
'          ,COD_PACIENTE       = NULL',
'    WHERE  HORA_INIC_PREVISTO = X.HORA_INIC_PREVISTO',
'    AND    DATA_AGENDA        = X.DATA_AGENDA',
'    AND    COD_EMPRESA        <> :P61_COD_EMP_PACIENTE',
'    AND    COD_PRESTR_SERV    = X.COD_PREST_SERV',
'    AND    TIPO_PREST_SERV    = X.TIPO_PREST_SERV;',
'  END LOOP;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165292555519398316079)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of SOLICITACAO_EXAMES'
,p_attribute_02=>'SOLICITACAO_EXAMES'
,p_attribute_03=>'P61_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Realizado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165293380960182848240)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST_INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  FOR X IN (select *',
'            from   agendas_medicos_horarios',
'            where  rowid = :P61_AGENDA_ROWID) LOOP',
'      ',
'',
'    UPDATE SOLICITACAO_EXAMES',
'    SET    DATA_AGENDA        = :P61_DATA_AGENDA_DSP',
'          ,HORA_INIC_PREVISTO = TO_DATE(REPLACE(TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')||:P61_HORA_INIC_PREVISTO_DSP,'' '',''''),''DD/MM/YYYYHH24:MI'')',
'          ,HORA_FIM_PREVISTO  = TO_DATE(REPLACE(TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')||:P61_HORA_FIM_PREVISTO_DSP,'' '',''''),''DD/MM/YYYYHH24:MI'')',
'          ,COD_PREST_SERV     = X.COD_PRESTR_SERV',
'    WHERE  COD_REQ            = :P61_COD_REQ;',
'    ',
'    Update Agendas_Medicos_Horarios',
'    SET    BLOQUEADO = ''S''',
'          ,COD_REQ            = NVL(COD_REQ,:P61_COD_REQ)',
'          ,USUARIO   = SUBSTR(:APP_USER||''ReqExame'',1,30)',
'          ,DT_ATUALIZACAO = SYSDATE',
'    WHERE  HORA_INIC_PREVISTO = X.HORA_INIC_PREVISTO',
'    AND    DATA_AGENDA        = X.DATA_AGENDA',
'    AND    COD_EMPRESA        <> :P61_COD_EMP_PACIENTE',
'    AND    COD_PRESTR_SERV    = X.COD_PRESTR_SERV',
'    AND    TIPO_PREST_SERV    = X.TIPO_PREST_SERV;',
'',
'    Update Agendas_Medicos_Horarios',
'           Set COD_PACIENTE = :P61_COD_PACIENTE',
'              ,TIPO_PACIENTE = :P61_TIPO_PACIENTE',
'              ,COD_TIPO_CONSULTA = :P61_COD_TIPO_CONSULTA',
'              ,COD_REQ            = NVL(COD_REQ,:P61_COD_REQ)',
'              ,USUARIO   = SUBSTR(:APP_USER||''ReqExame'',1,30)',
'              ,DT_ATUALIZACAO = SYSDATE',
'    /*           Cod_Empresa_Enc_Med        = X.Cod_Empresa_Enc_Med',
'               Cod_Prestr_Serv_Enc_Med    = X.Cod_Prestr_Serv_Enc_Med',
'               Tipo_Prest_Serv_Enc_Med    = X.Tipo_Prest_Serv_Enc_Med',
'               Data_Agenda_Enc_med        = X.Data_Agenda_Enc_med',
'               Hora_Inic_Previsto_Enc_Med = X.Hora_Inic_Previsto_Enc_Med*/',
'         Where RowId = :P61_AGENDA_ROWID;',
'   ',
'                       ',
'    if :p61_flag = ''N'' then',
unistr('     raise_application_error(-20001,''Requisi\00E7\00E3o: ''||:p61_cod_req||'' ''||:p61_mensagem);'),
'    end if;',
'  END LOOP;',
'   pkg_solicitacao_exames.post_insert(:p61_cod_req,',
'                           :p61_cod_emp_paciente,',
'                           :p_usuario,',
'                           :p61_flag,',
'                           :p61_mensagem);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(165292539475213316036)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165293743955919817691)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST_UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vtipo_paciente solicitacao_exames.tipo_paciente%type;',
'begin',
'',
'  if :P61_COD_TIPO_CONSULTA = ''ADM'' then -- ch37215 Adriana/Cibele observamos que a req estava gravando errado o tipo de paciente em alguns casos',
'    vtipo_paciente := 2;',
'  else',
'    vtipo_paciente := 1;',
'  end if;',
'',
'  FOR X IN (select *',
'            from   agendas_medicos_horarios',
'            where  rowid = :P61_AGENDA_ROWID) LOOP',
'      ',
'',
'    UPDATE SOLICITACAO_EXAMES',
'    SET    DATA_AGENDA        = :P61_DATA_AGENDA_DSP',
'          ,HORA_INIC_PREVISTO = TO_DATE(REPLACE(TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')||:P61_HORA_INIC_PREVISTO_DSP,'' '',''''),''DD/MM/YYYYHH24:MI'')',
'          ,HORA_FIM_PREVISTO  = TO_DATE(REPLACE(TO_CHAR(TO_DATE(:P61_DATA_AGENDA_DSP,''DD/MM/YYYY''),''DD/MM/YYYY'')||:P61_HORA_FIM_PREVISTO_DSP,'' '',''''),''DD/MM/YYYYHH24:MI'')',
'          ,COD_PREST_SERV     = X.COD_PRESTR_SERV',
'    WHERE  COD_REQ            = :P61_COD_REQ;',
'    ',
'    Update Agendas_Medicos_Horarios',
'    SET    BLOQUEADO = ''S''',
'          ,COD_REQ            = NVL(COD_REQ,:P61_COD_REQ)',
'          ,USUARIO   = SUBSTR(:APP_USER||''ReqExame'',1,30)',
'          ,DT_ATUALIZACAO = SYSDATE',
'    WHERE  HORA_INIC_PREVISTO = X.HORA_INIC_PREVISTO',
'    AND    DATA_AGENDA        = X.DATA_AGENDA',
'    AND    COD_EMPRESA        <> :P61_COD_EMP_PACIENTE',
'    AND    COD_PRESTR_SERV    = X.COD_PRESTR_SERV',
'    AND    TIPO_PREST_SERV    = X.TIPO_PREST_SERV;',
'',
'    Update Agendas_Medicos_Horarios',
'           Set COD_PACIENTE = :P61_COD_PACIENTE',
'              ,TIPO_PACIENTE = vtipo_paciente -- :P61_TIPO_PACIENTE',
'              ,COD_TIPO_CONSULTA = :P61_COD_TIPO_CONSULTA',
'              ,COD_REQ            = NVL(COD_REQ,:P61_COD_REQ)',
'              ,USUARIO   = SUBSTR(:APP_USER||''ReqExame'',1,30)',
'              ,DT_ATUALIZACAO = SYSDATE',
'    /*           Cod_Empresa_Enc_Med        = X.Cod_Empresa_Enc_Med',
'               Cod_Prestr_Serv_Enc_Med    = X.Cod_Prestr_Serv_Enc_Med',
'               Tipo_Prest_Serv_Enc_Med    = X.Tipo_Prest_Serv_Enc_Med',
'               Data_Agenda_Enc_med        = X.Data_Agenda_Enc_med',
'               Hora_Inic_Previsto_Enc_Med = X.Hora_Inic_Previsto_Enc_Med*/',
'         Where RowId = :P61_AGENDA_ROWID;',
'         ',
'     UPDATE MT_CHAMADA_PACIENTE M ',
'         SET M.COD_PREST_SERV = X.COD_PRESTR_SERV',
'        WHERE M.COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'        AND M.MATRICULA = :P61_COD_PACIENTE',
'        AND DATA = TRUNC(SYSDATE);',
'        ',
'    pkg_solicitacao_exames.post_update(:p61_cod_req,',
'                           :p61_cod_emp_paciente,',
'                           :p_usuario,',
'                           :p61_flag,',
'                           :p61_mensagem);',
'                       ',
'    if :p61_flag = ''N'' then',
'     raise_application_error(-20001,:p61_mensagem);',
'    end if;',
'  END LOOP;',
'  commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(139013365204541237513)
,p_process_sequence=>55
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPDATE_INF_FUNC_CANDIDATO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'V_CARGO NUMBER;',
'V_LOCAL VARCHAR2(8);',
'V_FUNCAO VARCHAR2(8);',
'BEGIN',
'V_CARGO := :P61_CARGO_PROPOSTO;',
'V_LOCAL := :P61_LOCAL_PRETENDIDO;',
'V_FUNCAO := :P61_FUNCAO_PROPOSTA;',
'BEGIN',
'UPDATE INF_FUNC_CANDIDATO',
'SET LOCAL_PRETENDIDO = V_LOCAL,',
'    CARGO_PRETENDIDO = V_CARGO,',
'    FUNCAO_PRETENDIDA = V_FUNCAO',
'    WHERE COD_CANDIDATO = :P61_COD_PACIENTE',
'    AND   COD_EMPRESA = :P61_COD_EMP_PACIENTE',
'    AND COD_FILIAL = :P61_FILIAL_AUX;',
'END;',
'COMMIT;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(165292555950273316080)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'reset page'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(141879313797406798704)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicio'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais',
' where cod_empresa = :p61_cod_emp_paciente',
'   and matricula = :p61_cod_paciente;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    if :p_painel = ''PC'' and :p61_rowid is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :P61_FILIAL_AUX := v_c1.filial;',
'',
'    end if;',
'    ',
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
