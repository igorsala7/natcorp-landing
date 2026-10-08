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
--     PAGE: 13
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00013
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>13);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_api.create_page(
 p_id=>13
,p_user_interface_id=>wwv_flow_api.id(72951057877835200729)
,p_name=>'Cadastro de Processo Seletivo'
,p_page_mode=>'MODAL'
,p_step_title=>'Cadastro de Processo Seletivo'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_ProcessoJanelas.css'
,p_javascript_code=>'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';'
,p_page_template_options=>'#DEFAULT#'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_ProcessoJanelas.css / Natcorp_ProcessoJanelas.js)',
'',
'Janela Processo seletivo: ficha do processo no alto (status, cargo, empresa, filial, CC, vaga,',
unistr('requisi\00E7\00E3o); "Classifica\00E7\00E3o e respons\00E1vel"; se\00E7\00F5es abertas; campo s\00F3 de leitura como texto; vazio sai.'),
'Para desligar: tire as duas URLs de arquivo. Guia: brand/apex/app/PROCESSOJANELAS-MANUTENCAO.md.',
unistr('---- (fim do bloco Natcorp; abaixo, o coment\00E1rio que a p\00E1gina j\00E1 tinha) ----')))
,p_protection_level=>'C'
,p_last_updated_by=>'GUILHERME.GENEROSA'
,p_last_upd_yyyymmddhh24miss=>'20260720175304'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52925314572766296250)
,p_plug_name=>'Cadastro de Processo Seletivo'
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(72951023803503200621)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'PS_PROCESSO_SELETIVO'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(50845861976524527979)
,p_plug_name=>unistr('Publica\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_region_template_options=>'#DEFAULT#:is-collapsed:t-Region--scrollBody:t-Form--slimPadding:margin-top-lg:margin-left-sm'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52898048704989220990)
,p_plug_name=>unistr('Outras Informa\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:is-collapsed:t-Region--scrollBody:margin-top-sm:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52898047432458220978)
,p_plug_name=>unistr('Solicita\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(52898048704989220990)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--leftLabels:margin-top-none:margin-bottom-none:margin-left-sm'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52898047725991220981)
,p_plug_name=>unistr('Indica\00E7\00E3o para Acompanhamento')
,p_parent_plug_id=>wwv_flow_api.id(52898048704989220990)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none:margin-left-sm'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52898048377073220987)
,p_plug_name=>unistr('Substitui\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(52898048704989220990)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none:margin-left-sm'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52898048459262220988)
,p_plug_name=>'Outros'
,p_parent_plug_id=>wwv_flow_api.id(52898048704989220990)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-useLocalStorage:is-collapsed:t-Region--noBorder:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:margin-top-none:margin-bottom-none:margin-left-sm'
,p_plug_template=>wwv_flow_api.id(72951028167707200630)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(52925342757435296442)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(72951023886675200622)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52925343169972296443)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52925344730242296452)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'DELETE'
,p_button_action=>'REDIRECT_URL'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_image_alt=>'Deletar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_button_redirect_url=>'javascript:apex.confirm(htmldb_delete_message,''DELETE'');'
,p_button_execute_validations=>'N'
,p_button_condition_type=>'NEVER'
,p_database_action=>'DELETE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52898050628748221010)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'CANDIDATO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Insere Candidatos'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P13_STATUS'
,p_button_condition2=>'A'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52898050934339221013)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'ADITIVO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--pillStart:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'<strong>Aditivo Contrato</strong>'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RP,7:P7_ROWID:&P13_ROWID_ADITIVO.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52956817878768623297)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'ADITIVO_AUX'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--pillStart:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aditivo Contrato'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RP,7:P7_COD_PROCESSO,P7_COD_ENTIDADE,P7_COD_REQ,P7_COD_EMPRESA:&P13_COD_PROCESSO.,&P13_COD_ENTIDADE.,&P13_COD_REQ.,&P13_COD_EMPRESA.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52925345192287296452)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'SAVE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--gapLeft'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P13_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(52925345597733296454)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(52925342757435296442)
,p_button_name=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(72951052672595200679)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'&nbsp&nbsp&nbspCriar&nbsp&nbsp&nbsp'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_condition=>'P13_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(42392755530919911990)
,p_name=>'P13_PLATAFORMAS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(50845861976524527979)
,p_prompt=>'Plataformas'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT V.NOME D, V.ID_NOME C',
'  FROM RS_PLATAFORMAS_VAGAS V',
' WHERE ((NVL(V.ATIVO,''N'') = ''S'' and :p13_dt_fechamento is null) or ',
'        (:p13_dt_fechamento is not null and exists (select 1 ',
'                                                      from PS_PROCESSO_SELETIVO_PLATAFORMAS r ',
'                                                     where r.cod_processo = :p13_cod_processo ',
'                                                       and r.cod_empresa = :p13_cod_empresa ',
'                                                       and r.id_nome = v.id_nome)))',
'order by v.nome'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P13_DT_FECHAMENTO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_read_only_when=>'P13_DT_FECHAMENTO'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50845863328795527992)
,p_name=>'P13_QUADRO_VAGA_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(50845861976524527979)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'Quadro de Vaga'
,p_source=>'QUADRO_VAGA_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''(''||l.id||'') ''||upper(l.nome) d,',
'        l.id c',
'from QUADRO_VAGAS_LAYOUT L',
'where ((:p13_status <> ''A'') or (:p13_status = ''A'' and l.status = ''A''))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P13_STATUS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(50845864231232528001)
,p_name=>'P13_TEMPLATE_DESCRICAO_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(50845861976524527979)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('Template de Descri\00E7\00E3o de Vaga')
,p_source=>'TEMPLATE_DESCRICAO_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''(''||l.cod||'') ''||upper(l.descricao) d,',
'        l.cod c',
'from RS_TEMPLATE_DESCRICAO L',
'where ((:p13_status <> ''A'') or (:p13_status = ''A'' and l.ativo = ''S''))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P13_STATUS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049159617220995)
,p_name=>'P13_STATUS_TXT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_use_cache_before_default=>'NO'
,p_prompt=>'STATUS'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE :P13_STATUS',
'          WHEN ''A'' THEN ''A - Ativo''',
'          WHEN ''F'' THEN ''F - Finalizado''',
'          WHEN ''C'' THEN ''C - Cancelado''',
'        ELSE NULL END) det ',
'   FROM dual'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-wizard'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049492661220998)
,p_name=>'P13_CARGO_TXT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CARGO'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT c.cod||'' - ''||c.nome det',
'  FROM cargos c',
' WHERE c.cod = :P13_COD_CARGO'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-window-user'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049615315220999)
,p_name=>'P13_CCUSTO_TXT'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_use_cache_before_default=>'NO'
,p_prompt=>'C. CUSTO'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT c.cod||'' - ''||c.nome det',
'  FROM centro_de_custo c',
' WHERE c.cod         = :P13_COD_CCUSTO',
'   AND c.cod_empresa = :P13_COD_EMPRESA'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-credit-card'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049648132221000)
,p_name=>'P13_SELECIONADOR_TXT'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.cod_prest_serv||'' - ''||p.nome det',
'  FROM prestador_servico p',
' WHERE p.tipo_prest_serv = ''5''',
'   AND p.cod_prest_serv  = :P13_COD_PREST_SERV'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049770271221001)
,p_name=>'P13_SOLICITANTE_TXT'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_use_cache_before_default=>'NO'
,p_prompt=>'SOLICITANTE'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT :P13_MAT_SOLICITANTE||'' - ''||i.nome det',
'  FROM inf_pessoais i, requisicao r ',
' WHERE i.matricula   = r.mat_req ',
'   AND i.cod_empresa = r.cod_emp_req ',
'   AND r.cod_req     = :P13_COD_REQ'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-user-pointer'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898049839603221002)
,p_name=>'P13_GESTOR_TXT'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_use_cache_before_default=>'NO'
,p_prompt=>'GESTOR'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.nome',
'  FROM inf_pessoais           p',
'      ,informacoes_funcionais f       ',
' WHERE f.cod_empresa = p.cod_empresa',
'   AND f.matricula   = p.matricula',
'   AND p.cod_empresa = :P13_EMP_GESTOR_IND',
'   AND p.matricula   = :P13_MAT_GESTOR_IND'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-user-ban'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898050001939221003)
,p_name=>'P13_AVALIADOR_TXT'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_use_cache_before_default=>'NO'
,p_prompt=>'AVALIADOR'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT p.nome',
'  FROM inf_pessoais           p',
'      ,informacoes_funcionais f       ',
' WHERE f.cod_empresa = p.cod_empresa',
'   AND f.matricula   = p.matricula',
'   AND p.cod_empresa = :P13_EMP_AVALIADOR_IND',
'   AND p.matricula   = :P13_MAT_AVALIADOR_IND'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-user-check'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898050103509221004)
,p_name=>'P13_EMAIL_GESTOR_TXT'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-MAIL'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT f.e_mail',
'  FROM inf_pessoais           p',
'      ,informacoes_funcionais f       ',
' WHERE f.cod_empresa = p.cod_empresa',
'   AND f.matricula   = p.matricula',
'   AND p.cod_empresa = :P13_EMP_GESTOR_IND',
'   AND p.matricula   = :P13_MAT_GESTOR_IND'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-envelope-o'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898050140060221005)
,p_name=>'P13_EMAIL_AVALIADOR_TXT'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-MAIL'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT f.e_mail',
'  FROM inf_pessoais           p',
'      ,informacoes_funcionais f       ',
' WHERE f.cod_empresa = p.cod_empresa',
'   AND f.matricula   = p.matricula',
'   AND p.cod_empresa = :P13_EMP_AVALIADOR_IND',
'   AND p.matricula   = :P13_MAT_AVALIADOR_IND'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-envelope-o'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898050301821221006)
,p_name=>'P13_SUBSTITUIDO_TXT'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(52898048377073220987)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('SUBSTITU\00CDDO')
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT :P13_MAT_SUBS||'' - ''||p.nome',
'  FROM inf_pessoais p',
' WHERE p.cod_empresa = :P13_COD_EMPRESA',
'   AND p.matricula   = :P13_MAT_SUBS'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-user-x'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52898050370197221007)
,p_name=>'P13_MOTIVO_TXT'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(52898048377073220987)
,p_use_cache_before_default=>'NO'
,p_prompt=>'MOTIVO'
,p_placeholder=>'-'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT m.cod_mot_subs||'' - ''||m.desc_mot_subs det',
'  FROM mot_subs m',
' WHERE m.cod_mot_subs = :P13_MOT_SUBS'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-exclamation-triangle-o'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925314967457296253)
,p_name=>'P13_ROWID'
,p_source_data_type=>'VARCHAR2'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925315256551296345)
,p_name=>'P13_COD_PROCESSO'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_default=>'seq_ps_processo_seletivo.NEXTVAL'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'PROCESSO'
,p_placeholder=>'-'
,p_source=>'COD_PROCESSO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041888379256304)
,p_item_icon_css_classes=>'fa-list-ol'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'9999999999'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925315677650296358)
,p_name=>'P13_COD_EMPRESA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'EMPRESA'
,p_placeholder=>'-'
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-building-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925316059943296359)
,p_name=>'P13_COD_FILIAL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'FILIAL'
,p_placeholder=>'-'
,p_source=>'COD_FILIAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-home'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925316465687296359)
,p_name=>'P13_COD_VAGA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'VAGA'
,p_placeholder=>'-'
,p_source=>'COD_VAGA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>6
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-bullseye'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925316869889296359)
,p_name=>'P13_COD_CARGO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'COD_CARGO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925317239139296360)
,p_name=>'P13_COD_CCUSTO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'COD_CCUSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925317647709296360)
,p_name=>'P13_MAT_SUBS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(52898048377073220987)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'MAT_SUBS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925318035883296361)
,p_name=>'P13_MOT_SUBS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(52898048377073220987)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'MOT_SUBS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925318449899296361)
,p_name=>'P13_LOCAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'LOCAL'
,p_placeholder=>'-'
,p_source=>'LOCAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>70
,p_cMaxlength=>70
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925318898596296361)
,p_name=>'P13_DT_SOLICITACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('DATA SOLICITA\00C7\00C3O')
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_SOLICITACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-calendar-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925319255633296368)
,p_name=>'P13_DT_APROVACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('DATA APROVA\00C7\00C3O')
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_APROVACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-calendar-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925319647370296368)
,p_name=>'P13_DT_FECHAMENTO'
,p_source_data_type=>'DATE'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'DATA FECHAMENTO'
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_FECHAMENTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-calendar-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925320070514296368)
,p_name=>'P13_MAT_SOLICITANTE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'MAT_SOLICITANTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925320486223296369)
,p_name=>'P13_OBSERVACAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('OBSERVA\00C7\00C3O')
,p_placeholder=>'-'
,p_source=>'OBSERVACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>2000
,p_cMaxlength=>2000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925320878782296372)
,p_name=>'P13_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'STATUS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925321278627296373)
,p_name=>'P13_COD_ENTIDADE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'CONSULTORIA'
,p_placeholder=>'-'
,p_source=>'COD_ENTIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT e.cod_entidade||'' - ''||e.nome_entidade det',
'      ,e.cod_entidade                         ret',
'  FROM entidade e',
' WHERE e.tipo_entidade = ''5''',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Entidades'
,p_attribute_08=>'380'
,p_attribute_09=>'420'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925321624783296373)
,p_name=>'P13_DT_INI_ENTIDADE'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('DATA IN\00CDCIO')
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_INI_ENTIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925322118301296373)
,p_name=>'P13_DT_FIM_ENTIDADE'
,p_source_data_type=>'DATE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'DATA FINAL'
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_FIM_ENTIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925322472782296374)
,p_name=>'P13_COD_PROC_ANTERIOR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'COD_PROC_ANTERIOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925322870403296374)
,p_name=>'P13_COD_REQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('REQUISI\00C7\00C3O')
,p_placeholder=>'-'
,p_source=>'COD_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-list-alt'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925323258599296375)
,p_name=>'P13_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_default=>'TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'')'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925323701502296375)
,p_name=>'P13_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_default=>':APP_USER'
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925324109381296376)
,p_name=>'P13_TIPO_ENTIDADE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'TIPO_ENTIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925324474864296378)
,p_name=>'P13_DESCRICAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'DESCRICAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925324868400296379)
,p_name=>'P13_DT_PERFIL'
,p_source_data_type=>'DATE'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(52898047432458220978)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'DATA PERFIL'
,p_placeholder=>'-'
,p_format_mask=>'DD/MM/RRRR'
,p_source=>'DT_PERFIL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925325252481296379)
,p_name=>'P13_VALOR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'VALOR'
,p_placeholder=>'-'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_source=>'VALOR'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>16
,p_cMaxlength=>16
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925325683952296379)
,p_name=>'P13_TAXA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(52898048459262220988)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'TAXA %'
,p_placeholder=>'-'
,p_format_mask=>'999D99'
,p_source=>'TAXA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>6
,p_cMaxlength=>6
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'0.00'
,p_attribute_02=>'100.00'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925326119776296382)
,p_name=>'P13_TIPO_PREST_SERV'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'TIPO_PREST_SERV'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925326427549296382)
,p_name=>'P13_COD_PREST_SERV'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'SELECIONADOR'
,p_placeholder=>'-'
,p_source=>'COD_PREST_SERV'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ps.cod_prest_serv||'' - ''|| Initcap(ps.nome)||DECODE(gs.descricao,NULL,NULL,'' - ''||gs.descricao)||case when trunc(sysdate) between trunc(ps.dt_vigencia_inic) and trunc(ps.dt_vigencia_fin) then '' (Ativo)'' else '' (Inativo)'' end det',
'      ,ps.cod_prest_serv                                                                      ret',
'  FROM prestador_servico      ps',
'      ,ps_dados_grupo_selecao dgs',
'      ,ps_grupo_selecao       gs',
' WHERE gs.cod_ps_grupo    (+) = dgs.cod_ps_grupo',
'   AND dgs.cod_prest_serv (+) = ps.cod_prest_serv',
'   AND dgs.tipo_prest_serv(+) = ps.tipo_prest_serv',
'   AND ps.tipo_prest_serv     = ''5'' ',
'   AND NVL(:P13_STATUS,''A'') = ''A'' --and trunc(sysdate) between trunc(ps.dt_vigencia_inic) and trunc(ps.dt_vigencia_fin))',
'ORDER BY  to_number(ps.cod_prest_serv);'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P13_STATUS'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>'Selecionadores'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925326828618296382)
,p_name=>'P13_COD_METRICA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>unistr('N\00CDVEL CONTRATA\00C7\00C3O')
,p_source=>'COD_METRICA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_METRICAS_PS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT m.cod_metrica||'' - ''||m.descricao det',
'      ,m.cod_metrica                     ret',
'  FROM ps_tipo_metricas m',
'ORDER BY LPAD(m.cod_metrica,5,0) '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925327287488296383)
,p_name=>'P13_COD_TIPO_PROCESSO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'TIPO PROCESSO'
,p_source=>'COD_TIPO_PROCESSO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_PROCESSOS_PS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(x.cod_tipo,5,''0'')||'' - ''||x.descricao det',
'      ,x.cod_tipo                                 ret',
'  FROM ps_tipo_processos x',
'ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925327676896296391)
,p_name=>'P13_USUARIO_PROG'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'USUARIO_PROG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925328012997296391)
,p_name=>'P13_DT_PROG'
,p_source_data_type=>'DATE'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'DT_PROG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925328387987296392)
,p_name=>'P13_EMP_GESTOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'EMPRESA'
,p_placeholder=>'-'
,p_source=>'EMP_GESTOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-building-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925328793621296392)
,p_name=>'P13_MAT_GESTOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'MAT_GESTOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925329209038296392)
,p_name=>'P13_EMP_AVALIADOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_prompt=>'EMPRESA'
,p_placeholder=>'-'
,p_source=>'EMP_AVALIADOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_tag_attributes=>'readonly'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(56619041527969256306)
,p_item_icon_css_classes=>'fa-building-o'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925329622171296393)
,p_name=>'P13_MAT_AVALIADOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(52898047725991220981)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'MAT_AVALIADOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925329999239296393)
,p_name=>'P13_TIPO_CONTRATO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'TIPO_CONTRATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52925330358644296393)
,p_name=>'P13_DT_PREV_FIM_CONTRATO'
,p_source_data_type=>'DATE'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_item_source_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_source=>'DT_PREV_FIM_CONTRATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52946475701243892567)
,p_name=>'P13_ERR_MSG'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(52956816422223623282)
,p_name=>'P13_ROWID_ADITIVO'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(52925314572766296250)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52898050559411221009)
,p_validation_name=>unistr('Valida M\00E9trica')
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P13_COD_METRICA IS NOT NULL THEN  ',
'    vMsg := pkg_Selecao.fnc_ValMetricaSelecionador(pcodMetrica      => :P13_COD_METRICA',
'                                                  ,pCodSelecionador => :P13_COD_PREST_SERV);',
'  END IF;                                                  ',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(52925345192287296452)
,p_associated_item=>wwv_flow_api.id(52925326828618296382)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52956816287492623281)
,p_validation_name=>'verificaAditivo'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  vMsg := pkg_Selecao.fnc_VerifAditivo_PS(pCodProcesso    => :P13_COD_PROCESSO',
'                                         ,pCodRequisicao  => :P13_COD_REQ',
'                                        ,pCodConsultoria  => :P13_COD_ENTIDADE);',
'  --',
'  RETURN(vMsg);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(52925321278627296373)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52957019518517394291)
,p_validation_name=>'ValidaDtIni'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P13_DT_INI_ENTIDADE IS NOT NULL AND :P13_DT_FIM_ENTIDADE IS NOT NULL THEN',
'    IF :P13_DT_INI_ENTIDADE > :P13_DT_FIM_ENTIDADE THEN',
unistr('      vReturn := ''DATA IN\00CDCIO maior que DATA FIM!'';'),
'    END IF;',
'  ELSIF :P13_DT_INI_ENTIDADE IS NULL AND :P13_DT_FIM_ENTIDADE IS NOT NULL THEN',
unistr('    vReturn := ''DATA IN\00CDCIO deve ser informada!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(52925321624783296373)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52957019819573394294)
,p_validation_name=>'ValidaDtFim'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P13_DT_FIM_ENTIDADE IS NOT NULL AND :P13_DT_INI_ENTIDADE IS NOT NULL THEN',
'    IF :P13_DT_FIM_ENTIDADE < :P13_DT_INI_ENTIDADE THEN',
unistr('      vReturn := ''DATA FIM  menor que DATA IN\00CDCIO!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(52925322118301296373)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(52957019987639394296)
,p_validation_name=>'VerificaOutrosDados'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P13_COD_ENTIDADE IS NULL AND ',
'    (:P13_DT_INI_ENTIDADE IS NOT NULL OR :P13_DT_FIM_ENTIDADE IS NOT NULL OR',
'     :P13_TAXA IS NOT NULL OR :P13_VALOR IS NOT NULL OR :P13_LOCAL IS NOT NULL) THEN',
'    vReturn      := ''Informe a CONSULTORIA ou exclua os outros dados relacionados!'';',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(52925321278627296373)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52925343302294296443)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52925343169972296443)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52925344075699296445)
,p_event_id=>wwv_flow_api.id(52925343302294296443)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52898049262164220996)
,p_name=>'AtribuiDadosReadonly'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52898049327216220997)
,p_event_id=>wwv_flow_api.id(52898049262164220996)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'BEGIN',
'  /*CASE',
'    WHEN :P13_STATUS = ''A'' THEN :P13_STATUS_TXT := ''A - Ativo'';',
'    WHEN :P13_STATUS = ''F'' THEN :P13_STATUS_TXT := ''F - Finalizado'';',
'    WHEN :P13_STATUS = ''C'' THEN :P13_STATUS_TXT := ''C - Cancelado'';',
'  ELSE ',
'    :P13_STATUS_TXT := NULL; ',
'  END CASE;*/',
'  null;',
'END;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52956819476858623313)
,p_name=>'HideShowAditivoROWID'
,p_event_sequence=>25
,p_condition_element=>'P13_ROWID_ADITIVO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956819554167623314)
,p_event_id=>wwv_flow_api.id(52956819476858623313)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050934339221013)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956819755839623316)
,p_event_id=>wwv_flow_api.id(52956819476858623313)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52956817878768623297)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956819648633623315)
,p_event_id=>wwv_flow_api.id(52956819476858623313)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52956817878768623297)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956819860983623317)
,p_event_id=>wwv_flow_api.id(52956819476858623313)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050934339221013)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52946477466733900529)
,p_name=>'DisparaAlerta'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P13_ERR_MSG'
,p_condition_element=>'P13_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52946477886688900534)
,p_event_id=>wwv_flow_api.id(52946477466733900529)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P13_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P13_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }',
'  ',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52946478303306903713)
,p_name=>'Inicia Alertify'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P13_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52946478717266903713)
,p_event_id=>wwv_flow_api.id(52946478303306903713)
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
 p_id=>wwv_flow_api.id(52898051095519221014)
