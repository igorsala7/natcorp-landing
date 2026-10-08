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
,p_default_workspace_id=>2159612644338390
,p_default_application_id=>207
,p_default_id_offset=>784870462376069010
,p_default_owner=>'RHREDEFLEX'
);
end;
/
 
prompt APPLICATION 207 - Painel do Operador - Natcorp
--
-- Application Export:
--   Application:     207
--   Name:            Painel do Operador - Natcorp
--   Date and Time:   19:26 Tuesday September 29, 2026
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
,p_user_interface_id=>wwv_flow_api.id(281503592036917360625)
,p_name=>unistr('Editar: Requisi\00E7\00E3o de Pessoal')
,p_step_title=>unistr('Editar: Requisi\00E7\00E3o de Pessoal')
,p_allow_duplicate_submissions=>'N'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'ON'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#jquery.maskedinput.min.js',
'#WORKSPACE_IMAGES#forms-functions.js',
'#WORKSPACE_IMAGES#jquery.maskMoney.min.js'))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'   apex.item("P52_VAGA_CONFIDENCIAL").disable();',
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
'//   apex.item("P52_MARCA_PONTO_1").disable(); Campo inexistente (Cibele)',
unistr('//   apex.item("P52_TP_REGISTRO_PONTO_1").disable(); Comentado por Cibele, pois esse campo n\00E3o existia na p\00E1gina'),
'   apex.item("P52_DATA_INICIO_1").disable();',
'   apex.item("P52_DATA_FIM_1").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL_1").disable();',
'   apex.item("P52_COD_HORARIO_1").disable();',
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
'   apex.item("P52_DATA_INICIO").disable();',
'   apex.item("P52_DATA_FIM").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").disable();',
'//apex.item("P52_COD_HORARIO").disable();',
'  // apex.item("P52_COD_HORARIO_1").disable();',
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
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'img { height: 100px }',
'',
'.apagar{',
'  min-width: 74px;',
'  max-width: 74px;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CIBELE.CRISTINA'
,p_last_upd_yyyymmddhh24miss=>'20250130190835'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(269956581602926880645)
,p_plug_name=>unistr('Requisi\00E7\00F5es Descendentes')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(269956580739432880637)
,p_name=>unistr('Requisi\00E7\00F5es')
,p_parent_plug_id=>wwv_flow_api.id(269956581602926880645)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select r.cod_req||'' (''||initcap(s.desc_sit_req)||'')'' requisicao, cod_req, cod_empresa',
'  from requisicao r, sit_req s',
' where r.cod_req_pai = :p52_cod_req',
'   and r.cod_sit_req = s.cod_sit_req',
'order by r.cod_req'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(269956581192537880641)
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
 p_id=>wwv_flow_api.id(269956581304963880642)
,p_query_column_id=>2
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269956581375458880643)
,p_query_column_id=>3
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(270154899688628193875)
,p_plug_name=>'Colaborador Inscrito'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>150
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(270227838255752025669)
,p_plug_name=>'Candidato Inscrito'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>160
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272434722002950675648)
,p_plug_name=>unistr('Forma\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>120
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272434722975513675657)
,p_plug_name=>unistr('Experi\00EAncia')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>130
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272434723645434675664)
,p_plug_name=>'Conhecimento'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>140
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281750712762204375345)
,p_plug_name=>'Avaliar Candidatos'
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>210
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281750981966006977807)
,p_name=>'Candidatos'
,p_parent_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_template=>wwv_flow_api.id(281503566040079360531)
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840790881104105013)
,p_query_column_id=>1
,p_column_alias=>'NOTA_DE_CORTE'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840791317420105015)
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
 p_id=>wwv_flow_api.id(271840791757136105015)
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
 p_id=>wwv_flow_api.id(271840792152328105016)
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
 p_id=>wwv_flow_api.id(271840792461643105017)
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
 p_id=>wwv_flow_api.id(271840792895709105018)
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
 p_id=>wwv_flow_api.id(281804530735846896792)
,p_plug_name=>'Idioma'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>100
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281820631438198389953)
,p_plug_name=>unistr('Informa\00E7\00F5es do Cargo')
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>170
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281826253952399785188)
,p_plug_name=>'Processo Seletivo'
,p_region_template_options=>'#DEFAULT#:js-dialog-size720x480:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>180
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281827490032502106561)
,p_name=>'Acompanhamento de Candidatos'
,p_template=>wwv_flow_api.id(281503564609400360528)
,p_display_sequence=>190
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840774532854104986)
,p_query_column_id=>1
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>1
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840774935591104988)
,p_query_column_id=>2
,p_column_alias=>'STATUS_CANDIDATO'
,p_column_display_sequence=>2
,p_column_heading=>'Status Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840775340921104989)
,p_query_column_id=>3
,p_column_alias=>'FASE'
,p_column_display_sequence=>3
,p_column_heading=>'Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840775688444104990)
,p_query_column_id=>4
,p_column_alias=>'DT_FASE'
,p_column_display_sequence=>4
,p_column_heading=>'Data Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840776100934104990)
,p_query_column_id=>5
,p_column_alias=>'AVALIADOR'
,p_column_display_sequence=>5
,p_column_heading=>'Avaliador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840776520200104991)
,p_query_column_id=>6
,p_column_alias=>'NOTA'
,p_column_display_sequence=>6
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840776907389104992)
,p_query_column_id=>7
,p_column_alias=>'RESULTADO_FASE'
,p_column_display_sequence=>7
,p_column_heading=>'Resultado Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840777272468104993)
,p_query_column_id=>8
,p_column_alias=>'MOT_AVAL_FASE'
,p_column_display_sequence=>9
,p_column_heading=>'Mot. Aval. Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840777724121104994)
,p_query_column_id=>9
,p_column_alias=>'AVALIACAO'
,p_column_display_sequence=>8
,p_column_heading=>unistr('Avalia\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840778135098104994)
,p_query_column_id=>10
,p_column_alias=>'DATA_AVAL_FASE'
,p_column_display_sequence=>10
,p_column_heading=>'Data Aval. Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840778491237104995)
,p_query_column_id=>11
,p_column_alias=>'APROVADO'
,p_column_display_sequence=>11
,p_column_heading=>'Aprovado'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281827654111486966358)
,p_name=>'Fases do Processo'
,p_template=>wwv_flow_api.id(281503564609400360528)
,p_display_sequence=>200
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840780052136104997)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840780406369104998)
,p_query_column_id=>2
,p_column_alias=>'COD_PROCESSO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840780796067104999)
,p_query_column_id=>3
,p_column_alias=>'FASE'
,p_column_display_sequence=>3
,p_column_heading=>'Fase'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840781164452105000)
,p_query_column_id=>4
,p_column_alias=>'NOTA_DE_CORTE'
,p_column_display_sequence=>11
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840781657009105000)
,p_query_column_id=>5
,p_column_alias=>'DT_INICIO_FASE'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Data In\00EDcio')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840782042335105001)
,p_query_column_id=>6
,p_column_alias=>'DT_FIM_FASE'
,p_column_display_sequence=>5
,p_column_heading=>'Data Fim'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840782453956105002)
,p_query_column_id=>7
,p_column_alias=>'STATUS'
,p_column_display_sequence=>6
,p_column_heading=>'Status'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840782839264105003)
,p_query_column_id=>8
,p_column_alias=>'ENTIDADE'
,p_column_display_sequence=>7
,p_column_heading=>'Entidade'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840783189281105004)
,p_query_column_id=>9
,p_column_alias=>'SLA'
,p_column_display_sequence=>8
,p_column_heading=>'SLA'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840783639397105005)
,p_query_column_id=>10
,p_column_alias=>'OBSERVACAO'
,p_column_display_sequence=>9
,p_column_heading=>unistr('Observa\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840784007015105006)
,p_query_column_id=>11
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>10
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840784383193105007)
,p_query_column_id=>12
,p_column_alias=>'NOTA'
,p_column_display_sequence=>12
,p_column_heading=>'Nota'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840784790762105008)
,p_query_column_id=>13
,p_column_alias=>'DATA_FASE_CANDIDATO'
,p_column_display_sequence=>13
,p_column_heading=>'Data Fase Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281852568441376374245)
,p_plug_name=>'Escolha: Ferramentas de Apoio / Equipamentos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>110
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281920565544946202292)
,p_plug_name=>'Cursos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281920642780294084087)
,p_plug_name=>'Cargos'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281920727594875953372)
,p_plug_name=>'Tarefas'
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>80
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281920729180052953388)
,p_plug_name=>unistr('Caracter\00EDsticas')
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight:js-dialog-size480x320'
,p_plug_template=>wwv_flow_api.id(281503564609400360528)
,p_plug_display_sequence=>90
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961127550877907666)
,p_plug_name=>unistr('Navega\00E7\00E3o')
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody:t-Form--slimPadding'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_api.id(281404602550938696386)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_api.id(281503587327674360576)
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961127916819907672)
,p_plug_name=>unistr('Requisi\00E7\00E3o de Pessoal')
,p_region_name=>'REQUISICAO_PESSOAL'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noUI:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>50
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(270154898143355193859)
,p_name=>'Colaboradores Inscritos'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>280
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_no_data_found=>'Clique em + Adicionar'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154898935495193867)
,p_query_column_id=>1
,p_column_alias=>'EMPRESA'
,p_column_display_sequence=>3
,p_column_heading=>'Empresa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154898957939193868)
,p_query_column_id=>2
,p_column_alias=>'FILIAL'
,p_column_display_sequence=>4
,p_column_heading=>'Filial'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899129643193869)
,p_query_column_id=>3
,p_column_alias=>'CCUSTO'
,p_column_display_sequence=>5
,p_column_heading=>'Centro de Custo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899171339193870)
,p_query_column_id=>4
,p_column_alias=>'COLABORADOR'
,p_column_display_sequence=>6
,p_column_heading=>'Colaborador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899276517193871)
,p_query_column_id=>5
,p_column_alias=>'CARGO'
,p_column_display_sequence=>7
,p_column_heading=>'Cargo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154898277485193861)
,p_query_column_id=>6
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899420357193872)
,p_query_column_id=>7
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899516679193873)
,p_query_column_id=>8
,p_column_alias=>'MATRICULA'
,p_column_display_sequence=>9
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154899597505193874)
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
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270154898769006193866)
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
 p_id=>wwv_flow_api.id(270227836104693025647)
,p_name=>'Candidatos Inscritos'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>290
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(270227838231376025668)
,p_query_column_id=>1
,p_column_alias=>'CANDIDATO'
,p_column_display_sequence=>2
,p_column_heading=>'Candidato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270227836267748025649)
,p_query_column_id=>2
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270227837042860025656)
,p_query_column_id=>3
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270227837919135025665)
,p_query_column_id=>4
,p_column_alias=>'COD_CANDIDATO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(270227838001832025666)
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
 p_id=>wwv_flow_api.id(270227838145635025667)
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
 p_id=>wwv_flow_api.id(270227836374720025650)
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
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597493756528930)
,p_plug_name=>unistr('Frequ\00EAncia')
,p_region_name=>'FREQUENCIA'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>70
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597559605528931)
,p_plug_name=>'Cargo'
,p_region_name=>'CARGO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>60
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597612497528932)
,p_plug_name=>unistr('Remunera\00E7\00E3o')
,p_region_name=>'REMUNERACAO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>80
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597777183528933)
,p_plug_name=>unistr('Informa\00E7\00F5es da Vaga')
,p_region_name=>'VAGA'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>40
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597859063528934)
,p_plug_name=>unistr('Vaga Fatur\00E1vel')
,p_region_name=>'VAGA_FATURAVEL'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>120
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433597954961528935)
,p_plug_name=>unistr('Caracter\00EDsticas do Candidato')
,p_region_name=>'CARACTERISTICA_CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>140
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598043166528936)
,p_plug_name=>'Idade'
,p_parent_plug_id=>wwv_flow_api.id(272433597954961528935)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598105498528937)
,p_plug_name=>'Sexo'
,p_parent_plug_id=>wwv_flow_api.id(272433597954961528935)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598287516528938)
,p_plug_name=>unistr('Tempo de Servi\00E7o')
,p_parent_plug_id=>wwv_flow_api.id(272433597954961528935)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598318241528939)
,p_plug_name=>'PCD'
,p_parent_plug_id=>wwv_flow_api.id(272433597954961528935)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>50
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598614469528942)
,p_plug_name=>unistr('Grau de Instru\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(272433597954961528935)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598437829528940)
,p_plug_name=>'Insalubridade / Periculosidade'
,p_region_name=>'INSALUBRIDADE'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>90
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>4
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598502862528941)
,p_plug_name=>'Contrato'
,p_region_name=>'CONTRATO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>110
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433598783792528943)
,p_plug_name=>unistr('Indica\00E7\00E3o de Candidato')
,p_region_name=>'INDICACAO_CANDIDATO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>150
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(272433600701182528962)
,p_plug_name=>'Projeto'
,p_region_name=>'PROJETO'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>100
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(272433601362785528969)
,p_name=>unistr('Cursos / Certificados Necess\00E1rios')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>170
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840806895289105036)
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
 p_id=>wwv_flow_api.id(271840807314103105038)
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
 p_id=>wwv_flow_api.id(271840807725871105039)
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
 p_id=>wwv_flow_api.id(271840808134870105040)
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
 p_id=>wwv_flow_api.id(271840808547257105041)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840808874680105042)
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
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(272433602311275528979)
,p_name=>unistr('Experi\00EAncia')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>180
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840810774206105046)
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
 p_id=>wwv_flow_api.id(271840811255185105046)
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
 p_id=>wwv_flow_api.id(271840811626626105047)
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
 p_id=>wwv_flow_api.id(271840811982015105048)
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
 p_id=>wwv_flow_api.id(271840810017051105044)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840810404728105045)
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
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(272434721058219675638)
,p_name=>'Conhecimento'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>190
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>6
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840813148031105049)
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
 p_id=>wwv_flow_api.id(271840813485860105050)
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
 p_id=>wwv_flow_api.id(271840813880136105051)
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
 p_id=>wwv_flow_api.id(271840814329394105052)
,p_query_column_id=>4
,p_column_alias=>'SEQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840814566645105052)
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
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281621044957723224237)
,p_plug_name=>unistr('Indica\00E7\00E3o Para Avaliar Requisi\00E7\00E3o')
,p_region_name=>'INDICACAO_AVALIAR'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>130
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281621045247316224240)
,p_plug_name=>'Gestor'
,p_parent_plug_id=>wwv_flow_api.id(281621044957723224237)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281621045305921224241)
,p_plug_name=>'Avaliador'
,p_parent_plug_id=>wwv_flow_api.id(281621044957723224237)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281804182334824979127)
,p_name=>unistr('Idiomas Necess\00E1rios')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>200
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_grid_column_span=>6
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840823388424105061)
,p_query_column_id=>1
,p_column_alias=>'IDIOMA'
,p_column_display_sequence=>2
,p_column_heading=>'Idioma'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840823789536105062)
,p_query_column_id=>2
,p_column_alias=>'NIVEL_CONHECIMENTO'
,p_column_display_sequence=>3
,p_column_heading=>'Nivel conhecimento'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840824207649105062)
,p_query_column_id=>3
,p_column_alias=>'SEQ'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840824649711105063)
,p_query_column_id=>4
,p_column_alias=>'COD_IDIOMA'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840825026787105064)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from IDIOMA_REQ_PESSOAL where seq = #SEQ# and cod_idioma = #COD_IDIOMA#,delete from IDIOMA_REQ_PESSOAL where cod_req = &P52_COD_REQ. and cod_idioma ='
||' #COD_IDIOMA#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_IDIOMA#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281919441456386243115)
,p_name=>unistr('Forma\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>160
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840826061851105065)
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
 p_id=>wwv_flow_api.id(271840826480711105066)
,p_query_column_id=>2
,p_column_alias=>'INSTRUCAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Instru\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
end;
/
begin
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840826949977105067)
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
 p_id=>wwv_flow_api.id(271840827305327105068)
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
 p_id=>wwv_flow_api.id(271840827721237105068)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840828090929105069)
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
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281919441882242243119)
,p_name=>unistr('Experi\00EAncia em Cargos')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>270
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840846894687105095)
,p_query_column_id=>1
,p_column_alias=>'CARGO'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840847269432105096)
,p_query_column_id=>2
,p_column_alias=>'NOME_CARGO'
,p_column_display_sequence=>2
,p_column_heading=>'Cargo'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840847661509105097)
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
 p_id=>wwv_flow_api.id(271840848101282105098)
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
 p_id=>wwv_flow_api.id(271840848489842105099)
,p_query_column_id=>5
,p_column_alias=>'COD_EMPRESA'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840848872113105099)
,p_query_column_id=>6
,p_column_alias=>'COD_CARGO'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840849357332105100)
,p_query_column_id=>7
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_COMANDO_1,P777_TITULO:delete from rp_cargo where cod_empresa = #COD_EMPRESA# and cod_cargo = #COD_CARGO# and cargo = #CARGO#,Apagando'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CARGO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_display_when_cond_type=>'ITEM_IS_NULL'
,p_display_when_condition=>'P52_COD_PREST_SERV'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281920563933816202275)
,p_name=>unistr('Tarefas que ir\00E1 desempenhar')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>230
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840850381361105101)
,p_query_column_id=>1
,p_column_alias=>'COD_TAREFA_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840850832362105102)
,p_query_column_id=>2
,p_column_alias=>'DESC_TAREFA_REQ'
,p_column_display_sequence=>3
,p_column_heading=>'Tarefa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840851243955105103)
,p_query_column_id=>3
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840851599592105104)
,p_query_column_id=>4
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840851986437105105)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840852362993105105)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from tar_peso_temp where seq = #SEQ# and cod_tarefa_req = #COD_TAREFA_REQ#,delete from tar_peso_temp where cod_req = &p52_cod_req. and cod_tarefa_req'
||' = #COD_TAREFA_REQ#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281920564848685202285)
,p_name=>unistr('Caracter\00EDsticas para desempenho da fun\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>210
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840829228067105071)
,p_query_column_id=>1
,p_column_alias=>'COD_CARAC_FUNC'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840829627459105073)
,p_query_column_id=>2
,p_column_alias=>'DESC_CARAC_FUNC'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Caracter\00EDstica')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840829990286105073)
,p_query_column_id=>3
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840830373582105074)
,p_query_column_id=>4
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840830774626105075)
,p_query_column_id=>5
,p_column_alias=>'SEQ'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840831234637105076)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from carac_peso_temp where seq = #SEQ# and cod_carac_func = #COD_CARAC_FUNC#,delete from carac_peso_temp where cod_req = &p52_cod_req. and cod_carac_'
||'func = #COD_CARAC_FUNC#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_CARAC_FUNCAO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281920644686851084106)
,p_name=>unistr('Tarefas que ir\00E1 desempenhar')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>240
,p_include_in_reg_disp_sel_yn=>'Y'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_new_grid_column=>false
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840832285171105077)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840832665856105078)
,p_query_column_id=>2
,p_column_alias=>'COD_TAREFA_REQ'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840833111013105079)
,p_query_column_id=>3
,p_column_alias=>'DESC_TAREFA_REQ'
,p_column_display_sequence=>4
,p_column_heading=>'Tarefa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840833527299105079)
,p_query_column_id=>4
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840833927943105080)
,p_query_column_id=>5
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271331917650405503418)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from tar_peso where cod_req = &P52_COD_REQ. and cod_tarefa_req = #COD_TAREFA_REQ#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_TAREFA_REQ#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281920645461369084114)
,p_name=>unistr('Caracter\00EDsticas para desempenho da fun\00E7\00E3o')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840834999356105081)
,p_query_column_id=>1
,p_column_alias=>'COD_REQ'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840835456876105082)
,p_query_column_id=>2
,p_column_alias=>'COD_CARAC_FUNC'
,p_column_display_sequence=>3
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840835767144105083)
,p_query_column_id=>3
,p_column_alias=>'DESC_CARAC_FUNC'
,p_column_display_sequence=>4
,p_column_heading=>unistr('Caracter\00EDstica')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840836182439105084)
,p_query_column_id=>4
,p_column_alias=>'COD_PESO'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840836625343105084)
,p_query_column_id=>5
,p_column_alias=>'DESC_PESO'
,p_column_display_sequence=>6
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271331917417964503415)
,p_query_column_id=>6
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1:Apagando,delete from carac_peso where cod_req = &P52_COD_REQ. and cod_carac_func = #COD_CARAC_FUNC#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#COD_CARAC_FUNCAO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961128339698907673)
,p_plug_name=>unistr('Detalhamento da Requisi\00E7\00E3o de Pessoal')
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>300
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961139060671907689)
,p_plug_name=>'Perfil'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>310
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'FUNCTION_BODY'
,p_plug_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ not in (1,5) then',
'return true;',
'elsif :p52_rowid is null and :P52_COD_SIT_REQ in (1,5) then',
'return false;',
'else',
'return false;',
'end if;'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961141527965907691)
,p_plug_name=>'Parecer'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_region_template_options=>'#DEFAULT#:js-showMaximizeButton:t-Region--scrollBody:t-Form--noPadding:t-Form--stretchInputs:t-Form--labelsAbove'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>320
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281969444133749332258)
,p_name=>'Ferramentas de Apoio / Equipamentos'
,p_parent_plug_id=>wwv_flow_api.id(281961127916819907672)
,p_template=>wwv_flow_api.id(281503566040079360531)
,p_display_sequence=>260
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
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
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
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
 p_id=>wwv_flow_api.id(271840844182859105090)
,p_query_column_id=>1
,p_column_alias=>'CODIGO'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840844635229105091)
,p_query_column_id=>2
,p_column_alias=>'DESCRICAO'
,p_column_display_sequence=>3
,p_column_heading=>unistr('Descri\00E7\00E3o')
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840844973999105092)
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
 p_id=>wwv_flow_api.id(271840845445347105093)
,p_query_column_id=>4
,p_column_alias=>'SEQ'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840845819180105094)
,p_query_column_id=>5
,p_column_alias=>'DERIVED$01'
,p_column_display_sequence=>1
,p_column_heading=>'&nbsp;'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:777:&SESSION.::&DEBUG.:RP,777:P777_TITULO,P777_COMANDO_1,P777_COMANDO_5:Apagando,delete from beneficios_vaga_temp where seq = #SEQ# and cod_beneficio = #CODIGO#,delete from beneficios_vaga_temp where cod_requisicao = &P52_COD_REQ. and co'
||'d_beneficio = #CODIGO#'
,p_column_linktext=>'Apagar'
,p_column_link_attr=>'data-id="#CODIGO#" class="apagar t-Button t-Button--danger t-Button--simple t-Button--stretch"'
,p_report_column_width=>100
,p_derived_column=>'Y'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961143151706907692)
,p_plug_name=>'&P52_TITULO.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--slimPadding:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(281503566040079360531)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(281961150631199907700)
,p_name=>'Aprovadores'
,p_template=>wwv_flow_api.id(281503566040079360531)
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
'   and nvl(:p52_prospeccao,''N'') = ''N'''))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P52_COD_REQ'
,p_query_row_template=>wwv_flow_api.id(281503574851633360547)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840738638497104934)
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
 p_id=>wwv_flow_api.id(271840738970386104937)
,p_query_column_id=>2
,p_column_alias=>'APROVADOR'
,p_column_display_sequence=>2
,p_column_heading=>'Aprovador'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840739431850104938)
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
 p_id=>wwv_flow_api.id(271840739789964104939)
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
 p_id=>wwv_flow_api.id(271840740195229104941)
,p_query_column_id=>5
,p_column_alias=>'COD_EMP_APROV'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840740627757104942)
,p_query_column_id=>6
,p_column_alias=>'MAT_APROV'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(271840741002919104943)
,p_query_column_id=>7
,p_column_alias=>'SEQ_APROV'
,p_column_display_sequence=>7
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(269940606544677179631)
,p_query_column_id=>8
,p_column_alias=>'JUSTIFICATIVA'
,p_column_display_sequence=>8
,p_column_heading=>'Justificativa'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(281961154224093907710)
,p_plug_name=>unistr('Bot\00F5es')
,p_region_template_options=>'#DEFAULT#:t-ButtonRegion--slimPadding:t-Form--slimPadding'
,p_plug_template=>wwv_flow_api.id(281503558045757360518)
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(270154900129579193879)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(270154899688628193875)
,p_button_name=>'create_colab_inscrito'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(270227838702207025673)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(270227838255752025669)
,p_button_name=>'create_cand_inscrito'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'BELOW_BOX'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269956581443098880644)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_button_name=>'Descendentes'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
,p_grid_new_row=>'N'
,p_grid_new_column=>'N'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840788218691105011)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_button_name=>'adicionar_nota'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Atribuir'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(254087187141179069777)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_button_name=>'clear_anexo_1'
,p_button_static_id=>'CLEAR_ANEXO_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--tiny'
,p_button_template_id=>wwv_flow_api.id(281503586715606360572)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Limpar'
,p_button_position=>'BODY'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-times'
,p_grid_new_row=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840746757981104953)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_button_name=>'p52_btn_solicitante'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(281503586715606360572)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'P52 btn solicitante'
,p_button_position=>'BODY'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_EMP,P13_MAT:&P52_COD_EMP_REQ.,&P52_MAT_REQ.'
,p_button_condition=>'P52_ROWID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_icon_css_classes=>'fa-user'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840741762285104947)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_button_name=>'p52_btn_reprovar_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
 p_id=>wwv_flow_api.id(271840760043847104974)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281804530735846896792)
