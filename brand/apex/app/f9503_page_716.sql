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
--   Date and Time:   00:20 Friday October 2, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 716
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00716
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>716);
end;
/
prompt --application/pages/page_00716
begin
wwv_flow_api.create_page(
 p_id=>716
,p_user_interface_id=>wwv_flow_api.id(201541282673876378229)
,p_name=>unistr('Requisi\00E7\00E3o de Hora Extra')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Requisi\00E7\00E3o de Hora Extra')
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_HoraExtra.css'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_HoraExtra.js'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_chained=>'N'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_HoraExtra.css / Natcorp_HoraExtra.js)',
'',
unistr('A estrutura \00E9 toda do APEX; o .js s\00F3 reorganiza a leitura (sem classe no APEX).'),
unistr('Pedido novo: abertura com o caminho do pedido (voc\00EA pede, quem aprova autoriza, voc\00EA faz as'),
unistr('  horas) e quatro passos: 1. Quem vai fazer (a caixa abre a lista); 2. Em que dia (Hoje, Amanh\00E3,'),
unistr('  S\00E1bado e o dia por extenso); 3. Em que hor\00E1rio: o rel\00F3gio de ponteiros (clockpicker) d\00E1 lugar'),
'  ao seletor de hora do aparelho (input type=time, valor HH:MM), atalhos de 1 a 4 horas e a',
unistr('  r\00E9gua do dia com a dura\00E7\00E3o; 4. Por que precisa (come\00E7os de motivo que escrevem na caixa).'),
unistr('  Rodap\00E9: a frase do pedido, o que falta e "Criar" = "Enviar pedido".'),
unistr('Pedido gravado: cabe\00E7alho (n\00BA, situa\00E7\00E3o, de quem, dia, hor\00E1rio na r\00E9gua, motivo, quem pediu);'),
unistr('  as abas viram uma p\00E1gina s\00F3 e a aprova\00E7\00E3o \00E9 o caminho das outras requisi\00E7\00F5es. Aprovar e'),
unistr('  Reprovar entram no caminho s\00F3 com uma etapa pendente.'),
'',
unistr('Nada \00E9 gravado pelo desenho. Para desligar tudo: tire as duas URLs de arquivo.'),
'Guia: brand/apex/app/HORAEXTRA-MANUTENCAO.md.'))
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260909094119'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(201318425907701461452)
,p_plug_name=>unistr('BOT\00D5ES')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(201541248682716378122)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(203739284598377629343)
,p_plug_name=>unistr('Abonar Marca\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(201318426286754461456)
,p_plug_name=>'MENU'
,p_parent_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
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
 p_id=>wwv_flow_api.id(203739293409561629354)
,p_plug_name=>'Hora Extra'
,p_parent_plug_id=>wwv_flow_api.id(201318426286754461456)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_api.id(201541256677038378135)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(203739295819608629356)
,p_name=>'Aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(201318426286754461456)
,p_template=>wwv_flow_api.id(201541256677038378135)
,p_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*select ''ROWID'', cod_emp_aprov||'' - ''||mat_aprov||'' - ''||initcap(fnct_nome_func(cod_emp_aprov,mat_aprov)) aprovador, dt_aprov Data, STATUS_APROV Status, cod_emp_aprov, mat_aprov',
'  from APROVA_HORA_EXTRA',
' where cod_solicitacao = :P716_COD_REQ  --:p716_cod_req',
' order by seq_aprov*/',
'',
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from APROVA_HORA_EXTRA a, usuario_oracle u',
' where a.cod_solicitacao = :P716_COD_REQ --:p714_cod_req ',
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
'  from APROVA_HORA_EXTRA a, usuario_oracle u',
' where a.cod_solicitacao = :P716_COD_REQ --:p714_cod_req ',
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
'  from APROVA_HORA_EXTRA',
' where cod_solicitacao = :p716_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P716_COD_REQ'
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
 p_id=>wwv_flow_api.id(188981763841192339704)
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
 p_id=>wwv_flow_api.id(188981764227665339705)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(188981764659892339705)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(188981764990639339705)
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
 p_id=>wwv_flow_api.id(188981765452553339706)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(188981765829162339706)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(170762836351791914611)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_column_heading=>'Seq Aprov'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(170762836417561914612)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981751792017339692)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(201318425907701461452)
