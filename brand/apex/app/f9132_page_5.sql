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
,p_default_application_id=>9132
,p_default_id_offset=>697006730928911864
,p_default_owner=>'RHNATCORP'
);
end;
/
 
prompt APPLICATION 9132 - Movimentações Financeiro - Menu
--
-- Application Export:
--   Application:     9132
--   Name:            Movimentações Financeiro - Menu
--   Date and Time:   10:53 Friday October 9, 2026
--   Exported By:     IGOR
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 5
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     199087473346935
--

begin
null;
end;
/
prompt --application/pages/delete_00005
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_api.create_page(
 p_id=>5
,p_user_interface_id=>wwv_flow_api.id(34587025913134988484)
,p_name=>unistr('Lan\00E7amentos')
,p_step_title=>unistr('Lan\00E7amentos')
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#WORKSPACE_IMAGES#Natcorp_LancOcorr.js'
,p_css_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#WORKSPACE_IMAGES#Natcorp_HistFiltros.css',
'#WORKSPACE_IMAGES#Natcorp_LancOcorr.css'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_last_updated_by=>'MARCELO.SENA'
,p_last_upd_yyyymmddhh24miss=>'20260814151757'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12734198816071558755)
,p_plug_name=>'<i>&P5_PROC_TXT.</i>'
,p_region_name=>'BLOCO'
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--noBorder:t-Region--hiddenOverflow:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586999916296988390)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'PLSQL_EXPRESSION'
,p_plug_display_when_condition=>':P5_PROCESSO IS NOT NULL AND :P5_PESQUISA = ''S'''
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12734102757947320220)
,p_plug_name=>'Folha'
,p_region_name=>'REP1_1'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID, ',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL,',
'       o.DATA_RETENCAO,',
'       o.DT_INIC_EVENTO,',
'       o.DT_FIN_EVENTO,',
'       o.HORAS,',
'       o.MINUTOS,',
'       o.OBSERVACAO,',
'       o.FAM_BENEFICIO,',
'       o.OPCAO_CALCULO',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'      ,(SELECT DECODE(e.tipo_lancamento_manual, 1,o.unidade1, 2,o.horas) FROM empresas e WHERE e.cod = o.cod_empresa) HrsQtd',
'      ,(SELECT DECODE(e.tipo_lancamento_manual, 1,o.unidade2, 2,o.minutos) FROM empresas e WHERE e.cod = o.cod_empresa) MinDia      ',
'  from OCORRENCIA_CALCULO     o',
'      ,ocorr_pagto            p',
'      ,informacoes_funcionais f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(12734103206222320220)
,p_name=>'Report 1'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>6996092187409466
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734103298283320220)
,p_db_column_name=>'ROWID'
,p_display_order=>0
,p_column_identifier=>'A'
,p_column_label=>'ROWID'
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_rpt_show_filter_lov=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734103672664320221)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734104039075320221)
,p_db_column_name=>'MATRICULA'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734104445525320221)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734104891917320221)
,p_db_column_name=>'DATA_REF'
,p_display_order=>5
,p_column_identifier=>'E'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734105252149320221)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>6
,p_column_identifier=>'F'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734105625417320221)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>7
,p_column_identifier=>'G'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734106070363320221)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>8
,p_column_identifier=>'H'
,p_column_label=>'Unidade1'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734106469236320222)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>9
,p_column_identifier=>'I'
,p_column_label=>'Unidade2'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734106911223320222)
,p_db_column_name=>'VALOR'
,p_display_order=>10
,p_column_identifier=>'J'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734107313421320222)
,p_db_column_name=>'FAIXA'
,p_display_order=>11
,p_column_identifier=>'K'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734107663082320222)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>12
,p_column_identifier=>'L'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734108025385320222)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>13
,p_column_identifier=>'M'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734108500221320222)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>14
,p_column_identifier=>'N'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734108910484320222)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>15
,p_column_identifier=>'O'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734109287386320223)
,p_db_column_name=>'USUARIO'
,p_display_order=>16
,p_column_identifier=>'P'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734109644022320223)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>17
,p_column_identifier=>'Q'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734110031761320223)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>18
,p_column_identifier=>'R'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734110498394320223)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>19
,p_column_identifier=>'S'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734110866229320223)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>20
,p_column_identifier=>'T'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734111235421320223)
,p_db_column_name=>'DT_INIC_EVENTO'
,p_display_order=>21
,p_column_identifier=>'U'
,p_column_label=>unistr('Dt. In\00EDcio Evento')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734111619447320223)
,p_db_column_name=>'DT_FIN_EVENTO'
,p_display_order=>22
,p_column_identifier=>'V'
,p_column_label=>'Dt. Fim Evento'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734112073195320224)
,p_db_column_name=>'HORAS'
,p_display_order=>23
,p_column_identifier=>'W'
,p_column_label=>'Horas'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734112497382320224)
,p_db_column_name=>'MINUTOS'
,p_display_order=>24
,p_column_identifier=>'X'
,p_column_label=>'Minutos'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734112902968320224)
,p_db_column_name=>'OBSERVACAO'
,p_display_order=>25
,p_column_identifier=>'Y'
,p_column_label=>'Obs.'
,p_column_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_ROWID,P6_PROCESSO:#ROWID#,1'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-file-text"></span>'
,p_column_link_attr=>unistr('title="Visualizar Observa\00E7\00E3o"')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734113268594320224)
,p_db_column_name=>'FAM_BENEFICIO'
,p_display_order=>26
,p_column_identifier=>'Z'
,p_column_label=>unistr('Fam. Benef\00EDcio')
,p_column_html_expression=>'<nobr>#FAM_BENEFICIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12734113654453320224)
,p_db_column_name=>'OPCAO_CALCULO'
,p_display_order=>27
,p_column_identifier=>'AA'
,p_column_label=>unistr('Op\00E7\00E3o C\00E1lculo')
,p_column_html_expression=>'<nobr>#OPCAO_CALCULO#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862982800518658265)
,p_db_column_name=>'EMPRESA'
,p_display_order=>37
,p_column_identifier=>'AB'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862982851943658266)
,p_db_column_name=>'FILIAL'
,p_display_order=>47
,p_column_identifier=>'AC'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862982929419658267)
,p_db_column_name=>'CCUSTO'
,p_display_order=>57
,p_column_identifier=>'AD'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983021388658268)
,p_db_column_name=>'CARGO'
,p_display_order=>67
,p_column_identifier=>'AE'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983261799658270)
,p_db_column_name=>'SITUACAO'
,p_display_order=>87
,p_column_identifier=>'AG'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983409300658271)
,p_db_column_name=>'VINCULO'
,p_display_order=>97
,p_column_identifier=>'AH'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983461780658272)
,p_db_column_name=>'SINDICATO'
,p_display_order=>107
,p_column_identifier=>'AI'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983586806658273)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>117
,p_column_identifier=>'AJ'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983700568658274)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>127
,p_column_identifier=>'AK'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983759315658275)
,p_db_column_name=>'DATAREF'
,p_display_order=>137
,p_column_identifier=>'AL'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983846539658276)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>147
,p_column_identifier=>'AM'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862983962866658277)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>157
,p_column_identifier=>'AN'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862984110954658278)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>167
,p_column_identifier=>'AO'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862984194358658279)
,p_db_column_name=>'HRSQTD'
,p_display_order=>177
,p_column_identifier=>'AP'
,p_column_label=>'Hora Qtd.'
,p_column_html_expression=>'<nobr>#HRSQTD#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12862984307872658280)
,p_db_column_name=>'MINDIA'
,p_display_order=>187
,p_column_identifier=>'AQ'
,p_column_label=>'Minuto Dia'
,p_column_html_expression=>'<nobr>#MINDIA#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002343262183669)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>197
,p_column_identifier=>'AR'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12734163704241382890)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'70566'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:SITUACAO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:DATA_RETENCAO:TPEVENTO:OCORRENCIA:HRSQTD:MINDIA:VALOR:FAIXA:DT_INIC_VAL:DT_FIN_VAL:DT_INIC_EVENTO:DT_FIN_EVENTO:HORAS_FERIAS:OBSERVACAO:USUAR'
||'IO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12736630503308553755)
,p_plug_name=>'Adiantamento'
,p_region_name=>'REP1_2'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID,',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL,',
'       o.DATA_RETENCAO',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'  from OCORRENCIA_CALCULO_ADIANT o',
'      ,ocorr_pagto               p',
'      ,informacoes_funcionais    f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6 '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(12736630690314553757)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>9523576279643003
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736643246658580365)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'AH'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632496665553775)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632612952553776)
,p_db_column_name=>'MATRICULA'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632710850553777)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632756242553778)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632852329553779)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736632940517553780)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633097068553781)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Hora Qtd.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633162516553782)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Minuto Dia'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633240223553783)
,p_db_column_name=>'VALOR'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633410366553784)
,p_db_column_name=>'FAIXA'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633466662553785)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633541432553786)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633650583553787)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633771814553788)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633853083553789)
,p_db_column_name=>'USUARIO'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736633987068553790)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736634041860553791)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736634193988553792)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>190
,p_column_identifier=>'R'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736634234639553793)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>200
,p_column_identifier=>'S'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736635083864553801)
,p_db_column_name=>'EMPRESA'
,p_display_order=>210
,p_column_identifier=>'T'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736635175928553802)
,p_db_column_name=>'FILIAL'
,p_display_order=>220
,p_column_identifier=>'U'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736635295955553803)
,p_db_column_name=>'CCUSTO'
,p_display_order=>230
,p_column_identifier=>'V'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736635327525553804)
,p_db_column_name=>'CARGO'
,p_display_order=>240
,p_column_identifier=>'W'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642326095580356)
,p_db_column_name=>'SITUACAO'
,p_display_order=>260
,p_column_identifier=>'Y'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642499029580357)
,p_db_column_name=>'VINCULO'
,p_display_order=>270
,p_column_identifier=>'Z'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642561885580358)
,p_db_column_name=>'SINDICATO'
,p_display_order=>280
,p_column_identifier=>'AA'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642628095580359)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>290
,p_column_identifier=>'AB'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642763845580360)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>300
,p_column_identifier=>'AC'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642825529580361)
,p_db_column_name=>'DATAREF'
,p_display_order=>310
,p_column_identifier=>'AD'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736642994659580362)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>320
,p_column_identifier=>'AE'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736643077234580363)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>330
,p_column_identifier=>'AF'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736643196335580364)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>340
,p_column_identifier=>'AG'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002729968183673)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>350
,p_column_identifier=>'AI'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12736651995629582047)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'95449'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:FILIAL:SITUACAO:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:DATA_RETENCAO:TPEVENTO:OCORRENCIA:UNIDADE1:UNIDADE2:VALOR:FAIXA:DT_INIC_VAL:DT_FIN_VAL:HORAS_FERIAS:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12736644211817580374)
,p_plug_name=>unistr('F\00E9rias')
,p_region_name=>'REP1_3'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>40
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID,',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'  from OCORRENCIA_CALCULO_FERIAS o',
'      ,ocorr_pagto               p',
'      ,informacoes_funcionais    f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6   '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(12736644230835580375)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>9537116800669621
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485154142938960)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'S'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736645910476580391)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736645937440580392)
,p_db_column_name=>'MATRICULA'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646058027580393)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646190750580394)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646217395580395)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'E'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646327094580396)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646468620580397)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>'Hora Qtd.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646578268580398)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Minuto Dia'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646688996580399)
,p_db_column_name=>'VALOR'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646810582580400)
,p_db_column_name=>'FAIXA'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646866235580401)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736646976839580402)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736647070122580403)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12736647145732580404)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737484643012938955)
,p_db_column_name=>'USUARIO'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737484715261938956)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737484846170938957)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>180
,p_column_identifier=>'Q'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737484970657938958)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>190
,p_column_identifier=>'R'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485281441938961)
,p_db_column_name=>'EMPRESA'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485413833938962)
,p_db_column_name=>'FILIAL'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485431789938963)
,p_db_column_name=>'CCUSTO'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485609933938964)
,p_db_column_name=>'CARGO'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485730884938966)
,p_db_column_name=>'SITUACAO'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485870498938967)
,p_db_column_name=>'VINCULO'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737485952685938968)
,p_db_column_name=>'SINDICATO'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486079328938969)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486161763938970)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486240474938971)
,p_db_column_name=>'DATAREF'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486316578938972)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486419659938973)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486594837938974)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002619383183672)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12737502885600990486)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'103958'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:SITUACAO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:TPEVENTO:OCORRENCIA:UNIDADE1:UNIDADE2:VALOR:FAIXA:DT_INIC_VAL:DT_FIN_VAL:HORAS_FERIAS:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12737486648546938975)
,p_plug_name=>unistr('13\00BA Sal\00E1rio')
,p_region_name=>'REP1_5'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID,',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'  from OCORRENCIA_CALCULO_13     o',
'      ,ocorr_pagto               p',
'      ,informacoes_funcionais    f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6   '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(12737486807661938976)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>10379693627028222
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487972647938988)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'L'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737525789929140759)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>20
,p_column_identifier=>'AG'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489471836939003)
,p_db_column_name=>'MATRICULA'
,p_display_order=>30
,p_column_identifier=>'AA'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489530817939004)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>40
,p_column_identifier=>'AB'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737525327332140755)
,p_db_column_name=>'DATA_REF'
,p_display_order=>50
,p_column_identifier=>'AC'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737525481581140756)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>60
,p_column_identifier=>'AD'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737525523583140757)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>70
,p_column_identifier=>'AE'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737525667182140758)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>80
,p_column_identifier=>'AF'
,p_column_label=>'Hora Qtd.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486899955938977)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>90
,p_column_identifier=>'A'
,p_column_label=>'Minuto Dia'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737486937091938978)
,p_db_column_name=>'VALOR'
,p_display_order=>100
,p_column_identifier=>'B'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487094167938979)
,p_db_column_name=>'FAIXA'
,p_display_order=>110
,p_column_identifier=>'C'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487125218938980)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>120
,p_column_identifier=>'D'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487242709938981)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>130
,p_column_identifier=>'E'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487401470938982)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>140
,p_column_identifier=>'F'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487482990938983)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>150
,p_column_identifier=>'G'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487541829938984)
,p_db_column_name=>'USUARIO'
,p_display_order=>160
,p_column_identifier=>'H'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487615764938985)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>170
,p_column_identifier=>'I'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487738658938986)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>180
,p_column_identifier=>'J'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737487876751938987)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>190
,p_column_identifier=>'K'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488059333938989)
,p_db_column_name=>'EMPRESA'
,p_display_order=>200
,p_column_identifier=>'M'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488139368938990)
,p_db_column_name=>'FILIAL'
,p_display_order=>210
,p_column_identifier=>'N'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488280837938991)
,p_db_column_name=>'CCUSTO'
,p_display_order=>220
,p_column_identifier=>'O'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488334037938992)
,p_db_column_name=>'CARGO'
,p_display_order=>230
,p_column_identifier=>'P'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488565454938994)
,p_db_column_name=>'SITUACAO'
,p_display_order=>250
,p_column_identifier=>'R'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488659618938995)
,p_db_column_name=>'VINCULO'
,p_display_order=>260
,p_column_identifier=>'S'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488757932938996)
,p_db_column_name=>'SINDICATO'
,p_display_order=>270
,p_column_identifier=>'T'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488830361938997)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>280
,p_column_identifier=>'U'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737488955380938998)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>290
,p_column_identifier=>'V'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489018831938999)
,p_db_column_name=>'DATAREF'
,p_display_order=>300
,p_column_identifier=>'W'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489193660939000)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>310
,p_column_identifier=>'X'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489268271939001)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>320
,p_column_identifier=>'Y'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737489384291939002)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>330
,p_column_identifier=>'Z'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002461598183671)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12737544321428185632)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'104373'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:SITUACAO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:TPEVENTO:OCORRENCIA:UNIDADE1:UNIDADE2:VALOR:FAIXA:DT_INIC_VAL:DT_FIN_VAL:HORAS_FERIAS:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12737525906193140760)
,p_plug_name=>'PLR'
,p_region_name=>'REP1_6'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>60
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID,',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL,',
'       o.DATA_RETENCAO',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'  from OCORRENCIA_CALCULO_PART   o',
'      ,ocorr_pagto               p',
'      ,informacoes_funcionais    f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)   ',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6 '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
end;
/
begin
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(12737525937292140761)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>10418823257230007
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526086272140762)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526192719140763)
,p_db_column_name=>'EMPRESA'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526312680140764)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526364075140765)
,p_db_column_name=>'CCUSTO'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526430010140766)
,p_db_column_name=>'CARGO'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526640786140768)
,p_db_column_name=>'SITUACAO'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526729716140769)
,p_db_column_name=>'VINCULO'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526898738140770)
,p_db_column_name=>'SINDICATO'
,p_display_order=>90
,p_column_identifier=>'I'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737526967614140771)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>100
,p_column_identifier=>'J'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527045967140772)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>110
,p_column_identifier=>'K'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527143074140773)
,p_db_column_name=>'DATAREF'
,p_display_order=>120
,p_column_identifier=>'L'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527232179140774)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>130
,p_column_identifier=>'M'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527346528140775)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>140
,p_column_identifier=>'N'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527455296140776)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>150
,p_column_identifier=>'O'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527603663140777)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>160
,p_column_identifier=>'P'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527621991140778)
,p_db_column_name=>'MATRICULA'
,p_display_order=>170
,p_column_identifier=>'Q'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527749905140779)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737527866984140780)
,p_db_column_name=>'DATA_REF'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528006535140781)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528104143140782)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528188431140783)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Hora Qtd.'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528243892140784)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Minuto Dia'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528400023140785)
,p_db_column_name=>'VALOR'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528419921140786)
,p_db_column_name=>'FAIXA'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528547298140787)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528651082140788)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528755586140789)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528901152140790)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737528988197140791)
,p_db_column_name=>'USUARIO'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529018463140792)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529208609140793)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529285520140794)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529392458140795)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002119239183667)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>350
,p_column_identifier=>'AI'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12737568601614254560)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'104615'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:SITUACAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:DATA_RETENCAO:TPEVENTO:OCORRENCIA:UNIDADE1:UNIDADE2:VALOR:FAIXA:DT_INIC_VAL:DT_FIN_VAL:HORAS_FERIAS:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12737529488280140796)
,p_plug_name=>'Pgto Diversos'
,p_region_name=>'REP1_7'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>70
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select o.ROWID, ',
'       o.COD_EMPRESA,',
'       o.MATRICULA,',
'       o.DC_MATRICULA,',
'       o.DATA_REF,',
'       o.COD_OCORR,',
'       o.DC_OCORR,',
'       o.UNIDADE1,',
'       o.UNIDADE2,',
'       o.VALOR,',
'       o.FAIXA,',
'       o.HORAS_FERIAS,',
'       o.MIN_FERIAS,',
'       o.DT_INIC_VAL,',
'       o.DT_FIN_VAL,',
'       o.USUARIO,',
'       o.DT_ULT_ATLZ,',
'       o.VALOR_CRUZEIRO,',
'       o.CD_NIVEL,',
'       o.DATA_RETENCAO,',
'       o.DT_INIC_EVENTO,',
'       o.DT_FIN_EVENTO,',
'       o.HORAS,',
'       o.MINUTOS,',
'       o.OBSERVACAO,',
'       o.SIT_FECHAMENTO,',
'       o.COD_FAMILIA',
'      ,(SELECT x1.cod||''-''||x1.nome FROM empresas x1 WHERE x1.cod = o.cod_empresa) Empresa ',
'      ,(SELECT x2.cod_filial||''-''||x2.nome_filial FROM filiais x2 WHERE x2.cod_empresa = f.cod_empresa AND x2.cod_filial = f.filial) filial',
'      ,(SELECT x3.cod||''-''||x3.nome FROM centro_de_custo x3 WHERE x3.cod_empresa = f.cod_empresa AND x3.cod = f.cod_ccusto) ccusto',
'      ,(SELECT x4.cod||''-''||x4.nome FROM cargos x4 WHERE x4.cod = f.cargo) cargo',
'      ,f.dt_admissao',
'      ,(SELECT x5.cod||''-''||x5.nome FROM sit_func x5 WHERE x5.cod = f.situacao) situacao',
'      ,(SELECT x6.cod||''-''||x6.nome FROM vinculo_empreg x6 WHERE x6.cod = f.vinculo) vinculo',
'      ,(SELECT x7.cod||''-''||x7.nome FROM sindicatos x7 WHERE x7.cod_empresa = f.cod_empresa AND x7.cod = f.num_sind_diss) sindicato',
'      ,(SELECT x8.cod||''-''||x8.descricao FROM tipo_salario x8 WHERE x8.cod = f.tipo_salario) tpSalario',
'      ,(SELECT x9.cod_tipo_pagto||''-''||x9.descricao FROM tipo_pagamento x9 WHERE x9.cod_tipo_pagto = f.cod_tipo_pagto) tpPagamento',
'      ,(SELECT x10.display FROM list_hist_finan_datas x10 WHERE x10.data_ref = o.data_ref) DataRef',
'      ,(SELECT x11.matricula||''-''||x11.nome FROM inf_pessoais x11 WHERE x11.cod_empresa = f.cod_empresa AND x11.matricula = f.matricula) funcionario',
'      ,(NVL((SELECT b.cod_familia||''-''||b.descricao_familia FROM beneficios_familia b WHERE b.cod_empresa = o.COD_EMPRESA AND b.cod_familia = o.COD_FAMILIA), o.COD_FAMILIA)) familia',
'      ,(DECODE(o.SIT_FECHAMENTO, ''S'',''S-Efetuado'', ''N'',''N-Pendente'', ''-'')) sitFechamto',
'      --',
unistr('      ,(DECODE(p.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')) tpEvento'),
'      ,(p.cod||''-''||p.nome) ocorrencia',
'      ,(SELECT DECODE(e.tipo_lancamento_manual, 1,o.unidade1, 2,o.horas) FROM empresas e WHERE e.cod = o.cod_empresa) HrsQtd',
'      ,(SELECT DECODE(e.tipo_lancamento_manual, 1,o.unidade2, 2,o.minutos) FROM empresas e WHERE e.cod = o.cod_empresa) MinDia      ',
'  from OCORRENCIA_CALCULO_DIVERSOS o',
'      ,ocorr_pagto                 p',
'      ,informacoes_funcionais_CAD  f',
' WHERE f.cod_empresa  = o.cod_empresa',
'   AND f.matricula    = o.matricula',
'   --AND f.dc_matricula = o.dc_matricula',
'   AND o.cod_empresa  = p.cod_empresa',
'   AND o.cod_ocorr    = p.cod',
'   AND (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.data_ref    = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_ocorr   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS    IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'   AND (:P5_CCUSTOS    IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'   AND (:P5_CARGOS     IS NULL OR f.cargo          IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'   AND ((:P5_DTADMINI  IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'   AND (:P5_SITUACOES  IS NULL OR f.situacao       IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'   AND (:P5_VINCULOS   IS NULL OR f.vinculo        IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'   AND (:P5_SINDICATOS IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'   AND (:P5_TIPOSAL    IS NULL OR f.tipo_salario   IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'   AND (:P5_TIPOPAG    IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'   AND (:P5_MATRICULAS IS NULL OR f.matricula||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_MATRICULAS, '':'')) t))   ',
'   --',
'   AND (:P5_DATAREF    IS NULL OR o.data_ref IN(SELECT /*+ cardinality (t 1)*/ TO_DATE(COLUMN_VALUE,''DD/MM/RRRR'') FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t))          ',
'   AND (:P5_TIPOEVENT  IS NULL OR p.tipo_rubrica||''#''||p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))             ',
'   AND (:P5_OCORRPAGTO IS NULL OR o.cod_ocorr||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_OCORRPAGTO, '':'')) t))                ',
'ORDER BY 2,3,5 DESC,6'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'NEVER'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(12737529669947140798)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>10422555912230044
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12846464795954144472)
,p_db_column_name=>'ROWID'
,p_display_order=>10
,p_column_identifier=>'AT'
,p_column_label=>'Rowid'
,p_column_type=>'OTHER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529782502140799)
,p_db_column_name=>'EMPRESA'
,p_display_order=>20
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529890015140800)
,p_db_column_name=>'FILIAL'
,p_display_order=>30
,p_column_identifier=>'B'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737529981920140801)
,p_db_column_name=>'CCUSTO'
,p_display_order=>40
,p_column_identifier=>'C'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737530053359140802)
,p_db_column_name=>'CARGO'
,p_display_order=>50
,p_column_identifier=>'D'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737530266381140804)
,p_db_column_name=>'SITUACAO'
,p_display_order=>70
,p_column_identifier=>'F'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737569654066273655)
,p_db_column_name=>'VINCULO'
,p_display_order=>80
,p_column_identifier=>'G'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737569720598273656)
,p_db_column_name=>'SINDICATO'
,p_display_order=>90
,p_column_identifier=>'H'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737569906497273657)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>100
,p_column_identifier=>'I'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737569981973273658)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>110
,p_column_identifier=>'J'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570089777273659)
,p_db_column_name=>'DATAREF'
,p_display_order=>120
,p_column_identifier=>'K'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570183776273660)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>130
,p_column_identifier=>'L'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_MATRICULAS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570277403273661)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>140
,p_column_identifier=>'M'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570357770273662)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>150
,p_column_identifier=>'N'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570483529273663)
,p_db_column_name=>'HRSQTD'
,p_display_order=>160
,p_column_identifier=>'O'
,p_column_label=>'Hora Qtd.'
,p_column_html_expression=>'<nobr>#HRSQTD#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570555794273664)
,p_db_column_name=>'MINDIA'
,p_display_order=>170
,p_column_identifier=>'P'
,p_column_label=>'Minuto Dia'
,p_column_html_expression=>'<nobr>#MINDIA#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570747541273666)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>180
,p_column_identifier=>'R'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570894983273667)
,p_db_column_name=>'MATRICULA'
,p_display_order=>190
,p_column_identifier=>'S'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737570931266273668)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>200
,p_column_identifier=>'T'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571108339273669)
,p_db_column_name=>'DATA_REF'
,p_display_order=>210
,p_column_identifier=>'U'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571143453273670)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>220
,p_column_identifier=>'V'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571249804273671)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>230
,p_column_identifier=>'W'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571398575273672)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>240
,p_column_identifier=>'X'
,p_column_label=>'Unidade1'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571435112273673)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>250
,p_column_identifier=>'Y'
,p_column_label=>'Unidade2'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571603546273674)
,p_db_column_name=>'VALOR'
,p_display_order=>260
,p_column_identifier=>'Z'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571664583273675)
,p_db_column_name=>'FAIXA'
,p_display_order=>270
,p_column_identifier=>'AA'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571742760273676)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>280
,p_column_identifier=>'AB'
,p_column_label=>unistr('Horas F\00E9rias')
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571841874273677)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>290
,p_column_identifier=>'AC'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737571924980273678)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>300
,p_column_identifier=>'AD'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572094052273679)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>310
,p_column_identifier=>'AE'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572200541273680)
,p_db_column_name=>'USUARIO'
,p_display_order=>320
,p_column_identifier=>'AF'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572222324273681)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>330
,p_column_identifier=>'AG'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572352662273682)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>340
,p_column_identifier=>'AH'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572489188273683)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>350
,p_column_identifier=>'AI'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572594306273684)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>360
,p_column_identifier=>'AJ'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572683248273685)
,p_db_column_name=>'DT_INIC_EVENTO'
,p_display_order=>370
,p_column_identifier=>'AK'
,p_column_label=>unistr('Dt. In\00EDcio Evento')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572768644273686)
,p_db_column_name=>'DT_FIN_EVENTO'
,p_display_order=>380
,p_column_identifier=>'AL'
,p_column_label=>'Dt. Fim Evento'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572835761273687)
,p_db_column_name=>'HORAS'
,p_display_order=>390
,p_column_identifier=>'AM'
,p_column_label=>'Horas'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737572955417273688)
,p_db_column_name=>'MINUTOS'
,p_display_order=>400
,p_column_identifier=>'AN'
,p_column_label=>'Minutos'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737573112288273689)
,p_db_column_name=>'OBSERVACAO'
,p_display_order=>410
,p_column_identifier=>'AO'
,p_column_label=>'Obs.'
,p_column_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_ROWID,P6_PROCESSO:#ROWID#,6'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-file-text"></span>'
,p_column_link_attr=>unistr('title="Visualizar Observa\00E7\00E3o"')
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737573411744273692)
,p_db_column_name=>'SIT_FECHAMENTO'
,p_display_order=>420
,p_column_identifier=>'AR'
,p_column_label=>'Sit Fechamento'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12737573487972273693)
,p_db_column_name=>'COD_FAMILIA'
,p_display_order=>430
,p_column_identifier=>'AS'
,p_column_label=>'Cod Familia'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918854488232723181)
,p_db_column_name=>'SITFECHAMTO'
,p_display_order=>450
,p_column_identifier=>'AV'
,p_column_label=>'Fechamento'
,p_column_html_expression=>'<nobr>#SITFECHAMTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918854566955723182)
,p_db_column_name=>'FAMILIA'
,p_display_order=>460
,p_column_identifier=>'AW'
,p_column_label=>'Familia'
,p_column_html_expression=>'<nobr>#FAMILIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943002358058183670)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>470
,p_column_identifier=>'AX'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12737592926835330899)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'104859'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'EMPRESA:FUNCIONARIO:SITUACAO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:TPEVENTO:OCORRENCIA:FAMILIA:SITFECHAMTO:HRSQTD:MINDIA:VALOR:FAIXA:DATA_RETENCAO:DT_INIC_VAL:DT_FIN_VAL:DT_INIC_EVENTO:DT_FIN_EVENTO:HORAS_FER'
||'IAS:OBSERVACAO:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12918653450659140181)
,p_plug_name=>'Todos os Processos'
,p_region_name=>'REP1'
,p_parent_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(34586999396255988388)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.*, x.numproc||''.''||SUBSTR(x.processo,3) PROC_DSP',
'      ,(SELECT b.cod_familia||''-''||b.descricao_familia FROM beneficios_familia b WHERE b.cod_empresa = x.COD_EMPRESA AND b.cod_familia = x.COD_FAMILIA) familia',
'      ,(DECODE(x.SIT_FECHAMENTO, ''S'',''S-Efetuado'', ''N'',''N-Pendente'', ''-'')) sitFechamto',
'  FROM TABLE(pkg_MovtFinanceiro.fnc_TabAllProcessosPipe(pProcesso   => :P5_PROCESSO',
'                                                       ,pEmpresas   => :P5_EMPRESAS',
'                                                       ,pFiliais    => :P5_FILIAIS',
'                                                       ,pCCustos    => :P5_CCUSTOS',
'                                                       ,pCargos     => :P5_CARGOS',
'                                                       ,pSituacoes  => :P5_SITUACOES',
'                                                       ,pVinculos   => :P5_VINCULOS',
'                                                       ,pSindicatos => :P5_SINDICATOS',
'                                                       ,pTiposSal   => :P5_TIPOSAL',
'                                                       ,pTiposPagto => :P5_TIPOPAG',
'                                                       ,pMatriculas => :P5_MATRICULAS  --REPLACE(REPLACE(:P5_MATRICULAS,''_'',''#''),''-'','':'')',
'                                                       ,pDtRef      => :P5_DATAREF',
'                                                       ,pTipoEvento => :P5_TIPOEVENT',
'                                                       ,pOcorrencia => :P5_OCORRPAGTO',
'                                                       ,pDtIniAdm   => :P5_DTADMINI',
'                                                       ,pDtFimAdm   => :P5_DTADMFIM',
'                                                       ,pUsuarios   => :P5_USUARIO',
'                                                       ,pDtsAltz    => :P5_DTATLZ',
'                                                       ,pMesAnoSit  => :P5_MESANOSIT',
'                                                       ,pDataSit    => :P5_DATASIT',
'                                                       ,pDtValIni   => :P5_DTVALINI',
'                                                       ,pDtValFim   => :P5_DTVALFIM)) x ',
'ORDER BY x.MATRICULA, TO_CHAR(x.DATA_REF,''MON/RRRR''), x.COD_OCORR --x.funcionario,x.DataRef,x.ocorrencia '))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO,P5_DATASIT,P5_MESANOSIT,P5_USUARIO,P5_DTATLZ,P5_DTVALINI,P5_DTVALFIM'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_plug_display_when_condition=>'P5_PROCESSO'
,p_plug_display_when_cond2=>'1:2:3:4:5:6:7'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
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
 p_id=>wwv_flow_api.id(12918653555246140182)
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'Nenhum Dado Encontrado!'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y_OF_Z'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_owner=>'MARCELO.SENA'
,p_internal_uid=>207476010512655143
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918854149237723178)
,p_db_column_name=>'IDROW'
,p_display_order=>10
,p_column_identifier=>'AR'
,p_column_label=>'Idrow'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853962445723176)
,p_db_column_name=>'PROCESSO'
,p_display_order=>20
,p_column_identifier=>'AP'
,p_column_label=>'Processo'
,p_column_html_expression=>'<nobr>#PROCESSO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918653813268140184)
,p_db_column_name=>'EMPRESA'
,p_display_order=>30
,p_column_identifier=>'A'
,p_column_label=>'Empresa'
,p_column_html_expression=>'<nobr>#EMPRESA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_EMPRESAS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_EMPRESAS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918653905808140185)
,p_db_column_name=>'FILIAL'
,p_display_order=>40
,p_column_identifier=>'B'
,p_column_label=>'Filial'
,p_column_html_expression=>'<nobr>#FILIAL#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_FILIAIS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_FILIAIS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918654022049140186)
,p_db_column_name=>'CCUSTO'
,p_display_order=>50
,p_column_identifier=>'C'
,p_column_label=>'Centro de Custo'
,p_column_html_expression=>'<nobr>#CCUSTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CCUSTOS IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CCUSTOS, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918654056789140187)
,p_db_column_name=>'CARGO'
,p_display_order=>60
,p_column_identifier=>'D'
,p_column_label=>'Cargo'
,p_column_html_expression=>'<nobr>#CARGO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_CARGOS IS NULL OR EXISTS(SELECT 1',
'                               FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_CARGOS, '':''))) t',
'                             HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918654279200140189)
,p_db_column_name=>'SITUACAO'
,p_display_order=>70
,p_column_identifier=>'E'
,p_column_label=>unistr('Situa\00E7\00E3o')
,p_column_html_expression=>'<nobr>#SITUACAO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SITUACOES IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850433679723140)
,p_db_column_name=>'VINCULO'
,p_display_order=>80
,p_column_identifier=>'F'
,p_column_label=>unistr('V\00EDnculo')
,p_column_html_expression=>'<nobr>#VINCULO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_VINCULOS IS NULL OR EXISTS(SELECT 1',
'                                 FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_VINCULOS, '':''))) t',
'                               HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850495805723141)
,p_db_column_name=>'SINDICATO'
,p_display_order=>90
,p_column_identifier=>'G'
,p_column_label=>'Sindicato'
,p_column_html_expression=>'<nobr>#SINDICATO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_SINDICATOS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SINDICATOS, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850601047723142)
,p_db_column_name=>'TPSALARIO'
,p_display_order=>100
,p_column_identifier=>'H'
,p_column_label=>unistr('Tipo Sal\00E1rio')
,p_column_html_expression=>'<nobr>#TPSALARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOSAL IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOSAL, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850736636723143)
,p_db_column_name=>'TPPAGAMENTO'
,p_display_order=>110
,p_column_identifier=>'I'
,p_column_label=>'Tipo Pagamento'
,p_column_html_expression=>'<nobr>#TPPAGAMENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOPAG IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOPAG, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850793794723144)
,p_db_column_name=>'DATAREF'
,p_display_order=>120
,p_column_identifier=>'J'
,p_column_label=>unistr('Per\00EDodo')
,p_column_html_expression=>'<nobr>#DATAREF#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_DATAREF IS NULL OR EXISTS(SELECT 1',
'                                FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_DATAREF, '':''))) t',
'                              HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850853588723145)
,p_db_column_name=>'FUNCIONARIO'
,p_display_order=>130
,p_column_identifier=>'K'
,p_column_label=>unistr('Funcion\00E1rio')
,p_column_html_expression=>'<nobr>#FUNCIONARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_MATRICULAS IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(REPLACE(:P5_MATRICULAS,''-'','':''), '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918850995953723146)
,p_db_column_name=>'TPEVENTO'
,p_display_order=>140
,p_column_identifier=>'L'
,p_column_label=>'Tipo Evento'
,p_column_html_expression=>'<nobr>#TPEVENTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_TIPOEVENT IS NULL OR EXISTS(SELECT 1',
'                                  FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_TIPOEVENT, '':''))) t',
'                                HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851062568723147)
,p_db_column_name=>'OCORRENCIA'
,p_display_order=>150
,p_column_identifier=>'M'
,p_column_label=>unistr('Ocorr\00EAncia')
,p_column_html_expression=>'<nobr>#OCORRENCIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'SQL_EXPRESSION'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P5_OCORRPAGTO IS NULL OR EXISTS(SELECT 1',
'                                   FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_OCORRPAGTO, '':''))) t',
'                                 HAVING COUNT(1) > 1 )'))
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851208398723148)
,p_db_column_name=>'HRSQTD'
,p_display_order=>160
,p_column_identifier=>'N'
,p_column_label=>'Hora Qtd.'
,p_column_html_expression=>'<nobr>#HRSQTD#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851320196723149)
,p_db_column_name=>'MINDIA'
,p_display_order=>170
,p_column_identifier=>'O'
,p_column_label=>'Minuto Dia'
,p_column_html_expression=>'<nobr>#MINDIA#</nobr>'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851410906723150)
,p_db_column_name=>'COD_EMPRESA'
,p_display_order=>180
,p_column_identifier=>'P'
,p_column_label=>'Cod Empresa'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851493162723151)
,p_db_column_name=>'MATRICULA'
,p_display_order=>190
,p_column_identifier=>'Q'
,p_column_label=>'Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851584787723152)
,p_db_column_name=>'DC_MATRICULA'
,p_display_order=>200
,p_column_identifier=>'R'
,p_column_label=>'Dc Matricula'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851661272723153)
,p_db_column_name=>'DATA_REF'
,p_display_order=>210
,p_column_identifier=>'S'
,p_column_label=>'Data Ref'
,p_column_type=>'DATE'
,p_display_text_as=>'HIDDEN'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851802166723154)
,p_db_column_name=>'COD_OCORR'
,p_display_order=>220
,p_column_identifier=>'T'
,p_column_label=>'Cod Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851912527723155)
,p_db_column_name=>'DC_OCORR'
,p_display_order=>230
,p_column_identifier=>'U'
,p_column_label=>'Dc Ocorr'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918851968452723156)
,p_db_column_name=>'UNIDADE1'
,p_display_order=>240
,p_column_identifier=>'V'
,p_column_label=>'Unidade1'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852144089723157)
,p_db_column_name=>'UNIDADE2'
,p_display_order=>250
,p_column_identifier=>'W'
,p_column_label=>'Unidade2'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852203637723158)
,p_db_column_name=>'VALOR'
,p_display_order=>260
,p_column_identifier=>'X'
,p_column_label=>'Valor'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852299157723159)
,p_db_column_name=>'FAIXA'
,p_display_order=>270
,p_column_identifier=>'Y'
,p_column_label=>'Faixa'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852438866723160)
,p_db_column_name=>'HORAS_FERIAS'
,p_display_order=>280
,p_column_identifier=>'Z'
,p_column_label=>'Origem'
,p_column_html_expression=>'<nobr>#HORAS_FERIAS#</nobr>'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_heading_alignment=>'LEFT'
,p_rpt_named_lov=>wwv_flow_api.id(12942318194998400185)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852457256723161)
,p_db_column_name=>'MIN_FERIAS'
,p_display_order=>290
,p_column_identifier=>'AA'
,p_column_label=>unistr('Minuto F\00E9rias')
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852553900723162)
,p_db_column_name=>'DT_INIC_VAL'
,p_display_order=>300
,p_column_identifier=>'AB'
,p_column_label=>'Validade Inicial'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852661170723163)
,p_db_column_name=>'DT_FIN_VAL'
,p_display_order=>310
,p_column_identifier=>'AC'
,p_column_label=>'Validade Final'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852798125723164)
,p_db_column_name=>'USUARIO'
,p_display_order=>320
,p_column_identifier=>'AD'
,p_column_label=>unistr('Usu\00E1rio')
,p_column_html_expression=>'<nobr>#USUARIO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852920151723165)
,p_db_column_name=>'DT_ULT_ATLZ'
,p_display_order=>330
,p_column_identifier=>'AE'
,p_column_label=>unistr('Atualiza\00E7\00E3o')
,p_column_html_expression=>'<nobr>#DT_ULT_ATLZ#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918852967468723166)
,p_db_column_name=>'VALOR_CRUZEIRO'
,p_display_order=>340
,p_column_identifier=>'AF'
,p_column_label=>'Valor Cruzeiro'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853100466723167)
,p_db_column_name=>'CD_NIVEL'
,p_display_order=>350
,p_column_identifier=>'AG'
,p_column_label=>'Cd Nivel'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853233023723168)
,p_db_column_name=>'DATA_RETENCAO'
,p_display_order=>360
,p_column_identifier=>'AH'
,p_column_label=>unistr('Data Reten\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'1:2:5:6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853266108723169)
,p_db_column_name=>'DT_INIC_EVENTO'
,p_display_order=>370
,p_column_identifier=>'AI'
,p_column_label=>unistr('Dt. In\00EDcio Evento')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'1:6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853399339723170)
,p_db_column_name=>'DT_FIN_EVENTO'
,p_display_order=>380
,p_column_identifier=>'AJ'
,p_column_label=>'Dt. Fim Evento'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'1:6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853508585723171)
,p_db_column_name=>'HORAS'
,p_display_order=>390
,p_column_identifier=>'AK'
,p_column_label=>'Horas'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853613316723172)
,p_db_column_name=>'MINUTOS'
,p_display_order=>400
,p_column_identifier=>'AL'
,p_column_label=>'Minutos'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853700757723173)
,p_db_column_name=>'OBSERVACAO'
,p_display_order=>410
,p_column_identifier=>'AM'
,p_column_label=>'Obs.'
,p_column_link=>'f?p=&APP_ID.:6:&SESSION.::&DEBUG.:RP,6:P6_PROCESSO,P6_ROWID,P6_PROC_TXT:#NUMPROC#,#IDROW#,#PROC_DSP#'
,p_column_linktext=>'<span aria-hidden="true" class="fa fa-file-text"></span>'
,p_column_link_attr=>unistr('title="Visualizar Observa\00E7\00E3o"')
,p_allow_sorting=>'N'
,p_allow_filtering=>'N'
,p_allow_highlighting=>'N'
,p_allow_ctrl_breaks=>'N'
,p_allow_aggregations=>'N'
,p_allow_computations=>'N'
,p_allow_charting=>'N'
,p_allow_group_by=>'N'
,p_allow_pivot=>'N'
,p_column_type=>'STRING'
,p_column_alignment=>'CENTER'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'1:6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853833183723174)
,p_db_column_name=>'SIT_FECHAMENTO'
,p_display_order=>420
,p_column_identifier=>'AN'
,p_column_label=>'Sit Fechamento'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918853904436723175)
,p_db_column_name=>'COD_FAMILIA'
,p_display_order=>430
,p_column_identifier=>'AO'
,p_column_label=>'Cod Familia'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
end;
/
begin
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918854732121723183)
,p_db_column_name=>'FAMILIA'
,p_display_order=>460
,p_column_identifier=>'AT'
,p_column_label=>unistr('Fam\00EDlia')
,p_column_html_expression=>'<nobr>#FAMILIA#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12918854771574723184)
,p_db_column_name=>'SITFECHAMTO'
,p_display_order=>470
,p_column_identifier=>'AU'
,p_column_label=>'Fechamento'
,p_column_html_expression=>'<nobr>#SITFECHAMTO#</nobr>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_condition=>'P5_PROCESSO'
,p_display_condition2=>'6:7'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12943003588543183682)
,p_db_column_name=>'DT_ADMISSAO'
,p_display_order=>480
,p_column_identifier=>'AV'
,p_column_label=>unistr('Data Admiss\00E3o')
,p_column_html_expression=>'<nobr>#DT_ADMISSAO#</nobr>'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_format_mask=>'DD/MM/RRRR'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12974008609523435062)
,p_db_column_name=>'NUMPROC'
,p_display_order=>500
,p_column_identifier=>'AX'
,p_column_label=>'Numproc'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(12974011117662435087)
,p_db_column_name=>'PROC_DSP'
,p_display_order=>510
,p_column_identifier=>'AY'
,p_column_label=>'Proc Dsp'
,p_column_type=>'STRING'
,p_display_text_as=>'HIDDEN'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(13015222410092361471)
,p_db_column_name=>'DT_SITUACAO'
,p_display_order=>520
,p_column_identifier=>'AZ'
,p_column_label=>unistr('Data Situa\00E7\00E3o')
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(12918869617644751207)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'2076921'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'PROCESSO:EMPRESA:FUNCIONARIO:SITUACAO:DT_SITUACAO:FILIAL:CCUSTO:CARGO:DT_ADMISSAO:VINCULO:SINDICATO:TPSALARIO:TPPAGAMENTO:DATAREF:TPEVENTO:OCORRENCIA:FAMILIA:SITFECHAMTO:HRSQTD:MINDIA:VALOR:FAIXA:DATA_RETENCAO:DT_INIC_VAL:DT_FIN_VAL:DT_INIC_EVENTO:DT'
||'_FIN_EVENTO:HORAS_FERIAS:OBSERVACAO:USUARIO:DT_ULT_ATLZ:'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(58549278215787579232)
,p_plug_name=>'Filtros'
,p_region_name=>'PSQ1'
,p_region_template_options=>'#DEFAULT#:t-Form--slimPadding:t-Form--stretchInputs:t-Form--labelsAbove:margin-top-none'
,p_plug_template=>wwv_flow_api.id(34586999916296988390)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(53527829940150309345)
,p_plug_name=>'Parametros'
,p_parent_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586991838802988376)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12734199073572558757)
,p_plug_name=>'Filtros'
,p_parent_plug_id=>wwv_flow_api.id(53527829940150309345)
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586991838802988376)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12862984385413658281)
,p_plug_name=>'Processo'
,p_parent_plug_id=>wwv_flow_api.id(53527829940150309345)
,p_region_template_options=>'#DEFAULT#:t-Form--noPadding:margin-top-none:margin-bottom-none'
,p_plug_template=>wwv_flow_api.id(34586991838802988376)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(68372581060257326221)
,p_plug_name=>unistr('Lan\00E7amentos')
,p_icon_css_classes=>'fa-tasks'
,p_region_template_options=>'#DEFAULT#:t-HeroRegion--noPadding:t-Form--slimPadding:margin-top-sm:margin-bottom-sm:margin-left-sm:margin-right-sm'
,p_plug_template=>wwv_flow_api.id(34586998341208988387)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source=>unistr('<p><i>Lan\00E7amentos de Ocorr\00EAncias</i></p>')
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12736630607504553756)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_button_name=>'BT_INS_LCTO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft:t-Button--padRight'
,p_button_template_id=>wwv_flow_api.id(34587020881614988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Inserir Lan\00E7amentos')
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:7:&SESSION.::&DEBUG.:RP,7:P7_ACAO,P7_PROCESSO,P7_SEQ_OCORR:I,&P5_PROCESSO.,&P5_SEQ_OCORR.'
,p_button_condition=>'P5_PROCESSO'
,p_button_condition2=>'1:2:3:4:5:6'
,p_button_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_icon_css_classes=>'fa-plus-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12736643365963580366)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_button_name=>'BT_UPD_LCTOX'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft:t-Button--padLeft'
,p_button_template_id=>wwv_flow_api.id(34587020881614988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Alterar | Excluir Lan\00E7amentos')
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:21:&SESSION.::&DEBUG.:RP,21:P21_ACAO,P21_PROCESSO,P21_SEQ_OCORR:U,&P5_PROCESSO.,&P5_SEQ_OCORR.'
,p_button_condition_type=>'NEVER'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12355407984877182184)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_button_name=>'BT_UPD_LCTO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--iconLeft:t-Button--padLeft'
,p_button_template_id=>wwv_flow_api.id(34587020881614988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>unistr('Alterar | Excluir Lan\00E7amentos')
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP,10:P10_ACAO,P10_PROCESSO,P10_SEQ_OCORR:U,&P5_PROCESSO.,&P5_SEQ_OCORR.'
,p_button_condition=>'P5_PROCESSO'
,p_button_condition2=>'1:2:3:4:5:6'
,p_button_condition_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_icon_css_classes=>'fa-check-square-o'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(9203406966582990624)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(12734198816071558755)
,p_button_name=>'BT_CALC_FOLHA'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--mobileHideLabel:t-Button--success:t-Button--iconLeft:t-Button--padLeft'
,p_button_template_id=>wwv_flow_api.id(34587020881614988434)
,p_button_image_alt=>'Calcular Folha'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=CALC_&P_BASE.:10:&SESSION.::&DEBUG.:RP,10:P10_ADD,P10_APP_ANT,P10_PAG_ANT,P10_EMPRESA,P10_FILIAL,P10_CCUSTO,P10_SINDICATO,P10_MATRICULA,P10_DTREF_AUXX:S,MVF_MENU_&P_BASE.,5,&P5_EMP_AUX.,&P5_FIL_AUX.,&P5_CCST_AUX.,&P5_SIND_AUX.,&P5_MAT_AUX.,&P5_DTREF_AUXX.'
,p_button_condition=>':P5_PROCESSO = 1 AND INSTR(:P5_EMPRESAS,'':'') = 0 AND ((:P5_APP_ANT IS NULL AND :P5_PAG_ANT IS NULL) OR (:P5_APP_ANT <> ''CALC_''||:P_BASE AND :P5_PAG_ANT <> 10))'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-calculator'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12734188581395454997)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_button_name=>'BT_PESQUISAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--simple:t-Button--iconLeft:t-Button--pillStart:t-Button--stretch'
,p_button_template_id=>wwv_flow_api.id(34587020881614988434)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Pesquisar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(12734167259193431459)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(68372581060257326221)
,p_button_name=>'RESET'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34587020591823988431)
,p_button_image_alt=>'Reset'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP,5:P5_APP_ANT,P5_PAG_ANT:&P5_APP_ANT.,&P5_PAG_ANT.'
,p_icon_css_classes=>'fa-undo'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(11258303786134163682)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(68372581060257326221)
,p_button_name=>'BACK'
,p_button_action=>'REDIRECT_APP'
,p_button_template_options=>'#DEFAULT#:t-Button--primary'
,p_button_template_id=>wwv_flow_api.id(34587020591823988431)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Voltar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_button_redirect_url=>'f?p=&P5_APP_ANT.:&P5_PAG_ANT.:&SESSION.::&DEBUG.:::'
,p_button_condition=>':P5_APP_ANT IS NOT NULL AND :P5_PAG_ANT IS NOT NULL'
,p_button_condition_type=>'PLSQL_EXPRESSION'
,p_icon_css_classes=>'fa-undo-arrow'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6186643540199559718)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(12918653450659140181)
,p_button_name=>'IA'
,p_button_static_id=>'BTN_IA'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(34587020591823988431)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'IA'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if :p_base = ''NATCORP'' then',
' return true;',
'else',
' return false;',
'end if;'))
,p_button_condition_type=>'FUNCTION_BODY'
,p_button_css_classes=>'btnIA fab-ia-natcorp'
,p_button_cattributes=>'style="background-image: url(''#WORKSPACE_IMAGES#IA-NATCORP-LOGO (128X128).png''); background-size: cover; background-position: center;"'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6186642765329559711)
,p_name=>'P5_FLG'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6186642946474559712)
,p_name=>'P5_MSG'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6186643028489559713)
,p_name=>'P5_STATIC_ID_IR'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6186643139228559714)
,p_name=>'P5_USER_PROMPT'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203407340808990627)
,p_name=>'P5_ERR_MSG'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203408644070990640)
,p_name=>'P5_EXEC_CALC'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409098654990645)
,p_name=>'P5_EMP_AUX'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409185108990646)
,p_name=>'P5_FIL_AUX'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409331224990647)
,p_name=>'P5_CCST_AUX'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409451014990648)
,p_name=>'P5_SIND_AUX'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409504525990649)
,p_name=>'P5_MAT_AUX'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9203409607287990650)
,p_name=>'P5_DTREF_AUX'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(9545232163953782754)
,p_name=>'P5_DTREF_AUXX'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10018367378527909687)
,p_name=>'P5_DTVALINI'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Validade inicial'
,p_placeholder=>'- Todas -'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10018367509506909689)
,p_name=>'P5_DTVALFIM'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Validade final'
,p_placeholder=>'- Todas -'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11258303162865163676)
,p_name=>'P5_APP_ANT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(11258303249670163677)
,p_name=>'P5_PAG_ANT'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12727216144302374644)
,p_name=>'P5_SEQ_OCORR'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734188986600454997)
,p_name=>'P5_PESQUISA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734189631791454998)
,p_name=>'P5_CODAUX'
,p_item_sequence=>220
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734190085576454998)
,p_name=>'P5_EMPRESAS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Empresas'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COPY OF LOV_EMPRESAS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT e.cod||'' - ''||e.nome dsc',
'      ,e.cod                ret',
'  FROM empresas e',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272316018792967597)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Empresas'
,p_attribute_08=>'380'
,p_attribute_09=>'430'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734190416471454998)
,p_name=>'P5_CCUSTOS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Centros de custo'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ((CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 AND INSTR(:P5_FILIAIS,'':'') > 0 THEN ''[''||LPAD(f.cod_empresa,3,''0'')||''|''||LPAD(f.cod_filial,4,''0'')||''] ''||LPAD(f.cod_ccusto,10,''0'')',
'              WHEN INSTR(:P5_EMPRESAS,'':'') = 0 AND INSTR(:P5_FILIAIS,'':'') > 0 THEN ''[''||LPAD(f.cod_filial,4,''0'')||''] ''||LPAD(f.cod_ccusto,10,''0'')',
'              WHEN INSTR(:P5_EMPRESAS,'':'') > 0 AND INSTR(:P5_FILIAIS,'':'') = 0 THEN ''[''||LPAD(f.cod_empresa,3,''0'')||''] ''||LPAD(f.cod_ccusto,10,''0'')                ',
'           ELSE LPAD(f.cod_ccusto,10,''0'') END)||''-''||(SELECT x.nome FROM centro_de_custo x WHERE x.cod_empresa = f.cod_empresa AND x.cod = f.cod_ccusto)) det',
'       ,f.cod_ccusto||''#''||f.cod_filial||''#''||f.cod_empresa  ret',
'  FROM filial_ccusto f',
' WHERE (f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (:P5_FILIAIS IS NULL OR f.cod_filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'ORDER BY f.cod_ccusto, f.cod_filial, f.cod_empresa'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_FILIAIS'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_FILIAIS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Centros de Custo'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734190832449454998)
,p_name=>'P5_MATRICULAS'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Matr\00EDculas')
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 THEN ''[''||LPAD(p.cod_empresa,3,''0'')||''] ''||LPAD(p.matricula,6,''0'')||''-''||p.nome',
'          ELSE LPAD(p.matricula,6,''0'')||''-''||p.nome END) det',
'      ,p.matricula||''#''||p.cod_empresa                   ret',
'  FROM inf_pessoais p',
' WHERE (p.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (p.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (p.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t)) ',
'   AND EXISTS(SELECT 1',
'                FROM informacoes_funcionais f',
'               WHERE f.cod_empresa  = p.cod_empresa',
'                 AND f.matricula    = p.matricula',
'                 AND f.dc_matricula = p.dc_matricula',
'                 AND (:P5_FILIAIS IS NULL OR f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_FILIAIS, '':'')) t))',
'                 AND (:P5_CCUSTOS IS NULL OR f.cod_ccusto||''#''||f.filial||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CCUSTOS, '':'')) t))',
'                 AND (:P5_CARGOS  IS NULL OR f.cargo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_CARGOS, '':'')) t))',
'                 AND ((:P5_DTADMINI IS NULL AND :P5_DTADMFIM IS NULL) OR (f.dt_admissao_basica BETWEEN TO_DATE(:P5_DTADMINI,''DD/MM/RRRR'') AND TO_DATE(:P5_DTADMFIM,''DD/MM/RRRR''))) ',
'                 AND (:P5_SITUACOES  IS NULL OR f.situacao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))',
'                 AND (:P5_VINCULOS  IS NULL OR f.vinculo IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_VINCULOS, '':'')) t))',
'                 AND (:P5_SINDICATOS  IS NULL OR f.num_sind_diss||''#''||f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SINDICATOS, '':'')) t))',
'                 AND (:P5_TIPOSAL  IS NULL OR f.tipo_salario IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOSAL, '':'')) t))',
'                 AND (:P5_TIPOPAG  IS NULL OR f.cod_tipo_pagto IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOPAG, '':'')) t))',
'                 AND ((f.situacao < ''90'' OR f.situacao = ''98'') OR ((f.situacao >= ''90'' AND f.situacao <> ''98'') AND',
'                      (:P5_DATASIT   IS NULL OR (f.dt_situacao = TO_DATE(:P5_DATASIT,''DD/MM/RRRR''))) AND',
'                      (:P5_MESANOSIT IS NULL OR (:P5_MESANOSIT IS NOT NULL AND (pkg_MovtFinanceiro.fnc_VerifDtSitDemtido(:P5_MESANOSIT, f.situacao, f.dt_situacao) = ''S'')) )))          ',
'             )         ',
'ORDER BY p.matricula, p.cod_empresa'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_EMPRESAS,P5_FILIAIS,P5_DATASIT,P5_MESANOSIT'
,p_ajax_items_to_submit=>'P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_EMPRESAS,P5_FILIAIS,P5_DATASIT,P5_MESANOSIT'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Matr\00EDculas ')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734198970449558756)
,p_name=>'P5_PROC_TXT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734199738291558764)
,p_name=>'P5_FILIAIS'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Filiais'
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 THEN ''[''||LPAD(f.cod_empresa, 3, ''0'')||''] ''||f.cod_filial||''-''||f.nome_filial',
'          ELSE f.cod_filial||''-''||f.nome_filial END) det',
'      ,f.cod_filial||''#''||f.cod_empresa              ret',
'  FROM filiais f',
' WHERE (f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'ORDER BY f.cod_filial, f.cod_empresa'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_EMPRESAS'
,p_ajax_items_to_submit=>'P5_EMPRESAS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Filiais'
,p_attribute_08=>'420'
,p_attribute_09=>'450'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734199902930558765)
,p_name=>'P5_CARGOS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Cargos'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(c.cod, 7,''0'')||''-''||c.nome det',
'      ,c.cod              ret',
'  FROM cargos c',
' WHERE (c.dt_term_vig_cargo >= TRUNC(SYSDATE))',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Cargos'
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734199976352558766)
,p_name=>'P5_DTADMINI'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Admiss\00E3o inicial')
,p_placeholder=>'- Todas -'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200018434558767)
,p_name=>'P5_DTADMFIM'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Admiss\00E3o final')
,p_placeholder=>'- Todas -'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200177021558768)
,p_name=>'P5_SITUACOES'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Situa\00E7\00F5es')
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT s.cod||''-''||s.nome det',
'      ,s.cod              ret',
'  FROM sit_func s',
'ORDER BY 2 '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Situa\00E7\00F5es')
,p_attribute_08=>'320'
,p_attribute_09=>'430'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200262332558769)
,p_name=>'P5_VINCULOS'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('V\00EDnculos')
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT v.cod||''-''||v.nome det',
'      ,v.cod              ret',
'  FROM vinculo_empreg v',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('V\00EDnculos')
,p_attribute_08=>'320'
,p_attribute_09=>'430'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200391632558770)
,p_name=>'P5_SINDICATOS'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Sindicatos'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 THEN ''[''||LPAD(sd.cod_empresa,3,''0'')||''] ''||sd.cod||''-''||sd.nome',
'          ELSE sd.cod||''-''||sd.nome END) det',
'      ,sd.cod||''#''||sd.cod_empresa       ret',
'  FROM sindicatos sd',
' WHERE (sd.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))  ',
'ORDER BY sd.cod, sd.cod_empresa '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_EMPRESAS'
,p_ajax_items_to_submit=>'P5_EMPRESAS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Sindicatos'
,p_attribute_08=>'480'
,p_attribute_09=>'520'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200495179558771)
,p_name=>'P5_TIPOSAL'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Tipos de sal\00E1rio')
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ts.cod||''-''||ts.descricao det',
'      ,ts.cod                    ret',
'  FROM tipo_salario ts',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Tipos de Sal\00E1rio')
,p_attribute_08=>'300'
,p_attribute_09=>'420'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200523939558772)
,p_name=>'P5_TIPOPAG'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Tipos de pagamento'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT LPAD(tp.cod_tipo_pagto,5,'' '')||''-''||tp.descricao det',
'      ,tp.cod_tipo_pagto                                ret',
'  FROM tipo_pagamento tp',
'ORDER BY 2 '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Tipos de Pagamento'
,p_attribute_08=>'300'
,p_attribute_09=>'420'
,p_attribute_11=>':'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200649121558773)
,p_name=>'P5_DATAREF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Per\00EDodos')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT l.display  det',
'      ,l.data_ref ret',
'  FROM list_hist_finan_datas l',
' WHERE TRUNC(l.data_ref,''month'') >= ADD_MONTHS(TRUNC(SYSDATE,''month''),-60)',
'ORDER BY 2 DESC '))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_attribute_07=>unistr('Per\00EDodos - Data de Refer\00EAncia')
,p_attribute_08=>'300'
,p_attribute_09=>'420'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200739066558774)
,p_name=>'P5_TIPOEVENT'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>'Tipos de evento'
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.det, x.ret',
unistr('  FROM(SELECT DISTINCT(CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 THEN ''[''||o.cod_empresa||''] ''||DECODE(o.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'')'),
unistr('                         ELSE DECODE(o.tipo_rubrica, 1, ''1-Vencimento, Provento ou Pens\00E3o'', 2, ''2-Desconto'', 3, ''3-Informativa'', 4, ''4-Informativa Dedutora'') END) det '),
'             ,o.tipo_rubrica||''#''||o.cod_empresa ret',
'             ,o.tipo_rubrica, o.cod_empresa',
'         FROM ocorr_pagto o',
'        WHERE (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'          AND (o.cod         = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'          AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))  ) x',
'ORDER BY x.tipo_rubrica, x.cod_empresa'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_EMPRESAS'
,p_ajax_items_to_submit=>'P5_EMPRESAS'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Tipos de Evento'
,p_attribute_08=>'350'
,p_attribute_09=>'450'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12734200834624558775)
,p_name=>'P5_OCORRPAGTO'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Ocorr\00EAncias')
,p_placeholder=>'- Todas -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (CASE WHEN INSTR(:P5_EMPRESAS,'':'') > 0 THEN ''[''||LPAD(o.cod_empresa,3,''0'')||''] ''||LPAD(o.cod,4,''0'')||''-''||o.nome',
'          ELSE LPAD(o.cod,4,''0'')||''-''||o.nome END) det',
'       ,o.cod||''#''||o.cod_empresa                               ret',
'  FROM ocorr_pagto o',
' WHERE (o.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod         = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t)) ',
'   AND (:P5_TIPOEVENT IS NULL OR o.tipo_rubrica||''#''||o.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_TIPOEVENT, '':'')) t))      ',
'ORDER BY o.cod, o.cod_empresa'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_TIPOEVENT'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_TIPOEVENT'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Ocorr\00EAncias')
,p_attribute_08=>'450'
,p_attribute_09=>'480'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12862984566347658283)
,p_name=>'P5_PROCESSO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(12862984385413658281)
,p_prompt=>'Processo'
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>unistr('STATIC2:1-Folha | Rescis\00E3o;1,2-Adiantamento;2,3-F\00E9rias;3,4-13\00BA Sal\00E1rio;4,5-Participa\00E7\00E3o no Lucros - PLR;5,6-Pagamentos Diversos;6,7-Todos os Processos - Somente Consulta;7')
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_cSize=>30
,p_colspan=>6
,p_grid_column=>4
,p_field_template=>wwv_flow_api.id(25272316018792967597)
,p_item_template_options=>'#DEFAULT#:margin-top-none:margin-bottom-none'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>'Processos'
,p_attribute_08=>'400'
,p_attribute_09=>'460'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12974011153598435088)
,p_name=>'P5_DATASIT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Data da demiss\00E3o')
,p_placeholder=>'- Selecione -'
,p_format_mask=>'DD/MM/RRRR'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(12974011328346435089)
,p_name=>'P5_MESANOSIT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('M\00EAs/ano da demiss\00E3o')
,p_placeholder=>'- Selecione -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT TO_CHAR(TRUNC(f.dt_situacao,''MM''),''MON/RRRR'') det',
'      ,TRUNC(f.dt_situacao,''MM'')                              ret',
'  FROM informacoes_funcionais f',
' WHERE (f.cod_empresa = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (f.matricula   = :P5_CODAUX OR :P5_CODAUX IS NULL)',
'   AND (f.cod_empresa IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t))',
'   AND (f.situacao IN(SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE FROM TABLE(APEX_STRING.split(:P5_SITUACOES, '':'')) t))      ',
'   AND (f.situacao >= ''90'' AND f.situacao <> ''98'')',
'ORDER BY 2 DESC'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- Selecione -'
,p_lov_cascade_parent_items=>'P5_SITUACOES,P5_EMPRESAS'
,p_ajax_items_to_submit=>'P5_EMPRESAS,P5_CODAUX,P5_SITUACOES'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Mes/Ano situa\00E7\00E3o')
,p_attribute_08=>'300'
,p_attribute_09=>'420'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13007764241479680540)
,p_name=>'P5_USUARIO'
,p_item_sequence=>200
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Usu\00E1rios')
,p_placeholder=>'- Todos -'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.detalhe, x.retorno',
'  FROM TABLE(pkg_MovtFinanceiro.fnc_TabUsuariosPipe(pProcesso   => :P5_PROCESSO',
'                                                   ,pEmpresas   => :P5_EMPRESAS',
'                                                   ,pMatriculas => :P5_MATRICULAS',
'                                                   ,pDtRef      => :P5_DATAREF',
'                                                   ,pDtValIni   => :P5_DTVALINI',
'                                                   ,pDtValFim   => :P5_DTVALFIM))x',
' WHERE x.retorno IS NOT NULL                                                    ',
'ORDER BY 2'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_PROCESSO,P5_EMPRESAS,P5_MATRICULAS,P5_DATAREF,P5_DTVALINI,P5_DTVALFIM'
,p_ajax_items_to_submit=>'P5_PROCESSO,P5_EMPRESAS,P5_MATRICULAS,P5_DATAREF,P5_DTVALINI,P5_DTVALFIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Usu\00E1rios')
,p_attribute_08=>'380'
,p_attribute_09=>'500'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13007764295287680541)
,p_name=>'P5_DTATLZ'
,p_item_sequence=>210
,p_item_plug_id=>wwv_flow_api.id(12734199073572558757)
,p_prompt=>unistr('Data de atualiza\00E7\00E3o')
,p_placeholder=>'- Todas -'
,p_format_mask=>'DD/MM/RRRR HH24:MI:SS'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT x.detalhe, x.retorno',
'  FROM TABLE(pkg_MovtFinanceiro.fnc_TabDataAtlzPipe(pProcesso   => :P5_PROCESSO',
'                                                   ,pEmpresas   => :P5_EMPRESAS',
'                                                   ,pMatriculas => :P5_MATRICULAS',
'                                                   ,pDtRef      => :P5_DATAREF',
'                                                   ,pUsuario    => :P5_USUARIO',
'                                                   ,pDtValIni   => :P5_DTVALINI',
'                                                   ,pDtValFim   => :P5_DTVALFIM))x',
' WHERE x.retorno IS NOT NULL                                                   ',
'ORDER BY TO_DATE(x.retorno, ''DD/MM/RRRR'') DESC; '))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P5_PROCESSO,P5_EMPRESAS,P5_MATRICULAS,P5_DATAREF,P5_USUARIO,P5_DTVALINI,P5_DTVALFIM'
,p_ajax_items_to_submit=>'P5_PROCESSO,P5_EMPRESAS,P5_MATRICULAS,P5_DATAREF,P5_USUARIO,P5_DTVALINI,P5_DTVALFIM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(25272315761639967594)
,p_item_template_options=>'#DEFAULT#'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'Y'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
,p_attribute_07=>unistr('Datas Atualiza\00E7\00E3o')
,p_attribute_08=>'320'
,p_attribute_09=>'450'
,p_attribute_11=>':'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13007764617491680544)
,p_name=>'P5_DTSIT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(13007767725620680575)
,p_name=>'P5_DISABLE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(58549278215787579232)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12734200962390558776)
,p_validation_name=>'Valida Processo'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_PROCESSO IS NULL THEN',
'    vReturn := ''PROCESSO deve ser informado!'';',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12862984566347658283)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12734201828161558785)
,p_validation_name=>unistr('Valida Per\00EDodo')
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_DATAREF IS NULL THEN',
'    IF :P5_DTVALINI IS NULL AND :P5_DTVALFIM IS NULL THEN',
unistr('      vReturn := ''PER\00CDODO deve ser informado!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12734200649121558773)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12734201948160558786)
,p_validation_name=>unistr('Valida Situa\00E7\00F5es')
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_SITUACOES IS NULL THEN',
unistr('    vReturn := ''SITUA\00C7\00D5ES deve ser informado!'';'),
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_validation_condition_type=>'NEVER'
,p_associated_item=>wwv_flow_api.id(12734200177021558768)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12734202081075558787)
,p_validation_name=>unistr('Valida Data In\00EDcio')
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_DTADMINI IS NULL AND :P5_DTADMFIM IS NOT NULL THEN',
unistr('    vReturn := ''DATA IN\00CDCIO deve ser informada!'';'),
'  ELSIF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NOT NULL THEN',
'    IF TO_DATE(:P5_DTADMINI, ''DD/MM/RRRR'') > TO_DATE(:P5_DTADMFIM, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DATA IN\00CDCIO n\00E3o deve ser maior que fim!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12734199976352558766)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(12734202134936558788)
,p_validation_name=>'Valida Data Fim'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NULL THEN',
'    vReturn := ''DATA FIM deve ser informada!'';',
'  ELSIF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NOT NULL THEN',
'    IF TO_DATE(:P5_DTADMFIM, ''DD/MM/RRRR'') < TO_DATE(:P5_DTADMINI, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DATA FIM n\00E3o deve ser menor que in\00EDcio!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12734200018434558767)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(13007765052653680549)
,p_validation_name=>unistr('Valida Data e M\00EAs/Ano Situa\00E7\00E3o')
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'  --',
'  --CURSOR cSit IS',
'  --  SELECT COUNT(1)',
'  --    FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'  --   WHERE t.column_value >= ''90'' AND t.column_value < ''98'';',
'  --',
'  vCont     NUMBER DEFAULT 0;',
'BEGIN',
'  IF :P5_SITUACOES IS NOT NULL THEN',
'    --OPEN cSit;',
'    --FETCH cSit INTO vCont;',
'    --CLOSE cSit;',
'    vCont := pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES);',
'    --',
'    IF vCont > 0 THEN',
'    --IF vCont = 0 THEN',
'      IF :P5_DATASIT IS NULL AND :P5_MESANOSIT IS NULL THEN',
unistr('        vReturn := ''[DATA ou M\00CAS/ANO] SITUA\00C7\00C3O deve ser informado para situa\00E7\00E3o demitido!'';'),
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(13015220130802361448)
,p_validation_name=>'Valida DT. Sit'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_SITUACOES IS NOT NULL AND :P5_DATASIT IS NULL AND :P5_MESANOSIT IS NULL THEN',
'    IF pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES) > 0 THEN',
unistr('    vReturn := ''DATA SITUA\00C7\00C3O deve ser informada!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12974011153598435088)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(13015221360768361461)
,p_validation_name=>'Valida MesAno Sit.'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_SITUACOES IS NOT NULL AND :P5_DATASIT IS NULL AND :P5_MESANOSIT IS NULL THEN',
'    IF pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES) > 0 THEN',
unistr('    vReturn := ''M\00CAS/ANO SITUA\00C7\00C3O deve ser informada!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12974011328346435089)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(10799942537193045088)
,p_validation_name=>'Valida Empresas'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_EMPRESAS IS NULL THEN',
'    vReturn := ''EMPRESAS deve ser informado!'';',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(12734190085576454998)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(10018367824139909692)
,p_validation_name=>unistr('Valida Dt. Validade In\00EDcio')
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_DTVALINI IS NOT NULL AND :P5_DTVALFIM IS NOT NULL THEN',
'    IF TO_DATE(:P5_DTVALINI, ''DD/MM/RRRR'') > TO_DATE(:P5_DTVALFIM, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DT. VALIDADE INICIAL n\00E3o deve ser maior que final!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(10018367378527909687)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(10018367977445909693)
,p_validation_name=>'Valida Dt. Validade Final'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vReturn    VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  IF :P5_DTVALINI IS NOT NULL AND :P5_DTVALFIM IS NOT NULL THEN',
'    IF TO_DATE(:P5_DTVALFIM, ''DD/MM/RRRR'') < TO_DATE(:P5_DTVALINI, ''DD/MM/RRRR'') THEN',
unistr('      vReturn := ''DT. VALIDADE FINAL n\00E3o deve ser menor que inicial!'';'),
'    END IF;',
'  END IF;',
'  --',
'  RETURN(vReturn);',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_associated_item=>wwv_flow_api.id(10018367509506909689)
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739693725505797799)
,p_name=>'Edit Report - Dialog Closed 1'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739693817123797800)
,p_event_id=>wwv_flow_api.id(12739693725505797799)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12734102757947320220)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739693941956797801)
,p_name=>'Edit Report - Dialog Closed 2'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739694031111797802)
,p_event_id=>wwv_flow_api.id(12739693941956797801)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12736630503308553755)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739694150554797803)
,p_name=>'Edit Report - Dialog Closed 3'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739694265306797804)
,p_event_id=>wwv_flow_api.id(12739694150554797803)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12736644211817580374)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739778341309500655)
,p_name=>'Edit Report - Dialog Closed 4'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739778487152500656)
,p_event_id=>wwv_flow_api.id(12739778341309500655)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12737486648546938975)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739778524342500657)
,p_name=>'Edit Report - Dialog Closed 5'
,p_event_sequence=>60
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739778676343500658)
,p_event_id=>wwv_flow_api.id(12739778524342500657)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12737525906193140760)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12739778750797500659)
,p_name=>'Edit Report - Dialog Closed 6'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739778868844500660)
,p_event_id=>wwv_flow_api.id(12739778750797500659)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12737529488280140796)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007768027370680578)
,p_name=>'Edit Report - Dialog Closed'
,p_event_sequence=>80
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12734198816071558755)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterclosedialog'
,p_display_when_type=>'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST'
,p_display_when_cond=>'P5_PROCESSO'
,p_display_when_cond2=>'1:2:3:4:5:6'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007768095753680579)
,p_event_id=>wwv_flow_api.id(13007768027370680578)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12918653450659140181)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12734208020780651119)
,p_name=>'Executa Pesquisa'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12734188581395454997)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734208480546651122)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_PESQUISA'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'S'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12739779004211500661)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF NOT APEX_COLLECTION.collection_exists(''LANCTO_FILTRO'') THEN',
'    APEX_COLLECTION.create_collection(''LANCTO_FILTRO'');',
'  ELSE',
'    APEX_COLLECTION.truncate_collection(''LANCTO_FILTRO'');',
'  END IF;',
'  --',
'  APEX_COLLECTION.add_member(p_collection_name => ''LANCTO_FILTRO''',
'                            ,p_c001            => :P5_EMPRESAS',
'                            ,p_c002            => :P5_FILIAIS',
'                            ,p_c003            => :P5_CCUSTOS',
'                            ,p_c004            => :P5_CARGOS',
'                            ,p_c005            => :P5_DTADMINI',
'                            ,p_c006            => :P5_DTADMFIM',
'                            ,p_c007            => :P5_SITUACOES',
'                            ,p_c008            => :P5_VINCULOS',
'                            ,p_c009            => :P5_SINDICATOS',
'                            ,p_c010            => :P5_TIPOSAL',
'                            ,p_c011            => :P5_TIPOPAG',
'                            ,p_c012            => :P5_MATRICULAS',
'                            ,p_c013            => :P5_DATAREF',
'                            ,p_c014            => :P5_TIPOEVENT',
'                            ,p_c015            => :P5_OCORRPAGTO',
'                            ,p_c016            => :P5_USUARIO',
'                            ,p_c017            => :P5_DTATLZ',
'                            ,p_c018            => :P5_MESANOSIT',
'                            ,p_d001            => :P5_DATASIT',
'                            ,p_d002            => :P5_DTVALINI',
'                            ,p_d003            => :P5_DTVALFIM);',
'END;'))
,p_attribute_02=>'P5_EMPRESAS,P5_FILIAIS,P5_CCUSTOS,P5_CARGOS,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_VINCULOS,P5_SINDICATOS,P5_TIPOSAL,P5_TIPOPAG,P5_MATRICULAS,P5_DATAREF,P5_TIPOEVENT,P5_OCORRPAGTO,P5_USUARIO,P5_DTATLZ,P5_DTVALINI,P5_DTVALFIM'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734209459204651122)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734208993853651122)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736643584946580368)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12736630607504553756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736643654757580369)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12355407984877182184)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13015221274926361460)
,p_event_id=>wwv_flow_api.id(12734208020780651119)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P5_DISABLE := NULL;',
'  --',
'  IF :P5_PROCESSO IS NULL OR :P5_EMPRESAS IS NULL OR (:P5_DATAREF IS NULL AND (:P5_DTVALINI IS NULL AND :P5_DTVALFIM IS NULL)) THEN',
'    :P5_DISABLE := ''S1'';',
'  END IF;',
'  --',
'  IF :P5_DISABLE IS NULL THEN',
'    IF :P5_DTADMINI IS NULL AND :P5_DTADMFIM IS NOT NULL THEN',
'      :P5_DISABLE := ''S2'';',
'    ELSIF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NOT NULL THEN',
'      IF TO_DATE(:P5_DTADMINI, ''DD/MM/RRRR'') > TO_DATE(:P5_DTADMFIM, ''DD/MM/RRRR'') THEN',
'        :P5_DISABLE := ''S3'';',
'      END IF;',
'    END IF;',
'  END IF;',
'  --',
'  IF :P5_DISABLE IS NULL THEN',
'    IF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NULL THEN',
'      :P5_DISABLE := ''S4'';',
'    ELSIF :P5_DTADMINI IS NOT NULL AND :P5_DTADMFIM IS NOT NULL THEN',
'      IF TO_DATE(:P5_DTADMFIM, ''DD/MM/RRRR'') < TO_DATE(:P5_DTADMINI, ''DD/MM/RRRR'') THEN',
'        :P5_DISABLE := ''S5'';',
'      END IF;',
'    END IF;  ',
'  END IF;',
'  --',
'  IF :P5_DISABLE IS NULL THEN',
'    IF :P5_SITUACOES IS NOT NULL THEN',
'      IF pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES) > 0 THEN',
'        IF :P5_DATASIT IS NULL AND :P5_MESANOSIT IS NULL THEN',
'          :P5_DISABLE := ''S6'';',
'        END IF;',
'      END IF;  ',
'    END IF;',
'  END IF;',
'  --',
'  IF :P5_DISABLE IS NULL THEN',
'    IF :P5_DTVALINI IS NOT NULL AND :P5_DTVALFIM IS NOT NULL THEN',
'      IF TO_DATE(:P5_DTVALINI, ''DD/MM/RRRR'') > TO_DATE(:P5_DTVALFIM, ''DD/MM/RRRR'') THEN',
'        :P5_DISABLE := ''S7'';',
'      END IF;',
'    END IF;',
'  END IF;  ',
'END;'))
,p_attribute_02=>'P5_PROCESSO,P5_DISABLE,P5_EMPRESAS,P5_DATAREF,P5_DTADMINI,P5_DTADMFIM,P5_SITUACOES,P5_DATASIT,P5_MESANOSIT,P5_DTVALINI,P5_DTVALFIM'
,p_attribute_03=>'P5_DISABLE'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12734201219100558779)
,p_name=>'Desabilita REP'
,p_event_sequence=>100
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(12734188581395454997)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
,p_da_event_comment=>'PL/SQL Expression -> :P5_PROCESSO IS NULL OR :P5_EMPRESAS IS NULL OR :P5_DATAREF IS NULL'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734201464363558781)
,p_event_id=>wwv_flow_api.id(12734201219100558779)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
end;
/
begin
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736643763317580370)
,p_event_id=>wwv_flow_api.id(12734201219100558779)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12736630607504553756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736643852648580371)
,p_event_id=>wwv_flow_api.id(12734201219100558779)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12736643365963580366)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12734213204228663978)
,p_name=>'Disable Report'
,p_event_sequence=>110
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(53527829940150309345)
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734213515939663978)
,p_event_id=>wwv_flow_api.id(12734213204228663978)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736644007137580372)
,p_event_id=>wwv_flow_api.id(12734213204228663978)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12736630607504553756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12736644061150580373)
,p_event_id=>wwv_flow_api.id(12734213204228663978)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12355407984877182184)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203407960306990634)
,p_event_id=>wwv_flow_api.id(12734213204228663978)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(9203406966582990624)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12734199550196558762)
,p_name=>'Atribui Processo TXT'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_PROCESSO'
,p_condition_element=>'P5_PROCESSO'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734199691648558763)
,p_event_id=>wwv_flow_api.id(12734199550196558762)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  :P5_PROC_TXT := NULL;',
'  --',
'  :P5_PROC_TXT := CASE :P5_PROCESSO',
unistr('                    WHEN 1 THEN ''Folha | Rescis\00E3o'''),
'                    WHEN 2 THEN ''Adiantamento''',
unistr('                    WHEN 3 THEN ''F\00E9rias'''),
unistr('                    WHEN 4 THEN ''13\00BA Sal\00E1rio'''),
unistr('                    WHEN 5 THEN ''Participa\00E7\00E3o nos Lucros - PLR'''),
'                    WHEN 6 THEN ''Pagamentos Diversos''',
'                    WHEN 7 THEN ''Todos os Processos - (Somente Consulta)''',
'                  ELSE NULL',
'                  END;',
'END;'))
,p_attribute_02=>'P5_PROCESSO,P5_PROC_TXT'
,p_attribute_03=>'P5_PROC_TXT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(12734222921352742937)
,p_name=>'Expand Collapse Parametros'
,p_event_sequence=>130
,p_condition_element=>'P5_PESQUISA'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734223367218742938)
,p_event_id=>wwv_flow_api.id(12734222921352742937)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$("body").find(".a-Collapsible").collapsible("expand");'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(12734223821432742939)
,p_event_id=>wwv_flow_api.id(12734222921352742937)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$("body").find(".a-Collapsible").collapsible("collapse");'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007764397323680542)
,p_name=>unistr('Verifica Situa\00E7\00F5es')
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_SITUACOES'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007764524464680543)
,p_event_id=>wwv_flow_api.id(13007764397323680542)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  --CURSOR cSit IS',
'  --  SELECT COUNT(1)',
'  --    FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'  --   WHERE t.column_value >= ''90'' AND t.column_value < ''98'';',
'  --',
'  vCont     NUMBER DEFAULT 0;',
'BEGIN',
'  :P5_DTSIT := 1;',
'  --',
'  IF :P5_SITUACOES IS NOT NULL THEN',
'    --OPEN cSit;',
'    --FETCH cSit INTO vCont;',
'    --CLOSE cSit;',
'    vCont := pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES);',
'    --',
'    IF vCont > 0 THEN',
'      :P5_DTSIT := 0;',
'    ELSE',
'      :P5_DTSIT := 1;',
'    END IF;',
'  ELSE',
'    :P5_DTSIT := 1;',
'  END IF;',
'END;'))
,p_attribute_02=>'P5_DTSIT,P5_SITUACOES'
,p_attribute_03=>'P5_DTSIT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007764674291680545)
,p_name=>unistr('Enable Disable DTs Situa\00E7\00E3o')
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_DTSIT'
,p_condition_element=>'P5_DTSIT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007764829403680546)
,p_event_id=>wwv_flow_api.id(13007764674291680545)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_MESANOSIT,P5_DATASIT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007767115873680569)
,p_event_id=>wwv_flow_api.id(13007764674291680545)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_DATASIT,P5_MESANOSIT'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007764889249680547)
,p_event_id=>wwv_flow_api.id(13007764674291680545)
,p_event_result=>'FALSE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_DATASIT,P5_MESANOSIT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007765185923680550)
,p_name=>unistr('Disable MesAno Situ\00E7\00E3o')
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_DATASIT'
,p_condition_element=>'P5_DATASIT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007765273554680551)
,p_event_id=>wwv_flow_api.id(13007765185923680550)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_MESANOSIT'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007765479668680553)
,p_event_id=>wwv_flow_api.id(13007765185923680550)
,p_event_result=>'FALSE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_ENABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_MESANOSIT'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007765407042680552)
,p_event_id=>wwv_flow_api.id(13007765185923680550)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_MESANOSIT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007766923757680567)
,p_name=>'Disable DT. e MesAno Sit.'
,p_event_sequence=>180
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007767002271680568)
,p_event_id=>wwv_flow_api.id(13007766923757680567)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  --CURSOR cSit IS',
'  --  SELECT COUNT(1)',
'  --    FROM (SELECT COLUMN_VALUE FROM TABLE(apex_string.split(:P5_SITUACOES, '':''))) t',
'  --   WHERE t.column_value >= ''90'' AND t.column_value < ''98'';',
'  --',
'  vCont     NUMBER DEFAULT 0;',
'BEGIN',
'  :P5_DTSIT := 1;',
'  --',
'  IF :P5_SITUACOES IS NOT NULL THEN',
'    --OPEN cSit;',
'    --FETCH cSit INTO vCont;',
'    --CLOSE cSit;',
'    vCont := pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES);',
'    --',
'    IF vCont > 0 THEN',
'      :P5_DTSIT := 0;',
'    ELSE',
'      :P5_DTSIT := 1;',
'    END IF;',
'  ELSE',
'    :P5_DTSIT := 1;',
'  END IF;',
'END;'))
,p_attribute_02=>'P5_SITUACOES,P5_DTSIT'
,p_attribute_03=>'P5_DTSIT'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007767181290680570)
,p_name=>unistr('Disable DT e M\00EAs Ano Sit is NULL')
,p_event_sequence=>190
,p_condition_element=>'P5_SITUACOES'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007767335960680571)
,p_event_id=>wwv_flow_api.id(13007767181290680570)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_DATASIT,P5_MESANOSIT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007767489262680573)
,p_name=>unistr('Disable DT e M\00EAs Ano Sit is NOT NULL')
,p_event_sequence=>200
,p_condition_element=>'P5_SITUACOES'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'PLSQL_EXPRESSION'
,p_display_when_cond=>'pkg_MovtFinanceiro.fnc_VerifSitDemitidos(pSituacoes => :P5_SITUACOES) = 0'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007767603976680574)
,p_event_id=>wwv_flow_api.id(13007767489262680573)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P5_DATASIT,P5_MESANOSIT'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(13007767770968680576)
,p_name=>'Disable REP1'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_DISABLE'
,p_condition_element=>'P5_DISABLE'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007767934092680577)
,p_event_id=>wwv_flow_api.id(13007767770968680576)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'JQUERY_SELECTOR'
,p_affected_elements=>'#REP1'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007768316470680581)
,p_event_id=>wwv_flow_api.id(13007767770968680576)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12736630607504553756)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(13007768403439680582)
,p_event_id=>wwv_flow_api.id(13007767770968680576)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(12355407984877182184)
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203407912459990633)
,p_event_id=>wwv_flow_api.id(13007767770968680576)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_DISABLE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_api.id(9203406966582990624)
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(11258303611300163680)
,p_name=>unistr('Trata Par\00E2metros')
,p_event_sequence=>230
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(11258303689497163681)
,p_event_id=>wwv_flow_api.id(11258303611300163680)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P5_APP_ANT IS NOT NULL AND :P5_PAG_ANT IS NOT NULL THEN',
'    IF :P5_FILIAIS IS NOT NULL THEN',
'      :P5_FILIAIS := REPLACE(REPLACE(:P5_FILIAIS,''-'','':''),''_'',''#'');',
'    END IF;',
'    --',
'    IF :P5_CCUSTOS IS NOT NULL THEN',
'      :P5_CCUSTOS := REPLACE(REPLACE(:P5_CCUSTOS,''-'','':''),''_'',''#'');',
'    END IF;  ',
'    --',
'    IF :P5_MATRICULAS IS NOT NULL THEN',
'      :P5_MATRICULAS := REPLACE(REPLACE(:P5_MATRICULAS,''-'','':''),''_'',''#'');',
'    END IF;      ',
'  END IF;',
'END;'))
,p_attribute_02=>'P5_APP_ANT,P5_PAG_ANT,P5_FILIAIS,P5_CCUSTOS,P5_MATRICULAS'
,p_attribute_03=>'P5_FILIAIS,P5_CCUSTOS,P5_MATRICULAS'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9203407140505990625)
,p_name=>unistr('Verifica C\00E1lculo Folha')
,p_event_sequence=>240
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(9203406966582990624)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203407235299990626)
,p_event_id=>wwv_flow_api.id(9203407140505990625)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  CURSOR cEmp IS SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE emp FROM TABLE(APEX_STRING.split(:P5_EMPRESAS, '':'')) t;',
'  CURSOR cDtRef IS SELECT /*+ cardinality (t 1)*/ COLUMN_VALUE dtRef FROM TABLE(APEX_STRING.split(:P5_DATAREF, '':'')) t;',
'  --',
'  TYPE typ_TabE IS TABLE OF cEmp%ROWTYPE INDEX BY BINARY_INTEGER;',
'  TYPE typ_TabD IS TABLE OF cDtRef%ROWTYPE INDEX BY BINARY_INTEGER;',
'  --',
'  t_TabE    typ_TabE;',
'  t_TabD    typ_TabD;',
'  --',
'  vProcs    VARCHAR2(250) DEFAULT NULL;',
'  vMsg      VARCHAR2(250) DEFAULT NULL;',
'BEGIN',
'  :P5_ERR_MSG   := NULL;',
'  :P5_EXEC_CALC := NULL;',
'  --',
'  IF :P5_EMPRESAS IS NOT NULL AND :P5_DATAREF IS NOT NULL THEN',
'    OPEN cEmp;',
'    FETCH cEmp BULK COLLECT INTO t_TabE;',
'    CLOSE cEmp;',
'    --',
'    OPEN cDtRef;',
'    FETCH cDtRef BULK COLLECT INTO t_TabD;',
'    CLOSE cDtRef;   ',
'    --',
'    IF t_TabE.COUNT > 0 AND t_TabD.COUNT > 0 THEN',
'      FOR e IN t_TabE.FIRST..t_TabE.LAST LOOP',
'        FOR d IN t_TabD.FIRST..t_TabD.LAST LOOP',
'          vProcs := Pkg_Verif_Proc.F_F010326(t_TabE(e).emp, t_TabD(d).dtRef);',
'          --',
'--vProcs := vProcs||''ADIANTAMENTO,FOLHA'';',
'          IF vProcs IS NOT NULL THEN',
unistr('            vMsg := ''<strong>C\00E1lculo n\00E3o permitido!</strong><br> Nesse momento h\00E1 os seguintes processos de c\00E1lculo sendo executados:<br>''||vProcs;'),
'            --',
'            EXIT;',
'          END IF;',
'        END LOOP;',
'        --',
'        IF vMsg IS NOT NULL THEN',
'          EXIT;',
'        END IF;',
'      END LOOP;',
'    END IF;',
'  END IF;',
'  --',
'  IF vMsg IS NOT NULL THEN',
'    :P5_ERR_MSG := vMsg;',
'  ELSE',
'    :P5_EXEC_CALC := ''S'';',
'  END IF;',
'END;'))
,p_attribute_02=>'P5_EMPRESAS,P5_DATAREF,P5_ERR_MSG,P5_EXEC_CALC'
,p_attribute_03=>'P5_ERR_MSG,P5_EXEC_CALC'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9203407425033990628)
,p_name=>'DisparaAlerta'
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_ERR_MSG'
,p_condition_element=>'P5_ERR_MSG'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203407469531990629)
,p_event_id=>wwv_flow_api.id(9203407425033990628)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if (apex.item( "P5_ERR_MSG" ).getValue().length > 0){',
'',
'  alertify.alert(apex.item( "P5_ERR_MSG" ).getValue());',
'',
'    document.getElementById("alertify-cover").style.position="static";',
'  }'))
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9203407627733990630)
,p_name=>'Inicia Alertify'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_ERR_MSG'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203407700371990631)
,p_event_id=>wwv_flow_api.id(9203407627733990630)
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
 p_id=>wwv_flow_api.id(9203408737861990641)