,p_button_name=>'CLOSE_IDIOMA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840795622765105023)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_button_name=>'CLOSE_CURSOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840798696912105026)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281920642780294084087)
,p_button_name=>'CLOSE_CARGOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840800963373105029)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281920727594875953372)
,p_button_name=>'CLOSE_TAREFA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840803268434105031)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281920729180052953388)
,p_button_name=>'CLOSE_CARACTERISTICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Fechar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940605241929179618)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_button_name=>'p52_btn_reprovar_1_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
 p_id=>wwv_flow_api.id(271840745291086104951)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:51:&SESSION.::&DEBUG.:::'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840745596994104952)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'CANCEL_1'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_button_redirect_url=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:'
,p_button_condition=>'P_PAGE_BRANCH'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840760422664104975)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281804530735846896792)
,p_button_name=>'CREATE_IDIOMA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840795961098105024)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_button_name=>'CREATE_CURSOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840799078369105027)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920642780294084087)
,p_button_name=>'CREATE_CARGOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840801437812105029)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920727594875953372)
,p_button_name=>'CREATE_TAREFA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840802865906105031)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920729180052953388)
,p_button_name=>'CREATE_CARACTERISTICA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269954060813957661024)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'CRIAR_IGUAL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
 p_id=>wwv_flow_api.id(271840745985325104952)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'CHAT_SUPPORT'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_image_alt=>unistr('D\00FAvidas')
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=&APP_ID.:765:&SESSION.::&DEBUG.:RP,765:P765_URL:http://10.11.150.78:83/'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-question-circle'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840741429786104944)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_button_name=>'p52_btn_aprovar_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
 p_id=>wwv_flow_api.id(271840744154527104950)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'ps'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Processo Seletivo'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_redirect_url=>'f?p=REQ_PESSOAL_&P_BASE.:23:&SESSION.::&DEBUG.:RP,23:P23_APP_CALLED,P23_PAGE_CALLED,P23_COD_REQ,P23_COD_EMPRESA:RS_PRC,29,&P52_COD_REQ.,&P52_COD_EMPRESA.'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct p.cod_req',
'  from ps_processo_seletivo p',
' where p.cod_req = :p52_cod_req'))
,p_button_condition_type=>'EXISTS'
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(269940605349985179619)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_button_name=>'p52_btn_aprovar_1_1'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840744539043104950)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'SAVE'
,p_button_static_id=>'SAVE'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Salvar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and :P52_COD_SIT_REQ in (1,5)  then',
'return true;',
'ELSE',
'return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840744948867104950)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_api.id(281961154224093907710)
,p_button_name=>'CREATE'
,p_button_static_id=>'CREATE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Criar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_button_condition=>'P52_ROWID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_database_action=>'INSERT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(268868623666382625533)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_button_name=>'AJUSTAR_REMUNERACAO'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Ajustar Valores'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_rowid is not null and ',
':p52_cod_vaga is null and',
':p52_cod_sit_req in (1,5) and ',
':p52_tipo_modalidade <> ''E'' and',
':p_perfil IN (''MASTER'',''REMUNERACAO'') then',
'return true;',
'elsif :p52_rowid is not null and ',
':p52_cod_sit_req in (1,5) and ',
':p52_tipo_modalidade = ''E'' and',
':p_perfil IN (''MASTER'',''REMUNERACAO'',''SELECAO'') then',
'return true;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_icon_css_classes=>'fa-exchange'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(270154898158374193860)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(270154898143355193859)
,p_button_name=>'add_colab'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(270227836162263025648)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(270227836104693025647)
,p_button_name=>'add_cand'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840809276970105043)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272433601362785528969)
,p_button_name=>'add_cursos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840812432660105049)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272433602311275528979)
,p_button_name=>'add_experiencia'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840815039637105053)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272434721058219675638)
,p_button_name=>'add_conhecimento'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840825378520105065)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281804182334824979127)
,p_button_name=>'add_idioma'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840828536829105070)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281919441456386243115)
,p_button_name=>'add_formacao'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840831576365105076)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920564848685202285)
,p_button_name=>'add_caracteristicas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840834320250105081)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920644686851084106)
,p_button_name=>'add_tarefas_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840837022497105085)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920645461369084114)
,p_button_name=>'add_caracteristicas_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840846184072105094)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281969444133749332258)
,p_button_name=>'chama_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840849706598105101)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281919441882242243119)
,p_button_name=>'add_cargos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840852794531105106)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281920563933816202275)
,p_button_name=>'add_tarefas'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840858993995105110)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_button_name=>'cargo'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Detalhes do Cargo'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271251954867538719815)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_button_name=>'New'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(281503586831677360575)
,p_button_image_alt=>'New'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_button_condition_type=>'NEVER'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840755429224104964)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272434722002950675648)
,p_button_name=>'create_Formacao'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840757692027104972)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272434722975513675657)
,p_button_name=>'create_experiencia'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840765837452104979)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_button_name=>'AVALIAR_CANDIDATOS'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
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
 p_id=>wwv_flow_api.id(271840786277759105009)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(272434723645434675664)
,p_button_name=>'create_conhecimento'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840766169498104979)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_button_name=>'candidatos'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Candidatos'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-users'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840793567866105020)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(281852568441376374245)
,p_button_name=>'create_beneficio'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Adicionar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-plus'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(271840766588096104980)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_button_name=>'fases'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_api.id(281503587005397360575)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Fases'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-sitemap'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(271841104920236105259)
,p_branch_name=>'Go To Page 51'
,p_branch_action=>'f?p=&APP_ID.:51:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>1
,p_branch_condition_type=>'ITEM_IS_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(271841104540907105259)
,p_branch_name=>'Go To Page P_PAGE_BRANCH'
,p_branch_action=>'f?p=&APP_ID.:&P_PAGE_BRANCH.:&SESSION.::&DEBUG.::P_PAGE_BRANCH:&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>21
,p_branch_condition_type=>'ITEM_IS_NOT_NULL'
,p_branch_condition=>'P_PAGE_BRANCH'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(269437386801752879194)
,p_branch_name=>'Go To Page 51 (Submit)'
,p_branch_action=>'f?p=&APP_ID.:51:&SESSION.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_COMPUTATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>11
,p_branch_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_branch_condition=>'APROVACAO'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(97820138174469394573)
,p_name=>'P52_MAT_SUBS_DESLIG'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(100401424171936548136)
,p_name=>'P52_MAT_SUBS_1'
,p_item_sequence=>350
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>unistr('Colaborador Substitu\00EDdo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>':P52_COD_REQ is not null and :P52_COD_MOT_REQ = 1'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_css_classes=>'apex_disabled'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107412843995411937526)
,p_name=>'P52_PROSPECCAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>unistr('Prospec\00E7\00E3o de Candidatos')
,p_source=>'PROSPECCAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_display_when=>'P_PAINEL'
,p_display_when2=>'PO'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(281503586488801360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Caso esteja abrindo uma requisi\00E7\00E3o apenas para realizar a prospec\00E7\00E3o de candidatos, marque esta op\00E7\00E3o como "Sim". '),
unistr('Desta forma, a requisi\00E7\00E3o n\00E3o passar\00E1 pelo fluxo de aprova\00E7\00E3o.'),
unistr('Ap\00F3s ter realizado a prospec\00E7\00E3o, desative essa op\00E7\00E3o para que ent\00E3o a requisi\00E7\00E3o passe pelo fluxo de aprova\00E7\00E3o e possa prosseguir com a admiss\00E3o do candidato aprovado.')))
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(107804923839165358975)
,p_name=>'P52_TIPO_PUBLICACAO'
,p_item_sequence=>310
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de Publica\00E7\00E3o')
,p_source=>'TIPO_PUBLICACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Externo;E,Interno;I'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Todos -'
,p_lov_null_value=>'T'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127233920011751185656)
,p_name=>'P52_COD_SINDICATO_AUX'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_item_default=>'P52_COD_SINDICATO'
,p_item_default_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(127233921066308185666)
,p_name=>'P52_MENSAGEM_AUX'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147893255272059838822)
,p_name=>'P52_RT_JORNADA_MENSAL_Z'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(147893255448483838823)
,p_name=>'P52_COD_HORARIO_Z'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(230247527620732979611)
,p_name=>'P52_ITEM_VALIDACAO_SAL'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(244552710401669997267)
,p_name=>'P52_VAGA_DISP_POR_REQ_DESLIG'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
,p_item_comment=>unistr('Conceito: a disponibiliza\00E7\00E3o da vaga para substitui\00E7\00E3o ocorre de 2 formas: ao aprovar a req. desligamento, ou pelo bot\00E3o de cria\00E7\00E3o de RP direto pela tela de req. de desligamento (por\00E9m, neste \00FAltimo cen\00E1rio, a vaga n\00E3o fica dispon\00EDvel, mas j\00E1 pode s')
||unistr('er utilizada em RP). A sinaliza\00E7\00E3o vem da p\00E1gina 59')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254087187072006069776)
,p_name=>'P52_ANEXO_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_use_cache_before_default=>'NO'
,p_prompt=>'<b>Anexe arquivo/documento com mais detalhes</b>'
,p_source=>'ANEXO_1'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'DB_COLUMN'
,p_attribute_02=>'ANEXO_MIMETYPE_1'
,p_attribute_03=>'ANEXO_FILENAME_1'
,p_attribute_04=>'ANEXO_CHARSET_1'
,p_attribute_05=>'ANEXO_DATA_1'
,p_attribute_06=>'Y'
,p_attribute_08=>'attachment'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(254171338578901726508)
,p_name=>'P52_COD_AREA'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('\00C1rea')
,p_source=>'COD_AREA'
,p_source_type=>'DB_COLUMN'
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
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268761526017116120815)
,p_name=>'P52_TIPO_MODALIDADE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_use_cache_before_default=>'NO'
,p_item_default=>'P'
,p_prompt=>'Tipo de Modalidade'
,p_source=>'TIPO_MODALIDADE'
,p_source_type=>'DB_COLUMN'
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
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268761526163354120816)
,p_name=>'P52_VLR_AUX_TIPO_MODALIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Valor de Aux\00EDlio')
,p_pre_element_text=>'R$'
,p_format_mask=>'99999999990D90'
,p_source=>'VLR_AUX_TIPO_MODALIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'999999999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268802778800923087880)
,p_name=>'P52_TRAB_INTERMITENTE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>'Trabalho Intermitente'
,p_source=>'TRAB_INTERMITENTE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268868624132060625538)
,p_name=>'P52_AJUSTAR_REMUNERACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(268959180653124342431)
,p_name=>'P52_TIPO_MODALIDADE_OCORR'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269950646593649718137)
,p_name=>'P52_QTD_POSICAO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('N\00BA de Posi\00E7\00F5es')
,p_source=>'QTD_POSICAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'1'
,p_attribute_02=>'9999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(269954061483062661031)
,p_name=>'P52_QTD_POSICAO_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270025378988221579956)
,p_name=>'P52_COD_REQ_PAI'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Req. de Origem'
,p_source=>'COD_REQ_PAI'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P52_COD_REQ_PAI'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270154899773106193876)
,p_name=>'P52_COD_EMPRESA_COLAB'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(270154899688628193875)
,p_prompt=>'Empresa'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod||'' - ''||initcap(nome_abrev) descricao, cod codigo ',
'  from empresas ',
' order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270154900151352193880)
,p_name=>'P52_MATRICULA_COLAB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(270154899688628193875)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270154900341539193881)
,p_name=>'P52_DT_INSCRICAO_COLAB'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(270154899688628193875)
,p_prompt=>unistr('Data de Inscri\00E7\00E3o')
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270227838490567025671)
,p_name=>'P52_CANDIDATO_CAND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(270227838255752025669)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629210761781313095)
,p_name=>'P52_COD_UNIDADE_ADM_Y'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629210836272313096)
,p_name=>'P52_COD_ATIVIDADE_Y'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629210981795313097)
,p_name=>'P52_COD_LOCAL_TRAB_Y'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629210986382313098)
,p_name=>'P52_COD_CCUSTO_CONTAB_Y'
,p_item_sequence=>540
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629211118819313099)
,p_name=>'P52_COD_UN_NEGOCIO_Y'
,p_item_sequence=>570
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629211644248313104)
,p_name=>'P52_COD_CCUSTO_Y'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212237354313110)
,p_name=>'P52_NOME_CCUSTO_Y'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212296277313111)
,p_name=>'P52_NOME_UNIDADE_ADM_Y'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212476679313112)
,p_name=>'P52_NOME_ATIVIDADE_Y'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212492310313113)
,p_name=>'P52_NOME_LOCAL_TRAB_Y'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212680273313114)
,p_name=>'P52_NOME_CCUSTO_CONTAB_Y'
,p_item_sequence=>550
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270629212697317313115)
,p_name=>'P52_NOME_UN_NEGOCIO_Y'
,p_item_sequence=>580
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270825219366365054978)
,p_name=>'P52_QTD_MOUSE_MOVE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(270825220339556054987)
,p_name=>'P52_MAT_SUBS_X'
,p_item_sequence=>380
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271251954105759719807)
,p_name=>'P52_ENABLE_DA'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840742197340104947)
,p_name=>'P52_APROV'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840742629216104949)
,p_name=>'P52_OK_APROV'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840743026696104949)
,p_name=>'P52_FLAG_APROV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_item_default=>'N'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840743416748104949)
,p_name=>'P52_MENSAGEM_APROV'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281961150631199907700)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840747160412104957)
,p_name=>'P52_TITULO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840747460985104957)
,p_name=>'P52_ROWID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840747887720104958)
,p_name=>'P52_COD_MOT_REQ'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Motivo de Abertura'
,p_source=>'COD_MOT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    select initcap(desc_mot_req) descricao, cod_mot_req',
'      from mot_req',
'     order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840748281080104958)
,p_name=>'P52_COD_MOT_SIT_REQ'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_MOT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840748735038104958)
,p_name=>'P52_COD_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Requisi\00E7\00E3o')
,p_source=>'COD_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_colspan=>4
,p_grid_label_column_span=>2
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840749101705104959)
,p_name=>'P52_COD_REQ_X'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'P52_COD_REQ'
,p_source_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840749470725104959)
,p_name=>'P52_COD_SIT_REQ'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
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
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840749930300104959)
,p_name=>'P52_DT_REQ'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Abertura'
,p_source=>'DT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_label_column_span=>2
,p_read_only_when=>'P52_ROWID'
,p_read_only_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840750307506104960)
,p_name=>'P52_DT_SIT_REQ'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de Situa\00E7\00E3o')
,p_source=>'DT_SIT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840750688435104960)
,p_name=>'P52_COD_EMP_REQ'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_EMP_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840751099218104960)
,p_name=>'P52_MAT_REQ'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'MAT_REQ'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840751548594104961)
,p_name=>'P52_SOLICITANTE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_prompt=>'Solicitante'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840751925469104961)
,p_name=>'P52_FLAG'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840752344471104962)
,p_name=>'P52_OK'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840752694198104962)
,p_name=>'P52_SEQ_APROV'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840753154950104962)
,p_name=>'P52_MENSAGEM'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840753536341104963)
,p_name=>'P52_ITEM_VALIDACAO'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840753917586104963)
,p_name=>'P52_USUARIO'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'USUARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840754272160104963)
,p_name=>'P52_DT_ATUALIZACAO'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_use_cache_before_default=>'NO'
,p_source=>'DT_ATUALIZACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840754749253104963)
,p_name=>'P52_UTILIZA_SECAO'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(281961143151706907692)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840755799108104970)
,p_name=>'P52_INSTR_FORMACAO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272434722002950675648)
,p_prompt=>unistr('Instru\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'select initcap(nome) descricao, cod from instrucao order by cod'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840756223721104970)
,p_name=>'P52_DESC_FORMACAO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272434722002950675648)
,p_prompt=>unistr('Forma\00E7\00E3o')
,p_placeholder=>unistr('Ex.: Ci\00EAncias Cont\00E1beis')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from formacao_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
,p_attribute_06=>'N'
,p_attribute_07=>'Y'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840756654415104971)
,p_name=>'P52_CONCL_FORMACAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272434722002950675648)
,p_item_default=>'S'
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840757027548104971)
,p_name=>'P52_EXIGE_FORMACAO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(272434722002950675648)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840758107101104972)
,p_name=>'P52_DESC_EXPERIENCIA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272434722975513675657)
,p_prompt=>unistr('Experi\00EAncia')
,p_placeholder=>unistr('Ex.: Lideran\00E7a de Equipe')
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from experiencia_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
,p_attribute_06=>'N'
,p_attribute_07=>'Y'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840758503378104973)
,p_name=>'P52_ANOS_EXPERIENCIA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272434722975513675657)
,p_prompt=>'Anos'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840758878199104973)
,p_name=>'P52_MESES_EXPERIENCIA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272434722975513675657)
,p_prompt=>'Meses'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840759302671104974)
,p_name=>'P52_EXIGE_EXPERIENCIA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272434722975513675657)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840760825522104975)
,p_name=>'P52_COD_IDIOMA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281804530735846896792)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840761238266104975)
,p_name=>'P52_NIVEL_CONHECIMENTO_IDIOMA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281804530735846896792)
,p_prompt=>unistr('N\00EDvel de Conhecimento')
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT Initcap(DESCRICAO), CODIGO ',
'  FROM NIVEL_CONHECIMENTO',
' ORDER BY 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840761957392104976)
,p_name=>'P52_CBO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'CBO'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840762290745104977)
,p_name=>'P52_DESC_OBJ_CARGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'Objetivos do Cargo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840762747581104977)
,p_name=>'P52_TEXTO_RESP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'Responsabilidades / Resultados'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840763086464104977)
,p_name=>'P52_DESC_QUALIF_NECESSID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>unistr('Qualifica\00E7\00F5es Necess\00E1rias')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840763514301104977)
,p_name=>'P52_DESC_SUP_EXERC'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>unistr('Supervis\00E3o Exercida')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840763925309104978)
,p_name=>'P52_DESC_POS_ESTRU'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>unistr('Posi\00E7\00E3o na Estrutura')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840764286400104978)
,p_name=>'P52_DESC_COMPLEXIDADE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'Complexidade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840764703179104978)
,p_name=>'P52_DESC_CONTR_REL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'Contatos/Relacionamentos'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840765132049104979)
,p_name=>'P52_DESC_RISC_AMB_TRAB'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281820631438198389953)
,p_prompt=>'Riscos e Ambientes'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840766974505104980)
,p_name=>'P52_COD_PROCESSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('N\00BA Processo Seletivo')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840767361355104980)
,p_name=>'P52_STATUS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Status'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840767845509104981)
,p_name=>'P52_COD_PROC_ANTERIOR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Processo Anterior'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840768246515104981)
,p_name=>'P52_COD_PREST_SERV'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Selecionador'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840768561779104981)
,p_name=>'P52_COD_TIPO_PROCESSO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Tipo de Processo'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840769030882104981)
,p_name=>'P52_COD_METRICA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('N\00EDvel de Contrata\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840769441161104982)
,p_name=>'P52_DT_SOLICITACAO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('Data Solicita\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840769859652104982)
,p_name=>'P52_DT_APROVACAO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('Data Aprova\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840770217505104982)
,p_name=>'P52_DT_PERFIL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Data Perfil'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840770574679104983)
,p_name=>'P52_DT_FECHAMENTO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Data Fechamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840770990508104984)
,p_name=>'P52_COD_ENTIDADE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Data Fechamento'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840771446934104984)
,p_name=>'P52_DT_INI_ENTIDADE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('Data In\00EDcio Entidade')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840771828258104984)
,p_name=>'P52_DT_FIM_ENTIDADE'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Data Fim Entidade'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840772194061104985)
,p_name=>'P52_TAXA'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Taxa'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840772575337104985)
,p_name=>'P52_VALOR'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Valor'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840773003186104985)
,p_name=>'P52_OBSERVACAO_PS'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840773401006104985)
,p_name=>'P52_LOCAL'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_prompt=>'Local'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840773771842104986)
,p_name=>'P52_FASE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(281826253952399785188)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840778864078104996)
,p_name=>'P52_FASE_CAND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281827490032502106561)
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840779332076104996)
,p_name=>'P52_CANDIDATO_ACMP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281827490032502106561)
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840785195858105009)
,p_name=>'P52_FASE_PS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281827654111486966358)
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840785621198105009)
,p_name=>'P52_CANDIDATO_FASE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281827654111486966358)
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840786704311105010)
,p_name=>'P52_DESC_CONHECIMENTO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272434723645434675664)
,p_prompt=>'Conhecimento'
,p_placeholder=>'Ex.: Scrum'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from formacao_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
,p_attribute_06=>'N'
,p_attribute_07=>'Y'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840787105444105010)
,p_name=>'P52_NIVEL_CONHECIMENTO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272434723645434675664)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840787511751105010)
,p_name=>'P52_EXIGE_CONHECIMENTO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272434723645434675664)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840788645271105011)
,p_name=>'P52_CANDIDATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281750712762204375345)
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
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840789058042105011)
,p_name=>'P52_NOTA_CORTE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_prompt=>'Nota Corte'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840789414438105012)
,p_name=>'P52_NOTA_CANDIDATO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_prompt=>'Nota'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840789811636105012)
,p_name=>'P52_APROVADO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_prompt=>'Aprovado?'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_value=>'N'
,p_begin_on_new_line=>'N'
,p_colspan=>2
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840790186722105012)
,p_name=>'P52_RESULTADO_FASE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281750712762204375345)
,p_prompt=>unistr('Observa\00E7\00E3o')
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>200
,p_cMaxlength=>200
,p_cHeight=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840793966819105020)
,p_name=>'P52_BENEFICIO_VAGA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281852568441376374245)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Selecionar as ferramentas necess\00E1rias para a execu\00E7\00E3o do trabalho do novo colaborador')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840794937143105022)
,p_name=>'P52_VALOR_BENEF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281852568441376374245)
,p_prompt=>'Valor'
,p_format_mask=>'FML999G999G999G999G990D00'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840796426715105024)
,p_name=>'P52_COD_CURSO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840796849289105024)
,p_name=>'P52_DESC_CURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_prompt=>'Curso'
,p_placeholder=>'Ex.: Pacote Office'
,p_display_as=>'NATIVE_AUTO_COMPLETE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct(nome) nome',
'  from curso_req_pessoal',
'order by 1'))
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'CONTAINS_IGNORE'
,p_attribute_04=>'N'
,p_attribute_06=>'N'
,p_attribute_07=>'Y'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840797237977105025)
,p_name=>'P52_NIVEL_CURSO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281920565544946202292)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840797594497105025)
,p_name=>'P52_CONCL_CURSO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_item_default=>'S'
,p_prompt=>unistr('Conclu\00EDdo')
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840798043065105025)
,p_name=>'P52_EXIGE_CURSO'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(281920565544946202292)
,p_item_default=>'S'
,p_prompt=>unistr('Exig\00EAncia')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Exigido;S,Desej\00E1vel;N')
,p_cHeight=>1
,p_colspan=>9
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840799472252105027)
,p_name=>'P52_COD_CARGO_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281920642780294084087)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840799947481105028)
,p_name=>'P52_ANOS_CARGO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281920642780294084087)
,p_prompt=>unistr('Anos de Experi\00EAncia')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840800326160105028)
,p_name=>'P52_MESES_CARGO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281920642780294084087)
,p_prompt=>unistr('Meses de Experi\00EAncia')
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840801782725105030)
,p_name=>'P52_COD_TAREFA_REQ'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281920727594875953372)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840802187195105030)
,p_name=>'P52_PESO_TAREFA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281920727594875953372)
,p_prompt=>'Peso'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_peso) descricao, COD_peso',
'  FROM peso',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840803690725105032)
,p_name=>'P52_COD_CARAC_FUNC'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281920729180052953388)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840804143394105032)
,p_name=>'P52_PESO_CARACTERISTICA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281920729180052953388)
,p_prompt=>'Peso'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT initcap(DESC_peso) descricao, COD_peso',
'  FROM peso',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840805402103105034)
,p_name=>'P52_NOVO_CONTRATO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433600701182528962)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>'Novo Contrato / Cliente'
,p_source=>'NOVO_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840805830977105035)
,p_name=>'P52_ORGAO_PUBLICO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433600701182528962)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>unistr('\00D3rg\00E3o P\00FAblico')
,p_source=>'ORGAO_PUBLICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840806258361105035)
,p_name=>'P52_VALOR_VENDA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433600701182528962)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor de Venda'
,p_pre_element_text=>'R$ '
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_VENDA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840816038455105054)
,p_name=>'P52_EMP_GESTOR_IND'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281621045247316224240)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'EMP_GESTOR_IND'
,p_source_type=>'DB_COLUMN'
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840816454770105055)
,p_name=>'P52_MAT_GESTOR_IND'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281621045247316224240)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_GESTOR_IND'
,p_source_type=>'DB_COLUMN'
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840817106276105055)
,p_name=>'P52_EMP_AVALIADOR_IND'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281621045305921224241)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'EMP_AVALIADOR_IND'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select e.cod||'' - ''||initcap(e.nome_abrev) descricao, e.cod codigo ',
'  from empresas e',
'  order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840817514605105055)
,p_name=>'P52_MAT_AVALIADOR_IND'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281621045305921224241)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Matr\00EDcula')
,p_source=>'MAT_AVALIADOR_IND'
,p_source_type=>'DB_COLUMN'
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
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840818214283105056)
,p_name=>'P52_TIPO_CONTRATO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(272433598502862528941)
,p_use_cache_before_default=>'NO'
,p_item_default=>'I'
,p_prompt=>'Tipo de Contrato'
,p_source=>'TIPO_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Determinado;D,Indeterminado;I'
,p_cHeight=>1
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Determinado se refere a atividades tempor\00E1rias ou transit\00F3rias, indeterminado a atividades n\00E3o tempor\00E1rias apenas dependentes de avalia\00E7\00E3o ap\00F3s 90 dias')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840819132215105058)
,p_name=>'P52_DT_PREVISAO_ADMISSAO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(272433598502862528941)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data Prevista de Admiss\00E3o')
,p_source=>'DT_PREVISAO_ADMISSAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840819543245105058)
,p_name=>'P52_DT_PREV_FIM_CONTRATO'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(272433598502862528941)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data Prevista de Fim de Contrato'
,p_source=>'DT_PREV_FIM_CONTRATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840820238188105059)
,p_name=>'P52_CANDIDATO_INDICADO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Candidato Indicado'
,p_source=>'CANDIDATO_INDICADO'
,p_source_type=>'DB_COLUMN'
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
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
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
 p_id=>wwv_flow_api.id(271840821115109105059)
