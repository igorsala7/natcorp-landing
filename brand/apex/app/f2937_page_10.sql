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
--   Date and Time:   00:29 Saturday October 3, 2026
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
,p_user_interface_id=>wwv_flow_api.id(177921868572188886966)
,p_name=>unistr('Controle de Agendas M\00E9dicas')
,p_step_title=>unistr('Controle de Agendas M\00E9dicas')
,p_autocomplete_on_off=>'OFF'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DESENHO DA TELA (Natcorp_AgendaMedica.css / Natcorp_AgendaMedica.js)',
'',
unistr('Por cima do grid "Hor\00E1rios", uma AGENDA DO DIA para o m\00E9dico: o dia por extenso com anterior /'),
unistr('hoje / pr\00F3ximo, o profissional, a sala e a empresa (Alterar abre os filtros), o resumo do dia'),
unistr('(agendados, na cl\00EDnica, atendidos, livres), um hor\00E1rio por linha com o paciente, o tipo de consulta'),
unistr('e o pr\00F3ximo passo (Agendar, Marcar chegada, Concluir), e o painel do hor\00E1rio com s\00F3 as a\00E7\00F5es que'),
unistr('valem (as mesmas regras da fun\00E7\00E3o regra_negocio). Agendar/Editar usa a vista de um registro do grid.'),
'O grid continua sendo o motor: os dados, o salvar (com o processo "Bloqueia outras empresas") e as',
unistr('regras s\00E3o os de sempre; os bot\00F5es originais s\00E3o apertados pelo desenho. Atualiza sozinho a cada minuto.'),
'Para desligar tudo: tire as duas URLs de arquivo. Guia: brand/apex/app/AGENDAMEDICA-MANUTENCAO.md.'))
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_AgendaMedica.js'
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_AgendaMedica.css'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Used for global spinner',
'var spinnerContainer;',
'var buttonAction;',
'',
'function getRowid() {',
'  var view   = apex.region("horarios").widget().interactiveGrid("getViews", "grid"),',
'      selectedRecords = view.getSelectedRecords();',
'',
'  if (selectedRecords && selectedRecords.length) {',
'    var model  = view.model,',
'        record = selectedRecords[0];',
'',
'    return getColumnValue(model, record, "ROWID");',
'  }',
'  return undefined;',
'}',
'',
'function setDadosConsulta() {',
'  var view   = apex.region("horarios").widget().interactiveGrid("getViews", "grid"),',
'      selectedRecords = view.getSelectedRecords();',
'  ',
'  if (selectedRecords && selectedRecords.length) {',
'    var model  = view.model,',
'        record = selectedRecords[0];',
'',
'    var tipo_paciente = getColumnValue(model, record, "TIPO_PACIENTE"),',
'        cod_paciente  = getColumnValue(model, record, "COD_PACIENTE"),',
'        tipo_consulta = getColumnValue(model, record, "TIPO_CONSULTA"),',
'        cod_req       = getColumnValue(model, record, "COD_REQ");',
'',
'    apex.item("P10_TIPO_PACIENTE").setValue(tipo_paciente || "");',
'    apex.item("P10_COD_PACIENTE").setValue(cod_paciente || "");',
'    apex.item("P10_TIPO_CONSULTA").setValue(tipo_consulta || "");',
'    apex.item("P10_COD_REQ").setValue(cod_req || "");',
'  } else {',
'    apex.item("P10_TIPO_PACIENTE").setValue("");',
'    apex.item("P10_COD_PACIENTE").setValue("");',
'    apex.item("P10_TIPO_CONSULTA").setValue("");',
'    apex.item("P10_COD_REQ").setValue("");',
'  }',
'}',
'',
'function regra_negocio(pData) {',
'  if (pData && pData.selectedRecords && pData.selectedRecords.length) {',
'    var model  = pData.model,',
'        record = pData.selectedRecords[0];',
'',
'    var bloqueado     = getColumnValue(model, record, "BLOQUEADO"),',
'        compareceu    = getColumnValue(model, record, "COMPARECEU"),',
'        realizou      = getColumnValue(model, record, "REALIZOU"),',
'        tipo_paciente = getColumnValue(model, record, "TIPO_PACIENTE"),',
'        cod_paciente  = getColumnValue(model, record, "COD_PACIENTE"),',
'        tipo_consulta = getColumnValue(model, record, "COD_TIPO_CONSULTA"),',
'        cod_req       = getColumnValue(model, record, "COD_REQ");',
'        senha         = getColumnValue(model, record, "SENHA"),',
'        rowid         = getColumnValue(model, record, "ROWID");',
'        classifASO    = getColumnValue(model, record, "CLASSIFASO");',
'',
'    // Update values on items',
'    apex.item("P10_TIPO_PACIENTE").setValue(tipo_paciente);',
'    apex.item("P10_COD_PACIENTE").setValue(cod_paciente);',
'    apex.item("P10_TIPO_CONSULTA").setValue(tipo_consulta);',
'    apex.item("P10_COD_REQ").setValue(cod_req);',
'    apex.item("P10_P_SENHA").setValue(senha);',
'    apex.item("P10_ROWID").setValue(rowid);',
'    ',
'    if (bloqueado === "S") {',
'      apex_disable("#COMPARECEU,#REALIZOU,#TIPO_PACIENTE,#COD_PACIENTE,#COD_TIPO_CONSULTA,#OBSERVACAO")',
'      disable_all_buttons()',
'      // Apply style "bloqueado"',
'    } else {',
'      apex_enable("#COMPARECEU,#REALIZOU,#TIPO_PACIENTE,#COD_PACIENTE,#COD_TIPO_CONSULTA,#OBSERVACAO")',
'      // Apply style "padrao"',
'      if (!cod_paciente) {',
'        apex_disable("#COMPARECEU,#REALIZOU")',
'        //disable_all_buttons()',
'        apex.item("DESMARCAR").disable()',
'        apex.item("TRANSFERIR").disable()',
'        apex.item("DADOS_FUNCIONARIO").disable()',
'        apex.item("CONSULTA_MEDICA").disable()',
'        apex.item("DADOS_CANDIDATO").disable()',
'        apex.item("AVALIACAO_MEDICA").disable()',
'        apex.item("ASO").disable()',
'        apex.item("CHAMAR_PACIENTE").disable()',
'        apex.item("CMO").disable()  ',
'      } else {',
'        apex_enable("#COMPARECEU")',
'        apex_disable("#REALIZOU")',
'        ',
'        if (senha.length > 0 ){',
'        apex.item("CHAMAR_PACIENTE").enable()',
'        }',
'        ',
'        apex.item("AVALIACAO_MEDICA").enable()',
'        apex.item("ASO").enable()',
'',
'        if (compareceu === ''N'') {',
'          apex_disable("#REALIZOU")',
'          apex.item("TRANSFERIR").enable()',
'          apex.item("DESMARCAR").enable()',
'          // Apply style "marcado"',
'        } else {',
'          apex_disable("#TIPO_PACIENTE,#COD_PACIENTE")',
'          apex_enable("#REALIZOU")',
'          apex.item("TRANSFERIR").disable()',
'          apex.item("DESMARCAR").disable()',
'          // Apply style "chegou"',
'          if (realizou === "S") {',
'            apex_disable("#BLOQUEADO,#COMPARECEU")',
'            // Apply style "realizado"',
'          }',
'        }',
'        if (tipo_paciente === "1") {',
'          apex.item("DADOS_FUNCIONARIO").enable()',
'          apex.item("CONSULTA_MEDICA").enable()',
'          apex.item("DADOS_CANDIDATO").disable()',
'          if (classifASO === "0") {',
'            apex.item("CMO").disable()',
'          } else {',
'            apex.item("CMO").enable()   ',
'          } ',
'        } else {',
'          apex.item("DADOS_FUNCIONARIO").disable()',
'          apex.item("CONSULTA_MEDICA").disable()',
'          apex.item("DADOS_CANDIDATO").enable()',
'          apex.item("CMO").disable()  ',
'        }',
'      }',
'    }',
'',
'  } else {',
'    disable_all_buttons()',
'  }',
'}',
'/* var view   = apex.region("horarios").widget().interactiveGrid("getViews", "grid"),',
'    model  = view.model,',
'    id     = model.getRecordId(view.getSelectedRecords()[0]),',
'    meta   = model.getRecordMetadata(id),',
'    fields = meta.fields',
'meta.highlight = "bloqueado"',
'//Object.keys(fields).forEach(function(col) {',
'//  fields[col].highlight = "bloqueado"',
'//});',
unistr('fields.HORA_INIC_PREVISTO.highlight = "bloqueado" // Necess\00E1rio pois n\00E3o respeita estilo por ser readonly'),
unistr('fields.HORA_FIM_PREVISTO.highlight = "bloqueado" // Necess\00E1rio pois n\00E3o respeita estilo por ser readonly'),
'//view.view$.grid("getSelection")[0][0].classList.remove("is-selected")',
'view.view$.grid("refresh")',
'*/',
'  ',
'function fixT000xBug(value) {',
'  return (value || "").replace(/t[0-9]{4}/g, "")',
'}',
'',
'function getCurrentValue(column) {',
'  var view   = getIGWidget().interactiveGrid("getViews", "grid"),',
'      model  = view.model,',
'      record = view.getSelectedRecords() && view.getSelectedRecords().length && view.getSelectedRecords()[0]',
'',
'  return getColumnValue(model, record, column);',
'}',
'  ',
'function getColumnValue(model, record, column) {',
'  var value = model.getValue(record, column)',
'',
'  if (typeof value === "object") // Get return value if LOV',
'    value = value.v',
'',
'  return fixT000xBug(value)',
'}',
'  ',
'function getTextColumns() {',
'  return ["HORA_INIC_PREVISTO",',
'          "HORA_FIM_PREVISTO",',
'          "TIPO_PACIENTE",',
'          "COD_PACIENTE",',
'          "COD_TIPO_CONSULTA",',
'          "OBSERVACAO",',
'          "COD_REQ"];',
'}',
'  ',
'function focus_handler(evt) {',
'  return false;',
'}',
'  ',
'function apex_disable(obj) {',
'  $(obj).each(function(){',
'    let $obj = $(this);',
'',
'    if ($obj.hasClass(''apex-item-popup-lov''))',
'      $obj = $obj.closest(''fieldset'');',
'',
'    $obj.addClass(''apex_disabled'')',
'        .attr(''tabindex'', ''-1'')',
'        .css(''pointer-events'', ''none'')',
'        .attr(''autocomplete'', ''off'')',
'        .css(''opacity'', ''.7'')',
'        .on(''keydown'', focus_handler)',
'        .find(''.a-Button--popupLOV,.a-Button--calendar'').hide()',
'    ;',
'',
'    // Remove date picker',
'    $obj.parent().find(''.a-Button--calendar'').hide()',
'  });',
'}',
'  ',
'function apex_enable(obj) {',
'  $(obj).each(function(){',
'    let $obj = $(this);',
'',
'    if ($obj.hasClass(''apex-item-popup-lov''))',
'      $obj = $obj.closest(''fieldset'');',
'',
'    $obj.removeClass(''apex_disabled'')',
'        .removeAttr(''tabindex'')',
'        .css(''pointer-events'', '''')',
'        //.attr(''autocomplete'', ''off'')',
'        .css(''opacity'', ''1'')',
'        .off(''keydown'', focus_handler)',
'        .find(''.a-Button--popupLOV,.a-Button--calendar'').show();',
'',
'    // Remove date picker',
'    $obj.parent().find(''.a-Button--calendar'').show()',
'  });',
'}',
'',
'function disable_all_buttons() {',
'  apex.item("AVALIACAO_MEDICA").disable()',
'  apex.item("DADOS_FUNCIONARIO").disable()',
'  apex.item("DADOS_CANDIDATO").disable()',
'  apex.item("CONSULTA_MEDICA").disable()',
'  apex.item("ASO").disable()',
'  apex.item("TRANSFERIR").disable()',
'  apex.item("DESMARCAR").disable()',
'  apex.item("CHAMAR_PACIENTE").disable()',
'  apex.item("CMO").disable()  ',
'}',
'',
'//function transformArrayIntoIDSelector(arr) {',
'//  return arr.map(function(id) {',
'//    return "#" + id',
'//  }).join(",");',
'//}',
'',
'function showSpinner() {',
'  var spinner = apex.util.showSpinner(),',
'      modal   = $(''<div class="ui-widget-overlay ui-front" style="z-index: 900;"></div>'')',
'',
'  $("body").append(modal)',
'',
'  return {spinner: spinner, modal: modal}',
'}',
'',
'function removeSpinner(spinnerContainer) {',
'  spinnerContainer && spinnerContainer.modal && spinnerContainer.modal.remove();',
'  spinnerContainer && spinnerContainer.spinner && spinnerContainer.spinner.remove();',
'}',
'',
'function getIGWidget() {',
'  return apex.region("horarios").widget()',
'}',
'',
'function buttonActionClick() {',
'  var IG      = getIGWidget(),',
'      view    = IG.interactiveGrid("getViews", "grid"),',
'      actions = IG.interactiveGrid("getActions");',
'',
'  if (view.model.isChanged()) {',
'    spinnerContainer = showSpinner()',
'    actions.invoke("save");',
'  } else {',
'    if (typeof buttonAction === ''function'') {',
'      buttonAction()',
'      buttonAction = function() {}',
'    }',
'  }',
'}',
'',
'function desmarcarConsulta() {',
'  var IG              = getIGWidget(),',
'      view            = IG.interactiveGrid("getViews", "grid"),',
'      selectedRecords = view.getSelectedRecords();',
'  ',
'  if (selectedRecords && selectedRecords.length) {',
'    var model   = view.model,',
'        record  = selectedRecords[0],',
'        columns = Object.keys(view.modelColumns);',
'',
'    columns.forEach(function(column) {',
'      if (view.modelColumns[column].readonly || column === "_meta" || column === "ATENDE_AREA_SELECAO") {',
'        // does nothing',
'      } else {',
'        if (/^(BLOQUEADO|COMPARECEU|REALIZOU)$/.test(column)) {',
'          model.setValue(record, column, "N");',
'        } else {',
'          model.setValue(record, column, "");',
'        }',
'      }',
'    })',
'  }',
'}',
'',
'',
'',
'',
'',
'',
'',
'var botao = $(''#bt-refresh'');',
'var infoTempo = $(''#info-tempo'');',
'var tempo = 0;',
'var intervalo;',
'',
'function formatarTempo(segundos) {',
'  var h = String(Math.floor(segundos / 3600)).padStart(2, ''0'');',
'  var m = String(Math.floor((segundos % 3600) / 60)).padStart(2, ''0'');',
'  var s = String(segundos % 60).padStart(2, ''0'');',
'  return h + '':'' + m + '':'' + s;',
'}',
'',
'function resetarTudo() {',
'  botao.removeClass(''bt-verde bt-vermelho'').addClass(''bt-cinza'');',
'  botao.text(''Clique aqui para atualizar'');',
'  infoTempo.hide();',
'  tempo = 0;',
'}',
'',
'function iniciarContador() {',
'  resetarTudo();',
'',
'  intervalo = setInterval(function() {',
'    tempo++;',
'',
unistr('    if (tempo >= 600) { // Mostra mensagem ap\00F3s 10 minutos'),
'      infoTempo.show();',
unistr('      infoTempo.text(''A agenda n\00E3o foi atualizada nos \00FAltimos '' + formatarTempo(tempo) + ''. Clique abaixo para atualizar os dados.'');'),
'    }',
'',
'  }, 1000);',
'',
unistr('  // Ap\00F3s 10 minutos (600 segundos) fica verde'),
'  setTimeout(function() {',
'    botao.removeClass(''bt-cinza bt-vermelho'').addClass(''bt-verde'');',
'  }, 600 * 1000);',
'',
unistr('  // Ap\00F3s 15 minutos (900 segundos) fica vermelho'),
'  setTimeout(function() {',
'    botao.removeClass(''bt-cinza bt-verde'').addClass(''bt-vermelho'');',
'  }, 900 * 1000);',
'}',
'',
'iniciarContador();',
'',
unistr('// Ao clicar no bot\00E3o'),
'botao.on(''click'', function() {',
'  clearInterval(intervalo);',
'  apex.submit(''REFRESH'');',
'});',
'',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Corrige Bug para Popup Lov */',
'.lov {',
'  width: 100% !important;',
'}',
'',
'.bloqueado {',
'  font-weight: bold;',
'  /*background-color: rgba(255, 0, 0, .4) !important;*/',
'  color: #F00 !important;',
'}',
'',
unistr('/* Cores do bot\00E3o */'),
'.bt-cinza {',
'  background-color: #e0e0e0 !important;',
'  color: black !important;',
'}',
'',
'.bt-verde {',
'  background-color: #4CAF50 !important;',
'  color: white !important;',
'}',
'',
'.bt-vermelho {',
'  background-color: #F44336 !important;',
'  color: white !important;',
'}',
'#info-tempo {',
'  display: none;',
'  margin-top: 10px;',
'  font-weight: bold;',
'}',
unistr('/* Centralizar o bot\00E3o */'),
'#bt-refresh {',
'  display: block;',
'  margin: 0 auto;',
'  padding: 12px 24px;',
'  font-size: 1.1rem;',
'  font-weight: bold;',
'  border-radius: 8px;',
'}',
'',
'/* Estilo da mensagem abaixo */',
'.mensagem-tempo {',
'  display: none;',
'  margin-top: 20px;',
'  margin-bottom: 20px;',
'  padding: 15px 25px;',
'  background-color: #fff8dc; /* amarelo bem clarinho */',
'  color: #333;',
'  font-size: 1.1rem;',
'  font-weight: 600;',
'  border-radius: 8px;',
'  box-shadow: 0px 2px 8px rgba(0,0,0,0.15);',
'  text-align: center;',
'  max-width: 400px;',
'  margin-left: auto;',
'  margin-right: auto;',
'  transition: all 0.5s ease;',
'}',
'',
'',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'FERNANDO.SANTOS'
,p_last_upd_yyyymmddhh24miss=>'20260827170048'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166657643728054094063)
,p_plug_name=>'Agenda'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166664365570616913442)
,p_plug_name=>unistr('Hor\00E1rios')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166663326712191319117)
,p_plug_name=>'Grid'
,p_region_name=>'horarios'
,p_parent_plug_id=>wwv_flow_api.id(166664365570616913442)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_item_display_point=>'BELOW'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ROWID,',
'       COD_EMPRESA,',
'       COD_PRESTR_SERV,',
'       TIPO_PREST_SERV,',
'       DATA_AGENDA,',
'       HORA_INIC_PREVISTO,',
'       HORA_FIM_PREVISTO,',
'       TIPO_PACIENTE,',
'       COD_PACIENTE,',
'       HORA_INICIO_CONSULTA,',
'       HORA_FIM_CONSULTA,',
'       COD_TIPO_CONSULTA,',
'       COMPARECEU,',
'       REALIZOU,',
'       DT_ATUALIZACAO,',
'       USUARIO,',
'       OBSERVACAO,',
'       BLOQUEADO,',
'       COD_EMPRESA_ENC_MED,',
'       COD_PRESTR_SERV_ENC_MED,',
'       TIPO_PREST_SERV_ENC_MED,',
'       DATA_AGENDA_ENC_MED,',
'       HORA_INIC_PREVISTO_ENC_MED,',
'       ATENDE_AREA_SELECAO,',
'       HORA_CHEGADA,',
'       LOCAL_ENTREVISTA,',
'       SENHA',
'      ,(SELECT COUNT(1)',
'        FROM tipo_consulta t',
'       WHERE t.cod_tipo_consulta = AGENDAS_MEDICOS_HORARIOS.COD_TIPO_CONSULTA',
'         AND t.classificacao_aso IN(''P'',''D'',''M'',''R'')) ClassifASO, ',
'/*         ',
'       (SELECT TO_CHAR(PA.DT_HORARIO_REALIZADO,''DD/MM/YYYY HH24:MI:SS'') FROM PRE_ATENDIMENTO PA WHERE PA.COD_EMPRESA = AGENDAS_MEDICOS_HORARIOS.COD_EMPRESA AND PA.COD_PACIENTE = AGENDAS_MEDICOS_HORARIOS.COD_PACIENTE AND PA.TIPO_PACIENTE = AGENDAS_MED'
||'ICOS_HORARIOS.TIPO_PACIENTE AND PA.DATA_AGENDA = AGENDAS_MEDICOS_HORARIOS.DATA_AGENDA) Pre_Atendimento',
'       ,(SELECT PA.ROWID FROM PRE_ATENDIMENTO PA WHERE PA.COD_EMPRESA = AGENDAS_MEDICOS_HORARIOS.COD_EMPRESA AND PA.COD_PACIENTE = AGENDAS_MEDICOS_HORARIOS.COD_PACIENTE AND PA.TIPO_PACIENTE = AGENDAS_MEDICOS_HORARIOS.TIPO_PACIENTE AND PA.DATA_AGENDA '
||'= AGENDAS_MEDICOS_HORARIOS.DATA_AGENDA) ROWID_PRE_ATENDIMENTO',
'*/',
'(SELECT TO_CHAR(PA.DT_HORARIO_REALIZADO,''DD/MM/YYYY HH24:MI:SS'') FROM PRE_ATENDIMENTO PA WHERE PA.DT_ATUALIZACAO = (SELECT MAX(X.DT_ATUALIZACAO) DT_ATUALIZACAO',
'                         FROM   PRE_ATENDIMENTO X',
'                         WHERE  PA.COD_EMPRESA = X.COD_EMPRESA',
'                         AND    PA.COD_PACIENTE = X.COD_PACIENTE',
'                         AND    PA.TIPO_PACIENTE = X.TIPO_PACIENTE',
'                         AND    PA.DATA_AGENDA = X.DATA_AGENDA)',
'   AND PA.COD_EMPRESA = AGENDAS_MEDICOS_HORARIOS.COD_EMPRESA AND PA.COD_PACIENTE = AGENDAS_MEDICOS_HORARIOS.COD_PACIENTE AND PA.TIPO_PACIENTE = AGENDAS_MEDICOS_HORARIOS.TIPO_PACIENTE AND PA.DATA_AGENDA = AGENDAS_MEDICOS_HORARIOS.DATA_AGENDA) Pre_Aten'
||'dimento',
'       ,(SELECT PA.ROWID FROM PRE_ATENDIMENTO PA WHERE PA.DT_ATUALIZACAO = (SELECT MAX(X.DT_ATUALIZACAO) DT_ATUALIZACAO',
'                         FROM   PRE_ATENDIMENTO X',
'                         WHERE  PA.COD_EMPRESA = X.COD_EMPRESA',
'                         AND    PA.COD_PACIENTE = X.COD_PACIENTE',
'                         AND    PA.TIPO_PACIENTE = X.TIPO_PACIENTE',
'                         AND    PA.DATA_AGENDA = X.DATA_AGENDA)',
'   AND PA.COD_EMPRESA = AGENDAS_MEDICOS_HORARIOS.COD_EMPRESA AND PA.COD_PACIENTE = AGENDAS_MEDICOS_HORARIOS.COD_PACIENTE AND PA.TIPO_PACIENTE = AGENDAS_MEDICOS_HORARIOS.TIPO_PACIENTE AND PA.DATA_AGENDA = AGENDAS_MEDICOS_HORARIOS.DATA_AGENDA) ROWID_PR'
||'E_ATENDIMENTO',
',COD_REQ',
'  from AGENDAS_MEDICOS_HORARIOS',
' where COD_EMPRESA     = :P10_COD_EMPRESA',
'   and COD_PRESTR_SERV = :P10_COD_PRESTR_SERV',
'   and TIPO_PREST_SERV = 1',
'   and DATA_AGENDA     = to_date(:P10_DATA_AGENDA, ''DD/MM/YYYY'')'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P10_COD_EMPRESA,P10_COD_PRESTR_SERV,P10_DATA_AGENDA'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
''))
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(102965016850217584379)
,p_name=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_REQ'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cod Req'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>330
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(161320258841616356206)
,p_name=>'PRE_ATENDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PRE_ATENDIMENTO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_LINK'
,p_heading=>unistr('Pr\00E9-Atendimento')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>310
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:74:&SESSION.::&DEBUG.:RP:P74_ROWID:&ROWID_PRE_ATENDIMENTO.'
,p_link_text=>'&PRE_ATENDIMENTO.'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>false
,p_is_primary_key=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
,p_help_text=>unistr('Clique para visualizar o dados do Pr\00E9-Atendimento')
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(161320258934038356207)
,p_name=>'ROWID_PRE_ATENDIMENTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID_PRE_ATENDIMENTO'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>320
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_column_comment=>' '
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(164812188809703294212)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(164815950254800548743)
,p_name=>'CLASSIFASO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CLASSIFASO'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>300
,p_attribute_01=>'N'
,p_static_id=>'CLASSIFASO'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663327943724319120)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663328360902319121)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_enable_hide=>true
,p_display_condition_type=>'NEVER'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663329632550319127)
,p_name=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663330235692319128)
,p_name=>'COD_PRESTR_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PRESTR_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663330804509319128)
,p_name=>'TIPO_PREST_SERV'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663331406808319129)
,p_name=>'DATA_AGENDA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATA_AGENDA'
,p_data_type=>'DATE'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>70
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663332014305319129)
,p_name=>'HORA_INIC_PREVISTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INIC_PREVISTO'
,p_data_type=>'DATE'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>unistr('In\00EDcio')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_format_mask=>'hh24:mi'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663332569507319130)
,p_name=>'HORA_FIM_PREVISTO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_FIM_PREVISTO'
,p_data_type=>'DATE'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Fim'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_02=>'VALUE'
,p_format_mask=>'hh24:mi'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663333242378319131)
,p_name=>'TIPO_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PACIENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo de Paciente'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166664098809965610459)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_static_id=>'TIPO_PACIENTE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663333794073319131)
,p_name=>'COD_PACIENTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PACIENTE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Paciente'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select p.matricula || '' - '' || p.nome as d,',
'       p.matricula                    as r',
'  from inf_pessoais p,',
'       informacoes_funcionais f',
' where f.cod_empresa  = p.cod_empresa',
'   and f.matricula    = p.matricula',
'   and p.cod_empresa  = :P10_COD_EMPRESA',
'   and :TIPO_PACIENTE = 1',
'   and (f.situacao < ''90'' or :COD_PACIENTE = p.matricula)',
' union all',
'select cod_candidato || '' - '' || nome as d,',
'       cod_candidato                  as r',
'  from inf_pessoais_candidato',
' where empresa          = :P10_COD_EMPRESA',
'   and :TIPO_PACIENTE   = 2',
'   and (status_candidato = ''P'' or :COD_PACIENTE = cod_candidato)',
' order by 1'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'TIPO_PACIENTE'
,p_ajax_items_to_submit=>'P10_COD_EMPRESA'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_static_id=>'COD_PACIENTE'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663334429578319132)
,p_name=>'HORA_INICIO_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INICIO_CONSULTA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Hora Inicio Consulta'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663334970640319132)
,p_name=>'HORA_FIM_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_FIM_CONSULTA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Hora Fim Consulta'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663335562157319134)
,p_name=>'COD_TIPO_CONSULTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_TIPO_CONSULTA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Tipo de Consulta'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_api.id(166664142566967702592)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'- Selecione -'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_static_id=>'COD_TIPO_CONSULTA'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663336181958319134)
,p_name=>'COMPARECEU'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMPARECEU'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_CA.TREVIS.APEX.IG_SIMPLE_CHECKBOX'
,p_heading=>'Chegou?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_01=>'S'
,p_attribute_02=>'N'
,p_is_required=>true
,p_filter_is_required=>false
,p_static_id=>'COMPARECEU'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663336824313319135)
,p_name=>'REALIZOU'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REALIZOU'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_CA.TREVIS.APEX.IG_SIMPLE_CHECKBOX'
,p_heading=>'Realizado?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_attribute_01=>'S'
,p_attribute_02=>'N'
,p_is_required=>true
,p_filter_is_required=>false
,p_static_id=>'REALIZOU'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
end;
/
begin
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663337374363319136)
,p_name=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DT_ATUALIZACAO'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663337996631319136)
,p_name=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USUARIO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>210
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663338639163319137)
,p_name=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OBSERVACAO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>unistr('Observa\00E7\00E3o')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>500
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_static_id=>'OBSERVACAO'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663339194074319137)
,p_name=>'BLOQUEADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'BLOQUEADO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_CA.TREVIS.APEX.IG_SIMPLE_CHECKBOX'
,p_heading=>'Bloqueado?'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_attribute_01=>'S'
,p_attribute_02=>'N'
,p_is_required=>true
,p_filter_is_required=>false
,p_static_id=>'BLOQUEADO'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663339839062319138)
,p_name=>'COD_EMPRESA_ENC_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_EMPRESA_ENC_MED'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Cod Empresa Enc Med'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>220
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663340378980319138)
,p_name=>'COD_PRESTR_SERV_ENC_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COD_PRESTR_SERV_ENC_MED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Cod Prestr Serv Enc Med'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>230
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>5
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663341046268319139)
,p_name=>'TIPO_PREST_SERV_ENC_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO_PREST_SERV_ENC_MED'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Tipo Prest Serv Enc Med'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>240
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663341656500319139)
,p_name=>'DATA_AGENDA_ENC_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATA_AGENDA_ENC_MED'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Data Agenda Enc Med'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663342233837319140)
,p_name=>'HORA_INIC_PREVISTO_ENC_MED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_INIC_PREVISTO_ENC_MED'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Hora Inic Previsto Enc Med'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663342837866319140)
,p_name=>'ATENDE_AREA_SELECAO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATENDE_AREA_SELECAO'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_CA.TREVIS.APEX.IG_SIMPLE_CHECKBOX'
,p_heading=>unistr('Sele\00E7\00E3o?')
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_attribute_01=>'S'
,p_attribute_02=>'N'
,p_is_required=>false
,p_filter_is_required=>false
,p_static_id=>'ATENDE_AREA_SELECAO'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663343432009319140)
,p_name=>'HORA_CHEGADA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'HORA_CHEGADA'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER'
,p_heading=>'Hora Chegada'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'CENTER'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166663343998139319141)
,p_name=>'LOCAL_ENTREVISTA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LOCAL_ENTREVISTA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Local Entrevista'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>280
,p_value_alignment=>'LEFT'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>500
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(166820597019577223956)
,p_name=>'SENHA'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SENHA'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Senha'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>290
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(166663327172890319118)
,p_internal_uid=>642476013262064299
,p_is_editable=>true
,p_edit_operations=>'u'
,p_update_authorization_scheme=>wwv_flow_api.id(161347559704688747727)
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:SEARCH_COLUMN:SEARCH_FIELD:ACTIONS_MENU:RESET:SAVE'
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(166663327645490319118)
,p_interactive_grid_id=>wwv_flow_api.id(166663327172890319118)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(166663327671520319119)
,p_report_id=>wwv_flow_api.id(166663327645490319118)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(102969511136877782982)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>31
,p_column_id=>wwv_flow_api.id(102965016850217584379)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(161360518606782734113)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>29
,p_column_id=>wwv_flow_api.id(161320258841616356206)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(161360655401220995849)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>30
,p_column_id=>wwv_flow_api.id(161320258934038356207)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(164812387778678173935)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>27
,p_column_id=>wwv_flow_api.id(164812188809703294212)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(164816251118450971630)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>28
,p_column_id=>wwv_flow_api.id(164815950254800548743)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663328822532319125)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(166663328360902319121)
,p_is_visible=>false
,p_is_frozen=>true
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663330053447319128)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(166663329632550319127)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663330577134319128)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(166663330235692319128)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663331240757319129)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(166663330804509319128)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663331854359319129)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166663331406808319129)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663332372401319130)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(166663332014305319129)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>77
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'FIRST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663333039498319130)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(166663332569507319130)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>76
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663333613114319131)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>11
,p_column_id=>wwv_flow_api.id(166663333242378319131)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>120
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663334228851319131)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>12
,p_column_id=>wwv_flow_api.id(166663333794073319131)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663334820096319132)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>15
,p_column_id=>wwv_flow_api.id(166663334429578319132)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663335395182319134)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>16
,p_column_id=>wwv_flow_api.id(166663334970640319132)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663336020345319134)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>13
,p_column_id=>wwv_flow_api.id(166663335562157319134)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>150
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663336611348319135)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(166663336181958319134)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663337162807319135)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(166663336824313319135)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663337824878319136)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>17
,p_column_id=>wwv_flow_api.id(166663337374363319136)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663338456110319136)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>18
,p_column_id=>wwv_flow_api.id(166663337996631319136)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663339017604319137)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>14
,p_column_id=>wwv_flow_api.id(166663338639163319137)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663339580746319138)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(166663339194074319137)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>85
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663340241086319138)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>19
,p_column_id=>wwv_flow_api.id(166663339839062319138)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663340838242319138)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>20
,p_column_id=>wwv_flow_api.id(166663340378980319138)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663341420927319139)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>21
,p_column_id=>wwv_flow_api.id(166663341046268319139)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663341968671319139)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>22
,p_column_id=>wwv_flow_api.id(166663341656500319139)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663342647918319140)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>23
,p_column_id=>wwv_flow_api.id(166663342233837319140)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663343226348319140)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(166663342837866319140)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663343842552319141)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>24
,p_column_id=>wwv_flow_api.id(166663343432009319140)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166663344438147319141)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>25
,p_column_id=>wwv_flow_api.id(166663343998139319141)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(166821771565604137474)
,p_view_id=>wwv_flow_api.id(166663327671520319119)
,p_display_seq=>26
,p_column_id=>wwv_flow_api.id(166820597019577223956)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166664365466928913441)
,p_plug_name=>'Actions'
,p_parent_plug_id=>wwv_flow_api.id(166664365570616913442)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(177921842575350886872)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="info-tempo" class="mensagem-tempo"></div>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(166820597068481223957)
,p_plug_name=>'Chamar Paciente'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--xlarge:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(177921841144671886869)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_04'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(121698867587692929304)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'BT_ATUALIZAR'
,p_button_static_id=>'bt-refresh'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atualizar'
,p_button_position=>'BODY'
,p_button_css_classes=>'bt-cinza'
,p_button_cattributes=>'style =''margin-bottom:20px;'''
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664365687481913443)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'AVALIACAO_MEDICA'
,p_button_static_id=>'AVALIACAO_MEDICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Avalia\00E7\00E3o M\00E9dica')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664365806463913444)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'DADOS_FUNCIONARIO'
,p_button_static_id=>'DADOS_FUNCIONARIO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Dados Funcion\00E1rio')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664365890139913445)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'DADOS_CANDIDATO'
,p_button_static_id=>'DADOS_CANDIDATO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Dados Candidato'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664365992081913446)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'CONSULTA_MEDICA'
,p_button_static_id=>'CONSULTA_MEDICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Consulta M\00E9dica')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664366121176913447)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'ASO'
,p_button_static_id=>'ASO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'ASO'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664366200159913448)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'TRANSFERIR'
,p_button_static_id=>'TRANSFERIR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Transferir / Remarcar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664366358972913449)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'DESMARCAR'
,p_button_static_id=>'DESMARCAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Desmarcar / Cancelar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664366399934913450)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'RELATORIO'
,p_button_static_id=>'RELATORIO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Relat\00F3rio')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166664366499447913451)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'CONSULTA_MATRICULA'
,p_button_static_id=>'CONSULTA_MATRICULA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Consulta por Matr\00EDcula')
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:26:&SESSION.::&DEBUG.:RP::'
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166820596883308223955)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'CHAMAR_PACIENTE'
,p_button_static_id=>'CHAMAR_PACIENTE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>'Chamar Paciente'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(164807976960798215508)
,p_button_sequence=>120
,p_button_plug_id=>wwv_flow_api.id(166664365466928913441)
,p_button_name=>'CMO'
,p_button_static_id=>'CMO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(177921863366948886916)
,p_button_image_alt=>unistr('Consulta M\00E9d. Ocupacional')
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(166820598232810223968)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_button_name=>'BTN_CHAMAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(177921863540668886916)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Chamar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(102965016916367584380)
,p_name=>'P10_COD_REQ'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(164807977831986215517)
,p_name=>'P10_CMO_BUTTON'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(164807978925323215528)
,p_name=>'P10_CMO_ROWID'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(164807980451440215543)
,p_name=>'P10_AGD_ROWID'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(165320556423340696607)
,p_name=>'P10_SALA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_prompt=>'Sala'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166657643786364094064)
,p_name=>'P10_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'LOV_EMPRESA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT emp.cod || '' - '' || emp.nome as dsp,',
'       emp.cod as ret',
'  FROM empresas emp',
' ORDER BY emp.cod'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166657643901315094065)
,p_name=>'P10_COD_PRESTR_SERV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_prompt=>'Profissional'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT P.cod_prest_serv || '' - '' || P.nome AS d, ',
'       P.cod_prest_serv AS r ',
'  FROM USUARIO_ORACLE UO ',
'      ,PRESTADOR_SERVICO P ',
' WHERE P.tipo_prest_serv = ''1'' ',
'   AND P.MAT_PRESTADOR = UO.CD_MATRICULA ',
'   AND P.COD_EMPRESA_ENDERECO = UO.CD_EMPRESA ',
'   AND UO.NM_USUARIO_ORACLE = :APP_USER ',
'   AND nvl(P.NM_USUARIO_ORACLE,:APP_USER ) = :APP_USER ',
'UNION ',
'',
'SELECT P.cod_prest_serv || '' - '' || P.nome AS d, ',
'       P.cod_prest_serv AS r ',
'  FROM PRESTADOR_SERVICO P ',
' WHERE P.tipo_prest_serv = ''1''',
'   AND EXISTS (',
'       SELECT 1 ',
'         FROM USUARIO_ORACLE UO ',
'        WHERE ((UO.CD_PERFIL = ''MASTER'') OR (P.NM_USUARIO_ORACLE = UO.NM_USUARIO_ORACLE))',
'        AND   UO.NM_USUARIO_ORACLE = :app_user)'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_item_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--BACKUP',
'SELECT P.cod_prest_serv || '' - '' || P.nome AS d, ',
'       P.cod_prest_serv AS r ',
'  FROM USUARIO_ORACLE UO ',
'      ,PRESTADOR_SERVICO P ',
' WHERE P.tipo_prest_serv = ''1'' ',
'   AND P.MAT_PRESTADOR = UO.CD_MATRICULA ',
'   AND P.COD_EMPRESA_ENDERECO = UO.CD_EMPRESA ',
'   AND UO.NM_USUARIO_ORACLE = :APP_USER ',
'   AND nvl(P.NM_USUARIO_ORACLE,:APP_USER ) = :APP_USER ',
'UNION ',
'SELECT P.cod_prest_serv || '' - '' || P.nome AS d, ',
'       P.cod_prest_serv AS r ',
'  FROM USUARIO_ORACLE UO ',
'      ,PRESTADOR_SERVICO P ',
' WHERE P.tipo_prest_serv = ''1'' ',
'   AND P.COD_EMPRESA_ENDERECO = UO.CD_EMPRESA ',
'   AND P.PJ = ''S'' ',
'   AND UO.NM_USUARIO_ORACLE = :APP_USER ',
'   AND P.NM_USUARIO_ORACLE = :APP_USER ',
'UNION ',
'SELECT P.cod_prest_serv || '' - '' || P.nome AS d, ',
'       P.cod_prest_serv AS r ',
'  FROM PRESTADOR_SERVICO P ',
' WHERE P.tipo_prest_serv = ''1'' ',
'   AND EXISTS (',
'       SELECT 1 ',
'         FROM USUARIO_ORACLE UO ',
'        WHERE ((UO.CD_PERFIL = ''MASTER'') OR (nvl(P.NM_USUARIO_ORACLE,:APP_USER) = :APP_USER))',
'          AND UO.NM_USUARIO_ORACLE = :APP_USER)',
'ORDER BY 1;'))
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166657643977416094066)
,p_name=>'P10_DATA_AGENDA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_prompt=>'Data'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(177921863024072886909)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667389836202441433)
,p_name=>'P10_POSSUI_AGENDA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667392165409441457)
,p_name=>'P10_URL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667392371491441459)
,p_name=>'P10_TIPO_PACIENTE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667392546673441460)
,p_name=>'P10_COD_PACIENTE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166667392596881441461)
,p_name=>'P10_TIPO_CONSULTA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166682262124142569642)
,p_name=>'P10_ROWID'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(166657643728054094063)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597428550223960)
,p_name=>'P10_P_DATA'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597556011223961)
,p_name=>'P10_P_COD_EMPRESA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597561515223962)
,p_name=>'P10_P_MATRICULA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597722745223963)
,p_name=>'P10_P_COD_CANDIDATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597765356223964)
,p_name=>'P10_P_SEQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820597861769223965)
,p_name=>'P10_P_SENHA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_prompt=>'Senha'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(166820598155706223967)
,p_name=>'P10_P_LOCAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(166820597068481223957)
,p_prompt=>'Sala'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(177921862926344886909)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166657644083197094067)
,p_name=>'Refresh Agenda'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_COD_EMPRESA,P10_COD_PRESTR_SERV,P10_DATA_AGENDA,P10_SALA'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*!!apex.item(''P10_COD_EMPRESA'').getValue() &&*/',
'!!apex.item(''P10_COD_PRESTR_SERV'').getValue() &&',
'!!apex.item(''P10_DATA_AGENDA'').getValue() &&',
'!!apex.item(''P10_SALA'').getValue()',
''))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_security_scheme=>wwv_flow_api.id(161347559215439747726)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667390182036441437)
,p_event_id=>wwv_flow_api.id(166657644083197094067)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166663326712191319117)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667389884884441434)
,p_event_id=>wwv_flow_api.id(166657644083197094067)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_POSSUI_AGENDA'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select case when count(1) > 0 then ''S'' else ''N'' end as possui',
'  from agendas_medicos',
' where cod_empresa     = nvl(:P10_COD_EMPRESA,cod_empresa)',
'   and cod_prestr_serv = :P10_COD_PRESTR_SERV',
'   and tipo_prest_serv = ''1''',
'   and data_agenda     = trunc(to_date(:P10_DATA_AGENDA, ''dd/mm/yyyy''))'))
,p_attribute_07=>'P10_COD_EMPRESA,P10_COD_PRESTR_SERV,P10_DATA_AGENDA'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166664366851696913454)
,p_name=>'Disable All Action Buttons'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367039288913456)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664365687481913443)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367373770913460)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664365806463913444)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367353412913459)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664365890139913445)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367228140913458)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664365992081913446)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664366894815913455)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664366121176913447)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367607523913462)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664366200159913448)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166664367497818913461)
,p_event_id=>wwv_flow_api.id(166664366851696913454)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(166664366358972913449)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166664367779299913464)
,p_name=>'Toggle Action Buttons'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(166663326712191319117)
,p_bind_type=>'bind'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667389666347441432)
,p_event_id=>wwv_flow_api.id(166664367779299913464)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'regra_negocio(this.data)'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667389084634441426)
,p_name=>'Set Grid to Edit Mode'
,p_event_sequence=>60
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667389171671441427)
,p_event_id=>wwv_flow_api.id(166667389084634441426)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region("horarios").widget().interactiveGrid("getActions").set("edit", true);'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667389482251441430)
,p_name=>'Prevent Changing When Blocked - Checkboxes'
,p_event_sequence=>70
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166663326712191319117)
,p_triggering_element=>'COMPARECEU,ATENDE_AREA_SELECAO,REALIZOU'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$(this.triggeringElement).hasClass(''apex_disabled'')'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667389647485441431)
,p_event_id=>wwv_flow_api.id(166667389482251441430)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'TRIGGERING_ELEMENT'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'$(this.triggeringElement).val() === ''S'' ? ''N'' : ''S'''
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667390444229441439)
,p_name=>'Create New Agenda'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_POSSUI_AGENDA'
,p_condition_element=>'P10_POSSUI_AGENDA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166657644238730094068)
,p_event_id=>wwv_flow_api.id(166667390444229441439)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166663326712191319117)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667389961495441435)
,p_event_id=>wwv_flow_api.id(166667390444229441439)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('A agenda para este dia ainda n\00E3o existe.'),
unistr('Deseja cri\00E1-la agora?')))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667390093072441436)
,p_event_id=>wwv_flow_api.id(166667390444229441439)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'pck_acoes_agenda.buscar_agenda(:P10_COD_EMPRESA, :P10_COD_PRESTR_SERV, ''1'', to_date(:P10_DATA_AGENDA, ''dd/mm/yyyy''));'
,p_attribute_02=>'P10_COD_EMPRESA,P10_COD_PRESTR_SERV,P10_DATA_AGENDA,P10_SALA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667390350711441438)
,p_event_id=>wwv_flow_api.id(166667390444229441439)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166663326712191319117)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667391349717441448)
,p_name=>'Throw Checkbox Actions'
,p_event_sequence=>100
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166663326712191319117)
,p_triggering_element=>'BLOQUEADO,COMPARECEU,REALIZOU,TIPO_PACIENTE,COD_PACIENTE'
,p_bind_type=>'live'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667391455662441449)
,p_event_id=>wwv_flow_api.id(166667391349717441448)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var view = apex.region("horarios").widget().interactiveGrid("getViews", "grid"),',
'    selection = view && view.getSelectedRecords();',
'',
'if (selection && selection[0]) {',
'  var data = {',
'        selectedRecords: selection,',
'        model: view.model ',
'      };',
'',
'  regra_negocio(data)',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667391739376441452)
,p_name=>unistr('Button Action - Avalia\00E7\00E3o M\00E9dica')
,p_event_sequence=>110
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664365687481913443)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667392876082441464)
,p_event_id=>wwv_flow_api.id(166667391739376441452)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'setDadosConsulta()'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667392352225441458)
,p_event_id=>wwv_flow_api.id(166667391739376441452)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P10_URL := apex_page.get_url (',
'  p_page        => 105,',
'  p_clear_cache => 105,',
'  p_items       => ''P105_COD_EMPRESA,P105_MATRICULA,P105_DATA_AVALIACAO,P105_COD_PREST_SERV,P105_TIPO_AVALIADO,P105_PAGE'',',
'  p_values      => apex_string.format (',
'                     ''%s,%s,%s,%s,%s,%s'',',
'                     :P10_COD_EMPRESA,',
'                     :P10_COD_PACIENTE,',
'                     :P10_DATA_AGENDA,',
'                     :P10_COD_PRESTR_SERV,',
'                     case when :P10_TIPO_PACIENTE = ''1'' then ''F'' else ''C'' end,',
'                     :APP_PAGE_ID',
'                   )',
');'))
,p_attribute_02=>'P10_COD_EMPRESA,P10_COD_PACIENTE,P10_DATA_AGENDA,P10_COD_PRESTR_SERV,P10_TIPO_PACIENTE'
,p_attribute_03=>'P10_URL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667391809304441453)
,p_event_id=>wwv_flow_api.id(166667391739376441452)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(122335180305906081461)
,p_name=>'New'
,p_event_sequence=>119
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_api.id(166663326712191319117)
,p_triggering_element=>'BLOQUEADO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(122335180392558081462)
,p_event_id=>wwv_flow_api.id(122335180305906081461)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'okkkkkkk'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166667391949700441454)
,p_name=>'After Interactive Grid Save'
,p_event_sequence=>120
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(166663326712191319117)
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'interactivegridsave'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166667392010463441455)
,p_event_id=>wwv_flow_api.id(166667391949700441454)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'removeSpinner(spinnerContainer)',
'if (this.data && this.data.status === "success")',
'  if (typeof buttonAction === ''function'')',
'    buttonAction()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166682259931011569620)
,p_name=>'Button Action - Desmarcar'
,p_event_sequence=>130
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664366358972913449)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166682260236340569623)
,p_event_id=>wwv_flow_api.id(166682259931011569620)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>'Deseja desmarcar a consulta selecionada?'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166682260063773569622)
,p_event_id=>wwv_flow_api.id(166682259931011569620)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'desmarcarConsulta()'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166682261794351569639)
,p_name=>'Button Action - Transferir'
,p_event_sequence=>140
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664366200159913448)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166682262323239569644)
,p_event_id=>wwv_flow_api.id(166682261794351569639)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'return apex_util.prepare_url (',
'         p_url                => apex_string.format (',
'                                   ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'                                   :APP_ID,',
'                                   ''31'',',
'                                   :SESSION,',
'                                   null,',
'                                   :DEBUG,',
'                                   ''31'',',
'                                   ''P31_ROWID'',',
'                                   :P10_ROWID',
'                                 ),',
'         p_triggering_element => ''$("#TRANSFERIR")''--,',
'       );'))
,p_attribute_07=>'P10_ROWID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166682262400165569645)
,p_event_id=>wwv_flow_api.id(166682261794351569639)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'window.location = apex.item(''P10_URL'').getValue()'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166683585481624143061)
,p_name=>'Button Action - ASO'
,p_event_sequence=>150
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664366121176913447)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683585732498143063)
,p_event_id=>wwv_flow_api.id(166683585481624143061)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(2000);',
'  l_tipo_exame varchar2(1);',
'begin',
'  begin',
'    Select Classificacao_Aso',
'      Into l_tipo_exame',
'      From Tipo_Consulta',
'     Where Cod_Tipo_Consulta = :P10_TIPO_CONSULTA;',
'  exception when others then null;',
'  end;    ',
'  l_url := case when :P10_TIPO_PACIENTE = 1 then -- Funcionario',
'             apex_string.format (',
'               ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'               :APP_ID,',
'               ''19'',',
'               :SESSION,',
'               null,',
'               :DEBUG,',
'               ''19'',',
'               ''P19_EMPRESA,P19_MATRICULA,P19_TIPO_EXAME,P19_DATA_ATUAL,P19_MEDICO,P19_COD_REQ'',',
'               apex_string.format(''%s,%s,%s,%s,%s,%s'', :P10_COD_EMPRESA, :P10_COD_PACIENTE, l_tipo_exame, :P10_DATA_AGENDA, :P10_COD_PRESTR_SERV, :P10_COD_REQ)',
'             )',
'           else -- Candidato',
'             apex_string.format (',
'               ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'               :APP_ID,',
'               ''24'',',
'               :SESSION,',
'               null,',
'               :DEBUG,',
'               ''24'',',
'               ''P24_COD_EMPRESA,P24_COD_CANDIDATO,P24_DATA_CONSULTA,P24_MEDICO,P24_ORIGEM_MED,P24_COD_REQ'',',
'               apex_string.format(''%s,%s,%s,%s,%s,%s'', :P10_COD_EMPRESA,:P10_COD_PACIENTE, :P10_DATA_AGENDA, :P10_COD_PRESTR_SERV, ''MI'', :P10_COD_REQ)',
'             )',
'           end;',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#ASO")'');',
'end;'))
,p_attribute_07=>'P10_ROWID,P10_TIPO_PACIENTE,P10_COD_PACIENTE,P10_TIPO_CONSULTA,P10_COD_PRESTR_SERV,P10_COD_REQ'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683585843683143064)
,p_event_id=>wwv_flow_api.id(166683585481624143061)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166683586043535143066)
,p_name=>unistr('Button Action - Consulta M\00E9dica')
,p_event_sequence=>160
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664365992081913446)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683586127009143067)
,p_event_id=>wwv_flow_api.id(166683586043535143066)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url               varchar2(2000);',
'  l_cod_entidade      prest_serv_entidade.cod_entidade%type;',
'  l_cod_especialidade prest_serv_especialidade.cod_especialidade%type;',
'  l_rowid             rowid;',
'  l_ag_rowid          rowid;',
'BEGIN',
'  l_ag_rowid := :P10_ROWID;',
'  begin',
'    select rowid',
'      into l_rowid',
'      from consulta_medica',
'     where cod_empresa       = :P10_COD_EMPRESA',
'       and matricula         = :P10_COD_PACIENTE',
'       and cod_tipo_consulta = :P10_TIPO_CONSULTA',
'       and dt_consulta       = to_date(:P10_DATA_AGENDA, ''dd/mm/yyyy'');',
'',
'    raise too_many_rows;',
'  exception',
'    when too_many_rows then',
'      l_url := apex_string.format (',
'                 ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'                 :APP_ID,',
'                 ''40'',',
'                 :SESSION,',
'                 null,',
'                 :DEBUG,',
'                 ''40'',',
'                 ''P40_ROWID'',',
'                 l_rowid',
'               );',
'    when no_data_found then',
'      begin',
'        select cod_entidade',
'          into l_cod_entidade',
'          from prest_serv_entidade',
'         where cod_prest_serv = :P10_COD_PRESTR_SERV',
'           and cod_dia_sem    = to_number(to_char(to_date(:P10_DATA_AGENDA, ''dd/mm/yyyy''), ''D''))',
'           and rownum         = 1;',
'      exception when others then null;',
'      end;',
'',
'      begin',
'        select a.cod_especialidade',
'          into l_cod_especialidade',
'          from prest_serv_especialidade a',
'         where a.cod_prest_serv  = :P10_COD_PRESTR_SERV',
'           and a.tipo_prest_serv = ''1''',
'           and rownum = 1;',
'      exception when others then null;',
'      end;',
'',
'      l_url := apex_string.format (',
'                 ''f?p=%s:%s:%s:%s:%s:%s:%s:%s:%s'',',
'                 :APP_ID,',
'                 ''40'',',
'                 :SESSION,',
'                 null,',
'                 :DEBUG,',
'                 ''40'',',
'                 ''P40_COD_EMPRESA,P40_MATRICULA,P40_COD_TIPO_CONSULTA,P40_DT_CONSULTA,P40_COD_PREST_SERV,P40_COD_ENTIDADE,P40_CHAMADA_AGENDA,P40_COD_ESPECIALIDADE,P40_ROWID_AGD,P40_COD_REQ'',',
'                 apex_string.format(''%s,%s,%s,%s,%s,%s,%s,%s,%s,%s'', :P10_COD_EMPRESA, :P10_COD_PACIENTE, :P10_TIPO_CONSULTA, :P10_DATA_AGENDA, :P10_COD_PRESTR_SERV, l_cod_entidade, ''S'', l_cod_especialidade, l_ag_rowid,:P10_COD_REQ)',
'               );',
'  end;',
'',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#CONSULTA_MEDICA")'');',
'end;'))
,p_attribute_07=>'P10_ROWID,P10_TIPO_PACIENTE,P10_COD_PACIENTE,P10_TIPO_CONSULTA,P10_COD_PRESTR_SERV,P10_COD_REQ'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683586160642143068)
,p_event_id=>wwv_flow_api.id(166683586043535143066)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166691430931868452129)
,p_name=>'Button Action - Dados Candidato'
,p_event_sequence=>170
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664365890139913445)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691430986995452130)
,p_event_id=>wwv_flow_api.id(166691430931868452129)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(2000);',
'begin',
'  l_url := apex_string.format (',
'             ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'             :APP_ID,',
'             ''29'',',
'             :SESSION,',
'             null,',
'             :DEBUG,',
'             ''29'',',
'             ''P29_COD_CANDIDATO'',',
'             apex_string.format(''%s'', :P10_COD_PACIENTE)',
'           );',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#DADOS_CANDIDATO")'');',
'end;'))
,p_attribute_07=>'P10_COD_PACIENTE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691431099348452131)
,p_event_id=>wwv_flow_api.id(166691430931868452129)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166691432958844452149)
,p_name=>'Button Action - Dados Funcionario'
,p_event_sequence=>180
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664365806463913444)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691432977352452150)
,p_event_id=>wwv_flow_api.id(166691432958844452149)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(2000);',
'begin',
'  l_url := apex_string.format (',
'             ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'             :APP_ID,',
'             ''6'',',
'             :SESSION,',
'             null,',
'             :DEBUG,',
'             ''6'',',
'             ''P6_COD_EMPRESA,P6_MATRICULA'',',
'             apex_string.format(''%s,%s'', :P10_COD_EMPRESA, :P10_COD_PACIENTE)',
'           );',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#DADOS_FUNCIONARIO")'');',
'end;'))
,p_attribute_07=>'P10_COD_EMPRESA,P10_COD_PACIENTE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166691433111738452151)
,p_event_id=>wwv_flow_api.id(166691432958844452149)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166698431445192559939)
,p_name=>'Button Action - Relatorio'
,p_event_sequence=>190
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664366399934913450)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166698431500405559940)
,p_event_id=>wwv_flow_api.id(166698431445192559939)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_url varchar2(2000);',
'begin',
'  l_url := apex_string.format (',
'             ''f?p=%s:%s:%s:%s:%s:%s:%s:%s'',',
'             :APP_ID,',
'             ''28'',',
'             :SESSION,',
'             null,',
'             :DEBUG,',
'             ''28'',',
'             ''P28_COD_EMPRESA,P28_COD_PRESTR_SERV,P28_DATA_INICIAL,P28_DATA_FINAL'',',
'             apex_string.format(''%s,%s,%s,%s'', :P10_COD_EMPRESA,:P10_COD_PRESTR_SERV,:P10_DATA_AGENDA,:P10_DATA_AGENDA)',
'           );',
'  return apex_util.prepare_url(p_url => l_url, p_triggering_element => ''$("#RELATORIO")'');',
'end;'))
,p_attribute_07=>'P10_COD_EMPRESA,P10_COD_PACIENTE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166698431571175559941)
,p_event_id=>wwv_flow_api.id(166698431445192559939)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166682264825333569669)
,p_name=>'Dialog Closed - Transferir'
,p_event_sequence=>200
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166664366200159913448)
,p_bind_type=>'live'
,p_bind_event_type=>'apexafterclosedialog'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683581470164143021)
,p_event_id=>wwv_flow_api.id(166682264825333569669)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (this.data && this.data.successMessage && this.data.successMessage.text) {',
'  apex.message.showPageSuccess(this.data.successMessage.text)',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166683581374177143020)
,p_event_id=>wwv_flow_api.id(166682264825333569669)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166663326712191319117)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(164815949846124548739)
,p_name=>'URL Chama CMO'
,p_event_sequence=>230
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(164807976960798215508)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164815949862072548740)
,p_event_id=>wwv_flow_api.id(164815949846124548739)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_URL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cAgdMedHr IS',
'    SELECT X.* ',
'      FROM agendas_medicos_horarios x',
'     WHERE x.ROWID = :P10_ROWID;',
'  --',
'  rAgdMedHr   cAgdMedHr%ROWTYPE;',
'BEGIN',
'  :P10_AGD_ROWID := :P10_ROWID;',
'  --',
'  OPEN cAgdMedHr;',
'  FETCH cAgdMedHr INTO rAgdMedHr; ',
'  CLOSE cAgdMedHr;',
'  --',
'  :P10_CMO_ROWID  := pkg_mt_adt_CMO.fnc_RetRowidCMO(pEmp    => rAgdMedHr.COD_EMPRESA',
'                                                   ,pMat    => rAgdMedHr.COD_PACIENTE',
'                                                   ,pTpCons => rAgdMedHr.COD_TIPO_CONSULTA',
'                                                   ,pDtCons => rAgdMedHr.DATA_AGENDA',
'                                                   ,pHrCons => rAgdMedHr.HORA_INIC_PREVISTO);',
'  --',
'  RETURN apex_page.get_url(p_application => ''MT_ATD_''||:P_BASE',
'                          ,p_page        => 70',
'                          ,p_clear_cache => 70 ',
'                          ,p_items       => ''P70_ROWID,P70_ROWID_AGD,P70_COD_REQ''',
'	                      ,p_values      => :P10_CMO_ROWID||'',''||:P10_AGD_ROWID||'',''||:P10_COD_REQ',
'	                      );',
'END;'))
,p_attribute_07=>'P10_ROWID,P10_TIPO_CONSULTA,P10_COD_REQ'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164815950037073548741)
,p_event_id=>wwv_flow_api.id(164815949846124548739)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'buttonAction = function() {',
'  window.location = apex.item(''P10_URL'').getValue()',
'}',
'buttonActionClick()'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166820597246071223958)
,p_name=>'Chamar Paciente'
,p_event_sequence=>240
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166820596883308223955)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166821784781109197522)
,p_event_id=>wwv_flow_api.id(166820597246071223958)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select *',
'   from mt_chamada_paciente',
'  where data = :p10_data_agenda',
'    and senha = :p10_p_senha;',
'    ',
' v_c1 c1%rowtype;',
'',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  if v_c1.seq is not null then',
'    ',
'    :p10_p_cod_empresa := v_c1.cod_empresa;',
'    :p10_p_matricula   := v_c1.matricula;',
'    :p10_p_cod_candidato := v_c1.cod_candidato;',
'    :p10_p_seq := v_c1.seq;',
'    :p10_p_data := :p10_data_agenda;',
'    :p10_p_local := :p10_sala;',
'  ',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P10_DATA_AGENDA,P10_P_SENHA,P10_SALA'
,p_attribute_03=>'P10_P_COD_EMPRESA,P10_P_MATRICULA,P10_P_COD_CANDIDATO,P10_P_SEQ,P10_P_DATA,P10_P_LOCAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166820597289876223959)
,p_event_id=>wwv_flow_api.id(166820597246071223958)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166820597068481223957)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(166820598295599223969)
,p_name=>'Insere_Status'
,p_event_sequence=>250
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(166820598232810223968)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166821784588450197520)
,p_event_id=>wwv_flow_api.id(166820598295599223969)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'insert into MT_CHAMADA_PACIENTE_STATUS VALUES (:P10_P_COD_EMPRESA,',
'                                              :P10_P_MATRICULA,',
'                                              :P10_P_COD_CANDIDATO,',
'                                              :P10_P_DATA, ',
'                                              :P10_P_SEQ,',
'                                              :P10_P_SENHA,',
'                                              ''M'',',
'                                              upper(:P10_P_LOCAL),',
'                                              SYSDATE,',
'                                              null,--:P10_P_OBSERVACAO_STATUS,',
'                                              :P_USUARIO,',
'                                              SYSDATE,',
'                                              1);',
'',
'COMMIT;',
'',
'end;'))
,p_attribute_02=>'P10_P_COD_EMPRESA,P10_P_MATRICULA,P10_P_COD_CANDIDATO,P10_P_DATA,P10_P_SEQ,P10_P_SENHA,P10_P_LOCAL,P_USUARIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166821784893757197523)
,p_event_id=>wwv_flow_api.id(166820598295599223969)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ALERT'
,p_attribute_01=>'Alerta Enviado!'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(166821785014168197524)
,p_event_id=>wwv_flow_api.id(166820598295599223969)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(166820597068481223957)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(164807978560012215524)
,p_name=>'Habilita Desabilita CMO Button'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P10_CMO_BUTTON'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164815946520295548706)
,p_event_id=>wwv_flow_api.id(164807978560012215524)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P10_CMO_BUTTON" ).getValue() == ''S'') {',
'  apex.item("CMO").enable()  ',
'} else {',
'  apex.item("CMO").disable()  ',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(164807979922362215538)
,p_event_id=>wwv_flow_api.id(164807978560012215524)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P10_CMO_ROWID'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166663344609292319141)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166663326712191319117)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>' - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(122335180552701081463)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(166663326712191319117)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Bloqueia outras empresas'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :APEX$ROW_STATUS = ''U'' then',
'',
'Update Agendas_Medicos_Horarios',
'    SET    BLOQUEADO = ''S''',
'          ,USUARIO   = SUBSTR(:APP_USER||''ReqExame'',1,30)',
'          ,DT_ATUALIZACAO = SYSDATE',
'    WHERE  HORA_INIC_PREVISTO = to_date(:DATA_AGENDA||'' ''||:HORA_INIC_PREVISTO,''dd/mm/yyyy hh24:mi'')',
'    AND    DATA_AGENDA        = :DATA_AGENDA',
'    AND    COD_EMPRESA        <> :P10_COD_EMPRESA',
'    AND    COD_PRESTR_SERV    = :COD_PRESTR_SERV',
'    AND    TIPO_PREST_SERV    = :TIPO_PREST_SERV;',
'',
'end if;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(166821788137837197555)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula COD_EMPRESA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  cursor c1 is',
'  select cod_empresa_endereco cod_empresa',
'    from prestador_servico',
'   where tipo_prest_serv = ''1''',
'   and cod_prest_serv = :p10_cod_prestr_serv;',
'',
'   v_c1 c1%rowtype;',
'',
'   v_cod_empresa empresas.cod%type;',
'',
'begin',
'',
'  if :p10_cod_empresa is null and :p10_cod_prestr_Serv is not null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    :p10_cod_empresa := v_c1.cod_empresa;',
'    ',
'  end if;',
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