,p_button_name=>'p716_btn_cancelar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981767062184339707)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(203739295819608629356)
,p_button_name=>'p716_btn_reprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(201541277642356378179)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P716_COD_REQ.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_HE.Valida_Sequencia(:p716_cod_empresa, :p716_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
 p_id=>wwv_flow_api.id(188981752189784339693)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(201318425907701461452)
,p_button_name=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p716_rowid is not null and :p716_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981752582976339693)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(201318425907701461452)
,p_button_name=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(201541277468636378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P716_COD_REQ'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(188981767460322339707)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(203739295819608629356)
,p_button_name=>'p716_btn_aprovar'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(201541277642356378179)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P716_COD_REQ.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_REQ_HE.Valida_Sequencia(:p716_cod_empresa, :p716_cod_req, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(188981793970945339728)
,p_branch_name=>'Voltar'
,p_branch_action=>'f?p=&APP_ID.:138:&SESSION.::&DEBUG.:RP,138:P138_EMP,P138_MAT:&P716_EMP.,&P716_MAT.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981753362860339694)
,p_name=>'P716_ROWID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981753721483339694)
,p_name=>'P716_FLAG'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981754114864339695)
,p_name=>'P716_MENSAGEM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981754563486339695)
,p_name=>'P716_OK'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981754934430339695)
,p_name=>'P716_ITEM_VALIDACAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981755315065339696)
,p_name=>'P716_COD_REQ'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981755760601339696)
,p_name=>'P716_DT_REQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Requisi\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981756150737339696)
,p_name=>'P716_COD_SIT_REQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
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
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981756528226339697)
,p_name=>'P716_DT_SIT_REQ'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Situa\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981756941400339697)
,p_name=>'P716_SOLICITANTE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_prompt=>'Solicitante'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cargo ',
'  from informacoes_funcionais',
' where cod_empresa = :p716_cod_emp_req',
'   and matricula = :p716_mat_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'return :p716_cod_emp_req||'' - ''||initcap(fnct_nome_empresa(:p716_cod_emp_req))||'' / ''||:p716_mat_req||'' - ''||initcap(fnct_nome_func(:p716_cod_emp_req,:p716_mat_req));',
'',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981757281632339697)
,p_name=>'P716_EMP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981757749007339698)
,p_name=>'P716_MAT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981758082991339698)
,p_name=>'P716_COD_EMP_REQ'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa Requisitante'
,p_source=>'COD_EMP_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981758551778339698)
,p_name=>'P716_MAT_REQ'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula Requisitante')
,p_source=>'MAT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981758916596339699)
,p_name=>'P716_FIL_REQ'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial'
,p_source=>'FIL_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981759301555339699)
,p_name=>'P716_COD_EMPRESA'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
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
'        (f_acesso_emp_pg_apex(cod, :p_usuario, :p_painel) = ''S'' and :p_painel = ''PO'') or ',
'       (cod = :P_EMPRESA_USER and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_read_only_when=>'P716_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981759771732339699)
,p_name=>'P716_MATRICULA'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_placeholder=>'- Selecione -'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula)) descricao, matricula cod',
'  from informacoes_funcionais_cad i',
' where cod_empresa = :p716_cod_empresa',
'   and i.situacao < ''90''',
'   and i.marca_ponto = ''S''',
'    AND ((f_acesso_pg_apex(i.cod_empresa, i.matricula, i.filial, i.cd_nivel, :p_usuario, :p_painel, ''PONTO'') = ''S'' and :p_painel in (''PO'',''PG'')) or ',
'         (i.cod_empresa = :P_EMPRESA_USER',
'         and i.matricula = :P_MATRICULA_USER',
'         and :p_painel = ''PC''))',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P716_COD_EMPRESA'
,p_ajax_items_to_submit=>'P716_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_read_only_when=>'P716_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981760174622339700)
,p_name=>'P716_USUARIO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981760488362339700)
,p_name=>'P716_DT_ATUALIZACAO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(203739284598377629343)
,p_use_cache_before_default=>'NO'
,p_format_mask=>'DD/MM/RRRR HH24:MI'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981761496764339701)
,p_name=>'P716_DATA_PONTO'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(203739293409561629354)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_placeholder=>'- Selecione -'
,p_source=>'DATA_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_read_only_when=>'P716_COD_REQ'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981761916703339702)
,p_name=>'P716_JORNADA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(203739293409561629354)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981762373880339702)
,p_name=>'P716_HORA_INICIAL'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(203739293409561629354)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora Inicial'
,p_source=>'HORA_INICIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981762690516339703)
,p_name=>'P716_HORA_FINAL'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(203739293409561629354)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Hora Final'
,p_source=>'HORA_FINAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981763084971339703)
,p_name=>'P716_COMENTARIOS'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(203739293409561629354)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Coment\00E1rio')
,p_source=>'COMENTARIOS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>1000
,p_cHeight=>2
,p_read_only_when=>'P716_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(201541277125760378172)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(188981767781085339708)
,p_name=>'P716_OBS_APROVADOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(203739295819608629356)
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
' where cod_solicitacao = :p716_cod_req',
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
 p_id=>wwv_flow_api.id(188981768345070339708)