,p_name=>'P52_NOME_INDICADO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Nome'
,p_source=>'NOME_INDICADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840821526783105059)
,p_name=>'P52_E_MAIL_INDICADO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'E-Mail'
,p_source=>'E_MAIL_INDICADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840821868849105060)
,p_name=>'P52_DDD_INDICADO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Telefone'
,p_placeholder=>'Ex.: 11'
,p_source=>'DDD_INDICADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840822261516105060)
,p_name=>'P52_TELEFONE_INDICADO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Telefone'
,p_placeholder=>'Ex.: 977775555'
,p_source=>'TELEFONE_INDICADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>9
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840822699164105060)
,p_name=>'P52_CPF_INDICADO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(272433598783792528943)
,p_use_cache_before_default=>'NO'
,p_prompt=>'CPF'
,p_source=>'CPF_INDICADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>14
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840837731762105086)
,p_name=>'P52_DESC_ATIVIDADES'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Descri\00E7\00E3o de Atividades')
,p_source=>'DESC_ATIVIDADES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>4000
,p_cMaxlength=>4000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840838085183105086)
,p_name=>'P52_SEQ'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840838517086105086)
,p_name=>'P52_FLG_UTILIZA_SALARIO_POS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840838914090105086)
,p_name=>'P52_BOTOES_REQ_PESSOAL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840839290559105087)
,p_name=>'P52_ALTEROU_VAGA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840839684608105087)
,p_name=>'P52_OBSERVACAO'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(281961128339698907673)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Observa\00E7\00F5es / Pol\00EDticas / Caracter\00EDsticas')
,p_placeholder=>unistr('Preencher com eventuais observa\00E7\00F5es para o cargo.')
,p_source=>'OBSERVACAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>5
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840840411107105088)
,p_name=>'P52_POS_ESTR_ORG'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281961139060671907689)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Posi\00E7\00E3o na Estrutura Organizacional')
,p_source=>'POS_ESTR_ORG'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840840816817105088)
,p_name=>'P52_EXP_NEC'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(281961139060671907689)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Experi\00EAncia Necess\00E1ria')
,p_source=>'EXP_NEC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840841176787105088)
,p_name=>'P52_REL_FUNC'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(281961139060671907689)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Rela\00E7\00F5es Funcionais')
,p_source=>'REL_FUNC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840841631911105088)
,p_name=>'P52_FAT_INS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(281961139060671907689)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Fatores de Insucesso (Incidentes Cr\00EDticos)')
,p_source=>'FAT_INS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840842039438105089)
,p_name=>'P52_PERS_DES'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(281961139060671907689)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Perspectivas de Desenvolvimento'
,p_source=>'PERS_DES'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840842677533105089)
,p_name=>'P52_PAR_JUST'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(281961141527965907691)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Justificativa (no caso de aumento de quadro)'
,p_source=>'PAR_JUST'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840843112821105089)
,p_name=>'P52_PAR_RH'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(281961141527965907691)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Parecer do Recursos Humanos'
,p_source=>'PAR_RH'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840843489443105090)
,p_name=>'P52_PAR_ORC'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(281961141527965907691)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Parecer do Or\00E7amento')
,p_source=>'PAR_ORC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>3000
,p_cMaxlength=>3000
,p_cHeight=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840853476748105107)
,p_name=>'P52_RT_JORNADA_MENSAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
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
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>'Escolher a jornada semanal e o regime mensal de horas da vaga.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840854428243105107)
,p_name=>'P52_RT_JORNADA_MENSAL_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
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
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolher a jornada semanal e o regime mensal de horas da vaga.'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840855297014105108)
,p_name=>'P52_COD_HORARIO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
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
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586573338360569)
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
 p_id=>wwv_flow_api.id(271840856192969105108)
,p_name=>'P52_COD_HORARIO_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_prompt=>unistr('Hor\00E1rio Contratual')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cod_horario||'' - ''||desc_horario nome, cod_horario cod',
'  from cad_horario_trabalho ',
'where cod_empresa = :p52_cod_empresa ',
'order by desc_horario'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher qual o hor\00E1rio da vaga.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840857096100105109)
,p_name=>'P52_MARCA_PONTO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_use_cache_before_default=>'NO'
,p_item_default=>'S'
,p_prompt=>'Marca Ponto?'
,p_source=>'MARCA_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_cHeight=>1
,p_colspan=>6
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840857555753105109)
,p_name=>'P52_TP_REGISTRO_PONTO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Tipo de Marca\00E7\00E3o')
,p_source=>'TP_REGISTRO_PONTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Ambos;A,Fixo;F,M\00F3vel;M')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840857868087105109)
,p_name=>'P52_RT_JORNADA_MENSAL_X'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_use_cache_before_default=>'NO'
,p_source=>'RT_JORNADA_MENSAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840858283387105109)
,p_name=>'P52_COD_HORARIO_X'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(272433597493756528930)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_HORARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840859449615105110)
,p_name=>'P52_COD_CARGO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select x.name name, x.id id',
'  from (',
'select SUBSTR(c.cod,1,7)||'' - ''||initcap(c.nome) name , cod id',
'  from cargos_empresas e, cargos c, parametros_recursos_humanos p',
' where e.cod_empresa = p.cod_empresa',
'   and e.cod_cargo = c.cod',
'   and c.dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'   and e.cod_empresa = :p52_cod_empresa',
'   and p.ind_empresa_cargo = ''S''',
' union ',
'SELECT SUBSTR(c.cod,1,7)||'' - ''||initcap(nome) name , cod id',
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
'                     and c.cod_cargo = x.id',
'                  )',
'union',
'select SUBSTR(r.cod,1,7)||'' - ''||initcap(r.nome) name , cod id',
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840859814507105111)
,p_name=>'P52_COD_CARGO_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_prompt=>'Cargo'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT SUBSTR(cod,1,7)||'' - ''||initcap(nome) descricao , cod',
'from cargos',
'where dt_term_vig_cargo > to_date(sysdate,''dd/mm/rrrr'')',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840860259549105111)
,p_name=>'P52_COD_FUNCAO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' name, cod id',
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840860562888105111)
,p_name=>'P52_COD_FUNCAO_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_prompt=>unistr('Fun\00E7\00E3o')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select Initcap(nome)||'' (''||cod||'')'' descricao, cod codigo',
'  from funcao',
' where sysdate between nvl(dt_inic_vig_funcao,sysdate) and nvl(dt_term_vig_funcao,sysdate)',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840860964744105111)
,p_name=>'P52_COD_CATEGORIA'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840861441218105112)
,p_name=>'P52_COD_CATEGORIA_1'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>unistr('Inclu\00EDdo propriedade DEFAULT puxando o conte\00FAdo do campo P52_COD_CATEGORIA_X 08/02/2022 Chamado 26029')
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840861843009105112)
,p_name=>'P52_COD_SINDICATO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_REQ,P52_COD_FILIAL,P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher para qual sindicato da empresa escolhida a vaga deve ser criada, para estagi\00E1rio selecionar 99 e PJ 998.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840862696319105112)
,p_name=>'P52_COD_SINDICATO_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_REQ,P52_COD_FILIAL,P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher para qual sindicato da empresa escolhida a vaga deve ser criada, para estagi\00E1rio selecionar 99 e PJ 998.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840863565261105113)
,p_name=>'P52_VINCULO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher o tipo de contrato das posi\00E7\00F5es que ser\00E3o criadas.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840864482307105113)
,p_name=>'P52_VINCULO_1'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
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
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Escolher o tipo de contrato das posi\00E7\00F5es que ser\00E3o criadas.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840865442276105114)
,p_name=>'P52_VINCULO_X'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_source=>'VINCULO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840865784702105114)
,p_name=>'P52_COD_CARGO_X'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CARGO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840866166563105114)
,p_name=>'P52_COD_FUNCAO_X'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_FUNCAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840866646106105115)
,p_name=>'P52_COD_CATEGORIA_X'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CATEGORIA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840867052379105115)
,p_name=>'P52_COD_SINDICATO_X'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(272433597559605528931)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_SINDICATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840867719166105115)
,p_name=>'P52_TIPO_SALARIO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select tipo_salario',
'  from cl_vaga a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial  = :p52_cod_filial',
'   and a.cod_vaga    = :p52_cod_vaga'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('Tipo de Sal\00E1rio')
,p_source=>'TIPO_SALARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Select INITCAP(descricao)||'' (''||cod||'')'' DESCRICAO,',
'       COD',
'  from tipo_salario',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_colspan=>6
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Escolher qual ser\00E1 o tipo de recebimento do colaborador.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840868569261105116)
,p_name=>'P52_TOTAL_SALARIO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_prompt=>unistr('Total Remunera\00E7\00E3o')
,p_pre_element_text=>'R$'
,p_format_mask=>'99999999990D90'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Preencher com o valor do sal\00E1rio somado com o beneficio.')
,p_attribute_01=>'0'
,p_attribute_02=>'9999999999'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840869515858105117)
,p_name=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_prompt=>unistr('% Benef\00EDcio')
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Flex - 20%;20,Flex - 30%;30,Flex - Exce\00E7\00E3o;0')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'FULL CLT'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_help_text=>unistr('Tipo do modelo de contrata\00E7\00E3o.')
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840870403538105117)
,p_name=>'P52_PERC_BENEF_EXCECAO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_prompt=>unistr('% Benef. Exce\00E7\00E3o')
,p_format_mask=>'9990D90'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_cMaxlength=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840870762804105118)
,p_name=>'P52_SALARIO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select valor_verba',
'  from cl_vaga a',
' where a.cod_empresa = :p52_cod_empresa',
'   and a.cod_filial  = :p52_cod_filial',
'   and a.cod_vaga    = :p52_cod_vaga'))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>unistr('Sal\00E1rio')
,p_pre_element_text=>'R$'
,p_format_mask=>'99999999990D90'
,p_source=>'SALARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>unistr('Verificar se o valor do sal\00E1rio est\00E1 correto.')
,p_attribute_01=>'0'
,p_attribute_02=>'9999999999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840871721272105118)
,p_name=>'P52_REMUNERACAO_VARIAVEL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Valor do Benef\00EDcio')
,p_pre_element_text=>'R$'
,p_format_mask=>'99999999990D90'
,p_source=>'REMUNERACAO_VARIAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'999999999'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840872115764105118)
,p_name=>'P52_MOTIVO_EXCECAO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Motivo Para a Exce\00E7\00E3o')
,p_placeholder=>unistr('Informe o motivo da exce\00E7\00E3o do percentual de benef\00EDcio')
,p_source=>'MOTIVO_EXCECAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cMaxlength=>4000
,p_cHeight=>5
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840872524437105119)
,p_name=>'P52_SALARIO_MAX'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_source=>'SALARIO_MAX'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840872925073105119)
,p_name=>'P52_PERC_BENEFICIO'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(272433597612497528932)
,p_use_cache_before_default=>'NO'
,p_prompt=>'%'
,p_format_mask=>'990D90'
,p_source=>'PERC_BENEFICIO_VARIAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840873561601105119)
,p_name=>'P52_FLAG_TEMPORARIO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo de Vaga'
,p_source=>'FLAG_TEMPORARIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>unistr('STATIC:N\00E3o Controlada;S,Controlada;N')
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Ao selecionar vaga n\00E3o controlada ser\00E1 criada somente uma posi\00E7\00E3o, e vaga controlada com mais de uma posi\00E7\00E3o.')
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840874523540105120)
,p_name=>'P52_VAGA_CONFIDENCIAL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Vaga Confidencial'
,p_source=>'VAGA_CONFIDENCIAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840874896711105120)
,p_name=>'P52_COD_EMPRESA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Empresa'
,p_source=>'COD_EMPRESA'
,p_source_type=>'DB_COLUMN'
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
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolha para qual empresa do grupo a vaga deve ser criada.'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840875852859105121)
,p_name=>'P52_IND_SERV_ALOCA_COLAB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840876180566105121)
,p_name=>'P52_COD_FILIAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Filial'
,p_source=>'COD_FILIAL'
,p_source_type=>'DB_COLUMN'
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
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>'Escolher para qual filial da empresa a vaga devera ser criada.'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840877083857105121)
,p_name=>'P52_COD_VAGA'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Posi\00E7\00E3o')
,p_source=>'COD_VAGA'
,p_source_type=>'DB_COLUMN'
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
unistr('   and Nvl(e.aprovado, ''N\00C3O'') = ''SIM'''),
'   and Nvl(a.disponivel, ''N'') = ''S''',
'   and a.cod_filial = e.filial',
'   and a.cod_empresa = f.cod_empresa(+)',
'   and a.cod_cargo = f.cod_cargo(+)',
'   and f.cod_instrucao = g.cod(+)',
'   and ((f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S'' and :p52_cod_req is null) or (:p52_cod_req is not null))',
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
'   and ((f_acesso_cc_pg_apex(c.cod_empresa, c.cod, :p_usuario, :p_painel) = ''S'' and :p52_cod_req is null) or (:p52_cod_req is not null))',
'   and ((:p_painel = ''PO'') or (not exists (select 1 ',
'from informacoes_funcionais i ',
'where i.cod_empresa = a.cod_empresa',
'and i.filial = a.cod_filial',
'and i.cad_vaga = a.cod_vaga',
'and i.cod_empresa = :p_empresa_user',
'and i.matricula = :p_matricula_user)))',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P_USUARIO,P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'t-Form-fieldContainer--stretchInputs'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'Y'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840877520683105122)
,p_name=>'P52_COD_CCUSTO'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>unistr('Centro de Custo (C\00E9lula)')
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
,p_grid_label_column_span=>1
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840877899829105122)
,p_name=>'P52_COD_CCUSTO_DSP'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840878324344105122)
,p_name=>'P52_COD_CCUSTO_1'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840878751918105123)
,p_name=>'P52_COD_UNIDADE_ADM'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
'          ,a.cod_unidade_adm cod',
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
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
'          ,a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where a.cod_empresa = :p52_cod_empresa',
'       and a.cod_filial = :p52_cod_filial',
'       and :p52_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_UTILIZA_SECAO'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840879119913105124)
,p_name=>'P52_COD_UNIDADE_ADM_DSP'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  VUNID_ADM_DSP VARCHAR2(400);',
'BEGIN',
'  BEGIN',
'    select distinct a.cod_unidade_adm||'' - ''||initcap(a.DESCRICAO)||',
'decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro) DESCRICAO'),
'  into VUNID_ADM_DSP',
'  from unidade_administrativa a, INFORMACOES_TERCEIROS IT',
' where it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa',
'   and a.cod_unidade_adm  = :P52_COD_UNIDADE_ADM_X',
'   and a.cod_empresa      = :p52_cod_empresa;',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      VUNID_ADM_DSP := :P52_COD_UNIDADE_ADM_X||'' - ''||Initcap(fnct_nome_unidade_adm(:p52_cod_empresa, null, :P52_COD_UNIDADE_ADM_X));',
'  END;',
'  return(VUNID_ADM_DSP);',
'EXCEPTION',
'  WHEN OTHERS THEN',
'  RETURN NULL;',
'END;'))
,p_source_type=>'FUNCTION_BODY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
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
 p_id=>wwv_flow_api.id(271840879461250105124)
,p_name=>'P52_COD_UNIDADE_ADM_1'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>'Unid. Administrativa (Cliente)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
'          ,a.cod_unidade_adm cod',
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
'  select distinct initcap(a.DESCRICAO)||'' - ''||a.cod_unidade_adm||',
'(SELECT decode(it.cod_tipo_inscricao,1,'', CNPJ - ''||REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(it.cgc_terceiro,'' '') ,14 ,''0'') ,''00,000,000,0000,00'') ',
'                               ,'','',''.'') ,'' '') ',
'              ,''.''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                      ,1000000)/100) ',
'                                ,''0000''))||''.'' ',
'              ,''/''||Trim(To_Char(Trunc(Mod(LPad(it.cgc_terceiro,14,''0'') ',
'                                       ,1000000)/100) ',
'                                ,''0000''))||''-'')',
'             ,2,'', CPF - ''||Translate(To_Char(it.cgc_terceiro/100 ',
'                     ,''000,000,000.00'') ',
'                     ,'',.'' ',
'                     ,''.-'')',
unistr('             ,'', Identifica\00E7\00E3o (Outros Docs - ''||it.cgc_terceiro)'),
'FROM   INFORMACOES_TERCEIROS it',
'where  it.cod_terceiro = a.cod_terceiro and it.filial = a.cod_filial and it.cod_empresa = a.cod_empresa) descricao',
'          ,a.cod_unidade_adm cod',
'      from unidade_administrativa a',
'     where a.cod_empresa = :p52_cod_empresa',
'       and a.cod_filial = :p52_cod_filial',
'       and :p52_utiliza_secao = ''N''',
'order by 1'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL'
,p_ajax_optimize_refresh=>'N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840879934097105124)
,p_name=>'P52_COD_ATIVIDADE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>unistr('Atividade (Servi\00E7o)')
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
'       and :P52_COD_REQ IS NULL',
'union',
'  select distinct t.cod||'' - ''||initcap(t.descricao) descricao, t.cod cod',
'    from atividade t',
'   where sysdate between t.dt_inicio and nvl(t.dt_fim,sysdate)',
'     and t.ativo = ''S''',
'     and :p52_utiliza_secao = ''N''',
'     and :P52_COD_REQ IS NULL',
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
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM,P52_UTILIZA_SECAO,P52_COD_UNIDADE_ADM_X,P52_COD_REQ'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840880284302105125)
,p_name=>'P52_COD_ATIVIDADE_DSP'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840880757725105125)
,p_name=>'P52_COD_ATIVIDADE_1'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840881121397105125)
,p_name=>'P52_COD_LOCAL_TRAB'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>'Local de Trabalho'
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
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_UNIDADE_ADM_X,P52_COD_UNIDADE_ADM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>1
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840881495425105125)
,p_name=>'P52_COD_LOCAL_TRAB_DSP'
,p_item_sequence=>230
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840881943360105126)
,p_name=>'P52_COD_LOCAL_TRAB_1'
,p_item_sequence=>240
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840882275856105126)
,p_name=>'P52_COD_CCUSTO_CONTAB'
,p_item_sequence=>250
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>unistr('C.Custo Cont\00E1bil')
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
,p_colspan=>3
,p_grid_label_column_span=>1
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840882714236105126)
,p_name=>'P52_COD_CCUSTO_CONTAB_DSP'
,p_item_sequence=>260
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840883071218105126)
,p_name=>'P52_COD_CCUSTO_CONTAB_1'
,p_item_sequence=>270
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_display_when=>'P52_ROWID'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840883473583105127)
,p_name=>'P52_COD_UN_NEGOCIO'
,p_item_sequence=>280
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>unistr('Unidade de Neg\00F3cio')
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
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840883898393105127)
,p_name=>'P52_COD_UN_NEGOCIO_1'
,p_item_sequence=>290
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
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
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840884282919105128)
,p_name=>'P52_REFEITORIO'
,p_item_sequence=>300
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Possui Refeit\00F3rio?')
,p_source=>'REFEITORIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:N\00E3o;N,Sim;S')
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840884747505105129)
,p_name=>'P52_DATA_INICIO'
,p_item_sequence=>320
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Data de In\00EDcio')
,p_source=>'DATA_INICIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840885148714105129)
,p_name=>'P52_DATA_FIM'
,p_item_sequence=>330
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Data de Encerramento'
,p_source=>'DATA_FIM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840885490750105129)
,p_name=>'P52_DESC_LOCAL'
,p_item_sequence=>340
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_prompt=>'Detalhe do Local de Trabalho'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840885936233105129)
,p_name=>'P52_MAT_SUBS'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Colaborador Substitu\00EDdo')
,p_source=>'MAT_SUBS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct v.matricula||'' - ''||Initcap(a.nome) descricao, v.matricula',
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
'select distinct d.mat_solicitado||'' - ''||Initcap(fnct_nome_func(d.cod_empresa, d.mat_solicitado)) descricao, d.mat_solicitado matricula',
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
,p_lov_cascade_parent_items=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_display_when=>'P52_COD_REQ'
,p_display_when_type=>'ITEM_IS_NULL'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
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
 p_id=>wwv_flow_api.id(271840886266671105130)
