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
--   Date and Time:   03:50 Tuesday September 29, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 144
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00144
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>144);
end;
/
prompt --application/pages/page_00144
begin
wwv_flow_api.create_page(
 p_id=>144
,p_user_interface_id=>wwv_flow_api.id(88927852534180042432)
,p_name=>unistr('Avalia\00E7\00E3o')
,p_page_mode=>'MODAL'
,p_step_title=>unistr('Avalia\00E7\00E3o')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.util.getTopApex().jQuery(".ui-dialog-titlebar-close").hide();',
'apex.util.getTopApex().jQuery(".ui-dialog").dialog("option", "closeOnEscape", false);',
'$(".ui-dialog").dialog("option", "closeOnEscape", false);',
'',
'$(document).on("apexafterclosedialog", function(event, data) {',
'    apex.server.process("VALIDAR_FECHAMENTO", {',
'        pageItems: "#P144_COD_EMPRESA,#P144_MATRICULA,#P144_COD_EMP_AVALIADOR,#P144_COD_MAT_AVALIADOR,#P144_COD_AVALIACAO,#P144_DATA_AVALIACAO,#P144_COD_ITEM_AVALIACAO,#P144_IND_ACOES_DIVERSAS"',
'    }, {',
'        dataType: "json",',
'        success: function(pData) {',
'            if (pData.status_valido === "S") {',
'                $("#BTN_NEXT_RECORD").show();',
'                $("#BTN_NEXT_ALERTA").hide();',
'                $("#BTN_PREV_RECORD").show();',
'                $("#BTN_PREV_ALERTA").hide();',
'            } else {',
'                $("#BTN_NEXT_RECORD").hide();',
'                $("#BTN_NEXT_ALERTA").show();',
'                $("#BTN_PREV_RECORD").hide();',
'                $("#BTN_PREV_ALERTA").show();',
'                // Se quiser exibir a mensagem de erro retornada:',
'                apex.message.showPageSuccess(pData.mensagem);',
'            }',
'        },',
'        error: function(e) {',
'            console.error("Erro na chamada AJAX:", e);',
'        }',
'    });',
'});',
''))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_attributes=>'closeOnEscape: false, modal: true'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CIBELE.CRISTINA'
,p_last_upd_yyyymmddhh24miss=>'20260630125413'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(74343649557179418453)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(88927818543020042325)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990941960250486707)
,p_plug_name=>'Respostas'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(86990945992092486722)
,p_plug_name=>'&P144_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(88927826537342042338)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21038820159651221571)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847328940042382)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320930296188027516)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_button_name=>'P144_ACAO'
,p_button_static_id=>'P144_ACAO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(88927847502660042382)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('A\00E7\00F5es')
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:141:&SESSION.::&DEBUG.:RP,141:P141_COD_CICLO,P141_TIPO_AVALIACAO,P141_COD_AVALIACAO,P141_DATA_AVALIACAO,P141_COD_EMP_AVALIADOR,P141_COD_MAT_AVALIADOR,P141_COD_EMP_AVALIADO,P141_COD_MAT_AVALIADO,P141_COD_ITEM_AVALIACAO,P141_COD_SUB_ITEM_AVALIACAO:&P144_COD_CICLO.,&P144_TIPO_AVALIACAO.,&P144_COD_AVALIACAO.,&P144_DATA_AVALIACAO.,&P144_COD_EMP_AVALIADOR.,&P144_COD_MAT_AVALIADOR.,&P144_COD_EMPRESA.,&P144_MATRICULA.,&P144_COD_ITEM_AVALIACAO.,&P144_RADIO_GROUP.'
,p_icon_css_classes=>'fa-check-square-o'
,p_button_comment=>unistr('ch38449 n\00E3o estava passando o sub item para a pr\00F3xima tela para retornar as a\00E7\00F5es')
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320929189006027515)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'P144_NEXT'
,p_button_static_id=>'BTN_NEXT_RECORD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P144 next'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:144:&SESSION.::&DEBUG.:RP,144:P144_COD_AVALIACAO,P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_ROWID,P144_COD_CICLO,P144_COD_CICLO_AUX,P144_IND_ACEITE,P144_REAVALIACAO:&P144_COD_AVALIACAO.,&P144_COD_EMPRESA.,&P144_MATRICULA.,&P144_COD_EMP_AVALIADOR.,&P144_COD_MAT_AVALIADOR.,&P144_DATA_AVALIACAO.,&P144_TIPO_AVALIACAO.,&P144_ROWID_NEXT.,&P144_COD_CICLO.,&P144_COD_CICLO_AUX.,&P144_IND_ACEITE.,&P144_REAVALIACAO.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF TO_NUMBER(:P144_ORDEM_ITEM) <> TO_NUMBER(:P144_ORDEM_COUNT) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21056785325729631070)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'P144_NEXT_ALERTA'
,p_button_static_id=>'BTN_NEXT_ALERTA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P144 next'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF TO_NUMBER(:P144_ORDEM_ITEM) <> TO_NUMBER(:P144_ORDEM_COUNT) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-chevron-right'
,p_button_comment=>unistr('Esse bot\00E3o ir\00E1 ficar ativo no lugar do P144_NEXT sempre que P144_IND_ACOES_DIVERSAS = ''S'' e n\00E3o tiver a\00E7\00E3o definida, porque ao clicar nesse bot\00E3o, ser\00E1 exibido alerta e impedir\00E1 o usu\00E1rio de navegar para o pr\00F3ximo registro')
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(58807759870818464678)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'P144_FINISH'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_image_alt=>'P144 finish'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF TO_NUMBER(:P144_ORDEM_ITEM) = TO_NUMBER(:P144_ORDEM_COUNT) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(63320929626235027516)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'P144_PREV'
,p_button_static_id=>'BTN_PREV_RECORD'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P144 prev'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'f?p=&APP_ID.:144:&SESSION.::&DEBUG.:RP,144:P144_COD_AVALIACAO,P144_ROWID,P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_COD_CICLO,P144_COD_CICLO_AUX,P144_IND_ACEITE,P144_REAVALIACAO:&P144_COD_AVALIACAO.,&P144_ROWID_PREV.,&P144_COD_EMPRESA.,&P144_MATRICULA.,&P144_COD_EMP_AVALIADOR.,&P144_COD_MAT_AVALIADOR.,&P144_DATA_AVALIACAO.,&P144_TIPO_AVALIACAO.,&P144_COD_CICLO.,&P144_COD_CICLO_AUX.,&P144_IND_ACEITE.,&P144_REAVALIACAO.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF TO_NUMBER(:P144_ORDEM_ITEM) > TO_NUMBER(:P144_ORDEM_PREV) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(21056785680108631073)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(74343649557179418453)
,p_button_name=>'P144_PREV_ALERTA'
,p_button_static_id=>'BTN_PREV_ALERTA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(88927847212869042379)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P144 previiii'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF TO_NUMBER(:P144_ORDEM_ITEM) > TO_NUMBER(:P144_ORDEM_PREV) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-chevron-left'
,p_button_comment=>unistr('Esse bot\00E3o ir\00E1 ficar ativo no lugar do P144_PREV sempre que P144_IND_ACOES_DIVERSAS = ''S'' e n\00E3o tiver a\00E7\00E3o definida, porque ao clicar nesse bot\00E3o, ser\00E1 exibido alerta e impedir\00E1 o usu\00E1rio de navegar para o registro anterior')
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(63320954804026027538)
,p_branch_name=>unistr('A\00E7\00F5es')
,p_branch_action=>'f?p=&APP_ID.:145:&SESSION.::&DEBUG.:RP,145:P145_COD_AVALIACAO,P145_COD_EMP_AVALIADO,P145_COD_EMP_AVALIADOR,P145_COD_ITEM_AVALIACAO,P145_COD_MAT_AVALIADO,P145_COD_MAT_AVALIADOR,P145_COD_SUB_ITEM_AVALIACAO,P145_DATA_AVALIACAO,P145_TIPO_AVALIACAO,P145_COD_CICLO:&P144_COD_AVALIACAO.,&P144_COD_EMPRESA.,&P144_COD_EMP_AVALIADOR.,&P144_COD_ITEM_AVALIACAO.,&P144_MATRICULA.,&P144_COD_MAT_AVALIADOR.,&P144_RADIO_GROUP.,&P144_DATA_AVALIACAO.,&P144_TIPO_AVALIACAO.,&P144_COD_CICLO.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
,p_branch_condition_type=>'NEVER'
,p_branch_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- ch 38449 Server Side Condition comentado:',
'Item=Value',
'P144_IND_ACOES_DIVERSAS=S'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(21038821708961221586)
,p_name=>'P144_ACAO_OK'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_item_default=>'P144_COD_ITEM_AVALIACAO'
,p_item_default_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>unistr('Esse campo verifica se precisa ou n\00E3o criar a\00E7\00E3o antes de fechar a tela')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(24631721854401749929)
,p_name=>'P144_LIBERA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(31961000275423859840)
,p_name=>'P144_IND_ACEITE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33276598472250261719)
,p_name=>'P144_COD_EMP_SUP'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33276598515530261720)
,p_name=>'P144_COD_MAT_SUP'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33276598808829261723)
,p_name=>'P144_MAT_PRIMEIRO_AVALIADOR'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33276598965418261724)
,p_name=>'P144_COD_PRIMEIRO_AVALIADOR'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(33393403390262806391)
,p_name=>'P144_COD_CICLO_AUX'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37810847683818334365)
,p_name=>'P144_DESC_GRUPO_COMP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_prompt=>unistr('Grupo de Compet\00EAncia')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_display_when=>'P144_DESC_GRUPO_COMP'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37810847717064334366)
,p_name=>'P144_COD_GRUPO_COMP'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_GRUPO_COMP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(39594396218975485853)
,p_name=>'P144_DESABILITA_QUESTOES_AUX'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(51906267404091269179)
,p_name=>'P144_IND_AUTOAVALIACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55506748107986125255)
,p_name=>'P144_COD_CICLO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320930695399027517)
,p_name=>'P144_COD_EMP_AVALIADOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320931040743027517)
,p_name=>'P144_COD_MAT_AVALIADOR'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320931487137027518)
,p_name=>'P144_DATA_AVALIACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320931884290027518)
,p_name=>'P144_CARACTERISTICA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320932285312027518)
,p_name=>'P144_RESPOSTA_MULTIPLA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_use_cache_before_default=>'NO'
,p_source=>'RESPOSTA_MULTIPLA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320932724802027519)
,p_name=>'P144_COD_SUB_ITEM_AVALIACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320933032954027519)
,p_name=>'P144_IND_ACOES_DIVERSAS'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320933454068027519)
,p_name=>'P144_RADIO_GROUP'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Resposta'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select Cod_Sub_Item_Avaliacao',
'  From Av_Aplica_Avaliacoes_Itens',
' Where Cod_Item_Avaliacao = :p144_cod_item_avaliacao',
'   and Cod_Emp_Avaliado = :p144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :p144_Matricula',
'   And Cod_Emp_Avaliador = :p144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :p144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :p144_Cod_Avaliacao',
'   And Data_Avaliacao = :p144_Data_Avaliacao',
'   And Tipo_Avaliacao = :p144_tipo_avaliacao',
'   -- And (:p144_cod_ciclo is null or cod_ciclo = :p144_cod_ciclo)',
'   And rownum = 1'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(s.texto) descricao,',
'       s.cod_sub_item_avaliacao',
'  from AV_SUB_ITENS_AVALIACAO s',
' where s.cod_empresa = :P144_COD_EMPRESA',
'   and s.cod_avaliacao = :P144_COD_AVALIACAO',
'   and s.cod_item_avaliacao = :P144_COD_ITEM_AVALIACAO',
' order by s.cod_sub_item_avaliacao DESC'))
,p_lov_cascade_parent_items=>'P144_COD_EMPRESA,P144_COD_AVALIACAO,P144_COD_ITEM_AVALIACAO'
,p_ajax_optimize_refresh=>'Y'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_LIBERA VARCHAR2(1);',
'',
'BEGIN',
'',
'SELECT FNC_LIBERA_RESPOSTAS(:P144_COD_EMPRESA, ',
'                                                :P144_COD_CICLO, --',
'                                                :P144_COD_AVALIACAO, --',
'                                                :APP_USER, ',
'                                                :P144_MATRICULA, ',
'                                                :P144_TIPO_AVALIACAO, ',
'                                                :P_EMPRESA_USER, ',
'                                                :P_MATRICULA_USER, ',
'                                                :P144_IND_ACEITE, ',
'                                                :P144_COD_EMP_AVALIADOR, ',
'                                                :P144_COD_MAT_AVALIADOR,',
'                                                :P144_COD_EMP_SUP,',
'                                                :P144_COD_MAT_SUP,',
'                                                :P144_DATA_AVALIACAO)',
'INTO V_LIBERA',
'FROM DUAL;',
'',
'IF V_LIBERA IS NOT NULL THEN',
':P144_LIBERA := V_LIBERA;',
'END IF;',
'',
'if :P144_TIPO_AVALIACAO = ''A'' AND  :P_PAINEL = ''PG'' THEN',
'RETURN TRUE;',
':P144_LIBERA :=''N'';',
'END IF;',
'',
'if :P144_TIPO_AVALIACAO <> ''A'' AND  :P_EMPRESA_USER = :P144_COD_EMPRESA /*:P144_COD_EMP_AVALIADO*/ AND :P_MATRICULA_USER = :P144_COD_MAT_AVALIADO THEN',
'RETURN TRUE;',
':P144_LIBERA :=''N'';',
'END IF;',
'',
'IF :P144_LIBERA =''S'' THEN ',
'RETURN FALSE;',
'ELSE RETURN TRUE;',
'END IF;',
'END;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320933859032027520)
,p_name=>'P144_CHECK_BOX'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_prompt=>'Resposta'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select Cod_Sub_Item_Avaliacao',
'  From Av_Aplica_Avaliacoes_Itens',
' Where Cod_Item_Avaliacao = :p144_cod_item_avaliacao',
'   and Cod_Emp_Avaliado = :p144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :p144_Matricula',
'   And Cod_Emp_Avaliador = :p144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :p144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :p144_Cod_Avaliacao',
'   And Data_Avaliacao = :p144_Data_Avaliacao',
'   And Tipo_Avaliacao = :p144_tipo_avaliacao',
'   And rownum = 1'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(s.texto) descricao,',
'       s.cod_sub_item_avaliacao',
'  from AV_SUB_ITENS_AVALIACAO s',
' where s.cod_empresa = :P144_COD_EMPRESA',
'   and s.cod_avaliacao = :P144_COD_AVALIACAO',
'   and s.cod_item_avaliacao = :P144_COD_ITEM_AVALIACAO',
' order by s.cod_sub_item_avaliacao DESC'))
,p_lov_cascade_parent_items=>'P144_COD_EMPRESA,P144_COD_AVALIACAO,P144_COD_ITEM_AVALIACAO'
,p_ajax_optimize_refresh=>'Y'
,p_begin_on_new_line=>'N'
,p_display_when_type=>'NEVER'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' ciclo',
'  FROM AV_AVALIACOES',
' WHERE trunc(SYSDATE) BETWEEN trunc(DT_INICIO) AND trunc(DT_FIM)',
'   AND COD_AVALIACAO = :P144_COD_AVALIACAO;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if nvl(v_c1.ciclo,''N'') = ''N'' then',
'return true;',
'else',
'',
'    if :p144_tipo_avaliacao = ''A'' and :P_EMPRESA_USER = :p144_cod_empresa and :P_MATRICULA_USER = :p144_matricula then',
'        return false;',
'    elsif :p144_tipo_avaliacao = ''G'' and :P_EMPRESA_USER = :p144_cod_emp_avaliador and :P_MATRICULA_USER = :p144_cod_mat_avaliador then',
'        return false;',
'    /* elsif:P144_tipo_avaliacao = ''G'' and :P_EMPRESA_USER = :P144_COD_EMP_SUP and :P_MATRICULA_USER = :P144_COD_MAT_SUP then  comentado DANIEL 29/04/2024',
'        return false;   */',
'    elsif :p144_tipo_avaliacao = ''C'' and ((:P_EMPRESA_USER = :p144_cod_empresa and :P_MATRICULA_USER = :p144_matricula) or ',
'                                          (:P_EMPRESA_USER = :p144_cod_emp_avaliador and :P_MATRICULA_USER = :p144_cod_mat_avaliador)) then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'end if;',
'',
'end;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320934319732027520)
,p_name=>'P144_NOTA_ITEM'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_prompt=>'Nota'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select Cod_Sub_Item_Avaliacao',
'  From Av_Aplica_Avaliacoes_Itens',
' Where Cod_Item_Avaliacao = :p144_cod_item_avaliacao',
'   and Cod_Emp_Avaliado = :p144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :p144_Matricula',
'   And Cod_Emp_Avaliador = :p144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :p144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :p144_Cod_Avaliacao',
'   And Data_Avaliacao = :p144_Data_Avaliacao',
'   And Tipo_Avaliacao = :p144_tipo_avaliacao',
'   and cod_sub_item_avaliacao is not null',
'   And rownum = 1'))
,p_display_when_type=>'EXISTS'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' ciclo',
'  FROM AV_AVALIACOES',
' WHERE trunc(SYSDATE) BETWEEN trunc(DT_INICIO) AND trunc(DT_FIM)',
'   AND COD_AVALIACAO = :P144_COD_AVALIACAO;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if nvl(v_c1.ciclo,''N'') = ''N'' then',
'return true;',
'else',
'',
'    if :p144_tipo_avaliacao = ''A'' and :P_EMPRESA_USER = :p144_cod_empresa and :P_MATRICULA_USER = :p144_matricula then',
'        return false;',
'    elsif :p144_tipo_avaliacao = ''G'' and :P_EMPRESA_USER = :p144_cod_emp_avaliador and :P_MATRICULA_USER = :p144_cod_mat_avaliador then',
'        return false;',
'    /* elsif:P144_tipo_avaliacao = ''G'' and :P_EMPRESA_USER = :P144_COD_EMP_SUP and :P_MATRICULA_USER = :P144_COD_MAT_SUP then comentado o caso da Valquiria',
'        return false;   */',
'    elsif :p144_tipo_avaliacao = ''C'' and ((:P_EMPRESA_USER = :p144_cod_empresa and :P_MATRICULA_USER = :p144_matricula) or ',
'                                          (:P_EMPRESA_USER = :p144_cod_emp_avaliador and :P_MATRICULA_USER = :p144_cod_mat_avaliador)) then',
'        return false;',
'    else',
'        return true;',
'    end if;',
'',
'end if;',
'',
'end;'))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320934723194027521)
,p_name=>'P144_RESPOSTA_DISSERTATIVA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(86990941960250486707)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Resposta Dissertativa'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select resposta_dissertativa',
'   From Av_Aplica_Avaliacoes_Itens v, av_sub_itens_avaliacao i',
'  Where v.cod_emp_avaliador = i.cod_empresa (+)',
'    and v.cod_avaliacao = i.cod_avaliacao (+)',
'    and v.cod_item_avaliacao = i.cod_item_avaliacao (+)',
'    and v.Cod_Sub_Item_Avaliacao = i.Cod_Sub_Item_Avaliacao (+)',
'    and v.Cod_Item_Avaliacao = :p144_cod_item_avaliacao',
'    and v.Cod_Emp_Avaliado   = :p144_Cod_Empresa',
'    And v.Cod_Mat_Avaliado   = :p144_Matricula',
'    And v.Cod_Emp_Avaliador  = :p144_Cod_Emp_Avaliador',
'    And v.Cod_Mat_Avaliador  = :p144_Cod_Mat_Avaliador',
'    And v.Cod_Avaliacao      = :p144_Cod_Avaliacao',
'    And v.Data_Avaliacao     = :p144_Data_Avaliacao',
'    And v.Tipo_Avaliacao     = :p144_tipo_avaliacao'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_LIBERA VARCHAR2(1);',
'',
'BEGIN',
'',
'SELECT FNC_LIBERA_RESPOSTAS(:P144_COD_EMPRESA, ',
'                                                :P144_COD_CICLO, --',
'                                                :P144_COD_AVALIACAO, --',
'                                                :APP_USER, ',
'                                                :P144_MATRICULA, ',
'                                                :P144_TIPO_AVALIACAO, ',
'                                                :P_EMPRESA_USER, ',
'                                                :P_MATRICULA_USER, ',
'                                                :P144_IND_ACEITE, ',
'                                                :P144_COD_EMP_AVALIADOR, ',
'                                                :P144_COD_MAT_AVALIADOR,',
'                                                :P144_COD_EMP_SUP,',
'                                                :P144_COD_MAT_SUP,',
'                                                :P144_DATA_AVALIACAO)',
'INTO V_LIBERA',
'FROM DUAL;',
'',
'IF V_LIBERA IS NOT NULL THEN',
':P144_LIBERA := V_LIBERA;',
'END IF;',
'',
'if :P144_TIPO_AVALIACAO = ''A'' AND  :P_PAINEL = ''PG'' THEN',
'RETURN TRUE;',
':P144_LIBERA :=''N'';',
'END IF;',
'',
'if :P144_TIPO_AVALIACAO <> ''A'' AND  :P_EMPRESA_USER = :P144_COD_EMPRESA /*:P144_COD_EMP_AVALIADO*/ AND :P_MATRICULA_USER = :P144_COD_MAT_AVALIADO THEN',
'RETURN TRUE;',
':P144_LIBERA :=''N'';',
'END IF;',
'',
'IF :P144_LIBERA =''S'' THEN ',
'RETURN FALSE;',
'ELSE RETURN TRUE;',
'END IF;',
'END;',
''))
,p_read_only_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320935408470027522)
,p_name=>'P144_DESC_COMP'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_prompt=>unistr('Compet\00EAncia')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_display_when=>'P144_DESC_COMP'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320935786883027522)
,p_name=>'P144_REAVALIACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320936220893027522)
,p_name=>'P144_ORDEM_PREV'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320936529816027523)
,p_name=>'P144_ORDEM_NEXT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320936957100027523)
,p_name=>'P144_ORDEM_COUNT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320937400971027523)
,p_name=>'P144_ROWID_PREV'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320937798614027524)
,p_name=>'P144_ROWID'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320938176634027524)
,p_name=>'P144_ROWID_NEXT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320938555316027524)
,p_name=>'P144_ORDEM_ITEM'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'ORDEM_ITEM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320938963343027525)
,p_name=>'P144_COD_EMPRESA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320939348666027525)
,p_name=>'P144_MATRICULA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320939761904027525)
,p_name=>'P144_COD_AVALIACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320940175176027526)
,p_name=>'P144_COD_ITEM_AVALIACAO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ITEM_AVALIACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320940628562027526)
,p_name=>'P144_COD_COMP'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_COMP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320941020199027526)
,p_name=>'P144_TIPO_AVALIACAO'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320941394275027526)
,p_name=>'P144_PESO'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_source=>'PESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320941781126027527)
,p_name=>'P144_TITULO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320942194064027527)
,p_name=>'P144_NOME_ITEM_AVALIACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_prompt=>unistr('Especifica\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320942562637027527)
,p_name=>'P144_DESCRICAO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descri\00E7\00E3o')
,p_source=>'ESPECIFICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>3
,p_display_when=>'P144_DESCRICAO'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(63320942986176027528)
,p_name=>'P144_OBSERVACAO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(86990945992092486722)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o / Pergunta')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>3
,p_display_when=>'P144_OBSERVACAO'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(88927846888336042375)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320945845448027531)
,p_name=>'Insere / Deleta Resposta RG'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_RADIO_GROUP'
,p_condition_element=>'P144_RADIO_GROUP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21038823850202221608)
,p_event_id=>wwv_flow_api.id(63320945845448027531)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'location.reload();'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320946393566027531)
,p_event_id=>wwv_flow_api.id(63320945845448027531)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select S.PESO, S.IND_ACOES_DIVERSAS',
'  from AV_SUB_ITENS_AVALIACAO s',
' where s.cod_empresa = :P144_COD_EMPRESA',
'   and s.cod_avaliacao = :P144_COD_AVALIACAO',
'   and s.cod_item_avaliacao = :P144_COD_ITEM_AVALIACAO',
'   and s.cod_sub_item_avaliacao = :P144_RADIO_GROUP;',
'   ',
'v_c1 c1%rowtype;',
'',
' Nota Av_Aplica_Avaliacoes_Itens.Nota_Item%Type;',
'',
'cursor c2 is',
'select cod_avaliacao, Cod_Sub_Item_Avaliacao',
'  from Av_Aplica_Avaliacoes_Itens',
' Where Cod_Emp_Avaliado = :P144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :P144_Matricula',
'   And Cod_Emp_Avaliador = :P144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :P144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :P144_Cod_Avaliacao',
'   And Data_Avaliacao = :P144_Data_Avaliacao',
'   AND Cod_item_avaliacao = :P144_Cod_Item_Avaliacao',
'   AND TIPO_AVALIACAO = :P144_TIPO_AVALIACAO',
'   AND (:P144_COD_CICLO IS NULL OR :P144_COD_CICLO = COD_CICLO)',
'   AND (:P144_COD_CICLO_AUX IS NULL OR :P144_COD_CICLO_AUX = COD_CICLO);',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  Nota := :P144_Peso * (V_C1.Peso / 100);',
'  ',
'  :p144_IND_ACOES_DIVERSAS := v_c1.IND_ACOES_DIVERSAS;',
'',
'  OPEN C2;',
'  FETCH C2 INTO V_C2;',
'  CLOSE C2;',
'',
'  if v_c2.cod_avaliacao is not null AND V_C2.Cod_Sub_Item_Avaliacao <> :P144_RADIO_GROUP then',
'',
'     begin',
'',
'         update Av_Aplica_Avaliacoes_Itens',
'            set Cod_Sub_Item_Avaliacao = :P144_RADIO_GROUP, nota_item = nota, usuario = :p_usuario, dt_atualizacao = sysdate',
'         Where Cod_Emp_Avaliado = :P144_Cod_Empresa',
'           And Cod_Mat_Avaliado = :P144_Matricula',
'           And Cod_Emp_Avaliador = :P144_Cod_Emp_Avaliador',
'           And Cod_Mat_Avaliador = :P144_Cod_Mat_Avaliador',
'           And Cod_Avaliacao = :P144_Cod_Avaliacao',
'           And Data_Avaliacao = :P144_Data_Avaliacao',
'           AND Cod_item_avaliacao = :P144_Cod_Item_Avaliacao',
'           AND TIPO_AVALIACAO = :P144_TIPO_AVALIACAO',
'           AND (:P144_COD_CICLO IS NULL OR :P144_COD_CICLO = COD_CICLO)',
'           AND (:P144_COD_CICLO_AUX IS NULL OR :P144_COD_CICLO_AUX = COD_CICLO);',
'',
'        commit;',
'',
'        exception',
'        when others then',
'        null;',
'',
'        end;',
'',
'   elsif v_c2.cod_avaliacao is null AND V_C2.Cod_Sub_Item_Avaliacao is null and :P144_RADIO_GROUP is not null and :p144_tipo_avaliacao is not null then',
'',
'   begin',
'',
'   Insert Into Av_Aplica_Avaliacoes_Itens',
'          (Cod_Emp_Avaliado,',
'           Cod_Mat_Avaliado,',
'           Cod_Emp_Avaliador,',
'           Cod_Mat_Avaliador,',
'           Cod_Avaliacao,',
'           Data_Avaliacao,',
'           Cod_Item_Avaliacao,',
'           Cod_Sub_Item_Avaliacao,',
'           Nota_Item,',
'           Tipo_avaliacao,',
'           COD_CICLO,',
'           usuario,',
'           dt_atualizacao)',
'        Values',
'          (:P144_Cod_Empresa,',
'           :P144_Matricula,',
'           :P144_Cod_Emp_Avaliador,',
'           :P144_Cod_Mat_Avaliador,',
'           :P144_Cod_Avaliacao,',
'           :P144_Data_Avaliacao,',
'           :P144_Cod_Item_Avaliacao,',
'           :P144_RADIO_GROUP,',
'           Nota,',
'           :P144_TIPO_AVALIACAO,',
'          NVL(:P144_COD_CICLO_AUX, :P144_COD_CICLO),',
'          :p_usuario,',
'          sysdate);',
'',
'  COMMIT;',
'EXCEPTION',
'WHEN OTHERS THEN',
'NULL;',
'  end;',
'',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_COD_ITEM_AVALIACAO,P144_RADIO_GROUP,P144_TIPO_AVALIACAO,P144_PESO,P144_COD_CICLO,P144_COD_CICLO_AUX'
,p_attribute_03=>'P144_IND_ACOES_DIVERSAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21038820105902221570)
,p_event_id=>wwv_flow_api.id(63320945845448027531)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(63320930296188027516)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P144_IND_ACOES_DIVERSAS'').value == ''S''){',
'$(''#P144_ACAO'').show();',
'}else{',
'$(''#P144_ACAO'').hide();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21038823812141221607)
,p_event_id=>wwv_flow_api.id(63320945845448027531)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320947782371027532)
,p_name=>'Insere / Deleta Resposta Texto'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_RESPOSTA_DISSERTATIVA'
,p_condition_element=>'P144_RESPOSTA_DISSERTATIVA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320948320730027533)
,p_event_id=>wwv_flow_api.id(63320947782371027532)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select S.PESO',
'  from AV_SUB_ITENS_AVALIACAO s',
' where s.cod_empresa = :P144_COD_EMPRESA',
'   and s.cod_avaliacao = :P144_COD_AVALIACAO',
'   and s.cod_item_avaliacao = :P144_COD_ITEM_AVALIACAO;',
'',
'v_c1 c1%rowtype;',
'',
' Nota Av_Aplica_Avaliacoes_Itens.Nota_Item%Type;',
'',
'cursor c2 is',
'select resposta_dissertativa, cod_avaliacao',
'  from Av_Aplica_Avaliacoes_Itens',
' Where Cod_Emp_Avaliado = :P144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :P144_Matricula',
'   And Cod_Emp_Avaliador = :P144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :P144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :P144_Cod_Avaliacao',
'   And Data_Avaliacao = :P144_Data_Avaliacao',
'   AND Cod_item_avaliacao = :P144_Cod_Item_Avaliacao',
'   AND TIPO_AVALIACAO = :P144_TIPO_AVALIACAO',
'   AND (:P144_COD_CICLO IS NULL OR COD_CICLO = :P144_COD_CICLO)',
'   AND (:P144_COD_CICLO_AUX IS NULL OR COD_CICLO = :P144_COD_CICLO_AUX);',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  Nota := :P144_Peso * (V_C1.Peso / 100);',
'',
'  OPEN C2;',
'  FETCH C2 INTO V_C2;',
'  CLOSE C2;',
'',
'  if v_c2.cod_avaliacao is not null then',
'',
'     begin',
'',
'         update Av_Aplica_Avaliacoes_Itens',
'            set Resposta_Dissertativa = :P144_Resposta_Dissertativa, nota_item = nota, usuario = :p_usuario, dt_atualizacao = sysdate',
'         Where Cod_Emp_Avaliado = :P144_Cod_Empresa',
'           And Cod_Mat_Avaliado = :P144_Matricula',
'           And Cod_Emp_Avaliador = :P144_Cod_Emp_Avaliador',
'           And Cod_Mat_Avaliador = :P144_Cod_Mat_Avaliador',
'           And Cod_Avaliacao = :P144_Cod_Avaliacao',
'           And Data_Avaliacao = :P144_Data_Avaliacao',
'           AND Cod_item_avaliacao = :P144_Cod_Item_Avaliacao',
'           AND TIPO_AVALIACAO = :P144_TIPO_AVALIACAO',
'           AND (:P144_COD_CICLO IS NULL OR COD_CICLO = :P144_COD_CICLO)',
'           AND (:P144_COD_CICLO_AUX IS NULL OR COD_CICLO = :P144_COD_CICLO_AUX);',
'',
'        commit;',
'',
'        exception',
'        when others then',
'        null;',
'',
'        end;',
'',
'   else',
'   if :P144_TIPO_AVALIACAO is not null then',
'   begin',
'',
'   Insert Into Av_Aplica_Avaliacoes_Itens',
'          (Cod_Emp_Avaliado,',
'           Cod_Mat_Avaliado,',
'           Cod_Emp_Avaliador,',
'           Cod_Mat_Avaliador,',
'           Cod_Avaliacao,',
'           Data_Avaliacao,',
'           Cod_Item_Avaliacao,',
'           Resposta_Dissertativa,',
'           Nota_Item,',
'           Tipo_avaliacao,',
'          cod_ciclo,',
'          usuario,',
'          dt_atualizacao)',
'        Values',
'          (:P144_Cod_Empresa,',
'           :P144_Matricula,',
'           :P144_Cod_Emp_Avaliador,',
'           :P144_Cod_Mat_Avaliador,',
'           :P144_Cod_Avaliacao,',
'           :P144_Data_Avaliacao,',
'           :P144_Cod_Item_Avaliacao,',
'           :P144_Resposta_Dissertativa,',
'           Nota,',
'           :P144_TIPO_AVALIACAO,',
'           NVL(:p144_cod_ciclo_aux,:p144_cod_ciclo),',
'          :p_usuario,',
'          sysdate);',
'',
'  COMMIT;',
'EXCEPTION',
'WHEN OTHERS THEN',
'NULL;',
'  end;',
'  end if;',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_COD_ITEM_AVALIACAO,P144_RESPOSTA_DISSERTATIVA,P144_TIPO_AVALIACAO,P144_PESO,P144_COD_CICLO,P144_COD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320948802234027534)
,p_event_id=>wwv_flow_api.id(63320947782371027532)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' ',
'cursor c1 is',
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = :p144_cod_empresa',
'   and cod_mat_avaliado = :p144_matricula',
'   and cod_avaliacao = :p144_cod_avaliacao',
'   and data_avaliacao = :p144_data_avaliacao',
'   AND (:P144_COD_CICLO IS NULL OR COD_CICLO = :P144_COD_CICLO)',
'   AND (:P144_COD_CICLO_AUX IS NULL OR COD_CICLO = :P144_COD_CICLO_AUX);',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'null;',
'/*',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.cod_mat_avaliado is null then',
'',
'        begin',
'',
'        insert into AV_APLICA_AVALIACOES',
'        (',
'        cod_emp_avaliado,',
'        cod_mat_avaliado,',
'        cod_emp_avaliador,',
'        cod_mat_avaliador,',
'        cod_avaliacao,',
'        data_avaliacao,',
'        tipo_avaliacao,',
'        cod_ciclo',
'        )',
'        values ',
'        (',
'        :p144_cod_empresa,',
'        :p144_matricula,',
'        :p144_cod_emp_avaliador,',
'        :p144_cod_mat_avaliador,',
'        :p144_cod_avaliacao,',
'        :p144_data_avaliacao,',
'        :p144_tipo_avaliacao,',
'        :P144_COD_CICLO',
'        );',
'',
'        commit;',
'',
'        end;',
'',
'    end if;',
'*/',
'end;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_COD_CICLO,P144_COD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320949161393027534)
,p_name=>'Esconder Campos'
,p_event_sequence=>80
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320949677957027534)
,p_event_id=>wwv_flow_api.id(63320949161393027534)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select S.IND_ACOES_DIVERSAS',
'  from AV_SUB_ITENS_AVALIACAO s',
' where s.cod_empresa = :P144_COD_EMPRESA',
'   and s.cod_avaliacao = :P144_COD_AVALIACAO',
'   and s.cod_item_avaliacao = :P144_COD_ITEM_AVALIACAO',
'   and s.cod_sub_item_avaliacao = :P144_RADIO_GROUP;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'  ',
'  :p144_IND_ACOES_DIVERSAS := v_c1.IND_ACOES_DIVERSAS;',
'',
'end;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_COD_AVALIACAO,P144_COD_ITEM_AVALIACAO,P144_RADIO_GROUP'
,p_attribute_03=>'P144_IND_ACOES_DIVERSAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33276599864898261733)
,p_event_id=>wwv_flow_api.id(63320949161393027534)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P144_CARACTERISTICA'').value != ''D''){',
'',
'    $(''#P144_RESPOSTA_DISSERTATIVA'').hide();',
'    $(''#P144_RESPOSTA_DISSERTATIVA_LABEL'').hide();',
'',
'    /*if ($x(''P144_RESPOSTA_MULTIPLA'').value == 0) {*/',
'         $(''#P144_RADIO_GROUP_CONTAINER'').show();',
'         $(''#P144_CHECK_BOX_CONTAINER'').hide();',
'   /* } else {',
'         $(''#P144_RADIO_GROUP_CONTAINER'').hide();',
'         $(''#P144_CHECK_BOX_CONTAINER'').show();',
'    }*/',
'}else{',
'    $(''#P144_RESPOSTA_DISSERTATIVA'').show();',
'    $(''#P144_RESPOSTA_DISSERTATIVA_LABEL'').show();',
'    $(''#P144_RADIO_GROUP_CONTAINER'').hide();',
'    $(''#P144_CHECK_BOX_CONTAINER'').hide();',
'}',
'',
'if ($x(''P144_IND_ACOES_DIVERSAS'').value == ''S''){',
'$(''#P144_ACAO'').show();',
'    ',
'    apex.server.process("VALIDAR_FECHAMENTO", {',
unistr('    pageItems: "#P144_COD_EMPRESA, #P144_MATRICULA, #P144_COD_EMP_AVALIADOR, #P144_COD_MAT_AVALIADOR, #P144_COD_AVALIACAO, #P144_DATA_AVALIACAO, #P144_COD_ITEM_AVALIACAO" // envie os dados da p\00E1gina se necess\00E1rio'),
'    ',
'    }, {',
'    success: function(pData) {',
'        if (pData.status_valido === ''N'') {',
'            $(''#BTN_NEXT_RECORD'').hide();',
'            $(''#BTN_NEXT_ALERTA'').show();',
'            $(''#BTN_PREV_RECORD'').hide();',
'            $(''#BTN_PREV_ALERTA'').show();',
'        } else {',
unistr('            // Esconde o bot\00E3o de "pr\00F3ximo registro"'),
'            $(''#BTN_NEXT_RECORD'').show();',
'            $(''#BTN_NEXT_ALERTA'').hide();',
'            $(''#BTN_PREV_RECORD'').show();',
'            $(''#BTN_PREV_ALERTA'').hide();',
'        }',
'    },',
'    error: function(request, status, error) {',
unistr('        apex.message.alert("Erro ao validar a\00E7\00F5es. Tente novamente.");'),
'    }',
'    });',
'    ',
'}else{',
'$(''#P144_ACAO'').hide();',
'$(''#BTN_NEXT_RECORD'').show();',
'$(''#BTN_NEXT_ALERTA'').hide();',
'$(''#BTN_PREV_RECORD'').show();',
'$(''#BTN_PREV_ALERTA'').hide();',
'}',
'',
'$x(''P144_NOTA_ITEM'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320950615796027535)
,p_name=>unistr('Informa A\00E7\00F5es')
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_IND_ACOES_DIVERSAS'
,p_condition_element=>'P144_IND_ACOES_DIVERSAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>'-- Comentado tratativa ch38449'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320951070305027535)
,p_event_id=>wwv_flow_api.id(63320950615796027535)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320951523684027535)
,p_name=>unistr('Reavalia\00E7\00E3o Campos')
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_REAVALIACAO'
,p_condition_element=>'P144_REAVALIACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320951988755027536)
,p_event_id=>wwv_flow_api.id(63320951523684027535)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P144_RADIO_GROUP,P144_CHECK_BOX,P144_RESPOSTA_DISSERTATIVA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320952490950027536)
,p_event_id=>wwv_flow_api.id(63320951523684027535)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P144_RADIO_GROUP,P144_CHECK_BOX,P144_RESPOSTA_DISSERTATIVA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(39598280548591264743)
,p_name=>unistr('Reavalia\00E7\00E3o Campos_1')
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_REAVALIACAO'
,p_condition_element=>'P144_DESABILITA_QUESTOES_AUX'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(39598280645591264744)
,p_event_id=>wwv_flow_api.id(39598280548591264743)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P144_RADIO_GROUP,P144_CHECK_BOX,P144_RESPOSTA_DISSERTATIVA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320952877365027536)
,p_name=>unistr('Reavalia\00E7\00E3o')
,p_event_sequence=>130
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320953369903027537)
,p_event_id=>wwv_flow_api.id(63320952877365027536)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  CURSOR C1 IS',
'    SELECT count(*) total',
'    FROM   AV_COMPOSICAO_AVALIACAO A',
'    WHERE  A.COD_EMPRESA        = :P144_COD_EMPRESA /*:P144_COD_EMP_AVALIADO*/',
'    AND    A.COD_AVALIACAO      = :P144_COD_AVALIACAO;',
'',
'    v_c1 c1%rowtype;',
'',
'    CURSOR C2 IS',
'    SELECT COUNT(*) TOTAL',
'    FROM Av_Aplica_Avaliacoes_Itens',
'    WHERE COD_EMP_AVALIADO   = :P144_COD_EMPRESA /*:P144_COD_EMP_AVALIADO*/',
'    AND   COD_MAT_AVALIADO   = :P144_MATRICULA /*:P144_COD_MAT_AVALIADO*/',
'    AND   COD_EMP_AVALIADOR  = :P144_COD_EMP_AVALIADOR',
'    AND   COD_MAT_AVALIADOR  = :P144_COD_MAT_AVALIADOR',
'    AND   COD_AVALIACAO      = :P144_COD_AVALIACAO',
'    AND   DATA_AVALIACAO     = :P144_DATA_AVALIACAO',
'    AND   TIPO_AVALIACAO     = :P144_TIPO_AVALIACAO;',
'    ',
'    V_C2 C2%ROWTYPE;',
'    ',
'begin',
'',
'      OPEN  C1;',
'      FETCH C1 INTO V_C1;',
'      CLOSE C1;',
'',
'      OPEN  C2;',
'      FETCH C2 INTO V_C2;',
'      CLOSE C2;',
'      ',
'      IF NVL(V_C1.TOTAL,0) > 0 THEN',
'      ',
'          IF NVL(V_C1.TOTAL,0) = NVL(V_C2.TOTAL,0) THEN',
'            begin',
'            SELECT REAVALIACAO',
'              into :P144_REAVALIACAO',
'              FROM AV_AVALIACOES',
'             WHERE COD_AVALIACAO = :P144_COD_AVALIACAO;',
'             ',
'            if :p144_tipo_avaliacao = ''C'' then',
'                :P144_REAVALIACAO := ''S'';',
'            end if;',
'            ',
'            exception',
'            when no_data_found then',
'            null;',
'            end;',
'          ELSE',
'',
'            :P144_REAVALIACAO := ''S'';',
'',
'          END IF;     ',
'       ',
'       END IF;',
'END;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_COD_AVALIACAO,P144_COD_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_COD_EMPRESA'
,p_attribute_03=>'P144_REAVALIACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(63320953734050027537)
,p_name=>unistr('(N\00E3o \00E9 avaliado(r)) Desabilita Campos')
,p_event_sequence=>140
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320954323542027537)
,p_event_id=>wwv_flow_api.id(63320953734050027537)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P144_RADIO_GROUP,P144_CHECK_BOX,P144_RESPOSTA_DISSERTATIVA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(58833469717144611029)
,p_name=>'Finaliza - Close Dialog'
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(58807759870818464678)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>unistr('-- A\00E7\00E3o substitu\00EDda pela tratativa seguinte.')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(58833469788249611030)
,p_event_id=>wwv_flow_api.id(58833469717144611029)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(33276599959119261734)
,p_name=>'SET_SUPLENTE'
,p_event_sequence=>170
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>':P144_COD_MAT_AVALIADOR != :P_MATRICULA_USER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(33307739655256384686)
,p_event_id=>wwv_flow_api.id(33276599959119261734)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'V_MAT informacoes_funcionais.matricula%type;',
'V_COD NUMBER(3);',
'BEGIN ',
'',
'BEGIN',
'SELECT MATRICULA_SUPLENTE',
'INTO V_MAT',
'FROM CENTRO_DE_CUSTO',
'WHERE COD_EMP_GESTOR = :P144_COD_EMP_AVALIADOR',
'AND MATRICULA_GESTOR = :P144_COD_MAT_AVALIADOR',
'AND COD_EMPRESA      = :P144_COD_EMPRESA;',
'END;',
'',
'BEGIN',
'SELECT COD_EMP_SUPLENTE',
'INTO V_COD',
'FROM CENTRO_DE_CUSTO',
'WHERE COD_EMP_GESTOR = :P144_COD_EMP_AVALIADOR   ',
'AND MATRICULA_GESTOR = :P144_COD_MAT_AVALIADOR',
'AND COD_EMPRESA      = :P144_COD_EMPRESA;',
'END;',
'',
':P144_COD_MAT_SUP := V_MAT;',
':P144_COD_EMP_SUP := V_COD;',
'EXCEPTION',
'WHEN OTHERS THEN',
'NULL;',
'END;',
''))
,p_attribute_02=>'P144_COD_PRIMEIRO_AVALIADOR,P144_MAT_PRIMEIRO_AVALIADOR,P144_COD_EMPRESA'
,p_attribute_03=>'P144_COD_EMP_SUP,P144_COD_MAT_SUP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21038820241606221572)
,p_name=>unistr('Voltar para a p\00E1gina anterior')
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(21038820159651221571)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_da_event_comment=>'ch38449'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21056784747183631064)
,p_event_id=>wwv_flow_api.id(21038820241606221572)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if NVL(:P144_IND_ACOES_DIVERSAS,''N'') = ''N'' then',
'    begin',
'      delete AV_APLICA_AVAL_ACOES_FUNC g',
'      WHERE  g.cod_emp_avaliado      = :p144_cod_empresa -- 3',
'        and g.cod_mat_avaliado       = :p144_matricula -- 39152',
'        and g.cod_emp_avaliador      = :p144_cod_emp_avaliador -- 1',
'        and g.cod_mat_avaliador      = :p144_cod_mat_avaliador -- 708118',
'        and g.cod_avaliacao          = :p144_cod_avaliacao -- ''7''',
'        and g.data_avaliacao         = to_date(:p144_data_avaliacao,''dd/mm/yyyy'') -- to_date(''16/06/2025'',''dd/mm/rrrr'')',
'        and g.tipo_avaliacao         = :p144_tipo_avaliacao -- ''G''',
'        and g.cod_ciclo              = :p144_cod_ciclo -- 150',
'        and g.cod_item_avaliacao     = :p144_cod_item_avaliacao; -- 141;',
'        commit;',
'    end;',
'  end if;',
'end;'))
,p_attribute_02=>'P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_EMPRESA,P144_COD_CICLO,P144_TIPO_AVALIACAO,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_COD_ITEM_AVALIACAO,P144_MATRICULA,P144_IND_ACOES_DIVERSAS'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21038821961436221589)
,p_event_id=>wwv_flow_api.id(21038820241606221572)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process("VALIDAR_FECHAMENTO", {',
unistr('    pageItems: "#P144_COD_EMPRESA, #P144_MATRICULA, #P144_COD_EMP_AVALIADOR, #P144_COD_MAT_AVALIADOR, #P144_COD_AVALIACAO, #P144_DATA_AVALIACAO, #P144_COD_ITEM_AVALIACAO" // envie os dados da p\00E1gina se necess\00E1rio'),
'    ',
'}, {',
'    success: function(pData) {',
'        if (pData.status_valido === ''N'') {',
'            apex.message.alert(pData.mensagem);',
'        } else {',
'            // Fecha o modal ou redireciona',
'            apex.navigation.dialog.close(true);',
'        }',
'    },',
'    error: function(request, status, error) {',
'        apex.message.alert("Erro ao validar. Tente novamente.");',
'    }',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(19257332832507620770)
,p_name=>unistr('Voltar para a p\00E1gina anterior_1')
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(58807759870818464678)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_da_event_comment=>'ch38449'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(19257332949272620771)
,p_event_id=>wwv_flow_api.id(19257332832507620770)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  if NVL(:P144_IND_ACOES_DIVERSAS,''N'') = ''N'' then',
'    begin',
'      delete AV_APLICA_AVAL_ACOES_FUNC g',
'      WHERE  g.cod_emp_avaliado      = :p144_cod_empresa -- 3',
'        and g.cod_mat_avaliado       = :p144_matricula -- 39152',
'        and g.cod_emp_avaliador      = :p144_cod_emp_avaliador -- 1',
'        and g.cod_mat_avaliador      = :p144_cod_mat_avaliador -- 708118',
'        and g.cod_avaliacao          = :p144_cod_avaliacao -- ''7''',
'        and g.data_avaliacao         = to_date(:p144_data_avaliacao,''dd/mm/yyyy'') -- to_date(''16/06/2025'',''dd/mm/rrrr'')',
'        and g.tipo_avaliacao         = :p144_tipo_avaliacao -- ''G''',
'        and g.cod_ciclo              = :p144_cod_ciclo -- 150',
'        and g.cod_item_avaliacao     = :p144_cod_item_avaliacao; -- 141;',
'        commit;',
'    end;',
'  end if;',
'end;'))
,p_attribute_02=>'P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_EMPRESA,P144_COD_CICLO,P144_TIPO_AVALIACAO,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_COD_ITEM_AVALIACAO,P144_MATRICULA,P144_IND_ACOES_DIVERSAS'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(19257333106820620772)
,p_event_id=>wwv_flow_api.id(19257332832507620770)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.server.process("VALIDAR_FECHAMENTO", {',
unistr('    pageItems: "#P144_COD_EMPRESA, #P144_MATRICULA, #P144_COD_EMP_AVALIADOR, #P144_COD_MAT_AVALIADOR, #P144_COD_AVALIACAO, #P144_DATA_AVALIACAO, #P144_COD_ITEM_AVALIACAO" // envie os dados da p\00E1gina se necess\00E1rio'),
'    ',
'}, {',
'    success: function(pData) {',
'        if (pData.status_valido === ''N'') {',
'            apex.message.alert(pData.mensagem);',
'        } else {',
'            // Fecha o modal ou redireciona',
'            apex.navigation.dialog.close(true);',
'        }',
'    },',
'    error: function(request, status, error) {',
'        apex.message.alert("Erro ao validar. Tente novamente.");',
'    }',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21038822253218221592)
,p_name=>unistr('New -- isolar processos n\00E3o utilizados')
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P144_RADIO_GROUP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320946841786027531)
,p_event_id=>wwv_flow_api.id(21038822253218221592)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_mat_avaliado',
'  from av_aplica_avaliacoes',
' where cod_emp_avaliado = :p144_cod_empresa',
'   and cod_mat_avaliado = :p144_matricula',
'   and cod_avaliacao = :p144_cod_avaliacao',
'   and data_avaliacao = :p144_data_avaliacao',
'   and tipo_avaliacao = :p144_tipo_avaliacao',
'   AND (:P144_COD_CICLO IS NULL OR COD_CICLO = :P144_COD_CICLO)',
'   AND (:P144_COD_CICLO_AUX IS NULL OR COD_CICLO = :P144_COD_CICLO_AUX);',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'null;',
'/*',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    if v_c1.cod_mat_avaliado is null then',
'',
'        begin',
'',
'        insert into AV_APLICA_AVALIACOES',
'        (',
'        cod_emp_avaliado,',
'        cod_mat_avaliado,',
'        cod_emp_avaliador,',
'        cod_mat_avaliador,',
'        cod_avaliacao,',
'        data_avaliacao,',
'        tipo_avaliacao,',
'        cod_ciclo',
'        )',
'        values ',
'        (',
'        :p144_cod_empresa,',
'        :p144_matricula,',
'        :p144_cod_emp_avaliador,',
'        :p144_cod_mat_avaliador,',
'        :p144_cod_avaliacao,',
'        :p144_data_avaliacao,',
'        :p144_tipo_avaliacao,',
'        :p144_cod_ciclo',
'        );',
'',
'        commit;',
'',
'        end;',
'',
'    end if;',
'*/',
'end;'))
,p_attribute_02=>'P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_COD_CICLO,P144_COD_CICLO_AUX'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(63320947380062027532)
,p_event_id=>wwv_flow_api.id(21038822253218221592)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
' XX VARCHAR2(100);',
'begin',
'Select nota_item',
'  into XX-- :p144_nota_item',
'  From Av_Aplica_Avaliacoes_Itens',
' Where Cod_Item_Avaliacao = :p144_cod_item_avaliacao',
'   and Cod_Emp_Avaliado = :p144_Cod_Empresa',
'   And Cod_Mat_Avaliado = :p144_Matricula',
'   And Cod_Emp_Avaliador = :p144_Cod_Emp_Avaliador',
'   And Cod_Mat_Avaliador = :p144_Cod_Mat_Avaliador',
'   And Cod_Avaliacao = :p144_Cod_Avaliacao',
'   And Data_Avaliacao = :p144_Data_Avaliacao',
'   And Tipo_Avaliacao = :p144_tipo_avaliacao',
'   and cod_sub_item_avaliacao = :p144_radio_group',
'   AND (:P144_COD_CICLO IS NULL OR COD_CICLO = :P144_COD_CICLO)',
'   AND (:P144_COD_CICLO_AUX IS NULL OR COD_CICLO = :P144_COD_CICLO_AUX)',
'   And rownum = 1;',
'exception',
'when others then',
'null;',
'end;'))
,p_attribute_02=>'P144_COD_ITEM_AVALIACAO,P144_COD_EMPRESA,P144_MATRICULA,P144_COD_EMP_AVALIADOR,P144_COD_MAT_AVALIADOR,P144_COD_AVALIACAO,P144_DATA_AVALIACAO,P144_TIPO_AVALIACAO,P144_RADIO_GROUP,P144_COD_CICLO,P144_COD_CICLO_AUX'
,p_attribute_03=>'P144_NOTA_ITEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21056785450669631071)
,p_name=>'Alerta Acao Pendente (next record)'
,p_event_sequence=>210
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(21056785325729631070)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21056785563914631072)
,p_event_id=>wwv_flow_api.id(21056785450669631071)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('apex.message.alert("Indique uma a\00E7\00E3o.");')
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21056785815435631074)
,p_name=>'Alerta Acao Pendente (prev record)'
,p_event_sequence=>220
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(21056785680108631073)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21056785849721631075)
,p_event_id=>wwv_flow_api.id(21056785815435631074)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('apex.message.alert("Indique uma a\00E7\00E3o.");')
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(21056789055131631107)
,p_name=>'Dialog Close - Submit'
,p_event_sequence=>230
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(86990941960250486707)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_da_event_comment=>unistr('Esse submit \00E9 o q vai for\00E7ar os bot\00F5es de navega\00E7\00E3o entre registros \00E0 revalidar a quest\00E3o da a\00E7\00E3o - N\00E3o remover essa DA')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(21056789177355631108)
,p_event_id=>wwv_flow_api.id(21056789055131631107)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320943731783027529)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch'
,p_attribute_02=>'AV_COMPOSICAO_AVALIACAO'
,p_attribute_03=>'P144_ROWID'
,p_attribute_04=>'ROWID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320944131923027529)
,p_process_sequence=>30
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST_QUERY'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'Select Descricao,',
'                Caracteristica',
'           Into :P144_Nome_Item_Avaliacao,',
'                :P144_Caracteristica',
'           From Av_Item_Avaliacao',
'          Where Codigo = :P144_Cod_Item_Avaliacao;',
'EXCEPTION',
'WHEN OTHERS THEN',
'NULL;',
'END;',
'',
'DECLARE',
'	--',
'	V_DESC_GRUPO AV_GRUPO_COMPETENCIA.DESCRICAO%TYPE;',
'  V_DESC AV_COMPETENCIA.DESCRICAO%TYPE;',
'    --',
'--',
'BEGIN',
'	--',
'  BEGIN',
'	  --',
'	  SELECT DESCRICAO',
'	    INTO V_DESC_GRUPO',
'	    FROM AV_GRUPO_COMPETENCIA',
'	   WHERE CODIGO = :P144_COD_GRUPO_COMP;',
'  --',
'  EXCEPTION',
'	  --',
'  	WHEN OTHERS THEN',
'	    --',
'	    V_DESC_GRUPO := NULL;',
'  --',
'  END;',
'  ',
'  :P144_DESC_GRUPO_COMP := V_DESC_GRUPO;',
'  ',
'  BEGIN',
'	  --',
'	  SELECT DESCRICAO',
'	    INTO V_DESC',
'	    FROM AV_COMPETENCIA',
'	   WHERE CODIGO = :P144_COD_COMP',
'       AND (:P144_COD_GRUPO_COMP IS NULL OR COD_GRUPO_COMPETENCIA = :P144_COD_GRUPO_COMP);',
'  --',
'  EXCEPTION',
'	  --',
'  	WHEN OTHERS THEN',
'	    --',
'	    V_DESC := NULL;',
'  --',
'  END;',
'  --',
'  :P144_DESC_COMP := V_DESC;',
'--',
'    begin',
'        if :p144_tipo_avaliacao = ''C'' then',
'           :p144_reavaliacao := ''S'';',
'        end if;',
'    end;',
'    ',
'    begin',
'    ',
'    select ind_autoavaliacao',
'      into :P144_IND_AUTOAVALIACAO',
'      from av_avaliacoes',
'     where cod_avaliacao = :p144_cod_avaliacao;',
'      ',
'    exception',
'    when others then',
'    null;',
'    ',
'    end;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320944611586027529)
,p_process_sequence=>40
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT COUNT(*) TOTAL',
'  FROM AV_COMPOSICAO_AVALIACAO',
' WHERE COD_EMPRESA = :P144_COD_EMPRESA',
'   AND COD_AVALIACAO = :P144_COD_AVALIACAO;',
'   ',
'V_C1 C1%ROWTYPE;',
'',
'CURSOR C_PREV IS',
'SELECT MAX(ORDEM_ITEM) ORDEM_PREV',
'  FROM AV_COMPOSICAO_AVALIACAO',
' WHERE COD_EMPRESA = :P144_COD_EMPRESA',
'   AND COD_AVALIACAO = :P144_COD_AVALIACAO',
'   AND ORDEM_ITEM < :P144_ORDEM_ITEM;',
'   ',
'V_PREV C_PREV%ROWTYPE;',
'',
'CURSOR C_NEXT IS',
'SELECT MIN(ORDEM_ITEM) ORDEM_NEXT',
'  FROM AV_COMPOSICAO_AVALIACAO',
' WHERE COD_EMPRESA = :P144_COD_EMPRESA',
'   AND COD_AVALIACAO = :P144_COD_AVALIACAO',
'   AND ORDEM_ITEM > :P144_ORDEM_ITEM;',
'   ',
'V_NEXT C_NEXT%ROWTYPE;',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
':P144_ORDEM_COUNT := V_C1.TOTAL;',
'',
'if :p144_nota_item is null then',
':p144_titulo := ''Pergunta ''||:p144_ordem_item||'' de ''||v_c1.total;',
'else',
':p144_titulo := ''Pergunta - Nota: ''||:p144_nota_item||'' ''||:p144_ordem_item||'' de ''||v_c1.total;',
'end if;',
'',
'OPEN C_PREV;',
'FETCH C_PREV INTO V_PREV;',
'CLOSE C_PREV;',
'',
':P144_ORDEM_PREV := V_PREV.ORDEM_PREV;',
'',
'OPEN C_NEXT;',
'FETCH C_NEXT INTO V_NEXT;',
'CLOSE C_NEXT;',
'',
':P144_ORDEM_NEXT := V_NEXT.ORDEM_NEXT;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(58807759835494464677)
,p_process_sequence=>50
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pagination'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c_prev is',
'select max(r.ordem_item) ordem_prev--max(r.rowid) rowid_prev',
'  from AV_COMPOSICAO_AVALIACAO r',
' where r.cod_avaliacao = :p144_cod_avaliacao',
'   and r.cod_empresa = :p144_cod_empresa',
'   and r.ordem_item < :p144_ordem_item;',
'',
'v_prev c_prev%rowtype;',
'',
'cursor c_next is',
'select min(r.ordem_item) ordem_next--min(r.rowid) rowid_next',
'  from AV_COMPOSICAO_AVALIACAO r',
' where r.cod_avaliacao = :p144_cod_avaliacao',
'   and r.cod_empresa = :p144_cod_empresa',
'   and r.ordem_item > :p144_ordem_item;',
'',
'v_next c_next%rowtype;',
'',
'cursor c_row (v_ordem number) is',
'select r.rowid',
'  from AV_COMPOSICAO_AVALIACAO r',
' where r.cod_avaliacao = :p144_cod_avaliacao',
'   and r.cod_empresa = :p144_cod_empresa',
'   and r.ordem_item = v_ordem;',
'',
'v_row c_row%rowtype;',
'',
'v_rowid_prev varchar2(255);',
'v_rowid_next varchar2(255);',
'',
'begin',
'',
'  open c_prev;',
'  fetch c_prev into v_prev;',
'  close c_prev;',
'  ',
'  open c_row (v_prev.ordem_prev);',
'  fetch c_row into v_row;',
'  close c_row;',
'  ',
'  v_rowid_prev := v_row.rowid;',
'  v_row.rowid := null;',
'  open c_next;',
'  fetch c_next into v_next;',
'  close c_next;',
'  ',
'  open c_row (v_next.ordem_next);',
'  fetch c_row into v_row;',
'  close c_row;',
'  ',
'  v_rowid_next := v_row.rowid;',
'  ',
'  :p144_rowid_prev := v_rowid_prev;--v_prev.rowid_prev;',
'  :p144_rowid_next := v_rowid_next;--v_next.rowid_next;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(63320943419157027528)
,p_process_sequence=>60
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_FORM_PAGINATION'
,p_process_name=>'Form Pagination'
,p_attribute_02=>'AV_COMPOSICAO_AVALIACAO'
,p_attribute_03=>'P144_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_07=>'COD_AVALIACAO'
,p_attribute_08=>'ORDEM_ITEM'
,p_attribute_09=>'P144_ROWID_NEXT'
,p_attribute_10=>'P144_ROWID_PREV'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(21038821883451221588)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'VALIDAR_FECHAMENTO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vacao_ok VARCHAR2(1);',
'BEGIN',
'  if NVL(:P144_IND_ACOES_DIVERSAS,''N'') = ''S'' then',
'    begin  ',
'      select DISTINCT ''S''',
'      into  vacao_ok',
'      from   AV_APLICA_AVAL_ACOES_FUNC',
'      WHERE COD_EMP_AVALIADO   = :P144_COD_EMPRESA -- 3 -- ',
'      AND   COD_MAT_AVALIADO   = :P144_MATRICULA -- 39152 -- ',
'      AND   COD_EMP_AVALIADOR  = :P144_COD_EMP_AVALIADOR -- 1 -- ',
'      AND   COD_MAT_AVALIADOR  = :P144_COD_MAT_AVALIADOR -- 708118 --',
'      AND   COD_AVALIACAO      = :P144_COD_AVALIACAO -- ''7'' -- ',
'      AND   DATA_AVALIACAO     = TO_DATE(:P144_DATA_AVALIACAO,''DD/MM/YYYY'') -- ''12/06/2025'' -- ',
'      AND   COD_ITEM_AVALIACAO = :P144_COD_ITEM_AVALIACAO;',
'    exception',
'      when others then',
'        vacao_ok := ''N'';',
'    end;',
'  else',
'    vacao_ok := ''S'';',
'  end if;',
'',
'  IF vacao_ok = ''N'' THEN',
'    apex_json.open_object;',
'    apex_json.write(''status_valido'', ''N'');',
unistr('    apex_json.write(''mensagem'', ''Indique uma a\00E7\00E3o.'');'),
unistr('--    apex_json.write(''mensagem'', ''Indique uma a\00E7\00E3o ou mude a resposta. ''||:P144_COD_EMPRESA||'', ''||:P144_MATRICULA||'', ''||:P144_COD_EMP_AVALIADOR||'', ''||:P144_COD_MAT_AVALIADOR||'', ''||:P144_COD_AVALIACAO||'', ''||:P144_DATA_AVALIACAO||'', ''||:P144_COD_')
||'ITEM_AVALIACAO);',
'    apex_json.close_object;',
'  ELSE',
'    apex_json.open_object;',
'    apex_json.write(''status_valido'', ''S'');',
'    apex_json.close_object;',
'  END IF;',
'EXCEPTION',
'  WHEN NO_DATA_FOUND THEN',
'    apex_json.open_object;',
'    apex_json.write(''status_valido'', ''N'');',
unistr('    apex_json.write(''mensagem'', ''Registro n\00E3o encontrado.'');'),
'    apex_json.close_object;',
'END;'))
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
