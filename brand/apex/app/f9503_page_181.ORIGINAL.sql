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
,p_default_id_offset=>777366879312119448
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9503 - Frequência - Lançamentos
--
-- Application Export:
--   Application:     9503
--   Name:            Frequência - Lançamentos
--   Date and Time:   10:19 Thursday October 1, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 181
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00181
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>181);
end;
/
prompt --application/pages/page_00181
begin
wwv_flow_api.create_page(
 p_id=>181
,p_user_interface_id=>wwv_flow_api.id(199995603908188555028)
,p_name=>unistr('Requisi\00E7\00E3o de Apura\00E7\00E3o')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Requisi\00E7\00E3o de Apura\00E7\00E3o')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Apuracao.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'document.addEventListener("DOMContentLoaded", function () {',
'  var input = document.getElementById("P181_QTD_HORAS_NOVO");',
unistr('  if (!input) return; // Campo n\00E3o existe nessa tela/contexto \00BF n\00E3o faz nada'),
'',
unistr('  // Bloqueia letras, permite s\00F3 n\00FAmeros e backspace'),
'  input.addEventListener("keypress", function (e) {',
'    if (!/[0-9]/.test(e.key)) {',
'      e.preventDefault();',
'    }',
'  });',
'',
'  input.addEventListener("input", function () {',
unistr('    let value = input.value.replace(/\005CD/g, ""); // remove tudo que n\00E3o for n\00FAmero'),
'    ',
'    if (value.length > 4) {',
unistr('      value = value.substring(0, 4); // limita a 4 d\00EDgitos'),
'    }',
'',
'    if (value.length >= 3) {',
'      input.value = value.substring(0, 2) + ":" + value.substring(2);',
'    } else {',
'      input.value = value;',
'    }',
'  });',
'});'))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Apuracao.css'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'900px'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20261001101841'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199861992483336738112)
,p_plug_name=>unistr('BOT\00D5ES')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(199995569917028554921)
,p_plug_display_sequence=>52
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(201812169032662989915)
,p_plug_name=>'Justificativa'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size600x400:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(199995576480671554931)
,p_plug_display_sequence=>72
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202282851174012906003)
,p_plug_name=>unistr('Abonar Marca\00E7\00E3o')
,p_region_name=>'MARCACAO'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>12
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(199861992862389738116)
,p_plug_name=>'MENU'
,p_parent_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_api.id(199995580060398554935)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_source_type=>'NATIVE_DISPLAY_SELECTOR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'STANDARD'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167429715420131886414)
,p_plug_name=>'Eventos'
,p_parent_plug_id=>wwv_flow_api.id(199861992862389738116)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(58881001853226783446)
,p_plug_name=>unistr('Observa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(167429715420131886414)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167429716245549886423)
,p_plug_name=>'Evento Novo'
,p_region_name=>'EVTN'
,p_parent_plug_id=>wwv_flow_api.id(167429715420131886414)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P181_COD_REQ'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211196039180398564084)
,p_plug_name=>'Evento Atual'
,p_parent_plug_id=>wwv_flow_api.id(167429715420131886414)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(211196044159364572314)
,p_plug_name=>'Evento Novo'
,p_region_name=>'EVTN'
,p_parent_plug_id=>wwv_flow_api.id(167429715420131886414)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(199995577911350554934)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NULL'
,p_plug_display_when_condition=>'P181_COD_REQ'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(202282862395243906016)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(199861992862389738116)
,p_template=>wwv_flow_api.id(199995577911350554934)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from aprova_apuracao a    , usuario_oracle u',
' where a.cod_solicitacao = :P181_COD_REQ ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   /*and (not exists (select 1',
'                     from perfil_aprovadores x',
'                    where x.cd_perfil = u.cd_perfil) or ',
'       exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate)))*/',
'union',
'select DISTINCT ''ROWID'', U.CD_PERFIL aprovador, a.dt_aprov Data, a.STATUS_APROV Status, NULL cod_emp_aprov, NULL mat_aprov, MIN(A.SEQ_APROV) SEQ_APROV, a.justificativa',
'  from aprova_apuracao a, usuario_oracle u',
' where a.cod_solicitacao = :P181_COD_REQ ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil',
'              and ativo = ''S'')',
'      and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from aprova_apuracao',
' where cod_solicitacao = :p181_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P181_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(199995586722904554950)
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
 p_id=>wwv_flow_api.id(167426166151831964271)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=PO_&P_BASE.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426166567177964272)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426166998960964272)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426167410212964273)
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
 p_id=>wwv_flow_api.id(167426167770504964273)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426168206864964273)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426168602293964274)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(167426168999898964274)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115498830880371088906)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_button_name=>'SALVAR_JUSTIFICATIVA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-save'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167426154163676964258)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'p181_btn_cancelar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_image_alt=>'Voltar'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115498745958961583694)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_button_name=>'FECHAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_image_alt=>'Fechar'
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(145562706478773211618)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Cancelar Requisi\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_conta number := 0;',
'    v_erro  varchar2(4000);',
'    ',
'    cursor c_datas is',
'    select data_ref_ponto, ind_trava_req_po',
'    from parametros_recursos_humanos',
'    where cod_empresa = :P181_EMP;',
'    r_datas c_datas%rowtype;',
'    ',
'    cursor c_req is',
'    select data_ponto from PE_REQ_APURACAO',
'    where cod_empresa =  :P181_EMP',
'    and cod_req = :P181_COD_REQ;',
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
'                and (:P181_OPERADOR_DELETA = ''S'' or :P181_OPERADOR_DELETA_DEMAIS = ''S'') then',
'                return true;',
'            end if;        ',
'        end if;',
'    else',
'        if (trunc(r_req.data_ponto) > trunc(r_datas.data_ref_ponto)) ',
'            and (:P181_OPERADOR_DELETA = ''S'' or :P181_OPERADOR_DELETA_DEMAIS = ''S'') then',
'            return true;',
'        end if;',
'    end if;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(115498744278495583677)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'JUSTIFICAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Apura\00E7\00E3o Justificativa')
,p_button_position=>'BELOW_BOX'
,p_button_alignment=>'LEFT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_permite_justificar    parametros_recursos_humanos.permite_justificar%type;',
'begin',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    end if;',
'    --',
'    begin',
'        select permite_justificar',
'            into v_permite_justificar',
'            from parametros_recursos_humanos',
'            where cod_empresa = :P181_EMP;',
'    exception ',
'        when others then',
'            v_permite_justificar := ''N'';',
'    end;',
'    if v_permite_justificar = ''S'' then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-commenting-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(144328813909815453586)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'NOVO_CRIAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_condition=>'P181_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_icon_css_classes=>'fa-plus-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(144328814349372453590)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'NOVO_SALVAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Salvar Requisi\00E7\00E3o')
,p_button_position=>'BELOW_BOX'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-save'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167426169421060964274)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(202282862395243906016)
,p_button_name=>'p181_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P181_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno     varchar2(3);',
'v_msg_retorno     varchar2(4000);',
'v_aprova_apuracao varchar2(1);',
'v_cod_sit        pe_req_apuracao.cod_sit_req%type;',
'begin',
'    begin',
'        select cod_sit_req',
'            into v_cod_sit',
'            from pe_req_apuracao',
'            where cod_req = :P181_COD_REQ;',
'    exception',
'        when others then',
'         v_cod_sit := 0;',
'    end;',
'    if v_cod_sit != 1 then',
'        return false;',
'    end if;',
'',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    end if;',
'',
'    PKG_REQ_APURACAO.Valida_Sequencia(nvl( :P181_EMP, :P181_COD_EMP_REQ), :P181_COD_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        begin',
'            select CD_REJEITA_APURACAO',
'                into v_aprova_apuracao',
'                from perfil_aprova_requisicao',
'                where cod_empresa = :P_EMPRESA_USER',
'                and cd_perfil = :P_PERFIL;',
'        exception',
'            when others then',
'                v_aprova_apuracao := ''S'';',
'        end;',
'        if v_aprova_apuracao = ''N'' then',
'            return false;',
'        end if;',
'        if v_aprova_apuracao = ''S'' then',
'            return true;',
'        end if;',
'        return false;',
'',
'    else',
'        return true;',
'    end if;',
' ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167426154640373964259)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(199995598702948554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167426154947484964259)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Criar Requisi\00E7\00E3o')
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-plus'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(167426169785885964274)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(202282862395243906016)
,p_button_name=>'p181_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(199995598876668554978)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P181_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno         varchar2(3);',
'v_msg_retorno         varchar2(4000);',
'v_aprova_apuracao     varchar2(1);',
'v_cod_sit        pe_req_apuracao.cod_sit_req%type;',
'',
'begin',
'    begin',
'        select cod_sit_req',
'            into v_cod_sit',
'            from pe_req_apuracao',
'            where cod_req = :P181_COD_REQ;',
'    exception',
'        when others then',
'         v_cod_sit := 0;',
'    end;',
'    if v_cod_sit != 1 then',
'        return false;',
'    end if;',
'',
'    if :P_PAINEL = ''PC'' then',
'        return false;',
'    end if;',
'',
'    PKG_REQ_APURACAO.Valida_Sequencia(nvl( :P181_EMP, :P181_COD_EMP_REQ), :P181_COD_REQ, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        begin',
'            select cd_aprova_apuracao',
'                into v_aprova_apuracao',
'                from perfil_aprova_requisicao',
'                where cod_empresa = :P_EMPRESA_USER',
'                and cd_perfil = :P_PERFIL;',
'        exception',
'            when others then',
'                v_aprova_apuracao := ''S'';',
'        end;',
'        if v_aprova_apuracao = ''N'' then',
'            return false;',
'        end if;',
'        if v_aprova_apuracao = ''S'' then',
'            return true;',
'        end if;',
'        return false;',
'    else',
'      return true;',
'    end if; ',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(167426196724594964299)
,p_branch_name=>'Voltar'
,p_branch_action=>'f?p=&APP_ID.:138:&SESSION.::&DEBUG.:RP,138:P138_EMP,P138_MAT:&P181_EMP.,&P181_MAT.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21081682404388332784)
,p_name=>'P181_JUSTIFICA_TELA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202282862395243906016)
,p_prompt=>'Justifica Tela'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33570358619982695966)
,p_name=>'P181_EVENTO_CONVERSAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>unistr('Evento Convers\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49627112830797413648)
,p_name=>'P181_HORAS_APURACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(49627112974626413649)
,p_name=>'P181_HORAS_REQUISICAO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>unistr('Horas em Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58881001748947783445)
,p_name=>'P181_OBSERVA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(58881001853226783446)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>3
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58883536572638903021)
,p_name=>'P181_MSG_CLOSE2'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(58883536752692903022)
,p_name=>'P181_CLOSE_PAGE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66764184163089284630)
,p_name=>'P181_OCULTA_BTN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(66764184764657284636)
,p_name=>'P181_MENSAGEM_LIMITE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(110196109622330737845)
,p_name=>'P181_MENSAGEM_BH'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(111109213039440552956)
,p_name=>'P181_POSICAO'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(115498746605474583700)
,p_name=>'P181_ALTERA_EVENTO_JUSTIFICATIVA'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(115498838979933184668)
,p_name=>'P181_JUSTIFICATIVA'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_prompt=>'Justificativa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where pepj.cod_empresa = :P181_EMP',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL ',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+)     ',
'union ',
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where ptj.cod_empresa = :P181_EMP',
'    AND NOT EXISTS (select 3',
'    from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj',
'    where pepj.cod_empresa = :P181_EMP  ',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL)',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+) ',
'order by 2',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(115498839414325184668)
,p_name=>'P181_CCUSTO_CONTABIL'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_prompt=>unistr('C/C Cont\00E1bil')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome, cod from ccusto_contab',
'where cod_empresa = :P181_EMP',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(199995598444609554972)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(115498839808973184668)
,p_name=>'P181_OBSERVACOES'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(201812169032662989915)
,p_prompt=>unistr('Observa\00E7\00F5es')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>200
,p_cHeight=>6
,p_field_template=>wwv_flow_api.id(199995598262344554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'Y'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137753300772997718237)
,p_name=>'P181_COMPARA_EVENTOS'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(137753321795781770527)
,p_name=>'P181_VALIDA_USERS'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138707091886761128700)
,p_name=>'P181_CONSULTA'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(138707092019121128701)
,p_name=>'P181_ALERTA_HORAS_ZERADAS'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140309783242899148093)
,p_name=>'P181_OPERADOR_DELETA_DEMAIS'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(140750711172205233487)
,p_name=>'P181_VALIDA_PERIODO_APROVA'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141349508471744972074)
,p_name=>'P181_COD_JUSTIFICATIVA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Justificativa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where pepj.cod_empresa = :P181_EMP',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL ',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+)     ',
'union ',
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where ptj.cod_empresa = :P181_EMP',
'    AND NOT EXISTS (select 3',
'    from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj',
'    where pepj.cod_empresa = :P181_EMP  ',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL)',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+) ',
'order by 2'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141349508562508972075)
,p_name=>'P181_COD_CCUSTO_CONTABIL'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>unistr('Ccusto Cont\00E1bil')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||nome, cod from ccusto_contab',
'where cod_empresa = :P181_EMP',
'order by 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141349508664082972076)
,p_name=>'P181_COD_JUSTIFICATIVA_DSP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Justificativa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where pepj.cod_empresa = :P181_EMP',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL ',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+)     ',
'union ',
'select distinct ptj.cod_justificativa||'' - ''||initcap(ptj.descricao) descricao, ptj.cod_justificativa',
'from  pe_tipo_justificativa ptj, pe_tipo_ocorrencia o',
'    where ptj.cod_empresa = :P181_EMP',
'    AND NOT EXISTS (select 3',
'    from PE_EVENTOS_PERFIL_JUST pepj ,  pe_tipo_justificativa ptj',
'    where pepj.cod_empresa = :P181_EMP  ',
'    and ptj.cod_empresa = pepj.cod_empresa(+)',
'    and ptj.cod_justificativa = pepj.cod_justificativa(+)',
'    and  pepj.cd_perfil = :P_PERFIL)',
'   and ptj.cod_empresa = o.cod_empresa (+)',
'   and ptj.cod_justificativa = o.cod_justificativa (+) ',
'order by 2'))
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(141349508785902972077)
,p_name=>'P181_COD_CCUSTO_CONTABIL_DSP'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>unistr('Ccusto Cont\00E1bil')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nome, cod from ccusto_contab',
'where cod_empresa = :P181_EMP',
'order by 2'))
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142082619105129262804)
,p_name=>'P181_VALIDA_DATA_PERIODO'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142260956454832821677)
,p_name=>'P181_TIPO_DISP_NOVO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Tipo Solicitado'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(142382330881848065766)
,p_name=>'P181_HORAS_REQ_NAPROV'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145562706211817211615)
,p_name=>'P181_OPERADOR_DELETA'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(145712424594631746689)
,p_name=>'P181_DOIS_PONTOS'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(146885281848929386050)
,p_name=>'P181_MUDA_COD_SIT_REQ'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(148000980250627740810)
,p_name=>'P181_HORAS_NOVO_MAIOR_HORA_ATUAL'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(150255141878980047929)
,p_name=>'P181_AVISO_HORAS_LIMITE'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(153228429006154636790)
,p_name=>'P181_AVISO_CRIACAO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(156122424161359362756)
,p_name=>'P181_CHECAR_APURACAO'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(162489540059152020839)
,p_name=>'P181_TIPO_CODE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163123250870368285194)
,p_name=>'P181_ALTERA_EVENTO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163675115624385094162)
,p_name=>'P181_TOTAL_HORAS_REQUISICOES'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(163749822286571707122)
,p_name=>'P181_TOTAL_APURADO_HORAS_REQ'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(199861992483336738112)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(164814938235185378734)
,p_name=>'P181_COD_EMPRESA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425964113603361015)
,p_name=>'P181_MSG_CLOSE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425964820607361022)
,p_name=>'P181_DATA_PONTO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Data Ponto'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425965867308361033)
,p_name=>'P181_COD_ITEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425965952349361034)
,p_name=>'P181_ID_APURACAO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167425966097134361035)
,p_name=>'P181_DTINI_MARCACAO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426155714281964260)
,p_name=>'P181_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426156100887964261)
,p_name=>'P181_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426156445187964261)
,p_name=>'P181_MENSAGEM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426156896781964261)
,p_name=>'P181_OK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426157253439964261)
,p_name=>'P181_ITEM_VALIDACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426157712925964262)
,p_name=>'P181_COD_REQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>unistr('Solicita\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P181_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426158059955964262)
,p_name=>'P181_DT_REQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P181_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426158469130964262)
,p_name=>'P181_COD_SIT_REQ'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) descricao, cod_sit_req',
'  from SIT_REQ',
' order by 2'))
,p_cHeight=>1
,p_cattributes_element=>'readonly=''readonly'''
,p_display_when=>'P181_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426158889365964262)
,p_name=>'P181_DT_SIT_REQ'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P181_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426159336477964264)
,p_name=>'P181_SOLICITANTE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>'Solicitante'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cargo ',
'  from informacoes_funcionais',
' where cod_empresa = :p181_cod_emp_req',
'   and matricula = :p181_mat_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'return :p181_cod_emp_req||'' - ''||initcap(fnct_nome_empresa(:p181_cod_emp_req))||'' / ''||:p181_mat_req||'' - ''||initcap(fnct_nome_func(:p181_cod_emp_req,:p181_mat_req));',
'',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P181_COD_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426159712191964264)
,p_name=>'P181_EMP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426160097935964264)
,p_name=>'P181_MAT'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426160498422964264)
,p_name=>'P181_COD_EMP_REQ'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426160864007964265)
,p_name=>'P181_MAT_REQ'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426161301817964265)
,p_name=>'P181_FIL_REQ'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426161643268964265)
,p_name=>'P181_COD_EMPRESA_OLD'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA_OLD'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426162044917964265)
,p_name=>'P181_MATRICULA'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426162509204964265)
,p_name=>'P181_USUARIO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426162894071964266)
,p_name=>'P181_DT_ATUALIZACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426170179159964275)
,p_name=>'P181_OBS_APROVADOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202282862395243906016)
,p_prompt=>unistr('Observa\00E7\00E3o do Aprovador')
,p_placeholder=>unistr('Informe alguma observa\00E7\00E3o.')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>2
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select mat_aprov',
'  from APROVA_ABONO',
' where cod_solicitacao = :p181_cod_req',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'''))
,p_read_only_when_type=>'NOT_EXISTS'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426798927621410498)
,p_name=>'P181_TIPO_EVENTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>'Tipo do Evento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>'STATIC:Banco;BANCO,Ponto;PONTO'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426799328729410507)
,p_name=>'P181_COD_EVENTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426799713214410508)
,p_name=>'P181_EVENTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>'Evento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426800110052410508)
,p_name=>'P181_TIPO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>'Tipo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426800484611410508)
,p_name=>'P181_QTD_HORAS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>'Qtde. Horas'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426800880437410508)
,p_name=>'P181_DATA'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>'Data'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426801322438410509)
,p_name=>'P181_BH_APURADO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(211196039180398564084)
,p_prompt=>unistr('Apura\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426803807642418718)
,p_name=>'P181_TIPO_EVENTO_NOVO'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Tipo do Evento Solicitado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Banco;BANCO,Ponto;PONTO'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426804224943418718)
,p_name=>'P181_COD_EVENTO_NOVO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Evento Solicitado'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select * from PKG_LIST_EVENTOS.fnc_list1(P_TIPO_EVENTO_NOVO =>:P181_TIPO_EVENTO_NOVO,',
'                                       P_TIPO_EVENTO =>:P181_TIPO_EVENTO,',
'                                       P_COD_EVENTO =>:P181_COD_EVENTO,',
'                                       P_EMP =>:P181_EMP,',
'                                       P_TIPO =>:P181_TIPO_CODE,',
'                                       P_PERFIL =>:P_PERFIL,',
'                                       P_ORIGEM =>:P181_ORIGEM',
'                                        );'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P181_TIPO_EVENTO_NOVO,P181_ORIGEM'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426804612756418720)
,p_name=>'P181_TIPO_NOVO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426805420518418720)
,p_name=>'P181_ORIGEM'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_item_default=>'1'
,p_prompt=>'Origem '
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Atual;1,Remanescente;2'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426805841611418720)
,p_name=>'P181_SALDO_REMAN'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Saldo Remanescente'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426806165738418720)
,p_name=>'P181_ROWID_REMAN'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167426806574413418721)
,p_name=>'P181_QTD_HORAS_NOVO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(211196044159364572314)
,p_prompt=>'Qtde. Horas'
,p_placeholder=>'HH:MM'
,p_format_mask=>'HH:MM'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>5
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429715617902886416)
,p_name=>'P181_MAT_COLABORADOR'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716382388886424)
,p_name=>'P181_TIPO_EVENTO_NOVO_DSP'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Tipo do Evento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>'STATIC:Banco;BANCO,Ponto;PONTO'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716446651886425)
,p_name=>'P181_COD_EVENTO_NOVO_DSP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Evento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select COD_EVENTO_FOLHA||'' - ''||e.DESCRICAO descricao, e.COD_EVENTO_FOLHA COD_EVENTO  ',
'from pe_eventos_folha e --, pe_eventos_banco b',
'where 1=1 --a.cod_empresa = b.cod_empresa',
'--and a.coeficiente = b.coeficiente_ponto',
'and e.cod_empresa = :P181_EMP',
'and folha = ''S''',
'and ''PONTO'' = :p181_tipo_evento_novo',
'union',
'select COD_EVENTO_BANCO||'' - ''||e.DESCRICAO descricao, e.COD_EVENTO_BANCO COD_EVENTO  ',
'from pe_eventos_banco e',
'where 1=1 --a.cod_empresa = b.cod_empresa',
'--and a.coeficiente = b.coeficiente_ponto',
'and e.cod_empresa = :P181_EMP',
'and ''BANCO'' = :p181_tipo_evento_novo',
'order by 2'))
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716654018886427)
,p_name=>'P181_TIPO_DISP_NOVO_DSP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Tipo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716832993886428)
,p_name=>'P181_ORIGEM_DSP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716868536886429)
,p_name=>'P181_SALDO_REMAN_DSP'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429716955489886430)
,p_name=>'P181_ROWID_REMAN_DSP'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429717095097886431)
,p_name=>'P181_QTD_HORAS_NOVO_DSP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Qtde. Horas'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429717186022886432)
,p_name=>'P181_DATA_PONTO_DSP'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>'Data'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167429717326043886433)
,p_name=>'P181_BH_APURADO_DSP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(167429716245549886423)
,p_prompt=>unistr('Apura\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(199995598360072554971)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(167431009209861936396)
,p_name=>'P181_NOVA_REQUISICAO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(202282851174012906003)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(71960765941353928637)
,p_validation_name=>'Valida Banco Horas'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    cursor c_param is',
'    select nvl(ind_operador_limite_bh, ''N'') parametro',
'    from parametros_recursos_humanos',
'    where cod_empresa = :P181_EMP;',
'    ',
'    r_param    c_param%rowtype;',
'    v_erro     varchar2(4000);',
'begin',
'    open c_param;',
'    fetch c_param into r_param;',
'    close c_param;',
'    ',
'    if r_param.parametro = ''S'' and :P_PAINEL = ''PO'' then ',
'        return null;',
'    else',
'        if :P181_TIPO_NOVO = ''C'' then',
'            v_erro :=  ',
'            FNCT_VALIDA_HORAS_BANCO (    P_COD_EMPRESA  => :P181_EMP',
'                                                   , P_MATRICULA   => :P181_MAT',
'                                                   , P_EVENTO      => :P181_COD_EVENTO_NOVO',
'                                                   , P_USUARIO     => :P_USUARIO',
'                                                   , P_PAINEL => :P_PAINEL);',
'',
'            return v_erro;',
'        end if;',
'    end if;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_associated_item=>wwv_flow_api.id(167426804224943418718)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(144328814695279453594)
,p_validation_name=>'Valida Horas Atuais x Horas Informadas '
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P181_QTD_HORAS_NOVO > :P181_QTD_HORAS then',
unistr('    return ''(6) Horas Informadas (''||:P181_QTD_HORAS_NOVO||'') n\00E3o pode ser Maior que Qtd.Horas (''||:P181_QTD_HORAS||'')'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(144335297237909835945)
,p_validation_name=>'Compara Limite com Horas Informadas'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    :P181_MENSAGEM_BH:= FNCT_VALIDA_HORAS_BANCO (    P_COD_EMPRESA  => :P181_EMP',
'                                                   , P_MATRICULA   => :P181_MAT',
'                                                   , P_EVENTO      => :P181_COD_EVENTO_NOVO',
'                                                   , P_USUARIO     => :P_USUARIO',
'                                                   , P_PAINEL => :P_PAINEL);',
'',
'/*',
'declare',
'    l_erro varchar2(1000) := null;',
'begin',
'    l_erro := PKG_REQ_APURACAO.fnt_calcula_limite(P181_EMP             => :P181_EMP,',
'                                                  P181_MAT             => :P181_MAT,',
'                                                  P181_QTD_HORAS_NOVO  => :P181_QTD_HORAS_NOVO,',
'                                                  P_PERFIL             => :P_PERFIL,',
'                                                  P_PAINEL             => :P_PAINEL,',
'                                                  P181_DATA            => :P181_DATA,',
'                                                  P181_TIPO_DISP_NOVO  => :P181_TIPO_DISP_NOVO);',
'    if l_erro  is not null then                                            ',
'    return ''(1) ''||l_erro;',
'    end if;',
'    return null;',
'end; */',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(144335297387351835946)
,p_validation_name=>unistr('Valida Horas em Requisi\00E7\00E3o')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'l_contador  number := 0;',
'    l_limite number := 0;',
'    l_horas  number := 0;',
'    l_horas_req number := 0;',
'    l_horas_info number := 0;',
'    l_min_req number := 0;',
'    l_min_info number := 0;',
'    l_horas_var    varchar2(100); l_min_var      varchar2(100);    ',
'    l_horas_lim    varchar2(100); l_min_lim      varchar2(100);        ',
'begin',
'',
'      begin',
'        select 1',
'          into l_contador',
'          from pe_folgas',
'        where cod_empresa = :P181_EMP',
'        and matricula = :P181_MAT',
'        and dt_folga = :P181_DATA;',
'      exception',
'        when others then',
'           l_contador := 0;',
'      end;',
'      if l_contador = 1 then',
'         return null;',
'      end if;',
'    if :P181_TIPO_NOVO = ''C'' then',
'        begin',
'            select nvl((substr(hora_limite_abono, 1, instr(hora_limite_abono, '':'')-1) + substr(hora_limite_abono, instr(hora_limite_abono, '':'')+1 )) * 60 ,0)',
'                into l_limite',
'            from pe_perfil_abono_geral',
'            where cod_empresa = :P181_EMP',
'            and cd_perfil = :P_PERFIL;',
'        exception',
'          when others then',
'            l_limite := 0;',
'        end;',
'        --',
'        begin',
'            select nvl((to_number(substr(:P181_QTD_HORAS_NOVO, 1, instr(:P181_QTD_HORAS_NOVO, '':'')-1))*60), 0) --horas_info',
'                     , nvl((to_number(substr(:P181_QTD_HORAS_NOVO, instr(:P181_QTD_HORAS_NOVO, '':'')+1)) ), 0) --min_info',
'                 into l_horas_info',
'                    , l_min_info',
'            from dual;    ',
'        exception',
'            when others then',
'                l_horas_info := 0;',
'                l_min_info:= 0;',
'        end;',
'        --',
'        begin',
'           select nvl(sum(',
'                (to_number(substr(qtd_horas, 1, instr(qtd_horas, '':'')-1))*60) ',
'                + (to_number(substr(qtd_horas, instr(qtd_horas, '':'')+1))) --horas_req',
'                ), 0)',
'               into l_horas_req',
'            from pe_req_apuracao a',
'            where cod_empresa = :P181_EMP',
'            and matricula = :P181_MAT',
'            and data_ponto = :P181_DATA',
'            and tipo = ''C''',
'            AND cod_sit_req in (1,2);',
'        exception',
'            when others then',
'                l_horas_req := 0;',
'        end;',
'        --',
'        l_horas := to_number(l_horas_req)+to_number(l_horas_info)+to_number(l_min_info);',
'        if l_limite > 0 then',
'            if to_number(l_horas) > to_number(l_limite) then',
'                l_horas_var := to_char(l_horas/60);',
'                l_min_var := l_horas_var - trunc(l_horas_var);',
'                l_min_var := round(l_min_var * 60,2);',
'                --',
'                l_horas_lim := to_char(l_limite/60);',
'                l_min_lim := l_horas_lim - trunc(l_horas_lim);',
'                l_min_lim := round(l_min_lim * 60,2);',
'',
unistr('                return ''(2) Total de Horas em Requisi\00E7\00E3o + Qtde. Horas Informadas = (''||to_char(trunc(l_horas_var))||'':''||lpad(l_min_var, 2, ''0'')||'),
unistr('                            '') ultrapassa o Limite de Horas Di\00E1rio. (''||to_char(trunc(l_horas_lim))||'':''||lpad(l_min_lim, 2, ''0'')||'')'';'),
'            end if;',
'        end if;',
'    end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(143525277381663260230)
,p_validation_name=>'Valida Saldo Remanescente'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P181_ORIGEM = 2 then',
'    if :P181_SALDO_REMAN = ''00:00'' or :P181_SALDO_REMAN is null then',
unistr('        return ''(3) Requisi\00E7\00E3o n\00E3o pode ser criada. N\00E3o existe Saldo Remanescente'';'),
'    end if;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426805841611418720)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(141883440767641265276)
,p_validation_name=>unistr('Hora n\00E3o pode ser nula')
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P181_QTD_HORAS_NOVO is null then',
unistr('    return ''(4) Informe as horas para a requisi\00E7\00E3o.'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426806574413418721)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(141668976113619239602)
,p_validation_name=>unistr('Hora n\00E3o pode ser 00:00')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P181_QTD_HORAS_NOVO = ''00:00'' then',
unistr('    return ''(5) Informe as horas para a requisi\00E7\00E3o diferente de [00:00].'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426806574413418721)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(137757718822723662946)
,p_validation_name=>unistr('Valida datas para apura\00E7\00E3o')
,p_validation_sequence=>80
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
'	   WHERE cod_empresa = :P181_emp;',
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
'      IF :P181_data < v_data_ref_ponto THEN',
'          --',
'         return(''Data fora do limite permitido: '' || v_data_ref_ponto);',
'      --',
'      END IF;',
'  end if;',
'--',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426800880437410508)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52286163068809261204)
,p_validation_name=>'Horas diponiveis por evento'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'    v_horas_apuracao         varchar2(12);',
'    v_horas_requisicao       varchar2(12);    ',
'    v_minuto_apuracao        varchar2(12);',
'    v_minuto_requisicao      varchar2(12);',
'    APURACAO VARCHAR2(10);',
'    REQUISICAO VARCHAR2(10);',
'    saldoH  VARCHAR2(10);',
'    saldoM  VARCHAR2(10);',
'    saldo  VARCHAR2(10);',
'',
'BEGIN',
'    SELECT TO_HOURS(  NVL(Fnct_Tot_Horas(NVL(SUM(horas), 0), NVL(SUM(minutos), 0)),   0) )',
'               INTO APURACAO',
'        FROM (SELECT SUM(SUBSTR(RA.QTD_HORAS,',
'                                1,',
'                                INSTR(RA.QTD_HORAS, '':'') - 1) ) horas,',
'                     SUM(SUBSTR(RA.QTD_HORAS, INSTR(RA.QTD_HORAS, '':'') + 1) ) minutos',
'    from pe_resultado_apuracao RA',
'    where cod_empresa = :P181_EMP',
'       and matricula = :P181_MAT ',
'       and TO_CHAR(data, ''DD/MM/YYYY'') = :P181_DATA',
'       and cod_evento  = :P181_COD_EVENTO );',
'',
'    SELECT TO_HOURS(  NVL(Fnct_Tot_Horas(NVL(SUM(horas), 0), NVL(SUM(minutos), 0)),   0) )',
'               INTO REQUISICAO',
'        FROM (SELECT SUM(SUBSTR(RA.QTD_HORAS,',
'                                1,',
'                                INSTR(RA.QTD_HORAS, '':'') - 1) ) horas,',
'                     SUM(SUBSTR(RA.QTD_HORAS, INSTR(RA.QTD_HORAS, '':'') + 1) ) minutos',
'    from pe_req_apuracao RA',
'    where cod_empresa = :P181_EMP',
'       and matricula = :P181_MAT ',
'       and TO_CHAR(data_ponto, ''DD/MM/YYYY'') = :P181_DATA',
'       and cod_evento_atual = :P181_COD_EVENTO',
'    and cod_sit_req = 1); ',
'    ',
'    v_horas_apuracao      := SUBSTR(APURACAO, 1, INSTR(APURACAO, '':'') -1);           ',
'    v_horas_requisicao    := SUBSTR(REQUISICAO, 1, INSTR(REQUISICAO, '':'') -1);        ',
'    v_minuto_apuracao     := SUBSTR(APURACAO, INSTR(APURACAO, '':'') +1);   ',
'    v_minuto_requisicao   := SUBSTR(REQUISICAO, INSTR(REQUISICAO, '':'') +1);  ',
'    ',
'    saldoH :=  (v_horas_apuracao - v_horas_requisicao);',
'    saldoM :=  (v_minuto_apuracao - v_minuto_requisicao);',
'    saldo := to_hours(Fnct_Tot_Horas((v_horas_apuracao - v_horas_requisicao) , (v_minuto_apuracao - v_minuto_requisicao)));',
'    ',
'    DELETE FROM TESTEX WHERE TEXTO LIKE ''ANDRE%'';',
'    INSERT INTO TESTEX VALUES (-1001, ''ANDRE - APURACAO = ''||APURACAO);',
'    INSERT INTO TESTEX VALUES (-1002, ''ANDRE - REQUISICAO = ''||REQUISICAO);',
'    INSERT INTO TESTEX VALUES (-1003, ''ANDRE - saldoH = ''||saldoH);',
'    INSERT INTO TESTEX VALUES (-1004, ''ANDRE - saldoM = ''||saldoM);',
'    INSERT INTO TESTEX VALUES (-1005, ''ANDRE - saldo = ''||saldo);',
'    COMMIT;',
'    if saldo < :P181_QTD_HORAS_NOVO then',
unistr('        return ''J\00E1 existe(m) uma requisi\00E7\00E3o(\00F5es) para esta <br />''||'),
'                                                    ''Empresa = ''||:P181_EMP||''<br />''||',
'                                                    ''Matricula = ''||:P181_MAT||''<br />''||',
'                                                    ''Evento = ''||:P181_COD_EVENTO||''<br />''||',
'                                                    ''Data = ''||:P181_DATA_PONTO||''<br />''||',
'                                                    ''Horas Restantes = ''||saldo;',
'    end if;    ',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(144328813909815453586)
,p_associated_item=>wwv_flow_api.id(167426806574413418721)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(26693732867936398434)
,p_validation_name=>unistr('Hora n\00E3o pode maior que')
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    if :P181_TIPO_NOVO = ''C'' then',
'        return',
'        PKG_REQ_APURACAO.FNCT_VALIDA_HORAS_BANCO( P_COD_EMPRESA => :P181_EMP',
'                                                , P_MATRICULA   => :P181_MAT',
'                                                , P_EVENTO      => :P181_COD_EVENTO_NOVO',
'                                                , P_HORAS_INFO  => :P181_QTD_HORAS_NOVO',
'                                                , P_PONTO       => :P181_DATA',
'                                                , P_USUARIO     => :P_USUARIO',
'                                                , P_PAINEL      => :P_PAINEL',
'                                                , P_PERFIL      => :P_PERFIL);',
'    ',
'    end if;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426806574413418721)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3771760976977530227)
,p_validation_name=>unistr('Minutos n\00E3o pode ser maior que 59 Min.')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  vNumHr     NUMBER        DEFAULT 0;',
'BEGIN',
'  IF :P181_QTD_HORAS_NOVO IS NOT NULL THEN',
'    vNumHr := TO_NUMBER(SUBSTR(:P181_QTD_HORAS_NOVO, INSTR(:P181_QTD_HORAS_NOVO, '':'')+1)) / 60;',
'    --',
'    IF ROUND(vNumHr,3) > 0.983333333333333 THEN',
unistr('      vReturn := ''Minutos [''||SUBSTR(:P181_QTD_HORAS_NOVO, INSTR(:P181_QTD_HORAS_NOVO, '':'')+1)||''] N\00C3O pode ser maior que 59!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(167426806574413418721)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(137753322216040770531)
,p_name=>'Valida P_EMPRESA_USER e P_MATRICULA_USER;'
,p_event_sequence=>5
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137753322280484770532)
,p_event_id=>wwv_flow_api.id(137753322216040770531)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P_EMPRESA_USER is null or :P_MATRICULA_USER is null then',
'    :P181_VALIDA_USERS := ''S'';',
'end if;',
''))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER'
,p_attribute_03=>'P181_VALIDA_USERS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(146885281251924386044)
,p_name=>unistr('Valida situa\00E7\00E3o x combo de situa\00E7\00E3o e bot\00E3o salvar')
,p_event_sequence=>275
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(146885281359861386045)
,p_event_id=>wwv_flow_api.id(146885281251924386044)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_COD_SIT_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(146885281483996386046)
,p_event_id=>wwv_flow_api.id(146885281251924386044)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(167426154640373964259)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167426194821695964299)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>295
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(167426169785885964274)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167426195267855964299)
,p_event_id=>wwv_flow_api.id(167426194821695964299)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167426195699629964299)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>305
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(167426169421060964274)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167426196204315964299)
,p_event_id=>wwv_flow_api.id(167426195699629964299)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167425963395557361008)
,p_name=>'post-change-cod_evento_novo'
,p_event_sequence=>315
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COD_EVENTO_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167425963513994361009)
,p_event_id=>wwv_flow_api.id(167425963395557361008)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
unistr('select decode(tipo_rubrica, 1, ''Cr\00E9dito'', 2, ''D\00E9bito'', 3, ''Base'') tipo_Desc, to_char(cod_ocorr) tipo, FOLHA folha'),
'  from pe_eventos_folha f, ocorr_pagto op',
' where ',
'  op.cod_empresa = f.cod_empresa ',
' and op.cod = f.cod_ocorr',
'    and f.cod_empresa = :p181_emp',
'   and f.cod_evento_folha = :P181_COD_EVENTO_NOVO --p214_cod_evento_novo',
'   and :p181_tipo_evento_novo = ''PONTO''',
'union ',
unistr('select decode(b.tipo,''C'',''Cr\00E9dito'',''D'',''D\00E9bito'') tipo_Desc, b.tipo tipo, ''S'' Folha'),
'  from pe_eventos_banco b',
' where b.cod_empresa = :p181_emp',
'   and b.cod_evento_banco = :P181_COD_EVENTO_NOVO --p214_cod_evento_novo',
'   and :p181_tipo_evento_novo = ''BANCO'';',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    :p181_tipo_novo := '''';',
'	:p181_tipo_disp_novo := '''';',
'    :p181_tipo_disp_novo := v_c1.tipo_desc;',
'    if v_c1.tipo is not null then',
'        :p181_tipo_novo := v_c1.tipo;',
'        if v_c1.folha = ''S'' then',
'        :p181_tipo_disp_novo := v_c1.tipo_desc;',
'        end if;',
'    end if;',
'',
'exception',
'    when others then',
'        :p181_tipo_disp_novo := ''Erro'';',
'end;',
''))
,p_attribute_02=>'P181_COD_EVENTO_NOVO'
,p_attribute_03=>'P181_TIPO_NOVO,P181_TIPO_DISP_NOVO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167431010362642936408)
,p_name=>'post-change-cod_evento_busca_sel'
,p_event_sequence=>325
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COD_EVENTO_SEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167431010509431936409)
,p_event_id=>wwv_flow_api.id(167431010362642936408)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
unistr('select case WHEN :p_base <> ''PREVCOM'' and f.cod_ocorr < 500 THEN ''Cr\00E9dito'' '),
unistr('            WHEN :p_base <> ''PREVCOM'' and f.cod_ocorr >= 500 THEN ''D\00E9bito'''),
unistr('            WHEN :p_base = ''PREVCOM'' and f.cod_ocorr < 5000 THEN ''Cr\00E9dito'' '),
unistr('            WHEN :p_base = ''PREVCOM'' and f.cod_ocorr >= 5000 THEN ''D\00E9bito''end tipo_Desc, '),
'       case WHEN :p_base <> ''PREVCOM'' and f.cod_ocorr < 500 THEN ''C'' ',
'            WHEN :p_base <> ''PREVCOM'' and f.cod_ocorr >= 500 THEN ''D'' ',
'            WHEN :p_base = ''PREVCOM'' and f.cod_ocorr < 5000 THEN ''C'' ',
'            WHEN :p_base = ''PREVCOM'' and f.cod_ocorr >= 5000 THEN ''D'' end tipo,',
'       FOLHA folha',
'  from pe_eventos_folha f',
' where f.cod_empresa = :P181_EMP',
'   and f.cod_evento_folha = :p181_cod_evento_novo',
'   and :p181_tipo_evento_novo = ''PONTO''',
'union ',
unistr('select decode(b.tipo,''C'',''Cr\00E9dito'',''D'',''D\00E9bito'') tipo_Desc, b.tipo tipo, ''S'' Folha'),
'  from pe_eventos_banco b',
' where b.cod_empresa = :P181_EMP',
'   and b.cod_evento_banco = :p181_cod_evento_novo',
'   and :p181_tipo_evento_novo = ''BANCO'';',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    :p181_tipo_novo := '''';',
'	:p181_tipo_disp_novo := '''';',
'    if v_c1.tipo is not null then',
'        :p181_tipo_sel := v_c1.tipo;',
'        if v_c1.folha = ''S'' then',
'        :p181_tipo_disp_sel := v_c1.tipo_desc;',
'        end if;',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P181_COD_EVENTO_SEL'
,p_attribute_03=>'P181_TIPO_SEL,P181_TIPO_DISP_SEL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167429715134341886411)
,p_name=>'Cancel Dialog'
,p_event_sequence=>345
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(167426154163676964258)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167429715230158886412)
,p_event_id=>wwv_flow_api.id(167429715134341886411)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167431008379572936388)
,p_name=>'alt_P181_ORIGEM'
,p_event_sequence=>355
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_ORIGEM'
,p_condition_element=>'P181_ORIGEM'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167431008461051936389)
,p_event_id=>wwv_flow_api.id(167431008379572936388)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_SALDO_REMAN'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167431008544909936390)
,p_event_id=>wwv_flow_api.id(167431008379572936388)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_SALDO_REMAN'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142686452750919006405)
,p_name=>'HIDE P181_ORIGEM'
,p_event_sequence=>365
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142686453000335006407)
,p_event_id=>wwv_flow_api.id(142686452750919006405)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_SALDO_REMAN'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(167431008681198936391)
,p_name=>'Define_P181_SALDO_REMAN'
,p_event_sequence=>375
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_ORIGEM'
,p_condition_element=>'P181_ORIGEM'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(167431008844468936393)
,p_event_id=>wwv_flow_api.id(167431008681198936391)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P181_SALDO_REMAN := ''00:00'';',
':P181_ROWID_REMAN := '''';'))
,p_attribute_02=>'P181_SALDO_REMAN,P181_ROWID_REMAN'
,p_attribute_03=>'P181_SALDO_REMAN,P181_ROWID_REMAN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163675115438277094160)
,p_name=>'Valida Req Abertas x Total horas'
,p_event_sequence=>385
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163675115509148094161)
,p_event_id=>wwv_flow_api.id(163675115438277094160)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_total_requisicoes NUMBER := 0;',
'    l_total_horas       NUMBER := 0;',
'    l_erro    varchar2(4000);',
'begin',
'    if :P181_COD_REQ is null then',
'        begin',
'            select nvl(sum(substr(trim(QTD_HORAS), 1, 2)+round((substr(trim(QTD_HORAS), 4, 2)/100),2)), 0)',
'                into l_total_requisicoes',
'            from pe_req_apuracao',
'                where cod_emp_req = :P181_EMP',
'                and matricula = :P181_MAT ',
'                and cod_evento_atual = :P181_COD_EVENTO',
'                and cod_item = :P181_COD_ITEM',
'                and data_ponto = to_date(:P181_DATA_PONTO, ''dd/mm/yyyy'')',
'                and COD_SIT_REQ not in (3, 4);',
'        exception ',
'            when others then',
'                l_total_requisicoes := 0;',
'        end;',
'        --',
'        begin',
'            /*select nvl(sum((substr(trim(qtd_horas), 1,2) + (substr(trim(qtd_horas), 4,2)/100))), 0)',
'            into l_total_horas',
'             from pe_resultado_apuracao',
'            where cod_empresa = :P181_EMP',
'            and matricula = :P181_MAT',
'            and data = to_date(:P181_DATA, ''dd/mm/yyyy'')',
'            and cod_item = :P181_COD_ITEM',
'            and cod_evento = :P181_COD_EVENTO;*/',
'            ',
'            select nvl(sum((substr(trim(qtd_horas_ant), 1,2) + (substr(trim(qtd_horas_ant), 4,2)/100))), 0)',
'            into l_total_horas',
'             from PE_HIST_RESUL_APURACAO',
'            where cod_empresa = :P181_EMP',
'            and matricula = :P181_MAT',
'            and data = to_date(:P181_DATA, ''dd/mm/yyyy'')',
'            --and cod_item = :P181_COD_ITEM',
'            and cod_evento_ant = :P181_COD_EVENTO;',
'                        ',
'            ',
'            ',
'        exception ',
'            when others then',
'                l_total_horas := 0;',
'        end;',
'        --  ',
'        if to_number(l_total_horas) >= to_number(l_total_requisicoes) then',
'             :P181_TOTAL_HORAS_REQUISICOES := null;',
'        else',
'            :P181_TOTAL_HORAS_REQUISICOES := l_total_requisicoes;        ',
'        end if;    ',
'    end if;',
'exception',
'    when others then',
'        l_erro := SQLERRM;',
'        :P181_TOTAL_HORAS_REQUISICOES := null;',
'end;'))
,p_attribute_02=>'P181_EMP,P181_MAT,P181_COD_EVENTO,P181_DATA_PONTO'
,p_attribute_03=>'P181_TOTAL_HORAS_REQUISICOES'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163675115720796094163)
,p_name=>'Mostra mensagem total de horas'
,p_event_sequence=>395
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_TOTAL_HORAS_REQUISICOES'
,p_condition_element=>'P181_TOTAL_HORAS_REQUISICOES'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163675115762575094164)
,p_event_id=>wwv_flow_api.id(163675115720796094163)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Requisi\00E7\00E3o de Apura\00E7\00E3o N\00C3O Permitida!!</strong><br>Ultrapassado o n\00FAmero de horas para o empresa / matricula / evento / data</strong>')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163675116271608094169)
,p_event_id=>wwv_flow_api.id(163675115720796094163)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163749822356836707123)
,p_name=>unistr('Checagem total de horas apuradas e em requisi\00E7\00F3es')
,p_event_sequence=>405
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_TOTAL_APURADO_HORAS_REQ'
,p_condition_element=>'P181_TOTAL_APURADO_HORAS_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163749822446490707124)
,p_event_id=>wwv_flow_api.id(163749822356836707123)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(2)<strong>Requisi\00E7\00E3o de Apura\00E7\00E3o N\00C3O Permitida!!</strong><br>Ultrapassado o n\00FAmero de horas para o <strong>empresa / matricula / evento / data</strong>')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163749822976678707129)
,p_event_id=>wwv_flow_api.id(163749822356836707123)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163123250678518285192)
,p_name=>'Valida se pode tratar pelo tipo de evento'
,p_event_sequence=>415
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163123250805739285193)
,p_event_id=>wwv_flow_api.id(163123250678518285192)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_permite pe_eventos_folha.permite_tratamento%type;',
'begin',
'    if NVL( :P181_CONSULTA , ''S'') != ''C'' then',
'        select permite_tratamento',
'            into l_permite',
'        from pe_eventos_folha ',
'        where COD_EMPRESA =:P181_EMP',
'        and COD_EVENTO_FOLHA = :P181_COD_EVENTO;',
'',
'        if l_permite = ''N'' then',
'            :P181_ALTERA_EVENTO := 1;',
'        else',
'            :P181_ALTERA_EVENTO := NULL;',
'        end if;',
'    end if;',
'exception',
'    when others then',
'        :P181_ALTERA_EVENTO := NULL;',
'end;'))
,p_attribute_02=>'P181_EMP,P181_COD_EVENTO,P181_CONSULTA'
,p_attribute_03=>'P181_ALTERA_EVENTO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(163123251032339285195)
,p_name=>unistr('Mensagem se pode tratar ou n\00E3o')
,p_event_sequence=>425
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_ALTERA_EVENTO'
,p_condition_element=>'P181_ALTERA_EVENTO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163123251087006285196)
,p_event_id=>wwv_flow_api.id(163123251032339285195)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(3) Este tipo de evento n\00E3o pode ser tratado !')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(163123251197523285197)
,p_event_id=>wwv_flow_api.id(163123251032339285195)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156981901703667698673)
,p_name=>'Valida formato hora'
,p_event_sequence=>435
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_FORMATO_HORA'
,p_condition_element=>'P181_FORMATO_HORA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156981901774178698674)
,p_event_id=>wwv_flow_api.id(156981901703667698673)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Formato de hora inv\00E1lido. Informe a hora no formato HH:MM.')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122423988520362754)
,p_name=>unistr('Valida se tem requisi\00E7\00E3o de abono')
,p_event_sequence=>445
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122424031831362755)
,p_event_id=>wwv_flow_api.id(156122423988520362754)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    CURSOR creq IS ',
'        SELECT COUNT(*)  as contador',
'            FROM  PE_REQ_TRATAMENTO_BATIMENTOS',
'        WHERE COD_EMPRESA = :P181_EMP',
'        AND MATRICULA = :P181_MAT',
'        AND DATA_PONTO = TO_DATE(:P181_DATA, ''DD/MM/YYYY'')',
'        AND COD_SIT_REQ not in ( 2, 3, 4 );',
'    r_req creq%ROWTYPE;        ',
'',
'begin',
'    if :P181_CONSULTA = ''C'' then     ',
'        :P181_CHECAR_APURACAO := NULL;    ',
'        OPEN creq;',
'        FETCH creq INTO r_req;',
'        CLOSE creq;',
'',
'        IF r_req.contador > 0 OR r_req.contador IS NULL THEN',
'            :P181_CHECAR_APURACAO := r_req.contador;',
'        ELSE',
'            :P181_CHECAR_APURACAO := NULL;    ',
'        END IF;    ',
'    end if;',
'exception',
'    when others then',
'        :P181_CHECAR_APURACAO := NULL;',
'end;'))
,p_attribute_02=>'P181_EMP,P181_MAT,P181_DATA_PONTO,P181_CONSULTA'
,p_attribute_03=>'P181_CHECAR_APURACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122424310935362757)
,p_name=>'Mostra Mensagem Quando Tem Req Abono'
,p_event_sequence=>455
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_CHECAR_APURACAO'
,p_condition_element=>'P181_CHECAR_APURACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122424330822362758)
,p_event_id=>wwv_flow_api.id(156122424310935362757)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(4) Colaborador tem requisi\00E7\00E3o de abono para a data de ponto')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122424464087362759)
,p_event_id=>wwv_flow_api.id(156122424310935362757)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122425479808362769)
,p_name=>'Valida Sit Req'
,p_event_sequence=>465
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122425611997362770)
,p_event_id=>wwv_flow_api.id(156122425479808362769)
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
'  from pe_req_apuracao',
' where cod_req = :P181_COD_REQ;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'    begin',
'         -- Passa a considerar o parametro de operador cancela a requisicao - ANDRE - 13-10-2023',
'        select operador_cancela_requisicoes',
'            into v_cancela',
'            from parametros_recursos_humanos',
'            where cod_empresa = :P181_EMP;',
'    exception',
'        when others then',
'            v_cancela := ''N'';',
'    end;',
'    --',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    if v_c1.mat_req != :P_MATRICULA_USER then',
'        if :P181_COD_SIT_REQ = 3 then',
'            if v_cancela = ''N'' then',
unistr('                :P181_MUDA_COD_SIT_REQ := ''Somente o usu\00E1rio solocitante pode cancelar a requisi\00E7\00E3o'';'),
'            end if;',
'        end if;    ',
'    else',
'        :P181_MUDA_COD_SIT_REQ := null;',
'    end if;',
'exception',
'when others then null;',
'end;',
''))
,p_attribute_02=>'P181_EMP,P181_COD_REQ,P181_COD_SIT_REQ,P181_MAT'
,p_attribute_03=>'P181_MUDA_COD_SIT_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122425705780362771)
,p_name=>'Dispara Mensagem'
,p_event_sequence=>475
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122425761830362772)
,p_event_id=>wwv_flow_api.id(156122425705780362771)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P181_FLAG'').value == "Q") {',
'alertify.confirm($v(''P181_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P181_FLAG'').value = ''S'';',
'        $x(''P181_MENSAGEM'').value = '''';',
'        $x(''P181_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P181_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P181_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P181_FLAG'').value == "N") {',
'            $x(''P181_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P181_MENSAGEM''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P181_ITEM_VALIDACAO'').value == ''P181_CREATE''){',
'            $x(''P181_OK'').value = ''S'';',
'        $x(''P181_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(156122425893722362773)
,p_name=>'Save'
,p_event_sequence=>485
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(167426154640373964259)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122425946210362774)
,p_event_id=>wwv_flow_api.id(156122425893722362773)
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
'cursor c_req is',
'select cod_sit_req',
'  from PE_REQ_APURACAO',
' where cod_req = :P181_COD_REQ;',
'',
'v_req c_req%rowtype;',
'',
'begin',
'    PKG_REQ_APURACAO.Valida_Sit_Req(:P181_EMP, :P181_COD_REQ, :P181_MAT, :P181_COD_SIT_REQ, :p_usuario, v_flg_retorno, v_msg_retorno, :p_painel);',
'',
' if v_flg_retorno <> ''N'' and trim(v_msg_retorno) is null or (:P181_COD_SIT_REQ = 3) then',
'    update PE_REQ_APURACAO',
'       set cod_sit_req = :P181_COD_SIT_REQ,',
'           dt_sit_req = sysdate,',
'           usuario = :p_usuario,',
'           dt_atualizacao = sysdate',
'     where cod_req = :P181_COD_REQ;',
'     ',
' end if;',
' if :P181_COD_SIT_REQ != 3 then',
'',
'    PKG_REQ_APURACAO.Post_Update(:P181_EMP,',
'                                    :P181_COD_REQ,',
'                                    V_flg_retorno,',
'                                    V_msg_retorno);',
'',
' end if;',
' if v_msg_retorno is not null then',
'    :p181_ok       := ''N'';',
'    :p181_FLAG     := v_flg_retorno;',
'    :p181_mensagem := v_msg_retorno;',
' else',
'    :p181_flag     := null;',
'    :p181_mensagem := null;',
'    :p181_ok       := ''S'';',
' end if;',
' ',
'end;',
''))
,p_attribute_02=>'P181_COD_REQ,P181_EMP,P181_MAT,P181_COD_SIT_REQ'
,p_attribute_03=>'P181_OK,P181_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122426106611362775)
,p_event_id=>wwv_flow_api.id(156122425893722362773)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P181_FLAG").getValue() == ''N'') {',
'console.log(apex.item("P181_MENSAGEM").getValue());',
'}else{',
'apex.navigation.dialog.cancel( true );',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(156122426133394362776)
,p_event_id=>wwv_flow_api.id(156122425893722362773)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(153228428006493636780)
,p_name=>unistr('Criar Requisi\00E7\00E3o')
,p_event_sequence=>495
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(167426154947484964259)
,p_condition_element=>'P181_AVISO_CRIACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(153228428642014636786)
,p_event_id=>wwv_flow_api.id(153228428006493636780)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    v_seq number;',
'    cursor c1 is',
'    select filial',
'      from informacoes_funcionais_cad',
'     where cod_empresa = :P_EMPRESA_USER',
'       and matricula = :P_MATRICULA_USER;',
'',
'    v_c1 c1%rowtype;   ',
'',
'    v_data date := :P181_DATA;',
'',
'begin',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    begin',
'        SELECT seq_requisicao.NEXTVAL',
'        INTO v_seq ',
'        FROM DUAL;',
'    end;',
'    :p181_cod_req := v_seq;',
'    :p181_cod_sit_req := 1;',
'    :p181_dt_req := sysdate;',
'    :p181_dt_sit_req := sysdate;',
'    :p181_cod_emp_req := :P_EMPRESA_USER;',
'    :p181_mat_req := :P_MATRICULA_USER;',
'    :p181_fil_req := v_c1.filial;',
'    :p181_usuario := :p_usuario;',
'end;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER,P181_DATA'
,p_attribute_03=>'P181_COD_REQ,P181_COD_SIT_REQ,P181_DT_REQ,P181_DT_SIT_REQ,P181_COD_EMP_REQ,P181_MAT_REQ,P181_FIL_REQ,P181_USUARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(153228428713177636787)
,p_event_id=>wwv_flow_api.id(153228428006493636780)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem          VARCHAR2(4000);',
'    l_use_matricula     PE_REQ_APURACAO.MATRICULA%TYPE;',
'    l_apurado           VARCHAR2(20);',
'    l_tipo              VARCHAR2(20);',
'    l_tipo_novo     VARCHAR2(20);         ',
'begin',
'    if :P181_NOVA_REQUISICAO is null then',
'        l_use_matricula := :P181_MAT;',
'    else',
'        l_use_matricula := :P181_USUARIO;    ',
'    end if;',
unistr('    --Considerar que uma nova requisi\00E7\00E3o \00E9 um evento Manual.'),
'    --select decode( :P181_BH_APURADO , ''Aberto'', ''A'', ''Fechado'', ''F'', ''Manual'', ''M'', ''A'') ',
'    l_apurado := ''M'';',
'    ',
unistr('    select decode(:P181_TIPO, ''Cr\00E9dito'', ''C'', ''D\00E9bito'', ''D'')'),
'        into l_tipo',
'    from dual;',
'    --',
unistr('    select decode(:P181_TIPO_DISP_NOVO, ''Cr\00E9dito'', ''C'', ''D\00E9bito'', ''D'')'),
'        into l_tipo_novo',
'    from dual;',
'    --    ',
'    PKG_REQ_APURACAO.insere_requisicao( p_cod_req             => :P181_COD_REQ   ',
'                                        , p_dt_req            => trunc(sysdate)            ',
'                                        , p_cod_sit_req       => 1           ',
'                                        , p_dt_sit_req        => trunc(sysdate)          ',
'                                        , p_cod_emp_req       => :p181_cod_emp_req             ',
'                                        , p_fil_req           => :p181_fil_req            ',
'                                        , p_mat_req           => :p181_mat_req              ',
'                                        , p_cod_empresa       => :P181_EMP              ',
'                                        , p_matricula         => l_use_matricula --:p181_matricula            ',
'                                        , p_data_ponto        => :p181_data_ponto          ',
'                                        , p_num_horas         => :p181_qtd_horas_novo              ',
'                                        , p_comentarios       => null             ',
'                                        , p_usuario           => :p181_usuario              ',
'                                        , p_dt_atualizacao    => trunc(sysdate)             ',
'                                        , p_tipo_evento       => :P181_TIPO_EVENTO_NOVO              ',
'                                        , p_cod_evento        => :P181_COD_EVENTO_NOVO  ',
'                                        , p_cod_evento_atual  => :P181_COD_EVENTO',
'                                        , p_tipo              => l_tipo_novo --:P181_TIPO_DISP_NOVO --:P181_TIPO_NOVO ',
'                                        , p_cod_item          => :p181_cod_item',
'                                        , p_id_apuracao       => :p181_id_apuracao',
'                                        , p_tipo_evento_atual => :P181_TIPO_EVENTO',
'                                        , p_qtd_horas_atual   => :P181_QTD_HORAS',
'                                        , p_apuracao_atual    => l_apurado ',
'                                        , p_tipo_atual        => l_tipo',
'                                        , p_mensagem          => l_mensagem',
'                                        );',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'end;',
''))
,p_attribute_02=>'P181_NOVA_REQUISICAO,P181_MAT,P181_USUARIO,P181_BH_APURADO,P181_TIPO'
,p_attribute_03=>'P181_MSG_CLOSE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(153228428858860636788)
,p_event_id=>wwv_flow_api.id(153228428006493636780)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem     VARCHAR2(4000);',
'    l_ok           VARCHAR2(10); ',
'    l_cod_sit_req  PE_REQ_APURACAO.cod_sit_req%type;',
'begin',
'    PKG_REQ_APURACAO.Post_Insert( pcod_empresa       => :P181_EMP',
'        , psolicitacao      => :P181_COD_REQ   ',
'        , pflg_retorno      => l_ok       ',
'        , pmsg_retorno      => l_mensagem);',
'        --',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'    ',
unistr('    :P181_AVISO_CRIACAO := ''Requisi\00E7\00E3o criada com sucesso.'';'),
'end;',
''))
,p_attribute_02=>'P181_EMP,P181_COD_REQ,P181_MAT,P181_DATA'
,p_attribute_03=>'P181_MSG_CLOSE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(153228429182705636791)
,p_name=>unistr('Requisi\00E7\00E3o criada com sucesso')
,p_event_sequence=>505
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_AVISO_CRIACAO'
,p_condition_element=>'P181_AVISO_CRIACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(153228429265121636792)
,p_event_id=>wwv_flow_api.id(153228429182705636791)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Requisi\00E7\00E3o criada com sucesso')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(153228429358889636793)
,p_event_id=>wwv_flow_api.id(153228429182705636791)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(150255141949117047930)
,p_name=>unistr('N\00FAmero de horas informado n\00E3o pode ser maior que limite de horas para abono')
,p_event_sequence=>515
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_AVISO_HORAS_LIMITE'
,p_condition_element=>'P181_AVISO_HORAS_LIMITE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(150255142041415047931)
,p_event_id=>wwv_flow_api.id(150255141949117047930)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(5) N\00FAmero de horas informado n\00E3o pode ser maior que <strong>limite de horas para abono</strong>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144328810975133453556)
,p_event_id=>wwv_flow_api.id(150255141949117047930)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(148000980361077740811)
,p_name=>'Horas novas maior que horas atuais'
,p_event_sequence=>525
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_HORAS_NOVO_MAIOR_HORA_ATUAL'
,p_condition_element=>'P181_HORAS_NOVO_MAIOR_HORA_ATUAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148000980465956740812)
,p_event_id=>wwv_flow_api.id(148000980361077740811)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'(8) Hora Nova Informada deve ser menor ou igual que Hora Atual'
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148000980763924740815)
,p_event_id=>wwv_flow_api.id(148000980361077740811)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(148000980846427740816)
,p_name=>unistr('Se horas est\00E3o zeradas')
,p_event_sequence=>535
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148000980947720740817)
,p_event_id=>wwv_flow_api.id(148000980846427740816)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl( :P181_CONSULTA, ''I'') != ''C'' then',
'    if :P181_QTD_HORAS = ''00:00'' then',
'        :P181_ALERTA_HORAS_ZERADAS := ''ZERO'';',
'    else',
'        :P181_ALERTA_HORAS_ZERADAS := NULL;',
'    end if;',
'end if;',
''))
,p_attribute_02=>'P181_CONSULTA,P181_QTD_HORAS'
,p_attribute_03=>'P181_ALERTA_HORAS_ZERADAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(146885281912412386051)
,p_name=>'Retorna valor cod sit req'
,p_event_sequence=>545
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MUDA_COD_SIT_REQ'
,p_condition_element=>'P181_MUDA_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(146885282069549386052)
,p_event_id=>wwv_flow_api.id(146885281912412386051)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(10) - Somente o usu\00E1rio solicitante pode cancelar a requisi\00E7\00E3o')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145712425087774746694)
,p_event_id=>wwv_flow_api.id(146885281912412386051)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_MUDA_COD_SIT_REQ'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select null from dual'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(146885282173944386053)
,p_event_id=>wwv_flow_api.id(146885281912412386051)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145712424325616746686)
,p_name=>'Bloquear Botao'
,p_event_sequence=>555
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145712424392830746687)
,p_event_id=>wwv_flow_api.id(145712424325616746686)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(167426154947484964259)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145712424904257746692)
,p_name=>'Alerta dois pontos na hora'
,p_event_sequence=>565
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_DOIS_PONTOS'
,p_condition_element=>'P181_DOIS_PONTOS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145712424962088746693)
,p_event_id=>wwv_flow_api.id(145712424904257746692)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Formato de hora inv\00E1lido. Informe a hora no formato HH:MM.')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144328812938415453576)
,p_event_id=>wwv_flow_api.id(145712424904257746692)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_ERRO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144328813632112453583)
,p_event_id=>wwv_flow_api.id(145712424904257746692)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_QTD_HORAS_NOVO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145625653499149212581)
,p_name=>'Evento Novo Nulo'
,p_event_sequence=>575
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COD_EVENTO_NOVO'
,p_condition_element=>'P181_COD_EVENTO_NOVO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145625653524476212582)
,p_event_id=>wwv_flow_api.id(145625653499149212581)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'Informe o Novo Evento'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145562706309335211616)
,p_name=>unistr('Mostra bot\00E3o cancelar')
,p_event_sequence=>585
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_OPERADOR_DELETA'
,p_condition_element=>'P181_OPERADOR_DELETA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145562706410291211617)
,p_event_id=>wwv_flow_api.id(145562706309335211616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145562706478773211618)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(145562706849718211622)
,p_name=>'Operador Cancela concluida'
,p_event_sequence=>595
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(145562706478773211618)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(141668978757373239628)
,p_event_id=>wwv_flow_api.id(145562706849718211622)
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
 p_id=>wwv_flow_api.id(145562707031000211623)