,p_name=>'P52_MOT_SUBS'
,p_item_sequence=>390
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Motivo de Substitui\00E7\00E3o')
,p_source=>'MOT_SUBS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  COD_MOT_SUBS||'' - ''||initcap(desc_mot_subs) descricao, COD_MOT_SUBS  ',
'from mot_SUBS',
'order by 2'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840886663816105130)
,p_name=>'P52_PONTOS_AVAL'
,p_item_sequence=>400
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('\00DAltima Avalia\00E7\00E3o')
,p_source=>'PONTOS_AVAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'0'
,p_attribute_02=>'999'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840887075720105130)
,p_name=>'P52_COD_CCUSTO_X'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CCUSTO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840887558357105130)
,p_name=>'P52_COD_UNIDADE_ADM_X'
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_UNIDADE_ADM'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840887943463105130)
,p_name=>'P52_COD_ATIVIDADE_X'
,p_item_sequence=>470
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_ATIVIDADE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840888339171105131)
,p_name=>'P52_COD_LOCAL_TRAB_X'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_LOCAL_TRAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840888699601105131)
,p_name=>'P52_COD_CCUSTO_CONTAB_X'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_CCUSTO_CONTAB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840889156112105131)
,p_name=>'P52_COD_UN_NEGOCIO_X'
,p_item_sequence=>560
,p_item_plug_id=>wwv_flow_api.id(272433597777183528933)
,p_use_cache_before_default=>'NO'
,p_source=>'COD_UN_NEGOCIO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840889784370105132)
,p_name=>'P52_VAGA_FATURAVEL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(272433597859063528934)
,p_use_cache_before_default=>'NO'
,p_item_default=>'N'
,p_prompt=>unistr('Vaga Fatur\00E1vel')
,p_source=>'VAGA_FATURAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>unistr('STATIC:Sim;S,N\00E3o;N')
,p_colspan=>6
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--radioButtonGroup'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840890254923105132)
,p_name=>'P52_VALOR_FATURAVEL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(272433597859063528934)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Valor'
,p_format_mask=>'99999990D00'
,p_source=>'VALOR_FATURAVEL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
,p_item_comment=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840891165242105133)
,p_name=>'P52_IDADE_MIN'
,p_item_sequence=>410
,p_item_plug_id=>wwv_flow_api.id(272433598043166528936)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Idade M\00EDnima')
,p_source=>'IDADE_MIN'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>10
,p_grid_label_column_span=>5
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840891571714105133)
,p_name=>'P52_IDADE_MAX'
,p_item_sequence=>420
,p_item_plug_id=>wwv_flow_api.id(272433598043166528936)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Idade M\00E1xima')
,p_source=>'IDADE_MAX'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_begin_on_new_field=>'N'
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840892277643105134)
,p_name=>'P52_SEXO'
,p_item_sequence=>430
,p_item_plug_id=>wwv_flow_api.id(272433598105498528937)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Sexo'
,p_source=>'SEXO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Feminino;F,Masculino;M,Ambos;A'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>2
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840892981808105134)
,p_name=>'P52_ANOS_SERVICO'
,p_item_sequence=>450
,p_item_plug_id=>wwv_flow_api.id(272433598287516528938)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Experi\00EAncia Anos')
,p_source=>'ANOS_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>6
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'0'
,p_attribute_02=>'100'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840893457120105135)
,p_name=>'P52_MESES_SERVICO'
,p_item_sequence=>460
,p_item_plug_id=>wwv_flow_api.id(272433598287516528938)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Experi\00EAncia Meses')
,p_source=>'MESES_SERVICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>32
,p_cMaxlength=>255
,p_grid_label_column_span=>6
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'0'
,p_attribute_02=>'12'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840894085791105135)
,p_name=>'P52_IND_DEF_FIS'
,p_item_sequence=>480
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'PCD'
,p_source=>'IND_DEF_FIS'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_value=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840894517370105136)
,p_name=>'P52_RAIS_IND_DEF_AUDITIVA'
,p_item_sequence=>490
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Auditiva'
,p_source=>'RAIS_IND_DEF_AUDITIVA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840894880716105136)
,p_name=>'P52_RAIS_IND_DEF_FISICO'
,p_item_sequence=>500
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('F\00EDsica')
,p_source=>'RAIS_IND_DEF_FISICO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840895290779105136)
,p_name=>'P52_RAIS_IND_DEF_MENTAL'
,p_item_sequence=>510
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Mental'
,p_source=>'RAIS_IND_DEF_MENTAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840895692256105137)
,p_name=>'P52_RAIS_IND_DEF_MULTIPLA'
,p_item_sequence=>520
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Multipla'
,p_source=>'RAIS_IND_DEF_MULTIPLA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840896121495105137)
,p_name=>'P52_RAIS_IND_DEF_VISUAL'
,p_item_sequence=>530
,p_item_plug_id=>wwv_flow_api.id(272433598318241528939)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Visual'
,p_source=>'RAIS_IND_DEF_VISUAL'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840896817677105137)
,p_name=>'P52_COD_INSTRUCAO'
,p_is_required=>true
,p_item_sequence=>440
,p_item_plug_id=>wwv_flow_api.id(272433598614469528942)
,p_use_cache_before_default=>'NO'
,p_prompt=>unistr('Grau de Instru\00E7\00E3o')
,p_source=>'COD_INSTRUCAO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'PLUGIN_BE.CTB.SELECT2'
,p_lov=>'select COD||'' - ''||initcap(nome) nome, cod codigo from instrucao order by cod'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_grid_label_column_span=>3
,p_field_template=>wwv_flow_api.id(281503586573338360569)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_help_text=>unistr('Selecionar o grau de instru\00E7\00E3o igual a descri\00E7\00E3o do cargo.')
,p_encrypt_session_state_yn=>'Y'
,p_attribute_01=>'SINGLE'
,p_attribute_08=>'CIC'
,p_attribute_10=>'100%'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840898028920105138)
,p_name=>'P52_IND_INSALUB'
,p_item_sequence=>360
,p_item_plug_id=>wwv_flow_api.id(272433598437829528940)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Insalubridade'
,p_source=>'IND_INSALUB'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(271840898368513105139)
,p_name=>'P52_IND_PERIC'
,p_item_sequence=>370
,p_item_plug_id=>wwv_flow_api.id(272433598437829528940)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Periculosidade'
,p_source=>'IND_PERIC'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:;S'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'N'
,p_grid_label_column_span=>4
,p_field_template=>wwv_flow_api.id(281503586391073360568)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'1'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(269966247212110051520)
,p_computation_sequence=>10
,p_computation_item=>'P52_USUARIO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>':P_USUARIO'
);
wwv_flow_api.create_page_computation(
 p_id=>wwv_flow_api.id(244562457734483938998)
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
 p_id=>wwv_flow_api.id(244562455718661938977)
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
 p_id=>wwv_flow_api.id(269966247324929051521)
,p_computation_sequence=>40
,p_computation_item=>'P52_DT_ATUALIZACAO'
,p_computation_type=>'PLSQL_EXPRESSION'
,p_computation=>'sysdate'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840903873398105146)
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
,p_associated_item=>wwv_flow_api.id(271840874896711105120)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840904286682105146)
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
,p_associated_item=>wwv_flow_api.id(271840876180566105121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840904710272105146)
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
,p_associated_item=>wwv_flow_api.id(271840877520683105122)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840905107315105146)
,p_validation_name=>'Cod_Horario'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p52_cod_horario is null and nvl(:p52_aprov,''N'') = ''N'' and :p52_cod_vaga is null then',
'return false;',
'else',
'return true;',
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>unistr('Campo Hor\00E1rio precisa ser preenchido!')
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_associated_item=>wwv_flow_api.id(271840855297014105108)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840903468325105145)
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
,p_associated_item=>wwv_flow_api.id(271840896817677105137)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840905468950105146)
,p_validation_name=>'Mot_Subs'
,p_validation_sequence=>70
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
,p_associated_item=>wwv_flow_api.id(271840886266671105130)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840905903439105147)
,p_validation_name=>'Cod_Vaga'
,p_validation_sequence=>80
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
,p_associated_item=>wwv_flow_api.id(271840877083857105121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840903141548105145)
,p_validation_name=>'valida_vaga'
,p_validation_sequence=>90
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
,p_associated_item=>wwv_flow_api.id(271840877083857105121)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840902269043105145)
,p_validation_name=>unistr('Valida Total Remunera\00E7\00E3o')
,p_validation_sequence=>100
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
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_associated_item=>wwv_flow_api.id(271840868569261105116)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840899915510105144)
,p_validation_name=>unistr('Valida Total Sal\00E1rio')
,p_validation_sequence=>110
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
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_associated_item=>wwv_flow_api.id(271840868569261105116)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840902740936105145)
,p_validation_name=>'Valida Salario'
,p_validation_sequence=>130
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
,p_associated_item=>wwv_flow_api.id(271840870762804105118)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(258596315668623559031)
,p_validation_name=>'Valida Piso Salario'
,p_validation_sequence=>140
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
,p_associated_item=>wwv_flow_api.id(271840870762804105118)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840901089254105144)
,p_validation_name=>unistr('Valida Campos Obrigat\00F3rios')
,p_validation_sequence=>150
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
 p_id=>wwv_flow_api.id(271840901898643105145)
,p_validation_name=>unistr('Sindicato Obrigat\00F3rio')
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_SINDICATO_X is null then--and :P52_ROWID is null then',
unistr('return ''O campo Sindicato n\00E3o pode ser nulo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271263528000916893799)
,p_validation_name=>unistr('V\00EDnculo Obrigat\00F3rio')
,p_validation_sequence=>170
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_VINCULO_X is null then',
unistr('return ''O campo V\00EDnculo n\00E3o pode ser nulo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(268868624350168625540)
,p_validation_name=>'Valida Valor X Benef'
,p_validation_sequence=>180
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
 p_id=>wwv_flow_api.id(271840900757861105144)
,p_validation_name=>'Valida Benef/Equip'
,p_validation_sequence=>190
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
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840900268809105144)
,p_validation_name=>unistr('Altera\00E7\00F5es Requisi\00E7\00E3o Conclu\00EDda')
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_COD_SIT_REQ = 2 THEN',
unistr('RETURN ''Requisi\00E7\00E3o j\00E1 conclu\00EDda, n\00E3o \00E9 permitido realizar altera\00E7\00F5es!'';'),
'END IF;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_always_execute=>'Y'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(271840744539043104950)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(271840899518735105143)
,p_validation_name=>unistr('Valida\00E7\00E3o Motivo Exce\00E7\00E3o')
,p_validation_sequence=>210
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_PERC_BENEFICIO_VARIAVEL = 0 and :p52_MOTIVO_EXCECAO is null then',
unistr('return ''Informe o motivo da exce\00E7\00E3o do percentual de benef\00EDcio.'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_associated_item=>wwv_flow_api.id(271840872115764105118)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269950645970757718131)
,p_validation_name=>unistr('Tipo Sal\00E1rio')
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_TIPO_SALARIO IS NULL AND :P52_TOTAL_SALARIO IS NOT NULL THEN',
unistr('RETURN ''Informe o Tipo do Sal\00E1rio!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_associated_item=>wwv_flow_api.id(271840867719166105115)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(178127733700488702529)
,p_validation_name=>'Valida Categoria'
,p_validation_sequence=>230
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :P52_COD_CARGO_X IS NOT NULL AND :P52_COD_CATEGORIA_X IS NULL THEN',
unistr('RETURN ''Informe o C\00F3digo de Categoria do Cargo!'';'),
'end if;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition=>'CRIAR_IGUAL'
,p_validation_condition_type=>'REQUEST_NOT_EQUAL_CONDITION'
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_associated_item=>wwv_flow_api.id(271840866646106105115)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269966246983365051518)
,p_validation_name=>'Valida_Sit_Req'
,p_validation_sequence=>240
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
,p_when_button_pressed=>wwv_flow_api.id(271840744539043104950)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(269588342706127546550)
,p_validation_name=>'Valida Cod_Horario'
,p_validation_sequence=>250
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
,p_associated_item=>wwv_flow_api.id(271840858283387105109)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(263626614113462500534)
,p_validation_name=>'Valida Perc Benf Excecao'
,p_validation_sequence=>260
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
,p_associated_item=>wwv_flow_api.id(271840870403538105117)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(194663110654602965558)
,p_validation_name=>'CRIAR_IGUAL (Validacoes)'
,p_validation_sequence=>270
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
'  Pkg_Pessoal.Valida_Unidade_Adm (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_unidade_adm,',
' v_flg,',
' v_msg);',
'',
'  if v_flg = ''N'' then raise saida; end if;',
'  ',
'  Pkg_Pessoal.Valida_Atividade (V_REQ.cod_empresa,',
' V_REQ.cod_filial,',
' V_REQ.cod_ccusto,',
' V_REQ.cod_unidade_adm,',
' V_REQ.cod_atividade,',
' v_flg,',
' v_msg);',
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
 p_id=>wwv_flow_api.id(148025603928687476227)
,p_validation_name=>'Valida RT_JORNADA_MENSAL'
,p_validation_sequence=>280
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
,p_associated_item=>wwv_flow_api.id(271840853476748105107)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(107496412788527445901)
,p_validation_name=>'Valida Aprovador'
,p_validation_sequence=>290
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
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'if 1 = 2 then',
'v_flg_retorno := pkg_req.VALIDA_EXISTE_APROV(:p52_cod_empresa,',
'                                              :p52_filial,',
'                                              :p52_cod_ccusto_x,',
'                                              null,--v_c1.matricula,',
'                                              :p_empresa_user, ',
'                                              :p_matricula_user, ',
'                                              null, ',
'                                              null);---''REQ_PESSOAL'');',
'                                              ',
'end if;',
'',
'    if nvl(v_flg_retorno,''S'') = ''N'' then',
unistr('        return ''N\00E3o foi parametrizado aprovadores para sua requisi\00E7\00E3o. Por favor, entrar em contato com os administradores do sistema!'';'),
'    else ',
'        return null;',
'    end if;',
'',
'end;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_when_button_pressed=>wwv_flow_api.id(271840744948867104950)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840913794665105151)
,p_name=>'Show / Hide Itens Problemas'
,p_event_sequence=>18
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840914275751105152)
,p_event_id=>wwv_flow_api.id(271840913794665105151)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840914735935105153)
,p_event_id=>wwv_flow_api.id(271840913794665105151)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840915236035105153)
,p_event_id=>wwv_flow_api.id(271840913794665105151)
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
 p_id=>wwv_flow_api.id(271840915725722105154)
,p_event_id=>wwv_flow_api.id(271840913794665105151)
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
 p_id=>wwv_flow_api.id(271840916137590105154)
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
 p_id=>wwv_flow_api.id(271840917581953105154)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840916614275105154)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
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
 p_id=>wwv_flow_api.id(271840918148906105155)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CCUSTO,P52_COD_LOCAL_TRAB,P52_VINCULO,P52_COD_UN_NEGOCIO,P52_COD_CARGO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO,P52_COD_FUNCAO,P52_COD_CATEGORIA,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269950646718244718138)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_QTD_POSICAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840917132134105154)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
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
 p_id=>wwv_flow_api.id(269950646757581718139)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
,p_event_result=>'FALSE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_QTD_POSICAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269950646862319718140)
,p_event_id=>wwv_flow_api.id(271840916137590105154)
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
 p_id=>wwv_flow_api.id(271840918504398105156)
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
 p_id=>wwv_flow_api.id(271840919023634105156)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
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
 p_id=>wwv_flow_api.id(271840922683507105158)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
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
':p52_mat_subs := v_c2.matricula||'' - ''|| v_c2.nome;',
'else',
'open c3;',
'fetch c3 into v_c3;',
'close c3;',
':p52_mat_subs := v_c3.matricula||'' - ''|| v_c3.nome;',
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
 p_id=>wwv_flow_api.id(271840921778665105158)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
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
'and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
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
'and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
'   and F_Acesso_Fil_cc_PG_APEX(aa.cod_empresa, aa.cod_filial, aa.cod_ccusto, :P_USUARIO) = ''S'';',
'   ',
'v_c1 c1%rowtype;',
'',
'cursor c2 is',
'select cargo, funcao, reg_trab, cod_horario',
'  from informacoes_funcionais',
' where cod_empresa = :p52_cod_empresa',
'   and matricula = REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]'');',
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
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_MAT_SUBS,P52_VAGA_DISP_POR_REQ_DESLIG,P52_COD_CCUSTO_1'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_LOCAL_TRAB_X,P52_VINCULO_X,P52_COD_CCUSTO_CONTAB_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X,P52_RT_JORNADA_MENSAL_X,P52_COD_HORARIO_X,P52_MARCA_PONTO,'
||'P52_TP_REGISTRO_PONTO,P52_REFEITORIO,P52_IND_INSALUB,P52_IND_PERIC,P52_COD_ATIVIDADE_X,P52_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_CCUSTO_1,P52_COD_LOCAL_TRAB_1'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840937217580105168)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
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
'and a.cod_empresa = f.cod_empresa(+)',
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
'if :p52_cod_req is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_ALTEROU_VAGA := ''N'';',
'',
':p52_vaga_faturavel := v_c1.vaga_faturavel;',
':p52_valor_Faturavel := v_c1.valor_faturavel;',
':p52_ind_def_fis := v_c1.ind_def_fis;',
':p52_rais_ind_def_fisico := v_c1.rais_ind_def_fisico;',
':p52_rais_ind_def_auditiva := v_c1.rais_ind_def_auditiva;',
':p52_rais_ind_def_visual := v_c1.rais_ind_def_visual;',
':p52_rais_ind_def_mental := v_c1.rais_ind_def_mental;',
':p52_rais_ind_def_multipla := v_c1.rais_ind_def_multipla;',
'',
':p52_tipo_salario := v_c1.tipo_salario;',
':p52_total_salario := NVL(v_c1.valor_total,NVL(v_c1.valor_verba,0)+NVL(v_c1.remuneracao_variavel,0));',
'',
'if v_c1.perc_beneficio_variavel in (20,30) then',
':p52_perc_beneficio_variavel := v_c1.perc_beneficio_variavel;',
':p52_perc_beneficio := v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel not in (20,30) and v_c1.perc_beneficio_variavel is not null then',
':p52_perc_beneficio_variavel := 0;',
':P52_PERC_BENEF_EXCECAO := v_c1.perc_beneficio_variavel;',
':p52_perc_beneficio := v_c1.perc_beneficio_variavel;',
'elsif v_c1.perc_beneficio_variavel is null then',
':p52_perc_beneficio_variavel := null;',
':p52_perc_beneficio := 0;',
'end if;',
'',
':p52_salario := v_c1.valor_verba;',
':p52_remuneracao_variavel := v_c1.remuneracao_variavel;',
':p52_vlr_aux_tipo_modalidade := v_c1.vlr_aux_tipo_modalidade;',
'',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_ALTEROU_VAGA,P52_COD_REQ,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_ALTEROU_VAGA,P52_TOTAL_SALARIO,P52_VAGA_FATURAVEL,P52_VALOR_FATURAVEL,P52_IND_DEF_FIS,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_VISUAL,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_REMUNERACAO_VARIAVEL,P52_PERC_BE'
||'NEFICIO_VARIAVEL,P52_TIPO_SALARIO,P52_SALARIO,P52_PERC_BENEF_EXCECAO,P52_PERC_BENEFICIO,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
,p_da_action_comment=>unistr('Ajuste Integra\00E7\00E3o Req. Deslig/RP')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840938086837105168)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
,p_event_result=>'TRUE'
,p_action_sequence=>50
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
 p_id=>wwv_flow_api.id(271840938577243105169)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
,p_event_result=>'TRUE'
,p_action_sequence=>60
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
 p_id=>wwv_flow_api.id(271840939961033105170)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
,p_event_result=>'TRUE'
,p_action_sequence=>70
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
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840939494366105170)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281969444133749332258)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270825219541828054979)
,p_event_id=>wwv_flow_api.id(271840918504398105156)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_qtd_mouse_move := 0;'
,p_attribute_03=>'P52_QTD_MOUSE_MOVE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840919376330105156)
,p_name=>'valida_Mat_subs'
,p_event_sequence=>58
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MAT_SUBS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840920444595105157)
,p_event_id=>wwv_flow_api.id(271840919376330105156)
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
'pkg_pessoal.Valida_mat_subs (:p52_cod_empresa, :p52_cod_filial, :p52_cod_vaga, REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]''), :p52_mot_subs, :p52_cod_cargo, :p52_cod_ccusto, v_flg_retorno, v_msg_retorno);',
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
'    :p52_mat_subs_x := REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]'');',
' end if; ',
'                        ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P52_MAT_SUBS,P52_MOT_SUBS,P52_COD_CCUSTO,P52_COD_CARGO'
,p_attribute_03=>'P52_FLAG,P52_MENSAGEM,P52_OK,P52_MAT_SUBS_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840920866136105157)
,p_event_id=>wwv_flow_api.id(271840919376330105156)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOT_SUBS'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840923148954105158)
,p_name=>unistr('Flag Tempor\00E1rio')
,p_event_sequence=>68
,p_condition_element=>'P52_FLAG_TEMPORARIO'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840923637286105159)
,p_event_id=>wwv_flow_api.id(271840923148954105158)
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
 p_id=>wwv_flow_api.id(271840923994106105160)
,p_name=>unistr('Esconder Campos Cria\00E7\00E3o')
,p_event_sequence=>78
,p_condition_element=>'P52_COD_REQ'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840924488390105160)
,p_event_id=>wwv_flow_api.id(271840923994106105160)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_PREST_SERV,P52_COD_SIT_REQ,P52_COD_MOT_SIT_REQ,P52_DT_REQ,P52_DT_SIT_REQ,P52_SOLICITANTE,P52_COD_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840925026930105160)
,p_event_id=>wwv_flow_api.id(271840923994106105160)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840925455157105160)
,p_name=>'Alerta Sequencia Aprov'
,p_event_sequence=>88
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MENSAGEM'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840925863638105160)
,p_event_id=>wwv_flow_api.id(271840925455157105160)
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
 p_id=>wwv_flow_api.id(271840926341700105161)
,p_name=>'Popula COD_CARGO'
,p_event_sequence=>108
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840926830713105161)
,p_event_id=>wwv_flow_api.id(271840926341700105161)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_cargo_1 := :p52_cod_cargo_x;'
,p_attribute_02=>'P52_COD_CARGO_X'
,p_attribute_03=>'P52_COD_CARGO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840927222133105161)
,p_name=>unistr('Confirma Aprova\00E7\00E3o')
,p_event_sequence=>118
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840741429786104944)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840927722584105162)
,p_event_id=>wwv_flow_api.id(271840927222133105161)
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
 p_id=>wwv_flow_api.id(271840928196379105163)
,p_event_id=>wwv_flow_api.id(271840927222133105161)
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
 p_id=>wwv_flow_api.id(271840928686548105163)
,p_event_id=>wwv_flow_api.id(271840927222133105161)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Requisi\00E7\00E3o Aprovada Com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840929256667105163)
,p_event_id=>wwv_flow_api.id(271840927222133105161)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840929597120105163)
,p_name=>unistr('Confirma Reprova\00E7\00E3o')
,p_event_sequence=>128
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840741762285104947)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840930138193105164)
,p_event_id=>wwv_flow_api.id(271840929597120105163)
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
 p_id=>wwv_flow_api.id(271840930566373105164)
,p_event_id=>wwv_flow_api.id(271840929597120105163)
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
 p_id=>wwv_flow_api.id(271840931077608105165)
,p_event_id=>wwv_flow_api.id(271840929597120105163)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>unistr('toastr.success(''Requisi\00E7\00E3o Reprovada Com Sucesso!'');')
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840931593922105165)
,p_event_id=>wwv_flow_api.id(271840929597120105163)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840931977913105165)
,p_name=>'Set Dt_Sit_Req'
,p_event_sequence=>138
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SIT_REQ'
,p_condition_element=>'P52_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840932560858105165)
,p_event_id=>wwv_flow_api.id(271840931977913105165)
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
 p_id=>wwv_flow_api.id(271840932959421105165)
,p_name=>'Desabilita Campos'
,p_event_sequence=>148
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
 p_id=>wwv_flow_api.id(271840933440937105166)
,p_event_id=>wwv_flow_api.id(271840932959421105165)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_VAGA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840933936332105166)
,p_event_id=>wwv_flow_api.id(271840932959421105165)
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
'   apex.item("P52_DATA_INICIO").enable();',
'   apex.item("P52_DATA_FIM").enable();',
'    apex.item("P52_TIPO_CONTRATO").enable();',
'    apex.item("P52_DT_PREVISAO_ADMISSAO").enable();',
'    apex.item("P52_DT_PREV_FIM_CONTRATO").enable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").enable();',
'apex.item("P52_COD_HORARIO").enable();',
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
 p_id=>wwv_flow_api.id(271840934373807105166)
,p_event_id=>wwv_flow_api.id(271840932959421105165)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_VAGA'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840934923705105166)
,p_event_id=>wwv_flow_api.id(271840932959421105165)
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
'   apex.item("P52_DATA_INICIO").disable();',
'   apex.item("P52_DATA_FIM").disable();',
'    apex.item("P52_TIPO_CONTRATO").disable();',
'    apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'    apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'   apex.item("P52_VAGA_CONFIDENCIAL").disable();',
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
 p_id=>wwv_flow_api.id(271840935336028105167)
,p_name=>'valida_ccusto'
,p_event_sequence=>158
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_X'
,p_condition_element=>'P52_COD_CCUSTO_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840935782885105167)
,p_event_id=>wwv_flow_api.id(271840935336028105167)
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
 p_id=>wwv_flow_api.id(271840936301015105167)
,p_event_id=>wwv_flow_api.id(271840935336028105167)
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
 p_id=>wwv_flow_api.id(271840940420704105171)
,p_name=>'Vaga: Popular Campos_3'
,p_event_sequence=>168
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(272433597777183528933)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'(apex.item("P52_COD_VAGA").getValue().length > 0 && (apex.item("P52_QTD_MOUSE_MOVE").getValue().length == 0 || apex.item("P52_QTD_MOUSE_MOVE").getValue() < 6))'
,p_bind_type=>'bind'
,p_bind_event_type=>'mousemove'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840940898066105171)
,p_event_id=>wwv_flow_api.id(271840940420704105171)
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
'   and (Nvl(a.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
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
'   and (Nvl(aa.disponivel, ''N'') = ''S'' or Nvl(:P52_VAGA_DISP_POR_REQ_DESLIG,''N'') = ''S'')',
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
'    ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_COD_CCUSTO_CONTAB_1,P52_COD_LOCAL_TRAB_1,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_SINDICATO_1,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X,P52_COD_LOCAL_TRAB_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB_X,P52_COD_HORARIO_X,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_CCUSTO_X,P52_COD_SINDICATO_1,P52_COD_SINDICATO_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840941430691105171)
,p_event_id=>wwv_flow_api.id(271840940420704105171)
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
 p_id=>wwv_flow_api.id(270825219602429054980)
,p_event_id=>wwv_flow_api.id(271840940420704105171)
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
 p_id=>wwv_flow_api.id(271233141298959858747)
,p_name=>'Submit Validation - Popula Campos'
,p_event_sequence=>178
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271251954867538719815)
,p_condition_element=>'P52_ENABLE_DA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271233141339535858748)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
 p_id=>wwv_flow_api.id(271251953348092719800)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
 p_id=>wwv_flow_api.id(271251953489197719801)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
 p_id=>wwv_flow_api.id(271251953534659719802)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
 p_id=>wwv_flow_api.id(271251953701209719803)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
 p_id=>wwv_flow_api.id(271251953778215719804)
