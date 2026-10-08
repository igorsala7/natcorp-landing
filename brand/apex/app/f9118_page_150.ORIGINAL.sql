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
,p_default_application_id=>9118
,p_default_id_offset=>697103804116150100
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9118 - Avaliações - Processos
--
-- Application Export:
--   Application:     9118
--   Name:            Avaliações - Processos
--   Date and Time:   16:14 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 150
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00150
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>150);
end;
/
prompt --application/pages/page_00150
begin
wwv_flow_api.create_page(
 p_id=>150
,p_user_interface_id=>wwv_flow_api.id(88927852534180042432)
,p_name=>'Feedback: Colaborador'
,p_step_title=>'Feedback: Colaborador'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.t-Header{',
'  display: none !important;',
'}',
'',
'@media only screen and (max-width: 700px) {',
'  .t-Comments-comment {',
'    font-size: 14px;',
'    line-height: 20px;',
'    max-width: 380px;',
'    display: block;',
'    white-space: normal;',
'    word-wrap: break-word;',
'  }',
'}',
'',
'@media only screen and (min-width: 701px) {',
'  .t-Comments-comment {',
'    font-size: 14px;',
'    line-height: 20px;',
'    max-width: 660px;',
'    display: block;',
'    white-space: normal;',
'    word-wrap: break-word;',
'  }',
'}',
'',
'.t-Comments-item{',
'margin-bottom: 28px !important;',
'}',
'',
'.t-Comments-userIcon{',
'  width: 42px !important;',
'  height: 42px !important;',
'  padding-top: 5px !important;',
'}',
'',
'',
'.t-Comments-body {',
'    padding: 4px !important;',
'    background-color: #f3f3f3 !important;',
'    border-radius: 8px !important;',
'}',
'',
'.t-Comments-comment{',
'  background-color: #f3f3f3 !important;',
'}',
'',
'.t-Comments-info{',
'  padding: 10px !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_deep_linking=>'Y'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20251002112757'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28554521650376445709)
,p_plug_name=>'Feedbacks'
,p_icon_css_classes=>'fa-sticky-note'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(88927824962254042335)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28554521808106445710)
,p_plug_name=>'Parametros'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--large:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>8
,p_plug_display_column=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_plug_display_when_condition=>'P_PAINEL'
,p_plug_display_when_cond2=>'PC'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(28652580235363927874)
,p_name=>'Feedback - Colaborador'
,p_template=>wwv_flow_api.id(88927826537342042338)
,p_display_sequence=>12
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:margin-top-md:margin-bottom-md'
,p_component_template_options=>'#DEFAULT#:t-Comments--chat'
,p_grid_column_span=>8
,p_display_column=>3
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
unistr('''<span aria-hidden="true" class="fa fa-user fa-2x"></span>'' user_icon, -- \00EDcone do coment\00E1rio'),
unistr('--''backgroundColorBlue colorPink'' icon_modifier, -- cor do coment\00E1rio'),
'case when f.cod_emp_feedback = :p_empresa_user and f.mat_feedback = :p_matricula_user then ''backgroundColorPink colorBlue'' else ''backgroundColorBlue colorPink'' end icon_modifier,',
unistr('''Autor: ''||nvl(Upper(nvl(nvl(px.nome_social,px.nome),fnct_nome_func(u.cd_empresa, u.cd_matricula))),lower(f.usuario))||''<br><small>''||upper(fnct_nome_cargo(i.cargo))||''</small>'' user_name, --nome do usu\00E1rio'),
'case when f.cod_empresa||''_''||f.matricula <> :p_empresa_user||''_''||:p_matricula_user then Upper(nvl(p.nome_social,p.nome))||''<br><small>''||upper(fnct_nome_cargo(i.cargo))||''</small><br>'' end || ',
unistr('replace(''<b>''||f.titulo||''</b>''||chr(10)||f.texto,chr(10),''<br>'') comment_text, -- texto do coment\00E1rio'),
unistr('to_char(f.dt_feedback,''dd/mm/rrrr hh24:mi'') COMMENT_DATE, -- data do coment\00E1rio'),
'''<br><div class="a-StarRating">',
'	<input type="text" name="PONTUACAO" value="''||f.nota||''" class="u-vh is-focusable" role="spinbutton" aria-valuenow="''||f.nota||''" aria-valuemax="5" aria-valuetext="''||f.nota||''"> ',
'		<div class="a-StarRating-stars"> ',
'			<div class="a-StarRating-starsInner">',
'				<div class="a-StarRating-stars-bg">',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (1,2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota = 5 then ''style="color: #c95788"'' end||''></span>',
'				</div>',
'			</div>',
'		</div>',
'</div>'' ATTRIBUTE_1,',
'/*',
'apex_page.get_url (',
'p_application => ''AV_PRC_''||:P_BASE,',
'p_page        => 149,',
'p_items       => ''P149_ROWID'',',
'p_values      => F.ROWID,',
'p_clear_cache => 149',
') ATTRIBUTE_1,',
'*/',
'null ATTRIBUTE_2,',
'null ATTRIBUTE_3,',
'null ATTRIBUTE_4,',
'case when f.cod_emp_feedback||''_''||f.mat_feedback = :p_empresa_user||''_''||:p_matricula_user then ''Editar'' end actions,',
'/*',
'''<div class="a-StarRating">',
'	<input type="text" name="PONTUACAO" value="''||f.nota||''" class="u-vh is-focusable" role="spinbutton" aria-valuenow="''||f.nota||''" aria-valuemax="5" aria-valuetext="''||f.nota||''"> ',
'		<div class="a-StarRating-stars"> ',
'			<div class="a-StarRating-starsInner">',
'				<div class="a-StarRating-stars-bg">',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (1,2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (2,3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (3,4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota in (4,5) then ''style="color: #c95788"'' end||''></span>',
'				<span class="a-StarRating-star fa fa-star"''||case when f.nota = 5 then ''style="color: #c95788"'' end||''></span>',
'				</div>',
'			</div>',
'		</div>',
'</div>'' ACTIONS,',
'*/',
'f.rowid',
'  FROM INFORMACOES_FUNCIONAIS I,',
'       INFORMACOES_FUNCIONAIS_CAD IX,',
'       INF_PESSOAIS P,',
'       INF_PESSOAIS_CAD PX,',
'       FEEDBACK_COLAB F,',
'       USUARIO_ORACLE U',
' WHERE i.cod_empresa = p.cod_empresa',
'   and i.cod_empresa = f.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.matricula = f.matricula',
'   and f.usuario = u.nm_usuario_oracle',
'   and f.cod_emp_feedback = px.cod_empresa',
'   and f.cod_emp_feedback = ix.cod_empresa',
'   and f.mat_feedback = px.matricula',
'   and f.mat_feedback = ix.matricula',
'   and ((f.publico = ''S'') or (f.publico = ''N'' and (f.cod_emp_feedback||''_''||f.mat_feedback = :p_empresa_user||''_''||:p_matricula_user) or (f.cod_empresa||''_''||f.matricula = :p_empresa_user||''_''||:p_matricula_user)))',
'   and ((f.colab_visualiza = ''S'') or (f.colab_visualiza = ''N'' and ((:p_painel <> ''PC'') or (f.cod_empresa||''_''||f.matricula <> :p_empresa_user||''_''||:p_matricula_user))))',
'   and ((:P_PAINEL <> ''PC'' AND ((nvl(:p150_tipo_feedback,0) = 0 and ((i.cod_empresa = :p_empresa_user',
'   and i.matricula = :p_matricula_user) or ',
'       (f.cod_emp_feedback = :p_empresa_user',
'   and f.mat_feedback = :p_matricula_user))) or ',
'      (:p150_tipo_feedback = 1 and ((i.cod_empresa = :p_empresa_user',
'   and i.matricula = :p_matricula_user))) or ',
'      (:p150_tipo_feedback = 2 and ((f.cod_emp_feedback = :p_empresa_user',
'   and f.mat_feedback = :p_matricula_user)))',
'        )) OR ',
'        (:P_PAINEL = ''PC'' and (i.cod_empresa = :p_empresa_user',
'   and i.matricula = :p_matricula_user)))',
'order by f.id_feedback desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P150_TIPO_FEEDBACK'
,p_query_row_template=>wwv_flow_api.id(88927834816541042353)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'- Nenhum Feedback Encontrado -'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554877805432959308)
,p_query_column_id=>1
,p_column_alias=>'USER_ICON'
,p_column_display_sequence=>1
,p_column_heading=>'User Icon'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554874194681959301)
,p_query_column_id=>2
,p_column_alias=>'ICON_MODIFIER'
,p_column_display_sequence=>2
,p_column_heading=>'Icon Modifier'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554874593888959303)
,p_query_column_id=>3
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>3
,p_column_heading=>'User Name'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554874967751959303)
,p_query_column_id=>4
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>4
,p_column_heading=>'Comment Text'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554875416220959304)
,p_query_column_id=>5
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>5
,p_column_heading=>'Comment Date'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554875732830959304)
,p_query_column_id=>6
,p_column_alias=>'ATTRIBUTE_1'
,p_column_display_sequence=>6
,p_column_heading=>'Attribute 1'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554876199471959305)
,p_query_column_id=>7
,p_column_alias=>'ATTRIBUTE_2'
,p_column_display_sequence=>7
,p_column_heading=>'Attribute 2'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554876577475959305)
,p_query_column_id=>8
,p_column_alias=>'ATTRIBUTE_3'
,p_column_display_sequence=>8
,p_column_heading=>'Attribute 3'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554876992340959306)
,p_query_column_id=>9
,p_column_alias=>'ATTRIBUTE_4'
,p_column_display_sequence=>9
,p_column_heading=>'Attribute 4'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554521595270445708)
,p_query_column_id=>10
,p_column_alias=>'ACTIONS'
,p_column_display_sequence=>11
,p_column_heading=>'Actions'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:149:&SESSION.::&DEBUG.:RP,149:P149_ROWID:#ROWID#'
,p_column_linktext=>'#ACTIONS#'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(28554878206931959308)
,p_query_column_id=>11
,p_column_alias=>'ROWID'
,p_column_display_sequence=>10
,p_column_heading=>'Rowid'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(28554878623118959309)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(28652580235363927874)
,p_button_name=>'ADD_FEEDBACK'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Feedback'
,p_button_position=>'BOTTOM'
,p_button_redirect_url=>'f?p=AV_PRC_&P_BASE.:149:&SESSION.::&DEBUG.:RP,149::'
,p_button_condition=>'P_PAINEL'
,p_button_condition2=>'PC'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(28554521842294445711)
,p_name=>'P150_TIPO_FEEDBACK'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(28554521808106445710)
,p_prompt=>'Feedbacks'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Meus Feedbacks;1,Feedbacks Criados por Mim;2'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Todos'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SUBMIT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28554882543508959322)
,p_name=>'Feedback'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P150_FEEDBACK'
,p_condition_element=>'P150_FEEDBACK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28554883042816959322)
,p_event_id=>wwv_flow_api.id(28554882543508959322)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(28652580235363927874)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28554883590470959323)
,p_event_id=>wwv_flow_api.id(28554882543508959322)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(28652580235363927874)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28554888811739959331)
,p_name=>'Add Feedback'
,p_event_sequence=>80
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(28554878623118959309)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28554889253312959331)
,p_event_id=>wwv_flow_api.id(28554888811739959331)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(28652580235363927874)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28554889691742959332)
,p_name=>'Add Feedback (Report)'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(28652580235363927874)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28554890204795959334)
,p_event_id=>wwv_flow_api.id(28554889691742959332)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(28652580235363927874)
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
