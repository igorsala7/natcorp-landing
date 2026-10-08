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
,p_default_application_id=>9113
,p_default_id_offset=>696776033023734483
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9113 - Recrutamento e Seleção - Processos
--
-- Application Export:
--   Application:     9113
--   Name:            Recrutamento e Seleção - Processos
--   Date and Time:   19:32 Saturday October 3, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 10
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00010
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_api.create_page(
 p_id=>10
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>unistr('Hist\00F3rico Fases do Processo')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Hist\00F3rico Fases do Processo')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.css'
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_ProcessoJanelas.css / Natcorp_ProcessoJanelas.js)',
'',
unistr('Janela Anota\00E7\00F5es das fases: "+" vira "Adicionar anota\00E7\00E3o"; lista vazia explicada.'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSOJANELAS-MANUTENCAO.md.',
unistr('---- (fim do bloco Natcorp; abaixo, o coment\00E1rio que a p\00E1gina j\00E1 tinha) ----')))
,p_last_upd_yyyymmddhh24miss=>'20240214123030'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52805343404259021597)
,p_plug_name=>'Filtro'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:t-Form--stretchInputs:t-Form--leftLabels:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(72951023803503200621)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52805343610391021599)
,p_plug_name=>unistr('Fases - Anota\00E7\00F5es')
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:i-h240:t-Region--stacked:t-Region--scrollBody:t-Form--noPadding:margin-top-none'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(72951031880997200635)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT h.cod_fase',
'      ,h.cod_fase||'' - ''||(SELECT INITCAP(f.desc_fase) FROM fase_candidato f WHERE f.cod_fase = h.cod_fase) fase',
'      ,NVL(TO_CHAR(h.dt_historico, ''DD/MM/RRRR HH24:MI:SS''), ''-'') dt_historico',
'      --,TO_CHAR(h.dt_atualizacao, ''DD/MM/RRRR HH24:MI:SS'')||h.usuario atualizacao_arquivos',
'      ,(CASE WHEN h.observacao IS NULL THEN ''-'' ELSE SUBSTR(h.observacao, 1, 50)||''...'' END) obsv',
'      ,h.cod_processo',
'      ,h.ROWID ',
'  FROM ps_hist_fase_proc h',
' WHERE h.cod_processo = :P10_PROCESSO',
'ORDER BY 3 DESC, 1'))
,p_plug_source_type=>'NATIVE_JQM_LIST_VIEW'
,p_ajax_items_to_submit=>'P10_PROCESSO'
,p_plug_query_num_rows=>100
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_02=>'FASE'
,p_attribute_06=>'OBSV'
,p_attribute_08=>'DT_HISTORICO'
,p_attribute_16=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:RP,11:P11_ROWID,P11_COD_PROCESSO:&ROWID.,&COD_PROCESSO.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52805343751291021601)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52805343610391021599)
,p_button_name=>'ADD_HISTORICO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary'
,p_button_template_id=>wwv_flow_api.id(72951052556524200676)
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:11:P11_COD_PROCESSO:&P10_PROCESSO.'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52805343474594021598)
,p_name=>'P10_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52805343404259021597)
,p_prompt=>'PROCESSO'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_NUM_PROCESSO_SELETIVO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ps.cod_processo det',
'      ,ps.cod_processo ret',
'  FROM ps_processo_seletivo ps',
'ORDER BY 2  '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52805676763524434575)
,p_name=>'P10_DESCRICAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52805343404259021597)
,p_use_cache_before_default=>'NO'
,p_item_default=>'-'
,p_prompt=>unistr('DESCRI\00C7\00C3O')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT NVL(ps.descricao, ''-'') ',
'  FROM ps_processo_seletivo ps',
' WHERE ps.cod_processo = :P10_PROCESSO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52805674676572430124)
,p_name=>unistr('AtribuiDescri\00E7\00E3o')
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_PROCESSO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52805675112181430133)
,p_event_id=>wwv_flow_api.id(52805674676572430124)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52805344252110021606)
,p_name=>'HideShowBT_ADD'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_PROCESSO'
,p_condition_element=>'P10_PROCESSO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52805344351248021607)
,p_event_id=>wwv_flow_api.id(52805344252110021606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52805343751291021601)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52805344430754021608)
,p_event_id=>wwv_flow_api.id(52805344252110021606)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52805343751291021601)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52805344538259021609)
,p_name=>'Hide_ADD_HISTORICO'
,p_event_sequence=>40
,p_condition_element=>'P10_PROCESSO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52805344629593021610)
,p_event_id=>wwv_flow_api.id(52805344538259021609)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52805343751291021601)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52805345213349021615)
,p_name=>'Fases - Dialog Close'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52805343610391021599)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52805345240710021616)
,p_event_id=>wwv_flow_api.id(52805345213349021615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(52805343610391021599)
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