,p_event_id=>wwv_flow_api.id(271233141298959858747)
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
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840941797759105171)
,p_name=>'Popula COD_CCUSTO_CONTAB_X'
,p_event_sequence=>188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840942317219105172)
,p_event_id=>wwv_flow_api.id(271840941797759105171)
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
 p_id=>wwv_flow_api.id(271840942759628105172)
,p_name=>'Popula COD_CCUSTO_CONTAB'
,p_event_sequence=>198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840943177113105172)
,p_event_id=>wwv_flow_api.id(271840942759628105172)
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
 p_id=>wwv_flow_api.id(271840943562936105172)
,p_name=>'(S/ Vaga) Popula COD_CCUSTO_CONTAB'
,p_event_sequence=>208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO_CONTAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840944135566105173)
,p_event_id=>wwv_flow_api.id(271840943562936105172)
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
 p_id=>wwv_flow_api.id(271840944463783105173)
,p_name=>'valida_cargo'
,p_event_sequence=>218
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
 p_id=>wwv_flow_api.id(271840944977867105173)
,p_event_id=>wwv_flow_api.id(271840944463783105173)
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
 p_id=>wwv_flow_api.id(271840945499970105173)
,p_event_id=>wwv_flow_api.id(271840944463783105173)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441456386243115)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840946059701105174)
,p_event_id=>wwv_flow_api.id(271840944463783105173)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840946431834105174)
,p_name=>'valida_cargo_1'
,p_event_sequence=>228
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
 p_id=>wwv_flow_api.id(271840946936534105174)
,p_event_id=>wwv_flow_api.id(271840946431834105174)
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
 p_id=>wwv_flow_api.id(271840947446947105174)
,p_event_id=>wwv_flow_api.id(271840946431834105174)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441456386243115)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840947924115105175)
,p_event_id=>wwv_flow_api.id(271840946431834105174)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840948266734105175)
,p_name=>'valida_filial'
,p_event_sequence=>238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FILIAL'
,p_condition_element=>'P52_COD_FILIAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840948849481105175)
,p_event_id=>wwv_flow_api.id(271840948266734105175)
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
 p_id=>wwv_flow_api.id(271840949188187105175)
,p_name=>'Valida_Cod_Sit_Req'
,p_event_sequence=>248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SIT_REQ'
,p_condition_element=>'P52_COD_SIT_REQ'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840949740642105175)
,p_event_id=>wwv_flow_api.id(271840949188187105175)
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
 p_id=>wwv_flow_api.id(271840950117168105176)
,p_name=>'Inicia Alertify'
,p_event_sequence=>258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_OK'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840950629759105176)
,p_event_id=>wwv_flow_api.id(271840950117168105176)
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
 p_id=>wwv_flow_api.id(271840951086436105176)
,p_event_id=>wwv_flow_api.id(271840950117168105176)
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
 p_id=>wwv_flow_api.id(271840951475443105176)
,p_name=>'Esconde Save/Create'
,p_event_sequence=>268
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_OK'
,p_condition_element=>'P52_OK'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840952007109105177)
,p_event_id=>wwv_flow_api.id(271840951475443105176)
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
 p_id=>wwv_flow_api.id(271840956628505105179)
,p_name=>'(Create) Habilita Campos'
,p_event_sequence=>278
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840957089797105179)
,p_event_id=>wwv_flow_api.id(271840956628505105179)
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
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840957581090105180)
,p_event_id=>wwv_flow_api.id(271840956628505105179)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_PERC_BENEFICIO,P52_COD_REQ'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840958085462105180)
,p_event_id=>wwv_flow_api.id(271840956628505105179)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO_MAX,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_SALARIO,P52_PERC_BENEFICIO,P52_COD_REQ,P52_CPF_INDICADO,P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_MOTIVO_EXCECAO,P52_ORGAO_PUBLI'
||'CO,P52_NOVO_CONTRATO,P52_VALOR_VENDA,P52_DESC_ATIVIDADES,P52_MAT_SUBS,P52_VLR_AUX_TIPO_MODALIDADE,P52_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269984184497324451330)
,p_event_id=>wwv_flow_api.id(271840956628505105179)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO_MAX,P52_VALOR_FATURAVEL,P52_REMUNERACAO_VARIAVEL,P52_TOTAL_SALARIO,P52_SALARIO,P52_PERC_BENEFICIO,P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269984184606187451331)
,p_event_id=>wwv_flow_api.id(271840956628505105179)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'console.log("P52_TOTAL_SALARIO = " + apex.item( "P52_TOTAL_SALARIO" ).getValue());'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840952369978105177)
,p_name=>'(Create) Popula %'
,p_event_sequence=>288
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840952958727105177)
,p_event_id=>wwv_flow_api.id(271840952369978105177)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840953416155105177)
,p_event_id=>wwv_flow_api.id(271840952369978105177)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840953897405105178)
,p_event_id=>wwv_flow_api.id(271840952369978105177)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$x(''P52_PERC_BENEFICIO'').disabled = false;',
'$x(''P52_PERC_BENEFICIO_VARIAVEL'').disabled = false;',
'$x(''P52_PERC_BENEF_EXCECAO'').disabled = false;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840954378721105178)
,p_event_id=>wwv_flow_api.id(271840952369978105177)
,p_event_result=>'TRUE'
,p_action_sequence=>40
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
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840954766563105178)
,p_name=>'(Create) Popula Campos X'
,p_event_sequence=>298
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840955314077105178)
,p_event_id=>wwv_flow_api.id(271840954766563105178)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P52_COD_CCUSTO_X := NVL(:P52_COD_CCUSTO_1,:P52_COD_CCUSTO);',
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
':P52_COD_HORARIO_X := NVL(:P52_COD_HORARIO_1,:P52_COD_HORARIO);'))
,p_attribute_02=>'P52_COD_CCUSTO_1,P52_COD_CCUSTO,P52_COD_UNIDADE_ADM_1,P52_COD_UNIDADE_ADM,P52_COD_ATIVIDADE_1,P52_COD_ATIVIDADE,P52_COD_LOCAL_TRAB_1,P52_COD_LOCAL_TRAB,P52_VINCULO_1,P52_VINCULO,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB,P52_COD_UN_NEGOCIO_1,P52_C'
||'OD_UN_NEGOCIO,P52_COD_CARGO_1,P52_COD_CARGO,P52_COD_FUNCAO_1,P52_COD_FUNCAO,P52_COD_CATEGORIA_1,P52_COD_CATEGORIA,P52_COD_SINDICATO_1,P52_COD_SINDICATO,P52_RT_JORNADA_MENSAL_1,P52_RT_JORNADA_MENSAL,P52_COD_HORARIO_1,P52_COD_HORARIO'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_VINCULO_X,P52_COD_CCUSTO_CONTAB_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X,P52_RT_JORNADA_MENSAL_X,P52_COD_HORARI'
||'O_X'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271251954200520719808)
,p_event_id=>wwv_flow_api.id(271840954766563105178)
,p_event_result=>'TRUE'
,p_action_sequence=>20
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
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270629211235118313100)
,p_name=>'(Create) Popula Campos Y'
,p_event_sequence=>308
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270629211293648313101)
,p_event_id=>wwv_flow_api.id(270629211235118313100)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840955696293105179)
,p_name=>'(Create) Popula Motivos'
,p_event_sequence=>318
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840956241716105179)
,p_event_id=>wwv_flow_api.id(271840955696293105179)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840958505671105180)
,p_name=>'(Aberto) Desabilita Campos (Pesquisa)'
,p_event_sequence=>328
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
' if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ in (1,5) AND :P_PERFIL IN (''REMUNERACAO'',''MASTER'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
' end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840958979163105180)
,p_event_id=>wwv_flow_api.id(271840958505671105180)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
 p_id=>wwv_flow_api.id(101444334285160703461)
,p_name=>'(Aberto) Desabilita Campos (Pesquisa)  New'
,p_event_sequence=>338
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(101444334701947703465)
,p_event_id=>wwv_flow_api.id(101444334285160703461)
,p_event_result=>'TRUE'
,p_action_sequence=>9
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
':p52_cod_cargo := :p52_cod_cargo_1;',
':p52_cod_funcao := :p52_cod_funcao_1;'))
,p_attribute_02=>'P52_COD_CARGO_1,P52_COD_FUNCAO_1'
,p_attribute_03=>'P52_COD_CARGO,P52_COD_FUNCAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(101444334486277703463)
,p_event_id=>wwv_flow_api.id(101444334285160703461)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARGO,P52_COD_FUNCAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(101444334350926703462)
,p_event_id=>wwv_flow_api.id(101444334285160703461)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.item("P52_COD_CARGO").enable();',
'apex.item("P52_COD_FUNCAO").enable();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(101444334552811703464)
,p_event_id=>wwv_flow_api.id(101444334285160703461)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARGO_1,P52_COD_FUNCAO_1'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840961410465105182)
,p_name=>'(Aberto) Remuneracao Desabilita Campos (Pesquisa) - MASTER REMUNERACAO'
,p_event_sequence=>348
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ in (1,5) and :P_PERFIL IN (''REMUNERACAO'',''MASTER'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840961943371105182)
,p_event_id=>wwv_flow_api.id(271840961410465105182)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'apex.item("P52_COD_CATEGORIA").disable();',
'',
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
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").disable();',
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
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_COD_CARGO").enable();',
'',
'',
'apex.item("P52_COD_AREA").enable();'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840964312279105183)
,p_name=>'(Encerrado) Desabilita Campos (Pesquisa)'
,p_event_sequence=>358
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if 1 = 2 then',
'  if :p52_rowid is not null and :P52_COD_SIT_REQ not in (1,5) then',
'    return true;',
'  elsif :p52_rowid is not null and :P_PERFIL NOT IN (''MASTER'',''REMUNERACAO'') then',
'    return true;',
'  else',
'    return false;',
'  end if;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840964859918105184)
,p_event_id=>wwv_flow_api.id(271840964312279105183)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'apex.item("P52_COD_CARGO").disable(); ',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_COD_HORARIO").disable();',
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
 p_id=>wwv_flow_api.id(271840967233506105185)
,p_name=>'Popula COD_UN_NEGOCIO'
,p_event_sequence=>378
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UN_NEGOCIO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840967755929105186)
,p_event_id=>wwv_flow_api.id(271840967233506105185)
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
 p_id=>wwv_flow_api.id(271840968074305105186)
,p_name=>unistr('Esconder Campo Sal\00E1rio')
,p_event_sequence=>388
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
'if :p52_rowid is not null then',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL);',
'return v_return;',
'else',
'return true;',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840968612770105186)
,p_event_id=>wwv_flow_api.id(271840968074305105186)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840969007731105186)
,p_name=>unistr('Mostrar Campo Sal\00E1rio')
,p_event_sequence=>398
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
'if :p52_rowid is not null then',
'v_return := FNCT_TRATA_VERIF_SAL_NIVEL(:P_USUARIO, NULL, NULL);',
'return v_return;',
'else',
'return true;',
'end if;',
'',
'end;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840969504354105186)
,p_event_id=>wwv_flow_api.id(271840969007731105186)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840969881037105187)
,p_name=>'Hide Aprov Sit <> 1'
,p_event_sequence=>408
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_display_when_cond=>'P52_COD_SIT_REQ'
,p_display_when_cond2=>'1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840970305992105187)
,p_name=>'Mostra Campo Valor Faturavel'
,p_event_sequence=>418
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VAGA_FATURAVEL'
,p_condition_element=>'P52_VAGA_FATURAVEL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840970830449105187)
,p_event_id=>wwv_flow_api.id(271840970305992105187)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840971310902105188)
,p_event_id=>wwv_flow_api.id(271840970305992105187)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840971775505105188)
,p_event_id=>wwv_flow_api.id(271840970305992105187)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VALOR_FATURAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840972199480105188)
,p_name=>'Valida Valor Faturavel'
,p_event_sequence=>428
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840972758591105188)
,p_event_id=>wwv_flow_api.id(271840972199480105188)
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
 p_id=>wwv_flow_api.id(271840973100856105189)
,p_name=>'Mask TOTAL_SALARIO'
,p_event_sequence=>438
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TOTAL_SALARIO'
,p_condition_element=>'P52_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840973635381105189)
,p_event_id=>wwv_flow_api.id(271840973100856105189)
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
 p_id=>wwv_flow_api.id(271840973997322105189)
,p_name=>'Mask REMUNERACAO_VARIAVEL'
,p_event_sequence=>448
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL'
,p_condition_element=>'P52_REMUNERACAO_VARIAVEL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840974537626105189)
,p_event_id=>wwv_flow_api.id(271840973997322105189)
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
 p_id=>wwv_flow_api.id(271840974889306105189)
,p_name=>'Mostra campos DEF'
,p_event_sequence=>458
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_IND_DEF_FIS'
,p_condition_element=>'P52_IND_DEF_FIS'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840975370428105190)
,p_event_id=>wwv_flow_api.id(271840974889306105189)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840975935487105190)
,p_event_id=>wwv_flow_api.id(271840974889306105189)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_RAIS_IND_DEF_AUDITIVA,P52_RAIS_IND_DEF_FISICO,P52_RAIS_IND_DEF_MENTAL,P52_RAIS_IND_DEF_MULTIPLA,P52_RAIS_IND_DEF_VISUAL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840976346200105190)
,p_name=>'Mostra Valores'
,p_event_sequence=>468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840976792668105191)
,p_event_id=>wwv_flow_api.id(271840976346200105190)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840977270095105191)
,p_event_id=>wwv_flow_api.id(271840976346200105190)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840977778647105191)
,p_event_id=>wwv_flow_api.id(271840976346200105190)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840978261894105191)
,p_event_id=>wwv_flow_api.id(271840976346200105190)
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
 p_id=>wwv_flow_api.id(271840978662835105192)
,p_name=>'Mostra Valores Excecao'
,p_event_sequence=>478
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
 p_id=>wwv_flow_api.id(271840979235318105192)
,p_event_id=>wwv_flow_api.id(271840978662835105192)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_PERC_BENEF_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840979736815105192)
,p_event_id=>wwv_flow_api.id(271840978662835105192)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840980207365105192)
,p_event_id=>wwv_flow_api.id(271840978662835105192)
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
 p_id=>wwv_flow_api.id(271840980569287105193)
,p_name=>'Esconde Valores'
,p_event_sequence=>488
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840981131362105193)
,p_event_id=>wwv_flow_api.id(271840980569287105193)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840981544673105193)
,p_name=>'Popula Remuneracao Variavel'
,p_event_sequence=>498
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840981964349105193)
,p_event_id=>wwv_flow_api.id(271840981544673105193)
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
 p_id=>wwv_flow_api.id(271840991644889105200)
,p_name=>'Popula Salario'
,p_event_sequence=>508
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TOTAL_SALARIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_AJUSTAR_REMUNERACAO'
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
 p_id=>wwv_flow_api.id(271840992150645105201)
,p_event_id=>wwv_flow_api.id(271840991644889105200)
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
'                                :p52_cod_filial,',
'                                :p52_cod_ccusto,',
'                                :p52_cod_cargo,',
'                                :p52_cod_sindicato,',
'                                :p52_cod_unidade_adm,',
'                                :p52_cod_un_negocio,',
'                                :p52_cod_atividade,',
'                                :p52_cod_vaga,',
'                                :p52_refeitorio,',
'                                :p52_vinculo_x,',
'                                :p52_rt_jornada_mensal_x,',
'                                :p52_total_salario,',
'                                :p52_perc_beneficio_variavel,',
'                                :p52_perc_benef_excecao,',
'                                :p52_vlr_aux_tipo_modalidade,',
'                                :p52_salario,',
'                                :p52_remuneracao_variavel,',
'                                :p52_perc_beneficio);',
'                                */',
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
'                                    ',
'if instr(1/2,''.'') > 0 then',
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'end if;',
'',
'  if v_perc_beneficio_variavel is null then -- Full-CLT',
'',
'    v_salario := nvl(v_total_salario,0) - nvl(v_valor_beneficio,0);',
'    v_remuneracao_variavel := nvl(v_valor_beneficio,0);',
'  ',
'  elsif v_perc_beneficio_variavel > 0 then -- Flex (20% ou 30%)',
'  ',
'    v_salario := round((v_total_salario * ((100-v_perc_beneficio_variavel)/100)),2);',
'    v_remuneracao_variavel := round((v_total_salario * (v_perc_beneficio_variavel/100)),2);',
'  ',
unistr('  elsif v_perc_beneficio_variavel = 0 then -- Flex (Exce\00E7\00E3o)'),
'  ',
'    if nvl(v_perc_benef_excecao,0) > 0 then',
'       v_remuneracao_variavel := round((v_total_salario * (v_perc_benef_excecao/100)),2);',
'       v_salario := v_total_salario - (nvl(v_remuneracao_variavel,0));',
'    else',
'       v_remuneracao_variavel := null;',
'       v_salario := v_total_salario - v_remuneracao_variavel;',
'    end if;',
'  ',
'  end if;',
'  ',
'  IF V_PERC_BENEFICIO_VARIAVEL > 0 THEN',
'     V_PERC_BENEFICIO := V_PERC_BENEFICIO_VARIAVEL;',
'  ELSIF V_PERC_BENEFICIO_VARIAVEL = 0 AND NVL(v_perc_benef_excecao,0) > 0 THEN',
'     V_PERC_BENEFICIO := v_perc_benef_excecao;',
'  ELSIF V_PERC_BENEFICIO_VARIAVEL IS NULL AND NVL(v_perc_benef_excecao,0) = 0 THEN',
'     V_PERC_BENEFICIO := NULL;',
'  END IF;',
'',
'',
':P52_SALARIO := v_salario;',
':P52_REMUNERACAO_VARIAVEL := v_remuneracao_variavel;',
':P52_PERC_BENEFICIO := v_perc_beneficio;',
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_VLR_AUX_TIPO_MODALIDADE,P52_PERC_BENEF_EXCECAO,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_PERC_BENEFICIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840982435728105193)
,p_name=>'Valida_Salario'
,p_event_sequence=>518
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270001065448562118812)
,p_event_id=>wwv_flow_api.id(271840982435728105193)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
 p_id=>wwv_flow_api.id(271840982880703105194)
,p_event_id=>wwv_flow_api.id(271840982435728105193)
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
 p_id=>wwv_flow_api.id(148025604305455476230)
,p_name=>'Valida_RT_JORNADA_MENSAL'
,p_event_sequence=>528
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147908105444251567578)
,p_event_id=>wwv_flow_api.id(148025604305455476230)
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
'if :P52_rowid is not null then',
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
'    if v_item_validacao = TRIM(UPPER(''P52_RT_JORNADA_MENSAL''))  OR v_item_validacao IS NULL  then',
'       :P52_OK := ''S'';',
'       :P52_ITEM_VALIDACAO := null;',
'    else',
'       :P52_ITEM_VALIDACAO := v_item_validacao;',
'    end if;',
' end if;',
' ',
'end;'))
,p_attribute_02=>'P52_ITEM_VALIDACAO,P52_ROWID'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148025604420767476232)
,p_event_id=>wwv_flow_api.id(148025604305455476230)
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
 p_id=>wwv_flow_api.id(148025604568865476233)
,p_name=>'Valida_COD_HORARIO'
,p_event_sequence=>538
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148025604668722476234)
,p_event_id=>wwv_flow_api.id(148025604568865476233)
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
 p_id=>wwv_flow_api.id(271840983310187105194)
,p_name=>unistr('Altera Sal\00E1rio e %')
,p_event_sequence=>548
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
 p_id=>wwv_flow_api.id(271840983787806105194)
,p_event_id=>wwv_flow_api.id(271840983310187105194)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
'',
unistr('if V_PERC_BENEFICIO_VARIAVEL = 0 then -- Flex - Exce\00E7\00E3o'),
':p52_perc_benef_excecao := ROUND(((nvl(v_remuneracao_variavel,0) /*+ nvl(v_vlr_aux_tipo_modalidade,0)*/) / v_total_salario),4) * 100;',
':p52_salario := nvl(v_total_salario,0) - nvl(v_remuneracao_variavel,0) /*- nvl(v_vlr_aux_tipo_modalidade,0)*/;                           ',
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_PERC_BENEFICIO_VARIAVEL,P52_TOTAL_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_VLR_AUX_TIPO_MODALIDADE'
,p_attribute_03=>'P52_SALARIO,P52_PERC_BENEF_EXCECAO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840984193110105194)
,p_name=>'Valida_Remuneracao_Variavel'
,p_event_sequence=>558
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840984670952105195)
,p_event_id=>wwv_flow_api.id(271840984193110105194)
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840985131979105195)
,p_name=>'(2) Valida_Remuneracao_Variavel < vlr_benef_sind'
,p_event_sequence=>568
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840985589585105195)
,p_event_id=>wwv_flow_api.id(271840985131979105195)
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
 p_id=>wwv_flow_api.id(148025604893023476236)
,p_name=>'(SAVE) Valida_Remuneracao_Variavel < vlr_benef_sind'
,p_event_sequence=>578
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744539043104950)
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'apex.item(''P52_REMUNERACAO_VARIAVEL'').getValue().length > 0'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840986045565105195)
,p_name=>unistr('(Empresa) Par\00E2metros')
,p_event_sequence=>588
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_EMPRESA'
,p_condition_element=>'P52_COD_EMPRESA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840986516420105196)
,p_event_id=>wwv_flow_api.id(271840986045565105195)
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
 p_id=>wwv_flow_api.id(271841089574217105250)
,p_event_id=>wwv_flow_api.id(271840986045565105195)
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
 p_id=>wwv_flow_api.id(271840986921793105196)
,p_name=>'Desabilita Campos Flag'
,p_event_sequence=>598
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FLG_UTILIZA_SALARIO_POS'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840987392180105198)
,p_event_id=>wwv_flow_api.id(271840986921793105196)
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
 p_id=>wwv_flow_api.id(271840987771982105198)
,p_name=>'Valida botoes_req_pessoal'
,p_event_sequence=>608
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BOTOES_REQ_PESSOAL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840988304585105198)
,p_event_id=>wwv_flow_api.id(271840987771982105198)
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
 p_id=>wwv_flow_api.id(271840988686133105199)
,p_name=>'Valida_Candidato_Indicado'
,p_event_sequence=>618
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CANDIDATO_INDICADO'
,p_condition_element=>'P52_CANDIDATO_INDICADO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840989747085105199)
,p_event_id=>wwv_flow_api.id(271840988686133105199)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840990235142105200)
,p_event_id=>wwv_flow_api.id(271840988686133105199)
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
 p_id=>wwv_flow_api.id(271840990717700105200)
,p_event_id=>wwv_flow_api.id(271840988686133105199)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840991209228105200)
,p_event_id=>wwv_flow_api.id(271840988686133105199)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840989174345105199)
,p_event_id=>wwv_flow_api.id(271840988686133105199)
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
 p_id=>wwv_flow_api.id(270337534087195268662)
,p_name=>'(Sindicato) Popula Salario'
,p_event_sequence=>628
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_TOTAL_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270337534181633268663)
,p_event_id=>wwv_flow_api.id(270337534087195268662)
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
'',
'end;'))
,p_attribute_02=>'P52_TOTAL_SALARIO,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO,P52_COD_SINDICATO,P52_COD_UNIDADE_ADM,P52_COD_UN_NEGOCIO,P52_COD_VAGA,P52_COD_ATIVIDADE,P52_REFEITORIO,P52_COD_CARGO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEFICIO,P52_RT_JORNADA_MENSAL_'
||'X,P52_COD_HORARIO_X'
,p_attribute_03=>'P52_SALARIO,P52_REMUNERACAO_VARIAVEL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271233140715011858741)
,p_name=>'Full-CLT Benef. Sindicato'
,p_event_sequence=>638
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REMUNERACAO_VARIAVEL,P52_MOTIVO_EXCECAO'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusout'
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
 p_id=>wwv_flow_api.id(271233140782304858742)