,p_event_id=>wwv_flow_api.id(145562706849718211622)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P181_COD_REQ'').enabled = true;',
'$x(''P181_COD_JUSTIFICATIVA'').enabled = true;',
'apex.widget.waitPopup();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145562707217297211625)
,p_event_id=>wwv_flow_api.id(145562706849718211622)
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
'    PKG_CANCELA_REQUISICOES_HIST.PRC_CANCELA_REQ_APURA( P_COD_REQ          => :P181_COD_REQ',
'                                                       , P_USUARIO        => :P_USUARIO',
'                                                       , P_MSG_RETORNO    => v_erro);',
'    ',
'    if v_erro is not null then',
'       :P714_MENSAGEM := ''Erro ao processar o cancelamento.''||v_erro;',
'    end if;',
'end;    '))
,p_attribute_02=>'P181_COD_REQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(145562707088104211624)
,p_event_id=>wwv_flow_api.id(145562706849718211622)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(144328814537384453592)
,p_name=>'Valida Dois Pontos'
,p_event_sequence=>605
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_QTD_HORAS_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(144328814614740453593)
,p_event_id=>wwv_flow_api.id(144328814537384453592)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_erro         varchar2(4000);',
'    v_pos          number;',
'    --v_anterior     varchar2(2);',
'    v_posterior    varchar2(6);',
'begin',
'    v_pos := instr(:P181_QTD_HORAS_NOVO , '':'');',
'    -- Valida Dois Pontos na Hora',
'    if instr(:P181_QTD_HORAS_NOVO , '':'') = 0 then',
unistr('        :P181_DOIS_PONTOS := ''Formato de hora inv\00E1lido. Informe a hora no formato HH:MM.'';'),
'    else',
'        :P181_DOIS_PONTOS := null;',
'    end if;',
'    ',
'    --v_anterior  := substr(:P181_QTD_HORAS_NOVO , 1, v_pos);',
'    v_posterior := substr(:P181_QTD_HORAS_NOVO , (v_pos + 1 ));',
'    if length(v_posterior) < 2 then    ',
unistr('        :P181_DOIS_PONTOS := ''Formato de hora inv\00E1lido. Informe a hora no formato HH:MM.'';'),
'    end if;',
'end;'))
,p_attribute_02=>'P181_QTD_HORAS_NOVO'
,p_attribute_03=>'P181_DOIS_PONTOS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142382330632253065764)
,p_name=>unistr('Tem horas em requisi\00E7\00E3o n\00E3o aprovada')
,p_event_sequence=>615
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142382330825916065765)
,p_event_id=>wwv_flow_api.id(142382330632253065764)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_horas_req number;',
'    v_horas_info varchar2(50);',
'begin',
'    if :P181_CONSULTA != ''C'' then',
'         begin',
'            select sum((substr(qtd_horas, 1, instr(qtd_horas, '':'')-1) + (substr(qtd_horas, instr(qtd_horas, '':'')+1)/60)))',
'            into v_horas_req',
'               from pe_req_apuracao ',
'               where cod_empresa = :P181_EMP',
'               and matricula = :P181_MAT ',
'               and data_ponto = :P181_DATA_PONTO',
'            and cod_sit_req not in (2,3,4)',
'            and :P_PAINEL = ''PC'';',
'        exception',
'            when others then',
'                v_horas_req :=NULL;',
'        end;',
'',
'        v_horas_info := substr(:P181_QTD_HORAS, 1, instr(:P181_QTD_HORAS, '':'')-1) + (substr(:P181_QTD_HORAS, instr(:P181_QTD_HORAS, '':'')+1)/60)*60;',
'        if v_horas_req is null then',
'            :P181_HORAS_REQ_NAPROV := null; ',
'        elsif v_horas_info is null then',
'            :P181_HORAS_REQ_NAPROV := null; ',
'        elsif v_horas_req is not null then',
'            if v_horas_req >= v_horas_info then',
'                :P181_HORAS_REQ_NAPROV := 1;',
'            end if;    ',
'        end if;',
'    end if;',
'end; '))
,p_attribute_02=>'P181_EMP,P181_MAT,P181_DATA_PONTO,P181_COD_EVENTO,P181_CONSULTA'
,p_attribute_03=>'P181_HORAS_REQ_NAPROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142382330941473065767)
,p_name=>'Valida horas colaborador'
,p_event_sequence=>625
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_HORAS_REQ_NAPROV'
,p_condition_element=>'P181_HORAS_REQ_NAPROV'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142382331068459065768)
,p_event_id=>wwv_flow_api.id(142382330941473065767)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(8) Este colaborador n\00E3o tem mais horas para requisi\00E7\00E3o por ter requisi\00E7\00F5es em <strong>Aberto</strong>. Verifique com seu <strong>Gestor</strong> a aprova\00E7\00E3o das requisi\00E7\00F5es.')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142382331328528065770)
,p_event_id=>wwv_flow_api.id(142382330941473065767)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142082618955603262802)
,p_name=>'Valida Datas Periodo'
,p_event_sequence=>635
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142082619004889262803)
,p_event_id=>wwv_flow_api.id(142082618955603262802)
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
'	 WHERE COD_EMPRESA = :P181_EMP;',
'',
'v_oper c_oper%rowtype;',
'',
'cursor c_gestor is',
'	SELECT dt_ini_ponto_gestor data_ini, ',
'         dt_fim_ponto_gestor data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P181_EMP;',
'',
'v_gestor c_gestor%rowtype;',
'',
'cursor c_colab is',
'	SELECT dt_ini_ponto_colab data_ini, ',
'         dt_fim_ponto_colab data_fim',
'	  FROM PARAMETROS_RECURSOS_HUMANOS',
'	 WHERE COD_EMPRESA = :P181_EMP;',
'',
'v_colab c_colab%rowtype;',
'',
'v_msg varchar2(4000);',
'v_conta number := 0;',
'begin',
'    if NVL( :P181_CONSULTA, ''X'') != ''C'' then',
'        :P181_VALIDA_DATA_PERIODO := null;',
'        if  :P_PAINEL = ''PO'' then',
'            open c_oper;',
'            fetch c_oper into v_oper;',
'            close c_oper;',
'            ',
'            if v_oper.ind_trava_req_po = ''S'' then',
'',
'                if v_oper.data_ref_ponto < :P181_DATA then',
'                    :P181_VALIDA_DATA_PERIODO := null;',
'                else',
'                    if :P181_DATA < v_oper.data_ini and :P181_DATA > v_oper.data_fim then',
'                        :P181_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                    else',
'                        :P181_VALIDA_DATA_PERIODO := null;',
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
'                if :P181_DATA not between v_colab.data_ini and v_colab.data_fim then',
'                    :P181_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                else',
'                    :P181_VALIDA_DATA_PERIODO := null;',
'                end if;',
'            elsif :P_PAINEL = ''PG'' then',
'                open c_gestor;',
'                fetch c_gestor into v_gestor;',
'                close c_gestor;',
'',
'                if :P181_DATA not between v_gestor.data_ini and v_gestor.data_fim then',
'                    :P181_VALIDA_DATA_PERIODO := ''INVALIDO'';',
'                else',
'                    :P181_VALIDA_DATA_PERIODO := null;',
'                end if;',
'            end if;        ',
'        end if;',
'    end if;',
'exception',
'when others then null;',
'end;'))
,p_attribute_02=>'P181_CONSULTA'
,p_attribute_03=>'P181_VALIDA_DATA_PERIODO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(142082619173403262805)
,p_name=>'Retorno Data Periodo'
,p_event_sequence=>645
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_VALIDA_DATA_PERIODO'
,p_condition_element=>'P181_VALIDA_DATA_PERIODO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'INVALIDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(142082619298901262806)
,p_event_id=>wwv_flow_api.id(142082619173403262805)
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
 p_id=>wwv_flow_api.id(142082619370860262807)