,p_name=>'Insere Candidatos'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(52898050628748221010)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52946508747556180385)
,p_event_id=>wwv_flow_api.id(52898051095519221014)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'NOTIFICATION'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Aguarde!! Iniciando Processamento... '
,p_attribute_11=>'1000'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52898051133314221015)
,p_event_id=>wwv_flow_api.id(52898051095519221014)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cCand IS',
'    SELECT COUNT(1) FROM candidato c WHERE c.cod_processo = :P13_COD_PROCESSO;',
'  --',
'  vContA NUMBER DEFAULT 0;',
'  vContB NUMBER DEFAULT 0;',
'  vContC NUMBER DEFAULT 0;',
'BEGIN',
'  :P13_ERR_MSG := NULL;',
'  --',
'  OPEN cCand;',
'  FETCH cCand into vContA;',
'  CLOSE cCand;',
'  --',
'  IF :P13_COD_PROCESSO IS NOT NULL AND :P13_COD_PREST_SERV IS NOT NULL THEN',
'    pkg_Selecao.prc_InsCandidatosEscolhidos_PS(pCodProcesso     => :P13_COD_PROCESSO',
'                                              ,pCodSelecionador => :P13_COD_PREST_SERV',
'                                              ,pUser            => :APP_USER',
'                                              ,pMsg             => :P13_ERR_MSG);',
'  ELSE',
'    IF :P13_COD_PREST_SERV IS NULL THEN',
unistr('      :P13_ERR_MSG := ''O processo [<strong>''||:P13_COD_PROCESSO||''</strong>] n\00E3o possui um SELECIONADOR!<br>Inser\00E7\00E3o de candidato <strong>N\00E3o Permitida</strong>.'';'),
'    END IF;',
'  END IF;',
'  --',
'  IF :P13_ERR_MSG IS NULL THEN                                            ',
'    OPEN cCand;',
'    FETCH cCand INTO vContB;',
'    CLOSE cCand;',
'    --',
'    IF vContA <> vContB THEN',
'      vContC := vContB - vContA;',
'      --',
'      IF vContC > 0 THEN',
'        :P13_ERR_MSG := ''Processamento realizado com <strong>SUCESSO</strong>!<br><strong>Inserido(s) [''||vContc||''] candidato(s)</strong>'';',
'      END IF;',
'    END IF;',
'  END IF;',
'END;'))
,p_attribute_02=>'P13_COD_PROCESSO,P13_COD_PREST_SERV,P13_ERR_MSG'
,p_attribute_03=>'P13_ERR_MSG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52956815265430623271)
,p_name=>'Verifica BT Aditivo'
,p_event_sequence=>60
,p_condition_element=>'P13_COD_ENTIDADE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P13_ROWID_ADITIVO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956815422895623272)
,p_event_id=>wwv_flow_api.id(52956815265430623271)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050934339221013)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52956819169899623310)
,p_name=>'Verifica BT Aditivo AUX'
,p_event_sequence=>70
,p_condition_element=>'P13_COD_ENTIDADE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P13_ROWID_ADITIVO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52956819263075623311)
,p_event_id=>wwv_flow_api.id(52956819169899623310)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52956817878768623297)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52957017205519394268)
,p_name=>'HideAditivo'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P13_COD_ENTIDADE'
,p_condition_element=>'P13_COD_ENTIDADE'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'&P13_COD_ENTIDADE.'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957017300985394269)
,p_event_id=>wwv_flow_api.id(52957017205519394268)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050934339221013)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957017368918394270)
,p_event_id=>wwv_flow_api.id(52957017205519394268)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52956817878768623297)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52957017436978394271)
,p_name=>'Dialog Closed Aditivo'
,p_event_sequence=>90
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(52925342757435296442)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957017695870394273)
,p_event_id=>wwv_flow_api.id(52957017436978394271)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cAditivo IS',
'    SELECT e.ROWID',
'  FROM ps_proc_rec_entidade e ',
' WHERE e.cod_processo  = :P13_COD_PROCESSO ',
'   AND e.cod_entidade  = :P13_COD_ENTIDADE ',
'   AND e.tipo_entidade = ''5'' ',
'   AND e.cod_req       = :P13_COD_REQ;',
'  --',
'  vROWID ROWID DEFAULT NULL;',
'BEGIN',
'  OPEN cAditivo;',
'  FETCH cAditivo INTO vROWID;',
'  CLOSE cAditivo;',
'  --',
'  :P13_ROWID_ADITIVO := vROWID;',
'END;'))
,p_attribute_02=>'P13_COD_PROCESSO,P13_COD_ENTIDADE,P13_COD_REQ,P13_ROWID_ADITIVO'
,p_attribute_03=>'P13_ROWID_ADITIVO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957018217936394278)
,p_event_id=>wwv_flow_api.id(52957017436978394271)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(52957020084612394297)
,p_name=>'HideShow BT Candidato'
,p_event_sequence=>100
,p_condition_element=>'P13_COD_PREST_SERV'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P13_STATUS'
,p_display_when_cond2=>'A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957020158232394298)
,p_event_id=>wwv_flow_api.id(52957020084612394297)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050628748221010)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(52957020230780394299)
,p_event_id=>wwv_flow_api.id(52957020084612394297)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(52898050628748221010)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52925346400788296456)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(52925314572766296250)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Cadastro de Processo Seletivo'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42392755967306911994)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Salva Plataformas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 (v_nome varchar2) is',
'select r.id_nome ',
'  from PS_PROCESSO_SELETIVO_PLATAFORMAS r ',
' where r.cod_processo = :p13_cod_processo ',
'   and r.cod_empresa = :p13_cod_empresa ',
'   and r.id_nome = v_nome',
'order by 1;',
'',
'v_c1 c1%rowtype;',
'',
'v_id varchar2(4000);',
'',
'begin',
'',
' for l0 in (select /*+ cardinality (t 1)*/ column_value from table(apex_string.split(:P13_PLATAFORMAS , '','')) t)',
' loop',
' ',
'  BEGIN',
'  DELETE FROM PS_PROCESSO_SELETIVO_PLATAFORMAS P ',
'   WHERE COD_EMPRESA = :P13_COD_EMPRESA ',
'     AND COD_PROCESSO = :P13_COD_PROCESSO ',
'     AND ID_VAGA_RETORNO IS NULL;',
'  ',
'  END;',
' ',
'  v_c1 := null;',
'  open c1(l0.column_value);',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  if v_c1.id_nome is null then',
'     insert into PS_PROCESSO_SELETIVO_PLATAFORMAS (cod_empresa, cod_processo, id_nome, usuario, dt_atualizacao) values',
'       (:p13_cod_empresa, :p13_cod_processo, l0.column_value, :p_usuario, sysdate);',
'  end if;',
'',
' end loop;',
' ',
' COMMIT;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52925345192287296452)
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52925346819405296460)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52925345926448296455)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_api.id(52925314572766296250)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Cadastro de Processo Seletivo'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52956817776534623296)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atribui ROWID Aditivo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cAditivo IS',
'    SELECT e.ROWID',
'  FROM ps_proc_rec_entidade e ',
' WHERE e.cod_processo  = :P13_COD_PROCESSO ',
'   AND e.cod_entidade  = :P13_COD_ENTIDADE ',
'   AND e.tipo_entidade = ''5'' ',
'   AND e.cod_req       = :P13_COD_REQ;',
'  --',
'  vROWID ROWID DEFAULT NULL;',
'BEGIN',
'  OPEN cAditivo;',
'  FETCH cAditivo INTO vROWID;',
'  CLOSE cAditivo;',
'  --',
'  :P13_ROWID_ADITIVO := vROWID;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(42392756004603911995)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Plataformas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select r.id_nome ',
'  from PS_PROCESSO_SELETIVO_PLATAFORMAS r ',
' where r.cod_processo = :p13_cod_processo ',
'   and r.cod_empresa = :p13_cod_empresa ',
'order by 1;',
'',
'v_c1 c1%rowtype;',
'',
'v_id varchar2(4000);',
'',
'begin',
'',
'for l1 in c1',
'loop',
'',
' if v_id is null then ',
'   v_id := l1.id_nome;',
' else',
'   v_id := v_id||'':''||l1.id_nome;',
' end if;',
'',
'end loop;',
'',
':p13_plataformas := v_id;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(52935875030145427700)
,p_process_sequence=>60
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atualiza\00E7\00E3o Gen\00E9rica de Dados')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('-- Atualiza\00E7\00E3o Gen\00E9rica de Dados'),
'BEGIN',
'  :P13_USUARIO        := :APP_USER;',
'  :P13_DT_ATUALIZACAO := TO_CHAR(SYSDATE, ''DD/MM/RRRR HH24:MI:SS'');',
'  --',
'  IF :P13_COD_ENTIDADE IS NOT NULL THEN',
'    :P13_TIPO_ENTIDADE  := ''5'';',
'  ELSE',
'    :P13_TIPO_ENTIDADE  := NULL;',
'  END IF;',
'  --',
'  IF :P13_COD_PREST_SERV IS NOT NULL THEN',
'    :P13_TIPO_PREST_SERV := ''5'';',
'  ELSE',
'    :P13_TIPO_PREST_SERV := NULL;',
'  END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(52925345192287296452)
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
