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
,p_default_application_id=>9503
,p_default_id_offset=>792625253271370653
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   01:37 Friday October 2, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 714
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00714
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>714);
end;
/
prompt --application/pages/page_00714
begin
wwv_flow_api.create_page(
 p_id=>714
,p_user_interface_id=>wwv_flow_api.id(201541282673876378229)
,p_name=>unistr('Marca\00E7\00E3o - Abono')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Marca\00E7\00E3o - Abono')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'600'
,p_dialog_width=>'70%'
,p_dialog_max_width=>'100%'
,p_dialog_chained=>'N'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260909233031'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(306820779320283663409)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-ButtonRegion--noBorder'
,p_plug_template=>wwv_flow_api.id(201541248682716378122)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>'return true;'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(315761003758298458292)
,p_plug_name=>'MENU'
,p_region_name=>'MARCACAO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--leftLabels:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(303444308342443120743)
,p_plug_name=>unistr('Marca\00E7\00E3o / Justicativa')
,p_region_name=>'MNU'
,p_parent_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(303444308404855120744)
,p_plug_name=>'Dados'
,p_region_name=>'DAD'
,p_parent_plug_id=>wwv_flow_api.id(303444308342443120743)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(315761013405450458304)
,p_plug_name=>unistr('Marca\00E7\00E3o')
,p_region_name=>'MARC'
,p_parent_plug_id=>wwv_flow_api.id(303444308404855120744)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(315761018948240458311)
,p_plug_name=>'Justificativa'
,p_region_name=>'JUST'
,p_parent_plug_id=>wwv_flow_api.id(303444308404855120744)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels:t-Form--labelsAbove:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(315761020551937458313)
,p_name=>'Aprovadores'
,p_region_name=>'APRV'
,p_parent_plug_id=>wwv_flow_api.id(303444308342443120743)
,p_template=>wwv_flow_api.id(201541256677038378135)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove:margin-top-none:margin-bottom-none:margin-left-none:margin-right-none'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct  a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, ',
'        a.dt_aprov Data,',
'        DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a,  informacoes_funcionais if',
' where  1=1 --a.cod_empresa = a.cod_emp_aprov',
' --and (a.mat_aprov = cc.matricula_suplente or a.mat_aprov = cc.matricula_gestor)',
' --and cc.cod = a.cod_ccusto',
' --and cc.cod_empresa = a.cod_emp_aprov',
' --',
' and if.cod_empresa(+) = a.cod_empresa',
' and if.matricula(+) = a.mat_aprov',
' and a.cod_solicitacao = :p714_cod_req',
'and (( :P714_COD_JUSTIFICATIVA = 151 and A.SEQ_APROV = 0 ) or ( :P714_COD_JUSTIFICATIVA != 151))',
' union',
' select distinct a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, ',
'                 a.dt_aprov Data, ',
'                 DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a,  usuario_oracle u    --,   CENTRO_DE_CUSTO cc',
' where 1=1 --cod = 8538',
' and a.cod_empresa = a.cod_emp_aprov',
' --and (a.mat_aprov = cc.matricula_suplente or a.mat_aprov = cc.matricula_gestor)',
' --and cc.cod = a.cod_ccusto',
' --and cc.cod_empresa = a.cod_emp_aprov',
' --',
' and (u.cd_empresa = a.cod_empresa and u.cd_matricula = a.mat_aprov)',
' and a.cod_solicitacao = :p714_cod_req',
'and (( :P714_COD_JUSTIFICATIVA = 151 and A.SEQ_APROV = 0 ) or ( :P714_COD_JUSTIFICATIVA != 151))',
'union',
'select U.CD_PERFIL aprovador, ',
'        a.dt_aprov Data, ',
'        DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a, usuario_oracle u',
' where a.cod_solicitacao = :p714_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa(+)',
'   and a.mat_aprov = u.cd_matricula(+)',
'  and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil) ',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
'    --and (( :P714_COD_JUSTIFICATIVA = 151 and A.SEQ_APROV = 0 ) or ( :P714_COD_JUSTIFICATIVA != 151))',
'',
'  GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
' order by 6',
'/* ',
'',
'select distinct a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, ',
'        a.dt_aprov Data,',
'        DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a,  informacoes_funcionais if',
' where  a.cod_empresa = a.cod_emp_aprov',
' --and (a.mat_aprov = cc.matricula_suplente or a.mat_aprov = cc.matricula_gestor)',
' --and cc.cod = a.cod_ccusto',
' --and cc.cod_empresa = a.cod_emp_aprov',
' --',
' and (if.cod_empresa = a.cod_empresa and if.matricula = a.mat_aprov)',
' and a.cod_solicitacao = :p714_cod_req',
' union',
' select distinct a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, ',
'                 a.dt_aprov Data, ',
'                 DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a,  usuario_oracle u    --,   CENTRO_DE_CUSTO cc',
' where 1=1 --cod = 8538',
' and a.cod_empresa = a.cod_emp_aprov',
' --and (a.mat_aprov = cc.matricula_suplente or a.mat_aprov = cc.matricula_gestor)',
' --and cc.cod = a.cod_ccusto',
' --and cc.cod_empresa = a.cod_emp_aprov',
' --',
' and (u.cd_empresa = a.cod_empresa and u.cd_matricula = a.mat_aprov)',
' and a.cod_solicitacao = :p714_cod_req',
'union',
'select U.CD_PERFIL aprovador, ',
'        a.dt_aprov Data, ',
'        DECODE(a.STATUS_APROV, ''A'', ''Aprovada'', ''P'', ''Pendente'', ''R'', ''Reprovada'')  Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from APROVA_ABONO a, usuario_oracle u',
' where a.cod_solicitacao = :p714_cod_req',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' ',
' ',
'  GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
' order by 6*/'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from APROVA_ABONO',
' where cod_solicitacao = :p714_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(201541265488592378151)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum Aprovador Encontrado.'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623280797319746)
,p_query_column_id=>1
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623504793319748)
,p_query_column_id=>2
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623540213319749)
,p_query_column_id=>3
,p_column_alias=>'STATUS'
,p_column_display_sequence=>4
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623654181319750)
,p_query_column_id=>4
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623144982319745)
,p_query_column_id=>5
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623712971319751)
,p_query_column_id=>6
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>6
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(141139623907278319752)
,p_query_column_id=>7
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>7
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(141855461648761971291)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(306820779320283663409)
,p_button_name=>'VOLTAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chevron-circle-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(147101556381254273353)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(306820779320283663409)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(201541277642356378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cancelar Requisi\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_conta number := 0;',
'    v_erro  varchar2(4000);',
'    ',
'    cursor c_datas is',
'    select data_ref_ponto, ind_trava_req_po',
'    from parametros_recursos_humanos',
'    where cod_empresa = :P714_EMP;',
'    r_datas c_datas%rowtype;',
'    ',
'    cursor c_req is',
'    select data_ponto from pe_req_tratamento_batimentos',
'    where cod_empresa =  :P714_EMP',
'    and cod_req = :P714_COD_REQ;',
'    r_req c_req%rowtype;',
'begin',
'',
'    open c_datas;',
'    fetch c_datas into r_datas;',
'    close c_datas;',
'    ',
'    open c_req;',
'    fetch c_req into r_req;',
'    close c_req;',
'    if  :P_PAINEL = ''PO'' then',
'        if r_datas.ind_trava_req_po != ''S'' then',
'            if (trunc(r_req.data_ponto) > trunc(r_datas.data_ref_ponto)) ',
'                and (:P714_OPERADOR_DELETA = ''S'' or :P714_OPERADOR_DELETA_DEMAIS = ''S'') then',
'                return true;',
'            end if;        ',
'        end if;',
'    else',
'        if (trunc(r_req.data_ponto) > trunc(r_datas.data_ref_ponto)) ',
'            and (:P714_OPERADOR_DELETA = ''S'' or :P714_OPERADOR_DELETA_DEMAIS = ''S'') then',
'            return true;',
'        end if;',
'    end if;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583272007045413855)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_button_name=>'P714_BTN_DEL_DATA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--pill'
,p_button_template_id=>wwv_flow_api.id(201541277352565378176)
,p_button_image_alt=>'P14 btn del data'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-close'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583272377232413861)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_button_name=>'p714_btn_del_batida'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--padLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(201541277352565378176)
,p_button_image_alt=>'P14 btn del batida'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-close'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583272776114413861)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_button_name=>'p714_btn_del_batida_abono'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--padLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(201541277352565378176)
,p_button_image_alt=>'P14 btn del batida'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-close'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583286543339413875)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(315761020551937458313)
,p_button_name=>'p714_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(201541277642356378179)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P714_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    ',
'v_flg_retorno     varchar2(3);',
'v_msg_retorno     varchar2(4000);',
'v_aprova_abono    varchar2(1);',
'v_cod_sit        pe_req_tratamento_batimentos.cod_sit_req%type;',
'',
'begin',
'    begin',
'        select cod_sit_req',
'            into v_cod_sit',
'            from pe_req_tratamento_batimentos',
'            where cod_req = :P714_COD_REQ;',
'    exception',
'        when others then',
'         v_cod_sit := 0;',
'    end;',
'    if v_cod_sit != 1 then',
'        return false;',
'    end if;',
'    --',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    end if;',
'',
'    PKG_PE_ABONO.Valida_Sequencia (:p714_cod_empresa, :p714_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        begin',
'            select CD_REJEITA_ABONO',
'             into v_aprova_abono',
'             from perfil_aprova_requisicao',
'             where cod_empresa = :P_EMPRESA_USER',
'              and cd_perfil = :P_PERFIL;',
'        exception',
'            when others then',
'                v_aprova_abono := ''S'';',
'        end;',
'        if v_aprova_abono = ''N'' then',
'            return false;',
'        end if;',
'        if v_aprova_abono = ''S'' then',
'            return true;',
'        end if;',
'        return false;',
'',
'    else',
'      return true;',
'    end if; ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583273229335413862)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_button_name=>'MAPA'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277352565378176)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Mapa'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=FREQ_CONSULTAS_&P_BASE.:9998:&SESSION.::&DEBUG.:RP,9998:P9998_DATA,P9998_EMP,P9998_MAT,P9998_POS,P9998_TIPO:&P714_DATA.,&P714_EMP.,&P714_MAT.,&P714_POSICAO.,A'
,p_icon_css_classes=>'fa-map-marker'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583258340751413835)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(306820779320283663409)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583257579831413829)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(306820779320283663409)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'from USUARIO_ORACLE UO',
'where UO.NM_USUARIO_ORACLE = :P_USUARIO',
'AND NOT EXISTS ( SELECT 1 FROM  PE_PERFIL_ABONO_GERAL PE ',
'                WHERE UO.CD_PERFIL = PE.CD_PERFIL',
'                AND UO.CD_EMPRESA = PE.COD_EMPRESA',
'                AND PE.BLOQUEIA = ''S'' )',
'and :P714_COD_REQ IS NULL'))
,p_button_condition_type=>'EXISTS'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(168583285808151413874)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(315761020551937458313)
,p_button_name=>'p714_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(201541277642356378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P714_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno     varchar2(3);',
'v_msg_retorno     varchar2(4000);',
'v_aprova_abono    varchar2(1);',
'v_cod_sit        pe_req_tratamento_batimentos.cod_sit_req%type;',
'begin',
'    begin',
'        select cod_sit_req',
'          into v_cod_sit',
'          from pe_req_tratamento_batimentos',
'          where cod_req = :P714_COD_REQ;',
'    exception',
'        when others then',
'         v_cod_sit := 0;',
'    end;',
'    if v_cod_sit != 1 then',
'        return false;',
'    end if;',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    end if;',
'',
'    PKG_PE_ABONO.Valida_Sequencia (:p714_cod_empresa, :p714_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        begin',
'            select cd_aprova_abono',
'                into v_aprova_abono',
'                from perfil_aprova_requisicao',
'                where cod_empresa = :P_EMPRESA_USER',
'                and cd_perfil = :P_PERFIL;',
'        exception',
'            when others then',
'                v_aprova_abono := ''S'';',
'        end;',
'        if v_aprova_abono = ''N'' then',
'            return false;',
'        end if;',
'        if v_aprova_abono = ''S'' then',
'            return true;',
'        end if;',
'        return false;',
'',
'    else',
'      return true;',
'    end if; ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(168583362165612413932)
,p_branch_name=>'Voltar'
,p_branch_action=>'f?p=&APP_ID.:137:&SESSION.::&DEBUG.:RP,137:P137_EMP,P137_MAT:&P714_EMP.,&P714_MAT.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'NEVER'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(108814309414794116799)
,p_name=>'P714_MENSAGEM_FECHA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(111694299871672866057)
,p_name=>'P714_VIRA_DIA_DSP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>'Vira Dia'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138250718081469302488)
,p_name=>'P714_PLANTAO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Plant\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138794802639986556550)
,p_name=>'P714_ERRO_CANCELA'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(139299001377663593736)
,p_name=>'P714_VALIDA_USERS'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140252771150669951906)
,p_name=>'P714_CONSULTA'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141815560816188083928)
,p_name=>'P714_OPERADOR_DELETA_DEMAIS'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142296391175424056700)
,p_name=>'P714_VALIDA_PERIODO_APROVA'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143101899849572010127)
,p_name=>'P714_OBRIGA_ABONO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(143628297318241085999)
,p_name=>'P714_VALIDA_DATA_PERIODO'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(146367742997662332150)
,p_name=>'P714_OPCAO_PLANTAO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_source=>'PLANTAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147101556456877273354)
,p_name=>'P714_OPERADOR_DELETA'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(148430961228182209257)
,p_name=>'P714_MUDA_COD_SIT_REQ'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(157668102314336185951)
,p_name=>'P714_CHECAR_APURACAO'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(159232772810224719786)
,p_name=>'P714_POSICAO_ENV_DSP'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Posi\00E7\00E3o Envio')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P714_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163434642072829203718)
,p_name=>'P714_TEM_REQ'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166360617302994201938)
,p_name=>'P714_LIMITE'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166770280442257658278)
,p_name=>'P714_TOTAL_REQ'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167236560084545650221)
,p_name=>'P714_POSICAO_ENVIO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_source=>'POSICAO_ENVIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583259062419413836)
,p_name=>'P714_MSG_CLOSE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583259481464413838)
,p_name=>'P714_CLOSE_PAGE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583259876158413838)
,p_name=>'P714_DTINI_MARCACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583260271943413839)
,p_name=>'P714_VALIDA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583260668815413839)
,p_name=>'P714_ROWID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583261067721413839)
,p_name=>'P714_FLAG'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583261526871413839)
,p_name=>'P714_MENSAGEM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583261894044413840)
,p_name=>'P714_OK'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583262290903413840)
,p_name=>'P714_ITEM_VALIDACAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583262642349413840)
,p_name=>'P714_COD_REQ'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583263066617413841)
,p_name=>'P714_DT_REQ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_placeholder=>'- Selecione -'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583263476203413842)
,p_name=>'P714_COD_SIT_REQ'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_cattributes_element=>'readonly=''readonly'''
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583263879245413842)
,p_name=>'P714_DT_SIT_REQ'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_placeholder=>'- Selecione -'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583264251730413842)
,p_name=>'P714_SOLICITANTE'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_prompt=>'Solicitante'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cargo ',
'  from informacoes_funcionais',
' where cod_empresa = :p714_cod_emp_req',
'   and matricula = :p714_mat_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'return :p714_cod_emp_req||'' - ''||initcap(fnct_nome_empresa(:p714_cod_emp_req))||'' / ''||:p714_mat_req||'' - ''||initcap(fnct_nome_func(:p714_cod_emp_req,:p714_mat_req));',
'',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583264681686413843)
,p_name=>'P714_EMP'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583265033726413843)
,p_name=>'P714_MAT'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583265437211413843)
,p_name=>'P714_DTINI_ABONO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583265878764413843)
,p_name=>'P714_DTFIM_ABONO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583266259661413843)
,p_name=>'P714_SEQ'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583266704781413843)
,p_name=>'P714_DATA_PONTO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Ponto'
,p_placeholder=>'- Selecione -'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DATA_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583267108117413843)
,p_name=>'P714_VIRA_DIA'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Vira Dia'
,p_placeholder=>'- Selecione -'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'VIRA_DIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583267496801413844)
,p_name=>'P714_COD_EMP_REQ'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Requisitante'
,p_source=>'COD_EMP_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583267883066413844)
,p_name=>'P714_MAT_REQ'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula Requisitante')
,p_source=>'MAT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583268285539413844)
,p_name=>'P714_FIL_REQ'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New'
,p_source=>'FIL_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583268672503413844)
,p_name=>'P714_USUARIO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583269104384413844)
,p_name=>'P714_DT_ATUALIZACAO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583269525545413845)
,p_name=>'P714_COD_EMPRESA'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome) descricao, cod',
'  from empresas_cad',
' where (((COD IN (SELECT X.COD_EMPRESA',
'                           FROM CENTRO_DE_CUSTO X',
'                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                         FROM USUARIO_ORACLE U  ',
'                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO))) and :p_painel = ''PG'') or ',
'        (f_acesso_emp_pg_apex(cod, :p_usuario) = ''S'' and :p_painel = ''PO'') or ',
'       (cod = :P_EMPRESA_USER and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P714_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583269915263413846)
,p_name=>'P714_MATRICULA'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_placeholder=>'- Selecione -'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) descricao, matricula cod',
'  from informacoes_funcionais_cad i',
' where cod_empresa = :p714_cod_empresa',
'   and i.situacao < ''90''',
'   and i.marca_ponto = ''S''',
'    AND (((I.COD_CCUSTO IN (SELECT X.COD',
'                           FROM CENTRO_DE_CUSTO X',
'                          WHERE X.MATRICULA_GESTOR IN (SELECT U.CD_MATRICULA ',
'                                                         FROM USUARIO_ORACLE U  ',
'                                                        WHERE U.NM_USUARIO_ORACLE = :P_USUARIO))) and :p_painel = ''PG'') or ',
'        (f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario) = ''S'' and :p_painel = ''PO'') or ',
'        (i.cod_empresa = :P_EMPRESA_USER',
'        and i.matricula = :P_MATRICULA_USER',
'         and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P714_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P714_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277028032378172)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583270322483413846)
,p_name=>'P714_CONSID_PTO_FERIADO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583270653334413846)
,p_name=>'P714_COD_JORNADA'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(315761003758298458292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583273553648413863)
,p_name=>'P714_DATA'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>'Data'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277287468378173)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583274022812413863)
,p_name=>'P714_POSICAO'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Posi\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with',
'    TP_POS as (',
'        SELECT posicao d, POSICAO c',
'          FROM PE_JORNADAS_COMPOSICAO pjc',
'         WHERE cod_jornada = :p714_cod_jornada                     ',
'           AND ((((((TO_CHAR(to_date(:P714_DATA), ''d'') = 1) AND (domingo = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 2) AND (segunda = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 3) AND (terca   = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 4) AND (quarta  = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 5) AND (quinta  = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 6) AND (sexta   = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) )',
'            OR   (((TO_CHAR(to_date(:P714_DATA), ''d'') = 7) AND (sabado  = ''S'')  AND (NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''N'')) ))',
'            OR ((NVL(:P714_CONSID_PTO_FERIADO,''N'') = ''S'' AND (FERIADO = ''S'') ))))',
'    )',
'select  A.D,A.C',
'from    (',
'            select  A.D,A.C',
'            from    TP_POS A',
'            union all',
'            select B.D,B.C',
'            from (select 1 D,1 C from dual connect by level = 1) B',
'            where not exists (select 1 from TP_POS)',
'         ) A',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P714_COD_JORNADA,P714_DATA,P714_CONSID_PTO_FERIADO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277287468378173)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583274359478413863)
,p_name=>'P714_JORNADA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Hor\00E1rio Previsto')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583274829269413863)
,p_name=>'P714_HORA_BATIDA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Marca\00E7\00E3o Realizada')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583275207457413863)
,p_name=>'P714_APAGAR_MARCACAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Apagar Marca\00E7\00E3o Realizada ?')
,p_source=>'APAGAR_MARCACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC: ;S'
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583275587067413864)
,p_name=>'P714_ENVIAR_MARCACAO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_item_default=>'SELECT NULL FROM DUAL'
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('Enviar Marca\00E7\00E3o p/Outra Posi\00E7\00E3o ?')
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC2: ;S'
,p_lov_cascade_parent_items=>'P714_POSICAO'
,p_ajax_optimize_refresh=>'Y'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'  FROM usuario_oracle uo',
' WHERE uo.nm_usuario_oracle = :P_USUARIO --:APP_USER',
'AND :P714_COD_REQ IS NULL',
'   AND NOT EXISTS ( SELECT 1 ',
'                      FROM pe_perfil_abono_geral pe ',
'                     WHERE uo.cd_perfil  = pe.cd_perfil',
'                       AND uo.cd_empresa = pe.cod_empresa',
'                       AND pe.bloqueia   = ''S'' )',
''))
,p_display_when_type=>'EXISTS'
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583276021926413864)
,p_name=>'P714_ENVMARC'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583276400319413865)
,p_name=>'P714_POSICAO_ENV'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Enviar p/Qual Posi\00E7\00E3o a Marca\00E7\00E3o Realizada ?')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT column_value det ',
'      ,column_value ret',
'  FROM apex_string.split_numbers(''1:2:3:4:5:6:7:8:9:10'','':'') ',
' WHERE COLUMN_VALUE <> :P714_POSICAO',
'ORDER BY 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P714_POSICAO'
,p_ajax_items_to_submit=>'P714_POSICAO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'  FROM usuario_oracle uo',
' WHERE uo.nm_usuario_oracle = :P_USUARIO --:APP_USER',
'   AND :P714_COD_REQ IS NULL',
'   AND NOT EXISTS ( SELECT 1 ',
'                      FROM pe_perfil_abono_geral pe ',
'                     WHERE uo.cd_perfil  = pe.cd_perfil',
'                       AND uo.cd_empresa = pe.cod_empresa',
'                       AND pe.bloqueia   = ''S'' )',
''))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583276779757413865)
,p_name=>'P714_POSENV_AR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583277215834413865)
,p_name=>'P714_XXX'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583277575194413865)
,p_name=>'P714_HORA_BATIDA_ABONO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>unistr('Hor\00E1rio de Abono da Posi\00E7\00E3o Atual')
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>24
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Feito'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583278028486413865)
,p_name=>'P714_HORA_BATIDA_ABONO_DSP'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_prompt=>'Hora Abono Mostra'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P714_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583278411049413865)
,p_name=>'P714_HORA_BATIDA_X'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New'
,p_placeholder=>'- Selecione -'
,p_format_mask=>'dd/mm/rrrr hh24:mi:ss'
,p_source=>'HORA_BATIDA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583278753315413866)
,p_name=>'P714_HORA_BATIDA_ABONO_X'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_prompt=>'New'
,p_placeholder=>'- Selecione -'
,p_format_mask=>'dd/mm/rrrr hh24:mi:ss'
,p_source=>'HORA_BATIDA_ABONO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583279208421413866)
,p_name=>'P714_POSICAO_X'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(315761013405450458304)
,p_use_cache_before_default=>'NO'
,p_source=>'POSICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583279875432413866)
,p_name=>'P714_COD_JUSTIFICATIVA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Justificativa'
,p_source=>'COD_JUSTIFICATIVA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT n descricao, i cod FROM pkg_list.fnc_list_justificativa(:P714_EMP, :P_PAINEL, :P_PERFIL)',
'/*',
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao)||',
' case when :P_PAINEL in (''PO'') and o.tipo_evento is not null then ',
'     '' | Evento Apurado: ''||o.tipo_ocorrencia||'' (''||initcap(o.tipo_evento)||'') | Evento Abonado: ''||o.evento_ponto||'' (''||initcap(o.tipo_evento_abono)||'')'' end descricao, ',
'ptj.cod_justificativa',
'from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where pepj.cod_empresa = :P714_EMP --:P714_COD_EMPRESA',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL ',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+) ',
'    ',
'union ',
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao)||',
' case when :P_PAINEL in (''PO'') and o.tipo_evento is not null then ',
'     '' | Evento Apurado: ''||o.tipo_ocorrencia||'' (''||initcap(o.tipo_evento)||'') | Evento Abonado: ''||o.evento_ponto||'' (''||initcap(o.tipo_evento_abono)||'')'' end descricao, ',
'ptj.cod_justificativa',
'from  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where ptj.cod_empresa = :P714_EMP',
'    AND NOT EXISTS (select 3',
'    from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj',
'    where pepj.cod_empresa = :P714_EMP    --:P714_COD_EMPRESA',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL)',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+) ',
'order by 2',
'*/'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P714_EMP'
,p_ajax_items_to_submit=>'P714_EMP'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(201541277287468378173)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583280306444413866)
,p_name=>'P714_NUM_DIAS_JUST'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_prompt=>unistr('Quantidade de Dias V\00E1lidos')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_display_when=>'P714_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'1'
,p_attribute_02=>'999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583280664145413867)
,p_name=>'P714_DT_INI_VAL_JUST'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_prompt=>unistr('In\00EDcio Validade')
,p_placeholder=>'-'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_display_when=>'P714_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583281131707413868)
,p_name=>'P714_DT_FIM_VAL_JUST'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_prompt=>'Fim Validade'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_display_when=>'P714_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583281442252413868)
,p_name=>'P714_ARQUIVO_JUST'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Comprovante'
,p_source=>'ARQUIVO_JUST'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'TIPO_ARQUIVO_JUST'
,p_attribute_03=>'NOME_ARQUIVO_JUST'
,p_attribute_04=>'CHARSET_ARQUIVO_JUST'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583287007347413875)
,p_name=>'P714_COMENTARIOS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(315761018948240458311)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Coment\00E1rio')
,p_source=>'COMENTARIOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>1000
,p_cHeight=>2
,p_read_only_when=>'P714_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(168583287346413413875)
,p_name=>'P714_OBS_APROVADOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(315761020551937458313)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o do Aprovador')
,p_placeholder=>unistr('Informe alguma observa\00E7\00E3o.')
,p_source=>'OBS_APROVADOR'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>2
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from APROVA_ABONO',
' where cod_solicitacao = :p714_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_read_only_when_type=>'NOT_EXISTS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(159232773264059719790)
,p_validation_name=>'Valida marcado apagar em branco enviar e horas de abono'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P714_APAGAR_MARCACAO = ''S'' and :P714_HORA_BATIDA_ABONO is not null and nvl( :P714_ENVIAR_MARCACAO, ''N'') = ''N'' ',
'       --and :P714_COD_JUSTIFICATIVA <> 8 ',
'       then',
'        :P714_APAGAR_MARCACAO := ''N'';',
'        return false;',
'    end if;',
'    return true;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('N\00E3o \00E9 necess\00E1rio apagar a marca\00E7\00E3o para abon\00E1-la. Exceto se desejar enviar a marca\00E7\00E3o para outra posi\00E7\00E3o.')
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583290646715413878)
,p_validation_name=>'Diferente Batida'
,p_validation_sequence=>20
,p_validation=>'P714_HORA_BATIDA_ABONO'
,p_validation2=>':p714_hora_batida'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>unistr('As Horas n\00E3o podem ser iguais.')
,p_associated_item=>wwv_flow_api.id(168583277575194413865)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583291122178413879)
,p_validation_name=>'Data Limite'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'	--',
'	v_data_ref_ponto DATE;',
'    v_ind_trava      varchar2(1);',
'	--',
'BEGIN',
'	--',
'  BEGIN',
'	  --',
'	  SELECT NVL(data_ref_ponto,TRUNC(SYSDATE)), ind_trava_req_po',
'	    INTO v_data_ref_ponto, v_ind_trava',
'	    FROM parametros_recursos_humanos',
'	   WHERE cod_empresa = :P714_emp;',
'  --',
'  EXCEPTION',
'  	--',
'	  WHEN OTHERS THEN',
'	    --',
'	    v_data_ref_ponto := TRUNC(SYSDATE);',
'  --',
'  END;',
'  --',
'  if v_ind_trava = ''S'' then',
'      IF :P714_data < v_data_ref_ponto THEN',
'          --',
'         return(''Data fora do limite permitido: '' || v_data_ref_ponto);',
'      --',
'      END IF;',
'  end if;',
'--',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(168583273553648413863)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583291519459413879)
,p_validation_name=>'Data Existente'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'cursor c1 is',
'	select count(*) tot',
'	from   pe_tratamento_batimentos',
'	where cod_empresa = :p714_emp',
'	and   matricula   = :p714_mat',
'	and   nvl(vira_dia,data_ponto)         = :p714_data',
'	and  (posicao     = 1 and ''S'' = ''N'' or ''S'' = ''S'');',
'	v_c1 c1%rowtype;',
'	v_imp number;',
'begin',
'',
'	open  c1;',
'	fetch c1 into v_c1;',
'	close c1;',
'',
'	if v_c1.tot > 0 and ''S'' = ''S'' then',
unistr('		return(''Data j\00E1 cadastrada!'');'),
'    END IF;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(168583273553648413863)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583290236635413878)
,p_validation_name=>'Valida Sit_Req'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_req',
'  from pe_req_tratamento_batimentos',
' where cod_req = :p714_cod_req;',
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
' pkg_pe_abono.Valida_Sit_Req(:p714_cod_empresa, :p714_cod_req, :p714_matricula, :p714_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno, :p_painel);',
'',
'end if;',
' if :P714_COD_SIT_REQ = 3 then',
'   v_msg_retorno := '''';',
' else  ',
'     if :P714_COD_SIT_REQ != 3 then',
'         if v_flg_retorno = ''N'' and v_msg_retorno is not null then',
'          return v_msg_retorno;',
'         end if;',
'     end if; ',
' end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'SAVE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_associated_item=>wwv_flow_api.id(168583263476203413842)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583291917682413879)
,p_validation_name=>unistr('Valida Matr\00EDcula')
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p_painel = ''PC'' and :p714_matricula <> :p_matricula_user then',
unistr('return ''Matr\00EDcula Inv\00E1lida!'';'),
'else',
'return null;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583292259369413879)
,p_validation_name=>unistr('Valida Posi\00E7\00E3o')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_emp empresas.cod%type;',
'v_mat informacoes_funcionais.matricula%type;',
'',
'begin',
' ',
' v_emp := nvl(:p714_cod_empresa, :p714_emp);',
' v_mat := nvl(:p714_matricula, :p714_mat);',
' ',
'  pkg_pe_abono.Valida_Posicao(v_emp',
'                                 ,v_mat',
'                                 ,:p714_data',
'                                 ,:p714_posicao',
'                                 ,v_flg_retorno',
'                                 ,v_msg_retorno',
'                                 ,:p_painel);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583289834404413878)
,p_validation_name=>unistr('Valida Per\00EDodo | Limite Abono')
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Verifica Per\00EDodo | Limite Abono'),
'DECLARE',
'  vReturn    VARCHAR2(550) DEFAULT NULL;',
'  --',
'  vMsg    VARCHAR2(550) DEFAULT NULL;',
'BEGIN',
'  --:P714_MSG_CLOSE  := NULL;',
'  --:P714_CLOSE_PAGE := NULL;',
'  :P714_VALIDA := NULL;',
'  --',
'  IF :P714_EMP IS NOT NULL AND :P714_DATA IS NOT NULL THEN',
'    vMsg := PKG_PE_ABONO.fnc_ValPeriodoAbonoPainel(pEmpresa   => :P714_EMP --P714_COD_EMPRESA',
'                                                  ,pUser      => :P_USUARIO --:APP_USER',
'                                                  ,pPainel    => :P_PAINEL',
'                                                  ,pData      => TRUNC(SYSDATE)',
'                                                  ,pPerIniPto => :P714_DATA);',
'    --',
'    IF vMsg IS NOT NULL THEN',
unistr('      vReturn := ''<strong>Edi\00E7\00E3o N\00C3O Permitida!!</strong><br>'';'),
'      vReturn := vReturn||REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>''), ''- '');',
'      --',
'      :P714_VALIDA := ''S'';',
'    ELSE',
'      IF :P714_COD_EMPRESA IS NOT NULL AND :P714_MATRICULA IS NOT NULL AND :P714_DATA IS NOT NULL THEN',
'        vMsg := PKG_PE_ABONO.fnc_ValLimiteAbono(pEmpresa   => :P714_EMP --P714_COD_EMPRESA',
'                                               ,pmatricula => :P714_MATRICULA',
'                                               ,pDataIni   => :P714_DTINI_ABONO',
'                                               ,pDataFim   => :P714_DTFIM_ABONO',
'                                               ,pUser      => :P_USUARIO --:APP_USER',
'                                               ,pQtdAbono  => 1',
'                                               ,pDataAbono => :P714_DATA',
'                                               ,pPainel    => :P_PAINEL);    ',
'        --',
'        IF vMsg IS NOT NULL THEN',
unistr('          vReturn := ''<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida!!</strong><br>'';'),
'          vReturn := vReturn||REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>''), ''- '');',
'          --',
'          :P714_VALIDA := ''S'';',
'        END IF;',
'      END IF;  ',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583288646248413877)
,p_validation_name=>'Valida Anexo'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    varchar2(250) DEFAULT NULL;',
'  --',
'  CURSOR cObrigComprov IS',
'    SELECT x.obriga_comprovante',
'      FROM pe_tipo_justificativa x',
'     WHERE x.cod_empresa = NVL(:P714_COD_EMPRESA, :P714_EMP)',
'       AND x.cod_justificativa = :P714_COD_JUSTIFICATIVA;',
'  --       ',
'  rObrigComprov    cObrigComprov%ROWTYPE;',
'BEGIN',
'  IF :P714_COD_JUSTIFICATIVA IS NOT NULL THEN',
'    IF :P714_ARQUIVO_JUST IS NULL THEN',
'      OPEN cObrigComprov;',
'      FETCH cObrigComprov INTO rObrigComprov;',
'      CLOSE cObrigComprov;',
'      --',
'      IF NVL(rObrigComprov.obriga_comprovante, ''N'') = ''S'' THEN',
'        vReturn := ''COMPROVANTE deve ser anexado!'';',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(168583257579831413829)
,p_associated_item=>wwv_flow_api.id(168583281442252413868)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583289055839413878)
,p_validation_name=>'Valida Num Dias'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P714_COD_JUSTIFICATIVA IS NOT NULL THEN',
'    IF NVL(:P714_NUM_DIAS_JUST, 0) = 0 THEN',
unistr('      vReturn := ''QTD. DIAS V\00C1LIDOS deve ser informado e maior que zero!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(168583257579831413829)
,p_associated_item=>wwv_flow_api.id(168583280306444413866)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583289487368413878)
,p_validation_name=>'Valida Dt Fim Validade'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P714_COD_JUSTIFICATIVA IS NOT NULL THEN',
'    IF :P714_DT_FIM_VAL_JUST IS NULL THEN',
'      vReturn := ''FIM VALIDADE deve ser informado!'';',
'    ELSE',
'      IF TO_DATE(:P714_DT_FIM_VAL_JUST, ''DD/MM/RRRR'') < TO_DATE(:P714_DT_INI_VAL_JUST, ''DD/MM/RRRR'') THEN',
unistr('        vReturn := ''FIM VALIDADE deve ser maior ou igual ao in\00EDcio!'';'),
'      END IF;      ',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(168583257579831413829)
,p_associated_item=>wwv_flow_api.id(168583281131707413868)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583288290745413877)
,p_validation_name=>'valid_P714_COD_JUSTIFICATIVA'
,p_validation_sequence=>120
,p_validation=>'P714_COD_JUSTIFICATIVA'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'#LABEL# deve ter algum valor.'
,p_associated_item=>wwv_flow_api.id(168583279875432413866)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(168583287859489413876)
,p_validation_name=>unistr('Valida Posi\00E7\00E3o Env')
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF NVL(:P714_ENVMARC, ''N'') = ''S'' THEN',
'    IF :P714_POSICAO_ENV IS NULL THEN',
unistr('      vReturn := ''Enviar POSI\00C7\00C3O deve ser informada!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(168583276400319413865)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8262093169224513204)
,p_validation_name=>'Valida Limite'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_msg varchar2(4000);',
'    v_flag  varchar(1);',
'begin',
'    :P714_MENSAGEM_FECHA := null;',
'    prc_valida_qtd_abono( p_cod_empresa => :P714_EMP',
'                    , p_matricula   => :P714_MAT',
'                    , p_painel      => :P_PAINEL',
'                    , p_perfil      => :P_PERFIL',
'                    , p_data_ponto  => :P714_DATA',
'                    , p_cod_req     => :P714_COD_REQ  ',
'                    , p_cod_justifica => :P714_COD_JUSTIFICATIVA',
'                    , p_flag        => v_flag',
'                    , p_messagem    => v_msg );',
'',
'    if v_msg is not null and v_flag = ''N'' then',
'        apex_error.add_error (',
'            p_message          => v_msg,',
'            p_display_location => apex_error.c_inline_with_field_and_notif',
'        );     ',
'    end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(139299001167054593734)
,p_name=>'Valida P_EMPRESA_USER e P_MATRICULA_USER;'
,p_event_sequence=>5
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(139299001249787593735)
,p_event_id=>wwv_flow_api.id(139299001167054593734)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P_EMPRESA_USER is null or :P_MATRICULA_USER is null then',
'    :P714_VALIDA_USERS := ''S'';',
'end if;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P714_VALIDA_USERS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583312769436413898)
,p_name=>'Deletar Data'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(312443206126360905436)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583313314586413898)
,p_event_id=>wwv_flow_api.id(168583312769436413898)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Deseja Excluir Todas as Batidas?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583313747467413898)
,p_event_id=>wwv_flow_api.id(168583312769436413898)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'P714_BTN_DEL_DATA'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583314135016413898)
,p_name=>'Deletar Batida'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(312443206532538905437)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583314657494413899)
,p_event_id=>wwv_flow_api.id(168583314135016413898)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja Deletar a Marca\00E7\00E3o Original?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583315219482413899)
,p_event_id=>wwv_flow_api.id(168583314135016413898)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'p714_btn_del_batida'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(148376461753943136886)
,p_name=>unistr('Mostra ou n\00E3o conforme situa\00E7\00E3o da requisi\00E7\00E3o')
,p_event_sequence=>25
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148430959257861209237)
,p_event_id=>wwv_flow_api.id(148376461753943136886)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_COD_SIT_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148430959533243209240)
,p_event_id=>wwv_flow_api.id(148376461753943136886)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_COD_SIT_REQ_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148430959823783209243)
,p_event_id=>wwv_flow_api.id(148376461753943136886)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583258340751413835)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583315615735413899)
,p_name=>'Deletar Batida Abono'
,p_event_sequence=>45
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(168583272776114413861)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583316060095413899)
,p_event_id=>wwv_flow_api.id(168583315615735413899)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>unistr('Deseja Deletar a Marca\00E7\00E3o Abonada?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583316539727413899)
,p_event_id=>wwv_flow_api.id(168583315615735413899)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'p714_btn_del_batida_abono'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583316965328413900)
,p_name=>'Hide Fields'
,p_event_sequence=>55
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583317445273413902)
,p_event_id=>wwv_flow_api.id(168583316965328413900)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_COD_REQ,P714_DT_REQ,P714_COD_SIT_REQ,P714_DT_SIT_REQ,P714_COD_EMP_REQ,P714_MAT_REQ,P714_DATA_PONTO,P714_VIRA_DIA,P714_SOLICITANTE,P714_FIL_REQ'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583317835024413902)
,p_name=>'Hide Fields_1'
,p_event_sequence=>65
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583318401776413903)
,p_event_id=>wwv_flow_api.id(168583317835024413902)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_DATA_PONTO,P714_VIRA_DIA,P714_HORA_BATIDA_X,P714_HORA_BATIDA_ABONO_X,P714_COD_EMP_REQ,P714_MAT_REQ,P714_FIL_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583318777964413903)
,p_name=>'Popula Campos_1'
,p_event_sequence=>75
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSICAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583319325156413903)
,p_event_id=>wwv_flow_api.id(168583318777964413903)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
'  from pe_tratamento_batimentos',
' where cod_empresa = nvl(:p714_emp,:p714_cod_empresa)',
'   and matricula = nvl(:p714_mat,:p714_matricula)',
'   and nvl(vira_dia,data_ponto) = :p714_data',
'   and posicao = :p714_posicao',
'   and :p714_cod_req is null',
' union',
' select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
'  from pe_req_tratamento_batimentos',
' where /*cod_empresa = nvl(:p714_emp,cod_empresa)',
'   and matricula = nvl(:p714_mat,matricula)',
'   and nvl(vira_dia,data_ponto) = nvl(:p714_data,nvl(vira_dia,data_ponto))',
'   and posicao = nvl(:p714_posicao,posicao)',
'   and */cod_req = :p714_cod_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_emp number, v_mat number, v_data date, v_pos number, v_pto_feriado varchar2) is',
'      SELECT horario, posicao',
'        FROM PE_JORNADAS_COMPOSICAO',
'       WHERE cod_jornada = Fnct_Pe_Retorna_Jornada( v_emp, v_mat, v_data )',
'         AND POSICAO = v_pos',
'         AND ((((((TO_CHAR(v_data, ''d'') = 1) AND (domingo = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 2) AND (segunda = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 3) AND (terca   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 4) AND (quarta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 5) AND (quinta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 6) AND (sexta   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 7) AND (sabado  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) ))',
'          OR ((NVL(v_pto_feriado,''N'') = ''S'' AND (FERIADO = ''S'') ))))',
'       ORDER BY POSICAO DESC;',
' ',
'v_c2 c2%rowtype;',
'',
' V_CONSID_PTO_FERIADO varchar2(1) := ''N'';',
'',
'v_emp informacoes_funcionais.cod_empresa%type;',
'v_mat informacoes_funcionais.matricula%type;',
'',
'begin',
'',
':P714_XXX := NULL;',
'',
'v_emp := nvl(:p714_emp,:p714_cod_empresa);',
'v_mat := nvl(:p714_mat,:p714_matricula);',
'',
'/*',
':p714_cod_empresa := :p714_emp;',
':p714_matricula := :p714_mat;',
'*/',
'    open  c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
' V_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(v_emp,v_mat,:p714_data);',
' ',
'    open  c2(v_emp, v_mat, :p714_data, :p714_posicao, V_CONSID_PTO_FERIADO);',
'    fetch c2 into v_c2;',
'    close c2;',
'    ',
'    if v_c2.horario is not null then',
'    :p714_jornada           := v_c2.horario;',
'    else',
'    :p714_jornada           := null;',
'    end if;',
' ',
'    if v_c1.cod_empresa is not null then ',
'    ',
'        :p714_hora_batida       := to_char(v_c1.hora_batida,''hh24:mi'');',
'        :p714_hora_batida_abono := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'        :p714_hora_batida_abono_dsp := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'',
'        :p714_cod_justificativa := v_c1.cod_justificativa;',
'        :p714_comentarios       := v_c1.comentarios;',
'        ',
'    else',
'',
'        :p714_hora_batida       := null;',
'        :p714_hora_batida_abono := null;',
'        :p714_hora_batida_abono_dsp := null;',
'        :p714_cod_justificativa := null;',
'        :p714_comentarios       := null;',
'        ',
'        :P714_XXX := ''S'';',
'    ',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P714_EMP,P714_MAT,P714_DATA,P714_POSICAO,P714_COD_EMPRESA,P714_MATRICULA,P714_XXX'
,p_attribute_03=>'P714_HORA_BATIDA,P714_HORA_BATIDA_ABONO,P714_COD_JUSTIFICATIVA,P714_COMENTARIOS,P714_HORA_BATIDA_ABONO_DSP,P714_JORNADA,P714_XXX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583319730607413904)
,p_name=>'Popula_Campos_2'
,p_event_sequence=>85
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_DATA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583320193019413904)
,p_event_id=>wwv_flow_api.id(168583319730607413904)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' ',
'cursor c1 is',
'select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
'  from pe_tratamento_batimentos',
' where cod_empresa = :p714_emp',
'   and matricula = :p714_mat',
'   and nvl(vira_dia,data_ponto) = :p714_data',
'   and posicao = :p714_posicao',
'   and :p714_cod_req is null',
' union',
' select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
'  from pe_req_tratamento_batimentos',
' where /*cod_empresa = nvl(:p714_emp,cod_empresa)',
'   and matricula = nvl(:p714_mat,matricula)',
'   and nvl(vira_dia,data_ponto) = nvl(:p714_data,nvl(vira_dia,data_ponto))',
'   and posicao = nvl(:p714_posicao,posicao)',
'   and */cod_req = :p714_cod_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_emp number, v_mat number, v_data date, v_pos number, v_pto_feriado varchar2) is',
'      SELECT horario, posicao',
'        FROM PE_JORNADAS_COMPOSICAO',
'       WHERE cod_jornada = Fnct_Pe_Retorna_Jornada( v_emp, v_mat, v_data )',
'         AND POSICAO = v_pos',
'         AND ((((((TO_CHAR(v_data, ''d'') = 1) AND (domingo = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 2) AND (segunda = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 3) AND (terca   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 4) AND (quarta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 5) AND (quinta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 6) AND (sexta   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 7) AND (sabado  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) ))',
'          OR ((NVL(v_pto_feriado,''N'') = ''S'' AND (FERIADO = ''S'') ))))',
'       ORDER BY POSICAO DESC;',
' ',
'v_c2 c2%rowtype;',
'',
' V_CONSID_PTO_FERIADO varchar2(1) := ''N'';',
'',
'begin',
'/*',
':p714_cod_empresa := :p714_emp;',
':p714_matricula := :p714_mat;',
'*/',
'    open  c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
' V_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
' ',
'  IF :P714_MAT IS NOT NULL AND :P714_DATA IS NOT NULL THEN',
' :P714_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
' :P714_COD_JORNADA := Fnct_Pe_Retorna_Jornada(:P714_EMP,:P714_MAT,:p714_DATA);',
' END IF;',
' ',
'    if v_c1.cod_empresa is not null then ',
'    ',
'',
'        :p714_data_ponto        := v_c1.data_ponto;',
'        :p714_vira_dia          := v_c1.vira_dia;',
'        :p714_hora_batida       := to_char(v_c1.hora_batida,''hh24:mi'');',
'        :p714_hora_batida_abono := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'        :p714_hora_batida_abono_dsp := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'',
'        :p714_cod_justificativa := v_c1.cod_justificativa;',
'        :p714_comentarios       := v_c1.comentarios;',
'    ',
'    open  c2(v_c1.cod_empresa, v_c1.matricula, v_c1.data_ponto, v_c1.posicao, V_CONSID_PTO_FERIADO);',
'    fetch c2 into v_c2;',
'    close c2;',
'    ',
'    :p714_jornada           := v_c2.horario;',
'    ',
'    else',
'    ',
'        :p714_data_ponto        := :p714_data;',
'        :p714_vira_dia          := null;',
'        :p714_hora_batida       := null;',
'        :p714_hora_batida_abono := null;',
'        :p714_hora_batida_abono_dsp := null;',
'        :p714_cod_justificativa := null;',
'        :p714_comentarios       := null;',
'        :p714_jornada           := null;',
'    ',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P714_EMP,P714_MAT,P714_DATA,P714_POSICAO'
,p_attribute_03=>'P714_HORA_BATIDA,P714_HORA_BATIDA_ABONO,P714_COD_JUSTIFICATIVA,P714_COMENTARIOS,P714_HORA_BATIDA_ABONO_DSP,P714_JORNADA,P714_DATA_PONTO,P714_VIRA_DIA,P714_COD_JORNADA,P714_CONSID_PTO_FERIADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583320619529413906)
,p_name=>'Dois Pontos'
,p_event_sequence=>95
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_HORA_BATIDA,P714_HORA_BATIDA_ABONO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583321091362413906)
,p_event_id=>wwv_flow_api.id(168583320619529413906)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p714_hora_batida is not null then',
'    :p714_hora_batida := substr(trim(to_char(replace(:p714_hora_batida,'':''),''0000'')),1,2)||'':''||substr(trim(to_char(replace(:p714_hora_batida,'':''),''0000'')),3,2);',
'    else ',
'    :p714_hora_batida := null;',
'    end if;',
'    ',
'    if :p714_hora_batida_abono is not null then',
'    :p714_hora_batida_abono := substr(trim(to_char(replace(:p714_hora_batida_abono,'':''),''0000'')),1,2)||'':''||substr(trim(to_char(replace(:p714_hora_batida_abono,'':''),''0000'')),3,2);',
'    else ',
'    :p714_hora_batida_abono := null;',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P714_HORA_BATIDA,P714_HORA_BATIDA_ABONO'
,p_attribute_03=>'P714_HORA_BATIDA,P714_HORA_BATIDA_ABONO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583321504604413906)
,p_name=>'Disable Fields'
,p_event_sequence=>105
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583321946936413907)
,p_event_id=>wwv_flow_api.id(168583321504604413906)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P714_HORA_BATIDA'').disabled = true;',
'$x(''P714_DATA'').disabled = true;',
'$x(''P714_COD_REQ'').disabled = true;',
'$x(''P714_DT_REQ'').disabled = true;',
'$x(''P714_DT_SIT_REQ'').disabled = true;',
'$x(''P714_COD_EMP_REQ'').disabled = true;',
'$x(''P714_MAT_REQ'').disabled = true;',
'//$x(''P714_DATA_PONTO'').disabled = true;',
'$x(''P714_VIRA_DIA'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583322431136413907)
,p_name=>'Disable Fields Consulta'
,p_event_sequence=>115
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583322845613413907)
,p_event_id=>wwv_flow_api.id(168583322431136413907)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P714_COD_JUSTIFICATIVA'').disabled = true;',
'$x(''P714_POSICAO'').disabled = true;',
'$x(''P714_DATA'').disabled = true;',
'$x(''P714_COD_EMPRESA'').disabled = true;',
'$x(''P714_MATRICULA'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583323321999413907)
,p_name=>'Enable Fields (Create)'
,p_event_sequence=>125
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(168583257579831413829)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583323745756413907)
,p_event_id=>wwv_flow_api.id(168583323321999413907)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P714_HORA_BATIDA'').disabled = false;',
'$x(''P714_DATA'').disabled = false;',
'$x(''P714_COD_REQ'').disabled = false;',
'$x(''P714_DT_REQ'').disabled = false;',
'$x(''P714_COD_SIT_REQ'').disabled = false;',
'$x(''P714_DT_SIT_REQ'').disabled = false;',
'$x(''P714_COD_EMP_REQ'').disabled = false;',
'$x(''P714_MAT_REQ'').disabled = false;',
'$x(''P714_DATA_PONTO'').disabled = false;',
'$x(''P714_VIRA_DIA'').disabled = false;',
'$x(''P714_COD_JUSTIFICATIVA'').enabled = false;',
'',
'apex.widget.waitPopup();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583324286586413907)
,p_event_id=>wwv_flow_api.id(168583323321999413907)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583324688880413908)
,p_name=>'Show Fields (Create)'
,p_event_sequence=>145
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(302414158832145831588)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583325170942413908)
,p_event_id=>wwv_flow_api.id(168583324688880413908)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_COD_REQ,P714_DT_REQ,P714_COD_SIT_REQ,P714_DT_SIT_REQ,P714_COD_EMP_REQ,P714_MAT_REQ,P714_DATA_PONTO,P714_VIRA_DIA,P714_HORA_BATIDA_X,P714_HORA_BATIDA_ABONO_X,P714_FIL_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583325545751413908)
,p_name=>'Save'
,p_event_sequence=>155
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(168583258340751413835)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583326092418413908)
,p_event_id=>wwv_flow_api.id(168583325545751413908)
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
'cursor c_req is',
'select cod_sit_req',
'  from pe_req_tratamento_batimentos',
' where cod_req = :p714_cod_req;',
'',
'v_req c_req%rowtype;',
'',
'begin',
'',
' pkg_pe_abono.Valida_Sit_Req(:p714_cod_empresa, :p714_cod_req, :p714_matricula, :p714_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno, :p_painel);',
' ',
'commit;',
' if v_flg_retorno <> ''N'' and trim(v_msg_retorno) is null or (:p714_cod_sit_req = 3) then',
'',
'    update pe_req_tratamento_batimentos',
'       set cod_sit_req = :p714_cod_sit_req,',
'           dt_sit_req = sysdate,',
'           usuario = :p_usuario,',
'           dt_atualizacao = sysdate',
'     where cod_req = :p714_cod_req;',
'',
'    commit;',
'',
'  PKG_PE_ABONO.Post_Update(:P714_cod_empresa,',
'                           :P714_cod_req,',
'                           V_flg_retorno,',
'                           V_msg_retorno);',
'                           ',
' end if;',
' ',
' if v_msg_retorno is not null then',
'    :p714_ok       := ''N'';',
'    :p714_FLAG     := v_flg_retorno;',
'    :p714_mensagem := v_msg_retorno;',
' else',
'    :p714_flag     := null;',
'    :p714_mensagem := null;',
'    :p714_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P714_COD_EMPRESA,P714_COD_REQ,P714_COD_SIT_REQ,P_USUARIO,P714_MATRICULA'
,p_attribute_03=>'P714_OK,P714_FLAG,P714_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583326618481413909)
,p_event_id=>wwv_flow_api.id(168583325545751413908)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P714_FLAG").getValue() == ''N'') {',
'console.log(apex.item("P714_MENSAGEM").getValue());',
'}else{',
'apex.navigation.dialog.cancel( true );',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583333535642413912)
,p_name=>'Dispara Alerta'
,p_event_sequence=>205
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MENSAGEM'
,p_condition_element=>'P714_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583334095227413913)
,p_event_id=>wwv_flow_api.id(168583333535642413912)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P714_FLAG'').value == "Q") {',
'alertify.confirm($v(''P714_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P714_FLAG'').value = ''S'';',
'        $x(''P714_MENSAGEM'').value = '''';',
'        $x(''P714_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P714_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P714_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P714_FLAG'').value == "N") {',
'            $x(''P714_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P714_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P714_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P714_MENSAGEM''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P714_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P714_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P714_ITEM_VALIDACAO'').value == ''P714_CREATE''){',
'            $x(''P714_OK'').value = ''S'';',
'        $x(''P714_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583334464110413913)
,p_name=>'OK: Show Create'
,p_event_sequence=>215
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_ITEM_VALIDACAO'
,p_condition_element=>'P714_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583334991928413913)
,p_event_id=>wwv_flow_api.id(168583334464110413913)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583335474556413913)
,p_event_id=>wwv_flow_api.id(168583334464110413913)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583335870556413914)
,p_name=>'Ativa Alertify'
,p_event_sequence=>225
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583336376756413914)
,p_event_id=>wwv_flow_api.id(168583335870556413914)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583336742809413914)
,p_name=>unistr('Retorna Hor\00E1rio de Jornada')
,p_event_sequence=>235
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_HORA_BATIDA_ABONO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583337251757413914)
,p_event_id=>wwv_flow_api.id(168583336742809413914)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_HORA_BATIDA_ABONO VARCHAR2(5) := :P714_HORA_BATIDA_ABONO;',
'',
'BEGIN',
'',
'if :P714_HORA_BATIDA_ABONO IS NULL THEN',
':P714_HORA_BATIDA_ABONO := :P714_JORNADA;',
'else',
':P714_HORA_BATIDA_ABONO := V_HORA_BATIDA_ABONO;',
'END IF;',
'',
'END;'))
,p_attribute_02=>'P714_HORA_BATIDA_ABONO,P714_JORNADA'
,p_attribute_03=>'P714_HORA_BATIDA_ABONO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583337725769413914)
,p_name=>'Valida Sit Req'
,p_event_sequence=>245
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_SIT_REQ'
,p_condition_element=>'P714_COD_SIT_REQ'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'3'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583338178233413915)
,p_event_id=>wwv_flow_api.id(168583337725769413914)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno     varchar2(3);',
'v_msg_retorno     varchar2(4000);',
'v_cancela         parametros_recursos_humanos.operador_cancela_requisicoes%type;',
'',
'cursor c1 is',
'select cod_req, mat_req',
'  from PE_REQ_TRATAMENTO_BATIMENTOS',
' where cod_req = :P714_COD_REQ;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'    if :P_PAINEL = ''PG'' then',
'        :P714_MUDA_COD_SIT_REQ := ''so operador''; ',
'    else',
'        begin',
'             -- Passa a considerar o parametro de operador cancela a requisicao - ANDRE - 13-10-2023',
'            select operador_cancela_requisicoes',
'                into v_cancela',
'                from parametros_recursos_humanos',
'                where cod_empresa = :P714_EMP;',
'        exception',
'            when others then',
'                v_cancela := ''N'';',
'        end;',
'        --',
'        open c1;',
'        fetch c1 into v_c1;',
'        close c1;',
'',
'        if v_c1.mat_req = :P_MATRICULA_USER then',
'            :P714_MUDA_COD_SIT_REQ := null;',
'        else',
'            if v_c1.mat_req != :P_MATRICULA_USER and :P714_COD_SIT_REQ = 3  and :P_PAINEL = ''PO'' and v_cancela = ''N'' then',
'                :P714_MUDA_COD_SIT_REQ := ''matriculas diferentes''; ',
'            else',
'                PKG_PE_ABONO.Valida_Sit_Req(:P714_EMP, :P714_COD_REQ, :P714_MAT, :P714_COD_SIT_REQ, :p_usuario, v_flg_retorno, v_msg_retorno, :p_painel);',
'                if v_msg_retorno is not null then',
'                    apex_error.add_error( p_message => v_msg_retorno, p_display_location => apex_error.c_inline_in_notification);',
'                else',
'                    :P714_MUDA_COD_SIT_REQ := null;            ',
'                end if;',
'            end if;',
'        end if;',
'    end if;',
'end;',
''))
,p_attribute_02=>'P714_COD_EMPRESA,P714_COD_REQ,P714_COD_SIT_REQ,P_USUARIO,P714_MATRICULA,P_PAINEL'
,p_attribute_03=>'P714_MUDA_COD_SIT_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583338619716413915)
,p_name=>'Popula Emp / Mat'
,p_event_sequence=>255
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583339044271413915)
,p_event_id=>wwv_flow_api.id(168583338619716413915)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P714_MAT IS NULL THEN',
':P714_EMP := :P714_COD_EMPRESA;',
':P714_MAT := :P714_MATRICULA;',
'END IF;'))
,p_attribute_02=>'P714_COD_EMPRESA,P714_MATRICULA,P714_MAT'
,p_attribute_03=>'P714_EMP,P714_MAT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583339485838413915)
,p_name=>'Hide Fields (emp/mat)'
,p_event_sequence=>265
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583339988761413915)
,p_event_id=>wwv_flow_api.id(168583339485838413915)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_COD_EMPRESA,P714_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583340351652413915)
,p_name=>'Valida_Posicao'
,p_event_sequence=>275
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_DATA,P714_POSICAO'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.da.testCondition( this.triggeringElement.id, ''NOT_NULL'' )'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583340921661413916)
,p_event_id=>wwv_flow_api.id(168583340351652413915)
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
'v_item_validacao varchar2(100) := :P714_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p714_mensagem := null;',
' ',
'  pkg_pe_abono.Valida_Posicao(NVL(:P714_EMP,:p714_cod_empresa)',
'                             ,NVL(:P714_MAT,:p714_matricula)',
'                             ,:p714_data',
'                             ,:p714_posicao',
'                             ,v_flg_retorno',
'                             ,v_msg_retorno',
'                             ,:p_painel);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P714_ITEM_VALIDACAO := TRIM(UPPER(''p714_data''));',
'    :p714_ok       := ''N'';',
'    :p714_flag     := v_flg_retorno;',
'    :p714_mensagem := v_msg_retorno;',
' else',
'    :p714_flag     := null;',
'    :p714_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p714_data'')) OR v_item_validacao IS NULL then',
'       :P714_OK := ''S'';',
'       :P714_ITEM_VALIDACAO := null;',
'    else',
'       :P714_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P714_ITEM_VALIDACAO,P714_COD_EMPRESA,P714_MATRICULA,P714_DATA,P714_POSICAO,P714_EMP,P714_MAT,P_PAINEL'
,p_attribute_03=>'P714_ITEM_VALIDACAO,P714_OK,P714_MENSAGEM,P714_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583341262089413916)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>285
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_SIT_REQ'
,p_condition_element=>'P714_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P714_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583341756633413916)
,p_event_id=>wwv_flow_api.id(168583341262089413916)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583342259444413916)
,p_event_id=>wwv_flow_api.id(168583341262089413916)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583342795579413916)
,p_event_id=>wwv_flow_api.id(168583341262089413916)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583343321948413916)
,p_event_id=>wwv_flow_api.id(168583341262089413916)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583343649497413916)
,p_name=>'Hide Hora_Batida_Abono'
,p_event_sequence=>295
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_APAGAR_MARCACAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163388559589827273743)
,p_event_id=>wwv_flow_api.id(168583343649497413916)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA_ABONO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583345107822413919)
,p_name=>unistr('Aprova\00E7\00E3o - Dialog Closed')
,p_event_sequence=>305
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(168583285808151413874)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167236560343517650224)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cUser IS',
'    SELECT COUNT(1)',
'      FROM usuario_oracle uo',
'     WHERE uo.nm_usuario_oracle = :APP_USER',
'       AND NOT EXISTS ( SELECT 1 ',
'                          FROM pe_perfil_abono_geral pe ',
'                         WHERE uo.cd_perfil  = pe.cd_perfil',
'                           AND uo.cd_empresa = pe.cod_empresa',
'                           AND pe.bloqueia   = ''S'' );',
'  --',
'  CURSOR cReq IS',
'    SELECT r.*',
'      FROM pe_req_tratamento_batimentos r',
'     WHERE r.cod_req = :P714_COD_REQ;',
'  --',
'  rReq    cReq%ROWTYPE;',
'  --',
'  vCount    NUMBER DEFAULT 0;',
'BEGIN',
'  OPEN cUser;',
'  FETCH cUser INTO vCount;',
'  CLOSE cUser;',
'  --',
'  IF vCount > 0 THEN',
'    OPEN cReq;',
'    FETCH cReq INTO rReq;',
'    CLOSE cReq;',
'    --',
'    IF rReq.cod_sit_req = 2 AND rReq.apagar_marcacao = ''S'' AND rReq.posicao_envio IS NULL AND rReq.hora_batida IS NOT NULL THEN ',
'      PKG_PE_ABONO.prc_RetrocedeTodasPos(pEmpresa   => rReq.cod_empresa   --:P714_EMP',
'                                        ,pmatricula => rReq.matricula     --:P714_MAT',
'                                        ,pDataPonto => rReq.data_ponto    --:P714_DATA',
'                                        ,pPosicao   => rReq.posicao       --:P714_POSICAO_X',
'                                        ,pUser      => :P_USUARIO);       --:APP_USER); ',
'    END IF;                                      ',
'  END IF; ',
'EXCEPTION',
'  WHEN OTHERS THEN',
unistr('    RAISE_APPLICATION_ERROR(-20931, ''ERRO [APROV.] RETROCEDER POSI\00C7\00D5ES: ''||SQLERRM);'),
'END;'))
,p_attribute_02=>'P714_APAGAR_MARCACAO,P714_ENVIAR_MARCACAO,P714_HORA_BATIDA,P714_POSICAO_ENV,P714_COD_REQ,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO_X'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167236560500267650225)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  pTypeAUX    PKG_PE_ABONO.typ_TabTratBat;',
'  --',
'  CURSOR cUser IS',
'    SELECT COUNT(1)',
'      FROM usuario_oracle uo',
'     WHERE uo.nm_usuario_oracle = :P_USUARIO --:APP_USER',
'       AND NOT EXISTS ( SELECT 1 ',
'                          FROM pe_perfil_abono_geral pe ',
'                         WHERE uo.cd_perfil  = pe.cd_perfil',
'                           AND uo.cd_empresa = pe.cod_empresa',
'                           AND pe.bloqueia   = ''S'' );',
'  --',
'  CURSOR cReq IS',
'    SELECT r.*',
'      FROM pe_req_tratamento_batimentos r',
'     WHERE r.cod_req = :P714_COD_REQ;',
'  --',
'  rReq    cReq%ROWTYPE;',
'  --',
'  vCount    NUMBER DEFAULT 0;',
'BEGIN',
'  OPEN cUser;',
'  FETCH cUser INTO vCount;',
'  CLOSE cUser;',
'  --',
'  IF vCount > 0 THEN',
'    OPEN cReq;',
'    FETCH cReq INTO rReq;',
'    CLOSE cReq;',
'    --',
'    IF rReq.cod_sit_req = 2 AND rReq.apagar_marcacao = ''S'' AND rReq.posicao_envio IS NOT NULL AND rReq.hora_batida IS NOT NULL THEN',
'      pTypeAUX.DELETE;',
'      --',
'      IF NOT APEX_COLLECTION.collection_exists(''TRAT_BATIMENTOS'') THEN',
'        APEX_COLLECTION.create_collection(''TRAT_BATIMENTOS'');',
'      ELSE',
'        APEX_COLLECTION.truncate_collection(''TRAT_BATIMENTOS'');',
'      END IF;',
'      --',
'      PKG_PE_ABONO.prc_CarregaBatimentoAtual(pEmpresa   => rReq.cod_empresa --:P714_EMP',
'                                            ,pmatricula => rReq.matricula   --:P714_MAT',
'                                            ,pDataPonto => rReq.data_ponto  --:P714_DATA',
'                                            ,pType      => pTypeAUX);',
'      --',
'      IF pTypeAUX.COUNT > 0 THEN',
'        PKG_PE_ABONO.prc_AvancaRetrocedePosicao(pEmpresa     => rReq.cod_empresa   --:P714_EMP',
'                                               ,pmatricula   => rReq.matricula     --:P714_MAT',
'                                               ,pDataPonto   => rReq.data_ponto    --:P714_DATA',
'                                               ,pPosicaoDe   => rReq.posicao       --:P714_POSICAO_X',
'                                               ,pPosicaoPara => rReq.posicao_envio --:P714_POSICAO_ENV',
'                                               ,pUser        => :P_USUARIO         --:APP_USER',
'                                               ,pType        => pTypeAUX); ',
'        --',
'        pkg_pe_abono.prc_deleta_batida(rReq.cod_empresa, rReq.matricula, rReq.data_ponto, rReq.posicao, rReq.usuario, null, :P714_COD_REQ);',
'      END IF;                                 ',
'    END IF;                                      ',
'  END IF; ',
'EXCEPTION',
'  WHEN OTHERS THEN',
unistr('    RAISE_APPLICATION_ERROR(-20931, ''ERRO [APROV.] AVAN\00C7AR | RETROCEDER POSI\00C7\00D5ES: ''||SQLERRM);'),
'END;'))
,p_attribute_02=>'P714_APAGAR_MARCACAO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(152711636183254907541)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    CURSOR req_abono IS',
'        SELECT *',
'        FROM pe_req_tratamento_batimentos',
'        WHERE cod_req = :P714_cod_req;',
'',
'    v_req_abono req_abono%ROWTYPE;',
'    v_flg_retorno varchar2(3);',
'    v_msg_retorno varchar2(4000);',
'    n_trata number := 0;',
'',
'    v_erro varchar2(4000);',
'',
'begin',
'    OPEN  req_abono;',
'    FETCH req_abono INTO v_req_abono;',
'    CLOSE req_abono;',
'-->> MSS 20231018',
'  IF v_req_abono.cod_sit_req = 2 THEN',
'--<<  ',
'    if nvl(v_req_abono.apagar_marcacao,''N'') = ''S'' and v_req_abono.posicao_envio is not null and v_req_abono.hora_batida_abono is not null then',
'        begin',
'            n_trata := Func_Pe_Contador(''PE_TRATAMENTO_BATIMENTOS'');',
'',
'            INSERT INTO PE_TRATAMENTO_BATIMENTOS (COD_EMPRESA,',
'                COD_HIST_BAT,',
'                MATRICULA,',
'                DATA_PONTO,',
'                HORA_BATIDA,',
'                COD_TRAT_BAT,',
'                FOI_TRATADO,',
'                DATA_PROCESSAMENTO,',
'                FOI_APURADO,',
'                COD_FUNC_OCORR,',
'                COD_OCORR,',
'                COD_JUSTIFICATIVA,',
'                POSICAO,',
'                VIRA_DIA,',
'                COD_IMPORTACAO,',
'                Usuario,',
'                dt_atualizacao,',
'                HORA_BATIDA_ABONO,',
'                ORIGEM,',
'                ORIGEM_IMP)',
'            VALUES (v_req_abono.cod_empresa,',
'                null,',
'                v_req_abono.matricula,',
'                v_req_abono.data_ponto,',
'                v_req_abono.data_ponto,',
'                n_trata,',
'                0,',
'                SYSDATE,',
'                0,',
'                NULL,',
'                NULL,',
'                NULL,',
'                NVL(v_req_abono.posicao,0), -- # retirar nvl',
'                null,',
'                0,',
'                v_req_abono.usuario,',
'                sysdate,',
'                v_req_abono.hora_batida_abono,',
'                ''A'',',
'                ''ABONO'');',
'           exception',
'        when others then',
'            v_msg_retorno := sqlerrm;',
'            :p714_ok       := ''N'';',
'            :p714_flag     := v_flg_retorno;',
'            :p714_mensagem := v_msg_retorno;',
'        end;',
'    end if;',
'  END IF;    -->> MSS 20231018',
'end;'))
,p_attribute_02=>'P714_COD_REQ'
,p_attribute_03=>'P714_OK,P714_FLAG,P714_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(158564629253789150753)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_aprovador        APROVA_ABONO.MAT_APROV%type;    ',
'    V_flg_retorno      varchar2(1);',
'    V_msg_retorno      varchar2(4000);',
'begin',
'    begin',
'        SELECT AF.MAT_APROV',
'            into v_aprovador',
'        FROM   APROVA_ABONO af',
'        WHERE  (EXISTS (SELECT DISTINCT 1',
'        FROM   PE_REQ_TRATAMENTO_BATIMENTOS  RF',
'              ,INFORMACOES_FUNCIONAIS_CAD IFF',
'        WHERE  (EXISTS (SELECT 1',
'                       FROM   SUB_CCUSTO SC',
'                       WHERE  SC.MAT_SUBS = :P_MATRICULA_USER',
'                       AND    SC.COD_EMP_SUBS = :P_EMPRESA_USER',
'                       AND    SC.MAT_GESTOR     = AF.MAT_APROV',
'                       AND    SC.COD_EMP_GESTOR = AF.COD_EMP_APROV',
'                       AND    SC.COD_SUB_CCUSTO = IFF.COD_SUB_CCUSTO',
'                       AND    SC.COD_CCUSTO     = IFF.COD_CCUSTO',
'                       AND    SC.COD_EMPRESA    = IFF.COD_EMPRESA)',
'        OR     EXISTS (SELECT 1',
'                       FROM   CENTRO_DE_CUSTO CC',
'                       WHERE  CC.MATRICULA_SUPLENTE = :P_MATRICULA_USER',
'                       AND    CC.COD_EMP_SUPLENTE = :P_EMPRESA_USER',
'                       AND    CC.MATRICULA_GESTOR = AF.MAT_APROV',
'                       AND    CC.COD_EMP_GESTOR = AF.COD_EMP_APROV',
'                       AND    CC.COD = IFF.COD_CCUSTO',
'                       AND    CC.COD_EMPRESA = IFF.COD_EMPRESA)',
'        OR     EXISTS (SELECT 1',
'                      FROM   PE_REQ_APURACAO RF2',
'                            ,INFORMACOES_FUNCIONAIS_CAD IFF2',
'                            ,CENTRO_DE_CUSTO CC2',
'                            ,CENTRO_DE_CUSTO CCS',
'                      WHERE  CCS.MATRICULA_SUPLENTE = :P_MATRICULA_USER',
'                      AND    CCS.COD_EMP_SUPLENTE   = :P_EMPRESA_USER',
'                      AND    CCS.COD                = CC2.COD_CCUSTO_SUPERIOR',
'                      AND    CCS.COD_EMPRESA        = CC2.COD_EMPRESA',
'                      AND    CC2.MATRICULA_GESTOR   = RF2.MATRICULA',
'                      AND    CC2.COD_EMP_GESTOR     = RF2.COD_EMPRESA',
'                      AND    CC2.COD                = IFF2.COD_CCUSTO',
'                      AND    CC2.COD_EMPRESA        = IFF2.COD_EMPRESA',
'                      AND    IFF2.MATRICULA         = RF2.MATRICULA',
'                      AND    IFF2.COD_EMPRESA       = RF2.COD_EMPRESA',
'                      AND    RF2.COD_REQ    =  :P714_COD_REQ',
'                      )',
'                       )',
'        AND    IFF.MATRICULA = RF.MATRICULA',
'        AND    IFF.COD_EMPRESA = RF.COD_EMPRESA',
'        AND    RF.COD_REQ = :P714_COD_REQ)',
'        OR     (af.mat_aprov     = :P_MATRICULA_USER',
'        AND    af.cod_emp_aprov = :P_EMPRESA_USER))',
'        AND    af.status_aprov = ''P''',
'        AND    af.COD_SOLICITACAO  = :P714_COD_REQ',
'        AND    af.cod_empresa   = :P_EMPRESA_USER        ; ',
'   exception',
'       when others then',
'          v_aprovador := null;',
'   end;    ',
'   -- ',
'   begin',
'        update aprova_abono',
'        set status_aprov     = ''A''',
'        , dt_aprov         = sysdate',
'            where cod_empresa    = nvl( :P714_EMP , :P_EMPRESA_USER )',
'            and cod_solicitacao  = :P714_COD_REQ',
'            and cod_emp_aprov    = :P_EMPRESA_USER',
'            and mat_aprov        = nvl(v_aprovador, :P_MATRICULA_USER);',
'',
'            commit;',
'   exception',
'        when others then',
'            V_msg_retorno := SQLERRM;',
'   end; ',
'   PRC_ATUALIZA_REQ(pcod_empresa   => nvl( :P714_EMP, :P_EMPRESA_USER),psolicitacao  => :P714_COD_REQ,pflg_retorno  => V_flg_retorno,pmsg_retorno  => V_msg_retorno);',
'',
'end;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583345571667413919)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583346055550413922)
,p_event_id=>wwv_flow_api.id(168583345107822413919)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583346525860413923)
,p_name=>unistr('Reprova\00E7\00E3o - Dialog Closed')
,p_event_sequence=>315
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(168583286543339413875)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583346951120413923)
,p_event_id=>wwv_flow_api.id(168583346525860413923)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583347483648413923)
,p_event_id=>wwv_flow_api.id(168583346525860413923)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583347911515413923)
,p_name=>unistr('(Situa\00E7\00E3o) Show Aprova\00E7\00E3o')
,p_event_sequence=>325
,p_condition_element=>'P714_COD_SIT_REQ'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583348364111413924)
,p_event_id=>wwv_flow_api.id(168583347911515413923)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583348840768413924)
,p_event_id=>wwv_flow_api.id(168583347911515413923)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583349420674413924)
,p_event_id=>wwv_flow_api.id(168583347911515413923)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583349900179413925)
,p_event_id=>wwv_flow_api.id(168583347911515413923)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583350325627413925)
,p_name=>'Show/Hide Save'
,p_event_sequence=>335
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_FLAG'
,p_condition_element=>'P714_FLAG'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583350748740413925)
,p_event_id=>wwv_flow_api.id(168583350325627413925)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583258340751413835)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583351266376413925)
,p_event_id=>wwv_flow_api.id(168583350325627413925)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583258340751413835)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583351630761413926)
,p_name=>'DisparaAlerta'
,p_event_sequence=>345
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MSG_CLOSE'
,p_condition_element=>'P714_MSG_CLOSE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583352036624413926)
,p_event_id=>wwv_flow_api.id(168583351630761413926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P714_MSG_CLOSE" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P714_MSG_CLOSE" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583352465304413926)
,p_name=>'Inicia Alertify'
,p_event_sequence=>355
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MSG_CLOSE'
,p_condition_element=>'P714_MSG_CLOSE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583352965529413926)
,p_event_id=>wwv_flow_api.id(168583352465304413926)
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
 p_id=>wwv_flow_api.id(168583353385736413926)