,p_validation_name=>'Valida_Cod_Sit_Req'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_req',
'  from PE_REQ_HORA_EXTRA',
' where cod_req = :p716_cod_req;',
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
' pkg_req_he.Valida_Sit_Req(:p716_cod_empresa, :p716_cod_req, :p716_matricula, :p716_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'end if;',
'',
' if v_msg_retorno is not null and v_flg_retorno = ''N'' then',
'  return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(188981756150737339696)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(189527751280465425121)
,p_validation_name=>'Valida Horas Extras'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(550) DEFAULT NULL;',
'  --',
'  vQtHrsRegSem   VARCHAR2(10) DEFAULT NULL;',
'  vQtHrsAcumul   VARCHAR2(10) DEFAULT NULL; ',
'  vQtHrsExcedi   VARCHAR2(10) DEFAULT NULL;',
'BEGIN',
'  IF :P716_DATA_PONTO IS NOT NULL AND :P716_HORA_INICIAL IS NOT NULL AND :P716_HORA_FINAL IS NOT NULL THEN',
'    vReturn := PKG_REQ_HE.fnc_VerifLimiteHorasExtras(pEmpresa   => :P716_COD_EMPRESA',
'                                                    ,pmatricula => :P716_MATRICULA',
'                                                    ,pHrExtraI  => :P716_HORA_INICIAL',
'                                                    ,pHrExtraF  => :P716_HORA_FINAL',
'                                                    ,pdata      => :P716_DATA_PONTO',
'                                                    ,pUser      => :P_USUARIO);',
'    --',
'    IF vReturn IS NULL THEN',
'      vReturn := PKG_REQ_HE.fnc_ValBancoHrsTotalHrs(pEmpresa   => :P716_COD_EMPRESA',
'                                                   ,pmatricula => :P716_MATRICULA',
'                                                   ,pDtInicio  => :P716_DATA_PONTO',
'                                                   ,pHoraIni   => :P716_HORA_INICIAL',
'                                                   ,pHoraFim   => :P716_HORA_FINAL',
'                                                   ,pQtdHrsRegSemanal => vQtHrsRegSem',
'                                                   ,pQtdHrsAcumuladas => vQtHrsAcumul',
'                                                   ,pQtdHrsExcedidas  => vQtHrsExcedi);',
'    END IF;                                               ',
'  END IF; ',
'  --',
'  IF vReturn IS NOT NULL THEN',
unistr('    vReturn := ''<strong>Inclus\00E3o de Hora Extra N\00C3O Permitida!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(188981752582976339693)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981772243005339712)
,p_name=>'Hide Fields'
,p_event_sequence=>35
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P716_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981772728558339712)
,p_event_id=>wwv_flow_api.id(188981772243005339712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_COD_REQ,P716_DT_REQ,P716_COD_SIT_REQ,P716_DT_SIT_REQ,P716_COD_EMP_REQ,P716_MAT_REQ,P716_SOLICITANTE,P716_FIL_REQ'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981773164154339712)
,p_name=>'Hide Fields_1'
,p_event_sequence=>45
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981773608432339713)
,p_event_id=>wwv_flow_api.id(188981773164154339712)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_COD_EMP_REQ,P716_MAT_REQ,P716_FIL_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981774012208339713)
,p_name=>'Dois Pontos'
,p_event_sequence=>65
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_HORA_INICIAL,P716_HORA_FINAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981774546703339713)
,p_event_id=>wwv_flow_api.id(188981774012208339713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p716_hora_inicial is not null then',
'    :p716_hora_inicial := substr(trim(to_char(replace(:p716_hora_inicial,'':''),''0000'')),1,2)||'':''||substr(trim(to_char(replace(:p716_hora_inicial,'':''),''0000'')),3,2);',
'    else ',
'    :p716_hora_inicial := null;',
'    end if;',
'    ',
'    if :p716_hora_final is not null then',
'    :p716_hora_final := substr(trim(to_char(replace(:p716_hora_final,'':''),''0000'')),1,2)||'':''||substr(trim(to_char(replace(:p716_hora_final,'':''),''0000'')),3,2);',
'    else ',
'    :p716_hora_final := null;',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P716_HORA_INICIAL,P716_HORA_FINAL'
,p_attribute_03=>'P716_HORA_INICIAL,P716_HORA_FINAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981774965959339713)
,p_name=>'Enable Fields (Create)'
,p_event_sequence=>105
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981752582976339693)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981775453988339715)
,p_event_id=>wwv_flow_api.id(188981774965959339713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$x(''P716_HORA_BATIDA'').disabled = false;',
'$x(''P716_DATA_PONTO'').disabled = false;',
'$x(''P716_COD_REQ'').disabled = false;',
'$x(''P716_DT_REQ'').disabled = false;',
'$x(''P716_COD_SIT_REQ'').disabled = false;',
'$x(''P716_DT_SIT_REQ'').disabled = false;',
'$x(''P716_COD_EMP_REQ'').disabled = false;',
'$x(''P716_MAT_REQ'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981775909915339715)
,p_event_id=>wwv_flow_api.id(188981774965959339713)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981776340442339715)
,p_name=>'Enable Fields (Save)'
,p_event_sequence=>115
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981752189784339693)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981776851471339716)
,p_event_id=>wwv_flow_api.id(188981776340442339715)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_HORA_INICIAL,P716_HORA_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981777311322339716)
,p_event_id=>wwv_flow_api.id(188981776340442339715)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981777730359339716)
,p_name=>'pre-insert'
,p_event_sequence=>125
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981752582976339693)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981778263730339717)
,p_event_id=>wwv_flow_api.id(188981777730359339716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'/*',
'cursor c1 is',
'select nvl(max(cod_req),1) seq',
'  from pe_req_tratamento_batimentos;',
'',
'v_c1 c1%rowtype;',
'*/',
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
'v_data date := :p716_data;',
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
':p716_cod_req := v_seq;',
':p716_cod_sit_req := 1;',
':p716_dt_req := sysdate;',
':p716_dt_sit_req := sysdate;',
':p716_cod_emp_req := :P_EMPRESA_USER;',
':p716_mat_req := :P_MATRICULA_USER;',
'--:p716_cod_empresa := :p716_emp;',
'--:p716_matricula := :p716_mat;',
'--:p716_posicao_x       := :p716_posicao;',
':p716_fil_req := v_c1.filial;',
':p716_usuario := :p_usuario;',
'--:p716_data_Ponto := nvl(:P716_DATA_PONTO,:P716_DATA);',
'',
'end;'))
,p_attribute_02=>'P716_EMP,P716_MAT,P716_DATA_PONTO'
,p_attribute_03=>'P716_COD_REQ,P716_COD_SIT_REQ,P716_DT_REQ,P716_DT_SIT_REQ,P716_COD_EMP_REQ,P716_MAT_REQ,P716_FIL_REQ,P716_USUARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981778672710339717)
,p_name=>'Show Fields (Create)'
,p_event_sequence=>145
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981752582976339693)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981779087836339717)
,p_event_id=>wwv_flow_api.id(188981778672710339717)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_COD_REQ,P716_DT_REQ,P716_COD_SIT_REQ,P716_DT_SIT_REQ,P716_COD_EMP_REQ,P716_MAT_REQ,P716_FIL_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981779549685339717)
,p_name=>'Show Fields (Save)'
,p_event_sequence=>155
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(199816293583544518980)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981779976351339718)
,p_event_id=>wwv_flow_api.id(188981779549685339717)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_COD_REQ,P716_DT_REQ,P716_COD_SIT_REQ,P716_DT_SIT_REQ,P716_COD_EMP_REQ,P716_MAT_REQ,P716_FIL_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981780469631339718)
,p_name=>'Dispara Alerta'
,p_event_sequence=>205
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_MENSAGEM'
,p_condition_element=>'P716_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981780934550339718)
,p_event_id=>wwv_flow_api.id(188981780469631339718)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P716_FLAG'').value == "Q") {',
'alertify.confirm($v(''P716_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P716_FLAG'').value = ''S'';',
'        $x(''P716_MENSAGEM'').value = '''';',
'        $x(''P716_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P716_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P716_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P716_FLAG'').value == "N") {',
'            $x(''P716_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P716_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P716_OK'').value = ''S'';',
'            }',
'        }',
'            ',
'        alertify.alert($v(''P716_MENSAGEM''));',
'        ',
'        ',
'    }else{',
'            if ($x(''P716_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P716_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P716_ITEM_VALIDACAO'').value == ''P716_CREATE''){',
'            $x(''P716_OK'').value = ''S'';',
'        $x(''P716_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981781288556339719)
,p_name=>'OK: Show Create'
,p_event_sequence=>215
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_ITEM_VALIDACAO'
,p_condition_element=>'P716_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981781777435339719)
,p_event_id=>wwv_flow_api.id(188981781288556339719)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981782367631339719)
,p_event_id=>wwv_flow_api.id(188981781288556339719)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981782830741339720)
,p_event_id=>wwv_flow_api.id(188981781288556339719)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981783335273339720)
,p_event_id=>wwv_flow_api.id(188981781288556339719)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981783767677339720)
,p_name=>'Ativa Alertify'
,p_event_sequence=>225
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981784219514339721)
,p_event_id=>wwv_flow_api.id(188981783767677339720)
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
 p_id=>wwv_flow_api.id(188981784647629339721)
,p_name=>unistr('Retorna Hor\00E1rio de Jornada')
,p_event_sequence=>235
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_HORA_BATIDA_ABONO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981785104198339721)
,p_event_id=>wwv_flow_api.id(188981784647629339721)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_HORA_BATIDA_ABONO VARCHAR2(5) := :P716_HORA_BATIDA_ABONO;',
'',
'BEGIN',
'',
'if :P716_HORA_BATIDA_ABONO IS NULL THEN',
':P716_HORA_BATIDA_ABONO := :P716_JORNADA;',
'else',
':P716_HORA_BATIDA_ABONO := V_HORA_BATIDA_ABONO;',
'END IF;',
'',
'END;'))
,p_attribute_02=>'P716_HORA_BATIDA_ABONO,P716_JORNADA'
,p_attribute_03=>'P716_HORA_BATIDA_ABONO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981785527194339722)
,p_name=>'Valida Sit Req'
,p_event_sequence=>245
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_COD_SIT_REQ'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981785997404339722)
,p_event_id=>wwv_flow_api.id(188981785527194339722)
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
'  from PE_REQ_HORA_EXTRA',
' where cod_req = :p716_cod_req;',
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
' pkg_req_he.Valida_Sit_Req(:p716_cod_empresa, :p716_cod_req, :p716_matricula, :p716_cod_sit_req, :p_usuario, v_flg_retorno, v_msg_retorno);',
'',
'NULL;',
'',
'end if;',
'',
' if v_msg_retorno is not null then',
'    :p716_ok       := ''N'';',
'    :p716_flag     := v_flg_retorno;',
'    :p716_mensagem := v_msg_retorno;',
' else',
'    :p716_flag     := null;',
'    :p716_mensagem := null;',
'    :p716_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P716_COD_EMPRESA,P716_COD_REQ,P716_COD_SIT_REQ,P_USUARIO,P716_MATRICULA'
,p_attribute_03=>'P716_FLAG,P716_MENSAGEM,P716_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981786416288339722)
,p_name=>'Valida_Data'
,p_event_sequence=>255
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_DATA_PONTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981786906464339723)
,p_event_id=>wwv_flow_api.id(188981786416288339722)
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
'v_item_validacao varchar2(100) := :P716_ITEM_VALIDACAO;',
'',
'begin',
'',
' :p716_mensagem := null;',
' ',
'  pkg_req_he.Valida_Data(:p716_cod_empresa',
'                                 ,:p716_matricula',
'                                 ,:p716_data_ponto',
'                                 ,v_flg_retorno',
'                                 ,v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'    :P716_ITEM_VALIDACAO := TRIM(UPPER(''p716_data_ponto''));',
'    :p716_ok       := ''N'';',
'    :p716_flag     := v_flg_retorno;',
'    :p716_mensagem := v_msg_retorno;',
' else',
'    :p716_flag     := null;',
'    :p716_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p716_data_ponto'')) OR v_item_validacao IS NULL then',
'       :P716_OK := ''S'';',
'       :P716_ITEM_VALIDACAO := null;',
'    else',
'       :P716_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P716_ITEM_VALIDACAO,P716_COD_EMPRESA,P716_MATRICULA,P716_DATA_PONTO'
,p_attribute_03=>'P716_ITEM_VALIDACAO,P716_MENSAGEM,P716_OK,P716_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981787304920339723)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>265
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P716_COD_SIT_REQ'
,p_condition_element=>'P716_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P716_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981787782667339723)
,p_event_id=>wwv_flow_api.id(188981787304920339723)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981788370770339724)
,p_event_id=>wwv_flow_api.id(188981787304920339723)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981788869837339724)
,p_event_id=>wwv_flow_api.id(188981787304920339723)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981789342016339724)
,p_event_id=>wwv_flow_api.id(188981787304920339723)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981789699145339725)
,p_name=>'Disable Fields'
,p_event_sequence=>275
,p_condition_element=>'P716_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981790175741339725)
,p_event_id=>wwv_flow_api.id(188981789699145339725)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_HORA_INICIAL,P716_HORA_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981790687761339725)
,p_event_id=>wwv_flow_api.id(188981789699145339725)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P716_HORA_INICIAL,P716_HORA_FINAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981791097874339726)
,p_name=>'Close Dialog'
,p_event_sequence=>285
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981751792017339692)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981791576804339726)
,p_event_id=>wwv_flow_api.id(188981791097874339726)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981791992521339726)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>295
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981767460322339707)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981792486752339727)
,p_event_id=>wwv_flow_api.id(188981791992521339726)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(188981792974089339727)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>305
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(188981767062184339707)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(188981793376035339727)
,p_event_id=>wwv_flow_api.id(188981792974089339727)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981768636431339709)
,p_process_sequence=>10
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
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;   ',
'',
'v_data date := :p716_data;',
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
':p716_cod_req := v_seq;',
':p716_cod_sit_req := 1;',
':p716_dt_req := sysdate;',
':p716_dt_sit_req := sysdate;',
':p716_cod_emp_req := :P_EMPRESA_USER;',
':p716_mat_req := :P_MATRICULA_USER;',
'--:p716_cod_empresa := :p716_emp;',
'--:p716_matricula := :p716_mat;',
'--:p716_posicao_x       := :p716_posicao;',
':p716_fil_req := v_c1.filial;',
':p716_usuario := :p_usuario;',
'--:p716_data_Ponto := nvl(:P716_DATA_PONTO,:P716_DATA);',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(188981752582976339693)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981771789440339711)
,p_process_sequence=>20
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
':p716_usuario := :p_usuario;',
':p716_dt_atualizacao := sysdate;',
'',
'/*',
'if :p716_hora_inicial is not null then',
':p716_hora_inicial       := :p716_data||'' ''||:p716_hora_batida;',
'end if;',
'',
'if :p716_hora_inicial is not null then',
':p716_hora_inicial := :p716_data||'' ''||:p716_hora_batida_abono;',
'end if;',
'*/',
'NULL;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981771002111339711)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Process'
,p_attribute_02=>'PE_REQ_HORA_EXTRA'
,p_attribute_03=>'P716_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I:U:D'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>unistr('Requisi\00E7\00E3o Criada Com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981770634737339710)
,p_process_sequence=>40
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
'PKG_REQ_HE.Post_Insert(:P716_cod_empresa          ,',
'                         :P716_cod_req      ,',
'                         V_flg_retorno             ,',
'                         V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    :p716_ok       := ''N'';',
'    :p716_flag     := v_flg_retorno;',
'    :p716_mensagem := v_msg_retorno;',
' else',
'    :p716_flag     := null;',
'    :p716_mensagem := null;',
'    :p716_ok       := ''S'';',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(188981752582976339693)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981769389457339709)
,p_process_sequence=>50
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
'PKG_REQ_HE.Post_Update(:P716_cod_empresa          ,',
'                       :P716_cod_req      ,',
'                      V_flg_retorno             ,',
'                      V_msg_retorno             );',
' ',
' if v_msg_retorno is not null then',
'    :p716_ok       := ''N'';',
'    :p716_flag     := v_flg_retorno;',
'    :p716_mensagem := v_msg_retorno;',
' else',
'    :p716_flag     := null;',
'    :p716_mensagem := null;',
'    :p716_ok       := ''S'';',
' end if;',
' ',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(188981752189784339693)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981769017243339709)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Processo executado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981770177323339710)
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
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
':P716_OK := ''S'';',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981769845174339710)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c2 is',
'SELECT HORARIO, POSICAO',
'  FROM PE_JORNADAS_COMPOSICAO',
' WHERE COD_JORNADA = Fnct_Pe_Retorna_Jornada( nvl(:p716_emp,:p716_cod_empresa),nvl(:p716_mat,:p716_matricula),  NULL/*:P716_DATA*/ )',
'   --AND POSICAO = :p716_posicao',
' order by 2;',
' ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'BEGIN',
'PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'END;',
'',
'    open  c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'',
'  --  :p716_jornada           := v_c2.horario;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(188981771395950339711)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'PE_REQ_HORA_EXTRA'
,p_attribute_03=>'P716_COD_REQ'
,p_attribute_04=>'COD_REQ'
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