,p_event_id=>wwv_flow_api.id(142082619173403262805)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140750710871578233484)
,p_name=>'Valida periodo perfil de aprovacao'
,p_event_sequence=>665
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140750711002495233485)
,p_event_id=>wwv_flow_api.id(140750710871578233484)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_validador   varchar2(25);',
'    --v_mensagem    varchar2(4000);',
'    v_page        number := 181; --APP_PAGE_ID',
'    v_data_ini    PE_PERFIL_ABONO_GERAL.data_inicio_abono%type;',
'    v_data_fim    PE_PERFIL_ABONO_GERAL.data_fim_abono%type;',
'',
'    cursor c_req is',
'      select distinct dt_solicitacao dt_req',
'      from consulta_requisicoes   ',
'      where tipo_req = decode(v_page, 181, ''REQ_APURA'', ''REQ_ABONO'')',
'      and solicitacao = :P181_COD_REQ;                 ',
'',
'    cursor c_param is',
'    select DT_INI_PONTO_GESTOR, DT_FIM_PONTO_GESTOR',
'    from PARAMETROS_RECURSOS_HUMANOS',
'    where COD_EMPRESA = :P181_EMP;',
'',
'    r_param    c_param%rowtype;',
'    r_req      c_req%rowtype;',
'',
'begin',
'    v_validador := null;',
'    if NVL(:P181_CONSULTA, ''S'') != ''C'' then',
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
'                where /*cod_empresa = :P181_EMP',
'                    and*/ cd_perfil = :P_PERFIL;',
'            exception',
'                when others then',
'                    begin',
'                        select data_inicio_abono, data_fim_abono',
'                            into v_data_ini, v_data_fim',
'                        from PE_PERFIL_ABONO_GERAL',
'                        where /*cod_empresa = :P181_EMP',
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
'    if :P181_COD_REQ is null then',
'        v_validador := null;',
'    end if;',
'    :P181_VALIDA_PERIODO_APROVA := v_validador;',
'exception',
'   when others then',
'     :P181_VALIDA_PERIODO_APROVA := sqlerrm;',
'end;',
''))
,p_attribute_02=>'P181_EMP,P181_CONSULTA,P181_COD_REQ'
,p_attribute_03=>'P181_VALIDA_PERIODO_APROVA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140750711254457233488)
,p_name=>unistr('Mostra mensagem periodo aprova\00E7\00E3o')
,p_event_sequence=>675
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_VALIDA_PERIODO_APROVA'
,p_condition_element=>'P181_VALIDA_PERIODO_APROVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140750711384040233489)
,p_event_id=>wwv_flow_api.id(140750711254457233488)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Data da Requisi\00E7\00E3o est\00E1 fora do per\00EDodo de aprova\00E7\00E3o/rejei\00E7\00E3o.')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140750711549400233490)
,p_event_id=>wwv_flow_api.id(140750711254457233488)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(140309783289767148094)
,p_name=>unistr('Exibe bot\00E3o cancelar demais situa\00E7\00F5es')
,p_event_sequence=>685
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_OPERADOR_DELETA_DEMAIS'
,p_condition_element=>'P181_OPERADOR_DELETA_DEMAIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(140309783404104148095)
,p_event_id=>wwv_flow_api.id(140309783289767148094)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145562706478773211618)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(138707092124032128702)
,p_name=>'Alerta horas zeradas'
,p_event_sequence=>695
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_ALERTA_HORAS_ZERADAS'
,p_condition_element=>'P181_ALERTA_HORAS_ZERADAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'ZERO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138707092251102128703)
,p_event_id=>wwv_flow_api.id(138707092124032128702)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Horas est\00E3o Zeradas')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(138707092276834128704)
,p_event_id=>wwv_flow_api.id(138707092124032128702)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(137753321934776770528)
,p_name=>'Mensagem P_EMPRESA_USER e P_MATRICULA_USER'
,p_event_sequence=>705
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_VALIDA_USERS'
,p_condition_element=>'P181_VALIDA_USERS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137753322013589770529)
,p_event_id=>wwv_flow_api.id(137753321934776770528)
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
 p_id=>wwv_flow_api.id(137753322113422770530)