,p_name=>unistr('Executa C\00E1lculo')
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_EXEC_CALC'
,p_condition_element=>'P5_EXEC_CALC'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'S'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
,p_display_when_type=>'NEVER'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203408768761990642)
,p_event_id=>wwv_flow_api.id(9203408737861990641)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'PLUGIN_BE.CTB.ALERTIFY'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'CONFIRM'
,p_attribute_04=>unistr('Confirma a execu\00E7\00E3o do c\00E1lculo da folha?')
,p_attribute_07=>'SIM'
,p_attribute_08=>unistr('N\00C3O')
,p_attribute_09=>'DEFAULT'
,p_attribute_10=>'OK'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9203408878856990643)
,p_event_id=>wwv_flow_api.id(9203408737861990641)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(9545232323531782755)
,p_name=>'Verifica Data Ref.'
,p_event_sequence=>290
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P5_DATAREF'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(9545232360155782756)
,p_event_id=>wwv_flow_api.id(9545232323531782755)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF INSTR(:P5_DATAREF,'':'') = 0 THEN',
'    :P5_DTREF_AUXX := :P5_DATAREF;',
'  END IF;',
'END;'))
,p_attribute_02=>'P5_DTREF_AUXX,P5_DATAREF'
,p_attribute_03=>'P5_DTREF_AUXX'
,p_attribute_04=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6186643165823559715)
,p_name=>unistr('Bot\00E3o IA')
,p_event_sequence=>300
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'[id^=''BTN_IA'']'
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6186643268669559716)
,p_event_id=>wwv_flow_api.id(6186643165823559715)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'(function() {',
unistr('  // Captura o bot\00E3o clicado'),
'  var button = event.target.closest("button");',
'',
'  if (!button) {',
unistr('    console.log("Bot\00E3o n\00E3o identificado.");'),
'    return;',
'  }',
'',
unistr('  // Sobe at\00E9 encontrar a regi\00E3o do IR'),
'  var regionDiv = button.closest(".t-IRR-region");',
'',
'  if (!regionDiv) {',
unistr('    console.log("Regi\00E3o com classe ''t-IRR-region'' n\00E3o encontrada.");'),
'    return;',
'  }',
'',
'  var staticId = regionDiv.id;',
'',
unistr('  // Atualiza os itens da p\00E1gina'),
'  apex.item("P5_STATIC_ID_IR").setValue(staticId);',
unistr('  apex.item("P5_USER_PROMPT").setValue("Analise os dados de lan\00E7amentos a seguir.");'),
'  alert("IA Processando os Dados. Clique na NATI para acompanhar o resultado.");',
'})();'))
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6186643437160559717)
,p_event_id=>wwv_flow_api.id(6186643165823559715)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'',
'  V_RESP    CLOB;',
'  V_FILES   VARCHAR2(4000);',
'',
'  V_SYSTEM_PROMPT CLOB;',
'  V_USER_PROMPT CLOB;',
'',
'  v_id_system_prompt NUMBER;',
'  v_servico varchar2(100) := ''N8N'';',
'  v_llm varchar2(100) := ''GEMINI'';',
'  v_region_static_id varchar2(100) := :P5_STATIC_ID_IR; --''IR_REGION'';',
'  v_region_name varchar2(100);',
'  v_opcao_arq_prompt varchar2(100) := ''CSV'';',
'',
'  v_ir_report_log_id number;',
'  v_chart_log_id number;',
'',
'  v_status varchar2(10);',
'  v_mensagem varchar2(4000);',
'',
'BEGIN',
'',
'  v_system_prompt := null;',
'  v_user_prompt := :P5_USER_PROMPT;  --''Analise os dados a seguir.'';',
'',
'  v_ir_report_log_id := ',
'  pkg_ai.fnct_gerar_csv_ir(',
'  p_app_id => :app_id,',
'  p_page_id => :app_page_id,',
'  p_region_static_id => v_region_static_id,',
'  p_region_name => v_region_name,',
'  p_servico => v_servico,',
'  p_user_prompt => v_user_prompt,',
'  p_user_prompt_aux => null,',
'  p_sys_prompt => null,',
'  p_status => v_status,',
'  p_mensagem => v_mensagem',
'  );',
'',
'  pkg_chatbot.prc_chat(',
'  p_servico => v_servico,',
'  p_client_id => :p_base,',
'  p_user_id => :p_usuario,',
'  p_cod_empresa => :p_empresa_user,',
'  p_matricula => :p_matricula_user,',
'  p_id_system_prompt => v_id_system_prompt,',
'  p_app_id => :app_id,',
'  p_page_id => :app_page_id,',
'  p_region_static_id => v_region_static_id,',
'  p_region_name => v_region_name,',
'  p_system_prompt => null,',
'  p_simples => ''S'',',
'  p_llm => v_llm,',
'  p_role => ''user'',',
'  p_user_prompt => v_user_prompt,',
'  p_user_prompt_adicional => null,',
'  p_ia => ''S'',',
'  p_mostrar => ''S'',',
'  p_temperature => null,',
'  p_ir_report_log_id => v_ir_report_log_id,',
'  p_opcao_arq_prompt => v_opcao_arq_prompt,',
'  p_response => V_RESP,',
'  p_output_files => V_FILES,',
'  p_status => v_status,',
'  p_mensagem => v_mensagem',
'  );',
'',
'  :P5_flg := v_status;',
'  :P5_msg := v_mensagem;',
'',
'END;'))
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(12727216233282374645)
,p_process_sequence=>20
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Atribui Seq Ocorr\00EAncia')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  vDtNum    NUMBER DEFAULT TO_NUMBER(TO_CHAR(SYSDATE, ''RRRRMMDDHH24MISS''));',
'  vRandon   NUMBER DEFAULT ROUND(dbms_random.value(1, 9));',
'BEGIN',
'  IF :P5_SEQ_OCORR IS NOT NULL THEN',
'    IF pkg_MovtFinanceiro.fnc_VerifLanctoOcorrTmpExiste(pSeq => :P5_SEQ_OCORR) > 0 THEN ',
'      pkg_MovtFinanceiro.prc_DEL_LanctoOcorrSeq(pSeq => :P5_SEQ_OCORR);',
'    END IF;',
'    --',
'    IF pkg_MovtFinanceiro.fnc_VerLanctOcorrUpdTmpExiste(pSeq => :P5_SEQ_OCORR) > 0 THEN',
'      pkg_MovtFinanceiro.prc_DEL_LancOcorrUpdSeq(pSeq => :P5_SEQ_OCORR);',
'    END IF;',
'    --',
'    :P5_SEQ_OCORR := NULL;',
'  END IF;   ',
'  --',
'  IF :P5_SEQ_OCORR IS NULL THEN',
'    :P5_SEQ_OCORR := vDtNum||vRandon; ',
'  END IF;',
'END;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(11258303448451163679)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>unistr('Trata Par\00E2metros')
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  -->> MSS 20260814',
'  IF :P5_EMPRESAS IS NOT NULL THEN',
'    :P5_EMPRESAS := REPLACE(:P5_EMPRESAS,''-'','':'');',
'  END IF;',
'  --<<  ',
'  IF :P5_APP_ANT IS NOT NULL AND :P5_PAG_ANT IS NOT NULL THEN',
'    IF :P5_FILIAIS IS NOT NULL THEN',
'      :P5_FILIAIS := REPLACE(REPLACE(:P5_FILIAIS,''-'','':''),''_'',''#'');',
'    END IF;',
'    --',
'    IF :P5_CCUSTOS IS NOT NULL THEN',
'      :P5_CCUSTOS := REPLACE(REPLACE(:P5_CCUSTOS,''-'','':''),''_'',''#'');',
'    END IF;  ',
'    --',
'    IF :P5_SINDICATOS IS NOT NULL THEN',
'      :P5_SINDICATOS := REPLACE(REPLACE(:P5_SINDICATOS,''-'','':''),''_'',''#'');',
'    END IF;  ',
'    --    ',
'    IF :P5_MATRICULAS IS NOT NULL THEN',
'      :P5_MATRICULAS := REPLACE(REPLACE(:P5_MATRICULAS,''-'','':''),''_'',''#'');',
'    END IF;   ',
'    --',
'    IF :P5_OCORRPAGTO IS NOT NULL THEN',
'      :P5_OCORRPAGTO := REPLACE(:P5_OCORRPAGTO,''_'',''#'');',
'    END IF;    ',
'    --    ',
'    IF :P5_DATAREF IS NOT NULL THEN',
'      :P5_DATAREF := REPLACE(:P5_DATAREF,''-'','':'');',
'    END IF; ',
'    --    ',
'    IF :P5_SITUACOES IS NOT NULL THEN',
'      :P5_SITUACOES := REPLACE(:P5_SITUACOES,''-'','':'');',
'    END IF; ',
'    --    ',
'    IF :P5_VINCULOS IS NOT NULL THEN',
'      :P5_VINCULOS := REPLACE(:P5_VINCULOS,''-'','':'');',
'    END IF;     ',
'    --',
'    IF :P5_TIPOSAL = ''T'' THEN',
'      :P5_TIPOSAL := NULL;',
'    END IF;    ',
'    --    ',
'    IF :P5_TIPOPAG = 0 THEN',
'      :P5_TIPOPAG := NULL;',
'    END IF;     ',
'  END IF;',
'  --',
'  :P5_EMP_AUX   := NULL;',
'  :P5_FIL_AUX   := NULL;',
'  :P5_CCST_AUX  := NULL;',
'  :P5_SIND_AUX  := NULL;',
'  :P5_MAT_AUX   := NULL;',
'  :P5_DTREF_AUX := NULL;',
'  --',
'  IF INSTR(:P5_EMPRESAS,'':'') = 0 THEN',
'    :P5_EMP_AUX    := :P5_EMPRESAS;',
'    :P5_FIL_AUX    := REPLACE(pkg_MovtFinanceiro.fnc_RetDadoStrg(pDado => :P5_FILIAIS, pSeparador => '':''),'':'',''-'');',
'    :P5_CCST_AUX   := REPLACE(pkg_MovtFinanceiro.fnc_RetDadoStrg(pDado => :P5_CCUSTOS, pSeparador => '':''),'':'',''-'');    ',
'    :P5_SIND_AUX   := REPLACE(pkg_MovtFinanceiro.fnc_RetDadoStrg(pDado => :P5_SINDICATOS, pSeparador => '':''),'':'',''-'');        ',
'    :P5_MAT_AUX    := REPLACE(pkg_MovtFinanceiro.fnc_RetDadoStrg(pDado => :P5_MATRICULAS, pSeparador => '':''),'':'',''-'');      ',
'    :P5_DTREF_AUX  := REPLACE(pkg_MovtFinanceiro.fnc_RetDadoStrg(pDado => :P5_DATAREF, pSeparador => '':''),'':'',''-'');                ',
'  END IF;',
'  ',
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
