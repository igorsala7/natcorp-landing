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
,p_default_application_id=>2942
,p_default_id_offset=>722933175033509773
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2942 - Segurança do Trabalho - CIPA
--
-- Application Export:
--   Application:     2942
--   Name:            Segurança do Trabalho - CIPA
--   Date and Time:   15:19 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 35
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00035
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>35);
end;
/
prompt --application/pages/page_00035
begin
wwv_flow_api.create_page(
 p_id=>35
,p_user_interface_id=>wwv_flow_api.id(34486131585327022107)
,p_name=>unistr('Confirmar Vota\00E7\00E3o')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Confirmar Vota\00E7\00E3o')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260806124345'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(14122259220019044378)
,p_plug_name=>unistr('Confirma\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(34486105588489022013)
,p_plug_display_sequence=>12
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14165291172311531937)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_button_name=>'VOLTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(34486126553807022057)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(14165291099464531936)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_button_name=>'CONFIRMAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(34486126553807022057)
,p_button_image_alt=>'Confirmar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'      select c.cod_cipa,',
'           c.dt_ini_cipa, ',
'           c.dt_fin_cipa, ',
'           cc.dt_formacao_comis_eleitoral,',
'           cc.dt_inscr_eleicao_cipa,',
'           cc.dt_lista_inscr_candidatos',
'      from cipa c,',
'           constituicao_cipa cc',
unistr('     where c.cod_cipa = cc.cod_cipa -- Adriana: dura\00E7\00E3o da vota\00E7\00E3o \00E9 1 dia antes da apura\00E7\00E3o'),
'       and trunc(sysdate) between trunc(dt_apuracao_votos)-15 and trunc(dt_apuracao_votos) -- Adriana 28-08-2025 -- between trunc(c.dt_ini_cipa) and trunc(cc.dt_inscr_eleicao_cipa)--trunc(dt_fin_cipa)',
'       AND c.COD_CIPA = :P35_COD_CIPA;   ',
'      ',
'    v_c1 c1%rowtype;',
'',
'cursor c2 is',
'    select ''S'' existe',
'      from cipa_candidatos',
'     where cod_empresa = :p35_cod_empresa',
'       and cod_filial = :p35_cod_filial',
'       and cod_cipa = :p35_cod_cipa',
'       and cand_cod_empresa = :p35_cand_cod_empresa',
'       and cand_matricula = :p35_cand_matricula;',
'       ',
'v_c2 c2%rowtype;',
'',
'cursor c3 is',
'    select ''S'' existe',
'      from cipa_candidatos_votos',
'     where cod_cipa = :p35_cod_cipa',
'       and voto_cod_empresa = :p_empresa_user',
'       and voto_matricula = :p_matricula_user;',
'       ',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_cipa is null then',
'return false;',
'else',
'',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'  ',
'  if nvl(v_c2.existe,''N'') = ''S'' then',
'  ',
'      open c3;',
'      fetch c3 into v_c3;',
'      close c3;',
'      ',
'      if nvl(v_c3.existe,''N'') = ''N'' then',
'        return true;',
'      else',
'        return false;',
'      end if;',
'  ',
'  else',
'  ',
'  return false;',
'  ',
'  end if;',
'',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14122259352350044379)
,p_name=>'P35_COD_CIPA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14122259420505044380)
,p_name=>'P35_COD_EMPRESA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14122259508833044381)
,p_name=>'P35_COD_FILIAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14122259642031044382)
,p_name=>'P35_CAND_COD_EMPRESA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14165290824603531933)
,p_name=>'P35_CAND_MATRICULA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(14165290872253531934)
,p_name=>'P35_TEXTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(14122259220019044378)
,p_prompt=>'Texto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(34486125939483022050)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(14165291503959531940)
,p_name=>'Close Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(14165291172311531937)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(14165291628047531941)
,p_event_id=>wwv_flow_api.id(14165291503959531940)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14165291261959531938)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'CONFIRMAR VOTO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'insert into cipa_candidatos_votos (',
'    cod_empresa,',
'    cod_filial,',
'    cod_cipa,',
'    cand_cod_empresa,',
'    cand_matricula,',
'    voto_cod_empresa,',
'    voto_matricula,',
'    dt_voto',
')',
'values',
'(',
'    :p35_cod_empresa,',
'    :p35_cod_filial,',
'    :p35_cod_cipa,',
'    :p35_cand_cod_empresa,',
'    :p35_cand_matricula,',
'    :p_empresa_user,',
'    :p_matricula_user,',
'    sysdate',
');',
'',
'commit;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(14165291099464531936)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14165291436034531939)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Voto Confirmado com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(14165291050286531935)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Inicio'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select c.cod_cipa,',
'           c.dt_ini_cipa, ',
'           c.dt_fin_cipa, ',
'           cc.dt_formacao_comis_eleitoral,',
'           cc.dt_inscr_eleicao_cipa,',
'           cc.dt_lista_inscr_candidatos',
'      from cipa c,',
'           constituicao_cipa cc',
unistr('     where c.cod_cipa = cc.cod_cipa -- Adriana: dura\00E7\00E3o da vota\00E7\00E3o \00E9 1 dia antes da apura\00E7\00E3o'),
'       and trunc(sysdate) between trunc(dt_apuracao_votos)-15 and trunc(dt_apuracao_votos) -- adriana 28-08-25 -- between trunc(c.dt_ini_cipa) and trunc(cc.dt_inscr_eleicao_cipa)--trunc(dt_fin_cipa)',
'       AND c.COD_CIPA = :P35_COD_CIPA;',
'',
'    v_c1 c1%rowtype;',
'',
'    cursor c2 is',
'        select ''S'' existe',
'          from cipa_candidatos',
'         where cod_empresa = :p35_cod_empresa',
'           and cod_filial = :p35_cod_filial',
'           and cod_cipa = :p35_cod_cipa',
'           and cand_cod_empresa = :p35_cand_cod_empresa',
'           and cand_matricula = :p35_cand_matricula;',
'',
'    v_c2 c2%rowtype;',
'',
'    cursor c3 is',
'        select ''S'' existe',
'          from cipa_candidatos_votos',
'         where cod_cipa = :p35_cod_cipa',
'           and voto_cod_empresa = :p_empresa_user',
'           and voto_matricula = :p_matricula_user;',
'',
'    v_c3 c3%rowtype;',
'    ',
'        cursor c4 is',
'    select trunc(dt_apuracao_votos)-15 ini_votacao,',
'           trunc(dt_apuracao_votos) final_votacao',
'      from cipa c,',
'           constituicao_cipa cc',
unistr('     where c.cod_cipa = cc.cod_cipa -- Adriana: dura\00E7\00E3o da vota\00E7\00E3o \00E9 1 dia antes da apura\00E7\00E3o'),
'       AND c.COD_CIPA = :P35_COD_CIPA;',
'',
'    v_c4 c4%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    open c4;',
'    fetch c4 into v_c4;',
'    close c4;',
'',
'    if v_c1.cod_cipa is null then',
unistr('      :p35_texto := ''O Periodo de vota\00E7\00E3o \00E9 entre: ''||v_c4.ini_votacao||'' e ''||v_c4.final_votacao;'),
'    else    ',
'',
'      open c3;',
'      fetch c3 into v_c3;',
'      close c3;',
'',
'      if nvl(v_c3.existe,''N'') = ''N'' then',
'         :p35_texto := ''Deseja confirmar seu voto em ''||upper(fnct_nome_func(:p35_cand_cod_empresa,:p35_cand_matricula))||''?'';',
'      else',
unistr('         :p35_texto := ''Voto J\00E1 Realizado!'';'),
'      end if;',
'',
'    end if;',
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