,p_event_id=>wwv_flow_api.id(271233140715011858741)
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
unistr(' v_msg_retorno := ''O valor de benef\00EDcio \00E9 menor do que o obrigat\00F3rio para os par\00E2metros informados.'';'),
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
||'X,P52_ITEM_VALIDACAO,P52_COD_REQ'
,p_attribute_03=>'P52_ITEM_VALIDACAO,P52_OK,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271251955153841719818)
,p_name=>'(Create) Full-CLT Benef. Sindicato'
,p_event_sequence=>648
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271251955245830719819)
,p_event_id=>wwv_flow_api.id(271251955153841719818)
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
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840992481472105201)
,p_name=>'Open Cursos'
,p_event_sequence=>658
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840809276970105043)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840993034991105201)
,p_event_id=>wwv_flow_api.id(271840992481472105201)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_CURSO,P52_NIVEL_CURSO,P52_CONCL_CURSO,P52_EXIGE_CURSO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840993467236105202)
,p_event_id=>wwv_flow_api.id(271840992481472105201)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920565544946202292)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840993950603105202)
,p_name=>'Open Formacao'
,p_event_sequence=>668
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840828536829105070)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840994433118105203)
,p_event_id=>wwv_flow_api.id(271840993950603105202)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_FORMACAO,P52_INSTR_FORMACAO,P52_CONCL_FORMACAO,P52_EXIGE_FORMACAO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840994877895105203)
,p_event_id=>wwv_flow_api.id(271840993950603105202)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434722002950675648)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840995287179105203)
,p_name=>'Open Experiencia'
,p_event_sequence=>678
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840812432660105049)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840995848692105203)
,p_event_id=>wwv_flow_api.id(271840995287179105203)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_EXPERIENCIA,P52_ANOS_EXPERIENCIA,P52_MESES_EXPERIENCIA,P52_EXIGE_EXPERIENCIA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840996278717105203)
,p_event_id=>wwv_flow_api.id(271840995287179105203)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434722975513675657)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840996750331105204)
,p_name=>'Open Conhecimento'
,p_event_sequence=>688
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840815039637105053)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840997219911105204)
,p_event_id=>wwv_flow_api.id(271840996750331105204)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DESC_CONHECIMENTO,P52_NIVEL_CONHECIMENTO,P52_EXIGE_CONHECIMENTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840997732384105204)
,p_event_id=>wwv_flow_api.id(271840996750331105204)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434723645434675664)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840998145109105204)
,p_name=>'Open Req. Cargos'
,p_event_sequence=>698
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840858993995105110)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840998650699105205)
,p_event_id=>wwv_flow_api.id(271840998145109105204)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281820631438198389953)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840998972497105205)
,p_name=>'Open PS'
,p_event_sequence=>708
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744154527104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271840999556163105205)
,p_event_id=>wwv_flow_api.id(271840998972497105205)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281826253952399785188)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271840999942413105205)
,p_name=>'Open Candidatos'
,p_event_sequence=>718
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840766169498104979)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841000444629105206)
,p_event_id=>wwv_flow_api.id(271840999942413105205)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827490032502106561)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841000911797105206)
,p_event_id=>wwv_flow_api.id(271840999942413105205)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827490032502106561)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841001341367105206)
,p_name=>'Open Avaliar_Candidatos'
,p_event_sequence=>728
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840765837452104979)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841001859526105206)
,p_event_id=>wwv_flow_api.id(271841001341367105206)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281750712762204375345)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841002346497105206)
,p_event_id=>wwv_flow_api.id(271841001341367105206)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281750712762204375345)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841002747265105207)
,p_name=>'Open Fases'
,p_event_sequence=>738
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840766588096104980)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841003213428105207)
,p_event_id=>wwv_flow_api.id(271841002747265105207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827654111486966358)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841003733224105207)
,p_event_id=>wwv_flow_api.id(271841002747265105207)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827654111486966358)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841004102302105207)
,p_name=>'Open Tarefas'
,p_event_sequence=>748
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840852794531105106)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841004560946105208)
,p_event_id=>wwv_flow_api.id(271841004102302105207)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_TAREFA_REQ,P52_PESO_TAREFA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841005154158105208)
,p_event_id=>wwv_flow_api.id(271841004102302105207)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920727594875953372)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841005479440105208)
,p_name=>'Open Tarefas_1'
,p_event_sequence=>758
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840834320250105081)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841006037360105208)
,p_event_id=>wwv_flow_api.id(271841005479440105208)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_TAREFA_REQ,P52_PESO_TAREFA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841006497705105208)
,p_event_id=>wwv_flow_api.id(271841005479440105208)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920727594875953372)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841006863633105209)
,p_name=>'Open Caracteristicas'
,p_event_sequence=>768
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840831576365105076)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841007449523105209)
,p_event_id=>wwv_flow_api.id(271841006863633105209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARAC_FUNC,P52_PESO_CARACTERISTICA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841007894113105209)
,p_event_id=>wwv_flow_api.id(271841006863633105209)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920729180052953388)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841008296887105209)
,p_name=>'Open Caracteristicas_1'
,p_event_sequence=>778
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840837022497105085)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841008816711105210)
,p_event_id=>wwv_flow_api.id(271841008296887105209)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARAC_FUNC,P52_PESO_CARACTERISTICA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841009356950105210)
,p_event_id=>wwv_flow_api.id(271841008296887105209)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920729180052953388)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841009687310105210)
,p_name=>'Open Idioma'
,p_event_sequence=>788
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840825378520105065)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841010221935105210)
,p_event_id=>wwv_flow_api.id(271841009687310105210)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_IDIOMA,P52_NIVEL_CONHECIMENTO_IDIOMA'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841010681068105211)
,p_event_id=>wwv_flow_api.id(271841009687310105210)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281804530735846896792)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841011118903105211)
,p_name=>'Open Cargos'
,p_event_sequence=>798
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840849706598105101)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841012100263105211)
,p_event_id=>wwv_flow_api.id(271841011118903105211)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920642780294084087)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841011651796105211)
,p_event_id=>wwv_flow_api.id(271841011118903105211)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_CARGO_REQ,P52_ANOS_CARGO,P52_MESES_CARGO'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270154901119448193889)
,p_name=>'Open Colab. Inscritos'
,p_event_sequence=>808
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270154898158374193860)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270154901160128193890)
,p_event_id=>wwv_flow_api.id(270154901119448193889)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270154899688628193875)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270154901319498193891)
,p_event_id=>wwv_flow_api.id(270154901119448193889)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_COD_EMPRESA_COLAB,P52_MATRICULA_COLAB,P52_DT_INSCRICAO_COLAB'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270154901443634193892)
,p_event_id=>wwv_flow_api.id(270154901119448193889)
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
 p_id=>wwv_flow_api.id(270227837284071025659)
,p_name=>'Open Cand. Inscritos'
,p_event_sequence=>818
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270227836162263025648)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227837402758025660)
,p_event_id=>wwv_flow_api.id(270227837284071025659)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270227838255752025669)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227837512573025661)
,p_event_id=>wwv_flow_api.id(270227837284071025659)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_CANDIDATO_CAND'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841012518235105211)
,p_name=>'Close Cursos'
,p_event_sequence=>828
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840795622765105023)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841013053334105212)
,p_event_id=>wwv_flow_api.id(271841012518235105211)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920565544946202292)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841013388470105212)
,p_name=>'Close Cargos'
,p_event_sequence=>838
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840798696912105026)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841013902119105212)
,p_event_id=>wwv_flow_api.id(271841013388470105212)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920642780294084087)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841014331290105212)
,p_name=>'Close Tarefas'
,p_event_sequence=>848
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840800963373105029)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841014856207105213)
,p_event_id=>wwv_flow_api.id(271841014331290105212)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920727594875953372)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841015190052105213)
,p_name=>'Close Caracteristica'
,p_event_sequence=>858
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840803268434105031)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841015674361105213)
,p_event_id=>wwv_flow_api.id(271841015190052105213)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920729180052953388)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841016129224105213)
,p_name=>'Close Idioma'
,p_event_sequence=>868
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840760043847104974)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841016617968105213)
,p_event_id=>wwv_flow_api.id(271841016129224105213)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281804530735846896792)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841016986923105214)
,p_name=>'Create Curso'
,p_event_sequence=>878
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840795961098105024)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841017500209105214)
,p_event_id=>wwv_flow_api.id(271841016986923105214)
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
 p_id=>wwv_flow_api.id(271841017993224105214)
,p_event_id=>wwv_flow_api.id(271841016986923105214)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920565544946202292)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841018555380105214)
,p_event_id=>wwv_flow_api.id(271841016986923105214)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433601362785528969)
);
end;
/
begin
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841018908541105215)
,p_name=>'Create Cargo'
,p_event_sequence=>888
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840799078369105027)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841019385069105215)
,p_event_id=>wwv_flow_api.id(271841018908541105215)
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
 p_id=>wwv_flow_api.id(271841019923938105215)
,p_event_id=>wwv_flow_api.id(271841018908541105215)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841020454863105215)
,p_event_id=>wwv_flow_api.id(271841018908541105215)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920642780294084087)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841020849264105216)
,p_name=>'Create Tarefas'
,p_event_sequence=>898
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840801437812105029)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841021317573105216)
,p_event_id=>wwv_flow_api.id(271841020849264105216)
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
 p_id=>wwv_flow_api.id(271841021841102105216)
,p_event_id=>wwv_flow_api.id(271841020849264105216)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920727594875953372)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841022283480105217)
,p_event_id=>wwv_flow_api.id(271841020849264105216)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920563933816202275)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841022831423105217)
,p_event_id=>wwv_flow_api.id(271841020849264105216)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920644686851084106)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841023230145105217)
,p_name=>'Create Caracteristica'
,p_event_sequence=>908
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840802865906105031)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841023689181105217)
,p_event_id=>wwv_flow_api.id(271841023230145105217)
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
 p_id=>wwv_flow_api.id(271841024237379105218)
,p_event_id=>wwv_flow_api.id(271841023230145105217)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920729180052953388)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841024704465105218)
,p_event_id=>wwv_flow_api.id(271841023230145105217)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920564848685202285)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841025194169105218)
,p_event_id=>wwv_flow_api.id(271841023230145105217)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920645461369084114)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841025641843105218)
,p_name=>'Create Idioma'
,p_event_sequence=>918
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840760422664104975)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841026123755105218)
,p_event_id=>wwv_flow_api.id(271841025641843105218)
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
 p_id=>wwv_flow_api.id(271841026593886105219)
,p_event_id=>wwv_flow_api.id(271841025641843105218)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281804530735846896792)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841027121724105219)
,p_event_id=>wwv_flow_api.id(271841025641843105218)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281804182334824979127)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841027473627105219)
,p_name=>'Refresh Regions'
,p_event_sequence=>928
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841027990074105219)
,p_event_id=>wwv_flow_api.id(271841027473627105219)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441456386243115)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841028492738105220)
,p_event_id=>wwv_flow_api.id(271841027473627105219)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841028888961105220)
,p_name=>'Delete Cargo'
,p_event_sequence=>938
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CARGO_APAGAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841029451346105220)
,p_event_id=>wwv_flow_api.id(271841028888961105220)
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
 p_id=>wwv_flow_api.id(271841029910425105220)
,p_event_id=>wwv_flow_api.id(271841028888961105220)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841030296228105221)
,p_name=>unistr('Ap\00F3s Apagar Cargo')
,p_event_sequence=>948
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281919441882242243119)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841030795736105221)
,p_event_id=>wwv_flow_api.id(271841030296228105221)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441882242243119)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841031241297105221)
,p_name=>unistr('Ap\00F3s Apagar Cursos')
,p_event_sequence=>958
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(272433601362785528969)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841031748629105221)
,p_event_id=>wwv_flow_api.id(271841031241297105221)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433601362785528969)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841032118512105221)
,p_name=>unistr('Ap\00F3s Apagar Forma\00E7\00E3o')
,p_event_sequence=>968
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281919441456386243115)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841032654723105222)
,p_event_id=>wwv_flow_api.id(271841032118512105221)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441456386243115)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841033032448105222)
,p_name=>unistr('Ap\00F3s Apagar Experi\00EAncia')
,p_event_sequence=>978
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(272433602311275528979)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841033481199105222)
,p_event_id=>wwv_flow_api.id(271841033032448105222)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433602311275528979)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841033936934105222)
,p_name=>unistr('Ap\00F3s Apagar Conhecimento')
,p_event_sequence=>988
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(272434721058219675638)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841034415873105223)
,p_event_id=>wwv_flow_api.id(271841033936934105222)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434721058219675638)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841034798274105223)
,p_name=>unistr('Ap\00F3s Apagar Tarefas')
,p_event_sequence=>998
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281920563933816202275)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841035267686105223)
,p_event_id=>wwv_flow_api.id(271841034798274105223)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920563933816202275)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841035669853105223)
,p_name=>unistr('Ap\00F3s Apagar Caracteristicas')
,p_event_sequence=>1008
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281920564848685202285)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841036228751105223)
,p_event_id=>wwv_flow_api.id(271841035669853105223)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920564848685202285)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841036609293105224)
,p_name=>unistr('Ap\00F3s Apagar Idioma')
,p_event_sequence=>1018
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281804182334824979127)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841037106417105224)
,p_event_id=>wwv_flow_api.id(271841036609293105224)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281804182334824979127)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841037515960105224)
,p_name=>unistr('Ap\00F3s Apagar Beneficio')
,p_event_sequence=>1028
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281969444133749332258)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841038001022105224)
,p_event_id=>wwv_flow_api.id(271841037515960105224)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281969444133749332258)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841039278701105225)
,p_name=>'Show Perfil'
,p_event_sequence=>1038
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BOTOES_REQ_PESSOAL'
,p_condition_element=>'P52_BOTOES_REQ_PESSOAL'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841039779330105225)
,p_event_id=>wwv_flow_api.id(271841039278701105225)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281961139060671907689)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841040340079105226)
,p_event_id=>wwv_flow_api.id(271841039278701105225)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281961139060671907689)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841040703932105226)
,p_name=>'(Pesquisa) Esconde Campos'
,p_event_sequence=>1048
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841041250277105226)
,p_event_id=>wwv_flow_api.id(271841040703932105226)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841041600561105226)
,p_name=>'Popula Especificacoes de Cargo'
,p_event_sequence=>1058
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO_X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841042064425105226)
,p_event_id=>wwv_flow_api.id(271841041600561105226)
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
 p_id=>wwv_flow_api.id(271841042576252105227)
,p_event_id=>wwv_flow_api.id(271841041600561105226)
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
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_exp_nec := v_c1.exp_nec;',
':p52_pos_estr_org := v_c1.pos_estr_org;',
':p52_rel_func := v_c1.rel_func;',
'',
'end;'))
,p_attribute_02=>'P52_COD_CARGO_X'
,p_attribute_03=>'P52_EXP_NEC,P52_POS_ESTR_ORG,P52_REL_FUNC'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841043098922105227)
,p_event_id=>wwv_flow_api.id(271841041600561105226)
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
'       --:p52_anos_servico := null; -- Comentador por Robson 23/06/2023',
'       --:p52_meses_servico := null;-- Comentador por Robson 23/06/2023',
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
'       --:p52_anos_servico := v_c2.anos_servico;-- Comentador por Robson 23/06/2023',
'       --:p52_meses_servico := v_c2.meses_servico;-- Comentador por Robson 23/06/2023',
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
 p_id=>wwv_flow_api.id(271841043545106105227)
,p_name=>'Refresh Fase do Processo'
,p_event_sequence=>1068
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FASE_PS,P52_CANDIDATO_FASE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841044039310105227)
,p_event_id=>wwv_flow_api.id(271841043545106105227)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827654111486966358)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841044457295105228)
,p_name=>'Mask Salario'
,p_event_sequence=>1078
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_SALARIO'
,p_condition_element=>'P52_SALARIO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841044889738105228)
,p_event_id=>wwv_flow_api.id(271841044457295105228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'',
''))
,p_attribute_02=>'P52_SALARIO'
,p_attribute_03=>'P52_SALARIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(258596315521408559030)
,p_event_id=>wwv_flow_api.id(271841044457295105228)
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
 p_id=>wwv_flow_api.id(271841045342109105228)
,p_name=>'Show Tipo_Registro'
,p_event_sequence=>1088
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MARCA_PONTO'
,p_condition_element=>'P52_MARCA_PONTO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841045788525105228)
,p_event_id=>wwv_flow_api.id(271841045342109105228)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TP_REGISTRO_PONTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841046334487105229)
,p_event_id=>wwv_flow_api.id(271841045342109105228)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TP_REGISTRO_PONTO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841046828513105229)
,p_event_id=>wwv_flow_api.id(271841045342109105228)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TP_REGISTRO_PONTO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841047213650105229)
,p_name=>unistr('(Refeit\00F3rio) Limpa campos valores')
,p_event_sequence=>1098
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_REFEITORIO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841047694110105229)
,p_event_id=>wwv_flow_api.id(271841047213650105229)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TOTAL_SALARIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO,P52_PERC_BENEFICIO,P52_MOTIVO_EXCECAO,P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841048156247105229)
,p_name=>'create_Beneficio'
,p_event_sequence=>1108
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840793567866105020)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841048567407105230)
,p_event_id=>wwv_flow_api.id(271841048156247105229)
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
 p_id=>wwv_flow_api.id(271841049137262105230)
,p_event_id=>wwv_flow_api.id(271841048156247105229)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281852568441376374245)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269588346010493546583)
,p_event_id=>wwv_flow_api.id(271841048156247105229)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_BENEFICIO_VAGA,P52_VALOR_BENEF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841049566447105230)
,p_event_id=>wwv_flow_api.id(271841048156247105229)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281969444133749332258)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841049981907105230)
,p_name=>'create_conhecimento'
,p_event_sequence=>1118
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840786277759105009)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841051008128105231)
,p_event_id=>wwv_flow_api.id(271841049981907105230)
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
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841051551952105231)
,p_event_id=>wwv_flow_api.id(271841049981907105230)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434723645434675664)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841050498212105231)
,p_event_id=>wwv_flow_api.id(271841049981907105230)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434721058219675638)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270154900397917193882)
,p_name=>'create_colab_inscrito'
,p_event_sequence=>1128
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270154900129579193879)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270154900537051193883)
,p_event_id=>wwv_flow_api.id(270154900397917193882)
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
 p_id=>wwv_flow_api.id(270154900629191193884)
,p_event_id=>wwv_flow_api.id(270154900397917193882)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270154899688628193875)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270154900702026193885)
,p_event_id=>wwv_flow_api.id(270154900397917193882)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270154898143355193859)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270227838840737025674)
,p_name=>'create_cand_inscrito'
,p_event_sequence=>1138
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270227838702207025673)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227838946336025675)
,p_event_id=>wwv_flow_api.id(270227838840737025674)
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
 p_id=>wwv_flow_api.id(270227838950346025676)
,p_event_id=>wwv_flow_api.id(270227838840737025674)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270227838255752025669)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227839134038025677)
,p_event_id=>wwv_flow_api.id(270227838840737025674)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270227836104693025647)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841051934409105231)
,p_name=>'create_Experiencia'
,p_event_sequence=>1148
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840757692027104972)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841052428535105232)
,p_event_id=>wwv_flow_api.id(271841051934409105231)
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
 p_id=>wwv_flow_api.id(271841052895263105232)
,p_event_id=>wwv_flow_api.id(271841051934409105231)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434722975513675657)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841053457393105232)
,p_event_id=>wwv_flow_api.id(271841051934409105231)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433602311275528979)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841053831855105232)
,p_name=>unistr('create_Forma\00E7\00E3o')
,p_event_sequence=>1158
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840755429224104964)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841054282290105233)
,p_event_id=>wwv_flow_api.id(271841053831855105232)
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
 p_id=>wwv_flow_api.id(271841054767451105233)
,p_event_id=>wwv_flow_api.id(271841053831855105232)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272434722002950675648)
,p_attribute_01=>'this.affectedElements.dialog(''close'');'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841055341983105233)
,p_event_id=>wwv_flow_api.id(271841053831855105232)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281919441456386243115)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841055669016105233)
,p_name=>'open_beneficios'
,p_event_sequence=>1168
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840846184072105094)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841056252934105233)
,p_event_id=>wwv_flow_api.id(271841055669016105233)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_BENEFICIO_VAGA,P52_VALOR_BENEF'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841056691142105234)
,p_event_id=>wwv_flow_api.id(271841055669016105233)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281852568441376374245)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841057100240105234)
,p_name=>'Popula Valor'
,p_event_sequence=>1178
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_BENEFICIO_VAGA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841057621641105234)
,p_event_id=>wwv_flow_api.id(271841057100240105234)
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
 p_id=>wwv_flow_api.id(271282656145185066924)
,p_event_id=>wwv_flow_api.id(271841057100240105234)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item("P52_VALOR_BENEF").disable();'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841058047251105234)
,p_name=>'New'
,p_event_sequence=>1188
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TESTE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841058464511105235)
,p_event_id=>wwv_flow_api.id(271841058047251105234)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_UNIDADE_ADM := :P52_TESTE;'
,p_attribute_02=>'P52_TESTE'
,p_attribute_03=>'P52_COD_UNIDADE_ADM'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841058955204105235)
,p_name=>'Mask Vlr Fat.'
,p_event_sequence=>1198
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_FATURAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841059383043105235)
,p_event_id=>wwv_flow_api.id(271841058955204105235)
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
 p_id=>wwv_flow_api.id(271841059776705105235)
,p_name=>'Mask Vlr Benef'
,p_event_sequence=>1208
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VALOR_BENEF'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841060328460105236)
,p_event_id=>wwv_flow_api.id(271841059776705105235)
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
 p_id=>wwv_flow_api.id(271841060700760105236)
,p_name=>'Popula COD_FUNCAO'
,p_event_sequence=>1218
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FUNCAO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841061163430105236)
,p_event_id=>wwv_flow_api.id(271841060700760105236)
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
 p_id=>wwv_flow_api.id(271841061654734105236)
,p_name=>'Popula COD_CATEGORIA'
,p_event_sequence=>1228
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CATEGORIA_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841062077181105236)
,p_event_id=>wwv_flow_api.id(271841061654734105236)
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
 p_id=>wwv_flow_api.id(271841062519159105237)
,p_name=>'Popula RT_JORNADA_MENSAL'
,p_event_sequence=>1238
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841063004497105237)
,p_event_id=>wwv_flow_api.id(271841062519159105237)
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
 p_id=>wwv_flow_api.id(271841063428253105237)
,p_name=>'Popula COD_HORARIO'
,p_event_sequence=>1248
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841063889444105237)
,p_event_id=>wwv_flow_api.id(271841063428253105237)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_horario_1 := :p52_cod_horario_x;'
,p_attribute_02=>'P52_COD_HORARIO_X'
,p_attribute_03=>'P52_COD_HORARIO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841064352163105237)
,p_name=>'Popula COD_UNIDADE_ADM'
,p_event_sequence=>1258
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841064770293105238)
,p_event_id=>wwv_flow_api.id(271841064352163105237)
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
 p_id=>wwv_flow_api.id(271841065243160105238)
,p_name=>'(S/ Vaga) Popula COD_UNIDADE_ADM'
,p_event_sequence=>1268
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841065664603105238)
,p_event_id=>wwv_flow_api.id(271841065243160105238)
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841066071177105238)
,p_name=>'Popula COD_ATIVIDADE_1'
,p_event_sequence=>1278
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_ATIVIDADE_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841066639804105239)
,p_event_id=>wwv_flow_api.id(271841066071177105238)
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
 p_id=>wwv_flow_api.id(271841066978355105239)
,p_name=>'Popula VINCULO_1'
,p_event_sequence=>1288
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841067504825105239)
,p_event_id=>wwv_flow_api.id(271841066978355105239)
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
 p_id=>wwv_flow_api.id(271841067938746105239)
,p_name=>'Popula COD_SINDICATO_1'
,p_event_sequence=>1298
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841068446489105239)
,p_event_id=>wwv_flow_api.id(271841067938746105239)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_COD_SINDICATO_1 := :p52_COD_SINDICATO_x;'
,p_attribute_02=>'P52_COD_SINDICATO_X'
,p_attribute_03=>'P52_COD_SINDICATO_1'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841068804696105240)
,p_name=>'Popula COD_LOCAL_TRAB'
,p_event_sequence=>1308
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841069276989105240)
,p_event_id=>wwv_flow_api.id(271841068804696105240)
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
 p_id=>wwv_flow_api.id(271841069698700105240)
,p_name=>'(S/ Vaga) Popula COD_ATIVIDADE'
,p_event_sequence=>1318
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_ATIVIDADE_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841070173535105240)
,p_event_id=>wwv_flow_api.id(271841069698700105240)
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
 p_id=>wwv_flow_api.id(271841070600619105241)
,p_name=>'(S/ Vaga) Popula VINCULO_1'
,p_event_sequence=>1328
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
 p_id=>wwv_flow_api.id(271841071134148105241)
,p_event_id=>wwv_flow_api.id(271841070600619105241)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_VINCULO := :p52_VINCULO_x;'
,p_attribute_02=>'P52_VINCULO_X'
,p_attribute_03=>'P52_VINCULO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841071461395105241)
,p_name=>'(S/ Vaga) Popula COD_SINDICATO_1'
,p_event_sequence=>1338
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841072037475105241)
,p_event_id=>wwv_flow_api.id(271841071461395105241)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
':p52_COD_SINDICATO := :p52_COD_SINDICATO_x;',
'',
'if :P52_COD_SINDICATO_X is null and :P52_ROWID is not null then',
':p52_flag := ''N''; ',
unistr('--:p52_mensagem := ''O campo Sindicato n\00E3o pode ser nulo!'';'),
'end if;',
'',
'end;'))
,p_attribute_02=>'P52_COD_SINDICATO_X,P52_ROWID'
,p_attribute_03=>'P52_COD_SINDICATO,P52_FLAG,P52_MENSAGEM'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841072427007105241)
,p_name=>'(S/ Vaga) Popula COD_LOCAL_TRAB'
,p_event_sequence=>1348
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841072913536105242)
,p_event_id=>wwv_flow_api.id(271841072427007105241)
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
 p_id=>wwv_flow_api.id(271841073321429105242)
