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
,p_default_id_offset=>795299883281732340
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2937 - Medicina Ocupacional - Atendimento
--
-- Application Export:
--   Application:     2937
--   Name:            Medicina Ocupacional - Atendimento
--   Date and Time:   03:21 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 74
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00074
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>74);
end;
/
prompt --application/pages/page_00074
begin
wwv_flow_api.create_page(
 p_id=>74
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Registro do Pr\00E9-Atendimento')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Registro do Pr\00E9-Atendimento')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_PreAtendimento.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_PreAtendimento.css'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_protection_level=>'C'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_PreAtendimento.css / Natcorp_PreAtendimento.js)',
'',
'A triagem da enfermagem como ficha, com os mesmos campos na mesma ordem: no alto o paciente (cartao de leitura no',
'registro feito, com a alergia em destaque; no novo, os 6 campos em duas linhas, Funcionario/Candidato em botoes);',
'sinais vitais em cartoes com a unidade no campo (pressao "120 / 80 mmHg", IMC calculado na hora com a classificacao,',
'aviso discreto fora da referencia); anotacoes com a orientacao a vista e "Nega alergias"; rodape com os botoes',
'originais e o que falta. Enter avanca, Ctrl+S salva, "170" vira "1,70", "12080" vira 120/80.',
'Os campos sao so MUDADOS de lugar: processos, validacao e acoes dinamicas continuam. Para desligar: tire as duas',
'URLs de arquivo. Guia: brand/apex/app/PREATENDIMENTO-MANUTENCAO.md.'))
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260126180641'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(161359906792003624117)
,p_plug_name=>unistr('Registro do Pr\00E9-Atendimento')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834497856886858)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PRE_ATENDIMENTO'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(130109200726267819547)
,p_plug_name=>unistr('SOMENTE EXIBI\00C7\00C3O')
,p_parent_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(130109200831039819548)
,p_plug_name=>'CAMPOS EDITAVEIS'
,p_parent_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(161320258058966356198)
,p_plug_name=>unistr('Avalia\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_menu_id=>wwv_flow_api.id(167714865964028895971)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(177921863862945886917)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(161359921750434624134)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921834581028886859)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(161359922189834624135)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(161359921750434624134)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(130053174033390576288)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(161359921750434624134)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P74_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(161359924533613624138)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(161359921750434624134)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P74_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130053174253795576290)
,p_name=>'P74_DATA_AGENDA_TXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_source=>'P74_DATA_AGENDA'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109200641812819546)
,p_name=>'P74_COD_TIPO_ATENDIMENTO_TXT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo do Atendimento'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD_TIPO_ATENDIMENTO||'' - ''||DESCRICAO DESCRICAO FROM TIPO_ATENDIMENTO',
'WHERE NVL(IND_PRE_ATENDIMENTO,''N'') = ''S'' AND COD_TIPO_ATENDIMENTO = :P74_COD_TIPO_ATENDIMENTO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109200941113819549)
,p_name=>'P74_COD_PREST_SERV_TXT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_prompt=>'Atendente'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT PS.COD_PREST_SERV || ''-'' || PS.NOME AS DESCRICAO',
'FROM PRESTADOR_SERVICO PS',
'WHERE PS.COD_PREST_SERV = :P74_COD_PREST_SERV;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109201048338819550)
,p_name=>'P74_DT_HORARIO_REALIZADO_TXT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Pr\00E9-Atendimento Realizado \00E0s')
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'P74_DT_HORARIO_REALIZADO'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109201139822819551)
,p_name=>'P74_COD_EMPRESA_TXT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'select cod||'' - ''||nome descricao from empresas where cod = :P74_COD_EMPRESA'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109201233932819552)
,p_name=>'P74_TIPO_PACIENTE_TXT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Paciente'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select descricao ',
'  from',
unistr('    (SELECT 1 AS codigo, ''Funcion\00E1rio'' AS descricao FROM DUAL'),
'    UNION ALL',
'    SELECT 2, ''Candidato'' FROM DUAL) ',
'where codigo = :P74_TIPO_PACIENTE;'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(130109201410714819553)
,p_name=>'P74_COD_PACIENTE_TXT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(130109200726267819547)
,p_prompt=>'Paciente'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT IP.MATRICULA||'' - ''||IP.NOME NOME_PACIENTE',
'FROM INF_PESSOAIS_CAD IP',
'WHERE IP.MATRICULA = :P74_COD_PACIENTE',
'AND   IP.COD_EMPRESA = :P74_COD_EMPRESA',
'AND   :P74_TIPO_PACIENTE = 1',
'UNION',
'SELECT IPC.COD_CANDIDATO||'' - ''||IPC.NOME NOME_PACIENTE',
'FROM   INF_PESSOAIS_CANDIDATO IPC',
'WHERE  IPC.COD_CANDIDATO = :P74_COD_PACIENTE',
'AND   :P74_TIPO_PACIENTE = 2'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(131326416798645075121)
,p_name=>'P74_IMC'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_prompt=>'IMC'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359907146811624117)
,p_name=>'P74_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359907508411624120)
,p_name=>'P74_DATA_AGENDA'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_default=>'trunc(sysdate)'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Data '
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DATA_AGENDA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>12
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359907985550624120)
,p_name=>'P74_COD_EMPRESA'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359908381129624121)
,p_name=>'P74_TIPO_PACIENTE'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Tipo de Paciente'
,p_source=>'TIPO_PACIENTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC2:Funcion\00E1rio;1,Candidato;2')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359908711205624121)
,p_name=>'P74_COD_PACIENTE'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Paciente'
,p_source=>'COD_PACIENTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT IP.MATRICULA||''-''||IP.NOME NOME_PACIENTE, IP.MATRICULA',
'FROM   MT_CHAMADA_PACIENTE CP',
'      ,INF_PESSOAIS_CAD IP',
'WHERE  ((NOT EXISTS (SELECT 1 FROM PRE_ATENDIMENTO PA WHERE PA.COD_PACIENTE = CP.MATRICULA AND PA.COD_EMPRESA = CP.COD_EMPRESA AND PA.DATA_AGENDA = CP.DATA AND PA.COD_TIPO_ATENDIMENTO = :P74_COD_TIPO_ATENDIMENTO))',
'OR      (:P74_ROWID IS NOT NULL)) AND',
'IP.MATRICULA = CP.MATRICULA',
'AND    IP.COD_EMPRESA = CP.COD_EMPRESA',
'AND    CP.MATRICULA IS NOT NULL',
'AND    :P74_TIPO_PACIENTE = 1',
'AND    CP.COD_EMPRESA = :P74_COD_EMPRESA',
'AND    CP.DATA = :P74_DATA_AGENDA -- TRUNC(SYSDATE)',
'UNION',
'SELECT IPC.COD_CANDIDATO||''-''||IPC.NOME NOME_PACIENTE, IPC.COD_CANDIDATO',
'FROM   MT_CHAMADA_PACIENTE CP',
'      ,INF_PESSOAIS_CANDIDATO_CAD IPC',
'WHERE   ((NOT EXISTS (SELECT 1 FROM PRE_ATENDIMENTO PA WHERE PA.COD_PACIENTE = IPC.COD_CANDIDATO AND PA.DATA_AGENDA = CP.DATA AND PA.COD_TIPO_ATENDIMENTO = :P74_COD_TIPO_ATENDIMENTO))',
' OR      (:P74_ROWID IS NOT NULL)) AND    ',
'IPC.COD_CANDIDATO = CP.COD_CANDIDATO',
'AND    CP.COD_CANDIDATO IS NOT NULL',
'AND    :P74_TIPO_PACIENTE = 2',
'AND    CP.COD_EMPRESA = :P74_COD_EMPRESA',
'AND    CP.DATA = :P74_DATA_AGENDA -- TRUNC(SYSDATE)',
'ORDER  BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P74_COD_EMPRESA,P74_TIPO_PACIENTE_TXT,P74_COD_TIPO_ATENDIMENTO'
,p_ajax_items_to_submit=>'P74_ROWID,P74_DATA_AGENDA,P74_COD_EMPRESA,P74_TIPO_PACIENTE_TXT,P74_TIPO_PACIENTE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359909185644624121)
,p_name=>'P74_TIPO_PREST_SERV'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_default=>'1'
,p_source=>'TIPO_PREST_SERV'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_item_comment=>unistr('O tipo prestador sempre ser\00E1 1 (prestador da \00E1rea de medicina)')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359909581292624122)
,p_name=>'P74_COD_PREST_SERV'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Atendente'
,p_source=>'COD_PREST_SERV'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT PS.COD_PREST_SERV||''-''||PS.NOME, PS.COD_PREST_SERV CODIGO',
'FROM   USUARIO_ORACLE UO, PRESTADOR_SERVICO PS',
'WHERE  PS.TIPO_PREST_SERV = 1',
'AND    PS.MAT_PRESTADOR = UO.CD_MATRICULA',
'AND    PS.COD_EMPRESA_ENDERECO = UO.CD_EMPRESA',
'AND    UO.NM_USUARIO_ORACLE = :APP_USER',
'ORDER  BY 1'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_cMaxlength=>5
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>unistr('O prestador neste caso \00E9 o enfermeiro(a) que ir\00E1 realizar o pr\00E9-atendimento (triagem)')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359909977810624122)
,p_name=>'P74_COD_TIPO_ATENDIMENTO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Tipo do Atendimento'
,p_source=>'COD_TIPO_ATENDIMENTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'SELECT DESCRICAO, COD_TIPO_ATENDIMENTO CODIGO FROM TIPO_ATENDIMENTO WHERE NVL(IND_PRE_ATENDIMENTO,''N'') = ''S'' ORDER BY 1'
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863185780886910)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359910327990624123)
,p_name=>'P74_PA_SISTOLICA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Press\00E3o Arterial Sist\00F3lica (m\00E1xima)')
,p_format_mask=>'990D00'
,p_source=>'PA_SISTOLICA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359910746235624123)
,p_name=>'P74_PA_DIASTOLICA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Press\00E3o Arterial Diast\00F3lica (m\00EDnima)')
,p_format_mask=>'990D00'
,p_source=>'PA_DIASTOLICA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359911193172624123)
,p_name=>'P74_SATURACAO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Satura\00E7\00E3o')
,p_post_element_text=>'% SpO2'
,p_format_mask=>'990D00'
,p_source=>'SATURACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359911583057624124)
,p_name=>'P74_FREQUENCIA_CARDIACA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Frequ\00EAncia Card\00EDaca')
,p_post_element_text=>'bpm'
,p_format_mask=>'990'
,p_source=>'FREQUENCIA_CARDIACA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>3
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359911923518624124)
,p_name=>'P74_TEMPERATURA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Temperatura'
,p_post_element_text=>' C (Celsius)'
,p_format_mask=>'990D00'
,p_source=>'TEMPERATURA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359912307243624124)
,p_name=>'P74_ALTURA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Altura'
,p_post_element_text=>'Exemplo: 1,70'
,p_format_mask=>'990D00'
,p_source=>'ALTURA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359912793415624125)
,p_name=>'P74_PESO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Peso'
,p_post_element_text=>' Kg (Kilogramas)'
,p_format_mask=>'990D00'
,p_source=>'PESO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>5
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_grid_column=>5
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359913150910624125)
,p_name=>'P74_ALERGIAS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Alergia \00E0')
,p_source=>'ALERGIAS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>600
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Informar se o colaborador/candidato possui rea\00E7\00E3o al\00E9rgica \00E0 algum componente/medicamento')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359913547198624125)
,p_name=>'P74_OBSERVACOES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Atendimento Enfermagem'
,p_source=>'OBSERVACOES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>unistr('Informar se o colaborador/paciente j\00E1 realizou algum tipo de cirurgia, se sofre de doen\00E7as cr\00F4nicas ou se h\00E1 alguma doen\00E7a heredit\00E1ria na fam\00EDlia, etc')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359913851590624126)
,p_name=>'P74_RELATO_PACIENTE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(161320258058966356198)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>'Relato do Paciente'
,p_source=>'RELATO_PACIENTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>60
,p_cMaxlength=>4000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_help_text=>'Informar os sintomas sentidos pelo colaborador/candidato'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359914212573624126)
,p_name=>'P74_DT_HORARIO_REALIZADO'
,p_source_data_type=>'DATE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(130109200831039819548)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_prompt=>unistr('Pr\00E9-Atendimento Realizado \00E0s')
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_HORARIO_REALIZADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359914646676624126)
,p_name=>'P74_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(161359915061206624127)
,p_name=>'P74_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_item_source_plug_id=>wwv_flow_api.id(161359906792003624117)
,p_format_mask=>'DD/MM/YYYY HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(161320259082274356208)
,p_validation_name=>unistr('Valida Data Pr\00E9-Atendimento')
,p_validation_sequence=>10
,p_validation=>'P74_DATA_AGENDA'
,p_validation2=>'TRUNC(SYSDATE)'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>unistr('N\00E3o \00E9 permitido informada uma data diferente da atual')
,p_always_execute=>'Y'
,p_validation_condition=>'P74_DATA_AGENDA'
,p_validation_condition_type=>'ITEM_IS_NOT_NULL'
,p_associated_item=>wwv_flow_api.id(161359907508411624120)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(161359922259780624135)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(161359922189834624135)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(161359923086608624136)
,p_event_id=>wwv_flow_api.id(161359922259780624135)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(131326416890274075122)
,p_name=>'Atualiza IMC'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P74_PESO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(131326417007760075123)
,p_event_id=>wwv_flow_api.id(131326416890274075122)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P74_IMC := round(:P74_PESO/(:P74_ALTURA*:P74_ALTURA),1);'
,p_attribute_02=>'P74_PESO,P74_ALTURA'
,p_attribute_03=>'P74_IMC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(131326417103529075124)
,p_name=>'Atualiza IMC_1'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(131326417179615075125)
,p_event_id=>wwv_flow_api.id(131326417103529075124)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P74_IMC := round(:P74_PESO/(:P74_ALTURA*:P74_ALTURA),1);'
,p_attribute_02=>'P74_PESO,P74_ALTURA'
,p_attribute_03=>'P74_IMC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(130053174362728576291)
,p_name=>'HIDE'
,p_event_sequence=>40
,p_condition_element=>'P74_ROWID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130109200256170819542)
,p_event_id=>wwv_flow_api.id(130053174362728576291)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(130109200831039819548)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130109200390222819543)
,p_event_id=>wwv_flow_api.id(130053174362728576291)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(130109200831039819548)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130109200517239819544)
,p_event_id=>wwv_flow_api.id(130053174362728576291)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(130109200726267819547)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(130109200573760819545)
,p_event_id=>wwv_flow_api.id(130053174362728576291)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(130109200726267819547)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(125785679278132656941)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Inserir status do Pr\00E9-Atendimento')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
unistr('    -- Cursor para buscar o \00FAltimo registro'),
'    CURSOR c_ultimo IS',
'        SELECT SEQ, SENHA  ',
'        FROM MT_CHAMADA_PACIENTE ',
'        WHERE COD_EMPRESA = :P74_COD_EMPRESA',
'          AND (',
unistr('              (MATRICULA = :P74_COD_PACIENTE) -- Busca pela matr\00EDcula'),
unistr('              OR (MATRICULA IS NULL AND COD_CANDIDATO = :P74_COD_PACIENTE) -- Se matr\00EDcula for NULL, busca pelo COD_CANDIDATO'),
'          )',
'          AND DATA = TRUNC(SYSDATE)',
'        ORDER BY SEQ DESC',
'        FETCH FIRST 1 ROW ONLY; ',
'',
'       /* SELECT SEQ, SENHA ',
'        FROM MT_CHAMADA_PACIENTE ',
'        WHERE COD_EMPRESA = :P74_COD_EMPRESA',
'          AND MATRICULA = :P74_COD_PACIENTE',
'          AND DATA = TRUNC(SYSDATE)',
'        ORDER BY SEQ DESC',
'        FETCH FIRST 1 ROW ONLY;*/',
'',
unistr('    -- Vari\00E1vel do tipo %ROWTYPE baseada no cursor'),
'    v_ultimo c_ultimo%ROWTYPE;',
'',
'BEGIN',
unistr('    -- Inicializa a vari\00E1vel'),
'    v_ultimo.SEQ := NULL;',
'    v_ultimo.SENHA := NULL;',
'',
'',
unistr('    -- Busca o \00FAltimo registro'),
'    OPEN c_ultimo;',
'    FETCH c_ultimo INTO v_ultimo;',
'    CLOSE c_ultimo;',
'',
unistr('    -- Se n\00E3o encontrou senha, aborta a inser\00E7\00E3o'),
'    IF v_ultimo.SENHA IS NULL THEN',
unistr('        RAISE_APPLICATION_ERROR(-20001, ''Nenhuma senha encontrada para este paciente hoje. Inser\00E7\00E3o cancelada.'');'),
'    END IF;',
'',
'    -- Insere o novo registro',
'    INSERT INTO MT_CHAMADA_PACIENTE_STATUS (',
'        COD_EMPRESA,',
'        MATRICULA,',
'        COD_CANDIDATO,',
'        DATA,',
'        SEQ,',
'        SENHA,',
'        STATUS,',
'        LOCAL,',
'        DATA_STATUS,',
'        OBSERVACAO,',
'        USUARIO,',
'        DT_ATUALIZACAO,',
'        FLAG',
'    ) VALUES (',
'        :P74_COD_EMPRESA,',
'        :P74_COD_PACIENTE,',
'        :P74_COD_PACIENTE,--CASE WHEN :P74_TIPO_PACIENTE = 2 THEN :P74_COD_PACIENTE ELSE NULL END,',
'        TRUNC(SYSDATE), ',
'        v_ultimo.SEQ,  ',
'        v_ultimo.SENHA, ',
'        ''P'', ',
'        ''SALA DE ESPERA'',  ',
'        SYSDATE,  ',
'        null,',
'        :APP_USER,  ',
'        SYSDATE,',
'        0',
'    );',
'',
'',
'END;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(161359924533613624138)
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(161320258690407356204)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Registra Data/Horario Atendimento'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P74_USUARIO := :APP_USER; ',
':P74_DT_ATUALIZACAO := TO_CHAR(SYSDATE,''DD/MM/RRRR HH24:MI:SS'');',
':P74_DT_HORARIO_REALIZADO := TO_CHAR(SYSDATE,''DD/MM/RRRR HH24:MI:SS'');'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(161359925342733624138)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(161359906792003624117)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>unistr('Process form Registro do Pr\00E9-Atendimento')
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(161359925702217624139)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(161359924933002624138)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(161359906792003624117)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>unistr('Initialize form Registro do Pr\00E9-Atendimento')
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
