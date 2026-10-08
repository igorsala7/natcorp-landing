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
,p_default_application_id=>300
,p_default_id_offset=>785128738853783604
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 300 - Painel do Colaborador - Natcorp
--
-- Application Export:
--   Application:     300
--   Name:            Painel do Colaborador - Natcorp
--   Date and Time:   16:26 Sunday October 4, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 78
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00078
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>78);
end;
/
prompt --application/pages/page_00078
begin
wwv_flow_api.create_page(
 p_id=>78
,p_user_interface_id=>wwv_flow_api.id(145492043237253058674)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de F\00E9rias')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de F\00E9rias')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ferias.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var htmldb_delete_message=''"DELETE_CONFIRM_MSG"'';',
'',
'var retornaData1_1 = function(number) {',
'    if ($x(''P78_DT_SAIDA_PARC1_1'').value.length  > 0 ) {',
'        return true;       ',
'    }else{',
'        return false;',
'    }',
'};',
'',
'var retornaData2_1 = function(number) {',
'    if ($x(''P78_DT_SAIDA_PARC2_1'').value.length  > 0 ) {',
'        return true;       ',
'    }else{',
'        return false;',
'    }',
'};',
'',
'var retornaData4_1 = function(number) {',
'    if ($x(''P78_DT_SAIDA_PARC4_1'').value.length  > 0 ) {',
'        return true;       ',
'    }else{',
'        return false;',
'    }',
'};',
'',
'$x(''P78_DT_SAIDA_PARC1_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC1_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL1_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL1_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC1_1'').disabled = true;',
'',
'$x(''P78_DT_SAIDA_PARC2_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC2_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC2_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL2_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL2_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC2_1'').disabled = true;',
'',
'$x(''P78_DT_SAIDA_PARC4_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC4_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC4_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL4_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL4_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC4_1'').disabled = true;'))
,p_css_file_urls=>'#WORKSPACE_IMAGES#Natcorp_Ferias.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#PARAMETROS .t-Region-buttons-right{',
'    width: 100% !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_page_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('DESENHO DA TELA (Natcorp_Ferias.css / Natcorp_Ferias.js, em Arquivos desta p\00E1gina)'),
'',
unistr('A estrutura \00E9 toda do APEX: ordem, colunas, t\00EDtulos, r\00F3tulos e bot\00F5es est\00E3o aqui no Page Designer'),
unistr('e aparecem na tela do mesmo jeito. O CSS/JS s\00F3 muda o DESENHO de quem tem uma destas classes:'),
'',
unistr('Regi\00F5es (Apar\00EAncia > Classes CSS):'),
unistr('  nc-fer-direito     Suas f\00E9rias: abre com "Voc\00EA tem N dias de f\00E9rias" e at\00E9 quando come\00E7ar (P78_SALDO_1, P78_DT_LIMITE_REQ).'),
unistr('  nc-fer-detalhes    Per\00EDodo de F\00E9rias e Dados: recolhidos, atr\00E1s do bot\00E3o "Ver os detalhes do per\00EDodo".'),
unistr('  nc-fer-parte       1\00AA/2\00AA/3\00AA parte: o formul\00E1rio de cada parte.'),
unistr('  nc-fer-programada  As partes j\00E1 programadas: o mesmo, com o selo "J\00E1 programada".'),
unistr('  nc-fer-linha       Confira suas f\00E9rias: cada parte em frases (vazia no APEX; o JS escreve).'),
unistr('  nc-fer-acoes       Bot\00F5es: presa ao p\00E9 da tela, dizendo o que falta escolher.'),
unistr('  nc-fer-colaborador Colaborador Solicitado: o cart\00E3o com a foto, o nome, a filial e os anos de casa.'),
unistr('  (sem classe)       a regi\00E3o com P78_COD_SOLICITACAO vira o cart\00E3o do pedido (n\00BA, situa\00E7\00E3o, quem pediu);'),
unistr('                     o relat\00F3rio com a coluna APROVADOR vira o caminho da aprova\00E7\00E3o, abaixo do pedido.'),
'',
unistr('Itens (Avan\00E7ado > Classes CSS; vai para o cont\00EAiner do item) \00BF a lista continua sendo o item de verdade:'),
unistr('  nc-fer-opcao    P78_OPCAO_FERIAS(_A): primeiro "Voc\00EA quer vender dias?", depois s\00F3 as op\00E7\00F5es que servem (l\00EA "N Parcela(s): X dias + Y abono").'),
unistr('  nc-fer-simnao   P78_HAVERA_REP, P78_OPCAO_13SAL*: bot\00F5es N\00E3o/Sim.'),
unistr('  nc-fer-dias     P78_NUM_DIAS_PARC*_LST, P78_DIAS_ABONO_PEC*_LST: bot\00F5es; com UMA op\00E7\00E3o, \00E9 escolhida sozinha e vira frase.'),
'  nc-fer-retorno  P78_DT_RETORNO_PARC*: a volta dita em frase ("Volta ao trabalho em quarta-feira, ...").',
'',
unistr('Clicar num bot\00E3o/cart\00E3o faz apex.item(...).setValue(...): as a\00E7\00F5es din\00E2micas de sempre disparam, e as'),
unistr('valida\00E7\00F5es continuam no servidor. Para mudar a tela: mude aqui. Para tirar o desenho: tire a classe.'),
unistr('Para desligar tudo: tire as duas URLs de arquivo desta p\00E1gina. N\00E3o renomeie os itens P78_* acima sem'),
'ajustar o Natcorp_Ferias.js. Fontes e guia: brand/apex/app/Natcorp_Ferias.src.js / .src.css e FERIAS-MANUTENCAO.md.'))
,p_last_updated_by=>'BRUNO.SOUSA'
,p_last_upd_yyyymmddhh24miss=>'20260915175226'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(89665647870701615830)
,p_plug_name=>unistr('Requisic\00F5es')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(145393053751274394435)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(145492038528010058625)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272262357542516568)
,p_plug_name=>'&P78_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272268777706516575)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_name=>'BOTOES'
,p_region_css_classes=>'nc-fer-acoes'
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492009246093058567)
,p_plug_display_sequence=>990
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>'pkg_apex.fnct_apex_region'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(202272271151975516577)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(145492017240415058580)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>4
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT ''ROWID'', a.cod_emp_aprov||'' - ''||a.mat_aprov||'' - ''||initcap(fnct_nome_func(a.cod_emp_aprov,a.mat_aprov)) aprovador, a.dt_aprov Data, a.STATUS_APROV Status, a.cod_emp_aprov, a.mat_aprov, A.SEQ_APROV, a.justificativa',
'  from aprova_ferias a, usuario_oracle u',
' where a.cod_solicitacao = :p78_cod_solicitacao',
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
'  from aprova_ferias a, usuario_oracle u',
' where a.cod_solicitacao = :p78_cod_solicitacao',
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
'select mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P78_COD_SOLICITACAO'
,p_query_row_template=>wwv_flow_api.id(145492026051969058596)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669317103976413685)
,p_query_column_id=>1
,p_column_alias=>'''ROWID'''
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:13:P13_EMP,P13_MAT:#COD_EMP_APROV#,#MAT_APROV#'
,p_column_linktext=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_lov_show_nulls=>'YES'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669317522788413688)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669317852777413689)
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
 p_id=>wwv_flow_api.id(89669318334108413689)
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
 p_id=>wwv_flow_api.id(89669318736368413689)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669319049812413689)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669319524767413689)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(89669319872342413690)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272274750104516580)
,p_plug_name=>'Colaborador Solicitado'
,p_region_name=>'COLABORADOR'
,p_region_css_classes=>'nc-fer-colaborador'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272278763717516583)
,p_plug_name=>'Colab Foto'
,p_parent_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P78_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272279582985516584)
,p_plug_name=>'Colab Info'
,p_parent_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P78_ROWID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272281567918516588)
,p_plug_name=>unistr('Suas f\00E9rias')
,p_region_name=>'PER'
,p_region_css_classes=>'nc-fer-direito'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(28299030000780000001)
,p_plug_name=>unistr('Confira suas f\00E9rias')
,p_region_name=>'LINHA_FERIAS'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-linha'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
,p_plug_comment=>unistr('Vazia de prop\00F3sito: o Natcorp_Ferias.js escreve aqui, em frases, quando cada parte come\00E7a e quando a pessoa volta (datas e dias das regi\00F5es nc-fer-parte e nc-fer-programada), com o aviso quando passa de P78_DT_LIMITE_REQ ou cruza com outra parte. Se ')
||unistr('o JS n\00E3o carregar, o CSS a esconde. Ao tirar o desenho da p\00E1gina, ponha esta regi\00E3o em Nunca.')
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202039115039662695324)
,p_plug_name=>unistr('Op\00E7\00F5es de Programa\00E7\00E3o de F\00E9rias')
,p_region_name=>'OPCAO'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_template_options=>'#DEFAULT#:t-Region--hideHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202042663264835043648)
,p_plug_name=>unistr('2\00AA parte')
,p_region_name=>'2_PARCELA2'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-programada'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>80
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202042664182479043657)
,p_plug_name=>unistr('3\00AA parte')
,p_region_name=>'2_PARCELA3'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-programada'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>110
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202136605286391907173)
,p_plug_name=>unistr('3\00AA parte')
,p_region_name=>'PARCELA3'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-parte'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>100
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272282369576516589)
,p_plug_name=>'Dados'
,p_region_name=>'DADOS'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-detalhes'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272287553987516594)
,p_plug_name=>unistr('1\00AA parte')
,p_region_name=>'PARCELA1'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-parte'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272292700792516598)
,p_plug_name=>unistr('2\00AA parte')
,p_region_name=>'PARCELA2'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-parte'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272296663588516604)
,p_plug_name=>'Parcela Coletiva'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>120
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272298636414516606)
,p_plug_name=>unistr('Per\00EDodo de F\00E9rias')
,p_region_name=>'PERIODO_FERIAS'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-detalhes'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(202272302310720516609)
,p_plug_name=>unistr('1\00AA parte')
,p_region_name=>'2_PARCELA1'
,p_parent_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_region_css_classes=>'nc-fer-programada'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(145492017240415058580)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669304524370413660)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_button_name=>'p78_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P76 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P78_COD_EMP_SOLICITANTE.,&P78_MATRICULA_SOLICITANTE.'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669321143989413691)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(202272271151975516577)
,p_button_name=>'p78_btn_reprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao',
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
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL AND :P78_SIT_REQUISICAO NOT IN (2,3,6) THEN',
'',
'pkg_ferias.Valida_Sequencia(:p78_cod_empresa, :p78_cod_solicitacao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
'end if;',
'',
'return false;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-close'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669321490938413691)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(202272271151975516577)
,p_button_name=>'p78_btn_reprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>'Reprovar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P78_COD_SOLICITACAO.,R,Deseja Reprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao',
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
'IF V_C1.MAT_APROV IS NOT NULL AND :P78_SIT_REQUISICAO NOT IN (2,3,6) THEN',
'',
'pkg_ferias.Valida_Sequencia(:p78_cod_empresa, :p78_cod_solicitacao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
 p_id=>wwv_flow_api.id(89669312346595413680)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:77:&SESSION.::&DEBUG.:RP::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669312771708413680)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.:RP:P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669311634907413680)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_button_name=>'SAVE'
,p_button_static_id=>'#P78_SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select cod_emp_aprov, mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao',
'   and cod_emp_aprov = :P_EMPRESA_USER',
'   and mat_aprov = :P_MATRICULA_USER;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if (:P78_SIT_REQUISICAO = 1) AND ((:p_perfil in (''FOLHA'',''MASTER'',''REMUNERACAO'',''FOLHA_CALCULO'',''FREQUENCIA'')) or (v_c1.mat_aprov is not null and :p_perfil NOT in (''FOLHA'',''MASTER'',''REMUNERACAO'',''FOLHA_CALCULO'',''FREQUENCIA''))) and :p78_rowid is not n'
||'ull then',
'return true;',
'elsif :P78_SIT_REQUISICAO = 2 and :p78_rowid is not null then',
'--return false;',
unistr('return true; -- Habilitado, por\00E9m, validar altera\00E7\00E3o de Situa\00E7\00E3o da Requisi\00E7\00E3o.'),
'elsif :P78_SIT_REQUISICAO = 3 and :p78_rowid is not null then',
'return false;',
'elsif :P78_SIT_REQUISICAO = 5 and :p78_rowid is not null and :p_painel <> ''PC'' and (:p_perfil in (''FOLHA'',''MASTER'',''REMUNERACAO'',''FOLHA_CALCULO'',''FREQUENCIA'') or v_c1.mat_aprov is not null) then',
'return true;',
'elsif :p_perfil in (''FOLHA'',''MASTER'',''REMUNERACAO'',''FOLHA_CALCULO'',''FREQUENCIA'') and :p78_rowid is not null then',
'return true;',
'else',
'return false;',
'end if;',
'',
'end;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669312029245413680)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_button_name=>'P78_CREATE'
,p_button_static_id=>'P78_CREATE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492038032013058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Enviar pedido de f\00E9rias')
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P78_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669320313803413690)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(202272271151975516577)
,p_button_name=>'p78_btn_aprovar'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao',
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
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.MAT_APROV IS NOT NULL AND :P78_SIT_REQUISICAO NOT IN (2,3,6) THEN',
'',
'   if :P78_MSG_APROVAR is not null then',
'      RETURN FALSE;',
'   end if;',
'pkg_ferias.Valida_Sequencia(:p78_cod_empresa, :p78_cod_solicitacao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
'end if;',
'',
'return false;',
'',
'END;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669320701488413690)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(202272271151975516577)
,p_button_name=>'p78_btn_aprovar_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Aprovar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>unistr('f?p=REQ_APROV_&P_BASE.:CONFIRMACAO:&SESSION.::&DEBUG.:RP,CONFIRMACAO:P1_COD_REQ,P1_STATUS,P1_TEXTO:&P78_COD_SOLICITACAO.,A,Deseja Aprovar esta requisi\00E7\00E3o? Informe uma justificativa.')
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'CURSOR C1 IS',
'select mat_aprov',
'  from APROVA_FERIAS',
' where cod_solicitacao = :p78_cod_solicitacao',
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
'IF V_C1.MAT_APROV IS NOT NULL AND :P78_SIT_REQUISICAO NOT IN (2,3,6) THEN',
'',
'   if :P78_MSG_APROVAR is not null then',
'      RETURN FALSE;',
'   end if;',
'',
'pkg_ferias.Valida_Sequencia(:p78_cod_empresa, :p78_cod_solicitacao, :P_EMPRESA_USER, :P_MATRICULA_USER, v_flg_retorno, v_msg_retorno);',
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
 p_id=>wwv_flow_api.id(89669331472643413703)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_button_name=>'REQ_PESSOAL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(145492038205733058624)
,p_button_image_alt=>unistr('Requisi\00E7\00E3o Pessoal')
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:52:&SESSION.:REQ_FERIAS:&DEBUG.:RP,78:P52_COD_EMPRESA,P52_MAT_SUBS,P52_COD_FILIAL,P52_COD_MOT_REQ,P52_COD_VAGA:&P78_COD_EMPRESA.,&P78_MATRICULA.,&P78_FILIAL.,1,&P78_COD_VAGA.'
,p_button_condition=>'P78_HAVERA_REP'
,p_button_condition2=>'S'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_icon_css_classes=>'fa-user-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(89669322243831413691)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_button_name=>'p78_btn_colab'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(145492037915942058621)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Visualizar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P78_COD_EMPRESA.,&P78_MATRICULA.'
,p_button_condition=>'P78_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-user'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(89669562155801414852)
,p_branch_name=>'(Create) Go To Page 77'
,p_branch_action=>'f?p=&APP_ID.:77:&SESSION.::&DEBUG.:78::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_branch_sequence=>20
,p_branch_condition_type=>'FUNCTION_BODY'
,p_branch_condition=>'return 1=1 AND (nvl(:P78_FLAG_CTRL,0) = 1 or :P78_HAVERA_REP = ''N'');'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(89669561091126414722)
,p_branch_name=>'(Create) Go To Page 52'
,p_branch_action=>'f?p=&APP_ID.:52:&SESSION.:REQ_FERIAS:&DEBUG.:78:P52_COD_EMPRESA,P52_MAT_SUBS,P52_COD_MOT_REQ,P52_COD_FILIAL,P52_COD_VAGA:&P78_COD_EMPRESA.,&P78_MATRICULA.,1,&P78_FILIAL.,&P78_COD_VAGA.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_branch_sequence=>30
,p_branch_condition_type=>'FUNCTION_BODY'
,p_branch_condition=>'return :P78_HAVERA_REP = ''S'';'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(89669561451517414852)
,p_branch_name=>'(Save) Go To Page 77'
,p_branch_action=>'f?p=&APP_ID.:77:&SESSION.::&DEBUG.:78::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(89669311634907413680)
,p_branch_sequence=>40
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(89669561752661414852)
,p_branch_name=>'Go To Page 24'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>50
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35229828884483007934)
,p_name=>'P78_OPCAO_FERIAS_CARREGA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(35229829957113007945)
,p_name=>'P78_OPCAO_FERIAS_DB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_use_cache_before_default=>'NO'
,p_source=>'OPCAO_FERIAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(44017081098268729829)
,p_name=>'P78_SHOW_HIDE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(55360441561585042919)
,p_name=>'P78_LOAD'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(59466411985931025524)
,p_name=>'P78_MATRICULA_SOLIC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(59472232072180439375)
,p_name=>'P78_EMP_SOLIC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(61474206531912283746)
,p_name=>'P78_DT_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(61474206621757283747)
,p_name=>'P78_DT_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(61474206749888283748)
,p_name=>'P78_DT_4'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(70908555555149517431)
,p_name=>'P78_DT_RETORNO_PARC1_1_AUX'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(74762669217347012931)
,p_name=>'P78_DT_RETORNO_PARC1_1A'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669304931197413668)
,p_name=>'P78_COD_SOLICITACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_SOLICITACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_read_only_when=>'P78_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669305321316413676)
,p_name=>'P78_TITULO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669305653627413676)
,p_name=>'P78_ROWID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669306047218413676)
,p_name=>'P78_DT_SOLICITACAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data'
,p_source=>'DT_SOLICITACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_read_only_when=>'P78_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669306492015413676)
,p_name=>'P78_FLAG'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669306854787413676)
,p_name=>'P78_SIT_REQUISICAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_source=>'SIT_REQUISICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Aberta;1,Conclu\00EDda;2,Cancelada;3,Reprovada;4,Aprovada;5,Suspensa;6')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669307293716413677)
,p_name=>'P78_MENSAGEM'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669307656439413677)
,p_name=>'P78_SOLICITANTE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669308100968413677)
,p_name=>'P78_USUARIO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Usu\00E1rio')
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669308495313413677)
,p_name=>'P78_COD_EMP_SOLICITANTE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669308882869413678)
,p_name=>'P78_USUARIO_PROG'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO_PROG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669309344997413678)
,p_name=>'P78_MATRICULA_SOLICITANTE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'MATRICULA_SOLICITANTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669309729676413678)
,p_name=>'P78_DT_ATUALIZACAO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Atualiza\00E7\00E3o')
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669310048910413678)
,p_name=>'P78_OBSERVACAO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>2
,p_display_when=>'P78_OBSERVACAO'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669310533499413678)
,p_name=>'P78_DT_ATUALIZACAO_PROG'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO_PROG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669310866514413678)
,p_name=>'P78_DT_SIT_SOLICITACAO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202272262357542516568)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_SIT_SOLICITACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669313180528413682)
,p_name=>'P78_ITEM_VALIDACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669313559966413682)
,p_name=>'P78_OK'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669313975083413682)
,p_name=>'P78_FLAG_CTRL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669314388604413682)
,p_name=>'P78_FLAG_CTRL_A'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669314758603413682)
,p_name=>'P78_EMP_A'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669315159229413682)
,p_name=>'P78_MAT_A'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669315643790413682)
,p_name=>'P78_COD_REQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669315947183413683)
,p_name=>'P78_MSG_APROVAR'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669316387148413683)
,p_name=>'P78_OP'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272268777706516575)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669322560379413692)
,p_name=>'P78_COD_EMPRESA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT COD||'' - ''||INITCAP(NOME) DESCRICAO, COD',
'  FROM EMPRESAS',
'where ((nvl(dt_encerramento,trunc(sysdate)) >= trunc(sysdate)',
'    and :P78_COD_SOLICITACAO is null) or ',
'        (:P78_COD_SOLICITACAO is not null)) ',
'    and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and cod = :p_empresa_user))',
' ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P78_COD_SOLICITACAO'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669322993029413692)
,p_name=>'P78_COD_EMPRESA_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669323400595413692)
,p_name=>'P78_MATRICULA'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Colaborador'
,p_source=>'MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select N DESCRICAO, I MATRICULA from pkg_list_matricula.fnc_list2(:p78_cod_empresa, :p_Painel, :p_empresa_user, :p_matricula_user)',
'/*',
unistr('select ''Matr\00EDcula: (''||a.matricula||'') ''||INITCAP(b.nome)'),
'||'' - Filial: (''||a.filial||'') ''||initcap(fnct_nome_filial(a.cod_empresa, a.filial))',
'||'' - C.Custo: (''||a.cod_ccusto||'') ''||initcap(fnct_nome_ccusto(a.cod_empresa, a.cod_ccusto))',
'||'' - Unid. Adm: (''||a.unidade_adm||'') ''||initcap(u.descricao)',
'||'' - Atividade: (''||a.cod_atividade||'') ''||initcap(v.descricao)',
'||'' - Local: (''||a.cod_localizacao||'') ''||initcap(fnct_nome_local_trab(a.cod_localizacao))',
' DESCRICAO, a.matricula',
'    from informacoes_funcionais    a,',
'         inf_pessoais            b,',
'         unidade_administrativa  u,',
'         atividade v',
'   where a.cod_empresa   = b.cod_empresa',
'     and a.matricula   = b.matricula',
'     and a.cod_empresa = :p78_cod_empresa',
'     and a.cod_empresa = u.cod_empresa (+)',
'     and a.unidade_adm = u.cod_unidade_adm (+)',
'     and a.cod_atividade = v.cod (+)',
'     and a.filial = u.cod_filial (+)',
'   --  and a.vinculo <>''E''',
'     and a.situacao < ''90''',
'     and (:p_Painel <> ''PC'' or (:p_painel = ''PC'' and a.cod_empresa = :p_empresa_user and a.matricula = :p_matricula_user))',
'order by a.matricula */'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P78_COD_EMPRESA'
,p_ajax_items_to_submit=>'P78_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'NO_FETCH'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669323791581413693)
,p_name=>'P78_MATRICULA_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669324218980413693)
,p_name=>'P78_MESES_ADM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669324638473413693)
,p_name=>'P78_VINCULO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669324947529413693)
,p_name=>'P78_COD_VAGA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669325354533413693)
,p_name=>'P78_OPCAO_PARC_SN'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669325835629413694)
,p_name=>'P78_DC_MATRICULA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_use_cache_before_default=>'NO'
,p_source=>'DC_MATRICULA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669326174546413694)
,p_name=>'P78_EMP'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669326612424413694)
,p_name=>'P78_MAT'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669327021980413694)
,p_name=>'P78_FILIAL'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669327439848413698)
,p_name=>'P78_IND_DUPLO_VINCULO'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669327830277413698)
,p_name=>'P78_DATA_REF'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669328237273413701)
,p_name=>'P78_SALDO_FER_MIN'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(202272274750104516580)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669328941003413701)
,p_name=>'P78_FOTO_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272278763717516583)
,p_display_as=>'NATIVE_DISPLAY_IMAGE'
,p_tag_css_classes=>'fotoColabMed'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'SQL'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select foto',
'  from fotos',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula;'))
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669329552128413702)
,p_name=>'P78_COD_EMPRESA_DISPLAY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272279582985516584)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669330019863413702)
,p_name=>'P78_MATRICULA_DISPLAY'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272279582985516584)
,p_prompt=>'Colaborador'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669330368055413702)
,p_name=>'P78_SITUACAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272279582985516584)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669330749884413703)
,p_name=>'P78_DT_ADMISSAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272279582985516584)
,p_prompt=>unistr('Data de Admiss\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669331859921413703)
,p_name=>'P78_QTD_PARCELAS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272281567918516588)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669332596854413704)
,p_name=>'P78_DIAS_DIREITO_OPC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669333035313413704)
,p_name=>'P78_OPCAO_FERIAS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_prompt=>unistr('Como voc\00EA quer tirar suas f\00E9rias?')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select N descricao, I cod',
'from pkg_list.fnc_list_opc_prog_ferias(:P78_cod_empresa,',
'                                       :P78_matricula,',
'                                       :P78_filial,',
'                                       nvl(:P78_DT_INIC_PER_FERIAS,:P78_DT_INIC_PER_FERIAS_1),',
'                                       :P78_QTD_PARCELAS,',
'                                       :P78_DIAS_DIREITO_OPC,',
'                                       :P78_DIAS_DIREITO_1,',
'                                       :P78_FLAG_CTRL,',
'                                       :P78_meses_adm)'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P78_DT_INIC_PER_FERIAS,P78_MATRICULA,P78_COD_EMPRESA,P78_FILIAL,P78_QTD_PARCELAS,P78_DIAS_DIREITO_OPC,P78_DIAS_DIREITO_1,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-opcao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669333439502413705)
,p_name=>'P78_OPCAO_FERIAS_A'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_prompt=>unistr('Como voc\00EA quer tirar suas f\00E9rias?')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 	f.qtd_parcelas||'' ''||'' Parcela(s): ''||f.descricao descricao, ',
'		f.cod',
'  from ferias_parametros_parcelas f'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-opcao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669333766654413705)
,p_name=>'P78_DIAS_ABONO_PEC1_OPC'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669334165833413705)
,p_name=>'P78_OPCAO_FERIAS_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_prompt=>unistr('(1) Op\00E7\00F5es de Programa\00E7\00E3o de F\00E9rias')
,p_source=>'P78_OPCAO_FERIAS_DB'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct f.qtd_parcelas||'' Parcela(s): ''||f.descricao descricao, f.cod',
'  from ferias_parametros_parcelas f',
' where f.cod_empresa = :p78_cod_empresa',
'   and f.cod_filial = :p78_filial',
'   and f.dias_direito = nvl(:P78_DIAS_DIREITO_1,:P78_DIAS_DIREITO_OPC)',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P78_COD_EMPRESA,P78_FILIAL,P78_DIAS_DIREITO_1,P78_DIAS_DIREITO_OPC'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 -- Igor 30/03',
'  from ferias_parametros_parcelas f',
' where f.cod_empresa = :p78_cod_empresa',
'   and f.cod_filial = :p78_filial'))
,p_display_when_type=>'EXISTS'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669334611714413706)
,p_name=>'P78_PARCELAS_OPC'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669334956878413706)
,p_name=>'P78_HAVERA_REP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202039115039662695324)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Outra pessoa vai fazer o seu trabalho enquanto voc\00EA estiver de f\00E9rias?')
,p_source=>'HAVERA_REP'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_colspan=>4
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-simnao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Responda Sim quando outra pessoa vai assumir o seu trabalho durante as f\00E9rias (reposi\00E7\00E3o). Com Sim, aparece o bot\00E3o Requisi\00E7\00E3o Pessoal para pedir essa pessoa.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669335680410413706)
,p_name=>'P78_DT_SAIDA_PARC2_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>unistr('Data da Sa\00EDda')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669336118478413706)
,p_name=>'P78_NUM_DIAS_PARC2_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>unistr('N\00FAmero de Dias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669336538658413706)
,p_name=>'P78_DIAS_ABONO_PEC2_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>'Dias de Abono'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669336917707413707)
,p_name=>'P78_OPCAO_13SAL2_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>unistr('13\00BA Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669337246309413707)
,p_name=>'P78_DESC_ADICIONAL2_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>unistr('B\00F4nus F\00E9rias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669337671627413707)
,p_name=>'P78_DT_RETORNO_PARC2_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_prompt=>'Data de Retorno'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669338090033413707)
,p_name=>'P78_DT_PAGTO_PARC2_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669338523386413707)
,p_name=>'P78_TIPO_FERIAS2_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202042663264835043648)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669339198323413708)
,p_name=>'P78_DT_SAIDA_PARC4_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>unistr('Data da Sa\00EDda')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669339585282413708)
,p_name=>'P78_NUM_DIAS_PARC4_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>unistr('N\00FAmero de Dias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669340022984413708)
,p_name=>'P78_DIAS_ABONO_PEC4_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>'Dias de Abono'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669340415491413709)
,p_name=>'P78_OPCAO_13SAL4_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>unistr('13\00BA Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669340789980413709)
,p_name=>'P78_DESC_ADICIONAL4_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>unistr('B\00F4nus F\00E9rias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669341167491413709)
,p_name=>'P78_DT_RETORNO_PARC4_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_prompt=>'Data de Retorno'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669341584414413709)
,p_name=>'P78_DT_PAGTO_PARC4_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669341987885413710)
,p_name=>'P78_TIPO_FERIAS4_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202042664182479043657)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669342683252413714)
,p_name=>'P78_DT_SAIDA_PARC4'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Em que dia voc\00EA come\00E7a as f\00E9rias?')
,p_source=>'DT_SAIDA_PARC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669343063149413714)
,p_name=>'P78_NUM_DIAS_PARC4'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero de Dias')
,p_source=>'NUM_DIAS_PARC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669343541029413714)
,p_name=>'P78_NUM_DIAS_PARC4_LST'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_prompt=>'Quantos dias?'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select N DESCRICAO, I DIAS ',
' from pkg_list_matricula.fnc_list_numdias(',
'                            :P78_COD_EMPRESA,',
'                            :P78_FILIAL,',
'                            nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A),',
'                            :P78_PARCELAS_OPC,',
'                            nvl(:P78_MESES_ADM,12),',
'                            nvl(:P78_NUM_DIAS_PARC1_LST,:P78_NUM_DIAS_PARC1_1),',
'                            nvl(:P78_NUM_DIAS_PARC2_LST,:P78_NUM_DIAS_PARC2_1))',
'/*',
'select  distinct',
'        X.DESCRICAO,',
'        X.DIAS',
'from    (',
'        select  decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DESCRICAO,',
'                decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DIAS,',
'                (nvl(A.NUM_DIAS_PARC4,0)+nvl(A.NUM_DIAS_PARC2,0)+nvl(A.NUM_DIAS_PARC1,0)) -',
'                (nvl(:P78_NUM_DIAS_PARC1_LST,0)+nvl(:P78_NUM_DIAS_PARC2_LST,0)) C2',
'        from    FERIAS_PARAMETROS_PARCELAS A,',
'                (select rownum NLIN from dual connect by level <= :P78_PARCELAS_OPC) B',
'        where   (',
'                    instr('';''||:P78_NUM_DIAS_PARC1_LST||'';''||:P78_NUM_DIAS_PARC2_LST||'';'','';''||decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4)||'';'') = 0 or',
'                    (instr('';''||:P78_NUM_DIAS_PARC1_LST||'';''||:P78_NUM_DIAS_PARC2_LST||'';'','';''||decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4)||'';'') > 0 and',
'                       (',
'                     ((nvl(A.NUM_DIAS_PARC4,0)+nvl(A.NUM_DIAS_PARC2,0)+nvl(A.NUM_DIAS_PARC1,0)) - (nvl(:P78_NUM_DIAS_PARC1_LST,0)+nvl(:P78_NUM_DIAS_PARC2_LST,0)) = nvl(A.NUM_DIAS_PARC1,0)) or',
'                     ((nvl(A.NUM_DIAS_PARC4,0)+nvl(A.NUM_DIAS_PARC2,0)+nvl(A.NUM_DIAS_PARC1,0)) - (nvl(:P78_NUM_DIAS_PARC1_LST,0)+nvl(:P78_NUM_DIAS_PARC2_LST,0)) = nvl(A.NUM_DIAS_PARC2,0)) or',
'                     ((nvl(A.NUM_DIAS_PARC4,0)+nvl(A.NUM_DIAS_PARC2,0)+nvl(A.NUM_DIAS_PARC1,0)) - (nvl(:P78_NUM_DIAS_PARC1_LST,0)+nvl(:P78_NUM_DIAS_PARC2_LST,0)) = nvl(A.NUM_DIAS_PARC4,0))',
'                        )',
'                    )',
'                )',
'        and     nvl(A.NUM_DIAS_PARC4,nvl(A.NUM_DIAS_PARC2,A.NUM_DIAS_PARC1)) is not null',
'        and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'        and     A.COD_FILIAL = :P78_FILIAL',
'        and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A)',
'        and     nvl(:P78_MESES_ADM,12) between nvl(A.MESES_MIN,0) and nvl(A.MESES_MAX,999)',
'        ) X',
'where   X.DIAS = X.C2',
'*/',
'/*',
'select x.descricao, x.dias',
'from (',
'select ',
'num_dias_parc1 descricao, num_dias_parc1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc2 descricao, num_dias_parc2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc4 descricao, num_dias_parc4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = :p78_opcao_ferias',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)',
'*/'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P78_PARCELAS_OPC,P78_NUM_DIAS_PARC1_LST,P78_NUM_DIAS_PARC2_LST,P78_COD_EMPRESA,P78_FILIAL,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669343918730413714)
,p_name=>'P78_DIAS_ABONO_PEC4'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dias de Abono'
,p_source=>'DIAS_ABONO_PEC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669344252883413715)
,p_name=>'P78_DIAS_ABONO_PEC4_LST'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_prompt=>'Dias vendidos (abono)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.descricao, x.dias',
'from (',
'select ',
'dias_abono_pec1 descricao, dias_abono_pec1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec2 descricao, dias_abono_pec2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec4 descricao, dias_abono_pec4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = nvl(:p78_opcao_ferias,:p78_opcao_ferias_a)',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)',
'',
''))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-'
,p_lov_cascade_parent_items=>'P78_COD_EMPRESA,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_FILIAL,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669344672110413715)
,p_name=>'P78_OPCAO_13SAL4'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Quer receber metade do 13\00BA sal\00E1rio junto com estas f\00E9rias?')
,p_source=>'OPCAO_13SAL4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-simnao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669345095160413715)
,p_name=>'P78_DESC_ADICIONAL4'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Descanso Adicional'
,p_source=>'DESC_ADICIONAL4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669345476258413715)
,p_name=>'P78_DT_RETORNO_PARC4'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Volta ao trabalho'
,p_source=>'DT_RETORNO_PARC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly=''readonly'''
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-retorno'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669345851562413715)
,p_name=>'P78_DT_PAGTO_PARC4'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_PAGTO_PARC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669346340444413715)
,p_name=>'P78_TIPO_FERIAS4'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_FERIAS4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669346707411413716)
,p_name=>'P78_OPCAO_ABONO_PEC4'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202136605286391907173)
,p_use_cache_before_default=>'NO'
,p_source=>'OPCAO_ABONO_PEC4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669347443362413716)
,p_name=>'P78_FALTA_HORA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_source=>'FALTA_HORA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669347789539413716)
,p_name=>'P78_FALTA_MINUTO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_source=>'FALTA_MINUTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669348211553413716)
,p_name=>'P78_DIAS_DIREITO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669348625380413716)
,p_name=>'P78_DIAS_DESCANSO_ADICIONAL'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_source=>'DIAS_DESCANSO_ADICIONAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669348981192413716)
,p_name=>'P78_SALDO_BRUTO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_source=>'SALDO_BRUTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669349416395413717)
,p_name=>'P78_SALDO'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_source=>'SALDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669349827689413717)
,p_name=>'P78_FALTA_HORA_1'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Faltas no Per\00EDodo')
,p_source=>'FALTA_HORA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669350194258413717)
,p_name=>'P78_FALTA_MINUTO_1'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dias'
,p_source=>'FALTA_MINUTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669350627480413717)
,p_name=>'P78_DIAS_DIREITO_1'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_prompt=>'Dias de Direito'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669350980684413717)
,p_name=>'P78_DIAS_DESCANSO_ADICIONAL_1'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('B\00F4nus de F\00E9rias')
,p_source=>'DIAS_DESCANSO_ADICIONAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669351421396413717)
,p_name=>'P78_SALDO_BRUTO_1'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Saldo Bruto'
,p_source=>'SALDO_BRUTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669351814980413717)
,p_name=>'P78_SALDO_1'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(202272282369576516589)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Saldo Final'
,p_source=>'SALDO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669352451570413718)
,p_name=>'P78_DT_SAIDA_PARC1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Em que dia voc\00EA come\00E7a as f\00E9rias?')
,p_source=>'DT_SAIDA_PARC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669352908667413718)
,p_name=>'P78_NUM_DIAS_PARC1_DSP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669353291052413718)
,p_name=>'P78_NUM_DIAS_PARC1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero de Dias')
,p_placeholder=>'Ex.: 30'
,p_source=>'NUM_DIAS_PARC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669353679316413718)
,p_name=>'P78_NUM_DIAS_PARC1_LST'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_prompt=>'Quantos dias?'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select N DESCRICAO, I DIAS ',
' from pkg_list_matricula.fnc_list_numdias(',
'                            :P78_COD_EMPRESA,',
'                            :P78_FILIAL,',
'                            nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A),',
'                            :P78_PARCELAS_OPC,',
'                            nvl(:P78_MESES_ADM,12),',
'                            null,',
'                            null)',
'/*select  distinct',
'        X.DESCRICAO,',
'        X.DIAS',
'from    (',
'        select  decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DESCRICAO,',
'                decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DIAS',
'        from    FERIAS_PARAMETROS_PARCELAS A,',
'                (select rownum NLIN from dual connect by level <= :P78_PARCELAS_OPC) B',
'        where   nvl(A.NUM_DIAS_PARC4,nvl(A.NUM_DIAS_PARC2,A.NUM_DIAS_PARC1)) is not null',
'        and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'        and     A.COD_FILIAL = :P78_FILIAL',
'        and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A)',
'        and     nvl(:P78_MESES_ADM,12) between nvl(A.MESES_MIN,0) and nvl(A.MESES_MAX,999)',
'        ) X',
'*/',
'/*',
'select x.descricao, x.dias',
'from (',
'select ',
'num_dias_parc1 descricao, num_dias_parc1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc2 descricao, num_dias_parc2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc4 descricao, num_dias_parc4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = :p78_opcao_ferias',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)',
'  */'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-'
,p_lov_cascade_parent_items=>'P78_PARCELAS_OPC,P78_COD_EMPRESA,P78_FILIAL,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669354058927413718)
,p_name=>'P78_DIAS_ABONO_PEC1_DSP'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669354513183413719)
,p_name=>'P78_DIAS_ABONO_PEC1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dias de Abono'
,p_source=>'DIAS_ABONO_PEC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669354878632413719)
,p_name=>'P78_DIAS_ABONO_PEC1_LST'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_prompt=>'Dias vendidos (abono)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.descricao, x.dias',
'from (',
'select ',
'dias_abono_pec1 descricao, dias_abono_pec1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec2 descricao, dias_abono_pec2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec4 descricao, dias_abono_pec4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A)',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-'
,p_lov_cascade_parent_items=>'P78_COD_EMPRESA,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_FILIAL,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669355330843413719)
,p_name=>'P78_OPCAO_13SAL1'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Quer receber metade do 13\00BA sal\00E1rio junto com estas f\00E9rias?')
,p_source=>'OPCAO_13SAL1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-simnao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669355679513413719)
,p_name=>'P78_DESC_ADICIONAL1'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Descanso Adicional'
,p_source=>'DESC_ADICIONAL1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669356099299413719)
,p_name=>'P78_DT_RETORNO_PARC1_X'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669356507130413719)
,p_name=>'P78_DT_RETORNO_PARC1'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Volta ao trabalho'
,p_format_mask=>'DD/MM/YYYY'
,p_source=>'DT_RETORNO_PARC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly=''readonly'''
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-retorno'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669356885406413720)
,p_name=>'P78_TESTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669357310677413720)
,p_name=>'P78_TESTE_2'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669357660594413720)
,p_name=>'P78_TESTE_3'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669358094996413721)
,p_name=>'P78_TESTE_DEFAULT'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669358465762413721)
,p_name=>'P78_DT_PAGTO_PARC1'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_PAGTO_PARC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669358885525413722)
,p_name=>'P78_TIPO_FERIAS1'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_FERIAS1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669359265631413722)
,p_name=>'P78_OPCAO_ABONO_PEC1'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(202272287553987516594)
,p_use_cache_before_default=>'NO'
,p_source=>'OPCAO_ABONO_PEC1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669359977725413722)
,p_name=>'P78_DT_SAIDA_PARC2'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Em que dia voc\00EA come\00E7a as f\00E9rias?')
,p_source=>'DT_SAIDA_PARC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'both'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669360395486413722)
,p_name=>'P78_NUM_DIAS_PARC2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero de Dias')
,p_source=>'NUM_DIAS_PARC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669360819182413722)
,p_name=>'P78_NUM_DIAS_PARC2_LST'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_prompt=>'Quantos dias?'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select N DESCRICAO, I DIAS ',
' from pkg_list_matricula.fnc_list_numdias(',
'                            :P78_COD_EMPRESA,',
'                            :P78_FILIAL,',
'                            nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A),',
'                            :P78_PARCELAS_OPC,',
'                            nvl(:P78_MESES_ADM,12),',
'                            nvl(:P78_NUM_DIAS_PARC1_LST,:P78_NUM_DIAS_PARC1_1),',
'                            null)',
'/*',
'select  ',
'        X.DESCRICAO,',
'        X.DIAS',
'from    (',
'        select  decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DESCRICAO,',
'                decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4) DIAS',
'        from    FERIAS_PARAMETROS_PARCELAS A,',
'                (select rownum NLIN from dual connect by level <= :P78_PARCELAS_OPC) B',
'        where   (',
'                    (A.NUM_DIAS_PARC1 != A.NUM_DIAS_PARC2 and',
'                        instr('';''||nvl(:P78_NUM_DIAS_PARC1_LST,:P78_NUM_DIAS_PARC1_1)||'';'','';''||decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4)||'';'') = 0) or',
'                    (A.NUM_DIAS_PARC1 = A.NUM_DIAS_PARC2 and ',
'                        instr('';1-''||nvl(:P78_NUM_DIAS_PARC1_LST,:P78_NUM_DIAS_PARC1_1)||'';'','';''||decode(B.NLIN,1,''1-''||A.NUM_DIAS_PARC1,2,''2-''||A.NUM_DIAS_PARC2,3,''3-''||A.NUM_DIAS_PARC4)||'';'') = 0)',
'                )',
'        and     nvl(A.NUM_DIAS_PARC4,nvl(A.NUM_DIAS_PARC2,A.NUM_DIAS_PARC1)) is not null',
'        and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'        and     A.COD_FILIAL = :P78_FILIAL',
'        and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A)',
'        and     nvl(:P78_MESES_ADM,12) between nvl(A.MESES_MIN,0) and nvl(A.MESES_MAX,999)',
'        group by',
'				decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4),',
'                decode(B.NLIN,1,A.NUM_DIAS_PARC1,2,A.NUM_DIAS_PARC2,3,A.NUM_DIAS_PARC4)',
'        ) X',
'where	X.DIAS is not null',
'*/',
'/*',
'select x.descricao, x.dias',
'from (',
'select ',
'num_dias_parc1 descricao, num_dias_parc1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc2 descricao, num_dias_parc2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'num_dias_parc4 descricao, num_dias_parc4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = :p78_opcao_ferias',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)',
'*/'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P78_NUM_DIAS_PARC1_LST,P78_NUM_DIAS_PARC1_1,P78_PARCELAS_OPC,P78_COD_EMPRESA,P78_FILIAL,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669361194867413723)
,p_name=>'P78_DIAS_ABONO_PEC2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Dias de Abono'
,p_source=>'DIAS_ABONO_PEC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669361559704413723)
,p_name=>'P78_DIAS_ABONO_PEC2_LST'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_prompt=>'Dias vendidos (abono)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select  ',
'        X.DESCRICAO,',
'        X.DIAS',
'from    (',
'        select  decode(B.NLIN,1,A.DIAS_ABONO_PEC1,2,A.DIAS_ABONO_PEC2,3,A.DIAS_ABONO_PEC4) DESCRICAO,',
'                decode(B.NLIN,1,A.DIAS_ABONO_PEC1,2,A.DIAS_ABONO_PEC2,3,A.DIAS_ABONO_PEC4) DIAS',
'        from    FERIAS_PARAMETROS_PARCELAS A,',
'                (select rownum NLIN from dual connect by level <= :P78_PARCELAS_OPC) B',
'        where   1=1--(nvl(A.DIAS_ABONO_PEC1,0) - (nvl(:P78_DIAS_ABONO_PEC1_LST,0)+nvl(:P78_DIAS_ABONO_PEC2_LST,0)+nvl(:P78_DIAS_ABONO_PEC4_LST,0)) > 0)',
'        and     1=1--nvl(A.DIAS_ABONO_PEC4,nvl(A.DIAS_ABONO_PEC2,A.DIAS_ABONO_PEC1)) is not null',
'        and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'        and     A.COD_FILIAL = :P78_FILIAL',
'        and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A)',
'        and     nvl(:P78_MESES_ADM,12) between nvl(A.MESES_MIN,0) and nvl(A.MESES_MAX,999)',
'        group by',
'                decode(B.NLIN,1,A.DIAS_ABONO_PEC1,2,A.DIAS_ABONO_PEC2,3,A.DIAS_ABONO_PEC4),',
'                decode(B.NLIN,1,A.DIAS_ABONO_PEC1,2,A.DIAS_ABONO_PEC2,3,A.DIAS_ABONO_PEC4)',
'        ) X',
'where   X.DIAS is not null',
'    ',
'/*select x.descricao, x.dias',
'from (',
'select ',
'dias_abono_pec1 descricao, dias_abono_pec1 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec2 descricao, dias_abono_pec2 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec4 descricao, dias_abono_pec4 dias, cod_empresa, cod, cod_filial, meses_min, meses_max',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = :p78_cod_empresa',
'  and x.cod = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A)',
'  and nvl(:p78_meses_adm,12) between nvl(x.meses_min,0) and nvl(x.meses_max,999)*/'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-'
,p_lov_cascade_parent_items=>'P78_PARCELAS_OPC,P78_DIAS_ABONO_PEC1_LST,P78_DIAS_ABONO_PEC4_LST,P78_COD_EMPRESA,P78_FILIAL,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_MESES_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P78_COD_SOLICITACAO'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-dias'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669361981197413723)
,p_name=>'P78_OPCAO_13SAL2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Quer receber metade do 13\00BA sal\00E1rio junto com estas f\00E9rias?')
,p_source=>'OPCAO_13SAL2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-simnao'
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669362356981413723)
,p_name=>'P78_DESC_ADICIONAL2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Descanso Adicional'
,p_source=>'DESC_ADICIONAL2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669362833962413723)
,p_name=>'P78_DT_RETORNO_PARC2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Volta ao trabalho'
,p_source=>'DT_RETORNO_PARC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_attributes=>'readonly=''readonly'''
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_css_classes=>'nc-fer-retorno'
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669363225918413723)
,p_name=>'P78_DT_PAGTO_PARC2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_PAGTO_PARC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669363551703413724)
,p_name=>'P78_TIPO_FERIAS2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_source=>'TIPO_FERIAS2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669363950826413724)
,p_name=>'P78_OPCAO_ABONO_PEC2'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202272292700792516598)
,p_use_cache_before_default=>'NO'
,p_source=>'OPCAO_ABONO_PEC2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669364655423413724)
,p_name=>'P78_DT_SAIDA_PARC3'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272296663588516604)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data da Sa\00EDda')
,p_source=>'DT_SAIDA_PARC3'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669365126035413724)
,p_name=>'P78_NUM_DIAS_PARC3'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272296663588516604)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00FAmero de Dias')
,p_source=>'NUM_DIAS_PARC3'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669365493904413724)
,p_name=>'P78_DT_RETORNO_PARC3'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272296663588516604)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Retorno'
,p_source=>'DT_RETORNO_PARC3'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669365906587413724)
,p_name=>'P78_TIPO_FERIAS3'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272296663588516604)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de F\00E9rias')
,p_source=>'TIPO_FERIAS3'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Normal;N,Coletiva;C'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669366554874413726)
,p_name=>'P78_DT_INIC_PER_FERIAS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_INIC_PER_FERIAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669366972001413726)
,p_name=>'P78_DT_FIM_PER_FERIAS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_FIM_PER_FERIAS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669367428002413727)
,p_name=>'P78_IND_SITUACAO_PERIODO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_SITUACAO_PERIODO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669367761091413727)
,p_name=>'P78_IND_SITUACAO_PERIODO_A'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669368233541413727)
,p_name=>'P78_IND_SITUACAO_PARC_2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_SITUACAO_PARC_2'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669368578326413727)
,p_name=>'P78_IND_SITUACAO_PARC_2_A'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669369043459413727)
,p_name=>'P78_IND_SITUACAO_PARC_4'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_use_cache_before_default=>'NO'
,p_source=>'IND_SITUACAO_PARC_4'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669369388738413727)
,p_name=>'P78_IND_SITUACAO_PARC_4_A'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669369807514413727)
,p_name=>'P78_JORNADA_REDUZIDA'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669370209675413730)
,p_name=>'P78_DT_INIC_PER_FERIAS_1'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_prompt=>unistr('Data In\00EDcio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669370590757413730)
,p_name=>'P78_DT_FIM_PER_FERIAS_1'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_prompt=>'Data Fim'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669371012870413730)
,p_name=>'P78_IND_SITUACAO_PERIODO_1'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_prompt=>unistr('Situa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669371414677413731)
,p_name=>'P78_JORNADA_REDUZIDA_1'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_prompt=>'Jornada Reduzida'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669371826216413731)
,p_name=>'P78_DT_LIMITE_REQ'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(202272298636414516606)
,p_prompt=>unistr('Data Limite In\00EDcio das F\00E9rias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669372537571413731)
,p_name=>'P78_DT_SAIDA_PARC1_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>unistr('Data da Sa\00EDda')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669372917503413731)
,p_name=>'P78_NUM_DIAS_PARC1_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>unistr('N\00FAmero de Dias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669373307506413731)
,p_name=>'P78_DIAS_ABONO_PEC1_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>'Dias de Abono'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669373695211413731)
,p_name=>'P78_OPCAO_13SAL1_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>unistr('13\00BA Sal\00E1rio')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669374065707413732)
,p_name=>'P78_DESC_ADICIONAL1_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>unistr('B\00F4nus F\00E9rias')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669374475500413732)
,p_name=>'P78_DT_RETORNO_PARC1_1'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_prompt=>'Data de Retorno'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(145492037591409058617)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669374936836413734)
,p_name=>'P78_DT_PAGTO_PARC1_1'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(89669375318079413735)
,p_name=>'P78_TIPO_FERIAS1_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(202272302310720516609)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669376282961413752)
,p_validation_name=>'Valid_P78_DIAS_ABONO_PEC1'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    nC number;',
'begin',
'    select  max(',
'				case',
'                when nvl(A.DIAS_ABONO_PEC1,0) = ',
'                     nvl(:P78_DIAS_ABONO_PEC1,nvl(:P78_DIAS_ABONO_PEC1_1,0))+nvl(:P78_DIAS_ABONO_PEC2,0)+nvl(:P78_DIAS_ABONO_PEC4,0) then 1 end',
'			)',
'    into    nC',
'    from    FERIAS_PARAMETROS_PARCELAS A',
'    where   A.COD_EMPRESA = nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'    and     A.COD_FILIAL = :P78_FILIAL',
'    and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OP);',
'	nC := 1;',
'    ',
'    return nC is not null;',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Selecione os Dias de Abono de uma das parcelas.'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669388683587413766)
,p_validation_name=>'Valida P78_DIAS_DIREITO_OPC'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'IF :P78_MATRICULA IS NOT NULL AND :P78_ROWID IS NULL THEN',
'',
' if NVL(:P78_DIAS_DIREITO_OPC,0) = 0 then',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''Para este per\00EDodo de f\00E9rias (''||:P78_DT_INIC_PER_FERIAS_1||'' \00E0 ''||:P78_DT_FIM_PER_FERIAS_1||''), o colaborador n\00E3o tem mais dias dispon\00EDveis a ser gozado.'';'),
' end if;',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        return trim(v_msg_retorno);',
'    end if;',
' ',
'END IF;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669390695347413767)
,p_validation_name=>'Valida dias distribuidos'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'num_dias_parc1 number := :P78_num_dias_parc1;',
'num_dias_parc2 number := :P78_num_dias_parc2;',
'num_dias_parc4 number := :P78_num_dias_parc4;',
'',
'dias_abono_pec1 number := :P78_dias_abono_pec1;',
'dias_abono_pec2 number := :P78_dias_abono_pec2;',
'dias_abono_pec4 number := :P78_dias_abono_pec4;',
'',
'dias_direito number := nvl(:P78_dias_direito,:P78_dias_direito_1);',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is null and :p78_dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is not null an'
||'d :p78_dt_saida_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
'',
'if :p78_meses_adm >= 12 then',
'    if ((:P78_PARCELAS_OPC = 1 and :P78_DT_SAIDA_PARC1 IS NOT NULL) OR',
'       (:P78_PARCELAS_OPC = 2 and :P78_DT_SAIDA_PARC1 IS NOT NULL AND :P78_DT_SAIDA_PARC2 IS NOT NULL) OR',
'       (:P78_PARCELAS_OPC = 3 and :P78_DT_SAIDA_PARC1 IS NOT NULL AND :P78_DT_SAIDA_PARC2 IS NOT NULL AND :P78_DT_SAIDA_PARC4 IS NOT NULL)) AND',
'       (nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)))',
'    then',
'        v_flg_retorno := ''N'';',
unistr('        v_msg_retorno := ''A soma do(s) dia(s) da(s) parcela(s), est\00E1 inferior aos dias de direito de ''||dias_direito||'' dias. Distribua os dias corretamente.'';'),
'    end if;',
'end if;',
'',
' if trim(v_msg_retorno) is not null then',
' return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669389916750413767)
,p_validation_name=>'Valida Data InformadaX'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p78_dt_saida_parc1_1 is null and :p78_dt_saida_parc1 is null then',
unistr('return ''Deve se informar a data de sa\00EDda de f\00E9rias!'';'),
'elsif (:p78_dt_saida_parc1_1 is not null or :p78_dt_saida_parc1 is not null) and :p78_dt_saida_parc2_1 is null and :p78_dt_saida_parc2 is null then',
unistr('return ''Deve se informar a data de sa\00EDda de f\00E9rias!'';'),
'elsif (:p78_dt_saida_parc1_1 is not null or :p78_dt_saida_parc1 is not null) or (:p78_dt_saida_parc2_1 is not null or :p78_dt_saida_parc2 is not null) and :p78_dt_saida_parc4_1 is null and :p78_dt_saida_parc4 is null then',
unistr('return ''Deve se informar a data de sa\00EDda de f\00E9rias!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669390296307413767)
,p_validation_name=>'Valida Dias Direito'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_DIAS_DIREITO_OPC = 0 then',
unistr('return ''Para este per\00EDodo de f\00E9rias, o colaborador n\00E3o tem mais dias dispon\00EDveis a ser gozado.'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669389487461413766)
,p_validation_name=>'Pre_Insert'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'v_dias_abono_pec FERIAS.dias_abono_pec1%TYPE;',
'begin',
'',
'',
'v_dias_abono_pec := nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1);',
'PKG_FERIAS.Pre_Insert( :p78_cod_solicitacao,',
'                       nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                       :p78_filial,',
'                       :p78_matricula,',
'                       :p78_sit_requisicao,',
'                       nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                       nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                       nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                       nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                       nvl(:p78_saldo,:p78_saldo_1),',
'                       nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),  ',
'                       nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                       :p78_dt_saida_parc3, -- Igor 30/03',
'                       nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1),',
'                       nvl(:p78_dt_retorno_parc1,nvl(:p78_dt_retorno_parc1_1,NVL(:P78_DT_RETORNO_PARC1_1A, :P78_DT_RETORNO_PARC1_1_AUX))),',
'                       nvl(:p78_dt_retorno_parc2,:p78_dt_retorno_parc2_1),',
'                       :p78_dt_retorno_parc3, -- Igor 30/03',
'                       nvl(:p78_dt_retorno_parc4,:p78_dt_retorno_parc4_1),',
'                      :p78_opcao_13sal1,',
'                      :p78_opcao_13sal2,',
'                      :p78_opcao_13sal4,',
'                       v_dias_abono_pec,',
'                       :p78_jornada_reduzida,',
'                       v_flg_retorno,',
'                       v_msg_retorno,',
'					 :P78_PARCELAS_OPC);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return trim(v_msg_retorno);',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669379540857413758)
,p_validation_name=>'Valida_Update_Rf'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_dias_abono_pec1 number := :p78_dias_abono_pec1;',
'',
'begin',
'',
'PKG_FERIAS.Valida_Update_Rf(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                            :p78_filial,',
'                            nvl(:P78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                            nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                            :p78_num_dias_parc1,',
'                            v_dias_abono_pec1,',
'                            nvl(:p78_saldo,:p78_saldo_1),',
'                            :p78_matricula,',
'                            :p78_jornada_reduzida,',
'                            V_flg_retorno,',
'                            V_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669389070500413766)
,p_validation_name=>unistr('OPCAO_FERIAS Obrigat\00F3rio')
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select x.descricao, x.dias',
'from (',
'select ',
'dias_abono_pec1 descricao, dias_abono_pec1 dias, cod_empresa, cod, cod_filial',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec2 descricao, dias_abono_pec2 dias, cod_empresa, cod, cod_filial',
'  from ferias_parametros_parcelas',
'union',
'select ',
'dias_abono_pec4 descricao, dias_abono_pec4 dias, cod_empresa, cod, cod_filial',
'  from ferias_parametros_parcelas) x',
'where x.dias is not null   ',
'  and x.cod_filial = :p78_filial',
'  and x.cod_empresa = nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1);',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if v_c1.dias is not null and nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A) is null AND :P78_VINCULO <> ''E'' then',
unistr('return ''O Campo Op\00E7\00F5es de Programa\00E7\00E3o de F\00E9rias \00E9 Obrigat\00F3rio!'';'),
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669333035313413704)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669388280477413765)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P78_SIT_REQUISICAO = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_api.id(89669311634907413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669382317122413760)
,p_validation_name=>'Valida_Num_Dias_Parcelas'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'num_dias_parc1 number := :P78_num_dias_parc1;',
'num_dias_parc2 number := :P78_num_dias_parc2;',
'num_dias_parc4 number := :P78_num_dias_parc4;',
'',
'dias_abono_pec1 number := :P78_dias_abono_pec1;',
'dias_abono_pec2 number := :P78_dias_abono_pec2;',
'dias_abono_pec4 number := :P78_dias_abono_pec4;',
'',
'dias_direito number := nvl(:P78_dias_direito,:P78_dias_direito_1);',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is null and :p78_dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and :p78_dt_saida_parc1 is not null and :p78_dt_saida_parc2 is not null an'
||'d :p78_dt_saida_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
' ',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('      return ''N\00FAmero de Dias de Parcelas: ''||v_msg_retorno;'),
'  end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669381450305413760)
,p_validation_name=>'Valida_dt_saida_parc1'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
'v_cod_empresa:= nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1);',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1);',
'v_dt_fim_per_ferias := nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1);',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := nvl(:p78_saldo_bruto,:p78_saldo_bruto_1);',
'v_falta_hora := nvl(:p78_falta_hora,:p78_falta_hora_1);',
'v_dias_direito := nvl(:p78_dias_direito,:p78_dias_direito_1);',
'v_dt_saida_parc1 := :p78_dt_saida_parc1;',
'v_saldo := nvl(:p78_saldo,:p78_saldo_1);',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a);',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno); ',
'',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('      return ''Data de Sa\00EDda Parcela 1: ''||v_msg_retorno;'),
'  end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669381876490413760)
,p_validation_name=>'Valida_Num_Dias_Parc1'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_cod_empresa      number := nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1);',
'v_matricula inf_pessoais.matricula%type := :p78_matricula;',
'v_ind_limpa varchar2(200) := ''N'';',
'v_dt_fim_per_ferias ferias.dt_fim_per_ferias%type := nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1);',
'v_saldo     number := nvl(:p78_saldo,:p78_saldo_1);',
'v_dt_saida_parc1   ferias.dt_saida_parc1%type := :p78_dt_saida_parc1;',
'v_num_dias_parc1   number(15,2) := :p78_num_dias_parc1;',
'v_dt_retorno_parc1 ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old    ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dias_descanso_adicional ferias.dias_descanso_adicional%type := :p78_dias_descanso_adicional;',
'v_desc_adicional1  ferias.desc_adicional1%type := :p78_desc_adicional1;',
'v_tipo_ferias1     ferias.tipo_ferias1%type := :p78_tipo_ferias1;',
'v_dias_abono_pec1  number := :p78_dias_abono_pec1;',
'v_dias_direito     number := nvl(:p78_dias_direito,:p78_dias_direito_1);',
'v_ind_situacao_periodo    ferias.ind_situacao_periodo%type := nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a);',
'v_jornada_reduzida varchar2(100) := :p78_jornada_reduzida;',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
'pkg_ferias.Valida_Num_Dias_Parc1(v_cod_empresa,',
'     v_matricula,',
'     v_ind_limpa,',
'     v_dt_fim_per_ferias,',
'     v_saldo,',
'     v_dt_saida_parc1,',
'     v_num_dias_parc1,',
'     v_dt_retorno_parc1,',
'     v_dias_descanso_adicional,',
'     v_desc_adicional1,',
'     v_tipo_ferias1,',
'     v_dias_abono_pec1,',
'     v_dias_direito,',
'     v_ind_situacao_periodo,',
'     v_jornada_reduzida,',
'     :p78_dias_abono_pec1_dsp,',
'     :p78_num_dias_parc1_dsp,',
'     v_flg_retorno,',
'     v_msg_retorno,',
'     nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A));',
'',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('      return ''N\00FAmero de Dias Parcela 1: ''||v_msg_retorno;'),
'  end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669382720026413761)
,p_validation_name=>'Valida_Dias_Abono_Pec1'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
'pkg_ferias.Valida_Dias_Abono_Pec1(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1)        ,',
'                                  :p78_matricula          ,',
'                                  :p78_filial             ,',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1) ,',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1)  ,',
'                                  :p78_num_dias_parc1     ,',
'                                  :p78_dt_saida_parc1     ,',
'                                  nvl(:p78_saldo,:p78_saldo_1)              ,',
'                                  :p78_dias_abono_pec1    ,',
'                                  :p78_opcao_abono_pec1   ,',
'                                  nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                                  nvl(:p78_dias_direito,:p78_dias_direito_1)       ,',
'                                  :p_usuario,',
'                                  v_flg_retorno        ,',
'                                  v_msg_retorno        );',
' ',
'',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('      return ''N\00FAmero de Dias Abono Parcela 1: ''||v_msg_retorno;'),
'  end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669383049718413761)
,p_validation_name=>'Valida_Opcao_13Sal1'
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'IF :p78_opcao_13sal1 IS NOT NULL AND',
'   :p78_dt_saida_parc1 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
'',
'pkg_ferias.Valida_Opcao_13Sal1(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                               :p78_matricula,',
'                               :p78_dt_saida_parc1,',
'                               :p78_dt_retorno_parc1,',
'                               :p78_opcao_13sal1,',
'                               nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
' ',
' ',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('      return ''Op\00E7\00E3o 13 Sal. Parcela 1: ''||v_msg_retorno;'),
'  end if;',
' ',
'END IF;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669383506560413761)
,p_validation_name=>'Valida_Desc_Adicional1'
,p_validation_sequence=>170
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
'    pkg_ferias.Valida_Desc_Adicional1(:p78_desc_adicional1,',
'                                      :p78_dias_descanso_adicional,',
'                                      nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                                    v_flg_retorno,',
'                                    v_msg_retorno);',
'',
'  if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'      return ''Desconto Adicional Parcela 1: ''||v_msg_retorno;',
'  end if;',
'',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669383906782413762)
,p_validation_name=>'Valida_Tipo_Ferias1'
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'    ',
'    if :p78_dt_saida_parc1 is not null then',
'    ',
'       pkg_ferias.Valida_Tipo_Ferias1(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1)        ,',
'                                      :p78_matricula          ,',
'                                      nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1) ,',
'                                      nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1)  ,',
'                                      :p78_data_ref,',
'                                      :p78_tipo_ferias1,',
'                                      nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                                      v_flg_retorno        ,',
'                                      v_msg_retorno        );',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''Tipo de F\00E9rias Parcela 1: ''||v_msg_retorno;'),
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669384340851413762)
,p_validation_name=>'Valida_dt_saida_parc2'
,p_validation_sequence=>190
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_DIAS_ABONO_PEC2 number := :P78_DIAS_ABONO_PEC2;',
'',
'begin',
'',
'    if :P78_DT_SAIDA_PARC2 is not null then',
'',
'pkg_ferias.Valida_Dt_Saida_Parc2(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                  :p78_cod_solicitacao,',
'                                  :p78_matricula,',
'                                  nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                                  nvl(:p78_dt_retorno_parc1,:p78_dt_retorno_parc1_1),',
'                                  nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                                  :p78_dt_saida_parc2,',
'                                  nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1),',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                  nvl(:p78_saldo,:p78_saldo_1),',
'                                  nvl(:p78_dias_direito,:p78_dias_direito_1),',
'                                 -- Inclusao da data limite como parametro nao obrigatorio para calculo da data de saida e retorno - chamado 29668 - Andre - 25-04-2023',
'                                  :P78_DT_LIMITE_REQ,                                 ',
'                                  :p78_num_dias_parc2,',
'                                  v_DIAS_ABONO_PEC2,',
'                                  :p78_dt_retorno_parc2,',
'                                  :p78_dt_pagto_parc2,',
'                                  :p78_tipo_ferias2,',
'                                  :p78_opcao_13sal2,',
'                                  :p78_dias_abono_pec1_dsp,',
'                                  :p78_num_dias_parc1_dsp,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''Data de Sa\00EDda Parcela 2: ''||v_msg_retorno;'),
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669384654812413762)
,p_validation_name=>'Valida_Num_Dias_Parc2'
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if :p78_dt_saida_parc2 is not null then',
'',
'pkg_ferias.Valida_Num_Dias_Parc2(nvl(:P78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                 :P78_matricula,',
'                                 nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                                 nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                                 :P78_dt_saida_parc2,',
'                                 nvl(:P78_dt_inic_per_ferias,:P78_dt_inic_per_ferias_1),',
'                                 nvl(:P78_dt_fim_per_ferias,:P78_dt_fim_per_ferias_1),',
'                                 :P78_dias_descanso_adicional,',
'                                 :P78_dias_abono_pec2,',
'                                 :P78_tipo_ferias2,',
'                                 :P78_desc_adicional1,',
'                                 :P78_desc_adicional2,',
'                                 :P78_num_dias_parc2,',
'                                 :P78_dt_retorno_parc2,',
'                                 :P78_dias_direito,',
'                                 :p_usuario,',
'                                 v_flg_retorno,',
'                                 v_msg_retorno);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''N\00FAmero de Dias Parcela 2: ''||v_msg_retorno;'),
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669385090501413762)
,p_validation_name=>'Valida_Dias_Abono_Pec2'
,p_validation_sequence=>210
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if :p78_dt_saida_parc2 is not null then',
'',
'    pkg_ferias.Valida_Abono_Pec2(nvl(:P78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                 :P78_matricula,',
'                                 nvl(:P78_dt_inic_per_ferias,:P78_dt_inic_per_ferias_1),',
'                                 nvl(:P78_dt_fim_per_ferias,:P78_dt_fim_per_ferias_1),',
'                                 nvl(:P78_ind_situacao_periodo,:P78_ind_situacao_periodo_a),',
'                                 nvl(:P78_dias_direito,:P78_dias_direito_1),',
'                                 nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                                 nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                                 :P78_dt_saida_parc2,',
'                                 :P78_num_dias_parc2,',
'                                 :P78_desc_adicional2,',
'                                 :P78_dias_abono_pec2,',
'                                 :P78_opcao_abono_pec2,',
'                                 :P78_dt_retorno_parc2,',
'                                 v_flg_retorno,',
'                                 v_msg_retorno);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'          return ''Dias de Abono Parcela 2: ''||v_msg_retorno;',
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669385483563413763)
,p_validation_name=>'Valida_Opcao_13Sal2'
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'if :p78_opcao_13sal2 is not null AND',
'   nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1) IS NOT NULL AND',
'   :p78_dt_saida_parc2 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
'   ',
'pkg_ferias.Valida_Opcao_13Sal2(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                               :p78_matricula,',
'                               nvl(:p78_opcao_13sal1,:p78_opcao_13sal1_1),',
'                               nvl(:P78_DT_SAIDA_PARC1,:P78_DT_SAIDA_PARC1_1),',
'                               :p78_opcao_13sal2,',
'                               :p78_dt_saida_parc2,',
'                               :p78_dt_retorno_parc2,',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''Op\00E7\00E3o 13 sal. Parcela 2: ''||v_msg_retorno;'),
'      end if;',
'end if;     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669385899849413763)
,p_validation_name=>'Valida_Desc_Adicional2'
,p_validation_sequence=>230
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if :p78_dt_saida_parc2 is not null then',
'',
'pkg_ferias.Valida_Desc_Adicional2(:p78_dias_descanso_adicional,',
'                                  :p78_desc_adicional1,',
'                                  :P78_dt_saida_parc2,',
'                                  :p78_num_dias_parc2,',
'                                  :p78_desc_adicional2,',
'                                  :p78_dt_retorno_parc2,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'          return ''Descanso Adicional Parcela 2: ''||v_msg_retorno;',
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669386293619413764)
,p_validation_name=>'Valida_dt_saida_parc4'
,p_validation_sequence=>240
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_DIAS_ABONO_PEC4 number := :P78_DIAS_ABONO_PEC4;',
'',
'begin',
'',
'    if :p78_dt_saida_parc4 is not null then',
'',
'pkg_ferias.Valida_Dt_Saida_Parc4(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                  :p78_cod_solicitacao,',
'                                  :p78_matricula,',
'                                  nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                                  :p78_dt_retorno_parc1,',
'                                  nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                                  :p78_dt_retorno_parc2,',
'                                  nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                                  nvl(:p78_num_dias_parc2,:p78_num_dias_parc2_1),',
'                                  :p78_dt_saida_parc4,',
'                                  nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1),',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                  nvl(:p78_saldo,:p78_saldo_1),',
'                                  nvl(:p78_dias_direito,:p78_dias_direito_1),',
'                                 -- Inclusao da data limite como parametro nao obrigatorio para calculo da data de saida e retorno - chamado 29668 - Andre - 25-04-2023',
'                                  :P78_DT_LIMITE_REQ,',
'                                  :p78_num_dias_parc4,',
'                                  :p78_dias_abono_pec4,',
'                                  :p78_dt_retorno_parc4,',
'                                  :p78_dt_pagto_parc4,',
'                                  :p78_tipo_ferias4,',
'                                  :p78_opcao_13sal4,',
'                                  :p78_dias_abono_pec1_dsp,',
'                                  :p78_num_dias_parc1_dsp,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''Data de Sa\00EDda Parcela 3: ''||v_msg_retorno;'),
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669381054401413759)
,p_validation_name=>'Valida_dt_retorno_parc1'
,p_validation_sequence=>250
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc1(:p78_dt_retorno_parc1,',
'                                   nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc1,',
'                                   nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                    nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                    :p78_matricula,',
'                                    nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1));',
'',
'if trim(v_msg_retorno) is not null then',
'return v_msg_retorno;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669356507130413719)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669380688823413758)
,p_validation_name=>'Valida_dt_retorno_parc2'
,p_validation_sequence=>260
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'if :p78_dt_saida_parc2 is null then',
'  :p78_dt_retorno_parc2 := null;',
'  return null;',
'end if;',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc2(:p78_dt_retorno_parc2,',
'                                   nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc2,',
'                                   nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                    nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                    :p78_matricula,',
'                                    nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1));',
'',
'if trim(v_msg_retorno) is not null then',
'return v_msg_retorno;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669362833962413723)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669380324850413758)
,p_validation_name=>'Valida_dt_retorno_parc4'
,p_validation_sequence=>270
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc4(:p78_dt_retorno_parc4,',
'                                   nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc4,',
'                                   nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                    nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                    :p78_matricula,',
'                                    nvl(:p78_dt_inic_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                    :p78_dt_saida_parc2);',
'',
'if trim(v_msg_retorno) is not null then',
'return v_msg_retorno;',
'end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669345476258413715)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669386655902413764)
,p_validation_name=>'Valida_Num_Dias_Parc4'
,p_validation_sequence=>280
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if :p78_dt_saida_parc4 is not null then',
'',
'pkg_ferias.Valida_Num_Dias_Parc4(nvl(:P78_cod_empresa,:P78_COD_EMPRESA_1),',
'                                    :P78_matricula,',
'                                    nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                                    nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1),',
'                                    :P78_num_dias_parc4,',
'                                    nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                                    nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1),',
'                                    nvl(:P78_dt_saida_parc2,:P78_dt_saida_parc2_1),',
'                                    :P78_dt_saida_parc4,',
'                                    nvl(:P78_dt_inic_per_ferias,:P78_dt_inic_per_ferias_1),',
'                                    nvl(:P78_dt_fim_per_ferias,:P78_dt_fim_per_ferias_1),                            ',
'                                    nvl(:p78_saldo,:p78_saldo_1),',
'                                    nvl(:p78_ind_situacao_parc_2,:p78_ind_situacao_parc_2_a),',
'                                    :p78_dias_abono_pec4,                                    ',
'                                    :P78_dias_descanso_adicional,',
'                                    :P78_dias_abono_pec4,',
'                                    :P78_tipo_ferias4,',
'                                    :P78_desc_adicional1,',
'                                    :P78_desc_adicional2,',
'                                    :P78_desc_adicional4,',
'                                    :P78_dt_retorno_parc4,',
'                                    nvl(:P78_dias_direito,:P78_dias_direito_1),',
'                                    v_flg_retorno,',
'                                    v_msg_retorno,                    ',
'                                    :p_usuario);',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''N\00FAmero de Dias Parcela 3: ''||v_msg_retorno;'),
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669387125771413764)
,p_validation_name=>'Valida_Dias_Abono_Pec4'
,p_validation_sequence=>290
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'    if :p78_dt_saida_parc4 is not null then',
'',
'pkg_ferias.Valida_Abono_Pec4(nvl(:P78_cod_empresa,:P78_COD_EMPRESA_1),',
'                             :P78_matricula,',
'                             nvl(:P78_dt_inic_per_ferias,:P78_dt_inic_per_ferias_1),',
'                             nvl(:P78_dt_fim_per_ferias,:P78_dt_fim_per_ferias_1),',
'                             nvl(:P78_ind_situacao_periodo,:P78_ind_situacao_periodo_a),',
'                             nvl(:P78_dias_direito,:P78_dias_direito_1),',
'                             nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                             nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                             nvl(:P78_dt_saida_parc2,:P78_dt_saida_parc2_1),',
'                             nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1),',
'                             nvl(:P78_desc_adicional2,:P78_desc_adicional2_1),',
'                             nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1),',
'                             :P78_dt_saida_parc4,',
'                             :P78_num_dias_parc4,',
'                             :P78_desc_adicional4,',
'                             :P78_dias_abono_pec4,',
'                             :P78_opcao_abono_pec4,',
'                             :P78_dt_retorno_parc4,',
'                             v_flg_retorno,',
'                             v_msg_retorno);',
'',
'     ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'          return ''Dias de Abono Parcela 3: ''||v_msg_retorno;',
'      end if;',
'     ',
'    end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669387905752413765)
,p_validation_name=>'Valida_Desc_Adicional4'
,p_validation_sequence=>310
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'',
'IF :p78_dt_saida_parc4 IS NOT NULL THEN',
' ',
'pkg_ferias.Valida_Desc_Adicional4(:p78_dias_descanso_adicional,',
'                                  nvl(:p78_desc_adicional1,:p78_desc_adicional1_1),',
'                                  nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                                  nvl(:p78_num_dias_parc2,:p78_num_dias_parc2_1),',
'                                  nvl(:p78_desc_adicional2,:p78_desc_adicional2_1),',
'                                  :p78_dt_saida_parc4,',
'                                  :p78_num_dias_parc4,',
'                                  :p78_desc_adicional4,',
'                                  :p78_dt_retorno_parc4,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
' ',
' ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'          return ''Descanso Adicional Parcela 3: ''||v_msg_retorno;',
'      end if;',
'     ',
'end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669378281881413757)
,p_validation_name=>unistr('Valida Matr\00EDcula Escolhida')
,p_validation_sequence=>320
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_ferias.Valida_Matricula_Solicitado(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1), :p78_matricula, v_flg_retorno, v_msg_retorno);',
'',
'    if v_flg_retorno = ''N'' and trim(v_msg_retorno) is not null then',
'        return v_msg_retorno;',
'    else ',
'      if :p_painel = ''PC'' and :p78_matricula <> :p_matricula_user then',
unistr('        return ''Matr\00EDcula Inv\00E1lida!'';'),
'      else',
'        return null;',
'      end if;',
'    end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669323400595413692)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669377921619413757)
,p_validation_name=>'Valida Aprovadores'
,p_validation_sequence=>330
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'cursor c1 is',
'select cod_empresa, filial, cod_ccusto, matricula',
'  from informacoes_funcionais',
' where cod_empresa = nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1)',
'   and matricula = :p78_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'--if :P_BASE = ''STEFANINI'' then',
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
'                                              ''REQ_FERIAS'');',
'',
'    if nvl(v_flg_retorno,''S'') = ''N'' then',
unistr('        return ''N\00E3o foi parametrizado aprovadores para sua requisi\00E7\00E3o. Por favor, entrar em contato com os administradores do sistema!'';'),
'    else ',
'        return null;',
'    end if;',
'',
'--end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669323400595413692)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669387478299413765)
,p_validation_name=>'Valida_Opcao_13Sal4'
,p_validation_sequence=>340
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'IF :p78_opcao_13sal4 IS NOT NULL AND ',
'   nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1) IS NOT NULL AND',
'   nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1) IS NOT NULL AND',
'   :p78_dt_saida_parc4 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
' ',
'pkg_ferias.Valida_Opcao_13Sal4(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                               :p78_matricula,',
'                               :p78_opcao_13sal1,',
'                               nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                               nvl(:p78_opcao_13sal2,:p78_opcao_13sal2_1),',
'                               nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                               :p78_dt_retorno_parc2,',
'                               :p78_opcao_13sal4,',
'                               :p78_dt_saida_parc4,',
'                               :p78_dt_retorno_parc4,',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
' ',
' ',
'      if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
unistr('          return ''Op\00E7\00E3o 13 Sal. Parcela 3: ''||v_msg_retorno;'),
'      end if;',
'     ',
'end if;',
'     ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669378733202413757)
,p_validation_name=>'Valida_sit_Requisicao'
,p_validation_sequence=>350
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'pkg_ferias.Valida_Sit_Requisicao(nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1), :p78_cod_solicitacao, :p78_matricula, :p78_sit_requisicao, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669311634907413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669379084817413758)
,p_validation_name=>'Valida Campos em Branco'
,p_validation_sequence=>360
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_DT_SAIDA_PARC1 is null and :P78_DT_SAIDA_PARC1_1 is null and :P78_PARCELAS_OPC = 1 then',
'    ',
'    if :P78_DT_SAIDA_PARC1 is null and',
'        :P78_DT_SAIDA_PARC1_1 is null and',
'        :P78_NUM_DIAS_PARC1 is null and',
'        :P78_NUM_DIAS_PARC1_1 is null then',
'       ',
'    ',
unistr('    return ''Campos em Branco na 1\00AA Parcela!'';'),
'    ',
'    end if;',
'    ',
'end if;',
'',
'if :P78_DT_SAIDA_PARC2 is null and :P78_DT_SAIDA_PARC2_1 is null and :P78_PARCELAS_OPC = 2 then',
'    ',
'    if :P78_DT_SAIDA_PARC1 is null and',
'        :P78_DT_SAIDA_PARC1_1 is null and',
'        :P78_NUM_DIAS_PARC1 is null and',
'        :P78_NUM_DIAS_PARC1_1 is null then',
'       ',
'    ',
unistr('    return ''Campos em Branco na 1\00AA Parcela!'';'),
'    ',
'    end if;        ',
'    ',
'    if  :P78_DT_SAIDA_PARC2 is null and',
'        :P78_DT_SAIDA_PARC2_1 is null and',
'        :P78_NUM_DIAS_PARC2 is null and',
'        :P78_NUM_DIAS_PARC2_1 is null',
'        then',
'    ',
unistr('    return ''Campos em Branco na 2\00AA Parcela!'';'),
'',
'    end if;',
'    ',
'end if;',
'',
'if :P78_DT_SAIDA_PARC4 is null and :P78_DT_SAIDA_PARC4_1 is null and :P78_PARCELAS_OPC = 3 then',
'    ',
'    if :P78_DT_SAIDA_PARC1 is null and',
'        :P78_DT_SAIDA_PARC1_1 is null and',
'        :P78_NUM_DIAS_PARC1 is null and',
'        :P78_NUM_DIAS_PARC1_1 is null then',
'       ',
'    ',
unistr('    return ''Campos em Branco na 1\00AA Parcela!'';'),
'    ',
'    end if;    ',
'    ',
'    if  :P78_DT_SAIDA_PARC2 is null and',
'        :P78_DT_SAIDA_PARC2_1 is null and',
'        :P78_NUM_DIAS_PARC2 is null and',
'        :P78_NUM_DIAS_PARC2_1 is null',
'        then',
'    ',
unistr('    return ''Campos em Branco na 2\00AA Parcela!'';'),
'',
'    end if;    ',
'    ',
'    ',
'    if :P78_DT_SAIDA_PARC4 is null and',
'       :P78_DT_SAIDA_PARC4_1 is null and',
'       :P78_NUM_DIAS_PARC4 is null and',
'       :P78_NUM_DIAS_PARC4_1 is null',
'    then ',
'    ',
unistr('    return ''Campos em Branco na 3\00AA Parcela!'';'),
'    ',
'    end if;',
'    ',
'end if;',
'',
'if :P78_DT_SAIDA_PARC1 is not null and :P78_DT_SAIDA_PARC1_1 is null then',
'    ',
'    if :P78_NUM_DIAS_PARC1 is null then',
unistr('    return ''Preencha o n\00FAmero de dias da 1\00AA Parcela!'';'),
'    end if;',
'    ',
'end if;',
'',
'if :P78_DT_SAIDA_PARC2 is not null and :P78_DT_SAIDA_PARC2_1 is null then',
'    ',
'    if :P78_NUM_DIAS_PARC2 is null then',
unistr('    return ''Preencha o n\00FAmero de dias da 2\00AA Parcela!'';'),
'    end if;',
'    ',
'end if;',
'',
'if :P78_DT_SAIDA_PARC4 is not null and :P78_DT_SAIDA_PARC4_1 is null then',
'    ',
'    if :P78_NUM_DIAS_PARC4 is null then',
unistr('    return ''Preencha o n\00FAmero de dias da 3\00AA Parcela!'';'),
'    end if;',
'    ',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=2;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669379874244413758)
,p_validation_name=>'PRE-UPDATE'
,p_validation_sequence=>370
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_FERIAS.Pre_Update ( :p78_cod_solicitacao,',
'                       :p78_sit_requisicao,',
'                       :p78_dt_saida_parc1,',
'                       :p78_dt_saida_parc2,',
'                       :p78_dt_saida_parc3,',
'                       :p78_dt_saida_parc4,',
'                       :p78_dt_retorno_parc1,',
'                       :p78_dt_retorno_parc2,',
'                       :p78_dt_retorno_parc3,',
'                       :p78_dt_retorno_parc4,',
'                       :p78_usuario,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    return v_msg_retorno;',
' end if;',
' ',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669311634907413680)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669376673351413754)
,p_validation_name=>unistr('Valida Estatut\00E1rio')
,p_validation_sequence=>380
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(550) DEFAULT NULL;',
'  vParcela VARCHAR2(1)   DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_SAIDA_PARC1 IS NOT NULL AND :P78_DT_RETORNO_PARC1 IS NOT NULL THEN',
'    vParcela := ''1'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_ValidaEstatutario(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                               ,pMatricula      => :P78_MATRICULA',
'                                               ,pTipo           => 3',
'                                               ,pDtSaidaParc    => :P78_DT_SAIDA_PARC1',
'                                               ,pDtSaidaParcX   => :P78_DT_SAIDA_PARC2',
'                                               ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1)',
'                                               ,pDtRetornParc  => :P78_DT_RETORNO_PARC1);',
'  END IF; ',
'  --',
'  IF vReturn IS NULL THEN  ',
'    IF :P78_DT_SAIDA_PARC2 IS NOT NULL AND :P78_DT_RETORNO_PARC2 IS NOT NULL THEN',
'    vParcela := ''2'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_ValidaEstatutario(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                               ,pMatricula      => :P78_MATRICULA',
'                                               ,pTipo           => 3',
'                                               ,pDtSaidaParc    => :P78_DT_SAIDA_PARC2',
'                                               ,pDtSaidaParcX   => :P78_DT_SAIDA_PARC4',
'                                               ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1)',
'                                               ,pDtRetornParc  => :P78_DT_RETORNO_PARC2);',
'    END IF; ',
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN  ',
'    IF :P78_DT_SAIDA_PARC4 IS NOT NULL AND :P78_DT_RETORNO_PARC4 IS NOT NULL THEN',
'      vParcela := ''3'';',
'      --',
'      vReturn := Pkg_Ferias.fnc_ValidaEstatutario(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                                 ,pMatricula      => :P78_MATRICULA',
'                                                 ,pTipo           => 3',
'                                                 ,pDtSaidaParc    => :P78_DT_SAIDA_PARC4',
'                                                 ,pDtSaidaParcX   => NULL',
'                                                 ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1)',
'                                                 ,pDtRetornParc  => :P78_DT_RETORNO_PARC4);',
'    END IF; ',
'  END IF;  ',
'  --',
'  IF vReturn IS NOT NULL THEN',
unistr('    vReturn := ''<strong>Inclus\00E3o de Requisi\00E7\00E3o de F\00E9rias N\00C3O Permitida!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
unistr('    --vReturn := REPLACE(REPLACE(vReturn, ''sa\00EDda'', ''sa\00EDda parcela''||vParcela), ''retorno'', ''retorno parcela''||vParcela);'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=1;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669377142590413755)
,p_validation_name=>'Valida Outra Empresa Dt Saida Parcelas'
,p_validation_sequence=>390
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(550) DEFAULT NULL;',
'  vParcela VARCHAR2(1)   DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_SAIDA_PARC1 IS NOT NULL THEN',
'    vParcela := ''1'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                              ,pMatricula      => :P78_MATRICULA',
'                                              ,pDtParcSR       => :P78_DT_SAIDA_PARC1',
'                                              ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'  END IF; ',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'      vParcela := ''2'';',
'      --',
'      vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                                ,pMatricula      => :P78_MATRICULA',
'                                                ,pDtParcSR       => :P78_DT_SAIDA_PARC2',
'                                                ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'    END IF;  ',
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :P78_DT_SAIDA_PARC4 IS NOT NULL THEN',
'      vParcela := ''3'';',
'      --',
'      vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => nvl(:P78_COD_EMPRESA,:P78_COD_EMPRESA_1)',
'                                                ,pMatricula      => :P78_MATRICULA',
'                                                ,pDtParcSR       => :P78_DT_SAIDA_PARC4',
'                                                ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'    END IF;  ',
'  END IF;  ',
'  --',
'  IF vReturn IS NOT NULL THEN',
unistr('    vReturn := ''<strong>Inclus\00E3o de Requisi\00E7\00E3o de F\00E9rias N\00C3O Permitida!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
unistr('    --vReturn := REPLACE(vReturn, ''Informe'', ''[DATA SA\00CDDA PARCELA''||vparcela||''] Informe'');'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'return 1=1;'
,p_validation_condition_type=>'FUNCTION_BODY'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(89669377482030413755)
,p_validation_name=>'Valida Outra Empresa Dt Retorno ParcelasX'
,p_validation_sequence=>400
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn  VARCHAR2(550) DEFAULT NULL;',
'  vParcela VARCHAR2(1)   DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_RETORNO_PARC1 IS NOT NULL THEN',
'    vParcela := ''1'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => :P78_COD_EMPRESA',
'                                              ,pMatricula      => :P78_MATRICULA',
'                                              ,pDtParcSR       => :P78_DT_RETORNO_PARC1',
'                                              ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'  END IF; ',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :P78_DT_RETORNO_PARC2 IS NOT NULL THEN',
'    vParcela := ''2'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => :P78_COD_EMPRESA',
'                                              ,pMatricula      => :P78_MATRICULA',
'                                              ,pDtParcSR       => :P78_DT_RETORNO_PARC2',
'                                              ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'    END IF;                                              ',
'  END IF;',
'  --',
'  IF vReturn IS NULL THEN',
'    IF :P78_DT_RETORNO_PARC4 IS NOT NULL THEN',
'    vParcela := ''3'';',
'    --',
'    vReturn := Pkg_Ferias.fnc_VerifPerOutraEmp(pEmpresa        => :P78_COD_EMPRESA',
'                                              ,pMatricula      => :P78_MATRICULA',
'                                              ,pDtParcSR       => :P78_DT_RETORNO_PARC4',
'                                              ,pDtFimPerFerias => NVL(:P78_DT_FIM_PER_FERIAS, :P78_DT_FIM_PER_FERIAS_1));',
'    END IF;                                              ',
'  END IF;  ',
'  --',
'  IF vReturn IS NOT NULL THEN',
unistr('    vReturn := ''<strong>Inclus\00E3o de Requisi\00E7\00E3o de F\00E9rias N\00C3O Permitida!</strong><br>''||REPLACE(REPLACE(REPLACE(vReturn, ''|'', ''<br>''), ''['',''<strong>''), '']'',''</strong>'');'),
'    --vReturn := REPLACE(vReturn, ''Informe'', ''[DATA RETORNO PARCELA''||vParcela||''] Informe'');',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_when_button_pressed=>wwv_flow_api.id(200048229415060008081)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(68831018683678631559)
,p_validation_name=>unistr('Valida Dt Retorno Parc1 - Estagi\00E1rio')
,p_validation_sequence=>410
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_RETORNO_PARC1 IS NOT NULL THEN',
'    vReturn := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                      ,pMatricula    => :P78_MATRICULA',
'                                                      ,pDtRetFerParc => :P78_DT_RETORNO_PARC1);',
'  END IF;',
'  --',
'  RETURN(REPLACE(vReturn, ''Retorno'',''Retorno Parcela 1''));',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Pkg_Ferias.fnc_VerifVincEstagiario(pEmpresa   => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                  ,pMatricula => :P78_MATRICULA) = ''S'''))
,p_validation_condition_type=>'PLSQL_EXPRESSION'
,p_associated_item=>wwv_flow_api.id(89669356507130413719)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(68831019160546631564)
,p_validation_name=>unistr('Valida Dt Retorno Parc2 - Estagi\00E1rio')
,p_validation_sequence=>420
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_RETORNO_PARC2 IS NOT NULL THEN',
'    vReturn := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                      ,pMatricula    => :P78_MATRICULA',
'                                                      ,pDtRetFerParc => :P78_DT_RETORNO_PARC2);',
'  END IF;',
'  --',
'  RETURN(REPLACE(vReturn, ''Retorno'',''Retorno Parcela 2''));',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Pkg_Ferias.fnc_VerifVincEstagiario(pEmpresa   => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                  ,pMatricula => :P78_MATRICULA) = ''S'''))
,p_validation_condition_type=>'PLSQL_EXPRESSION'
,p_associated_item=>wwv_flow_api.id(89669362833962413723)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(68831019447482631567)
,p_validation_name=>unistr('Valida Dt Retorno Parc4 - Estagi\00E1rio')
,p_validation_sequence=>430
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P78_DT_RETORNO_PARC4 IS NOT NULL THEN',
'    vReturn := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                      ,pMatricula    => :P78_MATRICULA',
'                                                      ,pDtRetFerParc => :P78_DT_RETORNO_PARC4);',
'  END IF;',
'  --',
'  RETURN(REPLACE(vReturn, ''Retorno'',''Retorno Parcela 3''));',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(89669345476258413715)
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(66002146321786939860)
,p_validation_name=>'Valida abono parcela1 obrigatorio'
,p_validation_sequence=>440
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'',
'if nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A) = 2  and :p78_dias_abono_pec1_lst is null then',
'   return ''O campo dias de abono da parcela 1 deve ser preenchido.'';',
'--elsif nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A) in(2,5) and (:p78_dias_abono_pec1_lst is null and :p78_dias_abono_pec2_lst is null) then',
'--   return ''O campo dias de abono deve ser preenchido.'';',
'end if;',
'',
'end;',
'',
'DECLARE',
'  CURSOR C1 IS',
'    select FPP.QTD_PARCELAS, FPP.DIAS_ABONO_PEC1, FPP.DIAS_ABONO_PEC2, FPP.DIAS_ABONO_PEC4',
'      from FERIAS_PARAMETROS_PARCELAS FPP',
'      WHERE FPP.COD_EMPRESA = :p78_cod_empresa',
'        AND FPP.COD_FILIAL = :p78_filial',
'        AND FPP.COD = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A);',
'  v_c1 c1%ROWTYPE;',
'BEGIN',
'  OPEN c1;',
'  FETCH c1',
'    INTO v_c1;',
'  CLOSE c1;',
'  ',
'  IF v_c1.QTD_PARCELAS >= 1 AND NVL(v_c1.DIAS_ABONO_PEC1, 0) > 0 THEN',
'    if nvl(v_c1.DIAS_ABONO_PEC1, 0) != nvl(:p78_dias_abono_pec1_lst, 0) + nvl(nvl(:p78_dias_abono_pec2_lst, :p78_dias_abono_pec2), 0) then',
'      return ''O campo dias de abono deve ser preenchido.'';',
'    end if;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669354878632413719)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(66002146426950939861)
,p_validation_name=>'Valida abono parcela2 obrigatorio'
,p_validation_sequence=>450
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('/* COMENTADO, POIS INICALMENTE IDENTIFICAMOS QUE N\00C3O FAZ SENTIDO FIXAR A VALIDA\00C7\00C3O PELA OP\00C7\00C3O DE FERIAS 5'),
'Bruno Sousa / Rosi 13/10/2023 ',
'begin',
'if nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A) = 5 and (:p78_dias_abono_pec1_lst is null and :p78_dias_abono_pec2_lst is null) then',
'return ''O campo dias de abono deve ser preenchido.'';',
'end if;',
'end;',
'*/',
'DECLARE',
'  CURSOR C1 IS',
'    select FPP.QTD_PARCELAS, FPP.DIAS_ABONO_PEC1, FPP.DIAS_ABONO_PEC2, FPP.DIAS_ABONO_PEC4',
'      from FERIAS_PARAMETROS_PARCELAS FPP',
'      WHERE FPP.COD_EMPRESA = :p78_cod_empresa',
'        AND FPP.COD_FILIAL = :p78_filial',
'        AND FPP.COD = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A);',
'  v_c1 c1%ROWTYPE;',
'  ',
'BEGIN',
'  OPEN c1;',
'  FETCH c1',
'    INTO v_c1;',
'  CLOSE c1;',
'',
'  IF v_c1.QTD_PARCELAS >= 2 AND NVL(v_c1.DIAS_ABONO_PEC2, 0) > 0 THEN',
'    if nvl(v_c1.DIAS_ABONO_PEC2, 0) != nvl(nvl(:p78_dias_abono_pec1_lst, :p78_dias_abono_pec1), 0) + nvl(:p78_dias_abono_pec2_lst, 0) then',
'      return ''O campo dias de abono deve ser preenchido.'';',
'    end if;',
'  END IF;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(89669312029245413680)
,p_associated_item=>wwv_flow_api.id(89669361559704413723)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669525402836414120)
,p_name=>'Parc_Opc 1'
,p_event_sequence=>2
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_PARCELAS_OPC'
,p_condition_element=>'P78_PARCELAS_OPC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669525876000414120)
,p_event_id=>wwv_flow_api.id(89669525402836414120)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1_DSP,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1_DSP,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC1_LST,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1_X,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_TIPO_FERIAS1,P78_'
||'OPCAO_ABONO_PEC1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55408890428102210432)
,p_event_id=>wwv_flow_api.id(89669525402836414120)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2_DSP,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC2_LST,P78_DIAS_ABONO_PEC2_DSP,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC2_LST,P78_OPCAO_23SAL2,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_DT_PAGTO_PARC2,P78_TIPO_FERIAS2,P78_'
||'OPCAO_ABONO_PEC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DT_PAGTO_PARC2_1,P78_OPCAO_13SAL2_1,P78_TIPO_FERIAS2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_RETORNO_PARC2_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669526885818414121)
,p_event_id=>wwv_flow_api.id(89669525402836414120)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4_DSP,P78_NUM_DIAS_PARC4,P78_NUM_DIAS_PARC4_LST,P78_DIAS_ABONO_PEC4_DSP,P78_DIAS_ABONO_PEC4,P78_DIAS_ABONO_PEC4_LST,P78_OPCAO_13SAL4,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4_X,P78_DT_RETORNO_PARC4,P78_DT_PAGTO_PARC'
||'4,P78_TIPO_FERIAS4,P78_OPCAO_ABONO_PEC4'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669527321242414121)
,p_name=>'Parc_Opc 2'
,p_event_sequence=>3
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_PARCELAS_OPC'
,p_condition_element=>'P78_PARCELAS_OPC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669527752029414121)
,p_event_id=>wwv_flow_api.id(89669527321242414121)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1_DSP,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1_DSP,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC1_LST,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1_X,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_TIPO_FERIAS1,P78_'
||'OPCAO_ABONO_PEC1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(55408890142052210429)
,p_event_id=>wwv_flow_api.id(89669527321242414121)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2_DSP,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC2_LST,P78_DIAS_ABONO_PEC2_DSP,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC2_LST,P78_OPCAO_23SAL2,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_DT_PAGTO_PARC2,P78_TIPO_FERIAS2,P78_'
||'OPCAO_ABONO_PEC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DT_PAGTO_PARC2_1,P78_OPCAO_13SAL2_1,P78_TIPO_FERIAS2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_RETORNO_PARC2_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669528805280414121)
,p_event_id=>wwv_flow_api.id(89669527321242414121)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4_DSP,P78_NUM_DIAS_PARC4,P78_NUM_DIAS_PARC4_LST,P78_DIAS_ABONO_PEC4_DSP,P78_DIAS_ABONO_PEC4,P78_DIAS_ABONO_PEC4_LST,P78_OPCAO_13SAL4,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4_X,P78_DT_RETORNO_PARC4,P78_DT_PAGTO_PARC'
||'4,P78_TIPO_FERIAS4,P78_OPCAO_ABONO_PEC4'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669529146567414121)
,p_name=>'Parc_Opc 3'
,p_event_sequence=>4
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_PARCELAS_OPC'
,p_condition_element=>'P78_PARCELAS_OPC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'3'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669529688233414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669530232456414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669530706965414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669531238814414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669531669024414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1_DSP,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1_DSP,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC1_LST,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1_X,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_TIPO_FERIAS1,P78_'
||'OPCAO_ABONO_PEC1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669532212083414122)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2_DSP,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC2_LST,P78_DIAS_ABONO_PEC2_DSP,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC2_LST,P78_OPCAO_23SAL2,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_DT_PAGTO_PARC2,P78_TIPO_FERIAS2,P78_'
||'OPCAO_ABONO_PEC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DT_PAGTO_PARC2_1,P78_OPCAO_13SAL2_1,P78_TIPO_FERIAS2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_RETORNO_PARC2_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669532745592414123)
,p_event_id=>wwv_flow_api.id(89669529146567414121)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4_DSP,P78_NUM_DIAS_PARC4,P78_NUM_DIAS_PARC4_LST,P78_DIAS_ABONO_PEC4_DSP,P78_DIAS_ABONO_PEC4,P78_DIAS_ABONO_PEC4_LST,P78_OPCAO_13SAL4,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4_X,P78_DT_RETORNO_PARC4,P78_DT_PAGTO_PARC'
||'4,P78_TIPO_FERIAS4,P78_OPCAO_ABONO_PEC4'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669533138697414123)
,p_name=>'valida_matricula_solicitado'
,p_event_sequence=>8
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null and :P78_ROWID is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669533590726414123)
,p_event_id=>wwv_flow_api.id(89669533138697414123)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_TRIG_EXIST_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669534119001414123)
,p_event_id=>wwv_flow_api.id(89669533138697414123)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
'IF :P78_MATRICULA IS NOT NULL THEN',
'',
' :p78_mensagem := null;',
'',
'pkg_ferias.Valida_Matricula_Solicitado(:p78_cod_empresa, :p78_matricula, v_flg_retorno, v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_matricula''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
'    :P78_SHOW_HIDE:= ''HIDE'';',
'    ',
' else',
'    :P78_SHOW_HIDE:= ''SHOW'';',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_matricula'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_ITEM_VALIDACAO,P78_DIAS_DIREITO_OPC'
,p_attribute_03=>'P78_MENSAGEM,P78_FLAG,P78_OK,P78_ITEM_VALIDACAO,P78_SHOW_HIDE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669534554560414123)
,p_event_id=>wwv_flow_api.id(89669533138697414123)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'cursor c1 is',
'select cod_empresa, filial, cod_ccusto, matricula',
'  from informacoes_funcionais',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if /*:P_BASE = ''STEFANINI'' and*/ nvl(:P78_OK,''S'') = ''S'' then',
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
'                                              ''REQ_FERIAS'');',
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
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_matricula''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_matricula'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_ITEM_VALIDACAO,P_EMPRESA_USER,P_MATRICULA_USER,P78_OK'
,p_attribute_03=>'P78_MENSAGEM,P78_FLAG,P78_OK,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669535082039414124)
,p_event_id=>wwv_flow_api.id(89669533138697414123)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Declare',
'',
'v_meses number;',
'',
'cursor c1 is',
'select FLOOR(months_between(trunc(sysdate), trunc(dt_admissao))) qtd_meses',
'  from informacoes_funcionais',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p78_meses_adm := nvl(v_c1.qtd_meses,0);',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA'
,p_attribute_03=>'P78_MESES_ADM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669535453163414124)
,p_name=>'valida_dias_direito_opc'
,p_event_sequence=>18
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_DIREITO_OPC'
,p_condition_element=>'P78_DIAS_DIREITO_OPC'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669535999296414124)
,p_event_id=>wwv_flow_api.id(89669535453163414124)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
'IF :P78_MATRICULA IS NOT NULL THEN',
'',
' :p78_mensagem := null;',
'',
' if :P78_DIAS_DIREITO_OPC = 0 then',
' v_flg_retorno := ''N'';',
unistr(' v_msg_retorno := ''Para este per\00EDodo de f\00E9rias (''||:P78_DT_INIC_PER_FERIAS_1||'' \00E0 ''||:P78_DT_FIM_PER_FERIAS_1||''), o colaborador n\00E3o tem mais dias dispon\00EDveis a ser gozado.'';'),
' ',
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_DIAS_DIREITO_OPC''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P78_DIAS_DIREITO_OPC'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_ITEM_VALIDACAO,P78_DIAS_DIREITO_OPC,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1'
,p_attribute_03=>'P78_MENSAGEM,P78_FLAG,P78_OK,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669536353063414124)
,p_name=>unistr('Cria\00E7\00E3o: Mostra Regi\00F5es')
,p_event_sequence=>28
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p78_rowid is null and :p78_ok = ''S'' then',
'return true;',
'else',
'return true;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669536908905414124)
,p_event_id=>wwv_flow_api.id(89669536353063414124)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669537393292414124)
,p_event_id=>wwv_flow_api.id(89669536353063414124)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272282369576516589)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669537823535414125)
,p_name=>'Jornada Reduzida'
,p_event_sequence=>38
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669538290284414125)
,p_event_id=>wwv_flow_api.id(89669537823535414125)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'			  select nvl(rt.jornada_reduzida,''N'')',
'			  into   :p78_jornada_reduzida',
'			  from   informacoes_funcionais_cad iff',
'			        ,reg_trabalho rt',
'			  where  rt.cod          = iff.reg_trab',
'			  and    rt.cod_empresa  = iff.cod_empresa',
'			  and    iff.matricula   = :p78_matricula',
'			  and    iff.cod_empresa = :p78_cod_empresa;',
'exception',
'  when others then',
'  :p78_jornada_reduzida := ''N'';',
'end;'))
,p_attribute_02=>'P78_MATRICULA,P78_COD_EMPRESA'
,p_attribute_03=>'P78_JORNADA_REDUZIDA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(85944770902653749369)
,p_name=>unistr('(Cria\00E7\00E3o) Matricula: Popula_Campos 1 old')
,p_event_sequence=>47
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669539232856414125)
,p_event_id=>wwv_flow_api.id(85944770902653749369)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_data_ini date;v_item_validacao varchar2(20):= :P78_ITEM_VALIDACAO;',
'CURSOR C_REQ(pdt_inic_per_ferias DATE) IS',
'SELECT R.SIT_REQUISICAO COD_SIT_REQ, NVL(P.REQ_FERIAS_SUBS_CONCLUIDA,''N'') REQ_FERIAS_SUBS_CONCLUIDA',
'FROM REQUISICAO_FERIAS R,',
'PARAMETROS_RECURSOS_HUMANOS P',
'WHERE R.COD_EMPRESA=P.COD_EMPRESA',
'AND R.SIT_REQUISICAO=2',
'AND R.COD_EMPRESA=:P78_COD_EMPRESA',
'AND R.MATRICULA=:P78_MATRICULA',
'AND R.Dt_Inic_Per_Ferias=pdt_inic_per_ferias;',
'V_REQ C_REQ%ROWTYPE;',
'begin',
'IF :P78_MATRICULA IS NOT NULL THEN',
':P78_MENSAGEM:=NULL;',
'BEGIN',
'select min(A.DT_INIC_PER_FERIAS) ',
'into v_data_ini',
'from FERIAS A,',
'(select B.*',
'from REQUISICAO_FERIAS B',
'where B.COD_EMPRESA=:P78_COD_EMPRESA',
'and B.MATRICULA=:P78_MATRICULA',
'and B.SIT_REQUISICAO not in (3,4,6)) B',
'where A.COD_EMPRESA=B.COD_EMPRESA(+) ',
'and A.MATRICULA=B.MATRICULA(+) ',
'and A.DT_INIC_PER_FERIAS = B.DT_INIC_PER_FERIAS(+) ',
'and B.COD_EMPRESA is null and A.COD_EMPRESA=:P78_COD_EMPRESA ',
'and A.MATRICULA=:P78_MATRICULA and ((nvl(A.NUM_DIAS_PARC1,0)+nvl(A.DIAS_ABONO_PEC1,0))<= 20 ',
'and A.COD_SOLICITACAO is null ',
'or A.DT_SAIDA_PARC2 is null ',
'or A.DT_SAIDA_PARC4 is null)',
'and A.IND_SITUACAO_PERIODO in (''P'',''R'');',
'END;',
'OPEN c_req(v_data_ini);',
'FETCH c_req INTO v_req;',
'close c_req;',
'if NVL(V_REQ.REQ_FERIAS_SUBS_CONCLUIDA,''N'') = ''N'' then',
'BEGIN',
'select Nvl(dias_descanso_adicional,0)',
',saldo_bruto',
',saldo',
',ind_situacao_periodo',
',dt_inic_per_ferias',
',dt_fim_per_ferias ',
',dt_saida_parc1',
',num_dias_parc1',
',dias_abono_pec1',
unistr(',decode(opcao_13sal1,''S'',''Sim'',''N'',''N\00E3o'') opcao_13sal1'),
',desc_adicional1',
',dt_retorno_parc1',
',tipo_ferias1',
',dt_saida_parc2',
',num_dias_parc2',
',dias_abono_pec2',
unistr(',decode(opcao_13sal2,''S'',''Sim'',''N'',''N\00E3o'') opcao_13sal2'),
',desc_adicional2',
',dt_retorno_parc2',
',tipo_ferias2',
',dt_saida_parc4',
',num_dias_parc4',
',dias_abono_pec4',
unistr(',decode(opcao_13sal4,''S'',''Sim'',''N'',''N\00E3o'') opcao_13sal4'),
',desc_adicional4',
',dt_retorno_parc4',
',tipo_ferias4',
',dt_saida_parc3',
',num_dias_parc3',
',dt_retorno_parc3',
',tipo_ferias3',
',dt_solicitacao',
',falta_hora',
',falta_minuto',
',opcao_abono_pec1',
',opcao_abono_pec2',
',dc_matricula',
',opcao_ferias',
',ind_situacao_parc_2',
',ind_situacao_parc_4',
'into :p78_dias_descanso_adicional',
',:p78_saldo_bruto',
',:p78_saldo',
',:p78_ind_situacao_periodo',
',:p78_dt_inic_per_ferias',
',:p78_dt_fim_per_ferias  ',
',:p78_dt_saida_parc1_1',
',:p78_num_dias_parc1_1',
',:p78_dias_abono_pec1_1',
',:p78_opcao_13sal1_1',
',:p78_desc_adicional1_1',
',:p78_dt_retorno_parc1_1',
',:p78_tipo_ferias1_1',
',:p78_dt_saida_parc2_1',
',:p78_num_dias_parc2_1',
',:p78_dias_abono_pec2_1',
',:p78_opcao_13sal2_1',
',:p78_desc_adicional2_1',
',:p78_dt_retorno_parc2_1',
',:p78_tipo_ferias2_1',
',:p78_dt_saida_parc4_1',
',:p78_num_dias_parc4_1',
',:p78_dias_abono_pec4_1',
',:p78_opcao_13sal4_1',
',:p78_desc_adicional4_1',
',:p78_dt_retorno_parc4_1',
',:p78_tipo_ferias4_1',
',:p78_dt_saida_parc3',
',:p78_num_dias_parc3',
',:p78_dt_retorno_parc3',
',:p78_tipo_ferias3',
',:p78_dt_solicitacao',
',:p78_falta_hora',
',:p78_falta_minuto',
',:p78_opcao_abono_pec1',
',:p78_opcao_abono_pec2',
',:p78_dc_matricula',
',:p78_opcao_ferias',
',:p78_ind_situacao_parc_2',
',:p78_ind_situacao_parc_4',
'from ferias',
'where cod_empresa=:p78_cod_empresa',
'and matricula=:p78_matricula   ',
'and dt_inic_per_ferias=nvl(v_data_ini,dt_inic_per_ferias);',
'EXCEPTION WHEN OTHERS THEN',
':p78_flag:=''N'';',
':p78_ok:=''N'';',
unistr(':p78_mensagem:=''N\00E3o h\00E1 per\00EDodos em aberto para a programa\00E7\00E3o! Solicite ao RH a cria\00E7\00E3o.'';'),
'END;',
'else',
'BEGIN',
'select Nvl(dias_descanso_adicional,0),saldo_bruto,saldo,ind_situacao_periodo,dt_inic_per_ferias,dt_fim_per_ferias ,falta_hora,falta_minuto,dc_matricula',
'into :p78_dias_descanso_adicional,:p78_saldo_bruto,:p78_saldo,:p78_ind_situacao_periodo,:p78_dt_inic_per_ferias,:p78_dt_fim_per_ferias,:p78_falta_hora,:p78_falta_minuto,:p78_dc_matricula',
'from ferias',
'where cod_empresa=:p78_cod_empresa',
'and matricula=:p78_matricula   ',
'and dt_inic_per_ferias = v_data_ini;',
'EXCEPTION WHEN OTHERS THEN',
':p78_flag:=''N'';',
':p78_ok:=''N'';',
unistr(':p78_mensagem:=''N\00E3o h\00E1 per\00EDodos em aberto para a programa\00E7\00E3o! Solicite ao RH a cria\00E7\00E3o.'';'),
'END;',
'END IF;',
'if :p78_cod_solicitacao is null then',
':P78_TIPO_FERIAS1:=''N'';',
':P78_TIPO_FERIAS2:=''N'';',
'end if;',
'END IF;',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_COD_EMPRESA,P78_MATRICULA,P78_COD_SOLICITACAO,P78_OPCAO_FERIAS'
,p_attribute_03=>'P78_FLAG,P78_OK,P78_MENSAGEM,P78_DIAS_DESCANSO_ADICIONAL,P78_SALDO_BRUTO,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DT_SAIDA_PARC1_1,P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_OPCAO_13SAL1_1,P78_DESC_ADICI'
||'ONAL1_1,P78_DT_RETORNO_PARC1_1,P78_TIPO_FERIAS1_1,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_OPCAO_13SAL2_1,P78_DESC_ADICIONAL2_1,P78_DT_RETORNO_PARC2_1,P78_TIPO_FERIAS2_1,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_AB'
||'ONO_PEC4_1,P78_OPCAO_13SAL4_1,P78_DESC_ADICIONAL4_1,P78_DT_RETORNO_PARC4_1,P78_TIPO_FERIAS4_1,P78_DT_SAIDA_PARC3,P78_NUM_DIAS_PARC3,P78_DT_RETORNO_PARC3,P78_TIPO_FERIAS3,P78_DT_SOLICITACAO,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_OPCAO_ABONO_PEC1,P78_OPCA'
||'O_ABONO_PEC2,P78_DC_MATRICULA,P78_TIPO_FERIAS1,P78_TIPO_FERIAS2,P78_IND_SITUACAO_PARC_2,P78_IND_SITUACAO_PARC_4'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669449595541414050)
,p_name=>'Dispara Alerta'
,p_event_sequence=>47
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MENSAGEM'
,p_condition_element=>'P78_MENSAGEM'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669450092781414050)
,p_event_id=>wwv_flow_api.id(89669449595541414050)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_FLAG'').value == "Q") {',
'alertify.confirm($v(''P78_MENSAGEM''), function (e) {',
'    if (e) {',
'        $x(''P78_FLAG'').value = ''S'';',
'        $x(''P78_MENSAGEM'').value = '''';',
'        $x(''P78_OK'').value = ''S'';',
'',
'    } else {',
'        $x(''P78_OK'').value = ''N'';',
'',
'    }',
'});',
'} else {',
'',
'    if ($x(''P78_MENSAGEM'').value.length  > 0 ) {',
'        ',
'        if ($x(''P78_FLAG'').value == "N") {',
'            $x(''P78_OK'').value = ''N'';',
'',
'        } else {',
'            if ($x(''P78_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P78_OK'').value = ''S'';',
'            }',
'        }',
'',
'		alertify.alert($v(''P78_MENSAGEM''));',
'		',
'        ',
'    }else{',
'            if ($x(''P78_ITEM_VALIDACAO'').value.length == 0){',
'            $x(''P78_OK'').value = ''S'';',
'            }',
'    }',
'    ',
'    if ($x(''P78_ITEM_VALIDACAO'').value == ''P78_CREATE''){',
'            $x(''P78_OK'').value = ''S'';',
'        $x(''P78_ITEM_VALIDACAO'').value = '''';',
'    }',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669538677669414125)
,p_name=>unistr('(Cria\00E7\00E3o) Matricula: Popula_Campos 1')
,p_event_sequence=>48
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*if :P78_ROWID is null and NVL(:P78_OK,''S'') = ''S'' then',
'return true;',
'else',
'return false;',
'end if;*/',
'',
'return :P78_FLAG_CTRL is null and :P78_ROWID is null and nvl(:P78_OK,''S'') = ''S'';',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(85944770765069749367)
,p_event_id=>wwv_flow_api.id(89669538677669414125)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'pkg_req_ferias.pg78_carrega(',
'p_P78_COD_EMPRESA => :P78_COD_EMPRESA,',
'p_P78_MATRICULA => :P78_MATRICULA,',
'p_P78_COD_SOLICITACAO => :P78_COD_SOLICITACAO,',
'p_P78_DIAS_DESCANSO_ADICIONAL => :P78_DIAS_DESCANSO_ADICIONAL,',
'p_P78_SALDO_BRUTO => :P78_SALDO_BRUTO,',
'p_P78_SALDO => :P78_SALDO,',
'p_P78_IND_SITUACAO_PERIODO => :P78_IND_SITUACAO_PERIODO,',
'p_P78_DT_INIC_PER_FERIAS => :P78_DT_INIC_PER_FERIAS,',
'p_P78_DT_FIM_PER_FERIAS => :P78_DT_FIM_PER_FERIAS,',
'p_P78_DT_SAIDA_PARC1_1 => :P78_DT_SAIDA_PARC1_1,',
'p_P78_NUM_DIAS_PARC1_1 => :P78_NUM_DIAS_PARC1_1,',
'p_P78_DIAS_ABONO_PEC1_1 => :P78_DIAS_ABONO_PEC1_1,',
'p_P78_OPCAO_13SAL1_1 => :P78_OPCAO_13SAL1_1,',
'p_P78_DESC_ADICIONAL1_1 => :P78_DESC_ADICIONAL1_1,',
'p_P78_DT_RETORNO_PARC1_1 => :P78_DT_RETORNO_PARC1_1,',
'p_P78_TIPO_FERIAS1_1 => :P78_TIPO_FERIAS1_1,',
'p_P78_DT_SAIDA_PARC2_1 => :P78_DT_SAIDA_PARC2,',
'p_P78_NUM_DIAS_PARC2_1 => :P78_NUM_DIAS_PARC2_1,',
'p_P78_DIAS_ABONO_PEC2_1 => :P78_DIAS_ABONO_PEC2_1,',
'p_P78_OPCAO_13SAL2_1 => :P78_OPCAO_13SAL2_1,',
'p_P78_DESC_ADICIONAL2_1 => :P78_DESC_ADICIONAL2_1,',
'p_P78_DT_RETORNO_PARC2_1 => :P78_DT_RETORNO_PARC2_1,',
'p_P78_TIPO_FERIAS2_1 => :P78_TIPO_FERIAS2_1,',
'p_P78_DT_SAIDA_PARC4_1 => :P78_DT_SAIDA_PARC4_1,',
'p_P78_NUM_DIAS_PARC4_1 => :P78_NUM_DIAS_PARC4_1,',
'p_P78_DIAS_ABONO_PEC4_1 => :P78_DIAS_ABONO_PEC4_1,',
'p_P78_OPCAO_13SAL4_1 => :P78_OPCAO_13SAL4_1,',
'p_P78_DESC_ADICIONAL4_1 => :P78_DESC_ADICIONAL4_1,',
'p_P78_DT_RETORNO_PARC4_1 => :P78_DT_RETORNO_PARC4_1,',
'p_P78_TIPO_FERIAS4_1 => :P78_TIPO_FERIAS4_1,',
'p_P78_DT_SAIDA_PARC3 => :P78_DT_SAIDA_PARC3,',
'p_P78_NUM_DIAS_PARC3 => :P78_NUM_DIAS_PARC3,',
'p_P78_DT_RETORNO_PARC3 => :P78_DT_RETORNO_PARC3,',
'p_P78_TIPO_FERIAS3 => :P78_TIPO_FERIAS3,',
'p_P78_DT_SOLICITACAO => :P78_DT_SOLICITACAO,',
'p_P78_FALTA_HORA => :P78_FALTA_HORA,',
'p_P78_FALTA_MINUTO => :P78_FALTA_MINUTO,',
'p_P78_OPCAO_ABONO_PEC1 => :P78_OPCAO_ABONO_PEC1,',
'p_P78_OPCAO_ABONO_PEC2 => :P78_OPCAO_ABONO_PEC2,',
'p_P78_DC_MATRICULA => :P78_DC_MATRICULA,',
'p_P78_OPCAO_FERIAS => :P78_OPCAO_FERIAS,',
'p_P78_IND_SITUACAO_PARC_2 => :P78_IND_SITUACAO_PARC_2,',
'p_P78_IND_SITUACAO_PARC_4 => :P78_IND_SITUACAO_PARC_4,',
'p_P78_TIPO_FERIAS1 => :P78_TIPO_FERIAS1,',
'p_P78_TIPO_FERIAS2 => :P78_TIPO_FERIAS2,',
'p_P78_FLAG => :P78_FLAG,',
'p_P78_OK => :P78_OK,',
'p_P78_MENSAGEM => :P78_MENSAGEM);',
'IF :P78_OPCAO_FERIAS IS NOT NULL THEN',
'  :P78_OPCAO_FERIAS_DB := :P78_OPCAO_FERIAS;',
'  :P78_OPCAO_FERIAS_A := :P78_OPCAO_FERIAS;',
'  :P78_OPCAO_FERIAS_CARREGA := 1;',
'ELSE',
'  :P78_OPCAO_FERIAS_CARREGA := 0;',
'END IF;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_COD_EMPRESA,P78_MATRICULA,P78_COD_SOLICITACAO'
,p_attribute_03=>'P78_FLAG,P78_OK,P78_MENSAGEM,P78_DIAS_DESCANSO_ADICIONAL,P78_SALDO_BRUTO,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DT_SAIDA_PARC1_1,P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_OPCAO_13SAL1_1,P78_DESC_ADICI'
||'ONAL1_1,P78_DT_RETORNO_PARC1_1,P78_TIPO_FERIAS1_1,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_OPCAO_13SAL2_1,P78_DESC_ADICIONAL2_1,P78_DT_RETORNO_PARC2_1,P78_TIPO_FERIAS2_1,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_AB'
||'ONO_PEC4_1,P78_OPCAO_13SAL4_1,P78_DESC_ADICIONAL4_1,P78_DT_RETORNO_PARC4_1,P78_TIPO_FERIAS4_1,P78_DT_SAIDA_PARC3,P78_NUM_DIAS_PARC3,P78_DT_RETORNO_PARC3,P78_TIPO_FERIAS3,P78_DT_SOLICITACAO,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_OPCAO_ABONO_PEC1,P78_OPCA'
||'O_ABONO_PEC2,P78_DC_MATRICULA,P78_TIPO_FERIAS1,P78_TIPO_FERIAS2,P78_IND_SITUACAO_PARC_2,P78_IND_SITUACAO_PARC_4,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_DB,P78_OPCAO_FERIAS_A,P78_OPCAO_FERIAS_CARREGA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669539660379414126)
,p_event_id=>wwv_flow_api.id(89669538677669414125)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P78_DT_SAIDA_PARC1_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC1_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL1_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL1_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC1_1'').disabled = true;',
'',
'$x(''P78_DT_SAIDA_PARC2_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC2_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC2_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL2_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL2_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC2_1'').disabled = true;',
'',
'$x(''P78_DT_SAIDA_PARC4_1'').disabled = true;',
'$x(''P78_NUM_DIAS_PARC4_1'').disabled = true;',
'$x(''P78_DIAS_ABONO_PEC4_1'').disabled = true;',
'$x(''P78_OPCAO_13SAL4_1'').disabled = true;',
'$x(''P78_DESC_ADICIONAL4_1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC4_1'').disabled = true;'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669540159670414126)
,p_event_id=>wwv_flow_api.id(89669538677669414125)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669540709041414126)
,p_event_id=>wwv_flow_api.id(89669538677669414125)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669541118141414126)
,p_name=>'(Pesquisa) Matricula: Popula_Campos 1'
,p_event_sequence=>58
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_COD_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669541607265414126)
,p_event_id=>wwv_flow_api.id(89669541118141414126)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_data_ini date;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'--if :p78_ok = ''S'' then',
'',
'IF :P78_MATRICULA IS NOT NULL and :p78_cod_solicitacao is not null THEN',
'',
':P78_MENSAGEM := NULL;',
'',
'           begin',
'            select min(dt_inic_per_ferias)',
'            Into v_data_ini',
'            from requisicao_ferias ',
'            where cod_empresa   = :p78_cod_empresa',
'            and matricula       = :p78_matricula',
'            and cod_solicitacao = :p78_cod_solicitacao;',
'           exception when no_data_found then',
'                    select min(dt_inic_per_ferias) ',
'                    Into v_data_ini',
'                    from ferias ',
'                    where cod_empresa = :p78_cod_empresa',
'                    and matricula = :p78_matricula',
'                    and ind_situacao_periodo in (''P'',''R'');',
'           end; ',
'        ',
'				    		BEGIN',
'								select Nvl(dias_descanso_adicional,0)',
'								     , saldo_bruto',
'								     , saldo',
'								     , ind_situacao_periodo',
'								     , dt_inic_per_ferias',
'								     , dt_fim_per_ferias ',
'								     , falta_hora',
'								     , falta_minuto',
'                                     , dc_matricula',
'								  into :p78_dias_descanso_adicional',
'								     , :p78_saldo_bruto',
'								     , :p78_saldo',
'								     , :p78_ind_situacao_periodo',
'								     , :p78_dt_inic_per_ferias',
'								     , :p78_dt_fim_per_ferias  ',
'								     , :p78_falta_hora',
'								     , :p78_falta_minuto',
'                                     , :P78_DC_MATRICULA',
'								  from ferias',
'								 where cod_empresa 				= :p78_cod_empresa',
'								   and matricula   				= :p78_matricula   ',
'								   and dt_inic_per_ferias = v_data_ini;',
'',
'					 END;',
'',
'END IF;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_COD_EMPRESA,P78_MATRICULA,P78_COD_SOLICITACAO'
,p_attribute_03=>'P78_MENSAGEM,P78_DIAS_DESCANSO_ADICIONAL,P78_SALDO_BRUTO,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_DC_MATRICULA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669542066286414127)
,p_event_id=>wwv_flow_api.id(89669541118141414126)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669542572737414127)
,p_event_id=>wwv_flow_api.id(89669541118141414126)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_1'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669542979037414127)
,p_name=>unistr('(Cria\00E7\00E3o) Matricula: Popula_Campos 2')
,p_event_sequence=>68
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*if :P78_ROWID is null and NVL(:P78_OK,''S'') = ''S'' then',
'return true;',
'else',
'return false;',
'end if;*/',
'',
'return :P78_FLAG_CTRL is null and :P78_ROWID is null and nvl(:P78_OK,''S'') = ''S'';'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669543497585414127)
,p_event_id=>wwv_flow_api.id(89669542979037414127)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
' flag number := Null;',
' Cursor c_idade_colab Is ',
'  select trunc(months_between(sysdate,i.DT_NASC)/12) as idade  from inf_pessoais_cad i  where i.MATRICULA = :p78_matricula and i.COD_EMPRESA = :p78_cod_empresa;',
' v_idade_colab c_idade_colab%rowtype;',
' Cursor c_idades Is',
'  select fer.IDADE_MAXIMA, fer.IDADE_MINIMA ',
'  from ferias_parametros fer, inf_pessoais_cad inf',
'  where inf.cod_empresa = fer.cod_empresa and inf.cod_empresa = :P78_COD_EMPRESA and inf.matricula = :P78_matricula and inf.filial = fer.cod_filial;',
' r_idades c_idades%RowType;',
' cursor c1 is',
' select nvl(a.pagto_abono_ferias, ''N'') abono_ferias, a.saldo_fer_min, c.dt_ref_folha, a.cod_filial, b.vinculo',
' from filiais_cad a, informacoes_funcionais b, parametros_recursos_humanos c',
' where  b.cod_empresa = a.cod_empresa and b.filiaL = a.cod_filial and b.cod_empresa = :P78_cod_empresa and b.matricula = :P78_matricula and c.cod_empresa = b.cod_Empresa;',
' v_c1 c1%rowtype;',
'v_data_ini date;',
'cursor c3 (v_filial number) is',
'select qtd_parcelas from ferias_Parametros where cod_empresa = :P78_cod_empresa and cod_filial = v_filial;',
'v_c3 c3%rowtype;',
'v_dias_direito number;',
'v_saldo_bruto number := :P78_SALDO_BRUTO;',
'v_saldo number := :P78_SALDO;',
'v_dias_abono_pec1 number := :P78_DIAS_ABONO_PEC1;',
'begin',
'IF :P78_MATRICULA IS NOT NULL THEN',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'v_saldo_bruto := replace(v_saldo_bruto,'','',''.''); v_saldo := replace(v_saldo,'','',''.''); :P78_MENSAGEM := NULL;',
'If (:P78_matricula Is Not Null And :P78_num_dias_parc1 Is Null) Then',
'Open c_idades; Fetch c_idades Into r_idades; Close c_idades;',
'Open  c_idade_colab; Fetch c_idade_colab Into v_idade_colab; Close c_idade_colab;',
'If (v_idade_colab.idade > r_idades.idade_maxima Or v_idade_colab.idade < r_idades.idade_minima) Then',
':P78_num_dias_parc1  := 30; :P78_dias_abono_pec1 := 0; :p78_num_dias_parc1_dsp  := ''N''; :p78_dias_abono_pec1_dsp := ''N'';',
'Else',
' if :p78_dt_saida_parc1 is not null then',
'  :P78_num_dias_parc1  := 0; :P78_dias_abono_pec1 := 0;',
' else',
'  :P78_num_dias_parc1  := null; :P78_dias_abono_pec1 := v_dias_abono_pec1; :p78_num_dias_parc1_dsp  := ''S''; :p78_dias_abono_pec1_dsp := ''S'';',
' end if;',
'End If;',
'End If;',
'open  c1; fetch c1 into v_c1; close c1;',
' :p78_filial := v_c1.cod_filial; :p78_saldo_fer_min := v_c1.saldo_fer_min;',
' v_dias_direito := Pkg_Atlz_Saldo_Ferias./*fnc_Ret*/Dias_Direito(:P78_COD_EMPRESA,:P78_MATRICULA,:P78_DT_INIC_PER_FERIAS_1,:P78_DT_FIM_PER_FERIAS_1);',
' IF v_dias_direito IS NULL THEN',
' if NVL(:p78_jornada_reduzida,''N'') = ''N'' then',
' v_dias_direito := (30 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0));',
' else',
' v_dias_direito := (18 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0));',
' end if;',
' v_dias_direito := nvl(f_jornada_reduzida(:p78_cod_empresa,:p78_matricula,v_dias_direito,null),0);',
' if nvl(:p78_falta_hora,0) > 7 and NVL(:p78_jornada_reduzida,''N'') = ''S'' then',
' v_dias_direito := v_dias_direito / 2;',
' end if;',
' END IF;',
' :p78_DIAS_DIREITO := nvl(v_dias_direito,0);',
'  if :P78_matricula is not null then',
'begin',
'select distinct a.falta_hora, a.falta_minuto',
'into :P78_falta_hora, :P78_falta_minuto',
'from ferias a',
'where a.cod_empresa = :P78_COD_EMPRESA and a.matricula = :P78_matricula',
'and a.dt_inic_per_ferias = ',
'(select min(dt_inic_per_ferias) v_data_ini from ferias ',
'where cod_empresa = a.cod_empresa and matricula = a.matricula',
unistr('--Bruno Sousa comentado condi\00E7\00E3o abaixo 24/06/2024'),
'and (cod_solicitacao Is Null and dt_saida_parc1 is null and dt_saida_parc2 is null and dt_saida_parc4 is null)',
'AND NOT EXISTS(SELECT 1',
'FROM REQUISICAO_FERIAS B',
'WHERE B.COD_EMPRESA = A.COD_EMPRESA',
'AND B.MATRICULA = A.MATRICULA',
'AND B.DT_INIC_PER_FERIAS = A.DT_INIC_PER_FERIAS',
'AND B.SIT_REQUISICAO not in (3,4,6))',
'and ind_situacao_periodo in (''P'',''R''));',
'exception',
'when others then null;',
'end;',
'  end if;',
'open  c3(v_c1.cod_filial);',
'fetch c3 into v_c3;',
'close c3;',
'if v_c1.vinculo <> ''E'' then',
':p78_qtd_parcelas := v_c3.qtd_parcelas;',
'else',
':p78_qtd_parcelas := 1;',
'end if;',
':P78_VINCULO := V_C1.VINCULO;',
'END IF;',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_SALDO_BRUTO,P78_SALDO,P78_ROWID,P78_OK,P78_FALTA_HORA,P78_JORNADA_REDUZIDA,P78_DIAS_ABONO_PEC1,P78_DIAS_DIREITO,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1'
,p_attribute_03=>'P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_FLAG,P78_OK,P78_MENSAGEM,P78_FILIAL,P78_QTD_PARCELAS,P78_SALDO_FER_MIN,P78_DIAS_DIREITO,P78_VINCULO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669543869326414128)
,p_name=>'Popula_campos_3'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669544430026414128)
,p_event_id=>wwv_flow_api.id(89669543869326414128)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  v_cod_empresa number;',
'  v_matricula number;',
'  v_data_ini date;',
'  v_dias_direito number;',
'  v_saldo_bruto number(15,2);',
'  v_saldo number(15,2);',
'  vDT_SAIDA_PARC1 date;',
'  vIND_SITUACAO_PERIODO varchar2(1);',
'  vNUM_DIAS_PARC1 number(2);',
'  vDIAS_ABONO_PEC1 number(2);',
'  vOPCAO_13SAL1 varchar2(1);',
'  vDT_RETORNO_PARC1 date;',
'begin',
'select A.COD_EMPRESA, A.MATRICULA, A.DT_INIC_PER_FERIAS, A.OPCAO_FERIAS, A.OPCAO_FERIAS',
'into v_cod_empresa, v_matricula, v_data_ini, :P78_OPCAO_FERIAS_A, :P78_OP',
'from REQUISICAO_FERIAS A',
'where A.COD_SOLICITACAO = :P78_COD_REQ;',
'',
'select A.COD_FILIAL ',
'into :P78_FILIAL',
'from FILIAIS_CAD A,',
'     INFORMACOES_FUNCIONAIS B',
'where A.COD_EMPRESA = B.COD_EMPRESA',
'and A.COD_FILIAL = B.filiaL',
'and B.COD_EMPRESA = v_cod_empresa',
'and B.MATRICULA = v_matricula;',
'select  ',
'A.DT_INIC_PER_FERIAS,',
'A.DT_FIM_PER_FERIAS,',
'A.IND_SITUACAO_PERIODO,',
'case A.IND_SITUACAO_PERIODO',
'when ''P'' then ''Pendente''',
'when ''G'' then ''Gozado''',
'when ''Q'' then ''Quitado''',
'when ''R'' then ''Parcial''',
'when ''C'' then ''Cancelado''',
'end,',
'A.FALTA_HORA,',
'A.FALTA_MINUTO,',
'A.DIAS_DESCANSO_ADICIONAL,',
'A.SALDO_BRUTO,',
'A.SALDO,',
'A.IND_SITUACAO_PARC_2,',
'A.IND_SITUACAO_PARC_4,',
'--Bruno Sousa 21/08/2024',
'A.IND_SITUACAO_PERIODO,',
'NVL(A.DT_SAIDA_PARC1, R.DT_SAIDA_PARC1),',
'NVL(A.NUM_DIAS_PARC1, R.NUM_DIAS_PARC1),',
'NVL(A.DIAS_ABONO_PEC1, R.DIAS_ABONO_PEC1),',
'NVL(A.OPCAO_13SAL1, R.OPCAO_13SAL1),',
'NVL(A.DT_RETORNO_PARC1, R.DT_RETORNO_PARC1)',
'into',
':P78_DT_INIC_PER_FERIAS_1,',
':P78_DT_FIM_PER_FERIAS_1,',
':P78_IND_SITUACAO_PERIODO_A,',
':P78_IND_SITUACAO_PERIODO_1,',
':P78_FALTA_HORA_1,',
':P78_FALTA_MINUTO_1,',
':P78_DIAS_DESCANSO_ADICIONAL_1,',
'v_saldo_bruto,',
'v_saldo,',
':P78_IND_SITUACAO_PARC_2_A,',
':P78_IND_SITUACAO_PARC_4_A,',
'--Bruno Sousa 21/08/2024',
'vIND_SITUACAO_PERIODO,',
'vDT_SAIDA_PARC1,',
'vNUM_DIAS_PARC1,',
'vDIAS_ABONO_PEC1,',
'vOPCAO_13SAL1,',
'vDT_RETORNO_PARC1',
'from FERIAS A, REQUISICAO_FERIAS R',
'where A.COD_EMPRESA = v_cod_empresa',
'and A.MATRICULA = v_matricula',
'and A.DT_INIC_PER_FERIAS = v_data_ini',
'and R.COD_SOLICITACAO = :P78_COD_REQ;',
'',
'if vIND_SITUACAO_PERIODO = ''R'' or (vIND_SITUACAO_PERIODO = ''P'' and to_char(sysdate, ''yyyymm'') >= to_char(vDT_SAIDA_PARC1, ''yyyymm'')) then',
'  :P78_DT_SAIDA_PARC1_1 := vDT_SAIDA_PARC1;',
'  :P78_NUM_DIAS_PARC1_1 := vNUM_DIAS_PARC1;',
'  :P78_DIAS_ABONO_PEC1_1 := vDIAS_ABONO_PEC1;',
'  :P78_OPCAO_13SAL1_1 := vOPCAO_13SAL1;',
'  :P78_DT_RETORNO_PARC1_1 := vDT_RETORNO_PARC1;',
'end if;',
':P78_DT_RETORNO_PARC1_1_AUX := :P78_DT_RETORNO_PARC1_1;',
'v_dias_direito := Pkg_Atlz_Saldo_Ferias.Dias_Direito(v_cod_empresa,v_matricula,:P78_DT_INIC_PER_FERIAS_1,:P78_DT_FIM_PER_FERIAS_1);',
'if v_dias_direito is null then',
'  if nvl(:P78_JORNADA_REDUZIDA,''N'') = ''N'' then',
'    v_dias_direito := (30 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0)); -- Humberto/Izidoro 29/09/2014',
'  else',
'    v_dias_direito := (18 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0)); -- Humberto/Izidoro 29/09/2014',
'  end if;',
'  if instr(1/2,'','') > 0 then',
'    EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS=".,"'';',
'  end if;',
'  v_dias_direito := f_jornada_reduzida(v_cod_empresa,v_matricula,v_dias_direito,null);',
'  if :P78_FALTA_HORA > 7 and nvl(:P78_JORNADA_REDUZIDA,''N'') = ''S'' then',
'    v_dias_direito := v_dias_direito / 2;',
'  end if;',
'end if;',
':P78_DIAS_DIREITO_1 := v_dias_direito;',
':P78_SALDO_BRUTO_1 := nvl(trim(v_saldo_bruto),0);',
':P78_SALDO_1 := nvl(trim(v_saldo),0);',
':P78_DIAS_DIREITO_OPC := nvl(:P78_DIAS_DIREITO_1,0);',
'if :P78_OPCAO_FERIAS_A is not null then',
'select A.QTD_PARCELAS,A.DIAS_ABONO_PEC1',
'into :P78_PARCELAS_OPC,:P78_DIAS_ABONO_PEC1_OPC',
'from FERIAS_PARAMETROS_PARCELAS A',
'where A.COD_EMPRESA = v_cod_empresa',
'and A.COD_FILIAL = :P78_FILIAL',
'and A.COD = :P78_OPCAO_FERIAS_A;',
'end if;',
'IF :P78_DT_SAIDA_PARC1_1 IS NULL THEN -- Igor 30/03',
' :P78_OPCAO_FERIAS_A := NULL;',
' :P78_OP := NULL;',
'END IF;',
'exception',
'  when others then',
'    return;',
'end;',
'IF :P78_OPCAO_FERIAS_A IS NOT NULL THEN',
':P78_OPCAO_FERIAS_DB := :P78_OPCAO_FERIAS_A;',
':P78_OPCAO_FERIAS := :P78_OPCAO_FERIAS_A;',
':P78_OPCAO_FERIAS_CARREGA := 1;',
'ELSE',
':P78_OPCAO_FERIAS_CARREGA := 0;',
'END IF;'))
,p_attribute_02=>'P78_COD_REQ,P78_COD_EMPRESA,P78_MATRICULA,P78_DT_SAIDA_PARC1_1'
,p_attribute_03=>'P78_OP,P78_IND_SITUACAO_PARC_2_A,P78_IND_SITUACAO_PARC_4_A,P78_OPCAO_FERIAS_A,P78_DT_SAIDA_PARC1_1,P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_OPCAO_13SAL1_1,P78_DT_RETORNO_PARC1_1,P78_DIAS_ABONO_PEC1_OPC,P78_PARCELAS_OPC,P78_DT_INIC_PER_FERIAS_1,'
||'P78_DT_FIM_PER_FERIAS_1,P78_IND_SITUACAO_PERIODO_A,P78_IND_SITUACAO_PERIODO_1,P78_FALTA_HORA_1,P78_FALTA_MINUTO_1,P78_DIAS_DIREITO_1,P78_DIAS_DESCANSO_ADICIONAL_1,P78_SALDO_BRUTO_1,P78_SALDO_1,P78_FILIAL,P78_DIAS_DIREITO_OPC,P78_DT_RETORNO_PARC1_1_AU'
||'X,P78_OPCAO_FERIAS_CARREGA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669544929407414128)
,p_event_id=>wwv_flow_api.id(89669543869326414128)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669545280570414128)
,p_name=>'Inicia Alertify'
,p_event_sequence=>78
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_TITULO'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669545755696414128)
,p_event_id=>wwv_flow_api.id(89669545280570414128)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_03=>'STANDARD'
,p_attribute_04=>'Teste'
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669546214237414129)
,p_name=>'Pre_Text_Dt_Saida_Parc1'
,p_event_sequence=>88
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669546669464414129)
,p_event_id=>wwv_flow_api.id(89669546214237414129)
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
'cursor c_existe is',
'select matricula',
'  from ferias',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula',
'   and dt_inic_per_ferias = :p78_dt_inic_per_ferias',
'   and dt_fim_per_ferias = :p78_dt_fim_per_ferias',
'   and dt_saida_parc1 = :p78_dt_saida_parc1;',
'   ',
'v_saldo_bruto_char varchar2(1000) := :P78_saldo_bruto;',
'v_saldo_bruto_number number;',
'',
'begin',
'',
'if instr(trim(v_saldo_bruto_char),'','') > 0 then',
'   v_saldo_bruto_number := to_number(replace(trim(v_saldo_bruto_char),'','',''.''));',
'else',
'   v_saldo_bruto_number := to_number(trim(v_saldo_bruto_char));',
'end if; ',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Pre_Text_Dt_Saida_Parc1(:P78_cod_empresa,',
'                                   :P78_matricula,',
'                                   :P78_falta_hora,',
'                                   :P78_dt_fim_per_ferias,',
'                                   :P78_jornada_reduzida,',
'                                   :P78_dias_direito,',
'                                   v_saldo_bruto_number, --:P78_saldo_bruto,',
'                                   :P78_tipo_ferias1,',
'                                   :P78_num_dias_parc1,',
'                                   :P78_dias_abono_pec1,',
'                                   :P78_saldo,',
'                                   :p78_ind_situacao_periodo,',
'                                   :p78_dias_abono_pec1_dsp,',
'                                   :p78_num_dias_parc1_dsp,',
'                                   v_flg_retorno,',
'                                   v_msg_retorno);',
' ',
' if v_msg_retorno is not null then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
'',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_FALTA_HORA,P78_DT_FIM_PER_FERIAS,P78_JORNADA_REDUZIDA,P78_DIAS_DIREITO,P78_SALDO_BRUTO,P78_TIPO_FERIAS1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DT_SAIDA_PARC1,P78_DT_INIC_PER_FER'
||'IAS'
,p_attribute_03=>'P78_TIPO_FERIAS1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_SALDO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669547066616414129)
,p_name=>'Valida_Dt_Saida_Parc1'
,p_event_sequence=>98
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1'
,p_condition_element=>'P78_DT_SAIDA_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669547552410414130)
,p_event_id=>wwv_flow_api.id(89669547066616414129)
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
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'V_DT_SAIDA date;',
'BEGIN',
'',
':p78_mensagem := null;',
'',
'V_DT_SAIDA := :P78_DT_SAIDA_PARC1;',
'v_flg_retorno := PKG_FERIAS.VALIDA_DT_SAIDA(:P78_COD_EMPRESA,:P78_MATRICULA,V_DT_SAIDA,v_msg_retorno);',
'IF v_flg_retorno = ''N'' THEN',
'  :P78_ok := ''N'';',
'  :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
unistr('  :p78_mensagem := ''Sa\00EDda Parcela 1: ''||v_msg_retorno;'),
'  return;',
'END IF;',
'',
'v_cod_empresa:= :p78_cod_empresa;',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := :p78_dt_inic_per_ferias;',
'v_dt_fim_per_ferias := :p78_dt_fim_per_ferias;',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := :p78_saldo_bruto;',
'v_falta_hora := :p78_falta_hora;',
'v_dias_direito := :p78_dias_direito;',
'v_dt_saida_parc1 := nvl(V_DT_SAIDA,:p78_dt_saida_parc1);',
'v_saldo := :p78_saldo;',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := :p78_ind_situacao_periodo;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno);',
'',
':p78_saldo := nvl(v_saldo,:p78_saldo);',
':p78_dias_abono_pec1 := NVL(nvl(v_dias_abono_pec1, :p78_dias_abono_pec1),0);',
':p78_num_dias_parc1 := nvl(v_num_dias_parc1,:p78_num_dias_parc1);',
':p78_opcao_13sal1 := nvl(v_opcao_13sal1,:p78_opcao_13sal1);',
':p78_opcao_13sal2 := nvl(v_opcao_13sal2,:p78_opcao_13sal2);',
':p78_tipo_ferias1 := nvl(v_tipo_ferias1,:p78_tipo_ferias1);',
'',
':P78_TESTE := :P78_TESTE||''(A1) V_DT_RETORNO_PARC1: ''||V_DT_RETORNO_PARC1;',
'',
'IF V_DT_RETORNO_PARC1 IS NOT NULL THEN',
':p78_dt_retorno_parc1 := v_dt_retorno_parc1;',
unistr(':P78_DT_RETORNO_PARC1_X := v_dt_retorno_parc1; -- Cibele 01/04/2022, n\00E3o estava atualizando corretamente a data de retorno da P1'),
'ELSE',
':p78_dt_retorno_parc1 := v_dt_retorno_parc1_old;',
unistr(':p78_dt_retorno_parc1_X := v_dt_retorno_parc1_old; -- Cibele 01/04/2022, n\00E3o estava atualizando corretamente a data de retorno da P1'),
'END IF;',
'',
':p78_dt_pagto_parc1 := nvl(v_dt_pagto_parc1,:p78_dt_pagto_parc1);',
'',
':P78_TESTE := :P78_TESTE||''(A2) p78_dt_retorno_parc1: ''||:p78_dt_retorno_parc1;',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_DT_1 := V_DT_SAIDA;',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if; ',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DT_SAIDA_PARC2,P78_SALDO_BRUTO,P78_FALTA_HORA,P78_DIAS_DIREITO,P78_DT_SAIDA_PARC1,P78_SALDO,P78_DIAS_ABONO_PEC1,P78_NUM_DIAS_PARC1,P78_OPCAO_13SAL1,P78'
||'_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_JORNADA_REDUZIDA,P78_IND_SITUACAO_PERIODO,P78_ITEM_VALIDACAO,P78_TESTE'
,p_attribute_03=>'P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_PAGTO_PARC1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_DT_RETORNO_PARC1_X,P7'
||'8_DT_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669548089625414130)
,p_event_id=>wwv_flow_api.id(89669547066616414129)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1_DSP,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1_DSP,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC1_LST,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1_X,P78_DT_RETORNO_PARC1,P78_TIPO_FERIAS1,P78_OPCAO_ABONO_PEC1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669548545519414130)
,p_name=>'Valida_Dt_Saida_Parc1a'
,p_event_sequence=>108
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1'
,p_condition_element=>'P78_DT_SAIDA_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669549524629414131)
,p_event_id=>wwv_flow_api.id(89669548545519414130)
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
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'V_DT_SAIDA DATE;',
'BEGIN',
'',
':p78_mensagem := null;',
'',
'',
'V_DT_SAIDA := :P78_DT_SAIDA_PARC1;',
'v_flg_retorno := PKG_FERIAS.VALIDA_DT_SAIDA(:P78_COD_EMPRESA,:P78_MATRICULA,V_DT_SAIDA,v_msg_retorno);',
'IF v_flg_retorno = ''N'' THEN',
'  :P78_ok := ''N'';',
'  :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
unistr('  :p78_mensagem := ''Sa\00EDda Parcela 1: ''||v_msg_retorno;'),
'  return;',
'END IF;',
'',
'v_cod_empresa:= :p78_cod_empresa;',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := :p78_dt_inic_per_ferias_1;',
'v_dt_fim_per_ferias := :p78_dt_fim_per_ferias_1;',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := :p78_saldo_bruto_1;',
'v_falta_hora := :p78_falta_hora_1;',
'v_dias_direito := :p78_dias_direito_1;',
'v_dt_saida_parc1 := nvl(V_DT_SAIDA,:p78_dt_saida_parc1);',
'v_saldo := :p78_saldo_1;',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := :p78_ind_situacao_periodo_a;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno);',
'',
':p78_saldo := nvl(v_saldo,:p78_saldo);',
':p78_dias_abono_pec1 := NVL(nvl(v_dias_abono_pec1, :p78_dias_abono_pec1),0);',
':p78_num_dias_parc1 := nvl(v_num_dias_parc1,:p78_num_dias_parc1);',
':p78_opcao_13sal1 := nvl(v_opcao_13sal1,:p78_opcao_13sal1);',
':p78_opcao_13sal2 := nvl(v_opcao_13sal2,:p78_opcao_13sal2);',
':p78_tipo_ferias1 := nvl(v_tipo_ferias1,:p78_tipo_ferias1);',
'',
':P78_TESTE := :P78_TESTE||''(A1) V_DT_RETORNO_PARC1: ''||V_DT_RETORNO_PARC1;',
'',
'IF V_DT_RETORNO_PARC1 IS NOT NULL THEN',
':p78_dt_retorno_parc1 := v_dt_retorno_parc1;',
unistr(':P78_DT_RETORNO_PARC1_X := v_dt_retorno_parc1; -- Cibele 01/04/2022, n\00E3o estava atualizando corretamente a data de retorno da P1'),
'ELSE',
':p78_dt_retorno_parc1 := v_dt_retorno_parc1_old;',
unistr(':p78_dt_retorno_parc1_X := v_dt_retorno_parc1_old; -- Cibele 01/04/2022, n\00E3o estava atualizando corretamente a data de retorno da P1'),
'END IF;',
'',
':p78_dt_pagto_parc1 := nvl(v_dt_pagto_parc1,:p78_dt_pagto_parc1);',
'',
':P78_TESTE := :P78_TESTE||''(A2) p78_dt_retorno_parc1: ''||:p78_dt_retorno_parc1;',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':p78_dt_1 := v_dt_saida_parc1;',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if; ',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_DT_SAIDA_PARC2,P78_SALDO_BRUTO_1,P78_FALTA_HORA_1,P78_DIAS_DIREITO_1,P78_DT_SAIDA_PARC1,P78_SALDO_1,P78_DIAS_ABONO_PEC1,P78_NUM_DIAS_PARC1,P78_OPCA'
||'O_13SAL1,P78_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_JORNADA_REDUZIDA,P78_IND_SITUACAO_PERIODO_1,P78_ITEM_VALIDACAO,P78_TESTE'
,p_attribute_03=>'P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_PAGTO_PARC1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_DT_RETORNO_PARC1_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669549016179414130)
,p_event_id=>wwv_flow_api.id(89669548545519414130)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1_DSP,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1_DSP,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC1_LST,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1_X,P78_DT_RETORNO_PARC1,P78_TIPO_FERIAS1,P78_OPCAO_ABONO_PEC1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669549917588414131)
,p_name=>'Valida_Dt_Saida_Parc3_1'
,p_event_sequence=>118
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC3'
,p_condition_element=>'P78_DT_SAIDA_PARC3'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669550407257414131)
,p_event_id=>wwv_flow_api.id(89669549917588414131)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Dt_Saida_Parc3_1(:p78_cod_empresa        ,',
'                                 :p78_matricula          ,',
'                                 :p78_cod_solicitacao    ,',
'                                 :p78_dt_inic_per_ferias ,',
'                                 :p78_dt_saida_parc3     ,',
'                                 v_flg_retorno        ,',
'                                 v_msg_retorno        ); ',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc3''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc3'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_SAIDA_PARC3,P78_ITEM_VALIDACAO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669550791358414131)
,p_name=>'Valida_Dt_Saida_Parc3_2'
,p_event_sequence=>128
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC3'
,p_condition_element=>'P78_DT_SAIDA_PARC3'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P78_OK'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669551317274414131)
,p_event_id=>wwv_flow_api.id(89669550791358414131)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Dt_Saida_Parc3_1(:p78_cod_empresa        ,',
'                                 :p78_matricula          ,',
'                                 :p78_cod_solicitacao    ,',
'                                 :p78_dt_inic_per_ferias ,',
'                                 :p78_dt_saida_parc3     ,',
'                                 v_flg_retorno        ,',
'                                 v_msg_retorno        ); ',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_matricula''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_matricula'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_SAIDA_PARC3,P78_ITEM_VALIDACAO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669551712890414132)
,p_name=>'When_New_Item_Parc2'
,p_event_sequence=>138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC2'
,p_condition_element=>'P78_DT_SAIDA_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669552237249414132)
,p_event_id=>wwv_flow_api.id(89669551712890414132)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'',
' pkg_ferias.When_New_Item_Parc2(:p78_cod_empresa,',
'                                :p78_matricula,',
'                                nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                                nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                                nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1),',
'                                :p78_dt_fim_per_ferias,',
'                                nvl(:p78_saldo,:p78_saldo_1),',
'                                nvl(:p78_dias_direito,:p78_dias_direito_1),',
'                                :p78_opcao_13sal2,',
'                                :p78_dias_abono_pec1_dsp,',
'                                :p78_num_dias_parc1_dsp,',
'                                v_flg_retorno,',
'                                v_msg_retorno); ',
'',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DT_FIM_PER_FERIAS,P78_SALDO,P78_DIAS_DIREITO,P78_ITEM_VALIDACAO,P78_DT_SAIDA_PARC1_1,P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DIAS_DIREITO_1,P78_SALDO_1'
,p_attribute_03=>'P78_OPCAO_13SAL2,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669552639252414132)
,p_name=>'When_New_Item_Parc4'
,p_event_sequence=>148
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC4'
,p_condition_element=>'P78_DT_SAIDA_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669553000981414314)
,p_event_id=>wwv_flow_api.id(89669552639252414132)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
' pkg_ferias.When_New_Item_Parc4(:p78_cod_empresa,',
'                                :p78_matricula,',
'                                nvl(:P78_DT_SAIDA_PARC1,:P78_DT_SAIDA_PARC1_1),',
'                                nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                                nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                                nvl(:P78_DT_SAIDA_PARC2,:P78_DT_SAIDA_PARC2_1),',
'                                nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1),',
'                                nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1),',
'                                :p78_dt_saida_parc4,',
'                                :p78_num_dias_parc4,',
'                                :p78_dias_abono_pec4,',
'                                :p78_dt_fim_per_ferias,',
'                                :p78_saldo,',
'                                :p78_dias_direito,',
'                                :p78_opcao_13sal4,',
'                                :p78_dias_abono_pec1_dsp,',
'                                :p78_num_dias_parc1_dsp,',
'                                v_flg_retorno,',
'                                v_msg_retorno); ',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DIAS_ABONO_PEC2,P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4,P78_DIAS_ABONO_PEC4,P78_DT_FIM_PER_FERIAS,P78_SALDO,P78_DIAS_DIREI'
||'TO,P78_OPCAO_13SAL4,P78_ITEM_VALIDACAO,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1'
,p_attribute_03=>'P78_OPCAO_13SAL4,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669553357599414314)
,p_name=>'Valida_Dt_Saida_Parc2'
,p_event_sequence=>158
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC2'
,p_condition_element=>'P78_DT_SAIDA_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669553919951414314)
,p_event_id=>wwv_flow_api.id(89669553357599414314)
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
'v_DIAS_ABONO_PEC2 number := :P78_DIAS_ABONO_PEC2;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'v_dt_saida date;',
'begin',
'',
'V_DT_SAIDA := :p78_dt_saida_parc2;',
'v_flg_retorno := PKG_FERIAS.VALIDA_DT_SAIDA(:P78_COD_EMPRESA,:P78_MATRICULA,V_DT_SAIDA,v_msg_retorno);',
'IF v_flg_retorno = ''N'' THEN',
'  :P78_ok := ''N'';',
'  :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc2''));',
unistr('  :p78_mensagem := ''Sa\00EDda Parcela 2: ''||v_msg_retorno;'),
'  return;',
'END IF;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc2(:p78_cod_empresa,',
'                                  :p78_cod_solicitacao,',
'                                  :p78_matricula,',
'                                  nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                                  nvl(:p78_dt_retorno_parc1,:p78_dt_retorno_parc1_1),',
'                                  nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                                  V_DT_SAIDA, --:p78_dt_saida_parc2,',
'                                  nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1),',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                  nvl(:p78_saldo,:p78_saldo_1),',
'                                  nvl(:p78_dias_direito,:p78_dias_direito_1),',
'                                 -- Inclusao da data limite como parametro nao obrigatorio para calculo da data de saida e retorno - chamado 29668 - Andre - 25-04-2023',
'                                  :P78_DT_LIMITE_REQ,                                 ',
'                                  :p78_num_dias_parc2,',
'                                  v_DIAS_ABONO_PEC2,',
'                                  :p78_dt_retorno_parc2,',
'                                  :p78_dt_pagto_parc2,',
'                                  :p78_tipo_ferias2,',
'                                  :p78_opcao_13sal2,',
'                                  :p78_dias_abono_pec1_dsp,',
'                                  :p78_num_dias_parc1_dsp,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
' :P78_DIAS_ABONO_PEC2 := nvl(v_DIAS_ABONO_PEC2,:P78_DIAS_ABONO_PEC2);',
' ',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :p78_dt_2     := V_DT_SAIDA;',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_DT_RETORNO_PARC1,P78_NUM_DIAS_PARC1,P78_DT_SAIDA_PARC2,P78_DIAS_ABONO_PEC1,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_SALDO,P78_DIAS_ABONO_PEC2,P78_DIAS_DIREITO,P78_ITEM_V'
||'ALIDACAO,P78_DT_SAIDA_PARC1_1,P78_DT_RETORNO_PARC1_1,P78_NUM_DIAS_PARC1_1,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_SALDO_1,P78_DIAS_DIREITO_1'
,p_attribute_03=>'P78_TIPO_FERIAS2,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_DT_RETORNO_PARC2,P78_DT_2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669554291523414320)
,p_name=>'Valida_Dt_Saida_Parc4'
,p_event_sequence=>168
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC4'
,p_condition_element=>'P78_DT_SAIDA_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669554778693414320)
,p_event_id=>wwv_flow_api.id(89669554291523414320)
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
'v_DIAS_ABONO_PEC4 number := :P78_DIAS_ABONO_PEC4;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'v_dt_saida date;',
'begin',
'',
'V_DT_SAIDA := :p78_dt_saida_parc4;',
'v_flg_retorno := PKG_FERIAS.VALIDA_DT_SAIDA(:P78_COD_EMPRESA,:P78_MATRICULA,V_DT_SAIDA,v_msg_retorno);',
'IF v_flg_retorno = ''N'' THEN',
'  :P78_ok := ''N'';',
'  :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc2''));',
unistr('  :p78_mensagem := ''Sa\00EDda Parcela 2: ''||v_msg_retorno;'),
'  return;',
'END IF;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc4(:p78_cod_empresa,',
'                                  :p78_cod_solicitacao,',
'                                  :p78_matricula,',
'                                  nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                                  :p78_dt_retorno_parc1,',
'                                  nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                                  :p78_dt_retorno_parc2,',
'                                  nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                                  nvl(:p78_num_dias_parc2,:p78_num_dias_parc2_1),',
'                                  V_DT_SAIDA, --:p78_dt_saida_parc4,',
'                                  nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1),',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                  nvl(:p78_saldo,:p78_saldo_1),',
'                                  nvl(:p78_dias_direito,:p78_dias_direito_1),',
'                                 -- Inclusao da data limite como parametro nao obrigatorio para calculo da data de saida e retorno - chamado 29668 - Andre - 25-04-2023',
'                                  :P78_DT_LIMITE_REQ,                                 ',
'                                  :p78_num_dias_parc4,',
'                                  :p78_dias_abono_pec4,',
'                                  :p78_dt_retorno_parc4,',
'                                  :p78_dt_pagto_parc4,',
'                                  :p78_tipo_ferias4,',
'                                  :p78_opcao_13sal4,',
'                                  :p78_dias_abono_pec1_dsp,',
'                                  :p78_num_dias_parc1_dsp,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'								  ',
' :P78_DIAS_ABONO_PEC4 := nvl(v_DIAS_ABONO_PEC4,:P78_DIAS_ABONO_PEC4);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :p78_dt_4     := V_DT_SAIDA;',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_DT_RETORNO_PARC1,P78_DT_SAIDA_PARC2,P78_DT_RETORNO_PARC2,P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_DT_SAIDA_PARC4,P78_DIAS_ABONO_PEC1,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIA'
||'S,P78_SALDO,P78_DIAS_DIREITO,P78_NUM_DIAS_PARC4,P78_DIAS_ABONO_PEC4,P78_DT_RETORNO_PARC4,P78_DT_PAGTO_PARC4,P78_TIPO_FERIAS4,P78_OPCAO_13SAL4,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_ITEM_VALIDACAO,P78_DT_SAIDA_PARC1_1,P78_DT_SAIDA_PARC2_1,'
||'P78_NUM_DIAS_PARC1_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC1_1,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1'
,p_attribute_03=>'P78_NUM_DIAS_PARC4,P78_DT_RETORNO_PARC4,P78_DT_PAGTO_PARC4,P78_TIPO_FERIAS4,P78_OPCAO_13SAL4,P78_OK,P78_FLAG,P78_MENSAGEM,P78_DIAS_ABONO_PEC4,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,,P78_NUM_DIAS_PARC1_DSP,P78_DT_4'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669555224953414320)
,p_name=>'Valida_Num_Dias_Parc1'
,p_event_sequence=>178
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1'
,p_condition_element=>'P78_NUM_DIAS_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669555651020414327)
,p_event_id=>wwv_flow_api.id(89669555224953414320)
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
'v_cod_empresa      number := :p78_cod_empresa;',
'v_matricula inf_pessoais.matricula%type := :p78_matricula;',
'v_ind_limpa varchar2(200) := ''N'';',
'v_dt_fim_per_ferias ferias.dt_fim_per_ferias%type := :p78_dt_fim_per_ferias;',
'v_saldo     number := :p78_saldo;',
'v_dt_saida_parc1   ferias.dt_saida_parc1%type := :p78_dt_saida_parc1;',
'v_num_dias_parc1   number(15,2) := :p78_num_dias_parc1;',
'v_dt_retorno_parc1 ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old    ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dias_descanso_adicional ferias.dias_descanso_adicional%type := :p78_dias_descanso_adicional;',
'v_desc_adicional1  ferias.desc_adicional1%type := :p78_desc_adicional1;',
'v_tipo_ferias1     ferias.tipo_ferias1%type := :p78_tipo_ferias1;',
'v_dias_abono_pec1  number := :p78_dias_abono_pec1;',
'v_dias_direito     number := :p78_dias_direito;',
'v_ind_situacao_periodo    ferias.ind_situacao_periodo%type := :p78_ind_situacao_periodo;',
'v_jornada_reduzida varchar2(100) := :p78_jornada_reduzida;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Num_Dias_Parc1(v_cod_empresa,',
'     v_matricula,',
'     v_ind_limpa,',
'     v_dt_fim_per_ferias,',
'     v_saldo,',
'     v_dt_saida_parc1,',
'     v_num_dias_parc1,',
'     v_dt_retorno_parc1,',
'     v_dias_descanso_adicional,',
'     v_desc_adicional1,',
'     v_tipo_ferias1,',
'     v_dias_abono_pec1,',
'     v_dias_direito,',
'     v_ind_situacao_periodo,',
'     v_jornada_reduzida,',
'     :p78_dias_abono_pec1_dsp,',
'     :p78_num_dias_parc1_dsp,',
'     v_flg_retorno,',
'     v_msg_retorno,',
'     nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A));',
'',
'--:p78_num_dias_parc1   := nvl(v_num_dias_parc1, :p78_num_dias_parc1);',
':P78_TESTE := v_dt_retorno_parc1;',
'if :p78_dt_saida_parc1 <> v_dt_saida_parc1 then',
':p78_dt_saida_parc1   := nvl(v_dt_saida_parc1, :p78_dt_saida_parc1);',
'end if;',
'',
'--if (v_dt_retorno_parc1 <> v_dt_retorno_parc1_old and v_dt_retorno_parc1 is not null) then',
'/*if (v_dt_retorno_parc1 is not null) then',
'   :p78_dt_retorno_parc1 := v_dt_retorno_parc1;',
'else ',
'   :p78_dt_retorno_parc1 := v_dt_retorno_parc1_old;',
'end if;',
'*/',
'if v_dt_retorno_parc1 is not null then',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1;',
'else',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1_old;',
'end if;',
':P78_TESTE := :P78_TESTE||'', v_num_dias_parc1: ''||v_num_dias_parc1||'', p78_dt_retorno_parc1: ''||:p78_dt_retorno_parc1;',
'IF NVL(v_num_dias_parc1,0) = 0 THEN',
':p78_dt_retorno_parc1 := NULL;',
'END IF;',
'',
':p78_dias_descanso_adicional := nvl(v_dias_descanso_adicional, :p78_dias_descanso_adicional);',
':p78_desc_adicional1  := nvl(v_desc_adicional1, :p78_desc_adicional1);',
':p78_tipo_ferias1     := nvl(v_tipo_ferias1, :p78_tipo_ferias1);',
':p78_dias_abono_pec1  := nvl(NVL(v_dias_abono_pec1, nvl(:p78_dias_abono_pec1,0)),0);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
' :P78_ok:= ''N'';',
' :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_num_dias_parc1''));',
'    else',
' :P78_ok:= ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_num_dias_parc1'')) OR v_item_validacao IS NULL then',
':P78_OK := ''S'';',
':P78_ITEM_VALIDACAO := null;',
'    else',
':P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_FIM_PER_FERIAS,P78_SALDO,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DT_RETORNO_PARC1,P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_DIAS_DIREITO,P78_IND_SITUACAO_PERIODO,P78_JORNADA_REDUZIDA,P78_ITEM_VALIDACAO'
||',P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_TESTE'
,p_attribute_03=>'P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669556239083414336)
,p_event_id=>wwv_flow_api.id(89669555224953414320)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_SALDO'').value == $x(''P78_NUM_DIAS_PARC1'').value) {',
'',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = true;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;    ',
'    ',
'}else{',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = false;    ',
'          ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669556546187414336)
,p_name=>'Valida_Num_Dias_Parc1a'
,p_event_sequence=>188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1'
,p_condition_element=>'P78_NUM_DIAS_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669557056805414336)
,p_event_id=>wwv_flow_api.id(89669556546187414336)
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
'v_cod_empresa      number := :p78_cod_empresa;',
'v_matricula inf_pessoais.matricula%type := :p78_matricula;',
'v_ind_limpa varchar2(200) := ''N'';',
'v_dt_fim_per_ferias ferias.dt_fim_per_ferias%type := :p78_dt_fim_per_ferias_1;',
'v_saldo     number := :p78_saldo_1;',
'v_dt_saida_parc1   ferias.dt_saida_parc1%type := :p78_dt_saida_parc1;',
'v_num_dias_parc1   number(15,2) := :p78_num_dias_parc1;',
'v_dt_retorno_parc1 ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old    ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dias_descanso_adicional ferias.dias_descanso_adicional%type := :p78_dias_descanso_adicional;',
'v_desc_adicional1  ferias.desc_adicional1%type := :p78_desc_adicional1;',
'v_tipo_ferias1     ferias.tipo_ferias1%type := :p78_tipo_ferias1;',
'v_dias_abono_pec1  number := :p78_dias_abono_pec1;',
'v_dias_direito     number := :p78_dias_direito_1;',
'v_ind_situacao_periodo    ferias.ind_situacao_periodo%type := :p78_ind_situacao_periodo_A;',
'v_jornada_reduzida varchar2(100) := :p78_jornada_reduzida;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
':p78_mensagem := null;',
'',
'',
'pkg_ferias.Valida_Num_Dias_Parc1(v_cod_empresa,',
'     v_matricula,',
'     v_ind_limpa,',
'     v_dt_fim_per_ferias,',
'     v_saldo,',
'     v_dt_saida_parc1,',
'     v_num_dias_parc1,',
'     v_dt_retorno_parc1,',
'     v_dias_descanso_adicional,',
'     v_desc_adicional1,',
'     v_tipo_ferias1,',
'     v_dias_abono_pec1,',
'     v_dias_direito,',
'     v_ind_situacao_periodo,',
'     v_jornada_reduzida,',
'     :p78_dias_abono_pec1_dsp,',
'     :p78_num_dias_parc1_dsp,',
'     v_flg_retorno,',
'     v_msg_retorno,',
'     nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A));',
'',
':P78_TESTE := v_dt_retorno_parc1;',
'if :p78_dt_saida_parc1 <> v_dt_saida_parc1 then',
':p78_dt_saida_parc1   := nvl(v_dt_saida_parc1, :p78_dt_saida_parc1);',
'end if;',
'',
'',
'if v_dt_retorno_parc1 is not null then',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1;',
'else',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1_old;',
'end if;',
':P78_TESTE := :P78_TESTE||'', v_num_dias_parc1: ''||v_num_dias_parc1||'', p78_dt_retorno_parc1: ''||:p78_dt_retorno_parc1;',
'IF NVL(v_num_dias_parc1,0) = 0 THEN',
':p78_dt_retorno_parc1 := NULL;',
'END IF;',
'',
':p78_dias_descanso_adicional := nvl(v_dias_descanso_adicional, :p78_dias_descanso_adicional);',
':p78_desc_adicional1  := nvl(v_desc_adicional1, :p78_desc_adicional1);',
':p78_tipo_ferias1     := nvl(v_tipo_ferias1, :p78_tipo_ferias1);',
':p78_dias_abono_pec1  := nvl(NVL(v_dias_abono_pec1, nvl(:p78_dias_abono_pec1,0)),0);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
' :P78_ok:= ''N'';',
' :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_num_dias_parc1''));',
'    else',
' :P78_ok:= ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_num_dias_parc1'')) OR v_item_validacao IS NULL then',
':P78_OK := ''S'';',
':P78_ITEM_VALIDACAO := null;',
'    else',
':P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_FIM_PER_FERIAS_1,P78_SALDO_1,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DT_RETORNO_PARC1,P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_DIAS_DIREITO_1,P78_IND_SITUACAO_PERIODO_1,P78_JORNADA_REDUZIDA,P78_ITEM_V'
||'ALIDACAO,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_TESTE'
,p_attribute_03=>'P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669557558211414636)
,p_event_id=>wwv_flow_api.id(89669556546187414336)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_SALDO'').value == $x(''P78_NUM_DIAS_PARC1'').value) {',
'',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = true;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;    ',
'    ',
'}else{',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = false;    ',
'          ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669557916125414636)
,p_name=>'Limpa Data de Retorno'
,p_event_sequence=>198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_condition_element=>'P78_NUM_DIAS_PARC1_LST'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669558373502414637)
,p_event_id=>wwv_flow_api.id(89669557916125414636)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_RETORNO_PARC1_1,P78_DT_RETORNO_PARC1_X'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669558812373414637)
,p_name=>'Seta num_dias_parc1'
,p_event_sequence=>208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669559181609414637)
,p_event_id=>wwv_flow_api.id(89669558812373414637)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_NUM_DIAS_PARC1 := :P78_NUM_DIAS_PARC1_LST;'
,p_attribute_02=>'P78_NUM_DIAS_PARC1_LST'
,p_attribute_03=>'P78_NUM_DIAS_PARC1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669559615637414641)
,p_name=>'Valida_Num_Dias_Parc1_LST'
,p_event_sequence=>218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_condition_element=>'P78_NUM_DIAS_PARC1_LST'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669560061311414641)
,p_event_id=>wwv_flow_api.id(89669559615637414641)
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
'v_cod_empresa      number := :p78_cod_empresa;',
'v_matricula inf_pessoais.matricula%type := :p78_matricula;',
'v_ind_limpa varchar2(200) := ''N'';',
'v_dt_fim_per_ferias ferias.dt_fim_per_ferias%type := :p78_dt_fim_per_ferias;',
'v_saldo     number := :p78_saldo;',
'v_dt_saida_parc1   ferias.dt_saida_parc1%type := :p78_dt_saida_parc1;',
'v_num_dias_parc1   number(15,2) := :p78_num_dias_parc1;',
'v_dt_retorno_parc1 ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old    ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dias_descanso_adicional ferias.dias_descanso_adicional%type := :p78_dias_descanso_adicional;',
'v_desc_adicional1  ferias.desc_adicional1%type := :p78_desc_adicional1;',
'v_tipo_ferias1     ferias.tipo_ferias1%type := :p78_tipo_ferias1;',
'v_dias_abono_pec1  number := :p78_dias_abono_pec1;',
'v_dias_direito     number := :p78_dias_direito;',
'v_ind_situacao_periodo    ferias.ind_situacao_periodo%type := :p78_ind_situacao_periodo;',
'v_jornada_reduzida varchar2(100) := :p78_jornada_reduzida;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Num_Dias_Parc1(v_cod_empresa,',
'     v_matricula,',
'     v_ind_limpa,',
'     v_dt_fim_per_ferias,',
'     v_saldo,',
'     v_dt_saida_parc1,',
'     v_num_dias_parc1,',
'     v_dt_retorno_parc1,',
'     v_dias_descanso_adicional,',
'     v_desc_adicional1,',
'     v_tipo_ferias1,',
'     v_dias_abono_pec1,',
'     v_dias_direito,',
'     v_ind_situacao_periodo,',
'     v_jornada_reduzida,',
'     :p78_dias_abono_pec1_dsp,',
'     :p78_num_dias_parc1_dsp,',
'     v_flg_retorno,',
'     v_msg_retorno,',
'     nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A));',
'',
'--:p78_num_dias_parc1   := nvl(v_num_dias_parc1, :p78_num_dias_parc1);',
'if :p78_dt_saida_parc1 <> v_dt_saida_parc1 then',
':p78_dt_saida_parc1   := nvl(v_dt_saida_parc1, :p78_dt_saida_parc1);',
'end if;',
'',
'--if (v_dt_retorno_parc1 <> v_dt_retorno_parc1_old and v_dt_retorno_parc1 is not null) then',
'/*if (v_dt_retorno_parc1 is not null) then',
'   :p78_dt_retorno_parc1 := v_dt_retorno_parc1;',
'else ',
'   :p78_dt_retorno_parc1 := v_dt_retorno_parc1_old;',
'end if;',
'*/',
'if v_dt_retorno_parc1 is not null then',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1;',
'else',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1_old;',
'end if;',
'',
'IF NVL(v_num_dias_parc1,0) = 0 THEN',
':p78_dt_retorno_parc1 := NULL;',
'END IF;',
'',
':p78_dias_descanso_adicional := nvl(v_dias_descanso_adicional, :p78_dias_descanso_adicional);',
':p78_desc_adicional1  := nvl(v_desc_adicional1, :p78_desc_adicional1);',
':p78_tipo_ferias1     := nvl(v_tipo_ferias1, :p78_tipo_ferias1);',
':p78_dias_abono_pec1  := nvl(NVL(v_dias_abono_pec1, nvl(:p78_dias_abono_pec1,0)),0);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
' :P78_ok:= ''N'';',
' :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_num_dias_parc1''));',
'    else',
' :P78_ok:= ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_num_dias_parc1'')) OR v_item_validacao IS NULL then',
':P78_OK := ''S'';',
':P78_ITEM_VALIDACAO := null;',
'    else',
':P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_FIM_PER_FERIAS,P78_SALDO,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DT_RETORNO_PARC1,P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_DIAS_DIREITO,P78_IND_SITUACAO_PERIODO,P78_JORNADA_REDUZIDA,P78_ITEM_VALIDACAO'
||',P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A'
,p_attribute_03=>'P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669560604608414648)
,p_event_id=>wwv_flow_api.id(89669559615637414641)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_SALDO'').value == $x(''P78_NUM_DIAS_PARC1'').value) {',
'',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = true;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;    ',
'    ',
'}else{',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = false;    ',
'          ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669398224023413781)
,p_name=>'Valida_Num_Dias_Parc1_LST_1'
,p_event_sequence=>228
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_condition_element=>'P78_NUM_DIAS_PARC1_LST'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669398734858413785)
,p_event_id=>wwv_flow_api.id(89669398224023413781)
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
'v_cod_empresa      number := :p78_cod_empresa;',
'v_matricula inf_pessoais.matricula%type := :p78_matricula;',
'v_ind_limpa varchar2(200) := ''N'';',
'v_dt_fim_per_ferias ferias.dt_fim_per_ferias%type := :p78_dt_fim_per_ferias_1;',
'v_saldo     number := :p78_saldo_1;',
'v_dt_saida_parc1   ferias.dt_saida_parc1%type := :p78_dt_saida_parc1;',
'v_num_dias_parc1   number(15,2) := :p78_num_dias_parc1;',
'v_dt_retorno_parc1 ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old    ferias.dt_retorno_parc1%type := :p78_dt_retorno_parc1;',
'v_dias_descanso_adicional ferias.dias_descanso_adicional%type := :p78_dias_descanso_adicional;',
'v_desc_adicional1  ferias.desc_adicional1%type := :p78_desc_adicional1;',
'v_tipo_ferias1     ferias.tipo_ferias1%type := :p78_tipo_ferias1;',
'v_dias_abono_pec1  number := :p78_dias_abono_pec1;',
'v_dias_direito     number := :p78_dias_direito_1;',
'v_ind_situacao_periodo    ferias.ind_situacao_periodo%type := :p78_ind_situacao_periodo_a;',
'v_jornada_reduzida varchar2(100) := :p78_jornada_reduzida;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Num_Dias_Parc1(v_cod_empresa,',
'     v_matricula,',
'     v_ind_limpa,',
'     v_dt_fim_per_ferias,',
'     v_saldo,',
'     v_dt_saida_parc1,',
'     v_num_dias_parc1,',
'     v_dt_retorno_parc1,',
'     v_dias_descanso_adicional,',
'     v_desc_adicional1,',
'     v_tipo_ferias1,',
'     v_dias_abono_pec1,',
'     v_dias_direito,',
'     v_ind_situacao_periodo,',
'     v_jornada_reduzida,',
'     :p78_dias_abono_pec1_dsp,',
'     :p78_num_dias_parc1_dsp,',
'     v_flg_retorno,',
'     v_msg_retorno,',
'     nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A));',
'',
'if :p78_dt_saida_parc1 <> v_dt_saida_parc1 then',
':p78_dt_saida_parc1   := nvl(v_dt_saida_parc1, :p78_dt_saida_parc1);',
'end if;',
'',
'',
'if v_dt_retorno_parc1 is not null then',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1;',
'else',
':p78_dt_retorno_parc1   := v_dt_retorno_parc1_old;',
'end if;',
'',
'IF NVL(v_num_dias_parc1,0) = 0 THEN',
':p78_dt_retorno_parc1 := NULL;',
'END IF;',
'',
':p78_dias_descanso_adicional := nvl(v_dias_descanso_adicional, :p78_dias_descanso_adicional);',
':p78_desc_adicional1  := nvl(v_desc_adicional1, :p78_desc_adicional1);',
':p78_tipo_ferias1     := nvl(v_tipo_ferias1, :p78_tipo_ferias1);',
':p78_dias_abono_pec1  := nvl(NVL(v_dias_abono_pec1, nvl(:p78_dias_abono_pec1,0)),0);',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
' :P78_ok:= ''N'';',
' :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_num_dias_parc1''));',
'    else',
' :P78_ok:= ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_num_dias_parc1'')) OR v_item_validacao IS NULL then',
':P78_OK := ''S'';',
':P78_ITEM_VALIDACAO := null;',
'    else',
':P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_FIM_PER_FERIAS_1,P78_SALDO_1,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DT_RETORNO_PARC1,P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_DIAS_DIREITO_1,P78_IND_SITUACAO_PERIODO_A,P78_JORNADA_REDUZIDA,P78_ITEM_V'
||'ALIDACAO,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A'
,p_attribute_03=>'P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669399238108413791)
,p_event_id=>wwv_flow_api.id(89669398224023413781)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_SALDO'').value == $x(''P78_NUM_DIAS_PARC1'').value) {',
'',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = true;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;    ',
'    ',
'}else{',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = false;    ',
'          ',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669399549864413792)
,p_name=>'Valida_Num_Dias_Parc3'
,p_event_sequence=>238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC3'
,p_condition_element=>'P78_NUM_DIAS_PARC3'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669400145331413792)
,p_event_id=>wwv_flow_api.id(89669399549864413792)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Num_Dias_Parc3(:p78_num_dias_parc3,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_num_dias_parc3''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_num_dias_parc3'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC3,P78_ITEM_VALIDACAO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669400476725413792)
,p_name=>'Valida_Num_Dias_Parc2'
,p_event_sequence=>248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC2'
,p_condition_element=>'P78_NUM_DIAS_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669401028552413792)
,p_event_id=>wwv_flow_api.id(89669400476725413792)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Num_Dias_Parc2(:P78_cod_empresa,',
'                                 :P78_matricula,',
'                                 nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                                 nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                                 :P78_dt_saida_parc2,',
'                                 :P78_dt_inic_per_ferias,',
'                                 :P78_dt_fim_per_ferias,',
'                                 :P78_dias_descanso_adicional,',
'                                 :P78_dias_abono_pec2,',
'                                 :P78_tipo_ferias2,',
'                                 :P78_desc_adicional1,',
'                                 :P78_desc_adicional2,',
'                                 :P78_num_dias_parc2,',
'                                 :P78_dt_retorno_parc2,',
'                                 :P78_dias_direito,',
'                                 :p_usuario,',
'                                 v_flg_retorno,',
'                                 v_msg_retorno);',
' ',
'IF NVL(:P78_num_dias_parc2,0) = 0 THEN',
':p78_dt_retorno_parc2 := NULL;',
'END IF;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DT_SAIDA_PARC2,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DIAS_DESCANSO_ADICIONAL,P78_NUM_DIAS_PARC2,P78_ITEM_VALIDACAO,P78_DIAS_DIREITO,P78_DT_RETORNO_PARC4,P78_NUM_DIAS_'
||'PARC1_1,P78_DIAS_ABONO_PEC1_1,P_USUARIO'
,p_attribute_03=>'P78_TIPO_FERIAS2,P78_DESC_ADICIONAL1,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669401404149413807)
,p_name=>'Valida_Num_Dias_Parc4'
,p_event_sequence=>258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC4'
,p_condition_element=>'P78_NUM_DIAS_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669401923687413808)
,p_event_id=>wwv_flow_api.id(89669401404149413807)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3); ',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'pkg_ferias.Valida_Num_Dias_Parc4(:P78_cod_empresa,',
':P78_matricula,',
'nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1),',
':P78_num_dias_parc4,',
'nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1),',
'nvl(:P78_dt_saida_parc2,:P78_dt_saida_parc2_1),',
':P78_dt_saida_parc4,',
':P78_dt_inic_per_ferias,',
':P78_dt_fim_per_ferias,                            ',
':p78_saldo,',
':p78_ind_situacao_parc_2,',
':p78_dias_abono_pec4,                                    ',
':P78_dias_descanso_adicional,',
':P78_dias_abono_pec4,',
':P78_tipo_ferias4,',
':P78_desc_adicional1,',
':P78_desc_adicional2,',
':P78_desc_adicional4,',
':P78_dt_retorno_parc4,',
':P78_dias_direito,',
'v_flg_retorno,',
'v_msg_retorno,                    ',
':p_usuario);',
'',
'IF NVL(:P78_num_dias_parc4,0) = 0 THEN',
':p78_dt_retorno_parc4 := NULL;',
'END IF;',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC4,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DIAS_DESCANSO_ADICIONAL,P78_DIAS_ABO'
||'NO_PEC4,P78_TIPO_FERIAS4,P78_DESC_ADICIONAL1,P78_DESC_ADICIONAL2,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4,P78_DIAS_DIREITO,P78_ITEM_VALIDACAO,P78_NUM_DIAS_PARC1_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC1_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC2_1,P'
||'78_SALDO,P_USUARIO,P78_IND_SITUACAO_PARC_2'
,p_attribute_03=>'P78_DIAS_ABONO_PEC4,P78_TIPO_FERIAS4,P78_DESC_ADICIONAL2,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669402265281413808)
,p_name=>'Valida_Dias_Abono_Pec1'
,p_event_sequence=>268
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC1'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item(''P78_DIAS_ABONO_PEC1'').getValue() != '''' &&',
'apex.item(''P78_DT_SAIDA_PARC1'').getValue() != '''''))
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669402755812413808)
,p_event_id=>wwv_flow_api.id(89669402265281413808)
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
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'v_cod_empresa:= :p78_cod_empresa;',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := :p78_dt_inic_per_ferias;',
'v_dt_fim_per_ferias := :p78_dt_fim_per_ferias;',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := :p78_saldo_bruto;',
'v_falta_hora := :p78_falta_hora;',
'v_dias_direito := :p78_dias_direito;',
'v_dt_saida_parc1 := :p78_dt_saida_parc1;',
'v_saldo := :p78_saldo;',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := :p78_ind_situacao_periodo;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno);',
'',
'IF V_DT_RETORNO_PARC1 IS NOT NULL THEN',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1;',
'ELSE',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1_old;',
'END IF;',
'',
'if v_dt_pagto_parc1 is not null then',
'  :p78_dt_pagto_parc1 := v_dt_pagto_parc1;',
'end if;',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_FILIAL,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1,P78_DT_SAIDA_PARC1,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DIAS_DIREITO,P78_ITEM_VALIDACAO,P_USUARIO'
,p_attribute_03=>'P78_OPCAO_ABONO_PEC1,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669403322668413809)
,p_event_id=>wwv_flow_api.id(89669402265281413808)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'v_cod_empresa:= :p78_cod_empresa;',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := :p78_dt_inic_per_ferias;',
'v_dt_fim_per_ferias := :p78_dt_fim_per_ferias;',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := :p78_saldo_bruto;',
'v_falta_hora := :p78_falta_hora;',
'v_dias_direito := :p78_dias_direito;',
'v_dt_saida_parc1 := :p78_dt_saida_parc1;',
'v_saldo := :p78_saldo;',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := :p78_ind_situacao_periodo;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno);',
'',
'IF V_DT_RETORNO_PARC1 IS NOT NULL THEN',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1;',
'ELSE',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1_old;',
'END IF;',
'',
'if v_dt_pagto_parc1 is not null then',
'  :p78_dt_pagto_parc1 := v_dt_pagto_parc1;',
'end if;',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DT_SAIDA_PARC2,P78_SALDO_BRUTO,P78_FALTA_HORA,P78_DIAS_DIREITO,P78_DT_SAIDA_PARC1,P78_SALDO,P78_DIAS_ABONO_PEC1,P78_NUM_DIAS_PARC1,P78_OPCAO_13SAL1,P78'
||'_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_JORNADA_REDUZIDA,P78_IND_SITUACAO_PERIODO,P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC1'
,p_attribute_03=>'P78_DT_RETORNO_PARC1_X,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_DT_PAGTO_PARC1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669403662702413809)
,p_name=>'Valida_Dias_Abono_Pec1a'
,p_event_sequence=>278
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC1'
,p_condition_element=>'P78_DIAS_ABONO_PEC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669404159990413809)
,p_event_id=>wwv_flow_api.id(89669403662702413809)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'if :p78_dt_saida_parc1 is not null then',
'',
'pkg_ferias.Valida_Dias_Abono_Pec1(:p78_cod_empresa        ,',
'                                  :p78_matricula          ,',
'                                  :p78_filial             ,',
'                                  :p78_dt_inic_per_ferias_1 ,',
'                                  :p78_dt_fim_per_ferias_1  ,',
'                                  :p78_num_dias_parc1     ,',
'                                  :p78_dt_saida_parc1     ,',
'                                  :p78_saldo_1              ,',
'                                  :p78_dias_abono_pec1    ,',
'                                  :p78_opcao_abono_pec1   ,',
'                                  :p78_ind_situacao_periodo_a,',
'                                  :p78_dias_direito_1       ,',
'                                  :p_usuario,',
'                                  v_flg_retorno        ,',
'                                  v_msg_retorno        );',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dias_abono_pec1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_dias_abono_pec1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_FILIAL,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_NUM_DIAS_PARC1,P78_DT_SAIDA_PARC1,P78_SALDO_1,P78_IND_SITUACAO_PERIODO_A,P78_DIAS_DIREITO_1,P78_ITEM_VALIDACAO,P_USUARIO'
,p_attribute_03=>'P78_OPCAO_ABONO_PEC1,P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669404701606413809)
,p_event_id=>wwv_flow_api.id(89669403662702413809)
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
'v_cod_empresa number;',
'v_cod_solicitacao number;',
'v_matricula number;',
'v_dt_inic_per_ferias date;',
'v_dt_fim_per_ferias date;',
'v_dt_saida_parc2 date :=null;',
'v_saldo_bruto number;',
'v_falta_hora number;',
'v_dias_direito number;',
'v_dt_saida_parc1 date;',
'v_saldo number;',
'v_dias_abono_pec1 number;',
'v_num_dias_parc1 number;',
'v_opcao_13sal1 varchar2(1);',
'v_opcao_13sal2 varchar2(1);',
'v_tipo_ferias1 varchar2(1);',
'v_dt_retorno_parc1 date;',
'v_dt_retorno_parc1_old date;',
'v_dt_pagto_parc1 date;',
'v_jornada_reduzida varchar2(10);',
'v_ind_situacao_periodo varchar2(3);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'v_cod_empresa:= :p78_cod_empresa;',
'v_cod_solicitacao := :p78_cod_solicitacao;',
'v_matricula := :p78_matricula;',
'v_dt_inic_per_ferias := :p78_dt_inic_per_ferias_1;',
'v_dt_fim_per_ferias := :p78_dt_fim_per_ferias_1;',
'v_dt_saida_parc2 := :p78_dt_saida_parc2;',
'v_saldo_bruto := :p78_saldo_bruto_1;',
'v_falta_hora := :p78_falta_hora_1;',
'v_dias_direito := :p78_dias_direito_1;',
'v_dt_saida_parc1 := :p78_dt_saida_parc1;',
'v_saldo := :p78_saldo_1;',
'v_dias_abono_pec1 := :p78_dias_abono_pec1;',
'v_num_dias_parc1 := :p78_num_dias_parc1;',
'v_opcao_13sal1 := :p78_opcao_13sal1;',
'v_opcao_13sal2 := :p78_opcao_13sal2;',
'v_tipo_ferias1 := :p78_tipo_ferias1;',
'v_dt_retorno_parc1 := :p78_dt_retorno_parc1;',
'v_dt_retorno_parc1_old := :p78_dt_retorno_parc1;',
'v_dt_pagto_parc1 := :p78_dt_pagto_parc1;',
'v_jornada_reduzida := :p78_jornada_reduzida;',
'v_ind_situacao_periodo := :p78_ind_situacao_periodo_a;',
'',
'pkg_ferias.Valida_Dt_Saida_Parc1(v_cod_empresa,',
'v_cod_solicitacao,',
'v_matricula,',
'v_dt_inic_per_ferias,',
'v_dt_fim_per_ferias,',
'v_dt_saida_parc2,',
'v_saldo_bruto,',
'v_falta_hora,',
'v_dias_direito,',
'v_dt_saida_parc1,',
'v_saldo,',
'v_dias_abono_pec1,',
'v_num_dias_parc1,',
'v_opcao_13sal1,',
'v_opcao_13sal2,',
'v_tipo_ferias1,',
'v_dt_retorno_parc1,',
'v_dt_pagto_parc1,',
'v_jornada_reduzida,',
'v_ind_situacao_periodo,',
':p78_dias_abono_pec1_dsp,',
':p78_num_dias_parc1_dsp,',
'v_flg_retorno,',
'v_msg_retorno);',
'',
'IF V_DT_RETORNO_PARC1 IS NOT NULL THEN',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1;',
'ELSE',
':p78_dt_retorno_parc1_X := v_dt_retorno_parc1_old;',
'END IF;',
'',
'if v_dt_pagto_parc1 is not null then',
'  :p78_dt_pagto_parc1 := v_dt_pagto_parc1;',
'end if;',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_saida_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_saida_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_DT_SAIDA_PARC2,P78_SALDO_BRUTO_1,P78_FALTA_HORA_1,P78_DIAS_DIREITO_1,P78_DT_SAIDA_PARC1,P78_SALDO_1,P78_DIAS_ABONO_PEC1,P78_NUM_DIAS_PARC1,P78_OPCA'
||'O_13SAL1,P78_OPCAO_13SAL2,P78_TIPO_FERIAS1,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_JORNADA_REDUZIDA,P78_IND_SITUACAO_PERIODO_A,P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC1'
,p_attribute_03=>'P78_DT_RETORNO_PARC1_X,P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DIAS_ABONO_PEC1_DSP,P78_NUM_DIAS_PARC1_DSP,P78_DT_PAGTO_PARC1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669405112936413810)
,p_name=>'Valida_Abono_Pec2'
,p_event_sequence=>288
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC2'
,p_condition_element=>'P78_DIAS_ABONO_PEC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669405546204413810)
,p_event_id=>wwv_flow_api.id(89669405112936413810)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Abono_Pec2(:P78_cod_empresa,',
'                             :P78_matricula,',
'                             nvl(:P78_dt_inic_per_ferias,:P78_dt_inic_per_ferias_1),',
'                             nvl(:P78_dt_fim_per_ferias,:P78_dt_fim_per_ferias_1),',
'                             nvl(:P78_ind_situacao_periodo,:P78_ind_situacao_periodo_a),',
'                             nvl(:P78_dias_direito,:P78_dias_direito_1),',
'                              nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                              nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                             :P78_dt_saida_parc2,',
'                             :P78_num_dias_parc2,',
'                             :P78_desc_adicional2,',
'                             :P78_dias_abono_pec2,',
'                             :P78_opcao_abono_pec2,',
'                             :P78_dt_retorno_parc2,',
'                             v_flg_retorno,',
'                             v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_dias_abono_pec2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P78_dias_abono_pec2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DESC_ADICIONAL2,P78_DIAS_ABONO_PEC2,P78_ITEM_VALIDACAO,P78_IND_SITUACAO_PERIODO,P78_DIAS_DIREI'
||'TO,P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_IND_SITUACAO_PERIODO_A,P78_DIAS_DIREITO_1'
,p_attribute_03=>'P78_OPCAO_ABONO_PEC2,P78_DT_RETORNO_PARC2,P78_MENSAGEM,P78_OK,P78_FLAG,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669405979574413810)
,p_name=>'Valida_Abono_Pec4'
,p_event_sequence=>298
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC4'
,p_condition_element=>'P78_DIAS_ABONO_PEC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669406514872413810)
,p_event_id=>wwv_flow_api.id(89669405979574413810)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'pkg_ferias.Valida_Abono_Pec4(:P78_cod_empresa,',
'                             :P78_matricula,',
'                             :P78_dt_inic_per_ferias,',
'                             :P78_dt_fim_per_ferias,',
'                             :P78_ind_situacao_periodo,',
'                             :P78_dias_direito,',
'                             nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1),',
'                             nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1),',
'                             nvl(:P78_dt_saida_parc2,:P78_dt_saida_parc2_1),',
'                             nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1),',
'                             nvl(:P78_desc_adicional2,:P78_desc_adicional2_1),',
'                             nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1),',
'                             :P78_dt_saida_parc4,',
'                             :P78_num_dias_parc4,',
'                             :P78_desc_adicional4,',
'                             :P78_dias_abono_pec4,',
'                             :P78_opcao_abono_pec4,',
'                             :P78_dt_retorno_parc4,',
'                             v_flg_retorno,',
'                             v_msg_retorno);',
'',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_dias_abono_pec4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''P78_dias_abono_pec4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_IND_SITUACAO_PERIODO,P78_DIAS_DIREITO,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DESC_ADICIONAL2,P78_DIAS_ABONO_PEC2,P78_DT_SAIDA_PAR'
||'C4,P78_NUM_DIAS_PARC4,P78_DESC_ADICIONAL4,P78_DIAS_ABONO_PEC4,P78_OPCAO_ABONO_PEC4,P78_DT_RETORNO_PARC4,P78_ITEM_VALIDACAO,P78_NUM_DIAS_PARC1_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC1_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC2_1,P78_DESC_ADICIONAL2_'
||'1,P78_DIAS_ABONO_PEC2_1'
,p_attribute_03=>'P78_OPCAO_ABONO_PEC4,P78_DT_RETORNO_PARC4,P78_MENSAGEM,P78_OK,P78_FLAG,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669406905972413992)
,p_name=>'Valida_Tipo_Ferias1'
,p_event_sequence=>308
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_TIPO_FERIAS1'
,p_condition_element=>'P78_TIPO_FERIAS1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669407281242413992)
,p_event_id=>wwv_flow_api.id(89669406905972413992)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'if :p78_matricula is not null then',
'',
':p78_mensagem := null;',
'',
'if :p78_cod_empresa is not null and',
':p78_matricula is not null and ',
'nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1) is not null and',
'nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1) is not null and ',
':p78_data_ref is not null and ',
':p78_tipo_ferias1 is not null and ',
'nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a) is not null then -- Igor 14/04',
'',
'pkg_ferias.Valida_Tipo_Ferias1(:p78_cod_empresa        ,',
'                                  :p78_matricula          ,',
'                                  nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1) ,',
'                                  nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1)  ,',
'                                  :p78_data_ref,',
'                                  :p78_tipo_ferias1,',
'                                  nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                                  v_flg_retorno        ,',
'                                  v_msg_retorno        );',
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_tipo_ferias1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_tipo_ferias1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_FILIAL,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1,P78_DT_SAIDA_PARC1,P78_SALDO,P78_OK,P78_ITEM_VALIDACAO,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1,P78_IND_SITUACAO_PERIODO_A'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669407726640413993)
,p_name=>'Valida_Opcao_13Sal1'
,p_event_sequence=>318
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_13SAL1'
,p_condition_element=>'P78_OPCAO_13SAL1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669408233690413993)
,p_event_id=>wwv_flow_api.id(89669407726640413993)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
'IF nvl(:p78_opcao_13sal1, ''N'') = ''S'' AND',
'   :p78_dt_saida_parc1 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
'',
' :p78_mensagem := null;',
'',
'pkg_ferias.Valida_Opcao_13Sal1(:p78_cod_empresa,',
'                               :p78_matricula,',
'                               :p78_dt_saida_parc1,',
'                               :p78_dt_retorno_parc1,',
'                               :p78_opcao_13sal1,',
'                               :p78_ind_situacao_periodo,',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_opcao_13sal1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_opcao_13sal1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_DT_RETORNO_PARC1,P78_OPCAO_13SAL1,P78_IND_SITUACAO_PERIODO,P78_OK,P78_ITEM_VALIDACAO,P78_FLAG_CTRL,P78_COD_SOLICITACAO,P78_COD_REQ'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669408571407413998)
,p_name=>'Valida_Opcao_13Sal2'
,p_event_sequence=>328
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_13SAL2'
,p_condition_element=>'P78_OPCAO_13SAL2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669409067354413998)
,p_event_id=>wwv_flow_api.id(89669408571407413998)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'IF nvl(:p78_opcao_13sal2, ''N'') = ''S'' AND',
'   nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1) IS NOT NULL AND',
'   :p78_dt_saida_parc2 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
'',
'pkg_ferias.Valida_Opcao_13Sal2(:p78_cod_empresa,',
'                               :p78_matricula,',
'                               nvl(:p78_opcao_13sal1,:p78_opcao_13sal1_1),',
'                               nvl(:P78_DT_SAIDA_PARC1,:P78_DT_SAIDA_PARC1_1),',
'                               :p78_opcao_13sal2,',
'                               :p78_dt_saida_parc2,',
'                               :p78_dt_retorno_parc2,',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_opcao_13sal2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_opcao_13sal2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_DT_SAIDA_PARC1,P78_DT_RETORNO_PARC2,P78_OPCAO_13SAL1,P78_OPCAO_13SAL2,P78_DT_SAIDA_PARC2,P78_OK,P78_ITEM_VALIDACAO,P78_OPCAO_13SAL1_1,P78_DT_SAIDA_PARC1_1,P78_FLAG_CTRL,P78_COD_SOLICITACAO,P78_COD_REQ'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669409543068413998)
,p_name=>'Valida_Opcao_13Sal4'
,p_event_sequence=>338
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_13SAL4'
,p_condition_element=>'P78_OPCAO_13SAL4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669409965975413998)
,p_event_id=>wwv_flow_api.id(89669409543068413998)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'IF :p78_opcao_13sal4 IS NOT NULL AND ',
'   nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1) IS NOT NULL AND',
'   nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1) IS NOT NULL AND',
'   :p78_dt_saida_parc4 IS NOT NULL THEN -- Bruno Sousa 30/12/2024',
' ',
'pkg_ferias.Valida_Opcao_13Sal4(:p78_cod_empresa,',
'                               :p78_matricula,',
'                               :p78_opcao_13sal1,',
'                               nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                               nvl(:p78_opcao_13sal2,:p78_opcao_13sal2_1),',
'                               nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                               :p78_dt_retorno_parc2,',
'                               :p78_opcao_13sal4,',
'                               :p78_dt_saida_parc4,',
'                               :p78_dt_retorno_parc4,',
'                               NVL(:P78_COD_REQ,:P78_COD_SOLICITACAO),',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_opcao_13sal4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_opcao_13sal4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'END IF;',
' ',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_COD_EMPRESA,P78_MATRICULA,P78_OPCAO_13SAL1,P78_DT_SAIDA_PARC1,P78_OPCAO_13SAL2,P78_DT_SAIDA_PARC2,P78_DT_RETORNO_PARC2,P78_OPCAO_13SAL4,P78_DT_SAIDA_PARC4,P78_DT_RETORNO_PARC4,P78_DT_SAIDA_PARC1_1,P78_OPCAO_13SAL2_1,P78_DT_SAID'
||'A_PARC2_1,P78_FLAG_CTRL,P78_COD_SOLICITACAO,P78_COD_REQ'
,p_attribute_03=>'P78_ITEM_VALIDACAO,P78_OK,P78_FLAG,P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669410372525413999)
,p_name=>'Valida_Desc_Adicional1'
,p_event_sequence=>348
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DESC_ADICIONAL1'
,p_condition_element=>'P78_DESC_ADICIONAL1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669410920734413999)
,p_event_id=>wwv_flow_api.id(89669410372525413999)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'begin',
'',
' ',
'',
'    :p78_mensagem := null;',
'',
'    pkg_ferias.Valida_Desc_Adicional1(:p78_desc_adicional1,',
'                                      :p78_dias_descanso_adicional,',
'                                      :p78_ind_situacao_periodo,',
'                                    v_flg_retorno,',
'                                    v_msg_retorno);',
'',
'     if trim(v_msg_retorno) is not null then',
'',
'        if v_flg_retorno in (''N'',''Q'') then',
'            :P78_ok       := ''N'';',
'            :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_desc_adicional1''));',
'        else',
'            :P78_ok       := ''S'';',
'        end if;',
'',
'        :P78_flag     := v_flg_retorno;',
'        :P78_mensagem := v_msg_retorno;',
'     else',
'        :P78_flag     := null;',
'        :P78_mensagem := null;',
'        if v_item_validacao = TRIM(UPPER(''p78_desc_adicional1'')) OR v_item_validacao IS NULL then',
'           :P78_OK := ''S'';',
'           :P78_ITEM_VALIDACAO := null;',
'        else',
'           :P78_ITEM_VALIDACAO := v_item_validacao;',
'        end if;',
'     end if;',
' ',
'end;'))
,p_attribute_02=>'P78_DESC_ADICIONAL1,P78_DIAS_DESCANSO_ADICIONAL,P78_IND_SITUACAO_PERIODO,P78_ITEM_VALIDACAO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669411266021413999)
,p_name=>'Valida_Desc_Adicional2'
,p_event_sequence=>358
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DESC_ADICIONAL2'
,p_condition_element=>'P78_DESC_ADICIONAL2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669411776182413999)
,p_event_id=>wwv_flow_api.id(89669411266021413999)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'pkg_ferias.Valida_Desc_Adicional2(:p78_dias_descanso_adicional,',
'                                  :p78_desc_adicional1,',
'                                  :P78_dt_saida_parc2,',
'                                  :p78_num_dias_parc2,',
'                                  :p78_desc_adicional2,',
'                                  :p78_dt_retorno_parc2,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_desc_adicional2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_desc_adicional2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_DESC_ADICIONAL1,P78_DIAS_DESCANSO_ADICIONAL,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_ITEM_VALIDACAO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_DT_RETORNO_PARC2,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669412223444414008)
,p_name=>'Valida_Desc_Adicional4'
,p_event_sequence=>368
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DESC_ADICIONAL4'
,p_condition_element=>'P78_DESC_ADICIONAL4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669412682234414009)
,p_event_id=>wwv_flow_api.id(89669412223444414008)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'pkg_ferias.Valida_Desc_Adicional4(:p78_dias_descanso_adicional,',
'                                  nvl(:p78_desc_adicional1,:p78_desc_adicional1_1),',
'                                  nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                                  nvl(:p78_num_dias_parc2,:p78_num_dias_parc2_1),',
'                                  nvl(:p78_desc_adicional2,:p78_desc_adicional2_1),',
'                                  :p78_dt_saida_parc4,',
'                                  :p78_num_dias_parc4,',
'                                  :p78_desc_adicional4,',
'                                  :p78_dt_retorno_parc4,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_desc_adicional4''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_desc_adicional4'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_DIAS_DESCANSO_ADICIONAL,P78_DESC_ADICIONAL1,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DESC_ADICIONAL2,P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4,P78_DESC_ADICIONAL4,P78_DT_RETORNO_PARC4,P78_ITEM_VALIDACAO,P78_DESC_ADICIONAL1_1,P78_DT_SAIDA_PARC2_1,P78'
||'_NUM_DIAS_PARC2_1,P78_DESC_ADICIONAL2_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_DT_RETORNO_PARC4,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669413087249414009)
,p_name=>unistr('Pesquisa: Mostra Regi\00F5es')
,p_event_sequence=>378
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_COD_SOLICITACAO'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669413603747414009)
,p_event_id=>wwv_flow_api.id(89669413087249414009)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272262357542516568)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669414053699414009)
,p_event_id=>wwv_flow_api.id(89669413087249414009)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272271151975516577)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669414578803414010)
,p_event_id=>wwv_flow_api.id(89669413087249414009)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669415088985414012)
,p_event_id=>wwv_flow_api.id(89669413087249414009)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272282369576516589)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669415447061414012)
,p_name=>'Popula Campos 3'
,p_event_sequence=>388
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_COD_EMPRESA'
,p_condition_element=>'P78_COD_EMPRESA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669416030594414012)
,p_event_id=>wwv_flow_api.id(89669415447061414012)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'',
'SELECT PAR.DT_REF_FOLHA, NVL(EMP.IND_DUPLO_VINCULO,''N'')',
'	INTO :P78_DATA_REF, :P78_IND_DUPLO_VINCULO',
'	FROM EMPRESAS EMP, PARAMETROS_RECURSOS_HUMANOS PAR',
'  WHERE PAR.COD_EMPRESA = :P78_COD_EMPRESA',
'  AND PAR.COD_EMPRESA = EMP.COD;',
'  ',
'END;'))
,p_attribute_02=>'P78_COD_EMPRESA'
,p_attribute_03=>'P78_DATA_REF,P78_IND_DUPLO_VINCULO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669416400957414012)
,p_name=>'Aprovar'
,p_event_sequence=>398
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669320313803413690)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669416873640414012)
,p_event_id=>wwv_flow_api.id(89669416400957414012)
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
'begin',
'',
'IF nvl(:P78_OK,''S'') = ''S'' THEN',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_ferias',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_solicitacao = :p78_cod_solicitacao ',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'',
'        end;',
'    ELSE',
'        begin',
'         update aprova_ferias',
'            set status_aprov = ''A'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_solicitacao = :p78_cod_solicitacao ',
'            and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'    PKG_FERIAS.Post_Update(:P78_cod_empresa          ,',
'                           :P78_cod_solicitacao      ,',
'                          V_flg_retorno             ,',
'                          V_msg_retorno             );',
'     ',
'     commit;',
'     ',
'     if v_msg_retorno is not null then',
'        :p78_ok       := ''N'';',
'        :p78_flag     := v_flg_retorno;',
'        :p78_mensagem := v_msg_retorno;',
'     else',
'        :p78_flag     := null;',
'        :p78_mensagem := null;',
'        :p78_ok       := ''S'';',
'     end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,,P_EMPRESA_USER,P_MATRICULA_USER,P78_OK,P_USUARIO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669417361547414012)
,p_event_id=>wwv_flow_api.id(89669416400957414012)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669417748942414013)
,p_name=>'Reprovar'
,p_event_sequence=>408
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669321143989413691)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P78_OK = ''S'' THEN',
'RETURN TRUE;',
'ELSE',
'RETURN FALSE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669418279931414019)
,p_event_id=>wwv_flow_api.id(89669417748942414013)
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
'IF nvl(:P78_OK,''S'') = ''S'' THEN',
'',
'    IF :p_perfil not in (''REMUNERACAO'',''BUSINESS PARTNER'',''CONT DE NEGOCIOS'') THEN',
'        begin',
'         update aprova_ferias',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_solicitacao = :p78_cod_solicitacao ',
'            and cod_emp_aprov = :P_EMPRESA_USER',
'            and mat_aprov = :P_MATRICULA_USER;',
'',
'        commit;',
'',
'        end;',
'    ELSE',
'        begin',
'         update aprova_ferias',
'            set status_aprov = ''R'', usuario = :p_usuario, dt_atualizacao = sysdate, dt_aprov = sysdate',
'          where cod_solicitacao = :p78_cod_solicitacao ',
'            and (cod_emp_aprov, mat_aprov) in (select U.cd_empresa, U.cd_matricula from usuario_oracle U where U.cd_Perfil = :p_Perfil);',
'',
'        commit;',
'',
'        end;',
'    END IF;',
'',
'    PKG_FERIAS.Post_Update(:P78_cod_empresa          ,',
'                           :P78_cod_solicitacao      ,',
'                          V_flg_retorno             ,',
'                          V_msg_retorno             );',
'     ',
'     commit;',
'     ',
'     if v_msg_retorno is not null then',
'        :p78_ok       := ''N'';',
'        :p78_flag     := v_flg_retorno;',
'        :p78_mensagem := v_msg_retorno;',
'     else',
'        :p78_flag     := null;',
'        :p78_mensagem := null;',
'        :p78_ok       := ''S'';',
'     end if;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,,P_EMPRESA_USER,P_MATRICULA_USER,P78_OK,P_USUARIO'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669418812804414024)
,p_event_id=>wwv_flow_api.id(89669417748942414013)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669419242764414024)
,p_name=>'Valida_Sit_Req'
,p_event_sequence=>418
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_SIT_REQUISICAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669419698531414025)
,p_event_id=>wwv_flow_api.id(89669419242764414024)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'pkg_ferias.Valida_Sit_Requisicao(:p78_cod_empresa, :p78_cod_solicitacao, :p78_matricula, :p78_sit_requisicao, :p_usuario, v_flg_retorno, v_msg_retorno);',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_sit_requisicao''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    :P78_DT_SIT_SOLICITACAO := sysdate;',
'    if v_item_validacao = TRIM(UPPER(''p78_sit_requisicao'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_COD_SOLICITACAO,P78_MATRICULA,P78_SIT_REQUISICAO,P78_ITEM_VALIDACAO,P_USUARIO'
,p_attribute_03=>'P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_DT_SIT_SOLICITACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669420094417414025)
,p_name=>unistr('Mostra Bonus F\00E9rias')
,p_event_sequence=>428
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_FILIAL'
,p_condition_element=>'P78_FILIAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return true;',
'    else ',
'    return false;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669420556192414025)
,p_event_id=>wwv_flow_api.id(89669420094417414025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DESC_ADICIONAL1,P78_DESC_ADICIONAL2'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669420998166414025)
,p_name=>unistr('Esconde Bonus F\00E9rias')
,p_event_sequence=>438
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_FILIAL'
,p_condition_element=>'P78_FILIAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'    cursor c1 is',
'    select abono_ferias bonus_ferias',
'      from ferias_parametros',
'     where cod_empresa = :p78_cod_empresa',
'       and cod_filial = :p78_filial;',
'       ',
'    v_c1 c1%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'    ',
'    if v_c1.bonus_ferias > 0 then',
'    return false;',
'    else ',
'    return true;',
'    end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669421537879414026)
,p_event_id=>wwv_flow_api.id(89669420998166414025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DESC_ADICIONAL1,P78_DESC_ADICIONAL2'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669421859484414030)
,p_name=>'Popular: dt_inic_per_ferias_1'
,p_event_sequence=>448
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_INIC_PER_FERIAS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669422387042414030)
,p_event_id=>wwv_flow_api.id(89669421859484414030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_INIC_PER_FERIAS_1 := :P78_DT_INIC_PER_FERIAS;'
,p_attribute_02=>'P78_DT_INIC_PER_FERIAS'
,p_attribute_03=>'P78_DT_INIC_PER_FERIAS_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669422838711414030)
,p_name=>'Popular: dt_fim_per_ferias_1'
,p_event_sequence=>458
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_FIM_PER_FERIAS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669423267705414030)
,p_event_id=>wwv_flow_api.id(89669422838711414030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_FIM_PER_FERIAS_1 := :P78_DT_FIM_PER_FERIAS;'
,p_attribute_02=>'P78_DT_FIM_PER_FERIAS'
,p_attribute_03=>'P78_DT_FIM_PER_FERIAS_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669423708472414030)
,p_name=>'Popular: P78_IND_SITUACAO_PERIODO_1'
,p_event_sequence=>468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_IND_SITUACAO_PERIODO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669424179266414032)
,p_event_id=>wwv_flow_api.id(89669423708472414030)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_IND_SITUACAO_PERIODO = ''P'' then',
'   :P78_IND_SITUACAO_PERIODO_1 := ''Pendente'';',
'elsif :P78_IND_SITUACAO_PERIODO = ''G'' then',
'   :P78_IND_SITUACAO_PERIODO_1 := ''Gozado'';',
'elsif :P78_IND_SITUACAO_PERIODO = ''Q'' then',
'   :P78_IND_SITUACAO_PERIODO_1 := ''Quitado'';',
'elsif :P78_IND_SITUACAO_PERIODO = ''R'' then',
'   :P78_IND_SITUACAO_PERIODO_1 := ''Parcial'';',
'elsif :P78_IND_SITUACAO_PERIODO = ''C'' then',
'   :P78_IND_SITUACAO_PERIODO_1 := ''Cancelado'';',
'end if;'))
,p_attribute_02=>'P78_IND_SITUACAO_PERIODO'
,p_attribute_03=>'P78_IND_SITUACAO_PERIODO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669424596798414032)
,p_name=>'Popular: P78_JORNADA_REDUZIDA_1'
,p_event_sequence=>478
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_JORNADA_REDUZIDA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669425073008414032)
,p_event_id=>wwv_flow_api.id(89669424596798414032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_JORNADA_REDUZIDA = ''S'' then',
':P78_JORNADA_REDUZIDA_1 := ''Sim'';',
'else',
unistr(':P78_JORNADA_REDUZIDA_1 := ''N\00E3o'';'),
'end if;'))
,p_attribute_02=>'P78_JORNADA_REDUZIDA'
,p_attribute_03=>'P78_JORNADA_REDUZIDA_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669425523807414032)
,p_name=>'Popular: P78_FALTA_HORA_1'
,p_event_sequence=>488
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_FALTA_HORA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669425984319414032)
,p_event_id=>wwv_flow_api.id(89669425523807414032)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_FALTA_HORA_1 := :P78_FALTA_HORA;'
,p_attribute_02=>'P78_FALTA_HORA'
,p_attribute_03=>'P78_FALTA_HORA_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669426354759414033)
,p_name=>'Popular: P78_FALTA_MINUTO_1'
,p_event_sequence=>498
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_FALTA_MINUTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669426881634414033)
,p_event_id=>wwv_flow_api.id(89669426354759414033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_FALTA_MINUTO_1 := :P78_FALTA_MINUTO;'
,p_attribute_02=>'P78_FALTA_MINUTO'
,p_attribute_03=>'P78_FALTA_MINUTO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669427274797414033)
,p_name=>'Popular: P78_DIAS_DIREITO_1'
,p_event_sequence=>508
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_DIREITO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669427761100414033)
,p_event_id=>wwv_flow_api.id(89669427274797414033)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_dias_number number;',
'    v_dias_char varchar2(10) := :P78_DIAS_DIREITO; -- Igor 30/03',
'begin',
'',
'    if instr(v_dias_char,''.'') > 0 then',
'       v_dias_number := replace(v_dias_char,''.'','','');',
'       :P78_DIAS_DIREITO_1 := v_dias_number;',
'    else',
'       :P78_DIAS_DIREITO_1 := :P78_DIAS_DIREITO;',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P78_DIAS_DIREITO'
,p_attribute_03=>'P78_DIAS_DIREITO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669428163233414033)
,p_name=>'Popular: P78_DIAS_DESCANSO_ADICIONAL_1'
,p_event_sequence=>518
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_DESCANSO_ADICIONAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669428729014414033)
,p_event_id=>wwv_flow_api.id(89669428163233414033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DIAS_DESCANSO_ADICIONAL_1 := :P78_DIAS_DESCANSO_ADICIONAL;'
,p_attribute_02=>'P78_DIAS_DESCANSO_ADICIONAL'
,p_attribute_03=>'P78_DIAS_DESCANSO_ADICIONAL_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669429080647414033)
,p_name=>'Popular: P78_SALDO_BRUTO_1'
,p_event_sequence=>528
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_SALDO_BRUTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669429547120414034)
,p_event_id=>wwv_flow_api.id(89669429080647414033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_SALDO_BRUTO_1 := :P78_SALDO_BRUTO;'
,p_attribute_02=>'P78_SALDO_BRUTO'
,p_attribute_03=>'P78_SALDO_BRUTO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669430039607414034)
,p_name=>'Popular: P78_SALDO_1'
,p_event_sequence=>538
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_SALDO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669430449382414034)
,p_event_id=>wwv_flow_api.id(89669430039607414034)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_SALDO_1 := :P78_SALDO;'
,p_attribute_02=>'P78_SALDO'
,p_attribute_03=>'P78_SALDO_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669430890072414034)
,p_name=>'Disable Parcela 1 Sit R'
,p_event_sequence=>548
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_IND_SITUACAO_PERIODO'
,p_condition_element=>'P78_IND_SITUACAO_PERIODO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'R'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669431401510414034)
,p_event_id=>wwv_flow_api.id(89669430890072414034)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669431932319414034)
,p_event_id=>wwv_flow_api.id(89669430890072414034)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669432345910414034)
,p_name=>'Pesquisa: Hide Parcela 2'
,p_event_sequence=>558
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669432817666414035)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669433286490414035)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669433818474414035)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669434307886414035)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669434801746414037)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669435158791414037)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669435708235414037)
,p_event_id=>wwv_flow_api.id(89669432345910414034)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669436122230414037)
,p_name=>'Pesquisa: Hide Parcela Coletiva'
,p_event_sequence=>568
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'   if :P78_ROWID is not null and :P78_DT_SAIDA_PARC3 IS     NULL THEN',
'      RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669436644696414037)
,p_event_id=>wwv_flow_api.id(89669436122230414037)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669436990262414037)
,p_name=>unistr('Cria\00E7\00E3o: Hide Parcela 1 (Pesquisa)')
,p_event_sequence=>578
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_COD_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669437525032414037)
,p_event_id=>wwv_flow_api.id(89669436990262414037)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669438001583414038)
,p_event_id=>wwv_flow_api.id(89669436990262414037)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669438441124414038)
,p_name=>'Pesquisa: Show Parcela 2'
,p_event_sequence=>588
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P78_ROWID is not null and :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'      RETURN TRUE;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669438914847414038)
,p_event_id=>wwv_flow_api.id(89669438441124414038)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669439436422414038)
,p_event_id=>wwv_flow_api.id(89669438441124414038)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669439901442414038)
,p_event_id=>wwv_flow_api.id(89669438441124414038)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669440265600414038)
,p_name=>'Valida_Update_Rf'
,p_event_sequence=>598
,p_bind_type=>'bind'
,p_bind_event_type=>'apexbeforepagesubmit'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'SAVE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669440839192414039)
,p_event_id=>wwv_flow_api.id(89669440265600414038)
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
'PKG_FERIAS.Valida_Update_Rf(:P78_cod_empresa,',
'                            :P78_filial,',
'                            nvl(:P78_dt_saida_parc1,:p78_dt_saida_parc1_1),',
'                            :P78_dt_fim_per_ferias,',
'                            :P78_num_dias_parc1,',
'                            :P78_dias_abono_pec1,',
'                            :P78_saldo,',
'                            :p78_matricula,',
'                            :p78_jornada_reduzida,',
'                            V_flg_retorno,',
'                            V_msg_retorno);',
'',
' ',
' if v_msg_retorno is not null then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_FILIAL,P78_DT_SAIDA_PARC1,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_SALDO,P78_MATRICULA,P78_JORNADA_REDUZIDA'
,p_attribute_03=>'P78_OK,P78_MENSAGEM,P78_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669441245407414039)
,p_name=>'Hide Region'
,p_event_sequence=>608
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_COD_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669441725761414039)
,p_event_id=>wwv_flow_api.id(89669441245407414039)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272262357542516568)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669442149892414039)
,p_event_id=>wwv_flow_api.id(89669441245407414039)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272282369576516589)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669442738246414039)
,p_event_id=>wwv_flow_api.id(89669441245407414039)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669443737949414044)
,p_event_id=>wwv_flow_api.id(89669441245407414039)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272271151975516577)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669443166521414039)
,p_event_id=>wwv_flow_api.id(89669441245407414039)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272274750104516580)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669444085015414044)
,p_name=>unistr('(Page Load) Cria\00E7\00E3o: Mostra Regi\00F5es')
,p_event_sequence=>618
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669444612167414044)
,p_event_id=>wwv_flow_api.id(89669444085015414044)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669445097434414044)
,p_event_id=>wwv_flow_api.id(89669444085015414044)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272282369576516589)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669445536179414044)
,p_name=>'OK: Show Create'
,p_event_sequence=>628
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_ITEM_VALIDACAO'
,p_condition_element=>'P78_ITEM_VALIDACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669445971442414048)
,p_event_id=>wwv_flow_api.id(89669445536179414044)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669446466668414048)
,p_event_id=>wwv_flow_api.id(89669445536179414044)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669446850620414049)
,p_name=>'OK: Show Create_1'
,p_event_sequence=>638
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_ITEM_VALIDACAO'
,p_condition_element=>'P78_ITEM_VALIDACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'P78_CREATE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669447376701414049)
,p_event_id=>wwv_flow_api.id(89669446850620414049)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669447779800414049)
,p_name=>unistr('(Cria\00E7\00E3o) Matricula: Popula_Campos 1_1')
,p_event_sequence=>648
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*if :P78_ROWID is null and NVL(:P78_OK,''S'') = ''S'' and :p78_matricula is not null and 1 = 1 then',
'return true;',
'else',
'return false;',
'end if;',
'*/',
'return (:P78_ROWID is null and NVL(:P78_OK,''S'') = ''S'' and :p78_matricula is not null);'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669448307308414049)
,p_event_id=>wwv_flow_api.id(89669447779800414049)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'IF :P78_MATRICULA IS NOT NULL THEN',
':P78_MENSAGEM:=NULL;',
'pkg_Req_Ferias.pg78_load1(p_P78_COD_EMPRESA => :P78_COD_EMPRESA,',
'                            p_P78_MATRICULA => :P78_MATRICULA,',
'                            p_P78_COD_SOLICITACAO => :P78_COD_SOLICITACAO,',
'                            p_P78_DIAS_DESCANSO_ADICIONAL => :P78_DIAS_DESCANSO_ADICIONAL,',
'                            p_P78_SALDO_BRUTO => :P78_SALDO_BRUTO,',
'                            p_P78_SALDO => :P78_SALDO,',
'                            p_P78_IND_SITUACAO_PERIODO => :P78_IND_SITUACAO_PERIODO,',
'                            p_P78_DT_INIC_PER_FERIAS => :P78_DT_INIC_PER_FERIAS,',
'                            p_P78_DT_FIM_PER_FERIAS => :P78_DT_FIM_PER_FERIAS,',
'                            p_P78_DT_SAIDA_PARC1 => :P78_DT_SAIDA_PARC1,',
'                            p_P78_NUM_DIAS_PARC1 => :P78_NUM_DIAS_PARC1,',
'                            p_P78_DIAS_ABONO_PEC1 => :P78_DIAS_ABONO_PEC1,',
'                            p_P78_OPCAO_13SAL1 => :P78_OPCAO_13SAL1,',
'                            p_P78_DESC_ADICIONAL1 => :P78_DESC_ADICIONAL1,',
'                            p_P78_DT_RETORNO_PARC1 => :P78_DT_RETORNO_PARC1,',
'                            p_P78_TIPO_FERIAS1 => :P78_TIPO_FERIAS1,',
'                            p_P78_DT_SAIDA_PARC2 => :P78_DT_SAIDA_PARC2,',
'                            p_P78_NUM_DIAS_PARC2 => :P78_NUM_DIAS_PARC2,',
'                            p_P78_DIAS_ABONO_PEC2 => :P78_DIAS_ABONO_PEC2,',
'                            p_P78_OPCAO_13SAL2 => :P78_OPCAO_13SAL2,',
'                            p_P78_DESC_ADICIONAL2 => :P78_DESC_ADICIONAL2,',
'                            p_P78_DT_RETORNO_PARC2 => :P78_DT_RETORNO_PARC2,',
'                            p_P78_TIPO_FERIAS2 => :P78_TIPO_FERIAS2,',
'                            p_P78_DT_SAIDA_PARC4 => :P78_DT_SAIDA_PARC4,',
'                            p_P78_NUM_DIAS_PARC4 => :P78_NUM_DIAS_PARC4,',
'                            p_P78_DT_RETORNO_PARC4 => :P78_DT_RETORNO_PARC4,',
'                            p_P78_TIPO_FERIAS4 => :P78_TIPO_FERIAS4,',
'                            p_P78_DT_SOLICITACAO => :P78_DT_SOLICITACAO,',
'                            p_P78_FALTA_HORA => :P78_FALTA_HORA,',
'                            p_P78_FALTA_MINUTO => :P78_FALTA_MINUTO,',
'                            p_P78_OPCAO_ABONO_PEC1 => :P78_OPCAO_ABONO_PEC1,',
'                            p_P78_OPCAO_ABONO_PEC2 => :P78_OPCAO_ABONO_PEC2,',
'                            p_P78_DC_MATRICULA => :P78_DC_MATRICULA,',
'                            p_P78_FLAG => :P78_FLAG,',
'                            p_P78_OK => :P78_OK,',
'                            p_P78_MENSAGEM => :P78_MENSAGEM);',
'END IF;',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_ROWID,P78_COD_SOLICITACAO,P78_OK'
,p_attribute_03=>'P78_FLAG,P78_OK,P78_MENSAGEM,P78_DIAS_DESCANSO_ADICIONAL,P78_SALDO_BRUTO,P78_SALDO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P7'
||'8_DT_RETORNO_PARC1,P78_TIPO_FERIAS1,P78_DT_SAIDA_PARC2,P78_NUM_DIAS_PARC2,P78_DIAS_ABONO_PEC2,P78_OPCAO_13SAL2,P78_DESC_ADICIONAL2,P78_DT_RETORNO_PARC2,P78_TIPO_FERIAS2,P78_DT_SAIDA_PARC4,P78_NUM_DIAS_PARC4,P78_DT_RETORNO_PARC4,P78_TIPO_FERIAS4,P78_D'
||'T_SOLICITACAO,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_OPCAO_ABONO_PEC1,P78_OPCAO_ABONO_PEC2,P78_DC_MATRICULA'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669448654368414049)
,p_name=>'Matricula: Popula_Campos 2_1'
,p_event_sequence=>658
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_ROWID is null and NVL(:P78_OK,''S'') = ''S'' and :p78_matricula is not null and 1 = 1 then',
'return true;',
'else',
'return false;',
'end if;'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669449217751414050)
,p_event_id=>wwv_flow_api.id(89669448654368414049)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  flag number := Null;',
'  Cursor c_idade_colab Is',
'  select trunc(months_between(sysdate,i.DT_NASC)/12) as idade',
'  from inf_pessoais_cad i',
'  where i.MATRICULA=:p78_matricula and i.COD_EMPRESA=:p78_cod_empresa;',
'  v_idade_colab c_idade_colab%rowtype;',
'  Cursor c_idades Is',
'  select fer.IDADE_MAXIMA, fer.IDADE_MINIMA  ',
'  from ferias_parametros fer, inf_pessoais_cad inf',
'  where inf.cod_empresa = fer.cod_empresa and inf.cod_empresa = :P78_COD_EMPRESA and inf.matricula = :P78_matricula and inf.filial = fer.cod_filial;',
'  r_idades c_idades%RowType;',
'  cursor c1 is',
'     select nvl(a.pagto_abono_ferias, ''N'') abono_ferias, a.saldo_fer_min, c.dt_ref_folha, a.cod_filial, b.vinculo',
'       from filiais_cad a, informacoes_funcionais b, parametros_recursos_humanos c',
'     where  b.cod_empresa = a.cod_empresa and b.filial = a.cod_filial and b.cod_empresa = :P78_cod_empresa and b.matricula = :P78_matricula and c.cod_empresa  = b.cod_Empresa;',
'     v_c1 c1%rowtype;',
'v_data_ini date;',
'cursor c3 (v_filial number) is',
'select qtd_parcelas',
'  from ferias_Parametros',
' where cod_empresa=:P78_cod_empresa and cod_filial=v_filial;',
'v_c3 c3%rowtype;',
'v_dias_direito number;',
'v_saldo_bruto number :=:P78_SALDO_BRUTO; v_saldo number := :P78_SALDO;',
'begin',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'v_saldo_bruto := replace(v_saldo_bruto,'','',''.''); v_saldo := replace(v_saldo,'','',''.'');',
':P78_MENSAGEM := NULL;',
'If (:P78_matricula Is Not Null And :P78_num_dias_parc1 Is Null) Then',
'  Open c_idades;',
'  Fetch c_idades Into r_idades;',
'  Close c_idades;',
'  Open  c_idade_colab;',
'  Fetch c_idade_colab Into v_idade_colab;',
'  Close c_idade_colab;',
'  If (v_idade_colab.idade > r_idades.idade_maxima Or v_idade_colab.idade < r_idades.idade_minima) Then',
'      :P78_num_dias_parc1 := 30; :P78_dias_abono_pec1 := 0; :p78_num_dias_parc1_dsp  := ''N''; :p78_dias_abono_pec1_dsp := ''N'';',
'  Else',
'   if :p78_dt_saida_parc1 is not null then',
'    :P78_num_dias_parc1 := 0; :P78_dias_abono_pec1 := 0;',
'   else',
'    :P78_num_dias_parc1 := null;  :P78_dias_abono_pec1 := null; :p78_num_dias_parc1_dsp := ''S''; :p78_dias_abono_pec1_dsp := ''S'';',
'   end if;',
'  End If;',
'End If;',
'open  c1;',
'fetch c1 into v_c1;',
'close c1;',
':p78_filial := v_c1.cod_filial;',
' v_dias_direito := Pkg_Atlz_Saldo_Ferias./*fnc_Ret*/Dias_Direito(:P78_COD_EMPRESA,:P78_MATRICULA,:P78_DT_INIC_PER_FERIAS_1,:P78_DT_FIM_PER_FERIAS_1);',
' IF v_dias_direito IS NULL THEN',
' if NVL(:p78_jornada_reduzida,''N'') = ''N'' then',
'      v_dias_direito := (30 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0)); -- Humberto/Izidoro 29/09/2014',
' else',
'      v_dias_direito := (18 - nvl(trim(v_saldo_bruto),0)) + (nvl(trim(v_saldo),0)); -- Humberto/Izidoro 29/09/2014',
' end if;',
' v_dias_direito := f_jornada_reduzida(:p78_cod_empresa,:p78_matricula,v_dias_direito,null);',
' if :p78_falta_hora > 7 and :p78_jornada_reduzida = ''S'' then',
'      v_dias_direito := v_dias_direito / 2;',
' end if;',
' END IF;',
' :p78_DIAS_DIREITO := v_dias_direito;',
'    if :P78_matricula is not null then',
'    begin',
'       select distinct max(a.falta_hora), max(a.falta_minuto)',
'         into :P78_falta_hora, :P78_falta_minuto',
'         from ferias a',
'        where a.cod_empresa = :P78_COD_EMPRESA',
'          and a.matricula = :P78_matricula',
'          and a.dt_inic_per_ferias = ',
'(select min(dt_inic_per_ferias) v_data_ini',
'from ferias ',
'where cod_empresa = a.cod_empresa',
'and matricula = a.matricula',
'and (cod_solicitacao Is Null and dt_saida_parc1 is null and dt_saida_parc2 is null and dt_saida_parc4 is null)',
'and NOT EXISTS(SELECT 1',
'FROM REQUISICAO_FERIAS B',
'WHERE B.COD_EMPRESA = A.COD_EMPRESA',
'AND B.MATRICULA = A.MATRICULA',
'AND B.DT_INIC_PER_FERIAS = A.DT_INIC_PER_FERIAS',
'AND B.SIT_REQUISICAO not in (3,4,6))',
'and ind_situacao_periodo in (''P'',''R''));',
'    end;',
'    end if;',
'open  c3(v_c1.cod_filial);',
'fetch c3 into v_c3;',
'close c3;',
'if v_c1.vinculo <> ''E'' then',
':p78_qtd_parcelas := v_c3.qtd_parcelas;',
'else',
':p78_qtd_parcelas := 1;',
'end if;',
'--Matricula: Popula_Campos 2_1',
':P78_VINCULO := V_C1.VINCULO;',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_SALDO_BRUTO,P78_SALDO,P78_ROWID,P78_OK,P78_FALTA_HORA,P78_JORNADA_REDUZIDA,P78_DT_INIC_PER_FERIAS_1,P78_DT_FIM_PER_FERIAS_1'
,p_attribute_03=>'P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_DIAS_DIREITO,P78_FALTA_HORA,P78_FALTA_MINUTO,P78_FLAG,P78_OK,P78_MENSAGEM,P78_FILIAL,P78_QTD_PARCELAS,P78_NUM_DIAS_PARC1_DSP,P78_DIAS_ABONO_PEC1_DSP,P78_VINCULO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(85944771437190749374)
,p_name=>'Dispara Alerta_1'
,p_event_sequence=>668
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MSG_S'
,p_condition_element=>'P78_MSG_S'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(85944771507050749375)
,p_event_id=>wwv_flow_api.id(85944771437190749374)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'alert(apex.item(''P78_MSG_S'').getValue());',
'alertify.alert(apex.item(''P78_MSG_S'').getValue());',
''))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669450516078414050)
,p_name=>'Valida Campos em Branco'
,p_event_sequence=>688
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(200048229415060008081)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669450982463414051)
,p_event_id=>wwv_flow_api.id(89669450516078414050)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($v(''P78_DT_SAIDA_PARC1'').length == 0 && $v(''P78_DT_SAIDA_PARC1_1'').length == 0 && $x(''P78_PARCELAS_OPC'').value == 1 ){',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC1'').length == 0 ||',
'        $v(''P78_DT_SAIDA_PARC1_1'').length == 0 ||',
'        $v(''P78_NUM_DIAS_PARC1'').length == 0 ||',
'        $v(''P78_NUM_DIAS_PARC1_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 1\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}',
'',
'if ($v(''P78_DT_SAIDA_PARC2'').length == 0 && $v(''P78_DT_SAIDA_PARC2_1'').length == 0 && $x(''P78_PARCELAS_OPC'').value == 2 ){',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC1'').length == 0 &&',
'        $v(''P78_DT_SAIDA_PARC1_1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC1_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 1\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC2'').length == 0 &&',
'        $v(''P78_DT_SAIDA_PARC2_1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC2'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC2_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 2\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}',
'',
'if ($v(''P78_DT_SAIDA_PARC4'').length == 0 && $v(''P78_DT_SAIDA_PARC4_1'').length == 0 && $x(''P78_PARCELAS_OPC'').value == 3 ){',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC1'').length == 0 &&',
'        $v(''P78_DT_SAIDA_PARC1_1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC1_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 1\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC2'').length == 0 &&',
'        $v(''P78_DT_SAIDA_PARC2_1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC2'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC2_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 2\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }    ',
'    ',
'    if ($v(''P78_DT_SAIDA_PARC4'').length == 0 &&',
'        $v(''P78_DT_SAIDA_PARC4_1'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC4'').length == 0 &&',
'        $v(''P78_NUM_DIAS_PARC4_1'').length == 0',
'       ){',
'    ',
unistr('    alert(''Campos em Branco na 3\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}',
'',
'if ($v(''P78_DT_SAIDA_PARC1'').length != 0 && $v(''P78_DT_SAIDA_PARC1_1'').length == 0 ){',
'    ',
'    if ($v(''P78_NUM_DIAS_PARC1'').length == 0 ',
'       ){',
'    ',
unistr('    alert(''Preencha o n\00FAmero de dias da 1\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}',
'',
'if ($v(''P78_DT_SAIDA_PARC2'').length != 0 && $v(''P78_DT_SAIDA_PARC2_1'').length == 0 ){',
'    ',
'    if ($v(''P78_NUM_DIAS_PARC2'').length == 0 ',
'       ){',
'    ',
unistr('    alert(''Preencha o n\00FAmero de dias da 2\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}',
'',
'if ($v(''P78_DT_SAIDA_PARC4'').length != 0 && $v(''P78_DT_SAIDA_PARC4_1'').length == 0 ){',
'    ',
'    if ($v(''P78_NUM_DIAS_PARC4'').length == 0 ',
'       ){',
'    ',
unistr('    alert(''Preencha o n\00FAmero de dias da 3\00AA Parcela!'');'),
'    $x(''P78_ok'').value = ''N'';',
'    ',
'    }',
'    ',
'}'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669451502349414057)
,p_event_id=>wwv_flow_api.id(89669450516078414050)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669451919548414058)
,p_name=>'PRE-INSERT'
,p_event_sequence=>698
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(200048229415060008081)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669452442757414058)
,p_event_id=>wwv_flow_api.id(89669451919548414058)
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
'v_dias_abono_pec1 number := :P78_dias_abono_pec1;',
'',
'v_seq number;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
'PKG_FERIAS.Pre_Insert( :p78_cod_solicitacao,',
'                       :p78_cod_empresa,',
'                       :p78_filial,',
'                       :p78_matricula,',
'                       :p78_sit_requisicao,',
'                       :p78_ind_situacao_periodo,',
'                       :p78_dt_inic_per_ferias,',
'                       :p78_dt_fim_per_ferias,',
'                       :p78_num_dias_parc1,',
'                       :p78_saldo,',
'                       :p78_dt_saida_parc1,',
'                       :p78_dt_saida_parc2,',
'                       :p78_dt_saida_parc3,',
'                       :p78_dt_saida_parc4,',
'                       :p78_dt_retorno_parc1,',
'                       :p78_dt_retorno_parc2,',
'                       :p78_dt_retorno_parc3,',
'                       :p78_dt_retorno_parc4,',
'                       :p78_dias_abono_pec1,',
'                       :p78_jornada_reduzida,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
' ',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_create1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_create1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_COD_SOLICITACAO,P78_COD_EMPRESA,P78_FILIAL,P78_MATRICULA,P78_SIT_REQUISICAO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1,P78_SALDO,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC3,P78_DT_SAIDA_P'
||'ARC4,P78_DT_RETORNO_PARC1,P78_DT_RETORNO_PARC2,P78_DT_RETORNO_PARC3,P78_DT_RETORNO_PARC4,P78_DIAS_ABONO_PEC1,P78_JORNADA_REDUZIDA,P78_ITEM_VALIDACAO,P78_OK,P78_FLAG,P78_MENSAGEM'
,p_attribute_03=>'P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669452763985414058)
,p_name=>'VALIDA_UPDATE_RF'
,p_event_sequence=>708
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(200048229415060008081)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669453305214414058)
,p_event_id=>wwv_flow_api.id(89669452763985414058)
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
'v_dias_abono_pec1 number := :P78_dias_abono_pec1;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
'PKG_FERIAS.Valida_Update_Rf(:P78_cod_empresa,',
'                            :P78_filial,',
'                            :P78_dt_saida_parc1,',
'                            :P78_dt_fim_per_ferias,',
'                            :P78_num_dias_parc1,',
'                            v_dias_abono_pec1,',
'                            :P78_saldo,',
'                            :p78_matricula,',
'                            :p78_jornada_reduzida,',
'                            V_flg_retorno,',
'                            V_msg_retorno);',
'',
' ',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_save1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_save1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_DIAS_ABONO_PEC1,P78_ITEM_VALIDACAO,P_EMPRESA_USER,P_MATRICULA_USER,P78_USUARIO,P78_COD_SOLICITACAO,P78_COD_EMPRESA,P78_FILIAL,P78_MATRICULA,P78_SIT_REQUISICAO,P78_IND_SITUACAO_PERIODO,P78_DT_INIC_PER_FERIAS,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC'
||'1,P78_SALDO,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC3,P78_JORNADA_REDUZIDA'
,p_attribute_03=>'P78_FLAG,P78_MENSAGEM,P78_OK,P78_ITEM_VALIDACAO,P78_SIT_REQUISICAO,P78_COD_SOLICITACAO,P78_DT_SOLICITACAO,P78_DT_ATUALIZACAO_PROG,P78_USUARIO_PROG,P78_COD_EMP_SOLICITANTE,P78_MATRICULA_SOLICITANTE,P78_USUARIO,P78_DT_ATUALIZACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669453724101414062)
,p_name=>'Habilitar Campos (Save)'
,p_event_sequence=>718
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669312029245413680)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669454232937414062)
,p_event_id=>wwv_flow_api.id(89669453724101414062)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P78_NUM_DIAS_PARC1'').disabled = false;',
'$x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'$x(''P78_NUM_DIAS_PARC1_1'').disabled = false;',
'$x(''P78_DIAS_ABONO_PEC1_1'').disabled = false;',
'',
'$x(''P78_DT_RETORNO_PARC1'').disabled = false;',
'$x(''P78_DT_RETORNO_PARC2'').disabled = false;',
'$x(''P78_DT_RETORNO_PARC4'').disabled = false;',
'',
'$x(''P78_DT_SAIDA_PARC1_1'').disabled = false;',
'$x(''P78_DT_SAIDA_PARC2_1'').disabled = false;',
'$x(''P78_DT_SAIDA_PARC4_1'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669454723209414063)
,p_event_id=>wwv_flow_api.id(89669453724101414062)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_SAIDA_PARC1,P78_NUM_DIAS_PARC1,P78_DIAS_ABONO_PEC1,P78_OPCAO_13SAL1,P78_DESC_ADICIONAL1,P78_DT_RETORNO_PARC1,P78_DT_PAGTO_PARC1,P78_TIPO_FERIAS1,P78_OPCAO_ABONO_PEC1,P78_DT_RETORNO_PARC2,P78_DT_RETORNO_PARC4,P78_DT_SAIDA_PARC4,P78_DT_SAIDA_PAR'
||'C1_1,P78_DT_SAIDA_PARC2_1,P78_DT_SAIDA_PARC4_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(74762669256342012932)
,p_event_id=>wwv_flow_api.id(89669453724101414062)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_RETORNO_PARC1_1A := :P78_DT_RETORNO_PARC1_1;'
,p_attribute_02=>'P78_DT_RETORNO_PARC1_1'
,p_attribute_03=>'P78_DT_RETORNO_PARC1_1A'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669455147788414063)
,p_event_id=>wwv_flow_api.id(89669453724101414062)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'P78_CREATE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669455605546414063)
,p_name=>'Hab/Desab num_dias_parc1'
,p_event_sequence=>738
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_DSP'
,p_condition_element=>'P78_NUM_DIAS_PARC1_DSP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669456063771414063)
,p_event_id=>wwv_flow_api.id(89669455605546414063)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_NUM_DIAS_PARC1_DSP'').value == ''S'') {',
'    ',
'          $x(''P78_NUM_DIAS_PARC1'').disabled = false;',
'          $x(''P78_NUM_DIAS_PARC1_1'').disabled = false; ',
'',
'}else{',
'',
'          $x(''P78_NUM_DIAS_PARC1'').disabled = true;',
'          $x(''P78_NUM_DIAS_PARC1_1'').disabled = true;',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669456522523414063)
,p_name=>'Hab/Desab dias_abono_pec1'
,p_event_sequence=>748
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC1_DSP'
,p_condition_element=>'P78_DIAS_ABONO_PEC1_DSP'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669456984254414067)
,p_event_id=>wwv_flow_api.id(89669456522523414063)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_DIAS_ABONO_PEC1_DSP'').value == ''S'') {',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = false;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = false; ',
'',
'}else{',
'',
'          $x(''P78_DIAS_ABONO_PEC1'').disabled = true;',
'          $x(''P78_DIAS_ABONO_PEC1_1'').disabled = true;',
'',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669457422562414067)
,p_name=>'POPULA TESTE2'
,p_event_sequence=>758
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669457862401414067)
,p_event_id=>wwv_flow_api.id(89669457422562414067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_TESTE_2'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P78_DT_RETORNO_PARC1);'
,p_attribute_07=>'P78_DT_RETORNO_PARC1'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669458255751414067)
,p_name=>'Seta P78_DT_RETORNO_PARC1'
,p_event_sequence=>768
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669458809871414068)
,p_event_id=>wwv_flow_api.id(89669458255751414067)
,p_event_result=>'TRUE'
,p_action_sequence=>19
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_TESTE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P78_TESTE||'',(B) P78_DT_RETORNO_PARC1_X: ''||:P78_DT_RETORNO_PARC1_X);'
,p_attribute_07=>'P78_TESTE,P78_DT_RETORNO_PARC1_X'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669459325014414068)
,p_event_id=>wwv_flow_api.id(89669458255751414067)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_DT_RETORNO_PARC1_X'').value.length > 0 ) {  ',
'$x(''P78_DT_RETORNO_PARC1'').value = $x(''P78_DT_RETORNO_PARC1_X'').value;',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669459725131414068)
,p_name=>'Hide Empresa Matricula'
,p_event_sequence=>778
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669460234259414068)
,p_event_id=>wwv_flow_api.id(89669459725131414068)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_COD_EMPRESA,P78_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669460608370414068)
,p_name=>'(Pesquisa) Hide Empresa Matricula'
,p_event_sequence=>788
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669461088192414068)
,p_event_id=>wwv_flow_api.id(89669460608370414068)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_COD_EMPRESA,P78_MATRICULA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669461499234414068)
,p_name=>'Disable Fields Consult'
,p_event_sequence=>798
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_COD_SOLICITACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669462028194414069)
,p_event_id=>wwv_flow_api.id(89669461499234414068)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#PARCELA1 *'').prop(''disabled'',true);',
'$(''#2_PARCELA1 *'').prop(''disabled'',true);',
'$(''#PARCELA2 *'').prop(''disabled'',true);',
'$(''#2_PARCELA2 *'').prop(''disabled'',true);',
'$(''#PARCELA3 *'').prop(''disabled'',true);',
'$(''#2_PARCELA3 *'').prop(''disabled'',true);',
'$(''#PARCELA_COL *'').prop(''disabled'',true);',
'$(''#OPCAO *'').prop(''disabled'',true);'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669462426155414069)
,p_name=>'Mostrar Parcela 1'
,p_event_sequence=>808
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_QTD_PARCELAS'
,p_condition_element=>'P78_QTD_PARCELAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(:p78_ok,''S'') = ''S'' then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669462846341414069)
,p_event_id=>wwv_flow_api.id(89669462426155414069)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669463392480414069)
,p_event_id=>wwv_flow_api.id(89669462426155414069)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669463860550414069)
,p_event_id=>wwv_flow_api.id(89669462426155414069)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669464273710414069)
,p_name=>'Mostrar Parcela 2'
,p_event_sequence=>818
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_QTD_PARCELAS'
,p_condition_element=>'P78_QTD_PARCELAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(:p78_ok,''S'') = ''S'' then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669464837913414069)
,p_event_id=>wwv_flow_api.id(89669464273710414069)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669465290765414070)
,p_event_id=>wwv_flow_api.id(89669464273710414069)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669465809057414070)
,p_event_id=>wwv_flow_api.id(89669464273710414069)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669466219724414071)
,p_name=>'Mostrar Parcela 3'
,p_event_sequence=>828
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_QTD_PARCELAS'
,p_condition_element=>'P78_QTD_PARCELAS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'3'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if nvl(:p78_ok,''S'') = ''S'' then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669466691981414071)
,p_event_id=>wwv_flow_api.id(89669466219724414071)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669467177815414071)
,p_event_id=>wwv_flow_api.id(89669466219724414071)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669467652978414072)
,p_event_id=>wwv_flow_api.id(89669466219724414071)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669468055493414072)
,p_name=>unistr('Hide Data Atualiza\00E7\00E3o')
,p_event_sequence=>838
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669468630805414072)
,p_event_id=>wwv_flow_api.id(89669468055493414072)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DT_ATUALIZACAO_PROG'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669468990832414072)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>848
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P78_SIT_REQUISICAO'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669469509830414073)
,p_event_id=>wwv_flow_api.id(89669468990832414072)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669470021413414073)
,p_event_id=>wwv_flow_api.id(89669468990832414072)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669470400442414073)
,p_name=>'Valida Dias Direito < Dias Informados'
,p_event_sequence=>858
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669470851320414073)
,p_event_id=>wwv_flow_api.id(89669470400442414073)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'dt_saida_parc1 date := :p78_dt_saida_parc1; --nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1);',
'dt_saida_parc2 date := :p78_dt_saida_parc2; --nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1);',
'dt_saida_parc4 date := :p78_dt_saida_parc4; --nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1);',
'',
'num_dias_parc1 number := nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1);',
'num_dias_parc2 number := nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1);',
'num_dias_parc4 number := nvl(:P78_num_dias_parc4,:P78_num_dias_parc4_1);',
'',
'dias_abono_pec1 number := nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1);',
'dias_abono_pec2 number := nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1);',
'dias_abono_pec4 number := nvl(:P78_dias_abono_pec4,:P78_dias_abono_pec4_1);',
'',
'dias_direito number := :P78_dias_direito;',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is null and dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null and dt_saida'
||'_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
'    ',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_DIREITO,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC4,P78_QTD_PARCELAS,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC1_1,P7'
||'8_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC4,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_ABONO_PEC4_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669471290297414073)
,p_name=>'Valida Dias Direito < Dias Informados_1'
,p_event_sequence=>868
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669471839882414074)
,p_event_id=>wwv_flow_api.id(89669471290297414073)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'dt_saida_parc1 date := :p78_dt_saida_parc1; --nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1);',
'dt_saida_parc2 date := :p78_dt_saida_parc2; --nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1);',
'dt_saida_parc4 date := :p78_dt_saida_parc4; --nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1);',
'',
'num_dias_parc1 number := nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1);',
'num_dias_parc2 number := nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1);',
'num_dias_parc4 number := nvl(:P78_num_dias_parc4,:P78_num_dias_parc4_1);',
'',
'dias_abono_pec1 number := nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1);',
'dias_abono_pec2 number := nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1);',
'dias_abono_pec4 number := nvl(:P78_dias_abono_pec4,:P78_dias_abono_pec4_1);',
'',
'dias_direito number := :P78_dias_direito_1;',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is null and dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null and dt_saida'
||'_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
'    ',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_DIREITO_1,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC4,P78_QTD_PARCELAS,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC1_1,'
||'P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC4,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_ABONO_PEC4_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669472235191414075)
,p_name=>'Valida Dias Direito < Dias Informados_LST'
,p_event_sequence=>878
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669472657303414076)
,p_event_id=>wwv_flow_api.id(89669472235191414075)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'dt_saida_parc1 date := :p78_dt_saida_parc1; --nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1);',
'dt_saida_parc2 date := :p78_dt_saida_parc2; --nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1);',
'dt_saida_parc4 date := :p78_dt_saida_parc4; --nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1);',
'',
'num_dias_parc1 number := nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1);',
'num_dias_parc2 number := nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1);',
'num_dias_parc4 number := nvl(:P78_num_dias_parc4,:P78_num_dias_parc4_1);',
'',
'dias_abono_pec1 number := nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1);',
'dias_abono_pec2 number := nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1);',
'dias_abono_pec4 number := nvl(:P78_dias_abono_pec4,:P78_dias_abono_pec4_1);',
'',
'dias_direito number := :P78_dias_direito;',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is null and dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null and dt_saida'
||'_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
'    ',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_DIREITO,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC4,P78_QTD_PARCELAS,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC1_1,P7'
||'8_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC4,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_ABONO_PEC4_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669473142231414076)
,p_name=>'Valida Dias Direito < Dias Informados_LST_1'
,p_event_sequence=>888
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC1_LST'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669473568753414077)
,p_event_id=>wwv_flow_api.id(89669473142231414076)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'dt_saida_parc1 date := :p78_dt_saida_parc1; --nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1);',
'dt_saida_parc2 date := :p78_dt_saida_parc2; --nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1);',
'dt_saida_parc4 date := :p78_dt_saida_parc4; --nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1);',
'',
'num_dias_parc1 number := nvl(:P78_num_dias_parc1,:P78_num_dias_parc1_1);',
'num_dias_parc2 number := nvl(:P78_num_dias_parc2,:P78_num_dias_parc2_1);',
'num_dias_parc4 number := nvl(:P78_num_dias_parc4,:P78_num_dias_parc4_1);',
'',
'dias_abono_pec1 number := nvl(:P78_dias_abono_pec1,:P78_dias_abono_pec1_1);',
'dias_abono_pec2 number := nvl(:P78_dias_abono_pec2,:P78_dias_abono_pec2_1);',
'dias_abono_pec4 number := nvl(:P78_dias_abono_pec4,:P78_dias_abono_pec4_1);',
'',
'dias_direito number := :P78_dias_direito_1;',
'',
'begin',
'',
' if nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is null and dt_saida_parc4 is null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias da parcelas 1 est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1 e 2, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' elsif nvl(dias_direito,0) < (nvl(num_dias_parc1,0) + nvl(dias_abono_pec1,0) + nvl(num_dias_parc2,0) + nvl(dias_abono_pec2,0) + nvl(num_dias_parc4,0) + nvl(dias_abono_pec4,0)) and dt_saida_parc1 is not null and dt_saida_parc2 is not null and dt_saida'
||'_parc4 is not null then',
'    v_flg_retorno := ''N'';',
unistr('    v_msg_retorno := ''A soma dos dias das parcelas 1, 2 e 3, est\00E1 superior aos dias de direito de ''||dias_direito||'' dias. Informe uma quantidade diferente.'';'),
' end if;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''P78_num_dias_parc2''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    ',
'    if v_item_validacao = TRIM(UPPER(''P78_num_dias_parc2'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
'    ',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4,P78_DIAS_DIREITO_1,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC4,P78_QTD_PARCELAS,P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC1_1,'
||'P78_NUM_DIAS_PARC1_1,P78_DIAS_ABONO_PEC1_1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC2_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC2_1,P78_DT_SAIDA_PARC4,P78_DT_SAIDA_PARC4_1,P78_NUM_DIAS_PARC4_1,P78_DIAS_ABONO_PEC4_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669474037070414077)
,p_name=>unistr('Op\00E7\00E3o de Parcelas')
,p_event_sequence=>898
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_PARC_SN'
,p_condition_element=>'P78_OPCAO_PARC_SN'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669474456413414078)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669474946604414078)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669475512243414078)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669476004896414078)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669476520120414083)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669479023901414084)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669479533675414084)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1,P78_NUM_DIAS_PARC2,P78_NUM_DIAS_PARC4'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669477022472414083)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DIAS_ABONO_PEC1,P78_DIAS_ABONO_PEC2,P78_DIAS_ABONO_PEC4'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669479992019414084)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1_LST,P78_NUM_DIAS_PARC2_LST,P78_NUM_DIAS_PARC4_LST'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669477488907414083)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DIAS_ABONO_PEC1_LST,P78_DIAS_ABONO_PEC2_LST,P78_DIAS_ABONO_PEC4_LST'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669478044974414084)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>70
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_NUM_DIAS_PARC1_LST,P78_NUM_DIAS_PARC2_LST,P78_NUM_DIAS_PARC4_LST'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669478474124414084)
,p_event_id=>wwv_flow_api.id(89669474037070414077)
,p_event_result=>'FALSE'
,p_action_sequence=>80
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_DIAS_ABONO_PEC1_LST,P78_DIAS_ABONO_PEC2_LST,P78_DIAS_ABONO_PEC4_LST'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669480363190414084)
,p_name=>'Popula Opcao_Parc_SN'
,p_event_sequence=>908
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669480889008414084)
,p_event_id=>wwv_flow_api.id(89669480363190414084)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select distinct descricao, cod',
'  from ferias_parametros_parcelas',
' where cod_empresa = :p78_cod_empresa;',
' ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select vinculo',
'  from informacoes_funcionais',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula;',
' ',
'v_c2 c2%rowtype;',
'',
'begin',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    open c2;',
'    fetch c2 into v_c2;',
'    close c2;',
'',
'    if v_c1.cod is not null and v_c2.vinculo <> ''E'' then',
'    :p78_opcao_parc_sn := ''S'';',
'    else',
'    :p78_opcao_parc_sn := ''N'';',
'    end if;',
'',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA'
,p_attribute_03=>'P78_OPCAO_PARC_SN'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669481301537414085)
,p_name=>'Seta num_dias_parc2'
,p_event_sequence=>918
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC2_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669481801479414085)
,p_event_id=>wwv_flow_api.id(89669481301537414085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_NUM_DIAS_PARC2 := :P78_NUM_DIAS_PARC2_LST;'
,p_attribute_02=>'P78_NUM_DIAS_PARC2_LST'
,p_attribute_03=>'P78_NUM_DIAS_PARC2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669482208206414085)
,p_name=>'Seta num_dias_parc4'
,p_event_sequence=>928
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_NUM_DIAS_PARC4_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669482726179414085)
,p_event_id=>wwv_flow_api.id(89669482208206414085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_NUM_DIAS_PARC4 := :P78_NUM_DIAS_PARC4_LST;'
,p_attribute_02=>'P78_NUM_DIAS_PARC4_LST'
,p_attribute_03=>'P78_NUM_DIAS_PARC4'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669483116495414085)
,p_name=>'Seta dias_abono_pec1'
,p_event_sequence=>938
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC1_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669483638291414086)
,p_event_id=>wwv_flow_api.id(89669483116495414085)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p78_dias_abono_pec1 := :p78_dias_abono_pec1_lst;'
,p_attribute_02=>'P78_DIAS_ABONO_PEC1_LST'
,p_attribute_03=>'P78_DIAS_ABONO_PEC1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669484001569414086)
,p_name=>'Seta dias_abono_pec2'
,p_event_sequence=>948
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC2_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669484466824414086)
,p_event_id=>wwv_flow_api.id(89669484001569414086)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p78_dias_abono_pec2 := :p78_dias_abono_pec2_lst;'
,p_attribute_02=>'P78_DIAS_ABONO_PEC2_LST'
,p_attribute_03=>'P78_DIAS_ABONO_PEC2'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669484870919414086)
,p_name=>'Seta dias_abono_pec4'
,p_event_sequence=>958
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DIAS_ABONO_PEC4_LST'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669485361904414086)
,p_event_id=>wwv_flow_api.id(89669484870919414086)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p78_dias_abono_pec4 := :p78_dias_abono_pec4_lst;'
,p_attribute_02=>'P78_DIAS_ABONO_PEC4_LST'
,p_attribute_03=>'P78_DIAS_ABONO_PEC4'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669485795733414086)
,p_name=>'Popula PARCELAS_OPC'
,p_event_sequence=>968
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_FERIAS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669486309105414087)
,p_event_id=>wwv_flow_api.id(89669485795733414086)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select qtd_parcelas, DIAS_ABONO_PEC1',
'  from ferias_parametros_parcelas',
' where cod_empresa = :p78_cod_empresa',
'   and cod_filial = :p78_filial',
'   and cod = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A);',
'',
'v_c1 c1%rowtype;',
'',
'begin',
' :P78_OPCAO_FERIAS_DB := :P78_OPCAO_FERIAS;',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
' :P78_PARCELAS_OPC := v_c1.qtd_parcelas;',
' :P78_DIAS_ABONO_PEC1_OPC := v_c1.DIAS_ABONO_PEC1;',
'end;',
''))
,p_attribute_02=>'P78_COD_EMPRESA,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_FILIAL'
,p_attribute_03=>'P78_DIAS_ABONO_PEC1_OPC,P78_PARCELAS_OPC,P78_OPCAO_FERIAS_DB'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669486683405414087)
,p_name=>unistr('Popula regi\00E3o colaborador')
,p_event_sequence=>978
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669487173956414087)
,p_event_id=>wwv_flow_api.id(89669486683405414087)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       I.FILIAL,',
'       i.dc_matricula,',
'       i.vinculo',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p78_cod_empresa',
'   and i.matricula = :p78_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'cursor c3 (v_filial number) is',
'select qtd_parcelas',
'  from ferias_Parametros',
' where cod_empresa = :P78_cod_empresa',
'   and cod_filial = v_filial;',
'   ',
'v_c3 c3%rowtype;',
'',
'cursor c is',
'  select *',
'  from   parametros_recursos_humanos',
'  where  cod_empresa = :P78_cod_empresa;',
'',
'param_rh c%rowtype;',
'prazo_limite date;',
'',
'v_dt_fim date := nvl(:P78_DT_FIM_PER_FERIAS,:P78_DT_FIM_PER_FERIAS_1); --Bruno Sousa 03/01/2024',
'',
'V_DT_LIMITE_REQ DATE;',
'',
'V_FLG VARCHAR2(1);',
'V_MSG VARCHAR2(4000);',
'begin',
'  open c;',
'  fetch c into param_rh;',
'  close c;',
'  PKG_FERIAS.VALIDA_ESTATUTARIO(:p78_cod_empresa,',
'                                :p78_matricula,',
'                                3,--P_TIPO NUMBER,',
'                                NULL,',
'                                NULL,',
'                                NULL,',
'                                v_dt_fim, --Bruno Sousa 03/01/2024',
'                                V_DT_LIMITE_REQ,',
'                                V_FLG,',
'                                V_MSG);',
'',
'   -->> MSS 20220815 (Rodrigo)',
'   IF Pkg_Ferias.fnc_VerifEstatutario(pEmpresa => :P78_COD_EMPRESA, pMatricula => :P78_MATRICULA) = ''S'' THEN',
unistr('     --:P78_DT_LIMITE_REQ := TO_DATE(''01/12/''||TO_CHAR(SYSDATE, ''RRRR''), ''DD/MM/RRRR'');   -- Alterado de 31 para 01/12/2022 Rog\00E9rio'),
unistr('     --:P78_DT_LIMITE_REQ := TO_DATE(''01/12/''||TO_CHAR(TO_DATE(:P78_DT_FIM_PER_FERIAS,''DD/MM/YYYY''), ''RRRR''), ''DD/MM/RRRR'');   -- Alterado de 31 para 01/12/2022 Rog\00E9rio'),
'     :P78_DT_LIMITE_REQ := TO_DATE(''01/12/''||TO_CHAR(v_dt_fim, ''RRRR''), ''DD/MM/RRRR'');   --Bruno Sousa 03/01/2024',
'   ELSE',
'     :P78_DT_LIMITE_REQ := NVL(V_DT_LIMITE_REQ,add_months(v_dt_fim, 12) - 31); -- to_date(replace(param_rh.dia_limite_ferias||''/''||to_char(sysdate,''mm/rrrr''),'' '',''''),''dd/mm/rrrr'');',
'   END IF;',
'   --<<',
'   -- 28/11/2022 Robson/Rodrigo',
'	if :P78_FLAG_CTRL is not null then',
'		:P78_DT_LIMITE_REQ := to_date(:P78_DT_LIMITE_REQ,''DD/MM/YYYY'')+nvl(:P78_NUM_DIAS_PARC1_1,0)+nvl(:P78_NUM_DIAS_PARC2_1,0)+nvl(:P78_DIAS_ABONO_PEC1_1,0)+nvl(:P78_DIAS_ABONO_PEC2_1,0);',
'	end if;',
'   --',
'',
'if :p78_matricula_display is null then',
'',
'    open c1;',
'    fetch c1 into v_c1;',
'    close c1;',
'',
'    :p78_cod_empresa_display := v_c1.empresa;',
'    :p78_matricula_display := v_c1.matricula;',
'    :p78_situacao_colab := v_c1.situacao;',
'    :p78_dt_admissao := v_c1.dt_admissao;',
'    :p78_dc_matricula := v_c1.dc_matricula;',
'',
'    if :p78_cod_solicitacao is null then',
'       :P78_TIPO_FERIAS1 := ''N'';',
'    end if;',
'',
'    open  c3(v_c1.filial);',
'    fetch c3 into v_c3;',
'    close c3;',
'',
'    if v_c1.vinculo <> ''E'' then',
'    :p78_qtd_parcelas := v_c3.qtd_parcelas;',
'    else',
'    :p78_qtd_parcelas := 1;',
'    end if;',
'    :P78_VINCULO := V_C1.VINCULO;',
'end if;',
'exception',
'when others then',
':p78_cod_empresa_display := :p78_cod_empresa;',
':p78_matricula_display := :p78_matricula;',
'end;'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_MATRICULA,P78_MATRICULA_DISPLAY,P78_COD_SOLICITACAO,P78_DT_FIM_PER_FERIAS,P78_NUM_DIAS_PARC1_1,P78_NUM_DIAS_PARC2_1,P78_DIAS_ABONO_PEC1_1,P78_DIAS_ABONO_PEC2_1'
,p_attribute_03=>'P78_COD_EMPRESA_DISPLAY,P78_MATRICULA_DISPLAY,P78_SITUACAO_COLAB,P78_DT_ADMISSAO,P78_DC_MATRICULA,P78_TIPO_FERIAS1,P78_QTD_PARCELAS,P78_DT_LIMITE_REQ'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669487608368414087)
,p_name=>unistr('(Hide/Show) Regi\00E3o Cria\00E7\00E3o / Pesquisa 1')
,p_event_sequence=>988
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1_1'
,p_condition_element=>'P78_DT_SAIDA_PARC1_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669488052802414087)
,p_event_id=>wwv_flow_api.id(89669487608368414087)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669488582767414087)
,p_event_id=>wwv_flow_api.id(89669487608368414087)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272302310720516609)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669489138631414088)
,p_event_id=>wwv_flow_api.id(89669487608368414087)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669489558280414088)
,p_event_id=>wwv_flow_api.id(89669487608368414087)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669490002549414088)
,p_name=>unistr('(Hide/Show) Regi\00E3o Parcelas')
,p_event_sequence=>998
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_PARCELAS_OPC,P78_QTD_PARCELAS'
,p_condition_element=>'P78_COD_SOLICITACAO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669490476785414088)
,p_event_id=>wwv_flow_api.id(89669490002549414088)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P78_OPCAO_PARC_SN" ).getValue() == ''S'') {',
unistr('console.log(''(Hide/Show) Regi\00E3o Parcelas #01'');'),
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue().length == 0 ) {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.1'');'),
'        $("div#PARCELA1").hide();',
'        $("div#2_PARCELA1").hide();',
'        $("div#PARCELA2").hide();',
'        $("div#2_PARCELA2").hide();',
'        $("div#PARCELA3").hide();',
'        $("div#2_PARCELA3").hide();',
'    }',
unistr('console.log(''(Hide/Show) Regi\00E3o Parcelas #01.2'');'),
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''1'' || apex.item( "P78_PARCELAS_OPC" ).getValue() == ''2'' || apex.item( "P78_PARCELAS_OPC" ).getValue() == ''3'' ) {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.3'');'),
'        if (apex.item( "P78_DT_SAIDA_PARC1_1" ).getValue().length  > 0 ) {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.3.1'');'),
'            $("div#2_PARCELA1").show();',
'            $("div#PARCELA1").hide();',
'        }else{',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.3.2'');'),
'            $("div#2_PARCELA1").hide();',
'            $("div#PARCELA1").show();',
'        }',
'    }',
'',
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''1'') {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.4.1'');'),
'        $("div#PARCELA2").hide();',
'        $("div#2_PARCELA2").hide();',
'        $("div#PARCELA3").hide();',
'        $("div#2_PARCELA3").hide();',
'    }',
'    ',
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''2'' || apex.item( "P78_PARCELAS_OPC" ).getValue() == ''3'' ) {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.5'');'),
'        if (apex.item( "P78_DT_SAIDA_PARC2_1" ).getValue().length  > 0 ) {',
'            $("div#2_PARCELA2").show();',
'            $("div#PARCELA2").hide();',
'        }else{',
'            $("div#2_PARCELA2").hide();',
'            $("div#PARCELA2").show();',
'        }',
'    }',
'',
'   if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''2'') {',
unistr('     console.log(''(Hide/Show) Regi\00E3o Parcelas #01.6.1'');'),
'        $("div#PARCELA3").hide();',
'        $("div#2_PARCELA3").hide();',
'    }',
unistr('console.log(''(Hide/Show) Regi\00E3o Parcelas #01.7'');'),
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''3'' ) {',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #01.7.1'');'),
'        if (apex.item( "P78_DT_SAIDA_PARC4_1" ).getValue().length  > 0 ) {',
'            $("div#2_PARCELA3").show();',
'            $("div#PARCELA3").hide();',
unistr('          console.log(''(Hide/Show) Regi\00E3o Parcelas #01.7.1.1'');'),
'        }else{',
'            $("div#2_PARCELA3").hide();',
'            $("div#PARCELA3").show();',
unistr('          console.log(''(Hide/Show) Regi\00E3o Parcelas #01.7.1.2'');'),
'        }',
'    }',
'}else if (apex.item( "P78_OPCAO_PARC_SN" ).getValue() == ''N'') {',
'  if (apex.item( "P78_QTD_PARCELAS" ).getValue() == ''1'' || apex.item( "P78_QTD_PARCELAS" ).getValue() == ''2'' || apex.item( "P78_QTD_PARCELAS" ).getValue() == ''3'' ) {',
'    if (apex.item( "P78_DT_SAIDA_PARC1_1" ).getValue().length  > 0 ) {',
'      $("div#2_PARCELA1").show();',
'      $("div#PARCELA1").hide();',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #02.1'');'),
'    }else{',
'      $("div#2_PARCELA1").hide();',
'      $("div#PARCELA1").show();',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #02.2'');'),
'    }',
'  }',
'  if (apex.item( "P78_QTD_PARCELAS" ).getValue() == ''2'' || apex.item( "P78_QTD_PARCELAS" ).getValue() == ''3'' ) {',
'    if (apex.item( "P78_DT_SAIDA_PARC2_1" ).getValue().length  > 0 ) {',
'      $("div#2_PARCELA2").show();',
'      $("div#PARCELA2").hide();',
'    }else{',
'      $("div#2_PARCELA2").hide();',
'      $("div#PARCELA2").show();',
'    }',
'  }',
'  if (apex.item( "P78_QTD_PARCELAS" ).getValue() == ''3'' ) {',
'    if (apex.item( "P78_DT_SAIDA_PARC4_1" ).getValue().length  > 0 ) {',
'      $("div#2_PARCELA3").show();',
'      $("div#PARCELA3").hide();',
'    }else{',
'      $("div#2_PARCELA3").hide();',
'      $("div#PARCELA3").show();',
'    }',
'  }',
'}else{',
unistr('console.log(''(Hide/Show) Regi\00E3o Parcelas #03'');'),
'$("div#PARCELA1").hide();',
'$("div#2_PARCELA1").hide();',
'$("div#PARCELA2").hide();',
'$("div#2_PARCELA2").hide();',
'$("div#PARCELA3").hide();',
'$("div#2_PARCELA3").hide();',
'}'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669491019697414089)
,p_event_id=>wwv_flow_api.id(89669490002549414088)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P78_OPCAO_FERIAS" ).getValue().length > 0 || apex.item( "P78_OPCAO_FERIAS_A" ).getValue().length > 0 ) {',
'  if (apex.item( "P78_DT_SAIDA_PARC1_1" ).getValue().length  > 0 ) {',
unistr('    console.log(''(Hide/Show) Regi\00E3o Parcelas #04.1'');'),
'    $("div#2_PARCELA1").show();',
'    $("div#PARCELA1").hide();',
'  }else{',
unistr('    console.log(''(Hide/Show) Regi\00E3o Parcelas #04.2'');'),
'    $("div#2_PARCELA1").hide();',
'    if (apex.item( "P78_PARCELAS_OPC" ).getValue() == ''1'' || apex.item( "P78_PARCELAS_OPC" ).getValue() == ''2'' || apex.item( "P78_PARCELAS_OPC" ).getValue() == ''3'' )  {',
'      $("div#PARCELA1").show();',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #04.3 '' + apex.item( "P78_PARCELAS_OPC" ).getValue());'),
'    }else{',
unistr('      console.log(''(Hide/Show) Regi\00E3o Parcelas #04.4 '' + apex.item( "P78_PARCELAS_OPC" ).getValue());'),
'      $("div#PARCELA1").hide();',
'    }',
'  }',
'  ',
'  if (apex.item( "P78_DT_SAIDA_PARC2_1" ).getValue().length  > 0 ) {',
'    $("div#2_PARCELA2").show();',
'    $("div#PARCELA2").hide();',
'  }else{',
'    $("div#2_PARCELA2").hide();',
'    if (apex.item( "P78_DT_SAIDA_PARC2" ).getValue().length  > 0 ) {',
'      $("div#PARCELA2").show();',
'    }',
'  }',
'  if (apex.item( "P78_DT_SAIDA_PARC4_1" ).getValue().length  > 0 ) {',
'    $("div#2_PARCELA3").show();',
'    $("div#PARCELA3").hide();',
'  }else{',
'    $("div#2_PARCELA3").hide();',
'    if (apex.item( "P78_DT_SAIDA_PARC4" ).getValue().length  > 0 ) {',
'      $("div#PARCELA3").show();',
'    }',
'  }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669491374955414089)
,p_name=>unistr('Pesquisa (Hide/Show) Regi\00E3o Parcelas_1')
,p_event_sequence=>1008
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(202272281567918516588)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669491858174414089)
,p_event_id=>wwv_flow_api.id(89669491374955414089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_DT_SAIDA_PARC1_1'').value.length > 0 && $x(''P78_DT_SAIDA_PARC1'').value.length == 0 ) {',
'        $("div#2_PARCELA1").show();',
'        $("div#PARCELA1").hide();',
'    }else{',
'        $("div#2_PARCELA1").hide();',
'        $("div#PARCELA1").show();',
'    }',
'',
'    if ($x(''P78_DT_SAIDA_PARC2_1'').value.length  > 0 && $x(''P78_DT_SAIDA_PARC2'').value.length == 0 ) {',
'        $("div#2_PARCELA2").show();',
'        $("div#PARCELA2").hide();',
'    }else{',
'        $("div#2_PARCELA2").hide();',
'        if ($x(''P78_DT_SAIDA_PARC2'').value.length  > 0 ) {',
'        $("div#PARCELA2").show();',
'        }',
'    }',
'',
'    if ($x(''P78_DT_SAIDA_PARC4_1'').value.length  > 0 && $x(''P78_DT_SAIDA_PARC4'').value.length == 0 ) {',
'        $("div#2_PARCELA3").show();',
'        $("div#PARCELA3").hide();',
'    }else{',
'        $("div#2_PARCELA3").hide();',
'        if ($x(''P78_DT_SAIDA_PARC4'').value.length  > 0 ) {',
'        $("div#PARCELA3").show();',
'        }',
'    }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669492252269414089)
,p_name=>unistr('(Hide/Show) Regi\00E3o Cria\00E7\00E3o / Pesquisa 2')
,p_event_sequence=>1018
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC2_1'
,p_condition_element=>'P78_DT_SAIDA_PARC2_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669492814004414089)
,p_event_id=>wwv_flow_api.id(89669492252269414089)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202042663264835043648)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669493328652414089)
,p_event_id=>wwv_flow_api.id(89669492252269414089)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202042663264835043648)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669493826172414089)
,p_event_id=>wwv_flow_api.id(89669492252269414089)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669494252872414090)
,p_event_id=>wwv_flow_api.id(89669492252269414089)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669494690116414090)
,p_name=>unistr('(Hide/Show) Regi\00E3o Cria\00E7\00E3o / Pesquisa 3')
,p_event_sequence=>1028
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC4_1'
,p_condition_element=>'P78_DT_SAIDA_PARC4_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669495175042414090)
,p_event_id=>wwv_flow_api.id(89669494690116414090)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202042664182479043657)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669495684606414090)
,p_event_id=>wwv_flow_api.id(89669494690116414090)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202042664182479043657)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669496151645414090)
,p_event_id=>wwv_flow_api.id(89669494690116414090)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669496715905414090)
,p_event_id=>wwv_flow_api.id(89669494690116414090)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669497057328414091)
,p_name=>unistr('Pesquisa (Hide/Show) Regi\00E3o Cria\00E7\00E3o 3')
,p_event_sequence=>1038
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC4'
,p_condition_element=>'P78_DT_SAIDA_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669497547133414091)
,p_event_id=>wwv_flow_api.id(89669497057328414091)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669498127737414091)
,p_event_id=>wwv_flow_api.id(89669497057328414091)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202136605286391907173)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669498516271414096)
,p_name=>unistr('Pesquisa (Hide/Show) Regi\00E3o Cria\00E7\00E3o 2')
,p_event_sequence=>1048
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC2'
,p_condition_element=>'P78_DT_SAIDA_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669498990289414096)
,p_event_id=>wwv_flow_api.id(89669498516271414096)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669499450113414097)
,p_event_id=>wwv_flow_api.id(89669498516271414096)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272292700792516598)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669499901346414097)
,p_name=>unistr('Pesquisa (Hide/Show) Regi\00E3o Cria\00E7\00E3o 1')
,p_event_sequence=>1058
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1'
,p_condition_element=>'P78_DT_SAIDA_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669500908035414098)
,p_event_id=>wwv_flow_api.id(89669499901346414097)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669500434453414097)
,p_event_id=>wwv_flow_api.id(89669499901346414097)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272287553987516594)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669501310967414098)
,p_name=>'Disable DT_RETORNO_PARC'
,p_event_sequence=>1068
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return 1=2;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669501766996414098)
,p_event_id=>wwv_flow_api.id(89669501310967414098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P78_DT_RETORNO_PARC1'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC2'').disabled = true;',
'$x(''P78_DT_RETORNO_PARC4'').disabled = true;'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669502172223414098)
,p_name=>unistr('Hide / Show Aprova\00E7\00F5es')
,p_event_sequence=>1078
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_SIT_REQUISICAO'
,p_condition_element=>'P78_SIT_REQUISICAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669503721304414100)
,p_event_id=>wwv_flow_api.id(89669502172223414098)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669504166580414100)
,p_event_id=>wwv_flow_api.id(89669502172223414098)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669321143989413691)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669502671559414098)
,p_event_id=>wwv_flow_api.id(89669502172223414098)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669321143989413691)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669503189045414100)
,p_event_id=>wwv_flow_api.id(89669502172223414098)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669504609071414100)
,p_name=>'Popula DIAS_DIREITO_OPC'
,p_event_sequence=>1088
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669505124471414101)
,p_event_id=>wwv_flow_api.id(89669504609071414100)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_dias_char_1 varchar2(10) := :P78_DIAS_DIREITO; -- Igor 30/03',
'v_dias_number_1 number;',
'',
'v_dias_char_2 varchar2(10) := :P78_SALDO_BRUTO;',
'v_dias_number_2 number;',
'',
'begin',
'',
'--:P78_DIAS_DIREITO_OPC := nvl(:P78_SALDO_BRUTO,0);',
'',
'if nvl(:P78_NUM_DIAS_PARC1_1,0) = 0 then',
'   ',
'   if instr(v_dias_char_1,''.'') > 0 then',
'   v_dias_number_1 := replace(v_dias_char_1,''.'','','');',
'   :P78_DIAS_DIREITO_OPC := v_dias_number_1;',
'   else',
'   :P78_DIAS_DIREITO_OPC := nvl(:P78_DIAS_DIREITO,0);',
'   end if;',
'else',
'',
'   if instr(v_dias_char_2,''.'') > 0 then',
'   v_dias_number_2 := replace(v_dias_char_2,''.'','','');',
'   :P78_DIAS_DIREITO_OPC := v_dias_number_2;',
'   else',
'   :P78_DIAS_DIREITO_OPC := nvl(:P78_SALDO_BRUTO,0);',
'   end if;',
'',
'',
'end if;',
'',
'/*',
'if nvl(:p78_num_dias_parc1_1,0) = 0 then',
'   :P78_DIAS_DIREITO_OPC := nvl(:P78_DIAS_DIREITO,0);',
'elsif nvl(:p78_num_dias_parc1_1,0) > 0 and nvl(:p78_num_dias_parc2_1,0) = 0 and :P78_IND_SITUACAO_PERIODO = ''R'' then',
'   :P78_DIAS_DIREITO_OPC := nvl(:P78_DIAS_DIREITO,0) + nvl(:p78_num_dias_parc1_1,0) + nvl(:p78_num_dias_parc2_1,0);',
'elsif nvl(:p78_num_dias_parc1_1,0) > 0 and nvl(:p78_num_dias_parc2_1,0) > 0 and :P78_IND_SITUACAO_PERIODO = ''R'' then',
'   :P78_DIAS_DIREITO_OPC := nvl(:P78_SALDO_BRUTO,0);',
'end if;',
'*/',
'NULL;',
'',
'end;'))
,p_attribute_02=>'P78_NUM_DIAS_PARC1_1,P78_DIAS_DIREITO,P78_NUM_DIAS_PARC1_1,P78_NUM_DIAS_PARC2_1,P78_SALDO_BRUTO'
,p_attribute_03=>'P78_DIAS_DIREITO_OPC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669505458278414101)
,p_name=>'(Create) Mostra a Parc 1 Programada'
,p_event_sequence=>1098
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return 1=2;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669506016961414101)
,p_event_id=>wwv_flow_api.id(89669505458278414101)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if ($x(''P78_DT_SAIDA_PARC1_1'').value.length  > 0 ) {',
'            $("div#2_PARCELA1").show();',
'            $("div#PARCELA1").hide();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669506433332414101)
,p_name=>'Update Requisicao_Ferias'
,p_event_sequence=>1108
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669311634907413680)
,p_condition_element=>'P78_SIT_REQUISICAO'
,p_triggering_condition_type=>'NOT_EQUALS'
,p_triggering_expression=>'2'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669506913112414101)
,p_event_id=>wwv_flow_api.id(89669506433332414101)
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
'PKG_FERIAS.Pre_Update ( :p78_cod_solicitacao,',
'                       :p78_sit_requisicao,',
'                       :p78_dt_saida_parc1,',
'                       :p78_dt_saida_parc2,',
'                       :p78_dt_saida_parc3,',
'                       :p78_dt_saida_parc4,',
'                       :p78_dt_retorno_parc1,',
'                       :p78_dt_retorno_parc2,',
'                       :p78_dt_retorno_parc3,',
'                       :p78_dt_retorno_parc4,',
'                       :p_usuario,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
' ',
'    update requisicao_ferias',
'       set sit_requisicao = :p78_sit_requisicao, ',
'           usuario = TO_CHAR(:P_EMPRESA_USER)||''/''||TO_CHAR(:P_MATRICULA_USER),',
'           dt_atualizacao = sysdate',
'     where cod_solicitacao = :p78_cod_solicitacao',
'       and :p78_cod_solicitacao is not null;',
'     ',
'     commit;',
'     ',
' end if;',
' ',
' ',
'end;'))
,p_attribute_02=>'P78_COD_SOLICITACAO,P78_SIT_REQUISICAO,P78_DT_SAIDA_PARC1,P78_DT_SAIDA_PARC2,P78_DT_SAIDA_PARC3,P78_DT_SAIDA_PARC4,P78_DT_RETORNO_PARC1,P78_DT_RETORNO_PARC2,P78_DT_RETORNO_PARC3,P78_DT_RETORNO_PARC4,P_EMPRESA_USER,P_MATRICULA_USER,P_USUARIO'
,p_attribute_03=>'P78_OK,P78_MENSAGEM,P78_FLAG'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669507364453414103)
,p_event_id=>wwv_flow_api.id(89669506433332414101)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'SAVE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669507809725414103)
,p_name=>unistr('Estagi\00E1rio')
,p_event_sequence=>1118
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_PARC_SN'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669508343738414103)
,p_event_id=>wwv_flow_api.id(89669507809725414103)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P78_VINCULO").getValue() == ''E''){',
'  apex.item( "P78_DIAS_ABONO_PEC1" ).hide(true);',
'  apex.item( "P78_OPCAO_13SAL1" ).hide(true);',
'  apex.item( "P78_DESC_ADICIONAL1" ).hide(true);',
'  apex.item( "P78_DIAS_ABONO_PEC1_LST" ).hide(true);',
'}else{',
'      apex.item( "P78_OPCAO_13SAL1" ).show(true);',
'      apex.item( "P78_DESC_ADICIONAL1" ).show(true);',
'  ',
'  if (apex.item("P78_OPCAO_PARC_SN").getValue() == ''S''){',
'      apex.item( "P78_DIAS_ABONO_PEC1_LST" ).show(true);',
'      apex.item( "P78_DIAS_ABONO_PEC1" ).hide(true);',
'  }else{',
'      apex.item( "P78_DIAS_ABONO_PEC1" ).show(true);',
'      apex.item( "P78_DIAS_ABONO_PEC1_LST" ).hide(true);',
'  }',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669508698964414103)
,p_name=>'Valida_dt_retorno_parc2'
,p_event_sequence=>1128
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC2'
,p_condition_element=>'P78_DT_RETORNO_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669509200853414104)
,p_event_id=>wwv_flow_api.id(89669508698964414103)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc2(:p78_dt_retorno_parc2,',
'                                   nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc2,',
'                                   nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                                    :p78_cod_empresa,',
'                                    :p78_matricula,',
'                                    nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1));',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_retorno_parc2''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_retorno_parc2'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC2,P78_IND_SITUACAO_PERIODO,P78_DT_SAIDA_PARC2,P78_DT_FIM_PER_FERIAS,P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_IND_SITUACAO_PERIODO_A,P78_DT_FIM_PER_FERIAS_1,P78_DT_INIC_PER_FERIAS_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669509577367414104)
,p_name=>'Valida_dt_retorno_parc1'
,p_event_sequence=>1138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_condition_element=>'P78_DT_RETORNO_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return :P78_ROWID is null and :P78_FLAG_CTRL is null;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669510061909414104)
,p_event_id=>wwv_flow_api.id(89669509577367414104)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc1(:p78_dt_retorno_parc1,',
'                                   :p78_ind_situacao_periodo,                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc1,',
'                                   :p78_dt_fim_per_ferias,',
'                                    :p78_cod_empresa,',
'                                    :p78_matricula,',
'                                    :p78_dt_inic_per_ferias);',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_retorno_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_retorno_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC1,P78_IND_SITUACAO_PERIODO,P78_DT_SAIDA_PARC1,P78_DT_FIM_PER_FERIAS,P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669510530715414104)
,p_name=>'Valida_dt_retorno_parc1a'
,p_event_sequence=>1148
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_condition_element=>'P78_DT_RETORNO_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669510983968414106)
,p_event_id=>wwv_flow_api.id(89669510530715414104)
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
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc1(:p78_dt_retorno_parc1,',
'                                   :p78_ind_situacao_periodo_a,                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc1,',
'                                   :p78_dt_fim_per_ferias_1,',
'                                    :p78_cod_empresa,',
'                                    :p78_matricula,',
'                                    :p78_dt_inic_per_ferias_1);',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_retorno_parc1''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_retorno_parc1'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC1,P78_IND_SITUACAO_PERIODO_A,P78_DT_SAIDA_PARC1,P78_DT_FIM_PER_FERIAS_1,P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS_1'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669511373597414106)
,p_name=>'POPULA TESTE_3'
,p_event_sequence=>1158
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669511887502414107)
,p_event_id=>wwv_flow_api.id(89669511373597414106)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_TESTE_3'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P78_DT_RETORNO_PARC1);'
,p_attribute_07=>'P78_DT_RETORNO_PARC1'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669512277244414107)
,p_name=>'Valida_dt_retorno_parc4'
,p_event_sequence=>1168
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC4'
,p_condition_element=>'P78_DT_RETORNO_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P78_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669512842891414107)
,p_event_id=>wwv_flow_api.id(89669512277244414107)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
':p78_mensagem := null;',
'',
'pkg_ferias.Valida_Dt_Retorno_Parc4(:p78_dt_retorno_parc4,',
'                                   :p78_ind_situacao_periodo,                        ',
'                                   v_flg_retorno,',
'                                   v_msg_retorno,',
'                                   :p78_dt_saida_parc4,',
'                                   :p78_dt_fim_per_ferias,',
'                                    :p78_cod_empresa,',
'                                    :p78_matricula,',
'                                    :p78_dt_inic_per_ferias,',
'                                    :p78_dt_saida_parc2);',
'',
'if trim(v_msg_retorno) is not null then',
'',
'if v_flg_retorno in (''N'',''Q'') then',
'    :P78_ok := ''N'';',
'    :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_dt_retorno_parc4''));',
'else',
'    :P78_ok := ''S'';',
'end if;',
'',
':P78_flag := v_flg_retorno;',
':P78_mensagem := v_msg_retorno;',
'else',
':P78_flag := null;',
':P78_mensagem := null;',
'if v_item_validacao = TRIM(UPPER(''p78_dt_retorno_parc4'')) OR v_item_validacao IS NULL then',
'   :P78_OK := ''S'';',
'   :P78_ITEM_VALIDACAO := null;',
'else',
'   :P78_ITEM_VALIDACAO := v_item_validacao;',
'end if;',
'end if;',
'',
'end;'))
,p_attribute_02=>'P78_ITEM_VALIDACAO,P78_DT_RETORNO_PARC4,P78_IND_SITUACAO_PERIODO,P78_DT_SAIDA_PARC4,P78_DT_FIM_PER_FERIAS,P78_COD_EMPRESA,P78_MATRICULA,P78_DT_INIC_PER_FERIAS,P78_DT_SAIDA_PARC2'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM,P78_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669513182902414107)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1178
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669321490938413691)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669513708065414112)
,p_event_id=>wwv_flow_api.id(89669513182902414107)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669514059543414112)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1188
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(89669320701488413690)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669514580193414112)
,p_event_id=>wwv_flow_api.id(89669514059543414112)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669515000678414112)
,p_name=>'POPULA TESTE X'
,p_event_sequence=>1198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1_X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669515521398414112)
,p_event_id=>wwv_flow_api.id(89669515000678414112)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_TESTE_3'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>'RETURN(:P78_DT_RETORNO_PARC1_X);'
,p_attribute_07=>'P78_DT_RETORNO_PARC1_X'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669515930662414113)
,p_name=>'Atualizar P78_NUM_DIAS_PARC1_LST'
,p_event_sequence=>1208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_SAIDA_PARC1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669516398090414113)
,p_event_id=>wwv_flow_api.id(89669515930662414113)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select  max(nvl(:P78_NUM_DIAS_PARC1_LST,case when A.QTD_PARCELAS = 1 then A.NUM_DIAS_PARC1 end)),',
'            max(nvl(:P78_DIAS_ABONO_PEC1_LST,case when A.QTD_PARCELAS = 1 then A.DIAS_ABONO_PEC1 end))',
'    into    :P78_NUM_DIAS_PARC1_LST,',
'            :P78_DIAS_ABONO_PEC1_LST',
'    from    FERIAS_PARAMETROS_PARCELAS A',
'    where   A.COD_EMPRESA = :P78_COD_EMPRESA',
'    and     A.COD_FILIAL = :P78_FILIAL',
'    and     A.COD = nvl(:P78_OPCAO_FERIAS,:P78_OPCAO_FERIAS_A);'))
,p_attribute_02=>'P78_COD_EMPRESA,P78_FILIAL,P78_OPCAO_FERIAS,P78_OPCAO_FERIAS_A,P78_NUM_DIAS_PARC1_LST,P78_DIAS_ABONO_PEC1_LST'
,p_attribute_03=>'P78_NUM_DIAS_PARC1_LST,P78_DIAS_ABONO_PEC1_LST'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669516763947414113)
,p_name=>'alt_P78_FLAG_CTRL'
,p_event_sequence=>1218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_FLAG_CTRL'
,p_condition_element=>'P78_FLAG_CTRL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669517318179414117)
,p_event_id=>wwv_flow_api.id(89669516763947414113)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_MATRICULA_1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669517810744414117)
,p_event_id=>wwv_flow_api.id(89669516763947414113)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669518325713414117)
,p_event_id=>wwv_flow_api.id(89669516763947414113)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_MATRICULA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669518753232414117)
,p_event_id=>wwv_flow_api.id(89669516763947414113)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_MATRICULA_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669519197105414117)
,p_name=>'Requisao no mesmo periodo'
,p_event_sequence=>1228
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669519673144414118)
,p_event_id=>wwv_flow_api.id(89669519197105414117)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P78_COD_EMPRESA := :P78_EMP_A;',
':P78_COD_EMPRESA_1 := :P78_EMP_A;',
':P78_MATRICULA := :P78_MAT_A;',
unistr('select ''Matr\00EDcula: (''||A.MATRICULA||'') ''||INITCAP(B.nome)'),
'            ||'' - FILIAL: (''||A.FILIAL||'') ''||initcap(fnct_nome_FILIAL(A.COD_EMPRESA, A.FILIAL))',
'            ||'' - C.Custo: (''||A.COD_CCUSTO||'') ''||initcap(fnct_nome_ccusto(A.COD_EMPRESA, A.COD_CCUSTO))',
'            ||'' - Unid. Adm: (''||A.UNIDADE_ADM||'') ''||initcap(U.DESCRICAO)',
'            ||'' - Atividade: (''||A.COD_atividade||'') ''||initcap(V.DESCRICAO)',
'            ||'' - Local: (''||A.COD_LOCALIZACAO||'') ''||initcap(fnct_nome_local_trab(A.COD_LOCALIZACAO))',
'into    :P78_MATRICULA_1',
'from    INFORMACOES_FUNCIONAIS  A,',
'        INF_PESSOAIS            B,',
'        UNIDADE_ADMINISTRATIVA  U,',
'        ATIVIDADE V',
'where   A.COD_EMPRESA   = B.COD_EMPRESA',
'and     A.MATRICULA   = B.MATRICULA',
'and     A.COD_EMPRESA = U.COD_EMPRESA (+)',
'and     A.UNIDADE_ADM = U.COD_UNIDADE_ADM (+)',
'and     A.COD_atividade = V.COD (+)',
'and     A.FILIAL = U.COD_FILIAL (+)',
'and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'and     A.MATRICULA = :P78_MATRICULA;',
'',
'select  floor(months_between(trunc(sysdate), trunc(A.DT_ADMISSAO)))',
'into    :P78_MESES_ADM',
'from    INFORMACOES_FUNCIONAIS A',
'where   A.COD_EMPRESA = :P78_COD_EMPRESA',
'and     A.MATRICULA = :P78_MATRICULA;',
''))
,p_attribute_02=>'P78_EMP_A,P78_MAT_A'
,p_attribute_03=>'P78_COD_EMPRESA,P78_MATRICULA,P78_MATRICULA_1,P78_COD_EMPRESA_1,P78_MESES_ADM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669520239847414118)
,p_event_id=>wwv_flow_api.id(89669519197105414117)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_COD_EMPRESA,P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669520554875414119)
,p_name=>'Popula_campos_3a'
,p_event_sequence=>1238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_DT_SAIDA_PARC1_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>'return nvl(:P78_FLAG_CTRL,0) = 1;'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669521108050414119)
,p_event_id=>wwv_flow_api.id(89669520554875414119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669522134643414119)
,p_event_id=>wwv_flow_api.id(89669520554875414119)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669523081642414119)
,p_event_id=>wwv_flow_api.id(89669520554875414119)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(89669523468549414119)
,p_name=>'alt_P78_MSG_APROVAR'
,p_event_sequence=>1248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MSG_APROVAR'
,p_condition_element=>'P78_MSG_APROVAR'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669524027030414120)
,p_event_id=>wwv_flow_api.id(89669523468549414119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669320701488413690)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669524530128414120)
,p_event_id=>wwv_flow_api.id(89669523468549414119)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'alertify.alert(apex.item(''P78_MSG_APROVAR'').getValue());'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(89669524992244414120)
,p_event_id=>wwv_flow_api.id(89669523468549414119)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669320701488413690)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68965591111347212912)
,p_name=>'Valida Duplo Vinculo'
,p_event_sequence=>1258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_MATRICULA'
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'        select matricula ',
'            from tipo_de_vinculo_func',
'        where codigo_tip <> 1',
'        and cod_empresa = :P78_COD_EMPRESA',
'        and matricula = :P78_MATRICULA',
'AND 1 = 2;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68965591239037212913)
,p_event_id=>wwv_flow_api.id(68965591111347212912)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_matricula    tipo_de_vinculo_func.matricula%TYPE;',
'begin',
'    begin',
'        select matricula ',
'            into l_matricula',
'            from tipo_de_vinculo_func',
'        where codigo_tip <> 1',
'        and cod_empresa = :P78_COD_EMPRESA',
'        and matricula = :P78_MATRICULA;',
'    exception',
'        when others then',
'            :P78_OK         := ''N'';',
'            :P78_FLAG       := ''N'';',
unistr('            :P78_MENSAGEM   := ''Funcion\00E1rio Duplo Vinculo ou Exclusivo HC. Programar f\00E9rias pelo m\00F3dulo Colaborador HC'';    '),
'    end;',
'end;',
''))
,p_attribute_02=>'P78_MATRICULA'
,p_attribute_03=>'P78_OK,P78_FLAG,P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68965592004635212921)
,p_event_id=>wwv_flow_api.id(68965591111347212912)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68965591376310212914)
,p_event_id=>wwv_flow_api.id(68965591111347212912)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68831018811527631560)
,p_name=>unistr('Verifica Dt Retorno Parc1 - Estagi\00E1rio')
,p_event_sequence=>1268
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC1'
,p_condition_element=>'P78_DT_RETORNO_PARC1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Pkg_Ferias.fnc_VerifVincEstagiario(pEmpresa   => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                  ,pMatricula => :P78_MATRICULA) = ''S'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68831018841381631561)
,p_event_id=>wwv_flow_api.id(68831018811527631560)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P78_MENSAGEM  := NULL;',
'  --',
'  vMsg := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                 ,pMatricula    => :P78_MATRICULA',
'                                                 ,pDtRetFerParc => :P78_DT_RETORNO_PARC1);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P78_MENSAGEM := REPLACE(REPLACE(vMsg, ''['', ''<strong>''), '']'',''</strong>'');',
'  END IF;',
'END;'))
,p_attribute_02=>'P78_MENSAGEM,P78_COD_EMPRESA,P78_COD_EMPRESA_1,P78_MATRICULA,P78_DT_RETORNO_PARC1_1'
,p_attribute_03=>'P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68831019008153631562)
,p_name=>unistr('Verifica Dt Retorno Parc2 - Estagi\00E1rio')
,p_event_sequence=>1278
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC2'
,p_condition_element=>'P78_DT_RETORNO_PARC2'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Pkg_Ferias.fnc_VerifVincEstagiario(pEmpresa   => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                  ,pMatricula => :P78_MATRICULA) = ''S'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68831019087473631563)
,p_event_id=>wwv_flow_api.id(68831019008153631562)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P78_MENSAGEM  := NULL;',
'  --',
'  vMsg := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                 ,pMatricula    => :P78_MATRICULA',
'                                                 ,pDtRetFerParc => :P78_DT_RETORNO_PARC2);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P78_MENSAGEM := REPLACE(REPLACE(vMsg, ''['', ''<strong>''), '']'',''</strong>'');',
'  END IF;',
'END;'))
,p_attribute_02=>'P78_MENSAGEM,P78_COD_EMPRESA,P78_COD_EMPRESA_1,P78_MATRICULA,P78_DT_RETORNO_PARC2'
,p_attribute_03=>'P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68831019234556631565)
,p_name=>unistr('Verifica Dt Retorno Parc3 - Estagi\00E1rio')
,p_event_sequence=>1288
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_RETORNO_PARC4'
,p_condition_element=>'P78_DT_RETORNO_PARC4'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Pkg_Ferias.fnc_VerifVincEstagiario(pEmpresa   => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                  ,pMatricula => :P78_MATRICULA) = ''S'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68831019360101631566)
,p_event_id=>wwv_flow_api.id(68831019234556631565)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vMsg    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P78_MENSAGEM  := NULL;',
'  --',
'  vMsg := Pkg_Ferias.fnc_ValDtRetFeriasEstagiario(pEmpresa      => NVL(:P78_COD_EMPRESA, :P78_COD_EMPRESA_1)',
'                                                 ,pMatricula    => :P78_MATRICULA',
'                                                 ,pDtRetFerParc => :P78_DT_RETORNO_PARC4);',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P78_MENSAGEM := REPLACE(REPLACE(vMsg, ''['', ''<strong>''), '']'',''</strong>'');',
'  END IF;',
'END;'))
,p_attribute_02=>'P78_MENSAGEM,P78_COD_EMPRESA,P78_COD_EMPRESA_1,P78_MATRICULA,P78_DT_RETORNO_PARC4'
,p_attribute_03=>'P78_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68754266392199835029)
,p_name=>unistr('Hide Per\00EDodo - Tipo Vinculo Func')
,p_event_sequence=>1298
,p_condition_element=>'P78_MATRICULA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'  FROM tipo_de_vinculo_func x',
' WHERE x.cod_empresa = :P78_COD_EMPRESA',
'   AND x.matricula   = :P78_MATRICULA',
'   AND x.codigo_tip NOT IN(1,3,4,8,9,13,10,14)',
'   AND x.cod_filial < 700',
'   AND :P_BASE = ''INCOR'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754266557068835031)
,p_event_id=>wwv_flow_api.id(68754266392199835029)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754266675905835032)
,p_event_id=>wwv_flow_api.id(68754266392199835029)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669312029245413680)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754267155990835037)
,p_event_id=>wwv_flow_api.id(68754266392199835029)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_MATRICULA,P78_COD_EMPRESA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754266440698835030)
,p_event_id=>wwv_flow_api.id(68754266392199835029)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Funcion\00E1rio Duplo Vinculo ou Exclusivo HC.</strong><br><i>Programar f\00E9rias pelo m\00F3dulo Colaborador HC</i>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(68754266782648835033)
,p_name=>unistr('Hide Per\00EDodo Recriar - Tipo Vinculo Func')
,p_event_sequence=>1308
,p_condition_element=>'P78_MAT_A'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'EXISTS'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT 1',
'  FROM tipo_de_vinculo_func x',
' WHERE x.cod_empresa = :P78_EMP_A',
'   AND x.matricula   = :P78_MAT_A',
'   AND x.codigo_tip NOT IN(1,3,4,8,9,13,10,14)',
'   AND x.cod_filial < 700',
'   AND :P_BASE = ''INCOR'''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754266842900835034)
,p_event_id=>wwv_flow_api.id(68754266782648835033)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754266982226835035)
,p_event_id=>wwv_flow_api.id(68754266782648835033)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(89669312029245413680)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(68754267076325835036)
,p_event_id=>wwv_flow_api.id(68754266782648835033)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('<strong>Funcion\00E1rio Duplo Vinculo ou Exclusivo HC.</strong><br><i>Recriar programa\00E7\00E3o de f\00E9rias pelo m\00F3dulo Colaborador HC</i>')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(67474149509005633319)
,p_name=>unistr('Mensagem e Fechar Regi\00E3o')
,p_event_sequence=>1318
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_ALERT_ACAO_JURIDICO'
,p_condition_element=>'P78_ALERT_ACAO_JURIDICO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_when_cond=>'P78_ALERT_ACAO_JURIDICO'
,p_display_when_cond2=>'S'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67474149613463633320)
,p_event_id=>wwv_flow_api.id(67474149509005633319)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('Colaborador com a\00E7\00E3o judicial de f\00E9rias, atendendo ao processo suas f\00E9rias s\00E3o compuls\00F3rias')
,p_attribute_07=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(67474149702940633321)
,p_event_id=>wwv_flow_api.id(67474149509005633319)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(202272281567918516588)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(61474206791841283749)
,p_name=>'Valida Saida de Ferias 1'
,p_event_sequence=>1328
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--RETURN :P78_DT_SAIDA_PARC1 = :P78_DT_1;',
'',
'IF :P78_DT_SAIDA_PARC1 != :P78_DT_1 THEN',
'  RETURN FALSE;',
'ELSE',
'  RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61474206938692283750)
,p_event_id=>wwv_flow_api.id(61474206791841283749)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_SAIDA_PARC1 := :P78_DT_1;'
,p_attribute_02=>'P78_DT_1'
,p_attribute_03=>'P78_DT_SAIDA_PARC1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(61474207008356283751)
,p_name=>'Valida Saida de Ferias 2'
,p_event_sequence=>1338
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--RETURN :P78_DT_SAIDA_PARC2 = :P78_DT_2;',
'',
'IF :P78_DT_SAIDA_PARC2 != :P78_DT_2 THEN',
'  RETURN FALSE;',
'ELSE',
'  RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61474207121424283752)
,p_event_id=>wwv_flow_api.id(61474207008356283751)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_SAIDA_PARC2 := :P78_DT_2;'
,p_attribute_02=>'P78_DT_2'
,p_attribute_03=>'P78_DT_SAIDA_PARC2'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(61474207274156283753)
,p_name=>'Valida Saida de Ferias 4'
,p_event_sequence=>1348
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_DT_4'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--RETURN :P78_DT_SAIDA_PARC4 = :P78_DT_4;',
'',
'IF :P78_DT_SAIDA_PARC4 != :P78_DT_4 THEN',
'  RETURN FALSE;',
'ELSE',
'  RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(61474207334140283754)
,p_event_id=>wwv_flow_api.id(61474207274156283753)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P78_DT_SAIDA_PARC2 := :P78_DT_2;'
,p_attribute_02=>'P78_DT_2'
,p_attribute_03=>'P78_DT_SAIDA_PARC2'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(44017081207358729830)
,p_name=>'if change show_hide item'
,p_event_sequence=>1378
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_SHOW_HIDE'
,p_condition_element=>'P78_SHOW_HIDE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(44017081223625729831)
,p_event_id=>wwv_flow_api.id(44017081207358729830)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//alert($v("P78_SHOW_HIDE"));',
'',
'var vshow=$v("P78_SHOW_HIDE");',
'',
'if (vshow=="HIDE"){',
'    $(''#PER'').hide();',
'    $(''#DADOS'').hide();',
'    $(''#P78_CREATE'').hide();',
'}else{',
'    $(''#PER'').show();',
'    $(''#DADOS'').show();',
'    $(''#P78_CREATE'').show();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(35229828969289007935)
,p_name=>'Carrega = 1'
,p_event_sequence=>1388
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_FERIAS_CARREGA'
,p_condition_element=>'P78_OPCAO_FERIAS_CARREGA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829038452007936)
,p_event_id=>wwv_flow_api.id(35229828969289007935)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829137074007937)
,p_event_id=>wwv_flow_api.id(35229828969289007935)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829276602007938)
,p_event_id=>wwv_flow_api.id(35229828969289007935)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829383308007939)
,p_event_id=>wwv_flow_api.id(35229828969289007935)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(35229829421257007940)
,p_name=>'Carrega = 0'
,p_event_sequence=>1398
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P78_OPCAO_FERIAS_CARREGA'
,p_condition_element=>'P78_OPCAO_FERIAS_CARREGA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829556994007941)
,p_event_id=>wwv_flow_api.id(35229829421257007940)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829762720007943)
,p_event_id=>wwv_flow_api.id(35229829421257007940)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_A'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(35229829876289007944)
,p_event_id=>wwv_flow_api.id(35229829421257007940)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P78_OPCAO_FERIAS_1'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669394153964413772)
,p_process_sequence=>40
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
'  where cod_empresa = :p78_COD_EMP_SOLICITANTE',
'    and matricula   = :p78_MATRICULA_SOLICITANTE;',
'',
' v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
'',
' if v_c1.colaborador is not null then',
'    :p78_solicitante := v_c1.colaborador;',
' end if;',
'',
':P78_MATRICULA_SOLIC := :P_MATRICULA_USER;',
':P78_EMP_SOLIC := :P_EMPRESA_USER;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669394565693413772)
,p_process_sequence=>50
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Seta T\00EDtulo')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_sit varchar2(30);',
'',
'begin',
'',
'   if :P78_SIT_REQUISICAO = 1 then',
'      v_sit := ''Aberta'';',
'elsif :P78_SIT_REQUISICAO = 2 then',
unistr('      v_sit := ''Conclu\00EDda'';'),
'elsif :P78_SIT_REQUISICAO = 3 then',
'      v_sit := ''Cancelada'';',
'elsif :P78_SIT_REQUISICAO = 4 then',
'      v_sit := ''Reprovada'';',
'elsif :P78_SIT_REQUISICAO = 5 then',
'      v_sit := ''Aprovada'';',
'elsif :P78_SIT_REQUISICAO = 6 then',
'      v_sit := ''Suspensa'';',
'end if;',
'',
'',
'if :p78_rowid is not null then',
unistr('   :p78_titulo := ''Requisi\00E7\00E3o de F\00E9rias: N\00BA ''||:p78_cod_solicitacao||'' - ''||:P78_DT_SOLICITACAO||'' (''||v_sit||'')'';'),
'else',
unistr('   :p78_titulo := ''Requisi\00E7\00E3o de F\00E9rias'';'),
'end if;',
'',
'if :p78_cod_solicitacao is null then',
'   :P78_TIPO_FERIAS1 := ''N'';',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669397362569413778)
,p_process_sequence=>60
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(Pesquisa) Popula Campos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_data_ini date;',
'',
'v_dias_direito number;',
'',
'cursor c1 is',
'select filial',
'  from informacoes_funcionais',
' where cod_empresa = :p78_cod_empresa',
'   and matricula = :p78_matricula;',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c3 (v_filial number) is',
'select qtd_parcelas',
'  from ferias_Parametros',
' where cod_empresa = :P78_cod_empresa',
'   and cod_filial = v_filial;',
'',
'v_c3 c3%rowtype;',
'',
'cursor c_req  is',
'select opcao_ferias',
'  from requisicao_ferias',
' where cod_solicitacao = :P78_cod_solicitacao;',
'',
'v_req c_req%rowtype;',
'',
'    CURSOR C_REQ_2(pdt_inic_per_ferias DATE) IS',
'    SELECT R.SIT_REQUISICAO COD_SIT_REQ, NVL(P.REQ_FERIAS_SUBS_CONCLUIDA,''N'') REQ_FERIAS_SUBS_CONCLUIDA',
'      FROM REQUISICAO_FERIAS R,',
'           PARAMETROS_RECURSOS_HUMANOS P',
'     WHERE R.COD_EMPRESA = P.COD_EMPRESA',
'       AND R.SIT_REQUISICAO = 2',
'       AND R.COD_EMPRESA = :P78_COD_EMPRESA',
'       AND R.MATRICULA = :P78_MATRICULA',
'       AND R.Dt_Inic_Per_Ferias = pdt_inic_per_ferias;',
'       ',
'    V_REQ_2 C_REQ_2%ROWTYPE;',
'    ',
'    cursor c_fer(pdt_inic_per_ferias DATE) IS',
'    SELECT ind_situacao_parc_1, ind_situacao_parc_2, ind_situacao_parc_4',
'      FROM FERIAS R',
'     WHERE R.COD_EMPRESA = :P78_COD_EMPRESA',
'       AND R.MATRICULA = :P78_MATRICULA',
'       AND R.Dt_Inic_Per_Ferias = pdt_inic_per_ferias;',
'       ',
'     v_fer c_fer%rowtype;',
'begin',
'',
'if :P78_COD_SOLICITACAO is not null then',
'',
':P78_OK := ''S'';',
'',
'open  c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
' :p78_filial := v_c1.filial;',
' ',
'open  c3(v_c1.filial);',
'fetch c3 into v_c3;',
'close c3;',
'',
' :p78_qtd_parcelas := v_c3.qtd_parcelas;',
' ',
'open c_req;',
'fetch c_req into v_req;',
'close c_req;',
' ',
'    EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'    BEGIN',
'    PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'    END;',
'',
'           begin',
'            select min(dt_inic_per_ferias)',
'            Into v_data_ini',
'            from requisicao_ferias ',
'            where cod_empresa   = :p78_cod_empresa',
'            and matricula       = :p78_matricula',
'            and cod_solicitacao = :p78_cod_solicitacao',
unistr('            and ind_situacao_periodo in (''P'',''R''); -- 1-Em andamento, 2-Conclu\00EDda, 3-Cancelada, 4-Reprovada, 5-Aprovada, 6-Cancelada pelo Ajuste dos Per\00EDodos'),
'           ',
'            open c_req_2(V_DATA_INI);',
'            fetch c_req_2 into v_req_2;',
'            close c_req_2;',
'            ',
'            open c_fer(V_DATA_INI);',
'            fetch c_fer into v_fer;',
'            close c_fer;',
'           ',
'           exception when no_data_found then',
'                    select min(dt_inic_per_ferias) ',
'                    Into v_data_ini',
'                    from ferias ',
'                    where cod_empresa = :p78_cod_empresa',
'                    and matricula = :p78_matricula',
'                    and ind_situacao_periodo in (''P'',''R'');',
'           end; ',
'',
'                IF NVL(V_REQ_2.REQ_FERIAS_SUBS_CONCLUIDA,''N'') = ''N'' THEN',
'                ',
'                                BEGIN',
'                                    select Nvl(dias_descanso_adicional,0)',
'                                         , saldo_bruto',
'                                         , saldo',
'                                         , ind_situacao_periodo',
'                                         , dt_inic_per_ferias',
'                                         , dt_fim_per_ferias ',
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then dt_saida_parc1 end  -- Igor 30/03/2023',
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then num_dias_parc1 end',
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then NVL(dias_abono_pec1,0) end',
unistr('                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then decode(opcao_13sal1,''S'',''Sim'',''N'',''N\00E3o'') end'),
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then desc_adicional1 end',
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then dt_retorno_parc1 end',
'                                         , case when v_fer.ind_situacao_parc_1 = ''C'' then tipo_ferias1 end',
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then dt_saida_parc2 end',
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then num_dias_parc2 end',
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then dias_abono_pec2 end',
unistr('                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then decode(opcao_13sal2,''S'',''Sim'',''N'',''N\00E3o'') end'),
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then desc_adicional2 end',
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then dt_retorno_parc2 end',
'                                         , case when v_fer.ind_situacao_parc_2 = ''C'' then tipo_ferias2 end',
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then dt_saida_parc4 end',
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then num_dias_parc4 end',
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then dias_abono_pec4 end',
unistr('                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then decode(opcao_13sal4,''S'',''Sim'',''N'',''N\00E3o'') end'),
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then desc_adicional4 end',
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then dt_retorno_parc4 end',
'                                         , case when v_fer.ind_situacao_parc_4 = ''C'' then tipo_ferias4 end',
'                                         , dt_saida_parc3',
'                                         , num_dias_parc3',
'                                         , dt_retorno_parc3',
'                                         , tipo_ferias3',
'                                       --  , DC_MATRICULA',
'                                         /*',
'                                         , cod_empresa',
'                                         , dt_solicitacao*/',
'                                         , falta_hora',
'                                         , falta_minuto',
'                                         --, opcao_ferias',
'                                      into :p78_dias_descanso_adicional',
'                                         , :p78_saldo_bruto',
'                                         , :p78_saldo',
'                                         , :p78_ind_situacao_periodo',
'                                         , :p78_dt_inic_per_ferias',
'                                         , :p78_dt_fim_per_ferias ',
'                                         , :p78_dt_saida_parc1_1',
'                                         , :p78_num_dias_parc1_1',
'                                         , :p78_dias_abono_pec1_1',
'                                         , :p78_opcao_13sal1_1',
'                                         , :p78_desc_adicional1_1',
'                                         , :p78_dt_retorno_parc1_1',
'                                         , :p78_tipo_ferias1_1',
'                                         , :p78_dt_saida_parc2_1',
'                                         , :p78_num_dias_parc2_1',
'                                         , :p78_dias_abono_pec2_1',
'                                         , :p78_opcao_13sal2_1',
'                                         , :p78_desc_adicional2_1',
'                                         , :p78_dt_retorno_parc2_1',
'                                         , :p78_tipo_ferias2_1',
'                                         , :p78_dt_saida_parc4_1',
'                                         , :p78_num_dias_parc4_1',
'                                         , :p78_dias_abono_pec4_1',
'                                         , :p78_opcao_13sal4_1',
'                                         , :p78_desc_adicional4_1',
'                                         , :p78_dt_retorno_parc4_1',
'                                         , :p78_tipo_ferias4_1',
'                                         , :p78_dt_saida_parc3',
'                                         , :p78_num_dias_parc3',
'                                         , :p78_dt_retorno_parc3',
'                                         , :p78_tipo_ferias3',
'                                         --, :P78_DC_MATRICULA',
'                                         /*',
'                                         , :p78_cod_empresa',
'                                         , :p78_dt_solicitacao*/',
'                                         , :p78_falta_hora',
'                                         , :p78_falta_minuto',
'                                         --, :p78_opcao_ferias',
'                                      from ferias',
'                                     where cod_empresa 				= :p78_cod_empresa',
'                                       and matricula   				= :p78_matricula   ',
'                                       and dt_inic_per_ferias = v_data_ini;',
'                                       --',
'                                       --',
'                             exception',
'                             when no_data_found then',
'                                   select Nvl(dias_descanso_adicional,0)',
'                                         , saldo_bruto',
'                                         , saldo',
'                                         , ind_situacao_periodo',
'                                         , dt_inic_per_ferias',
'                                         , dt_fim_per_ferias ',
'                                         , DC_MATRICULA',
'                                         , falta_hora',
'                                         , falta_minuto',
'                                         , opcao_ferias',
'                                      into :p78_dias_descanso_adicional',
'                                         , :p78_saldo_bruto',
'                                         , :p78_saldo',
'                                         , :p78_ind_situacao_periodo',
'                                         , :p78_dt_inic_per_ferias',
'                                         , :p78_dt_fim_per_ferias ',
'                                         , :P78_DC_MATRICULA',
'                                         , :p78_falta_hora',
'                                         , :p78_falta_minuto',
'                                         , :p78_opcao_ferias',
'                                      from requisicao_ferias',
'                                     where cod_empresa 				= :p78_cod_empresa',
'                                       and matricula   				= :p78_matricula   ',
'                                       and dt_inic_per_ferias = v_data_ini;',
'                         END;',
'                         ',
'             else',
'             ',
'                        BEGIN',
'                        select Nvl(dias_descanso_adicional,0)',
'                        , saldo_bruto',
'                        , saldo',
'                        , ind_situacao_periodo',
'                        , dt_inic_per_ferias',
'                        , dt_fim_per_ferias ',
'                        , falta_hora',
'                        , falta_minuto',
'                        , dc_matricula',
'                        into :p78_dias_descanso_adicional',
'                        , :p78_saldo_bruto',
'                        , :p78_saldo',
'                        , :p78_ind_situacao_periodo',
'                        , :p78_dt_inic_per_ferias',
'                        , :p78_dt_fim_per_ferias',
'                        , :p78_falta_hora',
'                        , :p78_falta_minuto',
'                        , :p78_dc_matricula',
'                        from ferias',
'                        where cod_empresa = :p78_cod_empresa',
'                        and matricula = :p78_matricula   ',
'                        and dt_inic_per_ferias = v_data_ini;',
'',
'                        EXCEPTION WHEN OTHERS THEN',
'                        :p78_flag := ''N'';',
'                        :p78_ok := ''N'';',
unistr('                        :p78_mensagem := ''N\00E3o h\00E1 per\00EDodos em aberto para a programa\00E7\00E3o! Solicite ao RH a cria\00E7\00E3o.'';'),
'',
'                        END;',
'             ',
'             END IF;',
'             ',
' v_dias_direito := Pkg_Atlz_Saldo_Ferias./*fnc_Ret*/Dias_Direito(:P78_COD_EMPRESA,:P78_MATRICULA,:P78_DT_INIC_PER_FERIAS,:P78_DT_FIM_PER_FERIAS);',
' IF v_dias_direito IS NULL THEN',
' if NVL(:p78_jornada_reduzida,''N'') = ''N'' then',
'      v_dias_direito := (30 - nvl(trim(:P78_saldo_bruto),0)) + (nvl(trim(:P78_saldo),0)); -- Humberto/Izidoro 29/09/2014',
' else',
'      v_dias_direito := (18 - nvl(trim(:P78_saldo_bruto),0)) + (nvl(trim(:P78_saldo),0)); -- Humberto/Izidoro 29/09/2014',
' end if;',
'    ',
' v_dias_direito := f_jornada_reduzida(:p78_cod_empresa,:p78_matricula,v_dias_direito,null); -- Rodrigo (Chamado 9869)',
' ',
' /*',
' :p78_opcao_ferias   := v_req.opcao_ferias;',
' :p78_opcao_ferias_1 := v_req.opcao_ferias;',
' */',
' ',
' if :p78_falta_hora > 7 and :p78_jornada_reduzida = ''S'' then -- Humberto/Izidoro 01/03/2016',
'      v_dias_direito := v_dias_direito / 2;',
' end if;',
' END IF;',
' :p78_DIAS_DIREITO := v_dias_direito;',
'',
'    if :p78_cod_solicitacao is null then',
'       :P78_TIPO_FERIAS1 := ''N'';',
'       :P78_TIPO_FERIAS2 := ''N'';',
'    end if;',
'',
'end if;',
'EXCEPTION WHEN OTHERS THEN',
'NULL;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P78_COD_SOLICITACAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669392208732413770)
,p_process_sequence=>70
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Parcelas Op\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select qtd_parcelas',
'  from ferias_parametros_parcelas',
' where cod_empresa = :p78_cod_empresa',
'   and cod_filial = :p78_filial',
'   and cod = nvl(:p78_opcao_ferias,:P78_OPCAO_FERIAS_A);',
'',
'v_c1 c1%rowtype;',
'',
'begin',
'',
' open c1;',
' fetch c1 into v_c1;',
' close c1;',
' ',
' :p78_parcelas_opc := v_c1.qtd_parcelas;',
' ',
' :p78_opcao_ferias_CARREGA := 1;',
' :p78_opcao_ferias_a := :p78_opcao_ferias_DB;',
' :p78_opcao_ferias_1 := :p78_opcao_ferias_DB;',
'end;',
''))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P78_ROWID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669391010709413767)
,p_process_sequence=>80
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Ativa BT Aprovar'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    FLG_RETORNO varchar2(3);',
'    MSG_RETORNO varchar2(4000);',
'    DIAS_ABONO_PEC2 number := :P78_DIAS_ABONO_PEC2;',
'    v_dias_direito number := :P78_DIAS_DIREITO;',
'    ',
'begin',
'    :P78_MSG_APROVAR := '''';',
'    if :P78_DT_SAIDA_PARC1 is not null and :p78_load = ''N'' then',
'        PKG_FERIAS.VALIDA_DT_SAIDA_PARC1(',
'            :P78_COD_EMPRESA,',
'            :P78_COD_SOLICITACAO,',
'            :P78_MATRICULA,',
'            :P78_DT_INIC_PER_FERIAS,',
'            :P78_DT_FIM_PER_FERIAS,',
'            :P78_DT_SAIDA_PARC2,',
'            :P78_SALDO_BRUTO,',
'            :P78_FALTA_HORA,',
'            v_dias_direito,',
'            :P78_DT_SAIDA_PARC1,',
'            :P78_SALDO,',
'            :P78_DIAS_ABONO_PEC1,',
'            :P78_NUM_DIAS_PARC1,',
'            :P78_OPCAO_13SAL1,',
'            :P78_OPCAO_13SAL2,',
'            :P78_TIPO_FERIAS1,',
'            :P78_DT_RETORNO_PARC1,',
'            :P78_DT_PAGTO_PARC1,',
'            :P78_JORNADA_REDUZIDA,',
'            :P78_IND_SITUACAO_PERIODO,',
'            :P78_DIAS_ABONO_PEC1_DSP,',
'            :P78_NUM_DIAS_PARC1_DSP,',
'            FLG_RETORNO,',
'            MSG_RETORNO);',
'        if trim(MSG_RETORNO) is not null and FLG_RETORNO = ''N'' then',
unistr('          :P78_MSG_APROVAR := ''Data de Sa\00EDda Parcela 1: ''||MSG_RETORNO;'),
'        end if;',
'    end if;',
'    if :P78_DT_SAIDA_PARC2 is not null and :p78_load = ''N'' and :P78_MSG_APROVAR is null then',
'        PKG_FERIAS.VALIDA_DT_SAIDA_PARC2(',
'            :P78_COD_EMPRESA,',
'            :P78_COD_SOLICITACAO,',
'            :P78_MATRICULA,',
'            :P78_DT_SAIDA_PARC1,',
'            :P78_DT_RETORNO_PARC1,',
'            :P78_NUM_DIAS_PARC1,',
'            :P78_DT_SAIDA_PARC2,',
'            :P78_DIAS_ABONO_PEC1,',
'            :P78_DT_INIC_PER_FERIAS,',
'            :P78_DT_FIM_PER_FERIAS,',
'            :P78_SALDO,',
'            v_dias_direito,',
'            :P78_DT_LIMITE_REQ,',
'            :P78_NUM_DIAS_PARC2,',
'            DIAS_ABONO_PEC2,',
'            :P78_DT_RETORNO_PARC2,',
'            :P78_DT_PAGTO_PARC2,',
'            :P78_TIPO_FERIAS2,',
'            :P78_OPCAO_13SAL2,',
'            :P78_DIAS_ABONO_PEC1_DSP,',
'            :P78_NUM_DIAS_PARC1_DSP,',
'            FLG_RETORNO,',
'            MSG_RETORNO);',
'',
'        if trim(MSG_RETORNO) is not null and FLG_RETORNO = ''N'' then',
unistr('          :P78_MSG_APROVAR := ''Data de Sa\00EDda Parcela 2: ''||MSG_RETORNO;'),
'        end if;',
'    end if;',
'    if :P78_DT_SAIDA_PARC4 is not null and :p78_load = ''N'' and :P78_MSG_APROVAR is null then',
'        PKG_FERIAS.VALIDA_DT_SAIDA_PARC4(',
'            :P78_COD_EMPRESA,',
'            :P78_COD_SOLICITACAO,',
'            :P78_MATRICULA,',
'            :P78_DT_SAIDA_PARC1,',
'            :P78_DT_RETORNO_PARC1,',
'            :P78_DT_SAIDA_PARC2,',
'            :P78_DT_RETORNO_PARC2,',
'            :P78_NUM_DIAS_PARC1,',
'            :P78_NUM_DIAS_PARC2,',
'            :P78_DT_SAIDA_PARC4,',
'            :P78_DIAS_ABONO_PEC1,',
'            :P78_DT_INIC_PER_FERIAS,',
'            :P78_DT_FIM_PER_FERIAS,',
'            :P78_SALDO,',
'            v_dias_direito,',
'            :P78_DT_LIMITE_REQ,',
'            :P78_NUM_DIAS_PARC4,',
'            :P78_DIAS_ABONO_PEC4,',
'            :P78_DT_RETORNO_PARC4,',
'            :P78_DT_PAGTO_PARC4,',
'            :P78_TIPO_FERIAS4,',
'            :P78_OPCAO_13SAL4,',
'            :P78_DIAS_ABONO_PEC1_DSP,',
'            :P78_NUM_DIAS_PARC1_DSP,',
'            FLG_RETORNO,',
'            MSG_RETORNO);',
'            ',
'        if trim(MSG_RETORNO) is not null and FLG_RETORNO = ''N'' then',
unistr('          :P78_MSG_APROVAR := ''Data de Sa\00EDda Parcela 3: ''||MSG_RETORNO;'),
'        end if;',
'    end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    nR number := 0;',
'begin',
'    if :P78_COD_SOLICITACAO is not null then',
'        select  count(*)',
'        into    nR',
'        from    APROVA_FERIAS A',
'        where   A.COD_SOLICITACAO = :P78_COD_SOLICITACAO;',
'    end if;',
'    return nR > 0;',
'end;'))
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669391373740413770)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PARA REQ NO MESMO PERIODO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P78_COD_EMPRESA := :P78_COD_EMPRESA_1;',
':P78_DT_INIC_PER_FERIAS := :P78_DT_INIC_PER_FERIAS_1;',
':P78_DT_FIM_PER_FERIAS := :P78_DT_FIM_PER_FERIAS_1;',
':P78_IND_SITUACAO_PERIODO := :P78_IND_SITUACAO_PERIODO_A;',
':P78_FALTA_HORA := :P78_FALTA_HORA_1;',
':P78_FALTA_MINUTO := :P78_FALTA_MINUTO_1;',
':P78_DIAS_DESCANSO_ADICIONAL := nvl(:P78_DIAS_DESCANSO_ADICIONAL,:P78_DIAS_DESCANSO_ADICIONAL_1);',
':P78_SALDO_BRUTO := :P78_SALDO_BRUTO_1;',
':P78_SALDO := :P78_SALDO_1;',
':P78_IND_SITUACAO_PARC_2 := nvl(:P78_IND_SITUACAO_PARC_2,:P78_IND_SITUACAO_PARC_2_A);',
':P78_IND_SITUACAO_PARC_4 := nvl(:P78_IND_SITUACAO_PARC_4,:P78_IND_SITUACAO_PARC_4_A);',
':P78_DIAS_DIREITO := :P78_DIAS_DIREITO_1;',
'if :p78_op is not null then -- Igor 30/03',
':P78_OPCAO_FERIAS := :P78_OP;',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_FLAG_CTRL,0) = 1;'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669392624240413770)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_dias_abono_pec1 number := :P78_dias_abono_pec1;',
'',
'v_seq number;',
'v_count number;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'',
'begin',
'',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
' 	:P78_sit_requisicao := ''1'';',
'	--',
'  loop',
'	  begin',
'		SELECT seq_requisicao.NEXTVAL',
'	  INTO v_seq ',
'	  FROM DUAL;',
'	  end;',
'    select count(*)',
'      into v_count',
'      from requisicao_ferias r',
'     where r.cod_solicitacao = v_seq;',
'    ',
'    if v_count = 0 then',
'      exit;',
'    end if;',
'  end loop;',
'  ',
'  :P78_cod_solicitacao := v_seq;',
'	--',
'',
'  IF :p78_dt_saida_parc1 IS NOT NULL THEN',
'  :p78_dias_abono_pec1 := nvl(:p78_dias_abono_pec1_lst,0); ',
'  end if;',
'',
'  IF :p78_dt_saida_parc2 IS NOT NULL THEN',
'  :p78_dias_abono_pec2 := nvl(:p78_dias_abono_pec2_lst,0); ',
'  end if;',
'',
'  IF :p78_dt_saida_parc4 IS NOT NULL THEN',
'  :p78_dias_abono_pec4 := nvl(:p78_dias_abono_pec4_lst,0); ',
'  end if;',
'      ',
'    IF nvl(:P78_dias_abono_pec1,0) = 0 THEN',
'      :P78_opcao_abono_pec1 := ''N'';',
'    ELSIF nvl(:P78_dias_abono_pec1,0) > 0 THEN',
'      :P78_opcao_abono_pec1 := ''S'';',
'    END IF;',
'',
'  IF nvl(:P78_OPCAO_ABONO_PEC1,''N'') = ''N'' THEN',
'     :P78_OPCAO_ABONO_PEC1 := ''N'';',
'  ELSE',
'     :P78_OPCAO_ABONO_PEC1 := ''S'';',
'  END IF;',
'      ',
'  IF nvl(:P78_OPCAO_ABONO_PEC2,''N'') = ''N'' AND :P78_DT_SAIDA_PARC2 IS NULL THEN',
'     :P78_OPCAO_ABONO_PEC2 := null;',
'     :P78_DT_RETORNO_PARC2 := NULL; -- Igor 30/03',
'     :P78_DT_PAGTO_PARC2 := NULL; -- Bruno Sousa 09/01/2024',
'  ELSE',
'         IF NVL(:P78_OPCAO_ABONO_PEC2,''N'') = ''N'' AND :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'            :P78_OPCAO_ABONO_PEC2 := ''N'';',
'      ELSIF NVL(:P78_OPCAO_ABONO_PEC2,''N'') = ''S'' AND :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'            :P78_OPCAO_ABONO_PEC2 := ''S'';',
'      END IF;',
'  END IF;',
'  ',
'  IF :P78_DT_SAIDA_PARC2 IS NULL THEN -- Bruno Sousa 09/01/2024',
'     :P78_OPCAO_13SAL2 := null;',
'     :P78_DT_RETORNO_PARC2 := NULL; -- Igor 30/03',
'     :P78_DT_RETORNO_PARC2_1 := NULL; -- Bruno Sousa 09/01/2024',
'     :P78_DT_PAGTO_PARC2 := NULL; -- Bruno Sousa 09/01/2024',
'  ELSE',
'         IF NVL(:P78_OPCAO_13SAL2,''N'') = ''N'' AND :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'            :P78_OPCAO_13SAL2 := ''N'';',
'      ELSIF NVL(:P78_OPCAO_13SAL2,''N'') = ''S'' AND :P78_DT_SAIDA_PARC2 IS NOT NULL THEN',
'            :P78_OPCAO_13SAL2 := ''S'';',
'      END IF;',
'  END IF;',
'',
'    IF nvl(:P78_dias_abono_pec4,0) = 0 and :P78_DT_SAIDA_PARC4 IS NOT NULL THEN',
'      :P78_opcao_abono_pec4 := ''N'';',
'    ELSIF nvl(:P78_dias_abono_pec4,0) > 0 and :P78_DT_SAIDA_PARC4 IS NOT NULL THEN',
'      :P78_opcao_abono_pec4 := ''S'';',
'    END IF;',
' ',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_create1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_create1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_OK,''N'') = ''S'';'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669395351799413772)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-INSERT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_dias_abono_pec1 number := :P78_dias_abono_pec1;',
'',
'v_seq number;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'v_dias_abono_pec FERIAS.dias_abono_pec1%TYPE;',
'CURSOR C1 IS',
'SELECT CAD_VAGA',
'  FROM INFORMACOES_FUNCIONAIS',
' WHERE COD_EMPRESA = :P78_COD_EMPRESA',
'   AND MATRICULA = :P78_MATRICULA;',
'   ',
'V_C1 C1%ROWTYPE;',
'',
'begin',
'',
'OPEN C1;',
'FETCH C1 INTO V_C1;',
'CLOSE C1;',
'',
'IF V_C1.CAD_VAGA IS NOT NULL THEN',
':P78_COD_VAGA := V_C1.CAD_VAGA;',
'END IF;',
'',
'NULL;',
'',
'IF :P78_HAVERA_REP IS NULL THEN',
':P78_HAVERA_REP := ''N'';',
'END IF;',
'',
'	:P78_dt_solicitacao := sysdate;',
'	:P78_DT_ATUALIZACAO_PROG := SYSDATE;',
'	:P78_USUARIO_PROG        := TO_CHAR(:P_EMPRESA_USER)||''/''||TO_CHAR(:P_MATRICULA_USER);',
'	:P78_cod_emp_solicitante := :P_EMPRESA_USER;',
'	:P78_matricula_solicitante := :P_MATRICULA_USER;',
'	:P78_usuario             := TO_CHAR(:P_EMPRESA_USER)||''/''||TO_CHAR(:P_MATRICULA_USER);--:P_USUARIO;',
'    :P78_dt_atualizacao      := sysdate;',
'',
'  :P78_DT_SIT_SOLICITACAO := sysdate;',
'v_dias_abono_pec := nvl(:p78_dias_abono_pec1,:p78_dias_abono_pec1_1);',
'PKG_FERIAS.Pre_Insert( :p78_cod_solicitacao,',
'                       nvl(:p78_cod_empresa,:P78_COD_EMPRESA_1),',
'                       :p78_filial,',
'                       :p78_matricula,',
'                       :p78_sit_requisicao,',
'                       nvl(:p78_ind_situacao_periodo,:p78_ind_situacao_periodo_a),',
'                       nvl(:p78_dt_inic_per_ferias,:p78_dt_inic_per_ferias_1),',
'                       nvl(:p78_dt_fim_per_ferias,:p78_dt_fim_per_ferias_1),',
'                       nvl(:p78_num_dias_parc1,:p78_num_dias_parc1_1),',
'                       nvl(:p78_saldo,:p78_saldo_1),',
'                       nvl(:p78_dt_saida_parc1,:p78_dt_saida_parc1_1),  ',
'                       nvl(:p78_dt_saida_parc2,:p78_dt_saida_parc2_1),',
'                       :p78_dt_saida_parc3, -- Igor 30/03',
'                       nvl(:p78_dt_saida_parc4,:p78_dt_saida_parc4_1),',
'                       nvl(:p78_dt_retorno_parc1,nvl(:p78_dt_retorno_parc1_1,NVL(:P78_DT_RETORNO_PARC1_1A, :P78_DT_RETORNO_PARC1_1_AUX))),',
'                       nvl(:p78_dt_retorno_parc2,:p78_dt_retorno_parc2_1),',
'                       :p78_dt_retorno_parc3, -- Igor 30/03',
'                       nvl(:p78_dt_retorno_parc4,:p78_dt_retorno_parc4_1),',
'                      :p78_opcao_13sal1,',
'                      :p78_opcao_13sal2,',
'                      :p78_opcao_13sal4,',
'                       v_dias_abono_pec,',
'                       :p78_jornada_reduzida,',
'                       v_flg_retorno,',
'                       v_msg_retorno,',
'					 :P78_PARCELAS_OPC);',
'            /*           ',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
'   ',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
'*/',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return nvl(:P78_OK,''N'') = ''S'';'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669396643057413776)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Valida_Update_Rf'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'v_dias_abono_pec1 number := :P78_dias_abono_pec1;',
'',
'v_item_validacao varchar2(20) := :P78_ITEM_VALIDACAO;',
'*/',
'begin',
'',
'null;',
'',
'/*',
'v_item_validacao := null;',
':P78_ITEM_VALIDACAO := null;',
'',
'PKG_FERIAS.Valida_Update_Rf(:P78_cod_empresa,',
'                            :P78_filial,',
'                            :P78_dt_saida_parc1,',
'                            :P78_dt_fim_per_ferias,',
'                            :P78_num_dias_parc1,',
'                            v_dias_abono_pec1,',
'                            :P78_saldo,',
'                            :p78_matricula,',
'                            :p78_jornada_reduzida,',
'                            V_flg_retorno,',
'                            V_msg_retorno);',
'',
'',
' if trim(v_msg_retorno) is not null then',
'',
'    if v_flg_retorno in (''N'',''Q'') then',
'        :P78_ok       := ''N'';',
'        :P78_ITEM_VALIDACAO := TRIM(UPPER(''p78_save1''));',
'    else',
'        :P78_ok       := ''S'';',
'    end if;',
'    ',
'    :P78_flag     := v_flg_retorno;',
'    :P78_mensagem := v_msg_retorno;',
' else',
'    :P78_flag     := null;',
'    :P78_mensagem := null;',
'    if v_item_validacao = TRIM(UPPER(''p78_save1'')) OR v_item_validacao IS NULL then',
'       :P78_OK := ''S'';',
'       :P78_ITEM_VALIDACAO := null;',
'    else',
'       :P78_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' */',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669311634907413680)
,p_process_when=>'return 1=1 and nvl(:P78_OK,''N'') = ''S'';'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669391833872413770)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-UPDATE (antes)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'	:P78_usuario             := TO_CHAR(:P_EMPRESA_USER)||''/''||TO_CHAR(:P_MATRICULA_USER);--:P_USUARIO;',
'    :P78_dt_atualizacao      := sysdate;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669311634907413680)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(84083120005373174838)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PARA REQ NO MESMO PERIODO_1'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P78_DT_SAIDA_PARC1 := nvl(:P78_DT_SAIDA_PARC1,:P78_DT_SAIDA_PARC1_1);',
':P78_NUM_DIAS_PARC1 := nvl(:P78_NUM_DIAS_PARC1,:P78_NUM_DIAS_PARC1_1);',
':P78_DIAS_ABONO_PEC1 := nvl(:P78_DIAS_ABONO_PEC1,:P78_DIAS_ABONO_PEC1_1);',
':P78_OPCAO_13SAL1 := nvl(:P78_OPCAO_13SAL1,:P78_OPCAO_13SAL1_1);',
':P78_DT_RETORNO_PARC1 := nvl(:P78_DT_RETORNO_PARC1,:P78_DT_RETORNO_PARC1_1);',
'',
':P78_DT_SAIDA_PARC2 := nvl(:P78_DT_SAIDA_PARC2,:P78_DT_SAIDA_PARC2_1);',
':P78_NUM_DIAS_PARC2 := nvl(:P78_NUM_DIAS_PARC2,:P78_NUM_DIAS_PARC2_1);',
':P78_DIAS_ABONO_PEC2 := nvl(:P78_DIAS_ABONO_PEC2,:P78_DIAS_ABONO_PEC2_1);',
':P78_OPCAO_13SAL2 := nvl(:P78_OPCAO_13SAL2,:P78_OPCAO_13SAL2_1);',
':P78_DT_RETORNO_PARC2 := nvl(:P78_DT_RETORNO_PARC2,:P78_DT_RETORNO_PARC2_1);'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_FLAG_CTRL,0) = 1;'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669394991201413772)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Automatic Row Processing'
,p_attribute_02=>'REQUISICAO_FERIAS'
,p_attribute_03=>'P78_ROWID'
,p_attribute_04=>'ROWID'
,p_attribute_09=>'P78_ROWID'
,p_attribute_11=>'I'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_OK,''N'') = ''S'';'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669396150494413773)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PRE-UPDATE (depois)'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'v_flg_retorno varchar2(3);',
'v_msg_retorno varchar2(4000);',
'',
'begin',
'',
'PKG_FERIAS.Pre_Update ( :p78_cod_solicitacao,',
'                       :p78_sit_requisicao,',
'                       :p78_dt_saida_parc1,',
'                       :p78_dt_saida_parc2,',
'                       :p78_dt_saida_parc3,',
'                       :p78_dt_saida_parc4,',
'                       :p78_dt_retorno_parc1,',
'                       :p78_dt_retorno_parc2,',
'                       :p78_dt_retorno_parc3,',
'                       :p78_dt_retorno_parc4,',
'                       :p78_usuario,',
'                       v_flg_retorno,',
'                       v_msg_retorno);',
'',
' if trim(v_msg_retorno) is not null and v_flg_retorno = ''N'' then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669311634907413680)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669395747197413772)
,p_process_sequence=>110
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
'PKG_FERIAS.Post_Insert(:P78_cod_empresa          ,',
'                       :P78_cod_solicitacao      ,',
'                       :p_usuario                ,',
'                       V_flg_retorno             ,',
'                       V_msg_retorno             );',
'',
'commit;',
'',
' if v_msg_retorno is not null then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_OK,''N'') = ''S'';'
,p_process_when_type=>'FUNCTION_BODY'
,p_process_success_message=>unistr('Requisi\00E7\00E3o criada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669396981281413777)
,p_process_sequence=>120
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
'PKG_FERIAS.Post_Update(:P78_cod_empresa          ,',
'                       :P78_cod_solicitacao      ,',
'                      V_flg_retorno             ,',
'                      V_msg_retorno             );',
'',
'commit;',
' ',
' if v_msg_retorno is not null then',
'    :p78_ok       := ''N'';',
'    :p78_flag     := v_flg_retorno;',
'    :p78_mensagem := v_msg_retorno;',
' else',
'    :p78_flag     := null;',
'    :p78_mensagem := null;',
'    :p78_ok       := ''S'';',
' end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669311634907413680)
,p_process_success_message=>unistr('Requisi\00E7\00E3o alterada com Sucesso!')
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(84083120182507174839)
,p_process_sequence=>130
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PARA REQ NO MESMO PERIODO_2'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    /* Comentado por Bruno Sousa 10/01/2024',
'    for C in (',
'        select  A.DT_RETORNO_PARC1,',
'                A.IND_SITUACAO_PARC_1,',
'                A.DT_RETORNO_PARC2,',
'                A.IND_SITUACAO_PARC_2',
'        from    REQUISICAO_FERIAS A',
'        where   A.COD_SOLICITACAO = :P78_COD_REQ ',
'    ) loop',
'        update  REQUISICAO_FERIAS A',
'        set     A.DT_RETORNO_PARC1      = nvl(A.DT_RETORNO_PARC1,C.DT_RETORNO_PARC1),',
'                A.IND_SITUACAO_PARC_1   = nvl(A.IND_SITUACAO_PARC_1,C.IND_SITUACAO_PARC_1),',
'                A.DT_RETORNO_PARC2      = nvl(A.DT_RETORNO_PARC2,C.DT_RETORNO_PARC2),',
'                A.IND_SITUACAO_PARC_2   = nvl(A.IND_SITUACAO_PARC_2,C.IND_SITUACAO_PARC_2)',
'        where   A.ROWID = :P78_ROWID;',
'    end loop;',
'    */',
'    update  REQUISICAO_FERIAS A',
'    set     A.SIT_REQUISICAO = 3',
'    where   A.SIT_REQUISICAO = 1',
'    and     A.ROWID != :P78_ROWID',
'    and     A.COD_EMPRESA = :P78_COD_EMPRESA',
'    AND     A.MATRICULA = :P78_MATRICULA',
'    and     exists (',
'                        select  1',
'                        from    REQUISICAO_FERIAS B',
'                        where B.COD_SOLICITACAO = :P78_COD_REQ',
'                        and     B.COD_EMPRESA = A.COD_EMPRESA',
'                        and     B.MATRICULA = A.MATRICULA',
'                        and     to_date(B.DT_INIC_PER_FERIAS,''DD/MM/RRRR'') = to_date(A.DT_INIC_PER_FERIAS,''DD/MM/RRRR'')',
'                    );',
'    /* Comentado por Bruno Sousa 15/09/2026 - ch46228',
'    if :p78_dt_saida_Parc2 is null then -- Igor 30/03/2023',
'      ',
'      update requisicao_ferias',
'         set dt_saida_parc2 = null,',
'             num_dias_parc2 = null,',
'             dias_abono_pec2 = null,',
'             opcao_13sal2 = null,',
'             desc_adicional2 = null,',
'             dt_retorno_parc2 = null,',
'             tipo_ferias2 = null',
'       where cod_solicitacao = :P78_COD_REQ;',
'       ',
'       commit;',
'    ',
'    end if;',
'    ',
'    if :p78_dt_saida_Parc4 is null then  -- Igor 30/03/2023',
'      ',
'      update requisicao_ferias',
'         set dt_saida_parc4 = null,',
'             num_dias_parc4 = null,',
'             dias_abono_pec4 = null,',
'             opcao_13sal4 = null,',
'             desc_adicional4 = null,',
'             dt_retorno_parc4 = null,',
'             tipo_ferias4 = null',
'       where cod_solicitacao = :P78_COD_REQ;',
'       ',
'       commit;',
'    ',
'    end if;',
'    */',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(89669312029245413680)
,p_process_when=>'return 1=1 and nvl(:P78_FLAG_CTRL,0) = 1;'
,p_process_when_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669397785598413780)
,p_process_sequence=>140
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'formato data dt_atualizacao'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P78_COD_SOLICITACAO is not null then',
'',
'    begin',
'    update requisicao_ferias',
'    set dt_atualizacao = sysdate, dt_atualizacao_prog = sysdate',
'    where COD_SOLICITACAO = :P78_COD_SOLICITACAO;',
'',
'    commit;',
'',
'    end;',
'',
'end if;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NEVER'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(59466411915452025523)
,p_process_sequence=>150
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'AJUSTA_SOLICITANTE'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor C_dados is',
'SELECT MATRICULA_SOLICITANTE ',
'FROM REQUISICAO_FERIAS',
'where COD_SOLICITACAO = :P78_cod_solicitacao;',
'',
'V_valida_mat number;',
'',
'begin',
'',
'',
'OPEN C_dados;',
'FETCH  C_dados INTO V_valida_mat;',
'CLOSE  C_dados;',
'',
'if V_valida_mat is null then ',
'   update REQUISICAO_FERIAS set MATRICULA_SOLICITANTE = :P78_MATRICULA_SOLIC',
'                             ,  COD_EMP_SOLICITANTE = :P78_EMP_SOLIC',
'    where COD_SOLICITACAO = :P78_cod_solicitacao;',
'  commit;',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669393432566413771)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'usuario'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_usuario varchar2(40);',
'begin',
'',
'    EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'',
'    BEGIN',
'    PKG_IDIOMA.SETA_IDIOMA(''AMERICAN'');',
'    END;',
'',
'    if :p78_matricula is not null then',
'    :p78_emp := :p78_cod_empresa;',
'    :p78_mat := :p78_matricula;',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669393030619413771)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Automatic Row Fetch requsicao_ferias'
,p_attribute_02=>'REQUISICAO_FERIAS'
,p_attribute_03=>'P78_COD_EMPRESA'
,p_attribute_04=>'COD_EMPRESA'
,p_attribute_05=>'P78_COD_SOLICITACAO'
,p_attribute_06=>'COD_SOLICITACAO'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P78_COD_SOLICITACAO'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(89669393829105413771)
,p_process_sequence=>30
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'popula_colab'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is',
'select i.cod_empresa||'' - ''||initcap(fnct_nome_empresa(i.cod_empresa)) empresa,',
'       i.matricula||'' - ''||initcap(fnct_nome_func(i.cod_empresa, i.matricula)) matricula,',
'       i.situacao||'' - ''||initcap(fnct_nome_situacao(i.situacao))||'' - ''||i.dt_situacao situacao,',
'       i.dt_admissao,',
'       I.FILIAL,',
'       i.dc_matricula,',
'       I.VINCULO',
'  from informacoes_funcionais_cad i',
' where i.cod_empresa = :p78_cod_empresa',
'   and i.matricula = :p78_matricula;',
'                   ',
'v_c1 c1%rowtype;',
'',
'',
'cursor c3 (v_filial number) is',
'select qtd_parcelas',
'  from ferias_Parametros',
' where cod_empresa = :P78_cod_empresa',
'   and cod_filial = v_filial;',
'   ',
'v_c3 c3%rowtype;',
'',
'CURSOR C4 IS',
'SELECT CAD_VAGA',
'  FROM INFORMACOES_FUNCIONAIS',
' WHERE COD_EMPRESA = :P78_COD_EMPRESA',
'   AND MATRICULA = :P78_MATRICULA;',
'   ',
'V_C4 C4%ROWTYPE;',
'',
'begin',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p78_cod_empresa_display := v_c1.empresa;',
':p78_matricula_display := v_c1.matricula;',
':p78_situacao_colab := v_c1.situacao;',
':p78_dt_admissao := v_c1.dt_admissao;',
':p78_dc_matricula := v_c1.dc_matricula;',
'',
'if :p78_cod_solicitacao is null then',
'   :P78_TIPO_FERIAS1 := ''N'';',
'end if;',
'',
'open  c3(v_c1.filial);',
'fetch c3 into v_c3;',
'close c3;',
'',
':p78_qtd_parcelas := v_c3.qtd_parcelas;',
'',
'if :P78_ROWID is null and :p78_cod_solicitacao is not null then',
':p78_cod_solicitacao := null;',
'end if;',
'',
'OPEN C4;',
'FETCH C4 INTO V_C4;',
'CLOSE C4;',
'',
'IF V_C4.CAD_VAGA IS NOT NULL THEN',
':P78_COD_VAGA := V_C4.CAD_VAGA;',
'END IF;',
'',
':P78_VINCULO := V_C1.VINCULO;',
'',
'if :p78_rowid is not null then',
'  :p78_load := ''S'';',
'else',
'  :p78_load := ''N'';',
'end if;',
'exception',
'when others then',
':p78_cod_empresa_display := :p78_cod_empresa;',
':p78_matricula_display := :p78_matricula;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(68478747443835639641)
,p_process_sequence=>40
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Dias Direito Formato'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_dias_number number;',
'    v_dias_char varchar2(10) := :P78_DIAS_DIREITO; -- Igor 30/03',
'begin',
'',
'    if instr(v_dias_char,''.'') > 0 then',
'       v_dias_number := replace(v_dias_char,''.'','','');',
'       :P78_DIAS_DIREITO := v_dias_number;',
'       :P78_DIAS_DIREITO_1 := v_dias_number;',
'    end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(68478747555316639642)
,p_process_sequence=>50
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Dias Direito OPC Formato'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_dias_number number;',
'    v_dias_char varchar2(10) := :P78_DIAS_DIREITO_OPC; -- Igor 30/03',
'begin',
'',
'    if instr(v_dias_char,''.'') > 0 then',
'       v_dias_number := replace(v_dias_char,''.'','','');',
'       :P78_DIAS_DIREITO_OPC := v_dias_number;',
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