,p_name=>unistr('Verifica Per\00EDodo | Limite Abono | Bloqueio')
,p_event_sequence=>365
,p_condition_element=>'P714_VALIDA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583353902681413926)
,p_event_id=>wwv_flow_api.id(168583353385736413926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Verifica Per\00EDodo | Limite Abono'),
'DECLARE',
'  vReturn    VARCHAR2(550) DEFAULT NULL;',
'  --',
'  vMsg    VARCHAR2(550) DEFAULT NULL;',
'  --',
'  CURSOR cBloqueio IS',
'    SELECT COUNT(1)',
'      FROM usuario_oracle o',
'     WHERE o.nm_usuario_oracle = :P_USUARIO --:APP_USER',
'       AND EXISTS(SELECT 1',
'                    FROM pe_perfil_abono_geral p',
'                   WHERE p.cd_perfil   = o.cd_perfil',
'                     AND p.cod_empresa = o.cd_empresa',
'                     AND p.bloqueia    = ''S'');',
'  --',
'  vCont    NUMBER DEFAULT 0;',
'BEGIN',
'    NULL;',
'    /*',
'  :P714_MSG_CLOSE  := NULL;',
'  :P714_CLOSE_PAGE := NULL;',
'  --',
'  OPEN cBloqueio;',
'  FETCH cBloqueio INTO vCont;',
'  CLOSE cBloqueio;',
'  --',
'  IF vCont = 0 THEN',
'    IF :P714_EMP IS NOT NULL AND (:P714_DTINI_MARCACAO IS NOT NULL OR :P714_DATA IS NOT NULL) THEN',
'      vMsg := PKG_PE_ABONO.fnc_ValPeriodoAbonoPainel(pEmpresa   => :P714_EMP',
'                                                    ,pUser      => :P_USUARIO --:APP_USER',
'                                                    ,pPainel    => :P_PAINEL',
'                                                    ,pData      => TRUNC(SYSDATE)',
'                                                    ,pPerIniPto => NVL(:P714_DTINI_MARCACAO, :P714_DATA));',
'      --',
'      IF vMsg IS NOT NULL THEN',
unistr('        vReturn := ''<strong>Edi\00E7\00E3o N\00C3O Permitida!!</strong><br>'';'),
'        vReturn := vReturn||REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>''), ''- '');',
'        --',
'        :P714_MSG_CLOSE  := vReturn;',
'        :P714_CLOSE_PAGE := ''S'';',
'      ELSE',
'        IF :P714_EMP IS NOT NULL AND :P714_MAT IS NOT NULL THEN',
'          IF :P714_DTINI_ABONO IS NOT NULL AND :P714_DTFIM_ABONO IS NOT NULL THEN',
'            vMsg := PKG_PE_ABONO.fnc_ValLimiteAbono(pEmpresa   => :P714_EMP',
'                                                   ,pmatricula => :P714_MAT',
'                                                   ,pDataIni   => :P714_DTINI_ABONO',
'                                                   ,pDataFim   => :P714_DTFIM_ABONO',
'                                                   ,pUser      => :P_USUARIO --:APP_USER',
'                                                   ,pQtdAbono  => 1);',
'          ELSE',
'            vMsg := PKG_PE_ABONO.fnc_ValLimiteAbono(pEmpresa   => :P714_EMP',
'                                                   ,pmatricula => :P714_MAT',
'                                                   ,pDataIni   => :P714_DTINI_ABONO',
'                                                   ,pDataFim   => :P714_DTFIM_ABONO',
'                                                   ,pUser      => :P_USUARIO --:APP_USER',
'                                                   ,pQtdAbono  => 1',
'                                                   ,pDataAbono => :P714_DATA',
'                                                   ,pPainel    => :P_PAINEL);',
'          END IF;',
'          --',
'          IF vMsg IS NOT NULL THEN',
unistr('            vReturn := ''<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida!!</strong><br>'';'),
'            vReturn := vReturn||REPLACE(REPLACE(REPLACE(REPLACE(vMsg, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>''), ''- '');',
'            --',
'            :P714_MSG_CLOSE  := vReturn;',
'            :P714_CLOSE_PAGE := ''S'';',
'          END IF;',
'        END IF;  ',
'      END IF;',
'    END IF;',
'  ELSE',
unistr('    vReturn := ''<strong>Edi\00E7\00E3o N\00C3O Permitida!!</strong><br><i>.Perfil Bloqueado, permitido somente consulta</i>'';'),
'    --',
'    :P714_MSG_CLOSE  := vReturn;',
'    :P714_CLOSE_PAGE := ''S'';',
'  END IF; */',
'END;'))
,p_attribute_02=>'P714_EMP,P714_MSG_CLOSE,P714_CLOSE_PAGE,P714_DTINI_MARCACAO,P714_DATA'
,p_attribute_03=>'P714_MSG_CLOSE,P714_CLOSE_PAGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(61745481220224257089)
,p_name=>'Trava Abono'
,p_event_sequence=>375
,p_condition_element=>'P714_VALIDA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745481274377257090)
,p_event_id=>wwv_flow_api.id(61745481220224257089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vReturn varchar2(2000);',
'begin',
'  vReturn := PKG_PE_ABONO.fnc_trava_abono(P_COD_EMPRESA => :P714_EMP,',
'                                          P_MATRICULA => :P714_MAT,',
'                                          P_DATA => :p714_data);',
'  if vReturn = ''S'' then',
unistr('    vReturn := ''<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida! Dia j\00E1 foi tratado!</strong><br>'';'),
'    --',
'    :P714_MSG_CLOSE  := vReturn;',
'    :P714_CLOSE_PAGE := ''S'';',
'  end if;',
'end;'))
,p_attribute_02=>'P714_EMP,P714_DATA,P714_MAT'
,p_attribute_03=>'P714_MSG_CLOSE,P714_CLOSE_PAGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(56474098820314724215)
,p_name=>'Tem Atestado'
,p_event_sequence=>385
,p_condition_element=>'P714_VALIDA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(56474098952978724216)
,p_event_id=>wwv_flow_api.id(56474098820314724215)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vReturn varchar2(2000);',
'begin',
'  vReturn := PKG_PE_ABONO.fnc_tem_atestado(P_COD_EMPRESA => :P714_EMP,',
'                                           P_MATRICULA => :P714_MAT,',
'                                           P_DATA => :p714_data);',
'  if vReturn = ''S'' then',
unistr('    vReturn := ''<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida! Funcion\00E1rio tem atestado!</strong><br>'';'),
'    --',
'    :P714_MSG_CLOSE  := vReturn;',
'    :P714_CLOSE_PAGE := ''S'';',
'  end if;',
'end;'))
,p_attribute_02=>'P714_EMP,P714_DATA,P714_MAT'
,p_attribute_03=>'P714_MSG_CLOSE,P714_CLOSE_PAGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583354264938413927)
,p_name=>'Disable Page'
,p_event_sequence=>395
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_CLOSE_PAGE'
,p_condition_element=>'P714_CLOSE_PAGE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745480531467257082)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745480621301257083)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(147101556381254273353)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745481024224257087)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(147101556381254273353)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745480807893257085)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745480700418257084)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#MARCACAO *'').prop(''disabled'',true);'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61745481137607257088)
,p_event_id=>wwv_flow_api.id(168583354264938413927)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#MARCACAO *'').prop(''enabled'',true);'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583355671993413928)
,p_name=>unistr('Desabilita Marca\00E7\00E3o')
,p_event_sequence=>405
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(315761013405450458304)
,p_condition_element=>'P714_CLOSE_PAGE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583356216338413930)
,p_event_id=>wwv_flow_api.id(168583355671993413928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#MARC'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583356580766413930)
,p_name=>'Desabilita Justificativa'
,p_event_sequence=>415
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(315761018948240458311)
,p_condition_element=>'P714_CLOSE_PAGE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583357051853413930)
,p_event_id=>wwv_flow_api.id(168583356580766413930)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#JUST'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583357479894413930)
,p_name=>'Desabilita Aprovadores'
,p_event_sequence=>425
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(315761020551937458313)
,p_condition_element=>'P714_CLOSE_PAGE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583358005867413931)
,p_event_id=>wwv_flow_api.id(168583357479894413930)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#APRV'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583358339211413931)
,p_name=>'Hide Show Itens'
,p_event_sequence=>435
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_JUSTIFICATIVA'
,p_condition_element=>'P714_COD_JUSTIFICATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P714_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583358898768413931)
,p_event_id=>wwv_flow_api.id(168583358339211413931)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583359366077413931)
,p_event_id=>wwv_flow_api.id(168583358339211413931)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583359851767413931)
,p_event_id=>wwv_flow_api.id(168583358339211413931)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583360291253413931)
,p_name=>'Set Valores Itens'
,p_event_sequence=>445
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_JUSTIFICATIVA'
,p_condition_element=>'P714_COD_JUSTIFICATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P714_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583360765112413932)
,p_event_id=>wwv_flow_api.id(168583360291253413931)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vDataF DATE   DEFAULT NULL;',
'  vDias  NUMBER DEFAULT NULL;',
'BEGIN',
'  IF :P714_DATA IS NOT NULL THEN',
'    :P714_DT_INI_VAL_JUST := :P714_DATA;',
'    --',
'    IF :P714_NUM_DIAS_JUST IS NULL THEN',
'      vDias := 1;',
'    ELSE',
'      vDias := :P714_NUM_DIAS_JUST;',
'    END IF;',
'    --',
'    IF :P714_NUM_DIAS_JUST IS NULL OR :P714_NUM_DIAS_JUST <> vDias THEN',
'      :P714_NUM_DIAS_JUST := vDias;',
'    END IF;',
'    --',
'    vDataF := TO_DATE(:P714_DATA) + (vDias - 1);',
'    --',
'    IF :P714_DT_FIM_VAL_JUST IS NULL OR :P714_DT_FIM_VAL_JUST <> vDataF THEN',
'      :P714_DT_FIM_VAL_JUST := vDataF;',
'    END IF;',
'  END IF;',
'END;'))
,p_attribute_02=>'P714_DATA,P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
,p_attribute_03=>'P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583361154228413932)
,p_name=>'Set Dt Fim Validade'
,p_event_sequence=>455
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_NUM_DIAS_JUST'
,p_condition_element=>'P714_NUM_DIAS_JUST'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P714_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583361698220413932)
,p_event_id=>wwv_flow_api.id(168583361154228413932)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vDataF DATE   DEFAULT NULL;',
'BEGIN',
'  IF :P714_DATA IS NOT NULL THEN',
'    IF :P714_DT_INI_VAL_JUST IS NOT NULL THEN',
'      IF :P714_NUM_DIAS_JUST > 0 THEN',
'        vDataF := TO_DATE(:P714_DT_INI_VAL_JUST) + (:P714_NUM_DIAS_JUST - 1);',
'        --',
'        IF :P714_DT_FIM_VAL_JUST IS NULL OR :P714_DT_FIM_VAL_JUST <> vDataF THEN',
'          :P714_DT_FIM_VAL_JUST := vDataF;',
'        END IF;',
'      ELSE',
'        :P714_DT_FIM_VAL_JUST := NULL;',
'      END IF;',
'    END IF;  ',
'  END IF;',
'END;'))
,p_attribute_02=>'P714_DATA,P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
,p_attribute_03=>'P714_DT_FIM_VAL_JUST'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583311336265413897)
,p_name=>'Set Num. Dias'
,p_event_sequence=>465
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_DT_FIM_VAL_JUST'
,p_condition_element=>'P714_DT_FIM_VAL_JUST'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P714_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583311909700413897)
,p_event_id=>wwv_flow_api.id(168583311336265413897)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vDias  NUMBER DEFAULT NULL;',
'BEGIN',
'  IF :P714_DATA IS NOT NULL THEN',
'    IF :P714_NUM_DIAS_JUST IS NOT NULL THEN',
'      vDias := TO_DATE(:P714_DT_FIM_VAL_JUST)  - TO_DATE(:P714_DT_INI_VAL_JUST); ',
'      --',
'      IF :P714_NUM_DIAS_JUST IS NULL OR :P714_NUM_DIAS_JUST <> vDias THEN',
'        :P714_NUM_DIAS_JUST := vDias + 1;',
'      END IF;',
'    END IF;  ',
'  END IF;',
'END;'))
,p_attribute_02=>'P714_DATA,P714_NUM_DIAS_JUST,P714_DT_INI_VAL_JUST,P714_DT_FIM_VAL_JUST'
,p_attribute_03=>'P714_NUM_DIAS_JUST'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583312431793413898)
,p_event_id=>wwv_flow_api.id(168583311336265413897)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_NUM_DIAS_JUST'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583300156805413884)
,p_name=>unistr('Habilita Desabilta Posi\00E7\00E3o Env')
,p_event_sequence=>475
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_ENVIAR_MARCACAO'
,p_condition_element=>'P714_ENVIAR_MARCACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583300664108413885)
,p_event_id=>wwv_flow_api.id(168583300156805413884)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSICAO_ENV'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583301172282413885)
,p_event_id=>wwv_flow_api.id(168583300156805413884)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSICAO_ENV'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583301706638413889)
,p_event_id=>wwv_flow_api.id(168583300156805413884)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSICAO_ENV,P714_POSENV_AR'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583302169005413889)
,p_event_id=>wwv_flow_api.id(168583300156805413884)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVMARC'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583302675938413889)
,p_event_id=>wwv_flow_api.id(168583300156805413884)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVMARC'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583303065195413890)
,p_name=>unistr('Verifia Posicao Avan\00E7ar Retoroceder')
,p_event_sequence=>485
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSICAO_ENV'
,p_condition_element=>'P714_POSICAO_ENV'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583303607703413891)
,p_event_id=>wwv_flow_api.id(168583303065195413890)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vRet    VARCHAR2(1) DEFAULT NULL;',
'BEGIN',
'  :P714_POSENV_AR := NULL;',
'  --',
'  IF :P714_POSICAO IS NOT NULL THEN',
'    IF :P714_POSICAO_ENV IS NOT NULL THEN',
'      IF TO_NUMBER(:P714_POSICAO_ENV) > TO_NUMBER(:P714_POSICAO) THEN',
'        IF TO_NUMBER(:P714_POSICAO_ENV) <= 10 THEN',
'          :P714_POSENV_AR := ''A'';',
'        END IF;',
'      ELSIF TO_NUMBER(:P714_POSICAO_ENV) < TO_NUMBER(:P714_POSICAO) THEN',
'        IF TO_NUMBER(:P714_POSICAO_ENV) >= 1 THEN',
'          :P714_POSENV_AR := ''R'';',
'        END IF;',
'      END IF;',
'      --',
'      :P714_POSICAO_ENVIO := TO_NUMBER(:P714_POSICAO_ENV);',
'    ELSE',
'      :P714_POSICAO_ENVIO := NULL;',
'    END IF;',
'  END IF;',
'  --',
'  IF :P714_POSENV_AR = ''R'' THEN',
'    vRet := PKG_PE_ABONO.fnc_VerifPosRetracao(pEmpresa   => :P714_EMP',
'                                             ,pmatricula => :P714_MAT',
'                                             ,pDataPonto => :P714_DATA',
'                                             ,pPosLimt   => :P714_POSICAO_ENV);',
'     --',
'     IF vRet = ''N'' THEN',
'       :P714_POSENV_AR := ''X'';',
'     ELSIF vRet IS NULL THEN',
'       :P714_POSENV_AR := ''?'';',
'     END IF;                                      ',
'  END IF;',
'END;'))
,p_attribute_02=>'P714_POSICAO,P714_POSICAO_ENV,P714_POSENV_AR,P714_EMP,P714_MAT,P714_DATA,P714_POSICAO_ENVIO'
,p_attribute_03=>'P714_POSENV_AR,P714_POSICAO_ENVIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583304086402413891)
,p_event_id=>wwv_flow_api.id(168583303065195413890)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSENV_AR,P714_POSICAO_ENVIO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583304527555413891)
,p_name=>unistr('Alerta Avan\00E7ar')
,p_event_sequence=>495
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSENV_AR'
,p_condition_element=>'P714_POSENV_AR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'A'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583304952997413892)
,p_event_id=>wwv_flow_api.id(168583304527555413891)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('As posi\00E7\00F5es <i>subsequentes</i> ser\00E3o <strong>avan\00E7adas</strong>!')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583305338982413892)
,p_name=>'Alerta Retroceder'
,p_event_sequence=>505
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSENV_AR'
,p_condition_element=>'P714_POSENV_AR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'R'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583305862992413892)
,p_event_id=>wwv_flow_api.id(168583305338982413892)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('As posi\00E7\00F5es <i>antecedentes</i> ser\00E3o <strong>retrocedidas</strong>!')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583306293421413892)
,p_name=>unistr('Alerta N\00C3O Retroceder')
,p_event_sequence=>515
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSENV_AR'
,p_condition_element=>'P714_POSENV_AR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583306734961413892)
,p_event_id=>wwv_flow_api.id(168583306293421413892)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Retra\00E7\00E3o de posi\00E7\00E3o N\00C3O Permitida!!</strong><br><i>Exclua a posi\00E7\00E3o para realizar a retra\00E7\00E3o.</i>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583307324927413893)
,p_event_id=>wwv_flow_api.id(168583306293421413892)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSICAO_ENV'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583307727979413893)
,p_name=>'Alerta Retroceder Indefinido'
,p_event_sequence=>525
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_POSENV_AR'
,p_condition_element=>'P714_POSENV_AR'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'?'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583308146175413893)
,p_event_id=>wwv_flow_api.id(168583307727979413893)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>N\00E3o foi poss\00EDvel verificar as posi\00E7\00F5es para realizar a retra\00E7\00E3o!!</strong>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583308643329413894)
,p_event_id=>wwv_flow_api.id(168583307727979413893)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_POSICAO_ENV'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583309051761413896)
,p_name=>'Hide Show Itens ENV'
,p_event_sequence=>535
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_HORA_BATIDA'
,p_condition_element=>'P714_HORA_BATIDA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583309590622413896)
,p_event_id=>wwv_flow_api.id(168583309051761413896)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVIAR_MARCACAO,P714_POSICAO_ENV'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583310132444413897)
,p_event_id=>wwv_flow_api.id(168583309051761413896)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVIAR_MARCACAO,P714_POSICAO_ENV'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(168583310522672413897)
,p_name=>'Set Itens  XXX'
,p_event_sequence=>545
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_XXX'
,p_condition_element=>'P714_XXX'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(168583310973284413897)
,p_event_id=>wwv_flow_api.id(168583310522672413897)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA,P714_JORNADA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167236559617390650217)
,p_name=>unistr('Disable Enviar Marca\00E7\00E3o')
,p_event_sequence=>555
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_APAGAR_MARCACAO'
,p_condition_element=>'P714_APAGAR_MARCACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167236559785190650218)
,p_event_id=>wwv_flow_api.id(167236559617390650217)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVIAR_MARCACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167236559823290650219)
,p_event_id=>wwv_flow_api.id(167236559617390650217)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVIAR_MARCACAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167236559954438650220)
,p_event_id=>wwv_flow_api.id(167236559617390650217)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_ENVIAR_MARCACAO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166770280116750658275)
,p_name=>unistr('Valida Total de Requisi\00E7\00F5es')
,p_event_sequence=>565
,p_condition_element=>'P714_COD_REQ'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166770280222654658276)
,p_event_id=>wwv_flow_api.id(166770280116750658275)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_data        varchar2(10);',
'    l_total       number := 0;  ',
'    l_limite      number := 0; ',
'begin',
'    NULL;',
'    /*',
'    if :P_PAINEL = ''PC'' then',
'        if :P714_DATA is null then',
'            l_data := substr(TRUNC(SYSDATE), 4);',
'        else    ',
'            l_data := substr(:P714_DATA, 4);',
'        end if;    ',
'        BEGIN',
'            SELECT nvl(a.quantidade_limite, 0)',
'            INTO l_limite',
'            FROM pe_perfil_abono_geral a',
'            WHERE a.cd_perfil = :P_PERFIL;',
'        EXCEPTION',
'           WHEN OTHERS THEN',
'              l_limite := 0;',
'        END;',
'        --',
'        select count(*) ',
'            into l_total',
'        from PE_REQ_TRATAMENTO_BATIMENTOS a',
'        where 1=1 ',
'        and matricula = :P714_MAT',
'        and cod_empresa = :P714_EMP',
'        and cod_sit_req in ( 1, 2, 4, 5 )    ',
'        and data_ponto >=  to_date(''01/''||l_data, ''dd/mm/yyyy'')',
'        and data_ponto <= last_day(to_date(''01''||l_data, ''dd/mm/yyyy''))',
'        and ( mat_req = ( select cd_matricula --nm_usuario_oracle ',
'                           from usuario_oracle uc',
'                           where cd_perfil = :P_PERFIL',
'                           and uc.cd_matricula = a.mat_req )',
'              or mat_req = ( select distinct matricula --nm_usuario_oracle ',
'                           from INFORMACOES_FUNCIONAIS uc',
'                           where 1=1 --cd_perfil = ''PORTAL_COLAB''',
'                           and matricula = a.mat_req ) ) ;',
'        --',
'        :P714_LIMITE := l_limite;',
'        if l_limite > 0 then',
'            if l_total >= l_limite then',
'                :P714_TOTAL_REQ := l_total;',
'            end if;',
'        end if;',
'    end if;',
'    */',
'end;'))
,p_attribute_02=>'P714_EMP,P714_MAT,P714_DATA'
,p_attribute_03=>'P714_TOTAL_REQ,P714_LIMITE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166770280584681658279)
,p_name=>'Fecha tela'
,p_event_sequence=>575
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_TOTAL_REQ'
,p_condition_element=>'P714_TOTAL_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166770281185652658285)
,p_event_id=>wwv_flow_api.id(166770280584681658279)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida!!</strong><br>Ultrapassado o limite de abonos de marca\00E7\00E3o no per\00EDodo informado!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(162754350184438501922)
,p_event_id=>wwv_flow_api.id(166770280584681658279)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163434641543213203713)
,p_name=>'Oculta horas abono'
,p_event_sequence=>585
,p_condition_element=>'P714_TEM_REQ'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434641659526203714)
,p_event_id=>wwv_flow_api.id(163434641543213203713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA_ABONO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434642336555203720)
,p_event_id=>wwv_flow_api.id(163434641543213203713)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA_ABONO_DSP'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434641783327203715)
,p_event_id=>wwv_flow_api.id(163434641543213203713)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA_ABONO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434642233805203719)
,p_event_id=>wwv_flow_api.id(163434641543213203713)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_HORA_BATIDA_ABONO_DSP'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163434641861676203716)
,p_name=>unistr('Verifica total de requisi\00E7\00F5es')
,p_event_sequence=>595
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_NUM_DIAS_JUST'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434642003773203717)
,p_event_id=>wwv_flow_api.id(163434641861676203716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    l_total       number := 0;  ',
'    l_limite      number := 0; ',
'begin',
'    begin',
'        SELECT nvl(a.quantidade_limite, 1)',
'            INTO l_limite',
'        FROM pe_perfil_abono_geral a',
'            WHERE a.cd_perfil = :P_PERFIL',
'            AND a.cod_empresa = :P714_EMP;',
'    exception',
'        when others then',
'            l_limite := -1;',
'    end;',
'    --',
'    if l_limite != -1 then',
'        select count(*) + :P714_NUM_DIAS_JUST',
'            into l_total',
'        from PE_REQ_TRATAMENTO_BATIMENTOS a',
'        where 1=1 ',
'        and matricula = :P714_MAT',
'        and cod_empresa = :P714_EMP',
'        and cod_sit_req in ( 1, 2, 4, 5 )    ',
'        and data_ponto >=  to_date(''01/''||substr(:P714_DATA, 4), ''dd/mm/yyyy'')',
'        and data_ponto <= last_day(to_date(''01''||substr(:P714_DATA, 4), ''dd/mm/yyyy''))',
'        and ( mat_req = ( select cd_matricula --nm_usuario_oracle ',
'                           from usuario_oracle uc',
'                           where cd_perfil = :P_PERFIL',
'                           and uc.cd_matricula = a.mat_req )',
'              or mat_req = ( select distinct matricula --nm_usuario_oracle ',
'                           from INFORMACOES_FUNCIONAIS uc',
'                           where 1=1 --cd_perfil = ''PORTAL_COLAB''',
'                           and matricula = a.mat_req ) ) ;',
'        --',
'        :P714_LIMITE := l_limite;',
'        l_limite := 5;',
'        --',
'        if l_total >= l_limite then',
'            begin',
'',
'                select quantidade_limite ',
'                    into :P714_NUM_DIAS_JUST',
'                from  pe_perfil_abono_geral',
'                where cod_empresa = :P714_EMP',
'                and cd_perfil = :P_PERFIL;',
'',
'            exception',
'                when others then',
'                    :P714_NUM_DIAS_JUST := 1;',
'            end;   ',
'        end if;',
'    end if;',
'    --',
'end;',
''))
,p_attribute_02=>'P714_MAT,P714_EMP,P714_DATA'
,p_attribute_03=>'P714_NUM_DIAS_JUST'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163434642527137203722)
,p_name=>'New'
,p_event_sequence=>605
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_VALIDA_TOTAL_NUM_DIAS'
,p_condition_element=>'P714_VALIDA_TOTAL_NUM_DIAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434642578622203723)
,p_event_id=>wwv_flow_api.id(163434642527137203722)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    select quantidade_limite ',
'        into :P714_NUM_DIAS_JUST',
'    from  pe_perfil_abono_geral',
'    where cod_empresa = :P714_EMP',
'    and cd_perfil = :P_PERFIL;',
'',
'exception',
'    when others then',
'        :P714_NUM_DIAS_JUST := 1;',
'end;    ',
''))
,p_attribute_02=>'P714_EMP'
,p_attribute_03=>'P714_NUM_DIAS_JUST'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163434642735172203724)
,p_event_id=>wwv_flow_api.id(163434642527137203722)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('N\00FAmero de requisi\00E7\00F5es excedeu ao limite permitido')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(162754350011951501920)
,p_name=>unistr('Valida total de requisi\00E7\00F5es')
,p_event_sequence=>615
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_JUSTIFICATIVA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(162754350117359501921)
,p_event_id=>wwv_flow_api.id(162754350011951501920)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    l_total       number := 0;  ',
'    l_limite      number := 0; ',
'begin',
'NULL;',
'/*',
'    if nvl( :P714_APAGAR_MARCACAO, ''N'') = ''N'' then',
'        if :P_PAINEL = ''PC'' then        ',
'            begin',
'            SELECT nvl(a.quantidade_limite, 0)',
'            INTO l_limite',
'            FROM pe_perfil_abono_geral a',
'            WHERE a.cd_perfil = :P_PERFIL;',
'            exception',
'                when others then',
'                    l_limite := 0;',
'            end;',
'            --',
'            if l_limite > 0 then',
'                select count(*) ',
'                    into l_total',
'                from PE_REQ_TRATAMENTO_BATIMENTOS a',
'                where 1=1 ',
'                and matricula = :P714_MAT',
'                and cod_empresa = :P714_EMP',
'                and cod_sit_req in ( 1, 2, 4, 5 )    ',
'                and data_ponto >=  to_date(''01/''||substr(:P714_DATA, 4), ''dd/mm/yyyy'')',
'                and data_ponto <= last_day(to_date(''01''||substr(:P714_DATA, 4), ''dd/mm/yyyy''))',
'                and ( mat_req = ( select cd_matricula --nm_usuario_oracle ',
'                                   from usuario_oracle uc',
'                                   where cd_perfil = :P_PERFIL',
'                                   and uc.cd_matricula = a.mat_req )',
'                      or mat_req = ( select distinct matricula ',
'                                   from INFORMACOES_FUNCIONAIS uc',
'                                   where  matricula = a.mat_req ) ) ;',
'                --',
'                :P714_LIMITE := l_limite;',
'                if l_total >= l_limite then',
'                    :P714_TOTAL_REQ := l_total;',
'                end if;',
'            end if;',
'        end if;',
'    end if; ',
'    */',
'end;'))
,p_attribute_02=>'P714_MAT,P714_EMP,P714_DATA,P714_APAGAR_MARCACAO'
,p_attribute_03=>'P714_LIMITE,P714_TOTAL_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(157668102138566185949)
,p_name=>unistr('Valida se tem Requisi\00E7\00E3o Apura\00E7\00E3o')
,p_event_sequence=>625
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(157668102209931185950)
,p_event_id=>wwv_flow_api.id(157668102138566185949)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    CURSOR creq IS ',
'         SELECT COUNT(f.matricula)  as contador',
'            FROM  PE_REQ_APURACAO f,',
'                  aprova_apuracao a',
'        WHERE f.COD_EMPRESA = :P714_EMP',
'        AND f.MATRICULA = :P714_MAT',
'        AND a.cod_empresa = f.cod_empresa',
'        AND a.cod_solicitacao = f.cod_req                ',
'        AND f.DATA_PONTO = TO_DATE(:P714_DATA, ''DD/MM/YYYY'')',
'        AND f.COD_SIT_REQ not in ( 2, 3, 4);',
'    r_req creq%ROWTYPE;        ',
'',
'begin',
'    if :P714_CONSULTA != ''C'' then',
'        :P714_CHECAR_APURACAO := NULL;    ',
'        OPEN creq;',
'        FETCH creq INTO r_req;',
'        CLOSE creq;',
'',
'        IF r_req.contador > 0 OR r_req.contador IS NULL THEN',
'            :P714_CHECAR_APURACAO := r_req.contador;',
'        ELSE',
'            :P714_CHECAR_APURACAO := NULL;    ',
'        END IF;',
'    end if;',
'exception',
'    when others then',
'        :P714_CHECAR_APURACAO := NULL;',
'end;'))
,p_attribute_02=>'P714_EMP,P714_MAT,P714_CONSULTA'
,p_attribute_03=>'P714_CHECAR_APURACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(157668102442873185952)
,p_name=>'Mostra Mensagem Quando Tem Req Apura'
,p_event_sequence=>635
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_CHECAR_APURACAO'
,p_condition_element=>'P714_CHECAR_APURACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(157668102544026185953)
,p_event_id=>wwv_flow_api.id(157668102442873185952)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Colaborador tem requisi\00E7\00E3o de apura\00E7\00E3o para a data de ponto')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(157668102660007185954)
,p_event_id=>wwv_flow_api.id(157668102442873185952)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(148430961346389209258)
,p_name=>'Exibe mensagem de cancelamento'
,p_event_sequence=>645
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MUDA_COD_SIT_REQ'
,p_condition_element=>'P714_MUDA_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148430961432208209259)
,p_event_id=>wwv_flow_api.id(148430961346389209258)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Somente o usu\00E1rio solocitante pode cancelar a requisi\00E7\00E3o')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148430961493635209260)
,p_event_id=>wwv_flow_api.id(148430961346389209258)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147101556528851273355)
,p_name=>unistr('Exibe bot\00E3o cancelar')
,p_event_sequence=>655
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_OPERADOR_DELETA'
,p_condition_element=>'P714_OPERADOR_DELETA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147101556635574273356)
,p_event_id=>wwv_flow_api.id(147101556528851273355)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'alert(''ok'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147101557196343273361)
,p_name=>'Operador cancela concluida'
,p_event_sequence=>665
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(147101556381254273353)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137508399259872327419)
,p_event_id=>wwv_flow_api.id(147101557196343273361)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Confirma cancelar requisi\00E7\00E3o ?')
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147108384599132034812)
,p_event_id=>wwv_flow_api.id(147101557196343273361)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P714_COD_REQ'').enabled = true;',
'$x(''P714_COD_JUSTIFICATIVA'').enabled = true;',
'',
'apex.widget.waitPopup();',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147108384764630034814)
,p_event_id=>wwv_flow_api.id(147101557196343273361)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_erro varchar2(4000);',
'begin',
'    /*PRC_CANCELA_REQ_BUSCA_HIST( P_COD_REQ          => :P714_COD_REQ',
'                                , P_USUARIO        => :P_USUARIO',
'                                , P_MSG_RETORNO    => v_erro);*/',
'    PKG_CANCELA_REQUISICOES_HIST.PRC_CANCELA_REQ_ABONO( P_COD_REQ          => :P714_COD_REQ',
'                                                       , P_USUARIO        => :P_USUARIO',
'                                                       , P_MSG_RETORNO    => v_erro);',
'    if v_erro is not null then',
'       :P714_MENSAGEM := ''Erro ao processar o cancelamento.''||v_erro;',
'    end if;',
'    ',
'    PKG_PE_ABONO.prc_ApuracaoReqAbono(:P714_COD_REQ,',
'                                      :P_USUARIO,',
'                                      v_erro);',
'    if v_erro is not null then',
'       :P714_MENSAGEM := ''Erro ao processar o cancelamento.''||v_erro;',
'    end if;',
'end;    ',
''))
,p_attribute_02=>'P714_COD_REQ'
,p_attribute_03=>'P714_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(124343616715020192528)
,p_event_id=>wwv_flow_api.id(147101557196343273361)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143628297044839085997)
,p_name=>unistr('Valida datas do per\00EDodo')
,p_event_sequence=>675
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143628297174852085998)
,p_event_id=>wwv_flow_api.id(143628297044839085997)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_oper is',
'	SELECT data_ini_ref_ponto data_ini, ',
'         data_fim_ref_ponto data_fim,',
'         data_ref_ponto, ',
'         ind_trava_req_po ',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P714_EMP;',
'',
'v_oper c_oper%rowtype;',
'',
'cursor c_gestor is',
'	SELECT dt_ini_ponto_gestor data_ini, ',
'         dt_fim_ponto_gestor data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P714_EMP;',
'',
'v_gestor c_gestor%rowtype;',
'',
'cursor c_colab is',
'	SELECT dt_ini_ponto_colab data_ini, ',
'         dt_fim_ponto_colab data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P714_EMP;',
'',
'v_colab c_colab%rowtype;',
'',
'v_msg varchar2(4000);',
'v_conta number := 0;',
'begin',
'    if NVL( :P714_CONSULTA, ''X'') != ''C'' then',
'        :P714_VALIDA_DATA_PERIODO := null;',
'        if  :P_PAINEL = ''PO'' then',
'            open c_oper;',
'            fetch c_oper into v_oper;',
'            close c_oper;',
'            ',
'            if v_oper.ind_trava_req_po = ''S'' then',
'',
'                if v_oper.data_ref_ponto < :P714_DATA then',
'                    :P714_VALIDA_DATA_PERIODO := null;',
'                else',
'                    if :P714_DATA < v_oper.data_ini and :P714_DATA > v_oper.data_fim then',
'                        :P714_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                    else',
'                        :P714_VALIDA_DATA_PERIODO := null;',
'                    end if;',
'                end if;    ',
'            end if;            ',
'        else    ',
'            if :P_PAINEL = ''PC'' then',
'                open c_colab;',
'                fetch c_colab into v_colab;',
'                close c_colab;',
'',
'',
'                if :P714_DATA not between v_colab.data_ini and v_colab.data_fim then',
'                    :P714_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                else',
'                    :P714_VALIDA_DATA_PERIODO := null;',
'                end if;',
'            elsif :P_PAINEL = ''PG'' then',
'                open c_gestor;',
'                fetch c_gestor into v_gestor;',
'                close c_gestor;',
'',
'                if :P714_DATA not between v_gestor.data_ini and v_gestor.data_fim then',
'                    :P714_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                else',
'                    :P714_VALIDA_DATA_PERIODO := null;',
'                end if;',
'            end if;        ',
'        end if;',
'    end if;',
'exception',
'when others then null;',
'end;'))
,p_attribute_02=>'P714_CONSULTA,P714_DATA'
,p_attribute_03=>'P714_VALIDA_DATA_PERIODO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143628297345019086000)
,p_name=>'Retorno valida data periodo'
,p_event_sequence=>685
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_VALIDA_DATA_PERIODO'
,p_condition_element=>'P714_VALIDA_DATA_PERIODO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'INVALIDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143628297521308086001)
,p_event_id=>wwv_flow_api.id(143628297345019086000)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(22) Data selecioonada est\00E1 fora do per\00EDodo de ponto.<br /><strong>N\00E3o pode ser alterada ou inclu\00EDda </strong>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143628297596621086002)
,p_event_id=>wwv_flow_api.id(143628297345019086000)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143101899708835010125)
,p_name=>'Valida se precisa abono'
,p_event_sequence=>695
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_JUSTIFICATIVA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143101899813344010126)
,p_event_id=>wwv_flow_api.id(143101899708835010125)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_abono varchar2(1);',
'begin',
'    :P714_OBRIGA_ABONO :=  null;  ',
'',
'    select obriga_abono',
'        into v_abono ',
'    from pe_tipo_justificativa',
'    where cod_empresa = :P714_EMP',
'    and cod_justificativa = :P714_COD_JUSTIFICATIVA;',
'    ',
'    if v_abono = ''S'' then',
'        if :P714_APAGAR_MARCACAO is null and :P714_HORA_BATIDA_ABONO is null then',
'            :P714_OBRIGA_ABONO := ''S'';   ',
'        else ',
'            :P714_OBRIGA_ABONO :=  ''N'';  ',
'        end if;',
'    else',
'        :P714_OBRIGA_ABONO := ''N'';  ',
'    end if;',
'',
'exception',
'    when others then',
'        :P714_OBRIGA_ABONO := ''N'';  ',
'',
'end;'))
,p_attribute_02=>'P714_COD_JUSTIFICATIVA,P714_APAGAR_MARCACAO,P714_HORA_BATIDA_ABONO'
,p_attribute_03=>'P714_OBRIGA_ABONO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(143101900036962010128)
,p_name=>'Mostra mensagem obriga abono'
,p_event_sequence=>705
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_OBRIGA_ABONO'
,p_condition_element=>'P714_OBRIGA_ABONO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(143122149804093776179)
,p_event_id=>wwv_flow_api.id(143101900036962010128)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Para esta Justificativa voc\00EA precisa informar os dados de Abono')
,p_attribute_07=>'Ok'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142895187688648795279)
,p_event_id=>wwv_flow_api.id(143101900036962010128)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142296390936199056698)
,p_name=>'Valida periodo perfil de aprovacao'
,p_event_sequence=>715
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142296391051347056699)
,p_event_id=>wwv_flow_api.id(142296390936199056698)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_validador   varchar2(25);',
'    --v_mensagem    varchar2(4000);',
'    v_page        number := 714; --APP_PAGE_ID',
'    v_data_ini    PE_PERFIL_ABONO_GERAL.data_inicio_abono%type;',
'    v_data_fim    PE_PERFIL_ABONO_GERAL.data_fim_abono%type;',
'',
'    cursor c_req is',
'      select distinct dt_solicitacao dt_req',
'      from consulta_requisicoes   ',
'      where tipo_req = decode(v_page, 181, ''REQ_APURA'', ''REQ_ABONO'')',
'      and solicitacao = :P714_COD_REQ;                 ',
'',
'    cursor c_param is',
'    select DT_INI_PONTO_GESTOR, DT_FIM_PONTO_GESTOR',
'    from PARAMETROS_RECURSOS_HUMANOS',
'    where COD_EMPRESA = :P714_EMP;',
'',
'    r_param    c_param%rowtype;',
'    r_req      c_req%rowtype;',
'',
'begin',
'    v_validador := null;',
'    if NVL(:P714_CONSULTA, ''S'') != ''C'' then',
'         open c_param;',
'         fetch c_param into r_param;',
'         close c_param;',
'',
'         open c_req;',
'         fetch c_req into r_req;',
'         close c_req;',
'',
'        if :P_PAINEL = ''PG'' then',
'            begin',
'                select data_inicio_abono, data_fim_abono',
'                    into v_data_ini, v_data_fim',
'                from PE_PERFIL_ABONO_GERAL',
'                where /*cod_empresa = :P714_EMP',
'                    and*/ cd_perfil = :P_PERFIL;',
'            exception',
'                when others then',
'                    begin',
'                        select data_inicio_abono, data_fim_abono',
'                            into v_data_ini, v_data_fim',
'                        from PE_PERFIL_ABONO_GERAL',
'                        where /*cod_empresa = :P714_EMP',
'                            and*/ cd_perfil = ''GESTOR'';',
'                    exception',
'                        when others then',
'                            v_data_ini := null;',
'                            v_data_fim := null;',
'                    end;',
'            end;',
'             if TRUNC(sysdate) >= v_data_ini and TRUNC(SYSDATE) <= v_data_fim then',
'                 v_validador := null;',
'             else',
'                 v_validador := ''12 - ERRO'';',
'             end if;',
'',
'            if v_data_ini is not null and v_data_fim is not null and v_validador is null then',
'                if  r_req.dt_req between v_data_ini and v_data_fim then',
'                   v_validador := null;',
'                else',
'                   v_validador := ''1 - ERRO'';',
'                    if  r_req.dt_req between r_param.DT_INI_PONTO_GESTOR  and r_param.DT_FIM_PONTO_GESTOR then',
'                     /*if (r_param.DT_INI_PONTO_GESTOR between v_data_ini and v_data_fim or',
'                        r_param.DT_FIM_PONTO_GESTOR between v_data_ini and v_data_fim) then*/',
'                        v_validador := null;',
'                     else',
'                        v_validador := ''11 - ERRO'';',
'                     end if;',
'',
'                end if;',
'            end if;',
'        end if;',
'    end if;',
'',
'    if :P714_COD_REQ is null then',
'        v_validador := null;',
'    end if;',
'    :P714_VALIDA_PERIODO_APROVA := v_validador;',
'exception',
'   when others then',
'     :P714_VALIDA_PERIODO_APROVA := sqlerrm;',
'end;',
''))
,p_attribute_02=>'P714_EMP,P714_CONSULTA,P714_COD_REQ'
,p_attribute_03=>'P714_VALIDA_PERIODO_APROVA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142296391290695056701)
,p_name=>unistr('Mostra mensagem periodo aprova\00E7\00E3o')
,p_event_sequence=>725
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_VALIDA_PERIODO_APROVA'
,p_condition_element=>'P714_VALIDA_PERIODO_APROVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(136384454809038948237)
,p_event_id=>wwv_flow_api.id(142296391290695056701)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Data da Requisi\00E7\00E3o est\00E1 fora do per\00EDodo de aprova\00E7\00E3o/rejei\00E7\00E3o.')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142296391429400056703)
,p_event_id=>wwv_flow_api.id(142296391290695056701)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(141815560943841083929)
,p_name=>unistr('Exibe bot\00E3o cancelar demais situa\00E7\00F5es')
,p_event_sequence=>735
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_OPERADOR_DELETA_DEMAIS'
,p_condition_element=>'P714_OPERADOR_DELETA_DEMAIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141815561096219083930)
,p_event_id=>wwv_flow_api.id(141815560943841083929)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(147101556381254273353)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(141855461796690971292)
,p_name=>'Cancel Dialog'
,p_event_sequence=>745
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(141855461648761971291)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141855461825902971293)
,p_event_id=>wwv_flow_api.id(141855461796690971292)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(139299001500897593737)
,p_name=>'Mensagem P_EMPRESA_USER e P_MATRICULA_USER'
,p_event_sequence=>755
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_VALIDA_USERS'
,p_condition_element=>'P714_VALIDA_USERS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(139299001545079593738)
,p_event_id=>wwv_flow_api.id(139299001500897593737)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Usu\00E1rio logado n\00E3o tem empresa e/ou matricula associadas')
,p_attribute_07=>'Ok'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(139299001649613593739)
,p_event_id=>wwv_flow_api.id(139299001500897593737)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138794802747925556551)
,p_name=>'Mostra erro cancelamento'
,p_event_sequence=>765
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_ERRO_CANCELA'
,p_condition_element=>'P714_ERRO_CANCELA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138794802849420556552)
,p_event_id=>wwv_flow_api.id(138794802747925556551)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P714_ERRO_CANCELA'').value.length  > 0 ) {',
'    alertify.alert($v(''P714_ERRO_CANCELA''));',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108814309181198116797)
,p_name=>'Valida quantidade de req.Abono criadas'
,p_event_sequence=>775
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_COD_JUSTIFICATIVA'
,p_condition_element=>'P714_COD_JUSTIFICATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108814309274092116798)
,p_event_id=>wwv_flow_api.id(108814309181198116797)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_msg varchar2(4000);',
'    v_flag  varchar(1);',
'begin',
'    :P714_MENSAGEM_FECHA := null;',
'    prc_valida_qtd_abono( p_cod_empresa => :P714_EMP',
'                    , p_matricula   => :P714_MAT',
'                    , p_painel      => :P_PAINEL',
'                    , p_perfil      => :P_PERFIL',
'                    , p_data_ponto  => :P714_DATA',
'                    , p_cod_req     => :P714_COD_REQ  ',
'                    , p_cod_justifica => :P714_COD_JUSTIFICATIVA',
'                    , p_flag        => v_flag',
'                    , p_messagem    => v_msg );',
'',
'    if v_msg is not null and v_flag = ''N'' then',
'       :P714_MENSAGEM_FECHA := v_msg;              ',
'     end if;',
'end;  '))
,p_attribute_02=>'P714_EMP,P714_MAT,P714_COD_REQ,P714_COD_JUSTIFICATIVA'
,p_attribute_03=>'P714_MENSAGEM_FECHA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108814309506565116800)
,p_name=>'Alerta e fecha Popup'
,p_event_sequence=>785
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_MENSAGEM_FECHA'
,p_condition_element=>'P714_MENSAGEM_FECHA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(98327934004567120636)
,p_event_id=>wwv_flow_api.id(108814309506565116800)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P714_FLAG'').value == "Q") {',
'alertify.confirm($v(''P714_MENSAGEM_FECHA''), function (e) {',
'    if (e) {',
'        $x(''P714_FLAG'').value = ''S'';',
'        $x(''P714_MENSAGEM_FECHA'').value = '''';',
'        $x(''P714_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P714_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P714_MENSAGEM_FECHA'').value.length  > 0 ) {',
'        ',
'        if ($x(''P714_FLAG'').value == "N") {',
'            $x(''P714_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P714_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P714_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P714_MENSAGEM_FECHA''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P714_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P714_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P714_ITEM_VALIDACAO'').value == ''P714_CREATE''){',
'            $x(''P714_OK'').value = ''S'';',
'        $x(''P714_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108814310086515116806)
,p_event_id=>wwv_flow_api.id(108814309506565116800)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P714_FLAG_OK'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(108814309878417116804)
,p_name=>'Fecha'
,p_event_sequence=>795
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P714_FLAG_OK'
,p_condition_element=>'P714_FLAG_OK'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(108814310046634116805)
,p_event_id=>wwv_flow_api.id(108814309878417116804)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(87417403254932743949)
,p_name=>'Valida data req x data ref ponto'
,p_event_sequence=>805
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(87417403403719743950)
,p_event_id=>wwv_flow_api.id(87417403254932743949)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P714_MSG_CLOSE := PKG_TRATA_DATAS.VALIDA_DATA_REF_PONTO( P_COD_EMPRESA        => :P714_EMP',
'                                                         , P_DATA_SOLICITADA  => :P181_DATA',
'                                                         , P_TIPO             => ''abono'' );',
''))
,p_attribute_02=>'P714_EMP,P714_DATA'
,p_attribute_03=>'P714_MSG_CLOSE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583294165649413880)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'/*',
'cursor c1 is',
'select nvl(max(cod_req),1) seq',
'  from pe_req_tratamento_batimentos;',
'',
'v_c1 c1%rowtype;',
'*/',
'v_seq number;',
'v_exists number;',
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;   ',
'',
'v_data date := :p714_data;',
'P_DT_PONTO     DATE;',
'',
'begin',
'',
unistr('-- Informa se a requisi\00E7\00E3o partiu de um plant\00E3o - Andre = 05-03-2024'),
'if :P714_OPCAO_PLANTAO IN (''P'', ''Q'') then',
'    :P714_OPCAO_PLANTAO := ''S'';',
'else',
'    :P714_OPCAO_PLANTAO := ''N'';',
'end if;',
'',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'begin',
'loop  ',
'    SELECT seq_requisicao.NEXTVAL',
'    INTO v_seq ',
'    FROM DUAL;',
'    ',
'    select count(*)',
'      into v_exists',
'      from pe_req_tratamento_batimentos',
'     where cod_req = v_seq;',
'    ',
'  exit when v_exists = 0;',
'end loop;',
'end;',
'',
':p714_cod_req := v_seq;',
':p714_cod_sit_req := 1;',
':p714_dt_req := sysdate;',
':p714_dt_sit_req := sysdate;',
':p714_cod_emp_req := :P_EMPRESA_USER;',
':p714_mat_req := :P_MATRICULA_USER;',
'',
'/*',
'IF :p714_matricula IS NULL THEN',
':p714_cod_empresa := :p714_emp;',
':p714_matricula := :p714_mat;',
'END IF;',
'*/',
':p714_posicao_x       := :p714_posicao;',
':p714_fil_req := v_c1.filial;',
':p714_usuario := :p_usuario;',
':p714_data_Ponto := nvl(:P714_DATA_PONTO,:P714_DATA);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583298601175413884)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Horas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_hora_batida       date;',
'v_hora_batida_abono date;',
'',
'begin',
'    --v_hora_batida       := to_date(:p714_data||'' ''||:p714_hora_batida,''dd/mm/rrrr hh24:mi:ss'');',
'    --v_hora_batida_abono := to_date(:p714_data||'' ''||:p714_hora_batida_abono,''dd/mm/rrrr hh24:mi:ss'');',
'',
'    if :p714_hora_batida is not null then',
'        :p714_hora_batida_x       := :p714_data||'' ''||:p714_hora_batida;',
'    end if;',
'',
'    if :p714_hora_batida_abono is not null then',
'        :p714_hora_batida_abono_x := :p714_data||'' ''||:p714_hora_batida_abono;',
'    end if;',
'',
'    if :P714_POSICAO is null then',
'        :P714_POSICAO := 1;',
'    end if;',
'',
'    if :p714_matricula is null then',
'        :p714_cod_empresa := :p714_emp;',
'        :p714_matricula := :p714_mat;',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583293368577413880)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Carrega Batimentos Atual'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  pTypeAUX    PKG_PE_ABONO.typ_TabTratBat;',
'  --',
'  vMsg     VARCHAR2(250) DEFAULT NULL; ',
'  --',
'  errExcpt EXCEPTION;',
'  ',
'BEGIN',
'  pTypeAUX.DELETE;',
'  --',
'  IF NOT APEX_COLLECTION.collection_exists(''TRAT_BATIMENTOS'') THEN',
'    APEX_COLLECTION.create_collection(''TRAT_BATIMENTOS'');',
'  ELSE',
'    APEX_COLLECTION.truncate_collection(''TRAT_BATIMENTOS'');',
'  END IF;',
'  --',
'  PKG_PE_ABONO.prc_CarregaBatimentoAtual(pEmpresa   => :P714_EMP',
'                                        ,pmatricula => :P714_MAT',
'                                        ,pDataPonto => :P714_DATA',
'                                        ,pType      => pTypeAUX);',
'  --',
'  IF pTypeAUX.COUNT = 0 THEN',
'    vMsg := ''Nenhum registro encontrado para a data [''||:P714_DATA||'']!'';',
'  ELSE',
'    FOR i IN pTypeAUX.FIRST..pTypeAUX.LAST LOOP',
'    ',
'      APEX_COLLECTION.add_member(p_collection_name => ''TRAT_BATIMENTOS''',
'                                ,p_n001 => pTypeAUX(i).cod_trat_bat               , p_d001 => pTypeAUX(i).data_ponto        ',
'                                ,p_n002 => pTypeAUX(i).cod_empresa                , p_d002 => pTypeAUX(i).hora_batida',
'                                ,p_n003 => pTypeAUX(i).matricula                  , p_d003 => pTypeAUX(i).hora_batida_abono',
'                                ,p_n004 => pTypeAUX(i).posicao                    , p_d004 => pTypeAUX(i).vira_dia',
'                                ,p_n005 => pTypeAUX(i).cod_hist_bat               , p_d005 => pTypeAUX(i).data_processamento',
'                                --',
'                                ,p_c001 => TO_CHAR(pTypeAUX(i).cod_func_ocorr)    , p_c006 => pTypeAUX(i).comentarios',
'                                ,p_c002 => TO_CHAR(pTypeAUX(i).cod_ocorr)         , p_c007 => pTypeAUX(i).abono_regra_aa',
'                                ,p_c003 => TO_CHAR(pTypeAUX(i).foi_tratado)       , p_c008 => pTypeAUX(i).horas_trab',
'                                ,p_c004 => TO_CHAR(pTypeAUX(i).foi_apurado)       , p_c009 => TO_CHAR(pTypeAUX(i).cod_lanc_marc)',
'                                ,p_c005 => TO_CHAR(pTypeAUX(i).cod_justificativa) , p_c010 => pTypeAUX(i).horas_trab_abono',
'                                ,p_c011 => pTypeAUX(i).sobreaviso                 , p_c016 => TO_CHAR(pTypeAUX(i).id_tratamento)',
'                                ,p_c012 => TO_CHAR(pTypeAUX(i).cod_importacao)    , p_c017 => pTypeAUX(i).cod_coletor',
'                                ,p_c013 => pTypeAUX(i).usuario                    , p_c018 => TO_CHAR(pTypeAUX(i).inicio_justificativa)',
'                                ,p_c014 => TO_CHAR(pTypeAUX(i).dt_atualizacao)    , p_c019 => TO_CHAR(pTypeAUX(i).fim_justificativa)',
'                                ,p_c015 => pTypeAUX(i).origem                     , p_c020 => pTypeAUX(i).latitude ',
'                                ,p_c021 => pTypeAUX(i).longitude                  , p_c022 => pTypeAUX(i).origem_imp',
'                                ,p_c023 => pTypeAUX(i).idRow);',
'    END LOOP;    ',
'  END IF;',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    RAISE errExcpt;',
'  END IF;',
'EXCEPTION',
'  WHEN errExcpt THEN',
'    RAISE_APPLICATION_ERROR(-20930, ''Carrega Dados Atuais de Batimentos [PRC_CARREGABATIMENTOATUAL]''||CHR(10)||''ERRO: ''||vMsg||CHR(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());',
'  WHEN OTHERS THEN',
'    RAISE_APPLICATION_ERROR(-20925, SQLERRM||CHR(10)||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());       ',
'END;'))
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
,p_process_when=>':P714_ENVIAR_MARCACAO = ''S'' AND :P714_POSICAO_ENV IS NOT NULL AND :P714_HORA_BATIDA IS NOT NULL'
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583295753152413882)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Process'
,p_attribute_02=>'PE_REQ_TRATAMENTO_BATIMENTOS'
,p_attribute_03=>'P714_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583298944413413884)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'P_DT_PONTO     DATE;',
'V_VIRA_DIA     DATE;',
'begin',
'-- Ajuste do retorno vira dia - Andre - 12-03-2024',
'PKG_PE_ABONO.Post_Insert(:P714_cod_empresa,',
'                            :P714_cod_req,',
'                            V_flg_retorno,',
'                            V_msg_retorno);',
'                            ',
'    if v_msg_retorno is not null then',
'        :p714_ok       := ''N'';',
'        :p714_flag     := v_flg_retorno;',
'        :p714_mensagem := v_msg_retorno;',
'    else',
'        :p714_flag     := null;',
'        :p714_mensagem := null;',
'        :p714_ok       := ''S'';',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(30967381634946108548)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Apuracao req_abono'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'PKG_PE_ABONO.prc_ApuracaoReqAbono(:P714_cod_req,',
'                                  :P_USUARIO,',
'                                  v_msg_retorno);',
'                            ',
'    if v_msg_retorno is not null then',
'        :p714_ok       := ''N'';',
'        :p714_flag     := ''N'';',
'        :p714_mensagem := v_msg_retorno;',
'    else',
'        :p714_flag     := null;',
'        :p714_mensagem := null;',
'        :p714_ok       := ''S'';',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583293811084413880)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Replica Requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  v_flg_retorno varchar2(3)    DEFAULT NULL;',
'  v_msg_retorno varchar2(4000) DEFAULT NULL;',
'BEGIN',
'  IF NVL(:P714_NUM_DIAS_JUST, 0) > 1 THEN',
'    PKG_PE_ABONO.prc_ReplicaPeReqTratBatimento(:P714_COD_REQ, TO_DATE(:P714_DT_INI_VAL_JUST, ''DD/MM/RRRR'') + 1, TO_DATE(:P714_DT_FIM_VAL_JUST, ''DD/MM/RRRR''), :P_USUARIO); --:APP_USER);                                              ',
'  END IF;',
'  --',
' if v_msg_retorno is not null then',
'    :p714_ok       := ''N'';',
'    :p714_flag     := NVL(v_flg_retorno,''N'');',
'    :p714_mensagem := v_msg_retorno;',
' else',
'    :p714_flag     := null;',
'    :p714_mensagem := null;',
'    :p714_ok       := ''S'';',
' end if;',
'',
'EXCEPTION',
'  WHEN OTHERS THEN',
unistr('    RAISE_APPLICATION_ERROR(-20920, ''ERRO REPLICA\00C7\00C3O ABONO: ''||SQLERRM);'),
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583292955926413880)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Avan\00E7a Retrocede Posi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  pTypeAUX    PKG_PE_ABONO.typ_TabTratBat;',
'  --',
'  CURSOR cCollection IS',
'    SELECT * FROM apex_collections WHERE collection_name = ''TRAT_BATIMENTOS'';',
'  --',
'  vIdx    NUMBER DEFAULT NULL;',
'  --',
'  CURSOR cReq IS',
'    SELECT r.*',
'      FROM pe_req_tratamento_batimentos r',
'     WHERE r.cod_req = :P714_COD_REQ;',
'  --',
'  rReq    cReq%ROWTYPE; ',
'  --',
'  vExec   NUMBER DEFAULT 0;',
'BEGIN',
'',
'  OPEN cReq;',
'  FETCH cReq INTO rReq;',
'  CLOSE cReq;',
'  --',
'  IF rReq.cod_sit_req = 2 AND rReq.apagar_marcacao = ''S'' AND rReq.posicao_envio IS NOT NULL AND rReq.hora_batida IS NOT NULL THEN',
'    vExec := 1;',
'  END IF;',
'  --',
'  IF vExec = 1 THEN ',
'    IF APEX_COLLECTION.COLLECTION_MEMBER_COUNT( p_collection_name => ''TRAT_BATIMENTOS'') > 0 THEN',
'      FOR Rec IN cCollection LOOP',
'        vIdx := pTypeAUX.COUNT + 1;',
'        --',
'        pTypeAUX(vIdx).cod_trat_bat := Rec.n001;    pTypeAUX(vIdx).data_ponto         := Rec.d001;   ',
'        pTypeAUX(vIdx).cod_empresa  := Rec.n002;    pTypeAUX(vIdx).hora_batida        := Rec.d002;     ',
'        pTypeAUX(vIdx).matricula    := Rec.n003;    pTypeAUX(vIdx).hora_batida_abono  := Rec.d003;           ',
'        pTypeAUX(vIdx).posicao      := Rec.n004;    pTypeAUX(vIdx).vira_dia           := Rec.d004;               ',
'        pTypeAUX(vIdx).cod_hist_bat := Rec.n005;    pTypeAUX(vIdx).data_processamento := Rec.d005;         ',
'        --',
'        pTypeAUX(vIdx).cod_func_ocorr    := Rec.c001;    pTypeAUX(vIdx).comentarios          := Rec.c006;  ',
'        pTypeAUX(vIdx).cod_ocorr         := Rec.c002;    pTypeAUX(vIdx).abono_regra_aa       := Rec.c007;   ',
'        pTypeAUX(vIdx).foi_tratado       := Rec.c003;    pTypeAUX(vIdx).horas_trab           := Rec.c008;  ',
'        pTypeAUX(vIdx).foi_apurado       := Rec.c004;    pTypeAUX(vIdx).cod_lanc_marc        := Rec.c009;   ',
'        pTypeAUX(vIdx).cod_justificativa := Rec.c005;    pTypeAUX(vIdx).horas_trab_abono     := Rec.c010;  ',
'        pTypeAUX(vIdx).sobreaviso        := Rec.c011;    pTypeAUX(vIdx).id_tratamento        := Rec.c016;   ',
'        pTypeAUX(vIdx).cod_importacao    := Rec.c012;    pTypeAUX(vIdx).cod_coletor          := Rec.c017;  ',
'        pTypeAUX(vIdx).usuario           := Rec.c013;    pTypeAUX(vIdx).inicio_justificativa := Rec.c018;  ',
'        pTypeAUX(vIdx).dt_atualizacao    := Rec.c014;    pTypeAUX(vIdx).fim_justificativa    := Rec.c019;  ',
'        pTypeAUX(vIdx).origem            := Rec.c015;    pTypeAUX(vIdx).latitude             := Rec.c020;   ',
'        pTypeAUX(vIdx).longitude         := Rec.c021;    pTypeAUX(vIdx).origem_imp           := Rec.c022;             ',
'        pTypeAUX(vIdx).idRow             := Rec.c023;                  ',
'      END LOOP;',
'      --',
'      APEX_COLLECTION.truncate_collection(''TRAT_BATIMENTOS'');',
'    END IF;',
'    --',
'    PKG_PE_ABONO.prc_AvancaRetrocedePosicao(pEmpresa     => :P714_EMP',
'                                           ,pmatricula   => :P714_MAT',
'                                           ,pDataPonto   => :P714_DATA',
'                                           ,pPosicaoDe   => :P714_POSICAO_X',
'                                           ,pPosicaoPara => :P714_POSICAO_ENV',
'                                           ,pUser        => :P_USUARIO --:APP_USER',
'                                           ,pType        => pTypeAUX);',
'    --',
'    pkg_pe_abono.prc_deleta_batida(rReq.cod_empresa, rReq.matricula, rReq.data_ponto, rReq.posicao, rReq.usuario, null, :P714_COD_REQ);',
'  END IF;',
'EXCEPTION',
'  WHEN OTHERS THEN',
unistr('    RAISE_APPLICATION_ERROR(-20930, ''ERRO AVAN\00C7A RETROCEDE POSI\00C7\00C3O: ''||SQLERRM);                                         '),
'END;'))
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
,p_process_when=>':P714_ENVIAR_MARCACAO = ''S'' AND :P714_POSICAO_ENV IS NOT NULL AND :P714_HORA_BATIDA IS NOT NULL AND :P714_APAGAR_MARCACAO = ''S'''
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583292597701413879)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Retrocede Todas Posi\00E7\00F5es')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cUser IS',
'    SELECT COUNT(1)',
'      FROM usuario_oracle uo',
'     WHERE uo.nm_usuario_oracle = :P_USUARIO --:APP_USER',
'       AND NOT EXISTS ( SELECT 1 ',
'                          FROM pe_perfil_abono_geral pe ',
'                         WHERE uo.cd_perfil  = pe.cd_perfil',
'                           AND uo.cd_empresa = pe.cod_empresa',
'                           AND pe.bloqueia   = ''S'' );',
'  --',
'  CURSOR cReq IS',
'    SELECT r.*',
'      FROM pe_req_tratamento_batimentos r',
'     WHERE r.cod_req = :P714_COD_REQ;',
'  --',
'  rReq    cReq%ROWTYPE;',
'  --',
'  vCount    NUMBER DEFAULT 0;',
'BEGIN',
'',
'  OPEN cUser;',
'  FETCH cUser INTO vCount;',
'  CLOSE cUser;',
'',
'  --',
'  IF vCount > 0 THEN',
'    OPEN cReq;',
'    FETCH cReq INTO rReq;',
'    CLOSE cReq;',
'    --',
'    IF rReq.cod_sit_req = 2 AND rReq.apagar_marcacao = ''S'' AND rReq.posicao_envio IS NULL AND rReq.hora_batida IS NOT NULL THEN',
'      PKG_PE_ABONO.prc_RetrocedeTodasPos(pEmpresa   => :P714_EMP',
'                                        ,pmatricula => :P714_MAT',
'                                        ,pDataPonto => :P714_DATA',
'                                        ,pPosicao   => :P714_POSICAO_X',
'                                        ,pUser      => :P_USUARIO); --:APP_USER); 	',
'    END IF;                                      ',
'  END IF;',
'EXCEPTION',
'  WHEN OTHERS THEN',
unistr('    RAISE_APPLICATION_ERROR(-20931, ''ERRO RETROCEDER POSI\00C7\00D5ES: ''||SQLERRM);'),
'END; '))
,p_process_error_message=>'#SQLERRM_TEXT#'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P714_APAGAR_MARCACAO = ''S'' AND (:P714_ENVIAR_MARCACAO IS NULL AND :P714_POSICAO_ENV IS NULL AND :P714_HORA_BATIDA IS NOT NULL)',
''))
,p_process_when_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583297393060413883)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_atualiza_batida'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' v_data         date;',
' v_batida       date;',
' v_batida_abono date;',
'',
'begin',
'    ',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'    ',
'    v_data := to_Date(:p714_data_ponto,''dd/mm/rrrr'');',
'    ',
'    if :p714_hora_batida is not null then',
'    v_batida := to_date(:p714_data||'' ''||:p714_hora_batida,''dd/mm/rrrr hh24:mi'');',
'    end if;',
'    ',
'    if :p714_hora_batida_abono is not null then',
'    v_batida_abono := to_date(:p714_data||'' ''||:p714_hora_batida_abono,''dd/mm/rrrr hh24:mi'');',
'    end if;',
'',
'    pkg_pe_abono.prc_atualiza_batida (:p714_emp, ',
'                                      :p714_mat, ',
'                                      v_data, ',
'                                      v_batida, ',
'                                      v_batida_abono, ',
'                                      :p714_posicao, ',
'                                      :p714_cod_justificativa, ',
'                                      :p714_comentarios, ',
'                                      :p_usuario);',
'    ',
'    commit;',
'',
'end;'))
,p_process_error_message=>unistr('Erro ao salvar altera\00E7\00F5es.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Altera\00E7\00F5es Realizadas com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583297813783413883)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_deleta_batida'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_pe_abono.prc_deleta_batida(:p714_emp, :p714_mat, :p714_data, :p714_posicao, :p_usuario, :p714_seq);',
'end;'))
,p_process_error_message=>unistr('Erro ao deletar marca\00E7\00E3o.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(312443206532538905437)
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Marca\00E7\00E3o Deletada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583298170999413883)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_deleta_batida_abono'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_pe_abono.prc_deleta_batida_abono(:p714_emp, :p714_mat, :p714_data, :p714_posicao, :p_usuario, :p714_seq);',
'end;'))
,p_process_error_message=>unistr('Erro ao deletar marca\00E7\00E3o.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(302414175797863831622)
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Marca\00E7\00E3o Deletada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583299350578413884)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_deleta_data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_pe_abono.prc_deleta_data (:p714_emp, :p714_mat, :p714_data);',
'end;'))
,p_process_error_message=>'Erro ao Deletar Data.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(312443206126360905436)
,p_process_when_type=>'NEVER'
,p_process_success_message=>'Data Deletada com Sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583299742966413884)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'prc_adiciona_data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cod_importacao number;',
'v_imp number;',
'BEGIN',
'    ',
'     begin',
'     select distinct cod_importacao',
'       into v_cod_importacao',
'       from pe_tratamento_batimentos',
'      where cod_empresa = :P714_EMP',
'        and matricula = :P714_mat',
'        and nvl(vira_dia,data_ponto) = :P714_data',
'        and posicao = 1; ',
'     exception',
'     when others then',
'     v_cod_importacao := null;',
'     ',
'     end;',
'     ',
'	    Prc_Pe_Imp_Filhos2(:P714_EMP,:P714_EMP,',
'	                   :P714_MAT,''N'',',
'	                   :P714_DATA,',
'		                 NULL,',
'		                 1,NULL,NULL,''A'', NVL(v_cod_importacao,0), v_imp,0, :p_usuario, ',
'		                  NULL, null );',
'',
'END; '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(312471809564760680370)
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(163434642996321203727)
,p_process_sequence=>160
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Processo Recupera deletado'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    CURSOR req_abono IS',
'        SELECT *',
'        FROM pe_req_tratamento_batimentos',
'        WHERE cod_req = :P714_cod_req;',
'',
'    v_req_abono req_abono%ROWTYPE;',
'    v_flg_retorno varchar2(3);',
'    v_msg_retorno varchar2(4000);',
'    n_trata number := 0;',
'',
'    v_erro varchar2(4000);',
'',
'begin',
'    OPEN  req_abono;',
'    FETCH req_abono INTO v_req_abono;',
'    CLOSE req_abono;',
'-->> MSS 20231018',
'  IF v_req_abono.cod_sit_req = 2 THEN',
'--<<  ',
'    if nvl(v_req_abono.apagar_marcacao,''N'') = ''S'' and v_req_abono.posicao_envio is not null and v_req_abono.hora_batida_abono is not null then',
'        begin',
'            n_trata := Func_Pe_Contador(''PE_TRATAMENTO_BATIMENTOS'');',
'',
'            INSERT INTO PE_TRATAMENTO_BATIMENTOS (COD_EMPRESA,',
'                COD_HIST_BAT,',
'                MATRICULA,',
'                DATA_PONTO,',
'                HORA_BATIDA,',
'                COD_TRAT_BAT,',
'                FOI_TRATADO,',
'                DATA_PROCESSAMENTO,',
'                FOI_APURADO,',
'                COD_FUNC_OCORR,',
'                COD_OCORR,',
'                COD_JUSTIFICATIVA,',
'                POSICAO,',
'                VIRA_DIA,',
'                COD_IMPORTACAO,',
'                Usuario,',
'                dt_atualizacao,',
'                HORA_BATIDA_ABONO,',
'                ORIGEM,',
'                ORIGEM_IMP)',
'            VALUES (v_req_abono.cod_empresa,',
'                null,',
'                v_req_abono.matricula,',
'                v_req_abono.data_ponto,',
'                v_req_abono.data_ponto,',
'                n_trata,',
'                0,',
'                SYSDATE,',
'                0,',
'                NULL,',
'                NULL,',
'                NULL,',
'                NVL(v_req_abono.posicao,0), -- # retirar nvl',
'                null,',
'                0,',
'                v_req_abono.usuario,',
'                sysdate,',
'                v_req_abono.hora_batida_abono,',
'                ''A'',',
'                ''ABONO'');',
'           exception',
'        when others then',
'            v_msg_retorno := sqlerrm;',
'            :p714_ok       := ''N'';',
'            :p714_flag     := v_flg_retorno;',
'            :p714_mensagem := v_msg_retorno;',
'        end;',
'    end if;',
'  END IF;    -->> MSS 20231018',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
,p_process_comment=>'WBP CREATE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(154774106593313459979)
,p_process_sequence=>170
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Cancela Requisicao'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_conta number := 0;',
'    v_cod_justificativa    PE_REQ_TRATAMENTO_BATIMENTOS.cod_justificativa%type;  ',
'    v_posicao              PE_REQ_TRATAMENTO_BATIMENTOS.posicao%type;     ',
'    v_cod_trat_bat         pe_tratamento_batimentos.COD_TRAT_BAT%type;',
'    v_erro                varchar2(4000);',
'    ',
'begin',
'    if :P714_COD_SIT_REQ = 3 then',
'        update PE_REQ_TRATAMENTO_BATIMENTOS',
'            set cod_sit_req = :P714_COD_SIT_REQ ',
'            , dt_sit_req = SYSDATE',
'        where cod_req = :P714_COD_REQ;',
'        --',
'        v_conta := SQL%ROWCOUNT;',
'        if v_conta != 0 then',
'            begin',
'            select cod_justificativa , posicao',
'                  into v_cod_justificativa, v_posicao',
'              from PE_REQ_TRATAMENTO_BATIMENTOS',
'              where cod_req = :P714_COD_REQ;',
'            exception ',
'                when others then',
'                    v_cod_justificativa := null;',
'            end; ',
'            --',
'            if v_cod_justificativa is null then',
'                    :p714_ok       := ''N'';',
'                    :p714_flag     := ''N'';',
unistr('                    :p714_mensagem := ''Erro ao localizar a justificativa da requisi\00E7\00E3o de abono e/ou posi\00E7\00E3o ''||:P714_COD_REQ;'),
'            else',
'            --',
'                begin',
'                    select P.COD_TRAT_BAT ',
'                        into v_cod_trat_bat ',
'                    from pe_tratamento_batimentos P ',
'                    where data_ponto = :P714_DATA',
'                    and cod_empresa = :P714_EMP',
'                    and matricula = :P714_MAT',
'                    AND POSICAO = v_posicao',
'                    AND HORA_BATIDA_ABONO IS NOT NULL ',
'                    AND COD_JUSTIFICATIVA = v_cod_justificativa;',
'                exception ',
'                    when others then',
'                        v_cod_trat_bat := null;',
'                end; ',
'                if v_cod_trat_bat is null then',
'                        :p714_ok       := ''N'';',
'                        :p714_flag     := ''N'';',
unistr('                        :p714_mensagem := ''Erro ao localizar o batimento para Empresa = ''||:P714_EMP||'' Matricula = ''||:P714_MAT||'' Data Ponto = '' ||:P714_DATA||'' Posi\00E7\00E3o = ''||v_posicao;'),
'                else',
'                    update pe_tratamento_batimentos',
'                        set hora_batida_abono = null, cod_justificativa = null',
'                        where COD_TRAT_BAT = v_cod_trat_bat;',
'        v_conta := SQL%ROWCOUNT;',
'                        :p714_ok       := ''S'';',
'                        :p714_flag     := ''S'';',
unistr('                        :p714_mensagem := ''Cancelamento da Requisi\00E7\00E3o ''||:P714_COD_REQ||'' executado com sucesso.'';'),
'                end if;',
'            end if;',
'        end if;',
'    end if;',
'exception',
'    when others then',
'    v_erro := SQLERRM;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(146367743089467332151)
,p_process_sequence=>180
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atualiza batida plant\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c_req is',
'        SELECT *',
'          FROM pe_req_tratamento_batimentos',
'         WHERE cod_req = :P714_COD_REQ;',
'',
'    v_req     c_req%ROWTYPE;',
'    v_erro    VARCHAR2(4000);',
'    v_conta    NUMBER := 0;',
'begin',
'    open c_req;',
'    fetch c_req into v_req;',
'    close c_req;',
'if :P714_OPCAO_PLANTAO IN (''P'', ''Q'') then',
'    begin        ',
'       update pe_tratamento_batimentos',
'       set plantao          = ''S''',
'          , VIRA_DIA        = v_req.vira_dia',
'          , USUARIO         = SUBSTR(:P_USUARIO||''Tela_714'',1,30)',
'          , DT_ATUALIZACAO  = SYSDATE',
'       where cod_empresa         = v_req.cod_empresa',
'                and matricula    = v_req.matricula',
'                and data_ponto   = v_req.data_ponto --NVL(v_req.vira_dia, v_req.data_ponto )',
'                --and vira_dia     = v_req.vira_dia ',
'                and posicao      = v_req.posicao;',
'                ',
'    v_conta := SQL%ROWCOUNT;                ',
'    exception',
'      when others then       ',
'        v_erro := SQLERRM;     ',
'    end;            ',
'end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(168583257579831413829)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583294945155413882)
,p_process_sequence=>190
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Processo executado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583296970298413883)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'',
'if :p714_seq is null then',
':p714_seq := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'end if;',
'',
'null; --usuario.seta_user(:P_USUARIO);',
'v_usuario := usuario.busca_user;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583296179721413882)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'PE_REQ_TRATAMENTO_BATIMENTOS'
,p_attribute_03=>'P714_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_08=>'posicao = nvl(nvl(:p714_posicao_x,:p714_posicao),posicao)'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583296608731413883)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c2 (v_emp number, v_mat number, v_data date, v_pos number, v_pto_feriado varchar2) is',
'      SELECT horario, posicao',
'        FROM PE_JORNADAS_COMPOSICAO',
'       WHERE cod_jornada = Fnct_Pe_Retorna_Jornada( v_emp, v_mat, v_data )',
'         AND POSICAO = v_pos',
'         AND ((((((TO_CHAR(v_data, ''d'') = 1) AND (domingo = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 2) AND (segunda = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 3) AND (terca   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 4) AND (quarta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 5) AND (quinta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 6) AND (sexta   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 7) AND (sabado  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) ))',
'          OR ((NVL(v_pto_feriado,''N'') = ''S'' AND (FERIADO = ''S'') ))))',
'       ORDER BY POSICAO DESC;',
'',
'v_c2 c2%rowtype;',
'',
' V_CONSID_PTO_FERIADO varchar2(1) := ''N'';',
'',
'begin',
'',
'if :p714_cod_empresa is not null then',
':p714_emp := :p714_cod_empresa;',
'end if;',
'',
'if :p714_matricula is not null then',
':p714_mat := :p714_matricula;',
'end if;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
' V_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
' ',
' IF :P714_MAT IS NOT NULL AND :P714_DATA IS NOT NULL THEN',
' :P714_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
' :P714_COD_JORNADA := Fnct_Pe_Retorna_Jornada(:P714_EMP,:P714_MAT,:p714_DATA);',
' END IF;',
' ',
'    open  c2(:p714_emp,:p714_mat,:p714_data, :p714_posicao, V_CONSID_PTO_FERIADO);',
'    fetch c2 into v_c2;',
'    close c2;',
'',
'    :p714_jornada           := v_c2.horario;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583294601490413880)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'-- #01',
'cursor c1 is',
'select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
unistr('    , DECODE(PLANTAO, ''S'', ''Sim'', ''N'', ''N\00E3o'') plantao'),
'  from pe_tratamento_batimentos',
' where cod_empresa = :p714_emp',
'   and matricula = :p714_mat',
'   and nvl(vira_dia,data_ponto) = :p714_data',
'   and posicao = :p714_posicao',
'   and :p714_cod_req is null',
' union',
' select cod_empresa, matricula, data_ponto, vira_dia, hora_batida, hora_batida_abono, posicao, cod_justificativa, comentarios',
unistr('    , DECODE(PLANTAO, ''S'', ''Sim'', ''N'', ''N\00E3o'') plantao'),
' ',
'  from pe_req_tratamento_batimentos',
' where cod_req = :p714_cod_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_emp number, v_mat number, v_data date, v_pos number, v_pto_feriado varchar2) is',
'      SELECT horario, posicao',
'        FROM PE_JORNADAS_COMPOSICAO',
'       WHERE cod_jornada = Fnct_Pe_Retorna_Jornada( v_emp, v_mat, v_data )',
'         AND POSICAO = v_pos',
'         AND ((((((TO_CHAR(v_data, ''d'') = 1) AND (domingo = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 2) AND (segunda = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 3) AND (terca   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 4) AND (quarta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 5) AND (quinta  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 6) AND (sexta   = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) )',
'          OR   (((TO_CHAR(v_data, ''d'') = 7) AND (sabado  = ''S'')  AND (NVL(v_pto_feriado,''N'') = ''N'')) ))',
'          OR ((NVL(v_pto_feriado,''N'') = ''S'' AND (FERIADO = ''S'') ))))',
'       ORDER BY POSICAO DESC;',
' ',
'v_c2 c2%rowtype;',
'',
'V_DATA_PARAMETRO DATE := :p714_data;',
'',
' V_CONSID_PTO_FERIADO varchar2(1) := ''N'';',
'',
'begin',
'',
'    open  c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
' V_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
' :P714_CONSID_PTO_FERIADO := F_Pe_Considera_Jornada_Feriado(:p714_emp,:p714_mat,:p714_data);',
'    :P714_PLANTAO := v_c1.plantao;',
'    if v_c1.cod_empresa is not null then ',
'        ',
'        :p714_data_ponto        := v_c1.data_ponto;',
'        :p714_vira_dia          := v_c1.vira_dia;',
'        :P714_VIRA_DIA_DSP      := v_c1.vira_dia;',
'        :p714_hora_batida       := to_char(v_c1.hora_batida,''hh24:mi'');',
'        :p714_hora_batida_abono := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'        :p714_hora_batida_abono_dsp := to_char(v_c1.hora_batida_abono,''hh24:mi'');',
'',
'        :p714_cod_justificativa := v_c1.cod_justificativa;',
'        :p714_comentarios       := v_c1.comentarios;',
'    ',
'    open  c2(v_c1.cod_empresa, v_c1.matricula, v_c1.data_ponto, v_c1.posicao, V_CONSID_PTO_FERIADO);',
'    fetch c2 into v_c2;',
'    close c2;',
'    ',
'    :p714_jornada           := v_c2.horario;',
'    ',
'    end if;',
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(168583295408928413882)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos 2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p714_data is null then',
':p714_data := nvl(:p714_vira_dia,:p714_data_ponto);',
'  if :p714_posicao is null then',
'  :p714_posicao := :p714_posicao_x;',
'  end if;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P714_COD_REQ'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(159232772582465719784)
,p_process_sequence=>70
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos_3'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    cursor c1 is',
'    select posicao_envio , COD_SIT_REQ',
'      from pe_req_tratamento_batimentos',
'      where cod_req = :P714_COD_REQ;',
'  ',
'    v_c1 c1%rowtype;  ',
'begin',
'    if :P714_COD_REQ is not null then',
'    ',
'        open c1;',
'        fetch c1 into v_c1;',
'        close c1;',
'        :P714_POSICAO_ENV_DSP := v_c1.posicao_envio;',
'    ',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P714_COD_REQ'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(141855464106830971315)
,p_process_sequence=>80
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos_4'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    SELECT DATA_INI_REF_PONTO DATA_INI, ',
'           DATA_FIM_REF_PONTO DATA_FIM',
'    INTO :P714_DTINI_ABONO, :P714_DTFIM_ABONO       ',
'      FROM PARAMETROS_RECURSOS_HUMANOS',
'     WHERE COD_EMPRESA = :P714_EMP;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P714_COD_REQ'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(147101556042844273350)
,p_process_sequence=>90
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Permite cancelar requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_operador_cancela_concluida       parametros_recursos_humanos.operador_cancela_concluida%type;',
'    l_operador_cancela_requisicoes     parametros_recursos_humanos.operador_cancela_requisicoes%type;',
'begin',
'    :P714_OPERADOR_DELETA := ''N'';',
'    :P714_OPERADOR_DELETA_DEMAIS := ''N'';',
'    --',
'    if :P714_COD_SIT_REQ != 3 then    -- Nao cancelada',
'        select operador_cancela_concluida, operador_cancela_requisicoes',
'            into l_operador_cancela_concluida,  l_operador_cancela_requisicoes',
'        from parametros_recursos_humanos',
'            where cod_empresa = :P_EMPRESA_USER;',
'        --',
'        --',
'        if :P_PAINEL = ''PO'' then      -- Painel do Operador',
'            --',
'            if l_operador_cancela_concluida = ''S'' /*and :P714_COD_SIT_REQ = 2*/ then',
'                :P714_OPERADOR_DELETA := ''S'';',
'            end if;',
'            if l_operador_cancela_requisicoes = ''S'' /*and :P714_COD_SIT_REQ = 2*/ then',
'                :P714_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;',
'        elsif :P_PAINEL = ''PG'' then     -- Painel do Gestor',
'            if (:P714_COD_SIT_REQ = 2 or :P714_COD_SIT_REQ = 1)  then',
'                :P714_OPERADOR_DELETA := ''S'';',
'                :P714_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;    ',
'        else    -- Painel do Colaborador',
'            --',
'            if :P714_COD_SIT_REQ = 1 then',
'                :P714_OPERADOR_DELETA := ''S'';',
'                :P714_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;        ',
'        end if;',
'   end if;',
'end;    '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(141815560792443083927)
,p_process_sequence=>100
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Permite cancelar demais status'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_operador_cancela_requisicoes parametros_recursos_humanos.operador_cancela_requisicoes%type;',
'begin',
'    if :P714_COD_SIT_REQ != 2 then',
'        select operador_cancela_requisicoes',
'            into l_operador_cancela_requisicoes',
'        from parametros_recursos_humanos',
'            where cod_empresa = :P_EMPRESA_USER;',
'        --',
'        if l_operador_cancela_requisicoes = ''S'' and :P_PAINEL = ''PO'' then',
'            :P714_OPERADOR_DELETA_DEMAIS := ''S'';',
'        end if;',
'    end if;',
'end;    '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
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