,p_event_id=>wwv_flow_api.id(137753321934776770528)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(137753300642891718235)
,p_name=>'Valida se evento novo igual evento original'
,p_event_sequence=>715
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COD_EVENTO_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137753300663867718236)
,p_event_id=>wwv_flow_api.id(137753300642891718235)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P181_COD_EVENTO_NOVO = :P181_COD_EVENTO and :P181_TIPO_EVENTO = :P181_TIPO_EVENTO_NOVO then',
'    :P181_COMPARA_EVENTOS := 1;',
'end if;'))
,p_attribute_02=>'P181_COD_EVENTO, P181_COD_EVENTO_NOVO,P181_TIPO_EVENTO,P181_TIPO_EVENTO_NOVO'
,p_attribute_03=>'P181_COMPARA_EVENTOS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(137753300876594718238)
,p_name=>unistr('Compara se est\00E1 criando requisi\00E7\00E3o com o mesmo evento que o anterior')
,p_event_sequence=>725
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_COMPARA_EVENTOS'
,p_condition_element=>'P181_COMPARA_EVENTOS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137753301007775718239)
,p_event_id=>wwv_flow_api.id(137753300876594718238)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('(15) Voc\00EA n\00E3o pode gerar requisi\00E7\00E3o para o mesmo tipo de evento e para o mesmo evento.')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(137753301095871718240)
,p_event_id=>wwv_flow_api.id(137753300876594718238)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_COD_EVENTO_NOVO,P181_TIPO_EVENTO_NOVO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select null from dual'
,p_attribute_07=>'P181_COD_EVENTO_NOVO,P181_TIPO_EVENTO_NOVO'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(126114946200751036739)
,p_name=>'Localiza saldo'
,p_event_sequence=>735
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_TIPO_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(126114946307239036740)
,p_event_id=>wwv_flow_api.id(126114946200751036739)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_erro varchar2(4000);',
'    v_retornoC    varchar2(50);',
'    v_retornoD    varchar2(50);',
'    v_retorno   varchar2(50);',
'',
'    CURSOR C_BH IS',
'    SELECT (DT_INI_BH-1) DT_INI_BH',
'    FROM PE_PARAMETROS_BH',
'    WHERE COD_EMPRESA = :P181_EMP;',
'    ',
'    R_BH C_BH%ROWTYPE;',
'    v_saldoC varchar2(20);',
'    v_saldoD varchar2(20);',
'    v_saldot varchar2(20);',
'',
'begin',
'',
'    v_saldot := NULL;',
'    OPEN C_BH;',
'    FETCH C_BH INTO R_BH;',
'    CLOSE C_BH;',
'',
'    v_saldot := FNCT_PE_SALDOS_REMAIN (p_cod_empresa => :P181_EMP,  ',
'                                                p_matricula    => :P181_MAT, ',
'                                                p_data_fim     => R_BH.DT_INI_BH, ',
'                                                p_tipo         => ''T'' );',
'        v_retornoC := FNCT_PE_SALDOS_REMAIN (p_cod_empresa => :P181_EMP, ',
'                                                p_matricula    =>  :P181_MAT, ',
'                                                p_data_fim     => R_BH.DT_INI_BH, ',
'                                                p_tipo         => ''C'' ); ',
'        v_retornoD := FNCT_PE_SALDOS_REMAIN (p_cod_empresa => :P181_EMP, ',
'                                                p_matricula    =>  :P181_MAT, ',
'                                                p_data_fim     => R_BH.DT_INI_BH, ',
'                                                p_tipo         => ''D'' ); ',
'',
'    ',
'    if :P181_TIPO_NOVO = ''D'' then',
'        v_retorno := v_retornoC;',
'    else',
'        v_retorno := v_retornoD;    ',
'    end if;',
'    ',
'    if v_saldot != ''00:00'' then',
'         :P181_SALDO_REMAN    := v_retorno;  ',
'    else',
'         :P181_SALDO_REMAN    := ''00:00'';      ',
'    end if;',
'exception',
'    when others then',
'        v_erro  := SQLERRM;',
'        :P181_SALDO_REMAN := ''00:00'';',
'',
'end;'))
,p_attribute_02=>'P181_EMP,P181_MAT,P181_TIPO_NOVO'
,p_attribute_03=>'P181_SALDO_REMAN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115498746258714583697)
,p_name=>'Valida se pode alterar o evento'
,p_event_sequence=>740
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(115498744278495583677)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498746429481583698)
,p_event_id=>wwv_flow_api.id(115498746258714583697)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_permite pe_eventos_folha.permite_justificar%type;',
'    v_erro varchar2(4000);',
'begin',
'    :P181_ALTERA_EVENTO:= null;',
'    if UPPER( :P181_TIPO_EVENTO ) = ''PONTO'' then    ',
'        select permite_justificar',
'            into l_permite',
'        from pe_eventos_folha ',
'        where COD_EMPRESA =:P181_EMP',
'        and COD_EVENTO_FOLHA = :P181_COD_EVENTO;',
'    elsif UPPER( :P181_TIPO_EVENTO ) = ''BANCO'' then ',
'        select permite_justificar',
'            into l_permite',
'        from PE_EVENTOS_BANCO ',
'        where COD_EMPRESA =:P181_EMP',
'        and COD_EVENTO_BANCO = :P181_COD_EVENTO;    ',
'    end if;',
'    --',
'    if l_permite = ''N'' then',
'        :P181_ALTERA_EVENTO_JUSTIFICATIVA := 1;',
'    else',
'        :P181_ALTERA_EVENTO_JUSTIFICATIVA := NULL;',
'    end if;',
'exception',
'    when others then',
'    v_erro := SQLERRM;',
'        :P181_ALTERA_EVENTO_JUSTIFICATIVA := SQLERRM;',
'end;',
''))
,p_attribute_02=>'P181_TIPO_EVENTO, P181_EMP, P181_COD_EVENTO'
,p_attribute_03=>'P181_ALTERA_EVENTO_JUSTIFICATIVA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115498744432644583678)
,p_name=>'Open Dialog Justificativa'
,p_event_sequence=>745
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(115498744278495583677)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498745005561583684)
,p_event_id=>wwv_flow_api.id(115498744432644583678)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(201812169032662989915)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115498745454881583689)
,p_name=>'Salvar justificativa'
,p_event_sequence=>755
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(115498830880371088906)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498745619749583690)
,p_event_id=>wwv_flow_api.id(115498745454881583689)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>'Deseja continuar ?'
,p_attribute_07=>'Sim'
,p_attribute_08=>unistr('N\00E3o')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498745838317583692)
,p_event_id=>wwv_flow_api.id(115498745454881583689)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(201812169032662989915)
,p_attribute_01=>'apex.widget.waitPopup();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498745740621583691)
,p_event_id=>wwv_flow_api.id(115498745454881583689)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_msg varchar2(4000);',
'begin',
'  PKG_JUSTIFICA_PONTO_HIST.salva(p_cod_empresa      => :P181_EMP,',
'                                 p_matricula        => :P181_MAT,',
'                                 p_data             => :P181_DATA,',
'                                 p_tipo_evento      => :P181_TIPO_EVENTO,',
'                                 p_cod_evento       => :P181_COD_EVENTO,',
'                                 p_posicao          => :P181_POSICAO,',
'                                 p_qtd_horas        => :P181_QTD_HORAS,',
'                                 p_justificativa    => :P181_JUSTIFICATIVA,',
'                                 p_cod_ccusto_contab=> :P181_CCUSTO_CONTABIL,',
'                                 p_observacoes      => :P181_OBSERVACOES,',
'                                 p_cod_item         => :P181_COD_ITEM,',
'                                 p_usuario          => :P_USUARIO,',
'                                 p_mensagem         => v_msg);',
'                                                             ',
'   if v_msg is not null then',
'        apex_error.add_error( p_message => v_msg',
'                             , p_display_location => apex_error.c_inline_in_notification );',
'   end if;',
'end;'))
,p_attribute_02=>'P181_DATA,P181_QTD_HORAS,P181_EMP,P181_MAT,P181_TIPO_EVENTO,P181_COD_EVENTO,P181_JUSTIFICATIVA,P181_CCUSTO_CONTABIL,P181_OBSERVACOES,P181_COD_ITEM'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29421702564349285344)
,p_event_id=>wwv_flow_api.id(115498745454881583689)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(201812169032662989915)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115498746076522583695)
,p_name=>'Fechar Tela Justificativa'
,p_event_sequence=>765
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(115498745958961583694)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498746241285583696)
,p_event_id=>wwv_flow_api.id(115498746076522583695)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(201812169032662989915)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(115498746668021583701)
,p_name=>'Mostra mensagem validar justificativa evento'
,p_event_sequence=>775
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_ALTERA_EVENTO_JUSTIFICATIVA'
,p_condition_element=>'P181_ALTERA_EVENTO_JUSTIFICATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498746788290583702)
,p_event_id=>wwv_flow_api.id(115498746668021583701)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Este tipo de evento n\00E3o pode ser justificado !')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(115498746931672583703)
,p_event_id=>wwv_flow_api.id(115498746668021583701)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(201812169032662989915)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(110196109380194737842)
,p_name=>'Dispara Mensagem horas BH'
,p_event_sequence=>795
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MENSAGEM_HORAS_BH'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(110196109462038737843)
,p_event_id=>wwv_flow_api.id(110196109380194737842)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P181_FLAG'').value == "Q") {',
'alertify.confirm($v(''P181_MENSAGEM_HORAS_BH''), function (e) {',
'    if (e) {',
'        $x(''P181_FLAG'').value = ''S'';',
'        $x(''P181_MENSAGEM'').value = '''';',
'        $x(''P181_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P181_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P181_MENSAGEM_HORAS_BH'').value.length  > 0 ) {',
'        ',
'        if ($x(''P181_FLAG'').value == "N") {',
'            $x(''P181_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P181_MENSAGEM_HORAS_BH''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P181_ITEM_VALIDACAO'').value == ''P181_CREATE''){',
'            $x(''P181_OK'').value = ''S'';',
'        $x(''P181_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(110196109575031737844)
,p_event_id=>wwv_flow_api.id(110196109380194737842)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(110196109753336737846)
,p_name=>'Exibe mensagem horas BH'
,p_event_sequence=>795
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MENSAGEM_BH'
,p_condition_element=>'P181_MENSAGEM_BH'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(110196109842674737847)
,p_event_id=>wwv_flow_api.id(110196109753336737846)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P181_FLAG'').value == "Q") {',
'alertify.confirm($v(''P181_MENSAGEM_BH''), function (e) {',
'    if (e) {',
'        $x(''P181_FLAG'').value = ''S'';',
'        $x(''P181_MENSAGEM_BH'').value = '''';',
'        $x(''P181_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P181_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P181_MENSAGEM_BH'').value.length  > 0 ) {',
'        ',
'        if ($x(''P181_FLAG'').value == "N") {',
'            $x(''P181_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P181_MENSAGEM_BH''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P181_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P181_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P181_ITEM_VALIDACAO'').value == ''P181_CREATE''){',
'            $x(''P181_OK'').value = ''S'';',
'        $x(''P181_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(110196110004728737849)
,p_event_id=>wwv_flow_api.id(110196109753336737846)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_TIPO_EVENTO_NOVO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(95848681055052234559)
,p_name=>'Valida se passadas duas horas de limite'
,p_event_sequence=>815
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_QTD_HORAS_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(95848681123402234560)
,p_event_id=>wwv_flow_api.id(95848681055052234559)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    if :P181_TIPO_NOVO = ''C'' then',
'        :P181_MENSAGEM :=  ',
'        PKG_REQ_APURACAO.FNCT_VALIDA_HORAS_BANCO( P_COD_EMPRESA => :P181_EMP',
'                                                , P_MATRICULA   => :P181_MAT',
'                                                , P_EVENTO      => :P181_COD_EVENTO_NOVO',
'                                                , P_HORAS_INFO  => :P181_QTD_HORAS_NOVO',
'                                                , P_PONTO       => :P181_DATA',
'                                                , P_USUARIO     => :P_USUARIO',
'                                                , P_PAINEL      => :P_PAINEL',
'                                                , P_PERFIL      => :P_PERFIL);',
'    ',
'    end if;',
'END;'))
,p_attribute_02=>'P181_EMP,P181_MAT,P181_COD_EVENTO_NOVO,P181_QTD_HORAS_NOVO,:P181_DATA'
,p_attribute_03=>'P181_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(94820263128206717518)
,p_name=>'Obtem remanescente'
,p_event_sequence=>825
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_TIPO_EVENTO_NOVO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(94820263252118717519)
,p_event_id=>wwv_flow_api.id(94820263128206717518)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    CURSOR C_BH IS',
'    SELECT (DT_INI_BH-1) DT_INI_BH',
'    FROM PE_PARAMETROS_BH',
'    WHERE COD_EMPRESA = :P181_EMP;',
'    ',
'    R_BH C_BH%ROWTYPE;',
'',
'    v_saldot varchar2(20);',
'begin',
'    v_saldot := null;',
'    if :P181_TIPO_EVENTO_NOVO = ''BANCO'' then',
'        v_saldot := NULL;',
'        OPEN C_BH;',
'        FETCH C_BH INTO R_BH;',
'        CLOSE C_BH;',
'',
'        if :P181_TIPO_CODE = ''C'' then',
'            v_saldot := FNCT_PE_SALDOS_REMAIN (p_cod_empresa => :P181_EMP,  ',
'                                                        p_matricula    => :P181_MAT,',
'                                                        p_data_fim     => R_BH.DT_INI_BH, ',
'                                                        p_tipo         => ''D'' );',
'        elsif :P181_TIPO_CODE = ''D'' then',
'            v_saldot := FNCT_PE_SALDOS_REMAIN (p_cod_empresa => :P181_EMP,  ',
'                                                        p_matricula    => :P181_MAT,',
'                                                        p_data_fim     => R_BH.DT_INI_BH, ',
'                                                        p_tipo         => ''C'' );',
'        end if;',
'        if v_saldot != ''00:00'' then',
'            :P181_ORIGEM := 2;',
'            :P181_SALDO_REMAN := v_saldot;',
'         else',
'            :P181_ORIGEM := 1;',
'            :P181_SALDO_REMAN := ''00:00'';',
'         end if;',
'     else',
'        :P181_ORIGEM := 1;',
'        :P181_SALDO_REMAN := ''00:00'';',
'     end if;',
'end;                                                '))
,p_attribute_02=>'P181_EMP, P181_MAT,P181_TIPO_EVENTO_NOVO,P181_TIPO_CODE'
,p_attribute_03=>'P181_ORIGEM,P181_SALDO_REMAN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(85871724363800920746)
,p_name=>'Valida data req x data ref ponto'
,p_event_sequence=>835
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(85871724464065920747)
,p_event_id=>wwv_flow_api.id(85871724363800920746)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P181_MENSAGEM := PKG_TRATA_DATAS.VALIDA_DATA_REF_PONTO( P_COD_EMPRESA        => :P181_EMP',
'                                                         , P_DATA_SOLICITADA  => :P181_DATA_PONTO',
'                                                         , P_TIPO             => ''ponto'' );'))
,p_attribute_02=>'P181_COD_EMPRESA,P181_DATA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(71960765511412928633)
,p_name=>'Dispara Mensagem e fecha'
,p_event_sequence=>855
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MENSAGEM_FECHA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(71960765667813928635)
,p_event_id=>wwv_flow_api.id(71960765511412928633)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P181_QTD_HORAS_NOVO'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'SELECT NULL FROM DUAL'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(71960765580941928634)
,p_event_id=>wwv_flow_api.id(71960765511412928633)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P181_MENSAGEM_FECHA'').value.length  > 0 ) {',
'        alertify.alert($v(''P181_MENSAGEM_FECHA''));',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66764184286005284631)
,p_name=>'P181_OCULTA_BTN'
,p_event_sequence=>865
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_OCULTA_BTN'
,p_condition_element=>'P181_OCULTA_BTN'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66764184326333284632)
,p_event_id=>wwv_flow_api.id(66764184286005284631)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(167426154947484964259)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66764184440945284633)
,p_event_id=>wwv_flow_api.id(66764184286005284631)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(144328813909815453586)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66764184587199284634)
,p_event_id=>wwv_flow_api.id(66764184286005284631)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(115498830880371088906)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(66764184891184284637)
,p_name=>'P181_MENSAGEM_LIMITE'
,p_event_sequence=>875
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MENSAGEM_LIMITE'
,p_condition_element=>'P181_MENSAGEM_LIMITE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(66764185018449284638)
,p_event_id=>wwv_flow_api.id(66764184891184284637)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>'&P181_MENSAGEM_LIMITE.'
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(58883536842658903023)
,p_name=>'DisparaAlerta'
,p_event_sequence=>885
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_MSG_CLOSE2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883536928318903024)
,p_event_id=>wwv_flow_api.id(58883536842658903023)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P181_MSG_CLOSE2" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P181_MSG_CLOSE2" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(58883537039160903025)
,p_name=>'Disable Page'
,p_event_sequence=>895
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_CLOSE_PAGE'
,p_condition_element=>'P181_CLOSE_PAGE'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537103549903026)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(167426154947484964259)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537247761903027)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145562706478773211618)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537871255903034)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(115498744278495583677)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537334186903028)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(144328813909815453586)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537849441903033)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(144328813909815453586)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537425890903029)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(115498744278495583677)
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537701753903032)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(145562706478773211618)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537471725903030)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#MARCACAO *'').prop(''disabled'',true);'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883537578587903031)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(167426154947484964259)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58883538048047903035)
,p_event_id=>wwv_flow_api.id(58883537039160903025)
,p_event_result=>'FALSE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#MARCACAO *'').prop(''enabled'',true);'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(57557291865266036850)
,p_name=>'Trava Abono'
,p_event_sequence=>905
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(57557292004474036851)
,p_event_id=>wwv_flow_api.id(57557291865266036850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  vReturn varchar2(2000);',
'begin',
'  vReturn := PKG_PE_ABONO.fnc_trava_abono(P_COD_EMPRESA => :P181_EMP,',
'                                          P_MATRICULA => :P181_MAT,',
'                                          P_DATA => :p181_data);',
'  if vReturn = ''S'' then',
unistr('    vReturn := ''<strong>Abono de Marca\00E7\00E3o N\00C3O Permitida! Dia j\00E1 foi tratado!</strong><br>'';'),
'    --',
'    :P181_MSG_CLOSE2  := vReturn;',
'    :P181_CLOSE_PAGE := ''S'';',
'  end if;',
'end;'))
,p_attribute_02=>'P181_EMP,P181_DATA,P181_MAT'
,p_attribute_03=>'P181_MSG_CLOSE2,P181_CLOSE_PAGE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(53613758173752420119)
,p_name=>unistr('Valida se tem requisi\00E7\00E3o')
,p_event_sequence=>915
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P181_TEM_REQUISOCAO'
,p_condition_element=>'P181_TEM_REQUISOCAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53613758319664420120)
,p_event_id=>wwv_flow_api.id(53613758173752420119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('J\00E1 existe uma requisi\00E7\00E3o para esta empresa, matricula, data ponto, horas e evento')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(53613758457315420122)
,p_event_id=>wwv_flow_api.id(53613758173752420119)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144328814013000453587)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Novo Criar - Passo 1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    v_seq number;',
'    cursor c1 is',
'    select filial',
'      from informacoes_funcionais_cad',
'     where cod_empresa = :P_EMPRESA_USER',
'       and matricula = :P_MATRICULA_USER;',
'',
'    v_c1 c1%rowtype;   ',
'',
'    v_data date := :P181_DATA;',
'',
'begin',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    begin',
'        SELECT seq_requisicao.NEXTVAL',
'        INTO v_seq ',
'        FROM DUAL;',
'    end;',
'    :p181_cod_req := v_seq;',
'    :p181_cod_sit_req := 1;',
'    :p181_dt_req := sysdate;',
'    :p181_dt_sit_req := sysdate;',
'    :p181_cod_emp_req := :P_EMPRESA_USER;',
'    :p181_mat_req := :P_MATRICULA_USER;',
'    :p181_fil_req := v_c1.filial;',
'    :p181_usuario := :p_usuario;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(144328813909815453586)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144328814124341453588)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Novo Criar - Passo 2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem          VARCHAR2(4000);',
'    l_use_matricula     PE_REQ_APURACAO.MATRICULA%TYPE;',
'    l_apurado           VARCHAR2(20);',
'    l_tipo              VARCHAR2(20);',
'    l_tipo_novo     VARCHAR2(20);         ',
'begin',
'    if :P181_NOVA_REQUISICAO is null then',
'        l_use_matricula := :P181_MAT;',
'    else',
'        l_use_matricula := :P181_USUARIO;    ',
'    end if;',
unistr('    --Considerar que uma nova requisi\00E7\00E3o \00E9 um evento Manual.'),
'    --select decode( :P181_BH_APURADO , ''Aberto'', ''A'', ''Fechado'', ''F'', ''Manual'', ''M'', ''A'') ',
'    l_apurado := ''M'';',
'    ',
unistr('    select decode(:P181_TIPO, ''Cr\00E9dito'', ''C'', ''D\00E9bito'', ''D'')'),
'        into l_tipo',
'    from dual;',
'    --',
unistr('    select decode(:P181_TIPO_DISP_NOVO, ''Cr\00E9dito'', ''C'', ''D\00E9bito'', ''D'')'),
'        into l_tipo_novo',
'    from dual;',
'    --    ',
'    PKG_REQ_APURACAO.insere_requisicao( p_cod_req             => :P181_COD_REQ   ',
'                                        , p_dt_req            => trunc(sysdate)            ',
'                                        , p_cod_sit_req       => 1           ',
'                                        , p_dt_sit_req        => trunc(sysdate)          ',
'                                        , p_cod_emp_req       => :p181_cod_emp_req             ',
'                                        , p_fil_req           => :p181_fil_req            ',
'                                        , p_mat_req           => :p181_mat_req              ',
'                                        , p_cod_empresa       => :P181_EMP              ',
'                                        , p_matricula         => l_use_matricula --:p181_matricula            ',
'                                        , p_data_ponto        => :p181_data_ponto          ',
'                                        , p_num_horas         => :p181_qtd_horas_novo',
'                                        , p_comentarios       => null             ',
'                                        , p_usuario           => :p181_usuario              ',
'                                        , p_dt_atualizacao    => trunc(sysdate)             ',
'                                        , p_tipo_evento       => :P181_TIPO_EVENTO_NOVO              ',
'                                        , p_cod_evento        => :P181_COD_EVENTO_NOVO  ',
'                                        , p_cod_evento_atual  => :P181_COD_EVENTO',
'                                        , p_tipo              => l_tipo_novo --:P181_TIPO_DISP_NOVO --:P181_TIPO_NOVO ',
'                                        , p_cod_item          => :p181_cod_item',
'                                        , p_id_apuracao       => :p181_id_apuracao',
'                                        , p_tipo_evento_atual => :P181_TIPO_EVENTO',
'                                        , p_qtd_horas_atual   => :P181_QTD_HORAS',
'                                        , p_apuracao_atual    => l_apurado ',
'                                        , p_tipo_atual        => l_tipo',
'                                        , p_justificativa     => :P181_COD_JUSTIFICATIVA',
'                                        , p_ccusto_contabil   => :P181_COD_CCUSTO_CONTABIL   ',
'                                        , p_origem            => :P181_ORIGEM',
'                                        , p_observacoes       => :P181_OBSERVA',
'                                        , p_mensagem          => l_mensagem',
'                                        );',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(144328813909815453586)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144328814279495453589)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Novo Criar - Passo 3'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem     VARCHAR2(4000);',
'    l_ok           VARCHAR2(10); ',
'    l_cod_sit_req  PE_REQ_APURACAO.cod_sit_req%type;',
'begin',
'',
'    PKG_REQ_APURACAO.Post_Insert( pcod_empresa       => :P181_EMP',
'                                , psolicitacao      => :P181_COD_REQ   ',
'                                , pflg_retorno      => l_ok       ',
'                                , pmsg_retorno      => l_mensagem);',
'                            ',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'  ',
unistr('    apex_application.g_print_success_message := ''Requisi\00E7\00E3o criada com sucesso.'';'),
'end;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(144328813909815453586)
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada com Sucesso !')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(144328814443180453591)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Novo Salvar - Passo 1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c_req is',
'select cod_sit_req',
'  from PE_REQ_APURACAO',
' where cod_req = :P181_COD_REQ;',
'',
'v_req c_req%rowtype;',
'',
'begin',
'    PKG_REQ_APURACAO.Valida_Sit_Req(:P181_EMP, :P181_COD_REQ, :P181_MAT, :P181_COD_SIT_REQ, :p_usuario, v_flg_retorno, v_msg_retorno, :p_painel);',
'',
' if v_flg_retorno <> ''N'' and trim(v_msg_retorno) is null or (:P181_COD_SIT_REQ = 3) then',
'    update PE_REQ_APURACAO',
'       set cod_sit_req = :P181_COD_SIT_REQ,',
'           dt_sit_req = sysdate,',
'           usuario = :p_usuario,',
'           dt_atualizacao = sysdate',
'     where cod_req = :P181_COD_REQ;',
'     ',
' end if;',
' if :P181_COD_SIT_REQ != 3 then',
'',
'    PKG_REQ_APURACAO.Post_Update(:P181_EMP,',
'                                    :P181_COD_REQ,',
'                                    V_flg_retorno,',
'                                    V_msg_retorno);',
'',
' end if;',
' if v_msg_retorno is not null then',
'    :p181_ok       := ''N'';',
'    :p181_FLAG     := v_flg_retorno;',
'    :p181_mensagem := v_msg_retorno;',
' else',
'    :p181_flag     := null;',
'    :p181_mensagem := null;',
'    :p181_ok       := ''S'';',
' end if;',
' ',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(144328814349372453590)
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(153228427952532636779)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Cancela requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P181_COD_SIT_REQ = 3 then',
'        update pe_req_apuracao',
'            set cod_sit_req = :P181_COD_SIT_REQ , dt_sit_req = SYSDATE',
'        where cod_req = :P181_COD_REQ;    ',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(167426154640373964259)
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145562706784619211621)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Cancela requisi\00E7\00E3o - Operador Cancela concluida')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    update pe_req_apuracao',
'    set cod_sit_req = :P181_COD_SIT_REQ , dt_sit_req = SYSDATE',
'    where cod_req = :P181_COD_REQ;    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(167426154640373964259)
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167425964872627361023)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre Insert'
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
'cursor c1 is',
'select filial',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;   ',
'',
'v_data date := :p181_data;',
'',
'begin',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    begin',
'        SELECT seq_requisicao.NEXTVAL',
'        INTO v_seq ',
'        FROM DUAL;',
'    end;',
'        :p181_cod_req := v_seq;',
'',
'    :p181_cod_sit_req := 1;',
'    :p181_dt_req := sysdate;',
'    :p181_dt_sit_req := sysdate;',
'    :p181_cod_emp_req := :P_EMPRESA_USER;',
'    :p181_mat_req := :P_MATRICULA_USER;',
'    :p181_fil_req := v_c1.filial;',
'    :p181_usuario := :p_usuario;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167425964959904361024)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Requisition'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem          VARCHAR2(4000);',
'    l_use_matricula     PE_REQ_APURACAO.MATRICULA%TYPE;',
'    l_apurado           VARCHAR2(20);',
'    l_tipo              VARCHAR2(20);',
'begin',
'    if :P181_NOVA_REQUISICAO is null then',
'        l_use_matricula := :P181_MAT;',
'    else',
'        l_use_matricula := :P181_USUARIO;    ',
'    end if;',
'    --',
'    select decode( :P181_BH_APURADO , ''Aberto'', ''A'', ''Fechado'', ''F'', ''Manual'', ''M'', ''A'') ',
'        into l_apurado',
'    from dual;',
'    --',
unistr('    select decode(:P181_TIPO, ''Cr\00E9dito'', ''C'', ''D\00E9bito'', ''D'')'),
'        into l_tipo',
'    from dual;',
'    --',
'    PKG_REQ_APURACAO.insere_requisicao( p_cod_req             => :P181_COD_REQ   ',
'                                        , p_dt_req            => trunc(sysdate)            ',
'                                        , p_cod_sit_req       => 1           ',
'                                        , p_dt_sit_req        => trunc(sysdate)          ',
'                                        , p_cod_emp_req       => :p181_cod_emp_req             ',
'                                        , p_fil_req           => :p181_fil_req            ',
'                                        , p_mat_req           => :p181_mat_req              ',
'                                        , p_cod_empresa       => :P181_EMP              ',
'                                        , p_matricula         => l_use_matricula --:p181_matricula            ',
'                                        , p_data_ponto        => :p181_data_ponto          ',
'                                        , p_num_horas         => :p181_qtd_horas_novo              ',
'                                        , p_comentarios       => null             ',
'                                        , p_usuario           => :p181_usuario              ',
'                                        , p_dt_atualizacao    => trunc(sysdate)             ',
'                                        , p_tipo_evento       => :P181_TIPO_EVENTO_NOVO              ',
'                                        , p_cod_evento        => :P181_COD_EVENTO_NOVO  ',
'                                        , p_cod_evento_atual  => :P181_COD_EVENTO',
'                                        , p_tipo              => :P181_TIPO_NOVO ',
'                                        , p_cod_item          => :p181_cod_item',
'                                        , p_id_apuracao       => :p181_id_apuracao',
'                                        , p_tipo_evento_atual => :P181_TIPO_EVENTO',
'                                        , p_qtd_horas_atual   => :P181_QTD_HORAS',
'                                        , p_apuracao_atual    => l_apurado ',
'                                        , p_tipo_atual        => l_tipo',
'                                        , p_mensagem          => l_mensagem',
'                                        );',
'    COMMIT;',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167429714838544886408)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_mensagem     VARCHAR2(4000);',
'    l_ok           VARCHAR2(10); ',
'    l_cod_sit_req  PE_REQ_APURACAO.cod_sit_req%type;',
'begin',
'    PKG_REQ_APURACAO.Post_Insert( pcod_empresa       => :P181_EMP',
'                                , psolicitacao      => :P181_COD_REQ   ',
'                                , pflg_retorno      => l_ok       ',
'                                , pmsg_retorno      => l_mensagem);',
'    --',
'    if l_mensagem is not null then                                     ',
'        :p181_msg_close := l_mensagem;',
'    end if;',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167429715333699886413)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_APURACAO.Post_Update(:P181_EMP,',
'                       :P181_COD_REQ,',
'                      V_flg_retorno,',
'                      V_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p181_ok       := ''N'';',
'    :p181_flag     := v_flg_retorno;',
'    :p181_mensagem := v_msg_retorno;',
' else',
'    :p181_flag     := null;',
'    :p181_mensagem := null;',
'    :p181_ok       := ''S'';',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167426171355523964276)
,p_process_sequence=>110
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
'',
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
'v_data date := :p181_data;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'  begin',
'	SELECT seq_requisicao.NEXTVAL',
'  INTO v_seq ',
'  FROM DUAL;',
'  end;',
'',
':p181_cod_req := v_seq;',
':p181_cod_sit_req := 1;',
':p181_dt_req := sysdate;',
':p181_dt_sit_req := sysdate;',
':p181_cod_emp_req := :P_EMPRESA_USER;',
':p181_mat_req := :P_MATRICULA_USER;',
'--:p181_cod_empresa := :p181_emp;',
'--:p181_matricula := :p181_mat;',
'--:p181_posicao_x       := :p181_posicao;',
':p181_fil_req := v_c1.filial;',
':p181_usuario := :p_usuario;',
'--:p181_data_Ponto := nvl(:P181_DATA_PONTO,:P181_DATA);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167426174592095964277)
,p_process_sequence=>120
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
'',
':p181_usuario := :p_usuario;',
':p181_dt_atualizacao := sysdate;',
'',
'/*',
'if :p181_hora_inicial is not null then',
':p181_hora_inicial       := :p181_data||'' ''||:p181_hora_batida;',
'end if;',
'',
'if :p181_hora_inicial is not null then',
':p181_hora_inicial := :p181_data||'' ''||:p181_hora_batida_abono;',
'end if;',
'*/',
'NULL;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167426173749102964277)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Process'
,p_attribute_02=>'PE_REQ_APURACAO'
,p_attribute_03=>'P181_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167426171753208964276)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167426173026724964276)
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
'',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'    PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
':P181_OK := ''S'';',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(140309785484990148116)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    SELECT DATA_INI_REF_PONTO DATA_INI, ',
'           DATA_FIM_REF_PONTO DATA_FIM',
'    INTO :P714_DTINI_ABONO, :P714_DTFIM_ABONO       ',
'      FROM PARAMETROS_RECURSOS_HUMANOS',
'     WHERE COD_EMPRESA = :P181_EMP;',
'exception',
'when others then null;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(167429712667154886387)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('recupera_evento_requisi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'l_erro VARCHAR2(4000);',
'l_step number := 0;',
'l_pos  number := 0;',
'--',
'l_cod_item     PE_REQ_APURACAO.cod_item%type;',
'begin',
'',
'    if :P181_EMP is null then',
'        :P181_EMP := :P181_COD_EMP_REQ;',
'    end if;',
'    l_step := 100;',
'    if :P181_COD_REQ is null then',
'        :P181_NOVA_REQUISICAO := null;',
'        begin',
'            select tipo_evento',
'                , cod_evento',
'                , trim(qtd_horas)',
'                , data',
'                , decode(r.bh_apurado,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'',r.bh_apurado) bh_apurado_desc',
'            into :P181_TIPO_EVENTO',
'                , :P181_COD_EVENTO_NOVO_DSP            ',
'                , :P181_QTD_HORAS',
'                , :P181_DATA',
'                , :p181_BH_APURADO',
'            from PE_RESULTADO_APURACAO r',
'            where COD_EMPRESA = NVL( :P181_EMP, COD_EMPRESA )',
'            and MATRICULA = NVL ( :P181_MAT, MATRICULA ) ',
'            and data = :P181_DATA_PONTO',
'            and cod_evento = :P181_COD_EVENTO',
'            and cod_item = :P181_COD_ITEM',
'            order by data desc;        ',
'        exception',
'            when others then',
'                    l_erro := SQLERRM;',
unistr('                    apex_error.add_error(p_message => ''(''||l_step||'') Erro ao recuperar dados do resultado da apura\00E7\00E3o ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);'),
'        end; ',
'        --',
'        if :P181_COD_EVENTO_NOVO_DSP is not null then',
'            begin',
'            ',
'                SELECT COD_EVENTO_FOLHA||'' - ''|| DESCRICAO',
'                into :P181_EVENTO_CONVERSAO',
'                from  pe_eventos_folha               ',
'                    where cod_empresa = :P181_EMP',
'                    and cod_evento_folha = (            ',
'                            select EVENTO_CONVERSAO',
'                            from  pe_eventos_folha    ',
'                            where cod_empresa = :P181_EMP',
'                            and cod_evento_folha = :P181_COD_EVENTO_NOVO_DSP   );',
'            exception',
'                when others then',
'                   :P181_EVENTO_CONVERSAO := ''-'';',
'            end;',
'        end if;',
'        --',
'        if :P181_TIPO_EVENTO = ''PONTO'' then',
'            l_step := 110;',
'             begin   ',
'                select ',
unistr('                        decode(tipo_rubrica, 1, ''Cr\00E9dito'', 2, ''D\00E9bito'', 3, ''Base'') tipo,'),
'                        decode(tipo_rubrica, 1, ''C'', 2, ''D'', 3, ''B'') tipo_code,',
'                       cod_evento_folha||'' - ''||descricao descricao',
'                into :P181_TIPO',
'                    , :P181_TIPO_CODE',
'                    , :P181_EVENTO',
'                     from pe_eventos_folha p, ocorr_pagto op',
'                     where p.cod_evento_folha = :P181_COD_EVENTO',
'                     and op.cod_empresa = p.cod_empresa ',
'                     and op.cod = p.cod_ocorr',
'                     and p.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'            exception',
'                when others then',
'                    l_erro := SQLERRM;',
'                    apex_error.add_error(p_message => ''(''||l_step||'') Erro ao recuperar dados do evento folha atual ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'            end;',
'        else',
'            l_step := 120;',
'            begin',
unistr('                select  decode(b.tipo,''C'',''Cr\00E9dito'',''D'',''D\00E9bito'') tipo,'),
'                    cod_evento_banco||'' - ''||descricao descricao,',
'                    b.tipo tipo_code',
'                into :P181_TIPO',
'                    , :P181_EVENTO',
'                    , :P181_TIPO_CODE',
'                from pe_eventos_banco b',
'                where cod_evento_banco =  :P181_COD_EVENTO',
'                     and b.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'                ',
'            exception',
'                when others then',
'                    l_erro := SQLERRM;',
'                    apex_error.add_error(p_message => ''(''||l_step||'') Erro ao recuperar dados do evento banco atual ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'            end;',
'        end if;  ',
'    else',
'        l_step := 2;',
'        begin',
'            select 1',
'                   , r.cod_item           cod_item_req',
'                   , r.dt_req           data_requisicao',
'                   , r.dt_sit_req       data_situacao_req',
'                   , r.cod_sit_req',
'                   /*, decode (r.cod_sit_req, 1, ''Aberta'',',
unistr('                                        2,''Conclu\00EDda'','),
'                                        3,''Cancelada'',',
'                                        4,''Reprovada'',',
'                                        5,''aprovada'',',
unistr('                                        6,''Suspens\00E3o'') cod_sit_req*/'),
unistr('                   , decode( r.tipo_atual, ''C'', ''Cr\00E9dito'', ''D'', ''D\00E9bito'' ) tipo_atual                    '),
unistr('                   , decode( r.tipo, ''C'', ''Cr\00E9dito'', ''D'', ''D\00E9bito'' ) tipo '),
'                   , r.tipo tipo_cod',
'                   , r.cod_emp_req           cod_emp_req',
'                   , r.mat_req               mat_req',
'                   , r.tipo_evento_atual     tipo_evento_atual',
'                   , r.cod_evento_atual      cod_evento_atual',
'                   , r.qtd_horas_atual       qtd_horas_atual',
'                   , r.data_ponto            data_ponto',
'                   , r.tipo_evento           tipo_evento_novo',
'                   , r.cod_evento            cod_evento_novo',
'                   , r.qtd_horas             qtd_horas_novo ',
'                   , decode( r.bh_apurado_atual,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'', r.bh_apurado_atual ) apurado_atual',
'                   , decode( r.bh_apurado,''A'',''Aberto'',''F'',''Fechado'',''M'',''Manual'', r.bh_apurado ) apurado_req',
'                   , r.cod_empresa||'' - ''||(select nome from empresas_cad where cod = r.cod_empresa) empresa',
'                   --, r.matricula||'' - ''||(select distinct nome from inf_pessoais_cad where matricula = r.matricula) matricula',
'                    , r.matricula||'' - ''||( select distinct  nome',
'                                            from inf_pessoais_cad ip,  ',
'                                                 informacoes_funcionais_cad if',
'                                            where if.matricula = ip.matricula',
'                                            and if.cod_empresa =  ip.cod_empresa',
'                                            and if.cod_empresa =  r.cod_empresa',
'                                            and if.matricula = r.matricula) matricula',
'                    , (select descricao from pe_tipo_justificativa where cod_empresa = r.cod_emp_req  and COD_JUSTIFICATIVA = r.COD_JUSTIFICATIVA) COD_JUSTIFICATIVA',
'                    , r.COD_CCUSTO_CONTABIL',
'                    , r.observacoes',
'              into l_pos',
'                  , :P181_COD_ITEM',
'                  , :P181_DT_REQ',
'                  , :P181_DT_SIT_REQ',
'                  , :P181_COD_SIT_REQ',
'                  , :P181_TIPO',
'                  , :P181_TIPO_DISP_NOVO_DSP',
'                  , :P181_TIPO_CODE',
'                  , :P181_COD_EMP_REQ',
'                  , :p181_MAT_REQ',
'                  , :P181_TIPO_EVENTO',
'                  , :P181_COD_EVENTO',
'                  , :P181_QTD_HORAS',
'                  , :P181_DATA',
'                  , :P181_TIPO_EVENTO_NOVO_DSP',
'                  , :P181_COD_EVENTO_NOVO_DSP',
'                  , :P181_QTD_HORAS_NOVO_DSP',
'                  , :P181_BH_APURADO',
'                  , :P181_BH_APURADO_DSP',
'                  , :P181_COD_EMPRESA',
'                  , :P181_MATRICULA',
'                  , :P181_COD_JUSTIFICATIVA_DSP',
'                  , :P181_COD_CCUSTO_CONTABIL_DSP',
'                  , :P181_OBSERVA',
'            from PE_REQ_APURACAO r    --, PE_RESULTADO_APURACAO a',
'            where  r.cod_req = :P181_COD_REQ;',
'            ',
'            :P181_DATA_PONTO_DSP     := :P181_DATA;',
'            :P181_NOVA_REQUISICAO    := :P181_COD_REQ;',
'        exception',
'            when others then',
'                l_pos  := 0; ',
'                l_erro := SQLERRM;',
unistr('                apex_error.add_error(p_message => ''(''||l_step||'') Erro geral ao recuperar dados da requisi\00E7\00E3o ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);'),
'        end;',
'        if l_pos != 0 then',
'            l_step := 3;',
'            if :P181_TIPO_EVENTO = ''PONTO'' then',
'                  l_step := 3.5;',
'                  begin   ',
'                      select      cod_evento_folha||'' - ''||descricao descricao',
'                      into :P181_EVENTO',
'                        from pe_eventos_folha p',
'                        where cod_evento_folha = :P181_COD_EVENTO',
'                     and p.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'                  exception',
'                      when others then',
'                    l_erro := SQLERRM;',
'                    apex_error.add_error(p_message => ''(''||l_step||'') Erro geral ao recuperar dados do evento folha atual ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'                  end;',
'            else',
'            l_step := 3.6;',
'                begin',
'                    select    cod_evento_banco||'' - ''||descricao descricao',
'                    into :P181_EVENTO',
'                    from pe_eventos_banco b',
'                    where cod_evento_banco =  :P181_COD_EVENTO',
'                     and b.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'                exception',
'                    when others then',
'                        l_erro := SQLERRM;',
'                        apex_error.add_error(p_message => ''(''||l_step||'') Erro ao recuperar dados do evento banco atual ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'                end;',
'            end if;',
'            --',
'            l_step := 4;',
'            if :P181_TIPO_EVENTO_NOVO_DSP = ''PONTO'' then',
'            l_step := 4.5;',
'                  begin   ',
'                      select      cod_evento_folha||'' - ''||descricao descricao',
'                      into :P181_COD_EVENTO_NOVO_DSP',
'                        from pe_eventos_folha p',
'                        where cod_evento_folha = :P181_COD_EVENTO_NOVO_DSP',
'                     and p.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'                  exception',
'                      when others then',
'                    l_erro := SQLERRM;',
'                    apex_error.add_error(p_message => ''(''||l_step||'') Erro geral ao recuperar dados do evento folha novo ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'                  end;',
'            else',
'            l_step := 4.6;',
'                begin',
'                    select    cod_evento_banco||'' - ''||descricao descricao',
'                    into :P181_COD_EVENTO_NOVO_DSP',
'                    from pe_eventos_banco b',
'                    where cod_evento_banco =  :P181_COD_EVENTO_NOVO_DSP',
'                     and b.cod_empresa = nvl(:P181_EMP, :P181_COD_EMP_REQ); ',
'                exception',
'                    when others then',
'                        l_erro := SQLERRM;',
'                        apex_error.add_error(p_message => ''(''||l_step||'') Erro ao recuperar dados do evento banco novo ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);',
'                end;',
'            end if;',
'            --:P181_DATA_PONTO_DSP     := :P181_DATA;',
'            --:P181_TIPO_DISP_NOVO_DSP := :P181_TIPO;        ',
'        end if;        ',
'    end if;',
'    ',
'    select ',
'        ifs.cod_empresa||'' - ''||(select nome from empresas_cad where cod = ifs.cod_empresa) empresa',
'      , ifs.matricula||'' - ''||( select distinct  nome',
'                                            from inf_pessoais_cad ip,  ',
'                                                 informacoes_funcionais_cad if',
'                                            where if.matricula = ip.matricula',
'                                            and if.cod_empresa =  ip.cod_empresa',
'                                            and if.cod_empresa =  ifs.cod_empresa',
'                                            and if.matricula = ifs.matricula) matricula',
'    into :P181_COD_EMPRESA, :P181_MATRICULA',
'    from informacoes_funcionais ifs ',
'        where cod_empresa = :P181_EMP',
'           and matricula = :P181_MAT;',
'exception',
'    when others then',
'        l_erro := SQLERRM;',
unistr('        apex_error.add_error(p_message => ''(''||l_step||'') Erro geral ao recuperar dados da requisi\00E7\00E3o ''||:P181_COD_REQ||''. => ''||l_erro, p_display_location => apex_error.c_inline_in_notification);'),
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(145562706120067211614)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Permite cancelar concluida'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_operador_cancela_concluida       parametros_recursos_humanos.operador_cancela_concluida%type;',
'    l_operador_cancela_requisicoes     parametros_recursos_humanos.operador_cancela_requisicoes%type;',
'begin',
'    :P181_OPERADOR_DELETA := ''N'';',
'    :P181_OPERADOR_DELETA_DEMAIS := ''N'';',
'    --',
'    if :P181_COD_SIT_REQ != 3 then    -- Nao cancelada',
'        select operador_cancela_concluida',
'            into l_operador_cancela_concluida',
'        from parametros_recursos_humanos',
'            where cod_empresa = :P_EMPRESA_USER;',
'        --',
'        select operador_cancela_requisicoes',
'            into l_operador_cancela_requisicoes',
'        from parametros_recursos_humanos',
'            where cod_empresa = :P_EMPRESA_USER;',
'        --',
'        if :P_PAINEL = ''PO'' then      -- Painel do Operador',
'            --',
'            if l_operador_cancela_concluida = ''S'' and :P181_COD_SIT_REQ = 2 then',
'                :P181_OPERADOR_DELETA := ''S'';',
'            end if;',
'            if l_operador_cancela_requisicoes = ''S'' /*and :P181_COD_SIT_REQ = 2*/ then',
'                :P181_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;',
'            ',
'        elsif :P_PAINEL = ''PG'' then     -- Painel do Gestor',
'        --sekect periodo gestor',
'            if (:P181_COD_SIT_REQ = 2 or :P181_COD_SIT_REQ = 1 )  then',
'                :P181_OPERADOR_DELETA := ''S'';',
'                :P181_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;',
'            ',
'        else    -- Painel do Colaborador',
'            --',
'            if :P181_COD_SIT_REQ = 1 then',
'                :P181_OPERADOR_DELETA := ''S'';',
'                :P181_OPERADOR_DELETA_DEMAIS := ''S'';',
'            end if;        ',
'        end if;',
'   end if;',
'exception',
'when others then null;',
'end;    '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(115498745899056583693)
,p_process_sequence=>60
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Recupera justificativa'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_msg varchar2(4000);',
'begin',
'',
'    PKG_JUSTIFICA_PONTO_HIST.recupera_justificativa(p_cod_empresa       => :P181_EMP,',
'                                                  p_cod_item            => :P181_COD_ITEM,',
'                                                  p_matricula           => :P181_MAT,',
'                                                  p_data                => :P181_DATA,',
'                                                  p_qtd_horas           => :P181_QTD_HORAS,',
'                                                  p_tipo_evento         => :P181_TIPO_EVENTO,',
'                                                  p_cod_evento          => :P181_COD_EVENTO,',
'                                                  p_posicao             => :P181_POSICAO,',
'                                                  --p_cod_item            => :P181_COD_ITEM,',
'                                                  p_justificativa       => :P181_JUSTIFICATIVA,  ',
'                                                  p_cod_ccusto_contabil => :P181_CCUSTO_CONTABIL,',
'                                                  p_observacoes         => :P181_OBSERVACOES,',
'                                                  p_mensagem            => v_msg);',
'',
'    if v_msg is not null then',
'        :P181_MENSAGEM := v_msg;',
'    end if;',
'exception    ',
'    when others then',
'        :P181_JUSTIFICATIVA  := null;',
'        :P181_CCUSTO_CONTABIL:= null;',
'        :P181_OBSERVACOES    := null;',
'end;  '))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(66764183962436284628)
,p_process_sequence=>70
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida_Limite_Apuracao'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_QTD_APURACAO 			NUMBER;',
'V_QTD_LIMI_APURACAO 	NUMBER;',
'V_DATA_INI_REF_PONTO	DATE;',
'V_DATA_FIM_REF_PONTO	DATE;',
'',
'BEGIN',
'    :P181_CONSULTA := ''S''; ',
'    :P181_MENSAGEM_LIMITE := null;',
'    if NVL(:P181_CONSULTA, ''S'') = ''C'' then',
'        :P181_OCULTA_BTN := ''N'';',
'    :P181_CONSULTA  := ''noif'';',
'        BEGIN',
'         SELECT TRUNC(DATA_INI_REF_PONTO) DATA_INI_REF_PONTO, ',
'                TRUNC(DATA_FIM_REF_PONTO) DATA_FIM_REF_PONTO',
'           INTO V_DATA_INI_REF_PONTO',
'             ,  V_DATA_FIM_REF_PONTO',
'           FROM PARAMETROS_RECURSOS_HUMANOS',
'          WHERE COD_EMPRESA = :P181_EMP;',
'        EXCEPTION WHEN OTHERS THEN',
'        V_DATA_INI_REF_PONTO := TRUNC(SYSDATE);',
'        V_DATA_FIM_REF_PONTO := TRUNC(SYSDATE);',
'        END;		 ',
'',
'        BEGIN',
'        SELECT COUNT(1) QTD',
'          INTO V_QTD_APURACAO',
'          FROM PE_REQ_APURACAO PRQ',
'         WHERE PRQ.COD_EMPRESA = :P181_EMP',
'           AND PRQ.MATRICULA = :P181_MAT',
'           AND TRUNC(PRQ.DATA_PONTO) BETWEEN TRUNC(V_DATA_INI_REF_PONTO) AND TRUNC(V_DATA_FIM_REF_PONTO);',
'        EXCEPTION WHEN OTHERS THEN',
unistr('        :P181_MENSAGEM_LIMITE := ''Erro ao processar a quantidade de Apura\00E7\00E3o na Matricula ''||:P181_MAT;'),
'        END;',
'',
'        BEGIN',
'        SELECT NVL(PAG.QUANTIDADE_LIMITE_APURA,999) QTD',
'            INTO V_QTD_LIMI_APURACAO',
'          FROM PE_PERFIL_ABONO_GERAL PAG',
'         WHERE PAG.COD_EMPRESA = :P181_EMP',
'           AND CD_PERFIL = :P_PERFIL;',
'        EXCEPTION',
'           WHEN NO_DATA_FOUND THEN',
'             V_QTD_LIMI_APURACAO := 999;',
'           WHEN OTHERS THEN',
unistr('             :P181_MENSAGEM := ''Erro ao processar a quantidade de Limite Apura\00E7\00E3o.'';'),
'        END;',
'',
'        IF V_QTD_LIMI_APURACAO <= V_QTD_APURACAO THEN ',
unistr('        :P181_MENSAGEM_LIMITE := ''Per\00EDodo ''||V_DATA_INI_REF_PONTO||'' - ''||V_DATA_FIM_REF_PONTO||'' - A matr\00EDcula excedeu o limite de apura\00E7\00E3o. Quantidade Limite: ''||V_QTD_LIMI_APURACAO||'' - Quantidade Registrada: ''||V_QTD_APURACAO||''. Por favor, verif')
||'ique.'';',
'        :P181_OCULTA_BTN := ''S'';',
'        END IF;',
'    END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(49627112633088413646)
,p_process_sequence=>80
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Horas Resultado x Requisicoes'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'    v_horas_apuracao         varchar2(12);',
'    v_horas_requisicao       varchar2(12);    ',
'    v_minuto_apuracao        varchar2(12);',
'    v_minuto_requisicao      varchar2(12);',
'    APURACAO VARCHAR2(10);',
'    REQUISICAO VARCHAR2(10);',
'    saldoH  VARCHAR2(10);',
'    saldoM  VARCHAR2(10);',
'    saldo  VARCHAR2(10);',
'',
'BEGIN',
'',
' SELECT TO_HOURS(  NVL(Fnct_Tot_Horas(NVL(SUM(horas), 0), NVL(SUM(minutos), 0)),   0) )',
'               INTO APURACAO',
'        FROM (SELECT SUM(SUBSTR(RA.QTD_HORAS,',
'                                1,',
'                                INSTR(RA.QTD_HORAS, '':'') - 1) ) horas,',
'                     SUM(SUBSTR(RA.QTD_HORAS, INSTR(RA.QTD_HORAS, '':'') + 1) ) minutos',
'    from pe_resultado_apuracao RA',
'    where cod_empresa = :P181_EMP',
'       and matricula = :P181_MAT ',
'       and TO_CHAR(data, ''DD/MM/YYYY'') = :P181_DATA',
'       and cod_evento  = :P181_COD_EVENTO );',
'',
'    SELECT TO_HOURS(  NVL(Fnct_Tot_Horas(NVL(SUM(horas), 0), NVL(SUM(minutos), 0)),   0) )',
'               INTO REQUISICAO',
'        FROM (SELECT SUM(SUBSTR(RA.QTD_HORAS,',
'                                1,',
'                                INSTR(RA.QTD_HORAS, '':'') - 1) ) horas,',
'                     SUM(SUBSTR(RA.QTD_HORAS, INSTR(RA.QTD_HORAS, '':'') + 1) ) minutos',
'    from pe_req_apuracao RA',
'    where cod_empresa = :P181_EMP',
'       and matricula = :P181_MAT ',
'       and TO_CHAR(data_ponto, ''DD/MM/YYYY'') =  :P181_DATA',
'       and cod_evento_atual = :P181_COD_EVENTO',
'    and cod_sit_req = 1); ',
'    ',
'    v_horas_apuracao      := SUBSTR(APURACAO, 1, INSTR(APURACAO, '':'') -1);           ',
'    v_horas_requisicao    := SUBSTR(REQUISICAO, 1, INSTR(REQUISICAO, '':'') -1);        ',
'    v_minuto_apuracao     := SUBSTR(APURACAO, INSTR(APURACAO, '':'') +1);   ',
'    v_minuto_requisicao   := SUBSTR(REQUISICAO, INSTR(REQUISICAO, '':'') +1);      ',
'    saldoH :=  (v_horas_apuracao - v_horas_requisicao);',
'    saldoM :=  (v_minuto_apuracao - v_minuto_requisicao);',
'    saldo := Fnct_Tot_Horas((v_horas_apuracao - v_horas_requisicao) , (v_minuto_apuracao - v_minuto_requisicao));',
'    saldo := to_hours(saldo);',
'',
'    --:P181_QTD_HORAS_NOVO := saldo;',
'    :P181_HORAS_APURACAO := APURACAO;',
'    :P181_HORAS_REQUISICAO := REQUISICAO;',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        APEX_ERROR.ADD_ERROR (',
'                                p_message          => SQLERRM,',
'                                p_display_location => APEX_ERROR.c_inline_in_notification);',
'END;',
''))
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