,p_name=>'Popula COD_CCUSTO_X'
,p_event_sequence=>1358
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CCUSTO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841073826029105242)
,p_event_id=>wwv_flow_api.id(271841073321429105242)
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
 p_id=>wwv_flow_api.id(271841074216873105242)
,p_name=>'Popula COD_UNIDADE_ADM_X'
,p_event_sequence=>1368
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UNIDADE_ADM'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841074676489105243)
,p_event_id=>wwv_flow_api.id(271841074216873105242)
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
 p_id=>wwv_flow_api.id(271841075062344105243)
,p_name=>'Popula COD_ATIVIDADE_X'
,p_event_sequence=>1378
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
 p_id=>wwv_flow_api.id(271841075572898105243)
,p_event_id=>wwv_flow_api.id(271841075062344105243)
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
 p_id=>wwv_flow_api.id(271841076033843105243)
,p_name=>'Popula COD_LOCAL_TRAB_X'
,p_event_sequence=>1388
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841076474340105243)
,p_event_id=>wwv_flow_api.id(271841076033843105243)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':P52_COD_LOCAL_TRAB_X := :P52_COD_LOCAL_TRAB;'
,p_attribute_02=>'P52_COD_LOCAL_TRAB'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841076894628105244)
,p_name=>'(1) Popula VINCULO_X'
,p_event_sequence=>1398
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841077410000105244)
,p_event_id=>wwv_flow_api.id(271841076894628105244)
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
 p_id=>wwv_flow_api.id(271841077811595105244)
,p_name=>'Popula COD_UN_NEGOCIO_X'
,p_event_sequence=>1408
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_UN_NEGOCIO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841078279959105244)
,p_event_id=>wwv_flow_api.id(271841077811595105244)
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
 p_id=>wwv_flow_api.id(271841078691556105244)
,p_name=>'Popula COD_CARGO_X'
,p_event_sequence=>1418
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CARGO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841079181534105245)
,p_event_id=>wwv_flow_api.id(271841078691556105244)
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
 p_id=>wwv_flow_api.id(271841079577948105245)
,p_name=>'Popula COD_FUNCAO_X'
,p_event_sequence=>1428
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_FUNCAO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841080070070105245)
,p_event_id=>wwv_flow_api.id(271841079577948105245)
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
 p_id=>wwv_flow_api.id(271841080522615105245)
,p_name=>'Popula COD_CATEGORIA_X'
,p_event_sequence=>1438
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_CATEGORIA'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841080995312105246)
,p_event_id=>wwv_flow_api.id(271841080522615105245)
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
 p_id=>wwv_flow_api.id(271841081407682105246)
,p_name=>'(1) Popula COD_SINDICATO_X'
,p_event_sequence=>1448
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841081899245105246)
,p_event_id=>wwv_flow_api.id(271841081407682105246)
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
 p_id=>wwv_flow_api.id(271841082310102105246)
,p_name=>'Popula RT_JORNADA_MENSAL_X'
,p_event_sequence=>1458
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841082819622105246)
,p_event_id=>wwv_flow_api.id(271841082310102105246)
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
 p_id=>wwv_flow_api.id(271841083213588105247)
,p_name=>'Popula COD_HORARIO_X'
,p_event_sequence=>1468
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO'
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841083717582105247)
,p_event_id=>wwv_flow_api.id(271841083213588105247)
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
 p_id=>wwv_flow_api.id(271841084069763105247)
,p_name=>'adicionar_nota'
,p_event_sequence=>1478
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840788218691105011)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841084613063105247)
,p_event_id=>wwv_flow_api.id(271841084069763105247)
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
 p_id=>wwv_flow_api.id(271841084968617105248)
,p_name=>'Refresh Candidatos'
,p_event_sequence=>1488
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840788218691105011)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841085507017105248)
,p_event_id=>wwv_flow_api.id(271841084968617105248)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281750981966006977807)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841085869199105248)
,p_name=>'Clear Avaliar Candidatos'
,p_event_sequence=>1498
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_CANDIDATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841086376231105248)
,p_event_id=>wwv_flow_api.id(271841085869199105248)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_NOTA_CANDIDATO,P52_APROVADO'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841086940075105249)
,p_event_id=>wwv_flow_api.id(271841085869199105248)
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
 p_id=>wwv_flow_api.id(271841087273691105249)
,p_name=>'Seta Aprovado'
,p_event_sequence=>1508
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_NOTA_CANDIDATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841087852898105249)
,p_event_id=>wwv_flow_api.id(271841087273691105249)
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
 p_id=>wwv_flow_api.id(271841088211259105249)
,p_name=>'Refresh Acompanhamento Candidato'
,p_event_sequence=>1518
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_FASE_CAND,P52_CANDIDATO_ACMP'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841088743084105249)
,p_event_id=>wwv_flow_api.id(271841088211259105249)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281827490032502106561)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841090019134105250)
,p_name=>unistr('Show / Hide Aprova\00E7\00F5es')
,p_event_sequence=>1528
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
 p_id=>wwv_flow_api.id(271841090499845105251)
,p_event_id=>wwv_flow_api.id(271841090019134105250)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841091028459105251)
,p_event_id=>wwv_flow_api.id(271841090019134105250)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841091526351105251)
,p_event_id=>wwv_flow_api.id(271841090019134105250)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841092019474105252)
,p_event_id=>wwv_flow_api.id(271841090019134105250)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'BUTTON'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841092428760105252)
,p_name=>'(Hide/Show) DT_PREV_FIM_CONTRATO'
,p_event_sequence=>1538
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_CONTRATO'
,p_condition_element=>'P52_TIPO_CONTRATO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841092777108105252)
,p_event_id=>wwv_flow_api.id(271841092428760105252)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841093347249105252)
,p_event_id=>wwv_flow_api.id(271841092428760105252)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_DT_PREV_FIM_CONTRATO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841093737422105252)
,p_name=>'Dispara Alerta Aprov'
,p_event_sequence=>1548
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_MENSAGEM_APROV'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841094231916105253)
,p_event_id=>wwv_flow_api.id(271841093737422105252)
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
 p_id=>wwv_flow_api.id(271841094639928105253)
,p_name=>'Save'
,p_event_sequence=>1558
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744539043104950)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148025604925523476237)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
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
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271331918268098503424)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_OK").getValue().length == 0 || apex.item("P52_OK").getValue() == ''S'') {',
'if (apex.item("P52_RT_JORNADA_MENSAL_X").getValue().length == 0) {',
'    apex.item("P52_OK").setValue(''N'');',
'    apex.item("P52_ITEM_VALIDACAO").setValue(''P52_RT_JORNADA_MENSAL'');',
unistr('    alertify.alert("Preencha a Carga Hor\00E1ria!");'),
'    document.getElementById("alertify-cover").style.position="static";',
'}else if (apex.item("P52_COD_HORARIO_X").getValue().length == 0){',
'    apex.item("P52_OK").setValue(''N'');',
'    apex.item("P52_ITEM_VALIDACAO").setValue(''P52_COD_HORARIO'');',
unistr('    alertify.alert("Preencha o Hor\00E1rio Contratual!");'),
'    document.getElementById("alertify-cover").style.position="static";',
'}else{',
' apex.item("P52_OK").setValue(''S'');',
' apex.item("P52_COD_CCUSTO").enable();',
' apex.item("P52_COD_CCUSTO_CONTAB").enable();',
' apex.item("P52_COD_UN_NEGOCIO").enable();',
' apex.item("P52_COD_UNIDADE_ADM").enable();',
' apex.item("P52_COD_ATIVIDADE").enable();',
' apex.item("P52_COD_LOCAL_TRAB").enable();',
' apex.item("P52_VINCULO").enable();',
' apex.item("P52_TRAB_INTERMITENTE").enable();',
' apex.item("P52_COD_CARGO").enable();',
' apex.item("P52_SALARIO").enable();',
' apex.item("P52_MAT_SUBS").enable();',
' apex.item("P52_TOTAL_SALARIO").enable();',
' apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
' apex.item("P52_SALARIO").enable();',
'    apex.item("P52_TIPO_MODALIDADE").enable();',
'    apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
' apex.item("P52_VALOR_FATURAVEL").enable();',
' apex.item("P52_IND_INSALUB").enable();',
' apex.item("P52_IND_PERIC").enable();',
' apex.item("P52_TIPO_SALARIO").enable();',
' apex.item("P52_COD_CATEGORIA").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'apex.item("P52_MARCA_PONTO").enable();',
'apex.item("P52_TP_REGISTRO_PONTO").enable();',
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
'',
unistr('apex.item("P52_COD_AREA").enable(); // mk 020822 corre\00E7\00E3o na sintaxe. antes, estava assim: apex.ite,("P52_COD_AREA").enable();'),
'    ',
'     apex.item("P52_SALARIO_MAX").enable();',
'     apex.item("P52_VALOR_FATURAVEL").enable();',
'     apex.item("P52_REMUNERACAO_VARIAVEL").enable();',
'     apex.item("P52_TOTAL_SALARIO").enable();',
'     apex.item("P52_SALARIO").enable();',
'     apex.item("P52_PERC_BENEFICIO").enable();',
'     apex.item("P52_COD_REQ").enable();',
'     apex.item("P52_CPF_INDICADO").enable();',
'     apex.item("P52_NOME_INDICADO").enable();',
'     apex.item("P52_E_MAIL_INDICADO").enable();',
'     apex.item("P52_DDD_INDICADO").enable();',
'     apex.item("P52_TELEFONE_INDICADO").enable();',
'     apex.item("P52_MOTIVO_EXCECAO").enable();',
'     apex.item("P52_ORGAO_PUBLICO").enable();',
'     apex.item("P52_NOVO_CONTRATO").enable();',
'     apex.item("P52_VALOR_VENDA").enable();',
'     apex.item("P52_DESC_ATIVIDADES").enable();',
'     apex.item("P52_MAT_SUBS").enable();',
'     apex.item("P52_VLR_AUX_TIPO_MODALIDADE").enable();',
'     apex.item("P52_TIPO_MODALIDADE").enable();',
'     apex.item("P52_TRAB_INTERMITENTE").enable();',
'     apex.item("P52_COD_AREA").enable();',
'    ',
'    apex.submit(''SAVE'');',
'}',
'}',
'',
''))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(236427590767454761906)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>30
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
 p_id=>wwv_flow_api.id(271841095065710105253)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>40
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
'IF NVL(perc_excecao,0) > 0 THEN',
':P52_PERC_BENEFICIO := NVL(perc_excecao,0);',
'ELSE',
':P52_PERC_BENEFICIO := NVL(perc_benef,0);',
'END IF;',
'',
'if v_c1.cod_sit_req = :p52_cod_sit_req and (',
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
'DT_SIT_REQ = :P52_DT_SIT_REQ,',
'vinculo = :p52_vinculo,',
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
'VLR_AUX_TIPO_MODALIDADE = :P52_VLR_AUX_TIPO_MODALIDADE,',
'VAGA_FATURAVEL = :P52_VAGA_FATURAVEL,',
'VALOR_FATURAVEL = :P52_VALOR_FATURAVEL,',
'TIPO_MODALIDADE = :P52_TIPO_MODALIDADE,',
'COD_AREA = :P52_COD_AREA,',
'RT_JORNADA_MENSAL = :P52_RT_JORNADA_MENSAL_X,',
'COD_HORARIO = :P52_COD_HORARIO_X,',
'refeitorio = :p52_refeitorio,',
'usuario = :p_usuario,',
'dt_atualizacao = sysdate',
'where cod_req = :p52_cod_req_x;',
'',
'commit;',
'end;',
'',
'elsif v_c1.cod_sit_req <> :p52_cod_sit_req then',
'',
'begin',
'update REQUISICAO',
'set COD_SIT_REQ = :P52_COD_SIT_REQ,',
'PAR_JUST = :P52_PAR_JUST,',
'PAR_RH = :P52_PAR_RH,',
'par_orc = :P52_PAR_ORC',
'where cod_req = :p52_cod_req_x;',
'',
'commit;',
'end;',
'',
'else',
'',
'begin',
'update REQUISICAO',
'set PAR_JUST = :P52_PAR_JUST,',
'PAR_RH = :P52_PAR_RH,',
'par_orc = :P52_PAR_ORC',
'where cod_req = :p52_cod_req_x;',
'',
'commit;',
'end;',
'',
'end if;',
'',
'begin',
'insert into tar_peso (cod_req, cod_tarefa_req, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req_x, cod_tarefa_req, cod_peso, :p_usuario, sysdate from tar_peso_temp where seq = :p52_seq);',
'commit;',
'delete from tar_peso_temp where seq = :p52_seq;',
'commit;',
'end;',
'',
'begin',
'insert into carac_peso (cod_req, cod_carac_func, cod_peso, usuario, dt_atualizacao) (select :p52_cod_req_x, cod_carac_func, cod_peso, :p_usuario, sysdate from carac_peso_temp where seq = :p52_seq);',
'commit;',
'delete from carac_peso_temp where seq = :p52_seq;',
'commit;',
'end;',
'',
'begin',
'update idioma_req_pessoal',
'set cod_req = :p52_cod_req_x',
'where seq = :p52_seq;',
'commit;',
'end;',
'',
'begin',
'update beneficios_vaga_temp',
'set cod_requisicao = :p52_cod_req_x',
'where seq = :p52_seq;',
'commit;',
'end;',
'',
'pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req_x, v_flg_retorno, v_msg_retorno);',
'',
'commit;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_SIT_REQ,P52_VINCULO,P52_ANOS_SERVICO,P52_MESES_SERVICO,P52_SEXO,P52_COD_INSTRUCAO,P52_OBSERVACAO,P52_POS_ESTR_ORG,P52_EXP_NEC,P52_REL_FUNC,P52_FAT_INS,P52_PERS_DES,P52_PAR_JUST,P52_PAR_RH,P52_PAR_ORC,P52_COD_REQ_X,P52_COD_EMPRESA,P52_SEQ,P52_'
||'COD_SINDICATO_X,P52_PERC_BENEFICIO,P52_PERC_BENEFICIO_VARIAVEL,P52_PERC_BENEF_EXCECAO,P52_REMUNERACAO_VARIAVEL,P52_SALARIO,P52_VAGA_FATURAVEL,P52_VALOR_FATURAVEL,P_USUARIO,P52_VLR_AUX_TIPO_MODALIDADE,P52_TIPO_MODALIDADE,P52_COD_AREA,P52_COD_HORARIO_X'
||',P52_RT_JORNADA_MENSAL_X,P52_OK,P52_REFEITORIO'
,p_attribute_03=>'P52_PERC_BENEFICIO'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(107412844112171937527)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
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
'if v_c1.cod_sit_req = :p52_cod_sit_req and (',
'nvl(v_c1.prospeccao,''N'') = ''S'' and nvl(:p52_prospeccao,''N'') = ''N''',
') then',
'',
'begin',
'',
'update REQUISICAO',
'set ',
'COD_SIT_REQ = 1,',
'DT_SIT_REQ = sysdate,',
'prospeccao = ''N'',',
'usuario = :p_usuario,',
'dt_atualizacao = sysdate',
'where cod_req = :p52_cod_req_x;',
'',
'commit;',
'end;',
'',
'----',
'',
'      Prc_Insere_Aprovador (:p52_cod_req_x,''REQ_PESSOAL'', v_flg_retorno, v_msg_retorno); ',
'      commit;',
'      ',
'      pkg_pessoal.Post_Update (:p52_cod_empresa,',
'                               :p52_cod_req_x,',
'                               v_flg_retorno,',
'                               v_msg_retorno);',
'      commit;       ',
'      ',
'      pkg_pessoal.prc_update_req (:p52_cod_req_x,',
'                                  usuario.busca_user,',
'                                  v_flg_retorno,',
'                                  v_msg_retorno);',
'      commit;   ',
'',
'----',
'--pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req_x, v_flg_retorno, v_msg_retorno);',
'end if;',
'commit;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_REQ_X,P52_COD_SIT_REQ,P52_OK,P52_PROSPECCAO,P_USUARIO,P52_COD_EMPRESA'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271331917957343503421)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>60
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
'       nvl(v_c1.idade_max,0) != :p52_idade_max  or',
'       nvl(v_c1.cod_cargo,''X'') != :p52_cargo or',
'       nvl(v_c1.cod_funcao,''X'') != :p52_cod_funcao',
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
'       emp_gestor_ind = :p52_emp_gestor_ind,',
'       mat_gestor_ind = :p52_mat_gestor_ind,',
'       emp_avaliador_ind = :p52_emp_avaliador_ind,',
'       mat_avaliador_ind = :p52_mat_avaliador_ind,',
'       idade_min = :p52_idade_min,',
'       idade_max = :p52_idade_max,',
'       cod_cargo = :p52_cod_cargo,',
'       cod_funcao = :p52_cod_funcao,',
'       usuario = :p_usuario,',
'       dt_atualizacao = sysdate',
' where cod_req = :p52_cod_req;',
'',
' commit;',
'',
'end;',
'',
'end if;',
'',
' pkg_pessoal.post_update(:p52_cod_empresa, :p52_cod_req_x, v_flg_retorno, v_msg_retorno);',
'',
'commit;',
'end if;',
'end;'))
,p_attribute_02=>'P52_COD_SIT_REQ,P52_COD_REQ,P52_CANDIDATO_INDICADO,P52_NOME_INDICADO,P52_E_MAIL_INDICADO,P52_DDD_INDICADO,P52_TELEFONE_INDICADO,P52_CPF_INDICADO,P52_EMP_GESTOR_IND,P52_MAT_GESTOR_IND,P52_EMP_AVALIADOR_IND,P52_MAT_AVALIADOR_IND,P52_IDADE_MIN,P52_IDADE'
||'_MAX,P52_DESC_ATIVIDADES,P_USUARIO,P52_OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841095651042105253)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>70
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
 p_id=>wwv_flow_api.id(271331918157978503423)
,p_event_id=>wwv_flow_api.id(271841094639928105253)
,p_event_result=>'TRUE'
,p_action_sequence=>80
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
'       cod_horario = v_c1.cod_horario,',
'       cod_sindicato = v_c1.cod_sindicato,',
'       cod_unidade_adm = v_c1.cod_unidade_adm,',
'       cod_atividade = v_c1.cod_atividade,',
'       vinculo = v_c1.vinculo,',
'       cod_un_negocio = v_c1.cod_un_negocio,',
'       cod_cargo = v_c1.cod_cargo,',
'       cod_funcao = v_c1.cod_funcao,',
'       cod_categoria = v_c1.cod_categoria',
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841097038129105254)
,p_name=>'get_lov_display (popup_lov)'
,p_event_sequence=>1568
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.popup_lov'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841097553040105255)
,p_event_id=>wwv_flow_api.id(271841097038129105254)
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
 p_id=>wwv_flow_api.id(271841097903665105255)
,p_name=>'get_lov_display (select2)'
,p_event_sequence=>1578
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.select2'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841098384501105255)
,p_event_id=>wwv_flow_api.id(271841097903665105255)
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
 p_id=>wwv_flow_api.id(271841098798641105255)
,p_name=>'get_lov_display (p52_cod_local_trab_1)'
,p_event_sequence=>1588
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB_X'
,p_condition_element=>'P52_COD_LOCAL_TRAB_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841099263515105256)
,p_event_id=>wwv_flow_api.id(271841098798641105255)
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
 p_id=>wwv_flow_api.id(148018077187904397330)
,p_name=>'get_lov_display (p52_rt_jornada_mensal)'
,p_event_sequence=>1598
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL'
,p_condition_element=>'P52_RT_JORNADA_MENSAL'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148018077309983397331)
,p_event_id=>wwv_flow_api.id(148018077187904397330)
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841099700650105256)
,p_name=>'Desc. Local Trab'
,p_event_sequence=>1608
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_LOCAL_TRAB,P52_COD_LOCAL_TRAB_1'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841100227257105256)
,p_event_id=>wwv_flow_api.id(271841099700650105256)
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
 p_id=>wwv_flow_api.id(271841100614871105257)
,p_name=>'Motivo Excecao'
,p_event_sequence=>1618
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
 p_id=>wwv_flow_api.id(271841101074809105257)
,p_event_id=>wwv_flow_api.id(271841100614871105257)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841101589736105257)
,p_event_id=>wwv_flow_api.id(271841100614871105257)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_MOTIVO_EXCECAO'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271841101974711105257)
,p_name=>'Empresa Aloca Colab?'
,p_event_sequence=>1628
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_IND_SERV_ALOCA_COLAB'
,p_condition_element=>'P52_IND_SERV_ALOCA_COLAB'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841102531298105258)
,p_event_id=>wwv_flow_api.id(271841101974711105257)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433600701182528962)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841103978614105258)
,p_event_id=>wwv_flow_api.id(271841101974711105257)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433597859063528934)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841103027200105258)
,p_event_id=>wwv_flow_api.id(271841101974711105257)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433597859063528934)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271841103500999105258)
,p_event_id=>wwv_flow_api.id(271841101974711105257)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(272433600701182528962)
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271326752409675138146)
,p_name=>'Create (Vaga) Popula campos vazios'
,p_event_sequence=>1638
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(271840744948867104950)
,p_condition_element=>'P52_COD_VAGA'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'focusin'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271326752554617138148)
,p_event_id=>wwv_flow_api.id(271326752409675138146)
,p_event_result=>'TRUE'
,p_action_sequence=>60
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
'if :p52_cod_ccusto_1 is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_ccusto_x :=  v_c1.cod_ccusto;',
':p52_cod_ccusto_1 :=  v_c1.cod_ccusto;',
'',
'end if;',
'',
'if :p52_cod_local_trab_1 is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_local_trab_x :=  v_c1.cod_local_trab;',
':p52_cod_local_trab_1 :=  v_c1.cod_local_trab;',
'',
'end if;',
'',
'if :p52_cod_ccusto_contab_1 is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_ccusto_contab_x :=  v_c1.cod_ccusto_contab;',
':p52_cod_ccusto_contab_1 :=  v_c1.cod_ccusto_contab;',
'end if;',
'',
'if :p52_cod_horario_1 is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_horario_x :=  v_c1.cod_horario;',
':p52_cod_horario_1 :=  v_c1.cod_horario;',
'end if;    ',
'',
'if :P52_COD_SINDICATO_1 is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':P52_COD_SINDICATO_1 := v_c1.cod_sindicato;',
':p52_cod_sindicato_x := v_c1.cod_sindicato;',
'end if;',
'',
'if :p52_tipo_salario is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_tipo_salario := v_c1.tipo_salario;',
'',
'end if;',
'',
'if :p52_total_salario is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_total_salario := v_c1.total_salario;',
'',
'end if;',
'',
'if :p52_salario is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_salario := v_c1.salario;',
'',
'end if;',
'',
'if :p52_remuneracao_variavel is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_remuneracao_variavel := v_c1.remuneracao_variavel;',
'',
'end if;',
'',
'if :p52_perc_beneficio is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_perc_beneficio := v_c1.perc_beneficio_variavel;',
'',
'end if;',
'',
'if :p52_tipo_modalidade is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_tipo_modalidade := v_c1.tipo_modalidade;',
'',
'end if;',
'',
'if :p52_vlr_aux_tipo_modalidade is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_vlr_aux_tipo_modalidade := v_c1.vlr_aux_tipo_modalidade;',
'',
'end if;',
'',
'if :p52_trab_intermitente is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_trab_intermitente := v_c1.trab_intermitente;',
'',
'end if;',
'    ',
'if :p52_cod_area is null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
':p52_cod_area := v_c1.cod_area;',
'',
'end if;',
'    ',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA,P_USUARIO,P52_COD_CCUSTO_CONTAB_1,P52_COD_LOCAL_TRAB_1,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_SINDICATO_1,P52_TOTAL_SALARIO,P52_SALARIO,P52_REMUNERACAO_VARIAVEL,P52_PERC_BENEFICIO,P52_TIPO_SALARIO,P52_T'
||'IPO_MODALIDADE,P52_VLR_AUX_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA,P52_VAGA_DISP_POR_REQ_DESLIG'
,p_attribute_03=>'P52_COD_LOCAL_TRAB_X,P52_COD_LOCAL_TRAB_1,P52_COD_CCUSTO_CONTAB_1,P52_COD_CCUSTO_CONTAB_X,P52_COD_HORARIO_X,P52_COD_HORARIO_1,P52_COD_CCUSTO_1,P52_COD_CCUSTO_X,P52_COD_SINDICATO_1,P52_COD_SINDICATO_X,P52_TOTAL_SALARIO,P52_SALARIO,P52_REMUNERACAO_VARI'
||'AVEL,P52_PERC_BENEFICIO,P52_TIPO_SALARIO,P52_TIPO_MODALIDADE,P52_VLR_AUX_TIPO_MODALIDADE,P52_TRAB_INTERMITENTE,P52_COD_AREA'
,p_attribute_04=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271331917512073503416)
,p_name=>unistr('Ap\00F3s Apagar Caracteristicas1')
,p_event_sequence=>1648
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281920645461369084114)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271331917565194503417)
,p_event_id=>wwv_flow_api.id(271331917512073503416)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920645461369084114)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(271331917771132503419)
,p_name=>unistr('Ap\00F3s Apagar Tarefas1')
,p_event_sequence=>1658
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(281920644686851084106)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(271331917884123503420)
,p_event_id=>wwv_flow_api.id(271331917771132503419)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(281920644686851084106)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270629212865699313116)
,p_name=>'(Mouse Move) Popular Campos Y'
,p_event_sequence=>1668
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(272433597777183528933)
,p_condition_element=>'P52_QTD_MOUSE_MOVE'
,p_triggering_condition_type=>'LESS_THAN_OR_EQUAL'
,p_triggering_expression=>'5'
,p_bind_type=>'bind'
,p_bind_event_type=>'mousemove'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270629212929237313117)
,p_event_id=>wwv_flow_api.id(270629212865699313116)
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
 p_id=>wwv_flow_api.id(269930769582909265644)
