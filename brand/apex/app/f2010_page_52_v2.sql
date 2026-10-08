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
,p_default_application_id=>2010
,p_default_id_offset=>785157711080795753
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 2010 - Requisição de Pessoal - Natcorp
--
-- Application Export:
--   Application:     2010
--   Name:            Requisição de Pessoal - Natcorp
--   Date and Time:   22:45 Monday September 28, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 52
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00052
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>52);
end;
/
prompt --application/pages/page_00052
begin
wwv_flow_api.create_page(
 p_id=>52
,p_user_interface_id=>wwv_flow_api.id(54947256137544418932)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Pessoal ')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Pessoal')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#jquery.maskedinput.min.js',
'#WORKSPACE_IMAGES#forms-functions.js',
'#WORKSPACE_IMAGES#jquery.maskMoney.min.js',
'#WORKSPACE_IMAGES#Natcorp_Requisicao.js'))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// Captura o clique no bot\00E3o com classe .btn-remover'),
'$(document).on("click", ".btn-remover", function () {',
'  var codReq = $(this).data("codreq");',
'',
unistr('  // Confirma\00E7\00E3o antes de remover (opcional)'),
'  apex.message.confirm("Deseja realmente remover o anexo?", function (okPressed) {',
'    if (okPressed) {',
'      // Chama o Ajax Callback',
'      apex.server.process("REMOVER_ANEXO", {',
'        x01: codReq',
'      }, {',
'        success: function (pData) {',
'          // Espera JSON do tipo { status: "OK" }',
'          if (pData && pData.status === "OK") {',
'            apex.message.showPageSuccess("Anexo removido com sucesso.");',
unistr('            // Atualiza a regi\00E3o do relat\00F3rio (use o Static ID correto!)'),
'            apex.region("relatorio_anexos").refresh();',
'          } else {',
'            apex.message.alert("Erro inesperado ao remover o anexo.");',
'          }',
'        },',
'        error: function (xhr, status, errorThrown) {',
unistr('          console.error("Erro t\00E9cnico:", errorThrown);'),
unistr('          apex.message.alert("Erro t\00E9cnico ao remover o anexo.");'),
'        }',
'      });',
'    }',
'  });',
'});',
'',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(document).on("click", ".btn-remover", function() {',
'  var codReq = $(this).data("codreq");',
'  removerAnexo(codReq);',
'});',
'',
'',
'if (apex.item("P52_FLAG_TEMPORARIO").getValue() == ''N'') {',
'',
'apex.item("P52_COD_CCUSTO").disable();',
'//apex.item("P52_COD_ATIVIDADE").disable();',
'    apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'    apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'    apex.item("P52_COD_UN_NEGOCIO").disable();',
'    apex.item("P52_COD_UNIDADE_ADM").disable();',
'    apex.item("P52_COD_LOCAL_TRAB").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'    apex.item("P52_VINCULO").disable();',
'  apex.item("P52_TRAB_INTERMITENTE").disable();',
'    apex.item("P52_COD_CARGO").disable();',
'    apex.item("P52_SALARIO").disable();',
'    apex.item("P52_TIPO_MODALIDADE").disable();',
'    apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'    apex.item("P52_MAT_SUBS").disable();',
'    apex.item("P52_IND_INSALUB").disable();',
'    apex.item("P52_IND_PERIC").disable();',
'   apex.item("P52_COD_CATEGORIA").disable();',
'   apex.item("P52_COD_FUNCAO").disable();',
'   apex.item("P52_RT_JORNADA_MENSAL").disable();',
'   apex.item("P52_MARCA_PONTO").disable();',
'   apex.item("P52_TP_REGISTRO_PONTO").disable();',
'   apex.item("P52_DATA_INICIO").disable();',
'   apex.item("P52_DATA_FIM").disable();',
'    apex.item("P52_TIPO_CONTRATO").disable();',
'    apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'    apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'    apex.item("P52_COD_CCUSTO_1").disable();',
'    apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'    apex.item("P52_COD_UN_NEGOCIO_1").disable();',
'    apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'    apex.item("P52_COD_ATIVIDADE_1").disable();',
'    apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'    apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'    apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'    apex.item("P52_VINCULO_1").disable();',
'    apex.item("P52_COD_CARGO_1").disable();',
'    apex.item("P52_SALARIO").disable();',
'    apex.item("P52_MAT_SUBS").disable();',
'    apex.item("P52_IND_INSALUB").disable();',
'    apex.item("P52_IND_PERIC").disable();',
'  apex.item("P52_COD_CATEGORIA_1").disable();',
'   apex.item("P52_COD_FUNCAO_1").disable();',
'   apex.item("P52_RT_JORNADA_MENSAL_1").disable();',
'   apex.item("P52_DATA_INICIO_1").disable();',
'   apex.item("P52_DATA_FIM_1").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL_1").enable();',
'//CH43237   apex.item("P52_COD_HORARIO_1").disable();',
'   apex.item("P52_REFEITORIO_1").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'    apex.item("P52_COD_CCUSTO_1").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'    apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'    apex.item("P52_COD_UN_NEGOCIO_1").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'    apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE").disable();',
'    apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'    apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'apex.item("P52_VINCULO").disable();',
'    apex.item("P52_VINCULO_1").disable();',
' apex.item("P52_COD_CARGO").disable();',
'    apex.item("P52_COD_CARGO_1").disable();',
'    apex.item("P52_SALARIO").disable();',
'    apex.item("P52_MAT_SUBS").disable();',
'    apex.item("P52_IND_INSALUB").disable();',
'    apex.item("P52_IND_PERIC").disable();',
'    apex.item("P52_TIPO_SALARIO").disable();',
'apex.item("P52_COD_CATEGORIA").disable();',
'   apex.item("P52_COD_CATEGORIA_1").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'    apex.item("P52_COD_FUNCAO_1").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'   apex.item("P52_RT_JORNADA_MENSAL_1").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'   apex.item("P52_TP_REGISTRO_PONTO").disable();',
'',
'    //INFORMACOES DO PONTO   ',
'    //    apex.item("P52_TIPO_PONTO").disable();',
'    //    apex.item("P52_JORNADA").disable();',
'    //    apex.item("P52_ESCALA").disable();',
'    //    apex.item("P52_CICLO").disable();',
'    //    apex.item("P52_CICLO_INICIAL").disable();',
'    //    apex.item("P52_CICLO_DAT_INICIAL").disable();',
'    //    apex.item("P52_CICLO_DAT_FINAL").disable();    ',
'   ',
'   apex.item("P52_DATA_INICIO").disable();',
'   apex.item("P52_DATA_FIM").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'  if (apex.item("P52_ROWID").getValue().length != 0){ //CH43237',
'    apex.item("P52_COD_HORARIO").disable();',
'    apex.item("P52_COD_HORARIO_1").disable();',
'  }',
'  ',
'   apex.item("P52_REFEITORIO_1").disable();',
'    apex.item("P52_COD_SINDICATO").disable();',
'    apex.item("P52_COD_SINDICATO_1").disable();',
'  ',
'  apex.item("P52_COD_AREA").disable();',
'}',
'',
'apex.item("P52_VALOR_BENEF").disable();',
'',
'/*$(function() {',
'',
'    if (apex.item("P52_ROWID").getValue().length == 0){',
'        $.mask.definitions[''~''] = "[+-]";   ',
'',
'     $("#P52_TOTAL_SALARIO").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'     $("#P52_SALARIO").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'     $("#P52_REMUNERACAO_VARIAVEL").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'     $("#P52_VLR_AUX_TIPO_MODALIDADE").maskMoney({prefix:''R$'', thousands:''.'', decimal:'','', affixesStay: true});',
'      ',
'    }',
'//  });',
'*/',
''))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Requisicao.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'img { height: 100px }',
'',
'.apagar{',
'  min-width: 74px;',
'  max-width: 74px;',
'}',
'',
''))
,p_page_template_options=>'#DEFAULT#'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('DESENHO DA TELA (Natcorp_Requisicao.css / Natcorp_Requisicao.js, em Arquivos desta p\00E1gina)'),
'',
unistr('A estrutura \00E9 toda do APEX. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
unistr('  nc-req-etapas       Steppers: o resumo da vaga no alto, a faixa da aprova\00E7\00E3o e o menu das etapas.'),
unistr('  nc-req-etapa        cada etapa (Identifica\00E7\00E3o, Cargo, Remunera\00E7\00E3o, Perfil, Detalhamento, Candidatos,'),
unistr('                      Pr\00E9via do an\00FAncio): uma por vez; o nome no menu \00E9 o t\00EDtulo da regi\00E3o.'),
unistr('  nc-req-ficha        se\00E7\00E3o que se l\00EA como documento; "Editar" abre o formul\00E1rio (que continua na p\00E1gina).'),
unistr('  nc-req-solicitacao  Solicita\00E7\00E3o: n\00FAmero, situa\00E7\00E3o, motivo, data e solicitante.'),
unistr('  nc-req-aprovadores  Aprovadores: faixa horizontal abaixo do resumo; Aprovar/Reprovar v\00E3o para ela.'),
unistr('  nc-req-acoes        Bot\00F5es Requisi\00E7\00E3o: no canto do resumo (computador) ou abaixo dele (celular).'),
unistr('  nc-req-lista        listas de requisitos: as linhas viram etiquetas (Obrigat\00F3rio / Desej\00E1vel).'),
unistr('  nc-req-grupo / nc-req-plano / nc-req-opcional / nc-req-textos   agrupamentos e se\00E7\00F5es de apoio.'),
unistr('  nc-req-pessoas      inscritos como cart\00F5es de pessoa.'),
unistr('  nc-req-escrita      a descri\00E7\00E3o; nc-req-previa: o an\00FAncio (vazia no APEX; o JS desenha).'),
'',
unistr('Os bot\00F5es e links s\00E3o os do APEX (s\00F3 mudam de lugar na tela). Data de Situa\00E7\00E3o fica somente leitura'),
'na tela (readonly: o valor continua indo no envio). Para desligar tudo: tire as duas URLs de arquivo.',
'Guia: brand/apex/app/REQUISICAO-MANUTENCAO.md.'))
,p_last_updated_by=>'IGOR'
,p_last_upd_yyyymmddhh24miss=>'20260928224522'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6852160517838270126)
,p_plug_name=>'Steppers'
,p_region_css_classes=>'nc-stepper-host nc-req-etapas'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody:t-Form--noPadding'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999052000000000001)
,p_plug_name=>'Candidatos'
,p_region_name=>'CANDIDATOS'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_css_classes=>'nc-req-etapa nc-req-candidatos'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P52_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Etapa dos inscritos (Colaboradores e Candidatos Inscritos). S\00F3 aparece com a requisi\00E7\00E3o gravada.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999052000000000002)
,p_plug_name=>unistr('Pr\00E9via do an\00FAncio')
,p_region_name=>'PREVIA_ETAPA'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_css_classes=>'nc-req-etapa nc-req-etapa-previa'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('\00DAltima etapa: como a vaga aparece para o candidato. Vazia de prop\00F3sito: o Natcorp_Requisicao.js desenha o an\00FAncio e a confer\00EAncia "Antes de publicar". Se o JS n\00E3o carregar, o CSS a esconde.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(282999052000000000003)
,p_plug_name=>'Como o candidato vai ver'
,p_region_name=>'PREVIA_ANUNCIO'
,p_parent_plug_id=>wwv_flow_api.id(282999052000000000002)
,p_region_css_classes=>'nc-req-previa'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'N'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('O an\00FAncio desenhado pelo Natcorp_Requisicao.js (cargo, empresa, descri\00E7\00E3o e requisitos).')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849870757729323429)
,p_plug_name=>'Perfil'
,p_region_css_classes=>'nc-req-etapa'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6858879155838043125)
,p_plug_name=>unistr('Requisitos T\00E9cnicos<span class="nc-native-header__subtitle">Forma\00E7\00E3o, cursos, experi\00EAncia, conhecimentos e idiomas</span>')
,p_region_css_classes=>'nc-req-grupo'
,p_parent_plug_id=>wwv_flow_api.id(6849870757729323429)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(170359332526286691690)
,p_name=>unistr('Cursos / Certificados Necess\00E1rios')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879155838043125)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select decode(c.exige,''S'',''Exigido'',''N'',''Desej\00E1vel'') Exig\00EAncia,'),
'       c.nome Curso, ',
unistr('       decode(c.nivel,1,''B\00E1sico'',2,''Intermedi\00E1rio'',3,''Avan\00E7ado'') N\00EDvel,'),
unistr('       decode(c.concluido,''S'',''Sim'',''N'',''N\00E3o'') Conclu\00EDdo,'),
'       :P52_SEQ SEQ',
'  from curso_req_pessoal c',
' where ((:p52_cod_req is not null and c.cod_req = :p52_cod_req) or',
'        (:p52_cod_req is null     and c.seq = :p52_seq))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879286286882908381)
,p_query_column_id=>1
,p_column_alias=>unistr('EXIG\00CANCIA')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Exig\00EAncia')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879286680582908381)
,p_query_column_id=>2
,p_column_alias=>'CURSO'
,p_column_display_sequence=>3
,p_column_heading=>'Curso'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879287071593908381)
,p_query_column_id=>3
,p_column_alias=>unistr('N\00CDVEL')
,p_column_display_sequence=>4
,p_column_heading=>unistr('N\00EDvel')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879287444608908381)
,p_query_column_id=>4
,p_column_alias=>unistr('CONCLU\00CDDO')
,p_column_display_sequence=>5
,p_column_heading=>unistr('Conclu\00EDdo')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879287896855908381)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879288258666908381)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from curso_req_pessoal where nome = ''#CURSO#'' and seq = #SEQ#,delete from curso_req_pessoal where nome = ''#CURSO#'' and cod_req = &P52_COD_REQ.'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CURSO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(170359333474776691700)
,p_name=>unistr('Experi\00EAncia')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879155838043125)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.nome experiencia, ',
'       e.anos,',
'       e.meses,',
unistr('       decode(e.exige,''S'',''Exigido'',''N'',''Desej\00E1vel'') Exig\00EAncia,'),
'       :P52_SEQ SEQ',
'  from experiencia_req_pessoal e',
' where ((:p52_cod_req is not null and e.cod_req = :p52_cod_req) or',
'        (:p52_cod_req is null     and e.seq = :p52_seq))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879289401086908382)
,p_query_column_id=>1
,p_column_alias=>'EXPERIENCIA'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Experi\00EAncia')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879289758374908382)
,p_query_column_id=>2
,p_column_alias=>'ANOS'
,p_column_display_sequence=>4
,p_column_heading=>'Anos'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879290141205908382)
,p_query_column_id=>3
,p_column_alias=>'MESES'
,p_column_display_sequence=>5
,p_column_heading=>'Meses'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879290618965908383)
,p_query_column_id=>4
,p_column_alias=>unistr('EXIG\00CANCIA')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Exig\00EAncia')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879291018456908383)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879291422400908383)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from EXPERIENCIA_REQ_PESSOAL where NOME = ''#EXPERIENCIA#'' and seq = #SEQ#,delete from EXPERIENCIA_REQ_PESSOAL where NOME = ''#EXPERIENCIA#'' and cod_re'
||'q = &P52_COD_REQ.'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#EXPERIENCIA#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(170360452221720838359)
,p_name=>'Conhecimento'
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879155838043125)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.nome conhecimento, ',
unistr('       decode(c.nivel,1,''B\00E1sico'',2,''Intermedi\00E1rio'',3,''Avan\00E7ado'') nivel,'),
unistr('       nvl(decode(c.exige,''S'',''Exigido'',''N'',''Desej\00E1vel''),''Desej\00E1vel'') Exig\00EAncia,'),
'       :P52_SEQ SEQ',
'  from conhecimento_req_pessoal c',
' where ((:p52_cod_req is not null and c.cod_req = :p52_cod_req) or',
'        (:p52_cod_req is null     and c.seq = :p52_seq))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879292474054908384)
,p_query_column_id=>1
,p_column_alias=>'CONHECIMENTO'
,p_column_display_sequence=>3
,p_column_heading=>'Conhecimento'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879292902293908384)
,p_query_column_id=>2
,p_column_alias=>'NIVEL'
,p_column_display_sequence=>4
,p_column_heading=>'Nivel'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879293284354908384)
,p_query_column_id=>3
,p_column_alias=>unistr('EXIG\00CANCIA')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Exig\00EAncia')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879293711457908384)
,p_query_column_id=>4
,p_column_alias=>'SEQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879294029015908384)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from conhecimento_req_pessoal where nome = ''#CONHECIMENTO#'' and seq = #SEQ#,delete from conhecimento_req_pessoal where nome = ''#CONHECIMENTO#'' and co'
||'d_req = &P52_COD_REQ.'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CONHECIMENTO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179729913498326141848)
,p_name=>unistr('Idiomas Necess\00E1rios')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879155838043125)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>160
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(B.descricao) idioma, initcap(n.descricao) nivel_conhecimento, :P52_SEQ SEQ, t.cod_idioma',
'from   idioma B, NIVEL_CONHECIMENTO N, IDIOMA_REQ_PESSOAL t',
'where b.codigo = t.cod_idioma',
'  and n.codigo = t.cod_nivel_conh',
'  and ((:p52_cod_req is not null and t.cod_req = :p52_cod_req) or',
'       (:p52_cod_req is null     and t.seq = :p52_seq))',
'order by 2'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879184060324908325)
,p_query_column_id=>1
,p_column_alias=>'IDIOMA'
,p_column_display_sequence=>2
,p_column_heading=>'Idioma'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879184489604908325)
,p_query_column_id=>2
,p_column_alias=>'NIVEL_CONHECIMENTO'
,p_column_display_sequence=>3
,p_column_heading=>'Nivel conhecimento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879184897306908326)
,p_query_column_id=>3
,p_column_alias=>'SEQ'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879183252359908325)
,p_query_column_id=>4
,p_column_alias=>'COD_IDIOMA'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879183689314908325)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from IDIOMA_REQ_PESSOAL where seq = #SEQ# and cod_idioma = #COD_IDIOMA#,delete from IDIOMA_REQ_PESSOAL where cod_req = &P52_COD_REQ. and cod_idioma ='
||' #COD_IDIOMA#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_IDIOMA#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179845172619887405836)
,p_name=>unistr('Forma\00E7\00E3o')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879155838043125)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select decode(f.exige,''S'',''Exigido'',''N'',''Desej\00E1vel'') Exig\00EAncia,'),
'       initcap(i.nome) instrucao,',
'       f.nome formacao, ',
unistr('       decode(f.concluida,''S'',''Sim'',''N'',''N\00E3o'') concluida,'),
'       :P52_SEQ SEQ',
'  from formacao_req_pessoal f, instrucao i',
' where f.cod_instrucao = i.cod',
'   and ((:p52_cod_req is not null and f.cod_req = :p52_cod_req) or',
'        (:p52_cod_req is null     and f.seq = :p52_seq))'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879186011716908326)
,p_query_column_id=>1
,p_column_alias=>unistr('EXIG\00CANCIA')
,p_column_display_sequence=>2
,p_column_heading=>unistr('Exig\00EAncia')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879186424220908326)
,p_query_column_id=>2
,p_column_alias=>'INSTRUCAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Instru\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879186797256908326)
,p_query_column_id=>3
,p_column_alias=>'FORMACAO'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Forma\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879187159577908327)
,p_query_column_id=>4
,p_column_alias=>'CONCLUIDA'
,p_column_display_sequence=>5
,p_column_heading=>'Concluida'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879187558729908327)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879188007899908327)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from formacao_req_pessoal where nome = ''#FORMACAO#'' and seq = #SEQ#,delete from formacao_req_pessoal where nome = ''#FORMACAO#'' and cod_req = &P52_COD'
||'_REQ.'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#FORMACAO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6858879248139043126)
,p_plug_name=>unistr('Desempenho da Fun\00E7\00E3o<span class="nc-native-header__subtitle">Caracter\00EDsticas, tarefas e recursos de apoio</span>')
,p_region_css_classes=>'nc-req-grupo'
,p_parent_plug_id=>wwv_flow_api.id(6849870757729323429)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(168080629306856356580)
,p_name=>'Colaboradores Inscritos'
,p_region_css_classes=>'nc-req-pessoas'
,p_parent_plug_id=>wwv_flow_api.id(282999052000000000001)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa, ''S'')) empresa,',
'       i.filial||'' - ''||initcap(fnct_nome_filial(i.cod_empresa, i.filial, ''S'')) filial,',
'       i.cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(i.cod_empresa, i.cod_ccusto)) ccusto,',
'       i.matricula||'' - ''||initcap(nvl(p.nome_social,p.nome)) colaborador,',
'       i.cargo||'' - ''||initcap(fnct_nome_cargo(i.cargo)) cargo,',
'       r.cod_req,',
'       r.cod_empresa,',
'       r.matricula,',
'       r.dt_inscricao',
'  from RP_FUNC_INSCRITOS r, informacoes_funcionais i, inf_pessoais p',
' where r.cod_empresa = i.cod_empresa',
'   and r.cod_empresa = p.cod_empresa',
'   and r.matricula = i.matricula',
'   and r.matricula = p.matricula',
'   and r.cod_req = :p52_cod_req',
' order by r.dt_inscricao, r.cod_empresa, r.matricula'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct p.cod_req',
'  from ps_processo_seletivo p',
' where p.cod_req = :p52_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879215024800908344)
,p_query_column_id=>1
,p_column_alias=>'EMPRESA'
,p_column_display_sequence=>3
,p_column_heading=>'Empresa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879215360478908344)
,p_query_column_id=>2
,p_column_alias=>'FILIAL'
,p_column_display_sequence=>4
,p_column_heading=>'Filial'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879215774845908344)
,p_query_column_id=>3
,p_column_alias=>'CCUSTO'
,p_column_display_sequence=>5
,p_column_heading=>'Centro de Custo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879216153705908345)
,p_query_column_id=>4
,p_column_alias=>'COLABORADOR'
,p_column_display_sequence=>6
,p_column_heading=>'Colaborador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879216539675908345)
,p_query_column_id=>5
,p_column_alias=>'CARGO'
,p_column_display_sequence=>7
,p_column_heading=>'Cargo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879217023341908345)
,p_query_column_id=>6
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879217401318908345)
,p_query_column_id=>7
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879217756167908345)
,p_query_column_id=>8
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879218210534908346)
,p_query_column_id=>9
,p_column_alias=>'DT_INSCRICAO'
,p_column_display_sequence=>10
,p_column_heading=>unistr('Data de Inscri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/rrrr'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879218553654908346)
,p_query_column_id=>10
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>2
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from RP_FUNC_INSCRITOS where cod_req = #COD_REQ# and cod_empresa = #COD_EMPRESA# and matricula = #MATRICULA#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(168153567268194188368)
,p_name=>'Candidatos Inscritos'
,p_region_css_classes=>'nc-req-pessoas'
,p_parent_plug_id=>wwv_flow_api.id(282999052000000000001)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select i.cod_candidato||'' - ''||initcap(nvl(p.nome_social,p.nome)) candidato,',
'       r.cod_req,',
'       r.cod_empresa,',
'       r.cod_candidato,',
'       i.data_apresentacao,',
'			 i.data_convocacao ',
'  from RP_CAND_INSCRITOS r, inf_func_candidato i, inf_pessoais_candidato p',
' where r.cod_candidato = i.cod_candidato',
'   and r.cod_candidato = p.cod_candidato',
'   and r.cod_req = :p52_cod_req',
' order by r.cod_candidato'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct p.cod_req',
'  from ps_processo_seletivo p',
' where p.cod_req = :p52_cod_req'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879219679592908346)
,p_query_column_id=>1
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>2
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879220083547908347)
,p_query_column_id=>2
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879220449857908347)
,p_query_column_id=>3
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879220876102908347)
,p_query_column_id=>4
,p_column_alias=>'COD_CANDIDATO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879221234064908347)
,p_query_column_id=>5
,p_column_alias=>'DATA_APRESENTACAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Data de Apresenta\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_column_format=>'DD/MM/RRRR'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879221702681908347)
,p_query_column_id=>6
,p_column_alias=>'DATA_CONVOCACAO'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Data de Convoca\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_column_format=>'DD/MM/RRRR'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879222055047908347)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from RP_CAND_INSCRITOS where cod_req = #COD_REQ# and cod_candidato = #COD_CANDIDATO#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179845173045743405840)
,p_name=>unistr('Experi\00EAncia em Cargos')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>220
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_new_grid_column=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cargo, initcap(c.nome) nome_cargo, r.anos_cargo, r.meses_cargo, r.cod_empresa, r.cod_cargo',
'  from RP_CARGO r, cargos c',
' where r.cargo = c.cod (+)',
'   and r.cod_empresa = :p52_cod_empresa',
'   and r.cod_cargo = NVL(:p52_cod_cargo,:P52_COD_CARGO_1)',
' order by 2 '))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_COD_CARGO,P52_COD_CARGO_1'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879189085060908327)
,p_query_column_id=>1
,p_column_alias=>'CARGO'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879189501264908328)
,p_query_column_id=>2
,p_column_alias=>'NOME_CARGO'
,p_column_display_sequence=>2
,p_column_heading=>'Cargo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879189845464908328)
,p_query_column_id=>3
,p_column_alias=>'ANOS_CARGO'
,p_column_display_sequence=>3
,p_column_heading=>'Anos'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879190268438908329)
,p_query_column_id=>4
,p_column_alias=>'MESES_CARGO'
,p_column_display_sequence=>4
,p_column_heading=>'Meses'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879190709273908330)
,p_query_column_id=>5
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879191039098908330)
,p_query_column_id=>6
,p_column_alias=>'COD_CARGO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879191506491908331)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_COMANDO_1,P777_TITULO:delete from rp_cargo where cod_empresa = #COD_EMPRESA# and cod_cargo = #COD_CARGO# and cargo = #CARGO#,Apagando'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CARGO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179846295097317364996)
,p_name=>unistr('Tarefas que ir\00E1 desempenhar')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>190
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cod_tarefa_req, t.desc_tarefa_req, r.cod_peso, p.desc_peso, r.seq',
'  from TAR_PESO_TEMP r, tarefa_req t, peso p',
' where r.cod_tarefa_req = t.cod_tarefa_req',
'   and r.cod_peso = p.cod_peso',
'   and r.seq = :p52_seq',
' order by 3'))
,p_display_when_condition=>'P52_COD_REQ'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879192621584908332)
,p_query_column_id=>1
,p_column_alias=>'COD_TAREFA_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879192968532908332)
,p_query_column_id=>2
,p_column_alias=>'DESC_TAREFA_REQ'
,p_column_display_sequence=>3
,p_column_heading=>'Tarefa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879193424858908332)
,p_query_column_id=>3
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879193790767908332)
,p_query_column_id=>4
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879194220654908332)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879194577809908333)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from tar_peso_temp where seq = #SEQ# and cod_tarefa_req = #COD_TAREFA_REQ#,delete from tar_peso_temp where cod_req = &p52_cod_req. and cod_tarefa_req'
||' = #COD_TAREFA_REQ#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179846296012186365006)
,p_name=>unistr('Caracter\00EDsticas para desempenho da fun\00E7\00E3o')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>170
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cod_carac_func, t.desc_carac_func, r.cod_peso, p.desc_peso, r.seq',
'  from CARAC_PESO_TEMP r, carac_func t, peso p',
' where r.cod_carac_func = t.cod_carac_func',
'   and r.cod_peso = p.cod_peso',
'   and r.seq = :p52_seq',
' ORDER BY 3'))
,p_display_when_condition=>'P52_COD_REQ'
,p_display_condition_type=>'ITEM_IS_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_SEQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879195684834908333)
,p_query_column_id=>1
,p_column_alias=>'COD_CARAC_FUNC'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879196107378908333)
,p_query_column_id=>2
,p_column_alias=>'DESC_CARAC_FUNC'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Caracter\00EDstica')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879196431531908333)
,p_query_column_id=>3
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879196921082908334)
,p_query_column_id=>4
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879197316950908334)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879197656399908334)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from carac_peso_temp where seq = #SEQ# and cod_carac_func = #COD_CARAC_FUNC#,delete from carac_peso_temp where cod_req = &p52_cod_req. and cod_carac_'
||'func = #COD_CARAC_FUNC#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_CARAC_FUNCAO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179846375850352246827)
,p_name=>unistr('Tarefas que ir\00E1 desempenhar')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cod_req, r.cod_tarefa_req, t.desc_tarefa_req, r.cod_peso, p.desc_peso',
'  from TAR_PESO r, tarefa_req t, peso p',
' where r.cod_tarefa_req = t.cod_tarefa_req',
'   and r.cod_peso = p.cod_peso',
'   and r.cod_req = :p52_cod_req',
' order by 3'))
,p_display_when_condition=>'P52_COD_REQ'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879198775049908334)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879199177312908335)
,p_query_column_id=>2
,p_column_alias=>'COD_TAREFA_REQ'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879199593419908335)
,p_query_column_id=>3
,p_column_alias=>'DESC_TAREFA_REQ'
,p_column_display_sequence=>4
,p_column_heading=>'Tarefa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879199943355908335)
,p_query_column_id=>4
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879200387042908335)
,p_query_column_id=>5
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879200795464908335)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from tar_peso where cod_req = &P52_COD_REQ. and cod_tarefa_req = #COD_TAREFA_REQ#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179846376624870246835)
,p_name=>unistr('Caracter\00EDsticas para desempenho da fun\00E7\00E3o')
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>180
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_new_grid_column=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cod_req, r.cod_carac_func, t.desc_carac_func, r.cod_peso, p.desc_peso',
'  from CARAC_PESO r, carac_func t, peso p',
' where r.cod_carac_func = t.cod_carac_func',
'   and r.cod_peso = p.cod_peso',
'   and r.cod_req = :p52_cod_req',
' ORDER BY 3'))
,p_display_when_condition=>'P52_COD_REQ'
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879201854205908336)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879202296667908336)
,p_query_column_id=>2
,p_column_alias=>'COD_CARAC_FUNC'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879202714423908336)
,p_query_column_id=>3
,p_column_alias=>'DESC_CARAC_FUNC'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Caracter\00EDstica')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879203107953908336)
,p_query_column_id=>4
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879203512778908336)
,p_query_column_id=>5
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>6
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879203850476908337)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from carac_peso where cod_req = &P52_COD_REQ. and cod_carac_func = #COD_CARAC_FUNC#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_CARAC_FUNCAO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179895175297250494979)
,p_name=>'Ferramentas de Apoio / Equipamentos'
,p_region_css_classes=>'nc-req-lista'
,p_parent_plug_id=>wwv_flow_api.id(6858879248139043126)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>210
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select B.cod_beneficio codigo, initcap(B.descr_beneficio) descricao, B.valor_padrao valor, :P52_SEQ SEQ',
'from   beneficios B, beneficios_vaga_temp t',
'where b.cod_beneficio = t.cod_beneficio',
'  and ((:p52_cod_req is null and t.seq = :p52_seq) or ',
'       (t.cod_requisicao = :p52_cod_req))',
'order by 2'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_SEQ,P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879212301797908343)
,p_query_column_id=>1
,p_column_alias=>'CODIGO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879212659943908343)
,p_query_column_id=>2
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Descri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879213030594908343)
,p_query_column_id=>3
,p_column_alias=>'VALOR'
,p_column_display_sequence=>4
,p_column_heading=>'Valor'
,p_use_as_row_header=>'N'
,p_column_format=>'FML999G999G999G999G990D00'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879213444695908343)
,p_query_column_id=>4
,p_column_alias=>'SEQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879213845370908344)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from beneficios_vaga_temp where seq = #SEQ# and cod_beneficio = #CODIGO#,delete from beneficios_vaga_temp where cod_requisicao = &P52_COD_REQ. and co'
||'d_beneficio = #CODIGO#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CODIGO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329118462691656)
,p_plug_name=>unistr('Caracter\00EDsticas do Candidato<span class="nc-native-header__subtitle">Escolaridade, tempo de servi\00E7o e acessibilidade</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'CARACTERISTICA_CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(6849870757729323429)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329206667691657)
,p_plug_name=>'Idade'
,p_parent_plug_id=>wwv_flow_api.id(170359329118462691656)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329268999691658)
,p_plug_name=>'Sexo'
,p_parent_plug_id=>wwv_flow_api.id(170359329118462691656)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329777970691663)
,p_plug_name=>unistr('Grau de Instru\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(170359329118462691656)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(54947222063212418824)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'REQUISICAO'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u'
,p_update_authorization_scheme=>wwv_flow_api.id(39665145016059181859)
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329947293691664)
,p_plug_name=>unistr('Indica\00E7\00E3o de Candidato<span class="nc-native-header__subtitle">Candidato indicado pelo requisitante</span>')
,p_region_css_classes=>'nc-req-opcional'
,p_region_name=>'INDICACAO_CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(6849870757729323429)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849870870397323430)
,p_plug_name=>'Detalhamento'
,p_region_css_classes=>'nc-req-etapa'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6858879449382043128)
,p_plug_name=>'Perfil da Vaga<span class="nc-native-header__subtitle">Contexto organizacional e expectativas</span>'
,p_region_css_classes=>'nc-req-opcional nc-req-textos'
,p_parent_plug_id=>wwv_flow_api.id(6849870870397323430)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>270
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179886859503200070394)
,p_plug_name=>unistr('Detalhamento da Requisi\00E7\00E3o<span class="nc-native-header__subtitle">Descritivo das atividades e observa\00E7\00F5es gerais</span>')
,p_region_css_classes=>'nc-req-escrita'
,p_region_name=>'detalhamento'
,p_parent_plug_id=>wwv_flow_api.id(6849870870397323430)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>250
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(29306577375839907481)
,p_plug_name=>'Download'
,p_region_name=>'relatorio_anexos'
,p_parent_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(54947229620665418836)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>7
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'  cod_req,',
'  anexo_filename_1 AS nome_arquivo,',
'  anexo_mimetype_1 AS tipo_arquivo,',
'  anexo_data_1     AS data_upload,',
'  cod_req          AS link_download,',
' /*  ''<button type="button" class="t-Button t-Button--danger t-Button--small btn-remover" data-codreq="'' || cod_req || ''">',
'   <span class="fa fa-trash"></span> Remover',
'</button>''',
' AS remover_botao*/',
' ',
'''<button type="button" class="t-Button t-Button--danger t-Button--outline t-Button--simple btn-remover" data-codreq="'' || cod_req || ''">',
'   <span class="fa fa-trash" aria-hidden="true"></span> Remover',
'</button>''',
'',
'',
' AS remover_botao',
'FROM requisicao',
'WHERE ',
' COD_REQ = :P52_COD_REQ',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_column_width=>'style=''margin-top:20px;'''
,p_plug_display_condition_type=>'EXISTS'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'  cod_req,',
'  anexo_filename_1 AS nome_arquivo,',
'  anexo_mimetype_1 AS tipo_arquivo,',
'  anexo_data_1     AS data_upload,',
'  cod_req          AS link_download,',
'    ''<button class="t-Button t-Button--danger t-Button--small btn-remover" data-codreq="'' || cod_req || ''">',
'     <span class="fa fa-trash" aria-hidden="true"></span> Remover',
'   </button>'' AS remover_botao',
'FROM requisicao',
'WHERE ',
' COD_REQ = :P52_COD_REQ',
' and anexo_1 is not null;'))
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(29306577935720907487)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'AARAO.PRIMO'
,p_internal_uid=>982892122941994128
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306578056406907488)
,p_db_column_name=>'COD_REQ'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Cod Req'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306578131112907489)
,p_db_column_name=>'NOME_ARQUIVO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Arquivo'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'STRING'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306578300137907490)
,p_db_column_name=>'TIPO_ARQUIVO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Tipo Arquivo'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306578338365907491)
,p_db_column_name=>'DATA_UPLOAD'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Data Upload'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306578671439907494)
,p_db_column_name=>'LINK_DOWNLOAD'
,p_display_order=>50
,p_column_identifier=>'G'
,p_column_label=>' <b></b>'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_allow_hide=>'N'
,p_column_type=>'NUMBER'
,p_column_alignment=>'CENTER'
,p_format_mask=>'DOWNLOAD:REQUISICAO:ANEXO_1:COD_REQ::ANEXO_MIMETYPE_1:ANEXO_FILENAME_1:ANEXO_DATA_1:ANEXO_CHARSET_1:inline:<span class="fa fa-download" aria-hidden="true"></span> Download:'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(29306579017815907498)
,p_db_column_name=>'REMOVER_BOTAO'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'<b></b>'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(29310601941405128054)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'9869162'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'NOME_ARQUIVO:LINK_DOWNLOAD::REMOVER_BOTAO'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179886872691467070412)
,p_plug_name=>unistr('Parecer<span class="nc-native-header__subtitle">Manifesta\00E7\00E3o do RH e do Or\00E7amento</span>')
,p_region_css_classes=>'nc-req-ficha nc-req-textos'
,p_parent_plug_id=>wwv_flow_api.id(6849870870397323430)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>280
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849870982742323431)
,p_plug_name=>unistr('Remunera\00E7\00E3o')
,p_region_css_classes=>'nc-req-etapa'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359328775998691653)
,p_plug_name=>unistr('Remunera\00E7\00E3o<span class="nc-native-header__subtitle">Sal\00E1rio, benef\00EDcios e aux\00EDlios</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'REMUNERACAO'
,p_parent_plug_id=>wwv_flow_api.id(6849870982742323431)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359329601330691661)
,p_plug_name=>unistr('Insalubridade / Periculosidade<span class="nc-native-header__subtitle">Adicionais legais aplic\00E1veis \00E0 vaga</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'INSALUBRIDADE'
,p_parent_plug_id=>wwv_flow_api.id(6849870982742323431)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359331864683691683)
,p_plug_name=>unistr('Projeto e Contrato<span class="nc-native-header__subtitle">V\00EDnculo com contrato de cliente e prazos</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'PROJETO'
,p_parent_plug_id=>wwv_flow_api.id(6849870982742323431)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179546776121224386958)
,p_plug_name=>unistr('Indica\00E7\00E3o Para Avaliar Requisi\00E7\00E3o<span class="nc-native-header__subtitle">Gestor respons\00E1vel e avaliador da requisi\00E7\00E3o</span>')
,p_region_css_classes=>'nc-req-plano'
,p_region_name=>'INDICACAO_AVALIAR'
,p_parent_plug_id=>wwv_flow_api.id(6849870982742323431)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179546776410817386961)
,p_plug_name=>'Gestor'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(179546776121224386958)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179546776469422386962)
,p_plug_name=>'Avaliador'
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(179546776121224386958)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849871164879323433)
,p_plug_name=>'Cargo'
,p_region_css_classes=>'nc-req-etapa'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849871147793323432)
,p_plug_name=>unistr('Controle de Frequ\00EAncia<span class="nc-native-header__subtitle">Marca\00E7\00E3o de ponto e ciclo de escala</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(6849871164879323433)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359328657257691651)
,p_plug_name=>unistr('Hor\00E1rio Contratual<span class="nc-native-header__subtitle">Modalidade, carga hor\00E1ria e hor\00E1rio contratual</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'FREQUENCIA'
,p_parent_plug_id=>wwv_flow_api.id(6849871164879323433)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359328723106691652)
,p_plug_name=>unistr('Cargo<span class="nc-native-header__subtitle">Enquadramento do cargo, fun\00E7\00E3o e categoria</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_region_name=>'CARGO'
,p_parent_plug_id=>wwv_flow_api.id(6849871164879323433)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6852160956095270131)
,p_plug_name=>unistr('Identifica\00E7\00E3o')
,p_region_css_classes=>'nc-req-etapa'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6852160584625270127)
,p_plug_name=>unistr('Informa\00E7\00F5es da Vaga<span class="nc-native-header__subtitle">Tipo de vaga, n\00FAmero de posi\00E7\00F5es e confidencialidade</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(37495107094942432643)
,p_plug_name=>unistr('Bot\00F5es Requisi\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_css_classes=>'nc-stepper-host nc-req-acoes'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>3
,p_plug_display_column=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179886874315208070413)
,p_plug_name=>unistr('Solicita\00E7\00E3o')
,p_region_css_classes=>'nc-req-ficha nc-req-solicitacao'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179886881794701070421)
,p_name=>'Aprovadores'
,p_region_css_classes=>'nc-req-aprovadores'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from aprova_req a, usuario_oracle u',
' where a.cod_req = :p52_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'   --and u.cd_perfil NOT IN (''BUSINESS PARTNER'',''REMUNERACAO'',''CONT DE NEGOCIOS'')',
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
'  from aprova_req a, usuario_oracle u',
' where a.cod_req = :p52_cod_req ',
'   and a.cod_emp_aprov = u.cd_empresa',
'   and a.mat_aprov = u.cd_matricula',
'  -- and u.cd_perfil = ''BUSINESS PARTNER''',
'   and exists (select 1',
'                 from perfil_aprovadores x',
'                where x.cd_perfil = u.cd_perfil)',
'   and not exists (select 1 ',
'                 from suplentes s',
'                where s.cod_emp_supl = a.cod_emp_aprov',
'                  and s.matricula_supl = a.mat_aprov',
'                  and a.dt_atualizacao between trunc(s.dt_inic_supl) and nvl(trunc(s.dt_fim_supl),sysdate))',
' GROUP BY U.CD_PERFIL, a.dt_aprov, a.STATUS_APROV, a.justificativa',
'ORDER BY 7'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_req',
'  from aprova_req ',
' where cod_req = :p52_cod_req',
'   and nvl(:p52_prospeccao,''N'') = ''N''',
'   and :p52_cod_sit_req <> 0'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879118762553908285)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879119194630908286)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879119560774908286)
,p_query_column_id=>3
,p_column_alias=>'DATA'
,p_column_display_sequence=>3
,p_column_heading=>'Data'
,p_use_as_row_header=>'N'
,p_column_format=>'dd/mm/yyyy hh24:mi'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879119997485908287)
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
 p_id=>wwv_flow_api.id(37879120392830908287)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879120729344908287)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879121220114908287)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879121558362908288)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170359328940684691654)
,p_plug_name=>'Vaga e Local'
,p_plug_comment=>unistr('Desligada pelo desenho da ficha da vaga: as regi\00F5es de dentro foram para a Identifica\00E7\00E3o. Uma a\00E7\00E3o din\00E2mica que mostre/esconda esta regi\00E3o (VAGA) n\00E3o tem mais efeito sobre elas.')
,p_region_name=>'VAGA'
,p_parent_plug_id=>wwv_flow_api.id(6852160517838270126)
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_display_condition_type=>'NEVER'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849871255612323434)
,p_plug_name=>unistr('Publica\00E7\00E3o de Vaga<span class="nc-native-header__subtitle">Divulga\00E7\00E3o interna e externa</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849871349759323435)
,p_plug_name=>unistr('Local de Trabalho<span class="nc-native-header__subtitle">Endere\00E7o de presta\00E7\00E3o e detalhes de apoio</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(6849871542875323436)
,p_plug_name=>unistr('Empresa e Estrutura<span class="nc-native-header__subtitle">Onde a vaga ser\00E1 alocada dentro da estrutura organizacional</span>')
,p_region_css_classes=>'nc-req-ficha'
,p_parent_plug_id=>wwv_flow_api.id(6852160956095270131)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(54947230140706418838)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(37495107718223432650)
,p_plug_name=>unistr('Motivo de Situa\00E7\00E3o')
,p_region_name=>'MOTIVO'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>190
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(167882312766428043366)
,p_plug_name=>unistr('Requisi\00E7\00F5es Descendentes')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(167882311902934043358)
,p_name=>unistr('Requisi\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(167882312766428043366)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('select r.cod_req||'' (''||case when r.cod_sit_req <> 0 then initcap(s.desc_sit_req) else ''Em Revis\00E3o'' end||'')'' requisicao, cod_req, cod_empresa'),
'  from requisicao r, sit_req s',
' where r.cod_req_pai = :p52_cod_req',
'   and r.cod_sit_req = s.cod_sit_req (+)',
'order by r.cod_req'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>5
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_WITH_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879128829360908293)
,p_query_column_id=>1
,p_column_alias=>'REQUISICAO'
,p_column_display_sequence=>1
,p_column_link=>'f?p=&APP_ID.:52:&SESSION.::&DEBUG.:RP,52:P52_COD_EMPRESA,P52_COD_REQ:#COD_EMPRESA#,#COD_REQ#'
,p_column_linktext=>'#REQUISICAO#'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879129241528908293)
,p_query_column_id=>2
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879129654733908293)
,p_query_column_id=>3
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168080630852129356596)
,p_plug_name=>'Colaborador Inscrito'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>170
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(168153569419253188390)
,p_plug_name=>'Candidato Inscrito'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>180
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170360453166451838369)
,p_plug_name=>unistr('Forma\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>140
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170360454139014838378)
,p_plug_name=>unistr('Experi\00EAncia')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>150
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(170360454808935838385)
,p_plug_name=>'Conhecimento'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>160
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179676443925705538066)
,p_plug_name=>'Avaliar Candidatos'
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>240
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179676713129508140528)
,p_name=>'Candidatos'
,p_parent_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_template=>wwv_flow_api.id(54947230140706418838)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select DISTINCT p.nota_de_corte, ',
'        (select i.cod_candidato||'' - ''||initcap(i.nome) ',
'           from inf_pessoais_candidato i',
'          where i.cod_candidato = c.cod_candidato) candidato,',
'        c.ind_aval_fase nota,',
'        c.date_fase data_fase_candidato,',
'        c.resultado_fase observacao,',
unistr('        decode(nvl(check_aprov,''N''),''N'',''N\00E3o'',''S'',''Sim'') aprovado'),
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c, PS_FASE_PADRAO_CARGO r',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'    and p.cod_fase = r.cod_fase',
'    and c.ind_aval_fase is not null',
'    and trunc(sysdate) between nvl(p.dt_inicio_fase,trunc(sysdate)) and nvl(p.dt_fim_fase,trunc(sysdate))',
'    and r.ind_responsavel in (''G'',''A'')'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_FASE_PS'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879142580201908303)
,p_query_column_id=>1
,p_column_alias=>'NOTA_DE_CORTE'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879142971907908303)
,p_query_column_id=>2
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>1
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879143330480908303)
,p_query_column_id=>3
,p_column_alias=>'NOTA'
,p_column_display_sequence=>3
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879143753139908303)
,p_query_column_id=>4
,p_column_alias=>'DATA_FASE_CANDIDATO'
,p_column_display_sequence=>6
,p_column_heading=>'Data de Fase'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879144170362908303)
,p_query_column_id=>5
,p_column_alias=>'OBSERVACAO'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Observa\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879144596295908304)
,p_query_column_id=>6
,p_column_alias=>'APROVADO'
,p_column_display_sequence=>5
,p_column_heading=>'Aprovado'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179730261899348059513)
,p_plug_name=>'Idioma'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>120
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179746362601699552674)
,p_plug_name=>unistr('Informa\00E7\00F5es do Cargo')
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>200
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179751985115900947909)
,p_plug_name=>'Processo Seletivo'
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>210
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179753221196003269282)
,p_name=>'Acompanhamento de Candidatos'
,p_template=>wwv_flow_api.id(54947228710027418835)
,p_display_sequence=>220
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select c.cod_candidato||'' - ''||initcap(p.nome) candidato,',
'       decode(p.status_candidato,''P'',''Pendente'',''A'',''Admitido'',p.status_candidato) status_candidato,',
'       initcap(f.desc_fase) fase,',
'       to_date(c.date_fase,''dd/mm/rrrr'') dt_fase,',
'       c.cod_prest_serv_avaliador||'' - ''||initcap(ip.nome) avaliador,',
'       c.ind_aval_fase nota,',
'       c.resultado_fase,',
'       c.mot_aval_fase,',
'       initcap(a.desc_aval_fase) Avaliacao,',
'       c.data_aval_fase,',
unistr('       decode(c.check_aprov,''S'',''Sim'',''N'',''N\00E3o'') Aprovado'),
'  from candidato c, inf_pessoais_candidato p, fase_candidato f, inf_pessoais ip, avaliacao_fase a',
' where c.cod_candidato = p.cod_candidato',
'   and c.cod_fase = f.cod_fase',
'   and c.cod_prest_serv_avaliador = ip.matricula (+)',
'   and c.cod_aval_fase = a.cod_aval_fase (+)',
'   and c.cod_req  = :p52_cod_req',
'   and c.cod_fase = nvl(:p52_fase_cand,c.cod_fase)',
'   and c.cod_candidato = nvl(:P52_CANDIDATO_ACMP,c.cod_candidato)',
' order by c.date_fase asc, c.cod_candidato asc'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_FASE_CAND,P52_CANDIDATO_ACMP'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum candidato selecionado para este processo seletivo'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879159685359908312)
,p_query_column_id=>1
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>1
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879160085634908312)
,p_query_column_id=>2
,p_column_alias=>'STATUS_CANDIDATO'
,p_column_display_sequence=>2
,p_column_heading=>'Status Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879160449983908312)
,p_query_column_id=>3
,p_column_alias=>'FASE'
,p_column_display_sequence=>3
,p_column_heading=>'Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879160881225908312)
,p_query_column_id=>4
,p_column_alias=>'DT_FASE'
,p_column_display_sequence=>4
,p_column_heading=>'Data Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879161239297908312)
,p_query_column_id=>5
,p_column_alias=>'AVALIADOR'
,p_column_display_sequence=>5
,p_column_heading=>'Avaliador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879161697763908312)
,p_query_column_id=>6
,p_column_alias=>'NOTA'
,p_column_display_sequence=>6
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879162053766908312)
,p_query_column_id=>7
,p_column_alias=>'RESULTADO_FASE'
,p_column_display_sequence=>7
,p_column_heading=>'Resultado Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879162491168908313)
,p_query_column_id=>8
,p_column_alias=>'MOT_AVAL_FASE'
,p_column_display_sequence=>9
,p_column_heading=>'Mot. Aval. Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879162889811908313)
,p_query_column_id=>9
,p_column_alias=>'AVALIACAO'
,p_column_display_sequence=>8
,p_column_heading=>unistr('Avalia\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879163258767908313)
,p_query_column_id=>10
,p_column_alias=>'DATA_AVAL_FASE'
,p_column_display_sequence=>10
,p_column_heading=>'Data Aval. Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879163703120908313)
,p_query_column_id=>11
,p_column_alias=>'APROVADO'
,p_column_display_sequence=>11
,p_column_heading=>'Aprovado'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(179753385274988129079)
,p_name=>'Fases do Processo'
,p_template=>wwv_flow_api.id(54947228710027418835)
,p_display_sequence=>230
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select s.cod_req, ',
'        p.cod_processo, ',
'        p.cod_fase||'' - ''||initcap(f.desc_fase) fase, ',
'        p.nota_de_corte, ',
'        p.dt_inicio_fase, ',
'        p.dt_fim_fase, ',
'        decode(p.status,''A'',''Ativo'',''F'',''Finalizado'',''C'',''Cancelado'') Status, ',
'        e.cod_entidade||'' - ''||initcap(e.nome_entidade) entidade, ',
'        p.sla, ',
'        p.observacao, ',
'        (select i.cod_candidato||'' - ''||initcap(i.nome) ',
'           from inf_pessoais_candidato i',
'          where i.cod_candidato = c.cod_candidato) candidato,',
'        c.ind_aval_fase nota,',
'        c.date_fase data_fase_candidato',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and c.cod_candidato = nvl(:P52_CANDIDATO_FASE,c.cod_candidato)',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'  order by 1,2,3'))
,p_display_condition_type=>'NEVER'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ,P52_FASE_PS,P52_CANDIDATO_FASE'
,p_query_row_template=>wwv_flow_api.id(54947238952260418854)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Nenhum fase selecionada para este processo seletivo'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879165191307908314)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879165612164908315)
,p_query_column_id=>2
,p_column_alias=>'COD_PROCESSO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879165998975908315)
,p_query_column_id=>3
,p_column_alias=>'FASE'
,p_column_display_sequence=>3
,p_column_heading=>'Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879166360285908315)
,p_query_column_id=>4
,p_column_alias=>'NOTA_DE_CORTE'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879166767989908315)
,p_query_column_id=>5
,p_column_alias=>'DT_INICIO_FASE'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Data In\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879167194540908315)
,p_query_column_id=>6
,p_column_alias=>'DT_FIM_FASE'
,p_column_display_sequence=>5
,p_column_heading=>'Data Fim'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879167591574908315)
,p_query_column_id=>7
,p_column_alias=>'STATUS'
,p_column_display_sequence=>6
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879167943996908315)
,p_query_column_id=>8
,p_column_alias=>'ENTIDADE'
,p_column_display_sequence=>7
,p_column_heading=>'Entidade'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879168348544908316)
,p_query_column_id=>9
,p_column_alias=>'SLA'
,p_column_display_sequence=>8
,p_column_heading=>'SLA'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879168781420908316)
,p_query_column_id=>10
,p_column_alias=>'OBSERVACAO'
,p_column_display_sequence=>9
,p_column_heading=>unistr('Observa\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879169155077908316)
,p_query_column_id=>11
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>10
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879169563400908316)
,p_query_column_id=>12
,p_column_alias=>'NOTA'
,p_column_display_sequence=>12
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(37879169945323908316)
,p_query_column_id=>13
,p_column_alias=>'DATA_FASE_CANDIDATO'
,p_column_display_sequence=>13
,p_column_heading=>'Data Fase Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179778299604877536966)
,p_plug_name=>'Escolha: Ferramentas de Apoio / Equipamentos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>130
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179846296708447365013)
,p_plug_name=>'Cursos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179846373943795246808)
,p_plug_name=>'Cargos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179846458758377116093)
,p_plug_name=>'Tarefas'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179846460343554116109)
,p_plug_name=>unistr('Caracter\00EDsticas')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(54947228710027418835)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(179886885387595070431)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(54947222146384418825)
,p_plug_display_sequence=>11
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37495107903982432652)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(37495107718223432650)
,p_button_name=>'confirmar_mot_sit_req'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-chev'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879130337214908294)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(168080630852129356596)
,p_button_name=>'create_colab_inscrito'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879132299418908295)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(168153569419253188390)
,p_button_name=>'create_cand_inscrito'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879108513740908270)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(37495107094942432643)
,p_button_name=>'Descendentes'
,p_button_static_id=>'DESCENDENTES'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight:t-Button--stretch:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('(&P52_QTD_POSICAO.) Requisi\00E7\00F5es Descendentes')
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :p52_qtd_posicao > 1 then',
'return true;',
'else ',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-share-alt'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37495106983999432642)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(37495107094942432643)
,p_button_name=>'REQ_CANCELAR'
,p_button_static_id=>'CANCELAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ in (0,1,5) and ((:p_usuario = :p52_usuario) or ',
'  (:p52_cod_emp_req = :p_empresa_user and :p52_mat_req = :p_matricula_user) or ',
'  (:p_perfil in (''MASTER'',''REMUNERACAO'',''FOLHA'') ))  then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37495108853466432661)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(37495107094942432643)
,p_button_name=>'REQ_SUSPENDER'
,p_button_static_id=>'SUSPENDER'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Suspender'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_sit_req in (1) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-pause'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37382432197905857746)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(37495107094942432643)
,p_button_name=>'REQ_REVISAR'
,p_button_static_id=>'REVISAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Revisar'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ in (1,5) and ',
'((:p_usuario = :p52_usuario) or ',
'  (:p52_cod_emp_req = :p_empresa_user and :p52_mat_req = :p_matricula_user) or ',
'  (:p_perfil in (''MASTER'',''REMUNERACAO'',''FOLHA'') )) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37495108579038432658)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(37495107094942432643)
,p_button_name=>'REQ_PUBLICAR'
,p_button_static_id=>'PUBLICAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconLeft:t-Button--stretch:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Publicar'
,p_button_position=>'BODY'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ in (0,6) and ((:p_usuario = :p52_usuario) or ',
'  (:p52_cod_emp_req = :p_empresa_user and :p52_mat_req = :p_matricula_user) or ',
'  (:p_perfil in (''MASTER'',''REMUNERACAO'',''FOLHA'') ))  then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879139924640908302)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_button_name=>'adicionar_nota'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atribuir'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(29306576320336907471)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_button_name=>'BT_ENVIAR_ARQUIVO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar Arquivo'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP:P2_COD_REQ:&P52_COD_REQ.'
,p_button_condition=>'P52_COD_SIT_REQ'
,p_button_condition2=>'1'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-plus'
,p_button_cattributes=>'style=''margin-top:30px;'''
,p_grid_new_row=>'Y'
,p_grid_column_span=>3
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879204951082908337)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_button_name=>'clear_anexo_1'
,p_button_static_id=>'CLEAR_ANEXO_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny'
,p_button_template_id=>wwv_flow_api.id(54947250816233418879)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Limpar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879108891597908271)
,p_button_sequence=>170
,p_button_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_button_name=>'p52_btn_solicitante'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight:t-Button--gapTop'
,p_button_template_id=>wwv_flow_api.id(54947250816233418879)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P52 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=CONSULTAS_&P_BASE.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P52_COD_EMP_REQ.,&P52_MAT_REQ.'
,p_button_condition=>'P52_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879122786832908289)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_button_name=>'p52_btn_reprovar_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_req ',
' where cod_req = :p52_cod_req_x',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'IF 1 = 2 THEN',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'  pkg_pessoal.Valida_Sequencia (:p52_cod_empresa, :p52_cod_req_x, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'      IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'          RETURN TRUE;',
'      ELSE',
'          RETURN FALSE;',
'      END IF;',
'',
'  ELSE',
'',
'  RETURN FALSE;',
'',
'  END IF;',
'',
'END IF;',
'',
'return false;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879145651794908304)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179730261899348059513)
,p_button_name=>'CLOSE_IDIOMA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879173851378908320)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_button_name=>'CLOSE_CURSOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879176968662908322)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179846373943795246808)
,p_button_name=>'CLOSE_CARGOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879179294014908323)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179846458758377116093)
,p_button_name=>'CLOSE_TAREFA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879181161220908323)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179846460343554116109)
,p_button_name=>'CLOSE_CARACTERISTICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879123140909908289)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_button_name=>'p52_btn_reprovar_1_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.,R,&P52_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_req ',
' where cod_req = :p52_cod_req_x',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'pkg_pessoal.Valida_Sequencia (:p52_cod_empresa, :p52_cod_req_x, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879127475007908292)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879127860714908292)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879145274475908304)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179730261899348059513)
,p_button_name=>'CREATE_IDIOMA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879173476810908320)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_button_name=>'CREATE_CURSOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879176577282908321)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846373943795246808)
,p_button_name=>'CREATE_CARGOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879178878847908322)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846458758377116093)
,p_button_name=>'CREATE_TAREFA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879180808055908323)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846460343554116109)
,p_button_name=>'CREATE_CARACTERISTICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879125480478908291)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'CRIAR_IGUAL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar igual'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :p52_flag_temporario = ''S'' then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-share-alt'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879125854939908291)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'CHAT_SUPPORT'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>unistr('D\00FAvidas')
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=PO_&P_BASE.:765:&SESSION.::&DEBUG.:RP,765:P765_URL:http'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-question-circle'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879122018197908288)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_button_name=>'p52_btn_aprovar_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_req ',
' where cod_req = :p52_cod_req_x',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'if 1 = 2 then',
'',
'  OPEN C1;',
'  FETCH C1 INTO V_C1;',
'  CLOSE C1;',
'',
'  IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'  pkg_pessoal.Valida_Sequencia (:p52_cod_empresa, :p52_cod_req_x, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'      IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'          RETURN TRUE;',
'      ELSE',
'          RETURN FALSE;',
'      END IF;',
'',
'  ELSE',
'',
'  RETURN FALSE;',
'',
'  END IF;',
'',
'end if;',
'',
'return false;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879126298325908291)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'ps'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Processo Seletivo'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:23:&SESSION.::&DEBUG.:RP,23:P23_APP_CALLED,P23_PAGE_CALLED,P23_COD_REQ,P23_COD_EMPRESA:RS_PRC,29,&P52_COD_REQ.,&P52_COD_EMPRESA.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct p.cod_req',
'  from ps_processo_seletivo p',
' where p.cod_req = :p52_cod_req'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879122365302908288)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_button_name=>'p52_btn_aprovar_1_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_TEXTO,P1_STATUS,P1_COD_REQ:Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.,A,&P52_COD_REQ.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from aprova_req ',
' where cod_req = :p52_cod_req_x',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER',
'   and status_aprov = ''P'';',
'',
'V_C1 C1%ROWTYPE;',
'',
'V_FLG_RETORNO VARCHAR2(1);',
'V_MSG_RETORNO VARCHAR2(4000);',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL THEN',
'',
'pkg_pessoal.Valida_Sequencia (:p52_cod_empresa, :p52_cod_req_x, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
'',
'    IF TRIM(V_MSG_RETORNO) IS NULL THEN',
'        RETURN TRUE;',
'    ELSE',
'        RETURN FALSE;',
'    END IF;',
'',
'ELSE',
'',
'RETURN FALSE;',
'',
'END IF;',
'',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879126659197908291)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'SAVE'
,p_button_static_id=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879127043764908292)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(179886885387595070431)
,p_button_name=>'CREATE'
,p_button_static_id=>'CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P52_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879185295494908326)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179729913498326141848)
,p_button_name=>'add_idioma'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879188415883908327)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179845172619887405836)
,p_button_name=>'add_formacao'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879191827937908331)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179845173045743405840)
,p_button_name=>'add_cargos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879194966242908333)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846295097317364996)
,p_button_name=>'add_tarefas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879198047323908334)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846296012186365006)
,p_button_name=>'add_caracteristicas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879201128422908335)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846375850352246827)
,p_button_name=>'add_tarefas_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879204319107908337)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179846376624870246835)
,p_button_name=>'add_caracteristicas_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879214318441908344)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179895175297250494979)
,p_button_name=>'chama_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879218974775908346)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(168080629306856356580)
,p_button_name=>'add_colab'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879222521715908347)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(168153567268194188368)
,p_button_name=>'add_cand'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879229827673908352)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_button_name=>'cargo'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Detalhes do Cargo'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879239407267908356)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_button_name=>'AJUSTAR_REMUNERACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ajustar Valores'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and ',
'--:p52_cod_vaga is null and',
':p52_cod_sit_req in (0,1,5) and ',
':p52_tipo_modalidade <> ''E'' and',
'(:p_perfil IN (''MASTER'',''REMUNERACAO'') or :p52_cod_sit_req in (0)) then',
'return true;',
'/*elsif :p52_rowid is not null and ',
':p52_cod_sit_req in (0,1,5) and ',
':p52_tipo_modalidade = ''E'' and',
'(:p_perfil IN (''MASTER'',''REMUNERACAO'',''SELECAO'') or :p52_cod_sit_req in (0)) then',
'return true;*/',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879288703937908382)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170359332526286691690)
,p_button_name=>'add_cursos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879291781266908383)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170359333474776691700)
,p_button_name=>'add_experiencia'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879294525121908384)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170360452221720838359)
,p_button_name=>'add_conhecimento'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879246831876908359)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(170359328940684691654)
,p_button_name=>'New'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(54947250932304418882)
,p_button_image_alt=>'New'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879133386348908295)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170360453166451838369)
,p_button_name=>'create_Formacao'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879135698064908299)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170360454139014838378)
,p_button_name=>'create_experiencia'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879137946018908301)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(170360454808935838385)
,p_button_name=>'create_conhecimento'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879151115291908308)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_button_name=>'AVALIAR_CANDIDATOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Avaliar Candidatos'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct p.cod_processo',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c, PS_FASE_PADRAO_CARGO r',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'    and p.cod_fase = r.cod_fase',
'    and trunc(sysdate) between p.dt_inicio_fase and nvl(p.dt_fim_fase,trunc(sysdate))',
'    and r.ind_responsavel in (''G'',''A'')'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-thumbs-o-up'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879151458477908308)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_button_name=>'candidatos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Candidatos'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879171489084908317)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(179778299604877536966)
,p_button_name=>'create_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(37879151843267908308)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_button_name=>'fases'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(54947251106024418882)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Fases'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-sitemap'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(37879561007959908517)
,p_branch_name=>'Go To Page 51'
,p_branch_action=>'f?p=&APP_ID.:51:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(37879560567204908517)
,p_branch_name=>'Go To Page P_PAGE_BRANCH'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(37879560130707908516)
,p_branch_name=>'Go To Page 51 (Submit)'
,p_branch_action=>'f?p=&APP_ID.:51:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>11
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'APROVACAO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9616588720180980778)
,p_name=>'P52_EMPAUX'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9616588803346980779)
,p_name=>'P52_FILAUX'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9616588887521980780)
,p_name=>'P52_FLAGAUX'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9633250834159431564)
,p_name=>'P52_VALSIND'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15040750550097028133)
,p_name=>'P52_JORNADA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Jornada'
,p_source=>'COD_JORNADA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct b.cod_jornada||''-''||b.nome_jornada||'' [''||a.jornada_mensal_h||'':''||replace(a.jornada_mensal_m,0,''00'')||'']'', b.cod_jornada',
'  from reg_trabalho a,',
'       pe_jornadas b',
' where a.jornada_mensal_h||'':''||replace(a.jornada_mensal_m,0,''00'')=b.total_horas_mensais',
'   and to_char(a.cod) = to_Char(nvl(nvl(:P52_RT_JORNADA_MENSAL_1,:P52_RT_JORNADA_MENSAL),:P52_RT_JORNADA_MENSAL_Z))',
' order by 2;',
' ',
' '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_RT_JORNADA_MENSAL_Z'
,p_ajax_items_to_submit=>'P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_RT_JORNADA_MENSAL_Z'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068288188430881684)
,p_name=>'P52_ESCALA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Escala'
,p_source=>'COD_ESCALA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ESC.COD_ESCALA||'' - ''|| ESC.DESCRICAO DISPLAY',
'   ,   ESC.COD_ESCALA',
'  from pe_escalas_jornadas ESJO',
'     , pe_escalas ESC',
' WHERE ESC.COD_ESCALA = ESJO.COD_ESCALA',
'   AND TO_CHAR(ESJO.COD_JORNADA) = TO_CHAR(:P52_JORNADA);'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_JORNADA'
,p_ajax_items_to_submit=>'P52_JORNADA'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068288270418881685)
,p_name=>'P52_CICLO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Ciclo'
,p_source=>'COD_CICLO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct b.COD_CICLO||''-''||b.NOME_CICLO||'' [''||b.TOTAL_HORAS_MENSAIS||'']'' display , b.COD_CICLO',
'  from reg_trabalho a,',
'       pe_ciclo_escalas b',
' where a.jornada_mensal_h||'':''||replace(a.jornada_mensal_m,0,''00'')=b.TOTAL_HORAS_MENSAIS',
'   and to_char(a.cod) = to_char(nvl(nvl(:P52_RT_JORNADA_MENSAL_1,:P52_RT_JORNADA_MENSAL),:P52_RT_JORNADA_MENSAL_Z))',
'and B.STATUS = ''A''',
' order by 2;',
' '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_RT_JORNADA_MENSAL_Z'
,p_ajax_items_to_submit=>'P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_RT_JORNADA_MENSAL_Z'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068288350151881686)
,p_name=>'P52_TIPO_PONTO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_prompt=>'Tipo de Escala'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Jornada/Escala;J,Ciclo;C'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068289314747881695)
,p_name=>'P52_CICLO_INICIAL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Ciclo Inicial'
,p_source=>'COD_CICLO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'   SELECT  NOME_COLUNA ||  case when VALOR_CICLO = ''F'' THEN '' - Folga'' ',
'                                       when VALOR_CICLO = ''C'' THEN '' - Compensado'' else null end display',
',COD_CICLO',
'  FROM (',
'    SELECT COD_CICLO, ',
'        CICLO_1, CICLO_2, CICLO_3, CICLO_4, CICLO_5, CICLO_6, CICLO_7, CICLO_8, CICLO_9, CICLO_10, ',
'        CICLO_11, CICLO_12, CICLO_13, CICLO_14, CICLO_15, CICLO_16, CICLO_17, CICLO_18, CICLO_19, CICLO_20, ',
'        CICLO_21, CICLO_22, CICLO_23, CICLO_24, CICLO_25, CICLO_26, CICLO_27, CICLO_28, CICLO_29, CICLO_30, CICLO_31',
'    FROM PE_CICLO_ESCALAS',
'    WHERE COD_EMPRESA = :P52_COD_EMPRESA',
'      and TO_CHAR(COD_CICLO) = TO_CHAR(:P52_CICLO)',
')',
'UNPIVOT INCLUDE NULLS ( ',
'    VALOR_CICLO FOR NOME_COLUNA IN (',
'        CICLO_1, CICLO_2, CICLO_3, CICLO_4, CICLO_5, CICLO_6, CICLO_7, CICLO_8, CICLO_9, CICLO_10, ',
'        CICLO_11, CICLO_12, CICLO_13, CICLO_14, CICLO_15, CICLO_16, CICLO_17, CICLO_18, CICLO_19, CICLO_20, ',
'        CICLO_21, CICLO_22, CICLO_23, CICLO_24, CICLO_25, CICLO_26, CICLO_27, CICLO_28, CICLO_29, CICLO_30, CICLO_31',
'    )',
')',
'WHERE (VALOR_CICLO IS NOT NULL AND VALOR_CICLO NOT IN ''N'');'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_CICLO'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_CICLO'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068289551734881698)
,p_name=>'P52_CICLO_DAT_INICIAL'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Ciclo Data Inicial'
,p_placeholder=>'- Selecione -'
,p_source=>'DATA_INICIO_CICLO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(15068289706535881699)
,p_name=>'P52_CICLO_DAT_FINAL'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Ciclo Data Final'
,p_placeholder=>'- Selecione -'
,p_source=>'DATA_FINAL_CICLO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(23898508656795538249)
,p_name=>'P52_IND_REVISADO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'IND_REVISADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(27363541989299488124)
,p_name=>'P52_COD_VAGA_1'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37330161076182177235)
,p_name=>'P52_MAT_SUBS_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_prompt=>unistr('Colaborador Substitu\00EDdo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>':P52_COD_REQ is not null and :P52_COD_MOT_REQ = 1 and :P52_COD_SIT_REQ <> 0'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_css_classes=>'apex_disabled'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37495107681116432649)
,p_name=>'P52_POSSUI_MOTIVO_REQ'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37495107801744432651)
,p_name=>'P52_MOT_SIT_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(37495107718223432650)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo'
,p_source=>'MOT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select UPPER(mc.descricao) d, mc.cod',
'  from req_motivo_situacao mc',
' where mc.ativo = ''S''',
'   and cod_sit_req = :p52_cod_sit_req',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_SIT_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37495108041412432653)
,p_name=>'P52_MOT_SIT_REQ_DSP'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_prompt=>unistr('Motivo de Situa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_display_when=>'P52_MOT_SIT_REQ'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37569787987249989767)
,p_name=>'P52_PROSPECCAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>unistr('Prospec\00E7\00E3o de Candidatos')
,p_source=>'PROSPECCAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_begin_on_new_line=>'N'
,p_display_when=>'P_PAINEL'
,p_display_when2=>'PO'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Caso esteja abrindo uma requisi\00E7\00E3o apenas para realizar a prospec\00E7\00E3o de candidatos, marque esta op\00E7\00E3o como "Sim". '),
unistr('Desta forma, a requisi\00E7\00E3o n\00E3o passar\00E1 pelo fluxo de aprova\00E7\00E3o.'),
unistr('Ap\00F3s ter realizado a prospec\00E7\00E3o, desative essa op\00E7\00E3o para que ent\00E3o a requisi\00E7\00E3o passe pelo fluxo de aprova\00E7\00E3o e possa prosseguir com a admiss\00E3o do candidato aprovado.')))
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879109270733908274)
,p_name=>'P52_COD_REQ'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879109626178908276)
,p_name=>'P52_COD_REQ_PAI'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Req. de Origem'
,p_source=>'COD_REQ_PAI'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P52_COD_REQ_PAI'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(54947250491700418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879110120996908276)
,p_name=>'P52_TITULO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879110428944908276)
,p_name=>'P52_ROWID'
,p_source_data_type=>'ROWID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879110875404908277)
,p_name=>'P52_COD_MOT_REQ'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Motivo de Abertura'
,p_source=>'COD_MOT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select initcap(desc_mot_req) descricao, cod_mot_req',
'      from mot_req',
'     order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879111305231908277)
,p_name=>'P52_COD_SIT_REQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'COD_SIT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(Desc_Sit_Req) d, cod_sit_req c',
'  from SIT_REQ',
'union',
unistr('select ''Em Revis\00E3o'' d, 0 from dual'),
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879111626290908277)
,p_name=>'P52_COD_MOT_SIT_REQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_MOT_SIT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879112033940908278)
,p_name=>'P52_COD_REQ_X'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_use_cache_before_default=>'NO'
,p_source=>'P52_COD_REQ'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879112430958908278)
,p_name=>'P52_DT_REQ'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Data de Abertura'
,p_placeholder=>'- Selecione -'
,p_source=>'DT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879112841639908278)
,p_name=>'P52_DT_SIT_REQ'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Data de Situa\00E7\00E3o')
,p_placeholder=>'- Selecione -'
,p_source=>'DT_SIT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879113234143908278)
,p_name=>'P52_COD_EMP_REQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_EMP_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879113638472908278)
,p_name=>'P52_MAT_REQ'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'MAT_REQ'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879114120555908279)
,p_name=>'P52_SOLICITANTE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879114488420908279)
,p_name=>'P52_FLAG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879114912395908279)
,p_name=>'P52_OK'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879115270676908279)
,p_name=>'P52_SEQ_APROV'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879115681671908279)
,p_name=>'P52_MENSAGEM'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879116112226908280)
,p_name=>'P52_ITEM_VALIDACAO'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879116472901908280)
,p_name=>'P52_ITEM_VALIDACAO_SAL'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879116849243908280)
,p_name=>'P52_USUARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'USUARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879117286356908280)
,p_name=>'P52_DT_ATUALIZACAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879117669876908280)
,p_name=>'P52_UTILIZA_SECAO'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879118059411908281)
,p_name=>'P52_ENABLE_DA'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(179886874315208070413)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879123585393908289)
,p_name=>'P52_APROV'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879123997756908289)
,p_name=>'P52_OK_APROV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879124372191908290)
,p_name=>'P52_FLAG_APROV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879124785567908291)
,p_name=>'P52_MENSAGEM_APROV'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179886881794701070421)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879130781522908294)
,p_name=>'P52_COD_EMPRESA_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(168080630852129356596)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879131192456908294)
,p_name=>'P52_MATRICULA_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(168080630852129356596)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.matricula||'' - ''||initcap(nvl(p.nome_social,p.nome)) d,',
'       i.matricula',
'  from informacoes_funcionais i, inf_pessoais p',
' where i.cod_empresa = p.cod_empresa',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p52_cod_empresa_colab',
'   and i.situacao < ''90''',
'   and not exists (select 1 ',
'                     from RP_FUNC_INSCRITOS r',
'                    where r.cod_empresa = i.cod_empresa',
'                      and r.matricula = i.matricula',
'                      and r.cod_req = :p52_cod_req)',
' order by i.matricula'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA_COLAB,P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879131556663908295)
,p_name=>'P52_DT_INSCRICAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(168080630852129356596)
,p_prompt=>unistr('Data de Inscri\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879132637451908295)
,p_name=>'P52_CANDIDATO_CAND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(168153569419253188390)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select i.cod_candidato||'' - ''||initcap(nvl(p.nome_social,p.nome)) d,',
'       i.cod_candidato',
'  from inf_func_candidato i, inf_pessoais_candidato p',
' where i.cod_candidato = p.cod_candidato',
'   and not exists (select 1 ',
'                     from RP_CAND_INSCRITOS r',
'                    where r.cod_candidato = i.cod_candidato',
'                      and r.cod_req = :p52_cod_req)',
' order by i.cod_candidato'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA_COLAB,P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879133778753908296)
,p_name=>'P52_INSTR_FORMACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170360453166451838369)
,p_prompt=>unistr('Instru\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select initcap(nome) descricao, cod from instrucao order by cod'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879134209983908296)
,p_name=>'P52_DESC_FORMACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170360453166451838369)
,p_prompt=>unistr('Forma\00E7\00E3o')
,p_placeholder=>unistr('Ex.: Ci\00EAncias Cont\00E1beis')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from formacao_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879134567920908296)
,p_name=>'P52_CONCL_FORMACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170360453166451838369)
,p_item_default=>'S'
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879134991298908296)
,p_name=>'P52_EXIGE_FORMACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170360453166451838369)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879136108939908299)
,p_name=>'P52_DESC_EXPERIENCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170360454139014838378)
,p_prompt=>unistr('Experi\00EAncia')
,p_placeholder=>unistr('Ex.: Lideran\00E7a de Equipe')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from experiencia_req_pessoal',
'order by 1'))
,p_cSize=>100
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879136488941908300)
,p_name=>'P52_ANOS_EXPERIENCIA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170360454139014838378)
,p_prompt=>'Anos'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879136909864908300)
,p_name=>'P52_MESES_EXPERIENCIA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170360454139014838378)
,p_prompt=>'Meses'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879137226877908300)
,p_name=>'P52_EXIGE_EXPERIENCIA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170360454139014838378)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879138353042908301)
,p_name=>'P52_DESC_CONHECIMENTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170360454808935838385)
,p_prompt=>'Conhecimento'
,p_placeholder=>'Ex.: Scrum'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from formacao_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879138746321908301)
,p_name=>'P52_NIVEL_CONHECIMENTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170360454808935838385)
,p_prompt=>unistr('N\00EDvel')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.d, x.c',
' from (',
unistr('select ''B\00E1sico'' d, 1 c from dual'),
'union ',
unistr('select ''Intermedi\00E1rio'' d, 2 c from dual'),
'union',
unistr('select ''Avan\00E7ado'' d, 3 c from dual) x'),
'order by 2'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879139191255908301)
,p_name=>'P52_EXIGE_CONHECIMENTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170360454808935838385)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879140307691908302)
,p_name=>'P52_CANDIDATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct initcap(i.nome) candidato, c.cod_candidato COD',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c, PS_FASE_PADRAO_CARGO r, inf_pessoais_candidato i',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and c.cod_candidato = i.cod_candidato',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'    and p.cod_fase = r.cod_fase',
'    and trunc(sysdate) between nvl(p.dt_inicio_fase,trunc(sysdate)) and nvl(p.dt_fim_fase,trunc(sysdate))',
'    and r.ind_responsavel in (''G'',''A'')',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_REQ,P52_FASE_PS'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879140704590908302)
,p_name=>'P52_NOTA_CORTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_prompt=>'Nota Corte'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879141061080908302)
,p_name=>'P52_NOTA_CANDIDATO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_prompt=>'Nota'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879141488378908302)
,p_name=>'P52_APROVADO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_prompt=>'Aprovado?'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879141852796908302)
,p_name=>'P52_RESULTADO_FASE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(179676443925705538066)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>200
,p_cMaxlength=>200
,p_cHeight=>3
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879146080266908304)
,p_name=>'P52_COD_IDIOMA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179730261899348059513)
,p_prompt=>'Idioma'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(descricao), codigo',
'  from idioma',
'where codigo not in (select cod_idioma from idioma_req_pessoal where seq = :p52_seq)',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_SEQ'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879146496552908304)
,p_name=>'P52_NIVEL_CONHECIMENTO_IDIOMA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179730261899348059513)
,p_prompt=>unistr('N\00EDvel de Conhecimento')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(DESCRICAO), CODIGO ',
'  FROM NIVEL_CONHECIMENTO',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879147136656908305)
,p_name=>'P52_CBO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'CBO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879147547619908305)
,p_name=>'P52_DESC_OBJ_CARGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'Objetivos do Cargo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879147976143908305)
,p_name=>'P52_TEXTO_RESP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'Responsabilidades / Resultados'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879148336341908306)
,p_name=>'P52_DESC_QUALIF_NECESSID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>unistr('Qualifica\00E7\00F5es Necess\00E1rias')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879148734346908307)
,p_name=>'P52_DESC_SUP_EXERC'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>unistr('Supervis\00E3o Exercida')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879149185147908307)
,p_name=>'P52_DESC_POS_ESTRU'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>unistr('Posi\00E7\00E3o na Estrutura')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879149562470908307)
,p_name=>'P52_DESC_COMPLEXIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'Complexidade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879149988291908307)
,p_name=>'P52_DESC_CONTR_REL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'Contatos/Relacionamentos'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879150352334908307)
,p_name=>'P52_DESC_RISC_AMB_TRAB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(179746362601699552674)
,p_prompt=>'Riscos e Ambientes'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879152313015908308)
,p_name=>'P52_COD_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('N\00BA Processo Seletivo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879152704806908308)
,p_name=>'P52_STATUS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Status'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879153087168908309)
,p_name=>'P52_COD_PROC_ANTERIOR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Processo Anterior'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879153455409908309)
,p_name=>'P52_COD_PREST_SERV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Selecionador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879153911985908309)
,p_name=>'P52_COD_TIPO_PROCESSO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Tipo de Processo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879154279892908309)
,p_name=>'P52_COD_METRICA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('N\00EDvel de Contrata\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879154643077908309)
,p_name=>'P52_DT_SOLICITACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('Data Solicita\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879155074151908309)
,p_name=>'P52_DT_APROVACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('Data Aprova\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879155502690908309)
,p_name=>'P52_DT_PERFIL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Data Perfil'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879155854466908309)
,p_name=>'P52_DT_FECHAMENTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Data Fechamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879156260839908310)
,p_name=>'P52_COD_ENTIDADE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Data Fechamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879156651679908310)
,p_name=>'P52_DT_INI_ENTIDADE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('Data In\00EDcio Entidade')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879157028524908310)
,p_name=>'P52_DT_FIM_ENTIDADE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Data Fim Entidade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879157509430908310)
,p_name=>'P52_TAXA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Taxa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879157864332908310)
,p_name=>'P52_VALOR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Valor'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879158306301908310)
,p_name=>'P52_OBSERVACAO_PS'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879158691292908310)
,p_name=>'P52_LOCAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_prompt=>'Local'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879158967451908311)
,p_name=>'P52_FASE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(179751985115900947909)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879164087246908314)
,p_name=>'P52_FASE_CAND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179753221196003269282)
,p_prompt=>'Fase'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct p.cod_fase||'' - ''||initcap(f.desc_fase) descricao, p.cod_fase cod',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879164497877908314)
,p_name=>'P52_CANDIDATO_ACMP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179753221196003269282)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT initcap(p.nome) candidato, c.cod_candidato COD',
'  from candidato c, inf_pessoais_candidato p, fase_candidato f, inf_pessoais ip, avaliacao_fase a',
' where c.cod_candidato = p.cod_candidato',
'   and c.cod_fase = f.cod_fase',
'   and c.cod_prest_serv_avaliador = ip.matricula',
'   and c.cod_aval_fase = a.cod_aval_fase (+)',
'   and c.cod_req  = :p52_cod_req',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879170386425908316)
,p_name=>'P52_FASE_PS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179753385274988129079)
,p_prompt=>'Fase'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
' select distinct p.cod_fase||'' - ''||initcap(f.desc_fase) descricao, p.cod_fase cod',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P52_COD_REQ'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879170758136908317)
,p_name=>'P52_CANDIDATO_FASE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179753385274988129079)
,p_prompt=>'Candidato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT initcap(p.nome) candidato, c.cod_candidato COD',
'  from candidato c, inf_pessoais_candidato p, fase_candidato f, inf_pessoais ip, avaliacao_fase a',
' where c.cod_candidato = p.cod_candidato',
'   and c.cod_fase = f.cod_fase',
'   and c.cod_prest_serv_avaliador = ip.matricula',
'   and c.cod_aval_fase = a.cod_aval_fase (+)',
'   and c.cod_req  = :p52_cod_req',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_cascade_parent_items=>'P52_COD_REQ'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879171893760908317)
,p_name=>'P52_BENEFICIO_VAGA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179778299604877536966)
,p_prompt=>unistr('Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(descr_beneficio)||'' - Valor: ''||valor_padrao descricao, cod_beneficio codigo',
'from   beneficios',
'where cod_beneficio not in (select x.cod_beneficio from beneficios_vaga_temp x where x.seq = :p52_seq)',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Selecionar as ferramentas necess\00E1rias para a execu\00E7\00E3o do trabalho do novo colaborador')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879172816332908318)
,p_name=>'P52_VALOR_BENEF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179778299604877536966)
,p_prompt=>'Valor'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879174305208908320)
,p_name=>'P52_COD_CURSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879174701332908321)
,p_name=>'P52_DESC_CURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_prompt=>'Curso'
,p_placeholder=>'Ex.: Pacote Office'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from curso_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879175079657908321)
,p_name=>'P52_NIVEL_CURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_prompt=>unistr('N\00EDvel')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.d, x.c',
' from (',
unistr('select ''B\00E1sico'' d, 1 c from dual'),
'union ',
unistr('select ''Intermedi\00E1rio'' d, 2 c from dual'),
'union',
unistr('select ''Avan\00E7ado'' d, 3 c from dual) x'),
'order by 2'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879175436970908321)
,p_name=>'P52_CONCL_CURSO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_item_default=>'S'
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879175920446908321)
,p_name=>'P52_EXIGE_CURSO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(179846296708447365013)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879177365479908322)
,p_name=>'P52_COD_CARGO_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179846373943795246808)
,p_prompt=>'Cargo'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select initcap(nome) nome_curso, cod',
'  from cargos',
' where cod not in (select r.cargo',
'                      from RP_CARGO r, cargos c',
'                     where r.cargo = c.cod (+)',
'                       and r.cod_empresa = :p52_cod_empresa',
'                       and r.cod_cargo = NVL(:p52_cod_cargo,:P52_COD_CARGO_1))',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_CARGO,P52_COD_CARGO_1'
,p_ajax_optimize_refresh=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879177731254908322)
,p_name=>'P52_ANOS_CARGO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179846373943795246808)
,p_prompt=>unistr('Anos de Experi\00EAncia')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879178146340908322)
,p_name=>'P52_MESES_CARGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179846373943795246808)
,p_prompt=>unistr('Meses de Experi\00EAncia')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879179660802908323)
,p_name=>'P52_COD_TAREFA_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179846458758377116093)
,p_prompt=>'Tarefa'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_tarefa_req) DESCRICAO, COD_tarefa_req',
'  FROM tarefa_req',
'where cod_tarefa_req not in (select r.cod_tarefa_req',
'                               from TAR_PESO_TEMP r',
'                              where r.seq = :p52_seq)',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_SEQ'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879180099741908323)
,p_name=>'P52_PESO_TAREFA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179846458758377116093)
,p_prompt=>'Peso'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_peso) descricao, COD_peso',
'  FROM peso',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879181568188908324)
,p_name=>'P52_COD_CARAC_FUNC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179846460343554116109)
,p_prompt=>unistr('Caracter\00EDstica')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_carac_func) DESCRICAO, COD_carac_func',
'  FROM carac_func',
' WHERE COD_CARAC_FUNC NOT IN (select cod_carac_func',
'                                from CARAC_PESO_TEMP',
'                               where seq = :p52_seq)',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_SEQ'
,p_ajax_optimize_refresh=>'Y'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879181980299908324)
,p_name=>'P52_PESO_CARACTERISTICA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179846460343554116109)
,p_prompt=>'Peso'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_peso) descricao, COD_peso',
'  FROM peso',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879205400519908337)
,p_name=>'P52_DESC_ATIVIDADES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Descri\00E7\00E3o de Atividades')
,p_placeholder=>unistr('Descreva as informa\00E7\00F5es das atividades que ser\00E3o utilizadas para informar os candidatos na divulga\00E7\00E3o da vaga.')
,p_source=>'DESC_ATIVIDADES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>4000
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Descreva as informa\00E7\00F5es das atividades que ser\00E3o utilizadas para informar os candidatos na divulga\00E7\00E3o da vaga.')
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879205815115908337)
,p_name=>'P52_SEQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879206184577908338)
,p_name=>'P52_FLG_UTILIZA_SALARIO_POS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879206578670908338)
,p_name=>'P52_BOTOES_REQ_PESSOAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879206971063908338)
,p_name=>'P52_ALTEROU_VAGA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879207394094908338)
,p_name=>'P52_OBSERVACAO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Observa\00E7\00F5es para o recrutamento')
,p_placeholder=>unistr('Descreva observa\00E7\00F5es importantes que auxiliar\00E3o a \00E1rea de recrutamento.')
,p_source=>'OBSERVACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Descreva observa\00E7\00F5es importantes que auxiliar\00E3o a \00E1rea de recrutamento.')
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879207736640908339)
,p_name=>'P52_ANEXO_1'
,p_source_data_type=>'BLOB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(179886859503200070394)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'<b>Anexe arquivo/documento com mais detalhes</b>'
,p_source=>'ANEXO_1'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ANEXO_MIMETYPE_1'
,p_attribute_03=>'ANEXO_FILENAME_1'
,p_attribute_04=>'ANEXO_CHARSET_1'
,p_attribute_05=>'ANEXO_DATA_1'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879208506554908341)
,p_name=>'P52_POS_ESTR_ORG'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6858879449382043128)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Posi\00E7\00E3o na Estrutura Organizacional')
,p_source=>'POS_ESTR_ORG'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879208864669908341)
,p_name=>'P52_EXP_NEC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6858879449382043128)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Experi\00EAncia Necess\00E1ria')
,p_source=>'EXP_NEC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879209247479908341)
,p_name=>'P52_REL_FUNC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6858879449382043128)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Rela\00E7\00F5es Funcionais')
,p_source=>'REL_FUNC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879209636772908342)
,p_name=>'P52_FAT_INS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6858879449382043128)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Fatores de Insucesso (Incidentes Cr\00EDticos)')
,p_source=>'FAT_INS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879210094876908342)
,p_name=>'P52_PERS_DES'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6858879449382043128)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Perspectivas de Desenvolvimento'
,p_source=>'PERS_DES'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879210774141908342)
,p_name=>'P52_PAR_JUST'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(179886872691467070412)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Justificativa (no caso de aumento de quadro)'
,p_source=>'PAR_JUST'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879211187515908342)
,p_name=>'P52_PAR_RH'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(179886872691467070412)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Parecer do Recursos Humanos'
,p_source=>'PAR_RH'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879211588205908343)
,p_name=>'P52_PAR_ORC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(179886872691467070412)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Parecer do Or\00E7amento')
,p_source=>'PAR_ORC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879223224394908348)
,p_name=>'P52_TIPO_MODALIDADE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359328657257691651)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'P'
,p_prompt=>'Tipo de Modalidade'
,p_source=>'TIPO_MODALIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT INITCAP(DESCRICAO) DESCRICAO, TIPO_MODALIDADE',
'  FROM TIPO_MODALIDADE_TRAB',
' WHERE COD_EMPRESA = :P52_COD_EMPRESA',
'  -- AND ((:p52_cod_sit_req in (2,3,4,5)) or (ATIVO = ''S''))',
'  AND ATIVO = ''S''',
' ORDER BY CASE WHEN TIPO_MODALIDADE = ''P'' THEN ''A'' WHEN TIPO_MODALIDADE = ''S'' THEN ''B'' ELSE TIPO_MODALIDADE END'))
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879223612285908348)
,p_name=>'P52_RT_JORNADA_MENSAL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359328657257691651)
,p_prompt=>unistr('Carga Hor\00E1ria')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Select ''C\00F3digo: ''||R.cod||'' - ''||r.desc_regime descricao_regime, '),
'       R.cod codigo_regime',
'from REG_TRABALHO R',
'WHERE R.COD <> ''NUL''',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' and not exists (select 1 ',
'                   from sind_reg_trabalho x ',
'                  where x.cod_empresa = r.cod_empresa ',
'                    and x.cod_sindicato = :p52_cod_sindicato',
'                )',
' union',
unistr(' Select ''C\00F3digo: ''||R.cod||'' - ''||r.desc_regime descricao_regime, '),
'       R.cod codigo_regime',
'from REG_TRABALHO R, SIND_REG_TRABALHO S',
'WHERE R.COD <> ''NUL''',
' AND R.COD = S.COD_REG_TRAB',
' AND R.COD_EMPRESA = S.COD_EMPRESA',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' AND S.COD_SINDICATO = :P52_COD_SINDICATO',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_SINDICATO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>'Escolher a jornada semanal e o regime mensal de horas da vaga.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879224452905908349)
,p_name=>'P52_RT_JORNADA_MENSAL_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(170359328657257691651)
,p_prompt=>unistr('Carga Hor\00E1ria')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select R.cod||'' - ''||r.desc_regime descricao_regime, ',
'       R.cod codigo_regime',
'from REG_TRABALHO R',
'WHERE R.COD <> ''NUL''',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' order by R.JORNADA_DIARIA_H, R.JORNADA_SEMANAL_H'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolher a jornada semanal e o regime mensal de horas da vaga.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879225381469908349)
,p_name=>'P52_COD_HORARIO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(170359328657257691651)
,p_prompt=>unistr('Hor\00E1rio Contratual')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_horario||'' - ''||desc_horario nome, cod_horario cod',
'  from cad_horario_trabalho ',
'where cod_empresa = :p52_cod_empresa ',
'  and COD_REG_TRAB = :p52_RT_JORNADA_MENSAL',
'order by desc_horario'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_RT_JORNADA_MENSAL'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Escolher qual o hor\00E1rio da vaga.')
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879226320994908350)
,p_name=>'P52_COD_HORARIO_1'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(170359328657257691651)
,p_prompt=>unistr('Hor\00E1rio Contratual')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_horario||'' - ''||desc_horario nome, cod_horario cod',
'  from cad_horario_trabalho ',
'where cod_empresa = :p52_cod_empresa ',
'  and COD_REG_TRAB = :p52_RT_JORNADA_MENSAL_X',
'order by desc_horario'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_RT_JORNADA_MENSAL_X'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_RT_JORNADA_MENSAL_X'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher qual o hor\00E1rio da vaga.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879227161915908351)
,p_name=>'P52_MARCA_PONTO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'S'
,p_prompt=>'Marca Ponto?'
,p_source=>'MARCA_PONTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879227605024908351)
,p_name=>'P52_TP_REGISTRO_PONTO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Tipo de Marca\00E7\00E3o')
,p_source=>'TP_REGISTRO_PONTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Ambos;A,Fixo;F,M\00F3vel;M')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879227928495908352)
,p_name=>'P52_RT_JORNADA_MENSAL_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'RT_JORNADA_MENSAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879228395583908352)
,p_name=>'P52_RT_JORNADA_MENSAL_Z'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879228732611908352)
,p_name=>'P52_COD_HORARIO_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_HORARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879229197323908352)
,p_name=>'P52_COD_HORARIO_Z'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(6849871147793323432)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879230288709908353)
,p_name=>'P52_COD_CARGO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.descricao d, x.cod c',
'  from (',
'select SUBSTR(c.cod,1,7)||'' - ''||initcap(c.nome) descricao , cod',
'  from cargos_empresas e, cargos c, parametros_recursos_humanos p',
' where e.cod_empresa = p.cod_empresa',
'   and e.cod_cargo = c.cod',
'   and c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and e.cod_empresa = :p52_cod_empresa',
'   and p.ind_empresa_cargo = ''S''',
'   /*   ',
'   and not exists (select 1 ',
'                    from cargos_ccusto cc ',
'                   where cc.cod_empresa = e.cod_empresa',
'                     and cc.cod_ccusto = :p52_cod_ccusto_x)',
'   */',
' union ',
'SELECT SUBSTR(c.cod,1,7)||'' - ''||initcap(nome) descricao , cod',
'  from cargos c',
' where c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and exists (select 1',
'                 from parametros_recursos_humanos p',
'                where p.cod_empresa = :p52_cod_empresa',
'                  and p.ind_empresa_cargo = ''N'')',
') x',
' where not exists (select 1',
'                     from cargos_ccusto c ',
'                    where c.cod_empresa = :p52_cod_empresa',
'                     and c.cod_cargo = x.cod',
'                  )',
'union',
'select SUBSTR(r.cod,1,7)||'' - ''||initcap(r.nome) d , cod c',
'  from cargos r, cargos_ccusto c',
' where r.cod = c.cod_cargo',
'   and c.cod_empresa = :p52_cod_empresa',
'   and c.cod_ccusto = :p52_cod_ccusto_x',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_CCUSTO_X'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879230693097908353)
,p_name=>'P52_COD_CARGO_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUBSTR(cod,1,7)||'' - ''||initcap(nome) d , cod c',
'from cargos',
'where dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879231044787908353)
,p_name=>'P52_COD_FUNCAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' d, cod c',
'  from funcao',
' where sysdate between nvl(dt_inic_vig_funcao,sysdate) and nvl(dt_term_vig_funcao,sysdate)',
'   and cod_cargo = :p52_cod_cargo ',
'   and :p52_cod_vaga is null',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_CARGO,P52_COD_VAGA'
,p_ajax_items_to_submit=>'P52_COD_CARGO,P52_COD_VAGA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879231462234908353)
,p_name=>'P52_COD_FUNCAO_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' d, cod c',
'  from funcao',
' where sysdate between nvl(dt_inic_vig_funcao,sysdate) and nvl(dt_term_vig_funcao,sysdate)',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879231867015908353)
,p_name=>'P52_COD_CATEGORIA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>'Categoria'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       initcap(cc.nome)||'' (''||ccr.cod_categoria||'')'' desc_categoria',
'      ,ccr.cod_categoria ',
'from   categoria_cargo_rel ccr',
'      ,categoria_cargo     cc',
'where  cc.cod                   = ccr.cod_categoria',
'and ccr.cod_cargo = :p52_cod_cargo ',
'and :p52_cod_vaga is null',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_CARGO,P52_COD_VAGA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879232303828908353)
,p_name=>'P52_COD_CATEGORIA_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_default=>'P52_COD_CATEGORIA_X'
,p_item_default_type=>'ITEM'
,p_prompt=>'Categoria'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct',
'       initcap(cc.nome)||'' (''||ccr.cod_categoria||'')'' desc_categoria',
'      ,ccr.cod_categoria ',
'from   categoria_cargo_rel ccr',
'      ,categoria_cargo     cc',
'where  cc.cod = ccr.cod_categoria',
'and    nvl(ccr.cod_empresa_sindjorn,:p52_cod_empresa) = :p52_cod_empresa',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_CARGO,P52_COD_VAGA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>unistr('Inclu\00EDdo propriedade DEFAULT puxando o conte\00FAdo do campo P52_COD_CATEGORIA_X 08/02/2022 Chamado 26029')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879232694808908354)
,p_name=>'P52_COD_SINDICATO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>'Sindicato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT S.COD||'' - ''||Initcap(S.sigla) descricao, S.COD codigo',
'FROM SINDICATOS S',
'WHERE S.COD_EMPRESA = :P52_COD_EMPRESA',
'and ((trunc(sysdate) >= nvl(s.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'and nvl(s.sit,''A'') not in (''E'',''I'')',
'and s.cod <> 999',
'and not exists ',
'(',
'SELECT 1',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P52_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'   and (sx.filial = :P52_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X) or sx.cod_local_trab is null)',
'   and exists (select 1 from SINDICATO_FILIAIS sfy where sfy.ind_elegivel=''S'' and sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P52_COD_FILIAL UNION',
'     select 1 from SINDICATO_CCUSTO scy where scy.ind_elegivel=''S'' and scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) UNION',
'     select 1 from SINDICATO_UNID_ADM suy where suy.ind_elegivel=''S'' and suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) UNION',
'     select 1 from SINDICATO_ATIVIDADE say where say.ind_elegivel=''S'' and say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) UNION',
'     select 1 from SINDICATO_LOCAL_TRAB sly where sly.ind_elegivel=''S'' and sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X)',
'           )',
')',
'union',
'SELECT Sx.COD_sindicato||'' - ''||Initcap(Sx.sigla) descricao, sx.cod_sindicato codigo',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P52_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'   and (sx.filial = :P52_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X) or sx.cod_local_trab is null)',
'   and exists (select 1 from SINDICATO_FILIAIS sfy where sfy.ind_elegivel=''S'' and sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P52_COD_FILIAL UNION',
'       select 1 from SINDICATO_CCUSTO scy where scy.ind_elegivel=''S'' and scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) UNION',
'       select 1 from SINDICATO_UNID_ADM suy where suy.ind_elegivel=''S'' and suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) UNION',
'       select 1 from SINDICATO_ATIVIDADE say where say.ind_elegivel=''S'' and say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) UNION',
'       select 1 from SINDICATO_LOCAL_TRAB sly where sly.ind_elegivel=''S'' and sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X)',
'           )',
'           ',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_REQ,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_COD_REQ,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher para qual sindicato da empresa escolhida a vaga deve ser criada, para estagi\00E1rio selecionar 99 e PJ 998.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'Validation REQUIRED = SIM (ch45510)'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879233551106908354)
,p_name=>'P52_COD_SINDICATO_1'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>'Sindicato'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT S.COD||'' - ''||Initcap(S.sigla) descricao, S.COD codigo',
'FROM SINDICATOS S',
'WHERE S.COD_EMPRESA = :P52_COD_EMPRESA',
'and ((trunc(sysdate) >= nvl(s.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'and nvl(s.sit,''A'') not in (''E'',''I'')',
'and s.cod <> 999',
'and not exists ',
'(',
'SELECT 1',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P52_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'   and (sx.filial = :P52_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X) or sx.cod_local_trab is null)',
'   and exists (',
'            select 1 from SINDICATO_FILIAIS sfy where sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P52_COD_FILIAL UNION',
'            select 1 from SINDICATO_CCUSTO scy where scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) UNION',
'            select 1 from SINDICATO_UNID_ADM suy where suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) UNION',
'            select 1 from SINDICATO_ATIVIDADE say where say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) UNION',
'            select 1 from SINDICATO_LOCAL_TRAB sly where sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X)',
'           )',
')',
'union',
'SELECT Sx.COD_sindicato||'' - ''||Initcap(Sx.sigla) descricao, sx.cod_sindicato codigo',
'  FROM vw_sindicato_eleg sx',
' where SX.COD_EMPRESA = :P52_COD_EMPRESA',
'   and ((trunc(sysdate) >= nvl(sx.dt_vigencia_inicial,trunc(sysdate)) and :P52_cod_req is null) or (:P52_cod_req is not null))',
'   and (sx.filial = :P52_COD_FILIAL or sx.filial is null)',
'   and (sx.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) or sx.cod_ccusto is null)',
'   and (sx.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) or sx.cod_unidade_adm is null)',
'   and (sx.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) or sx.cod_atividade is null)',
'   and (sx.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X) or sx.cod_local_trab is null)',
'   and exists (',
'            select 1 from SINDICATO_FILIAIS sfy where sfy.cod_sindicato = sx.cod_sindicato and sfy.cod_empresa = sx.cod_empresa and sfy.filial = :P52_COD_FILIAL UNION',
'            select 1 from SINDICATO_CCUSTO scy where scy.cod_sindicato = sx.cod_sindicato and scy.cod_empresa = sx.cod_empresa and scy.cod_ccusto = nvl(:P52_COD_CCUSTO,:P52_COD_CCUSTO_X) UNION',
'            select 1 from SINDICATO_UNID_ADM suy where suy.cod_sindicato = sx.cod_sindicato and suy.cod_empresa = sx.cod_empresa and suy.cod_unidade_adm = NVL(:P52_COD_UNIDADE_ADM,:P52_COD_UNIDADE_ADM_X) UNION',
'            select 1 from SINDICATO_ATIVIDADE say where say.cod_sindicato = sx.cod_sindicato and say.cod_empresa = sx.cod_empresa and say.cod_atividade = NVL(:P52_COD_ATIVIDADE,:P52_COD_ATIVIDADE_X) UNION',
'            select 1 from SINDICATO_LOCAL_TRAB sly where sly.cod_sindicato = sx.cod_sindicato and sly.cod_empresa = sx.cod_empresa and sly.cod_local_trab = NVL(:P52_COD_LOCAL_TRAB,:P52_COD_LOCAL_TRAB_X)',
'           )',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher para qual sindicato da empresa escolhida a vaga deve ser criada, para estagi\00E1rio selecionar 99 e PJ 998.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'Validation REQUIRED = SIM (ch45510)'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879234489424908355)
,p_name=>'P52_VINCULO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>unistr('V\00EDnculo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||Initcap(a.nome) descricao, a.cod codigo',
'      from vinculo_empreg a',
'      where ((:p52_rowid is null and a.cod <> ''V'') or ',
'             (:p52_rowid is not null))',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher o tipo de contrato das posi\00E7\00F5es que ser\00E3o criadas.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879235340859908355)
,p_name=>'P52_VINCULO_1'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_prompt=>unistr('V\00EDnculo')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct a.cod||'' - ''||Initcap(a.nome) descricao, a.cod codigo',
'      from vinculo_empreg a',
'      where ((:p52_rowid is null and a.cod <> ''V'') or ',
'             (:p52_rowid is not null))',
'      order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher o tipo de contrato das posi\00E7\00F5es que ser\00E3o criadas.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879236275931908355)
,p_name=>'P52_COD_AREA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('\00C1rea')
,p_source=>'COD_AREA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(descricao_area), cod_area_interesse',
'  from areas_interesse',
' where ativo = ''S''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'Outro'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_display_when_type=>'NEVER'
,p_field_template=>wwv_flow_api.id(54947250491700418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879236689817908355)
,p_name=>'P52_TRAB_INTERMITENTE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>'Trabalho Intermitente'
,p_source=>'TRAB_INTERMITENTE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879237037747908356)
,p_name=>'P52_VINCULO_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'VINCULO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879237466943908356)
,p_name=>'P52_COD_CARGO_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_CARGO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879237923465908356)
,p_name=>'P52_COD_FUNCAO_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_FUNCAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879238273050908356)
,p_name=>'P52_COD_CATEGORIA_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_CATEGORIA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879238692275908356)
,p_name=>'P52_COD_SINDICATO_X'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_SINDICATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879239734357908357)
,p_name=>'P52_AJUSTAR_REMUNERACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879240204071908357)
,p_name=>'P52_TIPO_SALARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Tipo de Sal\00E1rio')
,p_source=>'TIPO_SALARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select INITCAP(descricao)||'' (''||cod||'')'' DESCRICAO,',
'       COD',
'  from tipo_salario',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Escolher qual ser\00E1 o tipo de recebimento do colaborador.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879241054448908357)
,p_name=>'P52_TOTAL_SALARIO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_prompt=>unistr('Total Remunera\00E7\00E3o (R$)')
,p_format_mask=>'99999999990D90'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Preencher com o valor do sal\00E1rio somado com o beneficio.')
,p_attribute_01=>'0'
,p_attribute_02=>'9999999999'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879241951368908357)
,p_name=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_prompt=>unistr('% Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Flex - 20%;20,Flex - 30%;30,Flex - Exce\00E7\00E3o;0')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'FULL CLT'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Tipo do modelo de contrata\00E7\00E3o.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879242844501908358)
,p_name=>'P52_PERC_BENEF_EXCECAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_prompt=>unistr('% Benef. Exce\00E7\00E3o')
,p_format_mask=>'9990D90'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879243308061908358)
,p_name=>'P52_SALARIO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Sal\00E1rio (R$)')
,p_format_mask=>'99999999990D90'
,p_source=>'SALARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_help_text=>unistr('Verificar se o valor do sal\00E1rio est\00E1 correto.')
,p_attribute_01=>'0'
,p_attribute_02=>'9999999999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879244225409908358)
,p_name=>'P52_REMUNERACAO_VARIAVEL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Valor do Benef\00EDcio (R$)')
,p_format_mask=>'99999999990D90'
,p_source=>'REMUNERACAO_VARIAVEL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'0'
,p_attribute_02=>'999999999'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879244607602908358)
,p_name=>'P52_VLR_AUX_TIPO_MODALIDADE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Valor de Aux\00EDlio (R$)')
,p_format_mask=>'99999999990D90'
,p_source=>'VLR_AUX_TIPO_MODALIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'0'
,p_attribute_02=>'999999999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879244969324908358)
,p_name=>'P52_MOTIVO_EXCECAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Motivo Para a Exce\00E7\00E3o')
,p_placeholder=>unistr('Informe o motivo da exce\00E7\00E3o do percentual de benef\00EDcio')
,p_source=>'MOTIVO_EXCECAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879245326800908359)
,p_name=>'P52_SALARIO_MAX'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'SALARIO_MAX'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879245781156908359)
,p_name=>'P52_PERC_BENEFICIO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'%'
,p_format_mask=>'990D90'
,p_source=>'PERC_BENEFICIO_VARIAVEL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879246132515908359)
,p_name=>'P52_TIPO_MODALIDADE_OCORR'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(170359328775998691653)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879247291624908359)
,p_name=>'P52_FLAG_TEMPORARIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Tipo de Vaga'
,p_source=>'FLAG_TEMPORARIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>unistr('STATIC:N\00E3o Controlada;S,Controlada;N')
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Ao selecionar vaga n\00E3o controlada ser\00E1 criada somente uma posi\00E7\00E3o, e vaga controlada com mais de uma posi\00E7\00E3o.')
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879248191110908360)
,p_name=>'P52_QTD_POSICAO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('N\00BA de Posi\00E7\00F5es')
,p_source=>'QTD_POSICAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_attribute_01=>'1'
,p_attribute_02=>'9999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879248602548908360)
,p_name=>'P52_QTD_POSICAO_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879249017866908360)
,p_name=>'P52_VAGA_CONFIDENCIAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(6852160584625270127)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Vaga Confidencial'
,p_source=>'VAGA_CONFIDENCIAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC: ;S'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879249413733908360)
,p_name=>'P52_COD_EMPRESA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Empresa'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_EMPRESA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod codigo ',
'  from empresas ',
' WHERE ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :p52_cod_req is null) or ',
'        (:p52_cod_req is not null)) ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolha para qual empresa do grupo a vaga deve ser criada.'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879250290662908360)
,p_name=>'P52_IND_SERV_ALOCA_COLAB'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879250704234908361)
,p_name=>'P52_COD_FILIAL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Filial'
,p_placeholder=>'- Selecione -'
,p_source=>'COD_FILIAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_filial||'' - ''||Initcap(sigla) descricao, cod_filial',
'  from filiais ',
'where cod_empresa = :p52_cod_empresa',
'and (((encer_ativ = ''N'' AND SIT NOT IN (''E'',''I'')) AND :P52_ROWID IS NULL) or (:P52_ROWID IS not NULL))',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_REQ,P52_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolher para qual filial da empresa a vaga devera ser criada.'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879251620079908361)
,p_name=>'P52_COD_VAGA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Posi\00E7\00E3o')
,p_placeholder=>'- Selecione -'
,p_source=>'COD_VAGA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''Vaga: ''||to_number(a.cod_vaga)||',
unistr(''', Requisi\00E7\00E3o: ''||a.cod_requisicao||'),
''', Cargo: ''||b.cod||'' - ''||initcap(b.nome_abrev)||',
''', Compartilhada: ''||nvl(decode(a.ind_vaga_compartilhada,''S'',a.vaga_compartilhada,null),''N'')||',
''', C.Custo: ''||c.cod||'' - ''||initcap(c.nome)||',
unistr(''', V\00EDnculo: ''||d.cod || '' - '' ||initcap(d.nome)||'),
unistr(''', Sal\00E1rio: ''||a.valor_verba||'),
unistr(''', C.Custo Cont\00E1bil: ''||a.cod_ccusto_contab||'),
unistr(''', Unid. Neg\00F3cio: ''||a.cod_un_negocio||'),
''', Unid. Adm.: ''||a.cod_unidade_adm||',
unistr(''', V\00EDnculo: ''||d.cod||'' - ''||initcap(d.nome) descricao,'),
'a.cod_vaga codigo',
'  from cl_vaga                a,',
'       cargos                 b,',
'       centro_de_custo        c,',
'       vinculo_empreg         d,',
'       consulta_requisicoes_2 e,',
'       pc_parametro_formacao  f,',
'       instrucao              g',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.sit_vaga = ''A''',
'   and b.cod = a.cod_cargo',
'   and c.cod_empresa = a.cod_empresa',
'   and c.cod = a.cod_ccusto',
'   and d.cod = a.vinculo',
'   and e.cad_vaga(+) = a.cod_vaga',
unistr('   and (Nvl(e.aprovado, ''N\00C3O'') = ''SIM'' or :p52_rowid is not null)'),
'   and (Nvl(a.disponivel, ''N'') = ''S'' or :p52_rowid is not null)',
'   and a.cod_filial = e.filial',
'   and a.cod_empresa = f.cod_empresa(+)',
'   and a.cod_cargo = f.cod_cargo(+)',
'   and f.cod_instrucao = g.cod(+)',
'   and ((f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S'' and :p52_rowid is null) or (:p52_rowid is not null))',
'   and ((:p_painel = ''PO'') or (not exists (select 1 ',
'from informacoes_funcionais i ',
'where i.cod_empresa = a.cod_empresa',
'and i.filial = a.cod_filial',
'and i.cad_vaga = a.cod_vaga',
'and i.cod_empresa = :p_empresa_user',
'and i.matricula = :p_matricula_user)))',
'union',
'select DISTINCT ''Vaga: ''||to_number(aa.cod_vaga)||',
unistr(''', Requisi\00E7\00E3o: ''||aa.cod_requisicao||'),
''', Cargo: ''||b.cod||'' - ''||initcap(b.nome_abrev)||',
''', Compartilhada: ''||nvl(decode(a.ind_vaga_compartilhada,''S'',a.vaga_compartilhada,null),''N'')||',
''', C.Custo: ''||c.cod||'' - ''||initcap(c.nome)||',
unistr(''', V\00EDnculo: ''||d.cod || '' - '' ||initcap(d.nome)||'),
unistr(''', Sal\00E1rio: ''||aa.valor_verba||'),
unistr(''', C.Custo Cont\00E1bil: ''||aa.cod_ccusto_contab||'),
unistr(''', Unid. Neg\00F3cio: ''||aa.cod_un_negocio||'),
''', Unid. Adm.: ''||aa.cod_unidade_adm||',
unistr(''', V\00EDnculo: ''||d.cod||'' - ''||initcap(d.nome) descricao,'),
'aa.cod_vaga codigo',
'  from cl_vaga                a,',
'       cl_vaga                aa,',
'       cargos                 b,',
'       centro_de_custo        c,',
'       vinculo_empreg         d,',
'       consulta_requisicoes_2 e,',
'       pc_parametro_formacao  f,',
'       instrucao              g',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_empresa = aa.cod_empresa',
'   and a.cod_filial = aa.cod_filial',
'   and a.sit_vaga = ''A''',
'   and aa.sit_vaga = ''A''',
'   and b.cod = aa.cod_cargo',
'   and c.cod_empresa = aa.cod_empresa',
'   and c.cod = aa.cod_ccusto',
'   and d.cod = aa.vinculo',
'   and a.vaga_compartilhada = aa.cod_vaga',
'   and e.cad_vaga(+) = aa.cod_vaga',
'   and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
unistr('   and Nvl(e.aprovado, ''N\00C3O'') = ''SIM'''),
'   and Nvl(a.disponivel, ''N'') = ''N''',
'   and Nvl(aa.disponivel, ''N'') = ''S''',
'   and aa.cod_filial = e.filial',
'   and a.cod_empresa = f.cod_empresa(+)',
'   and a.cod_cargo = f.cod_cargo(+)',
'   and f.cod_instrucao = g.cod(+)',
'   and ((f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S'' and :p52_rowid is null) or (:p52_rowid is not null))',
'   and ((:p_painel = ''PO'') or (not exists (select 1 ',
'from informacoes_funcionais i ',
'where i.cod_empresa = a.cod_empresa',
'and i.filial = a.cod_filial',
'and i.cad_vaga = a.cod_vaga',
'and i.cod_empresa = :p_empresa_user',
'and i.matricula = :p_matricula_user)))',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P_USUARIO'
,p_ajax_items_to_submit=>'P52_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879251938359908362)
,p_name=>'P52_VAGA_DISP_POR_REQ_DESLIG'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>unistr('Conceito: a disponibiliza\00E7\00E3o da vaga para substitui\00E7\00E3o ocorre de 2 formas: ao aprovar a req. desligamento, ou pelo bot\00E3o de cria\00E7\00E3o de RP direto pela tela de req. de desligamento (por\00E9m, neste \00FAltimo cen\00E1rio, a vaga n\00E3o fica dispon\00EDvel, mas j\00E1 pode s')
||unistr('er utilizada em RP). A sinaliza\00E7\00E3o vem da p\00E1gina 59')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879252327252908362)
,p_name=>'P52_QTD_MOUSE_MOVE'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879252802684908363)
,p_name=>'P52_COD_CCUSTO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT c.cod||'' - ''||initcap(c.nome) descricao, c.cod',
'from centro_de_custo c,',
'     FILIAL_CCUSTO F',
'where c.cod_empresa = f.cod_empresa',
'and c.cod = f.cod_ccusto',
'and f.cod_empresa = :p52_cod_empresa',
'and f.cod_filial  = :p52_COD_filial',
'and (:p52_rowid is not null or ((c.dt_fim_vige IS NULL OR SYSDATE <= C.DT_FIM_VIGE)',
'                            and (f.dt_fin_val IS NULL OR sysdate <= f.dt_fin_val)))',
'and F_ACESSO_CC(C.COD_EMPRESA, C.COD) = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_ROWID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879253152508908363)
,p_name=>'P52_COD_CCUSTO_DSP'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'return :P52_COD_CCUSTO_X||'' - ''||Initcap(fnct_nome_ccusto(:P52_COD_empresa,:p52_cod_ccusto_x));',
'EXCEPTION',
'WHEN OTHERS THEN',
'RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879253598430908363)
,p_name=>'P52_COD_CCUSTO_1'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_ccusto||'' - ''||initcap(fnct_nome_ccusto(cod_empresa, cod_ccusto)) descricao, cod_ccusto ',
'from filial_ccusto',
'where cod_empresa = :p52_cod_empresa',
'and   cod_filial  = :p52_COD_filial',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879253978125908363)
,p_name=>'P52_COD_UNIDADE_ADM'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a, SECAO S',
'     where a.cod_empresa = :p52_cod_empresa',
'       and a.cod_filial = :p52_cod_filial',
'     --  and a.cod_empresa = s.cod_emp_unid_adm',
'       and a.cod_unidade_adm = s.cod_unid_adm',
'     --  and s.cod_emp_ccusto = :p52_cod_empresa',
'       and s.cod_ccusto = :p52_cod_ccusto',
'       and s.ativo = ''S''',
'       and :p52_utiliza_secao = ''S''',
'union',
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where a.cod_empresa = :p52_cod_empresa',
'       and a.cod_filial = :p52_cod_filial',
'       and :p52_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_CCUSTO'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879254418076908364)
,p_name=>'P52_COD_UNIDADE_ADM_DSP'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'return :P52_COD_UNIDADE_ADM_X||'' - ''||Initcap(fnct_nome_unidade_adm(:p52_cod_empresa, :p52_cod_filial, :P52_COD_UNIDADE_ADM_X));',
'EXCEPTION',
'WHEN OTHERS THEN',
'RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879254813585908364)
,p_name=>'P52_COD_UNIDADE_ADM_1'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm descricao, a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where a.cod_empresa = :p52_cod_empresa',
'       and a.cod_filial = :p52_cod_filial',
'     order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879255143956908364)
,p_name=>'P52_COD_ATIVIDADE'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t, secao s',
'   where t.ativo = ''S''',
'     and t.cod = s.cod_atividade',
'      -- and s.cod_emp_ccusto = :p52_cod_empresa',
'       and s.cod_ccusto = :p52_cod_ccusto',
'       and s.cod_unid_adm = NVL(:p52_cod_unidade_adm,:P52_COD_UNIDADE_ADM_X)',
'       and s.ativo = ''S''',
'       and :p52_utiliza_secao = ''S''',
'       and ((:P52_COD_REQ IS NULL) OR (:P52_COD_SIT_REQ = 0))',
'union',
'  select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     and :p52_utiliza_secao = ''N''',
'     and ((:P52_COD_REQ IS NULL) OR (:P52_COD_SIT_REQ = 0))',
'union',
'  select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     AND T.COD = :P52_COD_ATIVIDADE_X',
'     and :P52_COD_REQ IS NOT NULL',
'   order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_UNIDADE_ADM,P52_COD_UNIDADE_ADM_X'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_UTILIZA_SECAO,P52_COD_UNIDADE_ADM_X,P52_COD_REQ,P52_COD_SIT_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879255594677908364)
,p_name=>'P52_COD_ATIVIDADE_DSP'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'return :P52_COD_ATIVIDADE_X||'' - ''||Initcap(fnct_nome_atividade(:P52_COD_ATIVIDADE_X));',
'EXCEPTION',
'WHEN OTHERS THEN',
'RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879256007022908364)
,p_name=>'P52_COD_ATIVIDADE_1'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  select /*+ RULE */ distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     and :p52_cod_filial is not null',
'   order by 2 '))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879256419464908364)
,p_name=>'P52_COD_LOCAL_TRAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_prompt=>'Local de Trabalho'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, filial_local f',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       AND l.cod_local_trab = f.cod_local_filial',
'       and not exists (select 1 from unid_adm_secao_local u where u.cod_local_trab = l.cod_local_trab)',
'       AND F.COD_EMPRESA = :p52_COD_EMPRESA',
'       AND F.COD_FILIAL = :P52_COD_FILIAL',
'UNION',
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, unid_adm_secao_local u',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       and l.cod_local_trab = u.cod_local_trab',
'       AND U.COD_EMPRESA = :p52_COD_EMPRESA',
'       AND U.COD_UNIDADE_ADM = nvl(:P52_COD_UNIDADE_ADM_X,:P52_COD_UNIDADE_ADM)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_UNIDADE_ADM_X,P52_COD_UNIDADE_ADM'
,p_ajax_items_to_submit=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_UNIDADE_ADM_X,P52_COD_UNIDADE_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL OR :P52_COD_SIT_REQ = 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879256776882908365)
,p_name=>'P52_COD_LOCAL_TRAB_DSP'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_prompt=>'Local de Trabalho'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'return :P52_COD_LOCAL_TRAB_X||'' - ''||Initcap(fnct_nome_local_trab(:P52_COD_LOCAL_TRAB_X));',
'EXCEPTION',
'WHEN OTHERS THEN',
'RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879257129475908365)
,p_name=>'P52_COD_LOCAL_TRAB_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_prompt=>'Local de Trabalho'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, filial_local f',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       AND l.cod_local_trab = f.cod_local_filial',
'       and not exists (select 1 from unid_adm_secao_local u where u.cod_local_trab = l.cod_local_trab)',
'       AND F.COD_EMPRESA = :p52_COD_EMPRESA',
'       AND F.COD_FILIAL = :P52_COD_FILIAL',
'UNION',
'SELECT distinct l.cod_local_trab||'' - ''||initcap(l.DESCRICAO)||',
'case when trim(endereco) is not null then '' | ''||Initcap(endereco) end ||',
'                 case when trim(numero) is not null then '', ''||numero end ||',
'                 case when trim(complemento) is not null then '' - ''||complemento end ||',
'                 case when trim(bairro) is not null then '' - ''||bairro end ||',
'                 case when trim(cidade) is not null then '', ''||cidade end ||',
'                 case when trim(UF) is not null then ''/''||UF end ||',
'                 case when trim(cep) is not null then '' - CEP: ''||lpad(cep,5,''0'')||''-''||lpad(complemento_cep,3,''0'') end',
'descricao, l.cod_local_trab cod',
'      FROM local_trab l, unid_adm_secao_local u',
'     WHERE nvl(L.ATIVO,''S'') = ''S''',
'       and l.cod_local_trab = u.cod_local_trab',
'       AND U.COD_EMPRESA = :p52_COD_EMPRESA',
'       AND U.COD_UNIDADE_ADM = nvl(:P52_COD_UNIDADE_ADM_X,:P52_COD_UNIDADE_ADM)',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_UNIDADE_ADM_X,P52_COD_UNIDADE_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL OR :P52_COD_SIT_REQ = 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879257609929908366)
,p_name=>'P52_COD_CCUSTO_CONTAB'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('C.Custo Cont\00E1bil')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select distinct b.cod||'' - ''||initcap(b.nome) d, b.cod r',
'      from ccusto_contab b, secao s',
'     where b.cod_empresa = :p52_cod_empresa',
'       and b.cod = s.cod_ccusto_contab',
'     --  and s.cod_emp_ccusto = :p52_cod_empresa',
'       and s.cod_ccusto = :p52_cod_ccusto',
'       and s.cod_unid_adm = NVL(:p52_cod_unidade_adm,:P52_COD_UNIDADE_ADM_X)',
'       and s.cod_atividade = NVL(:p52_cod_atividade, :P52_COD_ATIVIDADE_X)',
'       and :p52_utiliza_secao = ''S''',
'union',
'    select distinct b.cod||'' - ''||initcap(b.nome) nome, b.cod codigo',
'      from ccusto_contab b',
'     where b.cod_empresa = :p52_cod_empresa',
'     and :p52_utiliza_secao = ''N''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_UTILIZA_SECAO,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>4
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879258002424908366)
,p_name=>'P52_COD_CCUSTO_CONTAB_DSP'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('C.Custo Cont\00E1bil')
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'RETURN :P52_COD_CCUSTO_CONTAB_X||'' - ''||INITCAP(FNCT_NOME_CCUSTO_CONTAB(:P52_COD_EMPRESA,:P52_COD_CCUSTO_CONTAB_X));',
'',
'EXCEPTION',
'WHEN OTHERS THEN',
'RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879258398587908366)
,p_name=>'P52_COD_CCUSTO_CONTAB_1'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('C.Custo Cont\00E1bil')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select distinct b.cod||'' - ''||initcap(b.nome) nome, b.cod codigo',
'      from ccusto_contab b',
'     where b.cod_empresa = :p52_cod_empresa',
'       and :p52_cod_vaga is not null',
'       and b.cod = :p52_cod_ccusto_contab_x',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_VAGA,P52_COD_CCUSTO_CONTAB_X'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879258762457908366)
,p_name=>'P52_COD_UN_NEGOCIO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Unidade de Neg\00F3cio')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select distinct a.cod_un_negocio||'' - ''||initcap(a.nome_un_negocio) descricao, a.cod_un_negocio codigo',
'      from unidade_de_negocio a',
'     where a.cod_empresa = :p52_cod_empresa',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879259161202908366)
,p_name=>'P52_COD_UN_NEGOCIO_1'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_prompt=>unistr('Unidade de Neg\00F3cio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select distinct a.cod_un_negocio||'' - ''||initcap(a.nome_un_negocio) descricao, a.cod_un_negocio codigo',
'      from unidade_de_negocio a',
'     where a.cod_empresa = :p52_cod_empresa',
'       and :p52_cod_filial is not null',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879259532103908367)
,p_name=>'P52_REFEITORIO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Possui Refeit\00F3rio?')
,p_source=>'REFEITORIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'12'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879259976154908367)
,p_name=>'P52_DATA_INICIO'
,p_source_data_type=>'DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Data de In\00EDcio')
,p_placeholder=>'- Selecione -'
,p_source=>'DATA_INICIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879260377235908367)
,p_name=>'P52_DATA_FIM'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Data de Encerramento'
,p_placeholder=>'- Selecione -'
,p_source=>'DATA_FIM'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879260804447908367)
,p_name=>'P52_DESC_LOCAL'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_prompt=>'Detalhe do Local de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879261132257908368)
,p_name=>'P52_MAT_SUBS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Colaborador Substitu\00EDdo')
,p_placeholder=>'- Selecione -'
,p_source=>'MAT_SUBS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct v.matricula||'' - ''||Initcap(a.nome) d, v.matricula c',
'  from cl_historico_vaga_func v,',
'       inf_pessoais a',
' where v.cod_empresa = a.cod_empresa',
'   and v.matricula = a.matricula',
'   and v.cod_empresa = :p52_cod_empresa',
'   and v.cod_filial = :p52_cod_filial',
'   and v.cod_vaga = :p52_cod_vaga',
'   AND :P52_FLAG_TEMPORARIO = ''N''',
'   and dt_inicio_vaga = (select max(x.dt_inicio_vaga)',
'                            from cl_historico_vaga_func x',
'                           where x.cod_empresa = v.cod_empresa',
'                             and x.cod_filial = v.cod_filial',
'                             and x.cod_vaga = v.cod_vaga)',
'union',
'select distinct d.mat_solicitado||'' - ''||Initcap(fnct_nome_func(d.cod_empresa, d.mat_solicitado)) d, d.mat_solicitado c',
'  from desligamento d',
' where d.cod_empresa = :p52_cod_empresa',
'   and d.cod_filial = :p52_cod_filial',
'   AND d.havera_rep = ''S''',
'   and d.cod_sit_desligamento IN (1,2,5) ',
'   and d.dt_desligamento >= add_months(trunc(sysdate),-12)',
'   AND :P52_FLAG_TEMPORARIO = ''S''',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_FLAG_TEMPORARIO'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL OR :P52_COD_SIT_REQ = 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879261586355908368)
,p_name=>'P52_MAT_SUBS_X'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879261926059908368)
,p_name=>'P52_MOT_SUBS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Motivo de Substitui\00E7\00E3o')
,p_source=>'MOT_SUBS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  COD_MOT_SUBS||'' - ''||initcap(desc_mot_subs) descricao, COD_MOT_SUBS  ',
'from mot_SUBS',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879262326421908368)
,p_name=>'P52_PONTOS_AVAL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('\00DAltima Avalia\00E7\00E3o')
,p_source=>'PONTOS_AVAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'0'
,p_attribute_02=>'999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879262812468908368)
,p_name=>'P52_COD_CCUSTO_X'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_CCUSTO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879263155304908368)
,p_name=>'P52_COD_CCUSTO_Y'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879263529240908368)
,p_name=>'P52_NOME_CCUSTO_Y'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879263997065908369)
,p_name=>'P52_COD_UNIDADE_ADM_X'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_UNIDADE_ADM'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879264329473908369)
,p_name=>'P52_COD_UNIDADE_ADM_Y'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879264814970908369)
,p_name=>'P52_NOME_UNIDADE_ADM_Y'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879265208268908369)
,p_name=>'P52_COD_ATIVIDADE_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_ATIVIDADE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879265612922908369)
,p_name=>'P52_COD_ATIVIDADE_Y'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879265974311908369)
,p_name=>'P52_NOME_ATIVIDADE_Y'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879266408654908369)
,p_name=>'P52_COD_LOCAL_TRAB_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879266764770908370)
,p_name=>'P52_COD_LOCAL_TRAB_Y'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879267151786908370)
,p_name=>'P52_NOME_LOCAL_TRAB_Y'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(6849871349759323435)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879267537767908370)
,p_name=>'P52_COD_CCUSTO_CONTAB_X'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_CCUSTO_CONTAB'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879267939646908370)
,p_name=>'P52_COD_CCUSTO_CONTAB_Y'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879268361219908370)
,p_name=>'P52_NOME_CCUSTO_CONTAB_Y'
,p_item_sequence=>580
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879268777469908370)
,p_name=>'P52_COD_UN_NEGOCIO_X'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>590
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_source=>'COD_UN_NEGOCIO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879269198550908370)
,p_name=>'P52_COD_UN_NEGOCIO_Y'
,p_item_sequence=>600
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879269557395908371)
,p_name=>'P52_NOME_UN_NEGOCIO_Y'
,p_item_sequence=>610
,p_item_plug_id=>wwv_flow_api.id(6849871542875323436)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879270246216908371)
,p_name=>'P52_VAGA_FATURAVEL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>unistr('Vaga Fatur\00E1vel')
,p_source=>'VAGA_FATURAVEL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879270637646908371)
,p_name=>'P52_VALOR_FATURAVEL'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Valor (R$)'
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_FATURAVEL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879271641415908373)
,p_name=>'P52_IDADE_MIN'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(170359329206667691657)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Idade M\00EDnima')
,p_source=>'IDADE_MIN'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>10
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879272095054908373)
,p_name=>'P52_IDADE_MAX'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(170359329206667691657)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Idade M\00E1xima')
,p_source=>'IDADE_MAX'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879272796435908373)
,p_name=>'P52_SEXO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(170359329268999691658)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Sexo'
,p_source=>'SEXO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Feminino;F,Masculino;M,Ambos;A'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879273485642908373)
,p_name=>'P52_ANOS_SERVICO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Experi\00EAncia Anos')
,p_source=>'ANOS_SERVICO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879273899779908374)
,p_name=>'P52_MESES_SERVICO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Experi\00EAncia Meses')
,p_source=>'MESES_SERVICO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'0'
,p_attribute_02=>'12'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879274564688908374)
,p_name=>'P52_IND_DEF_FIS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>'PCD'
,p_source=>'IND_DEF_FIS'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC: Sim;S, N\00E3o;N')
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879274998972908374)
,p_name=>'P52_RAIS_IND_DEF_AUDITIVA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Auditiva'
,p_source=>'RAIS_IND_DEF_AUDITIVA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879275360827908374)
,p_name=>'P52_RAIS_IND_DEF_FISICO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('F\00EDsica')
,p_source=>'RAIS_IND_DEF_FISICO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879275749355908374)
,p_name=>'P52_RAIS_IND_DEF_MENTAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Mental'
,p_source=>'RAIS_IND_DEF_MENTAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879276153716908375)
,p_name=>'P52_RAIS_IND_DEF_MULTIPLA'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Multipla'
,p_source=>'RAIS_IND_DEF_MULTIPLA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879276625185908375)
,p_name=>'P52_RAIS_IND_DEF_VISUAL'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Visual'
,p_source=>'RAIS_IND_DEF_VISUAL'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC:Sim;S'
,p_lov_display_null=>'YES'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879277285380908375)
,p_name=>'P52_COD_INSTRUCAO'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Grau de Instru\00E7\00E3o')
,p_source=>'COD_INSTRUCAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>'select COD||'' - ''||initcap(nome) nome, cod codigo from instrucao order by cod'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_field_template=>wwv_flow_api.id(54947250751136418876)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Selecionar o grau de instru\00E7\00E3o igual a descri\00E7\00E3o do cargo.')
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879278486333908376)
,p_name=>'P52_IND_INSALUB'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(170359329601330691661)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Insalubridade'
,p_source=>'IND_INSALUB'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC: ;S'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879278835967908376)
,p_name=>'P52_IND_PERIC'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(170359329601330691661)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Periculosidade'
,p_source=>'IND_PERIC'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879279557742908376)
,p_name=>'P52_TIPO_CONTRATO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'I'
,p_prompt=>'Tipo de Contrato'
,p_source=>'TIPO_CONTRATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Determinado;D,Indeterminado;I'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Determinado se refere a atividades tempor\00E1rias ou transit\00F3rias, indeterminado a atividades n\00E3o tempor\00E1rias apenas dependentes de avalia\00E7\00E3o ap\00F3s 90 dias')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879280514099908377)
,p_name=>'P52_DT_PREVISAO_ADMISSAO'
,p_source_data_type=>'DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Data Prevista de Admiss\00E3o')
,p_placeholder=>'- Selecione -'
,p_source=>'DT_PREVISAO_ADMISSAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879280869280908378)
,p_name=>'P52_DT_PREV_FIM_CONTRATO'
,p_source_data_type=>'DATE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Data Prevista de Fim de Contrato'
,p_placeholder=>'- Selecione -'
,p_source=>'DT_PREV_FIM_CONTRATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879281542962908378)
,p_name=>'P52_CANDIDATO_INDICADO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Candidato Indicado'
,p_source=>'CANDIDATO_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'CANDIDATO INDICATO - REQ. PESSOAL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_candidato, initcap(nvl(nome_social,nome)) nome, substr(lpad(num_cpf,9,''0''),1,3)||''.''||',
'       substr(lpad(num_cpf,9,''0''),4,3)||''.''||',
'       substr(lpad(num_cpf,9,''0''),7,3)||''-''||',
'       lpad(dc_cpf,2,0) cpf, e_mail',
'  from inf_pessoais_candidato',
' where status_candidato = ''P''',
'   and trim(e_mail) is not null',
'   and trim(nome) is not null',
' order by 2 desc'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Indica pr\00E9-aprova\00E7\00E3o da \00E1rea, necessita cadastro pr\00E9vio no Natcorp.')
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879282461109908379)
,p_name=>'P52_NOME_INDICADO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Nome'
,p_source=>'NOME_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879282912689908379)
,p_name=>'P52_E_MAIL_INDICADO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'E-Mail'
,p_source=>'E_MAIL_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879283233124908379)
,p_name=>'P52_DDD_INDICADO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'DDD'
,p_placeholder=>'Ex.: 11'
,p_source=>'DDD_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879283632972908379)
,p_name=>'P52_TELEFONE_INDICADO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Telefone'
,p_placeholder=>'Ex.: 977775555'
,p_source=>'TELEFONE_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>9
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879284117167908379)
,p_name=>'P52_CPF_INDICADO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(170359329947293691664)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'CPF'
,p_source=>'CPF_INDICADO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>14
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879284750583908380)
,p_name=>'P52_NOVO_CONTRATO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>'Novo Contrato / Cliente'
,p_source=>'NOVO_CONTRATO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879285162927908380)
,p_name=>'P52_ORGAO_PUBLICO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_item_default=>'N'
,p_prompt=>unistr('\00D3rg\00E3o P\00FAblico')
,p_source=>'ORGAO_PUBLICO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879285608661908380)
,p_name=>'P52_VALOR_VENDA'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(170359331864683691683)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Valor de Venda (R$)'
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_VENDA'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879295492689908385)
,p_name=>'P52_EMP_GESTOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(179546776410817386961)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Empresa'
,p_source=>'EMP_GESTOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(e.nome_abrev) descricao, e.cod codigo ',
'  from empresas e',
' WHERE exists (select distinct x.cod_emp_gestor ',
'                 from centro_de_custo x ',
'                where x.matricula_gestor is not null ',
'                  and x.cod_emp_gestor = e.cod)',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879295873940908385)
,p_name=>'P52_MAT_GESTOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(179546776410817386961)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_GESTOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) nome, i.matricula cod',
'  from centro_de_custo c, informacoes_funcionais_cad i',
' where c.cod_emp_gestor = i.cod_empresa',
'   and c.matricula_gestor = i.matricula',
'   and i.situacao < ''90''',
'   and c.cod_emp_gestor = :p52_emp_gestor_ind',
' order by 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_EMP_GESTOR_IND'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879296576502908386)
,p_name=>'P52_EMP_AVALIADOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(179546776469422386962)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>'Empresa'
,p_source=>'EMP_AVALIADOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(e.nome_abrev) descricao, e.cod codigo ',
'  from empresas e',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(37879296961229908386)
,p_name=>'P52_MAT_AVALIADOR_IND'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(179546776469422386962)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_AVALIADOR_IND'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) nome, i.matricula cod',
'  from informacoes_funcionais_cad i',
' where i.situacao < ''90''',
'   and i.cod_empresa = :p52_emp_avaliador_ind',
' order by 2;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_EMP_AVALIADOR_IND'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(38461889144061029995)
,p_name=>'P52_COD_SINDICATO_AUX'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(170359328723106691652)
,p_item_default=>'P52_COD_SINDICATO'
,p_item_default_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(38771877713419356076)
,p_name=>'P52_TIPO_PUBLICACAO'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(6849871255612323434)
,p_item_source_plug_id=>wwv_flow_api.id(170359329777970691663)
,p_prompt=>unistr('Tipo de Publica\00E7\00E3o')
,p_source=>'TIPO_PUBLICACAO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Externo;E,Interno;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_null_value=>'T'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(54947250589428418875)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(37879298554155908392)
,p_computation_sequence=>10
,p_computation_item=>'P52_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_USUARIO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(37879298128508908391)
,p_computation_sequence=>20
,p_computation_item=>'P52_MARCA_PONTO'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VMARCA_PONTO REQUISICAO.MARCA_PONTO%TYPE := :P52_MARCA_PONTO;',
'BEGIN',
'  IF :P52_COD_VAGA IS NOT NULL THEN',
'    BEGIN',
'      SELECT NVL(MARCA_PONTO,''S'')',
'      INTO   VMARCA_PONTO',
'      FROM   CL_VAGA WHERE COD_VAGA = :P52_COD_VAGA AND COD_FILIAL = :P52_COD_FILIAL AND COD_EMPRESA = :P52_COD_EMPRESA;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VMARCA_PONTO := NULL;',
'    END;',
'  END IF;',
'  RETURN(VMARCA_PONTO);',
'END;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(37879297811331908389)
,p_computation_sequence=>30
,p_computation_item=>'P52_TP_REGISTRO_PONTO'
,p_computation_type=>'FUNCTION_BODY'
,p_computation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VTP_REGISTRO_PONTO REQUISICAO.TP_REGISTRO_PONTO%TYPE := :P52_TP_REGISTRO_PONTO;',
'BEGIN',
'  IF :P52_COD_VAGA IS NOT NULL THEN',
'    BEGIN',
'      SELECT NVL(TP_REGISTRO_PONTO,''S'')',
'      INTO   VTP_REGISTRO_PONTO',
'      FROM   CL_VAGA WHERE COD_VAGA = :P52_COD_VAGA AND COD_FILIAL = :P52_COD_FILIAL AND COD_EMPRESA = :P52_COD_EMPRESA;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        VTP_REGISTRO_PONTO := NULL;',
'    END;',
'  END IF;',
'  RETURN(VTP_REGISTRO_PONTO);',
'END;'))
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(37879298970564908392)
,p_computation_sequence=>40
,p_computation_item=>'P52_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'sysdate'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879307330296908398)
,p_validation_name=>'Cod_Empresa'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_empresa is null and nvl(:p52_aprov,''N'') = ''N'' then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Empresa precisa ser preenchido!'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879249413733908360)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879307820630908398)
,p_validation_name=>'Cod_Filial'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_filial is null and nvl(:p52_aprov,''N'') = ''N'' then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Filial precisa ser preenchido!'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879250704234908361)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879308194829908398)
,p_validation_name=>'Cod_CCusto'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_ccusto is null and nvl(:p52_aprov,''N'') = ''N'' and :p52_cod_vaga is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Hierarquia precisa ser preenchido!'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879252802684908363)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879308593799908398)
,p_validation_name=>'Cod_Horario'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_horario is null and nvl(:p52_aprov,''N'') = ''N'' and nvl(:p52_cod_vaga,:p52_cod_vaga_1) is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Campo Hor\00E1rio precisa ser preenchido!')
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879225381469908349)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879306981547908398)
,p_validation_name=>'Cod_Instrucao'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_instrucao is null and nvl(:p52_aprov,''N'') = ''N'' and :p52_cod_vaga is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Campo Instru\00E7\00E3o precisa ser preenchido!')
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879277285380908375)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879308977306908398)
,p_validation_name=>'Mot_Subs'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_mat_subs is not null and :p52_mot_subs is null and nvl(:p52_aprov,''N'') = ''N'' then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Campo Motivo de Substitui\00E7\00E3o precisa ser preenchido!')
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879261926059908368)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879309393485908398)
,p_validation_name=>'Cod_Vaga'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_flag_temporario = ''N'' and :p52_cod_vaga is null and nvl(:p52_aprov,''N'') = ''N'' then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Vaga precisa ser preenchido!'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879251620079908361)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879306559307908397)
,p_validation_name=>'valida_vaga'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p52_cod_vaga is not null and Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') <> ''S'' then',
'',
' pkg_pessoal.Valida_Vaga (to_number(:p52_cod_empresa), to_number(:p52_cod_filial), :p52_cod_vaga, v_flg_retorno, v_msg_retorno);',
'',
'if trim(v_msg_retorno) is not null then',
'return trim(v_msg_retorno);',
'end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879251620079908361)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8178922597135887768)
,p_validation_name=>'Cod_Sindicato'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_sindicato is null and nvl(:p52_aprov,''N'') = ''N'' then',
'return false;',
'else ',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Sindicato X0 precisa ser preenchido!'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(37879232694808908354)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(8178922773279887769)
,p_validation_name=>'Cod_Sindicato_1'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_sindicato_1 is null /*and nvl(:p52_aprov,''N'') = ''N''*/ then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Campo Sindicato X1 precisa ser preenchido!'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(37879233551106908354)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879305819263908397)
,p_validation_name=>unistr('Valida Total Remunera\00E7\00E3o')
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if nvl(:P52_TOTAL_SALARIO,0) = 0 and :P52_FLAG_TEMPORARIO = ''S'' and :p52_rowid is null and :p52_vinculo_x <> ''A'' then',
unistr('return(''O Campo Total Remunera\00E7\00E3o n\00E3o pode ser nulo!'');'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_associated_item=>wwv_flow_api.id(37879241054448908357)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879303740069908396)
,p_validation_name=>unistr('Valida Total Sal\00E1rio')
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_total_salario number := replace(replace(nvl(:P52_TOTAL_SALARIO,0),''R$''),''.'');',
'v_remuneracao_variavel number := replace(replace(nvl(:p52_remuneracao_variavel,0),''R$''),''.'');',
'',
'begin',
'',
'if :P52_FLAG_TEMPORARIO = ''S'' then',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'  begin',
'    pkg_pessoal.Valida_Salario(:p52_cod_empresa, :p52_cod_filial, :p52_cod_vaga, v_total_salario, v_remuneracao_variavel, v_flg_retorno, v_msg_retorno, :P52_VINCULO_X);',
'  end;',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_associated_item=>wwv_flow_api.id(37879241054448908357)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879306197226908397)
,p_validation_name=>'Valida Salario'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P52_SALARIO is null and :P52_FLAG_TEMPORARIO = ''S'' and :p52_rowid is null then',
unistr('return(''O Campo Sal\00E1rio n\00E3o pode ser nulo!'');'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879243308061908358)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879300585269908395)
,p_validation_name=>'Valida Piso Salario'
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'',
'V_DT DATE;',
'',
'cursor c1 is',
'select cod_empresa',
'  from requisicao',
' where cod_req = :p52_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'IF :P52_ROWID IS NULL THEN',
'V_DT := SYSDATE;',
'ELSE',
'V_DT := :P52_DT_REQ;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'END IF;',
'',
'pkg_pessoal.Valida_Piso_Salario (:P52_SALARIO',
'                           ,nvl(:P52_COD_EMPRESA,v_c1.cod_empresa)',
'                           ,:P52_COD_CARGO_X',
'                           ,:P52_COD_SINDICATO_X',
'                           ,:P52_RT_JORNADA_MENSAL_X',
'                           ,:P52_TIPO_SALARIO',
'                           ,V_DT',
'                           ,V_FLG',
'                           ,V_MSG);',
'',
' if trim(v_msg) is not null then',
'    IF V_FLG = ''N'' THEN',
'      return v_msg;',
'    END IF;',
' end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879243308061908358)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879304943128908397)
,p_validation_name=>unistr('Valida Campos Obrigat\00F3rios')
,p_validation_sequence=>170
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :P52_UTILIZA_SECAO = ''S'' and (:P52_COD_CCUSTO_X IS NULL OR :P52_COD_UNIDADE_ADM_X IS NULL OR :P52_COD_ATIVIDADE_X IS NULL) then',
unistr('return(''Os campos de Centro de Custo (C\00E9lula), Unidade Adm. (Cliente) e Atividade (Servi\00E7o) s\00E3o obrigat\00F3rios!'');'),
'elsif :P52_COD_LOCAL_TRAB_X IS NULL then',
unistr('return(''O campo de Local de Trabalho \00E9 obrigat\00F3rio!'');'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879305359287908397)
,p_validation_name=>unistr('Sindicato Obrigat\00F3rio')
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_SINDICATO_X is null and :P52_ROWID is null then',
unistr('return ''O campo Sindicato n\00E3o pode ser nulo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879302955094908396)
,p_validation_name=>unistr('V\00EDnculo Obrigat\00F3rio')
,p_validation_sequence=>190
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_VINCULO_X is null then',
unistr('return ''O campo V\00EDnculo n\00E3o pode ser nulo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879301412520908396)
,p_validation_name=>'Valida Valor X Benef'
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio number := replace(replace(:P52_PERC_BENEFICIO,''R$''),''.'');',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'if 1 = 2 then',
'  IF ((:P52_ROWID IS NULL) OR (:P52_COD_SIT_REQ IN (1,5) AND :P52_ROWID IS NOT NULL))',
'  THEN',
'',
'    pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                       :p52_cod_filial,',
'                                       :p52_cod_ccusto,',
'                                       :p52_cod_cargo,',
'                                       :p52_cod_sindicato,',
'                                       :p52_cod_unidade_adm,',
'                                       :p52_cod_un_negocio,',
'                                       :p52_cod_atividade,',
'                                       NULL,--:p52_cod_vaga,',
'                                       :p52_refeitorio,',
'                                       nvl(nvl(:p52_vinculo,:P52_VINCULO_X),:p52_vinculo_1),',
'                                        v_valor_beneficio,',
'                                        V_PERC_BENEFICIO,',
'                                        :P52_RT_JORNADA_MENSAL_X,',
'                                    :p52_cod_horario_x);',
'',
'    if nvl(v_remuneracao_variavel,0) = nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''O valor de benef\00EDcio \00E9 exatamente igual ao obrigat\00F3rio para os par\00E2metros informados. Para este caso, informe o tipo de remunera\00E7\00E3o como Full-CLT.'';'),
'',
'    elsif nvl(v_remuneracao_variavel,0) < nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''O valor de benef\00EDcio \00E9 menor do que o obrigat\00F3rio para os par\00E2metros informados.'';'),
'',
'    elsif nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and nvl(v_valor_beneficio,0) > 0 then',
'',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''O valor de benef\00EDcio \00E9 diferente do obrigat\00F3rio (''||v_valor_beneficio||'') para os par\00E2metros informados. Para este caso, Full-CLT, informe o valor do benef\00EDcio corretamente.'';'),
'    ',
'    elsif nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and nvl(v_valor_beneficio,0) = 0 and :p52_refeitorio = ''S'' then',
'    ',
'     v_flg_retorno := ''N'';',
unistr('     v_msg_retorno := ''Para Full-CLT e havendo Refeit\00F3rio no Local, o valor de Remunera\00E7\00E3o Vari\00E1vel (R$''||:p52_remuneracao_variavel||'') deve ser de R$0,00''||'),
unistr('     case when :p52_rowid is not null then ''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'' else ''.'' end;'),
'    ',
'    end if;',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is null then',
'     return v_msg_retorno;',
'    end if;',
'',
'  END IF;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879304621198908397)
,p_validation_name=>'Valida Benef/Equip'
,p_validation_sequence=>210
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select *',
'  from beneficios_vaga_temp',
' where seq = :p52_seq;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select utiliza_benef_vaga valida',
'  from parametros_recursos_humanos',
' where cod_empresa = :p52_cod_empresa;',
' ',
'v_c2 c2%rowtype;',
' ',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  open c2;',
'  fetch c2 into v_c2;',
'  close c2;',
'',
'  if nvl(v_c2.valida,''N'') = ''S'' then',
'',
'    if v_c1.cod_beneficio is null then',
unistr('    return ''\00C9 necess\00E1rio informar ao menos um benef\00EDcio/equipamento!'';'),
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879304204824908397)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_COD_SIT_REQ = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879126659197908291)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879303418746908396)
,p_validation_name=>unistr('Valida\00E7\00E3o Motivo Exce\00E7\00E3o')
,p_validation_sequence=>230
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_PERC_BENEFICIO_VARIAVEL = 0 and :p52_MOTIVO_EXCECAO is null then',
unistr('return ''Informe o motivo da exce\00E7\00E3o do percentual de benef\00EDcio.'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_associated_item=>wwv_flow_api.id(37879244969324908358)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879302203228908396)
,p_validation_name=>unistr('Tipo Sal\00E1rio')
,p_validation_sequence=>240
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_TIPO_SALARIO IS NULL AND :P52_TOTAL_SALARIO IS NOT NULL THEN',
unistr('RETURN ''Informe o Tipo do Sal\00E1rio!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_associated_item=>wwv_flow_api.id(37879240204071908357)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879299787089908394)
,p_validation_name=>'Valida Categoria'
,p_validation_sequence=>250
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_CARGO_X IS NOT NULL AND :P52_COD_CATEGORIA_X IS NULL THEN',
unistr('RETURN ''Informe o C\00F3digo de Categoria do Cargo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_associated_item=>wwv_flow_api.id(37879238273050908356)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879302619314908396)
,p_validation_name=>'Valida_Sit_Req'
,p_validation_sequence=>260
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000); ',
'',
'cursor c1 is',
'select TRIM(TO_CHAR(cod_sit_REQ)) cod_sit_solicitacao, cod_sit_req, prospeccao',
'  from REQUISICAO',
' where cod_req = :P52_COD_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF v_c1.cod_sit_solicitacao IS NOT NULL and :P52_COD_SIT_REQ is not null and :P52_COD_SIT_REQ <> v_c1.cod_sit_solicitacao THEN',
'',
'    if :P52_COD_SIT_REQ = v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (1,5) and :P52_COD_SIT_REQ in (3,6) then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao = 6 and :P52_COD_SIT_REQ = 1 then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (2,3,4) and :P52_COD_SIT_REQ <> v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar a situa\00E7\00E3o desta requisi\00E7\00E3o.'';'),
'    /*',
'    else',
'      if v_c1.cod_sit_req <> :p52_cod_sit_req and v_c1.prospeccao = ''N'' and :p52_prospeccao = ''N'' then',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar para a situa\00E7\00E3o escolhida.'';'),
'      end if;',
'    */',
'    end if;',
'',
'END IF;',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'  return v_msg_retorno;',
' end if; ',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(37879126659197908291)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879301768043908396)
,p_validation_name=>'Valida Cod_Horario'
,p_validation_sequence=>270
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select utiliza_horario_vaga valida',
'  from parametros_recursos_humanos',
' where cod_empresa = :p52_cod_empresa;',
' ',
'v_c1 c1%rowtype;',
' ',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'',
'  if nvl(v_c1.valida,''N'') = ''S'' then',
'',
'    if :p52_cod_horario_x is null then',
unistr('    return ''\00C9 necess\00E1rio informar o Hor\00E1rio Contratual!'';'),
'    end if;',
'',
'  end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879228732611908352)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879301003249908395)
,p_validation_name=>'Valida Perc Benf Excecao'
,p_validation_sequence=>280
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_PERC NUMBER; ',
'',
'BEGIN',
'',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'V_PERC := :P52_PERC_BENEF_EXCECAO;',
'',
'if nvl(V_PERC,0) < 0 or nvl(V_PERC,0) > 100 then',
unistr('return ''Percentual de Remunera\00E7\00E3o Var\00EDavel Inv\00E1lido!'';'),
'end if;',
'',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CREATE,SAVE'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879242844501908358)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879300193795908395)
,p_validation_name=>'CRIAR_IGUAL (Validacoes)'
,p_validation_sequence=>290
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'CURSOR C_REQ IS',
'SELECT *',
'  FROM REQUISICAO',
' WHERE COD_REQ = :P52_COD_REQ;',
' ',
'V_REQ C_REQ%ROWTYPE;',
'',
'V_TOTAL_SALARIO NUMBER;',
'V_VALOR_BENEFICIO NUMBER;',
'',
'v_flg varchar2(1) := ''S'';',
'v_msg varchar2(4000);',
'',
'SAIDA EXCEPTION;',
'',
'begin',
'',
'   OPEN C_REQ;',
'  FETCH C_REQ INTO V_REQ;',
'  CLOSE C_REQ;',
'  ',
'  V_TOTAL_SALARIO := NVL(V_REQ.SALARIO,0) + NVL(V_REQ.REMUNERACAO_VARIAVEL,0);',
'',
'  Pkg_Pessoal.Valida_Filial (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' v_flg,',
' v_msg);',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'  ',
'  Pkg_Pessoal.Valida_Ccusto (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_vaga,',
' V_REQ.cod_cargo,',
' v_flg,',
' v_msg);',
'  ',
'  if v_flg = ''N'' then raise saida; end if;',
'',
'  if V_REQ.cod_unidade_adm is not null then',
'  Pkg_Pessoal.Valida_Unidade_Adm (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_unidade_adm,',
' v_flg,',
' v_msg);',
' end if;',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'  ',
'  if v_req.cod_atividade is not null then',
'  Pkg_Pessoal.Valida_Atividade (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_unidade_adm,',
' V_REQ.cod_atividade,',
' v_flg,',
' v_msg);',
' end if;',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'',
'Pkg_Pessoal.Valida_Local (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_unidade_adm,',
' V_REQ.cod_atividade,',
' V_REQ.cod_local_trab,',
' v_flg,',
' v_msg);',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'',
'  Pkg_Pessoal.Valida_Cargo (V_REQ.FLAG_TEMPORARIO',
' ,V_REQ.COD_EMPRESA',
' ,V_REQ.COD_FILIAL',
' ,V_REQ.COD_CARGO',
' ,V_FLG',
' ,V_MSG);',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'           ',
'    pkg_pessoal.Valida_Salario(V_REQ.cod_empresa, V_REQ.cod_filial, V_REQ.cod_vaga, v_total_salario, V_REQ.remuneracao_variavel, v_flg, v_msg, V_REQ.VINCULO);',
'                      ',
'  if v_flg = ''N'' then raise saida; end if;          ',
'                      ',
'    pkg_pessoal.Valida_Piso_Salario (V_REQ.SALARIO',
'     ,V_REQ.COD_EMPRESA',
'     ,V_REQ.COD_CARGO',
'     ,V_REQ.COD_SINDICATO',
'     ,V_REQ.RT_JORNADA_MENSAL',
'     ,V_REQ.TIPO_SALARIO                                ',
'     ,SYSDATE',
'     ,V_FLG',
'     ,V_MSG);',
'                           ',
'  if v_flg = ''N'' then raise saida; end if;',
'  ',
'  pkg_pessoal.Valida_Remuneracao_Variavel(V_REQ.cod_empresa, V_REQ.cod_filial, V_REQ.cod_vaga, V_REQ.salario, V_REQ.remuneracao_variavel, v_flg, v_msg);',
'  ',
'  if v_flg = ''N'' then raise saida; end if;',
'  ',
'pkg_pessoal.retorna_benef_sindicato (V_REQ.cod_empresa,',
'   V_REQ.cod_filial,',
'   V_REQ.cod_ccusto,',
'   V_REQ.cod_cargo,',
'   V_REQ.cod_sindicato,',
'   V_REQ.cod_unidade_adm,',
'   V_REQ.cod_un_negocio,',
'   V_REQ.cod_atividade,',
'   V_REQ.cod_vaga,',
'   V_REQ.refeitorio,',
'   V_REQ.VINCULO,',
'    v_valor_beneficio,',
'    null,',
'   V_REQ.RT_JORNADA_MENSAL,',
'   V_REQ.cod_horario);',
'',
'if V_REQ.remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg := ''N'';',
unistr('v_msg := ''Valor de benef\00EDcios R$''||V_REQ.remuneracao_variavel||'' n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'if v_flg = ''N'' then raise saida; end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and V_REQ.remuneracao_variavel <> nvl(v_valor_beneficio,0) and V_REQ.perc_beneficio_variavel is null then',
'v_flg := ''N'';',
unistr('v_msg := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'if v_flg = ''N'' then raise saida; end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and ',
'   nvl(V_REQ.remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and ',
'   V_REQ.PERC_BENEFICIO_VARIAVEL is null then',
'    v_flg := ''N'';',
unistr('    v_msg := ''Para Full-CLT, o valor de Remunera\00E7\00E3o Vari\00E1vel (R$''||V_REQ.remuneracao_variavel||'') n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'  ',
'if v_flg = ''N'' then raise saida; end if;',
'  ',
'exception ',
'when saida then',
'return v_msg;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37879299407262908393)
,p_validation_name=>'Valida RT_JORNADA_MENSAL'
,p_validation_sequence=>300
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select rt_jornada_mensal, cod_horario',
'  from requisicao',
' where cod_req = :p52_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p52_rt_jornada_mensal is null and v_c1.rt_jornada_mensal is not null then',
unistr('  return ''Preencha a Carga Hor\00E1ria!'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879223612285908348)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(37671817531161162208)
,p_validation_name=>'Valida Aprovador'
,p_validation_sequence=>310
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_empresa, filial, cod_ccusto, matricula',
'  from informacoes_funcionais_cad',
' where cod_empresa = :P_EMPRESA_USER',
'   and matricula = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'if 1 = 2 then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'v_flg_retorno := pkg_req.VALIDA_EXISTE_APROV(v_c1.cod_empresa,',
'                                              v_c1.filial,',
'                                              v_c1.cod_ccusto,',
'                                              v_c1.matricula,',
'                                              :p_empresa_user, ',
'                                              :p_matricula_user, ',
'                                              null, ',
'                                              ''REQ_PESSOAL'');',
'',
'    if nvl(v_flg_retorno,''S'') = ''N'' then',
unistr('        return ''N\00E3o foi parametrizado aprovadores para sua requisi\00E7\00E3o. Por favor, entrar em contato com os administradores do sistema!'';'),
'    else ',
'        return null;',
'    end if;',
'end if;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(37879127043764908292)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(9618762280947394963)
,p_validation_name=>'Valida Elegibilidade Fil'
,p_validation_sequence=>320
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vSindicato   sindicatos.cod%TYPE DEFAULT :P52_COD_SINDICATO; ',
'BEGIN',
'  IF :P52_FLAG_TEMPORARIO = ''S'' THEN',
'    IF :P52_COD_EMPRESA IS NOT NULL AND vSindicato IS NOT NULL AND :P52_COD_FILIAL IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => :P52_COD_EMPRESA',
'                                                 ,psindicato => vSindicato',
'                                                 ,pFilial    => :P52_COD_FILIAL',
'                                                 ,pCCusto    => NULL',
'                                                 ,pUnidAdm   => NULL',
'                                                 ,pAtividade => NULL',
'                                                 ,pLocalTrab => NULL);',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879250704234908361)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(9633250867051431565)
,p_validation_name=>'Valida Elegibilidade CCst'
,p_validation_sequence=>330
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vSindicato   sindicatos.cod%TYPE DEFAULT :P52_COD_SINDICATO;',
'BEGIN',
'  IF :P52_FLAG_TEMPORARIO = ''S'' THEN',
'    IF :P52_COD_EMPRESA IS NOT NULL AND vSindicato IS NOT NULL AND :P52_COD_CCUSTO IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => :P52_COD_EMPRESA',
'                                                 ,psindicato => vSindicato',
'                                                 ,pFilial    => NULL',
'                                                 ,pCCusto    => :P52_COD_CCUSTO',
'                                                 ,pUnidAdm   => NULL',
'                                                 ,pAtividade => NULL',
'                                                 ,pLocalTrab => NULL);',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879252802684908363)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(9633251005272431566)
,p_validation_name=>'Valida Elegibilidade Unid. Adm.'
,p_validation_sequence=>340
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vSindicato   sindicatos.cod%TYPE DEFAULT :P52_COD_SINDICATO;',
'BEGIN',
'  IF :P52_FLAG_TEMPORARIO = ''S'' THEN',
'    IF :P52_COD_EMPRESA IS NOT NULL AND vSindicato IS NOT NULL AND :P52_COD_UNIDADE_ADM IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => :P52_COD_EMPRESA',
'                                                 ,psindicato => vSindicato',
'                                                 ,pFilial    => NULL',
'                                                 ,pCCusto    => NULL',
'                                                 ,pUnidAdm   => :P52_COD_UNIDADE_ADM',
'                                                 ,pAtividade => NULL',
'                                                 ,pLocalTrab => NULL);',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879253978125908363)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(9633251085979431567)
,p_validation_name=>'Valida Elegibilidade Ativid.'
,p_validation_sequence=>350
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vSindicato   sindicatos.cod%TYPE DEFAULT :P52_COD_SINDICATO;',
'BEGIN',
'  IF :P52_FLAG_TEMPORARIO = ''S'' THEN',
'    IF :P52_COD_EMPRESA IS NOT NULL AND vSindicato IS NOT NULL AND :P52_COD_ATIVIDADE IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => :P52_COD_EMPRESA',
'                                                 ,psindicato => vSindicato',
'                                                 ,pFilial    => NULL',
'                                                 ,pCCusto    => NULL',
'                                                 ,pUnidAdm   => NULL',
'                                                 ,pAtividade => :P52_COD_ATIVIDADE',
'                                                 ,pLocalTrab => NULL);',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879255143956908364)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(9633251158869431568)
,p_validation_name=>'Valida Elegibilidade Loc.Trab.'
,p_validation_sequence=>360
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'  --',
'  vSindicato   sindicatos.cod%TYPE DEFAULT :P52_COD_SINDICATO;',
'BEGIN',
'  IF :P52_FLAG_TEMPORARIO = ''S'' THEN',
'    IF :P52_COD_EMPRESA IS NOT NULL AND vSindicato IS NOT NULL AND :P52_COD_LOCAL_TRAB IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => :P52_COD_EMPRESA',
'                                                 ,psindicato => vSindicato',
'                                                 ,pFilial    => NULL',
'                                                 ,pCCusto    => NULL',
'                                                 ,pUnidAdm   => NULL',
'                                                 ,pAtividade => NULL',
'                                                 ,pLocalTrab => :P52_COD_LOCAL_TRAB);',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(37879256419464908364)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9616588952621980781)
,p_name=>'Set Itens'
,p_event_sequence=>17
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9616589057938980782)
,p_event_id=>wwv_flow_api.id(9616588952621980781)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P52_EMPAUX  := :P52_COD_EMPRESA;',
'  :P52_FILAUX  := :P52_COD_FILIAL;',
'  :P52_FLAGAUX := :P52_FLAG_TEMPORARIO;',
'END;'))
,p_attribute_02=>'P52_EMPAUX,P52_FILAUX,P52_FLAGAUX,P52_COD_EMPRESA,P52_COD_FILIAL,P52_FLAG_TEMPORARIO'
,p_attribute_03=>'P52_EMPAUX,P52_FILAUX,P52_FLAGAUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879320058809908407)
,p_name=>'Show / Hide Itens Problemas'
,p_event_sequence=>18
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879320553150908408)
,p_event_id=>wwv_flow_api.id(37879320058809908407)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879321088885908411)
,p_event_id=>wwv_flow_api.id(37879320058809908407)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879321502783908411)
,p_event_id=>wwv_flow_api.id(37879320058809908407)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1,P52_VINCULO_1,P52_COD_UN_NEGOCIO_1,P52_COD_CARGO_1,P52_COD_SINDICATO_1,P52_COD_UNIDADE_ADM_1,P52_COD_ATIVIDADE_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_UN_NEGOCIO_1,P52_COD_FUNCAO_1,P52_COD_CATEGORIA_1,P52_RT_JORNADA_ME'
||'NSAL_1,P52_COD_HORARIO_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879321937207908412)
,p_event_id=>wwv_flow_api.id(37879320058809908407)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1,P52_VINCULO_1,P52_COD_UN_NEGOCIO_1,P52_COD_CARGO_1,P52_COD_SINDICATO_1,P52_COD_UNIDADE_ADM_1,P52_COD_ATIVIDADE_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_UN_NEGOCIO_1,P52_COD_FUNCAO_1,P52_COD_CATEGORIA_1,P52_RT_JORNADA_ME'
||'NSAL_1,P52_COD_HORARIO_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879322334977908412)
,p_name=>'Show / Hide Itens Problemas_2'
,p_event_sequence=>28
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FLAG_TEMPORARIO'
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879322914865908412)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879323366798908412)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1,P52_VINCULO_1,P52_COD_UN_NEGOCIO_1,P52_COD_CARGO_1,P52_COD_SINDICATO_1,P52_COD_UNIDADE_ADM_1,P52_COD_ATIVIDADE_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_UN_NEGOCIO_1,P52_COD_FUNCAO_1,P52_COD_CATEGORIA_1,P52_RT_JORNADA_ME'
||'NSAL_1,P52_COD_HORARIO_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879323911921908413)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879324354119908413)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_QTD_POSICAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879324876251908413)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1,P52_VINCULO_1,P52_COD_UN_NEGOCIO_1,P52_COD_CARGO_1,P52_COD_SINDICATO_1,P52_COD_UNIDADE_ADM_1,P52_COD_ATIVIDADE_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_UN_NEGOCIO_1,P52_COD_FUNCAO_1,P52_COD_CATEGORIA_1,P52_RT_JORNADA_ME'
||'NSAL_1,P52_COD_HORARIO_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879325357066908413)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_QTD_POSICAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879325872096908413)
,p_event_id=>wwv_flow_api.id(37879322334977908412)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_QTD_POSICAO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'1'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879326244912908413)
,p_name=>unistr('Vaga: Valida\00E7\00E3o e Popular Dados')
,p_event_sequence=>38
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_VAGA'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879326789920908414)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
' if Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') <> ''S'' then',
'   pkg_pessoal.Valida_Vaga (to_number(:p52_cod_empresa), to_number(:p52_cod_filial), :p52_cod_vaga, v_flg_retorno, v_msg_retorno);',
'   if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'     :p52_flag := v_flg_retorno;',
'     :p52_mensagem := v_msg_retorno;',
'     :p52_ok := ''N'';',
'   else ',
'     :P52_MENSAGEM := NULL;',
'     :P52_FLAG := NULL;',
'     :p52_ok := ''S'';',
'   end if;',
' else',
'   :P52_MENSAGEM := NULL;',
'   :P52_FLAG := NULL;',
'   :p52_ok := ''S'';',
' end if;',
'                        ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_FLAG,P52_MENSAGEM,P52_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879327308253908414)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'cursor c1 is ',
'select DISTINCT f.cod_instrucao,a.valor_verba,a.texto',
'from cl_vaga a,cargos b,centro_de_custo c,vinculo_empreg d,consulta_requisicoes_2 e,pc_parametro_formacao f,instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and a.cod_vaga = :p52_cod_vaga',
'and a.sit_vaga = ''A''',
'and b.cod = a.cod_cargo',
'and c.cod_empresa = a.cod_empresa',
'and c.cod = a.cod_ccusto',
'and d.cod = a.vinculo',
'and e.cad_vaga(+) = a.cod_vaga',
unistr('and Nvl(e.aprovado, ''N\00C3O'') = ''SIM'''),
'and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and a.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, c.cod, :P_USUARIO) = ''S''',
'union',
'select DISTINCT f.cod_instrucao,aa.valor_verba,aa.texto',
'from cl_vaga a,cl_vaga aa,cargos b,centro_de_custo c,vinculo_empreg d,consulta_requisicoes_2 e,pc_parametro_formacao f,instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and aa.cod_vaga = :p52_cod_vaga',
'and a.cod_empresa = aa.cod_empresa',
'and a.cod_filial = aa.cod_filial',
'and a.sit_vaga = ''A''',
'and aa.sit_vaga = ''A''',
'and b.cod = aa.cod_cargo',
'and c.cod_empresa = aa.cod_empresa',
'and c.cod = aa.cod_ccusto',
'and d.cod = aa.vinculo',
'and a.vaga_compartilhada = aa.cod_vaga',
'and e.cad_vaga(+) = aa.cod_vaga',
'and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
unistr('and Nvl(e.aprovado, ''N\00C3O'') = ''SIM'''),
'and Nvl(a.disponivel, ''N'') = ''N''',
'and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and aa.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, c.cod, :P_USUARIO) = ''S'';',
'v_c1 c1%rowtype;',
'cursor c2 is',
'select distinct v.matricula,a.nome',
'from cl_historico_vaga_func v,inf_pessoais_cad a',
'where v.cod_empresa = a.cod_empresa',
' and v.matricula = a.matricula',
' and v.cod_empresa = :p52_cod_empresa',
' and v.cod_filial = :p52_cod_filial',
' and v.cod_vaga = :p52_cod_vaga',
' and dt_inicio_vaga in (select max(x.dt_inicio_vaga) from cl_historico_vaga_func x where x.cod_empresa = v.cod_empresa and x.cod_filial = v.cod_filial and x.cod_vaga = v.cod_vaga);  ',
'v_c2 c2%rowtype;',
'',
'cursor c3 is ',
'select a.mat_solicitado matricula, fnct_nome_func(a.cod_empresa_solicitado, a.mat_solicitado) nome',
'from solicitacao_alteracao_func a, solicitacao_aprovadas c',
'where a.COD_SOLICITACAO = c.COD_SOLICITACAO',
'AND A.COD_SIT_SOLICITACAO NOT IN (3,4,6)',
'and a.dt_solicitacao in (SELECT MAX(b.dt_solicitacao) FROM solicitacao_alteracao_func b WHERE b.cod_empresa_solicitado = a.cod_empresa_solicitado and b.filial = a.filial AND b.cad_vaga = a.cad_vaga)',
'and a.cod_empresa_solicitado = :p52_cod_empresa',
'and a.filial = :p52_cod_filial',
'and a.cad_vaga = :p52_cod_vaga;',
'',
'v_c3 c3%rowtype;',
'',
'begin',
'',
'if /*:p52_cod_vaga is not null and */ :p52_cod_req is null then',
'',
'open  c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_instrucao := v_c1.cod_instrucao;',
':p52_ALTEROU_VAGA := ''S'';',
':P52_OBSERVACAO := v_c1.texto;',
'',
'if nvl(:P52_COD_MOT_REQ,99) <> 3 then',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
':p52_mat_subs := v_c2.matricula;',
'else',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
':p52_mat_subs := v_c3.matricula;',
'end if;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_COD_MOT_REQ,P52_COD_REQ,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_COD_INSTRUCAO,P52_ALTEROU_VAGA,P52_OBSERVACAO,P52_MAT_SUBS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879327812309908415)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_unidade_adm,',
'a.cod_atividade,',
'a.cod_local_trab,',
'a.vinculo,',
'a.cod_ccusto_contab,',
'a.cod_un_negocio,',
'a.cod_cargo,',
'a.cod_funcao,',
'a.cod_categoria,',
'a.cod_sindicato,',
'a.rt_jornada_mensal,',
'a.cod_horario,',
'a.marca_ponto,',
'a.tp_registro_ponto,',
'a.refeitorio,',
'a.ind_insalub,',
'a.ind_peric,',
'a.tipo_modalidade,',
'a.trab_intermitente',
'  from cl_vaga                a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga',
'   and a.sit_vaga = ''A''',
'and ((Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'   and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, a.cod_ccusto, :P_USUARIO) = ''S''',
'union',
'select DISTINCT aa.cod_ccusto,',
'aa.cod_unidade_adm,',
'aa.cod_atividade,',
'aa.cod_local_trab,',
'aa.vinculo,',
'aa.cod_ccusto_contab,',
'aa.cod_un_negocio,',
'aa.cod_cargo,',
'aa.cod_funcao,',
'aa.cod_categoria,',
'aa.cod_sindicato,',
'aa.rt_jornada_mensal,',
'aa.cod_horario,',
'aa.marca_ponto,',
'aa.tp_registro_ponto,',
'aa.refeitorio,',
'aa.ind_insalub,',
'aa.ind_peric,',
'aa.tipo_modalidade,',
'aa.trab_intermitente',
'  from cl_vaga                a,',
'       cl_vaga                aa',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and aa.cod_vaga = :p52_cod_vaga',
'   and a.cod_empresa = aa.cod_empresa',
'   and a.cod_filial = aa.cod_filial',
'   and a.sit_vaga = ''A''',
'   and aa.sit_vaga = ''A''',
'   and a.vaga_compartilhada = aa.cod_vaga',
'   and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
'and ((Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'   and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, aa.cod_ccusto, :P_USUARIO) = ''S'';',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select cargo, funcao, reg_trab, cod_horario',
'  from informacoes_funcionais',
' where cod_empresa = :p52_cod_empresa',
'   and matricula = :p52_mat_subs;',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'--if :p52_cod_vaga is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
':p52_cod_ccusto_x :=  v_c1.cod_ccusto;',
':p52_cod_ccusto_1 := v_c1.cod_ccusto;',
':p52_cod_unidade_adm_x :=  v_c1.cod_unidade_adm;',
':p52_cod_local_trab_1 := v_c1.cod_local_trab;',
':p52_cod_local_trab_x :=  v_c1.cod_local_trab;',
':p52_vinculo_x :=  v_c1.vinculo;',
':p52_trab_intermitente := v_c1.trab_intermitente;',
':p52_cod_ccusto_contab_x :=  v_c1.cod_ccusto_contab;',
':p52_cod_un_negocio_x :=  v_c1.cod_un_negocio;',
':p52_cod_atividade_x :=  v_c1.cod_atividade;',
':p52_cod_cargo_x :=  nvl(v_c1.cod_cargo,v_c2.cargo);',
':p52_cod_funcao_x :=  nvl(v_c1.cod_funcao,v_c2.funcao);',
':p52_cod_categoria_x := v_c1.cod_categoria;',
':p52_cod_sindicato_x :=  v_c1.cod_sindicato;',
':p52_tipo_modalidade :=  v_c1.tipo_modalidade;',
':p52_rt_jornada_mensal_x :=  nvl(v_c1.rt_jornada_mensal,v_c2.reg_trab);',
':p52_cod_horario_x :=  nvl(v_c1.cod_horario,v_c2.cod_horario);',
':p52_marca_ponto :=  v_c1.marca_ponto;',
':p52_tp_registro_ponto :=  v_c1.tp_registro_ponto;',
':p52_refeitorio :=  v_c1.refeitorio;',
':p52_ind_insalub :=  v_c1.ind_insalub;',
':p52_ind_peric := v_c1.ind_peric;',
'',
'--end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_MAT_SUBS,P52_VAGA_DISP_POR_REQ_DESLIG,P52_COD_CCUSTO_1,P52_ROWID'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_LOCAL_TRAB_X,P52_VINCULO_X,P52_COD_CCUSTO_CONTAB_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X,P52_RT_JORNADA_MENSAL_X,P52_COD_HORARIO_X,P52_MARCA_PONTO,'
||'P52_TP_REGISTRO_PONTO,P52_REFEITORIO,P52_IND_INSALUB,P52_IND_PERIC,P52_COD_ATIVIDADE_X,P52_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879328257932908415)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT b.cod cargo,',
'a.cod_ccusto_contab,',
'a.valor_total,',
'a.VAGA_FATURAVEL,',
'a.valor_faturavel,',
'a.vaga_confidencial,',
'a.ind_def_fis,',
'a.rais_ind_def_fisico,',
'a.rais_ind_def_auditiva,',
'a.rais_ind_def_visual,',
'a.rais_ind_def_mental,',
'a.rais_ind_def_multipla,',
'a.remuneracao_variavel,',
'a.perc_beneficio_variavel,',
'a.cod_atividade,',
'a.cod_sindicato,',
'a.marca_ponto,',
'a.tp_registro_ponto,',
'a.refeitorio,',
'a.tipo_salario,',
'a.valor_verba,',
'a.vlr_aux_tipo_modalidade',
'from cl_vaga a,cargos b,centro_de_custo c,vinculo_empreg d,consulta_requisicoes_2 e,pc_parametro_formacao f,instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and a.cod_vaga = :p52_cod_vaga',
'and a.sit_vaga = ''A''',
'and b.cod = a.cod_cargo',
'and c.cod_empresa = a.cod_empresa',
'and c.cod = a.cod_ccusto',
'and d.cod = a.vinculo',
'and e.cad_vaga(+) = a.cod_vaga',
unistr('and Nvl(e.aprovado,''N\00C3O'') = ''SIM'''),
'and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and a.cod_filial = e.filial',
'and a.cod_empresa=f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, c.cod, :P_USUARIO) = ''S''',
'union',
'select DISTINCT b.cod cargo,',
'aa.cod_ccusto_contab,',
'aa.valor_total,',
'aa.VAGA_FATURAVEL,',
'aa.valor_faturavel,',
'aa.vaga_confidencial,',
'aa.ind_def_fis,',
'aa.rais_ind_def_fisico,',
'aa.rais_ind_def_auditiva,',
'aa.rais_ind_def_visual, ',
'aa.rais_ind_def_mental,',
'aa.rais_ind_def_multipla,',
'aa.remuneracao_variavel,',
'aa.perc_beneficio_variavel,',
'aa.cod_atividade,',
'aa.cod_sindicato,',
'aa.marca_ponto,',
'aa.tp_registro_ponto,',
'aa.refeitorio,',
'aa.tipo_salario,',
'aa.valor_verba,',
'aa.vlr_aux_tipo_modalidade',
'from cl_vaga a,cl_vaga aa,cargos b,centro_de_custo c,vinculo_empreg d,consulta_requisicoes_2 e,pc_parametro_formacao f,instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and aa.cod_vaga = :p52_cod_vaga',
'and a.cod_empresa = aa.cod_empresa',
'and a.cod_filial = aa.cod_filial',
'and a.sit_vaga = ''A''',
'and aa.sit_vaga = ''A''',
'and b.cod = aa.cod_cargo',
'and c.cod_empresa = aa.cod_empresa',
'and c.cod = aa.cod_ccusto',
'and d.cod = aa.vinculo',
'and a.vaga_compartilhada = aa.cod_vaga',
'and e.cad_vaga(+) = aa.cod_vaga',
'and nvl(a.ind_vaga_compartilhada,''N'')=''S''',
unistr('and Nvl(e.aprovado,''N\00C3O'')=''SIM'''),
'and Nvl(a.disponivel,''N'')=''N''',
'and (Nvl(aa.disponivel, ''N'')=''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'')=''S'')',
'and aa.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, c.cod, :P_USUARIO)=''S'';',
'v_c1 c1%rowtype;',
'begin',
'if :p52_cod_req is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_ALTEROU_VAGA := ''N'';',
':p52_vaga_faturavel := v_c1.vaga_faturavel;',
':p52_valor_Faturavel := v_c1.valor_faturavel;',
':p52_ind_def_fis := v_c1.ind_def_fis;',
':p52_rais_ind_def_fisico := v_c1.rais_ind_def_fisico;',
':p52_rais_ind_def_auditiva := v_c1.rais_ind_def_auditiva;',
':p52_rais_ind_def_visual := v_c1.rais_ind_def_visual;',
':p52_rais_ind_def_mental := v_c1.rais_ind_def_mental;',
':p52_rais_ind_def_multipla := v_c1.rais_ind_def_multipla;',
':p52_tipo_salario := v_c1.tipo_salario;',
':p52_total_salario:=NVL(v_c1.valor_total,NVL(v_c1.valor_verba,0)+NVL(v_c1.remuneracao_variavel,0));',
'if v_c1.perc_beneficio_variavel in (20,30) then',
':p52_perc_beneficio_variavel:=v_c1.perc_beneficio_variavel;',
':p52_perc_beneficio:=v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel not in (20,30) and v_c1.perc_beneficio_variavel is not null then',
':p52_perc_beneficio_variavel:=0;',
':P52_PERC_BENEF_EXCECAO:=v_c1.perc_beneficio_variavel;',
':p52_perc_beneficio:=v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel is null then',
':p52_perc_beneficio_variavel:=null;',
':p52_perc_beneficio:=0;',
'end if;',
':p52_salario:=v_c1.valor_verba;',
':p52_remuneracao_variavel:=v_c1.remuneracao_variavel;',
':p52_vlr_aux_tipo_modalidade:=v_c1.vlr_aux_tipo_modalidade;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_ALTEROU_VAGA,P52_COD_REQ,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_ALTEROU_VAGA,P52_TOTAL_SALARIO,P52_VAGA_FATURAVEL,P52_VALOR_FATURAVEL,P52_IND_DEF_FIS,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_VISUAL,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_REMUNERACAO_VARIAVEL,P52_PERC_BE'
||'NEFICIO_VARIAVEL,P52_TIPO_SALARIO,P52_SALARIO,P52_PERC_BENEF_EXCECAO,P52_PERC_BENEFICIO,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879328801892908416)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.vaga_confidencial,',
'a.data_inicio,',
'a.data_fim,',
'a.cod_categoria,',
'a.cod_funcao,',
'a.dt_previsao_admissao,',
'a.DT_PREV_FIM_CONTRATO,',
'a.tipo_contrato',
'from cl_vaga a,',
'cargos b,',
'centro_de_custo c,',
'vinculo_empreg d,',
'consulta_requisicoes_2 e,',
'pc_parametro_formacao f,',
'instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and a.cod_vaga = :p52_cod_vaga',
'and a.sit_vaga = ''A''',
'and b.cod = a.cod_cargo',
'and c.cod_empresa = a.cod_empresa',
'and c.cod = a.cod_ccusto',
'and d.cod = a.vinculo',
'and e.cad_vaga(+) = a.cod_vaga',
unistr('and Nvl(e.aprovado,''N\00C3O'') = ''SIM'''),
'and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and a.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, c.cod, :P_USUARIO) = ''S''',
'union',
'select DISTINCT ',
'aa.vaga_confidencial,',
'aa.data_inicio,',
'aa.data_fim,',
'aa.cod_categoria,',
'aa.cod_funcao,',
'aa.dt_previsao_admissao,',
'aa.DT_PREV_FIM_CONTRATO,',
'aa.tipo_contrato',
'from cl_vaga a,',
'cl_vaga aa,',
'cargos b,',
'centro_de_custo c,',
'vinculo_empreg d,',
'consulta_requisicoes_2 e,',
'pc_parametro_formacao f,',
'instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and aa.cod_vaga = :p52_cod_vaga',
'and a.cod_empresa = aa.cod_empresa',
'and a.cod_filial = aa.cod_filial',
'and a.sit_vaga = ''A''',
'and aa.sit_vaga = ''A''',
'and b.cod = aa.cod_cargo',
'and c.cod_empresa = aa.cod_empresa',
'and c.cod = aa.cod_ccusto',
'and d.cod = aa.vinculo',
'and a.vaga_compartilhada = aa.cod_vaga',
'and e.cad_vaga(+) = aa.cod_vaga',
'and nvl(a.ind_vaga_compartilhada,''N'') = ''S''',
unistr('and Nvl(e.aprovado,''N\00C3O'') = ''SIM'''),
'and Nvl(a.disponivel,''N'') = ''N''',
'and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and aa.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, c.cod, :P_USUARIO) = ''S'';',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if /*:p52_cod_vaga is not null and*/ :p52_cod_req is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_data_inicio := v_c1.data_inicio;',
':p52_data_fim := v_c1.data_fim;',
':p52_cod_categoria := v_c1.cod_categoria;',
':p52_cod_funcao := v_c1.cod_funcao;',
':p52_vaga_confidencial := v_c1.vaga_confidencial;',
':P52_DT_PREVISAO_ADMISSAO := v_c1.dt_previsao_admissao;',
':P52_DT_PREV_FIM_CONTRATO := v_c1.DT_PREV_FIM_CONTRATO;',
':p52_tipo_contrato := v_c1.tipo_contrato;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_ALTEROU_VAGA,P52_COD_REQ,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_DATA_INICIO,P52_DATA_FIM,P52_COD_CATEGORIA,P52_COD_FUNCAO,P52_VAGA_CONFIDENCIAL,P52_DT_PREVISAO_ADMISSAO,P52_DT_PREV_FIM_CONTRATO,P52_TIPO_CONTRATO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879329255120908416)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.motivo_excecao,',
'a.orgao_publico,',
'a.novo_contrato,',
'a.valor_venda,',
'a.desc_atividades,',
'a.cod_area',
'from cl_vaga a,',
'cargos b,',
'centro_de_custo c,',
'vinculo_empreg d,',
'consulta_requisicoes_2 e,',
'pc_parametro_formacao f,',
'instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and a.cod_vaga = :p52_cod_vaga',
'and a.sit_vaga = ''A''',
'and b.cod = a.cod_cargo',
'and c.cod_empresa = a.cod_empresa',
'and c.cod = a.cod_ccusto',
'and d.cod = a.vinculo',
'and e.cad_vaga(+) = a.cod_vaga',
unistr('and Nvl(e.aprovado,''N\00C3O'') = ''SIM'''),
'and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and a.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, c.cod, :P_USUARIO) = ''S''',
'union',
'select DISTINCT ',
'a.motivo_excecao,',
'a.orgao_publico,',
'a.novo_contrato,',
'a.valor_venda,',
'a.desc_atividades,',
'a.cod_area',
'from cl_vaga a,',
'cl_vaga aa,',
'cargos b,',
'centro_de_custo c,',
'vinculo_empreg d,',
'consulta_requisicoes_2 e,',
'pc_parametro_formacao f,',
'instrucao g',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and aa.cod_vaga = :p52_cod_vaga',
'and a.cod_empresa = aa.cod_empresa',
'and a.cod_filial = aa.cod_filial',
'and a.sit_vaga = ''A''',
'and aa.sit_vaga = ''A''',
'and b.cod = aa.cod_cargo',
'and c.cod_empresa = aa.cod_empresa',
'and c.cod = aa.cod_ccusto',
'and d.cod = aa.vinculo',
'and a.vaga_compartilhada = aa.cod_vaga',
'and e.cad_vaga(+) = aa.cod_vaga',
'and nvl(a.ind_vaga_compartilhada,''N'') = ''S''',
unistr('and Nvl(e.aprovado,''N\00C3O'') = ''SIM'''),
'and Nvl(a.disponivel,''N'') = ''N''',
'and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'and aa.cod_filial = e.filial',
'and a.cod_empresa = f.cod_empresa(+)',
'and a.cod_cargo = f.cod_cargo(+)',
'and f.cod_instrucao = g.cod(+)',
'and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, c.cod, :P_USUARIO) = ''S'';',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if /*:p52_cod_vaga is not null and*/ :p52_cod_req is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_motivo_excecao := v_c1.motivo_excecao;',
':p52_orgao_publico := v_c1.orgao_publico;',
':p52_novo_contrato := v_c1.novo_contrato;',
':p52_valor_venda := v_c1.valor_venda;',
':p52_desc_atividades := v_c1.desc_atividades;',
':p52_cod_area := v_c1.cod_area;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_ALTEROU_VAGA,P52_COD_REQ,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_MOTIVO_EXCECAO,P52_ORGAO_PUBLICO,P52_NOVO_CONTRATO,P52_VALOR_VENDA,P52_DESC_ATIVIDADES,P52_COD_AREA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879329779132908416)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    for l1 in (select cod_empresa, ',
'                      cod_filial, ',
'                      cod_vaga, ',
'                      cod_beneficio, ',
'                      valor',
'                 from beneficios_vaga ',
'                where cod_empresa = :p52_cod_empresa ',
'                  and cod_filial = :p52_cod_filial',
'                  and cod_vaga = :p52_cod_vaga)',
'    loop',
'',
'        begin',
'        insert into beneficios_vaga_temp (seq, cod_requisicao, cod_empresa, cod_filial, cod_beneficio, valor) values ',
'                                         (:p52_seq, null, l1.cod_empresa, l1.cod_filial, l1.cod_beneficio, l1.valor);',
'                                         ',
'        commit;',
'        end;',
'',
'    end loop;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879330283479908416)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179895175297250494979)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879330734302908416)
,p_event_id=>wwv_flow_api.id(37879326244912908413)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_qtd_mouse_move := 0;'
,p_attribute_03=>'P52_QTD_MOUSE_MOVE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879331137080908416)
,p_name=>'valida_Mat_subs'
,p_event_sequence=>58
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MAT_SUBS'
,p_condition_element=>'P52_MAT_SUBS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879332192022908417)
,p_event_id=>wwv_flow_api.id(37879331137080908416)
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
'begin',
'',
'pkg_pessoal.Valida_mat_subs (:p52_cod_empresa, :p52_cod_filial, :p52_cod_vaga, :p52_mat_subs, :p52_mot_subs, :p52_cod_cargo, :p52_cod_ccusto, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
'    :p52_mat_subs_x := null;',
' else ',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
'    :p52_mat_subs_x := :p52_mat_subs;',
' end if; ',
'                        ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_MAT_SUBS,P52_MOT_SUBS,P52_COD_CCUSTO,P52_COD_CARGO'
,p_attribute_03=>'P52_FLAG,P52_MENSAGEM,P52_OK,P52_MAT_SUBS_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879332677251908417)
,p_event_id=>wwv_flow_api.id(37879331137080908416)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOT_SUBS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879333110385908417)
,p_name=>unistr('Flag Tempor\00E1rio')
,p_event_sequence=>68
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NULL OR :P52_COD_SIT_REQ = 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879333575890908417)
,p_event_id=>wwv_flow_api.id(37879333110385908417)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_flag_temporario is null then',
':p52_flag_temporario := ''N'';',
'END IF;'))
,p_attribute_02=>'P52_FLAG_TEMPORARIO'
,p_attribute_03=>'P52_FLAG_TEMPORARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879334022343908417)
,p_name=>unistr('Esconder Campos Cria\00E7\00E3o')
,p_event_sequence=>78
,p_condition_element=>'P52_COD_REQ'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879334503800908417)
,p_event_id=>wwv_flow_api.id(37879334022343908417)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_PREST_SERV,P52_COD_SIT_REQ,P52_COD_MOT_SIT_REQ,P52_DT_REQ,P52_DT_SIT_REQ,P52_SOLICITANTE,P52_COD_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879335004901908418)
,p_event_id=>wwv_flow_api.id(37879334022343908417)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879335371906908418)
,p_name=>'Alerta Sequencia Aprov'
,p_event_sequence=>88
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879335869828908418)
,p_event_id=>wwv_flow_api.id(37879335371906908418)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_FLAG'').value == "Q") {',
'alertify.confirm($v(''P52_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P52_FLAG'').value = ''S'';',
'        $x(''P52_MENSAGEM'').value = '''';',
'        $x(''P52_OK'').value = ''S'';',
'       // $(''#CREATE'').show();',
'      //  $(''#SAVE'').show();',
'    } else {',
'        $x(''P52_OK'').value = ''N'';',
'      //  $(''#CREATE'').hide();',
'      //  $(''#SAVE'').hide();',
'    }',
'    ',
'    document.getElementById("alertify-cover").style.position="static";',
'});',
'} else {',
'',
'    if ($x(''P52_MENSAGEM'').value.length  > 0 ) {',
'        ',
'       // if ($x(''P52_FLAG'').value == "N") {',
'         //   $(''#CREATE'').hide();',
'         //   $(''#SAVE'').hide();',
'       // } else {',
'         //   $(''#CREATE'').show();',
'          //   $(''#SAVE'').show();',
'      //  }',
'            ',
'        alertify.alert($v(''P52_MENSAGEM''));',
'  //  }else{',
'   //  $(''#CREATE'').show();',
'   //  $(''#SAVE'').show();',
'    }',
'',
'                 ',
'}',
'',
'$x(''P52_FLAG'').value = ''S'';',
'$x(''P52_MENSAGEM'').value = '''';',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879336245904908418)
,p_name=>'Popula COD_CARGO'
,p_event_sequence=>98
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879336748866908418)
,p_event_id=>wwv_flow_api.id(37879336245904908418)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_cod_cargo_1 := :p52_cod_cargo_x;',
'',
''))
,p_attribute_02=>'P52_COD_CARGO_X'
,p_attribute_03=>'P52_COD_CARGO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879337153943908418)
,p_name=>unistr('Confirma Aprova\00E7\00E3o')
,p_event_sequence=>108
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879122018197908288)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879337636564908419)
,p_event_id=>wwv_flow_api.id(37879337153943908418)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja Continuar com a Aprova\00E7\00E3o?')
,p_attribute_07=>'Aprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879338136577908419)
,p_event_id=>wwv_flow_api.id(37879337153943908418)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_req',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_req = :p52_cod_req ',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'',
'        end;',
'    ELSE',
'        begin',
'         update aprova_req',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_req = :p52_cod_req ',
'            and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'    :p52_aprov := ''S'';',
'',
'     pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req, v_flg_retorno, v_msg_retorno);',
'           ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P52_APROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879338644737908419)
,p_event_id=>wwv_flow_api.id(37879337153943908418)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Requisi\00E7\00E3o Aprovada Com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879339171645908419)
,p_event_id=>wwv_flow_api.id(37879337153943908418)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879339621092908419)
,p_name=>unistr('Confirma Reprova\00E7\00E3o')
,p_event_sequence=>118
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879122786832908289)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879340050465908419)
,p_event_id=>wwv_flow_api.id(37879339621092908419)
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
'begin',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_req',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_req = :p52_cod_req ',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'',
'        end;',
'    ELSE',
'        begin',
'         update aprova_req',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_req = :p52_cod_req ',
'            and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'    :p52_aprov := ''S'';',
'',
'     pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req, v_flg_retorno, v_msg_retorno);',
'           ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_REQ,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P52_APROV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879340589511908420)
,p_event_id=>wwv_flow_api.id(37879339621092908419)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Deseja Continuar com a Reprova\00E7\00E3o?')
,p_attribute_07=>'Reprovar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879341118088908420)
,p_event_id=>wwv_flow_api.id(37879339621092908419)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Requisi\00E7\00E3o Reprovada Com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879341573302908420)
,p_event_id=>wwv_flow_api.id(37879339621092908419)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879342015607908420)
,p_name=>'Set Dt_Sit_Req'
,p_event_sequence=>128
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SIT_REQ'
,p_condition_element=>'P52_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879342470436908420)
,p_event_id=>wwv_flow_api.id(37879342015607908420)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
':p52_dt_sit_req := sysdate;',
'end;'))
,p_attribute_03=>'P52_DT_SIT_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879342856224908420)
,p_name=>'Desabilita Campos'
,p_event_sequence=>138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FLAG_TEMPORARIO'
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879343358631908421)
,p_event_id=>wwv_flow_api.id(37879342856224908420)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_VAGA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879343837404908421)
,p_event_id=>wwv_flow_api.id(37879342856224908420)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_FLAG_TEMPORARIO").getValue() == ''S''){',
'apex.item("P52_COD_CCUSTO").enable();',
'    apex.item("P52_COD_CCUSTO_1").enable();',
'apex.item("P52_COD_CCUSTO_CONTAB").enable();',
'    apex.item("P52_COD_CCUSTO_CONTAB_1").enable();',
'apex.item("P52_COD_UN_NEGOCIO").enable();',
'    apex.item("P52_COD_UN_NEGOCIO_1").enable();',
'apex.item("P52_COD_UNIDADE_ADM").enable();',
'    apex.item("P52_COD_UNIDADE_ADM_1").enable();',
'apex.item("P52_COD_ATIVIDADE").enable();',
'    apex.item("P52_COD_ATIVIDADE_1").enable();',
'apex.item("P52_COD_LOCAL_TRAB").enable();',
'    apex.item("P52_COD_LOCAL_TRAB_1").enable();',
'apex.item("P52_VINCULO").enable();',
'    apex.item("P52_VINCULO_1").enable();',
'  apex.item("P52_TRAB_INTERMITENTE").enable();',
' apex.item("P52_COD_CARGO").enable();',
'    apex.item("P52_COD_CARGO_1").enable();',
'    apex.item("P52_SALARIO").enable();',
'    apex.item("P52_MAT_SUBS").enable();',
'    apex.item("P52_IND_INSALUB").enable();',
'    apex.item("P52_IND_PERIC").enable();',
'    apex.item("P52_TIPO_SALARIO").enable();',
'apex.item("P52_COD_CATEGORIA").enable();',
'   apex.item("P52_COD_CATEGORIA_1").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'    apex.item("P52_COD_FUNCAO_1").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'   apex.item("P52_RT_JORNADA_MENSAL_1").enable();',
'apex.item("P52_MARCA_PONTO").enable();',
'   apex.item("P52_TP_REGISTRO_PONTO").enable();',
'',
'    //INFORMACOES DO PONTO   ',
'        apex.item("P52_TIPO_PONTO").enable();',
'        apex.item("P52_JORNADA").enable();',
'        apex.item("P52_ESCALA").enable();',
'        apex.item("P52_CICLO").enable();',
'        apex.item("P52_CICLO_INICIAL").enable();',
'        apex.item("P52_CICLO_DAT_INICIAL").enable();',
'        apex.item("P52_CICLO_DAT_FINAL").enable();  ',
'',
'    ',
'   apex.item("P52_DATA_INICIO").enable();',
'   apex.item("P52_DATA_FIM").enable();',
'    apex.item("P52_TIPO_CONTRATO").enable();',
'    apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'    apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'//CH43237 apex.item("P52_COD_HORARIO").enable();',
'   apex.item("P52_COD_HORARIO_1").enable();',
'   apex.item("P52_REFEITORIO_1").enable();',
'    ',
'   apex.item("P52_TIPO_SALARIO").enable();',
'   apex.item("P52_TOTAL_SALARIO").enable();',
'   apex.item("P52_PERC_BENEFICIO_VARIAVEL").enable();',
'   apex.item("P52_PERC_BENEF_EXCECAO").enable();',
'   apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'   apex.item("P52_SALARIO").enable();',
'    apex.item("P52_TIPO_MODALIDADE").enable();',
'    apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'    apex.item("P52_COD_SINDICATO").enable();',
'    apex.item("P52_COD_SINDICATO_1").enable();',
'  ',
'  apex.item("P52_COD_AREA").enable();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879344336272908421)
,p_event_id=>wwv_flow_api.id(37879342856224908420)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_VAGA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879344892959908421)
,p_event_id=>wwv_flow_api.id(37879342856224908420)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_FLAG_TEMPORARIO").getValue() == ''N''){',
'apex.item("P52_COD_CCUSTO").disable();',
'    apex.item("P52_COD_CCUSTO_1").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'    apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'    apex.item("P52_COD_UN_NEGOCIO_1").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'    apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE").disable();',
'    apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'    apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'apex.item("P52_VINCULO").disable();',
'    apex.item("P52_VINCULO_1").disable();',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
' apex.item("P52_COD_CARGO").disable();',
'    apex.item("P52_COD_CARGO_1").disable();',
'    apex.item("P52_SALARIO").disable();',
'    apex.item("P52_MAT_SUBS").disable();',
'    apex.item("P52_IND_INSALUB").disable();',
'    apex.item("P52_IND_PERIC").disable();',
'    apex.item("P52_TIPO_SALARIO").disable();',
'apex.item("P52_COD_CATEGORIA").disable();',
'   apex.item("P52_COD_CATEGORIA_1").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'    apex.item("P52_COD_FUNCAO_1").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'   apex.item("P52_RT_JORNADA_MENSAL_1").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'   apex.item("P52_TP_REGISTRO_PONTO").disable();',
'    ',
'//INFORMACOES DO PONTO   ',
'   //     apex.item("P52_TIPO_PONTO").disable();',
'   //     apex.item("P52_JORNADA").disable();',
'   //     apex.item("P52_ESCALA").disable();',
'   //     apex.item("P52_CICLO").disable();',
'   //     apex.item("P52_CICLO_INICIAL").disable();',
'   //     apex.item("P52_CICLO_DAT_INICIAL").disable();',
'   //     apex.item("P52_CICLO_DAT_FINAL").disable();    ',
'',
'    ',
'   apex.item("P52_DATA_INICIO").disable();',
'   apex.item("P52_DATA_FIM").disable();',
'    apex.item("P52_TIPO_CONTRATO").disable();',
'    apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'    apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'//apex.item("P52_COD_HORARIO").disable();',
'   //apex.item("P52_COD_HORARIO_1").disable();',
'   apex.item("P52_REFEITORIO_1").disable();',
'    ',
'   apex.item("P52_TIPO_SALARIO").disable();',
'   apex.item("P52_TOTAL_SALARIO").disable();',
'   apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'   apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'   apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'   apex.item("P52_SALARIO").disable();',
'    apex.item("P52_TIPO_MODALIDADE").disable();',
'    apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'    apex.item("P52_COD_SINDICATO").disable();',
'    apex.item("P52_COD_SINDICATO_1").disable();',
'  ',
'  apex.item("P52_COD_AREA").disable();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879345270282908421)
,p_name=>'valida_ccusto'
,p_event_sequence=>148
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_X'
,p_condition_element=>'P52_COD_CCUSTO_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879345740375908422)
,p_event_id=>wwv_flow_api.id(37879345270282908421)
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
'begin',
'',
'pkg_pessoal.Valida_ccusto (:p52_cod_empresa, :p52_cod_filial, :p52_cod_ccusto_x, :p52_cod_vaga, :p52_cod_cargo, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
' else ',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
' end if; ',
'                        ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_COD_CARGO,P52_COD_CCUSTO_X'
,p_attribute_03=>'P52_FLAG,P52_OK,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879346288947908422)
,p_event_id=>wwv_flow_api.id(37879345270282908421)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_COD_CCUSTO_1 := :p52_COD_CCUSTO_X;'
,p_attribute_02=>'P52_COD_CCUSTO_X'
,p_attribute_03=>'P52_COD_CCUSTO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879346675532908422)
,p_name=>'Vaga: Popular Campos_3'
,p_event_sequence=>158
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(170359328940684691654)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'(apex.item("P52_COD_VAGA").getValue().length > 0 && (apex.item("P52_QTD_MOUSE_MOVE").getValue().length == 0 || apex.item("P52_QTD_MOUSE_MOVE").getValue() < 6))'
,p_bind_type=>'bind'
,p_bind_event_type=>'mousemove'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return 1=2 and :P52_ROWID is not null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879347211414908423)
,p_event_id=>wwv_flow_api.id(37879346675532908422)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'nvl(a.cod_horario,a.cod_horario_jornada) cod_horario,',
'a.cod_sindicato',
'  from cl_vaga                a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga',
'   and a.sit_vaga = ''A''',
'   and ((Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'   and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, a.cod_ccusto, :P_USUARIO) = ''S''',
'union',
'select DISTINCT ',
'aa.cod_ccusto,',
'aa.cod_local_trab,',
'aa.cod_ccusto_contab,',
'nvl(aa.cod_horario,aa.cod_horario_jornada) cod_horario,',
'aa.cod_sindicato',
'  from cl_vaga                a,',
'       cl_vaga                aa',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and aa.cod_vaga = :p52_cod_vaga',
'   and a.cod_empresa = aa.cod_empresa',
'   and a.cod_filial = aa.cod_filial',
'   and a.sit_vaga = ''A''',
'   and aa.sit_vaga = ''A''',
'   and a.vaga_compartilhada = aa.cod_vaga',
'   and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
'   and Nvl(a.disponivel, ''N'') = ''N''',
'   and ((Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'   and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, aa.cod_ccusto, :P_USUARIO) = ''S'';',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'    if :p52_cod_ccusto_1 is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p52_cod_ccusto_x :=  v_c1.cod_ccusto;',
'    :p52_cod_ccusto_1 :=  v_c1.cod_ccusto;',
'    ',
'    end if;',
'',
'    if :p52_cod_local_trab_1 is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p52_cod_local_trab_x :=  v_c1.cod_local_trab;',
'    :p52_cod_local_trab_1 :=  v_c1.cod_local_trab;',
'',
'    end if;',
'',
'    if :p52_cod_ccusto_contab_1 is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p52_cod_ccusto_contab_x :=  v_c1.cod_ccusto_contab;',
'    :p52_cod_ccusto_contab_1 :=  v_c1.cod_ccusto_contab;',
'    end if;',
'',
'    if :p52_cod_horario_1 is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p52_cod_horario_x :=  v_c1.cod_horario;',
'    :p52_cod_horario_1 :=  v_c1.cod_horario;',
'    end if;    ',
'',
'    if :P52_COD_SINDICATO_1 is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    :P52_COD_SINDICATO_1 := v_c1.cod_sindicato;',
'    :p52_cod_sindicato_x := v_c1.cod_sindicato;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_COD_CCUSTO_CONTAB_1,P52_COD_LOCAL_TRAB_1,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_SINDICATO_1,P52_VAGA_DISP_POR_REQ_DESLIG,P52_ROWID'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X,P52_COD_LOCAL_TRAB_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB_X,P52_COD_HORARIO_X,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_CCUSTO_X,P52_COD_SINDICATO_1,P52_COD_SINDICATO_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879347640412908423)
,p_event_id=>wwv_flow_api.id(37879346675532908422)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select distinct v.matricula',
'  from cl_historico_vaga_func v,',
'       inf_pessoais a',
' where v.cod_empresa = a.cod_empresa',
'   and v.matricula = a.matricula',
'   and v.cod_empresa = :p52_cod_empresa',
'   and v.cod_filial = :p52_cod_filial',
'   and v.cod_vaga = :p52_cod_vaga',
'   and dt_inicio_vaga = (select max(x.dt_inicio_vaga)',
'                            from cl_historico_vaga_func x',
'                           where x.cod_empresa = v.cod_empresa',
'                             and x.cod_filial = v.cod_filial',
'                             and x.cod_vaga = v.cod_vaga);',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p52_mat_subs is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.matricula is not null then',
':p52_mat_subs := v_c1.matricula;',
'end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_MAT_SUBS'
,p_attribute_03=>'P52_MAT_SUBS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37885720251417192701)
,p_event_id=>wwv_flow_api.id(37879346675532908422)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(:p52_qtd_mouse_move,0) = 0 then',
':p52_qtd_mouse_move := 1;',
'else',
':p52_qtd_mouse_move := :p52_qtd_mouse_move + 1;',
'end if;'))
,p_attribute_02=>'P52_QTD_MOUSE_MOVE'
,p_attribute_03=>'P52_QTD_MOUSE_MOVE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879348551289908423)
,p_name=>'Submit Validation - Popula Campos'
,p_event_sequence=>168
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879246831876908359)
,p_condition_element=>'P52_ENABLE_DA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879349113118908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p52_cod_ccusto is null and :p52_cod_ccusto_x is not null then',
'    :p52_cod_ccusto := :p52_cod_ccusto_x;',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P52_COD_CCUSTO,P52_COD_CCUSTO_X'
,p_attribute_03=>'P52_COD_CCUSTO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879349596346908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    ',
'    if :p52_cod_unidade_adm is null and :p52_cod_unidade_adm_x is not null then',
'    :p52_cod_unidade_adm := :p52_cod_unidade_adm_x;',
'    end if;',
'    ',
'end;'))
,p_attribute_02=>'P52_COD_UNIDADE_ADM,P52_COD_UNIDADE_ADM_X'
,p_attribute_03=>'P52_COD_UNIDADE_ADM'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879350057315908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p52_cod_local_trab is null and :p52_cod_local_trab_x is not null then',
'    :p52_cod_local_trab := :p52_cod_local_trab_x;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_LOCAL_TRAB,P52_COD_LOCAL_TRAB_X'
,p_attribute_03=>'P52_COD_LOCAL_TRAB'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879350598269908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p52_cod_ccusto_contab is null and :p52_cod_ccusto_contab_x is not null then',
'    :p52_cod_ccusto_contab := :p52_cod_ccusto_contab_x;',
'    end if;    ',
' ',
'end;'))
,p_attribute_02=>'P52_COD_CCUSTO_CONTAB,P52_COD_CCUSTO_CONTAB_X'
,p_attribute_03=>'P52_COD_CCUSTO_CONTAB'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879351090873908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p52_cod_sindicato is null and :p52_cod_sindicato_x is not null then',
'    :p52_cod_sindicato := :p52_cod_sindicato_x;',
'    end if;     ',
' ',
'end;'))
,p_attribute_02=>'P52_COD_SINDICATO,P52_COD_SINDICATO_X'
,p_attribute_03=>'P52_COD_SINDICATO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879351614041908424)
,p_event_id=>wwv_flow_api.id(37879348551289908423)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    if :p52_cod_un_negocio is null and :p52_cod_un_negocio_x is not null then',
'    :p52_cod_un_negocio := :p52_cod_un_negocio_x;',
'    end if;  ',
'    ',
'end;'))
,p_attribute_02=>'P52_COD_UN_NEGOCIO,P52_COD_UN_NEGOCIO_X'
,p_attribute_03=>'P52_COD_UN_NEGOCIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879351947493908425)
,p_name=>'Popula COD_CCUSTO_CONTAB_X'
,p_event_sequence=>178
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879352481299908425)
,p_event_id=>wwv_flow_api.id(37879351947493908425)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CCUSTO_CONTAB_X := :P52_COD_CCUSTO_CONTAB;'
,p_attribute_02=>'P52_COD_CCUSTO_CONTAB'
,p_attribute_03=>'P52_COD_CCUSTO_CONTAB_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879352921295908425)
,p_name=>'Popula COD_CCUSTO_CONTAB'
,p_event_sequence=>188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879353348132908425)
,p_event_id=>wwv_flow_api.id(37879352921295908425)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CCUSTO_CONTAB_1 := :P52_COD_CCUSTO_CONTAB_X;'
,p_attribute_02=>'P52_COD_CCUSTO_CONTAB_X'
,p_attribute_03=>'P52_COD_CCUSTO_CONTAB_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879353738682908425)
,p_name=>'(S/ Vaga) Popula COD_CCUSTO_CONTAB'
,p_event_sequence=>198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879354252448908425)
,p_event_id=>wwv_flow_api.id(37879353738682908425)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CCUSTO_CONTAB := :P52_COD_CCUSTO_CONTAB_X;'
,p_attribute_02=>'P52_COD_CCUSTO_CONTAB_X'
,p_attribute_03=>'P52_COD_CCUSTO_CONTAB'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879354715091908425)
,p_name=>'valida_cargo'
,p_event_sequence=>208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO'
,p_condition_element=>'P52_COD_CARGO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879355189172908426)
,p_event_id=>wwv_flow_api.id(37879354715091908425)
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
'begin',
'',
'pkg_pessoal.Valida_cargo(nvl(:p52_flag_temporario,''N''), :p52_cod_empresa, :p52_cod_filial, :P52_COD_CARGO, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
' else ',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
' end if; ',
'',
'end;'))
,p_attribute_02=>'P52_FLAG_TEMPORARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CARGO'
,p_attribute_03=>'P52_OK,P52_FLAG,P52_MENSAGEM,P52_COD_CARGO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879355679974908426)
,p_event_id=>wwv_flow_api.id(37879354715091908425)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845172619887405836)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879356205243908426)
,p_event_id=>wwv_flow_api.id(37879354715091908425)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879356597438908426)
,p_name=>'valida_cargo_1'
,p_event_sequence=>218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO_1'
,p_condition_element=>'P52_COD_CARGO_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879357028785908426)
,p_event_id=>wwv_flow_api.id(37879356597438908426)
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
'begin',
'',
'pkg_pessoal.Valida_cargo(nvl(:p52_flag_temporario,''N''), :p52_cod_empresa, :p52_cod_filial, :P52_COD_CARGO_1, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
' else ',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
' end if; ',
'',
'end;'))
,p_attribute_02=>'P52_FLAG_TEMPORARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CARGO_1'
,p_attribute_03=>'P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879357572370908426)
,p_event_id=>wwv_flow_api.id(37879356597438908426)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845172619887405836)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879358104514908426)
,p_event_id=>wwv_flow_api.id(37879356597438908426)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879358427247908427)
,p_name=>'valida_filial'
,p_event_sequence=>228
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FILIAL'
,p_condition_element=>'P52_COD_FILIAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879358977417908427)
,p_event_id=>wwv_flow_api.id(37879358427247908427)
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
'begin',
'',
'pkg_pessoal.Valida_Filial(:p52_cod_empresa, :p52_cod_filial, v_flg_retorno, v_msg_retorno);',
'',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
' else ',
'  :P52_MENSAGEM := NULL;',
'  :P52_FLAG := NULL;',
'  :p52_ok := ''S'';',
' end if; ',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL'
,p_attribute_03=>'P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879359407718908427)
,p_name=>'Valida_Cod_Sit_Req'
,p_event_sequence=>238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SIT_REQ'
,p_condition_element=>'P52_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879359866893908427)
,p_event_id=>wwv_flow_api.id(37879359407718908427)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000); ',
'',
'cursor c1 is',
'select TRIM(TO_CHAR(cod_sit_REQ)) cod_sit_solicitacao',
'  from REQUISICAO',
' where cod_req = :P52_COD_req;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
':p52_mensagem := null;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF v_c1.cod_sit_solicitacao IS NOT NULL and :P52_COD_SIT_REQ is not null and :P52_COD_SIT_REQ <> v_c1.cod_sit_solicitacao THEN',
'',
'    if :P52_COD_SIT_REQ = v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (1,5) and :P52_COD_SIT_REQ in (3,6) then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao = 6 and :P52_COD_SIT_REQ = 1 then',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'    elsif v_c1.cod_sit_solicitacao in (2,3,4) and :P52_COD_SIT_REQ <> v_c1.cod_sit_solicitacao then',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar a situa\00E7\00E3o desta requisi\00E7\00E3o.'';'),
'    else',
'       v_flg_retorno := ''N'';',
unistr('       v_msg_retorno := ''N\00E3o \00E9 permitido alterar para a situa\00E7\00E3o escolhida.'';'),
'    end if;',
'',
'else',
'       v_flg_retorno := ''S'';',
'       v_msg_retorno := null;',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
'END IF;',
' ',
' if v_msg_retorno is not null and v_flg_retorno in (''N'',''Q'') then',
'    :p52_flag := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
'    :p52_ok := ''N'';',
' else ',
'  :P52_MENSAGEM := NULL;',
' :P52_FLAG := NULL;',
'    :p52_ok := ''S'';',
' end if; ',
' ',
'end;'))
,p_attribute_02=>'P52_COD_PREST_SERV,P52_COD_SIT_REQ'
,p_attribute_03=>'P52_MENSAGEM,P52_FLAG,P52_OK'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879360226270908427)
,p_name=>'Inicia Alertify'
,p_event_sequence=>248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879360792053908428)
,p_event_id=>wwv_flow_api.id(37879360226270908427)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Inicio'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879361263032908428)
,p_event_id=>wwv_flow_api.id(37879360226270908427)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_DE.DANIELH.TOASTRNOTIFICATIONS'
,p_attribute_01=>'info'
,p_attribute_02=>'Teste'
,p_attribute_03=>'toast-top-right'
,p_attribute_04=>'true'
,p_attribute_05=>'true'
,p_attribute_06=>'false'
,p_attribute_07=>'true'
,p_attribute_08=>'300'
,p_attribute_09=>'1000'
,p_attribute_10=>'5000'
,p_attribute_11=>'1000'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879361644301908428)
,p_name=>'Esconde Save/Create'
,p_event_sequence=>258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_OK'
,p_condition_element=>'P52_OK'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879362208911908428)
,p_event_id=>wwv_flow_api.id(37879361644301908428)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_OK'').value == ''S'') { ',
'    if (apex.item("P52_ITEM_VALIDACAO_SAL").getValue().length == 0){',
'        $(''#CREATE'').show();',
'        $(''#SAVE'').show();',
'    }else{',
'        $(''#CREATE'').hide();',
'        $(''#SAVE'').hide();',
'    }',
'   // alert("1 "+ apex.item("P52_ITEM_VALIDACAO").getValue());',
'}else{',
'    if ($x(''P52_OK'').value == ''N'') { ',
'        $(''#CREATE'').hide();',
'        $(''#SAVE'').hide();',
'       // alert("2 "+ apex.item("P52_ITEM_VALIDACAO").getValue());',
'    }else{',
'        if (apex.item("P52_ITEM_VALIDACAO_SAL").getValue().length == 0){',
'            $(''#CREATE'').show();',
'            $(''#SAVE'').show();',
'        }else{',
'            $(''#CREATE'').hide();',
'            $(''#SAVE'').hide();',
'        }',
'       // alert("3 "+ apex.item("P52_ITEM_VALIDACAO").getValue());',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879362625274908428)
,p_name=>'(Create) Enable/Populate'
,p_event_sequence=>268
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879127043764908292)
,p_condition_element=>'P52_OK'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495107532727432648)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('alertify.alert(''Ainda existem ajustes a serem feitos antes de criar a requisi\00E7\00E3o.'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879363106400908429)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    apex.item("P52_COD_CCUSTO").enable();',
'    apex.item("P52_COD_CCUSTO_CONTAB").enable();',
'    apex.item("P52_COD_UN_NEGOCIO").enable();',
'    apex.item("P52_COD_UNIDADE_ADM").enable();',
'    apex.item("P52_COD_ATIVIDADE").enable();',
'    apex.item("P52_COD_LOCAL_TRAB").enable();',
'    apex.item("P52_VINCULO").enable();',
'    apex.item("P52_TRAB_INTERMITENTE").enable();',
'    apex.item("P52_COD_CARGO").enable();',
'    apex.item("P52_SALARIO").enable();',
'    apex.item("P52_MAT_SUBS").enable();',
'    apex.item("P52_TOTAL_SALARIO").enable();',
'    apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'    apex.item("P52_SALARIO").enable();',
'    apex.item("P52_TIPO_MODALIDADE").enable();',
'    apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'    apex.item("P52_VALOR_FATURAVEL").enable();',
'    apex.item("P52_IND_INSALUB").enable();',
'    apex.item("P52_IND_PERIC").enable();',
'    apex.item("P52_TIPO_SALARIO").enable();',
'  apex.item("P52_COD_CATEGORIA").enable();',
'   apex.item("P52_COD_FUNCAO").enable();',
'   apex.item("P52_RT_JORNADA_MENSAL").enable();',
'   apex.item("P52_MARCA_PONTO").enable();',
'   apex.item("P52_TP_REGISTRO_PONTO").enable();',
'   apex.item("P52_DATA_INICIO").enable();',
'   apex.item("P52_DATA_FIM").enable();',
'apex.item("P52_TIPO_CONTRATO").enable();   ',
'apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'   apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'',
'apex.item("P52_TIPO_PONTO").enable();',
'apex.item("P52_JORNADA").enable();',
'apex.item("P52_ESCALA").enable();',
'apex.item("P52_CICLO").enable();',
'apex.item("P52_CICLO_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_FINAL").enable();',
'',
'   apex.item("CPF_INDICADO").enable();',
'   apex.item("NOME_INDICADO").enable();',
'   apex.item("E_MAIL_INDICADO").enable();',
'   apex.item("DDD_INDICADO").enable();',
'   apex.item("TELEFONE_INDICADO").enable();',
'   apex.item("MOTIVO_EXCECAO").enable();',
'   apex.item("ORGAO_PUBLICO").enable();',
'   apex.item("NOVO_CONTRATO").enable();',
'   apex.item("VALOR_VENDA").enable();',
'   apex.item("DESC_ATIVIDADES").enable();',
'',
'apex.item("P52_VALOR_BENEF").enable();',
'',
'apex.item("P52_COD_AREA").enable();'))
,p_da_action_comment=>'(Create) Habilita Campos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879363609333908430)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_PERC_BENEFICIO,P52_COD_REQ'
,p_da_action_comment=>'(Create) Habilita Campos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879364028155908430)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO_MAX,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_SALARIO,P52_PERC_BENEFICIO,P52_COD_REQ,P52_CPF_INDICADO,P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_MOTIVO_EXCECAO,P52_ORGAO_PUBLI'
||'CO,P52_NOVO_CONTRATO,P52_VALOR_VENDA,P52_DESC_ATIVIDADES,P52_MAT_SUBS,P52_VLR_AUX_TIPO_MODALIDADE,P52_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA'
,p_da_action_comment=>'(Create) Habilita Campos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879364533502908430)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO_MAX,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_SALARIO,P52_PERC_BENEFICIO,P52_VLR_AUX_TIPO_MODALIDADE'
,p_da_action_comment=>'(Create) Habilita Campos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879365030980908430)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'console.log("P52_TOTAL_SALARIO = " + apex.item( "P52_TOTAL_SALARIO" ).getValue());'
,p_da_action_comment=>'(Create) Habilita Campos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879365925818908430)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_da_action_comment=>'(Create) Popula %'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879366431420908431)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO'
,p_da_action_comment=>'(Create) Popula %'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879366994971908432)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P52_PERC_BENEFICIO'').disabled = false;',
'$x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'$x(''P52_PERC_BENEF_EXCECAO'').disabled = false;'))
,p_da_action_comment=>'(Create) Popula %'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879367450746908432)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'perc_benef number := :P52_PERC_BENEFICIO_VARIAVEL;',
'perc_excecao number := :P52_PERC_BENEF_EXCECAO;',
'',
'begin',
'',
'if :P52_PERC_BENEFICIO is null then -- If adicionado por Igor Cardoso 04/06/2019',
'    IF NVL(perc_excecao,0) > 0 THEN',
'    :P52_PERC_BENEFICIO := NVL(perc_excecao,0);',
'    ELSE',
'    :P52_PERC_BENEFICIO := NVL(perc_benef,0);',
'    END IF;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_PERC_BENEF_EXCECAO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO'
,p_attribute_03=>'P52_PERC_BENEFICIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Popula %'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879368400694908432)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P52_COD_CCUSTO_X := nvl(NVL(:P52_COD_CCUSTO_1,:P52_COD_CCUSTO),:P52_COD_CCUSTO_X);',
':P52_COD_UNIDADE_ADM_X := NVL(:P52_COD_UNIDADE_ADM_1,:P52_COD_UNIDADE_ADM);',
':P52_COD_ATIVIDADE_X := NVL(:P52_COD_ATIVIDADE_1,:P52_COD_ATIVIDADE);',
':P52_COD_LOCAL_TRAB_X := NVL(:P52_COD_LOCAL_TRAB_1,:P52_COD_LOCAL_TRAB);',
':P52_VINCULO_X := NVL(:P52_VINCULO_1,:P52_VINCULO);',
':P52_COD_CCUSTO_CONTAB_X := NVL(:P52_COD_CCUSTO_CONTAB_1,:P52_COD_CCUSTO_CONTAB);',
':P52_COD_UN_NEGOCIO_X := NVL(:P52_COD_UN_NEGOCIO_1,:P52_COD_UN_NEGOCIO);',
':P52_COD_CARGO_X := NVL(:P52_COD_CARGO_1,:P52_COD_CARGO);',
':P52_COD_FUNCAO_X := NVL(:P52_COD_FUNCAO_1,:P52_COD_FUNCAO);',
':P52_COD_CATEGORIA_X := NVL(:P52_COD_CATEGORIA_1,:P52_COD_CATEGORIA);',
':P52_COD_SINDICATO_X := NVL(:P52_COD_SINDICATO_1,:P52_COD_SINDICATO);',
':P52_RT_JORNADA_MENSAL_X := NVL(:P52_RT_JORNADA_MENSAL_1,:P52_RT_JORNADA_MENSAL);',
':P52_COD_HORARIO_X := NVL(:P52_COD_HORARIO_1,:P52_COD_HORARIO);',
''))
,p_attribute_02=>'P52_COD_CCUSTO_1,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM_1,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE_1,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB_1,P52_COD_LOCAL_TRAB,P52_VINCULO_1,P52_VINCULO,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO_1,P52_C'
||'OD_UN_NEGOCIO,P52_COD_CARGO_1,P52_COD_CARGO,P52_COD_FUNCAO_1,P52_COD_FUNCAO,P52_COD_CATEGORIA_1,P52_COD_CATEGORIA,P52_COD_SINDICATO_1,P52_COD_SINDICATO,P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO_1,P52_COD_HORARIO'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_VINCULO_X,P52_COD_CCUSTO_CONTAB_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X,P52_RT_JORNADA_MENSAL_X,P52_COD_HORARI'
||'O_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Popula Campos X'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879368875530908433)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_flag_temporario = ''S'' and :p52_rowid is null then',
':P52_ENABLE_DA := ''S'';',
'else',
':P52_ENABLE_DA := ''N'';',
'end if;'))
,p_attribute_02=>'P52_FLAG_TEMPORARIO,P52_ROWID'
,p_attribute_03=>'P52_ENABLE_DA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Popula Campos X'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879369729804908433)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
':P52_COD_CCUSTO_Y := NVL(:P52_COD_CCUSTO_1,:P52_COD_CCUSTO);',
':P52_NOME_CCUSTO_Y := NVL(:P52_COD_CCUSTO_1,:P52_COD_CCUSTO)||'' - ''||INITCAP(fnct_nome_ccusto(:P52_COD_EMPRESA, NVL(:P52_COD_CCUSTO_1,:P52_COD_CCUSTO)));',
'',
':P52_COD_UNIDADE_ADM_Y := NVL(:P52_COD_UNIDADE_ADM_1,:P52_COD_UNIDADE_ADM);',
':P52_NOME_UNIDADE_ADM_Y := NVL(:P52_COD_UNIDADE_ADM_1,:P52_COD_UNIDADE_ADM)||'' - ''||INITCAP(fnct_nome_unidade_adm(:P52_COD_EMPRESA, NULL, NVL(:P52_COD_UNIDADE_ADM_1,:P52_COD_UNIDADE_ADM)));',
'',
':P52_COD_ATIVIDADE_Y := NVL(:P52_COD_ATIVIDADE_1,:P52_COD_ATIVIDADE);',
':P52_NOME_ATIVIDADE_Y := NVL(:P52_COD_ATIVIDADE_1,:P52_COD_ATIVIDADE)||'' - ''||INITCAP(FNCT_NOME_ATIVIDADE(NVL(:P52_COD_ATIVIDADE_1,:P52_COD_ATIVIDADE)));',
'',
':P52_COD_LOCAL_TRAB_Y := NVL(:P52_COD_LOCAL_TRAB_1,:P52_COD_LOCAL_TRAB);',
':P52_NOME_LOCAL_TRAB_Y := NVL(:P52_COD_LOCAL_TRAB_1,:P52_COD_LOCAL_TRAB)||'' - ''||INITCAP(FNCT_NOME_LOCAL_TRAB(NVL(:P52_COD_LOCAL_TRAB_1,:P52_COD_LOCAL_TRAB)));',
'',
':P52_COD_CCUSTO_CONTAB_Y := NVL(:P52_COD_CCUSTO_CONTAB_1,:P52_COD_CCUSTO_CONTAB);',
':P52_NOME_CCUSTO_CONTAB_Y := INITCAP(NVL(:P52_COD_CCUSTO_CONTAB_1,:P52_COD_CCUSTO_CONTAB));',
'',
':P52_COD_UN_NEGOCIO_Y := NVL(:P52_COD_UN_NEGOCIO_1,:P52_COD_UN_NEGOCIO);',
':P52_NOME_UN_NEGOCIO_Y := NVL(:P52_COD_UN_NEGOCIO_1,:P52_COD_UN_NEGOCIO)||'' - ''||INITCAP(FNCT_NOME_UN_NEGOCIO(:P52_COD_EMPRESA,NVL(:P52_COD_CCUSTO_CONTAB_1,:P52_COD_CCUSTO_CONTAB),NVL(:P52_COD_UN_NEGOCIO_1,:P52_COD_UN_NEGOCIO)));',
'',
'end;'))
,p_attribute_02=>'P52_COD_CCUSTO_1,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM_1,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE_1,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB_1,P52_COD_LOCAL_TRAB,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO_1,P52_COD_UN_NEGOCIO,P52_COD_EMPR'
||'ESA'
,p_attribute_03=>'P52_COD_CCUSTO_Y,P52_COD_UNIDADE_ADM_Y,P52_COD_ATIVIDADE_Y,P52_COD_LOCAL_TRAB_Y,P52_COD_CCUSTO_CONTAB_Y,P52_COD_UN_NEGOCIO_Y,P52_NOME_CCUSTO_Y,P52_NOME_UNIDADE_ADM_Y,P52_NOME_ATIVIDADE_Y,P52_NOME_LOCAL_TRAB_Y,P52_NOME_CCUSTO_CONTAB_Y,P52_NOME_UN_NEGO'
||'CIO_Y'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Popula Campos Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879370709421908433)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_MAT_SUBS IS NOT NULL THEN',
'	:P52_COD_MOT_REQ     := 1;',
'    :P52_COD_MOT_SIT_REQ := 1;',
'ELSE	',
'	:P52_COD_MOT_REQ     := nvl(:P52_COD_MOT_REQ,2);',
'    :P52_COD_MOT_SIT_REQ := nvl(:P52_COD_MOT_REQ,2);',
'END IF; ',
'',
'if :p52_flag_temporario is null then',
':p52_flag_temporario := ''N'';',
'END IF;'))
,p_attribute_02=>'P52_MAT_SUBS,P52_FLAG_TEMPORARIO,P52_COD_MOT_REQ'
,p_attribute_03=>'P52_COD_MOT_REQ,P52_COD_MOT_SIT_REQ,P52_FLAG_TEMPORARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Popula Motivos'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879484197034908480)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>150
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio number := replace(replace(:P52_PERC_BENEFICIO,''R$''),''.'');',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   null,--:p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    V_PERC_BENEFICIO,',
'                                    :P52_RT_JORNADA_MENSAL_X,',
'                                    :p52_cod_horario_x);',
'',
'if 1 = 2 then',
'if nvl(v_remuneracao_variavel,0) = nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 exatamente igual ao obrigat\00F3rio para os par\00E2metros informados. Para este caso, informe o tipo de remunera\00E7\00E3o como Full-CLT.'';'),
'',
'/*',
':p52_perc_beneficio_variavel := null;',
':P52_PERC_BENEF_EXCECAO := null;',
':p52_perc_beneficio := null;',
':p52_motivo_excecao := null;',
'*/',
'',
'elsif nvl(v_remuneracao_variavel,0) < nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 menor do que o obrigat\00F3rio para os par\00E2metros informados.'';'),
'',
'elsif nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and nvl(v_valor_beneficio,0) > 0 then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 diferente do obrigat\00F3rio (''||v_valor_beneficio||'') para os par\00E2metros informados. Para este caso, Full-CLT, informe o valor do benef\00EDcio corretamente.'';'),
'',
'end if;',
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''TIPO_REMUNERACAO''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''TIPO_REMUNERACAO'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_ITEM_VALIDACAO,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'(Create) Full-CLT Benef. Sindicato'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879527134944908498)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>160
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'nvl(a.cod_horario,a.cod_horario_jornada) cod_horario,',
'a.cod_sindicato,',
'a.valor_total total_salario,',
'a.valor_verba salario,',
'a.remuneracao_variavel,',
'a.perc_beneficio_variavel,',
'a.tipo_salario,',
'a.tipo_modalidade,',
'a.vlr_aux_tipo_modalidade,',
'a.trab_intermitente,',
'a.cod_area',
'from cl_vaga a',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and a.cod_vaga = :p52_cod_vaga',
'and a.sit_vaga = ''A''',
'and ((Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, a.cod_ccusto, :P_USUARIO) = ''S''',
'union',
'select DISTINCT ',
'aa.cod_ccusto,',
'aa.cod_local_trab,',
'aa.cod_ccusto_contab,',
'nvl(aa.cod_horario,aa.cod_horario_jornada) cod_horario,',
'aa.cod_sindicato,',
'aa.valor_total total_salario,',
'aa.valor_verba salario,',
'aa.remuneracao_variavel,',
'aa.perc_beneficio_variavel,',
'aa.tipo_salario,',
'aa.tipo_modalidade,',
'aa.vlr_aux_tipo_modalidade,',
'aa.trab_intermitente,',
'aa.cod_area',
'from cl_vaga a, cl_vaga aa',
'where a.cod_empresa = :p52_cod_empresa',
'and a.cod_filial = :p52_cod_filial',
'and aa.cod_vaga = :p52_cod_vaga',
'and a.cod_empresa = aa.cod_empresa',
'and a.cod_filial = aa.cod_filial',
'and a.sit_vaga = ''A''',
'and aa.sit_vaga = ''A''',
'and a.vaga_compartilhada = aa.cod_vaga',
'and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
'and Nvl(a.disponivel, ''N'') = ''N''',
'and ((Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'') or :p52_rowid is not null)',
'and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, aa.cod_ccusto, :P_USUARIO) = ''S'';',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'if :P52_COD_VAGA is not null then',
'if :p52_cod_ccusto_1 is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_cod_ccusto_x :=  nvl(v_c1.cod_ccusto,:p52_cod_ccusto_x);',
':p52_cod_ccusto_1 :=  nvl(v_c1.cod_ccusto,:p52_cod_ccusto_x);',
'end if;',
'',
'if :p52_cod_local_trab_1 is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_cod_local_trab_x := nvl(v_c1.cod_local_trab,:p52_cod_local_trab_x);',
':p52_cod_local_trab_1 := v_c1.cod_local_trab;',
'end if;',
'',
'if :p52_cod_ccusto_contab_1 is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_cod_ccusto_contab_x := nvl(v_c1.cod_ccusto_contab,:p52_cod_ccusto_contab_x);',
':p52_cod_ccusto_contab_1 := nvl(v_c1.cod_ccusto_contab,:p52_cod_ccusto_contab_x);',
'end if;',
'',
'if :p52_cod_horario_1 is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_cod_horario_x := nvl(v_c1.cod_horario,:p52_cod_horario_x);',
':p52_cod_horario_1 := v_c1.cod_horario;',
'end if;    ',
'',
'if :P52_COD_SINDICATO_1 is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':P52_COD_SINDICATO_1 := v_c1.cod_sindicato;',
':p52_cod_sindicato_x := nvl(v_c1.cod_sindicato,:p52_cod_sindicato_x);',
'end if;',
'',
'if :p52_tipo_salario is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_tipo_salario := v_c1.tipo_salario;',
'end if;',
'',
'if :p52_total_salario is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_total_salario := v_c1.total_salario;',
'end if;',
'',
'if :p52_salario is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_salario := v_c1.salario;',
'end if;',
'',
'if :p52_remuneracao_variavel is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_remuneracao_variavel := v_c1.remuneracao_variavel;',
'end if;',
'',
'if :p52_perc_beneficio is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_perc_beneficio := v_c1.perc_beneficio_variavel;',
'end if;',
'',
'if :p52_tipo_modalidade is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_tipo_modalidade := v_c1.tipo_modalidade;',
'end if;',
'',
'if :p52_vlr_aux_tipo_modalidade is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_vlr_aux_tipo_modalidade := v_c1.vlr_aux_tipo_modalidade;',
'end if;',
'',
'if :p52_trab_intermitente is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_trab_intermitente := v_c1.trab_intermitente;',
'end if;',
'    ',
'if :p52_cod_area is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
':p52_cod_area := v_c1.cod_area;',
'end if;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_SINDICATO_X,P52_COD_LOCAL_TRAB_X,P52_COD_HORARIO_X,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB_X,P52_COD_LOCAL_TRAB_1,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_SINDICATO_1,P52_TOTAL_SAL'
||'ARIO,P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_PERC_BENEFICIO,P52_TIPO_SALARIO,P52_TIPO_MODALIDADE,P52_VLR_AUX_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA,P52_VAGA_DISP_POR_REQ_DESLIG,P52_COD_CCUSTO_1,P52_COD_CCUSTO_X'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X,P52_COD_LOCAL_TRAB_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB_X,P52_COD_HORARIO_X,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_CCUSTO_X,P52_COD_SINDICATO_1,P52_COD_SINDICATO_X,P52_TOTAL_SALARIO,P52_SALARIO,P52_REMUNERACAO_VARI'
||'AVEL,P52_PERC_BENEFICIO,P52_TIPO_SALARIO,P52_TIPO_MODALIDADE,P52_VLR_AUX_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
,p_da_action_comment=>'Create (Vaga) Popula campos vazios'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37913308329796666208)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>170
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DATA_INICIO,P52_DATA_FIM,P52_IND_INSALUB,P52_IND_PERIC,P52_DT_PREVISAO_ADMISSAO,P52_DT_PREV_FIM_CONTRATO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495107480622432647)
,p_event_id=>wwv_flow_api.id(37879362625274908428)
,p_event_result=>'TRUE'
,p_action_sequence=>180
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('alertify.set({labels:{ok:"Criar",cancel:"Deixar em Revis\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja prosseguir com a cria\00E7\00E3o da requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'',
'          apex.item("P52_COD_SIT_REQ").setValue("1");',
'          //document.getElementById("SAVE").click();',
'        apex.submit(''CREATE'');',
'        ',
'	    }else{',
'          apex.item("P52_COD_SIT_REQ").setValue("0");',
'          //document.getElementById("SAVE").click();',
'        apex.submit(''CREATE'');',
'      }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'        ',
'	});',
'',
unistr('// Alterando as cores dos bot\00F5es ap\00F3s o di\00E1logo ser exibido'),
'setTimeout(function () {',
unistr('  // Seleciona o bot\00E3o OK'),
'  var okButton = document.querySelector(''.alertify-button-ok'');',
'  if (okButton) {',
'    okButton.style.backgroundColor = ''#4CAF50''; // Verde',
'    okButton.style.color = ''#fff'';',
'    okButton.style.border = ''none'';',
'  }',
'',
unistr('  // Seleciona o bot\00E3o Cancelar'),
'  var cancelButton = document.querySelector(''.alertify-button-cancel'');',
'  if (cancelButton) {',
'    cancelButton.style.backgroundColor = ''#027bc7''; // Azul',
'    cancelButton.style.color = ''#fff'';',
'    cancelButton.style.border = ''none'';',
'  }',
unistr('}, 10); // Timeout para garantir que os elementos est\00E3o renderizados')))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879371074195908433)
,p_name=>'(Aberto) Desabilita Campos (Pesquisa)'
,p_event_sequence=>318
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ in (0,1,5) AND :P_PERFIL NOT IN (''REMUNERACAO'',''MASTER'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879371533776908434)
,p_event_id=>wwv_flow_api.id(37879371074195908433)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P52_COD_SIT_REQ").disable();',
'',
'apex.item("P52_FLAG_TEMPORARIO").disable();',
'apex.item("P52_QTD_POSICAO").disable();',
'apex.item("P52_COD_EMPRESA").disable();',
'apex.item("P52_COD_FILIAL").disable();',
'apex.item("P52_COD_VAGA").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_CARGO").disable();',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_MAT_SUBS").disable();',
'apex.item("P52_MOT_SUBS").disable();',
'apex.item("P52_PONTOS_AVAL").disable();',
'',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
'',
'apex.item("P52_CANDIDATO_INDICADO").disable();',
'',
'apex.item("P52_IND_DEF_FIS").disable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").disable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").disable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").disable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").disable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").disable();',
'',
'apex.item("P52_COD_CATEGORIA").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'',
'//apex.item("P52_TIPO_PONTO").disable();',
'//apex.item("P52_JORNADA").disable();',
'//apex.item("P52_ESCALA").disable();',
'//apex.item("P52_CICLO").disable();',
'//apex.item("P52_CICLO_INICIAL").disable();',
'//apex.item("P52_CICLO_DAT_INICIAL").disable();',
'//apex.item("P52_CICLO_DAT_FINAL").disable();',
'',
'',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").disable();',
'',
'apex.item("P52_COD_SINDICATO").disable();',
'apex.item("P52_VAGA_FATURAVEL").disable();',
'apex.item("P52_VALOR_FATURAVEL").disable();',
'apex.item("P52_TOTAL_SALARIO").disable();',
'apex.item("P52_TIPO_MODALIDADE").disable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'apex.item("P52_TIPO_SALARIO").disable();',
'',
'apex.item("P52_COD_AREA").enable();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879371928815908434)
,p_name=>'(Aberto) Remuneracao Desabilita Campos (Pesquisa) - MASTER REMUNERACAO'
,p_event_sequence=>328
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ in (0,1,5) and :P_PERFIL IN (''REMUNERACAO'',''MASTER'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879372443750908434)
,p_event_id=>wwv_flow_api.id(37879371928815908434)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P52_COD_SIT_REQ").disable();',
'',
'apex.item("P52_FLAG_TEMPORARIO").disable();',
'apex.item("P52_QTD_POSICAO").disable();',
'apex.item("P52_COD_EMPRESA").disable();',
'apex.item("P52_COD_FILIAL").disable();',
'apex.item("P52_COD_VAGA").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_CARGO").disable();',
'apex.item("P52_SALARIO").disable();',
' apex.item("P52_MAT_SUBS").disable();',
'apex.item("P52_MOT_SUBS").disable();',
'apex.item("P52_PONTOS_AVAL").disable();',
'',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
'',
'apex.item("P52_CANDIDATO_INDICADO").disable();',
'',
'apex.item("P52_IND_DEF_FIS").disable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").disable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").disable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").disable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").disable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").disable();',
'',
' apex.item("P52_COD_CATEGORIA").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'',
'apex.item("P52_TIPO_PONTO").disable();',
'apex.item("P52_JORNADA").disable();',
'apex.item("P52_ESCALA").disable();',
'apex.item("P52_CICLO").disable();',
'apex.item("P52_CICLO_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_FINAL").disable();',
'',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_TOTAL_SALARIO").enable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").enable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'apex.item("P52_PERC_BENEF_EXCECAO").enable();',
'apex.item("P52_TIPO_SALARIO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'',
'apex.item("P52_COD_AREA").enable();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879372917656908434)
,p_name=>'(Encerrado) Desabilita Campos (Pesquisa)'
,p_event_sequence=>338
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ not in (0,1,5) then',
'    return true;',
'  elsif :p52_rowid is not null and :P_PERFIL NOT IN (''MASTER'',''REMUNERACAO'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879373379497908435)
,p_event_id=>wwv_flow_api.id(37879372917656908434)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P52_COD_SIT_REQ").disable();',
'',
'apex.item("P52_FLAG_TEMPORARIO").disable();',
'apex.item("P52_QTD_POSICAO").disable();',
'apex.item("P52_COD_EMPRESA").disable();',
'apex.item("P52_COD_FILIAL").disable();',
'apex.item("P52_COD_VAGA").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'apex.item("P52_COD_ATIVIDADE").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_VINCULO").disable();',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
'apex.item("P52_COD_CARGO").disable();',
'apex.item("P52_SALARIO").disable();',
'//CH43237 apex.item("P52_COD_HORARIO").disable();',
'apex.item("P52_MAT_SUBS").disable();',
'apex.item("P52_MOT_SUBS").disable();',
'apex.item("P52_PONTOS_AVAL").disable();',
'apex.item("P52_ANOS_SERVICO").disable();',
'apex.item("P52_MESES_SERVICO").disable();',
'apex.item("P52_SEXO").disable();',
'apex.item("P52_IDADE_MIN").disable();',
'apex.item("P52_IDADE_MAX").disable();',
'apex.item("P52_COD_INSTRUCAO").disable();',
'apex.item("P52_OBSERVACAO").disable();',
'apex.item("P52_IND_INSALUB").disable();',
'apex.item("P52_IND_PERIC").disable();',
'apex.item("P52_CANDIDATO_INDICADO").disable();',
'apex.item("P52_VAGA_FATURAVEL").disable();',
'apex.item("P52_VALOR_FATURAVEL").disable();',
'apex.item("P52_IND_DEF_FIS").disable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").disable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").disable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").disable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").disable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").disable();',
'apex.item("P52_TOTAL_SALARIO").disable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'apex.item("P52_TIPO_SALARIO").disable();',
'',
' apex.item("P52_COD_CATEGORIA").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'',
'apex.item("P52_TIPO_PONTO").disable();',
'apex.item("P52_JORNADA").disable();',
'apex.item("P52_ESCALA").disable();',
'apex.item("P52_CICLO").disable();',
'apex.item("P52_CICLO_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_FINAL").disable();',
'',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").disable();',
'apex.item("P52_TIPO_MODALIDADE").disable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'',
'apex.item("P52_COD_AREA").disable();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879452919195908466)
,p_name=>'Popula COD_UN_NEGOCIO'
,p_event_sequence=>348
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UN_NEGOCIO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879453424999908466)
,p_event_id=>wwv_flow_api.id(37879452919195908466)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_UN_NEGOCIO_1 := :P52_COD_UN_NEGOCIO_X;'
,p_attribute_02=>'P52_COD_UN_NEGOCIO_X'
,p_attribute_03=>'P52_COD_UN_NEGOCIO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879453743550908467)
,p_name=>unistr('Esconder Campo Sal\00E1rio')
,p_event_sequence=>358
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'',
'if :p52_rowid is not null AND :P52_COD_SIT_REQ <> 0 then',
' if not FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL) then',
'   return true; -- oculta',
' end if;',
'else',
'  return false;',
'end if;',
'',
'end;',
'',
'',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879454233679908468)
,p_event_id=>wwv_flow_api.id(37879453743550908467)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_TOTAL_SALARIO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879454652991908468)
,p_name=>unistr('Mostrar Campo Sal\00E1rio')
,p_event_sequence=>368
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_return boolean;',
'',
'begin ',
'',
'if :p52_rowid is not null AND :P52_COD_SIT_REQ <> 0 then',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL);',
'return v_return;',
'else',
'return true;',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879455162880908469)
,p_event_id=>wwv_flow_api.id(37879454652991908468)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879455576811908469)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>378
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P52_COD_SIT_REQ'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879455971897908469)
,p_name=>'Mostra Campo Valor Faturavel'
,p_event_sequence=>388
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VAGA_FATURAVEL'
,p_condition_element=>'P52_VAGA_FATURAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879456509765908469)
,p_event_id=>wwv_flow_api.id(37879455971897908469)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879456934258908469)
,p_event_id=>wwv_flow_api.id(37879455971897908469)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879457484517908469)
,p_event_id=>wwv_flow_api.id(37879455971897908469)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879457905303908469)
,p_name=>'Valida Valor Faturavel'
,p_event_sequence=>398
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879458380297908470)
,p_event_id=>wwv_flow_api.id(37879457905303908469)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'',
'  if :p52_VAGA_FATURAVEL = ''S'' and :p52_valor_Faturavel is null then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Informe um valor fatur\00E1vel!'';'),
'  elsif :p52_VAGA_FATURAVEL = ''S'' and NVL(:p52_valor_Faturavel,''0'') = ''0'' then',
'  v_flg_retorno := ''N'';',
unistr('  v_msg_retorno := ''Valor fatur\00E1vel n\00E3o pode ser 0!'';'),
'  end if;',
'  ',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''p52_valor_Faturavel''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p52_valor_Faturavel'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_VAGA_FATURAVEL,P52_VALOR_FATURAVEL,P52_ITEM_VALIDACAO'
,p_attribute_03=>'P52_FLAG,P52_MENSAGEM,P52_OK,P52_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879458729992908470)
,p_name=>'Mask TOTAL_SALARIO'
,p_event_sequence=>408
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TOTAL_SALARIO'
,p_condition_element=>'P52_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879459226136908470)
,p_event_id=>wwv_flow_api.id(37879458729992908470)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(replace(:p52_total_salario,''R$''),''.'');',
'',
'begin',
'',
':p52_total_salario := V_SAL;--trim(to_char(v_sal,''999G999G999G999G990D00''));',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO'
,p_attribute_03=>'P52_TOTAL_SALARIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879459645221908470)
,p_name=>'Mask REMUNERACAO_VARIAVEL'
,p_event_sequence=>418
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL'
,p_condition_element=>'P52_REMUNERACAO_VARIAVEL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879460163101908470)
,p_event_id=>wwv_flow_api.id(37879459645221908470)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_rem number;',
'v_rem_mask varchar2(200);',
'',
'begin',
'/*',
'    IF :P52_ROWID IS NULL THEN',
'    EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'    END IF;',
'*/',
'    v_rem := replace(replace(:P52_REMUNERACAO_VARIAVEL,''R$''),''.'','','');',
'/*',
'    IF :P52_ROWID IS NULL THEN',
'    EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'    END IF;',
'*/',
'    v_rem_mask :=  trim(to_char(v_rem,''99999990D90''));',
'',
'  :P52_REMUNERACAO_VARIAVEL := v_rem_mask;',
'',
'end;',
''))
,p_attribute_02=>'P52_REMUNERACAO_VARIAVEL,P52_ROWID'
,p_attribute_03=>'P52_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879460544164908470)
,p_name=>'Mostra campos DEF'
,p_event_sequence=>428
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_IND_DEF_FIS'
,p_condition_element=>'P52_IND_DEF_FIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879461122216908471)
,p_event_id=>wwv_flow_api.id(37879460544164908470)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879461577670908471)
,p_event_id=>wwv_flow_api.id(37879460544164908470)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879461962412908471)
,p_name=>'Mostra Valores'
,p_event_sequence=>438
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879462516325908471)
,p_event_id=>wwv_flow_api.id(37879461962412908471)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879462957023908471)
,p_event_id=>wwv_flow_api.id(37879461962412908471)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879463447298908471)
,p_event_id=>wwv_flow_api.id(37879461962412908471)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879463972715908472)
,p_event_id=>wwv_flow_api.id(37879461962412908471)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_FLAG_TEMPORARIO'').value == ''S''){',
'',
'    if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue().length == 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).disable() ;',
'      apex.item( "P52_SALARIO" ).disable() ;  ',
'      */  ',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;    ',
'      $x(''P52_SALARIO'').disabled = true;   ',
'',
'    }else if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue() > 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).disable() ;',
'      apex.item( "P52_SALARIO" ).disable() ;',
'      */',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;    ',
'      $x(''P52_SALARIO'').disabled = true;   ',
'      ',
'    }else if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue() == 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).enable() ;',
'      apex.item( "P52_SALARIO" ).disable() ; ',
'      */',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;    ',
'      $x(''P52_SALARIO'').disabled = true; ',
'',
'    }',
'    ',
'}else{',
'',
'    if ($x(''P52_BOTOES_REQ_PESSOAL'').value = ''S''){',
'        $x(''P52_SALARIO'').disabled = false;',
'        //$x(''P52_SALARIO_MAX'').disabled = false;',
'        $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'        $x(''P52_TOTAL_SALARIO'').disabled = false;',
'        $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'        $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'',
'        //document.getElementById(''PERFIL'').style.visibility = "visible";',
'    } else {',
'        $x(''P52_SALARIO'').disabled = true;',
'        //$x(''P52_SALARIO_MAX'').disabled = true;',
'        $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'        $x(''P52_TOTAL_SALARIO'').disabled = true;',
'        $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'        $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'',
'        //document.getElementById(''PERFIL'').style.visibility = "hidden";',
'    }',
'  ',
'    if ($x(''P52_FLG_UTILIZA_SALARIO_POS'').value == ''S''){',
'       // $x(''P52_SALARIO_MAX'').disabled = true;',
'       $x(''P52_TIPO_SALARIO'').disabled = true;',
'       $x(''P52_TOTAL_SALARIO'').disabled = true;',
'       $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'       $x(''P52_PERC_BENEF_EXCECAO'').disabled = true;',
'       $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'       $x(''P52_SALARIO'').disabled = true;',
'       $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'    } else {',
'        //$x(''P52_SALARIO_MAX'').disabled = false;',
'       $x(''P52_TIPO_SALARIO'').disabled = false;',
'       $x(''P52_TOTAL_SALARIO'').disabled = false;',
'       $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'       $x(''P52_PERC_BENEF_EXCECAO'').disabled = false;',
'       $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'       $x(''P52_SALARIO'').disabled = false;',
'       $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879464356589908472)
,p_name=>'Mostra Valores Excecao'
,p_event_sequence=>448
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879464889739908472)
,p_event_id=>wwv_flow_api.id(37879464356589908472)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879465396385908472)
,p_event_id=>wwv_flow_api.id(37879464356589908472)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879465911552908472)
,p_event_id=>wwv_flow_api.id(37879464356589908472)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'  $x(''P52_SALARIO'').disabled = true;    ',
'  $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879466301303908472)
,p_name=>'Esconde Valores'
,p_event_sequence=>458
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879466760563908473)
,p_event_id=>wwv_flow_api.id(37879466301303908472)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879467218153908473)
,p_name=>'Popula Remuneracao Variavel'
,p_event_sequence=>468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879467660729908473)
,p_event_id=>wwv_flow_api.id(37879467218153908473)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_total_salario number := replace(replace(:P52_TOTAL_SALARIO,''R$''),''.'');',
'--v_total_salario number := :P52_TOTAL_SALARIO;',
'',
'begin',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'if :p52_perc_beneficio_variavel > 0 then',
':p52_remuneracao_variavel := round((v_TOTAL_SALARIO * (:p52_perc_beneficio_variavel/100)),2) - nvl(:P52_VLR_AUX_TIPO_MODALIDADE,0);',
'/*:p52_SALARIO_MAX := round((v_TOTAL_SALARIO * ((100-:p52_perc_beneficio_variavel)/100)),2);*/',
':p52_SALARIO := round((v_TOTAL_SALARIO * ((100-:p52_perc_beneficio_variavel)/100)),2);',
'elsif :p52_perc_beneficio_variavel is null then',
':p52_remuneracao_variavel := null;',
'/*:p52_SALARIO_MAX := v_TOTAL_SALARIO;*/',
':p52_SALARIO := nvl(v_TOTAL_SALARIO,0);',
'elsif :p52_perc_beneficio_variavel = 0 then',
'--:P52_PERC_BENEF_EXCECAO := 0;',
':p52_remuneracao_variavel := 0;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_PERC_BENEFICIO_VARIAVEL,P52_TOTAL_SALARIO,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P52_REMUNERACAO_VARIAVEL,P52_SALARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879468027981908473)
,p_name=>'Popula Salario'
,p_event_sequence=>468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TOTAL_SALARIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P52_COD_VAGA'').getValue().length == 0 && ',
'apex.item(''P52_AJUSTAR_REMUNERACAO'').getValue() != ''N'' && ',
'apex.item(''P52_TOTAL_SALARIO'').getValue().length > 0'))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879468584012908474)
,p_event_id=>wwv_flow_api.id(37879468027981908473)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_total_salario           number := replace(replace(:p52_total_salario,''R$''),''.'');',
'v_salario                 number := replace(replace(:p52_salario,''R$''),''.'');',
'v_remuneracao_variavel    number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio_variavel number := replace(replace(:p52_perc_beneficio_variavel,''R$''),''.'');',
'v_perc_benef_excecao      number := replace(replace(:p52_perc_benef_excecao,''R$''),''.'');',
'v_perc_beneficio          number := replace(replace(:P52_PERC_BENEFICIO,''R$''),''.'');',
'v_vlr_aux_tipo_modalidade number := replace(replace(:P52_VLR_AUX_TIPO_MODALIDADE,''R$''),''.'');',
'',
'begin',
'/*',
'pkg_pessoal.prc_popula_salario (:p52_cod_empresa,',
':p52_cod_filial,',
':p52_cod_ccusto,',
':p52_cod_cargo,',
':p52_cod_sindicato,',
':p52_cod_unidade_adm,',
':p52_cod_un_negocio,',
':p52_cod_atividade,',
':p52_cod_vaga,',
':p52_refeitorio,',
':p52_vinculo_x,',
':p52_rt_jornada_mensal_x,',
':p52_total_salario,',
':p52_perc_beneficio_variavel,',
':p52_perc_benef_excecao,',
':p52_vlr_aux_tipo_modalidade,',
':p52_salario,',
':p52_remuneracao_variavel,',
':p52_perc_beneficio);',
'*/',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    V_PERC_BENEFICIO,',
'                                    :P52_RT_JORNADA_MENSAL_X,',
'                                    :p52_cod_horario_x);',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'  if v_perc_beneficio_variavel is null then -- Full-CLT',
'    v_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
'    v_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'  elsif v_perc_beneficio_variavel > 0 then -- Flex (20% ou 30%)',
'    v_salario := round((v_total_salario * ((100-v_perc_beneficio_variavel)/100)),2);',
'    v_remuneracao_variavel := round((v_total_salario * (v_perc_beneficio_variavel/100)),2);',
unistr('  elsif v_perc_beneficio_variavel = 0 then -- Flex (Exce\00E7\00E3o)'),
'    if nvl(v_perc_benef_excecao,0) > 0 then',
'       v_remuneracao_variavel := round((v_total_salario * (v_perc_benef_excecao/100)),2);',
'       v_salario := v_total_salario - (nvl(v_remuneracao_variavel,0));',
'    else',
'       v_remuneracao_variavel := null;',
'       v_salario := v_total_salario - v_remuneracao_variavel;',
'    end if;',
'  end if;',
'',
'  IF V_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     V_PERC_BENEFICIO := V_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF NVL(V_PERC_BENEFICIO_VARIAVEL,0) = 0 AND NVL(v_perc_benef_excecao,0) > 0 THEN',
'     V_PERC_BENEFICIO := v_perc_benef_excecao;',
'  ELSIF NVL(V_PERC_BENEFICIO_VARIAVEL,0) > 0 AND NVL(v_perc_benef_excecao,0) > 0 THEN',
'     V_PERC_BENEFICIO := v_perc_benef_excecao;',
'  ELSIF V_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(v_perc_benef_excecao,0) = 0 THEN',
'     V_PERC_BENEFICIO := NULL;',
'  END IF;',
'',
':P52_SALARIO := v_salario;',
':P52_REMUNERACAO_VARIAVEL := v_remuneracao_variavel;',
':P52_PERC_BENEFICIO := v_perc_beneficio;',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_VLR_AUX_TIPO_MODALIDADE,P52_PERC_BENEF_EXCECAO,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_PERC_BENEFICIO,P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879468979278908474)
,p_name=>'Valida_Salario'
,p_event_sequence=>478
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TOTAL_SALARIO'
,p_condition_element=>'P52_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879469430490908474)
,p_event_id=>wwv_flow_api.id(37879468979278908474)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_FLAG_TEMPORARIO'').value == ''S''){',
'',
'    if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue().length == 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).disable() ;',
'      apex.item( "P52_SALARIO" ).disable() ;  ',
'      */  ',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;    ',
'      $x(''P52_SALARIO'').disabled = true;   ',
'',
'    }else if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue() > 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).disable() ;',
'      apex.item( "P52_SALARIO" ).disable() ;',
'      */',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;    ',
'      $x(''P52_SALARIO'').disabled = true;   ',
'      ',
'    }else if (apex.item( "P52_PERC_BENEFICIO_VARIAVEL" ).getValue() == 0) {',
'      /*',
'      apex.item( "P52_REMUNERACAO_VARIAVEL" ).enable() ;',
'      apex.item( "P52_SALARIO" ).disable() ; ',
'      */',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;    ',
'      $x(''P52_SALARIO'').disabled = true; ',
'    }',
'    ',
'}else{',
'',
'    if ($x(''P52_BOTOES_REQ_PESSOAL'').value = ''S''){',
'        $x(''P52_SALARIO'').disabled = false;',
'        //$x(''P52_SALARIO_MAX'').disabled = false;',
'        $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'        $x(''P52_TOTAL_SALARIO'').disabled = false;',
'        $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'        $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'        //document.getElementById(''PERFIL'').style.visibility = "visible";',
'    } else {',
'        $x(''P52_SALARIO'').disabled = true;',
'        //$x(''P52_SALARIO_MAX'').disabled = true;',
'        $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'        $x(''P52_TOTAL_SALARIO'').disabled = true;',
'        $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'        $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'        //document.getElementById(''PERFIL'').style.visibility = "hidden";',
'    }',
'  ',
'    if ($x(''P52_FLG_UTILIZA_SALARIO_POS'').value == ''S''){',
'       // $x(''P52_SALARIO_MAX'').disabled = true;',
'       $x(''P52_TIPO_SALARIO'').disabled = true;',
'       $x(''P52_TOTAL_SALARIO'').disabled = true;',
'       $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'       $x(''P52_PERC_BENEF_EXCECAO'').disabled = true;',
'       $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'       $x(''P52_SALARIO'').disabled = true;',
'       $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'    } else {',
'        //$x(''P52_SALARIO_MAX'').disabled = false;',
'       $x(''P52_TIPO_SALARIO'').disabled = false;',
'       $x(''P52_TOTAL_SALARIO'').disabled = false;',
'       $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'       $x(''P52_PERC_BENEF_EXCECAO'').disabled = false;',
'       $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'       $x(''P52_SALARIO'').disabled = false;',
'       $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879469936262908474)
,p_event_id=>wwv_flow_api.id(37879468979278908474)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'v_total_salario number := replace(replace(:P52_TOTAL_SALARIO,''R$''),''.'');',
'v_remuneracao_variavel number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'',
'begin',
'',
'--EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'',
'pkg_pessoal.Valida_Salario(:p52_cod_empresa, :p52_cod_filial, :p52_cod_vaga, v_total_salario, v_remuneracao_variavel, v_flg_retorno, v_msg_retorno, nvl(nvl(:P52_VINCULO,:p52_vinculo_1),:P52_VINCULO_X));',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''p52_TOTAL_SALARIO''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p52_TOTAL_SALARIO'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_TOTAL_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_VINCULO_X,P52_VINCULO,P52_VINCULO_1'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879470379087908474)
,p_name=>'Valida_RT_JORNADA_MENSAL'
,p_event_sequence=>488
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL'
,p_condition_element=>'P52_RT_JORNADA_MENSAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879470889836908475)
,p_event_id=>wwv_flow_api.id(37879470379087908474)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :P52_rowid is not null AND :P52_COD_VAGA_1 IS NULL then',
'',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Informe a nova Carga Hor\00E1ria e o novo Hor\00E1rio Contratual.'';'),
'',
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_RT_JORNADA_MENSAL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_RT_JORNADA_MENSAL'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_ROWID,P52_COD_VAGA_1'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879471336213908475)
,p_event_id=>wwv_flow_api.id(37879470379087908474)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_RT_JORNADA_MENSAL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_RT_JORNADA_MENSAL'')) AND :P52_COD_SINDICATO_AUX IS NOT NULL OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_COD_SINDICATO_AUX'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879471757984908475)
,p_name=>'Valida_COD_HORARIO'
,p_event_sequence=>498
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO'
,p_condition_element=>'P52_COD_HORARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879472324634908475)
,p_event_id=>wwv_flow_api.id(37879471757984908475)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_COD_HORARIO''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_COD_HORARIO'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879472630124908475)
,p_name=>unistr('Altera Sal\00E1rio e %')
,p_event_sequence=>508
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P52_COD_VAGA'').getValue().length == 0 && ',
'apex.item(''P52_AJUSTAR_REMUNERACAO'').getValue() != ''N'' && ',
'apex.item(''P52_TOTAL_SALARIO'').getValue().length > 0'))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879473208268908475)
,p_event_id=>wwv_flow_api.id(37879472630124908475)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_total_salario           number := replace(replace(:p52_total_salario,''R$''),''.'');',
'v_remuneracao_variavel    number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio_variavel number := replace(replace(:p52_perc_beneficio_variavel,''R$''),''.'');',
'v_vlr_aux_tipo_modalidade number := replace(replace(:P52_VLR_AUX_TIPO_MODALIDADE,''R$''),''.'');',
'',
'begin',
unistr('if V_PERC_BENEFICIO_VARIAVEL = 0 then -- Flex - Exce\00E7\00E3o'),
':p52_perc_benef_excecao := ROUND(((nvl(v_remuneracao_variavel,0) /*+ nvl(v_vlr_aux_tipo_modalidade,0)*/) / v_total_salario),4) * 100;',
':p52_salario := nvl(v_total_salario,0) - nvl(v_remuneracao_variavel,0) /*- nvl(v_vlr_aux_tipo_modalidade,0)*/;',
'end if;',
'end;'))
,p_attribute_02=>'P52_SALARIO,P52_PERC_BENEFICIO_VARIAVEL,P52_TOTAL_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P52_PERC_BENEF_EXCECAO,P52_SALARIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879473621715908476)
,p_name=>'Valida_Remuneracao_Variavel'
,p_event_sequence=>518
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P52_COD_VAGA'').getValue().length == 0 && ',
'apex.item(''P52_AJUSTAR_REMUNERACAO'').getValue() != ''N'' && ',
'apex.item(''P52_REMUNERACAO_VARIAVEL'').getValue().length > 0'))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879474071342908476)
,p_event_id=>wwv_flow_api.id(37879473621715908476)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'/*v_salario_max number := replace(replace(:p52_salario_max,''R$''),''.'');*/',
'v_salario number := replace(replace(:p52_salario,''R$''),''.'');',
'v_remuneracao_variavel number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'',
'begin',
'/*',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'*/',
'pkg_pessoal.Valida_Remuneracao_Variavel(:p52_cod_empresa, :p52_cod_filial, :p52_cod_vaga, v_salario, v_remuneracao_variavel, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''p52_REMUNERACAO_VARIAVEL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p52_REMUNERACAO_VARIAVEL'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879474487713908476)
,p_name=>'(2) Valida_Remuneracao_Variavel < vlr_benef_sind'
,p_event_sequence=>528
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL,P52_COD_SINDICATO_X,P52_REFEITORIO'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.item(''P52_REMUNERACAO_VARIAVEL'').getValue().length > 0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879474991324908476)
,p_event_id=>wwv_flow_api.id(37879474487713908476)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel NUMBER := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'--v_remuneracao_variavel NUMBER := :p52_remuneracao_variavel;',
'',
'begin',
'/*',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'*/',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    null,',
'                                   :P52_RT_JORNADA_MENSAL,',
'                                    :p52_cod_horario_x);',
'',
'if v_remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Valor de benef\00EDcios R$''||:p52_remuneracao_variavel||'' n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and v_remuneracao_variavel <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and :P52_PERC_BENEF_EXCECAO is null then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'',
'if nvl(v_valor_beneficio,0) >= 0 and ',
'   nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and ',
'   :P52_PERC_BENEFICIO_VARIAVEL is null and ',
'   :P52_PERC_BENEF_EXCECAO is null then',
'    v_flg_retorno := ''N'';',
'    if nvl(v_valor_beneficio,0) > 0 then',
unistr('    v_msg_retorno := ''Para Full-CLT, o valor de Remunera\00E7\00E3o Vari\00E1vel (R$''||:p52_remuneracao_variavel||'') n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio||'),
unistr('     case when :p52_rowid is not null then ''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'' else ''.'' end;'),
'    elsif nvl(v_valor_beneficio,0) = 0 and :p52_refeitorio = ''S'' then',
unistr('    v_msg_retorno := ''Para Full-CLT e havendo Refeit\00F3rio no Local, o valor de Remunera\00E7\00E3o Vari\00E1vel (R$''||:p52_remuneracao_variavel||'') deve ser de R$0,00''||'),
unistr('     case when :p52_rowid is not null then ''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'' else ''.'' end;'),
'    end if;',
'end if;',
'',
'',
unistr('/*AGUARDAR APROVA\00C7\00C3O DA STEFANINI'),
'if v_msg_retorno is not null and :p52_rowid is not null then',
unistr('v_msg_retorno := v_msg_retorno||''.<br>Clique em Ajustar Valores no bloco de Remunera\00E7\00E3o e informe o valor correto.'';'),
'end if;',
'*/',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_REMUNERACAO_VARIAVEL,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_VINCULO_X,P52_PERC_BENEFICIO_VARIAVEL,P'
||'52_PERC_BENEF_EXCECAO,P52_ROWID,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879475751639908477)
,p_name=>unistr('(Empresa) Par\00E2metros')
,p_event_sequence=>548
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_EMPRESA'
,p_condition_element=>'P52_COD_EMPRESA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879476324006908477)
,p_event_id=>wwv_flow_api.id(37879475751639908477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'SELECT NVL(FLG_UTILIZA_SALARIO_POSICAO,''N'') FLAG, ind_serv_aloca_colab, cod_ocorr_tipo_modalidade',
'  FROM PARAMETROS_RECURSOS_HUMANOS',
' WHERE COD_EMPRESA = :P52_COD_EMPRESA;',
' ',
'V_C1 C1%ROWTYPE;',
'',
'V_FLAG_TEMP VARCHAR2(1) := :P52_FLAG_TEMPORARIO;',
'',
'BEGIN',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'if NVL(V_FLAG_TEMP,''N'') = ''N'' then',
':P52_FLG_UTILIZA_SALARIO_POS := V_C1.FLAG;',
'else',
':P52_FLG_UTILIZA_SALARIO_POS := ''N'';',
'end if;',
'',
':p52_ind_serv_aloca_colab := nvl(v_c1.ind_serv_aloca_colab,''N'');',
'',
'if v_c1.cod_ocorr_tipo_modalidade is not null then',
':p52_tipo_modalidade_ocorr := ''S'';',
'else',
':p52_tipo_modalidade_ocorr := ''N'';',
'end if;',
'',
'END;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_FLAG_TEMPORARIO'
,p_attribute_03=>'P52_FLG_UTILIZA_SALARIO_POS,P52_IND_SERV_ALOCA_COLAB'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879476757163908477)
,p_event_id=>wwv_flow_api.id(37879475751639908477)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p52_utiliza_secao',
'  from parametros_recursos_humanos ',
' where cod_empresa = :p52_cod_empresa;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA'
,p_attribute_03=>'P52_UTILIZA_SECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879477220707908477)
,p_name=>'Desabilita Campos Flag'
,p_event_sequence=>558
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FLG_UTILIZA_SALARIO_POS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879477650227908478)
,p_event_id=>wwv_flow_api.id(37879477220707908477)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_FLG_UTILIZA_SALARIO_POS'').value == ''S''){',
'   // $x(''P52_SALARIO_MAX'').disabled = true;',
'   $x(''P52_TIPO_SALARIO'').disabled = true;',
'   $x(''P52_TOTAL_SALARIO'').disabled = true;',
'   $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'   $x(''P52_PERC_BENEF_EXCECAO'').disabled = true;',
'   $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'   $x(''P52_SALARIO'').disabled = true;',
'   $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'} else {',
'    //$x(''P52_SALARIO_MAX'').disabled = false;',
'   $x(''P52_TIPO_SALARIO'').disabled = false;',
'   $x(''P52_TOTAL_SALARIO'').disabled = false;',
'   $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'   $x(''P52_PERC_BENEF_EXCECAO'').disabled = false;',
'   $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'   $x(''P52_SALARIO'').disabled = false;',
'   $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879478062517908478)
,p_name=>'Valida botoes_req_pessoal'
,p_event_sequence=>568
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BOTOES_REQ_PESSOAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879478560424908478)
,p_event_id=>wwv_flow_api.id(37879478062517908478)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_BOTOES_REQ_PESSOAL'').value = ''S''){',
'    $x(''P52_SALARIO'').disabled = false;',
'    //$x(''P52_SALARIO_MAX'').disabled = false;',
'    $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'    $x(''P52_TOTAL_SALARIO'').disabled = false;',
'    $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'    $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = false;',
'    //document.getElementById(''PERFIL'').style.visibility = "visible";',
'} else {',
'    $x(''P52_SALARIO'').disabled = true;',
'    //$x(''P52_SALARIO_MAX'').disabled = true;',
'    $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    $x(''P52_TOTAL_SALARIO'').disabled = true;',
'    $x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = true;',
'    $x(''P52_VLR_AUX_TIPO_MODALIDADE'').disabled = true;',
'    //document.getElementById(''PERFIL'').style.visibility = "hidden";',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879478984532908478)
,p_name=>'Valida_Candidato_Indicado'
,p_event_sequence=>578
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CANDIDATO_INDICADO'
,p_condition_element=>'P52_CANDIDATO_INDICADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879479498389908478)
,p_event_id=>wwv_flow_api.id(37879478984532908478)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879479967452908478)
,p_event_id=>wwv_flow_api.id(37879478984532908478)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'',
'pkg_pessoal.Valida_Candidato_Indicado(:p52_cod_empresa       ',
'                                     ,:p52_candidato_indicado ',
'                                     ,v_flg_retorno',
'                                     ,v_msg_retorno);',
'  ',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''p52_candidato_indicato''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p52_candidato_indicato'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_COD_EMPRESA,P52_CANDIDATO_INDICADO'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_MENSAGEM,P52_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879480453681908478)
,p_event_id=>wwv_flow_api.id(37879478984532908478)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879481025187908479)
,p_event_id=>wwv_flow_api.id(37879478984532908478)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879481426056908479)
,p_event_id=>wwv_flow_api.id(37879478984532908478)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select initcap(nvl(nome_social,nome)) nome,',
'       e_mail, ',
'       ddd,',
'       telefone,',
'       ddd_celular,',
'       telefone_celular,',
'       substr(lpad(num_cpf,9,''0''),1,3)||''.''||',
'       substr(lpad(num_cpf,9,''0''),4,3)||''.''||',
'       substr(lpad(num_cpf,9,''0''),7,3)||''-''||',
'       lpad(dc_cpf,2,0) cpf,',
'       cod_candidato ',
'  from inf_pessoais_candidato',
' where status_candidato = ''P''',
'   and trim(nome) is not null',
'   and cod_candidato = :p52_candidato_indicado;',
'   ',
'v_c1 c1%rowtype;',
'',
'',
'begin',
'',
'  open c1;',
'  fetch c1 into v_c1;',
'  close c1;',
'  ',
'  if v_c1.cod_candidato is not null then',
'  ',
'    :p52_nome_indicado := v_c1.nome;',
'    :p52_e_mail_indicado := v_c1.e_mail;',
'    :p52_ddd_indicado := nvl(v_c1.ddd_celular,v_c1.ddd);',
'    :p52_telefone_indicado := nvl(v_c1.telefone_celular,v_c1.telefone);',
'    if v_c1.cpf <> ''..-'' then',
'    :p52_cpf_indicado := v_c1.cpf;',
'    end if;',
'  ',
'  end if;',
' ',
'end;'))
,p_attribute_02=>'P52_CANDIDATO_INDICADO'
,p_attribute_03=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879481921970908479)
,p_name=>'(Sindicato) Popula Salario'
,p_event_sequence=>588
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879482389001908479)
,p_event_id=>wwv_flow_api.id(37879481921970908479)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_total_salario number := replace(replace(:p52_total_salario,''R$''),''.'');',
'--v_total_salario number := :p52_total_salario;',
'',
'begin',
'',
'/*:p52_salario_max := v_total_salario;*/',
'--:p52_salario := v_total_salario;',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    :P52_PERC_BENEFICIO,',
'                                    :P52_RT_JORNADA_MENSAL_X,',
'                                    :p52_cod_horario_x);',
'',
'-- v_valor_beneficio := replace(v_valor_beneficio,''.'','','');',
'',
'if nvl(v_valor_beneficio,0) > 0 and :p52_perc_beneficio_variavel is null then',
'',
'/*:p52_salario_max := v_total_salario;*/',
':p52_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
':p52_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'',
'elsif nvl(v_valor_beneficio,0) = 0 and :p52_perc_beneficio_variavel > 0 then',
'',
'    if :p52_perc_beneficio_variavel > 0 then',
'    :p52_remuneracao_variavel := round((v_TOTAL_SALARIO * (:p52_perc_beneficio_variavel/100)),2);',
'    /*:p52_SALARIO_MAX := round((v_TOTAL_SALARIO * ((100-:p52_perc_beneficio_variavel)/100)),2);*/',
'    :p52_SALARIO := round((v_TOTAL_SALARIO * ((100-:p52_perc_beneficio_variavel)/100)),2);',
'    else',
'    :p52_remuneracao_variavel := null;',
'    :p52_SALARIO := nvl(v_TOTAL_SALARIO,0) - nvl(:p52_remuneracao_variavel,0);',
'    /*:p52_SALARIO_MAX := v_TOTAL_SALARIO;*/',
'    end if;',
'',
'elsif nvl(v_valor_beneficio,0) > 0 and :p52_perc_beneficio_variavel > 0 then',
'',
'    if :p52_perc_beneficio_variavel > 0 then',
'    :p52_remuneracao_variavel := round((v_total_salario * (:p52_perc_beneficio_variavel/100)),2);',
'    :p52_salario := round((v_total_salario * ((100-:p52_perc_beneficio_variavel)/100)),2);',
'    /*:p52_salario_max := round((v_total_salario * ((100-:p52_perc_beneficio_variavel)/100)),2);*/',
'    else',
'    :p52_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'    :p52_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
'    /*:p52_salario_max := v_total_salario - v_valor_beneficio;*/',
'    end if;',
'',
'elsif nvl(v_valor_beneficio,0) = 0 and :p52_perc_beneficio_variavel is null then',
'',
'/*:p52_salario_max := v_total_salario;*/',
':p52_salario := nvl(v_total_salario,0); -- nvl(v_valor_beneficio,0);',
':p52_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'',
'elsif :p52_perc_beneficio_variavel = 0 then',
'',
':P52_PERC_BENEF_EXCECAO := 0;',
':p52_remuneracao_variavel := 0;',
':p52_SALARIO := nvl(v_TOTAL_SALARIO,0);',
'',
'else',
':p52_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
'end if;',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879482822183908479)
,p_name=>'Full-CLT Benef. Sindicato'
,p_event_sequence=>598
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL,P52_MOTIVO_EXCECAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879483296162908480)
,p_event_id=>wwv_flow_api.id(37879482822183908479)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio number := replace(replace(:P52_PERC_BENEFICIO,''R$''),''.'');',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'cursor c_req is',
'select sum(nvl(i.quantidade,1)*i.valor) Valor_Total',
'  from beneficios_familia b, ',
'       beneficios_familia_tipo t, ',
'       beneficios_fam_tipo_vlr v, ',
'       req_beneficios_itens_cand i, ',
'       req_beneficios_CANDIDATO r,',
'       RP_CAND_INSCRITOS c',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_familia = i.cod_familia',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and t.tipo_cod_familia = i.tipo_cod_familia',
'   and r.dt_req between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and r.dt_req between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate)',
'   and r.dt_req between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and b.cod_empresa = r.cod_empresa',
'   and r.cod_req = i.cod_req',
'   and c.cod_req = :p52_cod_req',
'   and c.cod_candidato = r.cod_candidato',
'   and r.cod_sit_req in (1,2,5);',
'   ',
'v_req c_req%rowtype;',
'',
'begin',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   NULL,--:p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    v_perc_beneficio,',
'                                    :P52_RT_JORNADA_MENSAL_X);',
'',
'if nvl(v_remuneracao_variavel,0) = nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 exatamente igual ao obrigat\00F3rio para os par\00E2metros informados. Para este caso, informe o tipo de remunera\00E7\00E3o como Full-CLT.'';'),
'',
'elsif nvl(v_remuneracao_variavel,0) < nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is not null then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio (R$''||nvl(v_remuneracao_variavel,0)||'') \00E9 menor do que o obrigat\00F3rio (R$''||v_valor_beneficio||'') para os par\00E2metros informados.'';'),
'',
'elsif nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and nvl(v_valor_beneficio,0) > 0 then',
'',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 diferente do obrigat\00F3rio (R$''||v_valor_beneficio||'') para os par\00E2metros informados. Para este caso, Full-CLT, informe o valor do benef\00EDcio corretamente.'';'),
'',
'end if;',
'',
'open c_req;',
'fetch c_req into v_req;',
'close c_req;',
'',
'if nvl(v_req.valor_total,0) > 0 and nvl(v_req.valor_total,0) <> nvl(v_remuneracao_variavel,0) then',
'   :P52_OK := ''S'';',
'   :P52_ITEM_VALIDACAO := null;',
'   :p52_flag     := ''S'';',
unistr('   :p52_mensagem := ''Candidato j\00E1 fez a distribui\00E7\00E3o dos benef\00EDcios, por\00E9m assim que salvar essa requisi\00E7\00E3o ser\00E1 necess\00E1rio refazer a distribui\00E7\00E3o dos benef\00EDcios, devido a altera\00E7\00E3o do valor da Remunera\00E7\00E3o Vari\00E1vel.'';'),
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''TIPO_REMUNERACAO''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''TIPO_REMUNERACAO'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_ITEM_VALIDACAO,P52_COD_REQ,P52_REMUNERACAO_VARIAVEL'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879484591303908480)
,p_name=>'Open Cursos'
,p_event_sequence=>618
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879288703937908382)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879485062269908481)
,p_event_id=>wwv_flow_api.id(37879484591303908480)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_CURSO,P52_NIVEL_CURSO,P52_CONCL_CURSO,P52_EXIGE_CURSO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879485610694908481)
,p_event_id=>wwv_flow_api.id(37879484591303908480)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846296708447365013)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879485939285908481)
,p_name=>'Open Formacao'
,p_event_sequence=>628
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879188415883908327)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879486448908908481)
,p_event_id=>wwv_flow_api.id(37879485939285908481)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_FORMACAO,P52_INSTR_FORMACAO,P52_CONCL_FORMACAO,P52_EXIGE_FORMACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879486978137908481)
,p_event_id=>wwv_flow_api.id(37879485939285908481)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360453166451838369)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879487333547908481)
,p_name=>'Open Experiencia'
,p_event_sequence=>638
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879291781266908383)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879487865558908481)
,p_event_id=>wwv_flow_api.id(37879487333547908481)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_EXPERIENCIA,P52_ANOS_EXPERIENCIA,P52_MESES_EXPERIENCIA,P52_EXIGE_EXPERIENCIA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879488404892908482)
,p_event_id=>wwv_flow_api.id(37879487333547908481)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360454139014838378)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879488773001908482)
,p_name=>'Open Conhecimento'
,p_event_sequence=>648
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879294525121908384)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879489296353908482)
,p_event_id=>wwv_flow_api.id(37879488773001908482)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_CONHECIMENTO,P52_NIVEL_CONHECIMENTO,P52_EXIGE_CONHECIMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879489802973908482)
,p_event_id=>wwv_flow_api.id(37879488773001908482)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360454808935838385)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879490154695908482)
,p_name=>'Open Req. Cargos'
,p_event_sequence=>658
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879229827673908352)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879490653968908482)
,p_event_id=>wwv_flow_api.id(37879490154695908482)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179746362601699552674)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879491049469908482)
,p_name=>'Open PS'
,p_event_sequence=>668
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879126298325908291)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879491616016908483)
,p_event_id=>wwv_flow_api.id(37879491049469908482)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179751985115900947909)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879491956985908483)
,p_name=>'Open Candidatos'
,p_event_sequence=>678
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879151458477908308)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879492458337908483)
,p_event_id=>wwv_flow_api.id(37879491956985908483)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753221196003269282)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879492997207908483)
,p_event_id=>wwv_flow_api.id(37879491956985908483)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753221196003269282)
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879493409508908483)
,p_name=>'Open Avaliar_Candidatos'
,p_event_sequence=>688
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879151115291908308)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879493870845908483)
,p_event_id=>wwv_flow_api.id(37879493409508908483)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179676443925705538066)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879494332076908484)
,p_event_id=>wwv_flow_api.id(37879493409508908483)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179676443925705538066)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879494775355908484)
,p_name=>'Open Fases'
,p_event_sequence=>698
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879151843267908308)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879495287138908484)
,p_event_id=>wwv_flow_api.id(37879494775355908484)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753385274988129079)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879495785296908484)
,p_event_id=>wwv_flow_api.id(37879494775355908484)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753385274988129079)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879496188908908484)
,p_name=>'Open Tarefas'
,p_event_sequence=>708
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879194966242908333)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879496626338908484)
,p_event_id=>wwv_flow_api.id(37879496188908908484)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_TAREFA_REQ,P52_PESO_TAREFA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879497168173908484)
,p_event_id=>wwv_flow_api.id(37879496188908908484)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846458758377116093)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879373763072908435)
,p_name=>'Open Tarefas_1'
,p_event_sequence=>718
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879201128422908335)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879374292861908435)
,p_event_id=>wwv_flow_api.id(37879373763072908435)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_TAREFA_REQ,P52_PESO_TAREFA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879374818669908435)
,p_event_id=>wwv_flow_api.id(37879373763072908435)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846458758377116093)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879375152638908435)
,p_name=>'Open Caracteristicas'
,p_event_sequence=>728
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879198047323908334)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879375674531908436)
,p_event_id=>wwv_flow_api.id(37879375152638908435)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARAC_FUNC,P52_PESO_CARACTERISTICA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879376149993908436)
,p_event_id=>wwv_flow_api.id(37879375152638908435)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846460343554116109)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879376579011908436)
,p_name=>'Open Caracteristicas_1'
,p_event_sequence=>738
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879204319107908337)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879377074989908436)
,p_event_id=>wwv_flow_api.id(37879376579011908436)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARAC_FUNC,P52_PESO_CARACTERISTICA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879377532581908436)
,p_event_id=>wwv_flow_api.id(37879376579011908436)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846460343554116109)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879377926746908436)
,p_name=>'Open Idioma'
,p_event_sequence=>748
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879185295494908326)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879378478473908436)
,p_event_id=>wwv_flow_api.id(37879377926746908436)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_IDIOMA,P52_NIVEL_CONHECIMENTO_IDIOMA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879378944823908437)
,p_event_id=>wwv_flow_api.id(37879377926746908436)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179730261899348059513)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879379397904908437)
,p_name=>'Open Cargos'
,p_event_sequence=>758
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879191827937908331)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879379841381908437)
,p_event_id=>wwv_flow_api.id(37879379397904908437)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846373943795246808)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879380412291908437)
,p_event_id=>wwv_flow_api.id(37879379397904908437)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARGO_REQ,P52_ANOS_CARGO,P52_MESES_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879380783063908437)
,p_name=>'Open Colab. Inscritos'
,p_event_sequence=>768
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879218974775908346)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879381253081908437)
,p_event_id=>wwv_flow_api.id(37879380783063908437)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168080630852129356596)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879381734709908437)
,p_event_id=>wwv_flow_api.id(37879380783063908437)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_EMPRESA_COLAB,P52_MATRICULA_COLAB,P52_DT_INSCRICAO_COLAB'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879382252915908438)
,p_event_id=>wwv_flow_api.id(37879380783063908437)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_dt_inscricao_colab := sysdate;'
,p_attribute_03=>'P52_DT_INSCRICAO_COLAB'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879382651684908438)
,p_name=>'Open Cand. Inscritos'
,p_event_sequence=>778
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879222521715908347)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879383217234908438)
,p_event_id=>wwv_flow_api.id(37879382651684908438)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168153569419253188390)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879383666505908438)
,p_event_id=>wwv_flow_api.id(37879382651684908438)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CANDIDATO_CAND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879384100023908438)
,p_name=>'Close Cursos'
,p_event_sequence=>788
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879173851378908320)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879384586840908438)
,p_event_id=>wwv_flow_api.id(37879384100023908438)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846296708447365013)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879384927197908438)
,p_name=>'Close Cargos'
,p_event_sequence=>798
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879176968662908322)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879385462176908439)
,p_event_id=>wwv_flow_api.id(37879384927197908438)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846373943795246808)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879385856791908439)
,p_name=>'Close Tarefas'
,p_event_sequence=>808
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879179294014908323)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879386360984908439)
,p_event_id=>wwv_flow_api.id(37879385856791908439)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846458758377116093)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879386781384908439)
,p_name=>'Close Caracteristica'
,p_event_sequence=>818
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879181161220908323)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879387262711908439)
,p_event_id=>wwv_flow_api.id(37879386781384908439)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846460343554116109)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879387636377908439)
,p_name=>'Close Idioma'
,p_event_sequence=>828
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879145651794908304)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879388193207908440)
,p_event_id=>wwv_flow_api.id(37879387636377908439)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179730261899348059513)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879388601318908440)
,p_name=>'Create Curso'
,p_event_sequence=>838
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879173476810908320)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879389089728908440)
,p_event_id=>wwv_flow_api.id(37879388601318908440)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'begin',
'',
'insert into curso_req_pessoal (cod_req, nome, concluido, nivel, exige, seq) values (:p52_cod_req, :p52_desc_curso, :p52_concl_curso, :p52_nivel_curso, :p52_exige_curso, :p52_seq);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_DESC_CURSO,P52_CONCL_CURSO,P52_NIVEL_CURSO,P52_EXIGE_CURSO,P52_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879389625159908440)
,p_event_id=>wwv_flow_api.id(37879388601318908440)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846296708447365013)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879390068391908440)
,p_event_id=>wwv_flow_api.id(37879388601318908440)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359332526286691690)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879390475401908440)
,p_name=>'Create Cargo'
,p_event_sequence=>848
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879176577282908321)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879391018372908440)
,p_event_id=>wwv_flow_api.id(37879390475401908440)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cargo cargos.cod%type;',
'',
'begin',
'',
'v_cargo := nvl(nvl(:p52_cod_cargo_x,:p52_cod_cargo),:p52_cod_cargo_1);',
'',
'insert into rp_cargo values (:p52_cod_empresa,v_cargo,:p52_cod_cargo_req,:p52_anos_cargo,:p52_meses_cargo,:p_usuario,sysdate);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_CARGO_REQ,P_USUARIO,P52_ANOS_CARGO,P52_MESES_CARGO,P52_COD_CARGO,P52_COD_CARGO_1,P52_COD_CARGO_X'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879391474868908441)
,p_event_id=>wwv_flow_api.id(37879390475401908440)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879391971966908441)
,p_event_id=>wwv_flow_api.id(37879390475401908440)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846373943795246808)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879392351971908441)
,p_name=>'Create Tarefas'
,p_event_sequence=>858
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879178878847908322)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879392844829908441)
,p_event_id=>wwv_flow_api.id(37879392351971908441)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'if :p52_cod_req is null then',
'',
'    begin',
'',
'    insert into tar_peso_temp values (:p52_seq,:p52_cod_tarefa_req,:p52_peso_tarefa);',
'',
'    commit;',
'',
'    end;',
'',
'else',
'',
'    begin',
'',
'    insert into tar_peso (cod_req, cod_tarefa_req, cod_peso, usuario, dt_atualizacao) values (:p52_cod_req,:p52_cod_tarefa_req,:p52_peso_tarefa, :p_usuario, sysdate);',
'',
'    commit;',
'',
'    end;',
'',
'end if;'))
,p_attribute_02=>'P52_COD_PREST_SERV,P52_SEQ,P52_COD_TAREFA_REQ,P52_PESO_TAREFA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879393327000908441)
,p_event_id=>wwv_flow_api.id(37879392351971908441)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846458758377116093)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879393844995908441)
,p_event_id=>wwv_flow_api.id(37879392351971908441)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846295097317364996)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879394379053908442)
,p_event_id=>wwv_flow_api.id(37879392351971908441)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846375850352246827)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879394760481908442)
,p_name=>'Create Caracteristica'
,p_event_sequence=>868
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879180808055908323)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879395240328908442)
,p_event_id=>wwv_flow_api.id(37879394760481908442)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_req is null then',
'    begin',
'',
'    insert into carac_peso_temp values (:p52_seq,:p52_cod_carac_func,:p52_peso_caracteristica);',
'',
'    commit;',
'',
'    end;',
'',
'else',
'',
'    begin',
'    insert into carac_peso (cod_req, cod_carac_func, cod_peso, usuario, dt_atualizacao) values (:p52_cod_req,:p52_cod_carac_func,:p52_peso_caracteristica, :p_usuario, sysdate);',
'',
'    commit;',
'',
'    end;',
'',
'end if;'))
,p_attribute_02=>'P52_SEQ,P52_COD_CARAC_FUNC,P52_PESO_CARACTERISTICA'
,p_attribute_03=>'P52_COD_PREST_SERV'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879395817808908442)
,p_event_id=>wwv_flow_api.id(37879394760481908442)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846460343554116109)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879396226387908442)
,p_event_id=>wwv_flow_api.id(37879394760481908442)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846296012186365006)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879396743656908442)
,p_event_id=>wwv_flow_api.id(37879394760481908442)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846376624870246835)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879397131981908442)
,p_name=>'Create Idioma'
,p_event_sequence=>878
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879145274475908304)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879397660965908443)
,p_event_id=>wwv_flow_api.id(37879397131981908442)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_req is null then',
'    begin',
'',
'    insert into IDIOMA_REQ_PESSOAL (cod_req, cod_idioma, cod_nivel_conh, dt_atualizacao, usuario, seq) values (null,:p52_cod_idioma,:p52_nivel_conhecimento_idioma,sysdate,:p_usuario,:p52_seq);',
'    commit;',
'',
'    end;',
'',
'else',
'',
'    begin',
'',
'    insert into IDIOMA_REQ_PESSOAL (cod_req, cod_idioma, cod_nivel_conh, dt_atualizacao, usuario, seq) values (:p52_cod_req,:p52_cod_idioma,:p52_nivel_conhecimento_idioma,sysdate,:p_usuario,null);',
'    commit;',
'',
'    end;',
'',
'end if;'))
,p_attribute_02=>'P52_SEQ,P52_COD_REQ,P52_COD_IDIOMA,P52_NIVEL_CONHECIMENTO_IDIOMA,P_USUARIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879398134105908443)
,p_event_id=>wwv_flow_api.id(37879397131981908442)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179730261899348059513)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879398697114908443)
,p_event_id=>wwv_flow_api.id(37879397131981908442)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179729913498326141848)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879399102479908443)
,p_name=>'Refresh Regions'
,p_event_sequence=>888
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879399556042908443)
,p_event_id=>wwv_flow_api.id(37879399102479908443)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845172619887405836)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879400058202908443)
,p_event_id=>wwv_flow_api.id(37879399102479908443)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879400522548908444)
,p_name=>'Delete Cargo'
,p_event_sequence=>898
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CARGO_APAGAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879401008866908444)
,p_event_id=>wwv_flow_api.id(37879400522548908444)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'delete ',
'  from RP_CARGO ',
' where cod_empresa = :p52_cod_empresa ',
'   and cod_cargo = :p52_cod_cargo',
'   and cargo = :p52_cargo_apagar;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_CARGO_APAGAR,P52_COD_CARGO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879401451941908444)
,p_event_id=>wwv_flow_api.id(37879400522548908444)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879401882278908444)
,p_name=>unistr('Ap\00F3s Apagar Cargo')
,p_event_sequence=>908
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179845173045743405840)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879402415784908444)
,p_event_id=>wwv_flow_api.id(37879401882278908444)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845173045743405840)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879402815276908444)
,p_name=>unistr('Ap\00F3s Apagar Cursos')
,p_event_sequence=>918
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(170359332526286691690)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879403235772908445)
,p_event_id=>wwv_flow_api.id(37879402815276908444)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359332526286691690)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879403675936908445)
,p_name=>unistr('Ap\00F3s Apagar Forma\00E7\00E3o')
,p_event_sequence=>928
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179845172619887405836)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879404209092908445)
,p_event_id=>wwv_flow_api.id(37879403675936908445)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845172619887405836)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879404598538908445)
,p_name=>unistr('Ap\00F3s Apagar Experi\00EAncia')
,p_event_sequence=>938
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(170359333474776691700)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879405085889908445)
,p_event_id=>wwv_flow_api.id(37879404598538908445)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359333474776691700)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879405461995908445)
,p_name=>unistr('Ap\00F3s Apagar Conhecimento')
,p_event_sequence=>948
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(170360452221720838359)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879405970033908445)
,p_event_id=>wwv_flow_api.id(37879405461995908445)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360452221720838359)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879406382122908445)
,p_name=>unistr('Ap\00F3s Apagar Tarefas')
,p_event_sequence=>958
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179846295097317364996)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879406861489908446)
,p_event_id=>wwv_flow_api.id(37879406382122908445)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846295097317364996)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879407317887908446)
,p_name=>unistr('Ap\00F3s Apagar Caracteristicas')
,p_event_sequence=>968
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179846296012186365006)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879407805679908446)
,p_event_id=>wwv_flow_api.id(37879407317887908446)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846296012186365006)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879408149306908446)
,p_name=>unistr('Ap\00F3s Apagar Idioma')
,p_event_sequence=>978
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179729913498326141848)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879408717193908446)
,p_event_id=>wwv_flow_api.id(37879408149306908446)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179729913498326141848)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879409078614908446)
,p_name=>unistr('Ap\00F3s Apagar Beneficio')
,p_event_sequence=>988
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179895175297250494979)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879409616336908446)
,p_event_id=>wwv_flow_api.id(37879409078614908446)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179895175297250494979)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879409975553908447)
,p_name=>'Show Perfil'
,p_event_sequence=>998
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BOTOES_REQ_PESSOAL'
,p_condition_element=>'P52_BOTOES_REQ_PESSOAL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879411360030908447)
,p_name=>'(Pesquisa) Esconde Campos'
,p_event_sequence=>1008
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879411860242908447)
,p_event_id=>wwv_flow_api.id(37879411360030908447)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879412235459908447)
,p_name=>'Popula Especificacoes de Cargo'
,p_event_sequence=>1018
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO_X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879412792107908447)
,p_event_id=>wwv_flow_api.id(37879412235459908447)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_cargo cargos.cod%type;',
'',
'begin',
'',
'  IF :P52_ROWID IS NULL THEN',
'',
'    v_cargo := :P52_COD_CARGO_X;',
'',
'    FOR L1 IN (SELECT COD_CARGO, COD_CURSO',
'                 FROM CURSO_CARGO',
'                WHERE COD_EMPRESA = :P52_COD_EMPRESA',
'                  AND COD_CARGO = v_cargo',
'                  AND (COD_CCUSTO = :P52_COD_CCUSTO_X OR COD_CCUSTO IS NULL)',
'                  AND SYSDATE <= DT_VALIDADE_CURSO)',
'    LOOP',
'',
'    insert into rp_curso_cargo values (L1.cod_curso,v_cargo,:p_usuario,sysdate);',
'',
'    commit;',
'',
'    END LOOP;',
'',
'  END IF;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_CCUSTO_X,P_USUARIO,P52_COD_CARGO_X,P52_ROWID'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879413255136908448)
,p_event_id=>wwv_flow_api.id(37879412235459908447)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select desc_qualif_necessid exp_nec,',
'       desc_pos_estru pos_estr_org,',
'       desc_contr_rel rel_func',
'  from especificacao_cargo',
' where cod_cargo = :p52_cod_cargo_X;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'if :P52_ROWID is null then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_exp_nec := v_c1.exp_nec;',
':p52_pos_estr_org := v_c1.pos_estr_org;',
':p52_rel_func := v_c1.rel_func;',
'end if;',
'end;'))
,p_attribute_02=>'P52_ROWID ,P52_COD_CARGO_X,P52_EXP_NEC,P52_REL_FUNC,P52_POS_ESTR_ORG'
,p_attribute_03=>'P52_EXP_NEC,P52_REL_FUNC,P52_POS_ESTR_ORG'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879413821389908448)
,p_event_id=>wwv_flow_api.id(37879412235459908447)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select c.cod_cbo||''-''||c.dc_cbo||'': ''||b.descricao cbo,',
'       d.desc_obj_cargo,',
'       d.texto texto_resp,',
'       desc_qualif_necessid,',
'       desc_pos_estru,',
'       desc_contr_rel,',
'       desc_sup_exerc,',
'       desc_complexidade,',
'       desc_risc_amb_trab ',
'  from cargos c, descricao_cargo d, cbo b, especificacao_cargo e',
' where c.cod = d.cod_cargo (+)',
'   and c.cod = e.cod_cargo (+)',
'   and c.cod_cbo = b.cod_cbo (+)',
'   and c.dc_cbo = b.dc_cbo (+)',
'   and c.cod = :P52_COD_CARGO_X;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select anos_servico, meses_servico, cod_instrucao, sexo',
'  from PC_PARAMETRO',
' where cod_empresa = :p52_cod_empresa',
'   and cod_filial = :p52_cod_filial',
'   and cod_cargo = :P52_COD_CARGO_X;',
'',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'if 1 = 1 then',
'',
'       :p52_cbo := null;',
'       :p52_desc_obj_cargo := null;',
'       :p52_texto_resp := null;',
'       :p52_desc_qualif_necessid := null;',
'       :p52_desc_pos_estru := null;',
'       :p52_desc_contr_rel := null;',
'       :p52_desc_sup_exerc := null;',
'       :p52_desc_complexidade := null;',
'       :p52_desc_risc_amb_trab := null;',
'       --:p52_anos_servico := null; -- Comentado por Robson 23/06/2023',
'       --:p52_meses_servico := null; -- Comentado por Robson 23/06/2023',
'      -- :p52_cod_instrucao := null;',
'      -- :p52_sexo := null;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
'       :p52_cbo := v_c1.cbo;',
'       :p52_desc_obj_cargo := v_c1.desc_obj_cargo;',
'       :p52_texto_resp := v_c1.texto_resp;',
'       :p52_desc_qualif_necessid := v_c1.desc_qualif_necessid;',
'       :p52_desc_pos_estru := v_c1.desc_pos_estru;',
'       :p52_desc_contr_rel := v_c1.desc_contr_rel;',
'       :p52_desc_sup_exerc := v_c1.desc_sup_exerc;',
'       :p52_desc_complexidade := v_c1.desc_complexidade;',
'       :p52_desc_risc_amb_trab := v_c1.desc_risc_amb_trab;',
'       ',
'       --:p52_anos_servico := v_c2.anos_servico; -- Comentado por Robson 23/06/2023',
'       --:p52_meses_servico := v_c2.meses_servico; -- Comentado por Robson 23/06/2023',
'      -- :p52_cod_instrucao := v_c2.cod_instrucao;',
'     --  :p52_sexo := v_c2.sexo;',
'       ',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_CARGO_X'
,p_attribute_03=>'P52_CBO,P52_DESC_OBJ_CARGO,P52_TEXTO_RESP,P52_DESC_QUALIF_NECESSID,P52_DESC_POS_ESTRU,P52_DESC_CONTR_REL,P52_DESC_SUP_EXERC,P52_DESC_COMPLEXIDADE,P52_DESC_RISC_AMB_TRAB'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879414202198908448)
,p_name=>'Refresh Fase do Processo'
,p_event_sequence=>1028
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FASE_PS,P52_CANDIDATO_FASE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879414654281908448)
,p_event_id=>wwv_flow_api.id(37879414202198908448)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753385274988129079)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879415038521908451)
,p_name=>'Mask Salario'
,p_event_sequence=>1038
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_SALARIO'
,p_condition_element=>'P52_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879415601992908451)
,p_event_id=>wwv_flow_api.id(37879415038521908451)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Comentado por Robson 14/06/2023',
'declare',
'',
'v_rem number;',
'v_rem_mask varchar2(200);',
'',
'begin',
'',
'    v_rem := replace(replace(:P52_SALARIO,''R$''),''.'','','');',
'',
'    v_rem_mask :=  trim(to_char(v_rem,''99999990D90''));',
'',
'  :P52_SALARIO := v_rem_mask;',
'',
'end;',
'*/',
'null;'))
,p_attribute_02=>'P52_SALARIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879416029651908452)
,p_event_id=>wwv_flow_api.id(37879415038521908451)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'V_ITEM_VALIDACAO VARCHAR2(100) := :P52_ITEM_VALIDACAO;',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'',
'V_DT DATE;',
'',
'begin',
'',
'IF :P52_ROWID IS NULL THEN',
'V_DT := SYSDATE;',
'ELSE',
'V_DT := :P52_DT_REQ;',
'END IF;',
'',
'pkg_pessoal.Valida_Piso_Salario (:P52_SALARIO',
'                           ,:P52_COD_EMPRESA',
'                           ,:P52_COD_CARGO_X',
'                           ,:P52_COD_SINDICATO_X',
'                           ,:P52_RT_JORNADA_MENSAL_X',
'                           ,:P52_TIPO_SALARIO',
'                           ,V_DT',
'                           ,V_FLG',
'                           ,V_MSG);',
'--------------------------',
' if trim(v_msg) is not null then',
'    if v_flg = ''N'' then',
'        :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_SALARIO''));',
'        :p52_ok       := ''N'';',
'        :P52_ITEM_VALIDACAO_SAL := TRIM(UPPER(''P52_SALARIO''));',
'    else',
'        if v_item_validacao = TRIM(UPPER(''P52_SALARIO'')) OR v_item_validacao IS NULL then',
'           :P52_OK := ''S'';',
'           :P52_ITEM_VALIDACAO := null;',
'           :P52_ITEM_VALIDACAO_SAL := null;',
'        else',
'           :P52_ITEM_VALIDACAO := v_item_validacao;',
'           :P52_ITEM_VALIDACAO_SAL := null;',
'        end if;',
'    end if;',
'    :p52_flag     := v_flg;',
'    :p52_mensagem := v_msg;',
'    ',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    :P52_ITEM_VALIDACAO_SAL := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_SALARIO'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_ROWID,P52_DT_REQ,P52_SALARIO,P52_COD_CARGO_X,P52_COD_SINDICATO_X,P52_COD_EMPRESA,P52_RT_JORNADA_MENSAL_X,P52_ITEM_VALIDACAO_SAL,P52_TIPO_SALARIO'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM,P52_ITEM_VALIDACAO_SAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879416484908908452)
,p_name=>'Show Tipo_Registro'
,p_event_sequence=>1048
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MARCA_PONTO'
,p_condition_element=>'P52_MARCA_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879417010297908452)
,p_event_id=>wwv_flow_api.id(37879416484908908452)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TIPO_PONTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879417470104908452)
,p_event_id=>wwv_flow_api.id(37879416484908908452)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TIPO_PONTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879417948803908452)
,p_event_id=>wwv_flow_api.id(37879416484908908452)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TIPO_PONTO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879418359152908452)
,p_name=>unistr('(Refeit\00F3rio) Limpa campos valores')
,p_event_sequence=>1058
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REFEITORIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879418924070908453)
,p_event_id=>wwv_flow_api.id(37879418359152908452)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TOTAL_SALARIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO,P52_PERC_BENEFICIO,P52_MOTIVO_EXCECAO,P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879419293131908453)
,p_name=>'create_Beneficio'
,p_event_sequence=>1068
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879171489084908317)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879419743942908453)
,p_event_id=>wwv_flow_api.id(37879419293131908453)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_benef number := replace(replace(:p52_valor_benef,''R$''),''.'');',
'',
'begin',
'',
'insert into beneficios_vaga_temp (seq, cod_requisicao, cod_empresa, cod_filial, cod_beneficio, valor)',
'values',
'(:p52_seq, :P52_COD_REQ, :p52_cod_empresa, :p52_cod_filial, :p52_beneficio_vaga, v_valor_benef);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_SEQ,P52_COD_EMPRESA,P52_COD_FILIAL,P52_BENEFICIO_VAGA,P52_VALOR_BENEF,P52_COD_REQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879420253131908453)
,p_event_id=>wwv_flow_api.id(37879419293131908453)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179778299604877536966)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879420783373908453)
,p_event_id=>wwv_flow_api.id(37879419293131908453)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_BENEFICIO_VAGA,P52_VALOR_BENEF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879421250560908453)
,p_event_id=>wwv_flow_api.id(37879419293131908453)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179895175297250494979)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879421648892908454)
,p_name=>'create_conhecimento'
,p_event_sequence=>1078
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879137946018908301)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879422126623908454)
,p_event_id=>wwv_flow_api.id(37879421648892908454)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'insert into conhecimento_req_pessoal (cod_req, nome, nivel, exige, seq)',
'values',
'(:p52_cod_req, :p52_desc_conhecimento, :p52_nivel_conhecimento, :p52_exige_experiencia, :p52_seq);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_DESC_CONHECIMENTO,P52_NIVEL_CONHECIMENTO,P52_EXIGE_EXPERIENCIA,P52_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879422685784908454)
,p_event_id=>wwv_flow_api.id(37879421648892908454)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360454808935838385)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879423168321908456)
,p_event_id=>wwv_flow_api.id(37879421648892908454)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360452221720838359)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879423547849908456)
,p_name=>'create_colab_inscrito'
,p_event_sequence=>1088
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879130337214908294)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879424062610908456)
,p_event_id=>wwv_flow_api.id(37879423547849908456)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cargo',
'  from informacoes_funcionais i',
' where i.cod_empresa = :p52_cod_empresa_colab',
'   and i.matricula = :p52_matricula_colab;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'insert into RP_FUNC_INSCRITOS (cod_req, cod_empresa, matricula, dt_inscricao, cod_cargo, usuario, dt_atualizacao)',
'values',
'(:p52_cod_req, :p52_cod_empresa_colab, :p52_matricula_colab, :p52_dt_inscricao_colab, v_c1.cargo, :p_usuario, sysdate);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_COD_EMPRESA_COLAB,P52_MATRICULA_COLAB,P52_DT_INSCRICAO_COLAB,P_USUARIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879424612433908456)
,p_event_id=>wwv_flow_api.id(37879423547849908456)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168080630852129356596)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879425105137908457)
,p_event_id=>wwv_flow_api.id(37879423547849908456)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168080629306856356580)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879425492500908457)
,p_name=>'create_cand_inscrito'
,p_event_sequence=>1098
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879132299418908295)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879425957252908457)
,p_event_id=>wwv_flow_api.id(37879425492500908457)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_empresa',
'  from inf_func_candidato',
' where cod_candidato = :p52_candidato_cand;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'insert into RP_CAND_INSCRITOS (cod_req, cod_empresa, cod_candidato, cod_cargo, usuario, dt_atualizacao)',
'values',
'(:p52_cod_req, v_c1.cod_empresa, :p52_candidato_cand, :p52_cod_cargo_x, :p_usuario, sysdate);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_CANDIDATO_CAND,P52_COD_CARGO_X,P_USUARIO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879426498066908457)
,p_event_id=>wwv_flow_api.id(37879425492500908457)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168153569419253188390)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879426990173908457)
,p_event_id=>wwv_flow_api.id(37879425492500908457)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168153567268194188368)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879427423745908457)
,p_name=>'create_Experiencia'
,p_event_sequence=>1108
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879135698064908299)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879427836897908458)
,p_event_id=>wwv_flow_api.id(37879427423745908457)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'insert into experiencia_req_pessoal (cod_req, nome, anos, meses, exige, seq)',
'values',
'(:p52_cod_req, :p52_desc_experiencia, :p52_anos_experiencia, :p52_meses_experiencia, :p52_exige_experiencia, :p52_seq);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_DESC_EXPERIENCIA,P52_ANOS_EXPERIENCIA,P52_MESES_EXPERIENCIA,P52_EXIGE_EXPERIENCIA,P52_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879428334015908458)
,p_event_id=>wwv_flow_api.id(37879427423745908457)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360454139014838378)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879428862894908458)
,p_event_id=>wwv_flow_api.id(37879427423745908457)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359333474776691700)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879429257388908458)
,p_name=>unistr('create_Forma\00E7\00E3o')
,p_event_sequence=>1118
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879133386348908295)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879429727432908458)
,p_event_id=>wwv_flow_api.id(37879429257388908458)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'insert into formacao_req_pessoal (cod_req, nome, cod_instrucao, concluida, exige, seq)',
'values',
'(:p52_cod_req, :p52_desc_formacao, :p52_instr_formacao, :p52_concl_formacao, :p52_exige_formacao, :p52_seq);',
'',
'commit;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_DESC_FORMACAO,P52_INSTR_FORMACAO,P52_CONCL_FORMACAO,P52_EXIGE_FORMACAO,P52_SEQ'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879430281448908458)
,p_event_id=>wwv_flow_api.id(37879429257388908458)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170360453166451838369)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879430816083908459)
,p_event_id=>wwv_flow_api.id(37879429257388908458)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179845172619887405836)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879431172347908459)
,p_name=>'open_beneficios'
,p_event_sequence=>1128
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879214318441908344)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879431649099908459)
,p_event_id=>wwv_flow_api.id(37879431172347908459)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_BENEFICIO_VAGA,P52_VALOR_BENEF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879432185257908459)
,p_event_id=>wwv_flow_api.id(37879431172347908459)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179778299604877536966)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879432579441908459)
,p_name=>'Popula Valor'
,p_event_sequence=>1138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BENEFICIO_VAGA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879433059486908459)
,p_event_id=>wwv_flow_api.id(37879432579441908459)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select valor_padrao valor',
'  into :p52_valor_benef',
'from   beneficios',
'where cod_beneficio = :p52_beneficio_vaga;',
'exception',
'when others then',
' :p52_valor_benef := null;',
'end;'))
,p_attribute_02=>'P52_BENEFICIO_VAGA'
,p_attribute_03=>'P52_VALOR_BENEF'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879433525825908459)
,p_event_id=>wwv_flow_api.id(37879432579441908459)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item("P52_VALOR_BENEF").disable();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879434875578908460)
,p_name=>'Mask Vlr Fat.'
,p_event_sequence=>1158
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879435385432908460)
,p_event_id=>wwv_flow_api.id(37879434875578908460)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(replace(:p52_valor_faturavel,''R$''),''.'');',
'',
'begin',
'',
':p52_valor_faturavel := trim(to_char(v_sal,''99999990D00''));',
'',
'end;'))
,p_attribute_02=>'P52_VALOR_FATURAVEL'
,p_attribute_03=>'P52_VALOR_FATURAVEL'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879435742351908460)
,p_name=>'Mask Vlr Benef'
,p_event_sequence=>1168
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_BENEF'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879436283616908460)
,p_event_id=>wwv_flow_api.id(37879435742351908460)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sal number := replace(replace(:p52_valor_benef,''R$''),''.'');',
'',
'begin',
'',
':p52_valor_benef := trim(to_char(v_sal,''999G999G999G999G990D00''));',
'',
'end;'))
,p_attribute_02=>'P52_VALOR_BENEF'
,p_attribute_03=>'P52_VALOR_BENEF'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879436625952908460)
,p_name=>'Popula COD_FUNCAO'
,p_event_sequence=>1178
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FUNCAO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879437160604908461)
,p_event_id=>wwv_flow_api.id(37879436625952908460)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_funcao_1 := :p52_cod_funcao_x;'
,p_attribute_02=>'P52_COD_FUNCAO_X'
,p_attribute_03=>'P52_COD_FUNCAO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879437557618908461)
,p_name=>'Popula COD_CATEGORIA'
,p_event_sequence=>1188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CATEGORIA_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879438035403908461)
,p_event_id=>wwv_flow_api.id(37879437557618908461)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_categoria_1 := :p52_cod_categoria_x;'
,p_attribute_02=>'P52_COD_CATEGORIA_X'
,p_attribute_03=>'P52_COD_CATEGORIA_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879438519170908462)
,p_name=>'Popula RT_JORNADA_MENSAL'
,p_event_sequence=>1198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879438937314908462)
,p_event_id=>wwv_flow_api.id(37879438519170908462)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_RT_JORNADA_MENSAL_1 := :P52_RT_JORNADA_MENSAL_X;'
,p_attribute_02=>'P52_RT_JORNADA_MENSAL_X'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879439355558908462)
,p_name=>'Popula COD_HORARIO'
,p_event_sequence=>1208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879439834204908462)
,p_event_id=>wwv_flow_api.id(37879439355558908462)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_horario_1 := nvl(:p52_cod_horario_x,:P52_COD_HORARIO_1);'
,p_attribute_02=>'P52_COD_HORARIO_X,P52_COD_HORARIO_1'
,p_attribute_03=>'P52_COD_HORARIO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879440251043908462)
,p_name=>'Popula COD_UNIDADE_ADM'
,p_event_sequence=>1218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879440774768908462)
,p_event_id=>wwv_flow_api.id(37879440251043908462)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_cod_unidade_adm_1 := :p52_cod_unidade_adm_x;',
''))
,p_attribute_02=>'P52_COD_UNIDADE_ADM_X'
,p_attribute_03=>'P52_COD_UNIDADE_ADM_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879441217602908462)
,p_name=>'(S/ Vaga) Popula COD_UNIDADE_ADM'
,p_event_sequence=>1228
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879441655997908463)
,p_event_id=>wwv_flow_api.id(37879441217602908462)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_cod_unidade_adm := :p52_cod_unidade_adm_x;',
''))
,p_attribute_02=>'P52_COD_UNIDADE_ADM_X'
,p_attribute_03=>'P52_COD_UNIDADE_ADM'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879442101635908463)
,p_name=>'Popula COD_ATIVIDADE_1'
,p_event_sequence=>1238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_ATIVIDADE_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879442582140908463)
,p_event_id=>wwv_flow_api.id(37879442101635908463)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_atividade_1 := :p52_cod_atividade_x;'
,p_attribute_02=>'P52_COD_ATIVIDADE_X'
,p_attribute_03=>'P52_COD_ATIVIDADE_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879442943939908463)
,p_name=>'Popula VINCULO_1'
,p_event_sequence=>1248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879443467025908463)
,p_event_id=>wwv_flow_api.id(37879442943939908463)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_VINCULO_1 := :p52_VINCULO_x;'
,p_attribute_02=>'P52_VINCULO_X'
,p_attribute_03=>'P52_VINCULO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879443886363908463)
,p_name=>'Popula COD_SINDICATO_1'
,p_event_sequence=>1258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879444353711908464)
,p_event_id=>wwv_flow_api.id(37879443886363908463)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_COD_SINDICATO_1 := :p52_COD_SINDICATO_x;',
''))
,p_attribute_02=>'P52_COD_SINDICATO_X'
,p_attribute_03=>'P52_COD_SINDICATO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879444823926908464)
,p_name=>'Popula COD_LOCAL_TRAB'
,p_event_sequence=>1268
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879445290076908464)
,p_event_id=>wwv_flow_api.id(37879444823926908464)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_LOCAL_TRAB_1 := :P52_COD_LOCAL_TRAB_X;'
,p_attribute_02=>'P52_COD_LOCAL_TRAB_X'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879445641463908464)
,p_name=>'(S/ Vaga) Popula COD_ATIVIDADE'
,p_event_sequence=>1278
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_ATIVIDADE_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879446127084908464)
,p_event_id=>wwv_flow_api.id(37879445641463908464)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_atividade := :p52_cod_atividade_x;'
,p_attribute_02=>'P52_COD_ATIVIDADE_X'
,p_attribute_03=>'P52_COD_ATIVIDADE'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879446613733908464)
,p_name=>'(S/ Vaga) Popula VINCULO_1'
,p_event_sequence=>1288
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879447055447908464)
,p_event_id=>wwv_flow_api.id(37879446613733908464)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_VINCULO := nvl(:p52_VINCULO_x,:P52_VINCULO);'
,p_attribute_02=>'P52_VINCULO_X,P52_VINCULO'
,p_attribute_03=>'P52_VINCULO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879447454155908465)
,p_name=>'(S/ Vaga) Popula COD_SINDICATO_1'
,p_event_sequence=>1298
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879447968429908465)
,p_event_id=>wwv_flow_api.id(37879447454155908465)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
':p52_COD_SINDICATO := nvl(:p52_COD_SINDICATO_x,:p52_COD_SINDICATO);',
'',
'if :P52_COD_SINDICATO_X is null and :P52_ROWID is not null then',
':p52_flag := ''N''; ',
unistr(':p52_mensagem := ''O campo Sindicato n\00E3o pode ser nulo!'';'),
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_SINDICATO_X,P52_COD_SINDICATO,P52_ROWID'
,p_attribute_03=>'P52_COD_SINDICATO,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879448420720908465)
,p_name=>'(S/ Vaga) Popula COD_LOCAL_TRAB'
,p_event_sequence=>1308
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879448844268908465)
,p_event_id=>wwv_flow_api.id(37879448420720908465)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_COD_LOCAL_TRAB := :p52_COD_LOCAL_TRAB_x;'
,p_attribute_02=>'P52_COD_LOCAL_TRAB_X'
,p_attribute_03=>'P52_COD_LOCAL_TRAB'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879449323497908465)
,p_name=>'Popula COD_CCUSTO_X'
,p_event_sequence=>1318
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879449807759908465)
,p_event_id=>wwv_flow_api.id(37879449323497908465)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CCUSTO_X := :P52_COD_CCUSTO;'
,p_attribute_02=>'P52_COD_CCUSTO'
,p_attribute_03=>'P52_COD_CCUSTO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879450201352908465)
,p_name=>'Popula COD_UNIDADE_ADM_X'
,p_event_sequence=>1328
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879450724975908466)
,p_event_id=>wwv_flow_api.id(37879450201352908465)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_UNIDADE_ADM is not null then',
':P52_COD_UNIDADE_ADM_X := :P52_COD_UNIDADE_ADM;',
'end if;'))
,p_attribute_02=>'P52_COD_UNIDADE_ADM'
,p_attribute_03=>'P52_COD_UNIDADE_ADM_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879451055759908466)
,p_name=>'Popula COD_ATIVIDADE_X'
,p_event_sequence=>1338
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_ATIVIDADE'
,p_condition_element=>'P52_COD_ATIVIDADE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879451569390908466)
,p_event_id=>wwv_flow_api.id(37879451055759908466)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_ATIVIDADE is not null and :P52_COD_VAGA is null then',
':P52_COD_ATIVIDADE_X := :P52_COD_ATIVIDADE;',
'end if;'))
,p_attribute_02=>'P52_COD_ATIVIDADE,P52_COD_VAGA'
,p_attribute_03=>'P52_COD_ATIVIDADE_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879452020546908466)
,p_name=>'Popula COD_LOCAL_TRAB_X'
,p_event_sequence=>1348
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ in (0,1) THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879452494804908466)
,p_event_id=>wwv_flow_api.id(37879452020546908466)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_LOCAL_TRAB_X := :P52_COD_LOCAL_TRAB;'
,p_attribute_02=>'P52_COD_LOCAL_TRAB'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879497593866908484)
,p_name=>'(1) Popula VINCULO_X'
,p_event_sequence=>1358
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879498105814908485)
,p_event_id=>wwv_flow_api.id(37879497593866908484)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_VINCULO_X := :P52_VINCULO;'
,p_attribute_02=>'P52_VINCULO'
,p_attribute_03=>'P52_VINCULO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879498428524908485)
,p_name=>'Popula COD_UN_NEGOCIO_X'
,p_event_sequence=>1368
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UN_NEGOCIO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879498929853908485)
,p_event_id=>wwv_flow_api.id(37879498428524908485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_UN_NEGOCIO_X := :P52_COD_UN_NEGOCIO;'
,p_attribute_02=>'P52_COD_UN_NEGOCIO'
,p_attribute_03=>'P52_COD_UN_NEGOCIO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879499333465908485)
,p_name=>'Popula COD_CARGO_X'
,p_event_sequence=>1378
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879499840202908485)
,p_event_id=>wwv_flow_api.id(37879499333465908485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CARGO_X := :P52_COD_CARGO;'
,p_attribute_02=>'P52_COD_CARGO'
,p_attribute_03=>'P52_COD_CARGO_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879500285101908485)
,p_name=>'Popula COD_FUNCAO_X'
,p_event_sequence=>1388
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FUNCAO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879500801016908485)
,p_event_id=>wwv_flow_api.id(37879500285101908485)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_FUNCAO_X := :P52_COD_FUNCAO;'
,p_attribute_02=>'P52_COD_FUNCAO'
,p_attribute_03=>'P52_COD_FUNCAO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879501134654908486)
,p_name=>'Popula COD_CATEGORIA_X'
,p_event_sequence=>1398
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CATEGORIA'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879501654320908486)
,p_event_id=>wwv_flow_api.id(37879501134654908486)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_CATEGORIA_X := :P52_COD_CATEGORIA;'
,p_attribute_02=>'P52_COD_CATEGORIA'
,p_attribute_03=>'P52_COD_CATEGORIA_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879502065263908486)
,p_name=>'(1) Popula COD_SINDICATO_X'
,p_event_sequence=>1408
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879502531327908486)
,p_event_id=>wwv_flow_api.id(37879502065263908486)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_SINDICATO_X := :P52_COD_SINDICATO;'
,p_attribute_02=>'P52_COD_SINDICATO'
,p_attribute_03=>'P52_COD_SINDICATO_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879502932815908486)
,p_name=>'Popula RT_JORNADA_MENSAL_X'
,p_event_sequence=>1418
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879503483105908486)
,p_event_id=>wwv_flow_api.id(37879502932815908486)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_RT_JORNADA_MENSAL_X := :P52_RT_JORNADA_MENSAL;'
,p_attribute_02=>'P52_RT_JORNADA_MENSAL'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879503848228908486)
,p_name=>'Popula COD_HORARIO_X'
,p_event_sequence=>1428
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879504354728908487)
,p_event_id=>wwv_flow_api.id(37879503848228908486)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_HORARIO_X := :P52_COD_HORARIO;'
,p_attribute_02=>'P52_COD_HORARIO'
,p_attribute_03=>'P52_COD_HORARIO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879504777212908487)
,p_name=>'adicionar_nota'
,p_event_sequence=>1438
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879139924640908302)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879505261461908487)
,p_event_id=>wwv_flow_api.id(37879504777212908487)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
' select distinct s.cod_req, ',
'        p.cod_processo, ',
'        p.cod_fase,',
'        p.nota_de_corte, ',
'        p.dt_inicio_fase, ',
'        p.dt_fim_fase, ',
'        decode(p.status,''A'',''Ativo'',''F'',''Finalizado'',''C'',''Cancelado'') Status, ',
'        e.cod_entidade||'' - ''||initcap(e.nome_entidade) entidade, ',
'        p.sla, ',
'        p.observacao,',
'        c.cod_empresa,',
'        c.cod_candidato,',
'        c.ind_aval_fase nota,',
'        c.date_fase data_fase_candidato',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c, PS_FASE_PADRAO_CARGO r',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'    and p.cod_fase = r.cod_fase',
'    and trunc(sysdate) between nvl(p.dt_inicio_fase,trunc(sysdate)) and nvl(p.dt_fim_fase,trunc(sysdate))',
'    and r.ind_responsavel in (''G'',''A'');',
'    ',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'select cod_candidato,',
'       ind_aval_fase, ',
'       date_fase, ',
'       cod_prest_serv_avaliador',
'  from candidato',
' where cod_req = :p52_cod_req',
'   and cod_candidato = :p52_candidato',
'   and cod_fase in (select x.cod_fase ',
'                      from PS_FASE_PADRAO_CARGO x ',
'                     where x.ind_responsavel in (''G'',''A''));',
'',
'v_c1 c1%rowtype;',
'',
'v_flg_retorno varchar2(1);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p52_resultado_fase is not null then',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_candidato is null then',
'',
'begin',
'insert into candidato (cod_empresa, cod_candidato, cod_fase, date_fase, cod_prest_serv_avaliador, usuario, dt_atualizacao, ind_aval_fase, cod_req, cod_processo, cod_emp_cand, check_aprov, resultado_fase, data_aval_fase)',
'               values (:p52_cod_empresa, :p52_candidato,v_c0.cod_fase, sysdate, :P_MATRICULA_USER, :P_USUARIO, SYSDATE, :P52_NOTA_CANDIDATO, :P52_COD_REQ, V_C0.COD_PROCESSO, :p52_COD_EMPRESA, nvl(:P52_APROVADO,''N''), :p52_resultado_fase, sysdate);',
'',
'end;',
'',
'',
'else ',
'',
'    begin',
'    update candidato',
'       set ind_aval_fase = :p52_nota_candidato, ',
'           check_aprov = nvl(:P52_APROVADO,''N''),',
'           date_fase = sysdate, ',
'           cod_prest_serv_avaliador = :P_MATRICULA_USER,',
'           usuario = :p_usuario,',
'           dt_atualizacao = sysdate,',
'           resultado_fase = :p52_resultado_fase,',
'           data_aval_fase = sysdate',
'     where cod_req = :p52_cod_req',
'       and cod_candidato = :p52_candidato',
'       and cod_fase in (select x.cod_fase ',
'                          from PS_FASE_PADRAO_CARGO x ',
'                         where x.ind_responsavel in (''G'',''A''));',
'',
'    commit;',
'',
'    end;',
'',
'end if;',
'',
'commit;',
'',
'    :p52_flag := ''S'';',
'    :p52_mensagem := null;',
'',
'else',
'',
'    :p52_flag := ''N'';',
unistr('    :p52_mensagem := ''Informe mais detalhes em Observa\00E7\00E3o!'';'),
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_FASE_PS,P52_CANDIDATO,P52_NOTA_CANDIDATO,P52_COD_EMPRESA,P52_APROVADO,P_MATRICULA_USER,P_USUARIO,P52_RESULTADO_FASE'
,p_attribute_03=>'P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879505723377908487)
,p_name=>'Refresh Candidatos'
,p_event_sequence=>1448
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879139924640908302)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879506212625908487)
,p_event_id=>wwv_flow_api.id(37879505723377908487)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179676713129508140528)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879506547452908488)
,p_name=>'Clear Avaliar Candidatos'
,p_event_sequence=>1458
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CANDIDATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879507065548908488)
,p_event_id=>wwv_flow_api.id(37879506547452908488)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOTA_CANDIDATO,P52_APROVADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879507560292908488)
,p_event_id=>wwv_flow_api.id(37879506547452908488)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c0 is',
' select distinct s.cod_req, ',
'        p.cod_processo, ',
'        p.cod_fase,',
'        p.nota_de_corte, ',
'        p.dt_inicio_fase, ',
'        p.dt_fim_fase, ',
'        decode(p.status,''A'',''Ativo'',''F'',''Finalizado'',''C'',''Cancelado'') Status, ',
'        e.cod_entidade||'' - ''||initcap(e.nome_entidade) entidade, ',
'        p.sla, ',
'        p.observacao,',
'        c.cod_empresa,',
'        c.cod_candidato,',
'        c.ind_aval_fase nota,',
'        c.date_fase data_fase_candidato',
'   from PS_PROCESSO_FASE p, ps_processo_seletivo s, fase_candidato f, entidade e, candidato c, PS_FASE_PADRAO_CARGO r',
'  where p.cod_processo = s.cod_processo ',
'    and p.cod_processo = c.cod_processo (+)',
'    and p.cod_fase = f.cod_fase (+)',
'    and p.cod_fase = c.cod_fase (+)',
'    and p.COD_ENTIDADE = e.cod_entidade (+)',
'    and p.tipo_entidade = ''5''',
'    and s.cod_req = :p52_cod_req',
'    and p.cod_fase = nvl(:p52_fase_ps,p.cod_fase)',
'    and p.cod_fase = r.cod_fase',
'    and trunc(sysdate) between nvl(p.dt_inicio_fase,trunc(sysdate)) and nvl(p.dt_fim_fase,trunc(sysdate))',
'    and r.ind_responsavel in (''G'',''A'');',
'    ',
'v_c0 c0%rowtype;',
'',
'cursor c1 is',
'select cod_candidato,',
'       ind_aval_fase, ',
'       date_fase, ',
'       cod_prest_serv_avaliador,',
'       check_aprov,',
'       resultado_fase',
'  from candidato',
' where cod_req = :p52_cod_req',
'   and cod_candidato = :p52_candidato',
'   and cod_fase in (select x.cod_fase ',
'                      from PS_FASE_PADRAO_CARGO x ',
'                     where x.ind_responsavel in (''G'',''A''));',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c0;',
'fetch c0 into v_c0;',
'close c0;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_nota_corte := v_c0.nota_de_corte;',
'',
'if v_c1.cod_candidato is not null then',
'',
' :p52_nota_candidato := v_c1.ind_aval_fase;',
' :p52_aprovado := v_c1.check_aprov;',
' :p52_resultado_fase := v_c1.resultado_fase;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_FASE_PS,P52_CANDIDATO'
,p_attribute_03=>'P52_NOTA_CORTE,P52_NOTA_CANDIDATO,P52_APROVADO,P52_RESULTADO_FASE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879508022671908488)
,p_name=>'Seta Aprovado'
,p_event_sequence=>1468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_NOTA_CANDIDATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879508474729908488)
,p_event_id=>wwv_flow_api.id(37879508022671908488)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_nota_candidato number := :p52_nota_candidato;',
'v_nota_corte number := :p52_nota_corte;',
'',
'begin',
'',
'if v_nota_candidato >= v_nota_corte then',
':p52_aprovado := ''S'';',
'else',
':p52_aprovado := ''N'';',
'end if; ',
'',
'end;'))
,p_attribute_02=>'P52_NOTA_CANDIDATO,P52_NOTA_CORTE'
,p_attribute_03=>'P52_APROVADO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879508923518908488)
,p_name=>'Refresh Acompanhamento Candidato'
,p_event_sequence=>1478
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FASE_CAND,P52_CANDIDATO_ACMP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879509400253908489)
,p_event_id=>wwv_flow_api.id(37879508923518908488)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179753221196003269282)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879509809429908489)
,p_name=>unistr('Show / Hide Aprova\00E7\00F5es')
,p_event_sequence=>1488
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SIT_REQ'
,p_condition_element=>'P52_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879510264305908489)
,p_event_id=>wwv_flow_api.id(37879509809429908489)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879510812603908489)
,p_event_id=>wwv_flow_api.id(37879509809429908489)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879511288520908489)
,p_event_id=>wwv_flow_api.id(37879509809429908489)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879511804109908489)
,p_event_id=>wwv_flow_api.id(37879509809429908489)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879512129368908489)
,p_name=>'(Hide/Show) DT_PREV_FIM_CONTRATO'
,p_event_sequence=>1498
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_CONTRATO'
,p_condition_element=>'P52_TIPO_CONTRATO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879512696779908489)
,p_event_id=>wwv_flow_api.id(37879512129368908489)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879513164294908490)
,p_event_id=>wwv_flow_api.id(37879512129368908489)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879513577384908490)
,p_name=>'Dispara Alerta Aprov'
,p_event_sequence=>1508
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MENSAGEM_APROV'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879514070878908490)
,p_event_id=>wwv_flow_api.id(37879513577384908490)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P52_FLAG_APROV'').value == "N") {',
'',
'    if ($x(''P52_MENSAGEM_APROV'').value.length  > 0 ) {',
'        ',
'        if ($x(''P52_FLAG_APROV'').value == "N") {',
'            $x(''P52_OK_APROV'').value = ''N'';',
'        } else {',
'            $x(''P52_OK_APROV'').value = ''S'';',
'        }',
'            ',
'        alert($v(''P52_MENSAGEM_APROV''));',
'    }else{',
'            $x(''P52_OK_APROV'').value = ''S'';',
'    }',
'        ',
'}else{',
'    ',
'    if ($x(''P52_MENSAGEM_APROV'').value.length > 0 ) {',
'        toastr.success($v(''P52_MENSAGEM_APROV''));',
'        apex.submit("SUBMIT");',
'    }',
'',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879514504083908490)
,p_name=>'Save1'
,p_event_sequence=>1518
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879126659197908291)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879517945537908492)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel NUMBER := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'--v_remuneracao_variavel NUMBER := :p52_remuneracao_variavel;',
'',
'begin',
'/*',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'*/',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    null,',
'                                   :P52_RT_JORNADA_MENSAL,',
'                                    :p52_cod_horario_x);',
'',
'if v_remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Valor de benef\00EDcios R$''||:p52_remuneracao_variavel||'' n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and v_remuneracao_variavel <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and :P52_PERC_BENEF_EXCECAO is null then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio;'),
'end if;',
'',
'',
'if nvl(v_valor_beneficio,0) > 0 and ',
'   nvl(v_remuneracao_variavel,0) <> nvl(v_valor_beneficio,0) and ',
'   :P52_PERC_BENEFICIO_VARIAVEL is null and ',
'   :P52_PERC_BENEF_EXCECAO is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Para Full-CLT, o valor de Remunera\00E7\00E3o Vari\00E1vel (R$''||:p52_remuneracao_variavel||'') n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio||'),
unistr('     case when :p52_rowid is not null then ''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'' else ''.'' end;'),
'   --  ||'' v_valor_beneficio: ''||v_valor_beneficio||'', v_remuneracao_variavel: ''||v_remuneracao_variavel||'', P52_PERC_BENEFICIO_VARIAVEL: ''||:P52_PERC_BENEFICIO_VARIAVEL||'', P52_PERC_BENEF_EXCECAO: ''||:P52_PERC_BENEF_EXCECAO||'', P52_RT_JORNADA_MENSAL'
||': ''||:P52_RT_JORNADA_MENSAL ;',
'end if;',
'',
'',
unistr('/*AGUARDAR APROVA\00C7\00C3O DA STEFANINI'),
'if v_msg_retorno is not null and :p52_rowid is not null then',
unistr('v_msg_retorno := v_msg_retorno||''.<br>Clique em Ajustar Valores no bloco de Remunera\00E7\00E3o e informe o valor correto.'';'),
'end if;',
'*/',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_REMUNERACAO_VARIAVEL,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_VINCULO_X,P52_PERC_BENEFICIO_VARIAVEL,P'
||'52_PERC_BENEF_EXCECAO,P52_ROWID,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9633250523506431561)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn      VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P52_VALSIND := NULL;',
'  --',
'  IF NVL(:P52_FLAG_TEMPORARIO, :P52_FLAGAUX) = ''S'' THEN',
'    IF NVL(:P52_COD_EMPRESA, :P52_EMPAUX) IS NOT NULL AND :P52_COD_SINDICATO IS NOT NULL THEN',
'      vReturn := Pkg_Pessoal.fnc_ValidaElegibSind(pEmpresa   => NVL(:P52_COD_EMPRESA, :P52_EMPAUX)',
'                                                 ,psindicato => :P52_COD_SINDICATO',
'                                                 ,pFilial    => NVL(:P52_COD_FILIAL, :P52_FILAUX)',
'                                                 ,pCCusto    => :P52_COD_CCUSTO',
'                                                 ,pUnidAdm   => :P52_COD_UNIDADE_ADM',
'                                                 ,pAtividade => :P52_COD_ATIVIDADE',
'                                                 ,pLocalTrab => :P52_COD_LOCAL_TRAB',
'                                                 ,pValSindSN => ''S'');',
'    END IF;',
'  END IF;',
'  --',
'  IF vReturn IS NOT NULL THEN',
'    :P52_VALSIND := vReturn;',
'  END IF;',
'END;',
''))
,p_attribute_02=>'P52_EMPAUX,P52_FILAUX,P52_FLAGAUX,P52_COD_SINDICATO,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB,P52_FLAG_TEMPORARIO,P52_COD_EMPRESA,P52_VALSIND'
,p_attribute_03=>'P52_VALSIND'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879515933157908491)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_OK").getValue().length == 0 || apex.item("P52_OK").getValue() == ''S'') {',
'	if (apex.item("P52_RT_JORNADA_MENSAL_X").getValue().length == 0) {',
'		apex.item("P52_OK").setValue(''N'');',
'		apex.item("P52_ITEM_VALIDACAO").setValue(''P52_RT_JORNADA_MENSAL'');',
unistr('		alertify.alert("Preencha a Carga Hor\00E1ria!");'),
'		document.getElementById("alertify-cover").style.position="static";',
'	}else if (apex.item("P52_COD_HORARIO_X").getValue().length == 0){',
'		apex.item("P52_OK").setValue(''N'');',
'		apex.item("P52_ITEM_VALIDACAO").setValue(''P52_COD_HORARIO'');',
unistr('		alertify.alert("Preencha o Hor\00E1rio Contratual!");'),
'		document.getElementById("alertify-cover").style.position="static";',
'	}else{',
'apex.item("P52_ANEXO_1").enable();',
'apex.item("P52_OK").setValue(''S'');',
'apex.item("P52_COD_SIT_REQ").enable();',
'apex.item("P52_COD_CCUSTO").enable();',
'apex.item("P52_COD_CCUSTO_CONTAB").enable();',
'apex.item("P52_COD_UN_NEGOCIO").enable();',
'apex.item("P52_COD_UNIDADE_ADM").enable();',
'apex.item("P52_COD_ATIVIDADE").enable();',
'apex.item("P52_COD_LOCAL_TRAB").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TRAB_INTERMITENTE").enable();',
'apex.item("P52_COD_CARGO").enable();',
'apex.item("P52_SALARIO").enable();',
'apex.item("P52_MAT_SUBS").enable();',
'apex.item("P52_TOTAL_SALARIO").enable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'apex.item("P52_SALARIO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_IND_INSALUB").enable();',
'apex.item("P52_IND_PERIC").enable();',
'apex.item("P52_TIPO_SALARIO").enable();',
'apex.item("P52_COD_CATEGORIA").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_MARCA_PONTO").enable();',
'apex.item("P52_TP_REGISTRO_PONTO").enable();',
'',
'apex.item("P52_TIPO_PONTO").enable();',
'apex.item("P52_JORNADA").enable();',
'apex.item("P52_ESCALA").enable();',
'apex.item("P52_CICLO").enable();',
'apex.item("P52_CICLO_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_FINAL").enable();',
'        ',
'apex.item("P52_DATA_INICIO").enable();',
'apex.item("P52_DATA_FIM").enable();',
'apex.item("P52_TIPO_CONTRATO").enable();   ',
'apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'',
'apex.item("P52_CPF_INDICADO").enable();',
'apex.item("P52_NOME_INDICADO").enable();',
'apex.item("P52_E_MAIL_INDICADO").enable();',
'apex.item("P52_DDD_INDICADO").enable();',
'apex.item("P52_TELEFONE_INDICADO").enable();',
'apex.item("P52_MOTIVO_EXCECAO").enable();',
'apex.item("P52_ORGAO_PUBLICO").enable();',
'apex.item("P52_NOVO_CONTRATO").enable();',
'apex.item("P52_VALOR_VENDA").enable();',
'apex.item("P52_DESC_ATIVIDADES").enable();',
'apex.item("P52_COD_AREA").enable();',
'apex.item("P52_SALARIO_MAX").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'apex.item("P52_TOTAL_SALARIO").enable();',
'apex.item("P52_SALARIO").enable();',
'apex.item("P52_PERC_BENEFICIO").enable();',
'apex.item("P52_COD_REQ").enable();',
'apex.item("P52_CPF_INDICADO").enable();',
'apex.item("P52_NOME_INDICADO").enable();',
'apex.item("P52_E_MAIL_INDICADO").enable();',
'apex.item("P52_DDD_INDICADO").enable();',
'apex.item("P52_TELEFONE_INDICADO").enable();',
'apex.item("P52_MOTIVO_EXCECAO").enable();',
'apex.item("P52_ORGAO_PUBLICO").enable();',
'apex.item("P52_NOVO_CONTRATO").enable();',
'apex.item("P52_VALOR_VENDA").enable();',
'apex.item("P52_DESC_ATIVIDADES").enable();',
'apex.item("P52_MAT_SUBS").enable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_TRAB_INTERMITENTE").enable();',
'apex.item("P52_COD_AREA").enable();',
'//apex.submit("SAVE");',
'let waitSpinner = apex.widget.waitPopup() //call the wait spinner',
'',
'setTimeout(() => {',
'waitSpinner.remove(); //remove the wait spinner after 3 seconds',
'} ,12000)',
'//apex.submit({request:"SAVE",set:{"showWait":true}});',
'}',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9633250560662431562)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_OK").getValue().length == 0 || apex.item("P52_OK").getValue() == ''S'') {',
'	if (apex.item("P52_VALSIND").getValue().length > 0){',
'		apex.item("P52_OK").setValue(''N'');',
'        apex.item("P52_ITEM_VALIDACAO").setValue(''P52_COD_SINDICATO'');',
'        alertify.alert(apex.item("P52_VALSIND").getValue());',
'        document.getElementById("alertify-cover").style.position="static";',
'    }',
'}  '))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9633250712613431563)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALSIND'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879516481971908491)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'perc_benef number := :P52_PERC_BENEFICIO_VARIAVEL;',
'perc_excecao number := :P52_PERC_BENEF_EXCECAO;',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'CURSOR C1 IS',
'select *',
'from requisicao',
'where cod_req = :p52_cod_req;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if nvl(:p52_ok,''N'') = ''S'' then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF NVL(perc_excecao,0) > 0 THEN',
':P52_PERC_BENEFICIO := NVL(perc_excecao,0);',
'ELSE',
':P52_PERC_BENEFICIO := NVL(perc_benef,0);',
'END IF;',
'',
'if v_c1.cod_sit_req = :p52_cod_sit_req and (',
'v_c1.cod_sindicato != :p52_cod_sindicato_x or',
'v_c1.PERC_BENEFICIO_VARIAVEL != :p52_PERC_BENEFICIO or',
'v_c1.remuneracao_variavel != :p52_remuneracao_variavel',
') then',
'',
'delete ',
'from req_beneficios_itens_cand_temp r',
'where exists ',
'(select 1',
'from RP_CAND_INSCRITOS i',
'where i.cod_candidato = r.cod_candidato',
'and i.cod_req = :p52_cod_req);',
'',
'delete ',
'from req_beneficios_itens_cand r',
'where',
'exists ',
'(select 1',
'from RP_CAND_INSCRITOS i, REQ_BENEFICIOS_CANDIDATO rb',
'where i.cod_candidato = rb.cod_candidato',
'and i.cod_req = :p52_cod_req',
'and rb.cod_req = r.cod_req);',
'',
'--update REQ_BENEFICIOS_CANDIDATO r ',
'--set r.cod_sit_req = 3, r.dt_sit_req = sysdate',
'delete from req_beneficios_candidato r',
'where exists ',
'(select 1',
'from RP_CAND_INSCRITOS i',
'where i.cod_candidato = r.cod_candidato',
'and i.cod_req = :p52_cod_req);',
'',
'commit;',
'',
'end if;',
'end if;',
'end;'))
,p_attribute_02=>'P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_COD_REQ,P52_COD_SIT_REQ,P52_COD_SINDICATO_X,P52_PERC_BENEFICIO,P52_REMUNERACAO_VARIAVEL,P52_COD_REQ,P52_OK'
,p_attribute_03=>'P52_PERC_BENEFICIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879516947476908492)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'perc_benef number := :P52_PERC_BENEFICIO_VARIAVEL;',
'perc_excecao number := :P52_PERC_BENEF_EXCECAO;',
'',
'v_flg varchar2(3);',
'v_msg varchar2(4000);',
'',
'CURSOR C1 IS',
'select *',
'from requisicao',
'where cod_req = :p52_cod_req_x;',
'v_c1 c1%rowtype;',
'',
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'IF NVL(perc_excecao,0) > 0 THEN',
':P52_PERC_BENEFICIO := NVL(perc_excecao,0);',
'ELSE',
':P52_PERC_BENEFICIO := NVL(perc_benef,0);',
'END IF;',
'',
'if ((:p52_cod_sit_req in (0,1,5,6)) or (v_c1.cod_sit_req = :p52_cod_sit_req)) and',
'(',
'v_c1.qtd_posicao != :p52_qtd_posicao or',
'v_c1.vinculo != :p52_vinculo or',
'v_c1.anos_servico != :P52_ANOS_SERVICO or',
'v_c1.meses_servico != :P52_meses_SERVICO or',
'v_c1.sexo != nvl(:p52_sexo,''A'') or',
'v_c1.cod_instrucao != :P52_COD_INSTRUCAO or',
'v_c1.observacao != :P52_OBSERVACAO or',
'v_c1.POS_ESTR_ORG != :P52_POS_ESTR_ORG or',
'v_c1.EXP_NEC != :P52_EXP_NEC or',
'v_c1.REL_FUNC != :P52_REL_FUNC or',
'v_c1.FAT_INS != :P52_FAT_INS or',
'v_c1.PERS_DES != :P52_PERS_DES or',
'v_c1.PAR_JUST != :P52_PAR_JUST or',
'v_c1.PAR_RH != :P52_PAR_RH or',
'v_c1.par_orc != :P52_PAR_ORC or',
'v_c1.cod_sindicato != :p52_cod_sindicato or',
'v_c1.PERC_BENEFICIO_VARIAVEL != :p52_PERC_BENEFICIO or',
'v_c1.remuneracao_variavel != :p52_remuneracao_variavel or',
'v_c1.salario != :p52_salario OR',
'V_C1.VAGA_FATURAVEL != :P52_VAGA_FATURAVEL OR',
'V_C1.VALOR_FATURAVEL != :P52_VALOR_FATURAVEL or',
'v_c1.VLR_AUX_TIPO_MODALIDADE != :P52_VLR_AUX_TIPO_MODALIDADE or',
'v_c1.TIPO_MODALIDADE != :P52_TIPO_MODALIDADE or ',
'v_c1.COD_AREA != :P52_COD_AREA or',
'v_c1.RT_JORNADA_MENSAL != :P52_RT_JORNADA_MENSAL_X OR',
'v_c1.COD_HORARIO != :P52_COD_HORARIO_X or',
'v_c1.refeitorio != :p52_refeitorio ',
') then',
'',
'begin',
'',
'update REQUISICAO',
'set ',
'COD_SIT_REQ = :P52_COD_SIT_REQ,',
'mot_sit_req = :p52_mot_sit_req,',
'vinculo = nvl(:p52_vinculo, vinculo),',
'anos_servico = :P52_ANOS_SERVICO,',
'meses_servico = :P52_meses_SERVICO,',
'sexo = nvl(:p52_sexo,''A''),',
'cod_instrucao = :P52_COD_INSTRUCAO,',
'observacao = :P52_OBSERVACAO,',
'POS_ESTR_ORG = :P52_POS_ESTR_ORG,',
'EXP_NEC = :P52_EXP_NEC,',
'REL_FUNC = :P52_REL_FUNC,',
'FAT_INS = :P52_FAT_INS,',
'PERS_DES = :P52_PERS_DES,',
'PAR_JUST = :P52_PAR_JUST,',
'PAR_RH = :P52_PAR_RH,',
'par_orc = :P52_PAR_ORC,',
'cod_sindicato = :p52_cod_sindicato,',
'PERC_BENEFICIO_VARIAVEL = :p52_PERC_BENEFICIO,',
'remuneracao_variavel = :p52_remuneracao_variavel,',
'salario = :p52_salario,',
'MOTIVO_EXCECAO = :P52_MOTIVO_EXCECAO,',
'VLR_AUX_TIPO_MODALIDADE = :P52_VLR_AUX_TIPO_MODALIDADE,',
'VAGA_FATURAVEL = :P52_VAGA_FATURAVEL,',
'VALOR_FATURAVEL = :P52_VALOR_FATURAVEL,',
'TIPO_MODALIDADE = :P52_TIPO_MODALIDADE,',
'COD_AREA = :P52_COD_AREA,',
'RT_JORNADA_MENSAL = :P52_RT_JORNADA_MENSAL_X,',
'COD_HORARIO = :P52_COD_HORARIO_X,',
'refeitorio = :p52_refeitorio,',
'qtd_posicao = :p52_qtd_posicao,',
'IND_INSALUB = NVL(:P52_IND_INSALUB,''N''),',
'IND_PERIC = NVL(:P52_IND_PERIC,''N''),',
'usuario = :p_usuario,',
'dt_atualizacao = sysdate',
'where cod_req = :p52_cod_req_x;',
'',
'end;',
'',
'elsif :p52_cod_sit_req in (0,3) then',
'',
'begin',
'update REQUISICAO',
'set COD_SIT_REQ = :P52_COD_SIT_REQ,',
'qtd_posicao = :p52_qtd_posicao,',
'mot_sit_req = :p52_mot_sit_req,',
'PAR_JUST = :P52_PAR_JUST,',
'PAR_RH = :P52_PAR_RH,',
'par_orc = :P52_PAR_ORC',
'where cod_req = :p52_cod_req_x;',
'',
'end;',
'',
'end if;',
'',
'begin',
'insert into tar_peso (cod_req, cod_tarefa_req, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req_x, cod_tarefa_req, cod_peso, :p_usuario, sysdate from tar_peso_temp where seq = :p52_seq);',
'delete from tar_peso_temp where seq = :p52_seq;',
'end;',
'',
'begin',
'insert into carac_peso (cod_req, cod_carac_func, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req_x, cod_carac_func, cod_peso, :p_usuario, sysdate from carac_peso_temp where seq = :p52_seq);',
'delete from carac_peso_temp where seq = :p52_seq;',
'end;',
'',
'begin',
'update idioma_req_pessoal',
'set cod_req = :p52_cod_req_x',
'where seq = :p52_seq;',
'end;',
'',
'begin',
'update beneficios_vaga_temp',
'set cod_requisicao = :p52_cod_req_x',
'where seq = :p52_seq;',
'end;',
'commit;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_SIT_REQ,P52_VINCULO,P52_ANOS_SERVICO,P52_MESES_SERVICO,P52_SEXO,P52_COD_INSTRUCAO,P52_OBSERVACAO,P52_POS_ESTR_ORG,P52_EXP_NEC,P52_REL_FUNC,P52_FAT_INS,P52_PERS_DES,P52_PAR_JUST,P52_PAR_RH,P52_PAR_ORC,P52_COD_REQ_X,P52_COD_EMPRESA,P52_SEQ,P52_'
||'COD_SINDICATO_X,P52_PERC_BENEFICIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO,P52_VAGA_FATURAVEL,P52_VALOR_FATURAVEL,P_USUARIO,P52_VLR_AUX_TIPO_MODALIDADE,P52_TIPO_MODALIDADE,P52_COD_AREA,P52_COD_HORARIO_X'
||',P52_RT_JORNADA_MENSAL_X,P52_OK,P52_REFEITORIO,P52_MOT_SIT_REQ,P52_QTD_POSICAO,P52_MOTIVO_EXCECAO'
,p_attribute_03=>'P52_PERC_BENEFICIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37117662496394636659)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg varchar2(3);',
'v_msg varchar2(4000);',
' v_blob          blob;',
'  v_filename      varchar2(255);',
'  v_mimetype      varchar2(255);',
'  v_charset       varchar2(128);',
'',
'CURSOR C1 IS',
'select *',
'from requisicao',
'where cod_req = :p52_cod_req_x;',
'v_c1 c1%rowtype;',
'',
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if :p52_cod_sit_req in (0,1,5,6) and (',
'v_c1.cod_local_trab = :p52_cod_local_trab_x or',
'v_c1.cod_cargo != nvl(:p52_cod_cargo_x,nvl(:p52_cod_cargo,v_c1.cod_cargo)) or',
'v_c1.cod_funcao != nvl(:p52_cod_funcao_x,nvl(:p52_cod_funcao,v_c1.cod_funcao)) or',
'v_c1.cod_categoria != nvl(:p52_cod_categoria_x,nvl(:p52_cod_categoria,v_c1.cod_categoria)) or ',
'v_c1.novo_contrato != :p52_novo_contrato or',
'v_c1.orgao_publico != :p52_orgao_publico or',
'v_c1.valor_venda != :p52_valor_venda or',
'v_c1.tipo_contrato != :p52_tipo_contrato or',
'v_c1.dt_previsao_admissao != :p52_dt_previsao_admissao or',
'v_c1.dt_prev_fim_contrato != :p52_dt_prev_fim_contrato or',
'v_c1.desc_atividades != :p52_desc_atividades or',
'v_c1.ind_def_fis != :p52_ind_def_fis or',
'v_c1.rais_ind_def_auditiva != :p52_rais_ind_def_auditiva or ',
'v_c1.rais_ind_def_fisico != :p52_rais_ind_def_fisico or ',
'v_c1.rais_ind_def_mental != :p52_rais_ind_def_mental or ',
'v_c1.rais_ind_def_multipla != :p52_rais_ind_def_multipla or ',
'v_c1.rais_ind_def_visual != :p52_rais_ind_def_visual or',
'v_c1.vaga_confidencial != :p52_vaga_confidencial or',
'v_c1.refeitorio != :p52_refeitorio or',
'v_c1.tipo_publicacao != :p52_tipo_publicacao or',
'v_c1.data_inicio != :p52_data_inicio or',
'v_c1.data_fim != :p52_data_fim',
') then',
'',
'begin',
'',
'update REQUISICAO',
'set ',
'cod_local_trab = :p52_cod_local_trab_x,',
'cod_cargo = nvl(:p52_cod_cargo_x,nvl(:p52_cod_cargo,v_c1.cod_cargo)),',
'cod_funcao = nvl(:p52_cod_funcao_x,nvl(:p52_cod_funcao,v_c1.cod_funcao)),',
'cod_categoria = nvl(:p52_cod_categoria_x,nvl(:p52_cod_categoria,v_c1.cod_categoria)),',
'novo_contrato = :p52_novo_contrato,',
'orgao_publico = :p52_orgao_publico,',
'valor_venda = :p52_valor_venda,',
'tipo_contrato = :p52_tipo_contrato,',
'dt_previsao_admissao = :p52_dt_previsao_admissao,',
'dt_prev_fim_contrato = :p52_dt_prev_fim_contrato,',
'desc_atividades = :p52_desc_atividades,',
'ind_def_fis = :p52_ind_def_fis,',
'rais_ind_def_auditiva = :p52_rais_ind_def_auditiva,',
'rais_ind_def_fisico = :p52_rais_ind_def_fisico,',
'rais_ind_def_mental = :p52_rais_ind_def_mental,',
'rais_ind_def_multipla = :p52_rais_ind_def_multipla,/*,',
'rais_ind_def_visual = :p52_rais_ind_def_visual*/',
'vaga_confidencial = :p52_vaga_confidencial,',
'refeitorio = :p52_refeitorio,',
'tipo_publicacao = :p52_tipo_publicacao,',
'data_inicio = :p52_data_inicio,',
'data_fim = :p52_data_fim,',
'usuario = :p_usuario,',
'dt_atualizacao = sysdate',
'where cod_req = :p52_cod_req_x;',
'end;',
'',
'end if;',
'',
'commit;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_SIT_REQ,P52_COD_REQ_X,P52_OK,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_LOCAL_TRAB_X,P52_NOVO_CONTRATO,P52_ORGAO_PUBLICO,P52_VALOR_VENDA,P52_TIPO_CONTRATO,P52_DT_PREVISAO_ADMISSAO,P52_DT_PREV_FIM_CONTRATO,P52_DESC_ATIVIDADES'
||',P52_IND_DEF_FIS,P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_VAGA_CONFIDENCIAL,P52_REFEITORIO,P52_TIPO_PUBLICACAO,P52_DATA_INICIO,P52_DATA_FIM'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37569788098473989768)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'CURSOR C1 IS',
'select *',
'from requisicao ',
'where cod_req = :p52_cod_req_x;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if (:p52_cod_sit_req in (1,5,6) --v_c1.cod_sit_req = :p52_cod_sit_req ',
'    and (',
'nvl(v_c1.prospeccao,''N'') = ''S'' and nvl(:p52_prospeccao,''N'') = ''N'' and :p52_cod_sit_req = 1',
')) or (v_c1.cod_sit_req = 0 and :p52_cod_sit_req = 1 and nvl(:p52_prospeccao,''N'') = ''N'')',
'then',
'',
'  begin',
'',
'  update REQUISICAO',
'  set ',
'  COD_SIT_REQ = :p52_cod_sit_req,',
'  DT_SIT_REQ = sysdate,',
'  prospeccao = nvl(:p52_prospeccao,''N''),',
'  usuario = :p_usuario,',
'  dt_atualizacao = sysdate,',
'  ind_revisado = :p52_ind_revisado',
'  where cod_req = :p52_cod_req_x;',
'',
'  commit;',
'  end;',
'',
'----',
'',
'      Prc_Insere_Aprovador (:p52_cod_req_x,''REQ_PESSOAL'', v_flg_retorno, v_msg_retorno); ',
'      commit;',
'',
'----',
'',
'elsif (v_c1.cod_sit_req = 1 and :p52_cod_sit_req = 0) then',
'',
'  begin',
'',
'  update REQUISICAO',
'  set ',
'  COD_SIT_REQ = :p52_cod_sit_req,',
'  DT_SIT_REQ = sysdate,',
'  usuario = :p_usuario,',
'  dt_atualizacao = sysdate',
'  where cod_req = :p52_cod_req_x;',
'',
'  commit;',
'  end;  ',
'  ',
'  delete from aprova_req where cod_req = :p52_cod_req_x;',
'  commit;',
'',
'end if;',
'',
'commit;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_REQ_X,P52_COD_SIT_REQ,P52_OK,P52_PROSPECCAO,P_USUARIO,P52_COD_EMPRESA,P52_IND_REVISADO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879517497647908492)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'CURSOR C1 IS',
'select *',
'  from requisicao',
' where cod_req = :p52_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'    if (',
'       nvl(V_C1.CANDIDATO_INDICADO,0) != :P52_CANDIDATO_INDICADO or',
'       nvl(V_C1.NOME_INDICADO,''X'') != :P52_NOME_INDICADO or  ',
'       nvl(V_C1.E_MAIL_INDICADO,''X'') != :P52_E_MAIL_INDICADO or ',
'       nvl(V_C1.DDD_INDICADO,0) != :P52_DDD_INDICADO or ',
'       nvl(V_C1.TELEFONE_INDICADO,0) != :P52_TELEFONE_INDICADO or ',
'       nvl(V_C1.CPF_INDICADO,''X'') != :P52_CPF_INDICADO or ',
'       nvl(v_c1.desc_atividades,''X'') != :P52_DESC_ATIVIDADES OR',
'       nvl(v_c1.emp_gestor_ind,0) != :p52_emp_gestor_ind or',
'       nvl(v_c1.mat_gestor_ind,0) != :p52_mat_gestor_ind or',
'       nvl(v_c1.emp_avaliador_ind,0) != :p52_emp_avaliador_ind or',
'       nvl(v_c1.mat_avaliador_ind,0) != :p52_mat_avaliador_ind or',
'       nvl(v_c1.idade_min,0) != :p52_idade_min or',
'       nvl(v_c1.idade_max,0) != :p52_idade_max OR',
'       NVL(V_C1.IND_INSALUB,''N'') != NVL(:P52_IND_INSALUB,''N'') OR',
'       NVL(V_C1.IND_PERIC,''N'') != NVL(:P52_IND_PERIC,''N'') OR',
'       NVL(V_C1.MESES_SERVICO,0) != NVL(:P52_MESES_SERVICO,0)',
'    ) then',
'',
'begin',
'',
'update REQUISICAO',
'   set CANDIDATO_INDICADO = :P52_CANDIDATO_INDICADO,  ',
'       NOME_INDICADO = :P52_NOME_INDICADO,',
'       E_MAIL_INDICADO = :P52_E_MAIL_INDICADO,',
'       DDD_INDICADO = :P52_DDD_INDICADO,',
'       TELEFONE_INDICADO = :P52_TELEFONE_INDICADO,',
'       CPF_INDICADO = :P52_CPF_INDICADO,',
'       desc_atividades = :P52_DESC_ATIVIDADES,',
'       --anexo_data_1 = trunc(sysdate),',
'       emp_gestor_ind = :p52_emp_gestor_ind,',
'       mat_gestor_ind = :p52_mat_gestor_ind,',
'       emp_avaliador_ind = :p52_emp_avaliador_ind,',
'       mat_avaliador_ind = :p52_mat_avaliador_ind,',
'       idade_min = :p52_idade_min,',
'       idade_max = :p52_idade_max,',
'       usuario = :p_usuario,',
'       dt_atualizacao = sysdate,',
'       IND_INSALUB = NVL(:P52_IND_INSALUB,''N''),',
'       IND_PERIC = NVL(:P52_IND_PERIC,''N''),',
'       MESES_SERVICO = :P52_MESES_SERVICO',
' where cod_req = :p52_cod_req;',
'',
' commit;',
'',
'end;',
'',
'end if;',
'',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_SIT_REQ,P52_COD_REQ,P52_CANDIDATO_INDICADO,P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO,P52_EMP_GESTOR_IND,P52_MAT_GESTOR_IND,P52_EMP_AVALIADOR_IND,P52_MAT_AVALIADOR_IND,P52_IDADE_MIN,P52_IDADE'
||'_MAX,P52_DESC_ATIVIDADES,P_USUARIO,P52_OK,P52_IND_INSALUB,P52_IND_PERIC,P52_MESES_SERVICO'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879514989654908490)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then',
'if :p52_cod_vaga is not null and :p52_salario is null then',
'     ',
'       BEGIN',
'       ',
'       FOR l1 IN (',
'       SELECT v.cod_vaga, v.tipo_salario, v.valor_total, v.perc_beneficio_variavel, v.valor_verba, v.remuneracao_variavel, v.tipo_modalidade, v.vlr_aux_tipo_modalidade',
'         FROM cl_vaga v ',
'        WHERE v.cod_vaga = :p52_cod_vaga ',
'          and EXISTS (SELECT r.cod_vaga',
'                        FROM requisicao r',
'                       WHERE r.cod_vaga = v.cod_vaga',
'                         AND NVL(r.salario,0) <> NVL(v.valor_verba,0)',
'                         AND NVL(r.salario,0) < 800',
'                         AND r.cod_sit_req IN (1,5)',
'                         AND r.cod_req = :p52_cod_req_x)',
'        ORDER BY TO_NUMBER(v.cod_vaga))',
'       LOOP',
'',
'       UPDATE requisicao',
'          SET tipo_salario = l1.tipo_salario,',
'              perc_beneficio_variavel = l1.perc_beneficio_variavel,',
'              salario = l1.valor_verba,',
'              remuneracao_variavel = l1.remuneracao_variavel,',
'              tipo_modalidade = l1.tipo_modalidade,',
'              vlr_aux_tipo_modalidade = l1.vlr_aux_tipo_modalidade',
'        WHERE cod_vaga = l1.cod_vaga',
'          and cod_req = :p52_cod_req_x;',
'',
'       END LOOP;',
'       exception',
'       when others then ',
'       null;',
'       END;',
'',
'        commit;',
'',
'   end if;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_VAGA,P52_COD_REQ_X,P52_OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879515475747908491)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'nvl(a.cod_horario,a.cod_horario_jornada) cod_horario,',
'a.cod_sindicato,',
'a.cod_unidade_adm,',
'a.cod_atividade,',
'a.vinculo,',
'a.cod_un_negocio,',
'a.cod_cargo,',
'a.cod_funcao,',
'a.cod_categoria',
'  from cl_vaga                a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'if nvl(:p52_ok,''N'') = ''S'' then ',
'if :p52_cod_req is not null and :p52_cod_vaga is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'update requisicao ',
'   set cod_ccusto = v_c1.cod_ccusto,',
'       cod_local_trab = v_c1.cod_local_trab,',
'       cod_ccusto_contab = v_c1.cod_ccusto_contab,',
'       -- cod_horario = v_c1.cod_horario,',
'       cod_sindicato = v_c1.cod_sindicato,',
'       cod_unidade_adm = v_c1.cod_unidade_adm,',
'       cod_atividade = v_c1.cod_atividade,',
'       vinculo = v_c1.vinculo,',
'       cod_un_negocio = v_c1.cod_un_negocio,',
'       cod_cargo = v_c1.cod_cargo,',
'       cod_funcao = v_c1.cod_funcao,',
'       cod_categoria = v_c1.cod_categoria',
'',
'',
' where cod_req = :p52_cod_req;',
'',
'end if;',
'end if;',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_COD_VAGA,P52_COD_EMPRESA,P52_COD_FILIAL,P52_OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37117662666874636660)
,p_event_id=>wwv_flow_api.id(37879514504083908490)
,p_event_result=>'TRUE'
,p_action_sequence=>140
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_OK").getValue().length == 0 || apex.item("P52_OK").getValue() == ''S'') {',
'	if (apex.item("P52_RT_JORNADA_MENSAL_X").getValue().length == 0) {',
'    console.log("validacao");',
'	}else if (apex.item("P52_COD_HORARIO_X").getValue().length == 0){',
'    console.log("validacao");',
'	}else{',
'     apex.submit("SAVE");',
'	}',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879518328599908492)
,p_name=>'get_lov_display (popup_lov)'
,p_event_sequence=>1528
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.popup_lov'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879518863634908493)
,p_event_id=>wwv_flow_api.id(37879518328599908492)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')) + ''this.triggeringElement: '' + $v(this.triggeringElement))',
'apex.server.process("get_lov_display", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879519229978908493)
,p_name=>'get_lov_display (select2)'
,p_event_sequence=>1538
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.select2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879519792340908493)
,p_event_id=>wwv_flow_api.id(37879519229978908493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')))',
'apex.server.process("get_lov_display", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879520133424908493)
,p_name=>'get_lov_display (p52_cod_local_trab_1)'
,p_event_sequence=>1548
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_LOCAL_TRAB_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879520626123908493)
,p_event_id=>wwv_flow_api.id(37879520133424908493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_LOCAL_TRAB_1'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando Local Trab.: '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')))',
'apex.server.process("get_lov_display_local", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879521050728908493)
,p_name=>'get_lov_display (p52_rt_jornada_mensal)'
,p_event_sequence=>1558
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL'
,p_condition_element=>'P52_RT_JORNADA_MENSAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879521589601908493)
,p_event_id=>wwv_flow_api.id(37879521050728908493)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_RT_JORNADA_MENSAL'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var $te = $(this.triggeringElement);',
'console.log(''Processando Local Trab.: '' + $te.attr(''id'') + ''. Valor: '' + $v($te.attr(''id'')))',
'apex.server.process("get_lov_display", {',
'  x01: $te.attr(''id''),',
'  x02: $v($te.attr(''id''))',
'}, {',
'  dataType: "text",',
'  success: function(pData) {',
'    if (pData) $te.val(pData)',
'  } ',
'});'))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879521942982908494)
,p_name=>'Desc. Local Trab'
,p_event_sequence=>1568
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB,P52_COD_LOCAL_TRAB_1'
,p_condition_element=>'P52_COD_LOCAL_TRAB'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879522511487908494)
,p_event_id=>wwv_flow_api.id(37879521942982908494)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select Initcap(descricao) descricao, ',
'       Initcap(endereco) endereco,',
'       numero,',
'       Complemento,',
'       initcap(bairro) bairro,',
'       initcap(Cidade) cidade,',
'       upper(uf) uf,',
'       cep,',
'       complemento_cep',
'  from local_trab',
'  where cod_local_trab = nvl(:p52_cod_local_trab,:p52_cod_local_trab_1);',
'  ',
'v_c1 c1%rowtype;',
'  ',
'v_desc_local varchar2(500);',
'',
'begin',
'  ',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.descricao is not null then',
'  v_desc_local := Initcap(v_c1.descricao);',
'end if;',
'',
'if v_c1.endereco is not null then',
'  v_desc_local := v_desc_local||'': ''||Initcap(v_c1.endereco);',
'end if;',
'',
'if v_c1.numero is not null then',
'  v_desc_local := v_desc_local||'', ''||v_c1.numero;',
'end if;',
'',
'if v_c1.complemento is not null then',
'  v_desc_local := v_desc_local||'' - ''||v_c1.complemento;',
'end if;',
'',
'if v_c1.bairro is not null then',
'  v_desc_local := v_desc_local||'' - ''||initcap(v_c1.bairro);',
'end if;',
'',
'if v_c1.cidade is not null then',
'  v_desc_local := v_desc_local||'' - ''||initcap(v_c1.Cidade);',
'end if;',
'',
'if v_c1.uf is not null then',
'  v_desc_local := v_desc_local||''/''||upper(v_c1.uf);',
'end if;',
'',
'if v_c1.cep is not null then',
'  v_desc_local := v_desc_local||'' - CEP: ''||lpad(v_c1.cep,5,0)||''-''||lpad(v_c1.complemento_cep,3,0);',
'end if;',
'',
':p52_desc_local := v_desc_local;',
'',
'end;'))
,p_attribute_02=>'P52_COD_LOCAL_TRAB,P52_COD_LOCAL_TRAB_1'
,p_attribute_03=>'P52_DESC_LOCAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879522877809908495)
,p_name=>'Motivo Excecao'
,p_event_sequence=>1578
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879523393718908495)
,p_event_id=>wwv_flow_api.id(37879522877809908495)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879523834194908496)
,p_event_id=>wwv_flow_api.id(37879522877809908495)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879524303910908496)
,p_name=>'Empresa Aloca Colab?'
,p_event_sequence=>1588
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_IND_SERV_ALOCA_COLAB'
,p_condition_element=>'P52_IND_SERV_ALOCA_COLAB'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879524824779908496)
,p_event_id=>wwv_flow_api.id(37879524303910908496)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359331864683691683)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879526258168908497)
,p_event_id=>wwv_flow_api.id(37879524303910908496)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(170359331864683691683)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879527577828908498)
,p_name=>unistr('Ap\00F3s Apagar Caracteristicas1')
,p_event_sequence=>1608
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179846376624870246835)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879528114001908498)
,p_event_id=>wwv_flow_api.id(37879527577828908498)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846376624870246835)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879528480265908498)
,p_name=>unistr('Ap\00F3s Apagar Tarefas1')
,p_event_sequence=>1618
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179846375850352246827)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879529011251908498)
,p_event_id=>wwv_flow_api.id(37879528480265908498)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(179846375850352246827)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879529394929908498)
,p_name=>'(Mouse Move) Popular Campos Y'
,p_event_sequence=>1628
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(170359328940684691654)
,p_condition_element=>'P52_QTD_MOUSE_MOVE'
,p_triggering_condition_type=>'LESS_THAN_OR_EQUAL'
,p_triggering_expression=>'5'
,p_bind_type=>'bind'
,p_bind_event_type=>'mousemove'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return 1=2 and :P52_ROWID is not null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879529916317908499)
,p_event_id=>wwv_flow_api.id(37879529394929908498)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P52_COD_CCUSTO" ).getValue().length = 0 && apex.item( "P52_COD_CCUSTO_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_CCUSTO" ).setValue( apex.item( "P52_COD_CCUSTO_Y" ).getValue(),apex.item( "P52_NOME_COD_CCUSTO_Y" ).getValue(),true );',
'}',
'if (apex.item( "P52_COD_UNIDADE_ADM_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_UNIDADE_ADM" ).setValue( apex.item( "P52_COD_UNIDADE_ADM_Y" ).getValue(),apex.item( "P52_NOME_UNIDADE_ADM_Y" ).getValue(),true );',
'}',
'if (apex.item( "P52_COD_ATIVIDADE_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_ATIVIDADE" ).setValue( apex.item( "P52_COD_ATIVIDADE_Y" ).getValue(),apex.item( "P52_NOME_ATIVIDADE_Y" ).getValue(),true );',
'}',
'if (apex.item( "P52_COD_LOCAL_TRAB_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_LOCAL_TRAB" ).setValue( apex.item( "P52_COD_LOCAL_TRAB_Y" ).getValue(),apex.item( "P52_NOME_LOCAL_TRAB_Y" ).getValue(),true );',
'}',
'if (apex.item( "P52_COD_CCUSTO_CONTAB_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_CCUSTO_CONTAB" ).setValue( apex.item( "P52_COD_CCUSTO_CONTAB_Y" ).getValue(),apex.item( "P52_NOME_CCUSTO_CONTAB_Y" ).getValue(),true );',
'}',
'if (apex.item( "P52_COD_UN_NEGOCIO_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_UN_NEGOCIO" ).setValue( apex.item( "P52_COD_UN_NEGOCIO_Y" ).getValue(),apex.item( "P52_NOME_UN_NEGOCIO_Y" ).getValue(),true );',
'}',
'',
'',
'',
'if (apex.item( "P52_COD_CCUSTO_1" ).getValue().length = 0 && apex.item( "P52_COD_CCUSTO_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_CCUSTO_1" ).setValue( apex.item( "P52_COD_CCUSTO_Y" ).getValue());',
'}',
'if (apex.item( "P52_COD_UNIDADE_ADM_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_UNIDADE_ADM_1" ).setValue( apex.item( "P52_COD_UNIDADE_ADM_Y" ).getValue());',
'}',
'if (apex.item( "P52_COD_ATIVIDADE_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_ATIVIDADE_1" ).setValue( apex.item( "P52_COD_ATIVIDADE_Y" ).getValue());',
'}',
'if (apex.item( "P52_COD_LOCAL_TRAB_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_LOCAL_TRAB_1" ).setValue( apex.item( "P52_COD_LOCAL_TRAB_Y" ).getValue());',
'}',
'if (apex.item( "P52_COD_CCUSTO_CONTAB_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_CCUSTO_CONTAB_1" ).setValue( apex.item( "P52_COD_CCUSTO_CONTAB_Y" ).getValue());',
'}',
'if (apex.item( "P52_COD_UN_NEGOCIO_Y" ).getValue().length > 0){',
'apex.item( "P52_COD_UN_NEGOCIO_1" ).setValue( apex.item( "P52_COD_UN_NEGOCIO_Y" ).getValue());',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879530267612908499)
,p_name=>'(Transferencia) Mat_Subs'
,p_event_sequence=>1638
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_MOT_REQ'
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'N'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879530731261908499)
,p_event_id=>wwv_flow_api.id(37879530267612908499)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c3 is ',
'select a.mat_solicitado matricula, fnct_nome_func(a.cod_empresa_solicitado, a.mat_solicitado) nome',
'  from solicitacao_alteracao_func a, solicitacao_aprovadas c',
' where a.COD_SOLICITACAO = c.COD_SOLICITACAO',
'   AND A.COD_SIT_SOLICITACAO NOT IN (3,4,6)',
'   and a.dt_solicitacao in (SELECT MAX(b.dt_solicitacao)',
'                                  FROM solicitacao_alteracao_func  b',
'                                 WHERE b.cod_empresa_solicitado   = a.cod_empresa_solicitado',
'                                   and b.filial                   = a.filial  ',
'                                   AND b.cad_vaga                 = a.cad_vaga)',
'   and a.cod_empresa_solicitado = :p52_cod_empresa',
'   and a.filial = :p52_cod_filial',
'   and a.cad_vaga = :p52_cod_vaga;',
'',
'v_c3 c3%rowtype;',
'',
'begin',
'',
' if :P52_COD_MOT_REQ = 3 then',
' ',
' open c3;',
' fetch c3 into v_c3;',
' close c3;',
' ',
' :p52_mat_subs := v_c3.matricula;',
'',
' end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_COD_MOT_REQ'
,p_attribute_03=>'P52_MAT_SUBS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879531170096908499)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1648
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879123140909908289)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879531662440908499)
,p_event_id=>wwv_flow_api.id(37879531170096908499)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVACAO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879532097745908499)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1658
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879122365302908288)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879532555770908499)
,p_event_id=>wwv_flow_api.id(37879532097745908499)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVACAO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879532995171908500)
,p_name=>'Criar Igual'
,p_event_sequence=>1668
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879125480478908291)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879533475080908500)
,p_event_id=>wwv_flow_api.id(37879532995171908500)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'PROMPT'
,p_attribute_04=>unistr('Deseja criar quantas requisi\00E7\00F5es iguais a esta?')
,p_attribute_06=>'P52_QTD_POSICAO_1'
,p_attribute_07=>'Confirmar'
,p_attribute_08=>'Cancelar'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879533948581908500)
,p_event_id=>wwv_flow_api.id(37879532995171908500)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CRIAR_IGUAL'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879534423808908500)
,p_name=>'Open Req. Descendentes'
,p_event_sequence=>1678
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879108513740908270)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879534854220908500)
,p_event_id=>wwv_flow_api.id(37879534423808908500)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(167882312766428043366)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879535305120908500)
,p_name=>'(Colab) Add. Colab - Dialog Closed'
,p_event_sequence=>1688
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879218974775908346)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879535744569908500)
,p_event_id=>wwv_flow_api.id(37879535305120908500)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168080629306856356580)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879536160907908501)
,p_name=>'(Cand) Add. Cand - Dialog Closed'
,p_event_sequence=>1698
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879222521715908347)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879536652180908501)
,p_event_id=>wwv_flow_api.id(37879536160907908501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168153567268194188368)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879537103969908501)
,p_name=>'(IR Colab) Add. Colab - Dialog Closed'
,p_event_sequence=>1708
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(168080629306856356580)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879537557212908501)
,p_event_id=>wwv_flow_api.id(37879537103969908501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168080629306856356580)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879537981098908501)
,p_name=>'(IR Cand) Add. Cand - Dialog Closed'
,p_event_sequence=>1718
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(168153567268194188368)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879538496742908501)
,p_event_id=>wwv_flow_api.id(37879537981098908501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(168153567268194188368)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879538867628908501)
,p_name=>'(Pesquisa) Disable Fields'
,p_event_sequence=>1728
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879539377590908502)
,p_event_id=>wwv_flow_api.id(37879538867628908501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_ROWID").getValue().length > 0) {',
'apex.item("P52_COD_SIT_REQ").disable();',
'apex.item("P52_FLAG_TEMPORARIO").disable();',
'apex.item("P52_QTD_POSICAO").disable();',
'apex.item("P52_COD_EMPRESA").disable();',
'apex.item("P52_COD_FILIAL").disable();',
'apex.item("P52_COD_VAGA").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'apex.item("P52_COD_LOCAL_TRAB").disable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB_1").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_CARGO").disable();',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_MAT_SUBS").disable();',
'apex.item("P52_MOT_SUBS").disable();',
'apex.item("P52_PONTOS_AVAL").disable();',
'apex.item("P52_IND_DEF_FIS").disable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").disable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").disable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").disable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").disable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").disable();',
'apex.item("P52_COD_CATEGORIA").disable();',
'apex.item("P52_COD_FUNCAO").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'    ',
'apex.item("P52_TIPO_PONTO").disable();',
'apex.item("P52_JORNADA").disable();',
'apex.item("P52_ESCALA").disable();',
'apex.item("P52_CICLO").disable();',
'apex.item("P52_CICLO_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_INICIAL").disable();',
'apex.item("P52_CICLO_DAT_FINAL").disable();    ',
'    ',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").disable();',
'apex.item("P52_REFEITORIO").disable();',
'apex.item("P52_COD_SINDICATO").disable();',
'apex.item("P52_VAGA_FATURAVEL").disable();',
'apex.item("P52_VALOR_FATURAVEL").disable();',
'apex.item("P52_TOTAL_SALARIO").disable();',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'apex.item("P52_TIPO_SALARIO").disable();',
'//CH43237 apex.item("P52_COD_HORARIO").disable();',
'apex.item("P52_VINCULO").disable();',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
'apex.item("P52_TIPO_MODALIDADE").disable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(32023020272833406078)
,p_event_id=>wwv_flow_api.id(37879538867628908501)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_ROWID").getValue().length > 0) {',
'if ((apex.item("P0_PERFIL").getValue() == "MASTER" ',
'|| apex.item("P0_PERFIL").getValue() == "REMUNERACAO"',
') &&',
'(apex.item("P52_COD_SIT_REQ").getValue() == "0" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "1" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "5") &&',
'apex.item("P52_COD_VAGA").getValue().length == 0',
')',
'{',
'apex.item("P52_REFEITORIO").enable();',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'//CH43237 apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_COD_AREA").enable();',
'apex.item("P52_COD_CARGO").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_COD_CATEGORIA").enable();',
'apex.item("P52_TIPO_CONTRATO").enable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'apex.item("P52_MARCA_PONTO").enable();',
'apex.item("P52_TP_REGISTRO_PONTO").enable();',
'',
'apex.item("P52_TIPO_PONTO").enable();',
'apex.item("P52_JORNADA").enable();',
'apex.item("P52_ESCALA").enable();',
'apex.item("P52_CICLO").enable();',
'apex.item("P52_CICLO_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_INICIAL").enable();',
'apex.item("P52_CICLO_DAT_FINAL").enable();',
'    ',
'}',
'if ((apex.item("P0_PERFIL").getValue() == "SELECAO" ',
') &&',
'(apex.item("P52_COD_SIT_REQ").getValue() == "0" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "1" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "5") &&',
'apex.item("P52_TIPO_MODALIDADE").getValue() == "E"',
')',
'{apex.item("P52_REFEITORIO").enable();',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_COD_SINDICATO_1").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'//CH43237 apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_COD_AREA").enable();',
'}',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495106843373432641)
,p_event_id=>wwv_flow_api.id(37879538867628908501)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_ROWID").getValue().length > 0) {',
'',
'if (apex.item("P52_COD_SIT_REQ").getValue() == "0"){',
'    ',
'apex.item("P52_COD_SIT_REQ").disable();',
'  ',
'apex.item("P52_FLAG_TEMPORARIO").disable();',
'apex.item("P52_QTD_POSICAO").enable();',
'apex.item("P52_COD_EMPRESA").disable();',
'apex.item("P52_COD_FILIAL").disable();',
'apex.item("P52_COD_VAGA").disable();',
'apex.item("P52_COD_CCUSTO").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_UNIDADE_ADM").disable();',
'apex.item("P52_COD_LOCAL_TRAB").enable();',
'apex.item("P52_COD_CCUSTO_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_DSP").disable();',
'apex.item("P52_COD_ATIVIDADE_DSP").disable();',
'apex.item("P52_COD_LOCAL_TRAB_DSP").disable();',
'apex.item("P52_COD_CCUSTO_CONTAB_DSP").disable();',
'apex.item("P52_COD_UNIDADE_ADM_1").disable();',
'apex.item("P52_COD_ATIVIDADE_1").disable();',
'apex.item("P52_COD_LOCAL_TRAB_1").enable();',
'apex.item("P52_COD_CCUSTO_CONTAB_1").disable();',
'apex.item("P52_COD_UN_NEGOCIO").disable();',
'apex.item("P52_COD_CARGO").enable();',
'apex.item("P52_MAT_SUBS").enable();',
'apex.item("P52_MOT_SUBS").enable();',
'apex.item("P52_PONTOS_AVAL").enable();',
'//apex.item("P52_CANDIDATO_INDICADO").disable();',
'apex.item("P52_IND_DEF_FIS").enable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").enable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").enable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").enable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").enable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").enable();',
'apex.item("P52_COD_CATEGORIA").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'apex.item("P52_MARCA_PONTO").enable();',
'apex.item("P52_TP_REGISTRO_PONTO").enable();',
'apex.item("P52_DATA_INICIO").enable();',
'apex.item("P52_DATA_FIM").enable();',
'apex.item("P52_TIPO_CONTRATO").enable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'apex.item("P52_REFEITORIO").enable();',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_TOTAL_SALARIO").disable();',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'apex.item("P52_TIPO_SALARIO").disable();',
'//CH43237 apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TRAB_INTERMITENTE").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'}',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879539756731908502)
,p_name=>unistr('Habilita/Desabilita Valor Aux\00EDlio')
,p_event_sequence=>1738
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_MODALIDADE'
,p_condition_element=>'P52_TIPO_MODALIDADE'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'S,H'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879540318112908502)
,p_event_id=>wwv_flow_api.id(37879539756731908502)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879540790567908502)
,p_event_id=>wwv_flow_api.id(37879539756731908502)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879541254689908502)
,p_event_id=>wwv_flow_api.id(37879539756731908502)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879541799609908502)
,p_event_id=>wwv_flow_api.id(37879539756731908502)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_TIPO_MODALIDADE").getValue() == ''H'') {',
unistr('     $("label[for=P52_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Home-Office)'')'),
'} else if (apex.item("P52_TIPO_MODALIDADE").getValue() == ''S'') {',
unistr('     $("label[for=P52_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Semi-Presencial)'')'),
'} else if (apex.item("P52_TIPO_MODALIDADE").getValue() == ''T'') {',
unistr('     $("label[for=P52_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Teletrabalho)'')'),
'} else if (apex.item("P52_TIPO_MODALIDADE").getValue() == ''E'') {',
unistr('     $("label[for=P52_VLR_AUX_TIPO_MODALIDADE]").text(''Valor Aux\00EDlio (Everywhere)'')'),
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879542263971908503)
,p_event_id=>wwv_flow_api.id(37879539756731908502)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'0'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879542707607908503)
,p_name=>'Valida Vlr Aux Tipo Modalidade'
,p_event_sequence=>1748
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VLR_AUX_TIPO_MODALIDADE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P52_COD_VAGA'').getValue().length == 0 && ',
'apex.item(''P52_AJUSTAR_REMUNERACAO'').getValue() != ''N'' && ',
'apex.item(''P52_VLR_AUX_TIPO_MODALIDADE'').getValue().length > 0'))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is null then',
'return true;',
'elsif :p52_rowid is not null and :p52_cod_sit_req in (0,1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879543195836908503)
,p_event_id=>wwv_flow_api.id(37879542707607908503)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  if :P52_PERC_BENEFICIO_VARIAVEL IS NULL then -- Full CLT',
'    if nvl(:p52_vlr_aux_tipo_modalidade,0) > 0 then',
'      :p52_total_salario := nvl(:p52_salario,0) + nvl(:p52_remuneracao_variavel,0)/* + nvl(:p52_vlr_aux_tipo_modalidade,0)*/;',
'    else',
'      :p52_total_salario := nvl(:p52_salario,0) + nvl(:p52_remuneracao_variavel,0);',
'    end if;',
'  end if;',
'',
'end;'))
,p_attribute_02=>'P52_PERC_BENEFICIO_VARIAVEL,P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P52_TOTAL_SALARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879543572046908503)
,p_name=>'Mostra Valores (New)'
,p_event_sequence=>1758
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879544026547908504)
,p_event_id=>wwv_flow_api.id(37879543572046908503)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'alert("item #01 P52_PERC_BENEFICIO: " + apex.item("P52_PERC_BENEFICIO").getValue() + ',
'               " P52_PERC_BENEFICIO_VARIAVEL: "+ apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue() + ',
'               " P52_PERC_BENEF_EXCECAO: " + apex.item("P52_PERC_BENEF_EXCECAO").getValue());',
'*/',
'if (apex.item("P52_ROWID").getValue().length == 0 ){',
'  ',
'  //alert("item #02");',
'  ',
'	if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().length > 0 ){',
'		',
'    //alert("item #03");',
'    ',
'	  apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'	  if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue() == 0 ){',
'      ',
'      //alert("item #04");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").show();',
'	  	apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  } else {',
'      ',
'      //alert("item #05");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  }',
'',
'	} else {',
'    ',
'    //alert("item #06");',
'		',
'		apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'	}',
'',
'',
'}else{',
'',
'  //alert("item #07");',
'  ',
'  if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().trim().length > 0){',
'',
'    //alert("item #08");',
'    ',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'    if ( apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().trim() == 0 || ',
'         apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().trim() == "0"){',
'',
'      //alert("item #09");',
'      ',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'      apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'      $x(''P52_SALARIO'').disabled = true;',
'      apex.item("P52_SALARIO").disable();',
'',
'      apex.item("P52_PERC_BENEF_EXCECAO").show();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue(apex.item("P52_PERC_BENEFICIO").getValue());',
'      apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    } else {',
'      ',
'      //alert("item #10");',
'      ',
'      apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'      apex.item("P52_MOTIVO_EXCECAO").hide();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'      apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'      $x(''P52_SALARIO'').disabled = true;',
'      apex.item("P52_SALARIO").disable();',
'    }',
'    ',
'  } else {',
'    ',
'    //alert("item #11");',
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'    ',
'  }',
'',
'}',
'',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879544509989908504)
,p_name=>'(Pesquisa) Mostra Valores'
,p_event_sequence=>1768
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879544979756908504)
,p_event_id=>wwv_flow_api.id(37879544509989908504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_PERC_BENEFICIO").getValue().length > 0 ){',
'		',
'  //alert("PAGE LOAD #01");',
'  ',
'		apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'',
'	  if ( apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 0 && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 20 && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 30 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "0,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "20,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "30,00" ){',
'      ',
'',
'    	  $x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	  apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'      ',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'      ',
'      apex.item("P52_PERC_BENEF_EXCECAO").show();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue(apex.item("P52_PERC_BENEFICIO").getValue());',
'      apex.item("P52_MOTIVO_EXCECAO").show();',
'      apex.item("P52_MOTIVO_EXCECAO").disable();',
'',
'	  } else {',
'      ',
'      //alert("PAGE LOAD #05");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'	  }',
'',
'	} else {',
'		',
'    //alert("PAGE LOAD #06");',
'    ',
'		apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'',
'	}',
'',
'//alert("PAGE LOAD #07");',
'',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'    ',
'    //alert("PAGE LOAD #08");',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'    ',
'    //alert("PAGE LOAD #09");',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879545402785908504)
,p_name=>'AJUSTAR REMUNERACAO'
,p_event_sequence=>1778
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879239407267908356)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879545880943908505)
,p_event_id=>wwv_flow_api.id(37879545402785908504)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P52_AJUSTAR_REMUNERACAO := ''S'';',
':P52_FLAG := NULL;',
':P52_MENSAGEM := NULL;'))
,p_attribute_03=>'P52_AJUSTAR_REMUNERACAO,P52_MENSAGEM,P52_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879546337428908505)
,p_event_id=>wwv_flow_api.id(37879545402785908504)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//alert("item #01");',
'',
'if (apex.item("P52_ROWID").getValue().length == 0 ){',
'  ',
'  //alert("item #02");',
'  ',
'	if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue().length > 0 ){',
'		',
'    //alert("item #03");',
'    ',
'	  apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'	  if (apex.item("P52_PERC_BENEFICIO_VARIAVEL").getValue() == 0 ){',
'      ',
'      //alert("item #04");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").show();',
'	  	apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  } else {',
'      ',
'      //alert("item #05");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'',
'	  }',
'',
'	} else {',
'    ',
'    //alert("item #06");',
'		',
'		apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'	}',
'',
'',
'}else{',
'',
' //alert("item #07");',
'  ',
'  if (apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 ){',
'',
'   //alert("item #08");',
'    ',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'    if ( apex.item("P52_PERC_BENEFICIO").getValue().trim() > 0 || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 20 ||',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 30 ||',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "0,00" ||',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "20,00" ||',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "30,00"){',
'',
'     //alert("item #09");',
'      ',
'      $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'      apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'      $x(''P52_SALARIO'').disabled = true;',
'      apex.item("P52_SALARIO").disable();',
'',
'      apex.item("P52_PERC_BENEF_EXCECAO").show();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue(apex.item("P52_PERC_BENEFICIO").getValue());',
'      apex.item("P52_MOTIVO_EXCECAO").show();',
'',
'    } else {',
'      ',
'     //alert("item #10");',
'',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'        ',
'    }',
'',
'  } else {',
'    ',
'   //alert("item #11");',
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'      ',
'     //alert("item #12");',
'      ',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'        ',
'  }',
'',
'}',
'',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879546769957908505)
,p_name=>unistr('Vinculo (E)stagi\00E1rio')
,p_event_sequence=>1788
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_VINCULO_X'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'E'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879547273418908505)
,p_event_id=>wwv_flow_api.id(37879546769957908505)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879547775879908505)
,p_event_id=>wwv_flow_api.id(37879546769957908505)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879548729539908506)
,p_event_id=>wwv_flow_api.id(37879546769957908505)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const e = document.getElementById(''P52_TOTAL_SALARIO'');',
'let f = e.className.search(''apex_disabled'') == -1;',
'if(!apex.item(''P52_TOTAL_SALARIO'').isDisabled() && !$x(''P52_TOTAL_SALARIO'').disabled && f){',
'	apex.item(''P52_PERC_BENEFICIO_VARIAVEL'').enable();',
'}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879549220835908506)
,p_name=>'Vinculo (C)ontratado'
,p_event_sequence=>1798
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_VINCULO_X'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879549637584908507)
,p_event_id=>wwv_flow_api.id(37879549220835908506)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879550160452908508)
,p_event_id=>wwv_flow_api.id(37879549220835908506)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879550681446908508)
,p_event_id=>wwv_flow_api.id(37879549220835908506)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TRAB_INTERMITENTE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879551111013908508)
,p_name=>'(Pesquisa) Dados de Vaga'
,p_event_sequence=>1808
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_ROWID IS NOT NULL AND :P52_COD_VAGA_1 IS NOT NULL AND :P52_COD_SIT_REQ <> 0 THEN',
'RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879551534261908509)
,p_event_id=>wwv_flow_api.id(37879551111013908508)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'nvl(a.cod_horario,a.cod_horario_jornada) cod_horario,',
'a.cod_sindicato,',
'a.cod_unidade_adm,',
'a.cod_atividade,',
'a.vinculo,',
'a.cod_un_negocio,',
'a.cod_cargo,',
'a.cod_funcao,',
'a.cod_categoria',
'  from cl_vaga                a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga;',
'',
'cursor c2 is',
'select r.cod_horario',
'  from requisicao r',
'where r.rowid = :P52_ROWID;   ',
'   ',
'v_c1 c1%rowtype;',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2;',
'fetch c2 into v_c2;',
'close c2;',
'',
':P52_COD_CCUSTO_X := V_C1.COD_CCUSTO;',
':P52_COD_UNIDADE_ADM_X := V_C1.COD_UNIDADE_ADM;',
':P52_COD_ATIVIDADE_X := V_C1.COD_ATIVIDADE;',
':P52_COD_LOCAL_TRAB_X := V_C1.COD_LOCAL_TRAB;',
':P52_COD_CCUSTO_CONTAB_X := V_C1.COD_CCUSTO_CONTAB;',
':P52_VINCULO_X := V_C1.VINCULO;',
':P52_COD_UN_NEGOCIO_X := V_C1.COD_UN_NEGOCIO;',
':P52_COD_CARGO_X := V_C1.COD_CARGO;',
':P52_COD_FUNCAO_X := V_C1.COD_FUNCAO;',
':P52_COD_CATEGORIA_X := V_C1.COD_CATEGORIA;',
':P52_COD_SINDICATO_X := V_C1.COD_SINDICATO;',
'--:P52_COD_HORARIO_X := V_C2.COD_HORARIO;',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_COD_CCUSTO_CONTAB_X,P52_VINCULO_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879552006217908509)
,p_name=>'(Anexo 1) Limpar'
,p_event_sequence=>1818
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879204951082908337)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879552510278908509)
,p_event_id=>wwv_flow_api.id(37879552006217908509)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_ANEXO_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879552878314908509)
,p_name=>'(Anexo 1) Valida Tamanho de Arquivo '
,p_event_sequence=>1828
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_ANEXO_1'
,p_condition_element=>'P52_ANEXO_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879553372088908509)
,p_event_id=>wwv_flow_api.id(37879552878314908509)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#CLEAR_ANEXO_1'').show();',
'',
'var fileSize = $x(''P52_ANEXO_1'').files[0].size;',
'',
'console.log(fileSize);',
'',
'if (fileSize > 2000000){',
'$(''#CREATE'').hide();',
'$(''#SAVE'').hide();',
unistr('alert(''O Tamanho do Arquivo est\00E1 excedendo o lim\00EDte de 2Mb! Redimensione ou diminua a qualidade do arquivo para que possa continuar!'');'),
'} else {',
'$(''#CREATE'').show();',
'$(''#SAVE'').show();',
'}',
'',
'/*if (apex.item("P52_ROWID").getValue().length > 0 && apex.item("P52_COD_SIT_REQ").getValue != "0") {',
'    apex.item("P52_ANEXO_1").disable();',
'}*/',
'',
unistr('// Verifica se est\00E1 em modo de altera\00E7\00E3o ou inclus\00E3o'),
'if (apex.item("P52_ROWID").getValue().length == 0) {',
unistr('    // Inclus\00E3o: sempre habilita'),
'    apex.item("P52_ANEXO_1").enable();',
'} else {',
unistr('    // Altera\00E7\00E3o: s\00F3 habilita se COD_SIT_REQ = ''1'' Aberta'),
'    if (apex.item("P52_COD_SIT_REQ").getValue() == "1") {',
'        apex.item("P52_ANEXO_1").enable();',
'    } else {',
'        apex.item("P52_ANEXO_1").disable();',
'    }',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879553894507908510)
,p_event_id=>wwv_flow_api.id(37879552878314908509)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#CLEAR_ANEXO_1'').hide();',
'',
'/*if (apex.item("P52_ROWID").getValue().length > 0 && apex.item("P52_COD_SIT_REQ").getValue != "0") {',
'    apex.item("P52_ANEXO_1").disable();',
'}*/',
'',
unistr('// Verifica se est\00E1 em modo de altera\00E7\00E3o ou inclus\00E3o'),
'if (apex.item("P52_ROWID").getValue().length == 0) {',
unistr('    // Inclus\00E3o: sempre habilita'),
'    apex.item("P52_ANEXO_1").enable();',
'} else {',
unistr('    // Altera\00E7\00E3o: s\00F3 habilita se COD_SIT_REQ = ''1'''),
'    if (apex.item("P52_COD_SIT_REQ").getValue() == "1") {',
'        apex.item("P52_ANEXO_1").enable();',
'    } else {',
'        apex.item("P52_ANEXO_1").disable();',
'    }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879554240292908510)
,p_name=>unistr('(Sindicato) Valida Valor de Remunera\00E7\00E3o')
,p_event_sequence=>1838
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_SINDICATO_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879554816206908511)
,p_event_id=>wwv_flow_api.id(37879554240292908510)
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
'v_item_validacao varchar2(100) := :P52_ITEM_VALIDACAO;',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel NUMBER := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'--v_remuneracao_variavel NUMBER := :p52_remuneracao_variavel;',
'',
'begin',
'null;',
'/*',
'v_item_validacao := NULL;',
':P52_ITEM_VALIDACAO := null;',
'',
' :p52_mensagem := null;',
' :p52_ok       := ''S'';',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio);',
'',
'if v_remuneracao_variavel < v_valor_beneficio AND nvl(v_valor_beneficio,0) > 0 then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Valor de benef\00EDcios R$''||:p52_remuneracao_variavel||'' n\00E3o pode ser menor que o valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio||''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'';'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and v_remuneracao_variavel <> nvl(v_valor_beneficio,0) and :p52_perc_beneficio_variavel is null and :P52_PERC_BENEF_EXCECAO is null then',
'v_flg_retorno := ''N'';',
unistr('v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio||''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'';'),
'end if;',
'',
'if nvl(v_valor_beneficio,0) > 0 and ',
'   v_remuneracao_variavel <> nvl(v_valor_beneficio,0) and ',
'   :P52_PERC_BENEFICIO_VARIAVEL is null and ',
'   :P52_PERC_BENEF_EXCECAO is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''Para Full-CLT, o valor de benef\00EDcios n\00E3o pode ser diferente do valor obrigat\00F3rio do sindicato de R$''||v_valor_beneficio||'),
unistr('     case when :p52_rowid is not null then ''. Clique no bot\00E3o "Ajustar Valores" e informe os dados corretamente.'' else ''.'' end;'),
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
'    :P52_ITEM_VALIDACAO := TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL''));',
'    :p52_ok       := ''N'';',
'    :p52_flag     := v_flg_retorno;',
'    :p52_mensagem := v_msg_retorno;',
' else',
'    :p52_flag     := null;',
'    :p52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P52_REMUNERACAO_VARIAVEL'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'*/',
'',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_REMUNERACAO_VARIAVEL,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_VINCULO_X,P52_PERC_BENEFICIO_VARIAVEL,P'
||'52_PERC_BENEF_EXCECAO,P52_ROWID'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879555073018908511)
,p_name=>unistr('Ajustar Remunera\00E7\00E3o = ''S''')
,p_event_sequence=>1848
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_AJUSTAR_REMUNERACAO'
,p_condition_element=>'P52_AJUSTAR_REMUNERACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37862764107900166103)
,p_event_id=>wwv_flow_api.id(37879555073018908511)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_total_salario           number := replace(replace(:p52_total_salario,''R$''),''.'');',
'v_salario                 number := replace(replace(:p52_salario,''R$''),''.'');',
'v_remuneracao_variavel    number := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'v_perc_beneficio_variavel number := replace(replace(:p52_perc_beneficio_variavel,''R$''),''.'');',
'v_perc_benef_excecao      number := replace(replace(:p52_perc_benef_excecao,''R$''),''.'');',
'v_perc_beneficio          number := replace(replace(:P52_PERC_BENEFICIO,''R$''),''.'');',
'v_vlr_aux_tipo_modalidade number := replace(replace(:P52_VLR_AUX_TIPO_MODALIDADE,''R$''),''.'');',
'',
'begin',
'/*',
'pkg_pessoal.prc_popula_salario (:p52_cod_empresa,',
':p52_cod_filial,',
':p52_cod_ccusto,',
':p52_cod_cargo,',
':p52_cod_sindicato,',
':p52_cod_unidade_adm,',
':p52_cod_un_negocio,',
':p52_cod_atividade,',
':p52_cod_vaga,',
':p52_refeitorio,',
':p52_vinculo_x,',
':p52_rt_jornada_mensal_x,',
':p52_total_salario,',
':p52_perc_beneficio_variavel,',
':p52_perc_benef_excecao,',
':p52_vlr_aux_tipo_modalidade,',
':p52_salario,',
':p52_remuneracao_variavel,',
':p52_perc_beneficio);',
'*/',
'',
'pkg_pessoal.retorna_benef_sindicato (:p52_cod_empresa,',
'                                   :p52_cod_filial,',
'                                   :p52_cod_ccusto,',
'                                   :p52_cod_cargo,',
'                                   :p52_cod_sindicato,',
'                                   :p52_cod_unidade_adm,',
'                                   :p52_cod_un_negocio,',
'                                   :p52_cod_atividade,',
'                                   :p52_cod_vaga,',
'                                   :p52_refeitorio,',
'                                   :P52_VINCULO_X,',
'                                    v_valor_beneficio,',
'                                    V_PERC_BENEFICIO,',
'                                    :P52_RT_JORNADA_MENSAL_X,',
'                                    :p52_cod_horario_x);',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'  if v_perc_beneficio_variavel is null then -- Full-CLT',
'    v_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
'    v_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'  elsif v_perc_beneficio_variavel > 0 then -- Flex (20% ou 30%)',
'    v_salario := round((v_total_salario * ((100-v_perc_beneficio_variavel)/100)),2);',
'    v_remuneracao_variavel := round((v_total_salario * (v_perc_beneficio_variavel/100)),2);',
unistr('  elsif v_perc_beneficio_variavel = 0 then -- Flex (Exce\00E7\00E3o)'),
'    if nvl(v_perc_benef_excecao,0) > 0 then',
'       v_remuneracao_variavel := round((v_total_salario * (v_perc_benef_excecao/100)),2);',
'       v_salario := v_total_salario - (nvl(v_remuneracao_variavel,0));',
'    else',
'       v_remuneracao_variavel := null;',
'       v_salario := v_total_salario - v_remuneracao_variavel;',
'    end if;',
'  end if;',
'',
'  IF V_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     V_PERC_BENEFICIO := V_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF NVL(V_PERC_BENEFICIO_VARIAVEL,0) = 0 AND NVL(v_perc_benef_excecao,0) > 0 THEN',
'     V_PERC_BENEFICIO := v_perc_benef_excecao;',
'  ELSIF NVL(V_PERC_BENEFICIO_VARIAVEL,0) > 0 AND NVL(v_perc_benef_excecao,0) > 0 THEN',
'     V_PERC_BENEFICIO := v_perc_benef_excecao;',
'  ELSIF V_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(v_perc_benef_excecao,0) = 0 THEN',
'     V_PERC_BENEFICIO := NULL;',
'  END IF;',
'',
':P52_SALARIO := v_salario;',
':P52_REMUNERACAO_VARIAVEL := v_remuneracao_variavel;',
':P52_PERC_BENEFICIO := v_perc_beneficio;',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_VLR_AUX_TIPO_MODALIDADE,P52_PERC_BENEF_EXCECAO,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_PERC_BENEFICIO,P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879555556820908511)
,p_event_id=>wwv_flow_api.id(37879555073018908511)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P52_TIPO_SALARIO").enable();',
'apex.item("P52_TOTAL_SALARIO").enable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").enable();',
'apex.item("P52_PERC_BENEF_EXCECAO").enable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'apex.item("P52_SALARIO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'apex.item("P52_MOTIVO_EXCECAO").enable();',
'apex.item("P52_PERC_BENEFICIO").enable();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879556095474908512)
,p_event_id=>wwv_flow_api.id(37879555073018908511)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'		//alert(''#000 P52_PERC_BENEFICIO ''+ apex.item("P52_PERC_BENEFICIO").getValue() );',
'',
'if (Number(apex.item("P52_PERC_BENEFICIO").getValue().replace('','', ''.'')) > 0){',
'		//alert(''#001'');',
'	  apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'	  if (apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 0 && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 20 && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 30 &&',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "0,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "20,00" && ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "30,00" && ',
'         Number(apex.item("P52_PERC_BENEFICIO").getValue().replace('','', ''.'')) != 0 && ',
'         Number(apex.item("P52_PERC_BENEFICIO").getValue().replace('','', ''.'')) != 20 && ',
'         Number(apex.item("P52_PERC_BENEFICIO").getValue().replace('','', ''.'')) != 30){',
'',
'      //alert(''#002'');',
'      ',
'    	  $x(''P52_REMUNERACAO_VARIAVEL'').disabled = false;',
'    	  apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'      ',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'      ',
'      apex.item("P52_PERC_BENEF_EXCECAO").show();',
'      apex.item("P52_PERC_BENEF_EXCECAO").setValue(apex.item("P52_PERC_BENEFICIO").getValue());',
'      apex.item("P52_MOTIVO_EXCECAO").show();',
'      apex.item("P52_MOTIVO_EXCECAO").enable();',
'      ',
'     //alert(''#003'');',
'	  } else {',
'    //alert(''#004'');',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'	  	apex.item("P52_MOTIVO_EXCECAO").hide();',
'	  	apex.item("P52_PERC_BENEF_EXCECAO").setValue("");',
'',
'    	$x(''P52_REMUNERACAO_VARIAVEL'').disabled = true;',
'    	apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'    	$x(''P52_SALARIO'').disabled = true;',
'    	apex.item("P52_SALARIO").disable();',
'      ',
'      //alert(''#005'');',
'	  }',
'',
'  //alert(''#006'');',
'  ',
'	} else {',
'  //alert(''#007'');',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'',
'	}',
'//alert(''#008'');',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'    ',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'    ',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879556449112908512)
,p_name=>'Nao Apagar RT_JORNADA_MENSAL'
,p_event_sequence=>1858
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879557009335908512)
,p_event_id=>wwv_flow_api.id(37879556449112908512)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select rt_jornada_mensal, cod_horario',
'  from requisicao ',
' where cod_req = :p52_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_rt_jornada_mensal varchar2) is',
'Select R.cod ',
'from REG_TRABALHO R',
'WHERE R.COD <> ''NUL''',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' and r.cod = v_rt_jornada_mensal',
' and not exists (select 1 ',
'                   from sind_reg_trabalho x ',
'                  where x.cod_empresa = r.cod_empresa ',
'                    and x.cod_sindicato = :p52_cod_sindicato_x',
'                )',
' union',
' Select R.cod',
'from REG_TRABALHO R, SIND_REG_TRABALHO S',
'WHERE R.COD <> ''NUL''',
' AND R.COD = S.COD_REG_TRAB',
' AND R.COD_EMPRESA = S.COD_EMPRESA',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' AND S.COD_SINDICATO = :P52_COD_SINDICATO_x',
' and r.cod = v_rt_jornada_mensal;',
' ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'open c2(v_c1.rt_jornada_mensal);',
'fetch c2 into v_c2;',
'close c2;',
'',
'insert into testex values(:p52_cod_req, v_c2.cod||'', ''||v_c1.rt_jornada_mensal||'', ''||v_c1.cod_horario); commit;',
'',
'if v_c2.cod is not null then',
' :p52_rt_jornada_mensal_Z := v_c1.rt_jornada_mensal;',
' :p52_cod_horario_Z := v_c1.cod_horario;',
'else',
' :p52_rt_jornada_mensal_Z := null;',
' :p52_cod_horario_Z := null;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_REQ,P52_COD_EMPRESA,P52_COD_SINDICATO_X'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL_Z,P52_COD_HORARIO_Z'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879557370574908512)
,p_name=>'Clear RT_JORNADA_MENSAL'
,p_event_sequence=>1868
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879557866676908513)
,p_event_id=>wwv_flow_api.id(37879557370574908512)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'Select R.cod codigo_regime',
'from REG_TRABALHO R',
'WHERE R.COD <> ''NUL''',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' and not exists (select 1 ',
'                   from sind_reg_trabalho x ',
'                  where x.cod_empresa = r.cod_empresa ',
'                    and x.cod_sindicato = :p52_cod_sindicato',
'                )',
' union',
' Select R.cod codigo_regime',
'from REG_TRABALHO R, SIND_REG_TRABALHO S',
'WHERE R.COD <> ''NUL''',
' AND R.COD = S.COD_REG_TRAB',
' AND R.COD_EMPRESA = S.COD_EMPRESA',
' AND R.COD_EMPRESA = :p52_cod_empresa',
' AND S.COD_SINDICATO = :P52_COD_SINDICATO;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.codigo_regime <> :p52_rt_jornada_mensal then',
'  :p52_rt_jornada_mensal := null;',
'else',
'  :p52_rt_jornada_mensal := v_c1.codigo_regime;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_SINDICATO,P52_RT_JORNADA_MENSAL'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879558263097908513)
,p_name=>'Set Value RT_JORNADA_MENSAL'
,p_event_sequence=>1878
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL_Z'
,p_condition_element=>'P52_RT_JORNADA_MENSAL_Z'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879558727061908513)
,p_event_id=>wwv_flow_api.id(37879558263097908513)
,p_event_result=>'TRUE'
,p_action_sequence=>1
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_rt_jornada_mensal := nvl(:p52_rt_jornada_mensal_z,:P52_RT_JORNADA_MENSAL);'
,p_attribute_02=>'P52_RT_JORNADA_MENSAL_Z,P52_RT_JORNADA_MENSAL'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37879559165376908514)
,p_name=>'Set Value COD_HORARIO'
,p_event_sequence=>1888
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO_Z'
,p_condition_element=>'P52_COD_HORARIO_Z'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37879559631314908515)
,p_event_id=>wwv_flow_api.id(37879559165376908514)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_cod_horario := nvl(:p52_cod_horario_z,:P52_COD_HORARIO);',
''))
,p_attribute_02=>'P52_COD_HORARIO_Z,P52_COD_HORARIO'
,p_attribute_03=>'P52_COD_HORARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37885722212644192720)
,p_name=>'P52_COD_HORARIO_V19'
,p_event_sequence=>1908
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37885722313140192721)
,p_event_id=>wwv_flow_api.id(37885722212644192720)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if($(''#P52_COD_HORARIO'').attr(''value'').length > 0 && $(''#P52_COD_HORARIO'').val() == ''''){',
'	$(''#P52_COD_HORARIO'').val($(''#P52_COD_HORARIO'').attr(''value''));',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37913307638884666201)
,p_name=>'Novo'
,p_event_sequence=>1918
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37879127043764908292)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(38461889253304029996)
,p_name=>'Set Sindicato Aux'
,p_event_sequence=>1928
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(38461889362739029997)
,p_event_id=>wwv_flow_api.id(38461889253304029996)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_SINDICATO_AUX := :P52_COD_SINDICATO;'
,p_attribute_02=>'P52_COD_SINDICATO'
,p_attribute_03=>'P52_COD_SINDICATO_AUX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(38461889615084029999)
,p_name=>'Alerta Sindicato'
,p_event_sequence=>1938
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_AUX'
,p_condition_element=>'P52_COD_SINDICATO_AUX'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_ROWID IS NOT NULL AND :P52_COD_SIT_REQ <> 0 AND :P52_COD_VAGA_1 IS NULL THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(38461889678406030000)
,p_event_id=>wwv_flow_api.id(38461889615084029999)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('O campo Sindicato n\00E3o pode ser nulo!!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37671817339002162206)
,p_name=>'Valida Aprovador'
,p_event_sequence=>1948
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37671817352211162207)
,p_event_id=>wwv_flow_api.id(37671817339002162206)
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
'v_item_validacao varchar2(20) := :P52_ITEM_VALIDACAO;',
'',
'cursor c1 is',
'select cod_empresa, filial, cod_ccusto, matricula',
'  from informacoes_funcionais_cad',
' where cod_empresa = :p_empresa_user',
'   and matricula = :p_matricula_user;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if nvl(:P52_OK,''S'') = ''S'' and 1 = 2 then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'v_flg_retorno := pkg_req.VALIDA_EXISTE_APROV(v_c1.cod_empresa,',
'                                              v_c1.filial,',
'                                              v_c1.cod_ccusto,',
'                                              v_c1.matricula,',
'                                              :p_empresa_user, ',
'                                              :p_matricula_user, ',
'                                              null, ',
'                                              ''REQ_PESSOAL'');',
'',
'    if nvl(v_flg_retorno,''S'') = ''N'' then',
unistr('       v_msg_retorno := ''N\00E3o foi parametrizado aprovadores para sua requisi\00E7\00E3o. Por favor, entrar em contato com os administradores do sistema!'';'),
'    else ',
'       v_flg_retorno := ''S'';',
'    end if;',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P52_ok       := ''N'';',
'        :P52_ITEM_VALIDACAO := TRIM(UPPER(''CREATE''));',
'    else',
'        :P52_ok       := ''S'';',
'    end if;',
'    ',
'    :P52_flag     := v_flg_retorno;',
'    :P52_mensagem := v_msg_retorno;',
' else',
'    :P52_flag     := null;',
'    :P52_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''CREATE'')) OR v_item_validacao IS NULL then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER,P52_ITEM_VALIDACAO,P52_OK'
,p_attribute_03=>'P52_OK,P52_FLAG,P52_MENSAGEM,P52_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37382432272251857747)
,p_name=>'Revisar'
,p_event_sequence=>1958
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37382432197905857746)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37382432341728857748)
,p_event_id=>wwv_flow_api.id(37382432272251857747)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja prosseguir com a revis\00E3o da requisi\00E7\00E3o? Ser\00E1 poss\00EDvel ajustar algumas informa\00E7\00F5es e as aprova\00E7\00F5es dever\00E3o ser realizadas novamente.'', function (e) {'),
'	    if (e) {',
'',
'          apex.item("P52_REFEITORIO").enable();',
'          apex.item("P52_COD_SIT_REQ").setValue("0");',
'          document.getElementById("SAVE").click();',
'        ',
'	    }else{',
unistr('        console.log("N\00E3o prosseguir.");'),
'      }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37495108958199432662)
,p_name=>'Suspender'
,p_event_sequence=>1968
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37495108853466432661)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495108999486432663)
,p_event_id=>wwv_flow_api.id(37495108958199432662)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja prosseguir com a suspens\00E3o da requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'',
'          apex.item("P52_REFEITORIO").enable();',
'          apex.item("P52_COD_SIT_REQ").setValue("6");',
'          document.getElementById("SAVE").click();',
'        ',
'	    }else{',
unistr('        console.log("N\00E3o prosseguir.");'),
'      }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37495108647660432659)
,p_name=>'Publicar'
,p_event_sequence=>1978
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37495108579038432658)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495108782829432660)
,p_event_id=>wwv_flow_api.id(37495108647660432659)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja prosseguir com a publica\00E7\00E3o da requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'',
'          apex.item("P52_REFEITORIO").enable();',
'          apex.item("P52_COD_SIT_REQ").setValue("1");',
'          apex.item("P52_IND_REVISADO").setValue("S");',
'          document.getElementById("SAVE").click();',
'        ',
'	    }else{',
unistr('        console.log("N\00E3o prosseguir.");'),
'      }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37495107196197432644)
,p_name=>unistr('Cancelar Requisi\00E7\00E3o')
,p_event_sequence=>1988
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37495106983999432642)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495107339577432646)
,p_event_id=>wwv_flow_api.id(37495107196197432644)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('alertify.set({labels:{ok:"Sim",cancel:"N\00E3o"},buttonReverse:false,buttonFocus:"ok"});'),
'',
unistr('	alertify.confirm(''Deseja prosseguir com o cancelamento da requisi\00E7\00E3o?'', function (e) {'),
'	    if (e) {',
'          apex.item("P52_REFEITORIO").enable();',
'          apex.item("P52_COD_SIT_REQ").setValue("3");',
'          ',
'          if (apex.item("P52_POSSUI_MOTIVO_REQ").getValue() == "S") {',
'             $(''#MOTIVO'').dialog(''open'');',
'          }else{',
'        ',
'             document.getElementById("SAVE").click();',
'            ',
'          }',
'        ',
'	    }else{',
unistr('        console.log("N\00E3o prosseguir.");'),
'      }',
'	    ',
'	    document.getElementById("alertify-cover").style.position="static";',
'	});'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(37495108161975432654)
,p_name=>'Confirma_sit_req'
,p_event_sequence=>1998
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(37495107903982432652)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(37495108325478432656)
,p_event_id=>wwv_flow_api.id(37495108161975432654)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_MOT_SIT_REQ").getValue().length == 0){',
'   alertify.alert(''Informe o motivo antes de prosseguir!'');',
'}else{',
'   document.getElementById("SAVE").click();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(29306578744520907495)
,p_name=>unistr('Ap\00F3s upload de arquivo')
,p_event_sequence=>2008
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(179886859503200070394)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(29306578937004907497)
,p_event_id=>wwv_flow_api.id(29306578744520907495)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*window.location.href = window.location.href;*/',
'  apex.region("relatorio_anexos").refresh();',
' /*apex.region("detalhamento").refresh();*/',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(28304464569337588763)
,p_name=>'Popula PCD'
,p_event_sequence=>2018
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(28304464655732588764)
,p_event_id=>wwv_flow_api.id(28304464569337588763)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_IND_DEF_FIS is null then',
'',
'  ',
'   :P52_IND_DEF_FIS := ''N'';',
'   ',
'  ',
'end if;'))
,p_attribute_02=>'P52_IND_DEF_FIS'
,p_attribute_03=>'P52_IND_DEF_FIS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(20333689650838225612)
,p_name=>unistr('Popula Prospec\00E7\00E3o')
,p_event_sequence=>2028
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(20333689742185225613)
,p_event_id=>wwv_flow_api.id(20333689650838225612)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_PROSPECCAO is null then',
'',
'  ',
'   :P52_PROSPECCAO := ''N'';',
'   ',
'  ',
'end if;'))
,p_attribute_02=>'P52_PROSPECCAO'
,p_attribute_03=>'P52_PROSPECCAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(26259400850864465148)
,p_name=>'Beneficio exc null'
,p_event_sequence=>2038
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(26259400971223465149)
,p_event_id=>wwv_flow_api.id(26259400850864465148)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_PERC_BENEFICIO_VARIAVEL IS NULL THEN ',
':P52_PERC_BENEF_EXCECAO := NULL;',
'END IF;'))
,p_attribute_02=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_attribute_03=>'P52_PERC_BENEF_EXCECAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(16401490453954435562)
,p_name=>'Desabilita Tipo de Vaga'
,p_event_sequence=>2048
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'   v_controlada_req_pessoal varchar2(1);',
'begin',
'   select controlada_req_pessoal',
'     into v_controlada_req_pessoal ',
'     from configuracoes; ',
'  if v_controlada_req_pessoal = ''S'' then',
'    return true; ',
'  else',
'    return false;',
'  end if;',
'end;  '))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16401490578181435563)
,p_event_id=>wwv_flow_api.id(16401490453954435562)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_FLAG_TEMPORARIO'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(16410147144927951215)
,p_event_id=>wwv_flow_api.id(16401490453954435562)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_FLAG_TEMPORARIO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15068288439702881687)
,p_name=>'HABILITA_CAMPOS_P52_TIPO_PONTO'
,p_event_sequence=>2058
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_PONTO'
,p_condition_element=>'P52_TIPO_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'J'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068288591006881688)
,p_event_id=>wwv_flow_api.id(15068288439702881687)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_JORNADA,P52_ESCALA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068288647575881689)
,p_event_id=>wwv_flow_api.id(15068288439702881687)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_JORNADA,P52_ESCALA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068289863705881701)
,p_event_id=>wwv_flow_api.id(15068288439702881687)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_JORNADA,P52_ESCALA'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15068288784066881690)
,p_name=>'HABILITA_CAMPOS_P52_TIPO_PONTO_1'
,p_event_sequence=>2068
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_PONTO'
,p_condition_element=>'P52_TIPO_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068288847948881691)
,p_event_id=>wwv_flow_api.id(15068288784066881690)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068288943791881692)
,p_event_id=>wwv_flow_api.id(15068288784066881690)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO,P52_CICLO_INICIAL,P52_CICLO_DAT_INICIAL,P52_CICLO_DAT_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068290081753881703)
,p_event_id=>wwv_flow_api.id(15068288784066881690)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO,P52_CICLO_INICIAL,P52_CICLO_DAT_INICIAL,P52_CICLO_DAT_FINAL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(15068289038294881693)
,p_name=>'DADOS_CICLO'
,p_event_sequence=>2078
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CICLO'
,p_condition_element=>'P52_CICLO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068289179278881694)
,p_event_id=>wwv_flow_api.id(15068289038294881693)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO_INICIAL,P52_CICLO_DAT_INICIAL,P52_CICLO_DAT_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068289468081881697)
,p_event_id=>wwv_flow_api.id(15068289038294881693)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO_INICIAL,P52_CICLO_DAT_INICIAL,P52_CICLO_DAT_FINAL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(15068289819415881700)
,p_event_id=>wwv_flow_api.id(15068289038294881693)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CICLO_INICIAL,P52_CICLO_DAT_INICIAL,P52_CICLO_DAT_FINAL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879314053038908403)
,p_process_sequence=>90
,p_process_point=>'AFTER_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(Pesquisa) Popula Campos_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'  cursor c1 is',
'  select distinct t.cod||'' - ''||initcap(t.descricao) atividade',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     AND T.COD = :P52_COD_ATIVIDADE_X',
'     and :P52_COD_REQ IS NOT NULL;',
'     ',
'  v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p52_cod_req is not null and :p52_cod_vaga is not null then',
'',
':P52_COD_CCUSTO_1 := :P52_COD_CCUSTO_X;',
':P52_COD_UNIDADE_ADM_1 := :P52_COD_UNIDADE_ADM_X;',
':P52_COD_ATIVIDADE_1 := :P52_COD_ATIVIDADE_X;',
':P52_COD_LOCAL_TRAB_1 := :P52_COD_LOCAL_TRAB_X;',
':P52_VINCULO_1 := :P52_VINCULO_X;',
':P52_COD_CCUSTO_CONTAB_1 := :P52_COD_CCUSTO_CONTAB_X;',
':P52_COD_UN_NEGOCIO_1 := :P52_COD_UN_NEGOCIO_X;',
':P52_COD_CARGO_1 := :P52_COD_CARGO_X;',
':P52_COD_FUNCAO_1 := :P52_COD_FUNCAO_X;',
':P52_COD_CATEGORIA_1 := :P52_COD_CATEGORIA_X;',
':P52_COD_SINDICATO_1 := :P52_COD_SINDICATO_X;',
':P52_RT_JORNADA_MENSAL_1 := :P52_RT_JORNADA_MENSAL_X;',
':P52_COD_HORARIO_1 := :P52_COD_HORARIO_X;',
'',
'elsif :p52_cod_req is not null and :p52_cod_vaga is null then',
'',
':P52_COD_CCUSTO := :P52_COD_CCUSTO_X;',
':P52_COD_UNIDADE_ADM := :P52_COD_UNIDADE_ADM_X;',
':P52_COD_ATIVIDADE := :P52_COD_ATIVIDADE_X;',
':P52_COD_LOCAL_TRAB := :P52_COD_LOCAL_TRAB_X;',
':P52_VINCULO := :P52_VINCULO_X;',
':P52_COD_CCUSTO_CONTAB := :P52_COD_CCUSTO_CONTAB_X;',
':P52_COD_UN_NEGOCIO := :P52_COD_UN_NEGOCIO_X;',
':P52_COD_CARGO := :P52_COD_CARGO_X;',
':P52_COD_FUNCAO := :P52_COD_FUNCAO_X;',
':P52_COD_CATEGORIA := :P52_COD_CATEGORIA_X;',
':P52_COD_SINDICATO := :P52_COD_SINDICATO_X;',
':P52_RT_JORNADA_MENSAL := :P52_RT_JORNADA_MENSAL_X;',
':P52_COD_HORARIO := :P52_COD_HORARIO_X;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879319650299908407)
,p_process_sequence=>10
,p_process_point=>'AFTER_FOOTER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Mat_Subs'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa, filial, cod_ccusto, cad_vaga, matricula',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p52_cod_empresa',
'    and matricula = :p52_mat_subs;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
'   if :p52_cod_req is null and :p52_mat_subs is not null then',
'',
'     open c1;',
'     fetch c1 into v_c1;',
'     close c1;',
'',
'     :p52_cod_filial := v_c1.filial;',
'     :p52_cod_ccusto := v_c1.cod_ccusto;',
'     :p52_cod_vaga := v_c1.cad_vaga;',
'',
'   end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_req',
'  from REQUISICAO',
' where cod_req = :p52_cod_req'))
,p_process_when_type=>'NOT_EXISTS'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879316825782908405)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_region_id=>wwv_flow_api.id(170359329777970691663)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Fetch Row from REQUISICAO'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod_req',
'  from REQUISICAO',
' where cod_req = :p52_cod_req'))
,p_process_when_type=>'EXISTS'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879312096778908401)
,p_process_sequence=>30
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Utiliza Secao'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'select utiliza_secao ',
'  into :p52_utiliza_secao',
'  from parametros_recursos_humanos ',
' where cod_empresa = :p52_cod_empresa;',
' ',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879312841276908402)
,p_process_sequence=>40
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Chamado Pela Req Deslig'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' flag_temporario, ',
'       i.cod_empresa, ',
'       i.filial,',
'       i.cod_ccusto,',
'       c.cod_ccusto_cont,',
'       c.cod_un_negocio,',
'       i.unidade_adm,',
'       i.cod_localizacao,',
'       i.vinculo,',
'       i.num_sind_diss,',
'       i.cargo,',
'       i.cod_horario,',
'       i.salario,',
'       i.remuneracao_variavel,',
'       i.total_remuneracao,',
'       i.perc_beneficio_variavel,',
'       p.sexo,',
'       p.instrucao grau_instrucao,',
'       p.ind_def_fis,',
'       p.rais_ind_def_auditiva,',
'       p.rais_ind_def_fisico,',
'       p.rais_ind_def_mental,',
'       p.rais_ind_def_multipla,',
'       p.rais_ind_def_visual,',
'       p.ind_def_fis_br,',
'       I.CAD_VAGA,',
'       i.tipo_modalidade,',
'       i.VLR_AUX_TIPO_MODALIDADE,',
'       i.trab_intermitente',
'  from informacoes_funcionais i,',
'       inf_pessoais p,',
'       centro_de_custo c',
' where i.cod_empresa = c.cod_empresa',
'   and i.cod_empresa = p.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p52_cod_empresa',
'   and i.matricula = :p52_mat_subs;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if V_C1.cad_vaga is null then',
'',
':P52_flag_temporario :=  v_c1.flag_temporario; ',
':P52_cod_empresa :=  v_c1.cod_empresa; ',
':P52_cod_filial := v_c1.filial;',
':P52_cod_ccusto := v_c1.cod_ccusto;',
':P52_cod_ccusto_contab := v_c1.cod_ccusto_cont;',
':P52_cod_un_negocio := v_c1.cod_un_negocio;',
':P52_cod_unidade_adm := v_c1.unidade_adm;',
':P52_cod_local_trab := v_c1.cod_localizacao;',
':P52_vinculo := v_c1.vinculo;',
':p52_trab_intermitente := v_c1.trab_intermitente;',
':P52_cod_sindicato := v_c1.num_sind_diss;',
':P52_cod_cargo := v_c1.cargo;',
':P52_cod_horario := v_c1.cod_horario;',
':P52_salario := v_c1.salario;',
':P52_remuneracao_variavel := v_c1.remuneracao_variavel;',
':P52_total_salario := v_c1.total_remuneracao;',
':p52_tipo_modalidade := v_c1.tipo_modalidade;',
':P52_VLR_AUX_TIPO_MODALIDADE := v_c1.VLR_AUX_TIPO_MODALIDADE;',
'',
'if v_c1.perc_beneficio_variavel in (20,30) then',
':P52_perc_beneficio_variavel := v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel > 0 and v_c1.perc_beneficio_variavel not in (20,30) then',
':P52_perc_beneficio_variavel := 0;',
':P52_perc_benef_excecao := v_c1.perc_beneficio_variavel;',
'end if;',
'',
':P52_sexo := v_c1.sexo;',
':P52_cod_instrucao := v_c1.grau_instrucao;',
':P52_ind_def_fis := v_c1.ind_def_fis;',
':P52_rais_ind_def_auditiva := v_c1.rais_ind_def_auditiva;',
':P52_rais_ind_def_fisico := v_c1.rais_ind_def_fisico;',
':P52_rais_ind_def_mental := v_c1.rais_ind_def_mental;',
':P52_rais_ind_def_multipla := v_c1.rais_ind_def_multipla;',
':P52_rais_ind_def_visual := v_c1.rais_ind_def_visual;',
'--:P52_ind_def_fis_br := v_c1.ind_def_fis_br;',
'',
'else',
'',
':P52_flag_temporario :=  ''N''; ',
':P52_cod_empresa :=  v_c1.cod_empresa; ',
':P52_cod_filial := v_c1.filial;',
':p52_cod_vaga := v_c1.cad_vaga;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'REQ_DESLIGAMENTO'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879313226208908402)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Chamado Pela Req Ferias'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' flag_temporario, ',
'       i.cod_empresa, ',
'       i.filial,',
'       i.cod_ccusto,',
'       c.cod_ccusto_cont,',
'       c.cod_un_negocio,',
'       i.unidade_adm,',
'       i.cod_localizacao,',
'       i.vinculo,',
'       i.num_sind_diss,',
'       i.cargo,',
'       i.cod_horario,',
'       i.salario,',
'       i.remuneracao_variavel,',
'       i.total_remuneracao,',
'       i.perc_beneficio_variavel,',
'       p.sexo,',
'       p.instrucao grau_instrucao,',
'       p.ind_def_fis,',
'       p.rais_ind_def_auditiva,',
'       p.rais_ind_def_fisico,',
'       p.rais_ind_def_mental,',
'       p.rais_ind_def_multipla,',
'       p.rais_ind_def_visual,',
'       p.ind_def_fis_br,',
'       I.CAD_VAGA,',
'       i.tipo_modalidade,',
'       i.VLR_AUX_TIPO_MODALIDADE,',
'       i.trab_intermitente',
'  from informacoes_funcionais i,',
'       inf_pessoais p,',
'       centro_de_custo c',
' where i.cod_empresa = c.cod_empresa',
'   and i.cod_empresa = p.cod_empresa',
'   and i.cod_ccusto = c.cod',
'   and i.matricula = p.matricula',
'   and i.cod_empresa = :p52_cod_empresa',
'   and i.matricula = :p52_mat_subs;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if V_C1.cad_vaga is null then',
'',
':P52_flag_temporario :=  v_c1.flag_temporario; ',
':P52_cod_empresa :=  v_c1.cod_empresa; ',
':P52_cod_filial := v_c1.filial;',
':P52_cod_ccusto := v_c1.cod_ccusto;',
':P52_cod_ccusto_contab := v_c1.cod_ccusto_cont;',
':P52_cod_un_negocio := v_c1.cod_un_negocio;',
':P52_cod_unidade_adm := v_c1.unidade_adm;',
':P52_cod_local_trab := v_c1.cod_localizacao;',
':P52_vinculo := v_c1.vinculo;',
':p52_trab_intermitente := v_c1.trab_intermitente;',
':P52_cod_sindicato := v_c1.num_sind_diss;',
':P52_cod_cargo := v_c1.cargo;',
':P52_cod_horario := v_c1.cod_horario;',
':P52_salario := v_c1.salario;',
':P52_remuneracao_variavel := v_c1.remuneracao_variavel;',
':P52_total_salario := v_c1.total_remuneracao;',
':p52_tipo_modalidade := v_c1.tipo_modalidade;',
':P52_VLR_AUX_TIPO_MODALIDADE := v_c1.VLR_AUX_TIPO_MODALIDADE;',
'',
'if v_c1.perc_beneficio_variavel in (20,30) then',
':P52_perc_beneficio_variavel := v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel > 0 and v_c1.perc_beneficio_variavel not in (20,30) then',
':P52_perc_beneficio_variavel := 0;',
':P52_perc_benef_excecao := v_c1.perc_beneficio_variavel;',
'end if;',
'',
':P52_sexo := v_c1.sexo;',
':P52_cod_instrucao := v_c1.grau_instrucao;',
':P52_ind_def_fis := v_c1.ind_def_fis;',
':P52_rais_ind_def_auditiva := v_c1.rais_ind_def_auditiva;',
':P52_rais_ind_def_fisico := v_c1.rais_ind_def_fisico;',
':P52_rais_ind_def_mental := v_c1.rais_ind_def_mental;',
':P52_rais_ind_def_multipla := v_c1.rais_ind_def_multipla;',
':P52_rais_ind_def_visual := v_c1.rais_ind_def_visual;',
'--:P52_ind_def_fis_br := v_c1.ind_def_fis_br;',
'',
'else',
'',
':P52_flag_temporario :=  ''N''; ',
':P52_cod_empresa :=  v_c1.cod_empresa; ',
':P52_cod_filial := v_c1.filial;',
':p52_cod_vaga := v_c1.cad_vaga;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'REQ_FERIAS'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879318882382908406)
,p_process_sequence=>60
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula_Solicitante'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' cursor c1 is',
' select cod_empresa||'' - ''||initcap(fnct_nome_empresa(cod_empresa))||'' / ''||',
'        matricula||'' - ''||initcap(fnct_nome_func(cod_empresa, matricula))||'' / ''||',
'        cargo||'' - ''||initcap(fnct_nome_cargo(cargo)) colaborador',
'   from informacoes_funcionais_cad',
'  where cod_empresa = :p52_cod_emp_req',
'    and matricula   = :p52_mat_req;',
'',
' v_c1 c1%rowtype;',
'',
'v_botoes_req varchar2(1);',
'',
'begin',
'',
'if :p52_cod_req is null then',
':P52_SEQ := to_number(to_char(sysdate,''ddmmrrrrhh24miss''));',
'end if;',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p52_solicitante := v_c1.colaborador;',
' end if;',
' ',
' begin',
' select botoes_req_pessoal into v_botoes_req from configuracoes;',
' :p52_botoes_req_pessoal := v_botoes_req;',
' exception',
' when others then',
' null;',
' end;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879319239360908406)
,p_process_sequence=>70
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'v_titulo varchar2(1000);',
'',
'cursor c_mot_sit_req is',
'select descricao',
'  from req_motivo_situacao',
' where cod = :p52_mot_sit_req;',
' ',
'v_mot_sit_req c_mot_sit_req%rowtype;',
'',
'begin',
'',
'',
'   if :p52_cod_sit_req = 1 and nvl(:p52_prospeccao,''N'') = ''N'' then',
'      v_sit := ''Aberta'';',
'elsif :p52_cod_sit_req = 1 and nvl(:p52_prospeccao,''N'') = ''S'' then',
unistr('      v_sit := ''Prospec\00E7\00E3o'';'),
'elsif :p52_cod_sit_req = 2 then',
unistr('      v_sit := ''Conclu\00EDda'';'),
'elsif :p52_cod_sit_req = 3 then',
'      v_sit := ''Cancelada'';',
'elsif :p52_cod_sit_req = 4 then',
'      v_sit := ''Reprovada'';',
'elsif :p52_cod_sit_req = 5 and nvl(:p52_prospeccao,''N'') = ''N'' then',
'      v_sit := ''Aprovada'';',
'elsif :p52_cod_sit_req = 5 and nvl(:p52_prospeccao,''N'') = ''S'' then',
unistr('      v_sit := ''Prospec\00E7\00E3o'';'),
'elsif :p52_cod_sit_req = 6 then',
unistr('      v_sit := ''Suspens\00E3o'';'),
'elsif :p52_cod_sit_req = 0 then',
unistr('      v_sit := ''Em Revis\00E3o'';'),
'end if;',
'',
':P52_ALTEROU_VAGA := ''N'';',
'',
'if :p52_rowid is not null then',
unistr('   v_titulo := ''Requisi\00E7\00E3o de Pessoal: N\00BA ''||:p52_cod_req||'' - ''||:p52_dt_req||'' (''||v_sit||'')'';'),
'   ',
'   if :p52_cod_req_pai is not null then',
unistr('   v_titulo := v_titulo||'' - Origem Req. N\00BA ''||:p52_cod_req_pai;'),
'   end if;',
'   ',
'else',
'   ',
unistr('   v_titulo := ''Requisi\00E7\00E3o de Pessoal'';'),
'end if;',
'',
':p52_titulo := v_titulo;',
'',
'if :p52_flag_temporario is null and :p52_rowid is null then',
':p52_flag_temporario := ''N'';',
'end if;',
'',
'open c_mot_sit_req;',
'fetch c_mot_sit_req into v_mot_sit_req;',
'close c_mot_sit_req;',
'',
':p52_mot_sit_req_dsp := v_mot_sit_req.descricao;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879315261693908404)
,p_process_sequence=>80
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula % Benef'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'    V_SALARIO NUMBER := replace(:P52_SALARIO,''.'');',
'    V_REMUNERACAO_VARIAVEL NUMBER := replace(:P52_REMUNERACAO_VARIAVEL,''.'');',
'',
'BEGIN',
'',
'IF :P52_ROWID IS NULL THEN',
':P52_AJUSTAR_REMUNERACAO := ''S'';',
'ELSE',
':P52_AJUSTAR_REMUNERACAO := ''N'';',
'END IF;',
'',
'    if :p52_rowid is not null then',
'',
'        IF :P52_PERC_BENEFICIO IN (20,30) THEN',
'        :P52_PERC_BENEFICIO_VARIAVEL := :P52_PERC_BENEFICIO;',
'        ELSIF NVL(:P52_PERC_BENEFICIO,0) = 0 THEN',
'        :P52_PERC_BENEFICIO_VARIAVEL := NULL;',
'        ELSE',
'        :P52_PERC_BENEFICIO_VARIAVEL := 0;',
'        :P52_PERC_BENEF_EXCECAO := :P52_PERC_BENEFICIO;',
'        END IF;',
'',
'        --:P52_total_salario := nvl(V_SALARIO,0) + nvl(V_REMUNERACAO_VARIAVEL,0);',
'        :P52_total_salario := nvl(V_SALARIO,0) + nvl(V_REMUNERACAO_VARIAVEL,0);-- + NVL(:P52_VLR_AUX_TIPO_MODALIDADE,0);',
'',
'    end if;',
'',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879315705157908404)
,p_process_sequence=>90
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Popula Descri\00E7\00F5es do Cargo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select c.cod_cbo||''-''||c.dc_cbo||'': ''||b.descricao cbo,',
'       d.desc_obj_cargo,',
'       d.texto texto_resp,',
'       desc_qualif_necessid,',
'       desc_pos_estru,',
'       desc_contr_rel,',
'       desc_sup_exerc,',
'       desc_complexidade,',
'       desc_risc_amb_trab ',
'  from cargos c, descricao_cargo d, cbo b, especificacao_cargo e',
' where c.cod = d.cod_cargo (+)',
'   and c.cod = e.cod_cargo (+)',
'   and c.cod_cbo = b.cod_cbo (+)',
'   and c.dc_cbo = b.dc_cbo (+)',
'   and c.cod = :p52_cod_cargo;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'       :p52_cbo := null;',
'       :p52_desc_obj_cargo := null;',
'       :p52_texto_resp := null;',
'       :p52_desc_qualif_necessid := null;',
'       :p52_desc_pos_estru := null;',
'       :p52_desc_contr_rel := null;',
'       :p52_desc_sup_exerc := null;',
'       :p52_desc_complexidade := null;',
'       :p52_desc_risc_amb_trab := null;',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'       :p52_cbo := v_c1.cbo;',
'       :p52_desc_obj_cargo := v_c1.desc_obj_cargo;',
'       :p52_texto_resp := v_c1.texto_resp;',
'       :p52_desc_qualif_necessid := v_c1.desc_qualif_necessid;',
'       :p52_desc_pos_estru := v_c1.desc_pos_estru;',
'       :p52_desc_contr_rel := v_c1.desc_contr_rel;',
'       :p52_desc_sup_exerc := v_c1.desc_sup_exerc;',
'       :p52_desc_complexidade := v_c1.desc_complexidade;',
'       :p52_desc_risc_amb_trab := v_c1.desc_risc_amb_trab;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879316067282908405)
,p_process_sequence=>100
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Processo Seletivo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_processo,',
'DECODE(status,''A'',''Ativo'',''F'',''Finalizado'',''C'',''Cancelado'') status,',
'cod_proc_anterior,',
'cod_prest_serv,',
'cod_tipo_processo,',
'cod_metrica,',
'dt_solicitacao,',
'dt_aprovacao,',
'dt_perfil,',
'dt_fechamento,',
'cod_entidade,',
'dt_ini_entidade,',
'dt_fim_entidade,',
'taxa,',
'valor,',
'observacao,',
'local',
'  from ps_processo_seletivo p',
' where p.cod_req = :p52_cod_req;',
'',
'v_c1 c1%rowtype;',
'',
'cursor c2 (v_cod_prest varchar2) is',
'SELECT PS.COD_PREST_SERV||'' - ''||PS.NOME||DECODE(GS.DESCRICAO,NULL,NULL,'''' - ''''||GS.DESCRICAO) NOME_PREST_SERV',
'FROM PRESTADOR_SERVICO PS, PS_DADOS_GRUPO_SELECAO DGS, PS_GRUPO_SELECAO GS',
'WHERE    GS.COD_PS_GRUPO(+)     = DGS.COD_PS_GRUPO',
'AND      DGS.COD_PREST_SERV(+)  = PS.COD_PREST_SERV',
'AND      DGS.TIPO_PREST_SERV(+) = PS.TIPO_PREST_SERV',
'AND      PS.TIPO_PREST_SERV = 5 ',
'and      PS.COD_PREST_SERV = v_cod_prest;',
'',
'V_C2 C2%ROWTYPE;',
'',
'cursor c3 (v_cod_metrica varchar2) is',
'SELECT TM.DESCRICAO metrica ',
'  FROM PS_TIPO_METRICAS TM ',
' where TM.COD_METRICA = v_cod_metrica;',
'',
'v_c3 c3%rowtype;',
'',
'cursor c4 (v_cod_tipo varchar2) is',
'SELECT DESCRICAO tipo_processo FROM PS_TIPO_PROCESSOS where COD_TIPO = v_cod_tipo;',
'',
'v_c4 c4%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_processo is not null then',
'',
'OPEN C2(v_c1.cod_prest_serv);',
'FETCH C2 INTO V_C2;',
'CLOSE C2;',
'',
'OPEN C3(v_c1.cod_metrica);',
'FETCH C3 INTO V_C3;',
'CLOSE C3;',
'',
'OPEN C4(v_c1.cod_tipo_processo);',
'FETCH C4 INTO V_C4;',
'CLOSE C4;',
'',
':P52_COD_PROCESSO := v_c1.cod_processo;',
':P52_STATUS := v_c1.status;',
':P52_COD_PROC_ANTERIOR := v_c1.cod_proc_anterior;',
':P52_COD_PREST_SERV := v_c2.NOME_PREST_SERV;',
':P52_COD_TIPO_PROCESSO := v_c4.tipo_processo;',
':P52_COD_METRICA := v_c3.metrica;',
':P52_DT_SOLICITACAO := v_c1.dt_solicitacao;',
':P52_DT_APROVACAO := v_c1.dt_aprovacao;',
':P52_DT_PERFIL := v_c1.dt_perfil;',
':P52_DT_FECHAMENTO := v_c1.dt_fechamento;',
':P52_COD_ENTIDADE := v_c1.cod_entidade;',
':P52_DT_INI_ENTIDADE := v_c1.dt_ini_entidade;',
':P52_DT_FIM_ENTIDADE := v_c1.dt_fim_entidade;',
':P52_TAXA := v_c1.taxa;',
':P52_VALOR := v_c1.valor;',
':P52_OBSERVACAO_PS := v_c1.observacao;',
':P52_LOCAL := v_c1.local;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879314913609908403)
,p_process_sequence=>110
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(Pesquisa) Popula Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT r.cod_vaga, ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'/*nvl(a.cod_horario,a.cod_horario_jornada)*/ r.cod_horario  cod_horario, ',
'a.cod_sindicato,',
'a.cod_unidade_adm,',
'a.cod_atividade,',
'a.vinculo,',
'a.cod_un_negocio,',
'a.cod_cargo,',
'a.cod_funcao,',
'a.cod_categoria',
'  from requisicao r, cl_vaga a',
' where a.cod_empresa = r.cod_empresa',
'   and a.cod_filial = r.cod_filial',
'   and a.cod_vaga = r.cod_vaga',
'   and r.cod_req = :p52_cod_req;',
'   ',
'/*',
'  from requisicao r, cl_vaga a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga;',
'*/',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'select utiliza_secao ',
'  into :p52_utiliza_secao',
'  from parametros_recursos_humanos ',
' where cod_empresa = :p52_cod_empresa;',
' ',
' if :p52_utiliza_secao is null then',
' :p52_utiliza_secao := ''N'';',
' end if;',
' ',
'if :p52_cod_req is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_vaga is not null then',
':p52_cod_vaga := v_c1.cod_vaga;',
':P52_COD_CCUSTO_X := V_C1.COD_CCUSTO;',
':P52_COD_UNIDADE_ADM_X := V_C1.COD_UNIDADE_ADM;',
':P52_COD_ATIVIDADE_X := V_C1.COD_ATIVIDADE;',
':P52_COD_LOCAL_TRAB_X := V_C1.COD_LOCAL_TRAB;',
':P52_COD_CCUSTO_CONTAB_X := V_C1.COD_CCUSTO_CONTAB;',
':P52_VINCULO_X := V_C1.VINCULO;',
':P52_COD_UN_NEGOCIO_X := V_C1.COD_UN_NEGOCIO;',
':P52_COD_CARGO_X := V_C1.COD_CARGO;',
':P52_COD_FUNCAO_X := V_C1.COD_FUNCAO;',
':P52_COD_CATEGORIA_X := V_C1.COD_CATEGORIA;',
':P52_COD_SINDICATO_X := V_C1.COD_SINDICATO;',
':P52_COD_HORARIO_X := V_C1.COD_HORARIO; ',
'',
':P52_COD_CCUSTO_1 := :P52_COD_CCUSTO_X;',
':P52_COD_UNIDADE_ADM_1 := :P52_COD_UNIDADE_ADM_X;',
':P52_COD_ATIVIDADE_1 := :P52_COD_ATIVIDADE_X;',
':P52_COD_LOCAL_TRAB_1 := :P52_COD_LOCAL_TRAB_X;',
':P52_VINCULO_1 := :P52_VINCULO_X;',
':P52_COD_CCUSTO_CONTAB_1 := :P52_COD_CCUSTO_CONTAB_X;',
':P52_COD_UN_NEGOCIO_1 := :P52_COD_UN_NEGOCIO_X;',
':P52_COD_CARGO_1 := :P52_COD_CARGO_X;',
':P52_COD_FUNCAO_1 := :P52_COD_FUNCAO_X;',
':P52_COD_CATEGORIA_1 := :P52_COD_CATEGORIA_X;',
':P52_COD_SINDICATO_1 := :P52_COD_SINDICATO_X;',
':P52_RT_JORNADA_MENSAL_1 := :P52_RT_JORNADA_MENSAL_X;',
':P52_COD_HORARIO_1 := :P52_COD_HORARIO_X;',
'',
'else',
'',
':P52_COD_CCUSTO := :P52_COD_CCUSTO_X;',
':P52_COD_UNIDADE_ADM := :P52_COD_UNIDADE_ADM_X;',
':P52_COD_ATIVIDADE := :P52_COD_ATIVIDADE_X;',
':P52_COD_LOCAL_TRAB := :P52_COD_LOCAL_TRAB_X;',
':P52_VINCULO := :P52_VINCULO_X;',
':P52_COD_CCUSTO_CONTAB := :P52_COD_CCUSTO_CONTAB_X;',
':P52_COD_UN_NEGOCIO := :P52_COD_UN_NEGOCIO_X;',
':P52_COD_CARGO := :P52_COD_CARGO_X;',
':P52_COD_FUNCAO := :P52_COD_FUNCAO_X;',
':P52_COD_CATEGORIA := :P52_COD_CATEGORIA_X;',
':P52_COD_SINDICATO := :P52_COD_SINDICATO_X;',
':P52_RT_JORNADA_MENSAL := :P52_RT_JORNADA_MENSAL_X;',
':P52_COD_HORARIO := :P52_COD_HORARIO_X;',
'',
'end if;',
'end if;',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_COD_REQ'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879311283266908401)
,p_process_sequence=>120
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Popula Campos Y'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_vaga is null then',
'    if :P52_COD_UNIDADE_ADM is null and :P52_COD_UNIDADE_ADM_Y is not null then',
'        :P52_COD_UNIDADE_ADM := :P52_COD_UNIDADE_ADM_Y;',
'        :P52_COD_ATIVIDADE := :P52_COD_ATIVIDADE_Y;',
'        :P52_COD_LOCAL_TRAB := :P52_COD_LOCAL_TRAB_Y;',
'        :P52_COD_CCUSTO_CONTAB := :P52_COD_CCUSTO_CONTAB_Y;',
'        :P52_COD_UN_NEGOCIO := :P52_COD_UN_NEGOCIO_Y;',
'    end if;',
'else',
'    if :P52_COD_UNIDADE_ADM_1 is null and :P52_COD_UNIDADE_ADM_Y is not null then',
'        :P52_COD_UNIDADE_ADM_1 := :P52_COD_UNIDADE_ADM_Y;',
'        :P52_COD_ATIVIDADE_1 := :P52_COD_ATIVIDADE_Y;',
'        :P52_COD_LOCAL_TRAB_1 := :P52_COD_LOCAL_TRAB_Y;',
'        :P52_COD_CCUSTO_CONTAB_1 := :P52_COD_CCUSTO_CONTAB_Y;',
'        :P52_COD_UN_NEGOCIO_1 := :P52_COD_UN_NEGOCIO_Y;',
'    end if;',
'end if;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_ROWID'
,p_process_when_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37330161140409177236)
,p_process_sequence=>130
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Popula Mat Sub Edi\00E7\00E3o_Jornada/Ciclo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select COD_EMPRESA ',
', mat_subs matricula',
',fnct_nome_func(a.COD_EMPRESA, a.mat_subs) nome',
',case when COD_CICLO is not null then ''C''',
'      when COD_JORNADA is not null then ''J'' END TIPO',
'from requisicao A',
'where COD_REQ = :P52_COD_REQ;',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p52_cod_req is not null then',
'',
'open  c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'',
'    if  v_c1.matricula is not null then',
'     :P52_MAT_SUBS_1 := v_c1.matricula||'' - ''|| v_c1.nome;',
'    end if;',
'    ',
'    IF V_C1.TIPO IS NOT NULL THEN ',
'     :P52_TIPO_PONTO := V_C1.TIPO;',
'    END IF;',
'    ',
'end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37382432493459857749)
,p_process_sequence=>140
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Motivo Req'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select ''S'' existe',
'  from req_motivo_situacao;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':P52_POSSUI_MOTIVO_REQ := nvl(v_c1.existe,''N'');',
'',
'',
'',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879317689891908406)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_seq number;',
'',
'begin',
'',
'IF NVL(:P52_QTD_POSICAO,0) = 0 THEN',
':P52_QTD_POSICAO := 1;',
'END IF;',
'',
'    BEGIN',
'  	SELECT seq_requisicao.NEXTVAL INTO v_seq FROM dual;',
'    END;',
'        ',
'    :p52_cod_req := v_seq;',
'    ',
'if :p52_flag_temporario is null then',
':p52_flag_temporario := ''S'';',
'end if;',
'',
'IF :P52_COD_VAGA IS NOT NULL THEN',
':P52_FLAG_TEMPORARIO := ''N'';',
'ELSE',
':P52_FLAG_TEMPORARIO := ''S'';',
'END IF;',
'',
'IF :P52_MAT_SUBS IS NOT NULL THEN',
'	 :P52_COD_MOT_REQ     := 1;',
'   :P52_COD_MOT_SIT_REQ := 1;',
'ELSE	',
'	 :P52_COD_MOT_REQ     := nvl(:P52_COD_MOT_REQ,2);',
'   :P52_COD_MOT_SIT_REQ := nvl(:P52_COD_MOT_REQ,2);',
'END IF;  ',
'',
'   if :P52_SEXO is null then',
'  :P52_SEXO := ''A'';',
'  end if;',
'  ',
'  :p52_usuario         := :p_usuario;',
'  :p52_dt_atualizacao  := sysdate;',
'',
'    --:P52_COD_SIT_REQ := 1;',
'    ',
'    :p52_DT_SIT_REQ  := SYSDATE;',
'    :P52_DT_REQ      := SYSDATE;',
'',
'    :p52_cod_emp_req := :P_EMPRESA_USER;',
'    :p52_mat_req     := :P_MATRICULA_USER;',
' ',
'  IF :P52_PERC_BENEFICIO IS NULL THEN',
'    IF :P52_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'       :P52_PERC_BENEFICIO := :P52_PERC_BENEFICIO_VARIAVEL;',
'    ELSIF :P52_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(:P52_PERC_BENEF_EXCECAO,0) > 0 THEN',
'       :P52_PERC_BENEFICIO := :P52_PERC_BENEF_EXCECAO;',
'    ELSIF :P52_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(:P52_PERC_BENEF_EXCECAO,0) = 0 THEN',
'       :P52_PERC_BENEFICIO := NULL;',
'    END IF;',
'  END IF;',
'   ',
'',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
'',
':P52_CICLO_INICIAL := REGEXP_REPLACE(:P52_CICLO_INICIAL, ''[^0-9]'', '''');',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879318115979908406)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Pre-Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'  :p52_usuario := :p_usuario;',
'  :p52_dt_atualizacao := sysdate;',
'  ',
'  IF :P52_PERC_BENEFICIO IS NULL THEN',
'    IF :P52_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'       :P52_PERC_BENEFICIO := :P52_PERC_BENEFICIO_VARIAVEL;',
'    ELSIF :P52_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(:P52_PERC_BENEF_EXCECAO,0) > 0 THEN',
'       :P52_PERC_BENEFICIO := :P52_PERC_BENEF_EXCECAO;',
'    ELSIF :P52_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(:P52_PERC_BENEF_EXCECAO,0) = 0 THEN',
'       :P52_PERC_BENEFICIO := NULL;',
'    END IF;',
'  END IF;',
'',
'if :p52_flag_temporario is null then',
':p52_flag_temporario := ''S'';',
'end if;',
'',
'IF :P52_COD_VAGA IS NOT NULL THEN',
':P52_FLAG_TEMPORARIO := ''N'';',
'ELSE',
':P52_FLAG_TEMPORARIO := ''S'';',
'END IF;',
'',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879310893347908400)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(Controlada) Se Nulo'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select DISTINCT ',
'a.cod_ccusto,',
'a.cod_local_trab,',
'a.cod_ccusto_contab,',
'nvl(a.cod_horario,a.cod_horario_jornada) cod_horario,',
'a.cod_sindicato,',
'a.valor_total total_salario,',
'a.valor_verba salario,',
'a.remuneracao_variavel,',
'a.perc_beneficio_variavel,',
'a.tipo_salario,',
'a.tipo_modalidade,',
'a.vlr_aux_tipo_modalidade,',
'a.trab_intermitente,',
'a.cod_area',
'  from cl_vaga                a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and a.cod_vaga = :p52_cod_vaga',
'   and a.sit_vaga = ''A''',
'   and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'   and F_Acesso_Fil_cc_PG_APEX(a.cod_empresa, a.cod_filial, a.cod_ccusto, :P_USUARIO) = ''S''',
'union',
'select DISTINCT ',
'aa.cod_ccusto,',
'aa.cod_local_trab,',
'aa.cod_ccusto_contab,',
'nvl(aa.cod_horario,aa.cod_horario_jornada) cod_horario,',
'aa.cod_sindicato,',
'aa.valor_total total_salario,',
'aa.valor_verba salario,',
'aa.remuneracao_variavel,',
'aa.perc_beneficio_variavel,',
'aa.tipo_salario,',
'aa.tipo_modalidade,',
'aa.vlr_aux_tipo_modalidade,',
'aa.trab_intermitente,',
'aa.cod_area',
'  from cl_vaga                a,',
'       cl_vaga                aa',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial = :p52_cod_filial',
'   and aa.cod_vaga = :p52_cod_vaga',
'   and a.cod_empresa = aa.cod_empresa',
'   and a.cod_filial = aa.cod_filial',
'   and a.sit_vaga = ''A''',
'   and aa.sit_vaga = ''A''',
'   and a.vaga_compartilhada = aa.cod_vaga',
'   and nvl(a.ind_vaga_compartilhada, ''N'') = ''S''',
'   and Nvl(a.disponivel, ''N'') = ''N''',
'   and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'   and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, aa.cod_ccusto, :P_USUARIO) = ''S'';',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :P52_FLAG_TEMPORARIO = ''N'' then',
'',
'    if :p52_tipo_salario is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_tipo_salario := v_c1.tipo_salario;',
'    ',
'    end if;',
'',
'    if :p52_total_salario is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_total_salario := v_c1.total_salario;',
'    ',
'    end if;',
'',
'    if :p52_salario is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_salario := v_c1.salario;',
'    ',
'    end if;',
'    ',
'    if :p52_remuneracao_variavel is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_remuneracao_variavel := v_c1.remuneracao_variavel;',
'    ',
'    end if;',
'',
'    if :p52_perc_beneficio is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_perc_beneficio := v_c1.perc_beneficio_variavel;',
'    ',
'    end if;',
'    ',
'    if :p52_tipo_modalidade is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_tipo_modalidade := v_c1.tipo_modalidade;',
'    ',
'    end if;',
'    ',
'    if :p52_vlr_aux_tipo_modalidade is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_vlr_aux_tipo_modalidade := v_c1.vlr_aux_tipo_modalidade;',
'    ',
'    end if;',
'',
'    if :p52_trab_intermitente is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_trab_intermitente := v_c1.trab_intermitente;',
'    ',
'    end if;',
'',
'    if :p52_cod_area is null then',
'    ',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'        ',
'    :p52_cod_area := v_c1.cod_area;',
'    ',
'    end if;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(31227417506378729047)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Em Revisao - Apaga Aprovadores'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'if :p52_cod_sit_req = 0 then',
'delete from aprova_req a',
' where a.cod_req = :p52_cod_req;',
'commit;',
'',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_COD_SIT_REQ'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'0'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879317300266908406)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(170359329777970691663)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process Row of REQUISICAO'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Efetuado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879314467736908403)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
'    update REQUISICAO',
'       set remuneracao_variavel = :p52_remuneracao_variavel,',
'           salario = :p52_salario,',
'           VLR_AUX_TIPO_MODALIDADE = :P52_VLR_AUX_TIPO_MODALIDADE,',
'           PERC_BENEFICIO_VARIAVEL = :P52_PERC_BENEFICIO',
'     where cod_req = :p52_cod_req;',
'     ',
'     commit;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'     ',
'end;'))
,p_process_error_message=>unistr('Erro ao Criar Requisi\00E7\00E3o.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879311674384908401)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert_1_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    v_mat_subs informacoes_funcionais.matricula%type := :P52_MAT_SUBS_X;',
'    v_cod_mot_req number(1);',
'    v_cod_mot_sit_req number(1);',
'',
'begin',
'',
'    IF V_MAT_SUBS IS NOT NULL THEN',
'        V_COD_MOT_REQ     := 1;',
'        V_COD_MOT_SIT_REQ := 1;',
'',
'        update REQUISICAO',
'           set cod_mot_req = V_COD_MOT_REQ,',
'               COD_MOT_SIT_REQ = v_cod_mot_sit_req,',
'               mat_subs = v_mat_subs',
'         where cod_req = :p52_cod_req;',
'',
'         commit;',
'',
'    END IF;  ',
'',
'end;'))
,p_process_error_message=>unistr('Erro ao Criar Requisi\00E7\00E3o.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879316449988908405)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert_Update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_req_pai',
'  from requisicao',
' where cod_req = :p52_cod_req;',
' ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.cod_req_pai is not null then',
'update requisicao',
'   set qtd_posicao = qtd_posicao - 1',
' where cod_req = v_c1.cod_req_pai;',
' ',
' commit; ',
'',
'update requisicao',
'   set cod_req_pai = null',
' where cod_req = :p52_cod_req;',
' ',
' commit; ',
'end if;',
'',
' pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req, v_flg_retorno, v_msg_retorno);',
'',
'begin',
' insert into tar_peso (cod_req, cod_tarefa_req, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req, cod_tarefa_req, cod_peso, :p_usuario, sysdate from tar_peso_temp where seq = :p52_seq);',
' commit;',
' delete from tar_peso_temp where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela tar_peso: ''||sqlerrm);',
'end;',
'begin',
' insert into carac_peso (cod_req, cod_carac_func, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req, cod_carac_func, cod_peso, :p_usuario, sysdate from carac_peso_temp where seq = :p52_seq);',
' commit;',
' delete from carac_peso_temp where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela carac_peso: ''||sqlerrm);',
'end;',
'',
'begin',
'update idioma_req_pessoal',
'   set cod_req = :p52_cod_req',
' where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela idioma_req_pessoal: ''||sqlerrm);',
'end;',
'',
'begin',
'        update beneficios_vaga_temp',
'           set cod_requisicao = :p52_cod_req',
'         where seq = :p52_seq;',
'    commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela beneficios_vaga_temp: ''||sqlerrm);',
'end;',
'',
'begin',
'update formacao_req_pessoal',
'   set cod_req = :p52_cod_req',
' where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela formacao_req_pessoal: ''||sqlerrm);',
'end;',
'',
'begin',
'update experiencia_req_pessoal',
'   set cod_req = :p52_cod_req',
' where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela experiencia_req_pessoal: ''||sqlerrm);',
'end;',
'',
'begin',
'update conhecimento_req_pessoal',
'   set cod_req = :p52_cod_req',
' where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela conhecimento_req_pessoal: ''||sqlerrm);',
'end;',
'',
'begin',
'update curso_req_pessoal',
'   set cod_req = :p52_cod_req',
' where seq = :p52_seq;',
' commit;',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabela curso_req_pessoal: ''||sqlerrm);',
'end;',
'',
'exception',
'when others then',
'null; --raise_application_error(-20000,''Erro ao salvar sub-tabelas: ''||sqlerrm);',
'',
'end;'))
,p_process_error_message=>'Erro ao inserir aprovadores.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879318524263908406)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post-Insert'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'  pkg_pessoal.post_insert(:p52_cod_req, v_flg_retorno, v_msg_retorno, :p_usuario, :p52_qtd_posicao);',
'',
'  if v_flg_retorno is not null and v_msg_retorno is not null then',
'     :p52_flag := v_flg_retorno;',
'     :p52_mensagem := v_msg_retorno;',
'  end if;',
'',
'end;'))
,p_process_error_message=>'Erro ao inserir aprovadores.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(37879127043764908292)
,p_process_when=>'CREATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37632942122636268873)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Salva Tipo Sal\00E1rio')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'update REQUISICAO',
'       set TIPO_SALARIO = :P52_TIPO_SALARIO',
'     where cod_req = :p52_cod_req;',
'     ',
'     commit;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P52_TIPO_SALARIO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879310027081908399)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Criar Igual'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
' v_cod_req number;',
'',
' v_flg varchar2(1);',
' v_msg varchar2(4000);',
' ',
'begin',
'',
'IF NVL(:P52_QTD_POSICAO_1,0) = 0 THEN',
':P52_QTD_POSICAO_1 := 1;',
'END IF;',
'',
'   pkg_pessoal.prc_insere_req (:p52_cod_req,',
'                               :p_usuario,',
'                               v_cod_req,',
'                              ''COPIA'',',
'                              :p52_qtd_posicao_1);',
'   UPDATE REQUISICAO',
'   SET    COD_SIT_REQ = 1',
'   WHERE  COD_REQ_PAI IS NULL',
'   AND    COD_REQ = v_cod_req; -- CH43105',
'   pkg_pessoal.post_insert(v_cod_req, ',
'                           v_flg,',
'                           v_msg,',
'                           :p_usuario,',
'                           :P52_QTD_POSICAO_1);',
'',
'  commit;',
'',
'  if v_flg is not null and v_msg is not null then',
'     :p52_flag := v_flg;',
'     :p52_mensagem := v_msg;',
'  end if;',
'    ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CRIAR_IGUAL'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'&P52_MENSAGEM.'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37117662750153636661)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'POST-UPDATE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
' declare',
' ',
' v_flg_retorno varchar2(1);',
' v_msg_retorno varchar2(4000);',
' ',
' begin',
'',
' pkg_pessoal.Post_Update (:p52_cod_empresa,',
'                               :p52_cod_req_x,',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
'      commit;       ',
'      ',
'      pkg_pessoal.prc_update_req (:p52_cod_req_x,',
'                                  usuario.busca_user,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'      commit;  ',
'      ',
' end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879310490571908400)
,p_process_sequence=>160
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Req. Filhos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_pessoal.prc_update_req (:p52_cod_req_X,',
'                            :p_usuario,',
'                            :p52_flag,',
'                            :p52_mensagem);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879309700123908398)
,p_process_sequence=>170
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Verifica Req. Benef. Cand'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_valor_beneficio number;',
'',
'v_remuneracao_variavel number;-- := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'',
'cursor c_req is',
'select sum(nvl(i.quantidade,1)*i.valor) Valor_Total, r.cod_req',
'  from beneficios_familia b, ',
'       beneficios_familia_tipo t, ',
'       beneficios_fam_tipo_vlr v, ',
'       req_beneficios_itens_cand i, ',
'       req_beneficios_CANDIDATO r,',
'       RP_CAND_INSCRITOS c',
' where b.cod_empresa = t.cod_empresa',
'   and b.cod_empresa = v.cod_empresa',
'   and b.cod_familia = i.cod_familia',
'   and b.cod_familia = t.cod_familia',
'   and b.cod_familia = v.cod_familia',
'   and t.tipo_cod_familia = v.tipo_cod_familia',
'   and t.tipo_cod_familia = i.tipo_cod_familia',
'   and r.dt_req between b.dt_inicio_familia and nvl(b.dt_fim_familia,sysdate)',
'   and r.dt_req between t.dt_inicio_tipo and nvl(t.dt_fim_tipo,sysdate)',
'   and r.dt_req between v.dt_inicio_valor and nvl(v.dt_fim_valor,sysdate)',
'   and b.cod_empresa = r.cod_empresa',
'   and r.cod_req = i.cod_req',
'   and c.cod_req = :p52_cod_req',
'   and c.cod_candidato = r.cod_candidato',
'   -- and r.cod_sit_req in (1,2,3,5)',
'   group by r.cod_req;',
'   ',
'v_req c_req%rowtype;',
'',
'begin',
'',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'v_remuneracao_variavel := replace(replace(:p52_remuneracao_variavel,''R$''),''.'');',
'',
'if :p52_cod_sit_req in (1,5) then',
'',
'  for l_req in c_req',
'  loop',
'',
'    if nvl(l_req.valor_total,0) > 0 and nvl(l_req.valor_total,0) <> nvl(v_remuneracao_variavel,0) then',
'',
'          begin',
'          delete from aprova_beneficios_candidato',
'           where cod_solicitacao = l_req.cod_req;',
'          commit;',
'          end;',
'',
'          begin',
'          delete ',
'          from req_beneficios_itens_cand_temp r',
'          where exists ',
'          (select 1',
'          from RP_CAND_INSCRITOS i',
'          where i.cod_candidato = r.cod_candidato',
'          and i.cod_req = :p52_cod_req);',
'          commit;',
'          end;',
'',
'          begin',
'          delete from req_beneficios_itens_cand where cod_req = l_req.cod_req;',
'          commit;',
'          end;',
'',
'          begin',
'          delete from req_beneficios_candidato where cod_req = l_req.cod_req;',
'          commit;',
'          end;',
'          ',
'    end if;',
'  ',
'  end loop;',
'  ',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(26259401058214465150)
,p_process_sequence=>180
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPDATE VLR AUX'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'    update REQUISICAO',
'          set VLR_AUX_TIPO_MODALIDADE = :P52_VLR_AUX_TIPO_MODALIDADE',
'            , COD_CICLO = nvl(:P52_CICLO,cod_ciclo)',
'            , CICLO_INICIAL = nvl(:P52_CICLO_INICIAL,CICLO_INICIAL)',
'            , COD_JORNADA = nvl(:P52_JORNADA,COD_JORNADA)',
'            , COD_ESCALA = nvl(:P52_ESCALA,COD_ESCALA)',
'            , DATA_INICIO_CICLO = nvl(:P52_CICLO_DAT_INICIAL,DATA_INICIO_CICLO)',
'            , DATA_FINAL_CICLO = nvl(:P52_CICLO_DAT_FINAL,DATA_FINAL_CICLO)',
'     where cod_req = :p52_cod_req;',
'     commit;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(37879126659197908291)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879313717804908402)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_lov_display'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  type t_lov is record (f_display varchar2(4000), f_return varchar2(4000));',
'  l_sql apex_application_page_items.lov_definition%type;',
'  l_cur sys_refcursor;',
'  l_lov t_lov;',
'begin',
'  if apex_application.g_x02 is not null then',
'    select lov_definition',
'      into l_sql',
'      from apex_application_page_items t',
'     where application_id  = :app_id',
'       and page_id         = :app_page_id',
'       --and display_as_code in (''NATIVE_POPUP_LOV'',''NATIVE_SELECT_LIST'',''PLUGIN_BE.CTB.SELECT2'')',
'	   and display_as_code in (''NATIVE_POPUP_LOV'',''PLUGIN_BE.CTB.SELECT2'')',
'       and item_name       = apex_application.g_x01;',
'',
'    open l_cur for l_sql;',
'    loop',
'      exit when l_cur%notfound or l_lov.f_return = apex_application.g_x02;',
'      fetch l_cur into l_lov;',
'    end loop;',
'    close l_cur;',
'',
'    htp.prn(l_lov.f_display);',
'  else',
'    htp.prn('''');',
'  end if;',
'exception when others then',
'  htp.prn('''');',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(37879312502025908402)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'get_lov_display_local'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  type t_lov is record (f_display varchar2(4000), f_return varchar2(4000));',
'  l_sql apex_application_page_items.lov_definition%type;',
'  l_cur sys_refcursor;',
'  l_lov t_lov;',
'begin',
'  if apex_application.g_x02 is not null then',
'    select lov_definition',
'      into l_sql',
'      from apex_application_page_items t',
'     where application_id  = :app_id',
'       and page_id         = :app_page_id',
'       and display_as_code = ''NATIVE_SELECT_LIST''',
'       and item_name       = apex_application.g_x01;',
'',
'    open l_cur for l_sql;',
'    loop',
'      exit when l_cur%notfound or l_lov.f_return = apex_application.g_x02;',
'      fetch l_cur into l_lov;',
'    end loop;',
'    close l_cur;',
'',
'    htp.prn(l_lov.f_display);',
'  else',
'    htp.prn('''');',
'  end if;',
'exception when others then',
'  htp.prn('''');',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(29306579114822907499)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REMOVER_ANEXO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  UPDATE requisicao',
'     SET anexo_filename_1 = NULL,',
'         anexo_mimetype_1 = NULL,',
'         anexo_charset_1  = NULL,',
'         anexo_data_1     = NULL,',
'         anexo_1          = NULL',
'   WHERE cod_req = apex_application.g_x01;',
'',
'  -- Retornar JSON de sucesso',
'  apex_json.open_object;',
'  apex_json.write(''status'', ''OK'');',
'  apex_json.close_object;',
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