,p_name=>'(Transferencia) Mat_Subs'
,p_event_sequence=>1678
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
 p_id=>wwv_flow_api.id(269930769516108265643)
,p_event_id=>wwv_flow_api.id(269930769582909265644)
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
 p_id=>wwv_flow_api.id(269940606195504179627)
,p_name=>'Reprovar - Dialog Closed'
,p_event_sequence=>1688
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940605241929179618)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940606294477179628)
,p_event_id=>wwv_flow_api.id(269940606195504179627)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVACAO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269940606388629179629)
,p_name=>'Aprovar - Dialog Closed'
,p_event_sequence=>1698
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269940605349985179619)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269940606485391179630)
,p_event_id=>wwv_flow_api.id(269940606388629179629)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'APROVACAO'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269954060935976661025)
,p_name=>'Criar Igual'
,p_event_sequence=>1708
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269954060813957661024)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269954061044200661027)
,p_event_id=>wwv_flow_api.id(269954060935976661025)
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
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269954061383311661030)
,p_event_id=>wwv_flow_api.id(269954060935976661025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'CRIAR_IGUAL'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(269956581695289880646)
,p_name=>'Open Req. Descendentes'
,p_event_sequence=>1718
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(269956581443098880644)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(269956581778755880647)
,p_event_id=>wwv_flow_api.id(269956581695289880646)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(269956581602926880645)
,p_attribute_01=>'this.affectedElements.dialog(''open'');'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270227835679148025643)
,p_name=>'(Colab) Add. Colab - Dialog Closed'
,p_event_sequence=>1728
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270154898158374193860)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227835834379025644)
,p_event_id=>wwv_flow_api.id(270227835679148025643)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270154898143355193859)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270227837736325025663)
,p_name=>'(Cand) Add. Cand - Dialog Closed'
,p_event_sequence=>1738
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(270227836162263025648)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227837794042025664)
,p_event_id=>wwv_flow_api.id(270227837736325025663)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270227836104693025647)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270227835891908025645)
,p_name=>'(IR Colab) Add. Colab - Dialog Closed'
,p_event_sequence=>1748
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(270154898143355193859)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227836004479025646)
,p_event_id=>wwv_flow_api.id(270227835891908025645)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270154898143355193859)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270227839231165025678)
,p_name=>'(IR Cand) Add. Cand - Dialog Closed'
,p_event_sequence=>1758
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(270227836104693025647)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270227839292932025679)
,p_event_id=>wwv_flow_api.id(270227839231165025678)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(270227836104693025647)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(270734139800668243751)
,p_name=>'(Pesquisa) Disable Fields'
,p_event_sequence=>1768
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(270734139911370243752)
,p_event_id=>wwv_flow_api.id(270734139800668243751)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item("P52_ROWID").getValue().length > 0) {',
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
'apex.item("P52_COD_UN_NEGOCIO").disable(); ',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_MAT_SUBS").disable();',
'apex.item("P52_MOT_SUBS").disable();',
'apex.item("P52_PONTOS_AVAL").disable();',
'apex.item("P52_CANDIDATO_INDICADO").disable();',
'apex.item("P52_IND_DEF_FIS").disable();',
'apex.item("P52_RAIS_IND_DEF_AUDITIVA").disable();',
'apex.item("P52_RAIS_IND_DEF_FISICO").disable();',
'apex.item("P52_RAIS_IND_DEF_MENTAL").disable();',
'apex.item("P52_RAIS_IND_DEF_MULTIPLA").disable();',
'apex.item("P52_RAIS_IND_DEF_VISUAL").disable();',
'apex.item("P52_RT_JORNADA_MENSAL").disable();',
'apex.item("P52_MARCA_PONTO").disable();',
'apex.item("P52_TP_REGISTRO_PONTO").disable();',
'apex.item("P52_DATA_INICIO").disable();',
'apex.item("P52_DATA_FIM").disable();',
'apex.item("P52_TIPO_CONTRATO").disable();',
'apex.item("P52_DT_PREVISAO_ADMISSAO").disable();',
'apex.item("P52_DT_PREV_FIM_CONTRATO").disable();',
'apex.item("P52_VAGA_CONFIDENCIAL").disable();',
'apex.item("P52_REFEITORIO").disable();',
'apex.item("P52_COD_SINDICATO").disable();',
'apex.item("P52_COD_CARGO").disable();',
'apex.item("P52_COD_FUNCAO").disable(); ',
'apex.item("P52_COD_CATEGORIA").disable(); ',
'apex.item("P52_VAGA_FATURAVEL").disable();',
'apex.item("P52_VALOR_FATURAVEL").disable();',
'apex.item("P52_TOTAL_SALARIO").disable();',
'apex.item("P52_SALARIO").disable();',
'apex.item("P52_PERC_BENEFICIO_VARIAVEL").disable();',
'apex.item("P52_REMUNERACAO_VARIAVEL").disable();',
'apex.item("P52_PERC_BENEF_EXCECAO").disable();',
'apex.item("P52_TIPO_SALARIO").disable();',
'apex.item("P52_COD_HORARIO").disable();',
'apex.item("P52_VINCULO").disable();',
'apex.item("P52_TRAB_INTERMITENTE").disable();',
'apex.item("P52_TIPO_MODALIDADE").disable();',
'apex.item("P52_VLR_AUX_TIPO_MODALIDADE").disable();',
'if ((apex.item("P9999_PERFIL").getValue() == "MASTER" ',
'|| apex.item("P9999_PERFIL").getValue() == "REMUNERACAO") &&',
'(apex.item("P52_COD_SIT_REQ").getValue() == "1" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "5") &&',
'apex.item("P52_COD_VAGA").getValue().length == 0)',
'{apex.item("P52_REFEITORIO").enable();',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_COD_AREA").enable();',
'apex.item("P52_COD_CARGO").enable();',
'apex.item("P52_COD_FUNCAO").enable();',
'apex.item("P52_COD_CATEGORIA").enable();}  ',
'if ((apex.item("P9999_PERFIL").getValue() == "SELECAO") &&',
'(apex.item("P52_COD_SIT_REQ").getValue() == "1" ||',
'apex.item("P52_COD_SIT_REQ").getValue() == "5") &&',
'apex.item("P52_TIPO_MODALIDADE").getValue() == "E")',
'{apex.item("P52_REFEITORIO").enable();',
'apex.item("P52_COD_SINDICATO").enable();',
'apex.item("P52_COD_SINDICATO_1").enable();',
'apex.item("P52_VAGA_FATURAVEL").enable();',
'apex.item("P52_VALOR_FATURAVEL").enable();',
'apex.item("P52_RT_JORNADA_MENSAL").enable();',
'apex.item("P52_COD_HORARIO").enable();',
'apex.item("P52_VINCULO").enable();',
'apex.item("P52_TIPO_MODALIDADE").enable();',
'apex.item("P52_COD_AREA").enable(); }',
'}'))
,p_da_action_comment=>unistr('habilitado os campos p52_cod_cargo, p52_cod_funcao e P52_COD_CATEGORIA que antes estavam sinalizados para desabilitar (cibele/patr\00EDcia 12/09/2024)')
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268761526233326120817)
,p_name=>unistr('Habilita/Desabilita Valor Aux\00EDlio')
,p_event_sequence=>1788
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_TIPO_MODALIDADE'
,p_condition_element=>'P52_TIPO_MODALIDADE'
,p_triggering_condition_type=>'IN_LIST'
,p_triggering_expression=>'S,H'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268761526391763120818)
,p_event_id=>wwv_flow_api.id(268761526233326120817)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268761526467420120819)
,p_event_id=>wwv_flow_api.id(268761526233326120817)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268761526739168120822)
,p_event_id=>wwv_flow_api.id(268761526233326120817)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_VLR_AUX_TIPO_MODALIDADE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868624969194625546)
,p_event_id=>wwv_flow_api.id(268761526233326120817)
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
 p_id=>wwv_flow_api.id(263631956035150526287)
,p_event_id=>wwv_flow_api.id(268761526233326120817)
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
 p_id=>wwv_flow_api.id(268761526528114120820)
,p_name=>'Valida Vlr Aux Tipo Modalidade'
,p_event_sequence=>1798
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
'elsif :p52_rowid is not null and :p52_cod_sit_req in (1,5) then',
'return true;',
'else',
'return false;',
'end if;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268761526711859120821)
,p_event_id=>wwv_flow_api.id(268761526528114120820)
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
 p_id=>wwv_flow_api.id(268868622674635625523)
,p_name=>'Mostra Valores (New)'
,p_event_sequence=>1808
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_PERC_BENEFICIO_VARIAVEL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868622752689625524)
,p_event_id=>wwv_flow_api.id(268868622674635625523)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
'  //alert("item #07");',
'  ',
'  if (apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 ){',
'',
'    //alert("item #08");',
'    ',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'',
'    if ( apex.item("P52_PERC_BENEFICIO").getValue().trim() > 0 || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 20 || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != 30 || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "0,00" || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "20,00" || ',
'         apex.item("P52_PERC_BENEFICIO").getValue().trim() != "30,00"){',
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
'',
'  } else {',
'    ',
'    //alert("item #11");',
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'',
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
 p_id=>wwv_flow_api.id(268868622817412625525)
,p_name=>'(Pesquisa) Mostra Valores'
,p_event_sequence=>1818
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868622925244625526)
,p_event_id=>wwv_flow_api.id(268868622817412625525)
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
 p_id=>wwv_flow_api.id(268868623739827625534)
,p_name=>'AJUSTAR REMUNERACAO'
,p_event_sequence=>1828
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(268868623666382625533)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868623884672625535)
,p_event_id=>wwv_flow_api.id(268868623739827625534)
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
 p_id=>wwv_flow_api.id(143436074954145473098)
,p_event_id=>wwv_flow_api.id(268868623739827625534)
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
'  //alert("item #07");',
'  ',
'  if (apex.item("P52_PERC_BENEFICIO").getValue().trim().length > 0 ){',
'',
'    //alert("item #08");',
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
'    //alert("item #11");',
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'      ',
'      //alert("item #12");',
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
 p_id=>wwv_flow_api.id(268959182082206342445)
,p_name=>unistr('Vinculo (E)stagi\00E1rio')
,p_event_sequence=>1838
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_VINCULO_X'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'E'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959182139425342446)
,p_event_id=>wwv_flow_api.id(268959182082206342445)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959182254766342447)
,p_event_id=>wwv_flow_api.id(268959182082206342445)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959182343959342448)
,p_event_id=>wwv_flow_api.id(268959182082206342445)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268959182412727342449)
,p_event_id=>wwv_flow_api.id(268959182082206342445)
,p_event_result=>'FALSE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_PERC_BENEFICIO_VARIAVEL'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(268802778859939087881)
,p_name=>'Vinculo (C)ontratado'
,p_event_sequence=>1848
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_VINCULO_X'
,p_condition_element=>'P52_VINCULO_X'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802779382463087886)
,p_event_id=>wwv_flow_api.id(268802778859939087881)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802779538616087887)
,p_event_id=>wwv_flow_api.id(268802778859939087881)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_TRAB_INTERMITENTE'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268802779609366087888)
,p_event_id=>wwv_flow_api.id(268802778859939087881)
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
 p_id=>wwv_flow_api.id(268146917396508908019)
,p_name=>'(Pesquisa) Dados de Vaga'
,p_event_sequence=>1858
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'FUNCTION_BODY'
,p_display_when_cond=>wwv_flow_string.join(wwv_flow_t_varchar2(
'IF :P52_ROWID IS NOT NULL AND :P52_COD_VAGA IS NOT NULL THEN',
'RETURN TRUE;',
'END IF;'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268146917570542908020)
,p_event_id=>wwv_flow_api.id(268146917396508908019)
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
'   ',
'v_c1 c1%rowtype;',
'',
'begin',
'',
'if :p52_cod_vaga is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
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
':P52_COD_HORARIO_X := V_C1.COD_HORARIO;',
'',
'end if;',
'',
'exception',
'when others then',
'null;',
'',
'end;'))
,p_attribute_02=>'P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_VAGA'
,p_attribute_03=>'P52_COD_CCUSTO_X,P52_COD_UNIDADE_ADM_X,P52_COD_ATIVIDADE_X,P52_COD_LOCAL_TRAB_X,P52_COD_CCUSTO_CONTAB_X,P52_VINCULO_X,P52_COD_UN_NEGOCIO_X,P52_COD_CARGO_X,P52_COD_FUNCAO_X,P52_COD_CATEGORIA_X,P52_COD_SINDICATO_X,P52_COD_HORARIO_X'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254087187323532069778)
,p_name=>'(Anexo 1) Limpar'
,p_event_sequence=>1868
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(254087187141179069777)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254087187403397069779)
,p_event_id=>wwv_flow_api.id(254087187323532069778)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_CLEAR'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P52_ANEXO_1'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254087187523066069780)
,p_name=>'(Anexo 1) Valida Tamanho de Arquivo '
,p_event_sequence=>1878
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_ANEXO_1'
,p_condition_element=>'P52_ANEXO_1'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254087187545446069781)
,p_event_id=>wwv_flow_api.id(254087187523066069780)
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
'if (apex.item("P52_ROWID").getValue().length > 0) {',
'    apex.item("P52_ANEXO_1").disable();',
'}'))
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254087187726034069782)
,p_event_id=>wwv_flow_api.id(254087187523066069780)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#CLEAR_ANEXO_1'').hide();',
'',
'if (apex.item("P52_ROWID").getValue().length > 0) {',
'    apex.item("P52_ANEXO_1").disable();',
'}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(254131742440899114072)
,p_name=>unistr('(Sindicato) Valida Valor de Remunera\00E7\00E3o')
,p_event_sequence=>1888
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_condition_element=>'P52_COD_SINDICATO_X'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(254131742546397114073)
,p_event_id=>wwv_flow_api.id(254131742440899114072)
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
 p_id=>wwv_flow_api.id(247001297226418909590)
,p_name=>unistr('Ajustar Remunera\00E7\00E3o = ''S''')
,p_event_sequence=>1898
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_AJUSTAR_REMUNERACAO'
,p_condition_element=>'P52_AJUSTAR_REMUNERACAO'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(268868623950588625536)
,p_event_id=>wwv_flow_api.id(247001297226418909590)
,p_event_result=>'TRUE'
,p_action_sequence=>10
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
 p_id=>wwv_flow_api.id(268868624082443625537)
,p_event_id=>wwv_flow_api.id(247001297226418909590)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (Number(apex.item("P52_PERC_BENEFICIO").getValue().replace('','', ''.'')) > 0){',
'		',
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
'',
'	  } else {',
'',
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
'',
'    apex.item("P52_REMUNERACAO_VARIAVEL").show();',
'    apex.item("P52_PERC_BENEF_EXCECAO").hide();',
'    apex.item("P52_MOTIVO_EXCECAO").hide();',
'',
'	}',
'',
'	if (apex.item("P52_TIPO_MODALIDADE").getValue() != ''P''){',
'    ',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").show();',
'	}else{',
'    ',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").hide();',
'		apex.item("P52_VLR_AUX_TIPO_MODALIDADE").setValue("");',
'	}'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(148018076995542397328)
,p_name=>'Nao Apagar RT_JORNADA_MENSAL'
,p_event_sequence=>1908
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_X'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_COD_REQ'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148018076821463397327)
,p_event_id=>wwv_flow_api.id(148018076995542397328)
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
 p_id=>wwv_flow_api.id(148025604032398476228)
,p_name=>'Clear RT_JORNADA_MENSAL'
,p_event_sequence=>1918
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(148025604730666476235)
,p_event_id=>wwv_flow_api.id(148025604032398476228)
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
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147893255544915838824)
,p_name=>'Set Value RT_JORNADA_MENSAL'
,p_event_sequence=>1928
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_RT_JORNADA_MENSAL_Z'
,p_condition_element=>'P52_RT_JORNADA_MENSAL_Z'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147893255610946838825)
,p_event_id=>wwv_flow_api.id(147893255544915838824)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_rt_jornada_mensal := :p52_rt_jornada_mensal_z;'
,p_attribute_02=>'P52_RT_JORNADA_MENSAL_Z'
,p_attribute_03=>'P52_RT_JORNADA_MENSAL'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(147893255734407838826)
,p_name=>'Set Value COD_HORARIO'
,p_event_sequence=>1938
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_HORARIO_Z'
,p_condition_element=>'P52_COD_HORARIO_Z'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(147908105357981567577)
,p_event_id=>wwv_flow_api.id(147893255734407838826)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>':p52_cod_horario := :p52_cod_horario_z;'
,p_attribute_02=>'P52_COD_HORARIO_Z'
,p_attribute_03=>'P52_COD_HORARIO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(127233920135751185657)
,p_name=>'Set Sindicato Aux'
,p_event_sequence=>1948
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127233920202624185658)
,p_event_id=>wwv_flow_api.id(127233920135751185657)
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
 p_id=>wwv_flow_api.id(127233920804669185664)
,p_name=>'Alerta Sindicato'
,p_event_sequence=>1958
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P52_COD_SINDICATO_AUX'
,p_condition_element=>'P52_COD_SINDICATO_AUX'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(127233921433028185670)
,p_event_id=>wwv_flow_api.id(127233920804669185664)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'ALERT'
,p_attribute_04=>unistr('O campo Sindicato n\00E3o pode ser nulo!')
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(107496412935615445902)
,p_name=>'Valida Aprovador'
,p_event_sequence=>1968
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'ITEM_IS_NULL'
,p_display_when_cond=>'P52_ROWID'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(107496413040042445903)
,p_event_id=>wwv_flow_api.id(107496412935615445902)
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
'if nvl(:P52_OK,''S'') = ''S'' then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
'',
'v_flg_retorno := pkg_req.VALIDA_EXISTE_APROV(:p52_cod_empresa,',
'                                              :p52_filial,',
'                                              :p52_cod_ccusto_x,',
'                                              null,--v_c1.matricula,',
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
'',
'/*',
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
'*/',
'end if;',
'',
'end;'))
,p_attribute_02=>'P_EMPRESA_USER,P_MATRICULA_USER,P52_ITEM_VALIDACAO,P52_OK,P52_COD_EMPRESA,P52_COD_FILIAL,P52_COD_CCUSTO_X'
,p_attribute_03=>'P52_OK,P52_FLAG,P52_MENSAGEM,P52_ITEM_VALIDACAO'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840907793468105148)
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
 p_id=>wwv_flow_api.id(271840913442413105151)
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
'    and matricula = REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]'');',
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
 p_id=>wwv_flow_api.id(271840910598366105150)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'Fetch Row from REQUISICAO'
,p_attribute_02=>'REQUISICAO'
,p_attribute_03=>'P52_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select distinct cod_req',
'  from REQUISICAO',
' where cod_req = :p52_cod_req'))
,p_process_when_type=>'EXISTS'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271330891409952668600)
,p_process_sequence=>20
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
 p_id=>wwv_flow_api.id(271840906617128105147)
,p_process_sequence=>30
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
'   and i.matricula = REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]'');',
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
 p_id=>wwv_flow_api.id(271840907035717105147)
,p_process_sequence=>40
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
'   and i.matricula = REGEXP_REPLACE(:p52_mat_subs,''[^[:digit:]]'');',
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
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840912573735105151)
,p_process_sequence=>50
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
 p_id=>wwv_flow_api.id(271840913020592105151)
,p_process_sequence=>60
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
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840908983276105149)
,p_process_sequence=>70
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
 p_id=>wwv_flow_api.id(271840909412803105149)
,p_process_sequence=>80
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
 p_id=>wwv_flow_api.id(271840909835642105149)
,p_process_sequence=>90
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
 p_id=>wwv_flow_api.id(271840908572164105148)
,p_process_sequence=>100
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'(Pesquisa) Popula Campos'
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
'if :p52_cod_req is not null and :p52_cod_vaga is not null then',
'',
'open c1;',
'fetch c1 into v_c1;',
'close c1;',
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
':P52_COD_HORARIO_X := V_C1.COD_HORARIO;',
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
 p_id=>wwv_flow_api.id(270629211713564313105)
,p_process_sequence=>110
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
 p_id=>wwv_flow_api.id(100401424265937548137)
,p_process_sequence=>120
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Popula Mat Sub Edi\00E7\00E3o')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'',
'cursor c1 is ',
'select COD_EMPRESA ',
', mat_subs matricula',
',fnct_nome_func(a.COD_EMPRESA, a.mat_subs) nome',
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
'end if;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840911389900105150)
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
'    :P52_COD_SIT_REQ := 1;',
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
' EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= '''',.'''' '';',
'',
' ',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840911797563105150)
,p_process_sequence=>30
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
'END IF;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269984184685006451332)
,p_process_sequence=>40
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
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840910996527105150)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_FORM_PROCESS'
,p_process_name=>'Process Row of REQUISICAO'
,p_attribute_02=>'REQUISICAO'
,p_attribute_03=>'P52_COD_REQ'
,p_attribute_04=>'COD_REQ'
,p_attribute_11=>'I'
,p_attribute_12=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
,p_process_success_message=>'Efetuado com sucesso!'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840908217868105148)
,p_process_sequence=>60
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
'           PERC_BENEFICIO_VARIAVEL = :P52_PERC_BENEFICIO,',
'           mat_subs                = nvl(mat_subs,nvl(:p52_mat_subs,nvl(:p52_mat_subs_x,:p52_mat_subs_deslig))) -- Chamado 35999',
'     where cod_req = :p52_cod_req;',
'     ',
'     commit;',
'',
'EXECUTE IMMEDIATE ''ALTER SESSION SET NLS_NUMERIC_CHARACTERS= ''''.,'''' '';',
'     ',
'end;'))
,p_process_error_message=>unistr('Erro ao Criar Requisi\00E7\00E3o.')
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(270825220168030054986)
,p_process_sequence=>70
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
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840910213111105149)
,p_process_sequence=>80
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
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840912239262105150)
,p_process_sequence=>90
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
' pkg_pessoal.post_insert(:p52_cod_req, v_flg_retorno, v_msg_retorno, :p_usuario, :p52_qtd_posicao);',
'',
'  if v_flg_retorno is not null and v_msg_retorno is not null then',
'     :p52_flag := v_flg_retorno;',
'     :p52_mensagem := v_msg_retorno;',
'  end if;',
'',
'end;'))
,p_process_error_message=>'Erro ao inserir aprovadores.'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744948867104950)
,p_process_when=>'P52_OK'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'S'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(108007237160979636279)
,p_process_sequence=>95
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post - Update'
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
 p_id=>wwv_flow_api.id(269954061273393661029)
,p_process_sequence=>100
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
'',
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
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(269954061667173661033)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Atualiza Req. Filhos'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'pkg_pessoal.prc_update_req (:p52_cod_req,',
'                            :p_usuario,',
'                            :p52_flag,',
'                            :p52_mensagem);',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(271840744539043104950)
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1',
'  from requisicao',
' where cod_sit_req = 1',
' and cod_req_pai = :p52_cod_req'))
,p_process_when_type=>'EXISTS'
,p_process_success_message=>'&P52_MENSAGEM.'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(268868624507229625541)
,p_process_sequence=>120
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
 p_id=>wwv_flow_api.id(271840907441608105148)
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
'       and display_as_code in (''NATIVE_POPUP_LOV''/*,''NATIVE_SELECT_LIST''*/,''PLUGIN_BE.CTB.SELECT2'')',
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
end;
/
begin
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(271840906220589105147)
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
null;
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
